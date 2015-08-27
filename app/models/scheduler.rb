# class methods used for schedule worker
class Scheduler
  def self.empty?
    $redis.llen("crawl_queue").nil? ? 0 : $redis.llen("crawl_queue").zero?
  end

  def self.queue=(queue)
    size = $redis.llen("crawl_queue")
    $redis.rpush("crawl_queue", queue) if size.zero? && queue.size > 0
  end

  def self.next
    return $redis.rpop("crawl_queue")
  end
end
