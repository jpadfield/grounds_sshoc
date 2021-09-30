CREATE VIEW object_event_influence AS
SELECT
  e.*,
  i.influence_name,
  i.influence_id
FROM
  (
    SELECT
      eo.*,
      t.timespan_name,
      t.timespan_start,
      t.timespan_end,
      t.timespan_descriptor,
      t.timespan_comment
    FROM
      timespan t
      INNER JOIN (
        SELECT
          e.*,
          o.object_inventory_number,
          o.object_creditline,
          o.manifacturing_process
        FROM
          object o
          RIGHT JOIN (
            SELECT
              e.event_name,
              e.event_id,
              e.event_type,
              e.timespan_id,
              e.timespan_confidence,
              et.thing_id
            FROM
              event e
              INNER JOIN (
                SELECT
                  *
                FROM
                  eventXthing
                WHERE
                  thing_type = 'object'
              ) et ON e.event_id = et.event_id
          ) e ON o.object_id = e.thing_id
      ) eo ON t.timespan_id = eo.timespan_id
  ) e
  LEFT JOIN (
    SELECT
      i.influence_name,
      i.influence_id,
      ie.event_id
    FROM
      influence i
      INNER JOIN influenceXevent ie ON i.influence_id = ie.influence_id
  ) i ON e.event_id = i.event_id