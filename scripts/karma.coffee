# Description:
#   BruddahBot keep da points for da kine.
#
# Dependencies:
#   None
#
# Commands:
#   user++ - add da kine
#   user-- - cockroach da kine
#
# Author:
#   Bob Matcuk

scores = [
  (u,k) -> "Ho brah, #{u} #{k} da kine!"
  (u,k,o) ->
    if o?
      if k > o then "#{u} goin #{o} fo #{k} da kine!" else "#{u} wen #{o} fo #{k} da kine."
    else
      "#{u} stay #{k} da kine."
]

module.exports = (robot) ->
  robot.hear /^(\w+)(--|\+\+)$/, (msg) ->
    # parse out the user and operator
    [_, user, operator] = msg.match
    user = user.replace(/(^\s*@)|([,:\s]*$)/g, '').trim().toLowerCase()
    return if user is msg.message.user.name.toLowerCase()

    # get the current karma points
    karma = robot.brain.get('karmaKine') or {}
    oldKarmaForUser = karma[user] | 0

    # update the karma
    karmaForUser = if operator is '++' then oldKarmaForUser + 1 else oldKarmaForUser - 1
    karma[user] = karmaForUser
    robot.brain.set('karmaKine', karma)

    # let 'em know
    msg.send(msg.random(scores)(user, karmaForUser, oldKarmaForUser))

  robot.respond /score (\w+)/i, (msg) ->
    # parse out the user
    [_, user] = msg.match
    user = user.replace(/(^\s*@)|([,:\s]*$)/g, '').trim().toLowerCase()

    # get the current karma
    karma = robot.brain.get('karmaKine') or {}
    karmaForUser = karma[user]
    return unless karmaForUser?

    # let 'em know
    msg.send(msg.random(scores)(user, karmaForUser))

