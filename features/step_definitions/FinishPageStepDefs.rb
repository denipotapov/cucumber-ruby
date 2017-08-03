When(/^открыта финальная страница заказа$/) do
  @success_popup = SuccessPopUp.new
  @success_popup.wait_until_success_popup_visible
  assert_true(@success_popup.has_success_popup?,"Всплывающее окно Финальной страницы заказа не отобразилось")
  assert_true(@success_popup.body.has_text?('Заказ отправлен!'),"Надпись /'Заказ отправлен!/' отсутствует")
end

When(/^сумма на финальной странице равна желаемой (.*), валюта (.*)$/) do |amount, currency|
  major = @success_popup.amount_major.text
  minor = @success_popup.amount_minor.text
  amountCurrency = @success_popup.amount_currency.text

  amountFromUI = (major + minor + amountCurrency).gsub(/\s+/, "")
  amountInTest = amount + currency

  assert_equal(amountInTest, amountFromUI, "Суммы на финальной странице заказа не равна сумме, введенной при заказе #{screenshot}")
end

When(/^дата выдачи на финальной странице равна желаемой$/) do
  orderDateUI = @success_popup.order_date.text
  orderDateTest = format_date(@orderDate) + " " + @orderDate[-4,4] + " г."

  assert_equal("Получение #{orderDateTest}", orderDateUI, "Дата выдачи на финальной странице не равна дате, введенной при заказе #{screenshot}")
end

When(/^адрес отделения на финальной странице равен адресу выбранного отделения$/) do
  addressUI = @success_popup.address.text
  addressTest = @city + ', ' + @branchAddress
  assert_equal(addressTest, addressUI, "Адрес отделения на финальной странице заказа не равен адресу, выбранному при заказе #{screenshot}")
end

When(/^график работы отделения на финальной странице совпадает с графиком выбранного отделения$/) do
  branchScheduleUI = @success_popup.schedule.text
  assert_equal(@branchSchedule, branchScheduleUI, "График работы отделения на финальной странице заказа не равен графику, выбранному при заказе #{screenshot}")
end

And(/^нажал кнопку "Закрыть"$/) do
  @success_popup.close_button.click
end