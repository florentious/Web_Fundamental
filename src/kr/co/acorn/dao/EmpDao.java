package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.EmpDto;
import kr.co.acorn.util.ConnLocator;

public class EmpDao {
	//singleton
	
	private static EmpDao single;
	private EmpDao() {
		
	}
	private static EmpDao getInstance() {
		if(single == null) {
			single = new EmpDao();
		}
		return single;
	}
	
	public ArrayList<EmpDto> select(int start, int end) {
		ArrayList<EmpDto> list = new ArrayList<EmpDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("Select empno, ename, job, mgr, hiredate FROM emp ORDER BY empno LIMIT ?,?");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setInt(++index, start);
			ps.setInt(++index, end);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				index = 0;
				list.add(new EmpDto(rs.getInt(++index), rs.getString(++index), rs.getString(++index), rs.getInt(++index), rs.getString(++index)));		
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			} catch(SQLException e) {
				
			}
		}
		
		
		return list;
		
	}
	
	
	public boolean insert(EmpDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES(?,?,?,?,?,?,?,?)");
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setInt(++index, dto.getNo());
			ps.setString(++index, dto.getName());
			ps.setString(++index, dto.getJob());
			ps.setInt(++index, dto.getMgr());
			ps.setString(++index, dto.getHireDate());
			ps.setInt(++index, dto.getSal());
			ps.setInt(++index, dto.getComm());
			ps.setInt(++index, dto.getDeptDto().getNo());
			
			ps.executeUpdate();
			
			
			
			
			isSuccess = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			} catch(SQLException e) {	
			}
		}
		
		return isSuccess;
		
	}
	
	
	
}
