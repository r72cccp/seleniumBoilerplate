# Страница авторизации пользователей

# Страница
class MainPage
  include RSpec::Matchers

  # Проверка, является ли открытая в данный момент времени страница - главной страницей сайта
  def main_page?
    Capybara.has_css?('div#main')
  end

  def left_side_menu?
    Capybara.has_css?('div#applicationMenuContent')
  end

  # Открывает меню слева на странице
  def open_leftside_menu
    Capybara.find(:css, 'div#applicationMenuContent').hover if left_side_menu?
  end

  # Проверяет, есть ли в меню пункт "Управление контрагентами"
  def manage_counterparties?
    Capybara.has_css?('a[data-message="SCR_Menu.CounterpartyManagement"]')
  end

  # Кликает на пункт меню "Управление контрагентами"
  def click_manage_counterparties
    Capybara.find('a[data-message="SCR_Menu.CounterpartyManagement"]').click if manage_counterparties?
  end
end
