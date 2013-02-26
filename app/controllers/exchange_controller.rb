class ExchangeController < ApplicationController

  def index
    @currencies = ExchangeRate.currencies
  end

  def convert
    query = params['convert']
    @from, @to, @amount = query[:from], query[:to], query[:amount].to_f
    rate = ExchangeRate.at(Date.parse(query[:date]), @from, @to)
    return render :no_data_available unless rate
    @result = rate * @amount
  end

end
