require 'net/http'
require 'uri'
require 'json'

class PushbulletHandler
  CMD_PREFIX = '[PB]'
  attr_reader :bot
  def initialize(bot)
    @bot = bot
  end
  
  def is_target?(txt)
    txt.start_with?(CMD_PREFIX)
  end
  
  def forward(msg)
    uri = URI.parse("https://api.pushbullet.com/v2/ephemerals")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Access-Token"] = ENV["PUSHBULLET_TOKEN"]
    request.body = JSON.dump({
      "push" => {
        "command" => msg
      },
      "type" => "push"
    })
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end

  def receive(txt, reply_token)
    cmd = txt.gsub(CMD_PREFIX, "")
    str = cmd + "をお願いしておくよ"
    forward(cmd) if bot
    messages = []
    messages.push({type: 'text', 
                  text: str})
    bot.reply(messages, reply_token) if bot
    messages
  end
end
