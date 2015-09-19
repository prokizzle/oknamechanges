class UsernameChange < ActiveRecord::Base
  def self.and_then(name)
    find_by(old_name: name)
  end

  def self.random
    offset = rand(count)
    change = offset(offset).first
    change_for(change.old_name)
  end

  def self.change_for(old_name)
    change = find_by(old_name: old_name)
    new_names, old_name = [change.new_name], change.old_name
    next_change = ''
    until next_change.nil?
      next_change = and_then(change.new_name)
      break if next_change.nil?
      new_names << next_change.new_name
      change = next_change
      break if next_change.new_name == old_name
    end
    match = Match.where(name: change.new_name).first
    { old_name: old_name, new_names: new_names, match: match }
  end
end
