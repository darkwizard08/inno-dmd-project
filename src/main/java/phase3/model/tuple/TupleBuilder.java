package phase3.model.tuple;

import phase3.model.entities.Writable;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author darkwizard
 */
public class TupleBuilder implements Writable {
	private List<String> attrs = new ArrayList<>();
	private String table = "";
	private ByteBuffer buffer;

	public TupleBuilder init(String... attributes) {
		attrs.clear();
		if (table.isEmpty())
			throw new Error("Should call table() first!");

		attrs.addAll(Arrays.asList(attributes)
						.stream()
						.map(s -> table + "." + s)
						.collect(Collectors.toList())
		);

		return this;
	}

	public TupleBuilder table(String name) {
		this.table = name;

		return this;
	}

	public Tuple create(String... values) {
		Tuple t = new Tuple(attrs);
		int pointer = 0;
		if (attrs.size() != values.length)
			throw new Error("Please, use init() method to properly adjust the future Tuples!");

		for (String attr : attrs)
			t.set(attr, values[pointer++]);

		return t;
	}

	public Tuple create(byte[] array) {
		Tuple t = new Tuple(attrs);
		ByteBuffer buffer = ByteBuffer.wrap(array);

		for (String attr : attrs) {
			byte[] attribute = new byte[buffer.getInt()];
			buffer.get(attribute);
			t.set(attr, new String(attribute));
		}

		return t;
	}

	@Override
	public byte[] serialize() {
		int length = length();
		buffer = ByteBuffer.allocate(length);
		buffer.putInt(length);
		for (String attr : attrs) {
			buffer.putInt(attr.length());
			buffer.put(attr.getBytes());
		}

		return buffer.array();
	}

	@Override
	public void build(byte[] array) {
		ByteBuffer buffer = ByteBuffer.wrap(array);
		int length = buffer.getInt();
		int count = 4;
		int sLength = 0;
		byte[] arr;
		while (count < length) {
			sLength = buffer.getInt();
			arr = new byte[sLength];
			buffer.get(arr);
			attrs.add(new String((arr)));
			count += 4;
			count += sLength;
		}
	}

	@Override
	public int length() {
		int length = 0;
		int count = 0;
		for (String attr : attrs) {
			length += attr.length();
			count++;
		}

		return length + 4 + (count * 4);
	}

	public List<String> attributes() {
		return attrs;
	}
}

