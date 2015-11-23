package db;

import model.*;
import phase3.CommandProcessor;
import phase3.model.tuple.Tuple;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CollectionUpdater {
	private static CollectionUpdater updtr = null;
	private final HashMap<String, String> update, delete, insert;
	private DBConnector conn = null;
	private CommandProcessor cp;

	private CollectionUpdater() {
		this.cp = new CommandProcessor();
		update = new HashMap<>();
		delete = new HashMap<>();
		insert = new HashMap<>();

		update.put("publication", "UPDATE \n" +
				"  public.\"Publication\"\n" +
				"SET\n" +
				"  \"Title\" = '%s', \"Year\" = %s\n" +
				"WHERE\n" +
				"  \"ID\" = %s");
		update.put("article", "UPDATE\n" +
				"  public.\"Article\"\n" +
				"SET\n" +
				"  \"JournalID\" = %s,\"Pages\" = %s\n" +
				"WHERE   \n" +
				"  \"PubID\" = %s");
		update.put("inproceedings", "UPDATE\n" +
				"  public.\"Inproceedings\"\n" +
				"SET \n" +
				"  \"Crossref\" = %s, \"Pages\" = %s\n" +
				"WHERE \n" +
				"  \"PubID\" = %s");
		update.put("proceedings", "UPDATE\n" +
				"  public.\"Proceedings\"\n" +
				"SET  \n" +
				"  \"ConferenceID\" = %s\n" +
				"WHERE \n" +
				"  \"PubID\" = %s");
		update.put("incollection", "UPDATE\n" +
				"  public.\"Incollection\"\n" +
				"SET\n" +
				"  \"Crossref\" = %s, \"Pages\" = %s\n" +
				"WHERE\n" +
				"  \"PubID\" = %s");
		update.put("book", "UPDATE\n" +
				"  public.\"Book\"\n" +
				"SET\n" +
				"  \"Volume\" = %s\n" +
				"WHERE\n" +
				"  \"PubID\" = %s");

		delete.put("publication", "DELETE \n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE\n" +
				"  \"ID\" = %s");
		delete.put("article", "DELETE \n" +
				"FROM \n" +
				"  public.\"Article\"\n" +
				"WHERE\n" +
				"  \"PubID\" = %s");
		delete.put("proceedings", "DELETE\n" +
				"FROM \n" +
				"  public.\"Proceedings\"\n" +
				"WHERE \n" +
				"  \"PubID\" = %s");
		delete.put("inproceedings", "DELETE\n" +
				"FROM \n" +
				"  public.\"Inroceedings\"\n" +
				"WHERE \n" +
				"  \"PubID\" = %s");
		delete.put("book", "DELETE\n" +
				"FROM \n" +
				"  public.\"Book\"\n" +
				"WHERE \n" +
				"  \"PubID\" = %s");
		delete.put("incollection", "DELETE\n" +
				"FROM \n" +
				"  public.\"Incollection\"\n" +
				"WHERE \n" +
				"  \"PubID\" = %s");

		delete.put("pubArea", "DELETE\n" +
				"FROM \n" +
				"  public.\"PubArea\"\n" +
				"WHERE \n" +
				"  \"PubID\" = %s");
		delete.put("pubKeyword", "DELETE\n" +
				"FROM \n" +
				"  public.\"PubKeyword\"\n" +
				"WHERE \n" +
				"  \"PubID\" = %s");
		delete.put("instAuthPub", "DELETE\n" +
				"FROM \n" +
				"  public.\"InstAuthPub\"\n" +
				"WHERE \n" +
				"  \"PubID\" = %s");
		delete.put("published", "DELETE\n" +
				"FROM \n" +
				"  public.\"Published\"\n" +
				"WHERE \n" +
				"  \"PublicationID\" = %s");
		delete.put("referenced", "DELETE\n" +
				"FROM \n" +
				"  public.\"Referenced\"\n" +
				"WHERE \n" +
				"  \"Referenced\".\"PubID\" = %s AND \n" +
				"  \"Referenced\".\"RefPubID\" = %s");

		insert.put("publication", "INSERT \n" +
				"INTO \n" +
				"  \"Publication\"(\"Title\", \"Year\", \"Type\")\n" +
				"VALUES\n" +
				"  ('%s', %s, '%s')\n" +
				"RETURNING\n" +
				"  \"ID\"");

		insert.put("article", "INSERT \n" +
				"INTO\n" +
				"  \"Article\"(\"PubID\", \"JournalID\", \"Pages\")\n" +
				"VALUES\n" +
				"  (%s, %s, %s)");
		insert.put("inproceedings", "INSERT\n" +
				"INTO\n" +
				"  \"Inproceedings\"(\"PubID\", \"Crossref\", \"Pages\")\n" +
				"VALUES\n" +
				"  (%s, %s, %s)");
		insert.put("proceedings", "INSERT \n" +
				"INTO\n" +
				"  \"Proceedings\"(\"PubID\", \"ConferenceID\")\n" +
				"VALUES\n" +
				"  (%s, %s)");
		insert.put("incollection", "INSERT\n" +
				"INTO\n" +
				"  \"Incollection\"(\"PubID\", \"Crossref\", \"Pages\")\n" +
				"VALUES\n" +
				"  (%s, %s, %s)");
		insert.put("book", "INSERT\n" +
				"INTO\n" +
				"  \"Book\"(\"PubID\", \"Volume\")\n" +
				"VALUES\n" +
				"  (%s, %s)");

		insert.put("instAuthPub", "INSERT \n" +
				"INTO\n" +
				"  \"InstAuthPub\"(\"PubID\", \"InstID\", \"Author\")\n" +
				"VALUES\n" +
				"  (%s, %s, '%s')");
		insert.put("pubArea", "INSERT\n" +
				"INTO \n" +
				"  \"PubArea\"(\"PubID\", \"AreaID\")\n" +
				"VALUES \n" +
				"  (%s, %s)");
		insert.put("pubKeyword", "INSERT\n" +
				"INTO \n" +
				"  \"PubKeyword\"(\"PubID\", \"KeywordID\")\n" +
				"VALUES\n" +
				"  (%s, %s)");
		insert.put("published", "INSERT\n" +
				"INTO\n" +
				"  \"Published\"(\"PublicationID\", \"PublisherID\")\n" +
				"VALUES\n" +
				"  (%s, %s)");
		insert.put("referenced", "INSERT\n" +
				"INTO\n" +
				"  \"Referenced\"(\"PubID\", \"RefPubID\")\n" +
				"VALUES\n" +
				"  (%s, %s)");
	}

	public static CollectionUpdater getInstance() {
		if (updtr == null) {
			updtr = new CollectionUpdater();
		}
		return updtr;
	}

	public int addPublication(Map<String, String> params) {
			// Check references
			if (params.get("type").equals("inproceedings") || params.get("type").equals("incollection")) {
				params.put("crossref", getReference(params));
				if (params.get("crossref") == null) {
					throw new NotFoundException();
				}
			}


		String id = getNewID("Publication", "Publication.ID");
		cp.insert("Publication", getNewID("Publication", "Publication.id"), id, params.get("title"), params.get("year"), params.get("type"));

		params.put("ID", id);

			params.put("cID", addCollection(params));


			switch (params.get("type")) {
				case "article":

					cp.insert("Article", id("Article"), params.get("ID"), params.get("cID"), params.get("pages"));
					break;
				case "inproceedings":

					cp.insert("Inproceedings", id("Inproceedings"), params.get("ID"), params.get("crossref"), params.get("pages"));
					break;
				case "proceedings":

					cp.insert("Proceedings", id("Proceedings"), params.get("ID"), params.get("cID"));
					break;
				case "incollection":

					cp.insert("Incollection", id("Incollection"), params.get("ID"), params.get("crossref"), params.get("pages"));
					break;
				case "book":

					cp.insert("Book", id("Book"), params.get("ID"), params.get("volume"));
					break;
			}

			addAreaKeywordPublisher(params);
			return Integer.parseInt(params.get("ID"));
	}

	public String addCollection(Map<String, String> params) {
		switch (params.get("type")) {
			case "article":
				Journal journal = CollectionRetriever.getInstance()
						.getJournal(params.get("journal"), params.get("volume"), params.get("number"));
				if (journal == null) {
					journal = addJournal(params.get("journal"), params.get("volume"), params.get("number"));
				}
				return Integer.toString(journal.getJournalID());
			case "proceedings":
				Conference conference = CollectionRetriever.getInstance()
						.getConference(params.get("conference"), params.get("volume"));
				if (conference == null) {
					conference = addConference(params.get("conference"), params.get("volume"));
				}
				return Integer.toString(conference.getConferenceID());
		}
		return "";
	}

	public String getReference(Map<String, String> params) {
		Publication publication = null;
		switch (params.get("type")) {
			case "inproceedings":
				publication = CollectionRetriever.getInstance()
						.getProceedings(params.get("proceedings"), params.get("proceedingsyear"));
				break;
			case "incollection":
				publication = CollectionRetriever.getInstance()
						.getBook(params.get("book"), params.get("bookyear"), params.get("volume"));
				break;
		}
		return publication != null ? Integer.toString(publication.getID()) : null;
	}

	public void addAreaKeywordPublisher(Map<String, String> params) {

		cp.scan("PubArea").filter("PubArea.PubID = " + params.get("ID")).delete("PubArea");

		cp.scan("PubKeyword").filter("PubKeyword.PubID = " + params.get("ID")).delete("PubKeyword");

		cp.scan("Published").filter("Published.PublicationID = " + params.get("ID")).delete("Published");

		if (params.get("area").length() > 0) {
			Area area = CollectionRetriever.getInstance().getArea(params.get("area"));
			if (area == null) {
				area = addArea(params.get("area"));
			}

			cp.insert("PubArea", id("PubArea"), params.get("ID"), Integer.toString(area.getID()));
		}

		if (params.get("keyword").length() > 0) {
			Keyword keyword = CollectionRetriever.getInstance().getKeyword(params.get("keyword"));
			if (keyword == null) {
				keyword = addKeyword(params.get("keyword"));
			}

			cp.insert("PubKeyword", id("PubKeyword"), params.get("ID"), Integer.toString(keyword.getID()));
		}
		if (params.get("publisher").length() > 0) {
			Publisher publisher = CollectionRetriever.getInstance().getPublisher(params.get("publisher"));
			if (publisher == null) {
				publisher = addPublisher(params.get("publisher"));
			}

			cp.insert("Published", id("Published"), params.get("ID"), Integer.toString(publisher.getID()));
		}
	}

	public void updatePublication(Map<String, String> params) {
		// Check references
		if (params.get("type").equals("inproceedings") || params.get("type").equals("incollection")) {
			params.put("crossref", getReference(params));
			if (params.get("crossref") == null) {
				throw new NotFoundException();
			}
		}


		cp.scan("Publication")
				.filter("Publication.ID = " + params.get("ID"))
				.set("Publication.Title", params.get("title"))
				.set("Publication.Year", params.get("year"))
				.update("Publication");

		params.put("cID", addCollection(params));

		switch (params.get("type")) {
			case "article":

				cp.scan("Article")
						.filter("Article.PubID = " + params.get("ID"))
						.set("Article.JournalID", params.get("cID"))
						.set("Article.Pages", params.get("pages"))
						.update("Article");
				break;
			case "proceedings":

				cp.scan("Proceedings")
						.filter("Proceedings.PubID = " + params.get("ID"))
						.set("Proceedings.ConferenceID", params.get("cID"))
						.update("Proceedings");
				break;
			case "inproceedings":

				cp.scan("Inproceedings")
						.filter("Inproceedings.PubID = " + params.get("ID"))
						.set("Inproceedings.Crossref", params.get("crossref"))
						.set("Inproceedings.Pages", params.get("pages"))
						.update("Inproceedings");
				break;
			case "incollection":

				cp.scan("Incollection")
						.filter("Incollection.PubID = " + params.get("ID"))
						.set("Incollection.Crossref", params.get("crossref"))
						.set("Incollection.Pages", params.get("pages"))
						.update("Incollection");
				break;
			case "book":

				cp.scan("Book")
						.filter("Book.PubID = " + params.get("ID"))
						.set("Book.Volume", params.get("volume"))
						.update("Book");
				break;
		}

		addAreaKeywordPublisher(params);
	}

	public void deletePublication(String type, String ID) {
		type = Character.toUpperCase(type.charAt(0)) + type.substring(1);

		cp.scan("Publication").filter("Publication.ID = " + ID).delete("Publication");

		cp.scan(type).filter(type + ".ID = " + ID).delete(type);

		cp.scan("PubArea").filter("PubArea.PubID = " + ID).delete("PubArea");

		cp.scan("PubKeyword").filter("PubKeyword.PubID = " + ID).delete("PubKeyword");

		cp.scan("InstAuthPub").filter("InstAuthPub.PubID = " + ID).delete("InstAuthPub");

		cp.scan("Published").filter("Published.PublicationID = " + ID).delete("Published");

		cp.scan("Referenced").filter("Referenced.PubID = " + ID).delete("Referenced");
		cp.scan("Referenced").filter("Referenced.RefPubID = " + ID).delete("Referenced");
		if (type.equals("Book") || type.equals("Proceedings")) {
			List<Object> publication = CollectionRetriever.getInstance().getCrossreferenced(type.equals("Book") ? "incollection" : "inproceedings", ID);
			for (Object o : publication) {
				Publication p = (Publication) o;
				deletePublication(p.type, Integer.toString(p.ID));
			}
		}
	}

	public String id(String table){
		return getNewID(table, table + ".id");
	}

	public int i(String conv) {
		return Integer.parseInt(conv);
	}

	public void addUser(String name, String pass) {
		cp.insert("User", getNewID("User", "User.id"), getNewID("User", "User.ID"), name, pass);
	}

	public Journal addJournal(String title, String volume, String number) {
		int newId = i(getNewID("Journal", "Journal.ID"));
		cp.init().insert("Journal",
				id("Journal"), newId + "",
				title, volume, number, "");

		return new Journal(newId, title, volume, number, null);

	}

	public Conference addConference(String title, String volume) {
		int newId = i(getNewID("Conference", "Conference.ID"));
		cp.init().insert("Conference", id("Conference"), newId + "", title, volume);

		return new Conference(newId, title, volume);
	}

	public Area addArea(String name) {
		int newId = i(getNewID("Area", "Area.ID"));
		cp.init().insert("Area", id("Area"), newId + "", name);

		return new Area(newId, name);
	}

	public Keyword addKeyword(String word) {
		int newId = i(getNewID("Keyword", "Keyword.ID"));
		cp.init().insert("Keyword", id("Keyword"), newId + "", word);

		return new Keyword(newId, word);
	}

	public Institution addInstitution(String title) {
		int newId = i(getNewID("Institution", "Institution.ID"));
		cp.init().insert("Institution", id("Institution"), newId + "", title);

		return new Institution(newId, title);
	}

	public Publisher addPublisher(String name) {
		int newId = i(getNewID("Publisher", "Publisher.ID"));
		cp.init().insert("Publisher", id("Publisher"), newId + "", name);

		return new Publisher(newId, name);
	}

	public Author addAuthor(String name, String alias) {
		Author auth = null;
		int newId;
		if (alias.length() > 0) {
			auth = CollectionRetriever.getInstance().getAuthor(alias);
		}
		newId = auth != null ? auth.getID() : i(getNewID("Author", "Author.ID"));
		cp.init().insert("Author", id("Author"), newId + "", name);

		return new Author(newId, name);
	}

	public void addInstAuthPub(String author, String alias, String institution, String PubID) {
		if (author.length() == 0) {
			return;
		}
		Institution inst = null;

		if (institution.length() > 0) {
			inst = CollectionRetriever.getInstance()
					.getInstitution(institution);

			if (inst == null) {
				inst = addInstitution(institution);
			}
		}
		if (CollectionRetriever.getInstance().getAuthor(author) == null) {
			addAuthor(author, alias);
		}
		
		cp.init().insert("InstAuthPub", id("InstAuthPub"),
				PubID, inst != null ? inst.getID() + "" : "", author);
	}

	public void deleteInstAuthPub(String author, String PubID) {
		cp.init().scan("InstAuthPub")
				.filter("InstAuthPub.PubID = " + PubID)
				.filter("InstAuthPub.Author = " + author)
				.delete("InstAuthPub");
	}

	public void addReference(String PubID, String RefPubID) {
		if (CollectionRetriever.getInstance().getFullPublicationInfo(Integer.parseInt(RefPubID)) != null) {
			cp.insert("Referenced", id("Referenced"), PubID, RefPubID);
		}
	}

	public void deleteReference(String PubID, String RefPubID) {
		cp.init().scan("Referenced")
				.filter("Referenced.PubID = " + PubID)
				.filter("Referenced.RefPubID = " + RefPubID)
				.delete("Referenced");
	}

	public String getNewID(String table, String attribute) {
		List<Tuple> res = cp.scan(table)
				.sort(attribute, "DESC")
				.limit(1)
				.list();
		return res.size() == 1 ? (Integer.parseInt(res.get(0).get(attribute)) + 1) + "" : 1 + "";
	}
}