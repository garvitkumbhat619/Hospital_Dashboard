SELECT
    m.id AS id,
    m.medicine_id AS medicine_id,
    m.name AS name,
    m.category AS category,
    m.supplier_id AS supplier_id,
    m.cost_price AS cost_price,
    m.unit_price AS unit_price,
    m.stock_qty AS stock_qty,
    m.expiry_date AS expiry_date,
    m.manufacture_date AS manufacture_date,
    m.batch_number AS batch_number,
    m.reorder_level AS reorder_level,
    s.name AS supplier_name
FROM
    medical_stock m
LEFT JOIN
    supplier s ON m.supplier_id = s.supplier_id;
    