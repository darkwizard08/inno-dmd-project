package db;

import model.*;
import phase3.CommandProcessor;
import phase3.model.tuple.Tuple;

import java.lang.reflect.Constructor;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class CollectionRetriever {
	private static CollectionRetriever retr = null;
	private final HashMap<String, String> queries, orderings, sortings, sortAttributes;
	private final String limitOffset = "\nLIMIT %s\n" +
			"OFFSET %s", orderBy = "\nORDER BY %s %s";
	private final HashSet<String> types;
	private final CommandProcessor cp;
	private DBConnector conn = null;

	private CollectionRetriever() {
		this.cp = new CommandProcessor();
		this.queries = new HashMap<>();
		this.orderings = new HashMap<>();
		this.sortings = new HashMap<>();
		this.sortAttributes = new HashMap<>();
		types = new HashSet<>(Arrays.asList("article", "proceedings", "inproceedings", "incollection", "book"));

		orderings.put("year", "\"Publication\".\"Year\"");
		orderings.put("cite", "rank_cnt");
		orderings.put(null, "");

		sortings.put("cite", "LEFT OUTER JOIN (SELECT \n" +
				"  \"Referenced\".\"RefPubID\", COUNT(\"Referenced\".\"PubID\") as count\n" +
				"FROM\n" +
				"  public.\"Referenced\"\n" +
				"GROUP BY\n" +
				"  \"Referenced\".\"RefPubID\") AS rank ON (rank.\"RefPubID\" = \"Publication\".\"ID\")\n");
		sortings.put("year", "");
		sortings.put(null, "");

		sortAttributes.put("cite", ",\n" +
				" coalesce(rank.count, 0) as rank_cnt");
		sortAttributes.put("year", "");
		sortAttributes.put(null, "");

		queries.put("researchArea", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Area\", \n" +
				"  public.\"PubArea\", \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Area\".\"ID\" = \"PubArea\".\"AreaID\" AND\n" +
				"  \"PubArea\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Area\".\"Name\" like '%%%s%%'");

		queries.put("authorName", "SELECT DISTINCT \n" +
				" \"Publication\".*\n" +
				"FROM \n" +
				" public.\"InstAuthPub\", \n" +
				" public.\"Publication\"\n" +
				"WHERE \n" +
				" \"Publication\".\"ID\" = \"InstAuthPub\".\"PubID\" AND\n" +
				" \"InstAuthPub\".\"Author\" IN (\n" +
				"   select \"Author\".\"Name\" \n" +
				"   from public.\"Author\" \n" +
				"   where \"Author\".\"ID\" in (\n" +
				"     select \"Author\".\"ID\"\n" +
				"     from public.\"Author\"\n" +
				"     where \"Author\".\"Name\" like '%%%s%%'))");

		queries.put("pubYear", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Publication\".\"Year\" = %s");

		queries.put("pubTitle", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Publication\".\"Title\" like '%%%s%%'");

		queries.put("keyword", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Keyword\", \n" +
				"  public.\"PubKeyword\", \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Keyword\".\"ID\" = \"PubKeyword\".\"KeywordID\" AND\n" +
				"  \"PubKeyword\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Keyword\".\"Word\" like '%%%s%%'");

		queries.put("pubType", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\", \n" +
				"  public.\"%1$s\"\n" +
				"WHERE \n" +
				"  \"%1$s\".\"PubID\" = \"Publication\".\"ID\"");

		queries.put("references", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\", \n" +
				"  public.\"Referenced\"\n" +
				"WHERE \n" +
				"  \"Referenced\".\"RefPubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Referenced\".\"PubID\" = %s");

		queries.put("citedBy", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\", \n" +
				"  public.\"Referenced\"\n" +
				"WHERE \n" +
				"  \"Referenced\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Referenced\".\"RefPubID\" = %s");

		queries.put("institution", "SELECT DISTINCT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\", \n" +
				"  public.\"InstAuthPub\", \n" +
				"  public.\"Institution\"\n" +
				"WHERE \n" +
				"  \"InstAuthPub\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"InstAuthPub\".\"InstID\" = \"Institution\".\"ID\" AND\n" +
				"  \"Institution\".\"Title\" like '%%%s%%'");

		queries.put("venue", "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE\n" +
				"  \"Publication\".\"ID\" IN (\n" +
				"  SELECT \n" +
				"    \"Article\".\"PubID\"\n" +
				"  FROM  \n" +
				"    public.\"Article\"\n" +
				"  WHERE \n" +
				"    \"Article\".\"JournalID\" IN (SELECT \"Journal\".\"ID\" from public.\"Journal\" where \"Journal\".\"Title\" like '%%%1$s%%')\n" +
				"\n" +
				"  UNION\n" +
				"\n" +
				"  SELECT \n" +
				"    \"Proceedings\".\"PubID\"\n" +
				"  FROM  \n" +
				"    public.\"Proceedings\"\n" +
				"  WHERE \n" +
				"    \"Proceedings\".\"ConferenceID\" IN (SELECT \"Conference\".\"ID\" from public.\"Conference\" where \"Conference\".\"Title\" like '%%%1$s%%')\n" +
				"\n" +
				"  UNION\n" +
				"\n" +
				"  SELECT \n" +
				"    \"Inproceedings\".\"PubID\"\n" +
				"  FROM  \n" +
				"    public.\"Inproceedings\"\n" +
				"  WHERE \n" +
				"    \"Inproceedings\".\"Crossref\" IN (\n" +
				"    SELECT \n" +
				"      \"Proceedings\".\"PubID\"\n" +
				"    FROM  \n" +
				"      public.\"Proceedings\"\n" +
				"    WHERE \n" +
				"      \"Proceedings\".\"ConferenceID\" IN (SELECT \"Conference\".\"ID\" from public.\"Conference\" where \"Conference\".\"Title\" like '%%%1$s%%')))");
	}

	public static CollectionRetriever getInstance() {
		if (retr == null)
			retr = new CollectionRetriever();
		return retr;
	}

	/* template
	public List<Object> getPublicationsOn...(String searchFor) {
		String query = ...;
		return this.processResult(conn.getRawQueryResult(query), Publication.class);
	}
	 */

	public List<Object> getPublications(String searchType, String searchFor, String offset, String sortType, String orderType) {
		if (searchType.equals("pubType")) {
			searchFor = searchFor.toLowerCase();
			if (!types.contains(searchFor.toLowerCase())) {
				return null;
			}
			searchFor = Character.toUpperCase(searchFor.charAt(0)) + searchFor.substring(1);
		}

		/*String query = String.format(queries.get(searchType), searchFor, offset);
		query = new StringBuffer(
				query)
				.insert(query.indexOf("WHERE"), sortings.get(sortType))
				.insert(query.indexOf("WHERE"), "CROSS JOIN (" + query.replace("\"Publication\".*", "COUNT(DISTINCT \"Publication\".\"ID\")") + ") AS count\n")
				.insert(query.indexOf("\nFROM"), sortAttributes.get(sortType))
				.insert(query.indexOf("\nFROM"), ",\n" +
						" count.count") +
				(sortType != null ? String.format(orderBy, orderings.get(sortType), orderType.toUpperCase()) : String.format(orderBy, "\"Publication\".\"ID\"", "ASC")) +
				String.format(limitOffset, "50", offset);
		ResultSet rs = conn.getRawQueryResult(query);
		List<Object> result = this.processResult(rs, PublicationSearchResult.class);*/
		List<Tuple> instAuthPub = cp.scan("InstAuthPub").list(),
				institution = cp.scan("Institution").list();

		switch (searchType) {
			case "researchArea":
				List<Tuple> area = cp.scan("Area")
						.filter("Area.Name = " + searchFor)
						.list(),
						pubArea = cp.scan("PubArea")
								.list();
				cp.scan("Publication")
						.join(pubArea, "Publication.ID", "PubArea.PubID", "INNER")
						.join(area, "PubArea.AreaID", "Area.ID", "INNER")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "pubYear":
				cp.scan("Publication")
						.filter("Publication.Year = " + searchFor);
				break;
			case "pubTitle":
				cp.scan("Publication")
						.filter("Publication.Title");
				break;
			case "keyword":
				List<Tuple> keyword = cp.scan("Keyword")
						.filter("Keyword.Word = " + searchFor)
						.list(),
						pubKeyword = cp.scan("PubKeyword")
								.list();
				cp.scan("Publication")
						.join(pubKeyword, "Publication.ID", "PubKeyword.PubID", "INNER")
						.join(keyword, "PubKeyword.KeywordID", "Keyword.ID", "INNER")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "pubType":
				List<Tuple> type = cp.scan(searchFor).list();
				cp.scan("Publication")
						.join(type, "Publication.ID", searchFor + ".ID", "INNER")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "references":
				List<Tuple> referenced = cp.scan("Referenced")
						.filter("Referenced.PubID = " + searchFor)
						.list();
				cp.scan("Publication")
						.join(referenced, "Publication.ID", "Referenced.RefPubID", "INNER")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
			case "citedBy":
				referenced = cp.scan("Referenced")
						.filter("Referenced.RefPubID = " + searchFor)
						.list();
				cp.scan("Publication")
						.join(referenced, "Publication.ID", "Referenced.PubID", "INNER")
						.project("Publication.ID", "Publication.Title", "Publication.Year", "Publication.Type");
				break;
		}

		cp.count("*").offset(Integer.parseInt(offset))
				.limit(50);

		List<Object> result = this.processResult(cp.list(), PublicationSearchResult.class);
		return result.size() == 0 ? null : result;
	}

	public FullInfo getFullPublicationInfo(int pubId) {
		String query = "SELECT \n" +
				"  \"Publication\".\"Title\", \n" +
				"  \"Publication\".\"Year\", \n" +
				"  \"Publication\".\"Type\", \n" +
				"  \"Area\".\"ID\", \n" +
				"  \"Area\".\"Name\", \n" +
				"  \"Keyword\".\"ID\", \n" +
				"  \"Keyword\".\"Word\", \n" +
				"  \"Publisher\".\"ID\", \n" +
				"  \"Publisher\".\"Name\" \n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"    LEFT OUTER JOIN public.\"PubArea\" ON (\"PubArea\".\"PubID\" = \"Publication\".\"ID\") \n" +
				"    LEFT OUTER JOIN public.\"PubKeyword\" ON (\"PubKeyword\".\"PubID\" = \"Publication\".\"ID\") \n" +
				"    LEFT OUTER JOIN public.\"Area\" ON (\"PubArea\".\"AreaID\" = \"Area\".\"ID\")\n" +
				"    LEFT OUTER JOIN public.\"Keyword\" ON (\"PubKeyword\".\"KeywordID\" = \"Keyword\".\"ID\")\n" +
				"    LEFT OUTER JOIN public.\"Published\" ON (\"Published\".\"PublicationID\" = \"Publication\".\"ID\")\n" +
				"    LEFT OUTER JOIN public.\"Publisher\" ON (\"Published\".\"PublisherID\" = \"Publisher\".\"ID\")\n" +
				"WHERE \n" +
				"  \"Publication\".\"ID\" = " + pubId + ";";

		ResultSet rs = conn.getRawQueryResult(query);
		try {
			if (rs.next()) {
				Publication publication = new Publication(pubId, rs.getString(1), rs.getInt(2), rs.getString(3));
				Area a = new Area(rs.getInt(4), rs.getString(5));
				Keyword keyword = new Keyword(rs.getInt(6), rs.getString(7));
				Publisher publisher = new Publisher(rs.getInt(8), rs.getString(9));

				ResultSet rs2;
				FullInfo result = null;
				switch (publication.getType()) {
					case "article":
						query = "SELECT \n" +
								"  \"Journal\".\"ID\", \n" +
								"  \"Journal\".\"Title\", \n" +
								"  \"Journal\".\"Volume\", \n" +
								"  \"Journal\".\"Number\", \n" +
								"  \"Journal\".\"Name\", \n" +
								"  \"Article\".\"Pages\"\n" +
								"FROM \n" +
								"  public.\"Article\", \n" +
								"  public.\"Journal\"\n" +
								"WHERE \n" +
								"  \"Article\".\"JournalID\" = \"Journal\".\"ID\" AND\n" +
								"  \"Article\".\"PubID\" = " + pubId + ";\n";

						rs2 = conn.getRawQueryResult(query);
						while (rs2.next()) {
							Journal j = new Journal(rs2.getInt(1), rs2.getString(2), rs2.getString(3), rs2.getString(4), rs2.getString(5));
							Article art = new Article(publication, j.getJournalID(), rs2.getString(6));
							result = new FullInfo(art, a, keyword, publisher);
							result.setAddition(j);
						}
						break;
					case "proceedings":
						query = "SELECT \n" +
								"  \"Conference\".\"ID\", \n" +
								"  \"Conference\".\"Title\", \n" +
								"  \"Conference\".\"Volume\"\n" +
								"FROM \n" +
								"  public.\"Proceedings\", \n" +
								"  public.\"Conference\"\n" +
								"WHERE \n" +
								"  \"Proceedings\".\"ConferenceID\" = \"Conference\".\"ID\" AND\n" +
								"  \"Proceedings\".\"PubID\" = " + pubId + ";\n";

						rs2 = conn.getRawQueryResult(query);
						while (rs2.next()) {
							Conference j = new Conference(rs2.getInt(1), rs2.getString(2), rs2.getString(3));
							Proceedings proc = new Proceedings(publication, j.getConferenceID());
							result = new FullInfo(proc, a, keyword, publisher);
							result.setAddition(j);
						}
						break;
					case "inproceedings":
						query = "SELECT \n" +
								"  \"Inproceedings\".\"Crossref\"\n" +
								"  \"Inproceedings\".\"Pages\", \n" +
								"FROM \n" +
								"  public.\"Inproceedings\"\n" +
								"WHERE \n" +
								"  \"Inproceedings\".\"PubID\" = " + pubId + ";";

						rs2 = conn.getRawQueryResult(query);
						while (rs2.next()) {
							Inproceedings inproc = new Inproceedings(publication, rs2.getInt(1), rs2.getString(2));
							result = new FullInfo(inproc, a, keyword, publisher);
							result.setAddition(getFullPublicationInfo(rs2.getInt(1)));
						}
						break;
					case "book":
						query = "SELECT \n" +
								"  \"Book\".\"Volume\"\n" +
								"FROM \n" +
								"  public.\"Book\"\n" +
								"WHERE \n" +
								"  \"Book\".\"PubID\" = " + pubId + ";";

						rs2 = conn.getRawQueryResult(query);
						while (rs2.next()) {
							Book j = new Book(publication, rs2.getString(1));
							result = new FullInfo(j, a, keyword, publisher);
						}
						break;
					case "incollection":
						query = "SELECT \n" +
								"  \"Incollection\".\"Crossref\", \n" +
								"  \"Incollection\".\"Pages\" \n" +
								"FROM \n" +
								"  public.\"Incollection\"\n" +
								"WHERE \n" +
								"  \"Incollection\".\"PubID\" = " + pubId + ";\n";

						rs2 = conn.getRawQueryResult(query);
						while (rs2.next()) {
							Incollection incoll = new Incollection(publication, rs2.getInt(1), rs2.getString(2));
							result = new FullInfo(incoll, a, keyword, publisher);
							result.setAddition(getFullPublicationInfo(rs2.getInt(1)));
						}
						break;
				}
				query = "SELECT \n" +
						"  \"Author\".\"ID\",\n" +
						"  \"InstAuthPub\".\"Author\", \n" +
						"  \"Institution\".\"ID\",\n" +
						"  \"Institution\".\"Title\"\n" +
						"FROM \n" +
						"  public.\"InstAuthPub\" \n" +
						"    LEFT OUTER JOIN public.\"Institution\" ON (\"InstAuthPub\".\"InstID\" = \"Institution\".\"ID\") \n" +
						"    JOIN \"Author\" ON (\"InstAuthPub\".\"Author\" = \"Author\".\"Name\")\n" +
						"WHERE \n" +
						"   \"InstAuthPub\".\"PubID\" = " + pubId + ";";
				if (result != null) {
					//List<Object> authors = this.processResult(conn.getRawQueryResult(query), Author.class);
					//result.setAuthors(authors);
				}
				return result;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public List<Object> processResult(List<Tuple> result, Class collectionOf) {
		return processResult(result, collectionOf, 0);
	}

	public List<Object> processResult(List<Tuple> result, Class collectionOf, int constID) {
		List<Object> answer = new LinkedList<>();

		try {
			for (Tuple t : result) {
				Constructor c = collectionOf.getDeclaredConstructors()[constID];
				Object[] array = new Object[c.getParameterCount()];
				for (int i = 0; i < c.getParameterCount(); ++i)
					array[i] = ("" + c.getParameterTypes()[i].getSimpleName()).compareTo("int") == 0
							? Integer.parseInt(t.get(i + 1)) : t.get(i + 1);
				Object instance = c.newInstance(array);

				answer.add(instance);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return answer;
	}

	public User getUser(String name) {
		/*String query = "SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"User\"\n" +
				"WHERE \n" +
				"  \"User\".\"Username\" ='" + name + "'\n";*/
		List<Tuple> res = cp.scan("User").filter("User.Username = " + name).list();
		List<Object> result = processResult(res, User.class);
		return result.size() > 0 ? (User) result.get(0) : null;
	}

	public Journal getJournal(String title, String volume, String number) {
		String query = "SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Journal\"\n" +
				"WHERE \n" +
				"  \"Journal\".\"Title\" = '" + title + "' AND \n" +
				"  \"Journal\".\"Volume\" = '" + volume + "' AND \n" +
				"  \"Journal\".\"Number\" = '" + number + "'";
		//List<Object> result = processResult(conn.getRawQueryResult(query), Journal.class);
		//return result.size() > 0 ? (Journal) result.get(0) : null;
		return null;
	}

	public Conference getConference(String title, String volume) {
		String query = "SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Conference\"\n" +
				"WHERE \n" +
				"  \"Conference\".\"Title\" = '" + title + "' AND \n" +
				"  \"Conference\".\"Volume\" = '" + volume + "'\n";
		//List<Object> result = processResult(conn.getRawQueryResult(query), Conference.class);
		//return result.size() > 0 ? (Conference) result.get(0) : null;
		return null;
	}

	public Book getBook(String title, String year, String volume) {
		String query = "SELECT \n" +
				"  \"Publication\".\"ID\", \n" +
				"  \"Publication\".\"Title\", \n" +
				"  \"Publication\".\"Year\", \n" +
				"  \"Book\".\"Volume\"\n" +
				"FROM \n" +
				"  public.\"Book\", \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Book\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Publication\".\"Title\" = '" + title + "' AND \n" +
				"  \"Publication\".\"Year\" = " + year + " AND \n" +
				"  \"Book\".\"Volume\" = '" + volume + "'";
		//List<Object> result = processResult(conn.getRawQueryResult(query), Book.class);
		//return result.size() > 0 ? (Book) result.get(0) : null;
		return null;
	}

	public Proceedings getProceedings(String title, String year) {
		String query = "SELECT \n" +
				"  \"Publication\".\"ID\", \n" +
				"  \"Publication\".\"Title\", \n" +
				"  \"Publication\".\"Year\", \n" +
				"  \"Book\".\"Volume\"\n" +
				"FROM \n" +
				"  public.\"Book\", \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Book\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Publication\".\"Title\" = '" + title + "' AND \n" +
				"  \"Publication\".\"Year\" = " + year;
		//List<Object> result = processResult(conn.getRawQueryResult(query), Proceedings.class);
		//return result.size() > 0 ? (Proceedings) result.get(0) : null;
		return null;
	}

	public Area getArea(String name) {
		String query = "SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Area\"\n" +
				"WHERE \n" +
				"  \"Area\".\"Name\" = '" + name + "'";
		//List<Object> result = processResult(conn.getRawQueryResult(query), Area.class);
		//return result.size() > 0 ? (Area) result.get(0) : null;
		return null;
	}

	public Keyword getKeyword(String word) {
		String query = "SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Keyword\"\n" +
				"WHERE \n" +
				"  \"Keyword\".\"Word\" = '" + word + "'";
		//List<Object> result = processResult(conn.getRawQueryResult(query), Keyword.class);
		//return result.size() > 0 ? (Keyword) result.get(0) : null;
		return null;
	}

	public Institution getInstitution(String title) {
		String query = "SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Institution\"\n" +
				"WHERE \n" +
				"  \"Institution\".\"Title\" = '" + title + "'";
		//List<Object> result = processResult(conn.getRawQueryResult(query), Institution.class);
		//return result.size() > 0 ? (Institution) result.get(0) : null;
		return null;
	}

	public Publisher getPublisher(String name) {
		String query = "SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Publisher\"\n" +
				"WHERE \n" +
				"  \"Publisher\".\"Name\" = '" + name + "'";
		//List<Object> result = processResult(conn.getRawQueryResult(query), Publisher.class);
		//return result.size() > 0 ? (Publisher) result.get(0) : null;
		return null;
	}

	public Author getAuthor(String name) {
		String query = "SELECT \n" +
				"  * \n" +
				"FROM \n" +
				"  public.\"Author\"\n" +
				"WHERE \n" +
				"  \"Author\".\"Name\" = '" + name + "'";
		//List<Object> result = processResult(conn.getRawQueryResult(query), Author.class, 1);
		//return result.size() > 0 ? (Author) result.get(0) : null;
		return null;
	}

	public List<Object> getCrossreferenced(String type, String ID) {
		type = Character.toUpperCase(type.charAt(0)) + type.substring(1);
		String query = String.format("SELECT \n" +
				"  \"Publication\".* \n" +
				"FROM \n" +
				"  public.\"Publication\", \n" +
				"  public.\"%1$s\"\n" +
				"WHERE \n" +
				"  \"%1$s\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"%1$s\".\"Crossref\" = %2$s;", type, ID);
		//return processResult(conn.getRawQueryResult(query), Publication.class);
		return null;
	}
}
