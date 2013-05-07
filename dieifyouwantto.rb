# encoding: utf-8

Process.daemon

require 'twitter'
require 'tweetstream'

Twitter.configure do |config|
  config.consumer_key       = ARGV[0]
  config.consumer_secret    = ARGV[1]
  config.oauth_token        = ARGV[2]
  config.oauth_token_secret = ARGV[3]
end

TweetStream.configure do |config|
  config.consumer_key       = ARGV[0]
  config.consumer_secret    = ARGV[1]
  config.oauth_token        = ARGV[2]
  config.oauth_token_secret = ARGV[3]
  config.auth_method        = :oauth
end

yamaoka = TweetStream::Client.new

yamaoka.userstream do |status|
  next if status.retweet?
  if /死(にたい|んでしまいたい|んでしまった方が楽です)([、。ー〜・‥…!！¥(（]|$|¥z)/ =~ status.text
    Twitter.update("@#{status.user.screen_name} じゃあ死ねよ。", :in_reply_to_status_id => status.id)
  elsif status.text.include?("@dieifyouwantto")
    Twitter.update("@#{status.user.screen_name} 死ねよ。", :in_reply_to_status_id => status.id)
  end
end
