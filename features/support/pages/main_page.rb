class MainPage < SitePrism::Page

  set_url "#{$cash_url}order?customerId={pin}"

  element :acc_drop_list, :css, '.page-order__select-account'
  element :select_account, :css, '.menu-item .account'
  elements :confirm_account, :css, '.paragraph'
  element :amount_text_field, :css, 'input#order-amount'
  element :banknote_checkbox, :css, 'label'
  element :banknote_text_field, :css, '#order-comment'
  element :city_drop_list, :css, '.branch-picker__city'
  element :select_city, :css, '.select__popup .menu-item'
  elements :confirm_city, :css, '.paragraph'
  element :branch_drop_list, :css, '.branch-picker__branch'
  elements :branches, :css, '.branch__title'
  element :select_branch, :css, '.branch__title'
  element :branch_address, :css, '.branch-picker__branch .select-button__text'
  elements :confirm_branch, :css, '.paragraph'
  element :calendar_drop, :css, '.calendar-input input'
  elements :confirm_calendar, :css, '.paragraph'
  element :order_button, :css, 'button.page-order__button'
  element :logout_button, :css, '.app-page__logout'
  element :empty_city, :css, '.branch-picker__city button span.select-button__text .branch-picker__select-placeholder'
  element :current_city, :css, '.branch-picker__city button span.select-button__text'
  element :current_branch, :css, '.branch-picker__branch button span.select-button__text'
  element :current_account, :css, '.account__number'
  elements :calendar_days, :css, 'td:not([data-day])'
  element :select_account_type,:css,'.account-select__selected .account__name';
  element :amount_title,:css, '.form-field .money-input'
  element :calendar_title,:css,'.calendar-input__custom-control'
  element :popup,:css,'.documents__info'
  elements :document_links,:css, '.info-link__info-link'
end