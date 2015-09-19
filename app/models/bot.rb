# Handles creating and recalling okcupid bots
class Bot
  def self.create(opts)
    browser = Browser.new(username: opts[:username], password: opts[:password])
    browser.login
    BotPool.add(browser.save_session) if browser.logged_in?
    browser.logged_in?
  end

  def self.user_agent
    $redis.get('user-agent')
  end
end
