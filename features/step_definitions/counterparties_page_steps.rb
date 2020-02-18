# Определение шагов на странице со списком пользователей

When(/^Открывается главная страница Exiar$/) do
  main_page = MainPage.new
  main_page.main_page?
end

Then(/^Администратор открывает боковое меню$/) do
  main_page = MainPage.new
  main_page.open_leftside_menu
end

Then(/^Администратор кликает пункт "Управление контрагентами"$/) do
  main_page = MainPage.new
  main_page.click_manage_counterparties
end

Then(/^Открывается страница со списком контрагентов$/) do
  counterpaties_manage_page = CounterpartyManagePage.new
  counterpaties_manage_page.counterpaties_manage_page?
end

Then(/^Администратор открывает страницу управления контрагентами$/) do
  counterpaties_manage_page = CounterpartyManagePage.new
  counterpaties_manage_page.visit_counterpaties_manage_page
end

Then(/^Администратор выполняет поиск контрагента по наименованию "(.+)"$/) do |counterparty_name|
  counterpaties_manage_page = CounterpartyManagePage.new
  counterpaties_manage_page.find_counterparty_by_name(name: counterparty_name)
end

Then(/^Администратор кликает кнопку редактирования контрагента$/) do
  counterpaties_manage_page = CounterpartyManagePage.new
  counterpaties_manage_page.click_edit_counterparty_button
end
