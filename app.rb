require 'sinatra'   # gem 'sinatra'
require 'line/bot'  # gem 'line-bot-api'
require './bot'

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

def bot
  @bot ||= Bot.new (client)
end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)
  p events

  events.each { |event|
    bot.receive(event)
  }

  "OK"
end
