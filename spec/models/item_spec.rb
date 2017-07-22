require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'ensure an item record belongs to a single todo record' do
    should belong_to(:todo)
  end

  it { should validate_presence_of(:name) }
end
