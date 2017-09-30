/**
 * @author Alessandra Fais
 */

package blog;

import java.util.List;

import exceptions.EmptyPostException;
import exceptions.UnauthorizedAccessException;
import exceptions.UnauthorizedBloggerException;
import exceptions.WrongCodePostException;

public interface SimpleBlog {
//	OVERVIEW: un Blog è una collezione di post caratterizzati da un codice e dal
//			  blogger che li ha inseriti; vale la proprietà che non ci possono 
//			  essere due post con lo stesso codice; i post sono mantenuti in
//			  ordine di inserimento
	
//	Costruttore con un parametro di tipo String
//	REQUIRES:
//	MODIFIES:
//	EFFECTS: inizializza this al blog vuoto con password la stringa passata come parametro

//	Metodi:
	
	void addBlogger(Blogger bob, String pass) throws UnauthorizedAccessException;
//	REQUIRES:
//	MODIFIES: this
//	EFFECTS: aggiunge il blogger bob all'insieme dei blogger attivi sul blog;
//	solleva l'eccezione UnauthorizedAccessException se pass non è corretta
	
	void deleteBlogger(Blogger bob, String pass) throws UnauthorizedAccessException;
//	REQUIRES:
//	MODIFIES: this
//	EFFECTS: elimina il blogger bob dall'insieme dei blogger attivi sul blog;
//	solleva l'eccezione UnauthorizedAccessException se pass non è corretta
	
	int post(String message, Blogger bob) throws UnauthorizedBloggerException;
//	REQUIRES:
//	MODIFIES: this
//	EFFECTS: inserisce nel blog un post del blogger bob e restituisce un codice
//	numerico del post; lancia l'eccezione UnauthorizedBloggerException se bob
//	non è tra i blogger attivi sul blog
	
	String readLast(Blogger bob) throws EmptyPostException;
//	REQUIRES:
//	MODIFIES:
//	EFFECTS: restituisce l'ultimo post inserito dal blogger bob; solleva
//	l'eccezione EmptyPostException se non ci sono post di bob
	
	String readLast() throws EmptyPostException;
//	REQUIRES:
//	MODIFIES:
//	EFFECTS: restituisce l'ultimo post inserito nel blog; solleva l'eccezione
//	EmptyPostException se il blog è vuoto
	
	List<String> readAll(Blogger bob);
//	REQUIRES:
//	MODIFIES:
//	EFFECTS: restituisce tutti i post inseriti dal blogger bob, nell'ordine di
//	inserimento

	List<String> readAll();
//	REQUIRES:
//	MODIFIES:
//	EFFECTS: restituisce tutti i post inseriti, nell'ordine di inserimento

	void delete(int code) throws WrongCodePostException;
//	REQUIRES:
//	MODIFIES: this
//	EFFECTS: cancella dal blog il post identificato da code; solleva l'eccezione
//	WrongCodePostException se non esiste un post con quel codice

	boolean emptyBlog();
//	REQUIRES:
//	MODIFIES:
//	EFFECTS: restituisce true se e solo se il blog è vuoto

}
