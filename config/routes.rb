Rails.application.routes.draw do
  # root 'home#index'
  root to: 'application#redirect_to_name_changes'
  get '/api/random-name-change' => 'name_changes#get_next'
  get '/api/total-changes' => 'name_changes#get_total'
  get '/namechanges' => 'home#index'
  post '/import/seeds' => 'import#seeds'
  post '/import/changes' => 'import#username_changes'
  require 'sidetiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
