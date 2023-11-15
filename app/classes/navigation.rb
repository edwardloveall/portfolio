class Navigation < ActionView::Base
  attr_reader :path

  def self.links(path = "/")
    new(path).links
  end

  def initialize(path = "/")
    @path = path
  end

  def links
    content_tag(:nav, class: :main) do
      ["about", "projects", "music"].each do |page|
        if active_page == page
          concat(link_to(page.titleize, "/#{page}", class: :active))
        else
          concat(link_to(page.titleize, "/#{page}"))
        end
      end
    end
  end

  private

  def active_page
    @active ||= path.split("/")[1] || "projects"
  end
end
