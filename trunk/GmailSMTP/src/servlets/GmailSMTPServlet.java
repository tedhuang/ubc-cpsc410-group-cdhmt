package servlets;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import classes.SMTPManager;

/**
 * Servlet implementation class GmailSMTPServlet
 */
public class GmailSMTPServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GmailSMTPServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SMTPManager emailManager = SMTPManager.getInstance();
		
		Enumeration param = request.getParameterNames();
		
		String toAddress = request.getParameter("emailAddress").toString();
		String subject = request.getParameter("subject").toString();
		String body = request.getParameter("body").toString();
		
		emailManager.sendMail(toAddress, subject, body);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		SMTPManager emailManager = SMTPManager.getInstance();
		
		String toAddress = request.getParameter("emailAddress").toString();
		String subject = request.getParameter("subject").toString();
		String body = request.getParameter("body").toString();
		
		emailManager.sendMail(toAddress, subject, body);
		
		// Write XML to response.
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		XMLResponse.append("\t<toAddress>" + toAddress + "</toAddress>\n");
		XMLResponse.append("\t<subject>" + subject + "</subject>\n");
		XMLResponse.append("\t<body>" + body + "</body>\n");
		XMLResponse.append("</response>\n");
			
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
	}

}
