# Страница авторизации пользователей
LOG_FILE_NAME ||= './log/selenium.log'.freeze

# Страница - родительский класс, содержит часто используемые методы
class Page
  include RSpec::Matchers

  # Проверяет наличие кнопки по её заголовку.
  def button_by_title?(title:)
    button_selector = button_title_to_selector(title: title)
    wait_for_ajax
    button_exists = Capybara.has_css?(button_selector)
    button_exists
  end

  # Находит кнопку по её заголовку
  def button_by_title(title:)
    button_selector = button_title_to_selector(title: title)
    Capybara.find(:css, button_selector)
  end

  # Кликает кнопку по её наименованию
  def click_button_by_title(title:)
    if button_by_title?(title: title)
      button_by_title(title: title).click
      sleep 2
    end
  end

  # Проверяет, видим ли попап по его заголовку
  def popup_by_title?(title:)
    popup_selector = popup_title_to_selector(title: title)
    wait_for_ajax
    popup_exists = Capybara.has_css?(popup_selector, visible: true)
    popup_exists
  end

  # Выбирает значение в селекте по его тектовому представлению
  def set_picker_value_by_title(selector_title:, option_title:)
    input_selector = input_title_to_selector(title: selector_title)
    input_exists = Capybara.has_css?(input_selector)
    return unless input_exists

    input = Capybara.find(:css, input_selector)
    input.click
    select_options_selector = "#{input_selector} a.selectboxit-option-anchor"
    select_options_exists = Capybara.has_css?(select_options_selector)
    return unless select_options_exists

    picker_options = Capybara.all(:css, select_options_selector)
    picker_options.each do |option|
      next if option.text != option_title

      option.click
      break
    end
  end

  # Получает выбранное значение в селекте по его заголовку
  def get_picker_value_by_title(selector_title:)
    input_selector = input_title_to_selector(title: selector_title)
    Capybara.find(:css, "#{input_selector} span.selectboxit-text").text
  end

  # Устанавливает выбранное значение в пикере деревьев
  def set_tree_picker_value_by_title(selector_title:, option_title:)
    input_selector = input_title_to_selector(title: selector_title)
    input_selector_exists = Capybara.has_css?(input_selector)
    return unless input_selector_exists

    input = Capybara.find(:css, input_selector)
    input.click
    tree_select_options_selector = "#{input_selector} label[class='radio']"
    item_found = false
    loop do
      expand_option_selector = "#{input_selector} i.icon-expand-alt"
      wait_for_ajax
      expand_option_items_exists = Capybara.has_css?(expand_option_selector)
      break unless expand_option_items_exists

      expand_option_items = Capybara.all(:css, expand_option_selector)
      break if expand_option_items.size.zero?

      expand_option_items.each(&:click)
      sleep 2

      tree_select_options = Capybara.all(:css, tree_select_options_selector)
      tree_select_options.each do |option|
        next if option.text != option_title

        option.click
        item_found = true
        break
      end

      break if item_found
    end
  end

  # Получает выбранное значение поля ввода по его заголовку
  def get_tree_picker_value_by_title(selector_title:)
    input_selector = input_title_to_selector(title: selector_title)
    input = Capybara.find(:css, "#{input_selector} input[type='text']")
    input.value
  end

  # Вводит текст в поле текcтового ввода
  def set_input_value_by_title(input_title:, text:)
    text_input_selector = input_title_to_selector(title: input_title)
    Capybara.find(:css, text_input_selector).set("#{text}\n")
  end

  # Получает введённое значение в текстовом поле ввода
  def get_input_value_by_title(input_title:)
    text_input_selector = input_title_to_selector(title: input_title)
    text_input = Capybara.find(:css, text_input_selector)
    text_input.value
  end

  private

  # Определяет селекторы для кнопок согласно их заголовкам
  def button_title_to_selector
    nil
  end

  # Определяет селекторы для попапов (всплывающие диалоговые окна)
  def popup_title_to_selector
    nil
  end

  # Определяет селекторы для текстовых инпутов, селекторов, селекторов деревьев
  def input_title_to_selector
    nil
  end

  # Для отладочных целей. Добавляет текст в LOG_FILE_NAME
  def log(data)
    return unless data
    return unless LOG_FILE_NAME

    timestamp = Time.new.to_s
    File.write(LOG_FILE_NAME, "#{LOG_FILE_NAME}--#{timestamp}\n#{ap data}\n\n", mode: 'a')
  end

  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop do
        jquery_not_active = Capybara.page.evaluate_script('jQuery.active').zero?
        jquery_ready = Capybara.page.evaluate_script('jQuery.isReady')
        break if jquery_ready && jquery_not_active
      end
    end
  end
end
