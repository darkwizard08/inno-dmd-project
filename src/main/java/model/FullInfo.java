package model;

import java.util.List;

/**
 * @author darkwizard
 */
public class FullInfo {
	public Publication publication;
	public Area area;
	public Keyword word;
	public Publisher publisher;
	public Object addition;
	public List<Author> authors;

	public FullInfo(Publication publication, Area area, Keyword word, Publisher publisher) {
		this.publication = publication;
		this.area = area;
		this.word = word;
		this.publisher = publisher;
	}

	public Object getAddition() {
		return addition;
	}

	public void setAddition(Object addition) {
		this.addition = addition;
	}
}
