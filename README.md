# GROUNDS to CIDOC-CRM
This repo contains code that connects to a version of the National Gallery's GROUNDS database on MySQL and maps the data to CIDOC-CRM.

## Running the code
* To run the code in this repo simply run grounds_mapping.py from the command line. 
* Certain inputs (AAT references) appear in the inputs folder as Excel spreadsheets; others are tables within MySQL.
* The MySQL connection can be pointed elsewhere in the connect_to_sql() function within common_functions.py.
* Copies of each section of the code are saved in the outputs folder as they are generated. There are seven subgraphs which combined make up a full graph. Outputs are saved in XML, TTL and TRIG formats.
* A partial rebuild can be initiated by deleting the relevant files in the outputs folder and rerunning the code (e.g. to rebuild all objects, delete the grounds_object files). The code checks for these output files before it decides which parts of the graph to build.
* A full rebuild can be initiated by passing the command line argument 'fullrebuild' when running grounds_mapping. This will take a long time to run so it's not recommended unless absolutely necessary.
 
## Tables reference for the GROUNDS database
![PXL_20210329_154909481](https://user-images.githubusercontent.com/26337095/131146037-c650f24e-3a40-4caa-872d-7140567c59bd.jpg)

