# See full documentation here: https://github.com/plataformatec/simple_form#configuration

SimpleForm.setup do |config|
  config.wrappers :default,
                  class: :input,
                  hint_class: :field_with_hint,
                  error_class: :field_with_errors do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label_input
    b.use :hint, wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }
  end

  config.boolean_label_class = 'checkbox'
  config.boolean_style = :nested
  config.browser_validations = false
  config.button_class = 'btn'
  config.default_wrapper = :default
  config.error_notification_class = 'error_notification'
  config.error_notification_tag = :div
end
