package Servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

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
		
		//String auctionItem = request.getParameter("auctionItem").toString();

		System.out.println("Check");
		
		//Hard coded URL for public album
		URL url = new URL("http://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=301748fd9ccc9801f9ed91772b19d8bd&user_id=55164508@N02");
		
		//Doesn't work:
//		StreamSource xml = new StreamSource(url.openStream());
//		StreamSource xsl = new StreamSource(new File("/path/to/file.xsl"));
//		StreamResult output = new StreamResult(response.getOutputStream());
//
//		try {
//		    Transformer transformer = TransformerFactory.newInstance().newTransformer(xsl);
//		    transformer.transform(xml, output);
//		} catch (TransformerException e) {
//		    throw new ServletException("Transforming XML failed.", e);
//		}
//		
//		System.out.println(output.toString()); //Testprint
//		
//		response.setContentType("application/xml");
//		response.getWriter().println(output);
		
	}

}
