Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get '/api/random-name-change' => 'name_changes#get_next'

  post '/api/upvote' => 'upvotes#upvote'
end
