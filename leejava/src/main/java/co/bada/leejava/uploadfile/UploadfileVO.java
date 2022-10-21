package co.bada.leejava.uploadfile;

import lombok.Data;

@Data
public class UploadfileVO {
	private int whatB;					// 게시판 구분(자유게시판1, qna2, 정보3, 모임4);
	private int whatB_no;				// 해당 게시판에서의 글번호
	private String whatB_uuid; 			// 고유넘버
	private String whatB_uploadPath;	// 업로브 경로(년,월,일)
	private String whatB_ofile; 		// 업로드 파일의 원본명
}
