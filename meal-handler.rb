class MealHandler
  attr_reader :bot
  def initialize(bot)
    @bot = bot
  end

  def receive(txt, reply_token)
    msg = ["xxxがいいと思います", "xxxはどうでしょう", "xxxなんていいですね", "xxxが食べたいな", "xxxがオススメです！"]
    recipe = ["カレー", "うどん", "ローストビーフ", "ハンバーグ", "ラーメン", "そば", "ミートソース スパゲッティ", "ナポリタン", "豚キムチ", "豚大根", "ぶり大根", "ふろふき大根", "オムライス", "ホットケーキ", "手巻き寿司", "カップ麺", "チキンタツタ", "焼き鳥", "からあげ", "白身魚の天ぷら", "メンチカツ", "煮込みラーメン", "とろろごはん", "ピザ", "焼きそば", "とんかつ", "コロッケ", "スパニッシュオムレツ", "ビーフシチュー", "クリームシチュー", "麻婆豆腐", "チャーハン", "牛丼", "豚丼", "春巻", "グラタン", "ポトフ", "ガーリックチキンソテー", "スモークチキン", "ハムカツ", "そぼろ丼", "ハンバーガー", "お好み焼き", "すき焼き", "おすし", "おでん", "天丼", "アヒージョ", "チキンのトマト煮"]
    srand
    i = rand(msg.size)
    r = rand(recipe.size)
    str = msg[i].gsub("xxx", recipe[r])

    messages = []
    messages.push({type: 'text', 
                  text: str})
    bot.reply(messages, reply_token);
  end
end
