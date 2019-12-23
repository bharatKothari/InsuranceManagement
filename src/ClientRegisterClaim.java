

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import databaseConnectivity.PolicyDatabase;

@WebServlet("/client/registerClaim")
public class ClientRegisterClaim extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ClientRegisterClaim() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session==null || session.getAttribute("clientID")==null) {
			response.sendRedirect(request.getContextPath()+"/mini project/examples/login-page.html");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/customer-dashboard/examples/claim.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		int policyNumber = Integer.parseInt(request.getParameter("policyNumber"));
		String status = "Under Evaluation";
		String description = request.getParameter("description");
		Connection con = PolicyDatabase.getConnection();
		try {
			PreparedStatement ps = con.prepareStatement("INSERT INTO claim(policyNumber,claimDate,status,description) VALUES(?,curdate(),?,?)");
			ps.setInt(1, policyNumber);
			ps.setString(2,status);
			ps.setString(3, description);
			ps.executeUpdate();
		}catch(Exception e) {
			System.out.println(e);
		}
		response.sendRedirect(request.getContextPath()+"/client");
	}
}
