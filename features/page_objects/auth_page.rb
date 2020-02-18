# Страница авторизации пользователей

# Страница
class AuthPage
  include RSpec::Matchers

  # Сбрасывает текущую сессию пользователя и переходит к странице авторизации
  def open_auth_page
    clear_cookies
    Capybara.visit('/')
  end

  # Проверка, является ли открытая в данный момент времени страница - страницей логина или активен попап с логином
  def auth_page?
    Capybara.has_css?('form#_loginForm') || Capybara.has_css?('form.login-form')
  end

  # Проверка, есть ли на странице авторизации поля для ввода имени и пароля, а так же кнопка
  def auth_fields_present?
    if auth_page?
      email_input_present = Capybara.has_css?('input#_user_login')
      password_input_present = Capybara.has_css?('input#_user_password')
      button_present = Capybara.has_css?('button[type="submit"]')
      email_input_present && password_input_present && button_present
    end
  end

  # Авторизует пользователя по его роли (см. файл config/env.local нотация: "<role_name>_name", "<role_name>_password")
  def login_user(user_role: :admin)
    if auth_fields_present?
      email_input = Capybara.find(:css, 'input#_user_login')
      email_input.set(ENV["#{user_role}_name"])
      password_input = Capybara.find(:css, 'input#_user_password')
      password_input.set(ENV["#{user_role}_password"])
      Capybara.find(:css, 'button[type="submit"]').click
    end
  end

  # Завершает сессию пользователя
  def logout_user
    Capybara.find(:css, 'a#terminateSessionLink').click
  end
end
