package model;

/**
 * @author darkwizard
 */
public class Keyword {
	public int ID;
	public String word;

	public Keyword(int ID, String word) {
		this.ID = ID;
		this.word = word;
	}

	public int getID() {
		return ID;
	}

	public void setID(int ID) {
		this.ID = ID;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}
}
