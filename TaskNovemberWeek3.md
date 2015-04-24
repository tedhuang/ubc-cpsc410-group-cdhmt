# Bugs and Issues Found on Dec 1 Debugging Session #

URGENT:
Page: Auction Details Page
Function requirement F14 states that closed auctions can be re-opened by the owner but right now if you close the auction, it cannot be accessed by the user anymore. (does not show up on manage auction)


URGENT:
Page: View All Auctions
Auction list does not refresh automatically like we said it was supposed to
-maybe add an auto refresh similar to what would happen after clicking bid


Type: Bug
Page: Manage Auction/View Details
-This only seems to affect some of the old created auctions (house s1, testtest)
Closing an expired auction does not change its status from expired to closed under the Status column in the Auction List Table. (Auction status changes to closed in the details page ) Due to this it is possible to "Change Auction Status" to close and then access the auction again from Manage Auction and still be able to close the auction again from "Owner Option: Change Auction Status"
(Tested with test1 - trying to close "testtest")


Type: Bug
Condition: logged in or not
Page: Auction List
Delete auction button under auction list page generates
javascript error and does nothing. This should not even be
there (take check box away)


Type: Defect
"Search People" does not work, maybe remove the link out of the right-side menu
Type: Issue
Page: Auction Details
User should not be able to add themselves as a friend

Type: Defect
Page: Manage Auction
User should not be able to check multiple checkboxes for
"EDIT" function
-Maybe have edit button next to each auction instead



Type: Defect:
Page: any
Clicking New Auction a million times makes UI go crazy


ooooooooooooooooooooooooooooooooooooooooooooo

Things to do when have time:

-Implement newest auctions first on the auction list

-Implement sort function?

-Add owner name to auction list table

-Add expiry time

-Implement description for auctions




# RESOLVED: #

Type: Issue:
Page: Auctions Details
Create auction button should be greyed out after it is
clicked before picture is uploaded

Type: Bug:
Page: Auctions Details
Nothing happens after setting to close and clicking "Owner
Option: Change Auction Status"

Type: Issue:
Page: Auctions Details
Bid button is greyed out but input for bid is still there,
maybe remove this

Type: Issue
Page: Auction List
Using a symbol such as " inside for the auction name will result in auction list loader not working

-Add more categories

-Add a response to flickr upload

ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo


# Introduction #

List of stuff we left to complete and the manhour estimation for them

# Details 28-30h #

URGENT MATTERS!!! FIX NOW -
  * remove delete button in view all auction
  * user profile not working

Bugs -
  * Advanged Search - not in, only basic search here

Pending Fixes
  * Friend's auction need to be loaded into advanced search tab
  * user Login / cred check - pass back the old credential if repeated login
  * chat - synchronize chat registering with login and logout fucntion
    * clear map if user logs out
    * offline message yay or nay?

Chat - 5h
  * MSG history functionality - 1h
  * DB Structuring 1h.

  * Chat client side receiving should be a HTTPRequest that simply monitors its onReadyStateChange() function to parse incoming XML
  * Chat client side sender should send msg using POST while client listen using GET

Friends - 2h - work with harry to fix
  * Need to hook up add friends
  * delete friends will mess up the UI

# Options #

Mail-Box System
  * possibly used for offline messaging and for friend request

AuctionExpireTime
  * repopulate DB with rows that has expiry time
  * keep in mind that SMS-daemon will need to check for expiry time
  * should a user who has bidded on an auction see it even if expired? (right now yes)
  * Should we put a expiry countdown timer on the viewAuctionsDetail page?

Random
  * Cleanup web.xml