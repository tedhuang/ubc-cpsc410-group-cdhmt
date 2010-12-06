package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * DEPRECATED
 * Servlet implementation class pageFrameTestServlet
 */
public class entryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public entryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Write XML to response.
		String auctionItem = request.getParameter("auctionItem").toString();
		String status=request.getParameter("status").toString(); 
		String timeLeft =request.getParameter("timeLeft").toString();
		String latestPrice=request.getParameter("latestPrice").toString();
		
		
		//		&	&amp;
		//		<	&lt;
		//		>	&gt;
		//		"	&quot;
		//		'	&apos
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		XMLResponse.append("\t<auctionItem>" + auctionItem + "</auctionItem>\n");
		XMLResponse.append("\t<status>" + status + "</status>\n");
		XMLResponse.append("\t<timeLeft>" + timeLeft + "</timeLeft>\n");
		XMLResponse.append("\t<latestPrice>" + latestPrice + "</latestPrice>\n");
		XMLResponse.append("</response>\n");
			
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
	}

}
