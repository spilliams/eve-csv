Not sure yet the direction I want to take this app. But it'll be EVE-related, and use [sinisterchipmunk/eve](https://github.com/sinisterchipmunk/eve)

Pardon the stream-of-consciousness here, but I need to figure out what this thing is.

#What does this do right now?

Absolutely nothing. Unless you count outputting "it works!" as something. Install with `bundle install` and run with `bundle exec rackup`. You may have to `kill -9` any running ruby processes (`lsof | grep ruby | grep IPv4` to get the pid)


#Why do we need an app?

Well, there are some things about running this corporation that could use an automated computation system like a computer. Some questions that we like to ask and don't like to wait for an answer about. For instance:

- what is the most profitable way to mine right now? where should I go? what should I fit? what should I pay my hauler?
- how much ammunition do I use in a normal play session? how expensive would it be to manufacture that ammunition versus buying it on the market?
- how does running level 4 security missions stack up against solomining?

I'm sure there are more questions, but these are enough to start thinking about a framework with which to start constructing an answering machine.

So for now this branch of this repository is going to contain a bunch of code that will someday replace the code in the master branch. That's right, we're refactoring that frameworkless php into an application (better now than after it gets to be 100 files big).
If anyone has database or environment preferences, I'm all ears. For now though I'll probably go with MySQL since I already have a host with it ready to go.

#Questions this app will not make it its business to answer
(ie: If it ends up answering these questions that is purely a stepping-stone to a larger answer not included in this list)

- How long will it take me to train for X skill/certificate/ship?
- How many of X can I fit on Y ship?
- How much money do I have?
- Do I have any EVE-Mail or Notifications?
- How many market bids do I have active?
- How many contracts do I have open?
- How many manufacturing processes am I running?