

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/client/viewPolicies")
public class clientViewPolicies extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public clientViewPolicies() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session==null || session.getAttribute("clientID")==null) {
			response.sendRedirect(request.getContextPath()+"/mini project/examples/login-page.html");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/customer-dashboard/examples/viewPolicies.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
