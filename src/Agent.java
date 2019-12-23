

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import databaseConnectivity.*;

@WebServlet("/agent")
public class Agent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Agent() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session==null || session.getAttribute("agentID")==null) {
			response.sendRedirect(request.getContextPath()+"/mini project/examples/agent login page.jsp");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/agent-dashboard/examples/dashboard.html");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("userName");
		String password = request.getParameter("password");
		if(id.equals("admin") && password.equals("admin")) {
			HttpSession session = request.getSession();
			session.setAttribute("admin",true);
			System.out.println("Admin Login Success");
			response.sendRedirect(request.getContextPath()+"/admin-dashboard/examples/dashboard.html");
		}
		else {
			int status = AgentDatabase.validateAgent(id,password);
			if(status==1) {
				HttpSession session = request.getSession();
				session.setAttribute("agentID", Integer.parseInt(id));
				System.out.println("Login Success");
				response.sendRedirect(request.getContextPath()+"/agent-dashboard/examples/dashboard.html");
			}
			else {
				System.out.println("WRONG PASSWORD");
				response.sendRedirect(request.getContextPath()+"/mini project/examples/agent login page.html");
			}
		}
	}

}
