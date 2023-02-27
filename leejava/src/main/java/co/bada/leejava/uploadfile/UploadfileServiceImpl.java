package co.bada.leejava.uploadfile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("uploadfileDao")
public class UploadfileServiceImpl implements UploadfileService {
	@Autowired
	UploadfileMapper map;

	@Override
	public int uploadfileInsert(UploadfileVO uvo) {
		// TODO Auto-generated method stub
		return map.uploadfileInsert(uvo);
	}

	@Override
	public List<UploadfileVO> uploadfileSelect(UploadfileVO uvo) {
		// TODO Auto-generated method stub
		return map.uploadfileSelect(uvo);
	}

	@Override
	public int uploadfileDelete(UploadfileVO uvo) {
		// TODO Auto-generated method stub
		return map.uploadfileDelete(uvo);
	}

	@Override
	public int uploadfileDeleteOne(UploadfileVO uvo) {
		// TODO Auto-generated method stub
		return map.uploadfileDeleteOne(uvo);
	}
}
