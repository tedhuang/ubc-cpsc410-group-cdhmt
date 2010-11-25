package Servlets;

import java.io.IOException;
import java.util.Calendar;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class chatRegisterServlet
 */
public class chatRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	Map<Integer, StringBuffer > incomingChatRequest;
	chatRelayServlet chatRelay;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public chatRegisterServlet() {
        super();
        
        incomingChatRequest	= new ConcurrentHashMap<Integer, StringBuffer >();
        chatRelay			= new chatRelayServlet();

    }


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String userIDString = request.getParameter("userID").toString();
		
		Integer userID = Integer.valueOf(userIDString);
		
		StringBuffer replyBuffer;
		
		if( incomingChatRequest.containsKey( userID ) ) {
			replyBuffer = incomingChatRequest.remove( userID );
		}
		else {
			replyBuffer = new StringBuffer("");
		}
		
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		
		XMLResponse.append( replyBuffer );
		
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String senderIDString = request.getParameter("userID").toString();
		String sendToIDString = request.getParameter("sendToID").toString();
		
		Integer senderID = Integer.valueOf(senderIDString);
		Integer sendToID = Integer.valueOf(sendToIDString);
		
		int pollingCode = 0;
		int sendToCode 	= 0;
		
		// setup sender side message polling
		StringBuffer replyBuffer = new StringBuffer();
		
		if (  chatRelay.sessionExists( senderID, sendToID ) ) {
			//TODO perhaps retrieve session message
			

		}
		else {
			pollingCode	= chatRelay.registerChatSession(senderID, sendToID);
			sendToCode = chatRelay.registerChatSession(sendToID, senderID);
			
			replyBuffer.append(
					"\t<chatSession" +
					" sendToID=\"" + sendToIDString + "\"" +
					" sendToCode=\"" + sendToCode + "\"" +
					" pollingCode=\"" + pollingCode + "\"" +
					">" + "</chatSession>\n");
		}
		
		
		StringBuffer tempBuffer;
		
		if( incomingChatRequest.containsKey( sendToID ) ) {
			tempBuffer = incomingChatRequest.get( sendToID );
		}
		else {
			tempBuffer = new StringBuffer();
		}
		
		
		//put pollingCode and senderID inside incomingChatRequest
		tempBuffer.append("\t<chatRequest" +
				" senderID=\"" + senderIDString + "\"" +
				" sendToCode=\"" + sendToCode + "\"" +
				" pollingCode=\"" + sendToCode + "\"" +
				">" + "</chatRequest>\n");
					
		incomingChatRequest.put(sendToID, tempBuffer);
		
		
		// Write XML to response if DB has return message
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		
		XMLResponse.append( replyBuffer );
		
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
		
	}

}
