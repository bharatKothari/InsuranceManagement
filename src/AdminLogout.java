

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/logout")
public class AdminLogout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminLogout() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session!=null || (boolean)session.getAttribute("admin")) {
			session.invalidate();
		}
		response.sendRedirect(request.getContextPath()+"/mini project/examples/agent login page.jsp");	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
