package hotel.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import hotel.db.OracleDB;

public class MemberDAO extends  OracleDB {
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	
	
	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
	    return instance;
	}
	
	public int delete(String id, String pw) {
	    int result = 0;
	    
	    try (Connection conn = getConnection();
	         PreparedStatement pstmt = conn.prepareStatement("delete from member where id=? and pw=?")) {
	        pstmt.setString(1, id);
	        pstmt.setString(2, pw);
	        
	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace(); // 또는 다른 오류 처리 방법을 고려합니다.
	    }
	    
	    return result;
	}




	    public boolean loginCheck(MemberDTO dto) {
	        boolean result = false;
	        conn = getConnection();
	        try {
	            String sql = "select * from member where id=? and pw=?";
	            pstmt = conn.prepareStatement(sql);

	           	pstmt.setString(1,dto.getId());
	 		   	pstmt.setString(2,dto.getPw());

	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	                result = true;
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        close(rs, pstmt, conn);
	        return result;
	    }
	
	public void insertMember(MemberDTO member)throws Exception {
		try{			
			  conn = getConnection();
			  
 	        String sql = "INSERT INTO member (id, pw, name, email, birth, addr, pnum) VALUES "
 	        		+ "(?, ?, ?, ?, ?, ?, ?)";
 	        
 	        pstmt = conn.prepareStatement(sql);
 	        
 	        pstmt.setString(1, member.getId());
 	        pstmt.setString(2, member.getPw());
 	        pstmt.setString(3, member.getName());
 	        pstmt.setString(4, member.getEmail());
 	        pstmt.setString(5, member.getBirth());
 	        pstmt.setString(6, member.getAddr());
 	        pstmt.setString(7, member.getPnum());


 	        pstmt.executeUpdate();
				
				
			
		}catch (Exception ex) {
   	        ex.printStackTrace();
   	    } finally {
   	     close(rs, pstmt, conn);
   	    }
   	}
	
    public int confirmId(String id) throws Exception {
        int x = -1;
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement("SELECT id FROM member WHERE id = ?")) {
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                x = 1; // 해당 아이디 있음
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
      	     close(rs, pstmt, conn);
      	    }
        
        return x;
    }

    public MemberDTO myInfo(String id) {
        MemberDTO dto = new MemberDTO();
            conn = getConnection();
            try {
                String sql = "select * from member where id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, id);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    dto.setId(rs.getString("id"));
                    dto.setPw(rs.getString("pw"));
                    dto.setName(rs.getString("name"));
                    dto.setEmail(rs.getString("email"));
                    dto.setBirth(rs.getString("birth"));
                    dto.setAddr(rs.getString("addr"));
                    dto.setPnum(rs.getString("pnum"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            close(rs, pstmt, conn);
            return dto;
        }
    
    public MemberDTO getMember(String id) throws Exception {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MemberDTO mb = null;

        try {
            conn = getConnection();
            pstmt = conn.prepareStatement("SELECT * FROM Membership WHERE id = ?");
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                mb = new MemberDTO();
                mb.setId(rs.getString("id"));
                mb.setPw(rs.getString("pw"));
                mb.setName(rs.getString("name"));
                mb.setEmail(rs.getString("email"));
                mb.setBirth(rs.getString("birth"));
                mb.setAddr(rs.getString("addr"));
                mb.setPnum(rs.getString("pnum"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 또는 로그에 더 자세한 오류 메시지를 기록할 수 있습니다.
            throw new Exception("데이터베이스에서 사용자 정보를 가져오는 중 오류 발생: " + e.getMessage());
        } finally {
            // 리소스 해제
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        }

        return mb;
    }
    
    public boolean updateMember(MemberDTO member) {
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE member SET name=?, email=?, addr=?, pnum=? WHERE id=?")) {
            pstmt.setString(1, member.getName());
            pstmt.setString(2, member.getEmail());
            pstmt.setString(3, member.getAddr());
            pstmt.setString(4, member.getPnum());
            pstmt.setString(5, member.getId());

            int rowsUpdated = pstmt.executeUpdate();

            return rowsUpdated > 0; // 반환값으로 업데이트 성공 여부를 알릴 수 있음
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
