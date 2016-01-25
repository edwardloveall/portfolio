require 'redcarpet'

class MarkdownRenderer
  EXTENSIONS = { fenced_code_blocks: true, tables: true }.freeze
  RENDERER_OPTIONS = { with_toc_data: true }.freeze

  def self.to_html(markdown)
    new(markdown).to_html
  end

  def initialize(markdown)
    @markdown = markdown || ''
  end

  def to_html
    renderer = SmartHtml.new(RENDERER_OPTIONS)
    Redcarpet::Markdown.new(renderer, EXTENSIONS).render(@markdown)
  end

  class SmartHtml < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
  end
end
