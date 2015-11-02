package db;

import model.*;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author darkwizard
 */
public class CollectionRetriever {
	private static CollectionRetriever retr = null;
	private DBConnector conn = null;

	private CollectionRetriever() {
		this.conn = DBConnector.getInstance();
		this.conn.connect();
	}

	public static CollectionRetriever getInstance() {
		if (retr == null)
			retr = new CollectionRetriever();
		return retr;
	}

	public List<Object> getPubsOnResearchArea(String resArea) {
		String sqlQuery = "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Area\", \n" +
				"  public.\"PubArea\", \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Area\".\"ID\" = \"PubArea\".\"AreaID\" AND\n" +
				"  \"PubArea\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Area\".\"Name\" like '%"+ resArea + "%';";

		ResultSet result = conn.getRawQueryResult(sqlQuery);
		return this.processResult(result, Publication.class);
	}

	/* template
	public List<Object> getPublicationsOn...(String searchFor) {
		String query = ...;
		return this.processResult(conn.getRawQueryResult(query), Publication.class);
	}
	 */

	public List<Object> getPublicationsOnYear(String searchFor) {
		String query = "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Publication\".\"Year\" = " + searchFor + ";";
		return this.processResult(conn.getRawQueryResult(query), Publication.class);
	}

	public List<Object> getPublicationsOnVenueName(String searchFor) {
		String query = "SELECT \n" +
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
				"    \"Article\".\"JournalID\" IN (SELECT \"Journal\".\"ID\" from public.\"Journal\" where \"Journal\".\"Title\" = '" + searchFor + "')\n" +
				"\n" +
				"  UNION\n" +
				"\n" +
				"  SELECT \n" +
				"    \"Proceedings\".*\n" +
				"  FROM  \n" +
				"    public.\"Proceedings\"\n" +
				"  WHERE \n" +
				"    \"Proceedings\".\"ConferenceID\" IN (SELECT \"Conference\".\"ID\" from public.\"Conference\" where \"Conference\".\"Title\" = '" + searchFor + "')\n" +
				"\n" +
				"  UNION\n" +
				"\n" +
				"  SELECT \n" +
				"    \"Inproceedings\".*\n" +
				"  FROM  \n" +
				"    public.\"Inproceedings\"\n" +
				"  WHERE \n" +
				"    \"Inproceedings\".\"Crossref\" IN (\n" +
				"    SELECT \n" +
				"      \"Proceedings\".\"PubID\"\n" +
				"    FROM  \n" +
				"      public.\"Proceedings\"\n" +
				"    WHERE \n" +
				"      \"Proceedings\".\"ConferenceID\" IN (SELECT \"Conference\".\"ID\" from public.\"Conference\" where \"Conference\".\"Title\" = '" + searchFor + "')));\n" +
				"\n" +
				"\n";
		return this.processResult(conn.getRawQueryResult(query), Publication.class);
	}

	public List<Object> getPublicationsOnTitle(String searchFor) {
		String query = "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Publication\".\"Title\" like '%" + searchFor + "%';\n";
		return this.processResult(conn.getRawQueryResult(query), Publication.class);
	}

	public List<Object> getPublicationsOnKeyword(String searchFor) {
		String query = "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Keyword\", \n" +
				"  public.\"PubKeyword\", \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Keyword\".\"ID\" = \"PubKeyword\".\"AreaID\" AND\n" +
				"  \"PubKeyword\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"Keyword\".\"Word\" like '%" + searchFor + "%';\n";
		return this.processResult(conn.getRawQueryResult(query), Publication.class);
	}

	public List<Object> getPublicationsOnType(String searchFor) {
		String query = "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\"\n" +
				"WHERE \n" +
				"  \"Publication\".\"Type\" = '" + searchFor + "';";
		return this.processResult(conn.getRawQueryResult(query), Publication.class);
	}

	public List<Object> getPublicationsOnInstitution(String searchFor) {
		String query = "SELECT \n" +
				"  \"Publication\".*\n" +
				"FROM \n" +
				"  public.\"Publication\", \n" +
				"  public.\"InstAuthPub\", \n" +
				"  public.\"Institution\"\n" +
				"WHERE \n" +
				"  \"InstAuthPub\".\"PubID\" = \"Publication\".\"ID\" AND\n" +
				"  \"InstAuthPub\".\"InstID\" = \"Institution\".\"ID\" AND\n" +
				"  \"Institution\".\"Title\" like '%" + searchFor + "%';";
		return this.processResult(conn.getRawQueryResult(query), Publication.class);
	}

	public List<Object> getPubsOnAuthorName(String authorName) {
		String query = "SELECT \n" +
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
				"     where \"Author\".\"Name\" like '%" + authorName + "%'));";

		return this.processResult(conn.getRawQueryResult(query), Publication.class);
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
			while (rs.next()) {
				Publication publication = new Publication(pubId, rs.getString(1), rs.getInt(2), rs.getString(3));
				Area a = new Area(rs.getInt(4), rs.getString(5));
				Keyword keyword = new Keyword(rs.getInt(6), rs.getString(7));
				Publisher publisher = new Publisher(rs.getInt(8), rs.getString(9));

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

						ResultSet rs2 = conn.getRawQueryResult(query);
						while (rs2.next()) {
							Journal j = new Journal(rs2.getInt(1), rs2.getString(2), rs2.getString(3), rs2.getString(4), rs2.getString(5));
							Article art = new Article(publication, j.getJournalID(), rs2.getString(6));

							return new FullInfo(art, a, keyword, publisher);
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

							return new FullInfo(proc, a, keyword, publisher);
						}
						break;
					case "inproceedings":
						query = "SELECT \n" +
								"  \"Conference\".\"ID\", \n" +
								"  \"Conference\".\"Title\", \n" +
								"  \"Conference\".\"Volume\", \n" +
								"  \"Inproceedings\".\"Crossref\"\n" +
								"  \"Inproceedings\".\"Pages\", \n" +
								"FROM \n" +
								"  public.\"Proceedings\", \n" +
								"  public.\"Conference\", \n" +
								"  public.\"Inproceedings\"\n" +
								"WHERE \n" +
								"  \"Proceedings\".\"ConferenceID\" = \"Conference\".\"ID\" AND\n" +
								"  \"Inproceedings\".\"Crossref\" = \"Proceedings\".\"PubID\" AND\n" +
								"  \"Inproceedings\".\"PubID\" = " + pubId + ";";

						rs2 = conn.getRawQueryResult(query);
						while (rs2.next()) {
							Conference j = new Conference(rs2.getInt(1), rs2.getString(2), rs2.getString(3));
							Inproceedings inproc = new Inproceedings(publication, rs2.getInt(4), rs2.getString(5));

							return new FullInfo(inproc, a, keyword, publisher);
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

							return new FullInfo(j, a, keyword, publisher);
						}
						break;
					case "incollection":
						query = "SELECT \n" +
								"  \"Book\".\"Volume\", \n" +
								"  \"Incollection\".\"Crossref\", \n" +
								"  \"Incollection\".\"Pages\" \n" +
								"FROM \n" +
								"  public.\"Book\", \n" +
								"  public.\"Incollection\"\n" +
								"WHERE \n" +
								"  \"Incollection\".\"Crossref\" = \"Book\".\"PubID\" AND\n" +
								"  \"Incollection\".\"PubID\" = " + pubId + ";\n";

						rs2 = conn.getRawQueryResult(query);
						while (rs2.next()) {
							Book j = new Book(publication, rs2.getString(1));
							Incollection incoll = new Incollection(publication, rs2.getInt(2), rs2.getString(3));

							return new FullInfo(incoll, a, keyword, publisher);
						}
						break;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public List<Object> processResult(ResultSet result, Class collectionOf) {
		List<Object> answer = new LinkedList<>();

		try {
			while (result.next()) {
				Constructor c = collectionOf.getDeclaredConstructors()[0];
				Object[] array = new Object[c.getParameterCount()];
				for (int i = 0; i < c.getParameterCount(); ++i)
					array[i] = ("" + c.getParameterTypes()[i].getSimpleName()).compareTo("int") == 0
							? result.getInt(i + 1) : result.getString(i + 1);
				Object instance = c.newInstance(array);

				answer.add(instance);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return answer;
	}

	public List<Object> getCollection(Class<?> collectionOf, String searchFor) {
		// getting relation in which we will search, and generating query pattern
		String relationName = collectionOf.getSimpleName();
		String sqlQuery = "select * from \"" + relationName + "\" where ";

		// this string will be executed on every field of the class
		String likeBuilder = " LIKE '%" + searchFor + "%'";

		// generating list of attributes of the relation
		String attributesComparison = Arrays.asList(collectionOf.getDeclaredFields())
				.stream()
				.map(Field::getName)
				.map(name -> Character.toUpperCase(name.charAt(0)) + name.substring(1))
				.map(upperName -> "\"" + upperName + "\"")
				.map(enclosed -> enclosed + "::char(255)")
				.map(elem -> elem + likeBuilder)
				.collect(Collectors.joining(" OR "));

		System.out.println(attributesComparison);

		// final query is here
		sqlQuery += attributesComparison;
		ResultSet result = conn.getRawQueryResult(sqlQuery);

		return this.processResult(result, collectionOf);
	}
}
