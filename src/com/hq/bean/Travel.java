package com.hq.bean;

import java.util.Date;

public class Travel {
 private int	id;
 private String	title;
 private String	depart;
 private String	city;
 private String	visitcity;
 private String	content;
 private int	issue;
 private Date	ctimes;
 private String pic;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDepart() {
		return depart;
	}

	public void setDepart(String depart) {
		this.depart = depart;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getVisitcity() {
		return visitcity;
	}

	public void setVisitcity(String visitcity) {
		this.visitcity = visitcity;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getIssue() {
		return issue;
	}

	public void setIssue(int issue) {
		this.issue = issue;
	}

	public Date getCtimes() {
		return ctimes;
	}

	public void setCtimes(Date ctimes) {
		this.ctimes = ctimes;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}
}
