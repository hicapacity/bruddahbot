# Bruddahbot

Everyone's favorite slack da kine. Cheehoo!

## Testing Locally

Bruddahbot stay local:

```bash
% env REDIS_URL="http://localhost" bin/hubot
```

After startup, bruddahbot will be called hubot because.

## Installing Your Very Own Bruddahbot(tm)

Bruddahbot stay Heroku and Redis Cloud, want config:

```bash
HUBOT_SLACK_BOTNAME: bruddahbot
HUBOT_SLACK_TEAM:    your team name here
HUBOT_SLACK_TOKEN:   your token here
REDISCLOUD_URL:      redis://rediscloud:etc etc etc
```

## Contributing

First, you should consider writing your functionality as a [hubot-script] so
you can share with the community.

If you really want to mess with code in this repo, fork it and submit a pull
request. That's the best way to ensure that your changes will actually make it
into the actual running instance of Bruddahbot.

## Shoots

If you need any info or help, message @bob in slack.



[hubot-script](https://github.com/github/hubot-scripts/blob/master/CONTRIBUTING.md)
