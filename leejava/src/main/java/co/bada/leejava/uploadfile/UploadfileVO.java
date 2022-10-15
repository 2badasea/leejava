package co.bada.leejava.uploadfile;

import lombok.Data;

@Data
public class UploadfileVO {
	private int whatB;				// 게시판 구분(자유게시판1, qna2, 정보3, 모임4);
	private int whatB_no;			// 해당 게시판에서의 글번호
	private int whatB_order;		// 게시글의 업로드파일 인덱스
	private String whatB_ofile; 	// 업로드 파일의 원본명
	private String whatB_pfile;		// 업로드 파일의 물리명
}
