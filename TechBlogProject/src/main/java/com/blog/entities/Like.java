package com.blog.entities;

public class Like {
	private int lid;
	private int pid;
	private int uid;
	
	public Like() {
		
	}

	public Like(int lid, int pid, int uid) {
		super();
		this.lid = lid;
		this.pid = pid;
		this.uid = uid;
	}

	public Like(int pid, int uid) {
		super();
		this.pid = pid;
		this.uid = uid;
	}

	public int getLid() {
		return lid;
	}

	public void setLid(int lid) {
		this.lid = lid;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}
	
	

}
