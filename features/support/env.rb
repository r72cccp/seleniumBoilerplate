# encoding: utf-8

require 'awesome_print'
require 'capybara'
require 'capybara/cucumber'
require 'cucumber'
require 'dotenv'
require 'mail'
require 'rspec'

SCREENSHOTS_DIR_PATH = './reports/screenshots'.freeze
REPORTS_PATH = './reports'.freeze

# Создание директории для скриншотов
def create_dir(path:, title:)
  if !Dir.exist?(path)
    Dir.mkdir(path, 0777)
    puts "Создана директория #{title}: #{path}"
  else
    puts "Директория #{title} #{path}"
  end
end

def clear_cookies
  browser = Capybara.current_session.driver.browser
  if browser.respond_to?(:clear_cookies)
    browser.clear_cookies
  elsif browser.respond_to?(:manage) && browser.manage.respond_to?(:delete_all_cookies)
    browser.manage.delete_all_cookies
  else
    raise 'Не получилось очистить куки. Нерабочий драйвер?'
  end
end

Dotenv.load('./config/.env.local')
capybara_settings = YAML.load(File.read('./capybara.yml'))

webdriver_settings = capybara_settings['webdriver_settings']
webdriver_settings.keys.each do |key|
  value = webdriver_settings[key]
  webdriver_settings[key.to_sym] = value
  webdriver_settings.delete(key)
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, webdriver_settings)
end

Capybara.default_driver = :selenium
Capybara.default_selector = :css
Capybara.default_max_wait_time = 10
Capybara.app_host = capybara_settings['app_host'][ENV['host'] || 'default']

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Создание директории для отчётов
create_dir(path: REPORTS_PATH, title: 'с отчётами')

# Создание директории для скриншотов
create_dir(path: SCREENSHOTS_DIR_PATH, title: 'со скриншотами')

Before do
  puts 'Начало выполнения тестов'
  Capybara.page.current_window.resize_to(1400, 860)
  Capybara.visit('/')
end

# Run after each scenario
After do |scenario|
  puts 'Завершение выполнения тестов'
  # Check, scenario is failed?
  if scenario.failed?
    time = Time.now.strftime('%Y_%m_%d_%Y_%H_%M_%S_')
    name_of_scenario = time + scenario.name.gsub(/\s+/, '_').gsub('/', '_')
    file_path = "#{File.expand_path(SCREENSHOTS_DIR_PATH)}/#{name_of_scenario}.png"
    puts "Создан скриншот #{file_path}"
    page.driver.browser.save_screenshot file_path
  end
end
