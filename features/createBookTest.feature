Feature: Создание нового учебника
  Scenario: Создаем новый учебник
    Given Открываем страницу "http://localhost"
    When  Указываем название учебника "Новый учебник"
    And   Сохраняем учебник
    And   Закрываем страницу

  Scenario: Проверяем новый учебник
    Given Открываем страницу "http://localhost"
    When  Выбираем из выпадающего списка учебник со слагом "novii-uchebnik.etb"
    Then  Проверяем название редактируемого учебника "Новый учебник"