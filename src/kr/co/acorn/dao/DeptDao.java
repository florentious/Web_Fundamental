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
	
	private void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if(rs!= null) rs.close();
			if(ps!= null) ps.close();
			if(con!= null) con.close();
		} catch (SQLException e) {
			// TODO: handle exception
		}
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
			close(con, ps, rs);
			
		}
		
		return list;
	}
	
	public int getTotalRows() {
		int rows = 0;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(deptno) FROM dept ");
			
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			int index = 0;
			if(rs.next()) {
				rows = rs.getInt(++index);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
			
		}

		return rows;
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
			
			int index = 0;
			ps.setInt(++index, no);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				index = 0;
				dto = new DeptDto(rs.getInt(++index), rs.getString(++index), rs.getString(++index));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
		
			close(con, ps, rs);
		}
		
		
		
		return dto;
	}
	
	public boolean insert(DeptDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO dept(deptno, dname, loc) VALUES(?,?,?)");
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setInt(++index, dto.getNo());
			ps.setString(++index, dto.getName());
			ps.setString(++index, dto.getLoc());
			
			ps.executeUpdate();
			
			isSuccess = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, null);
		}
		
		
		
		return isSuccess;
	}
	
	public boolean update(DeptDto dto, int curNo) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("UPDATE dept SET deptno = ?, dname = ?, loc = ? WHERE deptno = ?");
			
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setInt(++index, dto.getNo());
			ps.setString(++index, dto.getName());
			ps.setString(++index, dto.getLoc());
			ps.setInt(++index, curNo);
			
			ps.executeUpdate();
			
			isSuccess = true;
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, null);
		}
		
		
		return isSuccess;
	}
	
	public boolean delete(int curNo) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con=ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("DELETE FROM dept WHERE deptno = ?");
			
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setInt(++index, curNo);
			
			ps.executeUpdate();
			
			isSuccess=true;
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			close(con,ps,null);
		}
		
		
		
		return isSuccess;
		
	}
	

}
