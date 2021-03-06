###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

###
# Gem
###
require 'slim'
Slim::Engine.disable_option_validator!

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'images'

data.shop.each do |v|
  proxy "/shop/#{ v.url }.html",
  "/shop/template.html", locals: { shop: v }, ignore: true
end

data.event.each do |v|
  proxy "/event/#{ v.url }.html",
  "/event/template.html", locals: { event: v }, ignore: true
end

set :slim, { pretty: true, sort_attrs: true, format: :html5 }

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets
  activate :directory_indexes

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
  set :relative_links, true
  set :strip_index_file, false

  activate :autoprefixer do |config|
    config.browsers = ['last 2 versions', 'Explorer >= 9']
    config.cascade  = false
    config.inline   = true
  end
end
