# Callback worker to handle profile visits
class HandleVisitWorker
  include Sidekiq::Worker

  def perform(result_id)
    result = Browser.response(result_id)
    profile = Profile.parse(result)
    handle_name_changes(profile)

    condition = { name: result[:username] }
    Match.where(condition).update_all(inactive: true) if result[:inactive]
  end

  def handle_name_changes(profile)
    return false unless change_detected?(profile)
    args = [result[:username], profile[:new_handle]]
    Match.change_name(args) if profile[:a_list_name_change]
  end

  def change_detected?(profile)
    profile[:handle] != profile[:intended_handle] && !profile[:inactive]
  end
end
