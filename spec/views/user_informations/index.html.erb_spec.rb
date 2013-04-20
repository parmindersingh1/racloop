require 'spec_helper'

describe "user_informations/index" do
  before(:each) do
    assign(:user_informations, [
      stub_model(UserInformation),
      stub_model(UserInformation)
    ])
  end

  it "renders a list of user_informations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
