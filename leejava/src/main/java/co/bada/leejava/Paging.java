package co.bada.leejava;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Paging {
	
	private int listSize = 10; // 초기값으로 목록개수를 10으로 셋팅 한 페이지당 보여질 리스트의 개수
	private int rangeSize = 5; // 초기값으로 페이지범위를 5로 셋팅.  한 페이지 범위에 보여질 페이지의 개수
	private int page; // 현재 페이지. 현재 목록의 페이지 번호
	private int range; // 현재 페이지 범위. 각 페이지 범위 시작 번호 1이면 1~10, 2면 11~20 // rangeSize가 5면 절반
	private int listCnt; // 총 게시물의 갯수. 전체 게시글의 갯수(페이지 갯수 x) 
	private int pageCnt; // 총 '페이지'의 갯수
	private int startPage; // 시적번호. 각 페이지 '범위' 시작 번호 => 1/11/21/31  // rangeSize에 따름. 5라면, 1/6/11 ...
	private int startList; // 게시글 시작번호. 1페이지는 1, 2페이는 11부터 시작함  => listSize가 10이란 전제하에 
	private int endPage; // 끝 번호. 각 페이지 범위 끝 번호. 
	private boolean prev; // 이전 페이지. 이전 페이지 여부 
	private boolean next; // 다음 페이지. 다음 페이지 여부
	
	/*
	 * SQL쿼리에 쓸 start, end
	 * 최종적으로 페이지에 데이터를 출력할때, rownum기준으로 start와 end의 값 사이의 게시글이 출력된다. rownum의 값임. 
	 */
	private int start; //  
	private int end; // 
	
	// 일반적인 생성자 함수 => new연산자를 통해서 인스턴스 생성이 가능하다. (싱글톤 패턴 아님) 
	public Paging() {
	}
	
	public void pageinfo(int page, int range, int listCnt) {
		this.page = page; // 현재 페이지
		this.range = range;	// 현재 페이지 범위. 각 페이지 범위 시작 번호. 
		this.listCnt = listCnt;	// 총 게시물 갯수.페이지 갯수 아님
		// int형 두 수의 연산결과는int형 =>그래서 올림처리가 안 됨. 나누어 떨어진 몫만큼만 페이지가 생성. 나머지가 사라짐. 
		this.pageCnt = (int) Math.ceil((double) listCnt / listSize);// 전체 페이지수
		this.startPage = (range - 1) * rangeSize + 1;// 시작 페이지
		this.endPage = range * rangeSize; 	// 끝 페이지
		// 게시판 시작번호의 경우 우항의 계산식에서 +1을 해준 것이 실제 페이지별 게시글 시작번호다. 
		this.startList = (page - 1) * listSize;// 게시판 시작번호
		// SQL쿼리에 쓸 start, end 라고 명시되어 있음. 
		// sql쿼리 결과에서 rownum as rn인, 즉 몇 개의 row데이터(행)을 보여줄 것인지. 
		// 이때 start, end는 주어진 page내에서 글번호의 시작과 끝값을 의미한다. (rownum)  
		// range * rangesize() 와 유사하다. 
		this.end = page * listSize;
		// getEnd() => this.end()값. this.end() 값을 기준으로 this.start를 구한다. 
		// startPage()와 유사하다 =>  page * 
		this.start = getEnd() - listSize + 1;  // getEnd()는 getter/setter메서드의 리턴값
		
		// range가 1,즉 1~10페이지가 범위로 구성된 상태에선 이전버튼이 존재하지 않는다. 
		this.prev = range == 1 ? false : true;// 이전 버튼 상태
		this.next = endPage > pageCnt ? false : true;// 다음 버튼 상태
		// pageInfo()메서드로 계산된 endPage()값보다 실제 page수가 적을 경우, 실제페이지 값을 대입한다. 
		if (this.endPage > this.pageCnt) {
			// pageInfo()의 결과로, 실제 페이지 갯수(pageCnt)보다 endPage(10,20,30,...)이 더 크면 
			// 실제 페이지갯수를 endPage값에 대입시킨다. 
			this.endPage = this.pageCnt;
			// 그리고 실제페이지갯수(pageCnt)가  endPage가 됨으로, next버튼은 없다(false) 
			this.next = false;  
		}
	}
	//페이징 
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
