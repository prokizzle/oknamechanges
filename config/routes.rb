Rails.application.routes.draw do
  # root 'home#index'
  root to: 'application#redirect_to_name_changes'
  get '/api/random-name-change' => 'name_changes#get_next'
  get '/namechanges' => 'home#index'
end
