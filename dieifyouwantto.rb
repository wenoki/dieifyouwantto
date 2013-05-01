# encoding: utf-8

Process.daemon

require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret    = ENV['TWITTER_CONSUMER_SECRET']
  config.oauth_token        = ENV['TWITTER_ACCESS_TOKEN']
  config.oauth_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  config.auth_method        = :oauth
end

yamaoka = TweetStream::Client.new

yamaoka.userstream do |status|
  next if status.retweet?
  if /死(にたい|んでしまいたい|んでしまった方が楽です)([、。ー〜・‥…!！¥(（]|$|¥z)/ =~ status.text
    yamaoka.update("@#{status.user.screen_name} じゃあ死ねよ。", { :in_reply_to_status_id => status.id, })
  elsif status.text.include?("@dieifyouwantto")
    yamaoka.update("@#{status.user.screen_name} 死ねよ。", { :in_reply_to_status_id => status.id, })
  end
end
