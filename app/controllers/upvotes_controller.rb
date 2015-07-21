class UpvotesController < ApplicationController
  before_filter :authenticate_user!

  def upvote
    change = UsernameChange.find_by(id: params[:id])
    unless current_user.nil?
      change.liked_by(current_user)
    end

    render json: {likes: change.get_likes.size, loggedIn: !current_user.nil?}.as_json
  end

  def your_upvotes
    @changes = current_user.find_voted_items.map do |change|
      UsernameChange.change_for(change.old_name)
    end
  end
end