Rails.application.routes.draw do
  get "/" => "pages#index"

  get "/signup" => "users#new"
  post "/users" => "users#create"
  get "/users/:id" => "users#show"
  get "/users/:id/edit" => "users#edit"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/leagues/new" => "leagues#new"
  post "/leagues" => "leagues#create"
  get "/leagues/:id" => "leagues#show"
  #get "/leagues/:id/edit" => "leagues#edit"
  #patch "/leagues/:id" => "leagues#update"
  #delete "/leagues/:id" => "leagues#destroy"

end
