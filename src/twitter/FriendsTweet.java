package twitter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;


@SuppressWarnings("serial")
public class FriendsTweet extends HttpServlet {

	
	 public void doGet(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException {
         resp.setContentType("text/html");
         PrintWriter out=resp.getWriter();
       
         RequestDispatcher rd = req.getRequestDispatcher("Tweetfriends.jsp");
 		rd.include(req, resp);     
      
	 }
}