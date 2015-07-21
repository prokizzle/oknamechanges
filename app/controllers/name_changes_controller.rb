class NameChangesController < ApplicationController

  def get_next
    render json: UsernameChange.random.as_json
  end

  def like

  end
end
