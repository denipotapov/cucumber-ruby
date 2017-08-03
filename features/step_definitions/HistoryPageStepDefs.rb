When(/^дата выдачи в истории равна желаемой$/) do
  @history_page = HistoryPage.new
  @history_page.wait_until_receive_dates_visible
  orderDateUI = @history_page.receive_dates[0].text
  orderDateTest = "Получение " + format_date(@orderDate) + " " + Date.parse(@orderDate).strftime("%Y")
  assert_equal(orderDateTest, orderDateUI, "Дата выдачи на финальной странице заказа не равна дате, введенной при заказе")
end

When(/^сумма в истории равна желаемой (.*), (.*)$/) do |amount, currency|
  amountUI = @history_page.amount[0].text.gsub(/\s+/, "")
  amountInTest = amount + currency

  assert_equal(amountInTest, amountUI, "Сумма заказа в истории не равна сумме, введенной при заказе")
end

When(/^дата заказа в истории равна текущей дате$/) do
  orderDayUI = @history_page.order_dates[0].text
  orderDayInTest = format_date(DateTime.now.strftime("%d.%m.%Y"))

  assert_equal(orderDayInTest, orderDayUI, "День заказа в истории не равен дню совершения заказа")
end

When(/^счет списания в истории равен выбранному (.*)$/) do |acc|
  accountUI = @history_page.accounts[0].text
  accountTest = "••#{acc}"
  assert_true((accountUI.include? accountTest), "Счет заказа в истории не равен счету заказа")
end

When(/^адрес отделения в истории равен адресу выбранного отделения$/) do
  addressUI = @history_page.addresses[0].text
  addressTest = @city + ', ' + @branchAddress

  assert_equal(addressTest, addressUI, "Адрес отделения на финальной странице заказа не равен адресу, выбранному при заказе #{screenshot}")
end

When(/^тип счёта равен выбанному$/) do
  accountUI = @history_page.accounts[0].text
  assert_true((accountUI.include? @select_account_type), "Тип счета заказа в истории не равен типу счету заказа")
end