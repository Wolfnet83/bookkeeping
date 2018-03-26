module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      @messages = content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissable fade in") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end
    end
    @messages
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'
    new_params = {}
    new_params.merge!(params.to_h)
    new_params.merge!(sort_by: column, dir: direction)
    link_to title, url_for(new_params)
  end

  def number_in_money(currency, amount)
    currency.present? ? unit = currency.abbr_name : unit = 'MDL'
    number_to_currency amount, unit: unit, format: '%n %u'
  end
end
