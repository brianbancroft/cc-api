require 'httparty'

class CurrencyRate < ApplicationRecord
    def self.convert(from, to)
        api_key = ENV['EXCHANGE_API_KEY']
        api_endpoint = "https://v6.exchangerate-api.com/v6/#{api_key}/pair/#{from}/#{to}"
        
        saved_conversion = CurrencyRate.find_by(currency_from: from, currency_to: to)
        rate = -1

        if saved_conversion.nil?
            response = HTTParty.get(api_endpoint)

            data = JSON.parse response.body
            rate = data['conversion_rate']
            saved_conversion = CurrencyRate.new(currency_from: from, currency_to: to, rate: rate)
            saved_conversion.save

        elsif saved_conversion.updated_at < DateTime.now - 1.day
            # The API refreshes their currencies once every 24 hours
            response = HTTParty.get(api_endpoint)

            data = JSON.parse response.body

            rate = data['conversion_rate']

            saved_conversion.rate = rate
            saved_conversion.updated_at = DateTime.now
            saved_conversion.save
        else
            rate = saved_conversion.rate
        end
        return rate

    end

    validates :currency_from, presence: true
    validates :currency_to, presence: true
    validates :currency_from, length: { is: 3 }
    validates :currency_to, length: { is: 3 }
    validates :rate, presence: true
end
