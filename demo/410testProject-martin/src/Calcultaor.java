

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Calcultaor
 */
public class Calcultaor extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static int sum = 0;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Calcultaor() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private int add( String var1, String var2 ) {
    	int int1, int2;
    	int1 = Integer.parseInt(var1);
    	int2 = Integer.parseInt(var2);
    	
    	return int1+int2;
    }
    
    private String toXML( int sum ) {

    	return "<?xml version=\"1.0\"?>" + "\n" +
    			"<sum generated=\"1123969988414\">" + "\n" +
    			"<item code=\"sum\">" + "\n" +
    			"<value>"+sum+"</value>\n" +
    			"</item>\n" +
    			"</sum>"
    			;
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
		String action    = request.getParameter("action");
		String firstVar  = request.getParameter("firstVar");
		String secondVar = request.getParameter("secondVar");
		
		  if ((action != null) && (firstVar != null)&& (secondVar != null) ) {

			    // Add or remove items from the Cart
			    if ("add".equals(action)) {
			      sum = add(firstVar, secondVar);
			    }
			    
		  }
		  
		 String sumXML = toXML(sum );
		 
		 response.setContentType("application/xml");
		 response.getWriter().write(sumXML);

	}
}
