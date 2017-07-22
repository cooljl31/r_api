require 'rails_helper'

RSpec.describe Todo, type: :model do

  it 'ensure Todo model has 1:m relationship with the Item model' do
    should have_many(:items).dependent(:destroy)
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
