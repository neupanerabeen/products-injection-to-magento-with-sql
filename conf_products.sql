/*
 ******************************************************************
 *   sql script for inserting configurable product to magento 2   *
 ******************************************************************
*/


/*
*****
* First, insert simple products. Refer simple_products.sql for inserting simple products. IF (simple products in database) ready to configure! Lets roll!
*****
*/

/*
* inserting configurable product. Few steps below are same as inserting simple products. Well, just a few alterations. 
*/

/*
* inserting sku to catalog_product_entity. Initial step. Set type_id to "configurable" 
*/
INSERT INTO `catalog_product_entity` (`attribute_set_id`, `type_id`, `has_options`, `required_options`, `sku`) 
VALUES (4, 'configurable', 0, 0, 'conf-test-3');

/* obtain entity_id from catalog_product_entity. This value is required to insert attributes in corresponding catalog_product_entity_(datatype) tables*/
select entity_id from catalog_product_entity where sku ="conf_test-3";
/* entity_id is obtained as 18 for conf_test*/


/* inserting visibility attribute for entity_id 11*/
/* Obtain attribute_id and datatype of visibility, */
select attribute_id, backend_model, backend_type from eav_attribute where attribute_code="visibility";
/* attribute_id=99 backend_model=NULL, backend_type=int so it is stored as int*/
/* now, based on int dataType, entity_id and attribute_set, insert the data to corresponding table. Here, its catalog_product_entity_int*/
INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (99, 0, 18, 4);

/*similarly, insert int values for status as attribute_id = 97, quantity and stock status as 115, and taxclass id as 133*/
INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (97, 0, 18, 1);

INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (115, 0, 18, 1);

INSERT INTO `catalog_product_entity_int` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (133, 0, 18, 2);


/********************/
/* inserting description as 75 and short description as 76 on `catalog_product_entity_text` table. So, in reciprocal, `description` and `short_description` are stored as text*/
INSERT INTO `catalog_product_entity_text` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (75, 0, 18, "description for conf_test-3");

INSERT INTO `catalog_product_entity_text` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (76, 0, 18, "short desciption for conf_test-3");


/********************/
/*inserting name as 73 of conf-test-3 on catalog_product_entity_varchar
 * page_layout as 104
 * options_container as 106
 * url_key as 119
 * gift_message_available as 134
*/
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (73, 0, 18, "Test from sql--2");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (104, 0, 18, "1column");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (106, 0, 18, "container1");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (119, 0, 18, "cont_test-2");
INSERT INTO `catalog_product_entity_varchar` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (134, 0, 18, "2");


/********************/
/* inserting price as 77  and weight as 82*/
INSERT INTO `catalog_product_entity_decimal` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (77, 0, 18, '2');
INSERT INTO `catalog_product_entity_decimal` (`attribute_id`, `store_id`, `entity_id`, `value`)
VALUES (82, 0, 18, '2');

/********************/
/* inserting stock related details for conf-test-3 as 2*/
/*product_id is entity_id if test3 as 2, 
 *stock_id is 1 for linking stock id in cataloginventory_stock(it maintains foreign key constraints) ~Dig more if required!
 *qty for number of quantity in stock: 5 (for 5 units)
 * is_in_stock : 1 (for true)
 * notify_stock_qty : 1 (for stock administration)
 * manage_stock: 1 (i dont kno :)  )
 * qty_increaments: 1 (for unit of increment in stock)
*/
INSERT INTO `cataloginventory_stock_item` (`product_id`, `stock_id`,`qty`, `is_in_stock`, `notify_stock_qty`,`manage_stock`,`qty_increments`)
VALUES (18,1, 50, 1, 1,1,1);


/*********************/
/*
*inserting catogory to catalog_category_product on entity_id=18
* `category_id` : 2 (for defining which category does the product belong) ~Dig out table `catalog_category_entity` for more info  
*/
INSERT INTO `catalog_category_product` (`category_id`, `product_id`, `position`)
VALUES (2, 18, 1);


/*********************/
/*
* inserting product website in catalog_product_website for product_id as 5 and website_id as 1 (for base)
* `website_id` : 1 (for defining which website does the product belong) ~Dig out table `store_website` for more info  
*/
INSERT INTO `catalog_product_website`(`product_id`, `website_id`) 
VALUES(18,1);


/*
* Configuration part
*/

/*
* defining the attribute that configures the products. 
* Assume we have already defined a configurable attribute as `attribute_id` = 135 
*/
INSERT INTO `catalog_product_super_attribute`(`product_id`,`attribute_id`, `position`) 
VALUES (18,135,0);



/*********************/
/*
* inserting  in catalog_product_relation for parent_id and child_id accordingly. This id should maintain foreign key constraints to `catalog_product_entity` on `entity_id`.
* Insert a row for each parent-child association
* here, we have two products to associate
*/
INSERT INTO `catalog_product_relation`(`parent_id`, `child_id`) 
VALUES(18,15);

INSERT INTO `catalog_product_relation`(`parent_id`, `child_id`) 
VALUES(18,16);


/*********************/
/*
 * inserting  in `catalog_product_super_link` for parent_id and product_id accordingly. This id should maintain foreign key constraints to `catalog_product_entity` on product_id and parent_id. Give configurable entity_id from `product_catalog_entity` to parent_id and simple product's entity_id to product_id
* As stated above, we have two simple products associated to a configurable parent
*/
INSERT INTO `catalog_product_super_link`(`product_id`, `parent_id`) 
VALUES(15,18);
INSERT INTO `catalog_product_super_link`(`product_id`, `parent_id`)
VALUES(16,18);

/*
* THAT'S ALL!!
*/
