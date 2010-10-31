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
	public int lastBidder;
	public double minPrice;
	public double lastestBidPrice;
	public int bidCounter;
	public String auctionStatus;
	public String flickerAlbumID;
	public int numberOfViews;
	
	public void toXML(HttpServletResponse response) throws ServletException, IOException{
		
		//Write XML
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		
		XMLResponse.append("\t<auctionID>" + auctionID + "</auctionID>\n + " +
							"\t<auctionTitle>" + auctionTitle + "</auctionTitle>\n" +
							"\t<expiryDate>" + expiryDate + "</expiryDate>\n" +
							"\t<creationDate>" + creationDate + "</creationDate>\n"
							"\t<category>" + category + "</category>\n" +
							"\t<ownerID>" + ownerID + "</ownerID>\n" +
							"\t<lastBidder>" + lastBidder + "</lastBidder>\n" +
							"\t<minPrice>" + minPrice + "</minPrice>\n" +
							"\t<lastestBidPrice>" + lastestBidPrice + "</lastestBidPrice>\n" +
							"\t<bidCounter>" + bidCounter + "</bidCounter>\n" +
							"\t<auctionStatus>" + auctionStatus + "</auctionStatus>\n" +
							"\t<flickerAlbumID>" + flickerAlbumID + "</flickerAlbumID>\n" +
							"\t<numberOfViews>" + numberOfViews + "</numberOfViews>\n");
		XMLResponse.append("</response>\n");
		
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
				
	}
	
	

}
