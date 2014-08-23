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
#   hubot introduce yourself - hubot introduces himself
#
# Author:
#   Bob Matcuk

introductions = [
  "Howzit!"
  "Cheehoo!"
]

# some words: http://www.e-hawaii.com/pidgin/pidgin-english-words-starting-with-m
module.exports = (robot) ->
  robot.respond /introduce yourself/i, (msg) ->
    msg.send msg.random introductions

