CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL, 
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NULL,
    password VARCHAR(255) NOT NULL,
    cc_account VARCHAR(16) NOT NULL,
    amount bigint NOT NULL,
    bank_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT FK_BankAmount FOREIGN KEY (amount, cc_account)
    REFERENCES bank(amount, cc_account)
);

CREATE TABLE IF NOT EXISTS bank (
    id INT NOT NULL AUTO_INCREMENT, 
    bank_user_id VARCHAR(255) NOT NULL,
    bank_name VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    short_name VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    birth_date TIMESTAMP NOT NULL,
    birth_place VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NULL,
    password VARCHAR(255) NOT NULL,
    account_id VARCHAR(255) NOT NULL,
    cc_account VARCHAR(16) NOT NULL,
    amount bigint NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS orders (
    id INT NOT NULL AUTO_INCREMENT, 
    full_name VARCHAR(255) NOT NULL,
    food_name VARCHAR(255) NOT NULL,
    food_category VARCHAR(255) UNIQUE NULL,
    price VARCHAR(255) NOT NULL,
    total_price INT NOT NULL,
    total_item INT NOT NULL,
    qty INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT FK_foodsOrder FOREIGN KEY (qty, price, food_name, food_category)
    REFERENCES foods(qty, price, food_name, food_category),
    CONSTRAINT FK_userOrder FOREIGN KEY (full_name)
    REFERENCES users(full_name),
);

CREATE TABLE IF NOT EXISTS foods (
    id INT NOT NULL AUTO_INCREMENT, 
    food_name VARCHAR(255) NOT NULL,
    food_category VARCHAR(255) UNIQUE NULL,
    price VARCHAR(255) NOT NULL,
    qty INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS transactions (
    id INT NOT NULL AUTO_INCREMENT,
    bank_id VARCHAR NOT NULL,
    amount BIGINT NOT NULL,
    amount_payed INT NOT NULL,
    total_per_item VARCHAR(255) NOT NULL,
    total_price VARCHAR(255) NOT NULL,
    qty INT NOT NULL,
    cc_account VARCHAR(16) NOT NULL,
    bank_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id),
    CONSTRAINT FK_userBank FOREIGN KEY (bank_id, amount, cc_account)
    REFERENCES users(bank_user_id, amount, cc_account),
    CONSTRAINT FK_userTransaction FOREIGN KEY (total_item, total_per_item, qty)
    REFERENCES users(total_item, total_per_item, qty),
);