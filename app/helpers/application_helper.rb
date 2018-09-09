module ApplicationHelper

  def title(name)
    provide(:title, name)
  end

  def full_title(title = '')
    base_title = "Cyberlolz"
    if title.empty?
      base_title
    else
      "#{title} | #{base_title}"
    end
  end
end
