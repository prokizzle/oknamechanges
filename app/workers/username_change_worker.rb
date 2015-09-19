# handle imported username changes async
class UsernameChangeWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(old_name, new_name)
    UsernameChange.create(old_name: old_name, new_name: new_name)
  end
end