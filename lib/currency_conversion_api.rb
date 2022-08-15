require 'net/http'
require 'json'

class CurrencyConversionApi
    class << self
        def convert(base, amount, output)
            url = "https://api.exchangerate.host/latest?base=#{base}&amount=#{amount}&symbols=#{output}"
            uri = URI(url)
            response = Net::HTTP.get(uri)
            response_obj = JSON.parse(response)
        end
    end
end