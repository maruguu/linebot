require 'date'

class MemorialdayHandler
  attr_reader :bot
  attr_accessor :date
  def initialize(bot)
    @bot = bot
    @date = {}
  end
  
  def is_target?(txt)
    token = ["記念日"]
    token.each{ |t|
      return true if txt.include?(t)
    }
    false
  end
  
  # 登録のフォーマットは
  # 記念日登録\nタイトル\nYYYY/MM/DD
  def register(txt)
    line = txt.each_line.map(&:chomp)
    return "" unless line[0] == "記念日登録"
    begin
      dt = Date.parse(line[2])
      @date[line[1]] = dt
    rescue
      return ""
    end
    "#{line[1]}:#{dt.to_s}を登録しました"
  end

  def get_date_diff(a, b = Date.today)
    (b - a).to_i
  end

  def receive(txt, reply_token)
    str = ""
    str = register(txt)
    if str == ""
      @date.each {|title, d|
        diff = get_date_diff(d)
        str += "#{title}(#{d.to_s})から#{diff}日目です\n"
      }
      str.chomp!
    end
    usage = ""
    if str == ""
      str = "記念日が登録されていません\n登録するには下のメッセージを送ってください"
      usage = "記念日登録\nタイトル\nYYYY/MM/DD"
    end
    
    messages = []
    messages.push({type: 'text', text: str})
    messages.push({type: 'text', text: usage}) unless usage.empty?
    bot.reply(messages, reply_token) if bot;
    messages
  end
end
