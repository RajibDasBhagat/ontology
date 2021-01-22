package in.iitm.cse;

import org.apache.jena.query.Query;
import org.apache.jena.query.QueryExecution;
import org.apache.jena.query.QueryExecutionFactory;
import org.apache.jena.query.QueryFactory;
import org.apache.jena.query.ResultSet;
import org.apache.jena.sparql.engine.http.QueryEngineHTTP;

public class QueryExecutor 
{
	
	// DBPedia Endpoint
    String szEndpoint;

	public String getSzEndpoint() {
		return szEndpoint;
	}

	public void setSzEndpoint(String szEndpoint) {
		this.szEndpoint = szEndpoint;
	}

	public QueryExecutor(String szEndpoint) {
		super();
		this.szEndpoint = szEndpoint;
	}

	public QueryExecutor() {
		super();
		szEndpoint = "http://dbpedia.org/sparql";
	}
    
    public ResultSet executeSparqlQuery(String squery)
    {
        // Create a Query with the given String
        Query query = QueryFactory.create(squery);

        // Create the Execution Factory using the given Endpoint
        QueryExecution qexec = QueryExecutionFactory.sparqlService(
                szEndpoint, query);

        // Set Timeout
        ((QueryEngineHTTP)qexec).addParam("timeout", "10000");


        // Execute Query
        //int iCount = 0;
        ResultSet rs = qexec.execSelect();
        return rs;
       /* while (rs.hasNext()) {
            // Get Result
            QuerySolution qs = rs.next();

            // Get Variable Names
            Iterator<String> itVars = qs.varNames();

            // Count
            iCount++;
            System.out.println("Result " + iCount + ": ");

            // Display Result
            while (itVars.hasNext()) {
                String szVar = itVars.next().toString();
                String szVal = qs.get(szVar).toString();
                
                System.out.println("[" + szVar + "]: " + szVal);
            }
        }*/
    }

}
