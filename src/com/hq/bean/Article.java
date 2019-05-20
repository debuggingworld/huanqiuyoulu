package com.hq.bean;

import java.io.Serializable;
import java.util.Date;

import com.hq.db.annotation.Exclude;

public class Article implements Serializable{
private long id;
private String	title;
private String	keywords;
private String	content;
private String	pic;
private long  visits;
private Date ctime;
private int 	channel_id;
private int 	city_id;
private int level;

@Exclude
private String channelName;
@Exclude
private String cityName;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public long getVisits() {
		return visits;
	}

	public void setVisits(long visits) {
		this.visits = visits;
	}

	public Date getCtime() {
		return ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}

	public int getChannel_id() {
		return channel_id;
	}

	public void setChannel_id(int channel_id) {
		this.channel_id = channel_id;
	}

	public int getCity_id() {
		return city_id;
	}

	public void setCity_id(int city_id) {
		this.city_id = city_id;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public String getChannelName() {
		return channelName;
	}

	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
}
