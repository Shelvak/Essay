module ReportsHelper
  def tab_for_report(title, target, collection, active=false)
    if collection.try(:any?)
      link = link_to(title, target, data: { toggle: 'tab' })
      content_tag(:li, link, role: 'presentation', class: (active ? 'active' : ''))
    end
  end
end
