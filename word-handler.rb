class WordHandler
  attr_reader :bot
  attr_reader :dic
  def initialize(bot)
    @bot = bot
    @dic = {"おはよう" => "おはよう",
            "おやすみ" => "おやすみ",
            "かわいい" => "えへへ～～",
            "帰ります" => "おつおつ",
            "帰る" => "おつ",
    }
  end
  
  def get_word(txt)
    dic.each { |key, val|
      return val if txt.include?(key)
    }
    ""
  end

  def is_target?(txt)
    return false if get_word(txt).empty?
    true
  end
  
  def receive(txt, reply_token)
    str = get_word(txt)
    messages = []
    messages.push({type: 'text', 
                  text: str})
    bot.reply(messages, reply_token) if bot
    messages
  end
end
