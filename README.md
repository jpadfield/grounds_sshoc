[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.6461469.svg)](https://doi.org/10.5281/zenodo.6461469)
# SSHOC - Mapping Painting Sample data to the CIDOC CRM
Please note the content of the Inputs and Outputs is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].
[![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]
[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]
[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

In 2018 the <a href="https://doi.org/10.5281/zenodo.5838339">IPERION-CH Grounds Database</a> was presented to examine how the data produced through the scientific examination of historic painting preparation or grounds samples, from multiple institutions could be combined in a flexible digital form. Exploring the presentation of interrelated high resolution images, text, complex metadata and procedural documentation. The original <a href="https://research.ng-london.org.uk/iperion/">main user interface</a> is live, though password protected at this time. The SSHOC work aimed to make this data more [FAIR](https://www.go-fair.org/fair-principles/) so in addition to mapping it to a standard ontology, to increase Interoperability, it has also been made available in the form of <a href="http://en.wikipedia.org/wiki/Linked_Data">open linkable data</a> combined with a <a href="http://en.wikipedia.org/wiki/SPARQL">SPARQL</a> end-point. A draft version of this live data presentation can been found [Here](https://rdf.ng-london.org.uk/sshoc/).

This repo contains code that connects to a version of the National Gallery's GROUNDS database on MySQL and maps the data to CIDOC-CRM.

## Running the code
* To run the code in this repo simply run grounds_mapping.py from the command line. 
* Certain inputs (AAT references) appear in the inputs folder as Excel spreadsheets; others are tables within MySQL.
* The MySQL connection can be pointed elsewhere in the connect_to_sql() function within common_functions.py.
* Copies of each section of the code are saved in the outputs folder as they are generated. There are seven sub-graphs which combined make up a full graph. Outputs are saved in XML, TTL and TRIG formats.
* A partial rebuild can be initiated by deleting the relevant files in the outputs folder and rerunning the code (e.g. to rebuild all objects, delete the grounds_object files). The code checks for these output files before it decides which parts of the graph to build.
* A full rebuild can be initiated by passing the command line argument 'fullrebuild' when running grounds_mapping. This will take a long time to run so it's not recommended unless absolutely necessary.
* Run inferencing.py with a graph TTL file as the input to output an inferenced version of the RDF graph.

## MySQL view creation
* The file grounds_sql_queries.sql contains numerous queries that will create VIEWS that act as the inputs for the Python code. If this code is run atop another database the views should be created using this SQL code beforehand, otherwise it will not work.
 
## Tables reference for the GROUNDS database
[database structure_ground_16.10.2017.pdf](https://github.com/odelaney/grounds_sshoc/files/7067846/database.structure_ground_16.10.2017.pdf)

# Acknowledgement
This project was developed and tested as part of the work of the following project:

## H2020 EU project [SSHOC](https://sshopencloud.eu/)
<img height="64px" src="https://github.com/jpadfield/simple-site/blob/master/docs/graphics/sshoc-logo.png" alt="SSHOC Grant Info">
<img height="32px" src="https://github.com/jpadfield/simple-site/blob/master/docs/graphics/sshoc-eu-tag2.png" alt="SSHOC Grant Info">
