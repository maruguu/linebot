require './meal-handler'

class Bot
  attr_reader :client
  attr_reader :meal_handler

  def initialize(client)
    @client = client
    @meal_handler = MealHandler.new(self)
  end
  
  def receive(event)
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        meal_handler.receive(event.message['text'], event['replyToken'])        
      end
    end
  end

  def reply(message, token)
    res = client.reply_message(token, message)
    p res
    p res.body
  end
end
  