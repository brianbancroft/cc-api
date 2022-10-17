class  Api::V1::CurrenciesController < ApplicationController
    def index    
        render :json => {currencies: CurrencyList.retrieve}
    end


    # http://localhost:3000/api/v1/currencies/rate?from=AAA&to=BBB
    def rate
        from = params[:from]
        to = params[:to]

        if (from.nil? && to.nil?) || (from.length != 3 || to.length != 3) 
            render json: {message: 'bad request'}, status: :bad_request
        else 
            response_structure = {from: 'AAA', to: 'BBB', rate: 1.23}

            rate = CurrencyRate.convert(from, to)

            render :json => {from: from, to: to, rate: rate}
        end
    end
end
