package kr.co.shovvel.dm.exception;

public class WsValidException extends Exception {

	/**
	 *
	 */
	private static final long serialVersionUID = -2187867829701823638L;

	public WsValidException( String key ) {
		super( key );
	}

	public WsValidException( String key , Throwable cause ) {
		super( key , cause );
	}

	public WsValidException( Throwable cause ) {
		super( cause );
	}

}
