/**
 * @author Alessandra Fais
 */

package blog;

import java.util.LinkedList;
import java.util.List;

import exceptions.EmptyPostException;
import exceptions.UnauthorizedAccessException;
import exceptions.UnauthorizedBloggerException;
import exceptions.WrongCodePostException;

public class Blog implements SimpleBlog {
//	OVERVIEW: un Blog è una collezione di post caratterizzati da un codice e dal
//	 		  blogger che li ha inseriti; vale la proprietà che non ci possono 
//	 		  essere due post con lo stesso codice; i post sono mantenuti in
//	  		  ordine di inserimento
//
//	FUNZIONE DI ASTRAZIONE:
//	a(c) = [c.posts.get(i).getBlogger.getNickname: c.posts.get(i).getMessage per ogni 0 <= i < c.posts.size]
//
//	INVARIANTE DI RAPPRESENTAZIONE:
//	I(c) = [ (c.posts.size == 0) oppure
//			(c.posts.get(i).getCode < c.posts.get(i + 1).getCode per ogni 0 <= i < (c.posts.size-1)) ] &&
//		   [ (c.bloggers.size == 0) oppure
//			( (!c.bloggers.get(i).equals(c.bloggers.get(i + 1)) per ogni 0 <= i < (c.bloggers.size-1))
//				&& (c.bloggers.get(i) è autenticato per ogni 0 <= i < c.bloggers.size ) ]
	
	private String password = null;
	private int postcode;
	private List<Post> posts = null;
	private List<Blogger> bloggers = null;

//	Costruttore con un parametro di tipo String
	public Blog(String password) {
//		REQUIRES: password != null
//		EFFECTS: inizializza this al blog vuoto con password la stringa passata come parametro
		this.password = password;
		postcode = -1;
		posts = new LinkedList<Post>();
		bloggers = new LinkedList<Blogger>();
//		Il costruttore crea e inizializza un nuovo oggetto della classe Blog in cui
//		posts.size() e bloggers.size() sono entrambe 0, perciò è rispettata l'invariante
//		di rappresentazione: (A or B) and (C or (D and E)) è true per A=true e C=true.
	}

//	Metodi:
	
	@Override
	public void addBlogger(Blogger bob, String pass)
			throws UnauthorizedAccessException {
//		MODIFIES: this
//		EFFECTS: aggiunge il blogger bob all'insieme dei blogger attivi sul blog;
//				 solleva l'eccezione UnauthorizedAccessException se pass non è corretta;
//				 se anche solo uno dei parametri è null solleva implicitamente NullPointerException
		if(!password.equals(pass))
			throw new UnauthorizedAccessException("The inserted password is not valid.");
		else {
			if(!bloggers.contains(bob))
				bloggers.add(bob);
		}
//		Nel caso in cui venga inserita una password non corretta verrà sollevata un'eccezione. 
//		E' garantito che this resti invariato: esso soddisfa l'invariante di rappresentazione per 
//		ipotesi induttiva, perciò la soddisferà anche this_post essendo uguale a this_pre.
//		Altrimenti, se la password inserita non è corretta si possono verificare due casi:
//		- se il blogger non è già un blogger attivo, allora viene aggiunto correttamente (this.bloggers
//		viene modificato aggiungendo un elemento quindi si avrà bloggers_post.size = bloggers_pre.size + 1 > 0). 
//		La clausola E ha valore true perchè il blogger inserito è autenticato (ha inserito password corretta), la
//		clausola D è vera nel caso sia bloggers_post.size==1, e nel caso sia bloggers_post.size>1 continua
//		a essere vera per via del controllo (!bloggers.contains(bob)). Quindi l'invariante di
//		rappresentazione viene rispettato: (A or B) è true per costruzione e non viene modificato 
//		perchè non si manipola this.posts, (C or (D and E)) è true per D=true e E=true;
//		- se il blogger è già presente in this_pre.bloggers il controllo nella guardia dell'if assicura che 
//		this resti invariato (resta invariato this.posts e anche this.bloggers), perciò this_post continua a 
//		rispettare l'invariante di rappresentazione per costruzione.
	}

	@Override
	public void deleteBlogger(Blogger bob, String pass)
			throws UnauthorizedAccessException {
//		MODIFIES: this
//		EFFECTS: elimina il blogger bob dall'insieme dei blogger attivi sul blog;
//				 solleva l'eccezione UnauthorizedAccessException se pass non è corretta;
//				 se anche solo uno dei parametri è null solleva implicitamente NullPointerException
		if(!password.equals(pass))
			throw new UnauthorizedAccessException("The inserted password is not valid.");
		else
			bloggers.remove(bob);
//		Se la password passata come argomento non è corretta, il metodo solleva un'eccezione. Se l'invariante
//		di rappresentazione valeva per this_pre, allora vale anche per this_post (non c'è alcuna modifica).		
//		Nel caso in cui venga inserita una password corretta, se !this_pre.bloggers.contains(bob), 
//		il metodo remove di LinkedList garantisce che non venga apportata alcuna modifica; vale dunque 
//		this_pre == this_post e l'invariante continua ad essere verificato.
//		Se invece this_pre.bloggers.contains(bob) (il che comporta che bloggers.size != 0), il blogger viene rimosso
//		da this_post.bloggers. L'unicità del blogger (in this_pre.blogger) è garantita dalla correttezza del metodo 
//		addBlogger().
//		Il metodo non apporta modifiche a this.posts, dunque la prima parte dell'invariante di rappresentazione
//		continua a valere.
//		Dopo la rimozione del blogger possono verificarsi 2 casi, ossia bloggers.size()==0 (C=true), oppure 
//		bloggers è non vuoto (C=false) ma valgono D=true e E=true. In entrambi i casi, l'intero termine è true.
	}

	@Override
	public int post(String message, Blogger bob)
			throws UnauthorizedBloggerException {
//		MODIFIES: this
//		EFFECTS: inserisce nel blog un post del blogger bob e restituisce un codice
//				 numerico del post; lancia l'eccezione UnauthorizedBloggerException se bob
//				 non è tra i blogger attivi sul blog; se anche solo uno dei parametri è 
//				 null solleva implicitamente NullPointerException
		if(!bloggers.contains(bob))
			throw new UnauthorizedBloggerException("This blogger is not active in the blog.");
		else {
			Post p = new Post(++postcode, bob, message);
			posts.add(p);
		}
		return postcode;
//		Se il blogger non è autenticato (non è presente in this_pre.bloggers) viene sollevata un'eccezione. Se l'invariante
//		di rappresentazione valeva per this_pre, allora vale anche per this_post (non c'è alcuna modifica).			
//		Il metodo non modifica this.bloggers, perciò se l'invariante di rappresentazione vale per this_pre, il secondo
//		termine continua a essere true anche per this_post. Resta da dimostrare che (A or B)=true.
//		Dopo l'inserimento di un post posts.size()>0 sicuramente, perciò va dimostrato B=true: ciò è garantito dall'
//		incremento della variabile contatore a ogni inserimento di un post, così non possono esistere 2 post con lo
//		stesso codice. L'invariante di rappresentazione è dunque verificato per this_post.
	}

	@Override
	public String readLast(Blogger bob) throws EmptyPostException {
//		EFFECTS: restituisce l'ultimo post inserito dal blogger bob; solleva
//				 l'eccezione EmptyPostException se non ci sono post di bob;
//				 se il parametro è null solleva implicitamente NullPointerException
		if(posts.isEmpty())
			throw new EmptyPostException("This blogger doesn't have any post.");
		else {
			boolean found = false;
			String lastmsg = null;
			for(int i=(posts.size()-1); i>=0 && !found; i--) {
				if(posts.get(i).getBlogger().equals(bob)) {
					lastmsg = posts.get(i).getMessage();
					found = true;
				}
			}
			if(!found)
				throw new EmptyPostException("This blogger doesn't have any post.");				
			return lastmsg;
		}
//		Metodo observer (non apporta modifiche)
	}

	@Override
	public String readLast() throws EmptyPostException {
//		EFFECTS: restituisce l'ultimo post inserito nel blog; solleva l'eccezione
//				 EmptyPostException se il blog è vuoto
		if(emptyBlog())
			throw new EmptyPostException("The blog is empty.");
		else
			return posts.get(posts.size()-1).toString();
//		Metodo observer (non apporta modifiche)
	}

	@Override
	public List<String> readAll(Blogger bob) {
//		EFFECTS: restituisce tutti i post inseriti dal blogger bob, nell'ordine di
//				 inserimento; se il parametro è null solleva 
// 			     implicitamente NullPointerException
		List<String> bobpost = new LinkedList<String>();
		for(Post p : posts) {
			if(p.getBlogger().equals(bob))
				bobpost.add(p.getMessage());
		}
		return bobpost;
//		Metodo observer (non apporta modifiche)
	}

	@Override
	public List<String> readAll() {
//		EFFECTS: restituisce tutti i post inseriti, nell'ordine di inserimento
		List<String> postlist = new LinkedList<String>();
		for(Post p : posts) {
			postlist.add(p.toString());
		}
		return postlist;
//		Metodo observer (non apporta modifiche)
	}

	@Override
	public void delete(int code) throws WrongCodePostException {
//		MODIFIES: this
//		EFFECTS: cancella dal blog il post identificato da code; solleva l'eccezione
//				 WrongCodePostException se non esiste un post con quel codice
		if(code<0 || code>postcode)
			throw new WrongCodePostException("The inserted post code is not valid");
		else {
			boolean removed = false;
			for(int i=0; i<posts.size() && !removed; i++) {
				if(posts.get(i).getCode()==code) {
					posts.remove(i);
					removed = true;
				}
			}
			if(!removed)
				throw new WrongCodePostException("The inserted post code is not valid");
		}
//		Il metodo non modifica this.bloggers, perciò se l'invariante di rappresentazione vale per this_pre, il secondo
//		termine continua a essere true anche per this_post. Resta da dimostrare che (A or B)=true.
//		Se il codice inserito non rientra nel range di codici utilizzati a partire dalla creazione del blog
//		allora viene sollevata un'eccezione ed è garantito che this resti invariato, perciò this_post verifica
//		l'invariante di rappresentazione per ipotesi induttiva.
//		Se invece il codice è ritenuto valido viene ricercato il post relativo: se la lista posts è vuota
//		oppure il post non è più presente nel blog viene sollevata un'eccezione ed è garantito che this
//		non venga modificato: anche in questo caso this_post verifica l'invariante di rappresentazione.
//		Se il post viene trovato (this.posts.size!=0) si possono verificare due casi dopo l'eliminazione:
//		- this_post.posts.size == 0; l'invariante di rappresentazione è verificato (A=true);
//		- this_post.posts.size > 0; va dimostrata la B, che è vera per la correttezza del metodo post (unico altro 
//		modo per modificare this.posts oltre a remove).
	}

	@Override
	public boolean emptyBlog() {
//		EFFECTS: restituisce true se e solo se il blog è vuoto
		return posts.isEmpty();
//		Metodo observer (non apporta modifiche)
	}

//	FUNZIONE DI ASTRAZIONE:
//	a(c) = [c.posts.get(i).getBlogger.getNickname: c.posts.get(i).getMessage per ogni 0 <= i < c.posts.size]
	public String toString() {
//		EFFECTS: restituisce una rappresentazione testuale di this
		return readAll().toString();
//		Metodo observer (non apporta modifiche)
	}
	
}
