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

----Аналитика вакансий на сайте

SELECT
    CASE
        WHEN s.schedule_id = 'flexible' THEN 'Гибкий график'
        WHEN s.schedule_id = 'fullDay' THEN 'Полный день'
        WHEN s.schedule_id = 'shift' THEN 'Сменный график'
        WHEN s.schedule_id = 'remote' THEN 'Удалённо'
        ELSE 'Не указано'
    END AS "Формат работы",

    COUNT(DISTINCT v.id) AS "Число вакансий"

FROM app_schema.vw_vacancy v
JOIN app_schema.vw_vacancy_schedule s
    ON v.id = s.vw_vacancy_id

WHERE v.archived = false

GROUP BY
    CASE
        WHEN s.schedule_id = 'flexible' THEN 'Гибкий график'
        WHEN s.schedule_id = 'fullDay' THEN 'Полный день'
        WHEN s.schedule_id = 'shift' THEN 'Сменный график'
        WHEN s.schedule_id = 'remote' THEN 'Удалённо'
        ELSE 'Не указано'
    END

ORDER BY
    COUNT(DISTINCT v.id) DESC;





SELECT
    d.profarea_name AS "Профобласть",
    d.role_name AS "Роль",

    COUNT(DISTINCT v.id) AS "Число вакансий",

    COUNT(DISTINCT CASE 
        WHEN v."experience.id" = 'noExperience'
        THEN v.id 
    END) AS "Без опыта",

    COUNT(DISTINCT CASE 
        WHEN v."experience.id" <> 'noExperience'
        THEN v.id 
    END) AS "Опыт от года"

FROM app_schema.vw_vacancy v
JOIN app_schema.dict_profarea_to_role_mapping d
    ON CAST(d.role_id AS text) = ANY(v.professional_roles_id)

WHERE v.archived = false

GROUP BY
    d.profarea_name,
    d.role_name

ORDER BY
    COUNT(DISTINCT v.id) DESC;



SELECT
    COUNT(DISTINCT v.id) AS "Стажировки"
FROM app_schema.vw_vacancy v
WHERE v.internship = true
  AND v.archived = false;



SELECT
    CASE
        WHEN v."experience.id" = 'noExperience' THEN 'Нет опыта'
        WHEN v."experience.id" = 'between1And3' THEN 'От 1 года до 3 лет'
        WHEN v."experience.id" = 'between3And6' THEN 'От 3 до 6 лет'
        WHEN v."experience.id" = 'moreThan6' THEN 'Более 6 лет'
        ELSE 'Не указано'
    END AS "Опыт",

    COUNT(DISTINCT v.id) AS "Число вакансий"

FROM app_schema.vw_vacancy v
WHERE v.archived = false

GROUP BY 1
ORDER BY 2 DESC;
