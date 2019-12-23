

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import databaseConnectivity.Agent;
import databaseConnectivity.AgentDatabase;

@WebServlet("/admin/addAgent")
public class AdminAddAgent extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminAddAgent() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session==null || !(boolean)session.getAttribute("admin")) {
			response.sendRedirect(request.getContextPath()+"/mini project/examples/agent login page.jsp");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/admin-dashboard/examples/typography.html");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Agent a = new Agent();
		a.setName(request.getParameter("name"));
		a.setContact(request.getParameter("contact"));
		a.setAddress(request.getParameter("address"));
		AgentDatabase.addAgent(a, request.getParameter("password"));
		response.sendRedirect(request.getContextPath()+"/admin-dashboard/examples/dashboard.html");
	}
}
