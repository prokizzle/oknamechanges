class Match < ActiveRecord::Base
  def self.queue
    where(last_visited: 0..Chronic.parse('1 day ago').to_i).order(last_visited: :desc).limit(30).to_a.map{|u| u.name}
  end

  def self.change_name(old_name, new_name)
    return if old_name.empty?
    return if new_name.empty?
    Match.find_by(name: old_name).update_all(name: new_name)
    UsernameChange.create(old_name: old_name, new_name: new_name)
  end
end
