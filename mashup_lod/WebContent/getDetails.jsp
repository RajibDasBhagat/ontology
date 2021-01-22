<%@ page import="in.iitm.cse.QueryExecutor,org.apache.jena.query.ResultSet, org.apache.jena.query.QuerySolution, java.util.Iterator " %> 

<%
   // Returns all employees (active and terminated) as json.
   response.setContentType("application/json");

String id = request.getParameter("id");
String name = request.getParameter("name");

QueryExecutor qe = new QueryExecutor("https://query.wikidata.org/sparql");
String squery = "PREFIX wd: <http://www.wikidata.org/entity/>\n" + 
		"PREFIX wdt: <http://www.wikidata.org/prop/direct/>\n" + 
		"PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" + 
		"\n" + 
		"\n" + 
		"SELECT DISTINCT ?item ?name ?image ?citizenship ?dob ?website ?viafid ?dblpid ?acmid WHERE {\n" + 
		"  BIND(wd:" + id+ " as ?item).\n" + 
		"  ?item rdfs:label ?name.\n" + 
		"  ?item wdt:P31 wd:Q5.\n" + 
		"  OPTIONAL {?item wdt:P18 ?image.}\n" + 
		"   OPTIONAL {?item wdt:P27 ?country.\n" +
				" ?country  rdfs:label ?citizenship .}\n" + 
		"   OPTIONAL {?item wdt:P569 ?dob.}\n" + 
		"   OPTIONAL {?item wdt:P856 ?website.}\n" + 
		"   OPTIONAL {?item wdt:P214 ?viafid.}\n" + 
		"   OPTIONAL {?item wdt:P2456 ?dblpid.}\n" + 
		"   OPTIONAL {?item wdt:P864 ?acmid.}\n" + 

		"  FILTER((LANG(?name)) = \"en\")\n" + 
		"  FILTER((LANG(?citizenship)) = \"en\")\n" +
		"}\n" + 
		"" ; 
	ResultSet rs = qe.executeSparqlQuery(squery);
	 String s = "{\"id\":\"" + id + "\"";
	while (rs.hasNext()) {
        // Get Result
        QuerySolution qs = rs.next();

        // Get Variable Names
        Iterator<String> itVars = qs.varNames();

       
        String szVar ;
        String szVal ;
        // Display Result
        while (itVars.hasNext()) {
        	
			//Retrieving item        	
        	 szVar = itVars.next().toString();
             szVal = qs.get(szVar).toString();
             System.out.println(szVar + " " + szVal);
             
             switch(szVar)
             {
             case "dblpid": s = s.concat(", \"dblpid\":" + "\"" + szVal + "\""); break;
             case "citizenship":
            	 szVal = szVal.substring(0, szVal.length() - 3);
            	 s = s.concat(", \"citizenship\":" + "\"" + szVal + "\"");
            	 break;
             case "dob":
            		szVal = szVal.substring(0, 10);
             		s = s.concat(", \"dob\":" + "\"" + szVal + "\"");
             		break;
             case "acmid":s = s.concat(", \"acmid\":" + "\"" + szVal + "\"");break;
             case "website":s = s.concat(", \"website\":" + "\"" + szVal + "\"");break;
             case "name":
            	 szVal = szVal.substring(0, szVal.length() - 3);
            	 s = s.concat(", \"name\":" + "\"" + szVal + "\"");
            	 break;
             case "viafid":s = s.concat(", \"viafid\":" + "\"" + szVal + "\"");break;
             case "image":s = s.concat(", \"image\":" + "\"" + szVal + "\"");break;
             }
             

        }
	}
	s = s.concat("}");
	System.out.println(s);
	out.println(s);
%>