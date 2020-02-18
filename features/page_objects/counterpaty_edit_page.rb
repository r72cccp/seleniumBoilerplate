# Страница авторизации пользователей
require_relative 'page'

# Страница
class CounterpartyEditPage < Page
  # Проверка, является ли открытая в данный момент времени страница - страницей редактирования контрагента
  def counterparty_edit_page?(counterparty_name:)
    this_is_counterparty_edit_form = Capybara.has_css?('div#counterpartyTopForm')
    counterparty_name_input = Capybara.find(:css, 'input#counterpartyName')
    expect(counterparty_name_input.value == counterparty_name).to be true
    expect(this_is_counterparty_edit_form).to be true
  end

  # Проверяет, видно ли часть формы со списком запросов
  def counterparty_deals_list_part_visible?
    Capybara.has_css?('div#formParts div#counterpartyDeals')
  end

  private

  # Определяет селекторы основных кнопок на странице контрагента
  def button_title_to_selector(title:)
    button_definitions = {
      'Лимиты' => 'a[href="#counterpartyLimitsCont"]',
      'Запросы' => 'a[href="#counterpartyDeals"]',
      'Заключения' => 'a[href="#counterpartyAssessments"]',
      'Карточка' => 'a[href="#counterpartyInfoForm"]',
      'Финансы' => 'a[href="#counterpartyFinanceCondition"]',
      'Рейтинги' => 'a[href="#counterpartyRatings"]',
      'ФКР' => 'a[href="#counterpartyFCR"]',
    }
    button_definitions[title]
  end
end
