package co.bada.leejava;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class SHA256Util {
	
	
	// sha-256 암호화 함. 매개변수 source는 뷰에서 넘어온 password 값이다.
	public static String getEncrypt(String source, String salt) {
		return getEncrypt(source, salt.getBytes());
	}
	
	// 동일한 메소드를 사용할 수 있는 건, 오버로딩 되었기 때문.
	public static String getEncrypt(String source, byte[] salt) {
		
		String result = "";
		
		byte[] a = source.getBytes();
		byte[] bytes = new byte[a.length + salt.length];
		
		System.arraycopy(a,  0, bytes, 0, a.length);
		// bytes배열에 a와 salt바이트 배열이 복사되어서 들어감. 배열 복사 클래스 System.arraycopy
		System.arraycopy(salt, 0, bytes, a.length, salt.length);
		
		try {
			// 암호화 방식 지정 메소드. SHA-256을 사용한 객체를 사용하면 결괏값도 길이가 256비트다.(64자리 문자열) 
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			// update() 메서드는 지정된 바이트 데이터를 사용해 다이제스트를 갱신한다. 가공(갱신)처리한다는 뜻.
			md.update(bytes);
			// digest() 메서드는 update() 메서드로 가공된 해쉬값를을 바이트배열로 반환한다. return타입이 바이트 
			byte[] byteData = md.digest();
			
			StringBuffer sb = new StringBuffer();
			for(int i = 0; i<byteData.length; i++) {
				// byte타입의 배열에 & 0xFF 를 해주면, 0~255 범위 내에서 양의 정수로 표현하게 해준다.
				sb.append(Integer.toString( (byteData[i] & 0xFF) + 256, 16).substring(1) );
			}
			
			result = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	// salt를 얻어온다. 
	public static String generateSalt() {
		SecureRandom random = new SecureRandom();
		
		// 8개의 임의의 바이트 배열을 생성
		byte[] salt = new byte[8];
		random.nextBytes(salt);
		
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < salt.length; i++) {
			// byte 값을 Hex 값으로 바꾸기. 2자리 Hex String으로 변환시킴. Hex 문자열은 16진수 2자리로 이루어진 문자열
			sb.append(String.format("%02x", salt[i]));
		}
		
		return sb.toString();
	}
	
	
	
	
	
}
