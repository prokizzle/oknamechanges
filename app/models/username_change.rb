class UsernameChange < ActiveRecord::Base
  acts_as_votable

  def self.and_then(name)
    find_by(old_name: name)
  end

  def self.random
    offset = rand(count)
    change = offset(offset).first
    newNames = [change.new_name]
    oldName = change.old_name
    nextChange = ""
    change_id = change.id
    likes = change.votes_for.size
    until nextChange.nil?
      nextChange = and_then(change.new_name)
      unless nextChange.nil?
        newNames << nextChange.new_name
        change = nextChange
        break if nextChange.new_name == oldName
      end
    end
    return {id: change_id, old_name: oldName, new_names: newNames, likes: likes}
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
