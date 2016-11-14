###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

# Templating
require 'slim'

# Autoprefixing
activate :autoprefixer

# Set Relative Paths
activate :relative_assets
set :relative_links, true

# Create pages for each episode dynamically
data.episodes.each do |episode|
  if episode.published == true
    proxy "/episodes/#{episode.slug}.html", "/episodes/template.html", :locals => { :title => episode.title, :soundcloudID => episode.soundcloudID, :contributors => episode.contributors, :published => episode.published }
  end
end

ignore "/episodes/template.html"
