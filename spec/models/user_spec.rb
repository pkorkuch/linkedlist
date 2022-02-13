require 'rails_helper'

describe User do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password).allow_nil }
    it { should have_secure_password }
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should validate_length_of(:name).is_at_most(255) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should allow_value('email@example.com').for(:email) }
    it { should allow_value('email@examplecom').for(:email) }
    it { should allow_value('l@e').for(:email) }
    it { should_not allow_value('emailexample.com').for(:email) }
    it { should_not allow_value('emailexamplecom').for(:email) }
    it { should_not allow_value('@e').for(:email) }
    it { should_not allow_value('l@').for(:email) }
  end

  context '#remember_token' do
    it 'is nil when user is first created' do
      user = create(:user)
      expect(user.remember_token).to be_nil
    end
  end

  context '#remember' do
    it 'sets a remember token when called' do
      user = create(:user)
      user.remember
      expect(user.remember_token).to_not be_nil
    end
  end

  context '#authenticated?' do
    it 'is false when passed a nil remember token' do
      user = create(:user)
      expect(user.authenticated?(nil)).to be false
    end

    it 'is false when passed an invalid remember token' do
      user = create(:user)
      user.remember
      expect(user.authenticated?('x' * user.remember_token.length)).to be false
    end

    it 'is true when passed a valid remember token' do
      user = create(:user)
      user.remember
      expect(user.authenticated?(user.remember_token)).to be true
    end
  end

  context '#forget' do
    it 'invalidates an existing remember token' do
      user = create(:user)
      user.remember
      token = user.remember_token
      user.forget
      expect(user.authenticated?(token)).to be false
    end
  end

  context '.digest' do
    it 'returns a BCrypt digest of the given string' do
      str = SecureRandom.hex(16)
      digest = User.digest(str)
      expect(BCrypt::Password.new(digest).is_password?(str)).to be true
    end
  end

  context '.new_token' do
    it 'returns a new token' do
      expect(User.new_token).to_not be_nil
    end
  end
end