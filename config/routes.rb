Rails.application.routes.draw do

  scope module: 'api' do
    namespace :v1 do
      resources :tasks
      resources :users

      post 'user_token' => 'user_token#create'
    end
  end

end
