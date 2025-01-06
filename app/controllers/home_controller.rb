class HomeController < ApplicationController
  def index
    readme_path = Rails.root.join('README.md')
    markdown = File.read(readme_path)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @content = renderer.render(markdown).html_safe
  end
end
