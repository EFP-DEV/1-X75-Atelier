/* =========================================================
   TABLE: OPERATOR
   Origin: Entity in MCD (administrators / operators)
========================================================= */
CREATE TABLE operator (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    last_login DATETIME NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =========================================================
   TABLE: CATEGORY
   MCD: ITEM → CATEGORY is (1,1), so FK will be NOT NULL
========================================================= */
CREATE TABLE category (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(255) NOT NULL UNIQUE,
    label VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =========================================================
   TABLE: THEME
   MCD: ITEM → THEME is (1,1), FK NOT NULL
========================================================= */
CREATE TABLE theme (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(255) NOT NULL UNIQUE,
    label VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =========================================================
   TABLE: TAG
   Used only for 0,N free tagging
========================================================= */
CREATE TABLE tag (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(255) NOT NULL UNIQUE,
    label VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =========================================================
   TABLE: ITEM
   MCD:
     - CATEGORY 1,1 → category_id NOT NULL
     - THEME 1,1 → theme_id NOT NULL
========================================================= */
CREATE TABLE item (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    slug VARCHAR(255) NOT NULL UNIQUE,
    label VARCHAR(255) NOT NULL,
    short_description TEXT NULL,
    content LONGTEXT NULL,
    main_image VARCHAR(255),
    status VARCHAR(20) DEFAULT 'draft', -- draft, published, archived

    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,

    category_id INT UNSIGNED NOT NULL,   -- (1,1)
    theme_id INT UNSIGNED NOT NULL       -- (1,1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =========================================================
   TABLE: COLLECTION
   MCD:
     OPERATOR 1,N → COLLECTION (creator_id NOT NULL)
========================================================= */
CREATE TABLE collection (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    creator_id INT UNSIGNED NOT NULL,
    name VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =========================================================
   TABLE: COLLECTION_ITEM  (junction)
   MCD: COLLECTION 0,N — 0,N ITEM
========================================================= */
CREATE TABLE collection_item (
    collection_id INT UNSIGNED NOT NULL,
    item_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (collection_id, item_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =========================================================
   TABLE: MESSAGE
   MCD:
     OPERATOR 0,1 → MESSAGE
     Means: assigned_to must be NULLABLE
========================================================= */
CREATE TABLE message (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    subject VARCHAR(255),
    content TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'new', -- new, read, archived
    assigned_to INT UNSIGNED NULL      -- (0,1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* =========================================================
   TABLE: TAGUER (item_tag)
   MCD: ITEM 0,N — 0,N TAG
========================================================= */
CREATE TABLE taguer (
    item_id INT UNSIGNED NOT NULL,
    tag_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (item_id, tag_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
