require 'test_helper'

class SampleTest < ActiveSupport::TestCase
  def setup
    @sample = Fabricate(:sample)
  end

  test 'create' do
    assert_difference ['Sample.count', 'PaperTrail::Version.count'] do
      Sample.create! Fabricate.attributes_for(:sample)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Sample.count' do
        @sample.update!(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @sample.reload.attr
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Sample.count', -1) { @sample.destroy }
    end
  end

  test 'validates blank attributes' do
    @sample.attr = ''

    assert @sample.invalid?
    assert_equal 1, @sample.errors.size
    assert_equal_messages @sample, :attr, :blank
  end

  test 'validates unique attributes' do
    new_sample = Fabricate(:sample)
    @sample.attr = new_sample.attr

    assert @sample.invalid?
    assert_equal 1, @sample.errors.size
    assert_equal_messages @sample, :attr, :taken
  end
end
