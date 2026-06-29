
--Create FK: items.sku = recipes.recipe_id
--
ALTER TABLE items
ADD CONSTRAINT uq_items_sku UNIQUE (sku);

ALTER TABLE recipes
ADD CONSTRAINT fk_recipes_items
FOREIGN KEY (recipe_id)
REFERENCES items(sku);

