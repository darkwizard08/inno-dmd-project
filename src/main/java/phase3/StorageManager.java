package phase3;

import phase3.model.Pair;
import phase3.model.Table;
import phase3.model.entities.SimpleEntity;
import phase3.model.entities.Writable;
import phase3.model.tree.BTree;

import java.io.File;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.LinkedHashMap;
import java.util.Map;


public class StorageManager {
	private static StorageManager manager = null;
	//connector to the file for reading
	private RandomAccessFile storage;
	//list of free spaces in the file
	private BTree freeList;
	private Map<String, Table> tables = new LinkedHashMap<>();

	/**
	 * constructor to initialize the Manager
	 */
	private StorageManager() {
		File customDB = new File(".db");
		try {
			this.storage = new RandomAccessFile(customDB, "rw");
			this.freeList = new BTree();

			if (storage.length() > 0) {
				int endOfFile = (int) storage.length() - 4;
				storage.seek(endOfFile);
				int freeListOffset = storage.readInt();
				storage.seek(freeListOffset);
				byte[] buffer = new byte[endOfFile - freeListOffset];
				storage.read(buffer);
				freeList.build(buffer);

				int tablesOffset = freeList.getPairs()
						.get(freeList.getPairs().size() - 1)
						.getValue()
						.component1(); // get
				storage.seek(tablesOffset);

				while (storage.getFilePointer() < freeListOffset) {
					buffer = new byte[storage.readInt()];
					storage.seek(storage.getFilePointer() - 4);
					storage.read(buffer);
					Table t = new Table();
					t.build(buffer);
					tables.put(t.getTableName(), t);
				}
			} else {
				// initializing freeList, unless we will read it
				Pair p = new Pair(0, Integer.MAX_VALUE);
				this.freeList.insert(new SimpleEntity(p.component1(), p.component2() + ""), p);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static StorageManager getInstance() {
		if (manager == null) {
			manager = new StorageManager();
		}
		return manager;
	}

	/**
	 * Writing Writable object to byte file
	 *
	 * @param data - to write
	 */
	public int write(Writable data) {
		byte[] dataArray = data.serialize();
		int dataLength = dataArray.length;
		int freeLength;
		SimpleEntity deleted = null;
		int position = 0;
		try {
			for (javafx.util.Pair<SimpleEntity, Pair> p : freeList.getPairs()) {
				freeLength = p.getValue().getLength();
				if (dataLength <= freeLength) {
					position = p.getValue().getPosition();
					this.storage.seek(position);
					this.storage.write(dataArray);
					if (dataLength < freeLength) {
						p.getValue().setPosition(position + dataLength);
						p.getValue().setLength(freeLength - dataLength);
						freeList.update(p.getKey(), p.getValue());
					} else {
						deleted = p.getKey();
					}
					break;
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		if (deleted != null) {
			freeList.delete(deleted);
		}

		return position;
	}

	/**
	 * delete concrete tuple
	 *
	 * @param offset to start from
	 * @param len    is length of the tuple
	 * @return deleted byte array
	 */
	public byte[] deleteTuple(int offset, int len) {
		byte[] deleted = new byte[len];
		int dataPosition = offset + len;
		int position = 0;
		int length = 0;
		try {
			for (javafx.util.Pair<SimpleEntity, Pair> p : freeList.getPairs()) {
				position = p.getValue().getPosition();
				length = p.getValue().getLength();

				if (dataPosition == position) {
					p.getValue().setPosition(dataPosition);
					p.getValue().setLength(length + len);
					freeList.update(p.getKey(), p.getValue());

					storage.read(deleted, offset, len);

					return deleted;
				} else if ((position + length) == offset) {
					p.getValue().setLength(length + len);
					freeList.update(p.getKey(), p.getValue());
					storage.read(deleted, offset, len);
					return deleted;
				}
			}
			Pair p = new Pair(offset, len);
			freeList.insert(new SimpleEntity(p.component1(), p.component2() + ""), p);
			storage.seek(offset);
			storage.read(deleted);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return deleted;
	}

	/**
	 * reading data from storage
	 *
	 * @param offset - from what position we should start reading
	 * @param len    - length of the tuple
	 * @return byte-array for future restoring
	 */
	public byte[] read(int offset, int len) {
		try {
			storage.seek(offset);
			byte[] arr = new byte[len];
			storage.read(arr);
			return arr;
		} catch (IOException e) {
			e.printStackTrace();
		}
		throw new Error("Check readed file.");
	}

	public void close() {
		try {
			int tablesOffset = freeList.getPairs()
					.get(freeList.getPairs().size() - 1)
					.getValue()
					.component1();
			storage.seek(tablesOffset);

			for (Map.Entry<String, Table> e : tables.entrySet()) {
				storage.write(e.getValue().serialize());
			}

			int freeListOffset = (int) storage.getFilePointer();
			storage.write(freeList.serialize());
			storage.writeInt(freeListOffset);

			storage.close();
		} catch (Exception e) {

		}
	}

	public Table getTable(String tableName) {
		return tables.getOrDefault(tableName, null);
	}

	public void addTable(Table table) {
		tables.put(table.getTableName(), table);
	}
}
