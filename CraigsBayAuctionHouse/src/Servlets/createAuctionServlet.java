package Servlets;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Managers.DBManager;
import Managers.SMTPManager;


/**
 * Servlet implementation class GmailSMTPServlet
 */
public class createAuctionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public createAuctionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String AuctionTitle = request.getParameter("AuctionTitle").toString();
		String OwnerID = request.getParameter("OwnerID").toString();
		String MinPrice = request.getParameter("MinPrice").toString();
		
		DBManager dbm = new DBManager();
		dbm.createNewAuction(AuctionTitle, "test category",Double.parseDouble(MinPrice), Integer.parseInt(OwnerID), "flickr album");
		
		/*
		SMTPManager smtp = new SMTPManager();
		smtp.sendMail("delfinosmtp", "my sub", "body");
		*/
		
		// Write XML to response if DB has return message
//		StringBuffer XMLResponse = new StringBuffer();	
//		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
//		XMLResponse.append("<response>\n");
//		XMLResponse.append("\t<toAddress>" + toAddress + "</toAddress>\n");
//		XMLResponse.append("\t<subject>" + subject + "</subject>\n");
//		XMLResponse.append("\t<body>" + body + "</body>\n");
//		XMLResponse.append("</response>\n");
//			
//		response.setContentType("application/xml");
//		response.getWriter().println(XMLResponse);
	}

}