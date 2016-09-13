require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  def setup
    @client = Fabricate(:client)
  end

  test 'create' do
    assert_difference ['Client.count', 'PaperTrail::Version.count'] do
      Client.create! Fabricate.attributes_for(:client)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Client.count' do
        @client.update!(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @client.reload.attr
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Client.count', -1) { @client.destroy }
    end
  end

  test 'validates blank attributes' do
    @client.attr = ''

    assert @client.invalid?
    assert_equal 1, @client.errors.size
    assert_equal_messages @client, :attr, :blank
  end

  test 'validates unique attributes' do
    new_client = Fabricate(:client)
    @client.attr = new_client.attr

    assert @client.invalid?
    assert_equal 1, @client.errors.size
    assert_equal_messages @client, :attr, :taken
  end
end
