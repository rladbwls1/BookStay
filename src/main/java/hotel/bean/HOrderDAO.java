package hotel.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hotel.db.OracleDB;

public class HOrderDAO extends OracleDB {
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	
	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
	    return instance;
	}
	
	public HOrderDTO getOrder(int renum) {
	    HOrderDTO order = new HOrderDTO();
	    String query = "select * from horder h,hotel r where h.ref=r.num and h.renum=?";
	    
	    try (Connection conn = getConnection(); // 새로운 데이터베이스 연결을 생성
	         PreparedStatement stmt = conn.prepareStatement(query)) {
	        stmt.setInt(1,renum);
	        try (ResultSet rs = stmt.executeQuery()) {
	            while (rs.next()) {
	                order.setRenum(rs.getInt("renum"));
	                order.setId(rs.getString("id"));
	                order.setName(rs.getString("name"));
	                order.setRoomtype(rs.getString("roomtype"));
	                order.setRef(rs.getInt("ref"));
	                order.setCheckin(rs.getString("checkin")); // 데이터베이스 컬럼 이름을 확인하고 수정
	                order.setCheckout(rs.getString("checkout"));
	                order.setAdult(rs.getInt("adult"));
	                order.setKid(rs.getInt("kid"));
	                order.setState(rs.getInt("state"));
	                order.setPrice(rs.getInt("price"));
	                order.setPaytype(rs.getString("paytype"));
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }finally {
			close(rs, pstmt, conn);
		}

	    return order;
	}
	
	
	
	public int getRecentOrder(String id) {
    	int result=0;
    	try {
			conn=getConnection();
			String sql="select * from horder where id=? order by reg desc";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt("renum");
			}
    		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}return result;
    }
    
    // 사용자의 주문 내역을 데이터베이스에서 읽어오는 메서드
	public List<HOrderDTO> getOrders(String id) { 
	    List<HOrderDTO> orders = new ArrayList<>();
	    String query = "SELECT * FROM horder WHERE id = ?";

	    try (Connection conn = getConnection(); // 새로운 데이터베이스 연결을 생성
	         PreparedStatement stmt = conn.prepareStatement(query)) {
	        stmt.setString(1, id);
	        try (ResultSet rs = stmt.executeQuery()) {
	            while (rs.next()) {
	                HOrderDTO order = new HOrderDTO();
	                order.setRenum(rs.getInt("renum"));
	                order.setId(rs.getString("id"));
	                order.setRef(rs.getInt("ref"));
	                order.setCheckin(rs.getString("checkin")); // 데이터베이스 컬럼 이름을 확인하고 수정
	                order.setCheckout(rs.getString("checkout"));
	                order.setAdult(rs.getInt("adult"));
	                order.setKid(rs.getInt("kid"));
	                order.setState(rs.getInt("state"));
	                order.setReg(rs.getTimestamp("reg"));
	                order.setPaytype(rs.getString("paytype"));
	                order.setAdult(rs.getInt("adult"));
	                order.setKid(rs.getInt("kid"));
	                orders.add(order);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
			close(rs, pstmt, conn);
		}

	    return orders;
	}
	
	public List<HOrderDTO> getOrdersAdmin(int start, int end) {
	    List<HOrderDTO> orders = new ArrayList<>();
	    String query = "select rownum,b.*,h.* from "
	    		+ " horder b,hotel h where "
	    		+ " b.ref=h.num and rownum>=? and rownum<=? and checkin <= to_char(sysdate,'YYYY-MM-DD') "
	    		+ " order by checkin";

	    try (Connection conn = getConnection();
	         PreparedStatement stmt = conn.prepareStatement(query);
	    		
	        ) {
	    	stmt.setInt(1, start);
			stmt.setInt(2, end);
			ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	            HOrderDTO order = new HOrderDTO();
	            order.setRenum(rs.getInt("renum"));
	            order.setId(rs.getString("id"));
	            order.setCheckin(rs.getString("checkin"));
	            order.setCheckout(rs.getString("checkout"));
	            order.setAdult(rs.getInt("adult"));
	            order.setKid(rs.getInt("kid"));
	            order.setRoomtype(rs.getString("roomtype"));
	            order.setPaytype(rs.getString("paytype"));
	            order.setReg(rs.getTimestamp("reg"));
	            order.setName(rs.getString("name"));
	            orders.add(order);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
  }finally {
			close(rs, pstmt, conn);
			
		}

	    return orders;
	}
	
	public List<HOrderDTO> getLastOrdersAdmin(int start, int end) {
	    List<HOrderDTO> orders = new ArrayList<>();
	    String query = "select rownum,b.*,h.* from "
	    		+ " horder b,hotel h where "
	    		+ " b.ref=h.num and rownum>=? and rownum<=? and checkin > to_char(sysdate,'YYYY-MM-DD') "
	    		+ " order by checkin";

	    try (Connection conn = getConnection();
	         PreparedStatement stmt = conn.prepareStatement(query);
	    		
	        ) {
	    	stmt.setInt(1, start);
			stmt.setInt(2, end);
			ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	            HOrderDTO order = new HOrderDTO();
	            order.setRenum(rs.getInt("renum"));
	            order.setId(rs.getString("id"));
	            order.setCheckin(rs.getString("checkin"));
	            order.setCheckout(rs.getString("checkout"));
	            order.setAdult(rs.getInt("adult"));
	            order.setRoomtype(rs.getString("roomtype"));
	            order.setKid(rs.getInt("kid"));
	            order.setPaytype(rs.getString("paytype"));
	            order.setReg(rs.getTimestamp("reg"));
	            order.setName(rs.getString("name"));
	            orders.add(order);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }finally {
			close(rs, pstmt, conn);
		}

	    return orders;
	}
	public int count(int num) {
		int result = 0;
		// num이 0일 때 현재 예약 내역
		conn = getConnection();
		String sql = "";
		if(num == 1) {
			sql = "select count(*) from "
					+ " horder b,hotel h where "
					+ " b.ref=h.num and checkin > to_char(sysdate,'YYYY-MM-DD')";
		}else {
			sql = "select count(*) from "
					+ "	horder b,hotel h where "
					+ "	b.ref=h.num and checkin <= to_char(sysdate,'YYYY-MM-DD')";
		}
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
		return result;
	}
	public int insertOrder(HOrderDTO order)throws Exception {
    	int result=0;
		try{			
			conn = getConnection();
			  
 	        String sql = "INSERT INTO horder (renum, id, ref, Checkin, Checkout, Adult, Kid, State, Reg, Paytype, name) VALUES "
 	        		+ " (horder_seq.nextval, ?, ?,to_date(?,'YYYY-MM-DD'), to_date(?,'YYYY-MM-DD'), ?, ?, 0, SYSDATE,?,?)";
 	        pstmt = conn.prepareStatement(sql);
 	        pstmt.setString(1, order.getId());
 	        pstmt.setInt(2, order.getRef());
 	        pstmt.setString(3, order.getCheckin());
 	        pstmt.setString(4, order.getCheckout());
 	        pstmt.setInt(5, order.getAdult());
 	        pstmt.setInt(6, order.getKid());
	        pstmt.setString(7, order.getPaytype());
	        pstmt.setString(8, order.getName());
	        result = pstmt.executeUpdate();
		}catch (Exception ex) {
   	        ex.printStackTrace();
   	    } finally {
   	     close(rs, pstmt, conn);
   	    }
		return result;
   	}
}