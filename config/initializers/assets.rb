# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.configure do

  # Enable the asset pipeline
  APP_VERSION = `git describe --always` unless defined? APP_VERSION
  config.assets.enabled = true
  config.assets.version = APP_VERSION

  # Add the fonts path
  config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')

  # Precompile additional assets
  config.assets.precompile += %w( *.svg *.eot *.woff *.ttf )
  config.assets.precompile += %w( *.png *.jpg *.jpeg *.gif )

  config.react.addons = false # defaults to false

  # Needs to be false on Heroku
  config.serve_static_files = true
  config.static_cache_control = "public, max-age=31536000"

  # Add additional assets to the asset load path
  # Rails.application.config.assets.paths << Emoji.images_path

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # Rails.application.config.assets.precompile += %w( search.js )
end
