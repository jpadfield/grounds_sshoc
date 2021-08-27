CREATE VIEW object_part_title_table AS 
SELECT o.*, ot.title_name, ot.title_short, ot.title_comment FROM title ot INNER JOIN (SELECT o.object_inventory_number, o.object_comment, o.object_height, o.object_diameter, o.title_id, op.object_part_name, op.object_part_comment, op.object_part_type FROM object o RIGHT JOIN object_part op ON o.object_id = op.object_id) o ON ot.title_id = o.title_id

CREATE VIEW object_medium_support AS 
SELECT om.*, s.support_name, s.support_comment FROM support s LEFT JOIN (SELECT o.object_id, o.object_inventory_number, m.medium_name, m.medium_comment FROM object o RIGHT JOIN medium m ON o.object_id = m.object_id) om ON s.object_id = om.object_id

CREATE VIEW object_reference AS
SELECT o.object_id, o.object_inventory_number, r.reference_id, r.thing_type, r.reference_title, r.reference_comment, r.reference_type, r.reference_link FROM object o RIGHT JOIN (SELECT r.*, rt.thing_id, rt.thing_type FROM reference r INNER JOIN referenceXthing rt ON r.reference_id = rt.reference_id WHERE thing_type = 'object') r ON o.object_id = r.thing_id

CREATE VIEW obj_reference_timespan_f AS
SELECT ot.*, o.object_inventory_number FROM obj_reference_timespan ot LEFT JOIN object o ON ot.object_id = o.object_id

CREATE VIEW object_event_influence AS 
SELECT e.*, i.influence_name, i.influence_id FROM (SELECT eo.*, t.timespan_name, t.timespan_start, t.timespan_end, t.timespan_descriptor, t.timespan_comment FROM timespan t INNER JOIN (SELECT e.*, o.object_inventory_number, o.object_creditline, o.manifacturing_process FROM object o RIGHT JOIN (SELECT e.event_name, e.event_id, e.event_type, e.timespan_id, e.timespan_confidence, et.thing_id FROM event e INNER JOIN (SELECT * FROM eventXthing WHERE thing_type = 'object') et ON e.event_id = et.event_id) e ON o.object_id = e.thing_id) eo ON t.timespan_id = eo.timespan_id) e LEFT JOIN (SELECT i.influence_name, i.influence_id, ie.event_id FROM influence i INNER JOIN influenceXevent ie ON i.influence_id = ie.influence_id) i ON e.event_id = i.event_id

CREATE VIEW person_parent_table AS 
SELECT ep.*, p.person_name AS person_parent_name FROM person p RIGHT JOIN (SELECT ep.*, t.timespan_name, t.timespan_start, t.timespan_end, t.timespan_descriptor, t.timespan_comment FROM timespan t INNER JOIN (SELECT p.*, e.event_name, e.timespan_id, e.timespan_confidence FROM event e INNER JOIN (SELECT p.person_name, p.person_id, p.person_parent_id, e.event_id FROM person p INNER JOIN personXevent e ON p.person_id = e.person_id) p ON p.event_id = e.event_id) ep ON ep.timespan_id = t.timespan_id) ep ON ep.person_parent_id = p.person_id

CREATE VIEW person_role_institution AS
SELECT pr.*, i.institution_name FROM institution i RIGHT JOIN (SELECT p.person_name, p.person_prefix_name, p.person_comment, p.person_other_name, p.person_contact, p.person_title, p.person_id, r.role_name, r.role_comment, r.institution_id FROM (SELECT p.*, pp.person_prefix_name FROM person p LEFT JOIN person_prefix pp ON p.person_prefix_id = pp.person_prefix_id) p RIGHT JOIN (SELECT r.role_name, r.role_comment, pr.person_id, pr.institution_id FROM role r RIGHT JOIN personXrole pr ON r.role_id = pr.role_id) r ON p.person_id = r.person_id) pr ON i.institution_id = pr.institution_id

CREATE VIEW person_influence AS 
SELECT p.*, i.influence_name, i.aat_link, i.influence_comment, i.parent_influence_id FROM (SELECT p.*, pp.person_prefix_name FROM person p LEFT JOIN person_prefix pp ON p.person_prefix_id = pp.person_prefix_id) p INNER JOIN (SELECT i.influence_name, i.aat_link, i.influence_comment, i.parent_influence_id, pi.person_id FROM influence i INNER JOIN personXinfluence pi ON i.influence_id = pi.influence_id) i ON p.person_id = i.person_id

CREATE VIEW parent_influence AS 
SELECT i.*, pi.influence_name as parent_influence_name FROM person_influence i LEFT JOIN influence pi ON i.parent_influence_id = pi.influence_id

CREATE VIEW place_institution_parent AS
SELECT pi.*, p.place_name as parent_place_name FROM (SELECT p.place_id, p.place_type, p.parent_place_id, p.place_name, p.latitude, p.longitude, p.place_comment, i.institution_name, i.institution_acronym, i.webpage, i.institution_type, i.institution_comment FROM place p RIGHT JOIN institution i ON i.place_id = p.place_id) pi LEFT JOIN place p ON p.place_id = pi.parent_place_id

CREATE VIEW place_timespan AS 
SELECT t.*, p.place_name FROM timespan t RIGHT JOIN place p ON t.timespan_id = p.timespan_id

CREATE VIEW full_timespan AS
SELECT te.*, t.timespan_name FROM timespan_extra te RIGHT JOIN timespan t ON te.timespan_id = t.timespan_id

CREATE VIEW object_part_sample AS
SELECT o.*, s.sample_type, s.sample_comment FROM sample s LEFT JOIN (SELECT o.object_id, o.object_inventory_number, op.object_part_id, op.object_part_name FROM object o LEFT JOIN object_part op ON o.object_id = op.object_id) o ON o.object_id = s.object_id

CREATE VIEW sample_component_view AS 
SELECT osl.*, c.sample_component_id, c.sample_component_number, c.sample_component_amount, c.sample_component_size, c.sample_comp_function_confidence, c.sample_component_function, c.sample_component_comment, c.measurementXcomposition_id FROM sample_component c LEFT JOIN (SELECT op.*, s.sample_layer_comment, s.sample_layer_id, s.sample_layer_thickness, s.object_layer_number, s.sample_layer_number FROM sample_layer s LEFT JOIN(SELECT o.*, s.sample_type, s.sample_comment, s.sample_number, s.sample_id FROM sample s LEFT JOIN (SELECT o.object_id, o.object_inventory_number, op.object_part_id, op.object_part_name FROM object o LEFT JOIN object_part op ON o.object_id = op.object_id) o ON o.object_id = s.object_id) op ON s.sample_id = op.sample_id) osl ON osl.sample_layer_id = c.sample_layer_id

CREATE VIEW sample_colour AS 
SELECT s.*, cd.colour_descriptor_name, cd.colour_descriptor_comment FROM colour_descriptor cd INNER JOIN (SELECT s.*, cm.colour_modifier_name, cm.colour_modifier_comment FROM colour_modifier cm INNER JOIN (SELECT s.sample_layer_id, s.colour_modifier_id, s.colour_descriptor_id, c.colour_main_name, c.colour_main_comment FROM sample_layer s INNER JOIN colour_main c ON s.colour_main_id = c.colour_main_id) s ON cm.colour_modifier_id = s.colour_modifier_id) s ON cd.colour_descriptor_id = s.colour_descriptor_id

CREATE VIEW sample_component_colours AS 
SELECT s.sample_component_id, s.colour_main_name, c.colour_descriptor_name, s.colour_main_comment, c.colour_descriptor_comment FROM colour_descriptor c INNER JOIN (SELECT s.sample_component_id, s.colour_descriptor_id, cd.colour_main_name, cd.colour_main_comment FROM sample_component s INNER JOIN colour_main cd ON s.colour_main_id = cd.colour_main_id) s ON c.colour_descriptor_id = s.colour_descriptor_id

CREATE VIEW sample_component_parents AS 
SELECT sc.sample_component_id, s.sample_component_id AS sample_component_parent_id FROM sample_component sc INNER JOIN sample_component_view s ON sc.parent_component_id = s.sample_component_id

SELECT p.*, cd.colour_descriptor_name, cd.colour_descriptor_comment FROM (SELECT p.*, cm.colour_modifier_name, cm.colour_modifier_comment FROM (SELECT p.*, cm.colour_main_name, cm.colour_main_comment FROM (SELECT p.preparation_id, p.surface_visibility, p.colour_main_id, p.colour_modifier_id, p.colour_descriptor_id, p.application_technique, p.preparation_comment, o.object_inventory_number FROM preparation p LEFT JOIN object o ON p.object_id = o.object_id) p LEFT JOIN colour_main cm ON p.colour_main_id = cm.colour_main_id) p LEFT JOIN colour_modifier cm ON p.colour_modifier_id = cm.colour_modifier_id) p LEFT JOIN colour_descriptor cd ON p.colour_descriptor_id = cd.colour_descriptor_id

CREATE VIEW sample_event AS 
SELECT eo.*, o.object_inventory_number FROM (SELECT eo.*, t.timespan_name, t.timespan_start, t.timespan_end, t.timespan_descriptor, t.timespan_comment FROM timespan t INNER JOIN (SELECT e.*, o.sample_id, o.object_id, o.sample_type, o.sample_number FROM sample o RIGHT JOIN (SELECT e.event_name, e.event_id, e.event_type, e.timespan_id, e.timespan_confidence, et.thing_id FROM event e INNER JOIN (SELECT * FROM eventXthing WHERE thing_type = 'sample') et ON e.event_id = et.event_id) e ON o.sample_id = e.thing_id) eo ON t.timespan_id = eo.timespan_id) eo LEFT JOIN object o ON eo.object_id = o.object_id

CREATE VIEW sample_timespan_event AS
SELECT es.*, ft.timespan_name FROM (SELECT * FROM (SELECT e.*, et.thing_id FROM event e RIGHT JOIN eventXthing et ON e.event_id = et.event_id WHERE et.thing_type = 'sample') e LEFT JOIN sample_component_view s ON e.thing_id = s.sample_id) es LEFT JOIN timespan ft ON es.timespan_id = ft.timespan_id

CREATE VIEW event_protocol AS
SELECT pi.*, e.event_id, e.event_name FROM (SELECT pi.*, t.technique_name, t.technique_full_name, t.technique_link, t.technique_comment FROM (SELECT pi.*, t.timespan_name, t.timespan_start, t.timespan_end, t.timespan_descriptor, t.timespan_comment FROM (SELECT p.*, i.institution_name FROM protocol p LEFT JOIN institution i ON p.institution_id = i.institution_id) pi LEFT JOIN timespan t ON pi.timespan_id = t.timespan_id) pi LEFT JOIN technique t ON pi.technique_id = t.technique_id) pi LEFT JOIN event e ON pi.protocol_id = e.protocol_id

CREATE VIEW measurement_materials AS
SELECT me.*, m.material_name, m.material_type, m.material_class, m.material_subclass, m.material_link, m.material_comment, SUBSTRING_INDEX(me.event_name, 'painting ', -1) AS object_inventory_number FROM (SELECT me.*, mc.measurementXcomposition_id, mc.material_id, mc.material_value, mc.`material_value%`, mc.result_confidence, mc.measurementXcomposition_comment FROM (SELECT m.*, e.event_name, e.event_type FROM `measurement` m INNER JOIN event e ON m.event_id = e.event_id) me RIGHT JOIN measurementXcomposition mc ON me.measurement_id = mc.measurement_id) me LEFT JOIN material m ON me.material_id = m.material_id

CREATE VIEW sample_location AS
SELECT s.*, m.mesh_name FROM (SELECT s.*, i.image_file FROM (SELECT s.*, o.object_part_name FROM (SELECT s.*, o.object_inventory_number FROM (SELECT s.sample_id, s.sample_number, s.object_id, s.object_part_id, l.* FROM sample s LEFT JOIN location l ON s.location_id = l.location_id) s LEFT JOIN object o ON s.object_id = o.object_id) s LEFT JOIN object_part o ON s.object_part_id = o.object_part_id) s LEFT JOIN image i ON s.image_id = i.image_id) s LEFT JOIN 3Dmodel m ON s.3Dmodel_id = m.3Dmodel_id

CREATE VIEW mediaXobject AS 
SELECT t.media_id, o.object_inventory_number FROM (SELECT * FROM mediaXthing WHERE thing_type = 'object') t LEFT JOIN object o ON t.thing_id = o.object_id

CREATE VIEW mediaXsample AS 
SELECT media_id, thing_id FROM mediaXthing WHERE thing_type = 'sample'

CREATE VIEW mediaXperson AS 
SELECT t.media_id, p.person_name, p.person_prefix_name FROM (SELECT * FROM mediaXthing WHERE thing_type = 'person') t LEFT JOIN (SELECT p.person_id, p.person_name, pi.person_prefix_name FROM person p LEFT JOIN person_prefix pi ON p.person_prefix_id = pi.person_prefix_id) p ON t.thing_id = p.person_id

CREATE VIEW image_full AS
SELECT i.*, p.person_name, p.person_prefix_name FROM (SELECT i.*, s.thing_id AS sample_id FROM (SELECT i.*, o.object_inventory_number FROM image i LEFT JOIN mediaXobject o ON i.image_id = o.media_id) i LEFT JOIN mediaXsample s ON i.image_id = s.media_id) i LEFT JOIN mediaXperson p ON i.image_id = p.media_id

CREATE VIEW image_path_server_etc AS
SELECT i.*, s.server_name FROM (SELECT i.*, p.path_name, p.path_original, p.path_public FROM image_full i LEFT JOIN path p ON i.path_id = p.path_id) i LEFT JOIN server s ON i.server_id = s.server_id

CREATE VIEW model_path_server_etc AS 
SELECT pm.*, o.object_inventory_number FROM (SELECT pm.*, s.server_name FROM (SELECT p.path_name, p.path_original, p.path_public, m.* FROM `3Dmodel` m LEFT JOIN path p ON m.path_id = p.path_id) pm LEFT JOIN server s ON pm.server_id = s.server_id) pm LEFT JOIN mediaXobject o ON pm.3Dmodel_id = o.media_id

CREATE VIEW institution_classification AS 
SELECT i.institution_name, ct.* FROM (SELECT c.classification_name, c.classification_type, c.classification_parent_id, c.aat_link, c.classification_comment, c.classification_id, ct.thing_id FROM (SELECT * FROM classificationXthing WHERE thing_type = 'institution') ct LEFT JOIN classification c ON c.classification_id = ct.classification_id) ct RIGHT JOIN institution i ON i.institution_id = ct.thing_id

CREATE VIEW object_classification AS 
SELECT i.object_inventory_number, ct.* FROM (SELECT c.classification_name, c.classification_type, c.classification_parent_id, c.aat_link, c.classification_comment, c.classification_id, ct.thing_id FROM (SELECT * FROM classificationXthing WHERE thing_type = 'object') ct LEFT JOIN classification c ON c.classification_id = ct.classification_id) ct RIGHT JOIN object i ON i.object_id = ct.thing_id

CREATE VIEW protocol_classification AS 
SELECT i.protocol_name, ct.* FROM (SELECT c.classification_name, c.classification_type, c.classification_parent_id, c.aat_link, c.classification_comment, c.classification_id, ct.thing_id FROM (SELECT * FROM classificationXthing WHERE thing_type = 'protocol') ct LEFT JOIN classification c ON c.classification_id = ct.classification_id) ct RIGHT JOIN protocol i ON i.protocol_id = ct.thing_id

CREATE VIEW sample_layer_classification AS 
SELECT i.sample_layer_id, ct.* FROM (SELECT c.classification_name, c.classification_type, c.classification_parent_id, c.aat_link, c.classification_comment, c.classification_id, ct.thing_id FROM (SELECT * FROM classificationXthing WHERE thing_type = 'sample layer') ct LEFT JOIN classification c ON c.classification_id = ct.classification_id) ct RIGHT JOIN sample_layer i ON i.sample_layer_id = ct.thing_id

CREATE VIEW sample_reference AS 
SELECT o.sample_id, r.reference_id, r.thing_type, r.reference_title, r.reference_comment, r.reference_type, r.reference_link FROM sample o RIGHT JOIN (SELECT r.*, rt.thing_id, rt.thing_type FROM reference r INNER JOIN referenceXthing rt ON r.reference_id = rt.reference_id WHERE thing_type = 'sample') r ON o.sample_id = r.thing_id