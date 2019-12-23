

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import databaseConnectivity.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class addPlan
 */
@WebServlet("/admin/addPlan")
public class addPlan extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addPlan() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session==null || !(boolean)session.getAttribute("admin")) {
			response.sendRedirect(request.getContextPath()+"/mini project/examples/agent login page.jsp");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/admin-dashboard/examples/AddPlan.jsp");
		}
	}	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String PolicyName=request.getParameter("PolicyName");
		String PolicyType=request.getParameter("PolicyType");
		String description=request.getParameter("description");
		int duration = Integer.parseInt(request.getParameter("duration"));
		int adminCharge = Integer.parseInt(request.getParameter("adminCharge"));
		int comRate = Integer.parseInt(request.getParameter("comRate"));
		int status=0;
		try {
			Connection con = PolicyDatabase.getConnection();
			PreparedStatement ps=con.prepareStatement("INSERT INTO plans(planName,duration,description,policyType,comRate,adminCharge) VALUES (?,?,?,?,?,?)");
			ps.setString(1,PolicyName);
			ps.setInt(2,duration);
			ps.setString(3,description);
			ps.setString(4,PolicyType);
			ps.setInt(5,comRate);
			ps.setInt(6,adminCharge);
			status = ps.executeUpdate();
			con.close();
		}catch(Exception e) {
			System.out.println(e);
		}
		response.sendRedirect(request.getContextPath()+"/admin-dashboard/examples/dashboard.html");
	}
}