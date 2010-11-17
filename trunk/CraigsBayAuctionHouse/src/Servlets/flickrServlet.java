package Servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.math.BigInteger;
import java.net.URL;
import java.security.MessageDigest;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import Managers.FlickrManager;

/**
 * Servlet implementation class flickrServlet
 */
public class flickrServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public flickrServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
	
	/**
	 * Get the MD5 hash of a text string
	 */
	public static String MD5(String text)
	{
		String md5Text = "";
		try {
			MessageDigest digest = MessageDigest.getInstance("MD5");
			md5Text = new BigInteger(1, digest.digest((text).getBytes())).toString(16);
		} catch (Exception e) {
			System.out.println("Error in call to MD5");
		}
		
        if (md5Text.length() == 31) {
            md5Text = "0" + md5Text;
        }
		return md5Text;
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
		
		String apikey = "301748fd9ccc9801f9ed91772b19d8bd";
		String secret = "a6d78a61a59fbf33";
		String userid = "55164508@N02";
		String func = request.getParameter("func").toString();
		
		//TODO: add condition for more functions 
		//when func will define which function we are giving the hash to and in turn, they differ in the format of the response
		
		//if(func.equals("getFrob")){
			//hash calculation for getfrob call only
			String hash = MD5(secret + "api_key" + apikey + "formatjson" + "methodflickr.auth.getFrob" + "userid" + userid);
				
			System.out.println("Hash for getfrob: " + hash);
			
			StringBuffer XMLResponse = new StringBuffer();	
			XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
			XMLResponse.append("<response>\n");
			
			XMLResponse.append("\t<hash>" + hash + "</hash>\n");
			
			XMLResponse.append("</response>\n");
			response.setContentType("application/xml");
			response.getWriter().println(XMLResponse);
		//}
		
	}

}








