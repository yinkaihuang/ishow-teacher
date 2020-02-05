create database  if not exists educate DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

create table  if not exists educate.t_user(
id bigint primary key auto_increment,
login_account varchar(100) default "" comment "登录账号",
password varchar(100) default "" comment "密码",
phone_number varchar(50) default "" comment "手机号",
name varchar(50) default "" comment "用户名称",
gender varchar(10) default "" comment "性别",
id_card varchar(255) default "" comment "身份证号码",
address varchar(255) default "" comment "居住地址",
role int default 0 comment "角色",
birth_day datetime default now() comment "生日",
open_id varchar(255) default "" comment "微信ID",
create_date datetime default now() comment "创建时间",
update_date datetime default now() comment "更新时间",
enable tinyint default 1 comment "是否启动",
remark varchar(255) comment "备注"
)engine=innodb;

create table  if not exists educate.t_event_log(
id bigint primary key auto_increment,
operator varchar(100) default "" comment "操作人",
event varchar(100) default "" comment "事件",
create_date datetime default now() comment "创建时间",
update_date datetime default now() comment "更新时间",
enable tinyint default 1 comment "是否启动",
remark varchar(255) default "" comment "备注"
)engine=innodb;

create table  if not exists educate.t_file(
 id bigint primary key auto_increment,
 name varchar(100) default "" comment "文件名",
 md5 varchar(100) default "" comment "md5值",
 path varchar(255) default "" comment "文件路径",
 position bigint default 0 comment "偏移量",
 length bigint default 0 comment "文件大小",
 create_date datetime default now() comment "创建时间",
 update_date datetime default now() comment "修改时间",
 enable tinyint default 1 comment "是否启动",
 remark varchar(255) comment "备注"
)engine=innodb;

create table  if not exists educate.t_course(
 id bigint primary key auto_increment,
 name varchar(255) default "" comment "课程名称",
 author varchar(255) default "" comment "讲师",
 pusher varchar(255) default "" comment "视频发布者",
 image_id varchar(255) default "" comment "视频封面id",
 video_id varchar(255) default "" comment "视频录像id",
 type int comment "课程类型",
 level int comment "课程级别",
 tag varchar(255) default "" comment "课程标签",
 description text  comment "课程描述",
 free tinyint default 1 comment "是否免费",
 create_date datetime default now() comment "创建时间",
 update_date datetime default now() comment "修改时间",
 enable tinyint default 1 comment "是否启动",
 remark varchar(255) comment "备注"
)engine=innodb;