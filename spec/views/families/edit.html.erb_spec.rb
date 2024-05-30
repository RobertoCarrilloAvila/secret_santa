require 'rails_helper'

RSpec.describe 'families/edit', type: :view do
  let(:family) do
    Family.create!
  end

  before do
    assign(:family, family)
  end

  it 'renders the edit family form' do
    render

    assert_select 'form[action=?][method=?]', family_path(family), 'post' do
    end
  end
end
