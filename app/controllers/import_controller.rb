# Handles importing records
class ImportController < ApplicationController
  skip_before_action :verify_authenticity_token

  def username_changes
    params[:changes].each do |change|
      UsernameChangeWorker.perform_async(change[:old_name], change[:new_name])
    end
    head 200, content_type: 'text/html'
  end

  def seeds
    params[:names].each do |name|
      AddMatchWorker.perform_async(name)
    end
    head 200, content_type: 'text/html'
  end
end
