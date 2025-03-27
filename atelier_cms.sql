-- Operator table (administrators)
CREATE TABLE operator (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL COMMENT 'Hashed using password_hash()',
    email VARCHAR(100) NOT NULL UNIQUE,
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Visitor table (user preferences)
CREATE TABLE visitor (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    visitor_token VARCHAR(255) NOT NULL UNIQUE COMMENT 'Identifier for visitor',
    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,
    dark_mode BOOLEAN DEFAULT FALSE,
    font_size ENUM('small', 'medium', 'large') DEFAULT 'medium',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_activity TIMESTAMP NULL
);

-- Tag table (generic categorization system)
CREATE TABLE tag (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    operator_id INT UNSIGNED NOT NULL COMMENT 'creator',
    name VARCHAR(50) NOT NULL UNIQUE,
    slug VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (operator_id) REFERENCES operator(id) ON DELETE RESTRICT
);

-- Item table (main content - products/articles/resources)
CREATE TABLE item (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    operator_id INT UNSIGNED NOT NULL COMMENT 'creator',
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    content LONGTEXT,
    image VARCHAR(255) NULL COMMENT 'Path to the main image',
    price DECIMAL(10,2) NULL COMMENT 'Optional, depends on site type',
    stock INT UNSIGNED NULL COMMENT 'Optional, for product inventory',
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (operator_id) REFERENCES operator(id) ON DELETE RESTRICT
);

-- Item-Tag relationship (many-to-many)
CREATE TABLE item_tag (
    item_id INT UNSIGNED,
    tag_id INT UNSIGNED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (item_id, tag_id),
    FOREIGN KEY (item_id) REFERENCES item(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tag(id) ON DELETE CASCADE
);

-- Collection table (to define different types of collections: favorites, wishlists, etc.)
CREATE TABLE collection (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    visitor_id INT UNSIGNED NOT NULL,
    name VARCHAR(50) NOT NULL COMMENT 'e.g. favorite, basket, wishlist',
    description VARCHAR(255) NULL,
    is_public BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (visitor_id) REFERENCES visitor(id) ON DELETE CASCADE
);

-- Collection_item table (items in collections)
CREATE TABLE collection_item (
    collection_id INT UNSIGNED NOT NULL,
    item_id INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (collection_id, item_id),
    FOREIGN KEY (collection_id) REFERENCES collection(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES item(id) ON DELETE CASCADE
);

-- Search log table (for analytics)
CREATE TABLE search (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    visitor_id INT UNSIGNED NULL,
    query VARCHAR(255) NOT NULL,
    results_count INT UNSIGNED DEFAULT 0,
    session_id VARCHAR(255) COMMENT 'To track user sessions',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (visitor_id) REFERENCES visitor(id) ON DELETE SET NULL
);

-- Contact message table
CREATE TABLE message (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    is_spam BOOLEAN DEFAULT FALSE,
    operator_id INT UNSIGNED NULL COMMENT 'Operator who read the message',
    ip_address VARCHAR(45) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP NULL,
    FOREIGN KEY (operator_id) REFERENCES operator(id) ON DELETE SET NULL
);
