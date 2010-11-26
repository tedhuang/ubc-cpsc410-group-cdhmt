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
	
//	Map<Integer, HttpServletResponse> chatOngoingMap;
//	Map<Integer, HttpServletResponse> chatIdleMap;
	Map<Integer, StringBuffer > sessionMsgMap;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public chatRelayServlet() {
        super();
        
        
//        chatOngoingMap = new ConcurrentHashMap<Integer, HttpServletResponse>();
//        chatIdleMap = new ConcurrentHashMap<Integer, HttpServletResponse>();
        sessionMsgMap = new ConcurrentHashMap<Integer, StringBuffer >();
        
        DBManager dbm = new DBManager();
        
        // Statement stm = dbm.createStatement();
        
        //TODO use statment without disconnecting
    }
	
	private int cantorPairing( int key1, int key2 ) {
		return ( ((key1 + key2) * (key1 + key2 + 1) ) / 2  ) + key2;
	}
    
	public int registerChatSession(int senderID, int receiverID ) {
		
		int pollingCode = cantorPairing( receiverID, senderID) ;
		
		sessionMsgMap.put(pollingCode, new StringBuffer() );
		
		return pollingCode;
	}
	
	public void closeChatSession(int pollingCode ) {
		
		//TODO extra step/check?
		sessionMsgMap.remove(pollingCode );
		
	}
	
	public boolean sessionExists( int senderID, int sendToID ) {
		return sessionMsgMap.containsKey( cantorPairing( senderID, sendToID ) );
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Registering the user's response for chat
		Integer pollingCode = Integer.parseInt( request.getParameter("pollingCode") );
		
		StringBuffer tempBuffer;
		if( sessionMsgMap.containsKey( pollingCode ) ) {
			tempBuffer = sessionMsgMap.remove( pollingCode );
			System.out.println("Message from " + pollingCode + ":\n" + tempBuffer );
		}
		else {
			//tempBuffer = new StringBuffer("\t<message></message>");
			tempBuffer = new StringBuffer("");
		}
		
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		
		XMLResponse.append( tempBuffer );
		
		XMLResponse.append("</response>\n");
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// get ID for sender and receiver
		String senderIDString = request.getParameter("senderID").toString();
//		String sendToIDString = request.getParameter("sendToID").toString();
//		
//		Integer senderID = Integer.valueOf(senderIDString);
//		Integer sendToID = Integer.valueOf(sendToIDString);
		
		String sendToCodeString = request.getParameter("sendToCode").toString();
		Integer sendToCode = Integer.valueOf(sendToCodeString);
		
		// generate the key pairing
//		int pairKeyTo = cantorPairing( senderID.intValue(), sendToID.intValue() );
//		int pairKeyFrom = cantorPairing( sendToID.intValue(), senderID.intValue()  );
		
		String msg = request.getParameter("message").toString();
		
		StringBuffer tempBuffer;
		
		if ( sessionMsgMap.containsKey( sendToCode ) ) {
			tempBuffer = sessionMsgMap.get( sendToCode );
		}
		else {
			tempBuffer = new StringBuffer();
		}

		
		tempBuffer.append("\t<message" +
							" senderID=\"" + senderIDString + "\"" +
							" timeStamp=\"" + Calendar.getInstance().getTimeInMillis() + "\"" +
							">" + msg + "</message>\n");
		
		System.out.println("sendToCode: " + sendToCode + " \n" + tempBuffer );
		sessionMsgMap.put( sendToCode, tempBuffer );
		// Write XML to response if DB has return message
//		StringBuffer XMLResponse = new StringBuffer();	
//		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
//		XMLResponse.append("<response>\n");
//		
//		XMLResponse.append("\t<message>" + msg + "</message>\n");
//		
//		XMLResponse.append("</response>\n");
//		writeToResponse.setContentType("application/xml");
//		writeToResponse.getWriter().println(XMLResponse);
		

	}

}