/**
 * @author Alessandra Fais
 */

package blog;

import java.util.LinkedList;

import exceptions.EmptyPostException;
import exceptions.UnauthorizedAccessException;
import exceptions.UnauthorizedBloggerException;
import exceptions.WrongCodePostException;

public class BlogTest2 {

	public static void main(String[] args) throws UnauthorizedAccessException, WrongCodePostException, UnauthorizedBloggerException, EmptyPostException {
		String psw = "test";
		Blog b = new Blog(psw);

		
		/* Test emptyBlog */
		
		if(b.emptyBlog())
			System.out.println("Test0: OK -> emptyBlog()");
		else {
			System.out.println("Test0: ERROR -> emptyBlog()");			
			System.exit(1);
		}
		
		
		/* Test addBlogger */
		
		//Aggiunta blogger nuovo con password corretta
		b.addBlogger(new Blogger("Pippo"), psw);
		try {
			b.post("Ciao", new Blogger("Pippo"));
			System.out.println("Test1: OK -> addBlogger(Blogger bob, String pass)");
		}
		catch(UnauthorizedBloggerException e) {
			System.out.println("Test1: ERROR -> addBlogger(Blogger bob, String pass) - "+e.getMessage());
			System.exit(1);
		}

		//Aggiunta blogger nuovo con password non corretta (solleva eccezione)
		try {
			b.addBlogger(new Blogger("Pluto"), "ciao");
			throw new Exception();
		}
		catch(UnauthorizedAccessException e) {
			System.out.println("Test2: OK -> addBlogger(Blogger bob, String pass) - "+e.getMessage());
		}
		catch(Exception e) {
			System.out.println("Test2: ERROR -> addBlogger(Blogger bob, String pass)");
			System.exit(1);
		}
		
		//Aggiunta blogger nuovi con password corretta
		b.addBlogger(new Blogger("Pappo"), psw);
		b.addBlogger(new Blogger("Popo"), psw);
		b.addBlogger(new Blogger("Pluto"), psw);
		
		//Aggiunta blogger già presente con password corretta (l'insieme dei blogger resta invariato)
		b.addBlogger(new Blogger("Pluto"), psw);
		
		//Tutti gli utenti aggiunti sono blogger attivi (possono inserire correttamente post)
		try {
			b.post("Ciao", new Blogger("Pippo"));
			b.post("Ciao", new Blogger("Pappo"));
			b.post("Ciao", new Blogger("Popo"));
			b.post("Ciao", new Blogger("Pluto"));
			System.out.println("Test3: OK -> addBlogger(Blogger bob, String pass)");
		}
		catch(UnauthorizedBloggerException e) {
			System.out.println("Test3: ERROR -> addBlogger(Blogger bob, String pass) - "+e.getMessage());
			System.exit(1);
		}

		
		/* Test deleteBlogger */
		
		//Eliminazione blogger attivo con password corretta
		b.deleteBlogger(new Blogger("Pippo"), psw);
		
		//Il blogger è stato eliminato correttamente: non può più postare messaggi (eccezione)
		try {
			b.post("Ciao", new Blogger("Pippo"));
			System.out.println("Test4: ERROR -> deleteBlogger(Blogger bob, String pass)");
			System.exit(1);
		}
		catch(UnauthorizedBloggerException e) {
			System.out.println("Test4: OK -> deleteBlogger(Blogger bob, String pass) - "+e.getMessage());
		}
		
		//Eliminazione blogger attivo con password non corretta (solleva eccezione)
		try {
			b.deleteBlogger(new Blogger("Pluto"), "ciao");
			throw new Exception();
		}
		catch(UnauthorizedAccessException e) {
			System.out.println("Test5: OK -> deleteBlogger(Blogger bob, String pass) - "+e.getMessage());
		}
		catch(Exception e) {
			System.out.println("Test5: ERROR -> deleteBlogger(Blogger bob, String pass)");
			System.exit(1);
		}
		
		//Eliminazione blogger attivi con password corretta
		b.deleteBlogger(new Blogger("Pippo"), psw);
		b.deleteBlogger(new Blogger("Pappo"), psw);
		b.deleteBlogger(new Blogger("Pluto"), psw);

		//Eliminazione post inseriti: il blog torna vuoto
		for(int i=0; i<5; i++)
			b.delete(i);

		if(b.emptyBlog())
			System.out.println("Test6: OK -> delete()");
		else {
			System.out.println("Test6: ERROR -> delete()");		
			System.exit(1);
		}
		
		
		/* Test post e read/readAll */
		
		//Aggiunta post e controllo sull'ultimo post inserito nel blog
		int popo1 = b.post("Ciao da Popo", new Blogger("Popo"));
		if(b.readLast().equals("Popo: Ciao da Popo"))
			System.out.println("Test7: OK -> readLast()");
		else {
			System.out.println("Test7: ERROR -> readLast()");
			System.exit(1);
		}
		
		//Aggiunta post da parte di un blogger non attivo (solleva eccezione)
		try {
			b.post("Ciao da Pluto", new Blogger("Pluto"));
			throw new Exception();
		}
		catch(UnauthorizedBloggerException e) {
			System.out.println("Test8: OK -> post(String message, Blogger bob) - "+e.getMessage());
		}
		catch(Exception e) {
			System.out.println("Test8: ERROR -> post(String message, Blogger bob)");
			System.exit(1);
		}
		
		//Aggiunta post da parte di blogger attivi
		b.addBlogger(new Blogger("Pippo"), psw);
		b.addBlogger(new Blogger("Pappo"), psw);
		int pippo1 = b.post("Ciao da Pippo", new Blogger("Pippo"));
		int pappo1 = b.post("Ciao da Pappo", new Blogger("Pappo"));
		int pappo2 = b.post("Ciao ciao da Pappo", new Blogger("Pappo"));
		
		//Controllo sull'ultimo post inserito da un blogger
		try {
			b.readLast(new Blogger("Pippo")).equals("Ciao da Pippo");
			System.out.println("Test9: OK -> readLast(Blogger bob)");
		}
		catch(EmptyPostException e) {
			System.out.println("Test9: ERROR -> readLast(Blogger bob)");
			System.exit(1);
		}
		
		//Controllo su tutti i post presenti correntemente nel blog
		LinkedList<String> l = new LinkedList<String>();
		l.add("Popo: Ciao da Popo");
		l.add("Pippo: Ciao da Pippo");
		l.add("Pappo: Ciao da Pappo");
		l.add("Pappo: Ciao ciao da Pappo");
		if(b.readAll().equals(l))
			System.out.println("Test10: OK -> readAll()");
		else {
			System.out.println("Test10: ERROR -> readAll()");
			System.exit(1);
		}
		
		//Controllo su tutti i post scritti da un certo blogger e presenti nel blog
		LinkedList<String> l1 = new LinkedList<String>();
		l1.add("Ciao da Pappo");
		l1.add("Ciao ciao da Pappo");
		if(b.readAll(new Blogger("Pappo")).equals(l1))
			System.out.println("Test11: OK -> readAll(Blogger bob)");
		else {
			System.out.println("Test11: ERROR -> readAll(Blogger bob)");
			System.exit(1);
		}
		
	
		/* Test delete */
		
		//Codici dei post inseriti: popo1 = 5, pippo1 = 6, pappo1 = 7, pappo2 = 8
		
		//Eliminazione di un post con codice non corretto: non esiste nessun post
		//identificato dal codice inserito (solleva eccezione)
		try{
			b.delete(2);
			throw new Exception();
		}
		catch(WrongCodePostException e) {
			System.out.print("Test12: OK -> delete(int code) - "+e.getMessage());
			System.out.format(" - Codes in use are %d, %d, %d, %d.%n", popo1, pippo1, pappo1, pappo2);
		}
		catch(Exception e) {
			System.out.println("Test12: ERROR -> delete(int code)");
			System.exit(1);
		}
		
		//Eliminazione corretta di un post
		b.delete(pappo1);
		
		//Controllo sull'eliminazione del post dal blog
		l.remove("Pappo: Ciao da Pappo");
		if(b.readAll().equals(l))
			System.out.println("Test13: OK -> delete(int code)");
		else {
			System.out.println("Test13: ERROR -> delete(int code)");
			System.exit(1);
		}
		
		l1.remove("Ciao da Pappo");
		if(b.readAll(new Blogger("Pappo")).equals(l1))
			System.out.println("Test14: OK -> delete(int code)");
		else {
			System.out.println("Test14: ERROR -> delete(int code)");
			System.exit(1);
		}
			
		b.delete(popo1);
		try {
			b.readLast(new Blogger("Popo")).equals("Ciao da Popo");
			System.out.println("Test15: ERROR -> readLast(Blogger bob)");
			System.exit(1);
		}
		catch(EmptyPostException e) {
			System.out.println("Test15: OK -> readLast(Blogger bob) - "+e.getMessage());
		}
		
		
		/* Test emptyBlog */
		
		if(!b.emptyBlog())
			System.out.println("Test16: OK -> emptyBlog()");
		else {
			System.out.println("Test16: ERROR -> emptyBlog()");
			System.exit(1);
		}
		
		
		/* Test Funzione di Astrazione */
		
		System.out.println("\nFunzione di Astrazione: "+b.toString());
	}

}