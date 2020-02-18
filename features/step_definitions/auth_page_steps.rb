# Определение шагов на странице авторизации пользователя

When(/^Пользователь переходит на страницу авторизации$/) do
  auth_page = AuthPage.new
  auth_page.open_auth_page
end

Then(/^Открывается страница "Вход"$/) do
  auth_page = AuthPage.new
  auth_page.auth_page?
end

Then(/^На странице авторизации присутствуют поля ввода имени и пароля, а так же кнопка$/) do
  auth_page = AuthPage.new
  auth_page.auth_fields_present?
end

Then(/^Администратор авторизуется через email$/) do
  auth_page = AuthPage.new
  auth_page.login_user(user_role: :admin)
end

Then(/^Администратор выходит из системы$/) do
  auth_page = AuthPage.new
  auth_page.logout_user
end

Then(/^Пользователь авторизуется через email$/) do
  auth_page = AuthPage.new
  auth_page.login_user(user_role: :user)
end

Then(/^Пользователь выходит из системы$/) do
  auth_page = AuthPage.new
  auth_page.logout_user
end
