/*
 ******************************************************************
 *	sql script for inserting simple product to magento 2       *
 ******************************************************************
*/

/* inserting sku to catalog_product_entity. Initial step */
INSERT INTO `catalog_product_entity` (`attribute_set_id`, `type_id`, `has_options`, `required_options`, `sku`) 
VALUES (4, 'simple', 0, 0, 'simple-2-conf-2');

/* obtain entity_id from catalog_product_entity. This value is required to insert attributes in corresponding catalog_product_entity_(datatype) tables*/
select entity_id from catalog_product_entity where sku ="simple-2-conf-2";
/* entity_id is obtained as  for simple-2-conf-2*/


/* inserting visibility attribute for entity_id 5*/
/* Obtain attribute_id and datatype of visibility, */
select attribute_id, backend_model from eav_attribute where attribute_code="visibility";
/* attribute_id=99 datatype=NULL, but it is stored in int*/
/* now, based on int dataType, entity_id and attribute_set, insert the data*/
INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (99, 0, 16, 1);
/*similarly, insert int values for status as attribute_id = 97, quantity and stock status as 115, and taxclass id as 133*/
INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (97, 0, 16, 1);

INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (115, 0, 16, 1);

INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (133, 0, 16, 2);

/*here*/
INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (135, 0, 16, 4);

/********************/
/* inserting description as 75 and short description as 76 on catalog_product_entity_text table*/
INSERT INTO `catalog_product_entity_text` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (75, 0, 16, "description for simple-4-conf--2");

INSERT INTO `catalog_product_entity_text` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (76, 0, 16, "short desciption for simple-4-conf--2");


/********************/
/*inserting name as 73 of simple-4-conf on catalog_product_entity_varcar
 * page_layout as 104
 * options_container as 106
 * url_key as 119
 * gift_message_available as 134
*/
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (73, 0, 16, "Name of simple-4-conf--2");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (104, 0, 16, "1column");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (106, 0, 16, "container1");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (119, 0, 16, "simple-4-conf--2");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (134, 0, 16, "2");


/********************/
/* inserting price as 77  and weight as 82*/
INSERT INTO `catalog_product_entity_decimal` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (77, 0, 16, '5');
INSERT INTO `catalog_product_entity_decimal` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (82, 0, 16, '3');

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
VALUES (16,1, 5, 1, 1,1,1);


/*********************/
/*
 *inserting catogory to catalog_category_product on entity_id=5 
*/
INSERT INTO `catalog_category_product` (`entity_id`, `category_id`, `product_id`, `position`)
VALUES (5, 2, 16, 1);


/*********************/
/*
 * inserting product website in catalog_product_website for product_id as 5 and website_id as 1 (for base)
*/
INSERT INTO `catalog_product_website`(`product_id`, `website_id`) 
VALUES(16,1);
