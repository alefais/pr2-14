/**
 * @author Alessandra Fais
 */

package blog;

public class Post {
//	OVERVIEW: Post è una coppia (Blogger, stringa) dotata di un proprio codice identificativo.
//  		  La classe è assimilabile ad un record, fatta eccezione per la proprietà di incapsulamento
//			  che si è preferito mantenere (mediante i tre metodi getter).
	
	private int code = 0;
	private Blogger blogger = null;
	private String message = null;

//	FUNZIONE DI ASTRAZIONE:
//	a(c) = (c.blogger.getNickname: c.message)
//
//	INVARIANTE DI RAPPRESENTAZIONE:
//	I(c) = true

// 	Costruttore con parametri
	public Post(int c, Blogger b, String m) {
//  EFFECTS: inizializza this settandone Blogger, messaggio e codice identificativo.
		this.code = c;
		this.blogger = b;
		this.message = m;
	}

	public int getCode() {
//  EFFECTS: restituisce il codice identificativo di questo Post.
		return code;
//  Metodo observer
	}


	public Blogger getBlogger() {
//  EFFECTS: restituisce il Blogger di questo Post.
		return blogger;
//  Metodo observer
	}

	public String getMessage() {
//  EFFECTS: restituisce il messaggio contenuto in questo Post.
		return message;
//  Metodo observer
	}
	
	@Override
	public String toString() {
//  EFFECTS: restituisce una rappresentazione testuale di this
		String s = new String(blogger.getNickname()+": "+message);
		return s;
//  Metodo observer
	}

}
