package co.bada.leejava;

import java.util.Random;
import java.util.Scanner;

/*
 * 출력해야 할 모양
 *     *
 *    **
 *   ***
 *  ****
 */
public class Practice {

	public static void main(String[] args) {
		Scanner scn = new Scanner(System.in);
		System.out.println("임의의숫자 n을 입력하시오");
		int n = scn.nextInt();
		scn.close();
		
		for(int i = 1; i<=n; i++) {
			for(int j=1; j<= n-i; j++ ) {
				System.out.print(" ");
			}
			for(int j=1; j<=i; j++) {
				System.out.print("*");
			}
			System.out.println();
		}
		
		
		
		
		
		
		
	}

}
