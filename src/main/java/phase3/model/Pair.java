package phase3.model;

public class Pair implements Comparable<Pair> {
	//store the position of free place in the file
	private int position;
	//length of the free place
	private int length;

	/**
	 * constructor with parameters
	 *
	 * @param position set the position
	 * @param length   set the length
	 */
	public Pair(int position, int length) {
		this.position = position;
		this.length = length;
	}

	public int component1() {
		return this.getPosition();
	}

	public int component2() {
		return this.getLength();
	}

	/**
	 * getter for variable position
	 *
	 * @return the position of free place in the file
	 */
	public int getPosition() {
		return position;
	}

	/**
	 * sets new value to the position
	 *
	 * @param position new position of free place in the file
	 */
	public void setPosition(int position) {
		this.position = position;
	}

	/**
	 * getter for variable length
	 *
	 * @return length of the free place
	 */
	public int getLength() {
		return length;
	}

	/**
	 * sets new value to the length
	 *
	 * @param length new length of free place
	 */
	public void setLength(int length) {
		this.length = length;
	}

	@Override
	public int compareTo(Pair o) {
		if (this.length != o.length) {
			return this.length - o.length;
		} else {
			return this.position - o.position;
		}
	}
}
