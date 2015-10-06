class HomeController < ApplicationController
  def index
    @first_change = UsernameChange.random
    @total_changes = UsernameChange.all.size
  end

  def import
    params[:names].each do |name|
      AddMatchWorker.perform_async(name)
    end
    render json: { success: true }.as_json
  end
end
