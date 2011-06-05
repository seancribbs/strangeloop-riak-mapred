require 'rubygems'
require 'bundler/setup'
require 'typhoeus'
require 'twitter'
require 'yaml'

config = YAML.load_file('twitter.yml')

Twitter.configure do |c|
  c.consumer_key = config['consumer_key']
  c.consumer_secret = config['consumer_secret']
  c.oauth_token = config['oauth_token']
  c.oauth_token_secret = config['oauth_token_secret']
  c.adapter = :typhoeus
end

MAX_USERS = 100
if File.exist?("friends/seancribbs")
  users = File.read("friends/seancribbs").split("\n")
  count = Dir['friends/*'].size
else
  count = 0
  users = ['seancribbs']
end

while users.any? && count < MAX_USERS
  current = users.shift
  next if File.exist?("friends/#{current}")
  print "#{current}: "
  ids = Twitter.friend_ids(current)['ids']
  begin
    File.open("friends/#{current}", "w") do |f|
      ids.each_slice(100) do |il|
        begin
          ul = Twitter.users(il)
          print "#{ul.size} "
        rescue Twitter::NotFound
          next
        end
        ul.each do |u|
          users << u['screen_name']
          f.puts u['screen_name']
        end
      end
    end
    puts
  rescue
    puts $!.inspect
    system "rm friends/#{current}"
  end
  count += 1
end
puts "Done!"
