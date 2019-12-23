package kr.co.acorn.dto;

public class MemberDto {
	private String email;
	private String name;
	private String pwd;
	private String phone;
	private String regDate;
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
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
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
	
	
	public MemberDto() {
	}
	
	public MemberDto(String email, String name, String pwd, String phone) {
		this(email,name,pwd,phone,null);
	}
	public MemberDto(String email, String name, String pwd, String phone, String regDate) {
		this.email = email;
		this.name = name;
		this.pwd = pwd;
		this.phone = phone;
		this.regDate = regDate;
	}
	
	
}
