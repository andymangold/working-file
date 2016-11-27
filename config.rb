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

config[:host] = "https://andymangold.github.io/working-file"

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end

# Deployment to GitHub pages
activate :deploy do |deploy|
  deploy.deploy_method = :git
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  # deploy.branch   = 'custom-branch' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
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
    proxy "/episodes/#{episode.slug}.html", "/episodes/template.html", :locals => { :id => episode.id, :date => episode.date, :title => episode.title, :soundcloudID => episode.soundcloudID, :contributorSlugs => episode.contributorSlugs, :showNotes => episode.showNotes, :links => episode.links }
  end
end

ignore "/episodes/template.html"


# Create pages for each contributor dynamically
data.contributors.each do |contributor|
  proxy "/contributors/#{contributor.slug}.html", "/contributors/template.html", :locals => { :firstName => contributor.firstName, :lastName => contributor.lastName, :slug => contributor.slug, :host => contributor.host, :twitter => contributor.twitter, :website => contributor.website, :bio => contributor.bio }
end

ignore "/contributors/template.html"
