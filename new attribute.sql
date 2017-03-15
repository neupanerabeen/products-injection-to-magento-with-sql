/*********************/
/*
 * if there is no attribute, insert data as follows for inserting (new) attribute set 
	* insert a new attribute to eav_attribute
*/
INSERT INTO `eav_attribute` (`entity_type_id`, `attribute_code`, `attribute_model`, `backend_model`, `backend_type`, `backend_table`, `frontend_model`, `frontend_input`, `frontend_label`, `frontend_class`, `source_model`, `is_required`, `is_user_defined`, `default_value`, `is_unique`, `note`) 
VALUES (4, "test-size",NULL, NULL,"int",NULL,NULL,"select","Size",NULL,"Magento\\Eav\\Model\\Entity\\Attribute\\Source\\Table",0,1,NULL,0,NULL);

/*get attribute_id for this entry for further purposes*/
SELECT attribute_id FROM `eav_attribute` where attribute_code like "%test-size%"; 
/* returned 136*/


/*now, register the attribute in eav_attribute_option. Primary key of this entry will represent the attribute value in catalog_product_entity_int (for this case, int). So, for every new type of custom attribute, new row needs to be inserted here.*/
INSERT INTO `eav_attribute_option` (`attribute_id`,`sort_order`) 
VALUES(136,1);
/*get option_id for next step*/
SELECT option_id FROM `eav_attribute_option` where attribute_id = 136;
/*returned 6*/ 

/*
for other product
*/
INSERT INTO `eav_attribute_option` (`attribute_id`,`sort_order`) 
VALUES(136,1);

/*now, insert the options values for registered attribute option in eav_attribute_option_value. It is just giving the value for the atribute from eav_attribute_option table. eav_attribute_option_value table maintains foreign key constraints with eav_attribute_option in option_id */
INSERT INTO `eav_attribute_option_value` (`option_id`,`store_id`,`value`) 
VALUES(6,0,"XL");

INSERT INTO `eav_attribute_option_value` (`option_id`,`store_id`,`value`) 
VALUES(7,0,"M");

/* finally, insert the option_id from eav_attribute_option for 136 entry to catalog_product_entry_int*/
INSERT INTO `catalog_product_entity_int` (`attribute_id`,`store_id`,`entity_id`,`value`) 
VALUES(136,0,13,7);
/*
	* insert that new attribute to catalog_product_super_attribute
INSERT INTO `catalog_product_super_attribute` (`product_id`,`attribute_id`,`position`)
VALUES()
		** It should maintain foreign key constranits to eav_attribute as created above
	* insert that new attribute to catalog_product_super_attribute_label
		** It is defining the label for attribute set.
		** It should maintain foreign key constranits to catalog_product_super_attribute as created above
*/

