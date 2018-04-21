require './pushbullet-handler'
require 'test/unit'

class TestMealHandler < Test::Unit::TestCase
  def setup
    @handler = PushbulletHandler.new(nil)
  end

  def test_is_target?
    assert_equal(true, @handler.is_target?("[PB]再起動"))
    assert_equal(false, @handler.is_target?("PB再起動"))
  end

  def test_receive
    msg = @handler.receive("[PB]再起動", "xxx") 
    assert_equal("text", msg[0][:type])
    assert_equal("再起動をお願いしておくよ", msg[0][:text])
  end
end
