Portfolio::Api::Engine.routes.draw do
    get '/', to: 'portfolio#index'
    get '/holdings', to: 'portfolio#holdings'
    get '/returns', to: 'portfolio#returns'
    post '/addTrade', to: 'trade#create'
    post '/updateTrade/:id', to: 'trade#update'
    post '/removeTrade/:id', to: 'trade#remove'
end
