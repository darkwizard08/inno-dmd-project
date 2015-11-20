package db;

import model.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class CollectionUpdater {
	private static CollectionUpdater updtr = null;
	private final HashMap<String, String> update, delete, insert;
	private DBConnector conn = null;

	private CollectionUpdater() {
		this.conn = DBConnector.getInstance();
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
		try {
			// Check references
			if (params.get("type").equals("inproceedings") || params.get("type").equals("incollection")) {
				params.put("crossref", getReference(params));
				if (params.get("crossref") == null) {
					throw new NotFoundException();
				}
			}

			String query = String.format(insert.get("publication"), params.get("title"), params.get("year"), params.get("type"));
			ResultSet rs = conn.getRawQueryResult(query);
			rs.next();
			params.put("ID", Integer.toString(rs.getInt(1)));

			params.put("cID", addCollection(params));

			// Preprocess
			params.put("pages", params.get("pages").length() > 0 ? "'" + params.get("pages") + "'" : "NULL");
			params.put("volume", params.get("volume").length() > 0 ? "'" + params.get("volume") + "'" : "NULL");

			query = insert.get(params.get("type"));
			switch (params.get("type")) {
				case "article":
					query = String.format(query,
							params.get("ID"), params.get("cID"), params.get("pages"));
					break;
				case "inproceedings":
					query = String.format(query,
							params.get("ID"), params.get("crossref"), params.get("pages"));
					break;
				case "proceedings":
					query = String.format(query,
							params.get("ID"), params.get("cID"));
					break;
				case "incollection":
					query = String.format(query,
							params.get("ID"), params.get("crossref"), params.get("pages"));
					break;
				case "book":
					query = String.format(query,
							params.get("ID"), params.get("volume"));
					break;
			}
			conn.executeNonQuery(query);

			addAreaKeywordPublisher(params);
			return Integer.parseInt(params.get("ID"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
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
		String query;

		if (params.get("area").length() > 0) {
			Area area = CollectionRetriever.getInstance().getArea(params.get("area"));
			if (area == null) {
				area = addArea(params.get("area"));
			}
			query = String.format(delete.get("pubArea"), params.get("ID"));
			conn.executeNonQuery(query);
			query = String.format(insert.get("pubArea"), params.get("ID"), area.getID());
			conn.executeNonQuery(query);
		}
		if (params.get("keyword").length() > 0) {
			Keyword keyword = CollectionRetriever.getInstance().getKeyword(params.get("keyword"));
			if (keyword == null) {
				keyword = addKeyword(params.get("keyword"));
			}
			query = String.format(delete.get("pubKeyword"), params.get("ID"));
			conn.executeNonQuery(query);
			query = String.format(insert.get("pubKeyword"), params.get("ID"), keyword.getID());
			conn.executeNonQuery(query);
		}
		if (params.get("publisher").length() > 0) {
			Publisher publisher = CollectionRetriever.getInstance().getPublisher(params.get("publisher"));
			if (publisher == null) {
				publisher = addPublisher(params.get("publisher"));
			}
			query = String.format(delete.get("published"), params.get("ID"));
			conn.executeNonQuery(query);
			query = String.format(insert.get("published"), params.get("ID"), publisher.getID());
			conn.executeNonQuery(query);
		}
	}

	public void updatePublication(Map<String, String> params) {
		// Check references
		params.put("crossref", getReference(params));
		if (params.get("crossref") == null) {
			throw new NotFoundException();
		}

		String query = String.format(update.get("publication"),
				params.get("title"), params.get("year"), params.get("ID"));
		conn.executeNonQuery(query);

		params.put("cID", addCollection(params));

		// Preprocess
		params.put("pages", params.get("pages").length() > 0 ? "'" + params.get("pages") + "'" : "NULL");
		params.put("volume", params.get("volume").length() > 0 ? "'" + params.get("volume") + "'" : "NULL");

		query = update.get(params.get("type"));
		switch (params.get("type")) {
			case "article":
				query = String.format(query,
						params.get("cID"), params.get("pages"), params.get("ID"));
				break;
			case "proceedings":
				query = String.format(query,
						params.get("cID"), params.get("ID"));
				break;
			case "inproceedings":
				query = String.format(query,
						params.get("crossref"), params.get("pages"), params.get("ID"));
				break;
			case "incollection":
				query = String.format(query,
						params.get("crossref"), params.get("pages"), params.get("ID"));
				break;
			case "book":
				query = String.format(query,
						params.get("volume"), params.get("ID"));
				break;
		}
		conn.executeNonQuery(query);

		addAreaKeywordPublisher(params);
	}

	public void deletePublication(String type, String ID) {
		String query = String.format(delete.get("publication"), ID);
		conn.executeNonQuery(query);
		query = String.format(delete.get(type), ID);
		conn.executeNonQuery(query);
		query = String.format(delete.get("pubArea"), ID);
		conn.executeNonQuery(query);
		query = String.format(delete.get("pubKeyword"), ID);
		conn.executeNonQuery(query);
		query = String.format(delete.get("instAuthPub"), ID);
		conn.executeNonQuery(query);
		query = String.format(delete.get("published"), ID);
		conn.executeNonQuery(query);
	}

	public void addUser(String name, String pass) {
		String query = "insert into \"User\"(\"Username\", \"Password\") " +
				"values ('" + name + "', '" + pass + "')";
		conn.executeNonQuery(query);
	}

	public Journal addJournal(String title, String volume, String number) {
		try {
			String query = "insert into \"Journal\"(\"Title\", \"Volume\", \"Number\") " +
					"values ('" + title + "', "
					+ (volume.length() == 0 ? "NULL, " : "'" + volume + "', ")
					+ (number.length() == 0 ? "NULL" : "'" + number + "'") + ") returning \"ID\"";
			ResultSet rs = conn.getRawQueryResult(query);
			rs.next();
			return new Journal(rs.getInt(1), title, volume, number, null);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public Conference addConference(String title, String volume) {
		try {
			String query = "insert into \"Conference\"(\"Title\", \"Volume\") " +
					"values ('" + title + "', " +
					(volume.length() == 0 ? "NULL, " : "'" + volume + "', ") + ") returning \"ID\"";
			ResultSet rs = conn.getRawQueryResult(query);
			rs.next();
			return new Conference(rs.getInt(1), title, volume);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public Area addArea(String name) {
		try {
			String query = "insert into \"Area\"(\"Name\") " +
					"values ('" + name + "') returning \"ID\"";
			ResultSet rs = conn.getRawQueryResult(query);
			rs.next();
			return new Area(rs.getInt(1), name);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public Keyword addKeyword(String word) {
		try {
			String query = "insert into \"Keyword\"(\"Word\") " +
					"values ('" + word + "') returning \"ID\"";
			ResultSet rs = conn.getRawQueryResult(query);
			rs.next();
			return new Keyword(rs.getInt(1), word);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public Institution addInstitution(String title) {
		try {
			String query = "insert into \"Institution\"(\"Title\") " +
					"values ('" + title + "') returning \"ID\"";
			ResultSet rs = conn.getRawQueryResult(query);
			rs.next();
			return new Institution(rs.getInt(1), title);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public Publisher addPublisher(String name) {
		try {
			String query = "insert into \"Publisher\"(\"Name\") " +
					"values ('" + name + "') returning \"ID\"";
			ResultSet rs = conn.getRawQueryResult(query);
			rs.next();
			return new Publisher(rs.getInt(1), name);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public Author addAuthor(String name, String alias) {
		try {
			Author auth = null;
			if (alias.length() > 0) {
				auth = CollectionRetriever.getInstance().getAuthor(alias);
			}
			String query = "insert into \"Author\"(" + (auth != null ? "\"ID\", " : "") + "\"Name\") " +
					"values (" + (auth != null ? auth.getID() + ", " : "") + "'" + name + "') returning \"ID\"";
			ResultSet rs = conn.getRawQueryResult(query);
			rs.next();
			return new Author(rs.getInt(1), name);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
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
		Author auth = CollectionRetriever.getInstance().getAuthor(author);
		if (auth == null) {
			auth = addAuthor(author, alias);
		}
		String query = String.format(insert.get("instAuthPub"), PubID, inst != null ? inst.getID() : null, author);
		conn.executeNonQuery(query);
	}

	public void deleteInstAuthPub(String author, String PubID) {
		String query = "DELETE\n" +
				"FROM \n" +
				"  public.\"InstAuthPub\"\n" +
				"WHERE \n" +
				"  \"InstAuthPub\".\"PubID\" = " + PubID + " AND \n" +
				"  \"InstAuthPub\".\"Author\" = '" + author + "'";
		conn.executeNonQuery(query);
	}

	public void addReference(String PubID, String RefPubID) {
		if (CollectionRetriever.getInstance().getFullPublicationInfo(Integer.parseInt(RefPubID)) != null) {
			String query = String.format(insert.get("referenced"), PubID, RefPubID);
			conn.executeNonQuery(query);
		}
	}

	public void deleteReference(String PubID, String RefPubID) {
		String query = String.format(delete.get("referenced"), PubID, RefPubID);
		conn.executeNonQuery(query);
	}
}