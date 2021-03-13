package com.shoppingMall.product.vo;

public class ProductDetailVO {
	
	private int product_detail_no;
	private int product_no;
	private String product_color;
	private String cate_parent;		// 대분류 번호
	private String cate_name;		// 소분류 이름
	
	public int getProduct_detail_no() {
		return product_detail_no;
	}
	public void setProduct_detail_no(int product_detail_no) {
		this.product_detail_no = product_detail_no;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public String getProduct_color() {
		return product_color;
	}
	public void setProduct_color(String product_color) {
		this.product_color = product_color;
	}
	public String getCate_parent() {
		return cate_parent;
	}
	public void setCate_parent(String cate_parent) {
		this.cate_parent = cate_parent;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	
	@Override
	public String toString() {
		return "ProductDetailVO [product_detail_no=" + product_detail_no + ", product_no=" + product_no
				+ ", product_color=" + product_color + ", cate_parent=" + cate_parent + ", cate_name=" + cate_name
				+ "]";
	}

}
