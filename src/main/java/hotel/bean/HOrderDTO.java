package hotel.bean;

import java.sql.Timestamp;

public class HOrderDTO {
	private int renum;
	private String id;
	private int num;
	private String checkin;
	private String checkout;
	private int adult;
	private int kid;
	private int state;
	private Timestamp reg;
	private String paytype;
	private int adultcount;
	private int kidcount;
	
	public int getAdultCount() {
		return adultcount;
	}
	public void setAdultCount(int adultCount) {
		this.adultcount = adultcount;
	}
	public int getKidCount() {
		return kidcount;
	}
	public void setKidCount(int kidCount) {
		this.kidcount = kidcount;
	}
	public int getRenum() {
		return renum;
	}
	public void setRenum(int renum) {
		this.renum = renum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	public int getAdult() {
		return adult;
	}
	public void setAdult(int adult) {
		this.adult = adult;
	}
	public int getKid() {
		return kid;
	}
	public void setKid(int kid) {
		this.kid = kid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getPaytype() {
		return paytype;
	}
	public void setPaytype(String paytype) {
		this.paytype = paytype;
	}



}
