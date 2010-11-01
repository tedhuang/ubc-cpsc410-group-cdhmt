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
		
		return "\t<auctionID>" + auctionID + "</auctionID>\n + " +
				"\t<auctionTitle>" + auctionTitle + "</auctionTitle>\n" +
				"\t<expiryDate>" + expiryDate + "</expiryDate>\n" +
				"\t<creationDate>" + creationDate + "</creationDate>\n" +
				"\t<category>" + category + "</category>\n" +
				"\t<ownerID>" + ownerID + "</ownerID>\n" +
				"\t<lastBidderID>" + lastBidderID + "</lastBidderID>\n" +
				"\t<minPrice>" + minPrice + "</minPrice>\n" +
				"\t<latestBidPrice>" + latestBidPrice + "</latestBidPrice>\n" +
				"\t<bidCounter>" + bidCounter + "</bidCounter>\n" +
				"\t<auctionStatus>" + auctionStatus + "</auctionStatus>\n" +
				"\t<flickerAlbumID>" + flickerAlbumID + "</flickerAlbumID>\n" +
				"\t<numberOfViews>" + numberOfViews + "</numberOfViews>\n";
				
	}
	
	

}
