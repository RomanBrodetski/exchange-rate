require 'exchange_rate'
require 'date'
require 'spec_helper'
include Helpers

describe ExchangeRate do
  before(:all) do
    File.delete 'store.yaml' if File.exists? 'store.yaml'
  end
  after(:all) do
    File.delete 'store.yaml' if File.exists? 'store.yaml'
  end

  it 'resolves rates from ecb' do
    @rates = ExchangeRate.resolve_rates_from_ecb
    @rates.values[0].should include :EUR
  end

  it 'stores data in file system' do
    ExchangeRate.update_rates
    File.exists?('store.yaml').should be_true
  end

  it 'contains EUR information for all the dates' do
    @rates = ExchangeRate.rates
    @rates.values.each{|day| day.keys.should include :EUR}
  end

  it "doesn't have information for future dates" do
    ExchangeRate.at(Date.tomorrow, :EUR, :USD).should be_nil
  end

  it "doesn't have information for fictional currencies" do
    ExchangeRate.at(Date.tomorrow, :EUR, :FRF).should be_nil
  end

  it "returns reasonable rates for same currency" do
    ExchangeRate.at(last_existing_date(ExchangeRate.rates), :USD, :USD).should == 1
  end

  it "returns reasonable reciprocal rates" do
    eur_usd = ExchangeRate.at(last_existing_date(ExchangeRate.rates), :EUR, :USD)
    usd_eur = ExchangeRate.at(last_existing_date(ExchangeRate.rates), :USD, :EUR)
    eur_usd.should be_within(0.01).of 1.0 / usd_eur
  end

end