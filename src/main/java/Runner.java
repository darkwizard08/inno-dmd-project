/**
 * @author darkwizard
 */

import spark.template.jade.JadeTemplateEngine;

import static spark.Spark.get;
import static spark.Spark.post;

public class Runner {
	public static void main(String[] args) {
		new Runner().run();
	}

	public void run() {
		RequestProcessor proc = new RequestProcessor();

		get("/", (req, res) -> {res.redirect("/login"); return "Moving...";});
		get("/login", proc::login, new JadeTemplateEngine());
		get("/index", proc::index, new JadeTemplateEngine());
		get("/search", proc::search, new JadeTemplateEngine());
		post("/authorize", proc::authorize);
		get("/publication/:number", proc::getPublication, new JadeTemplateEngine());
		get("/publication/:number/update", proc::getPublicationForUpdate, new JadeTemplateEngine());
		get("/add", proc::addPublication, new JadeTemplateEngine());
	}


}
