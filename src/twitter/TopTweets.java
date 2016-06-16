package twitter;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Key;
import javax.servlet.RequestDispatcher;


@SuppressWarnings("serial")
public class TopTweets extends HttpServlet {

	
	 public void doGet(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException {
         resp.setContentType("text/html");
        
        
        RequestDispatcher rd = req.getRequestDispatcher("toptweets.jsp");
		rd.include(req, resp);     
     
                 
         }
	 
       

}