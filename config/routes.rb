ExchangeRateClient::Application.routes.draw do
  root :to => "exchange#index"
  post '/convert' => "exchange#convert"
end
