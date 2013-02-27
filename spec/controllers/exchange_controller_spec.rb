require 'spec_helper'
include Helpers

describe ExchangeController do
  it "should render index" do
    get 'index'
    expect(response).to be_success
    expect(response.code).to eq('200')
  end

  it "should convert" do
    date = last_existing_date(ExchangeRate.rates)
    xhr :post, 'convert', :convert => {:date => date, :from => :EUR, :to => :USD, :amount => 100}
    expect(response).to be_success
    expect(response.code).to eq('200')
    assigns(:result).should eq(ExchangeRate.at(date, :EUR, :USD) * 100)
  end
end