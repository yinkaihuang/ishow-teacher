create table t_user if not exists(
id bigint primary key auto_increment,
login_account varchar(100),
password varchar(100),
phone_number varchar(50) default "",
name varchar(50),
gender varchar(10),
birth_day datetime,
open_id varchar(200),
create_date datetime default now(),
update_date datetime default now(),
enable tinyint default 1,
remark varchar(255)
)engine=innodb;

create table if not exists t_event_log (
id bigint primary key auto_increment,
operator varchar(100),
event varchar(100),
create_date datetime default now(),
update_date datetime default now(),
enable tinyint default 1,
remark varchar(255)
)engine=innodb;

create table if not exists t_file(
 id bigint primary key auto_increment,
 name varchar(100) default "" comment "文件名",
 md5 varchar(100) default "" comment "md5值",
 path varchar(255) default "" comment "文件路径",
 position bigint default 0 comment "偏移量",
 length bigint default 0 comment "文件大小",
 create_date datetime default now(),
 update_date datetime default now(),
 enable tinyint default 1,
 remark varchar(255)
)engine=innodb;