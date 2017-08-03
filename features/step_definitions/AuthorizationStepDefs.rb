When(/^открыл страницу авторизации$/) do
  @authorizationPage = AuthorizationPage.new
  @authorizationPage.load
  url = current_url.gsub! 'cash-web', 'mobile-app'
  visit url
end

When(/^ввел номер карты (.*)$/) do |cardN|
  @authorizationPage.card_number_field.set cardN
end

When(/^ввел срок действия карты (.*)$/) do |cardExp|
  month = cardExp[0..1]
  year = cardExp[3..4]

  @authorizationPage.card_month_field.set month
  @authorizationPage.card_year_field.set year
end

When(/^ввел номер телефона (.*)$/) do |phoneN|
  @authorizationPage.phone_number_field.set phoneN
end

When(/^ввел код смс (.*)$/) do |sms|
  @authorizationPage.sms_field.set sms
end

When(/^открыл страницу заказа наличных$/) do
  @mainpage = MainPage.new
  visit $cash_url
end

When(/^пользователь авторизовался в Паспорте (.*) (.*) (.*) (.*)$/) do |cardN, cardExp, phoneN, sms|
  step "открыл страницу авторизации"
  step "нажал на кнопку регистрации"
  step "выбрал вход по карте"
  step "ввел номер карты #{cardN}$"
  step "ввел срок действия карты #{cardExp}$"
  step "ввел номер телефона #{phoneN}$"
  step "нажал кнопку Далее"
  step "ввел код смс #{sms}$"
  step "нажал кнопку подтверждения"
end

When(/^вышел из Заказа Наличных$/) do
  @mainpage.logout_button.click
end

When(/^нажал на кнопку регистрации$/) do
  @authorizationPage.reg_button.click
end

When(/^выбрал вход по карте$/) do
  @authorizationPage.cards_button.click
end

When(/^нажал кнопку Далее$/) do
  @authorizationPage.submit_card_button.click
end

When(/^нажал кнопку подтверждения$/) do
  @authorizationPage.submit_sms_button.click
end