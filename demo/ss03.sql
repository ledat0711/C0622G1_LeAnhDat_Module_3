DROP DATABASE IF EXISTS c0622g1;
CREATE DATABASE c0622g1;
use c0622g1;
create table class(
id int primary key auto_increment,
name varchar(20)
);
create table room(
id int primary key auto_increment,
name varchar(20),
class_id int,
foreign key(class_id) references class(id)
);
create table jame(
`account` varchar(50) primary key,
`password` varchar(50)
);
create table student(
id int primary key auto_increment,
name varchar(50),
birthday date,
gender boolean,
email varchar(50),
`point` float,
class_id int,
`account` varchar(50) unique,
foreign key (class_id) references class(id),
foreign key (`account`) references jame(`account`)
);

create table instructor(
id int primary key auto_increment,
name varchar(50),
birthday date,
salary double
);

create table instructor_class(
 class_id int,
 instructor_id int,
 start_time date,
 end_time date,
 primary key (class_id, instructor_id),
 foreign key(class_id) references class(id),
 foreign key(instructor_id) references instructor(id)
);

insert into class (name) values ('c1121g1'), ('c1221g1'),('a0821i1'),('a0921i1');
insert into room(name,class_id) values ('Ken',1), ('Jame',1),('Ada',2),('Andy',2);

insert into jame(`account`,`password`)
 values('cunn','12345'),('chunglh','12345'),('hoanhh','12345'),('dungd','12345'),('huynhtd','12345'),
 ('hainm','12345'),('namtv','12345'),('hieuvm','12345'),('kynx','12345'),('vulm','12345');

insert into jame(`account`,`password`)
 values('anv','12345'),('bnv','12345');

 
insert into instructor(`name`,birthday, salary)
 values('tran van chanh','1985-02-03',100),('tran minh chien','1985-02-03',200),('vu thanh tien','1985-02-03',300);
insert into instructor(`name`,birthday, salary)
 values('tran van nam','1989-12-12',100);

 
 insert into student(`name`,birthday, gender,`point`, class_id,`account`) 
 values ('nguyen ngoc cu','1981-12-12',1,8,1,'cunn'),('le hai chung','1981-12-12',1,5,1,'chunglh'),
 ('hoang huu hoan','1990-12-12',1,6,2,'hoanhh'),('dau dung','1987-12-12',1,8,1,'dungd'),
 ('ta dinh huynh','1981-12-12',1,7,2,'huynhtd'),('nguyen minh hai','1987-12-12',1,9,1,'hainm'),
 ('tran van nam','1989-12-12',1,4,2,'namtv'),('vo minh hieu','1981-12-12',1,3,1,'hieuvm'),
 ('le xuan ky','1981-12-12',1,7,2,'kynx'),('le minh vu','1981-12-12',1,7,1,'vulm');

 insert into student(`name`,birthday, gender,`point`, class_id,`account`) 
 values ('nguyen van a','1981-12-12',1,8,null,'anv'),('tran van b','1981-12-12',1,5,null,'bnv');

 insert into instructor_class(class_id,instructor_id) values (1,1),(1,2),(2,1),(2,2),(3,1),(3,2);

select * from room;
select* from class;
select* from student;
select* from jame;
select* from instructor;
select * from instructor_class;

select c.name,group_concat(r.name separator "&") as room from class c join room r on c.id=r.class_id group by c.name;
select id,name, ifnull(email,"khong c?? email") from student;

-- ss3 thao t??c v???i csdl

-- 1. L???y ra th??ng tin c??c h???c vi??n, v?? cho bi???t c??c h???c vi??n ??ang theo h???c l???p n??o.
select s.id, s.name, s.point, c.name as class_name from student s
join class c on s.class_id=c.id;

-- 2. L???y ra th??ng tin c??c h???c vi??n, v?? cho bi???t c??c h???c vi??n ??ang theo h???c l???p n??o 
-- v?? c??? c??c b???n ???? ????ng k?? nh??ng ch??a c?? l???p h???c.
select s.id, s.name, s.point, ifnull(c.name,'ch??a c?? l???p') as class_name from student s
left join class c on s.class_id=c.id;

-- 3. L???y th??ng tin c???a c??c h???c vi??n t??n 'nguyen minh hai'.
select * 
from student where name ='nguyen minh hai';
-- 4. L???y ra h???c vi??n c?? h??? l?? ???nguyen???
select * 
from student where name like 'nguyen%';

-- 5. L???y th??ng tin c???a c??c h???c vi??n t??n 'hai' ho???c 'huynh???.
select * 
from student where name like '% hai' or name like '% huynh';

-- l???y c??c h???c vi??n c?? t??n b???t ?????u b???ng ch??? h => regexp
select * from student where name  regexp '(^[a-zA-Z\\s]+\\sh[a-z]+$)';

-- 6. L???y ra c??c h???c vi??n c?? ??i???m l???n h??n 5 .
select * from student where point >5;
-- 7. l???y ra th??ng tin c??c h???c vi??n c?? ??i???m 4,6,8
select * from student where point in(4,6,8);

-- 8. Th??ng k??? s??? l?????ng h???c sinh theo t???ng lo???i ??i???m.
select *, count(point) as so_luong_hoc_sinh_co_muc_diem_nay from student s 
group by point;

-- 9 . Th??ng k??? s??? l?????ng h???c sinh theo ??i???m v?? ??i???m ph???i l???n h??n = 5
select point, count(point) as so_luong from student s 
group by point
having point>=5;
select point, count(point) as so_luong from student s 
where point>=5
group by point;

-- 10. Th??ng k??? s??? l?????ng h???c sinh theo ??i???m l???n h??n 5 v?? ch??? hi???n th??? v???i s??? l?????ng>=2
select point, count(point) as so_luong from student s 
where point>=5
group by point
having so_luong>2;
select * from student
where point>=5;

-- 11. L???y ra danh s??ch h???c vi??n c???a l???p c1121g1 v?? s???p x???p  h???c vi??n theo point gi???m d???n,
-- n???u point b???ng nhau th?? s???p x???p theo t??n gi???m d???n theo anphal.
select * from student s
join class c on s.class_id=c.id where c.name='c1121g1'
order by s.point desc, s.name desc;

