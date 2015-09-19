class Match < ActiveRecord::Base
  validates :name, uniqueness: true

  def self.queue
    condition = { last_visited: 0..Chronic.parse('7 days ago').to_i }
    where(condition).order(last_visited: :desc).limit(30).to_a.map(&:name)
  end

  def self.change_name(old_name, new_name)
    return if old_name.empty?
    return if new_name.empty?
    Match.find_by(name: old_name).update(name: new_name) if exists?(old_name)
    UsernameChange.create(old_name: old_name, new_name: new_name)
  end

  def self.exists?(old_name)
    !Match.find_by(name: old_name).nil?
  end
end
