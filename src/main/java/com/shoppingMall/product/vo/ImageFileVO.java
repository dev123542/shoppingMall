package com.shoppingMall.product.vo;

public class ImageFileVO {
	private int product_no;		//상품번호
	private int image_no;		//이미지번호
	private String file_name;	//파일이름	
	private String file_type;	//파일타입
	private String reg_id;		//등록아이디
	
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public int getImage_no() {
		return image_no;
	}
	public void setImage_no(int image_no) {
		this.image_no = image_no;
	}
	
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	@Override
	public String toString() {
		return "ImageFileVO [product_no=" + product_no + ", image_no=" + image_no + ", file_name=" + file_name
				+ ", file_type=" + file_type + ", reg_id=" + reg_id + "]";
	}

}
