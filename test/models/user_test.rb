require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'password', password_confirmation: 'password')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '    '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 256
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.name = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[userexample,com user_at_foo.org user.nameexample. foobar_baz.com foobar+baz.com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase

    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email should be saved in original case' do
    uppercase_email = @user.email.upcase
    @user.email = uppercase_email
    @user.save
    assert_equal @user.reload.email, uppercase_email
  end

  test 'user can be found by email regardless of case' do
    uppercase_email = @user.email.upcase
    @user.save
    assert_equal @user, User.find_by(email: uppercase_email)
  end

  test 'password should not be blank' do
    @user.password = @user.password_confirmation = ' ' * 8
    assert_not @user.valid?
  end

  test 'password should not be too short' do
    @user.password = @user.password_confirmation = 'a' * 7
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authenticated?('')
  end
end
