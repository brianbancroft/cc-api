class  Api::V1::CurrenciesController < ApplicationController
    api :GET, '/api/v1/currencies', 'List all supported currencies'
    returns :code => 200 do
        property :reason, String, :desc => "Why this was forbidden"
     end
    def index    
        render :json => {currencies: CurrencyList.retrieve}
    end

    api :GET, '/api/v1/currencies/rate', 'Provide a conversion rate between two given currencies'
    param :from, String, 'The currency you seek to convert from'
    param :to, String, 'The currency you seek to convert to'
    def rate
        from = params[:from]
        to = params[:to]

        if (from.nil? && to.nil?) || (from.length != 3 || to.length != 3) 
            render json: {message: 'bad request'}, status: :bad_request
        else 
            rate = CurrencyRate.convert(from, to)

            render :json => {from: from, to: to, rate: rate}
        end
    end
end
