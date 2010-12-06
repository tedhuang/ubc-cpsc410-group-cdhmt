package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import Managers.DBManager;

/**
 * Servlet implementation class chatRelayServlet
 */
public class chatRelayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//this data structure holds the in-flight messages
	Map<Integer, StringBuffer > sessionMsgMap;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public chatRelayServlet() {
    	
    	//Initializing the servlet
        super();
        
        sessionMsgMap = new ConcurrentHashMap<Integer, StringBuffer >();
        
    }
	
    /*
     * DEPRECATED
     * Pairing function for generating session codes for chat clients
     */
	private int cantorPairing( int key1, int key2 ) {
		return ( ((key1 + key2) * (key1 + key2 + 1) ) / 2  ) + key2;
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * responds to the polling client, all the messages awaiting transfer
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Registering the user's response for chat
		Integer pollingCode = Integer.parseInt( request.getParameter("pollingCode") );
		
		StringBuffer tempBuffer;
		
		//checks for unsent messages
		if( sessionMsgMap.containsKey( pollingCode ) ) {
			tempBuffer = new StringBuffer("\t<isMsg" +
			" boolean=\"true\"></isMsg>\n");
			tempBuffer.append(sessionMsgMap.remove( pollingCode ));
			System.out.println("Message from " + pollingCode + ":\n" + tempBuffer );
		}
		else {
			tempBuffer = new StringBuffer("\t<isMsg" +
							" boolean=\"false\"></isMsg>\n");
		}
		
		//flush all the unsent message to the client
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		
		XMLResponse.append( tempBuffer );
		
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
		
	}
	
	
    /*
     * DEPRECATED
     */
	public boolean sessionExists( Integer pollingCode, Integer sendtoCode ) {
		return (sessionMsgMap.containsKey( pollingCode ) && sessionMsgMap.containsKey( sendtoCode ) );
	}
	
    /*
     * DEPRECATED
     */
	public int registerChatSession(int senderID, int receiverID ) {
		
		int pollingCode = cantorPairing( receiverID, senderID) ;
		
		sessionMsgMap.put(pollingCode, new StringBuffer() );
		
		return pollingCode;
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * append the latest message to the inbox of the destined client
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// get ID for sender and receiver
		String senderIDString = request.getParameter("senderID").toString();

		
		String senderName = request.getParameter("senderName").toString();
		String sendToCodeString = request.getParameter("sendToCode").toString();
		Integer sendToCode = Integer.valueOf(sendToCodeString);
		
		String msg = request.getParameter("message").toString();
		
		StringBuffer tempBuffer;
		
		// check if the destination already have messages
		if ( sessionMsgMap.containsKey( sendToCode ) ) {
			tempBuffer = sessionMsgMap.get( sendToCode );
		}
		else {
			tempBuffer = new StringBuffer();
		}

		//append the current message into the destination inbox
		tempBuffer.append("\t<message" +
							" senderID=\"" + senderIDString + "\"" +
							" senderName=\"" + senderName + "\"" +
							" timeStamp=\"" + Calendar.getInstance().getTimeInMillis() + "\"" +
							">" + msg + "</message>\n");
		
		System.out.println("sendToCode: " + sendToCode + " \n" + tempBuffer );
		sessionMsgMap.put( sendToCode, tempBuffer );

	}

}
