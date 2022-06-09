package co.bada.leejava;

import lombok.Data;

@Data
public class Paging {

	private int listSize = 10; // 초기값으로 목록개수를 10으로 셋팅 한 페이지당 보여질 리스트의 개수
	private int rangeSize = 10; // 초기값으로 페이지범위를 10로 셋팅 한 페이지 범위에 보여질 페이지의 개수
	private int page; // 현재 페이지. 현재 목록의 페이지 번호
	private int range; // 현재 페이지 범위. 각 페이지 범위 시작 번호 1이면 1~10, 2면 11~20 
	private int listCnt; // 총 게시물의 갯수. 전체 게시글의 갯수(페이지 갯수 x) 
	private int pageCnt; // 총 '페이지'의 갯수
	private int startPage; // 시적번호. 각 페이지 '범위' 시작 번호 => 1/11/21/31  
	private int startList; // 게시글 시작번호. 1페이지는 1, 2페이는 11부터 시작함 
	private int endPage; // 끝 번호. 각 페이지 범위 끝 번호. 
	private boolean prev; // 이전 페이지. 이전 페이지 여부 
	private boolean next; // 다음 페이지. 다음 페이지 여부
	
	// SQL쿼리에 쓸 start, end 
	private int start; //  
	private int end; // 

	public Paging() {
	}

	public void pageinfo(int page, int range, int listCnt) {
		this.page = page; // 현재 페이지
		this.range = range;	// 현재 페이지 범위. 각 페이지 범위 시작 번호. 
		this.listCnt = listCnt;	// 총 게시물 갯수.페이지 갯수 아님
		this.pageCnt = (int) Math.ceil((double) listCnt / listSize);// 전체 페이지수
		this.startPage = (range - 1) * rangeSize + 1;// 시작 페이지
		this.endPage = range * rangeSize;// 끝 페이지
		this.startList = (page - 1) * listSize;// 게시판 시작번호
		this.prev = range == 1 ? false : true;// 이전 버튼 상태
		
		this.next = endPage > pageCnt ? false : true;// 다음 버튼 상태
		if (this.endPage > this.pageCnt) {
			this.endPage = this.pageCnt;
			this.next = false;
		}
		// SQL쿼리에 쓸 start, end 라고 명시되어 있음. 
		this.end = page * listSize;
		this.start = getEnd() - listSize + 1;  // getEnd()는 getter/setter메서드의 리턴값
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}
}
