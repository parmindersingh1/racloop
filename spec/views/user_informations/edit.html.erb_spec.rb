require 'spec_helper'

describe "user_informations/edit" do
  before(:each) do
    @user_information = assign(:user_information, stub_model(UserInformation))
  end

  it "renders the edit user_information form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_informations_path(@user_information), :method => "post" do
    end
  end
end
