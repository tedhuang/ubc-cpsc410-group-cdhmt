package Servlets;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import javax.swing.Timer;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Managers.DBManager;

/**
 * Servlet implementation class auctionExpiredSMSServlet
 */
public class auctionExpiredSMSServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int UPDATE_TIME = 900000; //15 min right now
		
    private Timer timer;   
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public auctionExpiredSMSServlet() {
        super();
    }
    
    public void init()
    {
    	 ActionListener onTrigger = new ActionListener() {
    			
    			@Override
    			public void actionPerformed(ActionEvent e) {
    				
    				checkForSendSMS();
    				
    			}
    		};
    		
    	timer = new Timer(UPDATE_TIME, onTrigger);
    	timer.start();
    	
    }
    
    private void checkForSendSMS()
    {
    	//timer.stop();
    	
    	DBManager dbm = new DBManager();
    	
    	dbm.checkForExpiredAuctionSMSMessage();
    	timer.restart();
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
		// TODO Auto-generated method stub
	}

}
