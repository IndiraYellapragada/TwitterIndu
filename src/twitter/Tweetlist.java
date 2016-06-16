package twitter;


import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;

import javax.servlet.RequestDispatcher;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Transaction;



@SuppressWarnings("serial")
public class Tweetlist extends HttpServlet {

	 public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException {
         resp.setContentType("text/html");
         PrintWriter out=resp.getWriter();
         DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

         String id = req.getParameter("keyid");
         out.println(id);
         Key k= KeyFactory.stringToKey(id);
         
         datastore.delete(k);
	

         RequestDispatcher rd = req.getRequestDispatcher("tweets.jsp");
    		rd.include(req, resp);

         
         
	 
}
}
