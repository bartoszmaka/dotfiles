#!/usr/bin/env ruby
# encoding: utf-8
empty   = "☆"
batt0 = "\uf244"
batt25 = "\uf243"
batt50 = "\uf242"
batt75 = "\uf241"
batt100 = "\uf240"
plug    = ""

  star_count = 5 
per_star = 100/star_count

v= Hash.new()

ARGF.each do |a|
  if a.start_with? "Now"
    #test for the first line
    if a =~ /'(.*)'/
      v[:source] = $~[1]
    else
      v[:source] = ""
    end
  elsif a.start_with?" -"
    if a =~ /(\d{1,3})%;\s(.*);\s(\d:\d{2}|\(no estimate\))/
      v[:percent] = $~[1].to_i
      v[:state]   = $~[2]
      v[:time]    = $~[3]
    else
      v[:percent] = "(calc..)"
      v[:state]   = "unknown"
      v[:time]    = "Estimating.."
    end
  end
end
outstring = ""
battery = batt0
if v[:percent] >= 100
  battery = batt100
elsif v[:percent] >= 75
  battery = batt75
elsif v[:percent] >= 50
  battery = batt50
elsif v[:percent] >= 25
  battery = batt25
end

if v[:source]== "Battery Power"
 outstring += "#{battery}  " 
else
 outstring +="#{plug} "
end

# full_stars  = v[:percent]/per_star
# empty_stars = star_count - full_stars
# full_stars.times  {outstring += "#{full} "}
# empty_stars.times {outstring += "#{empty} "}

outstring += "#{v[:percent]}%"

outstring += v[:time] == "0:00" ? " charged" : " (#{v[:time]})"

puts outstring
