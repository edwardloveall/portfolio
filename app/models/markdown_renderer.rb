require "redcarpet"
require "rouge"
require "redcarpet/render_strip"

class Redcarpet::Render::StripDown
  def link(_, _, content)
    content
  end
end

class MarkdownRenderer
  EXTENSIONS = {
    autolink: true,
    fenced_code_blocks: true,
    tables: true
  }.freeze

  def self.to_html(markdown)
    new(markdown).to_html
  end

  def self.to_text(markdown)
    new(markdown).to_text
  end

  def initialize(markdown)
    @markdown = markdown || ""
  end

  def to_html
    renderer = SmartHtml.new(with_toc_data: true)
    Redcarpet::Markdown.new(renderer, EXTENSIONS).render(@markdown)
  end

  def to_text
    renderer = Redcarpet::Render::StripDown
    Redcarpet::Markdown.new(renderer).render(@markdown).chomp
  end

  class SmartHtml < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(code, language)
      lexer = Rouge::Lexer.find_fancy(language, code) ||
        Rouge::Lexers::PlainText
      formatter = Formatter.new(css_class: "highlight #{lexer.tag}")
      formatter.format(lexer.lex(code))
    end
  end

  class Formatter < Rouge::Formatter
    def initialize(css_class: "highlight")
      @css_class = css_class
    end

    def stream(tokens, &b)
      yield %(<pre class="#{@css_class}"><code>)
      Rouge::Formatters::HTML.new.stream(tokens, &b)
      yield "</code></pre>"
    end
  end
end
