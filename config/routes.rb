Quiz::Application.routes.draw do
  
  get "cities/youwon" => "cities/youwon", as: :youwon
  
  resources :cities

end