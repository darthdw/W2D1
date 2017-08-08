require_relative 'super_useful'

puts "'five' == #{convert_to_int('five')}"

feed_me_a_fruit

name = ""
year = 1
fav_pastime = ""


begin
sam = BestFriend.new(name, year, fav_pastime)
rescue YearError
  puts "We've not known each other long enough!"
  year = convert_to_int(gets.chomp)
  retry
rescue ArgumentError
  puts "Tell me more!!!!"
  name = gets.chomp
  fav_pastime = gets.chomp
  retry
end

sam.talk_about_friendship
sam.do_friendstuff
sam.give_friendship_bracelet
