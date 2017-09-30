/**
 * @author Alessandra Fais
 */

package blog;

public class Blogger {
	private String nickname = null;
	
	public Blogger(String nickname) {
		this.nickname = nickname;
	}

	@Override
	public boolean equals(Object b) {
		return(((Blogger) b).getNickname().equals(this.getNickname()));
	}
	
	public String getNickname() {
		return nickname;
	}
}
