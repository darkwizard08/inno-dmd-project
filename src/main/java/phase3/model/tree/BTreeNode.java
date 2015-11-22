package phase3.model.tree;

import phase3.model.entities.SimpleEntity;

enum TreeNodeType {
	InnerNode,
	LeafNode
}

abstract class BTreeNode {
	protected SimpleEntity[] keys;
	protected int keyCount;
	protected BTreeNode parentNode;
	protected BTreeNode leftSibling;
	protected BTreeNode rightSibling;


	protected BTreeNode() {
		this.keyCount = 0;
		this.parentNode = null;
		this.leftSibling = null;
		this.rightSibling = null;
	}

	public int getKeyCount() {
		return this.keyCount;
	}

	@SuppressWarnings("unchecked")
	public SimpleEntity getKey(int index) {
		return this.keys[index];
	}

	public SimpleEntity[] getKeys() {
		return keys;
	}

	public void setKey(int index, SimpleEntity key) {
		this.keys[index] = key;
	}

	public BTreeNode getParent() {
		return this.parentNode;
	}

	public void setParent(BTreeNode parent) {
		this.parentNode = parent;
	}

	public abstract TreeNodeType getNodeType();


	/**
	 * Search a key on current node, if found the key then return its position,
	 * otherwise return -1 for a leaf node,
	 * return the child node index which should contain the key for a internal node.
	 */
	public abstract int search(SimpleEntity key);



	/* The codes below are used to support insertion operation */

	public boolean isOverflow() {
		return this.getKeyCount() == this.keys.length;
	}

	public BTreeNode dealOverflow() {
		int midIndex = this.getKeyCount() / 2;
		SimpleEntity upKey = this.getKey(midIndex);

		BTreeNode newRNode = this.split();

		if (this.getParent() == null) {
			this.setParent(new BTreeInnerNode());
		}
		newRNode.setParent(this.getParent());

		// maintain links of sibling nodes
		newRNode.setLeftSibling(this);
		newRNode.setRightSibling(this.rightSibling);
		if (this.getRightSibling() != null)
			this.getRightSibling().setLeftSibling(newRNode);
		this.setRightSibling(newRNode);

		// push up a key to parent internal node
		return this.getParent().pushUpKey(upKey, this, newRNode);
	}

	protected abstract BTreeNode split();

	protected abstract BTreeNode pushUpKey(SimpleEntity key, BTreeNode leftChild, BTreeNode rightNode);






	/* The codes below are used to support deletion operation */

	public boolean isUnderflow() {
		return this.getKeyCount() < (this.keys.length / 2);
	}

	public boolean canLendAKey() {
		return this.getKeyCount() > (this.keys.length / 2);
	}

	public BTreeNode getLeftSibling() {
		if (this.leftSibling != null && this.leftSibling.getParent() == this.getParent())
			return this.leftSibling;
		return null;
	}

	public void setLeftSibling(BTreeNode sibling) {
		this.leftSibling = sibling;
	}

	public BTreeNode getRightSibling() {
		if (this.rightSibling != null && this.rightSibling.getParent() == this.getParent())
			return this.rightSibling;
		return null;
	}

	public void setRightSibling(BTreeNode silbling) {
		this.rightSibling = silbling;
	}

	public BTreeNode dealUnderflow() {
		if (this.getParent() == null)
			return null;

		// try to borrow a key from sibling
		BTreeNode leftSibling = this.getLeftSibling();
		if (leftSibling != null && leftSibling.canLendAKey()) {
			this.getParent().processChildrenTransfer(this, leftSibling, leftSibling.getKeyCount() - 1);
			return null;
		}

		BTreeNode rightSibling = this.getRightSibling();
		if (rightSibling != null && rightSibling.canLendAKey()) {
			this.getParent().processChildrenTransfer(this, rightSibling, 0);
			return null;
		}

		// Can not borrow a key from any sibling, then do fusion with sibling
		if (leftSibling != null) {
			return this.getParent().processChildrenFusion(leftSibling, this);
		} else {
			return this.getParent().processChildrenFusion(this, rightSibling);
		}
	}

	protected abstract void processChildrenTransfer(BTreeNode borrower, BTreeNode lender, int borrowIndex);

	protected abstract BTreeNode processChildrenFusion(BTreeNode leftChild, BTreeNode rightChild);

	protected abstract void fusionWithSibling(SimpleEntity sinkKey, BTreeNode rightSibling);

	protected abstract SimpleEntity transferFromSibling(SimpleEntity sinkKey, BTreeNode sibling, int borrowIndex);
}
