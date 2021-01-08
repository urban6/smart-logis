package kr.co.shovvel.dm.tag;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.apache.log4j.Logger;

import kr.co.shovvel.dm.domain.management.operation.menu.MenuVO;

public class MenuListEditTag extends BodyTagSupport {

	/**
	 *
	 */
	private static final long	serialVersionUID		= 942879435071403070L;

	private Logger				logger					= Logger.getLogger( this.getClass() );

	private int					menuIndex				= 0;
	private List< Object >		menuList;
	private String				menuHtmlTitle			= "";
	private String				menuHtmlTarget			= "";

	private final String		ROW_ENTER				= "\r\n";
	private final String		MENU_LIST_HEADER		= "<div class=\"card-body col-md-12\">" + ROW_ENTER + "<div class=\"row\">" + ROW_ENTER + "<h4 class=\"card-title col-4\" style=\"margin-right:6.5%\">@menuHtmlTitle@</h4>" + ROW_ENTER
			+ "<h4 class=\"card-title\">URL</h4>" + ROW_ENTER + "</div>" + ROW_ENTER + "<div id=\"divMenuHtml\"></div>" + ROW_ENTER + "<div class=\"myadmin-dd-empty dd col-md-12\" id=\"@menuHtmlTarget@\" style=\"padding-right:0;padding-left:0;\">"
			+ ROW_ENTER;
	private final String		BODY_CONTENT_BTN	= "<div class=\"row\" style=\"background: none;\"><div class=\"col-12\" style=\"padding:2.5rem 1.2rem 1rem 2.9rem\"><button class=\"btn waves-effect waves-light btn-secondary\" onclick=\"javascript:fnCancel();\">취소</button><button class=\"btn waves-effect waves-light btn-primary float-right\" onclick=\"javascript:fnModifyMenu();\">저장</button></div></div>" + ROW_ENTER; //추가 ksh07-30
	private final String		MENU_LIST_FOOTER		= "</div>" + BODY_CONTENT_BTN + "</div>" + ROW_ENTER;
	private final String		MENU_ROW_HEADER			= "<ol class=\"dd-list\">" + ROW_ENTER;
	private final String		MENU_ROW_HEADER_TOP		= "<ol class=\"dd-list col-md-12\" style=\"padding-right:0;padding-left:0;\">" + ROW_ENTER;
	private final String		MENU_ROW_FOOTER			= "</ol>" + ROW_ENTER;
	private final String		ROW_HEADER				= "<li class=\"dd-item\" style=\"line-height: 33px;\" data-path=\"@menuPath@\" data-name=\"@menuName@\" data-id=\"@menuId@\" data-upper=\"@upMenuId@\" data-order=\"@displayOrder@\" data-depth=\"@depth@\">"
			+ ROW_ENTER;
	private final String		ROW_FOOTER				= "</li>" + ROW_ENTER;
	// private final String ROW_HANDLE = "<div class=\"dd-handle\"></div>" + ROW_ENTER;
	private final String		ROW_HANDLE_TOP			= "<div class=\"dd-handle dd3-handle\" style=\"height: 52px;\"></div>" + ROW_ENTER;
	private final String		ROW_CONTENT_START		= "<div class=\"dd3-content\">" + ROW_ENTER;
	private final String		ROW_CONTENT_END			= "</div>" + ROW_ENTER;

	private final String		ROW_CONTENT_BODY_START	= "<div class=\"input-group col-md-12\">" + ROW_ENTER;
	private final String		ROW_CONTENT_BODY_END	= "</div>" + ROW_ENTER;

	// private final String BODY_CONTENT_BTN_EXPAND = "<button data-action=\"collapse\" type=\"button\">Collapse</button><button data-action=\"expand\" type=\"button\" style=\"display:
	// none;\">Expand</button>"
	// + ROW_ENTER;
	private final String		BODY_CONTENT_BTN_DELETE	= "<div class=\"input-group-append\">" + ROW_ENTER
			+ "<button style=\"height: 35px;\" class=\"btn btn-danger\" type=\"button\" data-toggle=\"modal\" onclick=\"fnDelete('@menuId@')\" data-original-title=\"삭제\">" + ROW_ENTER
			+ "<i class=\"mr-2 mdi mdi-close-outline\"></i>" + ROW_ENTER + "</button>" + ROW_ENTER + "</div>" + ROW_ENTER;

	public int doEndTag() throws JspException {

		final BodyContent bodyContent = getBodyContent();

		try {
			menuIndex = 0;
			String menuListBody = getMenuListView( getMenuList() );

			pageContext.getOut().print( menuListBody );

		} catch ( Exception e ) {
			e.printStackTrace();
		}

		return SKIP_BODY;
	}

	private String getMenuListView( List< Object > menuList ) {
		String			result	= "";
		StringBuilder	sb		= new StringBuilder();
		for ( Object object : menuList ) {
			if ( object.getClass().equals( MenuVO.class ) ) {
				MenuVO	menu		= (MenuVO) object;

				String	menuBody	= getMenuBody( menu );

				sb.append( menuBody );
			}
			menuIndex++;
		}

		result = MENU_LIST_HEADER.replace( "@menuHtmlTitle@" , getMenuHtmlTitle() ).replace( "@menuHtmlTarget@" , getMenuHtmlTarget() );
		result += MENU_ROW_HEADER_TOP;
		result += sb.toString();
		result += MENU_ROW_FOOTER;
		result += MENU_LIST_FOOTER;

		return result;
	}

	private String getMenuBody( MenuVO menu ) {
		String			result			= "";
		StringBuilder	sb				= new StringBuilder();
		String			menuBody		= "";
		String			childrenBody	= "";

		if ( menu.getIsFolder().equals( "Y" ) ) {
			sb.append(
					"<input type=\"text\" class=\"form-control col-md-1\" style=\"max-width: calc(25% + 23px);\" id=\"menuNameOld_@upMenuId@_@menuId@\" name=\"menuName_@upMenuId@_@menuId@\" value=\"@menuName@\" onKeyUp=\"javascript:fnChangeValue('Name', '@upMenuId@', '@menuId@');\" />"
							+ ROW_ENTER );
		} else {
			sb.append(
					"<input type=\"text\" class=\"form-control col-md-1\" style=\"max-width: calc(25% + 23px);\" id=\"menuNameOld_@upMenuId@_@menuId@\" name=\"menuName_@upMenuId@_@menuId@\" value=\"@menuName@\" onKeyUp=\"javascript:fnChangeValue('Name', '@upMenuId@', '@menuId@');\" />"
							+ ROW_ENTER );
		}

		sb.append( "<input type=\"hidden\" id=\"menuIdOld_@upMenuId@_@menuId@\" name=\"menuId_@upMenuId@_@menuId@\" value=\"@menuId@\" />" + ROW_ENTER );

		sb.append( "<div class=\"input-group-append\">" + ROW_ENTER
				+ "<button style=\"height: 35px;\" class=\"btn btn-danger\" type=\"button\" data-toggle=\"modal\" onclick=\"fnDelete('@menuId@')\" data-original-title=\"삭제\">" + ROW_ENTER
				+ "<i class=\"mr-2 mdi mdi-close-outline\"></i>" + ROW_ENTER + "</button>" + ROW_ENTER + "</div>" + ROW_ENTER );

		sb.append( "<div class=\"input-group-append col-md-1\" style=\"max-width: calc(25% + -25px);\"></div>" + ROW_ENTER );

		sb.append(
				"<input type=\"text\" class=\"form-control col-md-9\" id=\"menuPathOld_@upMenuId@_@menuId@\" name=\"menuPath_@upMenuId@_@menuId@\" value=\"@menuPath@\" onKeyUp=\"javascript:fnChangeValue('Path', '@upMenuId@', '@menuId@');\"/>"
						+ ROW_ENTER );

		menuBody = replaceMenuStr( sb.toString() , menu );
		// menuBody += replaceMenuStr( BODY_CONTENT_BTN_DELETE , menu );

		result += replaceMenuStr( ROW_HEADER , menu );
		// if ( menu.getUpMenuId().equals( "" ) || menu.getUpMenuId().equals( "0" ) )
		result += replaceMenuStr( ROW_HANDLE_TOP , menu );
		// else
		// result += replaceMenuStr( ROW_HANDLE , menu );

		result += replaceMenuStr( ROW_CONTENT_START , menu );
		result += replaceMenuStr( ROW_CONTENT_BODY_START , menu );
		result += menuBody;

		result += ROW_CONTENT_BODY_END;
		result += ROW_CONTENT_END;

		if ( menu.getChildren().size() > 0 ) {
			childrenBody = getMenuChildrenList( menu.getChildren() );
			result += childrenBody;
		}

		result += ROW_FOOTER;
		result += ROW_ENTER;

		return result;
	}

	private String getMenuBody2( MenuVO menu ) {
		String			result			= "";
		StringBuilder	sb				= new StringBuilder();
		String			menuBody		= "";
		String			childrenBody	= "";

		sb.append(
				"<input type=\"text\" class=\"form-control col-md-3\" id=\"menuNameOld_@upMenuId@_@menuId@\" name=\"menuName_@upMenuId@_@menuId@\" value=\"@menuName@\" onKeyUp=\"javascript:fnChangeValue('Name', '@upMenuId@', '@menuId@');\" />"
						+ ROW_ENTER );
		sb.append( "<input type=\"hidden\" id=\"menuIdOld_@upMenuId@_@menuId@\" name=\"menuId_@upMenuId@_@menuId@\" value=\"@menuId@\" />" + ROW_ENTER );

		sb.append( "<div class=\"input-group-append\">" + ROW_ENTER
				+ "<button style=\"height: 35px;\" class=\"btn btn-danger\" type=\"button\" data-toggle=\"modal\" onclick=\"fnDelete('@menuId@')\" data-original-title=\"삭제\">" + ROW_ENTER
				+ "<i class=\"mr-2 mdi mdi-close-outline\"></i>" + ROW_ENTER + "</button>" + ROW_ENTER + "</div>" + ROW_ENTER );

		sb.append( "<div class=\"input-group-append col-md-1\" style=\"max-width: calc(25% + -16px);\"></div>" + ROW_ENTER );

		sb.append(
				"<input type=\"text\" class=\"form-control col-md-12\" id=\"menuPathOld_@upMenuId@_@menuId@\" name=\"menuPath_@upMenuId@_@menuId@\" value=\"@menuPath@\" onKeyUp=\"javascript:fnChangeValue('Path', '@upMenuId@', '@menuId@');\"/>"
						+ ROW_ENTER );
		menuBody = replaceMenuStr( sb.toString() , menu );
		// menuBody += replaceMenuStr( BODY_CONTENT_BTN_DELETE , menu );

		result += replaceMenuStr( ROW_HEADER , menu );
		// if ( menu.getUpMenuId().equals( "" ) || menu.getUpMenuId().equals( "0" ) )
		result += replaceMenuStr( ROW_HANDLE_TOP , menu );
		// else
		// result += replaceMenuStr( ROW_HANDLE , menu );

		result += replaceMenuStr( ROW_CONTENT_START , menu );
		result += replaceMenuStr( ROW_CONTENT_BODY_START , menu );
		result += menuBody;

		result += ROW_CONTENT_BODY_END;
		result += ROW_CONTENT_END;

		if ( menu.getChildren().size() > 0 ) {
			childrenBody = getMenuChildrenList( menu.getChildren() );
			result += childrenBody;
		}

		result += ROW_FOOTER;
		result += ROW_ENTER;

		return result;
	}

	private String getMenuChildrenList( List< MenuVO > menuList ) {
		String			result	= "";
		StringBuilder	sb		= new StringBuilder();

		for ( MenuVO menu : menuList ) {
			menuIndex++;
			String menuBody = getMenuBody2( menu );
			sb.append( menuBody );
		}

		result += MENU_ROW_HEADER;
		result += sb.toString();
		result += MENU_ROW_FOOTER;
		result += ROW_ENTER;

		return result;
	}

	private String replaceMenuStr( String menuStr , MenuVO menu ) {
		String result = "";
		result = menuStr.replace( "@upMenuId@" , menu.getUpMenuId() == null ? "" : menu.getUpMenuId() );
		result = result.replace( "@menuId@" , menu.getMenuId() == null ? "" : menu.getMenuId() );
		result = result.replace( "@menuName@" , menu.getMenuName() == null ? "" : menu.getMenuName() );
		result = result.replace( "@menuPath@" , menu.getMenuPath() == null ? "" : menu.getMenuPath() );
		result = result.replace( "@depth@" , menu.getDisplayOrder() == null ? "" : menu.getDepth() );
		result = result.replace( "@displayOrder@" , menu.getDisplayOrder() == null ? "" : menu.getDisplayOrder() );
		return result;
	}

	public List< Object > getMenuList() {
		if ( menuList == null ) {
			menuList = new ArrayList< Object >();
		}
		return menuList;
	}

	public void setMenuList( List< Object > menuList ) {
		this.menuList = menuList;
	}

	public String getMenuHtmlTitle() {
		if ( menuHtmlTitle == null || menuHtmlTitle.length() <= 0 ) {
			menuHtmlTitle = "메뉴 명";
		}
		return menuHtmlTitle;
	}

	public void setMenuHtmlTitle( String menuHtmlTitle ) {
		this.menuHtmlTitle = menuHtmlTitle;
	}

	public String getMenuHtmlTarget() {
		if ( menuHtmlTarget == null || menuHtmlTarget.length() <= 0 ) {
			menuHtmlTarget = "nestable";
		}
		return menuHtmlTarget;
	}

	public void setMenuHtmlTarget( String menuHtmlTarget ) {
		this.menuHtmlTarget = menuHtmlTarget;
	}

}
