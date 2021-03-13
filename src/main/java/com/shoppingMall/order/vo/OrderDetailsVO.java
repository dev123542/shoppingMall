package com.shoppingMall.order.vo;

public class OrderDetailsVO {

	private int order_details_no;	// 주문상세번호
	private String order_no;		// 주문 번호
	private int product_no;			// 상품 번호
	private int cartStock;			//
	
	public int getOrder_details_no() {
		return order_details_no;
	}
	public void setOrder_details_no(int order_details_no) {
		this.order_details_no = order_details_no;
	}
	public String getOrder_no() {
		return order_no;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
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
	
	@Override
	public String toString() {
		return "OrderDetailsVO [order_details_no=" + order_details_no + ", order_no=" + order_no + ", product_no="
				+ product_no + ", cartStock=" + cartStock + "]";
	}
	
}
