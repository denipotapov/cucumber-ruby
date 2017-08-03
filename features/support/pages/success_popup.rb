class SuccessPopUp < SitePrism::Page

  element :close_button, :css, '.popup-header__closer'
  element :body, :css, 'body'
  element :amount_major, :css, '.success-modal__para .amount__major'
  element :amount_minor, :css, '.success-modal__para .amount__minor-container'
  element :amount_currency, :css, '.success-modal__para .amount__currency'
  element :order_date, :css, '.success-modal__para:nth-of-type(3) div:nth-child(1)'
  element :address, :css, 'notification-modal__inner .success-modal__branch'
  element :schedule, :css, '.branch-schedule'
  element :success_popup,:css,'.success-modal__popup'

end