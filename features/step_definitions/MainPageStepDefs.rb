When(/^пользователь открыл страницу Заказа Наличных. Pin = (.*)$/) do |pin|
  @mainpage = MainPage.new
  @mainpage.load(pin: pin)
  screenshot
end

When(/^пользователь открыл страницу Заказа Наличных.$/) do |pin|
  @mainpage = MainPage.new
  @mainpage.load(pin: pin)
  screenshot
end

When(/^отделение из A-mobile = (.*)$/) do |branchMnemonic|
  visit "#{$cash_url}order?branch=#{branchMnemonic}"
end

When(/^счет из A-mobile = (.*)$/) do |account|
  visit "#{$cash_url}order?account=#{account}"
end

When(/^в заголовке страницы написано "([^"]*)"$/) do |arg|
  assert (page.has_text? arg), screenshot
end

When(/^выбрал счет (.*)$/) do |acc|
  sleep 1
  @mainpage.wait_until_acc_drop_list_visible
  @mainpage.acc_drop_list.click
  @mainpage.select_account(:text => acc).click
  @mainpage.confirm_account[0].click
  @select_account_type = @mainpage.select_account_type.text
end

When(/^ввел сумму (.*)$/) do |sum|
  @mainpage.amount_text_field.set sum
end

When(/^имеется предупреждение неверной суммы$/) do
  assert_true(page.has_text?('Сумма превышает остаток на счёте'), "Нет сообщения о неверной сумме #{screenshot}")
end

When(/^выбрал город (.*)$/) do |city|
  @city = city
  @mainpage.city_drop_list.click
  @mainpage.select_city(:text => city).click
  @mainpage.confirm_city[0].click
end

When(/^выбрал отделение (.*)$/) do |branch|
  @mainpage.wait_until_branch_drop_list_visible
  @mainpage.branch_drop_list.click
  @mainpage.select_branch(:text => branch).click
  @branchAddress = @mainpage.branch_address.text
  @mainpage.confirm_branch[0].click
end

When(/^установил дату выдачи (.*)$/) do |date|
  @orderDate = date
  @mainpage.calendar_drop.set date
  @mainpage.confirm_calendar[0].click
end


When(/^имеется текст "([^"]*)"$/) do |text|
  assert_true(page.has_text?(text), "Имеется сообщение об ошибке #{screenshot}")
end

When(/^дата выдачи = Т \+ (\d+)$/) do |days|

  @mainpage.calendar_drop.click
  inactive = Array.new()
  sleep 1
  @mainpage.calendar_days.each_with_index { |el, index |
    if (!el.text.to_s.empty?)
      inactive[index] = Date.strptime("#{el.text}-#{Date.today.strftime("%m")}-#{Date.today.strftime("%Y")}", '%d-%m-%Y').strftime("%u")
    end
  }
  #active = all("td[data-day]")

  lastInactive = inactive.last.to_i

  orderHour = Time.now.strftime("%H").to_i
  orderDayOfWeek = Date.today.strftime("%u").to_i
  orderDayOfMonth  = Date.today.strftime("%e").gsub(/\s+/, "").to_i

  checkOrderHour = 13

  screenshot

  if (days == "1" && orderHour < checkOrderHour)
    if(orderDayOfWeek == 1 || orderDayOfWeek == 2 || orderDayOfWeek == 3 || orderDayOfWeek == 4)
      assert_equal(orderDayOfWeek, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 5)
      assert_equal(7, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 6)
      assert_equal(1, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 7)
      assert_equal(1, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    end

  elsif (days == "1" && orderHour >= checkOrderHour)
    if(orderDayOfWeek == 1 || orderDayOfWeek == 2 || orderDayOfWeek == 3)
      assert_equal(orderDayOfWeek + 1, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 4)
      assert_equal(7, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 5)
      assert_equal(1, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 6)
      assert_equal(1, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 7)
      assert_equal(1, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    end

  elsif (days == "3" && orderHour < checkOrderHour)
    if(orderDayOfWeek == 1 || orderDayOfWeek == 2)
      assert_equal(orderDayOfWeek + 2, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 3)
      assert_equal(7, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 4)
      assert_equal(1, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 5)
      assert_equal(2, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 6)
      assert_equal(3, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 7)
      assert_equal(3, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    end

  elsif (days == "3" && orderHour >= checkOrderHour)
    if(orderDayOfWeek == 1)
      assert_equal(orderDayOfWeek + 3, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 2)
      assert_equal(7, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 3)
      assert_equal(1, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 4)
      assert_equal(2, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 5)
      assert_equal(3, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 6)
      assert_equal(3, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    elsif(orderDayOfWeek == 7)
      assert_equal(3, lastInactive, "Минимально возможная дата не удовлетворяет условиям Т + #{days} #{screenshot}")
    end
  end
end

When(/^раскрыл список отделений$/) do
  @mainpage.branch_drop_list.click
  @branches = @mainpage.branches.map { |e| e.text}
end

When(/^клиенту возможен выбор отделения "(.*)"$/) do |branch|
  assert_true((@branches.include? branch), "Среди списка отделений нет искомого #{p @branches}")
end

When(/^клиенту невозможен выбор отделения "(.*)"$/) do |branch|
  assert_true(!(@branches.include? branch), "Среди списка отделений имеется искомый #{p @branches}")
end

When(/^гланая страница не открыта$/) do
  assert (!page.has_text? "Заказ наличных"), screenshot
  assert_not_equal($cash_url, current_url)
end

When(/^предвыбран город (.*)$/) do |city|
  @mainpage.has_no_empty_city?
  assert_equal(city, @mainpage.current_city.text, "Не предвыбран верный город #{screenshot}")
end

When(/^предвыбрано отделение (.*)$/) do |branch|
  assert_equal(branch, @mainpage.current_branch.text, "Не предвыбрано верное отделение #{screenshot}")
end

When(/^предвыбран счет (.*)$/) do |account|
  accountUI = @mainpage.current_account.text
  accountTest = "••#{account[-4..-1]}"
  assert_equal(accountTest, accountUI, "Не предвыбран верный счет #{screenshot}")
end

And(/^нажал кнопку "Заказать"$/) do
  @mainpage.order_button.click
end

When(/^элемент формы (.*) содержит текст  (.*)$/) do |element, content|
  assert_true(@mainpage.send(element).text.include?(content), "В форме для элемента #{element} отсутсвует текст #{content} #{screenshot}");
end

When(/^элемент формы (.*) отображается на странице$/) do |element|
  assert_true(@mainpage.send("has_#{element}?"),"На странице отсутствует элемент #{element}")
end

When(/^нажал на ссылку всплывающее окна (.*)$/) do |element|
  assert_nothing_raised "На странице отсутствует ссылка /'#{element}/' на всплывающее окно" do
    @mainpage.document_links.find{|e| e.text == element}.click
  end
end

When(/^отображается всплывающее окно для (.*) с текстом (.*)$/) do |element, expectedContent|
  assert_true(@mainpage.has_popup?,"На странице отсутствует всплывающее окно /'#{element}/'")
  assert_true(@mainpage.popup.text.include?(expectedContent),"Всплывающее окно не содержит ожидаемого текста /'#{expectedContent}/'...")
end