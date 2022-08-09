package co.bada.leejava.banner;

import lombok.Data;

@Data
public class BannerVO {
	private int banno;							// 배너게시판 글번호
	private String m_email;						// 신청자 이메일
	private String banfile;						// 배너 이미지파일 원본명 
	private String banpfile;					// 배너 물리 파일명
	private String banapplytitle;				// 배너 신청글 제목
	private String banapplycontent;				// 배너 신청글 내용
	private String banapplydate;				// 배너 신청날짜.
	private String banapplytype;				// 배넛 신청유형(결제유형) 
	private String banpostdate;					// 배너 게시 시작일
	private String banpostenddate;				// 배너 게시 만료일 ( 게시 시작일 + 신청유형의 값) 
	private String banpoststatus;				// 배너 게시상태( 게시 or 노게시) 
}
