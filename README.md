# GROUNDS to CIDOC-CRM
This repo contains code that connects to a version of the National Gallery's GROUNDS database on MySQL and maps the data to CIDOC-CRM.

## Running the code
* To run the code in this repo simply run grounds_mapping.py from the command line. 
* Certain inputs (AAT references) appear in the inputs folder as Excel spreadsheets; others are tables within MySQL.
* The MySQL connection can be pointed elsewhere in the connect_to_sql() function within common_functions.py.
* Copies of each section of the code are saved in the outputs folder as they are generated. There are seven subgraphs which combined make up a full graph. Outputs are saved in XML, TTL and TRIG formats.
* A partial rebuild can be initiated by deleting the relevant files in the outputs folder and rerunning the code (e.g. to rebuild all objects, delete the grounds_object files). The code checks for these output files before it decides which parts of the graph to build.
* A full rebuild can be initiated by passing the command line argument 'fullrebuild' when running grounds_mapping. This will take a long time to run so it's not recommended unless absolutely necessary.
* Run inferencing.py with a graph TTL file as the input to output an inferenced version of the RDF graph.
 
## Tables reference for the GROUNDS database
[database structure_ground_16.10.2017.pdf](https://github.com/odelaney/grounds_sshoc/files/7067846/database.structure_ground_16.10.2017.pdf)


