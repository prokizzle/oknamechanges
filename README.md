# README

OKNameChanges was a bot that scanned profiles on OKCupid, and periodically returned to them to see if the usernames had changed. This is pretty easy to accomplish, since OKCupid aliases all of their old username URLs to the new username profiles. So if you were to go to `http://okcupid.com/profiles/old_user_name`, the link would resolve, but the username on the profile page would show their new username. So by checking to see if these two are different, I can easily detect a username change,
and quickly log it. Warning, this can take up quite a bit of database space. Expect to start seeing some results after a week.

In its current state, I expect this app to be broken. It takes a lot of maintenance to work, since OKCupid tends to release new features or changes roughly every Friday. They're very quickly transitioning the entire site to React, while simultaneously A/B testing new features. Keeping up with the OKCupid team is a nightmare, which is why I abandoned this project. On the other hand, it's insanely amusing to see a feed of username changes. 

Check out the reddit thread here: 
[https://www.reddit.com/r/OkCupid/comments/3id8ud/a_friend_of_mine_built_a_site_that_shows_okcupid/](https://www.reddit.com/r/OkCupid/comments/3id8ud/a_friend_of_mine_built_a_site_that_shows_okcupid/)

Basic usage
===========

- Add bots with

    bundle exec rake bots:add

You can add as many bots as you want. They all must be valid OKCupid users. All bots will be 'health-checked' periodically, and removed from the app if they are no longer valid accounts.
The more bots you have, the better this app works.

- Run the app

    bundle exec sidekiq

The app runs as a self-contained Sidekiq app, using Sidetiq as a scheduler. 

- Run it locally

    bundle exec foreman start

Using foreman will run the web server and the sidekiq server simultaneously. Don't forget to:

- `bundle install`
- `bundle exec rake db:create`
- `bundle exec rake db:migrate`

