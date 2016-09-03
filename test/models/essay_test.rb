require 'test_helper'

class EssayTest < ActiveSupport::TestCase
  def setup
    @essay = Fabricate(:essay)
  end

  test 'create' do
    assert_difference ['Essay.count', 'PaperTrail::Version.count'] do
      Essay.create! Fabricate.attributes_for(:essay)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Essay.count' do
        @essay.update!(attr: 'Updated')
      end
    end

    assert_equal 'Updated', @essay.reload.attr
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Essay.count', -1) { @essay.destroy }
    end
  end

  test 'validates blank attributes' do
    @essay.attr = ''

    assert @essay.invalid?
    assert_equal 1, @essay.errors.size
    assert_equal_messages @essay, :attr, :blank
  end

  test 'validates unique attributes' do
    new_essay = Fabricate(:essay)
    @essay.attr = new_essay.attr

    assert @essay.invalid?
    assert_equal 1, @essay.errors.size
    assert_equal_messages @essay, :attr, :taken
  end
end
