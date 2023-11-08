package hotel.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hotel.db.OracleDB;

public class MemberDAO extends  OracleDB {
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	
	
	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
	    return instance;
	}
	
		
			//아이디중복체크
	// 아이디 중복 체크
	public boolean loginCheck(MemberDTO dto) {
	    boolean result = false;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = getConnection();
	        String sql = "SELECT * FROM member WHERE id=? AND pw=?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, dto.getId());
	        pstmt.setString(2, dto.getPw());
	        
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            result = true;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        // 예외 처리 로직 추가
	    } finally {
	        // 연결 및 리소스 관리
	        close(rs, pstmt, conn);
	    }

	    return result;
	}
            
		

	
	 // 이름 이메일을 ,휴대폰번호를  이용해서 비밀번호찾기   -20231027 도준
	    public boolean findPW(String id, String name, String email, String pnum) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        boolean result = false;
	        try {
	            conn = getConnection();
	            String sql = "select *from member where name= ? and email= ? and pnum=?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, name);
	            pstmt.setString(2, email);
	            pstmt.setString(3, pnum);
	            rs = pstmt.executeQuery();
	            if (rs.next()) {
	                result = true; // 사용자 정보가 일치하는 경우
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            close(rs, pstmt, conn);
	        }
	        return result;
	    }

	    
	    
		 // 이름 ,이메일을 ,휴대폰번호를  이용해서 아이디찾기   -20231027 도준
	    public String findId(String name, String email, String pnum) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String result = "";
	        try {
	            conn = getConnection();
	            String sql = "SELECT id FROM member WHERE name=? AND email=? AND pnum=?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, name);
	            pstmt.setString(2, email);
	            pstmt.setString(3, pnum);
	            rs = pstmt.executeQuery();
	            if (rs.next()) {
	                result = rs.getString("id"); // 사용자 정보가 모두 일치하는 경우
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            close(rs, pstmt, conn);
	        }
	        return result;
	    }
	    
	    //2023 11 06 도준 생성  조회  > 인서트  > 딜리트 한번에함   :  타테이블에 이관하고 삭제하는 메서드  
	       public boolean transferMemberData(String id, String pw) {
	           Connection conn = null;
	           PreparedStatement pstmt = null;

	           try {
	               conn = getConnection();

	               // 1. 아이디와 비밀번호로 회원 정보 조회 (예: member 테이블)
	               String selectQuery = "SELECT id, pw, name, email, birth, addr, pnum, joindate FROM member WHERE id = ? AND pw = ?";
	               pstmt = conn.prepareStatement(selectQuery);
	               pstmt.setString(1, id);
	               pstmt.setString(2, pw);
	               ResultSet rs = pstmt.executeQuery();

	               if (rs.next()) {
	                   // 2. 조회한 정보로 다른 테이블에 인서트 (예: quitmember 테이블)
	                   String insertQuery = "INSERT INTO quitmember (id, pw, name, email, birth, addr, pnum, joindate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	                   pstmt = conn.prepareStatement(insertQuery);
	                   pstmt.setString(1, rs.getString("id"));
	                   pstmt.setString(2, rs.getString("pw"));
	                   pstmt.setString(3, rs.getString("name"));
	                   pstmt.setString(4, rs.getString("email"));
	                   pstmt.setDate(5, rs.getDate("birth"));
	                   pstmt.setString(6, rs.getString("addr"));
	                   pstmt.setString(7, rs.getString("pnum"));
	                   pstmt.setDate(8, rs.getDate("joindate"));
	                   pstmt.executeUpdate();

	                   // 3. 원래 테이블에서 삭제 (예: member 테이블)
	                   String deleteQuery = "DELETE FROM member WHERE id = ? AND pw = ?";
	                   pstmt = conn.prepareStatement(deleteQuery);
	                   pstmt.setString(1, id);
	                   pstmt.setString(2, pw);
	                   pstmt.executeUpdate();

	                   return true;
	               }
	           } catch (SQLException e) {
	               e.printStackTrace();
	           } finally {
	               // 리소스 정리
	               if (pstmt != null) {
	                   try {
	                       pstmt.close();
	                   } catch (SQLException e) {
	                       e.printStackTrace();
	                   }
	               }
	               if (conn != null) {
	                   try {
	                       conn.close();
	                   } catch (SQLException e) {
	                       e.printStackTrace();
	                   }
	               }
	           }

	           return false;
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
	   	    }}
		

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
                    dto.setGrade(rs.getInt("grade"));
                    dto.setJoindate(rs.getTimestamp("joindate"));
                    
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            close(rs, pstmt, conn);
            return dto;
        }
    
    //찐 업데이트 수정 메서드 
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
					dto.setPrice(rs.getInt("price"));
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
	
	public ArrayList<String> getAllHeart(){
		ArrayList<String> list = new ArrayList<String>();
		try {
			String sql="select heart from member";
			conn=getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}return list;
	}
	public void allupdateHeart() {
		ArrayList<hotelDTO> hlist = new hotelDAO().getAllMain();
		ArrayList<String> list=getAllHeart();
		int heartCount=0;
		try {
			conn=getConnection();
			for(hotelDTO dto : hlist) {// 전체숙박업소 정보
				String check = Integer.toString(dto.getNum());//숙박업소 게시글번호
					for(String s:list) {						//회원정보 모든 찜목록 정보
						if(s==null||s.length()<1) {		
						}
						else if(s.contains(check)) {
							heartCount+=1;
						}
						pstmt=conn.prepareStatement("update hotel set heartcount=? where num=?");
						pstmt.setInt(1, heartCount);
						pstmt.setInt(2, dto.getNum());
						pstmt.executeUpdate();
						
					}
					heartCount=0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rs, pstmt, conn);
		}
	}
	
	public void updateHeartCount(int num) {
		int heartCount=0;
		String check=Integer.toString(num);
		ArrayList<String> list = getAllHeart();
		try {
			for(String s : list) {
				if(s==null||s.length()<1) {
				}
				else if(s.contains(check)) {
					heartCount+=1;
				}
			}
		conn=getConnection();
		String sql = "update hotel set heartcount=? where num=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, heartCount);
		pstmt.setInt(2, num);
		pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, conn);
		}
		
		
	}
	
		 
	    public List<hotelDTO> heartList(String id) throws Exception {
	    	List<hotelDTO> heartList = new ArrayList<>();
	    	Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        try {
	            conn = getConnection();

	            // 아래의 SQL 쿼리는 'some_value' 대신에 로그인한 사용자의 ID를 사용하여 해당 사용자가 찜한 상품을 가져옵니다.
	            pstmt = conn.prepareStatement(
	                "SELECT h.*, m.* FROM hotel h " +
	                "INNER JOIN member m ON h.member_id = m.member_id " +
	                "WHERE m.id = ?"
	                /*
	                  "hotel" 테이블과 "member" 테이블을 연결하고, 
	                 특정 "member"의 "id" 값과 일치하는 "hotel" 행을 검색하는기능
	                 * */
	            );
	            pstmt.setString(1, id);

	            rs = pstmt.executeQuery();

	            while (rs.next()) {
	                hotelDTO hotel = new hotelDTO();
	                // HotelDTO에 데이터를 매핑
	                hotel.setNum(rs.getInt("num"));
	                hotel.setType(rs.getString("type"));
	                hotel.setTitle(rs.getString("title"));
	                hotel.setContent(rs.getString("content"));
	                hotel.setContactfax(rs.getString("contactfax"));
	                hotel.setContact(rs.getString("contact"));
	                hotel.setService(rs.getString("service"));
	                hotel.setPrice(rs.getInt("price"));
	                hotel.setAddress(rs.getString("address"));
	                hotel.setImg(rs.getString("img"));
	                hotel.setRef(rs.getInt("ref"));
	                hotel.setRe_step(rs.getInt("re_step"));
	                hotel.setRoomtype(rs.getString("roomtype"));
	                hotel.setAdultmax(rs.getInt("adultmax"));
	                hotel.setKidmax(rs.getInt("kidmax"));
	                hotel.setCount(rs.getInt("count"));

	                // HotelDTO를 리스트에 추가
	                heartList.add(hotel);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            close(rs, pstmt, conn);
	        }

	        return heartList;
	    }
	    
		//찜하기 메서드 
		public void addrUpdateHeart(String id, String num)   {
			
		        Connection conn = null;
		        PreparedStatement pstmt = null;
		        ResultSet rs = null;
		        conn = getConnection();
		    
		        try {
		        String sql = "UPDATE member SET heart=?  WHERE id=?";
		              pstmt = conn.prepareStatement(sql);
		          pstmt.setString(1,num);   //heart에는 num값이 들어가기때문에    
		          pstmt.setString(2,id);
		     
		         pstmt.executeUpdate();
		        } catch(Exception e) {
		            e.printStackTrace();
		         }finally {
		        	  close(rs, pstmt, conn);
		         }
		        }
		
		
			

		
	    	//찜목록 조회 커밋 날짜 : 2023 10 26 만드는중 
	 
	    public void MemberHeartList(hotelDTO dto)throws Exception {

		        Connection conn = null;
		        PreparedStatement ps = null;
		    
		        rs = pstmt.executeQuery();
		        ResultSet rs = null;

		        conn = getConnection();

		        try {
		            String sql = "SELECT num, title, img FROM hotel";
		            pstmt = conn.prepareStatement(sql);
		            
		            // 쿼리 실행
		            rs = pstmt.executeQuery();
		            
		            // 나머지 코드
		            while (rs.next()) {
		                String num = rs.getString("num");
		                String title = rs.getString("title");
		                String img = rs.getString("img");
		                // 나머지 표시 코드
		            }
		        } catch (Exception ex) {
		            ex.printStackTrace();
		        } finally {
		            close(rs, pstmt, conn);
		        }
			
	
	    }
	    public int checkGrade(String id) {
			int grade = 11;
			try {
				conn=getConnection();
				String sql = "select grade from member where id=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					grade=rs.getInt(1);
				}
				System.out.println(grade);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			} return grade;
		}
	    public void checkHuman() {
	    	try {
				conn=getConnection();
				String sql="update member set grade=81 where lastlogin<(select add_months(to_date(sysdate,'yyyy-MM-DD'),-3) pre_month from dual)";
				pstmt=conn.prepareStatement(sql);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
	    }
	    public void humanRelease(String id) {
	    	try {
				conn=getConnection();
				String sql="update member set grade=0 where id=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(rs, pstmt, conn);
			}
	    }
	    public int insertquitMember(QuitMemberDTO quitmember) {
	        Connection conn = null;
	        int result = 0;
	        try {
	            conn = getConnection();
	            String sql = "INSERT INTO quitmember (id, pw, name, email, birth, addr, pnum, joindate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	                pstmt.setString(1, quitmember.getId());
	                pstmt.setString(2, quitmember.getPw());
	                pstmt.setString(3, quitmember.getName());
	                pstmt.setString(4, quitmember.getEmail());
	                pstmt.setString(5, quitmember.getBirth());
	                pstmt.setString(6, quitmember.getAddr());
	                pstmt.setString(7, quitmember.getPnum());
	                pstmt.setString(8, quitmember.getJoindate());
	                result = pstmt.executeUpdate();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            result = -1; // 실패한 경우 -1을 반환
	        } finally {
	            // Connection 및 리소스 관련 처리
	        }
	        return result;
	    }

}