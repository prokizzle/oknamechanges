# Handles all HTTP requests, takes a callback
# Callback must be a sidekiq worker that takes
# @request_id as the only argument
class HttpRequestWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(link, callback=nil)
    return false unless internet_connection?
    request_id = UUIDTools::UUID.random_create
    Clipboard.copy request_id if callback.nil?
    src = page_source(link) rescue nil
    result_object = { url: link, username: intended_username(link),
                      src: src, inactive: src.nil? }
    publish_result(request_id, result_object, callback)
  end

  def publish_result(request_id, result_object, callback)
    $redis.set(request_id, Marshal.dump(result_object))
    perform_callback(callback, request_id)
  end

  def page_source(link)
    page_object = agent.get(link)
    page_object.encoding = 'utf-8'
    page_object.parser.xpath('//html').to_s
  end

  def intended_username(link)
    URI.decode(link.split('/').last)
  end

  def internet_connection?
    Net::Ping::External.new("8.8.8.8").ping?
  end

  def agent
    Mechanize.new do |a|
      a.read_timeout = 30
      a.ssl_version = :TLSv1
      a.cookie_jar = YAML.load(BotPool.next)
      a.user_agent = Bot.user_agent
    end
  end

  def perform_callback(callback, request_id)
    return false if callback.nil?
    worker = Object.const_get(callback)
    worker.send(:perform_async, request_id)
  end
end
