# Handles creating and recalling okcupid sessions
class CrawlSession
  def self.create(opts)
    browser = Browser.new(username: opts[:username], password: opts[:password])
    browser.login
    self.cookies = browser.save_session if browser.is_logged_in?
    browser.is_logged_in?
  end

  def self.get
    browser = Browser.new(session: cookies, user_agent: user_agent)
    browser.is_logged_in?
  end

  def self.cookies
    $redis.get('cookies')
  end

  def self.cookies=(cookies)
    $redis.set('cookies', cookies)
  end

  def self.user_agent
    $redis.get('user-agent')
  end
end
