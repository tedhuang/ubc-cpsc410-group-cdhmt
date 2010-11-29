package Servlets;

import java.io.IOException;
import java.util.Calendar;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Classes.User;
import Managers.DBManager;

/**
 * Servlet implementation class chatRegisterServlet
 */
public class chatRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	Map<Integer, StringBuffer > incomingChatRequest;
	chatRelayServlet chatRelay;
	DBManager dbm;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public chatRegisterServlet() {
        super();
        
        incomingChatRequest	= new ConcurrentHashMap<Integer, StringBuffer >();
        chatRelay			= new chatRelayServlet();
        dbm 				= new DBManager();
        
    }


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * Polling for inComingChatRequest
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//String userIDString = request.getParameter("userID").toString();
		String credential = request.getParameter("Credential").toString();
		int id = dbm.userCredentialCheckNoUpdate(credential);
		
		//Integer userID = Integer.valueOf(userIDString);
		Integer userID = new Integer(id);
		
		StringBuffer replyBuffer;
		
		if( incomingChatRequest.containsKey( userID ) ) {
			replyBuffer = incomingChatRequest.remove( userID );
			System.out.println("User " + userID + " incoming chat registering");
			System.out.println(replyBuffer);
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
	 * used to send chat requests
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//String senderIDString = request.getParameter("userID").toString();
		String credential = request.getParameter("Credential").toString();
		int userID = dbm.userCredentialCheckNoUpdate(credential);
		String sendToIDString = request.getParameter("sendToID").toString();
		
		Integer senderID = new Integer(userID);
		Integer sendToID = Integer.valueOf(sendToIDString);
		
		User senderUser = dbm.userGetByID( senderID );
		User sendToUser = dbm.userGetByID( sendToID );
		
		int pollingCode = 0;
		int sendToCode 	= 0;
		
		// setup sender side message polling
		StringBuffer replyBuffer = new StringBuffer();
		
		if (  chatRelay.sessionExists( senderID, sendToID ) ) {
			//TODO perhaps retrieve session message
			System.out.println("Session Exists between " + senderID + " and " + sendToID);

		}
		else {
			pollingCode	= chatRelay.registerChatSession(senderID, sendToID);
			sendToCode = chatRelay.registerChatSession(sendToID, senderID);
			
			replyBuffer.append(
					"\t<chatSession" +
					" sendToID=\"" + sendToIDString + "\"" +
					" sendToCode=\"" + sendToCode + "\"" +
					" pollingCode=\"" + pollingCode + "\"" +
					" friendName=\"" + sendToUser.userName + "\"" +
					">" + "</chatSession>\n");
			System.out.println(replyBuffer);
		}
		
		//TODO need to stop user from setting up chat if sendTo is offline
		StringBuffer tempBuffer;
		
		if( incomingChatRequest.containsKey( sendToID ) ) {
			tempBuffer = incomingChatRequest.get( sendToID );
		}
		else {
			tempBuffer = new StringBuffer();
		}
		
		//setup chatRequest, fill parameter for receiver side
		//put pollingCode and senderID inside incomingChatRequest
		tempBuffer.append("\t<chatRequest" +
				" senderID=\"" + senderID.toString() + "\"" +
				" sendToCode=\"" + pollingCode + "\"" +
				" pollingCode=\"" + sendToCode + "\"" +
				" friendName=\"" + senderUser.userName + "\"" +
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
