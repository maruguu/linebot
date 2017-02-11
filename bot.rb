require './meal-handler'
require './memorialday-handler'
require './word-handler'
require './photo-handler'

class Bot
  attr_reader :client
  attr_reader :meal_handler
  attr_reader :memorialday_handler
  attr_reader :word_handler
  attr_reader :photo_handler

  def initialize(client)
    @client = client
    @meal_handler = MealHandler.new(self)
    @memorialday_handler = MemorialdayHandler.new(self)
    @word_handler = WordHandler.new(self)
    @photo_handler = PhotoHandler.new(self)
  end
  
  def receive(event)
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        photo_handler.receive(event.message['text'], event['replyToken']) if photo_handler.is_target?(event.message['text'])
        meal_handler.receive(event.message['text'], event['replyToken']) if meal_handler.is_target?(event.message['text'])
        memorialday_handler.receive(event.message['text'], event['replyToken']) if memorialday_handler.is_target?(event.message['text'])
        word_handler.receive(event.message['text'], event['replyToken']) if word_handler.is_target?(event.message['text'])
      end
    end
  end

  def reply(message, token)
    res = client.reply_message(token, message)
    p res
    p res.body
  end
end
