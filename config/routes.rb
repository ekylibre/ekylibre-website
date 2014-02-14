Sekyl::Application.routes.draw do
  filter :locale #, :exclude => /^\/admin/

  get "*anything" => "home#not_found"
  post "*anything" => "home#not_found"

  root 'home#index'
end
