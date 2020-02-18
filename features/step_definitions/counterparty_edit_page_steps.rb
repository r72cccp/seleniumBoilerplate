# Определение шагов на странице со списком пользователей

When(/^Открывается страница редактирования контрагента "(.+)"$/) do |counterparty_name|
  counterparty_edit_page = CounterpartyEditPage.new
  counterparty_edit_page.counterparty_edit_page?(counterparty_name: counterparty_name)
end

Then(/^Администратор открывает страницу редактирования контрагента по наименованию "(.+)"$/) do |counterparty_name|
  counterpaties_manage_page = CounterpartyManagePage.new
  counterpaties_manage_page.visit_counterpaties_manage_page
  counterpaties_manage_page.find_counterparty_by_name(name: counterparty_name)
  counterpaties_manage_page.click_edit_counterparty_button
end

Then(/^Доступна кнопка "(.+)" на странице контрагента$/) do |button_title|
  counterpaty_edit_page = CounterpartyEditPage.new
  expect(counterpaty_edit_page.button_by_title?(title: button_title)).to be true
end

Then(/^Администратор на странице контрагента кликает кнопку "(.+)"/) do |button_title|
  counterpaty_edit_page = CounterpartyEditPage.new
  counterpaty_edit_page.click_button_by_title(title: button_title)
end

Then(/^Открывается страница со списком запросов$/) do
  counterpaty_edit_page = CounterpartyEditPage.new
  expect(counterpaty_edit_page.counterparty_deals_list_part_visible?).to be true
end
