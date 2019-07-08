package com.gsitm.meeting.util;


public class Pagination {
	
	private int startRowNum;
	private int endRowNum;
	private int startPageNo;
	private int endPageNo;
	private int prev;
	private int next;
	private int pageNo;
	public int getStartRowNum() {
		return startRowNum;
	}
	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}
	public int getEndRowNum() {
		return endRowNum;
	}
	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}
	public int getStartPageNo() {
		return startPageNo;
	}
	public void setStartPageNo(int startPageNo) {
		this.startPageNo = startPageNo;
	}
	public int getEndPageNo() {
		return endPageNo;
	}
	public void setEndPageNo(int endPageNo) {
		this.endPageNo = endPageNo;
	}
	public int getPrev() {
		return prev;
	}
	public void setPrev(int prev) {
		this.prev = prev;
	}
	public int getNext() {
		return next;
	}
	public void setNext(int next) {
		this.next = next;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public Pagination(int startRowNum, int endRowNum, int startPageNo, int endPageNo, int prev, int next, int pageNo) {
		super();
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
		this.startPageNo = startPageNo;
		this.endPageNo = endPageNo;
		this.prev = prev;
		this.next = next;
		this.pageNo = pageNo;
	}
	public Pagination() {
		super();
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Pagination [startRowNum=");
		builder.append(startRowNum);
		builder.append(", endRowNum=");
		builder.append(endRowNum);
		builder.append(", startPageNo=");
		builder.append(startPageNo);
		builder.append(", endPageNo=");
		builder.append(endPageNo);
		builder.append(", prev=");
		builder.append(prev);
		builder.append(", next=");
		builder.append(next);
		builder.append(", pageNo=");
		builder.append(pageNo);
		builder.append("]");
		return builder.toString();
	}
	
}
