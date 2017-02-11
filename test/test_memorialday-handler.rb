require './memorialday-handler'
require 'test/unit'

class TestMemorialdayHandler < Test::Unit::TestCase
  def setup
    @handler = MemorialdayHandler.new(nil)
  end

  def test_is_target?
    assert_equal(true, @handler.is_target?("記念日"))
    assert_equal(true, @handler.is_target?("記念日登録\n結婚記念日\n2009/06/03"))
    assert_equal(false, @handler.is_target?("記念"))
  end

  def test_register
    assert_equal("結婚記念日:2009-06-03を登録しました", @handler.register("記念日登録\n結婚記念日\n2009-06-03"))
    assert_equal("結婚記念日:2009-06-03を登録しました", @handler.register("記念日登録\n結婚記念日\n2009/06/03"))
    assert_equal("結婚記念日:2009-06-03を登録しました", @handler.register("記念日登録\n結婚記念日\n2009-6-3"))
    assert_equal("", @handler.register("記念日登録したよ"))
    assert_equal("", @handler.register("記念日登録\nタイトル\nYYYY/MM/DD"))
  end

  def test_get_date_diff
    a = Date.new(2011, 9, 4)
    b = Date.new(2011, 9, 5)
    c = Date.new(2012, 9, 4)
    assert_equal(1, @handler.get_date_diff(a, b))
    assert_equal(366, @handler.get_date_diff(a, c))

    t1 = Date.today - 1
    assert_equal(1, @handler.get_date_diff(t1))
  end

  def test_receive
    msg = @handler.receive("記念日登録したよ", "xxx") 
    assert_equal(2, msg.size)
    assert_equal("記念日が登録されていません\n登録するには下のメッセージを送ってください", msg[0][:text])
    assert_equal("記念日登録\nタイトル\nYYYY/MM/DD", msg[1][:text])
    
    t1 = Date.today - 1
    msg = @handler.receive("記念日登録\n結婚記念日\n#{t1.to_s}", "xxx") 
    assert_equal(1, msg.size)
    assert_equal("結婚記念日:#{t1.to_s}を登録しました", msg[0][:text])
    
    msg = @handler.receive("記念日", "xxx") 
    assert_equal(1, msg.size)
    assert_equal("結婚記念日(#{t1.to_s})から1日目です", msg[0][:text])
    
    t2 = Date.today - 2
    msg = @handler.receive("記念日登録\n誕生日\n#{t2.to_s}", "xxx") 
    msg = @handler.receive("記念日", "xxx") 
    assert_equal(1, msg.size)
    assert_equal("結婚記念日(#{t1.to_s})から1日目です\n誕生日(#{t2.to_s})から2日目です", msg[0][:text])
  end
end
