package co.bada.leejava;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class CoolSMS {
	
	public void certifiedPhone(String sendPhone, int randomNum) {
		String api_key = "NCS8J8DI7T1QG1MK";
		String api_secret = "AOHD4TE2IYO5LHFGGITFRQP4Y8JSWSAW";
		// Message는 pom에 추가한 javaSDK 라이브러리를 통해 가져온 클래스다.
		Message coolsms = new Message(api_key, api_secret); 
		
		// 4개는(to, from, type, text) 반드시 입력해야 한다. must be filled
		HashMap<String, String> map = new HashMap<>();
		map.put("to", sendPhone);		// 수신 전화번호
		map.put("from", "01084480980"); // 발신 전화번호
		map.put("type", "SMS");
		String message = "[자바이야기] 인증번호는 "+"["+randomNum+"]" + " 입니다.";
		map.put("text", message); 		// 문자 내용 입력 
		map.put("app_version", "test app 1.2"); 
		
		// 실제 인증번호를 보내는 부분 => 주석을 지우면 실제로 보내진다.
//		try {
//			JSONObject obj = (JSONObject)coolsms.send(map);
//			System.out.println("obj값: " + obj.toString());
//		} catch (CoolsmsException e) {
//			System.out.println("에러메시지ㅗ: " + e.getMessage());
//			System.out.println("에러코드: " + e.getCode());
//		}
	}
}
