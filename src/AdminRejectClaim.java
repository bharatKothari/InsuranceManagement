

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import databaseConnectivity.PolicyDatabase;

@WebServlet("/admin/rejectClaim")
public class AdminRejectClaim extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminRejectClaim() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		int claimID = (int)session.getAttribute("claimID");
		Connection con = PolicyDatabase.getConnection();
		String accepted = "Claim Rejected";
		try {
			PreparedStatement ps = con.prepareStatement("UPDATE claim SET status=? WHERE claimID=?");
			ps.setString(1,accepted);
			ps.setInt(2,claimID);
			ps.executeUpdate();
			response.sendRedirect(request.getContextPath()+"/admin-dashboard/examples/dashboard.html");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
