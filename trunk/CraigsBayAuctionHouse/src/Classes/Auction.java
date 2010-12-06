package Classes;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*
 * Encapsulates an auction
 * 
 */
public class Auction {
	
	public int		auctionID;
	public String	auctionTitle;
	public String	expiryDate;
	public String	creationDate;
	public String	category;
	public int		ownerID;
	public int		lastBidderID;
	public double	minPrice;
	public double	latestBidPrice;
	public int		bidCounter;
	public String	auctionStatus;
	public String	flickerAlbumID;
	public int		numberOfViews;
	public String auctionDescription;
	public double millisecondsLeft;
	
	public Auction() {
		auctionID 		= -1;
		auctionTitle 	= null;
		expiryDate		= "";
		creationDate	= "";
		category		= null;
		ownerID			= -1;
		lastBidderID	= -1;
		minPrice		= -1;
		latestBidPrice	= -1;
		bidCounter		= 0;
		auctionStatus	= null;
		flickerAlbumID	= null;
		numberOfViews	= 0;
		auctionDescription="";
		millisecondsLeft=0;
	}

	
	//TODO: make sure null entry and null value could be processed for a certain field
	public String toXMLContent() {
		
		return "\t\t<auction" +
				" auctionID=\"" + auctionID + "\"" +
				" auctionTitle=\"" + auctionTitle + "\"" +
				" expiryDate=\"" + expiryDate  + "\"" +
				" creationDate=\"" + creationDate + "\"" +
				" category=\"" + category + "\"" +
				" ownerID=\"" + ownerID + "\"" +
				" lastBidderID=\"" + lastBidderID + "\"" +
				" minPrice=\"" + minPrice + "\"" +
				" latestBidPrice=\"" + latestBidPrice + "\"" +
				" bidCounter=\"" + bidCounter + "\"" +
				" auctionStatus=\"" + auctionStatus + "\"" +
				" flickerAlbumID=\"" + flickerAlbumID + "\"" +
				" numberOfViews=\"" + numberOfViews + "\"" +
				" auctionDescription=\"" + auctionDescription + "\"" +
				" expiryTimeMS=\"" + millisecondsLeft + "\"" +
				"/>\n";
				
	}
}
