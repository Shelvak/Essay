module MenuHelper
  def menu_item_for model, path
    if can?(:read, model)
      link = link_to model.model_name.human(count: 0), path
      active = model.model_name.route_key == controller_name

      content_tag(:li, link, (active ? { class: 'active' } : {}))
    end
  end

  def custom_menu_item_for component, title, path
    if can?(:read, component)
      link = link_to t('menu.' + title), path
      active = component.to_s.pluralize == controller_name

      content_tag(:li, link, (active ? { class: 'active' } : {}))
    end
  end

end
