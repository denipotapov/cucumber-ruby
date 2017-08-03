class HistoryPage < SitePrism::Page

  elements :receive_dates, :css, '.history-order__delivery-date'
  elements :amount, :css, '.amount'
  elements :accounts, :css, '.history-order__account'
  elements :addresses, :css, '.history-order__branch'
  elements :order_dates, :css, '.history-order__creation-date'

end