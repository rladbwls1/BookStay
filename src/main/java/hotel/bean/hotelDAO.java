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
	public void hotelMainInsert(hotelDTO dto) {
			int maxnum=0;
		try {
			conn=getConnection();
			
			String sql="insert into hotel(num,type,title,content,contactfax,contact,service,aprice,kprice,address,img,ref,re_step) "
						+ " values(hotel_seq.nextval,?,?,?,?,?,?,0,0,?,?,hotel_seq.currval,0)";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getType());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getContactfax());
			pstmt.setString(5, dto.getContact());
			pstmt.setString(6, dto.getService());
			pstmt.setString(7, dto.getAddress());
			pstmt.setString(8, dto.getImg());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	public hotelDTO getContentMain(int num) {
		hotelDTO dto= new hotelDTO();
		try {
			conn=getConnection();
			String sql="select * from hotel where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setAddress(rs.getString("address"));
				dto.setTitle(rs.getString("title"));
				dto.setImg(rs.getString("img"));
				dto.setService(rs.getString("service"));
				dto.setContact(rs.getString("contact"));
				dto.setContactfax(rs.getString("contactfax"));
				dto.setAdultmax(rs.getInt("adultmax"));
				dto.setAprice(rs.getInt("aprice"));
				dto.setContent(rs.getString("content"));
				dto.setCount(rs.getInt("count"));
				dto.setKidmax(rs.getInt("kidmax"));
				dto.setKprice(rs.getInt("kprice"));
				dto.setNum(num);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		} return dto;
	}
	public void hotelContentInsert(hotelDTO dto) {
		try {
			conn=getConnection();
			String sql="insert into hotel(num,type,title,content,contactfax,contact,aprice,kprice,address,img,ref,re_step,roomtype) "
					+ " values(hotel_seq.nextval,?,?,?,?,?,?,?,?,?,?,1,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getType());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getContactfax());
			pstmt.setString(5, dto.getContact());
			pstmt.setInt(6, dto.getAprice());
			pstmt.setInt(7, dto.getKprice());
			pstmt.setString(8, dto.getAddress());
			pstmt.setString(9, dto.getImg());
			pstmt.setInt(10, dto.getRef());
			pstmt.setString(11, dto.getRoomtype());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	public ArrayList<hotelDTO> getContent(int num) {
		ArrayList<hotelDTO> list = new ArrayList<hotelDTO>();
		try {
			String sql="select * from hotel where ref=? and re_step=1";
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				hotelDTO dto= new hotelDTO();
				dto.setNum(rs.getInt("num"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setImg(rs.getString("img"));
				dto.setAprice(rs.getInt("aprice"));
				dto.setKprice(rs.getInt("kprice"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		} return list;
	}
	public void priceUpdate(int num) {
		int min=0;
		try {
			conn=getConnection();
			String sql="select min(aprice) from hotel where ref=? and re_step=1";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				min=rs.getInt(1);
			}
			sql="update hotel aprice=? where num=? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, min);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	public void updateContent(hotelDTO dto) {
		try {
			conn=getConnection();
			if(dto.getRe_step()==0) {
			String sql="update hotel set title=?,content=?,contact=?,contactfax=?,img=? where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getContact());
			pstmt.setString(4, dto.getContactfax());
			pstmt.setString(5, dto.getImg());
			pstmt.setInt(6, dto.getNum());
			pstmt.executeUpdate();
			}else {
			String sql="update hotel set title=?,content=?,roomtype=?,aprice=?,kprice=?,img=? where num=?";	
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getRoomtype());
			pstmt.setInt(4, dto.getAprice());
			pstmt.setInt(5, dto.getKprice());
			pstmt.setString(6, dto.getImg());
			pstmt.setInt(7, dto.getNum());
			pstmt.executeUpdate();
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	public void deleteHotel(int num,int re_step) {
		try {
			conn=getConnection();
			String sql="";
			if(re_step==1) {
				sql="delete from hotel where num=?";
			}else {
				sql="delete from hotel where ref=?";
			}
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
	}
	public ArrayList<hotelDTO> HotelBlock(String chkin, String chkout) {
		ArrayList<hotelDTO> list = new ArrayList<>();
		conn = getConnection();
		try {
			String sql = "select * "
					+ " from horder "
					+ "where (checkin < to_date(?) AND checkout > to_date(?))";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, chkout);
			pstmt.setString(2, chkin);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				hotelDTO dto = new hotelDTO();
				dto.setRef(rs.getInt("ref"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return list;
	} public ArrayList<hotelDTO> test(){
		ArrayList<hotelDTO> list = new ArrayList<hotelDTO>();
		try {
			conn=getConnection();
			String sql="select * from hotel";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				hotelDTO dto = new hotelDTO();
				dto.setAddress(rs.getString("address"));
				dto.setTitle(rs.getString("title"));
				dto.setImg(rs.getString("img"));
				dto.setAprice(rs.getInt("aprice"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setNum(rs.getInt("num"));
				dto.setRef(rs.getInt("ref"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}return list;
		
	}
}
