package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class pageFrameTestServlet
 */
public class pageFrameTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public pageFrameTestServlet() {
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
		String title = "pageFrame test page";
		String body = "&ltbutton type=&quotbutton&quot &gt PageFrameTest &lt/button&gt";
		
		
		//		&	&amp;
		//		<	&lt;
		//		>	&gt;
		//		"	&quot;
		//		'	&apos
		StringBuffer XMLResponse = new StringBuffer();	
		XMLResponse.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n");
		XMLResponse.append("<response>\n");
		XMLResponse.append("\t<title>" + title + "</title>\n");
		XMLResponse.append("\t<body>" + body + "</body>\n");
		XMLResponse.append("\t<test>" + "&ltbutton type=&quotbutton&quot &gt PageFrameTest &lt/button&gt" + "</test>\n");
		XMLResponse.append("</response>\n");
			
		response.setContentType("application/xml");
		response.getWriter().println(XMLResponse);
	}

}
