/*
 ******************************************************************
 *	SQL script for inserting grouped product to Magento 2      *
 ******************************************************************
*/

/* inserting sku to catalog_product_entity. This is the initialization step for any product. */
INSERT INTO `catalog_product_entity` (`attribute_set_id`, `type_id`, `has_options`, `required_options`, `sku`, `created_at`, `updated_at`) 
VALUES (4, 'grouped', 0, 0, 'Test Group 2', '2013-02-06 10:15:08', '2016-08-18 06:12:57');

/* obtain entity_id from catalog_product_entity. This value is required to insert attributes in corresponding catalog_product_entity_(datatype) tables*/
select entity_id from catalog_product_entity where sku ="Test-Group-2";
/* entity_id is obtained as 7 for Test-Group-2*/

/********************/
/* inserting visibility attribute for entity_id 5*/
/* Obtain attribute_id and datatype of visibility */
select attribute_id, backend_type from eav_attribute where attribute_code="visibility";
/* attribute_id=99 backend_type=int, so it is stored in catalog_product_entity_int*/
/* similarly, get attribute_id of all required attribute_codes */
/* now, based on int dataType, entity_id and attribute_set, insert the data.*/
INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (99, 0, 7, 4);
/*similarly, insert int values for status as attribute_id = 97, quantity and stock status as 115*/
INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (97, 0, 7, 1);

INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (115, 0, 7, 1);


/********************/
/* inserting description as 75 and short description as 76 on catalog_product_entity_text table*/
INSERT INTO `catalog_product_entity_text` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (75, 0, 7, "description for group test 2");

INSERT INTO `catalog_product_entity_text` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (76, 0, 7, "short desciption for group test 2");


/********************/
/*inserting following on catalog_product_entity_varchar
 * name as 73
 * page_layout as 104
 * options_container as 106
 * url_key as 119
 * gift_message_available as 134
*/
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (73, 0, 7, "Name of group-test-2");

INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (104, 0, 7, "1column");

INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (106, 0, 7, "container1");

INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (119, 0, 7, "Group test 2");

INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (134, 0, 7, "2");


/********************/
/* inserting stock related details for the product*/
/*product_id is entity_id of the product as 2, 
 *stock_id is 1 for linking stock id in cataloginventory_stock (it maintains foreign key constraints)
 *qty for number of quantity in stock: 0. since quantity is flexible in grouped products
 * is_in_stock : 1
 * notify_stock_qty : 1 for stock administration
 * manage_stock: 1 i dont kno  :)
 * qty_increaments: 1, for unit of increment in stock
*/
INSERT INTO `cataloginventory_stock_item` (`product_id`, `stock_id`,`qty`, `is_in_stock`, `notify_stock_qty`,`manage_stock`,`qty_increments`)
VALUES (7,1, 0, 1, 1,1,1);


/*********************/
/*
 *inserting catogory to catalog_category_product on entity_id=7 
 * used multiple insert in catalog_category_product for assigning multiple categories to same product
 * here, product_id is the entity_id that identifies the product
 * here, category_id is 2 for default category. Find similar categories in catalog_category_entity table
*/
INSERT INTO `catalog_category_product` (`category_id`, `product_id`, `position`)
VALUES (2, 7, 1);


/*********************/
/*
 * inserting product website in catalog_product_website for product_id as 5 and website_id as 1 for base, 2 for Main Website
 * used multiple insert in catalog_category_product for assigning multiple websites to same product
 * here, product_id is the entity_id that identifies the product
 * website_id is the website_id in store_website that identifies the type of website
*/

INSERT INTO `catalog_product_website`(`product_id`, `website_id`) 
VALUES(7,1);


/*********************/
/*
 * insert parent child relation of grouped products
 * this is maintainted in catalog_product_link
 * link-id is primary key to denote relation for other purposes
 * product_id is the sku entity_id of product from catalog_product_entityouped products
 * linked_product_id are simple products
 * link type is 3 (valued as 'super' in catalog_product_link_type) for grouped products
*/
INSERT INTO `catalog_product_link` (`product_id`,`linked_product_id`,`link_type_id`)
VALUES (7,5,3);

INSERT INTO `catalog_product_link` (`product_id`,`linked_product_id`,`link_type_id`)
VALUES (7,4,3);

INSERT INTO `catalog_product_link` (`product_id`,`linked_product_id`,`link_type_id`)
VALUES (7,3,3);

/*
 * now define quantity for the grouped item. 
 * product_link_attribute_id is for which variable to assign. we are giving qty, so it is 5. It can be found in catalog_product_link_attribute
 * link_id is the link _id from catalog_product_link, this link gives the relation among the products
 * value is the actual value to be assigned to product_link_attribute_id i.e 5 for qty
*/
INSERT INTO `catalog_product_link_attribute_decimal` (`product_link_attribute_id`,`link_id`,`value`)
VALUES (5,18,3);

INSERT INTO `catalog_product_link_attribute_decimal` (`product_link_attribute_id`,`link_id`,`value`)
VALUES (5,19,5);

INSERT INTO `catalog_product_link_attribute_decimal` (`product_link_attribute_id`,`link_id`,`value`)
VALUES (5,20,3);
