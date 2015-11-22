package phase3.model.entities;

public interface Writable {
	byte[] serialize();

	void build(byte[] array);

	int length();
}
