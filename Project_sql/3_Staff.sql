
--Số ca làm việc của từng nhân viên
--
SELECT 
   CONCAT(first_name,' ', last_name) AS Ten_Nhan_Vien,
   st.staff_id,
   COUNT(rt.shift_id) AS So_Ca_Lam_Viec
FROM rota rt
INNER JOIN staff st ON rt.staff_id = st.staff_id 
GROUP BY 
    st.first_name, st.last_name, st.staff_id


