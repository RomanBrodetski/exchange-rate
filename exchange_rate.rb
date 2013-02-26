require 'net/http'
require 'nokogiri'
require 'date'
require 'yaml'

module ExchangeRate
  RatesUrl = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'

  def self.fetch_rates
    xml_data = Net::HTTP.get_response(URI.parse(RatesUrl)).body
    doc = Nokogiri::XML(xml_data).remove_namespaces!
    rates = {}

    doc.xpath('//Cube/Cube[Cube]').each do |date_rates|
      time = Date.strptime(date_rates.attr('time'), '%Y-%m-%d')
      rates[time] = date_rates.children.map do |rate|
        {rate.attr('currency').to_sym => rate.attr('rate').to_f}
      end.inject :merge
    end

    rates
  end

end