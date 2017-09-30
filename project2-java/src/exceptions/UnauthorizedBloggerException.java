/**
 * @author Alessandra Fais
 */

package exceptions;

public class UnauthorizedBloggerException extends Exception {

	private static final long serialVersionUID = 1L;

	public UnauthorizedBloggerException() {
		super();
	}
	
	public UnauthorizedBloggerException(String s) {
		super(s);
	}
}
