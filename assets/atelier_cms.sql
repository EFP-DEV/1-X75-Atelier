--
-- 1. Create core tables (no FKs yet), with PK `id` AUTO_INCREMENT
--

CREATE TABLE `operator` (
  `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `password`      VARCHAR(255) NOT NULL COMMENT 'Hashed using password_hash()',
  `email`         VARCHAR(255) NOT NULL UNIQUE,
  `last_login`    TIMESTAMP      NULL,
  `is_active`     TINYINT        DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tag` (
  `id`             INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `operator_id`    INT UNSIGNED NOT NULL,
  `parent_tag_id`  INT UNSIGNED      NULL,
  `name`           VARCHAR(50)  NOT NULL UNIQUE,
  `slug`           VARCHAR(50)  NOT NULL UNIQUE,
  `created_at`     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  `updated_at`     TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
                                 ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `collection` (
  `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `operator_id`   INT UNSIGNED NOT NULL,
  `name`          VARCHAR(50)  NOT NULL COMMENT 'e.g. favorite, basket, wishlist',
  `description`   VARCHAR(255)      NULL,
  `is_public`     TINYINT           DEFAULT 1,
  `created_at`    TIMESTAMP         DEFAULT CURRENT_TIMESTAMP,
  `updated_at`    TIMESTAMP         DEFAULT CURRENT_TIMESTAMP
                                 ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `message` (
  `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `operator_id`   INT UNSIGNED      NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `item` (
  `id`              INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `operator_id`     INT UNSIGNED NOT NULL COMMENT 'creator',
  `category_tag_id` INT UNSIGNED NOT NULL,
  `theme_tag_id`    INT UNSIGNED NOT NULL,
  `title`           VARCHAR(255) NOT NULL,
  `slug`            VARCHAR(255) NOT NULL UNIQUE,
  `description`     TEXT,
  `content`         LONGTEXT,
  `avatar`          VARCHAR(255)      NULL COMMENT 'Path to the main image',
  `created_at`      TIMESTAMP         DEFAULT CURRENT_TIMESTAMP,
  `updated_at`      TIMESTAMP         DEFAULT CURRENT_TIMESTAMP
                                   ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `search` (
  `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `query`         VARCHAR(500) NOT NULL COMMENT 'search term',
  `result_count`  INT UNSIGNED      DEFAULT NULL COMMENT 'number of results returned',
  `created_at`    TIMESTAMP         NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'when the search was executed',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `item_tag` (
  `item_id`       INT UNSIGNED NOT NULL,
  `tag_id`        INT UNSIGNED NOT NULL,
  PRIMARY KEY (`item_id`,`tag_id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `collection_item` (
  `collection_id` INT UNSIGNED NOT NULL,
  `item_id`       INT UNSIGNED NOT NULL,
  PRIMARY KEY (`collection_id`,`item_id`)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;


--
-- 2. Add FOREIGN KEY constraints via ALTER TABLE
--    (All ON DELETE actions RESTRICT, ON UPDATE CASCADE)
--

ALTER TABLE `tag`
  ADD CONSTRAINT `fk_tag_operator`
    FOREIGN KEY (`operator_id`)
    REFERENCES `operator` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tag_parent`
    FOREIGN KEY (`parent_tag_id`)
    REFERENCES `tag` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE `collection`
  ADD CONSTRAINT `fk_collection_operator`
    FOREIGN KEY (`operator_id`)
    REFERENCES `operator` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE `message`
  ADD CONSTRAINT `fk_message_operator`
    FOREIGN KEY (`operator_id`)
    REFERENCES `operator` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE `item`
  ADD CONSTRAINT `fk_item_operator`
    FOREIGN KEY (`operator_id`)
    REFERENCES `operator` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_item_category_tag`
    FOREIGN KEY (`category_tag_id`)
    REFERENCES `tag` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_item_theme_tag`
    FOREIGN KEY (`theme_tag_id`)
    REFERENCES `tag` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE `item_tag`
  ADD CONSTRAINT `fk_item_tag_item`
    FOREIGN KEY (`item_id`)
    REFERENCES `item` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_item_tag_tag`
    FOREIGN KEY (`tag_id`)
    REFERENCES `tag` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE `collection_item`
  ADD CONSTRAINT `fk_collection_item_collection`
    FOREIGN KEY (`collection_id`)
    REFERENCES `collection` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_collection_item_item`
    FOREIGN KEY (`item_id`)
    REFERENCES `item` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;
