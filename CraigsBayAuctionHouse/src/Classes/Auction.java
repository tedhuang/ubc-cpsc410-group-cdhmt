package Classes;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Auction {
	
	public int auctionID;
	public String auctionTitle;
	public double expiryDate;
	public double creationDate;
	public String category;
	public int ownerID;
	public int lastBidderID;
	public double minPrice;
	public double latestBidPrice;
	public int bidCounter;
	public String auctionStatus;
	public String flickerAlbumID;
	public int numberOfViews;

	
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
				"/>\n";
				
	}
	
	

}
