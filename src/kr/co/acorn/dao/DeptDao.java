package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.DeptDto;
import kr.co.acorn.util.ConnLocator;

public class DeptDao {
	//singleton pattern
	
	private static DeptDao single;
	private DeptDao() {
		
	}
	public static DeptDao getInstance() {
		if(single == null) {
			single = new DeptDao();
		}
		return single;
	}
	
	public ArrayList<DeptDto> select(int start, int len) {
		ArrayList<DeptDto> list = new ArrayList<DeptDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT deptno, dname, loc FROM dept ORDER BY deptno LIMIT ?,?");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setInt(++index, start);
			ps.setInt(++index, len);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				index = 0;
				list.add(new DeptDto(rs.getInt(++index), rs.getString(++index), rs.getString(++index)));
				/*
				int no = rs.getInt(++index);
				String name = rs.getString(++index);
				String loc = rs.getString(++index);
				list.add(new DeptDto(no,name,loc));
				*/
				
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(ps != null) ps.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
		}
		
		return list;
	}
	
	public DeptDto select(int no) {
		DeptDto dto = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("SELECT deptno, dname, loc FROM dept WHERE deptno = ?");
			
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				int index = 0;
				dto = new DeptDto(rs.getInt(++index), rs.getString(++index), rs.getString(++index));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs!= null) rs.close();
				if(ps!= null) ps.close();
				if(con!= null) con.close();
			} catch (SQLException e) {
				// TODO: handle exception
			}
		}
		
		
		
		return dto;
	}
	

}
