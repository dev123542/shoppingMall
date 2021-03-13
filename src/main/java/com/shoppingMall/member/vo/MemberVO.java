package com.shoppingMall.member.vo;

import java.sql.Date;

public class MemberVO {
	private String member_id;		// 아이디
	private String member_name;		// 이름
	private String pw;				// 비밀번호
	private String email;			// 이메일
	private String phone;			// 전화번호
	private Date member_credate;	// 가입일
	private int verify;				// 이메일 인증
	private String authority;		// 관리자 권한
	
	
	public MemberVO() {}
	public MemberVO(String member_id, String pw, String email, String phone) {
		super();
		this.member_id = member_id;
		this.pw = pw;
		this.email = email;
		this.phone = phone;
	}
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getMember_credate() {
		return member_credate;
	}
	public void setMember_credate(Date member_credate) {
		this.member_credate = member_credate;
	}
	public int getVerify() {
		return verify;
	}
	public void setVerify(int verify) {
		this.verify = verify;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	@Override
	public String toString() {
		return "MemberVO [member_id=" + member_id + ", member_name=" + member_name + ", pw=" + pw + ", email=" + email
				+ ", phone=" + phone + "]";
	}
	
	
}
