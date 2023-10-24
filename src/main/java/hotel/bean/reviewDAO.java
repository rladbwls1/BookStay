package hotel.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import hotel.db.OracleDB;

public class reviewDAO extends OracleDB {
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	
	public List<reviewDTO> getReviewHotel(String hotelNum) {
	    List<reviewDTO> reviews = new ArrayList<>();

	    try {
	        conn = getConnection();
	        String sql = "SELECT * FROM review WHERE ref = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, hotelNum);

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            reviewDTO review = new reviewDTO();
	            review.setId(rs.getString("id"));
	            review.setContent(rs.getString("content"));
	            review.setReg(rs.getTimestamp("reg"));
	            review.setJumsu(rs.getInt("jumsu"));
	            reviews.add(review);
	        }
	    } catch (Exception e) {
	        e.printStackTrace(); // 에러 메시지 출력
	    } finally {
	        close(rs, pstmt, conn); // 데이터베이스 연결 및 리소스 닫기
	    }
	    return reviews;
	}

	
	 
	

}