package databasepools;

import java.sql.Connection;
import com.mchange.v2.c3p0.ComboPooledDataSource ;


public class c3p0pooledconnection implements DBConnection{
private ComboPooledDataSource ds  ;
public c3p0pooledconnection() {
	try {
		Class.forName("com.ibm.db2.jcc.DB2Driver") ;
	} catch (ClassNotFoundException e1) {
		System.out.println("not found") ; 
		// TODO Auto-generated catch block
		e1.printStackTrace();
	} 
	try{
		
		
	ds = new ComboPooledDataSource() ;
	ds.setDriverClass("com.ibm.db2.jcc.DB2Driver") ;
	ds.setJdbcUrl("jdbc:db2://localhost:50000/CMC") ;
	ds.setUser("db2admin") ;
	ds.setPassword("admin") ;
	ds.setMinPoolSize(0) ;
	ds.setMaxPoolSize(10);
	
	
	}catch(Exception e ){
		System.out.println(e) ;	
	}
	
	
}
	public void close() {
		// TODO Auto-generated method stub
		if(ds!= null){
			ds.close() ;
		}
	}

	public Connection create() {
		// TODO Auto-generated method stub
		if(ds==null)return null ;
		try{
			return ds.getConnection();
		}catch(Exception e ){
			System.out.println(e) ;
			return null ;
		}
		
	}

	public void release(Connection value) {
		// TODO Auto-generated method stub
		
	}

}
