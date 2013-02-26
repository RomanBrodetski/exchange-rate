class ExchangeController < ApplicationController
  def index
    puts  ExchangeRate.methods(false)
    @from = ExchangeRate.currencies
  end
end
