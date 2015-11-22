package phase3.model.entities;

import phase3.model.tuple.Tuple;

import java.nio.ByteBuffer;

public class SimpleEntity implements Writable, Comparable<SimpleEntity> {
	private String attribute = "";
	private int id;

	public SimpleEntity(int id, String attribute) {
		this.attribute = attribute;
		this.id = id;
	}

	public SimpleEntity(Tuple tuple, String attributeName) {
		id = Integer.parseInt(tuple.get("id"));
		attribute = tuple.get(attributeName);
	}

	public String getAttribute() {
		return attribute;
	}

	public void setAttribute(String attribute) {
		this.attribute = attribute;
	}

	@Override
	public byte[] serialize() {
		ByteBuffer buffer = ByteBuffer.allocate(this.length());
		buffer.putInt(this.length());
		buffer.putInt(id);
		buffer.put(attribute.getBytes());
		return buffer.array();
	}

	@Override
	public void build(byte[] array) {
		ByteBuffer buffer = ByteBuffer.wrap(array);
		int length = buffer.getInt();
		this.id = buffer.getInt();
		byte[] attr = new byte[array.length - 8];
		buffer.get(attr);
		this.attribute = new String(attr);
	}

	@Override
	public int length() {
		return 8 + attribute.length();
	}

	@Override
	public int compareTo(SimpleEntity o) {
		//int result = this.attribute.compareTo(o.attribute);
		int result;
		try {
			result = new Integer(this.attribute).compareTo(new Integer(o.attribute));
		} catch (NumberFormatException e) {
			result = this.attribute.compareTo(o.attribute);
		}
		return result != 0 ? result : this.id - o.id;
	}
}
