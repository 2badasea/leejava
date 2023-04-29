package co.bada.leejava.notice;

import lombok.Data;

@Data
public class NoticeVO {
	private int n_no; // 글번호
	private String n_writer;	// 작성자
	private String n_wdate; 	// 작성일
	private String n_category; 	// 카테고리
	private String n_title;		// 글제목
	private String n_content;	// 글내용
	private String n_file;		// 첨부파일 원본명
	private String n_pfile;		// 첨부파일 물리적으로 저장된 이름. 
	private int n_hit;			// 조회수
	private String n_fixed;		// 게시글 상단 고정여부
}
