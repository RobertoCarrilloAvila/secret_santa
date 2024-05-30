require 'rails_helper'

RSpec.describe 'families/index', type: :view do
  before do
    assign(:families, [
             Family.create!,
             Family.create!
           ])
  end

  it 'renders a list of families' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
