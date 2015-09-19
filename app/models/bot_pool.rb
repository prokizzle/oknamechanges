# Handles a pool of okcupid bots
class BotPool
  def self.next
    session = $redis.rpop('bots')
    $redis.lpush('bots', session)
    session
  end

  def self.add(session)
    $redis.lpush('bots', session)
  end

  def self.size
    $redis.llen('bots')
  end

  def self.enabled?
    !size.zero?
  end

  def self.next_for_service
    $redis.rpop('bots')
  end
end
