package databaseConnectivity;

public class Client {
	int clientID,zipcode;
	String name,sex,contact,dob,aadhar,houseNo;
		
	public void setClientID(int clientID) {
		this.clientID=clientID;
	}
	public void setName(String name){
		this.name=name;
	}
	public void setDOB(String dob) {
		this.dob=dob;
	}
	public void setSex(String sex) {
		this.sex=sex;
	}
	public void setContact(String contact){
		this.contact=contact;
	}
	public void setAadhaar(String aadhaar){
		this.aadhar=aadhaar;
	}
	public void setHouseNo(String houseNo){
		this.houseNo=houseNo;
	}
	public void setZipcode(int zipcode) {
		this.zipcode=zipcode;
	}
	
	public int getClientID() {
		return this.clientID;
	}
	public String getName() {
		return this.name;
	}
	public String getDOB() {
		return this.dob;
	}
	public String getSex() {
		return this.sex;
	}
	public String getConatct() {
		return this.contact;
	}
	public String getAadhaar() {
		return this.aadhar;
	}
	public String getHouseNo() {
		return this.houseNo;
	}
	public int getZipcode() {
		return this.zipcode;
	}
}