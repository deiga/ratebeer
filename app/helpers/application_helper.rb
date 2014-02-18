module ApplicationHelper
  def edit_and_destroy_buttons(item)
    unless current_user.nil?
      edit = link_to('Edit', url_for([:edit, item]), class: 'ui mini button circular')
      del = link_to('Destroy', item, method: :delete,
        data: {confirm: 'Are you sure?' }, class: 'ui mini negative button circular')
      raw("#{edit} #{del}")
    end
  end

  def round(number)
    number_with_precision(number, precision: 1)
  end
end
