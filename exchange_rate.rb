require 'net/http'
require 'nokogiri'
require 'date'
require 'yaml'

class ExchangeRate
  RatesUrl = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'

  def at date, from, to
    puts rates.class
    rates[date][to.to_sym] / rates[date][from.to_sym]
  end

  def rates
    update_rates unless File.exists? ("store.yaml")
    @rates ||= YAML.load_file("store.yaml")
  end

  def update_rates
    File.open("store.yaml", "w") do |file|
      file.write @rates = resolve_rates_from_ecb.to_yaml
    end
  end

  def resolve_rates_from_ecb
    xml_data = Net::HTTP.get_response(URI.parse(RatesUrl)).body
    doc = Nokogiri::XML(xml_data).remove_namespaces!
    rates = {}
    doc.xpath('//Cube/Cube[Cube]').each do |date_rates|
      time = Date.strptime(date_rates.attr('time'), '%Y-%m-%d')
      rates[time] = date_rates.children.map do |rate|
        {rate.attr('currency').to_sym => rate.attr('rate').to_f}
      end.inject(:merge).merge(:EUR => 1.0)
    end
    rates
  end

end

# a = ExchangeRate.new
puts ExchangeRate.new.at(Date.today, :EUR, :USD)