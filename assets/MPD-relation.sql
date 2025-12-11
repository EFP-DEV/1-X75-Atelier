/* =========================================================
   ITEM → CATEGORY  (1,1)
   SQL translation:
     - FK NOT NULL
     - RESTRICT deletion
========================================================= */
ALTER TABLE item
ADD CONSTRAINT fk_item_category
FOREIGN KEY (category_id) REFERENCES category(id)
ON DELETE RESTRICT;

/* =========================================================
   ITEM → THEME  (1,1)
========================================================= */
ALTER TABLE item
ADD CONSTRAINT fk_item_theme
FOREIGN KEY (theme_id) REFERENCES theme(id)
ON DELETE RESTRICT;

/* =========================================================
   COLLECTION → OPERATOR  (1,N)
========================================================= */
ALTER TABLE collection
ADD CONSTRAINT fk_collection_creator
FOREIGN KEY (creator_id) REFERENCES operator(id)
ON DELETE CASCADE;

/* =========================================================
   COLLECTION_ITEM → COLLECTION
========================================================= */
ALTER TABLE collection_item
ADD CONSTRAINT fk_collection_item_collection
FOREIGN KEY (collection_id) REFERENCES collection(id)
ON DELETE CASCADE;

/* =========================================================
   COLLECTION_ITEM → ITEM
========================================================= */
ALTER TABLE collection_item
ADD CONSTRAINT fk_collection_item_item
FOREIGN KEY (item_id) REFERENCES item(id)
ON DELETE CASCADE;

/* =========================================================
   MESSAGE → OPERATOR  (0,1)
   SQL translation:
     - FK is NULLABLE
     - ON DELETE SET NULL
========================================================= */
ALTER TABLE message
ADD CONSTRAINT fk_message_operator
FOREIGN KEY (assigned_to) REFERENCES operator(id)
ON DELETE SET NULL;

/* =========================================================
   TAGUER → ITEM
========================================================= */
ALTER TABLE taguer
ADD CONSTRAINT fk_taguer_item
FOREIGN KEY (item_id) REFERENCES item(id)
ON DELETE CASCADE;

/* =========================================================
   TAGUER → TAG
========================================================= */
ALTER TABLE taguer
ADD CONSTRAINT fk_taguer_tag
FOREIGN KEY (tag_id) REFERENCES tag(id)
ON DELETE CASCADE;
