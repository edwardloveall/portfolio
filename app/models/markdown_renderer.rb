require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'
require 'redcarpet/render_strip'

class Redcarpet::Render::StripDown
  def link(_, _, content)
    content
  end
end

class MarkdownRenderer
  EXTENSIONS = { fenced_code_blocks: true, tables: true }.freeze
  RENDERER_OPTIONS = { with_toc_data: true }.freeze

  def self.to_html(markdown)
    new(markdown).to_html
  end

  def self.to_text(markdown)
    new(markdown).to_text
  end

  def initialize(markdown)
    @markdown = markdown || ''
  end

  def to_html
    renderer = SmartHtml.new(RENDERER_OPTIONS)
    Redcarpet::Markdown.new(renderer, EXTENSIONS).render(@markdown)
  end

  def to_text
    renderer = Redcarpet::Render::StripDown
    Redcarpet::Markdown.new(renderer).render(@markdown).chomp
  end

  class SmartHtml < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    include Rouge::Plugins::Redcarpet
  end
end
