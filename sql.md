# Introduction #

CCREATE TABLE AuctionsTable
(AuctionID int(10) NOT NULL AUTO\_INCREMENT,AuctionTitle varchar(255),ExpiryDate date,CreationDate date,Category varchar(255),OwnerID int(10),LastBidderID int(10),MinPrice double(10,2),
LatestBidPrice double(10,2),BidCounter int(10) NOT NULL DEFAULT '0',AuctionStatus varchar(255),FlickerAlbumID varchar(255),NumberOfViews int(10) NOT NULL DEFAULT '0', AuctionExpireTime bigint(20) unsigned, PRIMARY KEY (AuctionID));

CREATE TABLE UserTable
(UserID int(10) NOT NULL AUTO\_INCREMENT,UserName varchar(255) NOT NULL, Password varchar(255) NOT NULL, PhoneNumber varchar(10), FriendID varchar(255), PhoneCarrier varchar(255), EmailAddress varchar(255), Credential varchar(255), LoginExpireTime bigint(20) unsigned, PRIMARY KEY (UserID) );

CREATE TABLE UserBidsTable
(AuctionID int(10) NOT NULL, UserID int(10) NOT NULL , FOREIGN KEY(AuctionID) REFERENCES AuctionsTable(AuctionID), FOREIGN KEY(UserID) REFERENCES UserTable(UserID) );

CREATE TABLE ChatLogTable
(AuctionID int(10) NOT NULL, UserID int(10) NOT NULL, ChatHistory varchar(4096) );


# Details #

Add your content here.  Format your content with:
  * Text in **bold** or _italic_
  * Headings, paragraphs, and lists
  * Automatic links to other wiki pages