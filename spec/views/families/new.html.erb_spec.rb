require 'rails_helper'

RSpec.describe "families/new", type: :view do
  before(:each) do
    assign(:family, Family.new())
  end

  it "renders new family form" do
    render

    assert_select "form[action=?][method=?]", families_path, "post" do
    end
  end
end
