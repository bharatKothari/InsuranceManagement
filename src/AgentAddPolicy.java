

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import databaseConnectivity.*;

@WebServlet("/agent/addPolicy")
public class AgentAddPolicy extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AgentAddPolicy() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session==null || session.getAttribute("agentID")==null) {
			response.sendRedirect(request.getContextPath()+"/agent");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/agent-dashboard/examples/addPolicy.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Policy p = new Policy();
		p.agentID=(int)session.getAttribute("agentID");
		p.clientID=Integer.parseInt(request.getParameter("clientID"));
		p.planID=(int)session.getAttribute("planID");
		p.cover=(int)session.getAttribute("cover");
		p.payment_interval=(int)session.getAttribute("interval");
		p.startDate=request.getParameter("startDate");
		p.premium=(int)session.getAttribute("premium");
		p.nomineeID=request.getParameter("nomineeID");
		Connection con = PolicyDatabase.getConnection();
		try {
			PreparedStatement ps=con.prepareStatement("INSERT INTO nominee(nomineeName,aadhaar,contact,dob) VALUES (?,?,?,?)");
			ps.setString(1, request.getParameter("nomineeName"));
			ps.setString(2, request.getParameter("nomineeID"));
			ps.setString(3, request.getParameter("nomineeContact"));
			ps.setString(4, request.getParameter("nomineeDOB"));
			ps.executeUpdate();
			con.close();
		}catch(Exception e) {
			System.out.println(e);
		}
		int status = PolicyDatabase.addPolicy(p);		
		if(status!=1) {
			System.out.println("Policy Not Inserted");
			response.sendRedirect(request.getContextPath()+"/agent");
		}
		response.sendRedirect(request.getContextPath()+"/agent-dashboard/examples/quote.jsp");
	}
}
