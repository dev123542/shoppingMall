package com.shoppingMall.order.vo;

import java.sql.Date;

public class OrderListVO {  // s_order, s_order_details, s_product 테이블 조인
	
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
	private int total_goods_price;  // 상품 종 금액
	
	private int order_details_no;	// 주문상세번호
	private int product_no;			// 상품 번호
	private int cartStock;			//
	
	private String product_name;	// 상품명
	private String product_image;	// 상품이미지 - main_image
	private int origin_price;	    // 상품 금액
	
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
	public int getOrder_details_no() {
		return order_details_no;
	}
	public void setOrder_details_no(int order_details_no) {
		this.order_details_no = order_details_no;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public int getCartStock() {
		return cartStock;
	}
	public void setCartStock(int cartStock) {
		this.cartStock = cartStock;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	public int getOrigin_price() {
		return origin_price;
	}
	public void setOrigin_price(int origin_price) {
		this.origin_price = origin_price;
	}
	
	@Override
	public String toString() {
		return "OrderListVO [order_no=" + order_no + ", member_id=" + member_id + ", member_add1=" + member_add1
				+ ", member_add2=" + member_add2 + ", member_add3=" + member_add3 + ", phone=" + phone + ", order_date="
				+ order_date + ", amount=" + amount + ", orderRec=" + orderRec + ", order_msg=" + order_msg
				+ ", total_goods_price=" + total_goods_price + ", order_details_no=" + order_details_no
				+ ", product_no=" + product_no + ", cartStock=" + cartStock + ", product_name=" + product_name
				+ ", product_image=" + product_image + ", origin_price=" + origin_price + "]";
	}
	
}
