module ApplicationHelper
  def md(text)
    MARKDOWN.render(text).html_safe
  end
end
