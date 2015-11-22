package phase3;


import phase3.model.entities.Writable;

public class Transaction {

	public Transaction() {
		// opening .transaction
	}

	public static void commit() {
		// merge .transaction file into .db
	}

	public void addToTransaction(Writable data) {
		// writing binary data to .transaction
	}
}
