@УправлениеКонтрагентами
Feature: Управление контрагентами

  @ОткрытиеСтраницыСоСпискомКонтрагентов @Список @Регрессия
  Scenario: Открытие страницы со списком контрагентов
    * Администратор авторизуется через email
    * Открывается главная страница Сайта
    * Администратор открывает боковое меню
    * Администратор кликает пункт "Управление контрагентами"
    * Открывается страница со списком контрагентов
    * Администратор выходит из системы

  @ОткрытиеКонтрагентаАвтотест @Форма @Регрессия
  Scenario: Открытие контрагента "Автотест не трогать, не вводить"
    * Администратор авторизуется через email
    * Администратор открывает страницу управления контрагентами
    * Администратор выполняет поиск контрагента по наименованию "Автотест не трогать, не вводить"
    * Администратор кликает кнопку редактирования контрагента
    * Открывается страница редактирования контрагента "Автотест не трогать, не вводить"
    * Администратор выходит из системы
