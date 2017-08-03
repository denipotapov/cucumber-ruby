require 'selenium/webdriver'
require 'capybara'
require 'capybara/cucumber'

def screenshot
  #formatter = Cucumber::Formatter::Json.new
  filename = "#{Capybara.save_path}#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.png"
  page.driver.browser.save_screenshot(filename)
  embed(filename, 'image/png', 'Screenshot')
  filename
end

def format_date(date)
  date = Date.parse(date)
  month = date.strftime("%m")
  day = date.strftime("%d")

  case month
    when '01'
      date = day + ' ' + 'января'
    when '02'
      date = day + ' ' + 'февраля'
    when '03'
      date = day + ' ' + 'марта'
    when '04'
      date = day + ' ' + 'апреля'
    when '05'
      date = day + ' ' + 'мая'
    when '06'
      date = day + ' ' + 'июня'
    when '07'
      date = day + ' ' + 'июля'
    when '08'
      date = day + ' ' + 'августа'
    when '09'
      date = day + ' ' + 'сентября'
    when '10'
      date = day + ' ' + 'октября'
    when '11'
      date = day + ' ' + 'ноября'
    when '12'
      date = day + ' ' + 'декабря'
  end
end