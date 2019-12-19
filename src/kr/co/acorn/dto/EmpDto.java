package kr.co.acorn.dto;

public class EmpDto {
	private int no;
	private String name;
	private String job;
	private int mgr;
	private String hireDate;
	private int sal;
	private int comm;
	// 변수 하나만 선언해서 이름까지 받아오기 위해서
	private DeptDto deptDto;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public int getMgr() {
		return mgr;
	}
	public void setMgr(int mgr) {
		this.mgr = mgr;
	}
	public String getHireDate() {
		return hireDate;
	}
	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}
	public int getSal() {
		return sal;
	}
	public void setSal(int sal) {
		this.sal = sal;
	}
	public int getComm() {
		return comm;
	}
	public void setComm(int comm) {
		this.comm = comm;
	}
	public DeptDto getDeptDto() {
		return deptDto;
	}
	public void setDeptDto(DeptDto deptDto) {
		this.deptDto = deptDto;
	}
	
	// list.jsp 에서는 5개정보만 가져오니까 5개용으로 만들고, 그 외에 write, view 에는  다가져오는 생성자를 만들어야한다.
	// list.jsp 용도
	public EmpDto(int no, String name, String job, int mgr, String hireDate) {
		this.no = no;
		this.name = name;
		this.job = job;
		this.mgr = mgr;
		this.hireDate = hireDate;
	}
	
	// detail 용도
	public EmpDto(int no, String name, String job, int mgr, String hireDate, int sal, int comm, DeptDto deptDto) {
		this.no = no;
		this.name = name;
		this.job = job;
		this.mgr = mgr;
		this.hireDate = hireDate;
		this.sal = sal;
		this.comm = comm;
		this.deptDto = deptDto;
	}
	
	
	
	
	
	
	
}
