--Chi phí nguyên liệu của từng món
--

SELECT 
    it.item_name AS Ten_Mon,
    it.item_cat AS Category,
    CASE 
            WHEN it.item_size = 'N/A' THEN 'Standard'
            ELSE it.item_size 
        END AS Kich_Thuoc,
    round(SUM(rs.quantity * (ig.ing_price / ig.ing_weight)),2) AS Phi_Nguyen_Lieu
FROM items it
INNER JOIN recipes rs ON it.sku = rs.recipe_id
INNER JOIN ingredients ig ON rs.ing_id = ig.ing_id
GROUP BY it.item_cat, it.item_name, it.item_size
ORDER BY it.item_cat

--Món có margin cao nhất / thấp nhất
--
WITH Phi_Nguyen_Lieu AS (
SELECT 
    it.item_name    AS Ten_Mon,
    it.item_cat     AS Category,
    CASE 
            WHEN it.item_size = 'N/A' THEN 'Standard'
            ELSE it.item_size 
        END AS Kich_Thuoc,
    round(SUM(rs.quantity * (ig.ing_price / ig.ing_weight)),2) AS Phi_Nguyen_Lieu,
    it.item_price AS Gia_Ban,
    it.item_price - round(SUM(rs.quantity * (ig.ing_price / ig.ing_weight)),2) as Loi_Nhuan
FROM items it
INNER JOIN recipes rs ON it.sku = rs.recipe_id
INNER JOIN ingredients ig ON rs.ing_id = ig.ing_id
GROUP BY it.item_cat, it.item_name, it.item_size, Gia_Ban
ORDER BY it.item_cat
)
SELECT 
    Category,
    Ten_Mon,
    Kich_Thuoc,
    Gia_Ban,
    Phi_Nguyen_Lieu,
    Loi_Nhuan,
    DENSE_RANK() OVER (PARTITION BY Category ORDER BY 
        (Gia_Ban - Phi_Nguyen_Lieu) DESC)  AS Rank_Cao_Nhat
FROM Phi_Nguyen_Lieu
ORDER BY Category, Rank_Cao_Nhat
