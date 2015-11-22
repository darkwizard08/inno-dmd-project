package phase3.model.tree;

import phase3.model.Pair;
import phase3.model.entities.SimpleEntity;
import phase3.model.entities.Writable;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.List;

public class BTree implements Writable {
	private BTreeNode root;
	private ByteBuffer leaves;
	private List<javafx.util.Pair<SimpleEntity, Pair>> pairs;

	public BTree() {
		this.root = new BTreeLeafNode();
		pairs = new ArrayList<>();
	}

	/**
	 * Insert a new key and its associated value into the B+ tree.
	 */
	public void insert(SimpleEntity key, Pair value) {
		pairs.add(new javafx.util.Pair<>(key, value));
		BTreeLeafNode leaf = this.findLeafNodeShouldContainKey(key);
		leaf.insertKey(key, value);

		if (leaf.isOverflow()) {
			BTreeNode n = leaf.dealOverflow();
			if (n != null) {
				this.root = n;
			}
		}
		sort();
	}

	/**
	 * Search a key value on the tree and return its associated value.
	 */
	public Pair search(SimpleEntity key) {
		BTreeLeafNode leaf = this.findLeafNodeShouldContainKey(key);

		int index = leaf.search(key);
		return (index == -1) ? null : leaf.getValue(index);
	}

	/**
	 * change the value of already
	 * existed item
	 *
	 * @param key   of the item to change
	 * @param value new value to set
	 */
	public void update(SimpleEntity key, Pair value) {
		BTreeLeafNode leaf = this.findLeafNodeShouldContainKey(key);

		int index = leaf.search(key);
		leaf.setValue(index, value);
		pairs.parallelStream()
				.filter(t -> t.getKey() == key)
				.forEach(t -> t = new javafx.util.Pair<>(key, value));
		sort();
	}

	/**
	 * Delete a key and its associated value from the tree.
	 */
	public void delete(SimpleEntity key) {
		BTreeLeafNode leaf = this.findLeafNodeShouldContainKey(key);

		if (leaf.delete(key) && leaf.isUnderflow()) {
			BTreeNode n = leaf.dealUnderflow();
			if (n != null)
				this.root = n;
		}
	}

	/**
	 * Search the leaf node which should contain the specified key
	 */
	@SuppressWarnings("unchecked")
	private BTreeLeafNode findLeafNodeShouldContainKey(SimpleEntity key) {
		BTreeNode node = this.root;
		while (node.getNodeType() == TreeNodeType.InnerNode) {
			node = ((BTreeInnerNode) node).getChild(node.search(key));
		}

		return (BTreeLeafNode) node;
	}

	@Override
	public byte[] serialize() {
		byte[] array;
		int size = length();

		leaves = ByteBuffer.allocate(size);
		leaves.putInt(size);
		for (javafx.util.Pair<SimpleEntity, Pair> pair : pairs) {
			array = pair.getKey().serialize();
			leaves.putInt(array.length);
			leaves.put(array);
			leaves.putInt(pair.getValue().getPosition());
			leaves.putInt(pair.getValue().getLength());
		}

		return leaves.array();
	}


	public List<javafx.util.Pair<SimpleEntity, Pair>> getPairs() {
		return pairs;
	}

	public int size() {
		return size(root);
	}

	public int size(BTreeNode node) {
		int size = 0;
		if (node == null)
			return 0;
		else {
			if (node instanceof BTreeInnerNode)
				for (int i = 0; i < ((BTreeInnerNode) node).children.length; ++i)
					size += size(((BTreeInnerNode) node).getChild(i));
			else
				size += node.getKeyCount();

			return size;
		}
	}

	@Override
	public void build(byte[] array) {
		ByteBuffer buffer = ByteBuffer.wrap(array);
		int length = buffer.getInt();
		int entitySize = 0;
		int count = 4;
		SimpleEntity entity;
		Pair pair;
		byte[] arr;
		while (count < length) {
			entity = new SimpleEntity(-1, "");
			entitySize = buffer.getInt();
			arr = new byte[entitySize];
			//?
			buffer.get(arr);
			count += entitySize;
			entity.build(arr);
			pair = new Pair(buffer.getInt(), buffer.getInt());
			this.insert(entity, pair);
			count += 12;
		}
	}

	@Override
	public int length() {
		int length = 0;
		int count = 0;
		for (javafx.util.Pair<SimpleEntity, Pair> pair : pairs) {
			length += pair.getKey().length();
			count++;
		}

		return length + (12 * count) + 4;
	}

	private void sort() {
		pairs.sort((p1, p2) -> p1.getKey().compareTo(p2.getKey()));
	}
}
