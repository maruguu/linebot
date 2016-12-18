
class Bot
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def receive(event)
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        message = {
          type: 'text',
          text: event.message['text']
        }
        res = client.reply_message(event['replyToken'], message)
        p res
        p res.body
      end
    end
  end
end
  