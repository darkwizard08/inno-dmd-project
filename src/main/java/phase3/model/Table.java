package phase3.model;

import phase3.model.entities.SimpleEntity;
import phase3.model.entities.Writable;
import phase3.model.tree.BTree;
import phase3.model.tuple.Tuple;
import phase3.model.tuple.TupleBuilder;

import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.List;

public class Table implements Writable {
	//name of the table
	private String tableName;
	private TupleBuilder tupleBuilder;
	//map for storing trees by attribute values
	private HashMap<String, BTree> map;

	public Table() {
		tupleBuilder = new TupleBuilder();
		map = new HashMap<>();
	}

	/**
	 * constructor with parameter
	 * initialize table with given key
	 *
	 * @param tableName is the name of the table
	 */
	public Table(String tableName, String... attributes) {
		this.tableName = tableName;
		this.tupleBuilder = new TupleBuilder().table(tableName).init(attributes);
		map = new HashMap<>();
		map.put("id", new BTree());
	}

	/**
	 * inserts new entity tuple to the tree
	 *
	 * @param tuple  is an entity to add
	 * @param length is length of the tuple
	 * @param block  is a page in the file where the tuple is
	 */
	public void insertTuple(Tuple tuple, int length, int block) {
		map.entrySet()
				.stream()
				.filter(e -> e.getValue() != null)
				.forEach(e -> e.getValue().insert(new SimpleEntity(tuple, e.getKey()), new Pair(block, length)));
	}

	public void deleteTuple(Tuple tuple) {
		map.entrySet()
				.stream()
				.filter(e -> e.getValue() != null)
				.forEach(e -> e.getValue().delete(new SimpleEntity(tuple, e.getKey())));
	}

	public Tuple buildTuple(String... values) {
		return this.tupleBuilder.create(values);
	}

	public Tuple buildTuple(byte[] array) {
		return this.tupleBuilder.create(array);
	}

	public String getTableName() {
		return tableName;
	}

	@Override
	public byte[] serialize() {
		byte[] array;
		int tbLength = tupleBuilder.serialize().length;
		int length = tbLength;
		length += length();
		ByteBuffer buffer = ByteBuffer.allocate(length);
		buffer.putInt(length);
		buffer.putInt(tableName.length());
		buffer.put(tableName.getBytes());
		buffer.putInt(tbLength);
		buffer.put(tupleBuilder.serialize());
		int elem = 0;
		for (String key : map.keySet()) {
			buffer.putInt(key.length());
			buffer.put(key.getBytes());
			array = map.get(key).serialize();
			elem = array.length;
			buffer.putInt(elem);
			buffer.put(array);
		}

		return buffer.array();
	}

	@Override
	public void build(byte[] array) {
		ByteBuffer buffer = ByteBuffer.wrap(array);
		int length = buffer.getInt();
		int tableN = buffer.getInt();
		byte[] arr = new byte[tableN];
		buffer.get(arr);
		this.tableName = new String(arr);
		int count = 8 + tableN;
		int tbLength = buffer.getInt();
		count += 4;
		arr = new byte[tbLength];
		buffer.get(arr);
		count += tbLength;
		tupleBuilder.build(arr);
		BTree tree;
		int leng = 0;
		String key;
		while (count < length) {
			leng = buffer.getInt();
			arr = new byte[leng];
			buffer.get(arr);
			key = new String(arr);
			count += 4;
			count += arr.length;
			leng = buffer.getInt();
			arr = new byte[leng];
			buffer.get(arr);
			count += arr.length;
			count += 4;
			tree = new BTree();
			tree.build(arr);
			map.put(key, tree);
		}
	}

	@Override
	public int length() {
		int length = 0;
		int count = 0;
		for (String key : map.keySet()) {
			length += key.length();
			length += map.get(key).length();
			count++;
		}

		length += tableName.length();
		length += 12;
		length += (8 * count);

		return length;
	}

	/**
	 * add tree indexed by the value
	 *
	 * @param attribute is a field for indexing by
	 * @param tree      is tree of entities
	 */
	public void addTree(String attribute, BTree tree) {
		this.map.put(attribute, tree);
	}

	/**
	 * return tree by attribute value
	 *
	 * @param attribute is field of the tuple
	 * @return tree indexed by the attribute values
	 */
	public BTree getTree(String attribute) {
		return map.get(attribute);
	}

	public List<String> attributes() {
		return tupleBuilder.attributes();
	}
}
