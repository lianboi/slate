create table BS_Type(Type_id integer, Type_name varchar(50));

create table bs_lookup(keyword_id integer, type integer, bs_keword varchar(50), _order integer);

create table bs_metric(metric_id integer, metric_name varchar(300), metric_value  integer);

create table bs_map(keyword_id integer, metric_id integer);

create table bs_scoring_lookup(bs_sl_id integer, user_id integer, date_time date, lp_id integer, course_id integer, user_id_accessor integer);

create table bs_score_map(bs_sl_id integer, bs_keyword_id integer, metric_id integer, time_on_screen integer);

insert into bs_type values(1, 'Classroom'); insert into bs_type(2,'School');

alter table bs_scoring add column user_id_accessor integer;

create table user_table(user_id integer, username varchar(30), role_id integer, api_key varchar(100), api_token varchar(100), first_name varchar(30), last_name varchar(30), email varchar(50), phone integer, hash varchar(100), salt varchar(100), time_to_expire varchar(30), deleted integer, blocked integer);
