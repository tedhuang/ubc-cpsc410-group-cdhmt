package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Managers.DBManager;

/**
 * Servlet implementation class userLogoutServlet
 */
public class userLogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public userLogoutServlet() {
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
		String userCred = request.getParameter("Credential").toString();

		
		DBManager dbm = new DBManager();
				
		//int userID = dbm.userCredentialCheck( userCred);
		
		dbm.userLogout(userCred);
		
//		if (dbm.userLogout( userCred ) ) {
//			System.out.println("Logout Sucessful");
//		}
//		else {
//			System.out.println("Logout Fail?");
//		}
		
	}

}
