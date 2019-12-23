

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/agent/viewPlans")
public class AgentViewPlans extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AgentViewPlans() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession(false);
		if(session==null || session.getAttribute("agentID")==null) {
			response.sendRedirect(request.getContextPath()+"/agent");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/agent-dashboard/examples/viewPlans.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
