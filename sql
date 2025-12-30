---изменение поля 

SELECT id, email, user_name
FROM app_schema."user"
WHERE id = ('321762');


UPDATE app_schema."user"
SET user_name = 'Мария'
WHERE id =('321762');



---сколько вакансий не архивных по уникальным датам 
   SELECT 
 DATE(published_at) AS publish_date,
    COUNT(*) AS vacancies_count
FROM app_schema.vw_vacancy
WHERE archived = FALSE
GROUP BY DATE(published_at)
ORDER BY publish_date;

SELECT COUNT(*) AS total_vacancies
FROM app_schema.vw_vacancy
WHERE archived = FALSE;

SELECT COUNT(*) AS total_vacancies
FROM app_schema.vw_vacancy;


SELECT 
    DATE(published_at) AS publish_date,
    COUNT(*) AS vacancies_count
FROM app_schema.vw_vacancy
WHERE archived = FALSE
GROUP BY DATE(published_at)
ORDER BY publish_date;



---Вакансии ХХ по по проф ролям 

SELECT vv.*
FROM app_schema.vw_vacancy AS vv
WHERE 9 = ANY(vv.professional_roles_profarea_id);



SELECT COUNT(*) AS vacancy_count  ---только колличесво
FROM app_schema.vw_vacancy AS vv
WHERE 15 = ANY(vv.professional_roles_profarea_id);



SELECT COUNT(*) AS vacancy_count  ---только колличество
FROM app_schema.vw_vacancy AS vv
WHERE 15 = ANY(vv.professional_roles_profarea_id)
  AND '183' = ANY(vv.professional_roles_id);

SELECT vv.*
FROM app_schema.vw_vacancy AS vv
WHERE 15 = ANY(vv.professional_roles_profarea_id)
  AND '183' = ANY(vv.professional_roles_id);


UPDATE app_schema.company
SET phone_number = '89958803919'
WHERE id = '282308';

---убрать вакансии хх в архив
UPDATE app_schema.vw_vacancy
SET archived = TRUE
WHERE id IN (126398284, 123200157, 127008299, 125977378, 126224432, 126114241, 127562573, 126831473, 127782665, 124296697, 127779599, 126969853, 127213597, 1264
60112, 127607972);


-- Найти студентов по email или id

select *
from app_schema."user" u 
where u.email in ('tatianatest+444@bk.ri');
--where u.id in ();

-- Найти UTM-метки студента по его email

select *
from app_schema."user" u
join app_schema.user_utm uu on u.id = uu.user_id 
where u.email  in ();

-- Удалить студетов по id

delete 
from app_schema."user" 
where id in ('319456');

-- Найти отклики по email студента (или по id отклика)

select
	u.id,
	u.email ,
	sr.*
from
	app_schema.student_response sr
left join app_schema."user" u on
	u.bubble_id = sr.user_internal_id
where
	u.email in ('tatianatest+444@bk.ri')
	--where sr.id in ()
order by
	created_at desc;

-- Посмотрень историю смены статусов отклика по id

select *
from app_schema.response_status rs 
where id  in ();

-- Удалить отклики по id

delete 
from app_schema.student_response 
where id in ();

-- Проверить, что отклик студента попал в таблицу на проверку (Антифрод) - поиск по email студента

select *
from app_schema.student_response_to_check srtc 
where srtc.email in ('2845382','2845383','2828921','2279491','2148847','2148603','2127532','2045285');

-- Изменить информацию о студенте

update app_schema."user"
set user_name =null ,
user_surname = null ,
phone_number =null,
user_area = null,
email = ''
where email = '';
