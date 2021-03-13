package com.shoppingMall.cart.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("cartVO")
public class CartVO {
	
	private String member_id;	// 회원아이디
	private int product_no;		// 상품번호
	private int cart_goods_qty;	// 수량
	private Date cart_date;		// 장바구니날짜
	private int origin_price;	// 원가
	private int sale_price;		// 할인가
	private int cart_no;		// 장바구니번호
	
	public CartVO() {}

	public CartVO(String member_id, int product_no, int cart_goods_qty, Date cart_date, int origin_price, int sale_price,
			int cart_no) {
		super();
		this.member_id = member_id;
		this.product_no = product_no;
		this.cart_goods_qty = cart_goods_qty;
		this.cart_date = cart_date;
		this.origin_price = origin_price;
		this.sale_price = sale_price;
		this.cart_no = cart_no;
	}


	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getProduct_no() {
		return product_no;
	}

	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}

	public int getCart_goods_qty() {
		return cart_goods_qty;
	}

	public void setCart_goods_qty(int cart_goods_qty) {
		this.cart_goods_qty = cart_goods_qty;
	}

	public Date getCart_date() {
		return cart_date;
	}

	public void setCart_date(Date cart_date) {
		this.cart_date = cart_date;
	}

	public int getOrigin_price() {
		return origin_price;
	}

	public void setOrigin_price(int origin_price) {
		this.origin_price = origin_price;
	}

	public int getSale_price() {
		return sale_price;
	}

	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
	}

	public int getCart_no() {
		return cart_no;
	}

	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}


	@Override
	public String toString() {
		return "CartVO [member_id=" + member_id + ", product_no=" + product_no + ", cart_goods_qty=" + cart_goods_qty + ", cart_date="
				+ cart_date + ", origin_price=" + origin_price + ", sale_price=" + sale_price + ", cart_no=" + cart_no
				+ "]";
	}


}
