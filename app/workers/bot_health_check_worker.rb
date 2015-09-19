# Health check for bots
# Makes sure the BotPool only contains healthy bots
class BotHealthCheckWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: false
  recurrence { hourly }

  def perform
    return false unless internet_connection?
    BotPool.size.times do
      bot = BotPool.next_for_service
      browser = Browser.new(session: bot)
      BotPool.add(bot) if browser.logged_in?
    end
  end

  def internet_connection?
    Net::Ping::External.new("8.8.8.8").ping?
  end
end
