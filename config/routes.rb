Rails.application.routes.draw do

  scope module: 'api' do
    namespace :v1 do
      resources :tasks
    end
  end
  
end
