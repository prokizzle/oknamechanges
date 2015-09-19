# worker for adding new okcupid users to the database
class AddMatchWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(username)
    Match.create(name: username) if Match.find_by(name: username).nil?
  end
end
