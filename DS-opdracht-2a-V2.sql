CREATE TABLE mhl_cities_unknown AS SELECT s.* FROM mhl_suppliers s LEFT JOIN mhl_cities ci ON s.city_ID = ci.id WHERE ci.id IS NULL;
DELETE s FROM mhl_suppliers s LEFT JOIN mhl_cities ci ON s.city_ID = ci.id WHERE ci.id IS NULL;
ALTER TABLE mhl_suppliers ADD CONSTRAINT fk_mhl_suppliers_city_id FOREIGN KEY (city_ID) REFERENCES mhl_cities(id);

CREATE TABLE mhl_contacts_unknown AS SELECT c.* FROM mhl_contacts c LEFT JOIN mhl_suppliers s ON c.supplier_ID = s.id WHERE s.id IS NULL;
DELETE c FROM mhl_contacts c LEFT JOIN mhl_suppliers s ON c.supplier_ID = s.id WHERE s.id IS NULL;
ALTER TABLE mhl_contacts ADD CONSTRAINT fk_mhl_contacts_supplier_id FOREIGN KEY (supplier_ID) REFERENCES mhl_suppliers(id) ON DELETE CASCADE;

CREATE TABLE mhl_hitcount_unknown AS SELECT h.* FROM mhl_hitcount h LEFT JOIN mhl_suppliers s ON h.supplier_ID = s.id WHERE s.id IS NULL;
DELETE h FROM mhl_hitcount h LEFT JOIN mhl_suppliers s ON h.supplier_ID = s.id WHERE s.id IS NULL;
ALTER TABLE mhl_hitcount ADD CONSTRAINT fk_mhl_hitcount_supplier_id FOREIGN KEY (supplier_ID) REFERENCES mhl_suppliers(id);

CREATE TABLE mhl_properties_unknown AS SELECT p.* FROM mhl_properties p LEFT JOIN mhl_suppliers s ON p.supplier_ID = p.id WHERE s.id IS NULL;
DELETE p FROM mhl_properties p LEFT JOIN mhl_suppliers s ON p.supplier_ID = s.id WHERE s.id IS NULL;
ALTER TABLE mhl_properties ADD CONSTRAINT fk_mhl_properties_supplier_id FOREIGN KEY (supplier_ID) REFERENCES mhl_suppliers(id); 

CREATE TABLE mhl_yn_properties_unknown AS SELECT pt.* FROM mhl_yn_properties pt LEFT JOIN mhl_suppliers s ON pt.supplier_ID = s.id WHERE s.id IS NULL;
DELETE pt FROM mhl_yn_properties pt LEFT JOIN mhl_suppliers s ON pt.supplier_ID = s.id WHERE s.id IS NULL;
ALTER TABLE mhl_yn_properties ADD CONSTRAINT fk_mhl_yn_properties_supplier_id FOREIGN KEY (supplier_ID) REFERENCES mhl_suppliers(id);

CREATE TABLE mhl_suppliers_mhl_rubriek_view_unknown AS SELECT rv.* FROM mhl_suppliers_mhl_rubriek_view rv LEFT JOIN mhl_suppliers s ON rv.mhl_suppliers_ID = s.id WHERE s.id IS NULL; 
DELETE rv FROM mhl_suppliers_mhl_rubriek_view rv LEFT JOIN mhl_suppliers s ON rv.mhl_suppliers_ID = s.id WHERE s.id IS NULL;
ALTER TABLE mhl_suppliers_mhl_rubriek_view ADD CONSTRAINT fk_mhl_suppliers_rubriek_supplier_id FOREIGN KEY (mhl_suppliers_ID) REFERENCES mhl_suppliers(id); 

CREATE TABLE mhl_rubrieken_unknown AS SELECT r.* FROM mhl_rubrieken r LEFT JOIN mhl_rubrieken p ON r.parent = p.id WHERE p.id IS NULL and r.parent IS NOT NULL;
DELETE r FROM mhl_rubrieken r LEFT JOIN mhl_rubrieken p ON r.parent = p.id WHERE p.id IS NULL AND r.parent IS NOT NULL; 

CREATE TABLE mhl_companies_unknown AS SELECT co.* FROM mhl_companies co LEFT JOIN mhl_suppliers s ON co.supplier_ID = co.id WHERE co.id IS NULL;
DELETE co FROM mhl_companies co LEFT JOIN mhl_suppliers s ON co.supplier_ID = co.id WHERE co.id IS NULL;
ALTER TABLE mhl_suppliers ADD CONSTRAINT fk_mhl_supplier_company FOREIGN KEY (company) REFERENCES mhl_companies(id);