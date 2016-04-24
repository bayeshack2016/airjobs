Rails.application.routes.draw do
  get '/jobs', to: "jobs#index"
  get '/jobs/find', to: "jobs#find"
end
