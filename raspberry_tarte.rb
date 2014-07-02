# -*- coding: utf-8 -*-
require 'chatterbot/dsl'
require 'nest'

redis = Nest.new $0, Redis.new(:url => ENV["REDISCLOUD_URL"])

replies =
  [
   "Tu devrais installer un Debian GNU/Linux sur ton ordinateur.",
   "Les logiciels privateurs ne respectent pas les quatres libertés du logiciel libre !",
   "Tu es prisonnier de ton nouveau PC car il n'utilise pas un BIOS libre.",
   "Jette ton windows et écoute cette conférence de 2h de Richard Stallman http://bit.ly/17hjUIB."
  ]

search("#nouveaupc OR #nouvelordi") do |tweet|
  next unless redis["sent"].sadd(tweet.id)

  reply "#{tweet_user(tweet)} #{replies.sample}", tweet
end
