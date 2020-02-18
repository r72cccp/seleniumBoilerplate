# Страница авторизации пользователей

# Страница
class CounterpartyManagePage
  include RSpec::Matchers

  # Проверка, является ли открытая в данный момент времени страница - страницей управления контрагентами
  def counterpaties_manage_page?
    Capybara.has_css?('div.counterpartyFormLayout')
  end

  # открывает страницу управления контрагентами
  def visit_counterpaties_manage_page
    Capybara.visit('/atr-framework-services/pages?start_new_pageflow=SeenecoCore.SCR_CounterpartyManagement')
  end

  # Проверяет, есть ли поле для ввода наименования контрагента
  def can_find_counterparty_by_name?
    Capybara.has_css?('input#counterpartyFilter')
  end

  # На странице управления контрагентами выполняет поиск контрагента по наименованию
  def find_counterparty_by_name(name:)
    Capybara.find(:css, 'input#counterpartyFilter').set(name) if can_find_counterparty_by_name?
  end

  def edit_counterparty_button?
    Capybara.has_css?('button.actionsMenuBtn.changeCounterparty')
  end

  # На странице управления контрагентами, после нахождения выбранного контрагента кликает на кнопку редактирования
  def click_edit_counterparty_button
    Capybara.find(:css, 'button.actionsMenuBtn.changeCounterparty').click if edit_counterparty_button?
  end
end
