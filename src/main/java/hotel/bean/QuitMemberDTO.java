package hotel.bean;

import java.sql.Timestamp;

public class QuitMemberDTO {

		private String id;
		private String pw;
		private String name;
		private String email;
		private String birth;
		private String pnum;
		private String addr;
		private Timestamp joindate;


		public String getId() {
			return id;
		}
		public void setId(String id) {
			this.id = id;
		}
		public String getPw() {
			return pw;
		}
		public void setPw(String pw) {
			this.pw = pw;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getBirth() {
			return birth;
		}
		public void setBirth(String birth) {
			this.birth = birth;
		}
		public String getPnum() {
			return pnum;
		}
		public void setPnum(String pnum) {
			this.pnum = pnum;
		}
		public String getAddr() {
			return addr;
		}
		public void setAddr(String addr) {
			this.addr = addr;
		}
		

		public Timestamp getJoindate() {
			return joindate;
		}
		public void setJoindate(Timestamp joindate) {
			this.joindate = joindate;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}



}
