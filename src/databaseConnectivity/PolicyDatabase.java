package databaseConnectivity;
import java.sql.*;

public class PolicyDatabase {
	public static int addPaymentDetails(int policyNumber) {
		int status=0;
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("INSERT INTO payment(policyNumber,payDate,premium_amt,lateFee) VALUES (?,CURRENT_TIMESTAMP(),calculate_due_premium(?),calculate_late_fee(?))");
			ps.setInt(1, policyNumber);
			ps.setInt(2, policyNumber);
			ps.setInt(3, policyNumber);
			status=ps.executeUpdate();
			con.close();
		}catch(Exception e) {
			System.out.println(e);
		}
		return status;
	}
	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/insurance","root","very_strong_password");
		}catch(Exception e) {
			System.out.println(e);
		}
		return con;
	}
	public static int addPolicy(Policy p) {
		int status=0;
		try {
			Connection con = getConnection();
			PreparedStatement ps=con.prepareStatement("INSERT INTO policy(clientID,planID,cover,nomineeID,premium,dueDate,payment_interval,startDate,agentID,commission,status) VALUES (?,?,?,?,?,curdate(),?,curdate(),?,?,?)");
			ps.setInt(1,p.clientID);
			ps.setInt(2,p.planID);
			ps.setInt(3,p.cover);
			ps.setString(4,p.nomineeID);
			ps.setInt(5,p.premium);
			ps.setInt(6,p.payment_interval);
			ps.setInt(7,p.agentID);
			ps.setInt(8,p.commission);
			ps.setString(9,"Active");
			status = ps.executeUpdate();
			PreparedStatement ps1 = con.prepareStatement("SELECT MAX(policyNumber) from policy");
			ResultSet rs1 = ps1.executeQuery();
			rs1.next();
			int policyNumber = rs1.getInt(1);
			addPaymentDetails(policyNumber);
			
			con.close();
		}catch(Exception e) {
			System.out.println(e);
		}
		return status;
	}
}
