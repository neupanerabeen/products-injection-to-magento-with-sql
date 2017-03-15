/*
 ******************************************************************
 *	sql script for inserting simple product to magento 2      *
 ******************************************************************
*/

/* inserting sku to catalog_product_entity. Initial step. `type_id` is simple for simple products */
INSERT INTO `catalog_product_entity` (`attribute_set_id`, `type_id`, `has_options`, `required_options`, `sku`) 
VALUES (4, 'simple', 0, 0, 'simple-4-conf-2');

/* obtain entity_id from catalog_product_entity. This value is required to insert attributes in corresponding catalog_product_entity_(datatype) tables*/
select entity_id from catalog_product_entity where sku ="simple-4-conf-2";
/* entity_id is obtained as 5 for simple-4-conf*/


/* inserting visibility attribute for entity_id 13*/
/* Obtain attribute_id and datatype of visibility, */
select attribute_id, backend_model, backend_type from eav_attribute where attribute_code="visibility";
/* attribute_id=99 backend_model=NULL, backend_type=int so it is stored as int*/
/* now, based on int dataType, entity_id and attribute_set, insert the data to corresponding table. Here, its catalog_product_entity_int*/
INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (99, 0, 13, 4);
/*similarly, insert int values for status as attribute_id = 97, quantity and stock status as 115, and taxclass id as 133*/
INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (97, 0, 13, 1);

INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (115, 0, 13, 1);

INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (133, 0, 13, 2);

/********************/
/* inserting description as 75 and short description as 76 on catalog_product_entity_text table*/
INSERT INTO `catalog_product_entity_text` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (75, 0, 13, "description for simple-4-conf--2");

INSERT INTO `catalog_product_entity_text` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (76, 0, 13, "short desciption for simple-4-conf--2");


/********************/
/*inserting name as 73 of simple-4-conf on catalog_product_entity_varcar
 * page_layout as 104
 * options_container as 106
 * url_key as 119
 * gift_message_available as 134
*/
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (73, 0, 13, "Name of simple-4-conf--2");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (104, 0, 13, "1column");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (106, 0, 13, "container1");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (119, 0, 13, "simple-4-conf--2");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (134, 0, 13, "2");


/********************/
/* inserting price as 77  and weight as 82*/
INSERT INTO `catalog_product_entity_decimal` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (77, 0, 13, '5');
INSERT INTO `catalog_product_entity_decimal` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (82, 0, 13, '3');

/********************/
/* inserting stock related details for simple-4-conf as 2*/
/*product_id is entity_id of simple-4-conf as 2, 
 *stock_id is 1 for linking stock id in cataloginventory_stock(it maintains foreign key constraints)
 *qty for number of quantity in stock: 5
 * is_in_stock : 1
 * notify_stock_qty : 1 for stock administration
 * manage_stock: 1 i dont kno :)
 * qty_increaments: 1, for unit of increment in stock
*/
INSERT INTO `cataloginventory_stock_item` (`product_id`, `stock_id`,`qty`, `is_in_stock`, `notify_stock_qty`,`manage_stock`,`qty_increments`)
VALUES (13,1, 5, 1, 1,1,1);


/*********************/
/*
 *inserting catogory to catalog_category_product on entity_id=5 
*/
INSERT INTO `catalog_category_product` (`entity_id`, `category_id`, `product_id`, `position`)
VALUES (5, 2, 13, 1);


/*********************/
/*
 * inserting product website in catalog_product_website for product_id as 5 and website_id as 1 (for base)
*/
INSERT INTO `catalog_product_website`(`product_id`, `website_id`) 
VALUES(13,1);
