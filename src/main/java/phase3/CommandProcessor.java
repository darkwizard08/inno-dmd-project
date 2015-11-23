package phase3;

import phase3.model.Operator;
import phase3.model.tuple.Tuple;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

public class CommandProcessor {
	private DataManager dm = new DataManager();
	private List<Tuple> resultSet = new ArrayList<>();

	/**
	 * initialises list
	 *
	 * @return processor with defined list
	 */
	public CommandProcessor init() {
		resultSet = new ArrayList<>();
		return this;
	}

	/**
	 * scanning entire file
	 *
	 * @param table - is name of table to scan
	 * @return processor with defined list
	 */
	public CommandProcessor scan(String table) {
		this.resultSet = dm.scan(table);
		return this;
	}

	/**
	 * select entities attributes from the table
	 * @param table is table name from which to select
	 * @param attribute is field of the entity to select
	 * @param condition is condition to filter by
	 * @return processor with defined list

	public CommandProcessor select(String table, String attribute, String condition){
	return this.scan(table).project(attribute).filter(condition);
	}
	 */

	/**
	 * filter tuples by the condition
	 *
	 * @param condition to filter by
	 * @return processor with defined list
	 */
	public CommandProcessor filter(String condition) {
		String[] args = condition.split(" ");
		// will be "field operator arg"
		Operator op = new Operator(args);

		this.resultSet = resultSet.stream()
				.filter(op::matches)
				.collect(Collectors.toList());

		return this;
	}

	/**
	 * make a projection of the given attribute to the table
	 *
	 * @param attributes is field of the entity to project
	 * @return processor with defined list
	 */
	public CommandProcessor project(String... attributes) {
		List<Tuple> res = new ArrayList<>();

		for (Tuple t : resultSet) {
			Tuple nt = new Tuple(attributes);
			nt.copy(t);
			res.add(nt);
		}

		this.resultSet = res;

		return this;
	}

	/**
	 * sort the tuples
	 *
	 * @param attribute - on what we will sort
	 * @param order     - ASC | DESC
	 * @return processor with defined list
	 */
	public CommandProcessor sort(String attribute, String order) {
		this.resultSet = this.resultSet.stream().sorted((o1, o2) -> {
			switch (order) {
				case "ASC":
					try {
						int arg = Integer.parseInt(o1.get(attribute)),
								compare = Integer.parseInt(o2.get(attribute));
						return Integer.compare(arg, compare);
					} catch (NumberFormatException e) {

					}
					return o1.get(attribute).compareTo(o2.get(attribute));
				case "DESC":
					try {
						int arg = Integer.parseInt(o1.get(attribute)),
								compare = Integer.parseInt(o2.get(attribute));
						return Integer.compare(compare, arg);
					} catch (NumberFormatException e) {

					}
					return o2.get(attribute).compareTo(o1.get(attribute));
				default:
					throw new Error("Can't sort this tuple!");
			}
		}).collect(Collectors.toList());

		return this;
	}

	/**
	 * join certain number of tables
	 *
	 * @param anotherTable is tables to join
	 * @return processor with defined list
	 */
	public CommandProcessor join(List<Tuple> anotherTable, String onLeft, String onRight, String joinType) {
		List<Tuple> finalSet = new ArrayList<>();

		if (joinType.equals("CROSS")) {
			for (Tuple t : resultSet) {
				for (Tuple t2 : anotherTable) {
					Tuple res = new Tuple(t.getKeys());
					res.build(t.serialize());
					res.merge(t2);
					finalSet.add(res);
				}
			}
			this.resultSet = finalSet;
			return this;
		}

		for (int i = 0; i < this.resultSet.size(); ++i) {
			Tuple merging = this.resultSet.get(i);
			int num = merging.getKeys().size();
			anotherTable
					.stream()
					.filter(tuple -> merging.get(onLeft).equals(tuple.get(onRight)))
					.forEach(merging::merge);

			if (merging.getKeys().size() > num) {
				System.out.println("Merged " + merging);
				finalSet.add(merging);
			} else if (joinType.equals("LEFT OUTER")) {
				if (anotherTable.size() > 0) {
					Tuple t = new Tuple(anotherTable.get(0).getKeys());
					merging.merge(t);
				}
				finalSet.add(merging);
				System.out.println("LEFT OUTER MERGE");
			}
		}

		this.resultSet = finalSet;
		return this;
	}

	public CommandProcessor join(String tableName, List<Tuple> anotherTable, String onLeft, String onRight, String joinType) {
		List<String> tableAttrs = dm.getTable(tableName).attributes();
		List<Tuple> finalSet = new ArrayList<>();

		if (joinType.equals("CROSS")) {
			for (Tuple t : resultSet) {
				for (Tuple t2 : anotherTable) {
					Tuple res = new Tuple(t.getKeys());
					res.build(t.serialize());
					res.merge(t2);
					finalSet.add(res);
				}
			}
			this.resultSet = finalSet;
			return this;
		}

		for (int i = 0; i < this.resultSet.size(); ++i) {
			Tuple merging = this.resultSet.get(i);
			int num = merging.getKeys().size();
			anotherTable
					.stream()
					.filter(tuple -> merging.get(onLeft).equals(tuple.get(onRight)))
					.forEach(merging::merge);

			if (merging.getKeys().size() > num) {
				System.out.println("Merged " + merging);
				finalSet.add(merging);
			} else if (joinType.equals("LEFT OUTER")) {
				Tuple t = new Tuple(anotherTable.size() > 0 ? anotherTable.get(0).getKeys() : tableAttrs);
				merging.merge(t);
				finalSet.add(merging);
				System.out.println("LEFT OUTER MERGE");
			}
		}

		this.resultSet = finalSet;
		return this;
	}

	public CommandProcessor join(List<String> attributes, List<Tuple> anotherTable, String onLeft, String onRight, String joinType) {
		List<Tuple> finalSet = new ArrayList<>();

		if (joinType.equals("CROSS")) {
			for (Tuple t : resultSet) {
				for (Tuple t2 : anotherTable) {
					Tuple res = new Tuple(t.getKeys());
					res.build(t.serialize());
					res.merge(t2);
					finalSet.add(res);
				}
			}
			this.resultSet = finalSet;
			return this;
		}

		for (int i = 0; i < this.resultSet.size(); ++i) {
			Tuple merging = this.resultSet.get(i);
			int num = merging.getKeys().size();
			anotherTable
					.stream()
					.filter(tuple -> merging.get(onLeft).equals(tuple.get(onRight)))
					.forEach(merging::merge);

			if (merging.getKeys().size() > num) {
				System.out.println("Merged " + merging);
				finalSet.add(merging);
			} else if (joinType.equals("LEFT OUTER")) {
				Tuple t = new Tuple(attributes);
				merging.merge(t);
				finalSet.add(merging);
				System.out.println("LEFT OUTER MERGE");
			}
		}

		this.resultSet = finalSet;
		return this;
	}

	/**
	 * group by the table by the certain attribute
	 *
	 * @param attribute is a field to group by
	 * @return processor with defined list
	 */
	public CommandProcessor groupBy(String attribute) {
		List<Tuple> result = new ArrayList<>();
		for (Tuple t : resultSet) {
			boolean exists = result.stream()
					.filter(tuple -> tuple.get(attribute).equals(t.get(attribute)))
					.count() > 0;

			if (!exists)
				result.add(t);
		}

		this.resultSet = result;
		return this;
	}

	public CommandProcessor offset(int pos) {
		if (pos > resultSet.size())
			this.resultSet = new ArrayList<>();
		else
			this.resultSet = this.resultSet.subList(pos, resultSet.size());
		return this;
	}

	public CommandProcessor count(String attribute) {
		String columnName = "count(" + attribute + ")";

		if (attribute.equals("*")) {
			this.resultSet = resultSet.stream()
					.map(tuple -> {
						Tuple t = new Tuple(tuple.getKeys());
						t.build(tuple.serialize());
						t.set(columnName, "" + resultSet.size());
						return t;
					})
					.collect(Collectors.toList());

			return this;
		}

		HashMap<String, Integer> count = new HashMap<>();
		for (Tuple t : resultSet) {
			String val = t.get(attribute);
			int num = count.getOrDefault(val, 0);
			count.put(val, num + 1);
		}

		this.resultSet = resultSet.stream()
				.map(tuple -> {
					Tuple t = new Tuple(tuple.getKeys());
					t.build(tuple.serialize());
					t.set(columnName, count.get(t.get(attribute)) + "");
					return t;
				})
				.collect(Collectors.toList());

		return this;
	}

	public CommandProcessor limit(int size) {
		this.resultSet = this.resultSet.subList(0, this.resultSet.size() < size ? this.resultSet.size() : size);
		return this;
	}

	/**
	 * insert tuple into the table
	 *
	 * @param table is the name of the table
	 * @param field is a tuple to insert
	 */
	public void insert(String table, String... field) {
		dm.insert(table, field);
	}

	/**
	 * add btree index for table on given attribute
	 *
	 * @param table     the name of the table
	 * @param attribute a field to index
	 */
	public void addIndex(String table, String attribute) {
		dm.addIndex(table, attribute);
	}

	/**
	 * set attribute of all tuples to value
	 *
	 * @param attribute to change the value
	 * @param value     to set on specified attribute
	 * @return processor with defined list
	 */
	public CommandProcessor set(String attribute, String value) {
		this.resultSet.parallelStream()
				.forEach(t -> t.set(attribute, value));
		return this;
	}

	public CommandProcessor coalesce(String param, String value) {
		/*this.resultSet.stream().forEach(tuple ->
						tuple.getKeys().stream()
								.forEach(s -> {
											if (tuple.get(s).equals(""))
												tuple.set(s, param);
										}
								)
		);*/
		this.resultSet.stream().forEach(t -> t.set(param, value));

		return this;
	}

	/**
	 * update the table with resultSet
	 *
	 * @param tableName to update
	 */
	public void update(String tableName) {
		this.resultSet.stream()
				.forEach(t -> dm.update(tableName, t));
	}

	/**
	 * delete resultSet from table
	 *
	 * @param tableName to delete
	 */
	public void delete(String tableName) {
		this.resultSet.stream()
				.forEach(t -> dm.delete(tableName, t));
	}

	public void create(String tableName, String... attributes) {
		dm.create(tableName, attributes);
	}

	public void close() {
		dm.close();
	}

	public CommandProcessor rename(String oldAttrName, String newAttrName) {
		this.resultSet.forEach(t -> t.renameKey(oldAttrName, newAttrName));
		return this;
	}

	public List<Tuple> list() {
		return resultSet;
	}
}
