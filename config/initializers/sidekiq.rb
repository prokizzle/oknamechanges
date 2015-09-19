require 'sidekiq'
require 'sidekiq-runner'

Sidekiq.configure_server do |config|
  Encoding.default_external = Encoding::UTF_8
  config.redis = { url: ENV['redis_url'],
                   namespace: 'lazycupid'
                   }
end

Sidekiq.configure_client do |config|
  Encoding.default_external = Encoding::UTF_8
  config.redis = { url: ENV['redis_url'],
                   namespace: 'lazycupid' }
end

SidekiqRunner.configure do |config|
  config.add_instance('default') do |instance|
    instance.verbose = false
    instance.concurrency = 5
    instance.add_queue 'default'
  end
end

SidekiqRunner.configure_god do |god_config|
  god_config.interval = 30
  god_config.maximum_memory_usage = 700 # 4 GB.
end
