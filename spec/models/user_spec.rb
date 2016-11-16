require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it 'is invalid of name or email is not present' do
      expect(User.new.valid?).to eq(false)
    end

    it 'is valid if name and email are present' do
      expect(User.new(email: 'test@email.com', name: 'test').valid?).to eq(true)
    end

    it 'is invalid if the email is not unique' do
      create(:user, email: 'test@email.com', name: 'test')

      expect(User.new(email: 'test@email.com', name: 'other').valid?).to eq(false)
    end
  end
end
