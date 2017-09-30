/**
 * @author Alessandra Fais
 */

package exceptions;

public class WrongCodePostException extends Exception {

	private static final long serialVersionUID = 1L;

	public WrongCodePostException() {
		super();
	}
	
	public WrongCodePostException(String s) {
		super(s);
	}
}
