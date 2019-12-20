package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.DeptDto;
import kr.co.acorn.dto.EmpDto;
import kr.co.acorn.util.ConnLocator;

public class EmpDao {
	//singleton
	
	private static EmpDao single;
	private EmpDao() {
		
	}
	public static EmpDao getInstance() {
		if(single == null) {
			single = new EmpDao();
		}
		return single;
	}
	
	private void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if(rs!= null) rs.close();
			if(ps!= null) ps.close();
			if(con!= null) con.close();
		} catch (SQLException e) {
			// TODO: handle exception
		}
	}
	
	public ArrayList<EmpDto> select(int start, int end) {
		ArrayList<EmpDto> list = new ArrayList<EmpDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("Select empno, ename, job, mgr, dname, e.deptno, Date_format(hiredate,'%Y/%m/%d') ");
			sql.append("FROM emp e JOIN dept d ON e.deptno=d.deptno ");
			sql.append("ORDER BY hiredate DESC, empno DESC ");
			sql.append("LIMIT ?,?");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setInt(++index, start);
			ps.setInt(++index, end);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				index = 0;
				
				int no = rs.getInt(++index);
				String name = rs.getString(++index);
				String job = rs.getString(++index);
				int mgr = rs.getInt(++index);
				String dname = rs.getString(++index);
				int deptno = rs.getInt(++index);
				String hireDate = rs.getString(++index);
				
				DeptDto deptDto = new DeptDto(deptno,dname,null);
				
				list.add(new EmpDto(no,name,job,mgr,hireDate, deptDto));
						
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
		}
		
		
		return list;
		
	}
	
	public EmpDto select(int cNo) {
		EmpDto dto = null;

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("SELECT empno, ename, job, mgr, Date_format(hiredate,'%Y/%m/%d'), sal, comm, e.deptno, dname ");
			sql.append("FROM emp e JOIN dept d ON e.deptno=d.deptno ");
			sql.append("WHERE empno = ? ");

			ps = con.prepareStatement(sql.toString());

			int index = 0;
			ps.setInt(++index, cNo);

			rs = ps.executeQuery();

			if (rs.next()) {
				index = 0;
				int no = rs.getInt(++index);
				String name = rs.getString(++index);
				String job = rs.getString(++index);
				int mgr = rs.getInt(++index);
				String hireDate = rs.getString(++index);
				int sal = rs.getInt(++index);
				int comm = rs.getInt(++index);
				int deptno = rs.getInt(++index);
				String dname = rs.getString(++index);
				
				DeptDto deptDto = new DeptDto(deptno, dname, null);
				
				dto = new EmpDto(no,name,job,mgr,hireDate,sal,comm, deptDto);
				
				
				//dto = new EmpDto(rs.getInt(++index), rs.getString(++index), rs.getString(++index), rs.getInt(++index), rs.getString(++index), rs.getInt(++index), rs.getInt(++index), rs.getInt(++index));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);

		}

		return dto;
	}
	
	public int getTotalRows() {
		int totalRows = 0;
		
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("SELECT COUNT(empno) FROM emp");
			
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				int index = 0;
				totalRows = rs.getInt(++index);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
			
		}
		
		
		return totalRows;
	}
	
	public int getMaxNextNo() {
		int result = 0;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			
			// 최대값을 구하는 함수에서 아무것도 없는경우에는 null이 반환된다.
			// 그래서 ifnull 함수를 통해서 0으로 제어해야한다.
			sql.append("SELECT ifnull(MAX(empno)+1, 1) FROM emp");
			
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				int index = 0;
				result = rs.getInt(++index);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
			
		}
		
		
		return result;
	}
	
	
	public boolean insert(EmpDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) ");
			sql.append("VALUES(?,?,?,?,CURDATE(),?,?,?) ");
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setInt(++index, dto.getNo());
			ps.setString(++index, dto.getName());
			ps.setString(++index, dto.getJob());
			ps.setInt(++index, dto.getMgr());
			
			ps.setInt(++index, dto.getSal());
			ps.setInt(++index, dto.getComm());
			ps.setInt(++index, dto.getDeptDto().getNo());
			
			ps.executeUpdate();
			
			isSuccess = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,null);
		}
		
		return isSuccess;
		
	}
	
	
	
	public boolean update(EmpDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE emp ");
			sql.append("SET ename =?, job = ?, mgr =?, sal =?, comm=?, deptno=? ");
			sql.append("WHERE empno = ? ");
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setString(++index, dto.getName());
			ps.setString(++index, dto.getJob());
			ps.setInt(++index, dto.getMgr());
			ps.setInt(++index, dto.getSal());
			
			ps.setInt(++index, dto.getComm());
			ps.setInt(++index, dto.getDeptDto().getNo());
			ps.setInt(++index, dto.getNo());
			
			ps.executeUpdate();
			
			isSuccess = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,null);
		}
		
		return isSuccess;
	}
	
	public boolean delete(int no) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM emp WHERE empno = ?");
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setInt(++index, no );
			
			ps.executeUpdate();
			
			isSuccess = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,null);
		}
		
		return isSuccess;
		
	}
	
	
}
