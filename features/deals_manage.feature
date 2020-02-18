@УправлениеЗапросами
Feature: Управление запросами

  @ОткрытиеСтраницыСоСпискомЗапросовКонтрагентаАвтотест @Контрагент @Форма @Запрос @Регрессия
  Scenario: Открытие страницы со списком запросов контрагента "Автотест не трогать, не вводить"
    * Администратор авторизуется через email
    * Администратор открывает страницу редактирования контрагента по наименованию "Автотест не трогать, не вводить"
    * Доступна кнопка "Запросы" на странице контрагента
    * Администратор на странице контрагента кликает кнопку "Запросы"
    * Открывается страница со списком запросов
    * Администратор выходит из системы

  @СозданиеИУдалениеЗапросаДляКонтрагентаАвтотест @Контрагент @Форма @Запрос @Регрессия
  Scenario: Создание запроса с типом сделки "Кредитование" и финпродуктом "Кредитный договор" для контрагента "Автотест не трогать, не вводить"
    * Администратор авторизуется через email
    * Администратор открывает страницу редактирования контрагента по наименованию "Автотест не трогать, не вводить"
    * Администратор на странице контрагента кликает кнопку "Запросы"
    * Открывается страница со списком запросов
    * Администратор на странице со списком запросов контрагента кликает кнопку "Добавить запрос"
    * Появляется попап "Создание запроса"
    * Кнопка "Создать запрос в попапе Создание запроса" является неактивной
    * Администратор на странице контрагента в селекторе "Тип сделки в попапе Создание запроса" выбирает "Кредитование"
    * Администратор на странице контрагента в селекторе деревьев "Финансовый продукт в попапе Создание запроса" выбирает "Кредитный договор"
    * Кнопка "Создать запрос в попапе Создание запроса" является активной
    * Администратор на странице контрагента в текстовом инпуте "Номер договора в попапе Создание запроса" вводит значение "0000001"
    * Администратор на странице контрагента нажимает кнопку "Создать запрос в попапе Создание запроса"
    * Открывается форма редактирования запроса
    * На форме редактирования запроса селектор "Тип сделки" заполнен значением "Кредитование"
    * На форме редактирования запроса селектор деревьев "Финансовый продукт" заполнен значением "Кредитный договор"
    * На форме редактирования запроса текстовое поле "Номер договора" заполнено значением "0000001"
    * Администратор на странице контрагента в текстовом инпуте "Номер запроса в форме редактирования запроса" вводит значение "0000001-001"
    * Администратор на странице со списком запросов контрагента кликает кнопку "Сохранить на странице редактирования запроса"
    * Администратор закрывает форму редактирования запроса
    * Администратор открывает попап по клику на строку запроса с номером "0000001-001"
    * Администратор на странице со списком запросов контрагента кликает кнопку "Редактировать на попапе открывающемся по клику на строке сделки"
    * Открывается форма редактирования запроса
    * На форме редактирования запроса текстовое поле "Номер запроса" заполнено значением "0000001-001"
    * Администратор закрывает форму редактирования запроса
    * Администратор открывает попап по клику на строку запроса с номером "0000001-001"
    * Администратор на странице со списком запросов контрагента кликает кнопку "Удалить на попапе открывающемся по клику на строке сделки"
    * Администратор на странице со списком запросов контрагента кликает кнопку "Да на диалоговом окне подтверждения удаления запроса из списка запросов"
    * Администратор выходит из системы

  @СозданиеЗапросаСПараметрами @Контрагент @Форма @Запрос @Анонс
  Scenario: Создание запроса с параметрами
    * Администратор авторизуется через email
    * Администратор создаёт для контрагента "Автотест не трогать, не вводить" запрос с параметрами:
      """
      Номер договора: "0000001"
      Номер запроса: "0000001-002"
      Тип сделки: "Страхование и Кредитование"
      Финансовый продукт: "Страхование кредита на пополнение оборотных средств экспортера"
      """
    * Администратор открывает форму редактирования запроса с номером "0000001-002"
    * Администратор удаляет для контрагента "Автотест не трогать, не вводить" запрос с номером "0000001-002"
    * Администратор выходит из системы
