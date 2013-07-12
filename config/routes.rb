Sekyl::Application.routes.draw do
  filter :locale #, :exclude => /^\/admin/

  root 'home#index'
end
