package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.BitcoinDto;
import kr.co.acorn.util.ConnLocator;

public class BitcoinDao {
	private static BitcoinDao single;
	private BitcoinDao() {
	}
	public static BitcoinDao getInstance() {
		if (single == null) {
			single = new BitcoinDao();
		}
		return single;
	}
	
	public boolean insert(BitcoinDto dto) {
		boolean isSuccess = false;
	
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO bitcoin(bitcoin_date ,bitcoin_open ,bitcoin_high ,bitcoin_low ,bitcoin_close ,bitcoin_volume ,bitcoin_marketCap) ");
			sql.append("VALUES(?,?,?,?,?,?,?)");
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setString(++index, dto.getDate());
			ps.setFloat(++index, dto.getOpen());
			ps.setFloat(++index, dto.getHigh());
			ps.setFloat(++index, dto.getLow());
			ps.setFloat(++index, dto.getClose());
			ps.setLong(++index, dto.getVolume());
			ps.setLong(++index, dto.getMarketCap());
			
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
	
	
	public ArrayList<BitcoinDto> select() {
		 ArrayList<BitcoinDto> list = new ArrayList<BitcoinDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT bitcoin_date ,bitcoin_open ,bitcoin_high ,bitcoin_low ,bitcoin_close ,bitcoin_volume ,bitcoin_marketCap ");
			sql.append("FROM bitcoin ");
			sql.append("ORDER BY bitcoin_date desc ");
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int index = 0;
				
				String date = rs.getString(++index);
				float open = rs.getFloat(++index);
				float high = rs.getFloat(++index);
				float low = rs.getFloat(++index);
				float close = rs.getFloat(++index);
				long volume = rs.getLong(++index);
				long marketCap = rs.getLong(++index);
				
				list.add(new BitcoinDto(date,open,high,low,close,volume,marketCap));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(con!=null) con.close();
			} catch(SQLException e) {
				
			}
			
		}
		
		return list;
		
	}
	
	public int getTotal() {
		int result = 0;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("SELECT COUNT(bitcoin_date) FROM bitcoin");
			
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
			try {
				if(rs!= null) rs.close();
				if(ps!= null) ps.close();
				if(con!= null) con.close();
			} catch (SQLException e) {
				// TODO: handle exception
			}
			
		}
		
		
		
		return result;
	}
	
	
}
