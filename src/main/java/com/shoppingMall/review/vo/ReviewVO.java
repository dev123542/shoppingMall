package com.shoppingMall.review.vo;

import java.sql.Date;

import com.shoppingMall.product.vo.ProductVO;

public class ReviewVO {
	
	private int review_no;
	private String writer;
	private String review_txt;
	private int review_star;
	private String review_file;
	private int product_no;
	private Date reg_date;
	
	private ProductVO productResult;
	
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getReview_file() {
		return review_file;
	}
	public void setReview_file(String review_file) {
		this.review_file = review_file;
	}
	public String getReview_txt() {
		return review_txt;
	}
	public void setReview_txt(String review_txt) {
		this.review_txt = review_txt;
	}
	public int getReview_star() {
		return review_star;
	}
	public void setReview_star(int review_star) {
		this.review_star = review_star;
	}
	
	public ProductVO getProductResult() {
		return productResult;
	}
	public void setProductResult(ProductVO productResult) {
		this.productResult = productResult;
	}
	
	@Override
	public String toString() {
		return "ReviewVO [review_no=" + review_no + ", writer=" + writer + ", review_txt=" + review_txt
				+ ", review_star=" + review_star + ", review_file=" + review_file + ", product_no=" + product_no
				+ ", reg_date=" + reg_date + ", productResult=" + productResult + "]";
	}
	
}
