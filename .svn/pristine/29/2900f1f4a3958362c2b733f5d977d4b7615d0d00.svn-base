package kr.co.shovvel.dm.domain.common.paging;

import java.util.List;
import java.util.Map;

import lombok.ToString;

import com.thoughtworks.xstream.annotations.XStreamAlias;

import kr.co.shovvel.hcf.utils.MessageUtil;

@XStreamAlias("paging")
@SuppressWarnings("rawtypes")
@ToString
public class Paging {

	private List lists;
	private int totalCount;
	private int page=1;
	private int perPage=Integer.parseInt(MessageUtil.getMessage("paging.per_page"));
	private int perSize=Integer.parseInt(MessageUtil.getMessage("paging.per_size"));
	private Map map;
	
	public List getLists() {
		return lists;
	}
	public void setLists(List lists) {
		this.lists = lists;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getPerSize() {
		return perSize;
	}
	public void setPerSize(int perSize) {
		this.perSize = perSize;
	}
	public Map getMap() {
		return map;
	}
	public void setMap(Map map) {
		this.map = map;
	}
}
