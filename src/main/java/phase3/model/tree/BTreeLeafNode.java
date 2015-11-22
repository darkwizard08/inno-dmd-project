package phase3.model.tree;

import phase3.model.Pair;
import phase3.model.entities.SimpleEntity;

class BTreeLeafNode extends BTreeNode {
	protected final static int LEAFORDER = 4;
	private Object[] values;

	public BTreeLeafNode() {
		this.keys = new SimpleEntity[LEAFORDER + 1];
		this.values = new Object[LEAFORDER + 1];
	}

	@SuppressWarnings("unchecked")
	public Pair getValue(int index) {
		return (Pair) this.values[index];
	}

	public void setValue(int index, Pair value) {
		this.values[index] = value;
	}

	@Override
	public TreeNodeType getNodeType() {
		return TreeNodeType.LeafNode;
	}

	@Override
	public int search(SimpleEntity key) {
		for (int i = 0; i < this.getKeyCount(); ++i) {
			int cmp = this.getKey(i).compareTo(key);
			if (cmp == 0) {
				return i;
			} else if (cmp > 0) {
				return -1;
			}
		}

		return -1;
	}


	/* The codes below are used to support insertion operation */

	public void insertKey(SimpleEntity key, Pair value) {
		int index = 0;
		while (index < this.getKeyCount() && this.getKey(index).compareTo(key) < 0)
			++index;
		this.insertAt(index, key, value);
	}

	private void insertAt(int index, SimpleEntity key, Pair value) {
		// move space for the new key
		for (int i = this.getKeyCount() - 1; i >= index; --i) {
			this.setKey(i + 1, this.getKey(i));
			this.setValue(i + 1, this.getValue(i));
		}

		// insert new key and value
		this.setKey(index, key);
		this.setValue(index, value);
		++this.keyCount;
	}


	/**
	 * When splits a leaf node, the middle key is kept on new node and be pushed to parent node.
	 */
	@Override
	protected BTreeNode split() {
		int midIndex = this.getKeyCount() / 2;

		BTreeLeafNode newRNode = new BTreeLeafNode();
		for (int i = midIndex; i < this.getKeyCount(); ++i) {
			newRNode.setKey(i - midIndex, this.getKey(i));
			newRNode.setValue(i - midIndex, this.getValue(i));
			this.setKey(i, null);
			this.setValue(i, null);
		}
		newRNode.keyCount = this.getKeyCount() - midIndex;
		this.keyCount = midIndex;

		return newRNode;
	}

	@Override
	protected BTreeNode pushUpKey(SimpleEntity key, BTreeNode leftChild, BTreeNode rightNode) {
		throw new UnsupportedOperationException();
	}




	/* The codes below are used to support deletion operation */

	public boolean delete(SimpleEntity key) {
		int index = this.search(key);
		if (index == -1)
			return false;

		this.deleteAt(index);
		return true;
	}

	private void deleteAt(int index) {
		int i = index;
		for (i = index; i < this.getKeyCount() - 1; ++i) {
			this.setKey(i, this.getKey(i + 1));
			this.setValue(i, this.getValue(i + 1));
		}
		this.setKey(i, null);
		this.setValue(i, null);
		--this.keyCount;
	}

	@Override
	protected void processChildrenTransfer(BTreeNode borrower, BTreeNode lender, int borrowIndex) {
		throw new UnsupportedOperationException();
	}

	@Override
	protected BTreeNode processChildrenFusion(BTreeNode leftChild, BTreeNode rightChild) {
		throw new UnsupportedOperationException();
	}

	/**
	 * Notice that the key sunk from parent is be abandoned.
	 */
	@Override
	@SuppressWarnings("unchecked")
	protected void fusionWithSibling(SimpleEntity sinkKey, BTreeNode rightSibling) {
		BTreeLeafNode siblingLeaf = (BTreeLeafNode) rightSibling;

		int j = this.getKeyCount();
		for (int i = 0; i < siblingLeaf.getKeyCount(); ++i) {
			this.setKey(j + i, siblingLeaf.getKey(i));
			this.setValue(j + i, siblingLeaf.getValue(i));
		}
		this.keyCount += siblingLeaf.getKeyCount();

		this.setRightSibling(siblingLeaf.rightSibling);
		if (siblingLeaf.rightSibling != null)
			siblingLeaf.rightSibling.setLeftSibling(this);
	}

	@Override
	@SuppressWarnings("unchecked")
	protected SimpleEntity transferFromSibling(SimpleEntity sinkKey, BTreeNode sibling, int borrowIndex) {
		BTreeLeafNode siblingNode = (BTreeLeafNode) sibling;

		this.insertKey(siblingNode.getKey(borrowIndex), siblingNode.getValue(borrowIndex));
		siblingNode.deleteAt(borrowIndex);

		return borrowIndex == 0 ? sibling.getKey(0) : this.getKey(0);
	}
}
