/**
 * @author Alessandra Fais
 */

package exceptions;

public class UnauthorizedAccessException extends Exception {

	private static final long serialVersionUID = 1L;

	public UnauthorizedAccessException() {
		super();
	}
	
	public UnauthorizedAccessException(String s) {
		super(s);
	}

}
