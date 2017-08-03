class AuthorizationPage < SitePrism::Page

  set_url $cash_url

  element :card_number_field, :css, '#creditCardNumber'
  element :card_month_field, :css, '#creditCardMonth'
  element :card_year_field, :css, '#creditCardYear'
  element :phone_number_field, :css, '#phoneNumberInput'
  element :sms_field, :css, '#smsCodeInput'
  element :reg_button, :xpath, '//span[contains(text(), "Регистрация")]'
  element :cards_button, :xpath, '//span[contains(text(), "Карты")]'
  element :submit_card_button, :xpath, '//span[contains(text(), "Далее")]'
  element :submit_sms_button, :xpath, '//span[contains(text(), "Подтвердить")]'

end