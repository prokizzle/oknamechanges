# Callback worker to handle profile visits
class HandleVisitWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(result_id)
    result = Browser.response(result_id)
    profile = Profile.parse(result)
    handle_name_changes(result, profile)

    condition = { name: result[:username] }
    return if Match.where(condition).nil?
    update_match(condition, profile, result)
    add_users(profile)
  end

  def update_match(condition, profile, result)
    Match.where(condition).update_all(inactive: true) if result[:inactive]
    Match.where(condition).update_all(
      last_visited: Time.current.to_i,
      city: profile[:city],
      state: profile[:state],
      gender: profile[:gender]
    )
  end

  def handle_name_changes(result, profile)
    return false unless change_detected?(profile)
    Match.change_name(result[:username], profile[:new_handle]) if profile[:a_list_name_change]
  end

  def change_detected?(profile)
    return false if profile[:inactive]
    URI.decode(profile[:handle]) != URI.decode(profile[:intended_handle])
  end

  def add_users(profile)
    profile[:similar_users].to_a.each do |user|
      AddMatchWorker.perform_async(user)
    end
  end
end
