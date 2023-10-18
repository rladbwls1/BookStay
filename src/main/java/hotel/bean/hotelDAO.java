package hotel.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import hotel.db.OracleDB;

public class hotelDAO extends OracleDB{
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public ArrayList<hotelDTO> hotelList(int category, String type, String title, String checkin, String checkout, int adult, int kid){
		ArrayList<hotelDTO> list = new ArrayList<>();
		String sql="";
		
		conn = getConnection();
		if(category == 0) {
			sql = "select * from hotel where (title like ? or address like ?)";
			if(type == "all") {
				sql += " ";
			  } else if (type == "hotel") {
			    sql += " and type = '호텔'";
			  } else if (type == "resort") {
			    sql += " and type = '리조트'";
			  } else if (type == "motel") { 
			    sql += " and type = '모텔'";
			  } else if (type == "other") {
			    sql += " and type = '기타'";
			  }
			  sql += " and adultmax >= ? and kidmax >= ?";
		}else if(category == 1) {
			  sql = "select * from hotel where (title like ? or address like ?)";
			  if(type == "all") {
					sql += " ";
			  } else if (type == "hotel") {
			    sql += " and type = '호텔'";
			  } else if (type == "resort") {
			    sql += " and type = '리조트'";
			  } else if (type == "motel") { 
			    sql += " and type = '모텔'";
			  } else if (type == "other") {
			    sql += " and type = '기타'";
			  }
			  sql += " and adultmax >= ? and kidmax >= ? order by count desc";
		}else if(category == 2) {	
			sql = "select * from hotel where (title like ? or address like ?)"; 
			if(type == "all") {
				sql += " ";
			} else if (type == "hotel") {
				sql += " and type = '호텔'";
			} else if (type == "resort") {
			    sql += " and type = '리조트'";
	   	  	} else if (type == "motel") {
	   	  		sql += " and type = '모텔'";
			} else if (type == "other") {
				sql += " and type = '기타'";
			}  
			sql += " and adultmax >= ? and kidmax >= ? order by aprice desc";
		}else if(category == 3) {	
			sql = "select * from hotel where (title like ? or address like ?)"; 
			if(type == "all") {
				sql += " ";
			} else if (type == "hotel") {
				sql += " and type = '호텔'";
			} else if (type == "resort") {
			    sql += " and type = '리조트'";
	   	  	} else if (type == "motel") {
	   	  		sql += " and type = '모텔'";
			} else if (type == "other") {
				sql += " and type = '기타'";
			}  
			sql += " and adultmax >= ? and kidmax >= ? order by aprice asc";
		}else if(category == 4) {	
			sql = "select * from hotel where (title like ? or address like ?)"; 
			if(type == "all") {
				sql += " ";
			} else if (type == "hotel") {
				sql += " and type = '호텔'";
			} else if (type == "resort") {
			    sql += " and type = '리조트'";
	   	  	} else if (type == "motel") {
	   	  		sql += " and type = '모텔'";
			} else if (type == "other") {
				sql += " and type = '기타'";
			}  
			sql += " and adultmax >= ? and kidmax >= ? order by aprice  asc";
		}
		try {
			pstmt = conn.prepareStatement(sql);
			String query = "%" + title + "%";
			pstmt.setString(1, query);
			pstmt.setString(2, query);
			pstmt.setInt(3, adult);
			pstmt.setInt(4, kid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				hotelDTO dto = new hotelDTO();
				dto.setTitle(rs.getString("title"));
				dto.setAddress(rs.getString("address"));
				dto.setAprice(rs.getInt("aprice"));
				dto.setKprice(rs.getInt("kprice"));
				dto.setImg(rs.getString("img"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	}
	
	public ArrayList<hotelDTO> hothotel(String loc){
		ArrayList<hotelDTO> list = new ArrayList<>();
		conn = getConnection();
		try {
			String sql = "select * from "
					+ " (select * from hotel where address like ? order by count desc) "
					+ " where rownum <= 9";
			pstmt = conn.prepareStatement(sql);
			String query = "%" + loc + "%";
			pstmt.setString(1, query);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				hotelDTO dto = new hotelDTO();
				dto.setImg(rs.getString("img"));
				dto.setTitle(rs.getString("title"));
				dto.setKprice(rs.getInt("kprice"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
		
	}
	
	public int count(String title, String checkin, String checkout, int adult, int kid) {
		conn = getConnection();
		int result = 0;
		try {
			String sql = "select count(*) from hotel "
					+ " where title like ? or address like ? and "
					+ "	adultmax >= ? and kidmax >= ?";
			pstmt = conn.prepareStatement(sql);
			String query = "%" + title + "%";
			pstmt.setString(1, query);
			pstmt.setString(2, query);
			pstmt.setInt(3, adult);
			pstmt.setInt(4, kid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return result;
	}
}
