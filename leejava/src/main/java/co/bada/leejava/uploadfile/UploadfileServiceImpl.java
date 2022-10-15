package co.bada.leejava.uploadfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("uploadfileDao")
public class UploadfileServiceImpl implements UploadfileService {
	@Autowired
	UploadfileMapper map;
}
