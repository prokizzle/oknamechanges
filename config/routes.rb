Rails.application.routes.draw do
  root 'home#index'
  get '/api/random-name-change' => 'name_changes#get_next'
end
