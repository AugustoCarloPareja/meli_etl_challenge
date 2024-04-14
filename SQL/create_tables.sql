/*
First of all, thank you for reviewing this challenge.

A side note is that the ids could have been a GUID (in that case, they should have been treated as varchar).
But for quick development of this challenge, they have been treated as int type.

Also, a fictional database instance named "meli_challenge" has been created for the purpose of this challenge.

Happy reviewing!
*/

-- Customer table
CREATE TABLE [meli_challenge].[dbo].Customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender INT NOT NULL,
    address VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    email VARCHAR(255) NOT NULL,
	country INT NOT NULL,
    contact_phone INT,
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_updated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status INT NOT NULL
);

-- Category table
CREATE TABLE [meli_challenge].[dbo].Category (
    category_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    path VARCHAR(255) NOT NULL,
    hierarchy_level INT NOT NULL,
	created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_updated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status INT NOT NULL
);

-- Item table
CREATE TABLE [meli_challenge].[dbo].Item (
    item_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    available_quantity INT NOT NULL,
    price INT NOT NULL,
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_updated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	status INT NOT NULL,
    category_id INT NOT NULL,
    CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Order table
CREATE TABLE [meli_challenge].[dbo].[Order] (
    order_id INT PRIMARY KEY,
	buyer_id INT NOT NULL,
	seller_id INT NOT NULL,
    item_id INT NOT NULL,
    created_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_updated_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	status INT NOT NULL,
    quantity INT NOT NULL,
    total_amount INT NOT NULL,
    tracking_number VARCHAR(50) NOT NULL,
    shipping_adress VARCHAR(50) NOT NULL,
    CONSTRAINT fk_buyer_id FOREIGN KEY (buyer_id) REFERENCES Customer(customer_id),
	CONSTRAINT fk_seller_id FOREIGN KEY (seller_id) REFERENCES Customer(customer_id),
    CONSTRAINT fk_item_id FOREIGN KEY (item_id) REFERENCES Item(item_id)
);