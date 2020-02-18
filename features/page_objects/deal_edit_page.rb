# Страница редактирования сделки
require_relative 'page'

# Страница
class DealEditPage < Page
  # Проверка, является ли открытая в данный момент времени страница - страницей редактирования сделки
  def deal_edit_page?
    this_is_deal_edit_form = Capybara.has_css?('div#dealForm')
    expect(this_is_deal_edit_form).to be true
  end

  # Проверяе, является ли открытая страница списком сделок контрагента
  def deal_list_page?
    sleep 1
    this_is_deal_list_page = Capybara.has_css?('div#requestAndPortfolioCont div#dealsTab')
    expect(this_is_deal_list_page).to be true
  end

  # Находясь на странице со списком сделок, кликает по строке со сделкой с номером deal_number, открывая попап с кнопками
  def open_deal_popup_from_deal_list_by_deal_number(deal_number:)
    deal_list_rows_selector = 'div#counterpartyDeals table#dealList tr.deal'
    deal_list_rows_exists = Capybara.has_css?(deal_list_rows_selector)
    return unless deal_list_rows_exists

    deal_list_rows = Capybara.all(:css, deal_list_rows_selector)
    deal_list_rows.each do |deal_list_row|
      deal_number_cell = deal_list_row.find(:css, 'td.nowrap:nth-child(2)')
      next if deal_number_cell.text != deal_number

      deal_list_row.click
      break
    end
  end

  # Создаёт сделку и вводит необходимые параметры
  def create_deal_with_params(counterparty_name:, params_block:)
    params = {}
    params_block.gsub(/[\r\n]+/, '#').split('#').each do |parameter|
      parameter_name = parameter[/^.+:/]
      parameter_value = parameter[/:.+$/].sub(/^: "/, '').sub(/"$/, '')
      params[parameter_name] = parameter_value
    end
    log({
      counterparty_name: counterparty_name,
      params_block: params_block,
      params: params,
    })
  end

  private

  def button_title_to_selector(title:)
    button_definitions = {
      'Добавить запрос' => 'button#addDeal',
      'Да на диалоговом окне подтверждения удаления запроса из списка запросов' => 'div#deleteDealConfirm button.btnConfirm',
      'Кнопка закрытия формы редактирования запроса' => 'div#counterpartyDeals a#hideDealInfo',
      'Создать запрос в попапе Создание запроса' => 'div#dealInitialForm button#createDeal',
      'Сохранить на странице редактирования запроса' => 'div#dealActionsMenu button#saveDeal',
      'Редактировать на попапе открывающемся по клику на строке сделки' => 'div.additionalInfo div.actionsMenu button.actionsMenuBtn.changeDeal',
      'Удалить на попапе открывающемся по клику на строке сделки' => 'div.additionalInfo div.actionsMenu button.actionsMenuBtn.deleteDeal',
    }
    button_definitions[title]
  end

  def popup_title_to_selector(title:)
    popup_definitions = {
      'Создание запроса' => 'div#dealInitialForm',
    }
    popup_definitions[title]
  end

  def input_title_to_selector(title:)
    input_definitions = {
      'Номер договора в попапе Создание запроса' => 'input#initialContractNumber',
      'Номер договора' => 'input#dealContractNumber',
      'Номер запроса в форме редактирования запроса' => 'div#dealForm input#dealCode',
      'Номер запроса' => 'input#dealCode',
      'Тип сделки в попапе Создание запроса' => 'span#initialDealTypePickerSelectBoxItContainer',
      'Тип сделки' => 'span#dealTypePickerSelectBoxItContainer',
      'Финансовый продукт в попапе Создание запроса' => 'span#initialFinancialProductPicker',
      'Финансовый продукт' => 'span#financialProductPicker',
    }
    input_definitions[title]
  end
end
