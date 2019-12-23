

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import databaseConnectivity.*;

@WebServlet("/client")
public class Customer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Customer() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session==null || session.getAttribute("clientID")==null) {
			response.sendRedirect(request.getContextPath()+"/mini project/examples/login-page.html");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/customer-dashboard/examples/dashboard.html");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("userName");
		String password = request.getParameter("password");
		int status = ClientDatabase.validateCustomer(id,password);
		if(status==1) {
			HttpSession session = request.getSession();
			session.setAttribute("clientID", id);
			response.sendRedirect(request.getContextPath()+"/customer-dashboard/examples/dashboard.html");
		}
		else {
			System.out.println("WRONG PASSWORD");
			response.sendRedirect(request.getContextPath()+"/mini project/examples/login-page.html");
		}
	}
}
