package Classes;

import java.util.Calendar;
/*
 * Session Credential Generator
 */

import javax.servlet.http.HttpServletRequest;

public class Credential {

       private String hashString = null;

       public Credential( String username, String password ) {
    	   this.generateHash(username, password);
       }
       
       public Credential( HttpServletRequest request ) {
    	   this.hashString = request.getParameter("Credential").toString();
       }

       private void generateHash( String username, String password ) {
           this.hashString = Integer.toHexString( username.hashCode() )
                                               + Integer.toHexString( password.hashCode() )
                                               + Integer.toHexString( Calendar.getInstance().getTime().hashCode() );
       }

       
       public String returnHash() {
    	   return hashString;
       }
}
