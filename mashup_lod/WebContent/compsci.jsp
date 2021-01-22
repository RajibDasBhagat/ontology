<%@ page import="in.iitm.cse.QueryExecutor,org.apache.jena.query.ResultSet, org.apache.jena.query.QuerySolution, java.util.Iterator " %> 

<!DOCTYPE HTML>

<html>
	<head>
		<title>List of Computer Scientists</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		
		<link rel="stylesheet" href="assets/css/jquery.custombox.css">
		<link rel="stylesheet" href="assets/css/bootstrap.min.css">
		<link rel="stylesheet" href="assets/css/main.css" />
		<script>
		function showdetails(id,name)
		{
			$("#headingright").html("Details of " + name);
			$.ajax({
				url: 'getDetails.jsp',
				data: {id: id, name: name},
				type: 'POST',
				success: function(result)
							{
								//alert(result.id);
								$("#name").html(result.name);
								$("#image").html( "<img src='" + result.image+"' height='100' width='75' />");
								$("#website").html("<a href='"+ result.website+"' target='_blank' class='link'>" + result.website + "</a>");
								$("#citizenship").html(result.citizenship);
								$("#dob").html(result.dob);
								$("#acmid").html("<a href='https://dl.acm.org/author_page.cfm?id="+result.acmid+"' target='_blank' class='link'>" + "Click here to view ACM profile" + "</a>");
								$("#viafid").html("<a href='https://viaf.org/viaf/"+result.viafid+"' target='_blank' class='link'>" + "Click here to view VIAF profile" + "</a>");
								$("#dblpid").html("<a href='https://dblp.org/pid/"+result.dblpid+"' target='_blank' class='link'>" + "Click here to view details in DBLP dataset" + "</a>");
							},
				error: function(){alert("Error occurred");}
			});
		}	

		</script>
	</head>
	<body class="subpage">
	
		<!-- Header -->
			<header id="header">
				<div class="inner">
					<a href="index.html" class="logo">Computer Scientists</a>
					<nav id="nav">
						<a href="index.html">Home</a>
					</nav>
					<a href="#navPanel" class="navPanelToggle"><span class="fa fa-bars"></span></a>
				</div>
			</header>

		<!-- Main -->
			<%
			QueryExecutor qe = new QueryExecutor("https://query.wikidata.org/sparql");
			String squery = "PREFIX wd: <http://www.wikidata.org/entity/>\n" + 
				"PREFIX wdt: <http://www.wikidata.org/prop/direct/>\n" + 
				"PREFIX pq: <http://www.wikidata.org/prop/qualifier/>\n" + 
				"PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n" + 
				"\n" + 
				"SELECT DISTINCT ?item ?name WHERE {\n" + 
				"  ?item rdfs:label ?name.\n" + 
				"  ?item wdt:P31 wd:Q5.\n" + 
				"  { {?item wdt:P106 wd:Q82594} UNION {?item wdt:P101 wd:Q21198} }.\n" + 
				"  OPTIONAL { ?item wdt:P864 ?acmid. }\n" + 
				"  OPTIONAL { ?item wdt:P214 ?VIAF_ID. }\n" + 
				"  OPTIONAL {  }\n" + 
				"  OPTIONAL { ?item wdt:P2456 ?DBLP_ID. }\n" + 
				"  BIND(CONCAT(\"viaf:\", ?VIAF_ID) AS ?b)\n" + 
				"  FILTER((LANG(?name)) = \"en\")\n" + 
				"}\n" + 
				"LIMIT 200"  ; 
			ResultSet rs = qe.executeSparqlQuery(squery);
			%>
			<section id="main" class="wrapper">
				<div class="inner">			
					<div class="row 200%">
					
						<!-- Left Pane Start -->
						<div id="leftpane" class="6u 12u$(medium)">

							<h3 id="headingleft">List of Computer Scientists</h3>
							<h4>Please click on the name of the person to retrieve details</h4>
							<div><h6 class="courtesy">Data Courtesy: Wikidata</h6></div>
							<br/>
							<div class="table-wrapper">
										<table id="mobile_list" class="alt">
											<thead>
												<tr>
													<th>Sl No </th>
													<th>Author Name</th>
												</tr>
												</thead>
											<tbody>
												<%
												int iCount = 0;
		while (rs.hasNext()) {
            // Get Result
            QuerySolution qs = rs.next();

            // Get Variable Names
            Iterator<String> itVars = qs.varNames();

            // Count
            iCount++;
            

            // Display Result
            while (itVars.hasNext()) {
                String szVar = itVars.next().toString();
                String szVal = qs.get(szVar).toString();
				String id = szVal.substring(31, szVal.length());
				
                szVar = itVars.next().toString();
                szVal = qs.get(szVar).toString();
			    szVal = szVal.substring(0, szVal.length()-3);
                System.out.println("[" + id + "]: " + szVal);

%>
												<tr>
													<td><%= iCount %></td>
													<td><a href=# onclick="showdetails('<%=id%>','<%=szVal%>');" class='link'><%= szVal %></a></td>
												</tr>
<%
            }
        }
												%>
											
												
											</tbody>
										</table>
							</div>
						</div>
						<!-- Left Pane End -->
						
						<!-- Right Pane Start -->

						<div id="rightpane" class="6u$ 12u$(medium)">
						
							<!-- Google Map showing Store locations -->
							<h3 id="headingright"></h3>
							
							<div>
								<div class="table-wrapper">
										<table id="mobile_list" class="alt">
											<thead>
												<tr>
													<th></th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>Name</td>
													<td id="name" style="font-weight:bold"></td>
												</tr>
												<tr>
													<td>Image</td>
													<td id="image"></td>
												</tr>
												<tr>
													<td>Citizenship</td>
													<td id="citizenship"></td>
												</tr>
												<tr>
													<td>Date of birth</td>
													<td id="dob"></td>
												</tr>
												<tr>
													<td>Website</td>
													<td id="website"></td>
												</tr>
												<tr>
													<td>ACM Profile</td>
													<td id="acmid"></td>
												</tr>
												<tr>
													<td>VIAF Profile</td>
													<td id="viafid"></td>
												</tr>
												<tr>
													<td>DBLP Profile</td>
													<td id="dblpid"></td>
												</tr>
											</tbody>
										</table>
								</div>
							</div>
							<div></div>
							<br/>
							<br/>
							
							
							<div>
							
							</div>
							<div></div>
						</div>
						<!-- Right Pane End -->
						
						
					</div>	<!-- <div class="row 200%"> -->
				</div>		<!-- <div class="inner">	 -->
			</section>
			

			


		<!-- Footer -->
			<footer id="footer">
				<div class="inner">
					<div class="flex">
						<div class="copyright">
							Developed for Assignment #3 - Theory & Applications of Ontologies
						</div>
					</div>
				</div>
			</footer>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>
			<script src="assets/js/jquery.custombox.js"></script> <!-- For popup showing brand details-->
			<script src="assets/js/bootstrap.min.js"></script> <!-- For popup showing brand details-->
			<script>
			
			</script>
	</body>
</html>