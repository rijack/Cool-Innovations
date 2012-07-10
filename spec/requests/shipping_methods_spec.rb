require 'spec_helper'

describe "ShippingMethods" do
  describe "GET /shipping_methods" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get shipping_methods_path
      response.status.should be(200)
    end
  end
end
