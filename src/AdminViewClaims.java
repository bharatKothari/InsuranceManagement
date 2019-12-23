

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/viewClaims")
public class AdminViewClaims extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminViewClaims() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session==null || !(boolean)session.getAttribute("admin")) {
			response.sendRedirect(request.getContextPath()+"/mini project/examples/agent login page.jsp");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/admin-dashboard/examples/viewclaim.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
