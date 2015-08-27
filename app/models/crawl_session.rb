# Handles creating and recalling okcupid sessions
class CrawlSession
  def self.create(opts)
    browser = Browser.new(username: opts[:username], password: opts[:password])
    browser.login
    self.cookies = browser.save_session if browser.logged_in?
    browser.logged_in?
  end

  def self.get
    browser = Browser.new(session: cookies, user_agent: user_agent)
    browser.logged_in?
  end

  def self.cookies
    $redis.get('cookies')
  end

  def self.cookies=(session)
    $redis.set('cookies', session)
  end

  def self.user_agent
    $redis.get('user-agent')
  end
end
