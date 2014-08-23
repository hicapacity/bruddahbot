# Description:
#   put back the table
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   ajacksified

module.exports = (robot) ->
  robot.hear /（╯°□°）╯︵ ┻━┻/i, (msg) ->
    msg.send('Ho, bra!   ┬──┬ ノ( ゜-゜ノ)')
