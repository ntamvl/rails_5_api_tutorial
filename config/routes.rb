Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/docs' => redirect('/api_html/dist/index.html?url=/apidocs/api-docs.json')

  constraints subdomain: 'api' do
    # some namespace
  end

  scope module: 'api' do
    scope module: 'v1' do
      get '/' => 'home#index_public'
    end
    namespace :v1 do
      resources :users
    end
  end
end
