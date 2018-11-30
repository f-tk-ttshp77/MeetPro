Rails.application.routes.draw do

  get '/' => 'home#top'
  get '/about' => 'home#about'
  post '/rooms/create' => 'rooms#create'
  post '/rooms/addition' => 'rooms#addition'
  get '/rooms/:id' => 'rooms#show'
  post '/users/state_change/:id' => 'rooms#state_change'
  get '/msgtype/new' => 'msgtype#new'
  post '/msgtype/create' =>'msgtype#create'

  devise_for :users, :controllers => {
   :registrations => 'users/registrations',
   :sessions => 'users/sessions'
  }

  devise_scope :user do
    get 'users/my_page' => 'users/registrations#my_page', as: :mypage
    post 'users/:id/update_image' => 'users/registrations#update_image'

  end

end
