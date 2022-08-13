package co.bada.leejava.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import co.bada.leejava.message.MessageService;

@Controller
public class MessageController {
		@Autowired
		MessageService messageDao;
	private static final Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	/*	쪽지 작성, 족지 삭제, 쪽지 읽기, */
	
}
