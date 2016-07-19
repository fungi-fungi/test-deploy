require "rails_helper"

RSpec.describe Api::V1::ErrorsController, :type => :controller do
  describe "Request unexisting path" do
    it "gets error message" do
      expect(get: '/bla-bla').to route_to(controller: 'errors', action: 'routing', unmatched_route: 'bla-bla')
    end
  end
end