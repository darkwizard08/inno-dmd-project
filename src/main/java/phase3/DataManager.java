package phase3;

import javafx.util.Pair;
import phase3.model.Table;
import phase3.model.entities.SimpleEntity;
import phase3.model.tree.BTree;
import phase3.model.tuple.Tuple;

import java.util.ArrayList;
import java.util.List;


class DataManager {
	private StorageManager storage = StorageManager.getInstance();

	public DataManager() {

	}

	public void insert(String tableName, String... args) {
		// we determine, what kind of data it is.
		Table accordingTable = getTable(tableName);
		Tuple tup = accordingTable.buildTuple(args);

		// we're inserting record into storage

		int offset = storage.write(tup);
		// Then inserting, or writing index to appropriate tree.
		accordingTable.insertTuple(tup, tup.length(), offset);
	}

	public Table getTable(String tableName) {
		if (storage.getTable(tableName) != null) {
			return storage.getTable(tableName);
		} else throw new Error("No such table!");
	}

	public void create(String tableName, String... attributes) {
		storage.addTable(new Table(tableName, attributes));
	}

	public void update(String tableName, Tuple tuple) {
		BTree tree = getTable(tableName).getTree("id");

		// updating == deleting + inserting again
		delete(tableName, tuple);

		// inserting new
		int pos = storage.write(tuple);

		// now updating tree with new offset
		tree.insert(new SimpleEntity(tuple, "id"), new phase3.model.Pair(pos, tuple.length()));
	}

	public void delete(String tableName, Tuple tuple) {
		Table table = getTable(tableName);
		BTree tree = table.getTree("id");
		SimpleEntity key = new SimpleEntity(tuple, "id");

		// looking for that element in appropriate tree.
		// getting it's index
		phase3.model.Pair p = tree.search(key);
		int pos = p.getPosition();
		int len = p.getLength();

		// and deleting the record at given offset
		storage.deleteTuple(pos, len);
		tree.delete(key);
	}

	public List<Tuple> scan(String tableName) {
		Table table = getTable(tableName);
		BTree tree = table.getTree("id");
		List<Tuple> result = new ArrayList<>();

		for (Pair<SimpleEntity, phase3.model.Pair> p : tree.getPairs()) {
			int pos = p.getValue().getPosition();
			int len = p.getValue().getLength();

			Tuple tuple = table.buildTuple(storage.read(pos, len));

			result.add(tuple);
		}

		return result;
	}

	public void addIndex(String tableName, String attributeName) {
		Table table = getTable(tableName);
		BTree tableTree = table.getTree("id");
		BTree tree = new BTree();

		for (Pair<SimpleEntity, phase3.model.Pair> p : tree.getPairs()) {
			int pos = p.getValue().getPosition();
			int len = p.getValue().getLength();

			Tuple tuple = table.buildTuple(storage.read(pos, len));

			tree.insert(new SimpleEntity(tuple, attributeName), p.getValue());
		}

		table.addTree(attributeName, tree);
	}

	public void close() {
		storage.close();
	}

	public void testAddTable(Table t) {
		storage.addTable(t);
	}
}
