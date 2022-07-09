package co.bada.leejava;

import java.util.UUID;

public class Practice {

	public static void main(String[] args) {
		String fileName = "loofy.jpg";
		fileName = fileName.substring(fileName.lastIndexOf("."));
		String savedName  = null;
		for(int i = 0; i<3; i++) {
			UUID n = UUID.randomUUID();
			savedName = n+ fileName;
			System.out.println(savedName);
		}
		
		
		String name = "LEEBADA";
		String test1 = name.substring(3);
		System.out.println(test1);
		String test2 = name.substring(3,6);
		System.out.println(test2);
		String test3 = name.substring(name.lastIndexOf("B"));
		System.out.println(test3);
	}

}