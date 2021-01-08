package kr.co.shovvel.dm.common;

public enum ResponseCode {

	success("SUCCESS"),
	emptyData("EMPTY_DATA"),
	invalidateData("INVALID_DATA");
	
	public String value;
	
	ResponseCode(String value) {
		this.value = value;
	}
		
	public String getValue() {
		return  value.toString();
	}
	
	
}
