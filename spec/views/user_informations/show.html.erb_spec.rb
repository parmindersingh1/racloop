require 'spec_helper'

describe "user_informations/show" do
  before(:each) do
    @user_information = assign(:user_information, stub_model(UserInformation))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
