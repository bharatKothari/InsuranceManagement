package databaseConnectivity;

public class Agent {
	int agentID;
	String name,contact,address;
	
	public void setAgentID(int agentID) {
		this.agentID=agentID;
	}
	public void setName(String name) {
		this.name=name;
	}
	public void setContact(String contact) {
		this.contact=contact;
	}
	public void setAddress(String address) {
		this.address=address;
	}
	
	public int getAgentID() {
		return this.agentID;
	}
	public String getName() {
		return this.name;
	}
	public String getContact() {
		return this.contact;
	}
	public String getAddress() {
		return this.address;
	}
}
