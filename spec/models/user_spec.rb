require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { User.new(first_name: 'Test', last_name: 'User') }

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }

    it 'allows valid email' do
      user.email = 'user@example.com'
      expect(user).to be_valid
    end

    it 'does not allow invalid email' do
      user.email = 'user@example'
      expect(user).to_not be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:schedules) }
  end
end
