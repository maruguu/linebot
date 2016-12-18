require "uri"
require "net/http"
require 'json'

class MealHandler
  attr_reader :bot
  def initialize(bot)
    @bot = bot
  end

  def query_to_uri(hash)
    return hash.map{ |k,v| "#{k.to_s}=#{v}"}.join("&")
  end

  def receive(txt, reply_token)
    q = { "type" => "everyone", "limit" => 1}
    uri = URI.parse("https://api.photozou.jp/rest/photo_list_public.json?#{query_to_uri(q)}")
    req = Net::HTTP::Get.new("#{uri.path}?#{uri.query}")

    messages = []
    Net::HTTP.start(uri.host){ |http|
      response = http.request(req)
      json = JSON.parser.new(response.body)
      hash =  json.parse()
      info = hash['info']
      photo = info['photo']
      puts photo[0]['image_url']
      messages.push({type: 'text', 
                     text: photo[0]['photo_title']})
      messages.push({type: 'image', 
                     originalContentUrl: photo[0]['original_image_url'], 
                     previewImageUrl: photo[0]['thumbnail_image_url']})
    }
    bot.reply(messages, reply_token);
  end
end
