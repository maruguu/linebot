require './word-handler'
require 'test/unit'

class TestWordHandler < Test::Unit::TestCase
  def setup
    @handler = WordHandler.new(nil)
  end

  def test_is_target?
    assert_equal(true, @handler.is_target?("おはようからおやすみまで"))
    assert_equal(true, @handler.is_target?("おやすみ"))
    assert_equal(true, @handler.is_target?("かわいい"))
    assert_equal(true, @handler.is_target?("帰ります"))
    assert_equal(true, @handler.is_target?("帰るの"))
    assert_equal(false, @handler.is_target?("おは"))
  end

  def test_receive
    msg = @handler.receive("おはようございます", "xxx") 
    assert_equal("おはよう", msg[0][:text])
    msg = @handler.receive("おやすみなさい", "xxx") 
    assert_equal("おやすみ", msg[0][:text])
    msg = @handler.receive("かわいい", "xxx") 
    assert_equal("えへへ～～", msg[0][:text])
  end
end
