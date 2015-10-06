location = ENV['REDIS_URL'] || ENV['redis_url']
uri = URI.parse(location)
$redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)
