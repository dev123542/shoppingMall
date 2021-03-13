package com.shoppingMall.board.vo;

public class SearchCriteria extends CriteriaVO{

	private String searchType = "";
	private String keyword = "";
	// 관리자 검색 추가
	private String product_name = "";
	private String product_sort = "";
	private String cate_parent = "";
	private String origin_price = "";
	 
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_sort() {
		return product_sort;
	}
	public void setProduct_sort(String product_sort) {
		this.product_sort = product_sort;
	}
	public String getCate_parent() {
		return cate_parent;
	}
	public void setCate_parent(String cate_parent) {
		this.cate_parent = cate_parent;
	}
	public String getOrigin_price() {
		return origin_price;
	}
	public void setOrigin_price(String origin_price) {
		this.origin_price = origin_price;
	}
	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + ", product_name=" + product_name
				+ ", product_sort=" + product_sort + ", cate_parent=" + cate_parent + ", origin_price=" + origin_price
				+ "]";
	}
	
//	@Override
//	public String toString() {
//		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
//	}
	
	
}
