# Scheduler for creating profile visit jobs
class ScheduleWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: false
  recurrence { minutely.second_of_minute(1, 20, 40) }

  def perform
    Scheduler.queue = Match.queue if Scheduler.empty?
    _name = Scheduler.next
    url = "http://www.okcupid.com/profile/#{_name}"
    Browser.request(url, HandleVisitWorker) unless _name.nil?
  end
end
