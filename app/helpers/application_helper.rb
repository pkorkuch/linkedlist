module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'LinkedList'
    return base_title if page_title.empty?

    "#{page_title} | #{base_title}"
  end
end
