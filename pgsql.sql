create table BS_Type(Type_id integer, Type_name varchar(50));

create table bs_lookup(keyword_id integer, type integer, bs_keword varchar(50), _order integer);

create table bs_metric(metric_id integer, metric_name varchar(300), metric_value  integer);

create table bs_map(keyword_id integer, metric_id integer);

create table bs_scoring(user_id integer, date_time date, lp_id integer, course_id integer, bs_keyword_id integer, metric_id integer, time_on_screen integer);

insert into bs_type values(1, 'Classroom'); insert into bs_type(2,'School');

alter table bs_scoring add column user_id_accessor integer;
