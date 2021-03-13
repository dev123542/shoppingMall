package com.shoppingMall.order.vo;

import java.sql.Date;

public class OrderVO {
	
	private String order_no;		// 주문 번호 - int에서 string으로 타입 변환
	private String member_id;		// 회원 아이디
	private String member_add1;		// 우편 번호
	private String member_add2;		// 1차 주소
	private String member_add3;		// 2차 주소
	private String phone;			// 연락처
	private Date order_date;		// 주문일
	private int amount;				// 상품 총 수량
	private String orderRec;		// 수령인 이름 - 새로 추가
	private String order_msg;		// 배송 메세지 - 새로 추가
	private int total_goods_price;  // 상품 총 금액 - 새로 추가
	private String payment;			// 결제수단 : 무통장, 카드
	private String bank;			// 입금 은행
	private String status;			// 배송상태
	
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_add1() {
		return member_add1;
	}
	public void setMember_add1(String member_add1) {
		this.member_add1 = member_add1;
	}
	public String getMember_add2() {
		return member_add2;
	}
	public void setMember_add2(String member_add2) {
		this.member_add2 = member_add2;
	}
	public String getMember_add3() {
		return member_add3;
	}
	public void setMember_add3(String member_add3) {
		this.member_add3 = member_add3;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getOrderRec() {
		return orderRec;
	}
	public void setOrderRec(String orderRec) {
		this.orderRec = orderRec;
	}
	public String getOrder_msg() {
		return order_msg;
	}
	public void setOrder_msg(String order_msg) {
		this.order_msg = order_msg;
	}
	public int getTotal_goods_price() {
		return total_goods_price;
	}

	public void setTotal_goods_price(int total_goods_price) {
		this.total_goods_price = total_goods_price;
	}
	
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "OrderVO [order_no=" + order_no + ", member_id=" + member_id + ", member_add1=" + member_add1
				+ ", member_add2=" + member_add2 + ", member_add3=" + member_add3 + ", phone=" + phone + ", order_date="
				+ order_date + ", amount=" + amount + ", orderRec=" + orderRec + ", order_msg=" + order_msg
				+ ", total_goods_price=" + total_goods_price + ", payment=" + payment + ", bank=" + bank + ", status="
				+ status + "]";
	}
	
}