import db.CollectionRetriever;
import db.CollectionUpdater;
import db.NotFoundException;
import model.FullInfo;
import model.User;
import spark.ModelAndView;
import spark.Request;
import spark.Response;
import spark.Spark;

import java.util.HashMap;
import java.util.Map;

public class RequestProcessor {
	private static final String USER_SESSION_ID = "user";
	public HashMap<String, String> emptyMapForRenderingNothing = new HashMap<>();

	public RequestProcessor() {
		Spark.staticFileLocation("/public"); // Static files
	}

	public ModelAndView login(Request req, Response res) {
		return new ModelAndView(emptyMapForRenderingNothing, "login");
	}

	public String authorize(Request req, Response res) {
		String username = req.queryParams("username");
		String password = req.queryParams("password");
		User user = CollectionRetriever.getInstance().getUser(username);
		if (user != null && user.getPassword().equals(password)) {
			addAuthenticatedUser(req, user);
			res.redirect("/");
			return null;
		}
		Spark.halt(400, "Bad username or password");
		return "";
	}

	public String register(Request req, Response res) {
		String username = req.queryParams("username");
		String password = req.queryParams("password");
		if (CollectionRetriever.getInstance().getUser(username) == null) {
			CollectionUpdater.getInstance().addUser(username, password);
		} else {
			Spark.halt(400, "User with such name already exists");
			return null;
		}
		res.redirect("/login");
		return "";
	}

	public ModelAndView getPublication(Request req, Response res) {
		int pubNumber = Integer.parseInt(req.params(":number"));
		FullInfo fi = CollectionRetriever.getInstance().getFullPublicationInfo(pubNumber);

		HashMap<String, Object> mapping = new HashMap<>();
		if (fi != null)
			mapping.put("data", fi);
		else {
			throw new NotFoundException();
		}

		return new ModelAndView(mapping, "page");
	}

	public ModelAndView getPublicationForUpdate(Request req, Response res) {
		int pubNumber = Integer.parseInt(req.params(":number"));
		FullInfo fi = CollectionRetriever.getInstance().getFullPublicationInfo(pubNumber);

		HashMap<String, Object> mapping = new HashMap<>();
		if (fi != null) {
			mapping.put("data", fi);
		} else {
			throw new NotFoundException();
		}

		return new ModelAndView(mapping, "update");
	}

	public ModelAndView updatePublication(Request req, Response res) {
		HashMap<String, String> params = new HashMap<>();
		for (Map.Entry<String, String[]> e : req.queryMap().toMap().entrySet()) {
			params.put(e.getKey(), e.getValue()[0]);
		}

		CollectionUpdater.getInstance().updatePublication(params);

		res.redirect("/publication/" + req.params(":number"));
		return null;
	}

	public ModelAndView deletePublication(Request req, Response res) {
		CollectionUpdater.getInstance().deletePublication(req.queryParams("type"), req.params(":number"));

		res.redirect("/");
		return null;
	}

	public ModelAndView addAuthor(Request req, Response res) {
		CollectionUpdater.getInstance()
				.addInstAuthPub(req.queryParams("name"), req.queryParams("alias"), req.queryParams("institution"), req.params(":number"));


		res.redirect("/publication/" + req.params(":number"));
		return null;
	}

	public ModelAndView removeAuthor(Request req, Response res) {
		CollectionUpdater.getInstance()
				.deleteInstAuthPub(req.queryParams("name"), req.params(":number"));

		res.redirect("/publication/" + req.params(":number"));
		return null;
	}

	public ModelAndView addReference(Request req, Response res) {
		CollectionUpdater.getInstance()
				.addReference(req.params(":number"), req.queryParams("RefPubID"));

		res.redirect("/publication/" + req.params(":number"));
		return null;
	}

	public ModelAndView removeReference(Request req, Response res) {
		CollectionUpdater.getInstance()
				.deleteReference(req.params(":number"), req.queryParams("RefPubID"));

		res.redirect("/publication/" + req.params(":number"));
		return null;
	}

	public ModelAndView search(Request req, Response res) {
		String searchFor = req.queryParams("query");
		String searchType = req.queryParams("type");
		String orderType = req.queryParams("order");
		String sortType = req.queryParams("sort");
		String offset = req.queryParams("offset") != null ? req.queryParams("offset") : "0";

		HashMap<String, Object> mapping = new HashMap<>();
		mapping.put("results", CollectionRetriever.getInstance()
				.getPublications(searchType, searchFor, offset, sortType, orderType));
		mapping.put("offset", offset);
		mapping.put("query", searchFor);
		mapping.put("type", searchType);
		mapping.put("order", orderType);
		mapping.put("sort", sortType);

		return new ModelAndView(mapping, "searchresult");
	}

	public ModelAndView addPublication(Request req, Response res) {
		HashMap<String, String> params = new HashMap<>();
		for (Map.Entry<String, String[]> e : req.queryMap().toMap().entrySet()) {
			params.put(e.getKey(), e.getValue()[0]);
		}

		int id = CollectionUpdater.getInstance().addPublication(params);

		res.redirect("/publication/" + id);
		return null;
	}

	public ModelAndView index(Request req, Response res) {
		return new ModelAndView(emptyMapForRenderingNothing, "index");
	}

	private void addAuthenticatedUser(Request req, User u) {
		req.session().attribute(USER_SESSION_ID, u);
	}
}
