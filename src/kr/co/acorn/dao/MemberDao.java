package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.MemberDto;
import kr.co.acorn.util.ConnLocator;

public class MemberDao {
	private static MemberDao single;

	private MemberDao() {

	}

	public static MemberDao getInstance() {
		if (single == null) {
			single = new MemberDao();
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
	
	public boolean isEmail(String email) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("SELECT m_email ");
			sql.append("FROM member ");
			sql.append("WHERE m_email = ?");
			
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setString(++index, email);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				// next가 있는거 자체로 이 if문에 들어오기 때문에
				isSuccess = true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
			
		}
		
		return isSuccess;
	}
	
	public boolean isCorrect(String email, String password) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(m_email) FROM member WHERE m_email = ? AND m_pwd = PASSWORD(?) ");
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setString(++index, email);
			ps.setString(++index, password);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				index = 0;
				int count = rs.getInt(++index);
				if(count != 0) {
					isSuccess = true;
				}
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
		}
		
		return isSuccess;
	}
	
	public int getTotalRows() {
		int totalRows = 0;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("SELECT COUNT(m_email) FROM member");
			
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
			close(con,ps,rs);
			
		}
		
		return totalRows;
	}
	
	public MemberDto select(String email) {
		MemberDto dto = null;

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("SELECT m_email,m_name,m_phone,m_regdate FROM member WHERE m_email = ?");

			ps = con.prepareStatement(sql.toString());

			int index = 0;
			ps.setString(++index, email);

			rs = ps.executeQuery();

			if (rs.next()) {
				index = 0;
				
				String mEmail = rs.getString(++index);
				String name = rs.getString(++index);
				String phone = rs.getString(++index);
				String regDate = rs.getString(++index);
				
				dto = new MemberDto(mEmail,name,null,phone,regDate);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);

		}

		return dto;
	}
	
	
	public ArrayList<MemberDto> select(int start, int len) {
		ArrayList<MemberDto> list = new ArrayList<MemberDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT m_email, m_name, m_phone, m_regdate ");
			sql.append("FROM member ");
			sql.append("ORDER BY m_regdate DESC ");
			sql.append("LIMIT ?,?");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setInt(++index, start);
			ps.setInt(++index, len);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				index = 0;
				
				String email = rs.getString(++index);
				String name = rs.getString(++index);
				String phone = rs.getString(++index);
				String regDate = rs.getString(++index);
								
				list.add(new MemberDto(email,name,null,phone,regDate));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
			
		}
		
		return list;
	}
	
	
	public boolean insert(MemberDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO member(m_email, m_name, m_pwd, m_phone, m_regdate) VALUES(?,?,PASSWORD(?),?,now())");
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setString(++index, dto.getEmail());
			ps.setString(++index, dto.getName());
			ps.setString(++index, dto.getPwd());
			ps.setString(++index, dto.getPhone());
			
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
	
	
	public boolean delete(String email) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM member WHERE m_email = ?");
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setString(++index, email);
			
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
	
	public boolean update(MemberDto dto, String email, boolean isChangePwd) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			// 비밀번호 변경을 하지 않을 경우
			if(isChangePwd) {
				sql.append("UPDATE member SET m_email =?, m_name =?, m_pwd = PASSWORD(?), m_phone = ? WHERE m_email = ?");				
				ps = con.prepareStatement(sql.toString());
				
				int index=0;
				ps.setString(++index, dto.getEmail());
				ps.setString(++index, dto.getName());
				ps.setString(++index, dto.getPwd());
				ps.setString(++index, dto.getPhone());
				ps.setString(++index, email);
			} else {
				sql.append("UPDATE member SET m_email =?, m_name =?, m_phone = ? WHERE m_email = ?");
				ps = con.prepareStatement(sql.toString());
				
				int index=0;
				ps.setString(++index, dto.getEmail());
				ps.setString(++index, dto.getName());
				ps.setString(++index, dto.getPhone());
				ps.setString(++index, email);
			}
			
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
