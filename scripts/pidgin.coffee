# Description:
#   BruddahBot life beef.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot introduce yourself - aloha!
#   hubot how is the food? - food is good!
#   thanks bruddahbot - show your appreciation
#
# Author:
#   Bob Matcuk

introductions = [
  "Howzit!"
  "Cheehoo!"
]

greetings = [
  (u) -> "Yo #{u}, howzit?!"
  (u) -> "Aloha, #{u}!"
]

grindz = [
  "aurite"
  "brok da mout!"
  "so ono!"
]

youreWelcome = [
  "a‘ole pilikia"
  "shoots"
]

# some words: http://www.e-hawaii.com/pidgin/pidgin-english-words-starting-with-m
module.exports = (robot) ->
  robot.enter (msg) ->
    msg.send(msg.random(greetings)(msg.message.user.name))

  robot.respond /introduce yourself/i, (msg) ->
    msg.send msg.random introductions

  robot.respond /how(?:z|'?s| is| are) the (?:food|grind[sz])/i, (msg) ->
    msg.send msg.random grindz

  robot.hear /(?:thanks|mahalo) bruddahbot/i, (msg) ->
    msg.send msg.random youreWelcome

