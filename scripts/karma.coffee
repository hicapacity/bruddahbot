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
  (u,k,o) -> "Ho brah, #{u} #{k} da kine!#{(unless o? and k < o then ' :shaka:' else '')}"
  (u,k,o) ->
    if o?
      if k > o then "#{u} goin #{o} fo #{k} da kine! :shaka:" else "#{u} wen #{o} fo #{k} da kine."
    else
      "#{u} stay #{k} da kine."
]

getUserKarmaExpression = (userKarmaToken) ->
  hasAtSymbol = userKarmaToken.startsWith('@')
  username = if hasAtSymbol
  then userKarmaToken.slice(1, -2)
  else userKarmaToken.slice(0, -2)

  operator = userKarmaToken.slice(-2)

  {
    type: 'UserKarmaExpression',
    isMentioned: hasAtSymbol,
    username: username.toLowerCase(),
    operator
  }

getUserKarmaExpressions = (userKarmaTokens) ->
  userKarmaTokens.map getUserKarmaExpression

module.exports = (robot) ->
  # Matches all occurances of karma tokens in a message
  # Examples:
  # * [@user++] is the best!
  # * Mahalo [user++]!
  # * Thanks [@user1++] [@user2++] [@user3++]!
  #   But not [user4--] :(

  robot.hear /\@?([\w.]+)(--|\+\+)/g, (msg) ->
    seenUsernames = new Set()
    userKarmaExpressions = getUserKarmaExpressions(msg.match)
      .filter((expr) ->
        # Unless the user has been already been seen, 
        # Or unless the user does not exist
        if !seenUsernames.has(expr.username) and robot.brain.userForName(expr.username)
          seenUsernames.add(expr.username)

          # don't let user adjust their own score
          expr.username != msg.message.user.name.toLowerCase())

    for { username, operator } in userKarmaExpressions
      # get the current karma points
      karma = robot.brain.get('karmaKine') or {}
      oldKarmaForUser = karma[username] | 0

      # update the karma
      karmaForUser = if operator is '++' then oldKarmaForUser + 1 else oldKarmaForUser - 1
      karma[username] = karmaForUser
      robot.brain.set('karmaKine', karma)

      # let 'em know
      msg.send(msg.random(scores)(username, karmaForUser, oldKarmaForUser))

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

