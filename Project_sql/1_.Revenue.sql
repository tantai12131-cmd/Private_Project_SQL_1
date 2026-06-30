--Tổng doanh thu theo từng món 
--Không tính size
SELECT 
    it.item_id,
    it.item_name as Ten_Mon, 
    SUM(it.item_price* od.quantity) as Doanh_Thu
FROM 
    orders od
INNER JOIN items it ON od.item_id = it.item_id
GROUP BY  
    it.item_id, it.item_name
ORDER BY 
    Doanh_Thu DESC


--Xếp hạng món theo doanh thu trong từng category
--Đổi N/A = Standard
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
    Ten_Mon,
    Kich_Thuoc,
    DENSE_RANK() OVER(
        PARTITION BY Category
        ORDER BY Doanh_Thu DESC ) AS Xep_Hang_Cat
FROM 
    Tong_Doanh_Thu_Tung_Mon
ORDER BY 
    Category, Xep_Hang_Cat;
