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

config[:host] = "https://workingfile.co"

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
  deploy.build_before = true
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
  proxy "/episodes/#{episode.id}.html", "/episodes/template.html", :locals => { :id => episode.id, :date => episode.date, :title => episode.title, :transcript => episode.transcript, :contributorSlugs => episode.contributorSlugs, :showNotes => episode.showNotes, :links => episode.links }
end

ignore "/episodes/template.html"


# Create pages for each contributor dynamically
data.contributors.each do |contributor|
  proxy "/contributors/#{contributor.slug}.html", "/contributors/template.html", :locals => { :firstName => contributor.firstName, :lastName => contributor.lastName, :slug => contributor.slug, :host => contributor.host, :twitter => contributor.twitter, :websites => contributor.websites, :bio => contributor.bio }
end

ignore "/contributors/template.html"

set :url_root, 'https://workingfile.co'

activate :search_engine_sitemap


module ArrayToSentenceExtension
  def to_sentence(options = {})
    default_connectors = {
      words_connector: ", ",
      two_words_connector: " and ",
      last_word_connector: ", and "
    }
    options = default_connectors.merge!(options)

    case length
    when 0
      ""
    when 1
      "#{self[0]}"
    when 2
      "#{self[0]}#{options[:two_words_connector]}#{self[1]}"
    else
      "#{self[0...-1].join(options[:words_connector])}#{options[:last_word_connector]}#{self[-1]}"
    end
  end
end

Array.prepend(ArrayToSentenceExtension)
