package phase3.model;

import phase3.model.tuple.Tuple;

/**
 * @author darkwizard
 */
public class Operator {
	private String field;
	private String operator;
	private String arg;

	public Operator(String... params) {
		this.field = params[0];
		this.operator = params[1].toUpperCase();
		this.arg = params[2];
		// "Author.Name" "in" "Vasya Petrov, Petya Ivanov"
	}

	public boolean matches(Tuple tuple) {
		String value = tuple.get(this.field);
		if (value == null || value.isEmpty())
			throw new Error("Operation can't be implemented! Tuple is empty, or incorrect Operator passed!");

		try {
			int arg = Integer.parseInt(this.arg);
			int compare = Integer.parseInt(tuple.get(this.field));
			return compare(compare, arg);

		} catch (NumberFormatException e) {
			// comparing as Strings, ok!
		}

		// okay, can perform operator
		// TODO: write reflection here
		return compare(value, this.arg);
	}

	public boolean like(String compare, String pattern) {
		// Something like %ething%
		pattern = pattern.toUpperCase();
		return compare.toUpperCase().contains(pattern);
	}

	public boolean in(String compare, String value) {
		String[] values = value.split(", ");
		for (String v : values)
			if (v.equals(compare))
				return true;

		return false;
	}

	public boolean compare(Comparable left, Comparable right) {
		switch (this.operator) {
			case "=":
				return left.compareTo(right) == 0;
			case "LIKE":
				return like(left.toString(), right.toString());
			case "IN":
				return in(left.toString(), right.toString());
			default:
				throw new Error("No such operator found!");
		}
	}
}
