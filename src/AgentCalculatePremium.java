 

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import databaseConnectivity.PolicyDatabase;
import java.sql.*;

@WebServlet("/agent/calculatePremium")
public class AgentCalculatePremium extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AgentCalculatePremium() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session==null || session.getAttribute("agentID")==null) {
			response.sendRedirect(request.getContextPath()+"/agent");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/agent-dashboard/examples/calculate.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String planName=request.getParameter("planName");
		int interval = Integer.parseInt(request.getParameter("interval"));
		int cover = Integer.parseInt(request.getParameter("cover"));
		System.out.println(planName + interval + cover);
		try {
			Connection con = PolicyDatabase.getConnection();
			PreparedStatement ps = con.prepareStatement("Select duration,adminCharge,planID from plans where planName = ?");
			ps.setString(1, planName);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int adminCharge = rs.getInt("adminCharge");
			int duration = rs.getInt("duration");
			int premium = cover*(100+adminCharge)*interval/(100*duration*12);
			session.setAttribute("planName",planName);
			session.setAttribute("cover", cover);
			session.setAttribute("interval",interval);
			session.setAttribute("premium",premium);
			session.setAttribute("planID", rs.getInt("planID"));
			response.sendRedirect(request.getContextPath()+"/agent/addPolicy");
		}catch(Exception e) {
			System.out.println(e);
		}
	}
}
