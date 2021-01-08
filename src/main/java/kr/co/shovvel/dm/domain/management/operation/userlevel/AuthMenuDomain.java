package kr.co.shovvel.dm.domain.management.operation.userlevel;

public class AuthMenuDomain {
	private String menu_id;
	private String level_id;
	private String depth;
	private String up_menu_id;
	private String display_order;
	private String auth_type;
	private String authMenuArr;
	
	public String getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(String menu_id) {
		this.menu_id = menu_id;
	}
	public String getLevel_id() {
		return level_id;
	}
	public void setLevel_id(String level_id) {
		this.level_id = level_id;
	}
	public String getDepth() {
		return depth;
	}
	public void setDepth(String depth) {
		this.depth = depth;
	}
	public String getUp_menu_id() {
		return up_menu_id;
	}
	public void setUp_menu_id(String up_menu_id) {
		this.up_menu_id = up_menu_id;
	}
	public String getDisplay_order() {
		return display_order;
	}
	public void setDisplay_order(String display_order) {
		this.display_order = display_order;
	}
	public String getAuth_type() {
		return auth_type;
	}
	public void setAuth_type(String auth_type) {
		this.auth_type = auth_type;
	}
	public String getAuthMenuArr() {
		return authMenuArr;
	}
	public void setAuthMenuArr(String authMenuArr) {
		this.authMenuArr = authMenuArr;
	}
}
