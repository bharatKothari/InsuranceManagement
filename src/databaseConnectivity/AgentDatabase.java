package databaseConnectivity;
import java.sql.*;

public class AgentDatabase {
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
	public static int addAgent(Agent a,String password) {
		int status=0;
		try {
			Connection con = getConnection();
			PreparedStatement ps=con.prepareStatement("INSERT INTO agent(agentName,contact,address,password) VALUES (?,?,?,?)");
			ps.setString(1,a.getName());
			ps.setString(2,a.getContact());
			ps.setString(3,a.getAddress());
			ps.setString(4,password);
			status = ps.executeUpdate();
			con.close();
		}catch(Exception e) {
			System.out.println(e);
		}
		return status;
	}
	public static Client[] getClientsOfAgent(int agentID) {
		
		int ids[];
		int i=0;
		Client array[]=new Client[0];
		try {
			Connection con = getConnection();
			PreparedStatement psLength = con.prepareStatement("SELECT COUNT(clientID) FROM policy WHERE agentID=?");
			psLength.setInt(1, agentID);
			ResultSet size = psLength.executeQuery();
			size.next();
			int length = size.getInt(1);
			ids = new int[length];
			array = new Client[length];
			PreparedStatement ps = con.prepareStatement("SELECT DISTINCT clientID FROM policy WHERE agentID=?");
			ps.setInt(1,agentID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ids[i]=rs.getInt("clientID");
				array[i]=ClientDatabase.getClient(ids[i]);
				i++;
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return array;
	}
	public static int validateAgent(String userName,String password) {
		int status=0;
		try {
			Connection con = getConnection();
			PreparedStatement ps=con.prepareStatement("SELECT * FROM agent WHERE agentID=? AND password=?");
			ps.setString(1, userName);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
				status=1;
		}catch(Exception e) {
			System.out.println(e);
		}
		return status;
	}	
}