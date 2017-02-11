
require 'signet/oauth_2/client'
require 'picasa'

class PicasaClient

  def initialize
    @client = nil
  end

  def client
    @client ||= Picasa::Client.new(user_id: ENV['GOOGLE_USER_ID'], access_token: access_token)
  end

  def access_token
    signet = Signet::OAuth2::Client.new(
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      token_credential_uri: "https://www.googleapis.com/oauth2/v3/token",
      refresh_token: ENV['GOOGLE_REFRESH_TOKEN']
    )
    signet.refresh! 

    # Use access token with picasa gem
    signet.access_token
  end

  def get_random_photo_url
    album = client.album.list.entries.find{  |a| a.title == ENV['GOOGLE_PHOTO_ALBUM_NAME'] } 
    photo = client.album.show(album.id).entries.sample
    photo.content.src
  end
end

class PhotoHandler
  attr_reader :bot
  attr_reader :picasa
  
  def initialize(bot)
    @bot = bot
    @picasa = PicasaClient.new
  end
  
  def is_target?(txt)
    token = ["写真", "しゃしん"]
    token.each{ |t|
      return true if txt.include?(t)
    }
    false
  end
  
  def receive(txt, reply_token)
    url = picasa.get_random_photo_url
    messages = []
    messages.push({type: 'image', 
                   originalContentUrl: url,
                   previewImageUrl: url})
    bot.reply(messages, reply_token);
    messages
  end
end
