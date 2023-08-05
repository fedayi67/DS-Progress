-- data base olusturma
-- in pgadmin while writing our codes there's no difference of capital or lower letter
create database deneme; -- deneme isimli database olusturur/ create is a DDL hence we can create tables and database
-- DDL (Data Definition Lang.) create 

Create table ogrenciler1(
ogr_no varchar(10),
isim varchar(10),
tel varchar(15),
email varchar(25),
kayit_tarihi date
);
-- ctrl and - decreases the size of the font
-- ctrl and 0 turns it back to normal
-- this is how we create a table from another table
-- 06/03/2023
create table ogrenciortalama
as select isim,tel
from ogrenciler1
/*
for lengthy or big comments
*/
create table ogrenci_bilgi
as select isim,tel from ogrenciler1;

-- DML -> Data Manipulation Language. -> Insert (A command to enter data in the table)
-- Tum sutunlara veri ekleme

SELECT * FROM public.ogrenciler1
INSERT INTO ogrenciler1 VALUES ('1234','Erol','7507719018','jawed.fedayi67@gmail.com','06/03/2023');

-- bazi sutunlara veri ekleme

INSERT INTO ogrenciler1 (isim,tel,email) VALUES ('Evren','025478961','evren@gmail.com');
-- practice 1
create table tedarikciler(
tedarik_id char(4),
tedarikci_ismi varchar(25),
tedarikci_adres varchar(50),
ulasim_tarihi date
);
SELECT * FROM PUBLIC.tedarikci_ziyaret
CREATE TABLE tedarikci_ziyaret
AS SELECT tedarikci_ismi, ulasim_tarihi FROM tedarikciler
-- practice2
CREATE TABLE oretmenler(
kimlik_no char(11),
isim varchar(25),
brans varchar(20),
cinsiyet varchar(5)
);
insert into oretmenler values ('234431223','Ayse Guler','Matematik','Kadin');
SELECT * FROM PUBLIC.oretmenler;
insert into oretmenler (kimlik_no,isim) values ('567597624','Ali Veli');

-- DQL -> Data Query Language -> SELECT Command

-- Tablodaki tum sutun bilgilerini getirmek icin: * after select
select * from ogrenciler1;

--tablodaki sitedigimiz bir veya birden fazla sutunu getirmek icin
SELECT isim,tel from ogrenciler1;

-- SQL constraints are used to specify rules for the data in a table. 
-- Constraints are used to limit the type of data that can go into a table. 

-- CONSTRAINT (KISITLAMA)
-- UNIQUE and NOT NULL
-- NOT: kisitlamalar tablo olusturulurken yapilmalidir. Sonradan ALTER komutu
-- ile kisitlama eklenebilir fakat bu iliskili tablolarda sorun teskil edebilir
Create table ogrenciler3(
ogr_no varchar(10) ,
isim varchar(10) UNIQUE,
tel varchar(15),
email varchar(25),
kayit_tarihi date
);

SELECT * FROM ogrenciler3
INSERT INTO ogrenciler3 VALUES ('1234','Erol','7507719018','jawed.fedayi67@gmail.com','06/03/2023');
INSERT INTO ogrenciler3 VALUES ('1234','ErolEvren','7507719018','jawed.fedayi67@gmail.com','06/03/2023');

Create table ogrenciler4(
ogr_no varchar(10) ,
isim varchar(10) UNIQUE,
tel varchar(15) not null,
email varchar(25) not null,
kayit_tarihi date
);

SELECT * FROM ogrenciler4
INSERT INTO ogrenciler4 VALUES ('1234','Erol','7507719018','jawed.fedayi67@gmail.com','06/03/2023');
INSERT INTO ogrenciler4 (isim,email) VALUES ('Evren','evren@gmail.com');
INSERT INTO ogrenciler4 VALUES ('1234','ErolEvren','','jawed.fedayi67@gmail.com','06/03/2023');
--in order to make a variable both unique and not null we can:
Create table ogrenciler5(
ogr_no varchar(10) ,
isim varchar(10) UNIQUE,
tel varchar(15) not null,
email varchar(25) not null,
kayit_tarihi date,
UNIQUE (tel,email) -- now both tel and email are unique and not null
);
SELECT * FROM ogrenciler5
INSERT INTO ogrenciler5 VALUES ('1234','Erol','7507719018','jawed.fedayi67@gmail.com','06/03/2023');
INSERT INTO ogrenciler5 (isim,email) VALUES ('Evren','evren@gmail.com');
INSERT INTO ogrenciler5 VALUES ('1234','ErolEvren','','jawed.fedayi67@gmail.com','06/03/2023');
INSERT INTO ogrenciler5 VALUES ('1234','Ern','','jawed.f67@gmail.com','06/03/2023');


Create table ogrenciler6(
ogr_no varchar(10) ,
isim varchar(10) UNIQUE,
tel varchar(15) not null,
email varchar(25) not null,
kayit_tarihi date,
UNIQUE (tel,email) -- now both tel and email are unique and not null
);
SELECT * FROM ogrenciler6
INSERT INTO ogrenciler6 VALUES ('1234','Erol','7507719018','jawed.fedayi67@gmail.com','06/03/2023');
INSERT INTO ogrenciler6 (isim,email) VALUES ('Evren','evren@gmail.com');
INSERT INTO ogrenciler6 VALUES ('1234','ErolEvren','','jawed.fedayi67@gmail.com','06/03/2023');
INSERT INTO ogrenciler6 VALUES ('1234','ErLn','7507719018','jawed.f67@gmail.com','06/03/2023');

Create table ogrenciler7(
ogr_no varchar(10) ,
isim varchar(10) UNIQUE, -- unique kisitlamasi oldugu icin iki kere ayni veriyi atamayiz
tel varchar(15) not null,
email varchar(25) not null,
kayit_tarihi date,
UNIQUE (tel,email) -- now both tel and email are unique and not null
);
-- WE NEED CONSTRAINT NAME WHILE USING COMMANDS LIKE ALTER
-- WE CAN NAME A CONSTRAINT LIKE UNIQUE A SHIRT NAME LIKE
CONSTRAINT uniq_key unique (tel) -- boyle oldugu zaman bu uniq_key kullanabiliriz


Create table ogrenciler9(
ogr_no varchar(10) ,
isim varchar(10) UNIQUE,
tel varchar(15) not null,-- hem not null hem unique kisitlamasi varsa,hicligi bir kere kabul eder, ikinci kere etmez
email varchar(25) not null,
kayit_tarihi date,
CONSTRAINT uniq_key unique (tel),-- bir kisitlamaya kendimiz isim vermek istersek
-- ornekteki gibi
UNIQUE (email) -- burada constraint ismini kendisi belliyor
);
-- not null i bir deger gibi kabul edeniliyor

create table personel
(
id char(10),
isim varchar(50) NOT NULL,
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,
maas int
);
select * from personel
insert into personel (id,soyisim) values ('12345','evren');
/*null value in column "isim" of relation "personel" violates not-null constraint
yukaridaki insert islemini kabul etmez ve yukaridaki gibi hata verir
cunku isim sutununa not null kisitlamasi tablo olustururken atanmistir, dolayisiyla
isim sutunu bos gecilmez*/

-- PRIMARY KEY(UNIQUE-NOT NULL ozellikleri alir) ayni zamanda RSql da pk olmalidir
-- Tabloya primary key atamasi 1. yol

create table personel1 
(
id char(10) PRIMARY KEY,
isim varchar(50),
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,
maas int
);
select * from personel1
-- 2nd way
create table personel2 
(
id char(10),
isim varchar(50),
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,
maas int,
constraint pk primary key (id)
);
select * from personel2
-- 3rd way
create table personel3
(
id char(10),
isim varchar(50),
soyisim varchar(50),
email varchar(50),
ise_baslama_tar date,
maas int,
primary key (id) 
);
select * from personel3
-- practice3 from pdf
--Foreign Key -> Primary key olan tablo ile baglanti kuracak, diger tablodaki
-- sutuna foreign key atamasi yapar

--practice4
create table tedarikciler1
( --> parent tavle
tedarikci_id varchar(10) Primary key,
tedarikci_isim varchar(30),
iletisim_isim varchar(50)
)


create table urunler( --> Child table
tedarikci_id varchar(10),
urun_id varchar(10),
foreign key (tedarikci_id) references tedarikciler1(tedarikci_id)
)
-- references address icin 
-- Parent tablonun primary key sutunu ile child tablonun foreign key atamasi 
--yapilmis sunutu yukaridaki sekilde baglanti kurmus olur

create table tedarikciler2
( --> parent tavle
tedarikci_id varchar(10) Primary key,
tedarikci_isim varchar(30),
iletisim_isim varchar(50)
)

create table urunler1( --> Child table
urun_isim varchar(10), -- no need the size be same
urun_id varchar(10),
foreign key (urun_isim) references tedarikciler2(tedarikci_id)
)

create table tedarikciler3
( --> parent tavle
tedarikci_id varchar(10) Primary key,
tedarikci_isim varchar(30),
iletisim_isim varchar(50)
)

create table urunler2( --> Child table
urun_isim varchar(50), -- no need the size be same
urun_id varchar(10),
foreign key (urun_isim) references tedarikciler3(tedarikci_id)
)
create table tedarikciler4
( --> parent tavle
tedarikci_id int Primary key,
tedarikci_isim varchar(30),
iletisim_isim varchar(50)
)

create table urunler3( --> Child table
urun_isim varchar(50), -- no need the size be same
urun_id varchar(10),
foreign key (urun_isim) references tedarikciler4(tedarikci_id)
)
/*
Parent tablonun primary key sutunu ile child tablonun foreign key atamasi 
yapilmis sunutu yukaridaki sekilde baglanti kurmus olur.
Baglanti kuracagimiz sutunlarin data tipleri ayni olmalidir
ayni olmazsa asagidaki hatayi aliriz:
DETAIL:  Key columns "urun_isim" and "tedarikci_id" are of incompatible types:
character varying and integer.
*/
-- bir kere tablolar arasi PK FK iliskisi kurduktan sonra. child tabledaki FKyi silmeden 
-- PKyi silemeyiz, farkli yol ve yontemleri var
--Solve practice 5


