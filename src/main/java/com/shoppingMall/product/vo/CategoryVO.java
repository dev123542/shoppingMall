package com.shoppingMall.product.vo;

public class CategoryVO {
	
	private String cate_code;
	private String cate_name;
	private String cate_parent;
	
	public String getCate_code() {
		return cate_code;
	}
	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public String getCate_parent() {
		return cate_parent;
	}
	public void setCate_parent(String cate_parent) {
		this.cate_parent = cate_parent;
	}
	
	@Override
	public String toString() {
		return "CategoryVO [cate_code=" + cate_code + ", cate_name=" + cate_name + ", cate_parent=" + cate_parent + "]";
	}
	
	
}
