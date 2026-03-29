-- Basic Funnel Analysis
with
    tbl1
    as
    
    (
        SELECT
            COUNT(DISTINCT CASE WHEN event_type = 'visit' THEN user_id END) AS Number_of_Visit,
            COUNT(DISTINCT CASE WHEN event_type = 'view_service' THEN user_id END) AS Number_of_View,
            COUNT(DISTINCT CASE WHEN event_type = 'book' THEN user_id END) AS Number_of_Books
        FROM [interview].[dbo].[events]
    )

SELECt *,
    CONCAT('%', (CAST(Number_of_View as float) / Number_of_Visit) * 100) as convertion_rate_view,
    CONCAT('%', (CAST(Number_of_Books as float) / Number_of_View) * 100) as convertion_rate_book
from tbl1








-- Advanced Funnel Analysis
with
    tbl
    as
    (
        select *,
            lead(event_type) over(PARTITION BY user_id order by event_date asc) as next_event,
            lead(event_type, 2) over(PARTITION BY user_id order by event_date asc) as second_next_event
        from [dbo].[events]
    ),
    tbl_2
    as
    (
        select *,
            (case 
when event_type = 'visit' and next_event = 'view_service' and second_next_event = 'book' then 1 else 0
end) as flag
        from tbl
    )

select distinct user_id
from tbl_2
where flag = 1








-- Conversion Rate for Marketing Channels
with
    tbl1
    as
    (
        select e.user_id, e.event_type, mc.channel,
            (case when e.event_type = 'visit' then 1 else 0 end) as visit_flag,
            (case when e.event_type = 'book' then 1 else 0 end) as book_flag
        from [dbo].[events] e
            left join [dbo].[marketing_channels] mc on e.user_id = mc.user_id
    ),
    tbl2
    as
    (
        select channel, sum(visit_flag) as visiting, sum(book_flag) as booking
        from tbl1
        group by channel
    )

select *,
    (CAST(booking as float) / visiting) * 100 as converstion_rate
from tbl2







-- Customer Segmentation Analysis
/* High-value user -> User has at least one completed appointment
Engaged user -> user has visit but not having book
Inactive users -> user does not have any appointment */
with
    tbl
    as
    (
        select u.user_id,
            max(case when e.event_type = 'visit' then 1 end) as flag_visit,
            max(case when e.event_type = 'book' then 1 end) as flag_book,
            max(case when a.status = 'completed' then 1 end) as flag_appointment
        from users u
            left join appointments a on a.user_id = u.user_id
            left join events e on e.user_id = u.user_id
        group by u.user_id
    )

select *,
    case 
        when flag_appointment = 1 then 'High-value'
        when flag_visit = 1 and flag_book is null then 'Engaged'
        else 'Inactive'
    end as customer_flag
from tbl

