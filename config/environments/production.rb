Rails.application.configure do
  config.react.variant = :production
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.action_dispatch.rack_cache = true

  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass
  config.assets.compile = false
  config.assets.digest = true

  config.log_level = :debug

  config.action_controller.asset_host = ENV['ASSET_HOST']

  config.cache_store = :redis_store, ENV['cache'], { expires_in: 90.minutes }
  config.static_cache_control = "public, max-age=#{1.year.to_i}"
  config.action_dispatch.rack_cache = {
    metastore:   "#{ENV['REDIS_URL']}/1/metastore",
    entitystore: "#{ENV['REDIS_URL']}/1/entitystore"
  }

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
end
