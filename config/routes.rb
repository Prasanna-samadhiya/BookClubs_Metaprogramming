Rails.application.routes.draw do
  devise_for :users

  # root will also use the universal action
  root "bookclubs#action", defaults: { do: "index" }

  resources :bookclubs do
    collection do
      get    :action, defaults: { do: "index" }
      post   :action, defaults: { do: "create" }
    end

    member do
      get    :action, defaults: { do: "show" }
      post   :action, defaults: { do: "join" }
      delete :action, defaults: { do: "leave" }
      delete :action, defaults: { do: "destroy" }
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
