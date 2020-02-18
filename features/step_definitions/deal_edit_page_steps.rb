# Определение шагов на странице со списком пользователей

When(/^Администратор открывает страницу со списком запросов$/) do
  deal_edit_page = DealEditPage.new
  expect(deal_edit_page.deal_list_page?).to be true
end

Then(/^Администратор на странице со списком запросов контрагента кликает кнопку "(.+)"$/) do |button_title|
  deal_edit_page = DealEditPage.new
  deal_edit_page.click_button_by_title(title: button_title)
end

Then(/^Появляется попап "(.+)"$/) do |popup_title|
  deal_edit_page = DealEditPage.new
  expect(deal_edit_page.popup_by_title?(title: popup_title)).to be true
end

Then(/^Кнопка "(.+)" является (.+)$/) do |button_title, status_name|
  deal_edit_page = DealEditPage.new
  button = deal_edit_page.button_by_title(title: button_title)
  if status_name == 'неактивной'
    expect(button).to be_disabled
  elsif status_name == 'активной'
    expect(button).not_to be_disabled
  end
end

Then(/^Администратор на странице контрагента в селекторе "(.+)" выбирает "(.+)"$/) do |selector_title, deal_type|
  deal_edit_page = DealEditPage.new
  deal_edit_page.set_picker_value_by_title(selector_title: selector_title, option_title: deal_type)
end

Then(/^Администратор на странице контрагента в селекторе деревьев "(.+)" выбирает "(.+)"$/) do |selector_title, deal_type|
  deal_edit_page = DealEditPage.new
  deal_edit_page.set_tree_picker_value_by_title(selector_title: selector_title, option_title: deal_type)
end

Then(/^Администратор на странице контрагента в текстовом инпуте "(.+)" вводит значение "(.+)"$/) do |selector_title, contract_number|
  deal_edit_page = DealEditPage.new
  deal_edit_page.set_input_value_by_title(input_title: selector_title, text: contract_number)
end

Then(/^Администратор на странице контрагента нажимает кнопку "(.+)"$/) do |button_title|
  deal_edit_page = DealEditPage.new
  deal_edit_page.click_button_by_title(title: button_title)
end

Then(/^Открывается форма редактирования запроса$/) do
  deal_edit_page = DealEditPage.new
  expect(deal_edit_page.deal_edit_page?).to be true
end

Then(/^На форме редактирования запроса селектор "(.+)" заполнен значением "(.+)"$/) do |selector_title, selector_value|
  deal_edit_page = DealEditPage.new
  expect(deal_edit_page.get_picker_value_by_title(selector_title: selector_title) == selector_value).to be true
end

check_regexp = /^На форме редактирования запроса селектор деревьев "(.+)" заполнен значением "(.+)"$/
Then(check_regexp) do |tree_selector_title, tree_selector_value|
  deal_edit_page = DealEditPage.new
  tree_picker_value = deal_edit_page.get_tree_picker_value_by_title(selector_title: tree_selector_title)
  expect(tree_picker_value == tree_selector_value).to be true
end

Then(/^На форме редактирования запроса текстовое поле "(.+)" заполнено значением "(.+)"$/) do |text_input_title, text_input_value|
  deal_edit_page = DealEditPage.new
  expect(deal_edit_page.get_input_value_by_title(input_title: text_input_title) == text_input_value).to be true
end

Then(/^Администратор закрывает форму редактирования запроса$/) do
  deal_edit_page = DealEditPage.new
  deal_edit_page.click_button_by_title(title: 'Кнопка закрытия формы редактирования запроса')
end

Then(/^Администратор открывает попап по клику на строку запроса с номером "(.+)"$/) do |deal_number|
  deal_edit_page = DealEditPage.new
  deal_edit_page.open_deal_popup_from_deal_list_by_deal_number(deal_number: deal_number)
end

Then(/^Администратор создаёт для контрагента "(.+)" запрос с параметрами:/) do |counterparty_name, params_block|
  deal_edit_page = DealEditPage.new
  deal_edit_page.create_deal_with_params(counterparty_name: counterparty_name, params_block: params_block)
end
