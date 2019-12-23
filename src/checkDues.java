

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import databaseConnectivity.*;

@WebServlet("/agent/checkDues")
public class checkDues extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public checkDues() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session==null || session.getAttribute("agentID")==null) {
			response.sendRedirect(request.getContextPath()+"/agent");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/agent-dashboard/examples/pay_bill.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		int policyNumber= (int)session.getAttribute("policyNumber");
		int status = PolicyDatabase.addPaymentDetails(policyNumber);
		if(status!=1) {
			System.out.println("Payment Not Successful");
		}
		response.sendRedirect(request.getContextPath()+"/agent-dashboard/examples/success.jsp");
	}
}
