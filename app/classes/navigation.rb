class Navigation
  Link = Struct.new(:path, :text, :attrs, keyword_init: true)

  def self.links(path = "/")
    new(path).links
  end

  def initialize(path = "/")
    @path = path
  end

  def links
    active_attrs = {class: :active, aria: {current: true}}
    ["about", "projects", "music"].map do |page|
      if active_page == page
        Link.new(path: "/#{page}", text: page.titleize, attrs: active_attrs)
      else
        Link.new(path: "/#{page}", text: page.titleize)
      end
    end
  end

  private

  attr_reader :path

  def active_page
    @active ||= path.split("/")[1] || "projects"
  end
end
