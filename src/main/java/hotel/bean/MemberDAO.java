package hotel.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
                    dto.setHeart(rs.getString("heart"));
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            close(rs, pstmt, conn);
            return dto;
        }
    
    
    public int updateMember(MemberDTO member)    {
        int result= 0;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        
        conn = getConnection();
        try {
        String sql = "UPDATE member SET pw=?, email=?, birth=?, addr=?, pnum=? WHERE id=?";
              pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, member.getPw());
          pstmt.setString(2, member.getEmail());
          pstmt.setString(3, member.getBirth());
          pstmt.setString(4, member.getAddr());
          pstmt.setString(5, member.getPnum());
          pstmt.setString(6, member.getId());
     
          result = pstmt.executeUpdate();
        } catch(Exception e) {
            e.printStackTrace();
         }finally {
        	  close(rs, pstmt, conn);
		}
      
         return result;
      }
    
	public void updateHeart(String id,String heart) {
		try {
			conn=getConnection();
			String sql="update member set heart=? where id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, heart);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}	finally {
			close(rs, pstmt, conn);
		}
	}
	public ArrayList<hotelDTO> getHearts(String [] heart){
		ArrayList<hotelDTO> list = new ArrayList<hotelDTO>();
		try {
			if(heart==null) {return list;}
			conn=getConnection();
			for(int i=0; i<heart.length; i++) {
				String sql="select * from hotel where num=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(heart[i]));
				rs=pstmt.executeQuery();
				if(rs.next()) {
					hotelDTO dto = new hotelDTO();
					dto.setNum(rs.getInt("num"));
					dto.setImg(rs.getString("img"));
					dto.setTitle(rs.getString("title"));
					dto.setRef(rs.getInt("ref"));
					dto.setAprice(rs.getInt("aprice"));
					dto.setAddress(rs.getString("address"));
					list.add(dto);
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}return list;
			
		
	}
}
