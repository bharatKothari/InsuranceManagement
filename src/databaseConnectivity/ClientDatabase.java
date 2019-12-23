package databaseConnectivity;
import java.sql.*;

public class ClientDatabase {
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
	public static int addCustomer(Client c,String password) {
		int status=0;
		try {
			Connection con = getConnection();
			PreparedStatement ps=con.prepareStatement("INSERT INTO client(clientName,dob,sex,contact,aadhaar,houseNo,zip,password) VALUES (?,?,?,?,?,?,?,?)");
			ps.setString(1,c.getName());
			ps.setString(2,c.getDOB());
			ps.setString(3, c.getSex());
			ps.setString(4,c.getConatct());
			ps.setString(5,c.getAadhaar());
			ps.setString(6,c.getHouseNo());
			ps.setInt(7,c.getZipcode());
			ps.setString(8, password);
			status = ps.executeUpdate();
			con.close();
		}catch(Exception e) {
			System.out.println(e);
		}
		return status;
	}
	public static Client getClient(int ClientID) {
		Client c = new Client();
		try {
			Connection con = getConnection();
			PreparedStatement ps = con.prepareStatement("SELECT * FROM client WHERE clientID=?");
			ps.setInt(1, ClientID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				c.setClientID(ClientID);
				c.setName(rs.getString("clientName"));
				c.setDOB(rs.getString("dob"));
				c.setSex(rs.getString("sex"));
				c.setContact(rs.getString("contact"));
				c.setAadhaar(rs.getString("aadhaar"));
				c.setHouseNo(rs.getString("houseNo"));
				c.setZipcode(rs.getInt("zip"));
			}
			else {
				c = null;
			}
		}catch(Exception e) {
			System.out.println(e);
		}
		return c;
	}
	public static int validateCustomer(String userName,String password) {
		int status=0;
		try {
			Connection con = getConnection();
			PreparedStatement ps=con.prepareStatement("SELECT * FROM client WHERE clientID=? AND password=?");
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
	public static int insertLocation(String area,String city,String state, int zip) {
		int status=0;
		try {
			Connection con = getConnection();
			PreparedStatement ps=con.prepareStatement("INSERT INTO location(area,city,state,zip) VALUES(?,?,?,?)");
			ps.setString(1, area);
			ps.setString(2, city);
			ps.setString(3, state);
			ps.setInt(4, zip);
			status=ps.executeUpdate();
		}catch(Exception e) {
			System.out.println(e);
		}
		return status;
	}
}
