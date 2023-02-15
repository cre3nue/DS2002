# DROP database `northwind_dw3`;
CREATE DATABASE `Northwind_DW3` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE Northwind_DW3;

# DROP TABLE `dim_customers`;
CREATE TABLE `dim_customers` (
  `customer_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;


# DROP TABLE `dim_employees`;
CREATE TABLE `dim_employees` (
  `employee_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  `web_page` longtext,
  PRIMARY KEY (`employee_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;


# DROP TABLE `dim_products`;
CREATE TABLE `dim_products` (
  `product_key` int NOT NULL AUTO_INCREMENT,
  `product_code` varchar(25) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `standard_cost` decimal(19,4) DEFAULT '0.0000',
  `list_price` decimal(19,4) NOT NULL DEFAULT '0.0000',
  `reorder_level` int DEFAULT NULL,
  `target_level` int DEFAULT NULL,
  `quantity_per_unit` varchar(50) DEFAULT NULL,
  `discontinued` tinyint(1) NOT NULL DEFAULT '0',
  `minimum_reorder_quantity` int DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_key`),
  KEY `product_code` (`product_code`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4;


# DROP TABLE `dim_shippers`;
CREATE TABLE `dim_shippers` (
  `shipper_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipper_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;


# DROP TABLE `dim_suppliers`;
CREATE TABLE `dim_suppliers` (
  `supplier_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`supplier_key`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;


-- ----------------------------------------------------------------------
-- TODO: JOIN the orders, order_details, order_details_status and 
--       orders_status tables to create a new Fact Table in Northwind_DW.
-- To keep things simple, don't include purchase order or inventory info
-- ----------------------------------------------------------------------
# DROP TABLE `fact_orders`;
CREATE TABLE `fact_orders`(
  `order_key` int NOT NULL AUTO_INCREMENT,
  `employee_key` int DEFAULT NULL,
  `customer_key` int DEFAULT NULL,
  `product_key` int DEFAULT NULL,
  `shipper_key` int DEFAULT NULL,
  `ship_name` varchar(50) DEFAULT NULL,
  `ship_address` varchar(50) DEFAULT NULL,
  `ship_city` varchar(50) DEFAULT NULL,
  `ship_state_province` varchar(50) DEFAULT NULL,
  `ship_zip_postal_code` int DEFAULT NULL,
  `ship_country_region` varchar(50) DEFAULT NULL,
  `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `order_date` datetime DEFAULT NULL,
  `shipped_date` datetime DEFAULT NULL,
  `shipping_fee` decimal(19,4) DEFAULT '0.0000',
  `taxes` double DEFAULT '0',
  `payment_type` varchar(50) DEFAULT NULL,
  `paid_date` datetime DEFAULT NULL,
  `tax_rate` double DEFAULT '0',
  `order_status` varchar(50) DEFAULT '0',
  `order_details_status` varchar(50) NOT NULL,
  `unit_price` decimal(19,4) DEFAULT '0.0000',
  `discount` double NOT NULL DEFAULT '0',
  `date_allocated` datetime DEFAULT NULL,
  PRIMARY KEY (`order_key`),
 
  -- CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_key`) REFERENCES `northwind`.`customers` (`id`),
  -- CONSTRAINT `fk_orders_employees1` FOREIGN KEY (`employee_key`) REFERENCES `northwind`.`employees` (`id`),
  -- CONSTRAINT `fk_orders_orders_status1` FOREIGN KEY (`order_status`) REFERENCES `northwind`.`orders_status` (`id`),
  -- CONSTRAINT `fk_orders_orders_tax_status1` FOREIGN KEY (`tax_status_id`) REFERENCES `orders_tax_status` (`id`),
  -- CONSTRAINT `fk_orders_shippers1` FOREIGN KEY (`shipper_key`) REFERENCES `northwind`.`shippers` (`id`)
  CONSTRAINT `fk_order_details_orders1` FOREIGN KEY (`order_key`) REFERENCES `northwind`.`orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb3;

-- CREATE TABLE `orders` (
--   `order_key` int NOT NULL AUTO_INCREMENT,
--   `employee_id` int DEFAULT NULL,
--   `customer_id` int DEFAULT NULL,
--   `product_id` int DEFAULT NULL,
--   `order_date` datetime DEFAULT NULL,
--   `shipped_date` datetime DEFAULT NULL,
--   `shipping_fee` decimal(19,4) DEFAULT '0.0000',
--   `taxes` decimal(19,4) DEFAULT '0.0000',
--   `payment_type` varchar(50) DEFAULT NULL,
--   `paid_date` datetime DEFAULT NULL,
--   `notes` longtext,
--   `tax_rate` double DEFAULT '0',
--   `tax_status_id` tinyint DEFAULT NULL,
--   `order_status` varchar(50) DEFAULT '0',
--   `order_id` int NOT NULL,
--   `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
--   `unit_price` decimal(19,4) DEFAULT '0.0000',
--   `discount` double NOT NULL DEFAULT '0',
--   `order_details_status` int DEFAULT NULL,
--   `date_allocated` datetime DEFAULT NULL,
--   PRIMARY KEY (`order key`),
--   #`status_id` tinyint DEFAULT '0',
--  
--   CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
--   CONSTRAINT `fk_orders_employees1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
--   CONSTRAINT `fk_orders_orders_status1` FOREIGN KEY (`status_id`) REFERENCES `orders_status` (`id`),
--   CONSTRAINT `fk_orders_orders_tax_status1` FOREIGN KEY (`tax_status_id`) REFERENCES `orders_tax_status` (`id`),
--   CONSTRAINT `fk_orders_shippers1` FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb3;

-- CREATE TABLE `order_details` (
--   `id` int NOT NULL AUTO_INCREMENT,
--   `order_id` int NOT NULL,
--   `product_id` int DEFAULT NULL,
--   `quantity` decimal(18,4) NOT NULL DEFAULT '0.0000',
--   `unit_price` decimal(19,4) DEFAULT '0.0000',
--   `discount` double NOT NULL DEFAULT '0',
--   `order_details_status` int DEFAULT NULL,
--   `date_allocated` datetime DEFAULT NULL,
--   `purchase_order_id` int DEFAULT NULL,
--   `inventory_id` int DEFAULT NULL,
--   PRIMARY KEY (`id`),
--   
--   CONSTRAINT `fk_order_details_order_details_status1` FOREIGN KEY (`status_id`) REFERENCES `order_details_status` (`id`),
--   CONSTRAINT `fk_order_details_orders1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
--   CONSTRAINT `fk_order_details_products1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb3;

-- CREATE TABLE `order_details_status` (
--   `id` int NOT NULL,
--   `status_name` varchar(50) NOT NULL,
--   PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- CREATE TABLE `orders_status` (
--   `id` tinyint NOT NULL,
--   `status_name` varchar(50) NOT NULL,
--   PRIMARY KEY (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

# same as orders table code but change status_id to status_name and tinyint to int
# change id to order_key and accordingly primary key to order_key
# can get rid of som eother info after primary key line before constraints
# take out shipping info bc breaks 2nd and 3rd normal form by dep on shipping id

# in fact table:  numerical values and foreign keys too 
# to gen table:  right click table, send to SQL editor, create statement
# or copy to clipboard