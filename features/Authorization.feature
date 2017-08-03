# encoding: UTF-8
# language: ru

  Функционал: Авторизация пользователя через систему Паспорт
    ####################################################################################################################
    Структура сценария: Вход пользователя
      Когда открыл страницу авторизации
      И нажал на кнопку регистрации
      И выбрал вход по карте
      И ввел номер карты <cardN>
      И ввел срок действия карты <cardExp>
      И ввел номер телефона <phoneN>
      И нажал кнопку Далее
      И ввел код смс <sms>
      И нажал кнопку подтверждения
      И открыл страницу заказа наличных
      Тогда в заголовке страницы написано "Заказ наличных"

    @INT
    Примеры:
      | cardN               | cardExp | phoneN      | sms  |
      | 4154 8120 2967 7972 | 02/19   | 79151234565 | 0000 |

    @PRELIVE
    Примеры:
      | cardN               | cardExp | phoneN      | sms  |

    @PROD
    Примеры:
      | cardN               | cardExp | phoneN      | sms  |

    ####################################################################################################################
    Структура сценария: Выход пользователя
      #Когда пользователь авторизовался в Паспорте <cardN>, <cardExp>, <phoneN>, <sms>
      #Дано пользователь авторизован в Паспорте
      Когда открыл страницу заказа наличных
      Тогда в заголовке страницы написано "Заказ наличных"
      И вышел из Заказа Наличных
      И открыл страницу заказа наличных
      Тогда гланая страница не открыта

    @INT
      Примеры:
        | cardN               | cardExp | phoneN      | sms  |
        | 4154 8120 2967 7972 | 02/19   | 79151234565 | 0000 |

    @PRELIVE
      Примеры:
        | cardN               | cardExp | phoneN      | sms  |

    @PROD
      Примеры:
        | cardN               | cardExp | phoneN      | sms  |