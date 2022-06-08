package co.bada.leejava;

import lombok.Data;

@Data
public class Pagination {
	private int listSize = 10;   // 초기값으로 목록개수를 10으로 셋팅. 한 페이지당 보여줄 게시글 갯수
	private int rangeSize = 10;   // 초기값으로 페이지범위를 10으로 셋팅
	private int page;	// 현재 페이지. 현재 목록의 페이지 번호
	private int range;	// 현재 페이지 범위. 각 페이지 범위 시작 번호
	private int listCnt;	// 총 게시물의 갯수. 전체 게시물의 갯수.
	private int pageCnt;	// 총 페이지 범위의 갯수. 전체 페이지 범위의 갯수
	private int startPage;	// 시작번호. 각 페이지 "범위" 시작 번호 => 1/ 11/ 21/ 31 10개단위 페이지 '범위'를 기준으로 한다.  
	private int startList;	// 게시판 시작번호 1페이지는 1, 2페이지는 11 이런 것 row=0 => 1번글. 이런 의미
	private int endPage;	// 끝 번호. 각 페이지 범위 끝 번호
	private boolean prev;	// 이전 페이지. 이전 페이지 여부
	private boolean next;	// 다음 페이지. 다음 페이지 여부
	
	
	// 매개변수로 현재페이지, 현재 페이지 범위, 총 게시물의 갯수가 왓다. 
	public void pageInfo(int page, int range, int listCnt) { 
		this.page = page;  // 현재 페이지
		this.range = range;	// 현재 페이지 범위. 각 페이지 범위 시작 번호 
		this.listCnt = listCnt;	// 총 게시물 갯수. 전체 게시물의 갯수.
		
		// 전체 페이지수 수 => 게시글의 총 갯수에서 한 페이지당 보여질 리스트의 갯수를 나눈다.
		this.pageCnt = (int)Math.ceil(listCnt/listSize);
		
		// 시작 페이지
		this.startPage = (range -1) * rangeSize + 1;
		
		// 끝페이지
		this.endPage = range * rangeSize; 
		
		// 게시판 시작번호
		this.startList = (page -1) * listSize;
		
		// 이전 버튼 상태
		this.prev = range == 1 ? false : true; 
		
		// 다음 버튼 상태
		this.next = endPage > pageCnt ? false : true; 
		if( this.endPage > pageCnt) {
			this.endPage = this.pageCnt;
			this.next = false;
		}
		
		
		
		
	}
	
	
}
