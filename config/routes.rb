Rails.application.routes.draw do
  get 'work/vacancy'
  post 'work/vacancy'
  put 'work/vacancy'
  patch 'work/vacancy'

  get 'work/summary'
  post 'work/summary'

  get 'work/reply'
  post 'work/reply'
  get 'work/replysum'

  root 'main#index'

  get 'main/index'
  get 'main/about'
  get 'main/work'

  get 'sessions/new'
  post 'sessions/new'
  get 'sessions/create'
  post 'sessions/create'
  get 'sessions/destroy'
end
