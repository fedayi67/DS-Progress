--SQL KOMUTLARI GRUPLARA AYRILIR:

--1.(Data Query Language - DQL) Veri Sorgulama Dili

--SELECT: veritabanındaki verileri getirir.

--2.(Data Manipulation Language - DML) Veri Kullanma Dili

--INSERT:Veritabanına veri ekler.
--DELETE:Veritabanındaki verileri siler
--UPDATE:Veritabanındaki verileri günceller.

--3.(Data Definition Language - DDL) Veri Tanimlama Dili

--DROP: Tabloyu siler.
--ALTER: Tabloyu günceller.
--CREATE: Tablo oluşturur.


create table ogrenciler
(
id int,
isim varchar(40),
adres varchar(100),
sinav_notu int
);

--- INSERT:Veritabanına yeni veri ekler.

insert into ogrenciler values(120, 'Ali Can', 'Ankara', 75);
insert into ogrenciler values(121, 'Veli Mert', 'Trabzon', 85);
insert into ogrenciler values(122, 'Ayşe Tan', 'Bursa', 65);
insert into ogrenciler values(123, 'Derya Soylu', 'Istanbul', 95);
insert into ogrenciler values(124, 'Yavuz Bal', 'Ankara', 85);
insert into ogrenciler values(125, 'Emre Gül', 'Hatay', 90);
insert into ogrenciler values(126, 'Harun Reşit', 'Isparta', 100);

select * from ogrenciler;

--SORU1: ogrenciler tablosundaki id ve isim sütununu listele

select id,isim from ogrenciler;

--SORU2: sinav_notu 80'den büyük olan öğrencilerin tüm bilgilerini listele

select * from ogrenciler where sinav_notu>80;

--SORU3: adres'i 'Ankara' olan ögrencilerin tüm bilgilerini listele

select * from ogrenciler where adres='Ankara';

--SORU4: sinav_notu 85 ve adres'i 'Ankara' olan öğrenci isim'ini listele

select isim from ogrenciler where sinav_notu=85 and adres='Ankara';

--SORU5: .sinav_notu 65 veya 85 olan ogrencilerin tüm bilgilerini listele
select * from ogrenciler;

select * from ogrenciler where sinav_notu=65 or sinav_notu=85;

--2.yol
select * from ogrenciler where sinav_notu in(65,85);

--SORU6: .sinav_notu 65 ve 85 arasında olan ogrencilerin tüm bilgilerini listele

select * from ogrenciler where sinav_notu between 65 and 85;

--2. yol
select * from ogrenciler where sinav_notu>=65 and sinav_notu<=85;


--SORU7: .id'si 122 ve 125 arasında olmayan ögrencilerin id, isim'ini ve sinav_notu listele

select id, isim, sinav_notu from ogrenciler where id not between 122 and 125;


--2.yol
select id,isim,sinav_notu from ogrenciler where id<122 or id>125;



--SORU8: sinav_notu 75 olan satırı siliniz
select * from ogrenciler;

delete from ogrenciler where sinav_notu=75;

--SORU9: adres'i 'Trabzon' olan satırı siliniz

delete from ogrenciler where adres='Trabzon';


--SORU10: isim'i 'Derya Soylu' veya 'Yavuz Bal' olan satırları siliniz

delete from ogrenciler where isim='Derya Soylu' or isim='Yavuz Bal';

--2.yol
delete from ogrenciler where isim in('Derya Soylu', 'Yavuz Bal');

select * from ogrenciler;


--SORU11: sinav_notu 100 den küçük olan satırları siliniz

delete from ogrenciler where sinav_notu<100;

--SORU12: Tablodaki tüm verileri siliniz
delete from ogrenciler;

select * from ogrenciler;


--SORU13: ogrenciler tablosunu siliniz

drop table ogrenciler;





-- CONSTRAINT -- Kısıtlamalar


-- UNIQUE -->  sütundaki verilerin BENZERSİZ olmasıdır
-- NOT NULL --> Bir sutunun NULL içermemesini sağlar
-- NOT NULL kısıtlaması veri türünden hemen sonra yazılır. CONSTRAINT ismi tanımlanmaz.
-- PRIMARY KEY --> NOT NULL - UNIQUE (BENZERSİZ)
-- FOREIGN KEY --> Başka bir tablodaki PRİMARY KEY'i referans göstermek için kullanılır.
--Böylelikle, tablolar arasında Parent- Child ilişkisi oluşur.
-- CHECK --> Bir sutunun değer aralığını sınırlamak için kullanılır.


/*SORU: memurlar isminde bir tablo oluşturunuz. id, isim, maas sutunları olsun.
id sutununun data tipi int olsun. PRİMARY KRY kısıtlaması olsun.
isim sutununun data tipi varchar(30) olsun. UNIQUE kısıtlaması olsun.
maas sutununun data tipi int olsun. maas 5000 buyuk olsun. NOT NULL kısıtlaması olsun. */

create table memurlar(
id int PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int CHECK (maas>5000) NOT NULL
)


/*SORU: insanlar isminde bir tablo oluşturunuz. isim, soyisim sutunları olsun.
isim sutununun data tipi varchar(20) olsun. PRİMARY KEY kısıtlaması olsun. Kısıtlamanın ismi pr_ks olsun
soyisim sutununun data tipi varchar(30) olsun. UNIQUE kısıtlaması olsun. Kısıtlamanın ismi uni_ks olsun*/


create table insanlar(
isim varchar(20),
soyisim varchar(30),
CONSTRAINT pr_ks PRIMARY KEY(isim),
CONSTRAINT uni_ks UNIQUE(soyisim)

)


create table calisanlar
(
id char(5) PRIMARY KEY,   --->unique + not null  
isim varchar(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);

insert into calisanlar values(10002, 'Mehmet Yılmaz', 12000, '2018-04-14');
insert into calisanlar values(10008, null, 5000, '2018-04-14');
insert into calisanlar values(10010, null,5000, '2018-04-14');
insert into calisanlar values(10020, null, 5000, '2018-04-14');
insert into calisanlar values(10004, 'Veli Han', 5000, '2018-04-14');
insert into calisanlar values(10005, 'Mustafa Ali', 5000, '2018-04-14');
insert into calisanlar values(10006, 'Canan Yaş', 'null', '2019-04-12');  -- not null
insert into calisanlar values(10003, 'CAN', 5000, '2018-04-14');
insert into calisanlar values(10007, 'CAN', 5000, '2018-04-14');  -- unique
insert into calisanlar values(10009, 'Cem', '', '2018-04-14');  -- data turu int
insert into calisanlar values('', 'osman', 2000, '2018-04-14');
insert into calisanlar values('', 'osman can', 2000, '2018-04-14'); -- primary key 
insert into calisanlar values('', 'veli can', 6000, '2018-04-14'); -- primary key
insert into calisanlar values(10002, 'ayse Yılmaz', 12000, '2018-04-14');  -- primary key
insert into calisanlar values(null, 'filiz', 12000, '2018-04-14');  -- primary key


-- FOREGIN KEY --> Başka bir tablodaki PRİMARY KEY'i referans göstermek için kullanılır. 
-- Böylelikle, tablolar arasında parent child ilişkisi oluşur.


--1) parent tabloda olmayan primary key ile child tabloya veri girişi yapılamaz
  -- child tablo null deger kabul eder

--2) child tablodaki veri silinmeden parent tablodaki veri silinemez

--3) child tablo silinmeden parent tablo silinemez


CREATE TABLE parent 
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);
    
INSERT INTO parent VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO parent VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO parent VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO parent VALUES (104, 'Apple', 'Adam Eve');

select * from parent;

CREATE TABLE child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk FOREIGN KEY(ted_vergino) REFERENCES parent(vergi_no)
);    
    
INSERT INTO child VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO child VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO child VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO child VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO child VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO child VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO child VALUES(104, 1007,'Phone', 'Aslan Yılmaz');
    
select * from child;

--SORU 1: child tablosuna ted_verginosu 101 olan veri girişi yapınız

insert into child values(101, 2000, 'Araba', 'Burak');

--SORU 2: .child tablosuna ted_verginosu 105 olan veri girişi yapınız.

-- parent tabloda olmayan primary key ile child tabloya veri girisi yapılamaz

--insert into child values(105, 3000,'Motor','Haşim') bu sebeple bu kod eror verir


--SORU 3: child tablosuna ted_vergino null olan veri girişi yapınız 

select * from child;

insert into child values(null, 4000, 'Bisiklet','Nuri');

-- child tablo null deger kabul eder.

--SORU 4: .parent tablosundaki vergi_no 101 olan veriyi siliniz. 

-- child tablodaki veri silinmeden parent tablodaki veri silinemez

--delete from parent where vergi_no=101; bu sebeple bu kod eror verir


--SORU 5: child tablosundaki ted_vergino 101 olan verileri siliniz

delete from child where ted_vergino=101;


select * from child;


--SORU 6: .parent tablosundaki vergi_no 101 olan veriyi siliniz 

delete from parent where vergi_no=101;


--SORU 7: .parent tablosunu siliniz. 

-- child tablo silinmeden parent tablo silinemez

--drop table parent; bu sebeple bu kod eror verir


select * from child;


--SORU 8: child tablosunu siliniz 

drop table child;



--SORU 9: .parent tablosunu siliniz

drop table parent;




























