

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import databaseConnectivity.*;

@WebServlet("/agent/addClient")
public class AgentAddClient extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AgentAddClient() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if(session==null || session.getAttribute("agentID")==null) {
			response.sendRedirect(request.getContextPath()+"/agent");
		}
		else {
			response.sendRedirect(request.getContextPath()+"/agent-dashboard/examples/addClient.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Client c = new Client();
		c.setName(request.getParameter("name"));
		c.setAadhaar(request.getParameter("aadhaar"));
		c.setContact(request.getParameter("contact"));
		c.setDOB(request.getParameter("DOB"));
		c.setHouseNo(request.getParameter("houseNo"));
		c.setSex(request.getParameter("sex"));
		ClientDatabase.insertLocation(request.getParameter("area"),request.getParameter("city"),request.getParameter("state"), Integer.parseInt(request.getParameter("zipcode")));
		c.setZipcode(Integer.parseInt(request.getParameter("zipcode")));
		int status = ClientDatabase.addCustomer(c, request.getParameter("password"));
		if(status!=1) {
			System.out.println("Client Not Inserted");
		}
		response.sendRedirect(request.getContextPath()+"/agent");
	}

}
