package db;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import model.InstAuthPub;
import model.Publication;

/**
 * @author darkwizard
 */
public class CollectionRetriever {
	private DBConnector conn = null;
	private static CollectionRetriever retr = null;

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
