Rails.application.routes.draw do
  get 'apple/index'
  get '/apple/show', to: 'apple#show', as: :show

  root 'apple#index'
end
