require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:date) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:schedule_shows) }
    it { should have_many(:shows).through(:schedule_shows) }
  end
end
