package co.bada.leejava.message;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("messageDao")
public class MessageServiceImpl implements MessageService {
	@Autowired
	private MessageMapper map;
}
