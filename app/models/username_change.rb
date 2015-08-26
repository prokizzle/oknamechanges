class UsernameChange < ActiveRecord::Base
  acts_as_votable

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
    newNames, oldName = [change.new_name], change.old_name
    nextChange, change_id, likes = "", change.id, change.votes_for.size
    until nextChange.nil?
      nextChange = and_then(change.new_name)
      unless nextChange.nil?
        newNames << nextChange.new_name
        change = nextChange
        break if nextChange.new_name == oldName
      end
    end
    match = Match.where(name: change.new_name).first
    return {id: change_id, old_name: oldName, new_names: newNames, likes: likes, match: match}
  end

  def self.test
    change = find_by(old_name: "Paulina_z")
    newNames = [change.new_name]
    oldName = change.old_name
    nextChange = ""
    until nextChange.nil?
      nextChange = and_then(change.new_name)
      unless nextChange.nil?
        newNames << nextChange.new_name
        change = nextChange
      end
    end
    return {old_name: oldName, new_names: newNames}
  end
end
