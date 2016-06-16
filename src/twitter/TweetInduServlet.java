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
public class TweetInduServlet extends HttpServlet {

	
	 public void doGet(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException {
         resp.setContentType("text/html");
        
        
        String username=req.getParameter("zname");
        String uid=req.getParameter("uid");

        HttpSession sess=req.getSession();
        sess.setAttribute("username",username);
   
        RequestDispatcher rd = req.getRequestDispatcher("tweets.jsp");
		rd.include(req, resp);     
     
                 
         }
	 
       public void doPost(HttpServletRequest req, HttpServletResponse resp)
               throws IOException, ServletException {
    	   
    	   PrintWriter out=resp.getWriter();
    	   String content = req.getParameter("content");
         String username=req.getParameter("zombie");
         //String userid=req.getParameter("userid");
          
         
          Entity twtpost = new Entity("TweetsIndu");
           twtpost.setProperty("status", content);    
           twtpost.setProperty("zombie", username);     
           twtpost.setProperty("count", 0);    
           
           DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

           datastore.put(twtpost);

           out.println("Request is posted ");         

           RequestDispatcher rd = req.getRequestDispatcher("welcome.jsp");
   		rd.include(req, resp);     
       
}
       
       
       

}