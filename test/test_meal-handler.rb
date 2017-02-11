require './meal-handler'
require 'test/unit'

class TestMealHandler < Test::Unit::TestCase
  def setup
    @handler = MealHandler.new(nil)
  end

  def test_is_target?
    assert_equal(true, @handler.is_target?("ごはん"))
    assert_equal(true, @handler.is_target?("朝ゴハン"))
    assert_equal(true, @handler.is_target?("ご飯ですよ"))
    assert_equal(false, @handler.is_target?("ご は ん"))
  end

  def test_receive
    msg = @handler.receive("aaa", "xxx") 
    assert_equal("text", msg[0][:type])
    puts msg[0][:text]
  end
end
