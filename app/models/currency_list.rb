require 'httparty'


class CurrencyListValidator < ActiveModel::Validator
    def validate(record)
      if CurrencyList.count > 0
        record.errors.add :base, "Currency list record already exists"
      end
    end
  end

class CurrencyList < ApplicationRecord
    self.table_name = "currency_list"

    def self.retrieve
      record = CurrencyList.first
      create_new_record = record.nil?
      retrieve_updated_record = record.nil? ? false : record.updated_at < DateTime.now - 1.week

      list = []

      if create_new_record || retrieve_updated_record
        api_key = ENV['EXCHANGE_API_KEY']
        api_endpoint = "https://v6.exchangerate-api.com/v6/#{api_key}/codes"

        # TODO: Error handling.
        response = HTTParty.get(api_endpoint)

        data = JSON.parse response.body
        codes = data['supported_codes']

        codes.each { |code| list.push({code: code[0], label: code[1]}) }
      end

      if create_new_record
        record = CurrencyList.new
        record.list = list
        record.save
      elsif retrieve_updated_record
        record.list = list
        record.updated_at = DateTime.now
        record.save
      else 
        list = record.list
      end

      return list
    end 

    validates_with CurrencyListValidator, on: :create
end
