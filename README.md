#What does this do right now?

From the web:

- create an account with an email address and password
- add account details like your name and API information
- import characters

From the console:

- rake tasks to generate CSVs of all characters' skills and all characters' standings

#What is the purpose of this app?

To provide to in-game players resources that are not attainable by hand, with in-game menus or by third-party software.
To provide to out-of-game players a Corp portal.

Essentially this is going to be a question-answering machine. Players in-game aren't going to want to read a lot or sift through a lot of data, they want to spend time playing. IE we *want* a high bounce rate.

#V1

This app will reach version 1.0 when

- DONE! it can successfully reproduce all functionality of the CSV generator in the master branch
- it can utilize the CSVs it generates in its own views

To that end, at v1.0 this app should be able to tell you things like

- When I solomine, what should I fit? How big of a cut should I give a hauler?
- Who should I give my ore to in the corp to refine and how much of a cut should they get?
- What does the current market look like for ore and minerals? Should I refine X ore?

#V2

It's really up in the air.
I want to stay away from features like Forums, Message Boards etc. That said, it might be nice to have a place to schedule corp events (there is an in-game calendar though).

Features definitely in v2.0

- who is online? where are they? who wants to run a mission?
- who is that guy and why is he in my corp?
- Responsive design:
  - 700w or bigger: for those who want to see everything the app has to offer
  - 200w or smaller: for those who just want the player listing
  - 200w-700w: uhhh, we'll have to think of something for this
  - mobile: ???

#Questions this app will not make it its business to answer
(ie: If it ends up answering these questions that is purely a stepping-stone to a larger question not included in this list)

- How long will it take me to train for X skill/certificate/ship?
- How many of X can I fit on Y ship?
- How much money do I have?
- Do I have any EVE-Mail or Notifications?
- How many market bids do I have active?
- How many contracts do I have open?
- How many manufacturing processes am I running?