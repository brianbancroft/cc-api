require "rails_helper"

RSpec.describe Api::V1::CurrenciesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/currencies").to route_to("api/v1/currencies#index")
    end

    it "routes to #rate" do
      expect(get: "/api/v1/currencies/rate").to route_to("api/v1/currencies#rate")
    end
  end
end
