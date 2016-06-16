package twitter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;

@SuppressWarnings("serial")
public class UpdateCountTweet extends HttpServlet {

	
	 public void doGet(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException {
         resp.setContentType("text/html");
    
         RequestDispatcher rd = req.getRequestDispatcher("tweets.jsp");
 		rd.include(req, resp);     
      
	 }
	 public void doPost(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException {
         resp.setContentType("text/html");
         PrintWriter out=resp.getWriter();
         DatastoreService ds = DatastoreServiceFactory.getDatastoreService(); 
        out.print("here");
         String strKey=req.getParameter("keyid");
 		Key key = KeyFactory.stringToKey(strKey);
 		Query query = new Query("TweetsIndu");
 		Filter filter = new Query.FilterPredicate(Entity.KEY_RESERVED_PROPERTY,FilterOperator.EQUAL,key);
 		query.setFilter(filter);
 		PreparedQuery pq = ds.prepare(query);
 		Entity tweet = pq.asSingleEntity();
 		req.setAttribute("zombie", tweet.getProperty("zombie"));
 		req.setAttribute("status", tweet.getProperty("status"));
 		tweet.setProperty("count", ((Long)tweet.getProperty("count")).intValue()+1);
 		ds.put(tweet);
 		req.setAttribute("count",(tweet.getProperty("count")));
        RequestDispatcher rd = req.getRequestDispatcher("tweets.jsp");
 		rd.include(req, resp);     
      
	 }
}