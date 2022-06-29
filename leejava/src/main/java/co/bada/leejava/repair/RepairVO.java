package co.bada.leejava.repair;

import lombok.Data;

@Data
public class RepairVO {
	private int repair_no;
	private String repair_category;
	private String repair_title;
	private String repair_content;
	private String repair_wdate;
}
