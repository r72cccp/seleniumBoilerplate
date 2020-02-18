# Тестирование

* [Настройка Selenium тестов](#setup_tests)
* [Запуск Selenium тестов](#run_tests)
* [Запуск отдельных тестов](#run_separate_tests)

## <a name="setup_tests">Настройка Selenium тестов</a>

Создать файл [config/.env.local](test/selenium/config/.env.local.example):

  ```bash
  cp config/.env.sample.local config/.env.local
  ```

Заполнить данные в файле для регистрации

  ```bash
  # Аккаунты для авторизации с помощью email

  # 1. Админский аккаунт. Нужен в том числе для управления правами остальных аккаунтов для тестирования
  export admin_name="********"           # Имя пользователя с полными правами
  export admin_password="********"       # Пароль пользователя с полными правами
  # 2. Пользовательский аккаунт. Нужен для назначения разных наборов прав и тестирования из-под пользователя с пониженными правами
  export user_name="********"            # Имя пользователя с полными правами
  export user_password="********"        # Пароль пользователя с полными правами
  ```

В файле [front/test/selenium/capybara.yml](test/selenium/capybara.yml) находятся настройки оболочки тестов, при этом они
допускают два режима запуска браузера - удалённый и локальный. 

### Удалённый запуск:

  При удалённом запуске тесты запускаются на компьютере с ip, например, 192.168.1.1, а браузер с приложением запускается
  на хосте с ip 192.168.1.2:

  ```yml
  webdriver_settings:
    browser: :remote                   # Режим удалённого запуска браузера
    desired_capabilities: :chrome      # Режим совместимости с хромом
    url: "http://192.168.1.2:9515"     # Хост, на котором запущен браузер в режиме удалённого управления
  app_host:
    default: 'https://dev.yoursite.ru'     # Хост сайта на компе разработчика
    stage: 'https://staging.yoursite.ru'                 # Хост сайта на тестовом сервере
  ```

### Локальный запуск:

  ```yml
  settings:
    browser: 'chrome'
    driver_path: './drivers/chromedriver'
    app_host:
    default: 'https://dev.yoursite.ru'     # Хост сайта на компе разработчика
    stage: 'https://staging.yoursite.ru'                 # Хост сайта на тестовом сервере
  ```

## <a name="run_tests">Запуск Selenium тестов</a>

Тесты имитируют действия пользователя в браузере. Для запуска тестов необходимо:

* Перейти в директорию ./selenium
* Из консоли выполнить команду bundle (однократно) для установки необходимых gem'ов
* Из консоли выполнить команду cucumber
* После выполнения тестов сформируется папка selenium/reports с отчетом report.html

Если подключение к webdriver удалённое, то необходимо:

* скачать chromedriver для винды [отсюда](https://sites.google.com/a/chromium.org/chromedriver/downloads)
* Скопировать скрипт для запуска:

```bash
cp drivers/chromedriver.sample.bat drivers/chromedriver.bat
```

* Отредактировать скрипт, тут 0.0.0.0 - ip машины, которая запускает селениум тесты.

```bat
call chromedriver --whitelisted-ips="y.y.y.y"
```

* Запустить chromedriver на удалённом хосте:

```bat
chromedriver.bat
```

* Начать выполнение тестов:

  - На компьютере разработчика:

```bash
cd ~/projects/seeneco/selenium
cucumber
```

  - На тестовом сервере:

```
cd ~/projects/seeneco/selenium
host=staging cucumber
```

  - На рабочем сервере:

```
cd ~/projects/seeneco/selenium
host=production cucumber
```

## <a name="run_separate_tests">Запуск отдельных тестов</a>

Иногда при работе с отдельным участком кода не нужно запускать все тесты, так как их запуск занимает продолжительное
время. В таких случаях можно ограничиться запуском отдельной фичи (Feature) или отдельного сценария (Scenario)

Для того, чтобы различать отдельные фичи, отдельные сценарии друг от друга в целях идентификации можно использовать 
уникальные теги:

```cucumber
@УправлениеКонтрагентами
Feature: Управление контрагентами

  @ОткрытиеСтраницыСоСпискомКонтрагентов @Списки
  Scenario: Открытие страницы со списком контрагентов
    * Администратор авторизуется через email
    * Открывается главная страница сайта
    * Администратор открывает боковое меню
    * Администратор кликает пункт "Управление контрагентами"
    * Открывается страница со списком контрагентов
    * Администратор выходит из системы

  @ОткрытиеКонтрагентаАвтотест @Форма
  Scenario: Открытие контрагента "Автотест не трогать, не вводить"
    * Администратор авторизуется через email
    * Администратор открывает страницу управления контрагентами
    * Администратор выполняет поиск контрагента по наименованию "Автотест не трогать, не вводить"
    * Администратор кликает кнопку редактирования контрагента
    * Открывается страница редактирования контрагента "Автотест не трогать, не вводить"
    * Администратор выходит из системы

  @ОткрытиеСтраницыСоСпискомЗапросовКонтрагентаАвтотест @Форма
  Scenario: Открытие страницы со списком запросов контрагента "Автотест не трогать, не вводить"
    * Администратор авторизуется через email
    * Администратор открывает страницу редактирования контрагента по наименованию "Автотест не трогать, не вводить"
    * Администратор кликает кнопку "Запросы"
    * Открывается страница со списком запросов
    * Администратор выходит из системы
```

Тогда мы можем запустить отдельный сценарий:

```bash
cucumber --tags @ОткрытиеКонтрагентаАвтотест
```

Или мы можем запустить фичу целиком:

```bash
cucumber --tags @УправлениеКонтрагентами
```

Или мы можем запустить только те сценарии, которые мы пометили тегом @Форма:

```bash
cucumber --tags @Форма,@Список
```

Редактируйте [список тегов](./features/tags.md) по мере добавления новых.
