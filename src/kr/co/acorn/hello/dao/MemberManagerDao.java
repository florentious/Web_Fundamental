package kr.co.acorn.hello.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.hello.dto.MemberManagerDto;
import kr.co.acorn.util.ConnLocator;

public class MemberManagerDao {
	// singleton - use only 1 object
	private static MemberManagerDao single;
	private MemberManagerDao() {
		
	}
	public static MemberManagerDao getInstance() {
		if(single == null) {
			single = new MemberManagerDao();
		}
		return single;
	}
	
	public boolean insert(MemberManagerDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO memberManager(member_id, member_name) VALUES(?,?)");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setString(++index, dto.getId());
			ps.setString(++index, dto.getName());
			
			ps.executeUpdate();
			
			isSuccess = true;	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(ps != null) ps.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		return isSuccess;		
	}
	
	public boolean update(MemberManagerDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE memberManager SET member_name = ? WHERE member_id = ?");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setString(++index, dto.getName());
			ps.setString(++index, dto.getId());
			
			ps.executeUpdate();
			
			isSuccess = true;	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(ps != null) ps.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		return isSuccess;		
	}
	
	public boolean delete(String id) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM memberManager WHERE member_id = ?");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setString(++index, id);			
			
			ps.executeUpdate();
			
			isSuccess = true;	
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(ps != null) ps.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
		return isSuccess;		
	}
	
	public boolean select() {
		boolean isSuccess = false;
		
		ArrayList<MemberManagerDto> list = new ArrayList<MemberManagerDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT member_id, member_name FROM memberManager ORDER BY member_id");
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int index = 0;
				list.add(new MemberManagerDto(rs.getString(++index),rs.getString(++index)));
			}
			
			isSuccess = true;	
			
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
		
		return isSuccess;		
	}
	
	public boolean select(String id) {
		boolean isSuccess = false;
		
		MemberManagerDto dto = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT member_id, member_name FROM memberManager ORDER BY member_id");
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				int index = 0;
				dto = new MemberManagerDto(rs.getString(++index),rs.getString(++index));
			}
			
			isSuccess = true;	
			
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
		
		return isSuccess;		
	}
	
	
	
}
