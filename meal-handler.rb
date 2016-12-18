
class MealHandler
  attr_reader :bot
  def initialize(bot)
    @bot = bot
  end

  def receive(txt, reply_token)
    messages = []
    m = {
      type: 'text',
      text: txt
    }
    messages.push(m)
    messages.push({type: 'text', text: 'おまけ'})
    bot.reply(messages, reply_token);
  end
end
