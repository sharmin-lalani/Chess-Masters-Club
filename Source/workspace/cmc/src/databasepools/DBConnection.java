package databasepools;

import java.sql.Connection;

public interface DBConnection {
	 /**
	  * Creates a connection.
	  */
	 public Connection create();
	 
	 /**
	  * Releases a connection.
	  */
	 public void release(Connection value);
	 
	 /**
	  * Destroys the object.
	  */
	 public void close();
}
