package com.hq.bean;import java.util.Date;public class House implements java.io.Serializable {	private long id;	private String name;	private String keyword;	private String area;	private String addr;	private String price_rmb;	private String price_other;	private String feature;	private String types;	private String propertys;	private String sizes;	private int payment;	private String huxing;	private String fitment;	private long country_id;	private long city_id;	private int level;	private Date ctimes;	private String txt1;	private String txt2;	private String txt3;	private String pic;	private int yj_persent;	private String yj_many;		private int isdel;//是否禁用  1禁用 0启用		private String target;			public long getId() {		return id;	}	public void setId(long id) {		this.id = id;	}	public String getName() {		return name;	}	public void setName(String name) {		this.name = name;	}	public String getKeyword() {		return keyword;	}	public void setKeyword(String keyword) {		this.keyword = keyword;	}	public String getArea() {		return area;	}	public void setArea(String area) {		this.area = area;	}	public String getAddr() {		return addr;	}	public void setAddr(String addr) {		this.addr = addr;	}	public String getPrice_rmb() {		return price_rmb;	}	public void setPrice_rmb(String price_rmb) {		this.price_rmb = price_rmb;	}	public String getPrice_other() {		return price_other;	}	public void setPrice_other(String price_other) {		this.price_other = price_other;	}	public String getFeature() {		return feature;	}	public void setFeature(String feature) {		this.feature = feature;	}	public String getTypes() {		return types;	}	public void setTypes(String types) {		this.types = types;	}	public String getPropertys() {		return propertys;	}	public void setPropertys(String propertys) {		this.propertys = propertys;	}	public String getSizes() {		return sizes;	}	public void setSizes(String sizes) {		this.sizes = sizes;	}	public int getPayment() {		return payment;	}	public void setPayment(int payment) {		this.payment = payment;	}	public String getHuxing() {		return huxing;	}	public void setHuxing(String huxing) {		this.huxing = huxing;	}	public String getFitment() {		return fitment;	}	public void setFitment(String fitment) {		this.fitment = fitment;	}	public long getCountry_id() {		return country_id;	}	public void setCountry_id(long country_id) {		this.country_id = country_id;	}	public long getCity_id() {		return city_id;	}	public void setCity_id(long city_id) {		this.city_id = city_id;	}	public int getLevel() {		return level;	}	public void setLevel(int level) {		this.level = level;	}	public Date getCtimes() {		return ctimes;	}	public void setCtimes(Date ctimes) {		this.ctimes = ctimes;	}	public String getTxt1() {		return txt1;	}	public void setTxt1(String txt1) {		this.txt1 = txt1;	}	public String getTxt2() {		return txt2;	}	public void setTxt2(String txt2) {		this.txt2 = txt2;	}	public String getTxt3() {		return txt3;	}	public void setTxt3(String txt3) {		this.txt3 = txt3;	}	public String getPic() {		return pic;	}	public void setPic(String pic) {		this.pic = pic;	}	public int getYj_persent() {		return yj_persent;	}	public void setYj_persent(int yj_persent) {		this.yj_persent = yj_persent;	}	public String getYj_many() {		return yj_many;	}	public void setYj_many(String yj_many) {		this.yj_many = yj_many;	}	public int getIsdel() {		return isdel;	}	public void setIsdel(int isdel) {		this.isdel = isdel;	}	public String getTarget() {		return target;	}	public void setTarget(String target) {		this.target = target;	}	}