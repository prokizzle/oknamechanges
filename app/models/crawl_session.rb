# Handles creating and recalling okcupid sessions
class CrawlSession
  def self.cookies
    $redis.get('cookies')
  end

  def self.user_agent
    $redis.get('user-agent')
  end
end
