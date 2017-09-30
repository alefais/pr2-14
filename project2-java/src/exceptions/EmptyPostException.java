/**
 * @author Alessandra Fais
 */

package exceptions;

public class EmptyPostException extends Exception {

	private static final long serialVersionUID = 1L;

	public EmptyPostException() {
		super();
	}
	
	public EmptyPostException(String s) {
		super(s);
	}

}
