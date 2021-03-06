require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = Fabricate(:user)
  end

  test 'create' do
    assert_difference ['User.count', 'PaperTrail::Version.count'] do
      User.create! Fabricate.attributes_for(:user)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'User.count' do
        @user.update!(name: 'Updated')
      end
    end

    assert_equal 'Updated', @user.reload.name
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('User.count', -1) { @user.destroy }
    end
  end

  test 'validates blank attributes' do
    @user.name = ''
    @user.email = ''

    assert @user.invalid?
    assert_equal 2, @user.errors.size
    [:name, :email].each { |attr| assert_equal_messages @user, attr, :blank }
  end

  test 'validates well formated attributes' do
    @user.email = 'incorrect@format'

    assert @user.invalid?
    assert_equal 1, @user.errors.size
    assert_equal_messages @user, :email, :invalid
  end

  test 'validates unique attributes' do
    new_user = Fabricate(:user)
    @user.email = new_user.email

    assert @user.invalid?
    assert_equal 1, @user.errors.size
    assert_equal_messages @user, :email, :taken
  end

  test 'validates confirmated attributes' do
    @user.password = 'admin124'
    @user.password_confirmation = 'admin125'
    assert @user.invalid?
    assert_equal 1, @user.errors.count
    assert_equal_messages @user, :password_confirmation, :confirmation
  end

  test 'validates length of _short_ attributes' do
    @user.password = @user.password_confirmation = '12345'

    assert @user.invalid?
    assert_equal 1, @user.errors.count
    assert_equal_messages @user, :password, :too_short, count: 6
  end

  test 'validates length of _long_ attributes' do
    @user.name = 'abcde' * 52
    @user.lastname = 'abcde' * 52
    @user.email = "#{'abcde' * 52}@test.com"

    assert @user.invalid?
    assert_equal 3, @user.errors.count
    [:name, :lastname, :email].each do |attr|
      assert_equal_messages @user, attr, :too_long, count: 255
    end
  end

  # TODO: when we put textacular we will use this
  #test 'magick search' do
  #  5.times { Fabricate(:user) { name { "magick_name" } } }
  #  3.times { Fabricate(:user) { lastname { "magick_lastname" } } }
  #  Fabricate(:user) {
  #    name { "magick_name" }
  #    lastname { "magick_lastname" }
  #  }

  #  users = User.magick_search('magick')

  #  assert_equal 9, users.count
  #  assert users.all? { |u| u.to_s =~ /magick/ }

  #  users = User.magick_search('magick_name')

  #  assert_equal 6, users.count
  #  assert users.all? { |u| u.to_s =~ /magick_name/ }

  #  users = User.magick_search('magick_name magick_lastname')

  #  assert_equal 1, users.count
  #  assert users.all? { |u| u.to_s =~ /magick_name magick_lastname/ }

  #  users = User.magick_search(
  #    "magick_name #{I18n.t('magick_columns.or').first} magick_lastname"
  #  )

  #  assert_equal 9, users.count
  #  assert users.all? { |u| u.to_s =~ /magick_name|magick_lastname/ }

  #  users = User.magick_search('nobody')

  #  assert users.empty?
  #end
end
