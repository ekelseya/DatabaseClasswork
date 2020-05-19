// Principles of Database Systems
// Dr. Thyago Mota
// Authors: Lance Barto & Eryn Kelsey-Adkins
// Date: December 05, 2019

// Load the data from the .json file in the local import folder
CALL apoc.load.json('file:///network.json') YIELD value AS disease
MERGE ( a:Disease { code: disease.a.id, name: disease.a.name } )
MERGE ( b:Disease { code: disease.b.id, name: disease.b.name } )
MERGE (a)-[:associates]->(b);

// Call the community grouping algorithm (commented out because can't run more than one script at a time)

// CALL algo.louvain.stream('Disease', 'associates')
// IELD nodeId, community
// RETURN algo.asNode(nodeId).code AS id, community
// ORDER BY community;
