import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import db.CollectionRetriever;
import model.Article;
import spark.ModelAndView;
import spark.Request;
import spark.Response;
import spark.Spark;

/**
 * @author darkwizard
 */
public class RequestProcessor {

	public RequestProcessor() {
		Spark.staticFileLocation("/public"); // Static files
	}

	public HashMap<String, String> emptyMapForRenderingNothing = new HashMap<>();

	public ModelAndView login(Request r, Response response) {
		return new ModelAndView(emptyMapForRenderingNothing, "login");
	}

	public String authorize(Request r, Response response) {
		String username = r.queryParams("username");
		String password = r.queryParams("password");

		if ("admin".compareTo(username) == 0 && "admin".compareTo(password) == 0)
			response.redirect("/index");

		Spark.halt(401, "Access denied!");
		return "";
	}

	public ModelAndView search(Request r, Response res) {
		String searchFor = r.queryParams("searchFor");
		String searchType = r.queryParams("searchType");

		System.out.println(searchType);
		HashMap<String, Object> mapping = new HashMap<>();

		switch (searchType) {
			case "researchArea":
				mapping.put("results", CollectionRetriever.getInstance().getPubsOnResearchArea(searchFor));
				break;
			case "authorName":
				mapping.put("results", CollectionRetriever.getInstance().getPubsOnAuthorName(searchFor));
				break;
			case "pubYear":
				mapping.put("results", CollectionRetriever.getInstance().getPublicationsOnYear(searchFor));
				break;
			case "pubTitle":
				mapping.put("results", CollectionRetriever.getInstance().getPublicationsOnTitle(searchFor));
				break;
			case "keyword":
				mapping.put("results", CollectionRetriever.getInstance().getPublicationsOnKeyword(searchFor));
				break;
			case "pubType":
				mapping.put("results", CollectionRetriever.getInstance().getPublicationsOnType(searchFor));
				break;
			default:
				System.out.println("Unknown case :(");
		}

		return new ModelAndView(mapping, "searchresult");
	}

	public ModelAndView index(Request r, Response response) {
		return new ModelAndView(emptyMapForRenderingNothing, "index");
	}
}
