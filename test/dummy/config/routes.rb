Rails.application.routes.draw do
  mount Weirdy::Engine => "/weirdy"
  match ':controller(/:action(/:id))(.:format)', via: [:get, :post]
end
