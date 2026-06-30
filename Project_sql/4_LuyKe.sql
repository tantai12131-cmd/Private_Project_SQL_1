--Running total doanh thu theo thứ tự order (tích lũy)
--
WITH Tong_Doanh_Thu_Tung_Mon AS (
    SELECT 
        it.item_cat AS Category,
        it.item_id,
        it.item_name AS Ten_Mon, 
        CASE 
            WHEN it.item_size = 'N/A' THEN 'Standard'
            ELSE it.item_size 
        END AS Kich_Thuoc,
        SUM(it.item_price * od.quantity) as Doanh_Thu
    FROM 
        orders od
    INNER JOIN items it ON od.item_id = it.item_id
    GROUP BY  
        it.item_cat, it.item_id, it.item_name, it.item_size
)
SELECT 
    Category,
    SUM(Doanh_Thu) OVER(
        PARTITION BY Category
        ORDER BY Doanh_Thu DESC ) AS Luy_Ke_Doanh_Thu_Tung_Mon
FROM 
    Tong_Doanh_Thu_Tung_Mon
ORDER BY 
    Category, Luy_Ke_Doanh_Thu_Tung_Mon;



