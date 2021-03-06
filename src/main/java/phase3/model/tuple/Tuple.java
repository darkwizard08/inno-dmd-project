package phase3.model.tuple;

import phase3.model.entities.Writable;

import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

/**
 * @author darkwizard
 */
public class Tuple implements Writable {

	private LinkedHashMap<String, String> attributes;

	public Tuple(String... columnNames) {
		this(Arrays.asList(columnNames));
	}

	public Tuple(Iterable<String> collection) {
		this.attributes = new LinkedHashMap<>();
		for (String name : collection)
			this.attributes.put(name, "");
	}

	public void copy(Tuple other) {
		for (String key : this.attributes.keySet()) {
			String copy = other.get(key);
			if (copy == null)
				throw new Error("No such column in Tuple!");
			this.attributes.put(key, copy);
		}
	}

	public void renameKey(String oldKey, String newKey) {
		if (!this.attributes.containsKey(newKey)) {
			String value = this.get(oldKey);
			this.attributes.remove(oldKey);
			this.attributes.put(newKey, value);
		}
	}

	public void merge(Tuple otherTuple) {
		this.attributes.putAll(otherTuple.attributes);
	}

	public boolean contains(String otherKey) {
		return this.attributes.containsKey(otherKey);
	}

	public String get(String key) {
		// key is "id", for ex.
		// need to match for <tableName>.id
		String result = this.attributes.get(key);
		if (result != null)
			return result;

		// if we're here, something went wrong. Need wide matching
		for (String k : this.getKeys()) {
			String[] _ = k.split("\\.");
			String last = _[_.length - 1];
			if (last.equals(key))
				return this.get(k);
		}

		throw new Error("looked through all keys, but no match :(");
	}

	public void set(String key, String value) {
		this.attributes.put(key, value);
	}

	public String get(int i){
		return (String) this.attributes.values().toArray()[i];
	}

	public Set<String> getKeys() {
		return this.attributes.keySet();
	}

	@Override
	public byte[] serialize() {
		ByteBuffer buffer = ByteBuffer.allocate(this.length());
		for (Map.Entry<String, String> s : attributes.entrySet()) {
			buffer.putInt(s.getValue().length());
			buffer.put(s.getValue().getBytes());
		}
		return buffer.array();
	}

	@Override
	public void build(byte[] array) {
		ByteBuffer buffer = ByteBuffer.wrap(array);
		// Assuming we know attributes in advance
		for (Map.Entry<String, String> s : attributes.entrySet()) {
			byte[] attribute = new byte[buffer.getInt()];
			buffer.get(attribute);
			s.setValue(new String(attribute));
		}
	}

	@Override
	public int length() {
		int length = 4 * attributes.size(); // size of each attribute
		for (Map.Entry<String, String> s : attributes.entrySet()) {
			length += s.getValue().length(); // each attribute
		}
		return length;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof Tuple) {
			for (String key : this.getKeys()) {
				if (!((Tuple) obj).contains(key))
					return false;

				if (!((Tuple) obj).get(key).equals(this.get(key)))
					return false;
			}

			return true;
		}
		return super.equals(obj);
	}
}
