require 'rails_helper'
require 'spec_helper'

RSpec.describe RequestsController, type: :controller do

  describe "create tutoring request" do
    before :each do
      @oski = double("Tutee", :sid=>1, :first_name=>"an", :email=>"an.ju@cal.ber")
    end
    it "it should generate routing for tutee" do
      {:get => tutee_homepage_path(1)}.
          should route_to(:controller => "tutees", :action => "show", :id => "1")
    end

  end

end