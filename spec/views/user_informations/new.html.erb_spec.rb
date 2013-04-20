require 'spec_helper'

describe "user_informations/new" do
  before(:each) do
    assign(:user_information, stub_model(UserInformation).as_new_record)
  end

  it "renders new user_information form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_informations_path, :method => "post" do
    end
  end
end
