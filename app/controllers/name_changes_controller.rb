class NameChangesController < ApplicationController

  def get_next
    render json: UsernameChange.random.as_json
  end

  def like

  end

  def popular
    @changes = UsernameChange.all.order(:cached_votes_total => :desc).limit(15).map do |change|
      UsernameChange.change_for(change.old_name)
    end
  end
end
