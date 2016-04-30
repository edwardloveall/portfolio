class Navigation < ActionView::Base
  def self.perform(path)
    new(path).perform
  end

  def initialize(path)
    @path = path
  end

  def perform
    content_tag(:nav, class: :main) do
      nav_set.each do |link|
        concat link_from_string(link)
      end
    end
  end

  private

  attr_reader :path

  def nav_set
    sets = {
      '/about' => ['projects', 'music'],
      '/projects' => ['about', 'music'],
      '/music' => ['about', 'projects']
    }
    set_key = sets.keys.detect { |key| path.match(key) } || '/projects'
    sets[set_key]
  end

  def link_from_string(string)
    link_to(string.titleize, "/#{string}")
  end
end
