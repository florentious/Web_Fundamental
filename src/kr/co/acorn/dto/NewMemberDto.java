package kr.co.acorn.dto;

public class NewMemberDto {
	private String id;
	private String pwd;
	private String email;
	private String name;
	private String location;
	private String phone;
	private String regDate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public NewMemberDto(String id, String pwd, String email, String name, String location, String phone, String regDate) {
		this.id = id;
		this.pwd = pwd;
		this.email = email;
		this.name = name;
		this.location = location;
		this.phone = phone;
		this.regDate = regDate;
	}
	
	
	
}
