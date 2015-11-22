/**
 * @author darkwizard
 */

import db.NotFoundException;
import model.User;
import phase3.CommandProcessor;
import spark.ModelAndView;
import spark.Request;
import spark.template.jade.JadeTemplateEngine;

import java.util.HashMap;

import static spark.Spark.*;

public class Runner {
	private static final String USER_SESSION_ID = "user";
	private static final CommandProcessor cp = new CommandProcessor();

	public static void main(String[] args) {
		new Runner().run();
	}

	public void run() {
		RequestProcessor proc = new RequestProcessor();

		before("/*", (req, res) -> {
			User user = getAuthenticatedUser(req);
			if (user == null && !req.pathInfo().equals("/register") && !req.pathInfo().equals("/login") && !req.pathInfo().matches("/.*\\.css")) {
				res.redirect("/login");
				halt();
			} else if (user != null && (req.pathInfo().equals("/register") || req.pathInfo().equals("/login"))) {
				res.redirect("/");
				halt();
			}
		});

		get("/", (req, res) -> {
			res.redirect("/index");
			return null;
		});
		get("/login", proc::login, new JadeTemplateEngine());
		post("/login", proc::authorize);
		post("/register", proc::register);
		get("/index", proc::index, new JadeTemplateEngine());
		get("/search", proc::search, new JadeTemplateEngine());

		get("/publication/:number", proc::getPublication, new JadeTemplateEngine());
		get("/publication/:number/update", proc::getPublicationForUpdate, new JadeTemplateEngine());
		post("/publication/:number/update", proc::updatePublication);
		post("/publication/:number/delete", proc::deletePublication);
		post("/publication/:number/author/remove", proc::removeAuthor);
		post("/publication/:number/author/add", proc::addAuthor);
		post("/publication/:number/reference/remove", proc::removeReference);
		post("/publication/:number/reference/add", proc::addReference);

		get("/add", (req, res) -> {
			HashMap<String, Object> mapping = new HashMap<>();
			mapping.put("type", req.queryParams("type"));
			return new ModelAndView(mapping, "add");
		}, new JadeTemplateEngine());
		post("/add", proc::addPublication);

		exception(NotFoundException.class, (e, request, response) -> {
			response.status(404);
			response.body("Resource not found");
		});

		get("/stop", (request, response) -> {
			cp.close();
			stop();
			return null;
		});
	}

	private User getAuthenticatedUser(Request req) {
		return req.session().attribute(USER_SESSION_ID);
	}
}
