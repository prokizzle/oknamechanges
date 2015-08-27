# Handles all HTTP requests, takes a callback
class HttpRequestWorker
  include Sidekiq::Worker

  def perform(link, callback)
    request_id = UUIDTools::UUID.random_create
    src = page_source(link) rescue nil
    result_object = { url: link, username: intended_handle(link),
                      src: src, inactive: !src.nil? }
    handle_request(request_id, result_object, callback)
  end

  def handle_request(request_id, result_object, callback)
    $redis.set(request_id, Marshal.dump(result_object))
    perform_callback(callback, request_id)
  end

  def page_source(link)
    page_object = agent.get(link)
    page_object.encoding = 'utf-8'
    page_object.parser.xpath('//html').to_s
  end

  def intended_handle(link)
    @handle ||= link.split('/').last
  end

  def agent
    @cookies ||= CrawlSession.get_cookies
    @agent ||= Mechanize.new do |a|
      a.ssl_version = :TLSv1
      a.cookie_jar      = YAML.load(cookies)
      a.user_agent      = CrawlSession.user_agent
      a.read_timeout    = 30
    end
  end

  def perform_callback(callback, request_id)
    return false if callback.nil?
    worker = Object.const_get(callback)
    worker.send(:perform_async, request_id)
  end
end
