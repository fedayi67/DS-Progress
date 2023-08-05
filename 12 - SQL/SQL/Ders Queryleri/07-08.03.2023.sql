-- Primary key ve foreign key practice

create table student(
st_no char(4) PRIMARY KEY,
isim varchar(10),
soyisim varchar(20),
tel varchar(11),
email varchar(20),
sehir varchar(20)
);
SELECT * FROM public.student

INSERT INTO STUDENT VALUES ('1234','EROL','EVREN','053213546','EROL@GMAIL.COM','ANKARA');
INSERT INTO STUDENT VALUES ('1235','BERK','CAN','05373546','EROL123@GMAIL.COM','BURSA');
INSERT INTO STUDENT VALUES ('1236','RMEYSA','KAYA','74859632104','ERUMEYSAL@GMAIL.COM','IZMIR');
INSERT INTO STUDENT VALUES ('1237','AHMET','ERKAN','079513546','AHMET@GMAIL.COM','ISTANBUL');
INSERT INTO STUDENT VALUES ('1238','EMRE','CAN','053219546','EMRE@GMAIL.COM','BURDUR');

CREATE TABLE notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real,
finalnotu real,
FOREIGN  KEY (st_no) REFERENCES student(st_no)
);

SELECT * FROM public.notlar

INSERT INTO notlar VALUES ('1234','1. donem','75.5','80','85.5');
INSERT INTO notlar VALUES ('1235','1. donem','70','65','82.5');
INSERT INTO notlar VALUES ('1236','1. donem','65','95','70');
INSERT INTO notlar VALUES ('1237','1. donem','55','95','70');
INSERT INTO notlar VALUES ('1238','1. donem','0','50','85');
INSERT INTO notlar VALUES ('1234','2. donem','65','80.5','75');
INSERT INTO notlar VALUES ('1235','2. donem','55','75','95');

--DQL -> Data Query Language -> WHERE kosulu
-- student tablosundan berk isimli ogrencinin tel ve email bilgilerini listeleyiniz
select * from student

select isim,tel,email from student where isim = 'BERK';

-- ogrenci numarasi 1236 olan ogrencinin tum bilgilerini listeleyiniz
select * from student where st_no = '1236';

-- ogrenci numarasi 1236 olan ogrencinin isim,tel ve emailini bilgilerini listeleyiniz
select isim,tel,email from student where st_no = '1236';

-- ogrenci numarasi 1238 olan ogrencinin notlarini listeleyiniz
select * from notlar
where st_no = '1238';

-- pgrenci numarasi 1234 olan ogrencinin notlarini listeleyiniz
select * from notlar
where st_no = '1234';

INSERT INTO notlar VALUES ('1239','2. donem','55','75','95');
-- parent de olmayan bir veriyi child tablea giremeyiz, eger girmeye calisirsak,
-- boyle bir hata verir
--Key (st_no)=(1239) is not present in table "student".

-- CHECK CONSTRAINT--> bIR SUTUNU SINIRLANDIRMAK ICIN KULLANILIR
--CONSTRAINT ATAMALARI TABLO OLUSTURULURKEN YAPILMALI, SONRASINDA ALTER TABLE ILE 
-- YAPILA DEGISIKLIKLER KARISIKLIGA YOL ACAR

-- let's delete previous notlar table and recreate with check constraint
CREATE TABLE notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real,
finalnotu real check (finalnotu>45),
FOREIGN  KEY (st_no) REFERENCES student(st_no)
);
INSERT INTO notlar VALUES ('1234','1. donem','75.5','80','85.5');
INSERT INTO notlar VALUES ('1235','1. donem','70','65','82.5');
INSERT INTO notlar VALUES ('1236','1. donem','65','95','70');
INSERT INTO notlar VALUES ('1237','1. donem','55','95','70');
INSERT INTO notlar VALUES ('1238','1. donem','0','50','85');
INSERT INTO notlar VALUES ('1234','2. donem','65','80.5','75');
INSERT INTO notlar VALUES ('1235','2. donem','55','46','50');

-- CHECHK CONSTRAINT DE 45 UZERI GIRMEMIZ GEREKIYOR DEDIK ONUN ICIN SON KODDA
-- BOYLE BIR ERROR VERI:
--ERROR: new row for relation "notlar" violates check constraint "notlar_finalnotu_check"
DROP TABLE notlar;
 -- burada bir daha notlari sildik
 
select * from notlar;

-- Notlar tablosundan 80'nin ustundeki notlari listeleyiniz
select ikincivizenotu from notlar where ikincivizenotu > '80';

-- ilk vizenotu 65in altinda olanlari listeleyiniz
select ilkvizenotu from notlar where ilkvizenotu < '65';
-- parent tableden istedigimiz zaman bilgi kaldiramayiz,DELETE ile,
-- once child table'den silmemiz lazim

--DML -> DELETE command
--SYNTAX
--DELETE from tablo-adi
-- Eger veriyi silmek istersek DELETE FROM tablo_adi WHERE Sutun_adi = 'veri'
DELETE FROM notlar; -- Notlar tablosundaki tum veriler silindi

-- Notlar tablosunda st_no 1234 olan verinin tum notlarini siliniz
delete from notlar where st_no = '1234';

-- student tablosundan ogrenci numarasi 1234 olan verinin tum bilgilerini siliniz
SELECT * FROM student;

DELETE FROM student;
delete from student where st_no = '1234';
-- simdi child table de veriler oldugu icin student tablosunu silemez
-- ama notlar tablosundan 1234 numarali bilgiler silindigi icin onu silebiliriz
-- iliskili tablelarda child tableden veri silmeden parent tableden silemeyiz.
--eger o veriyi silmek istiyorsak once child tableden sonra parent tableden silebiliriz.

--NOTE: Child tablodan olan bir veriyi parent tableden silmeye calisirsak :
--ERROR:  update or delete on table "student" violates foreign key constraint "notlar_st_no_fkey" on table "notlar"
--hatayi aliriz

-- there is a way to delete data from parent table without deleting it from child table


--TRUNCATE -> Bu komut ile tablodaki tum verileri silebiliriz. Yalniz sartli silme yapamayiz.

TRUNCATE TABLE notlar;
select * from notlar;
select * from student;

-- now we delete notlar table in order to be able to use ON DELETE CASCADE

--ON DELETE CASCADE -> bu command sayesinde parent tablodan istedigimiz veriyi silebiliriz
-- parent tableden sildigimiz zaman child tableden de silinir
CREATE TABLE notlar(
st_no char(4),
donem varchar(10),
ilkvizenotu real,
ikincivizenotu real,
finalnotu real check (finalnotu>45),
FOREIGN  KEY (st_no) REFERENCES student(st_no)
ON DELETE CASCADE
);

select * from notlar;

-- student tablosundan 1234 numarali ogrencinin tum verilerini siliniz
delete from student where st_no = '1234';

/*
	ON DELETE CASCADE komutu kullanmadan parent tabloyu kaldirmak istersek,
once child tablei kaldirmamiz gerekir.
	ON DELETE CASCADE komutunu child table olustururken kullandiysak DROP TABLE 
parent_tablo CASCADE yazarak kaldirabiliriz
*/
-- Delete is a DML Command, deletes the data
-- DROP is a DDL command, deletes the table or database
DROP TABLE tablo_adi  --> tabloyu tamamen database kaldirma kodu
DROP TABLE student CASCADE; --siler cascade'dam dolayi
DROP TABLE student; -- silemez, cascade'dan dolayi
select * from student;


-- IN CONDITION
CREATE TABLE musteriler
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

select * from musteriler;

--AND->Her iki sarti birden saglamasi gerekir
--OR-> tek bir sarti saglasa yeterlidir

--urun ismi orange ile Apple olan veileri listeleyiniz

select * from musteriler where urun_isim = 'Orange' and urun_isim = 'Apple'
-- boyle yazarsak ya yaninda baska ayni isimdeki sutun arar ya da orange yaninda apple arar
-- bunun icin hem orange hem apple demesi gerek

select * from musteriler where urun_isim = 'Orange' or urun_isim = 'Apple';

-- urunismi apple ile orange olan musteri isimlerini listeleyiniz
select musteri_isim from musteriler where urun_isim = 'Orange' or urun_isim = 'Apple';

-- 2. Yol --> IN CONDITION KULLANIMI
-- urunismi apple ile orange olan musteri isimlerini,urunisimlerini listeleyiniz
select musteri_isim, urun_isim from musteriler where urun_isim in ('Orange','Apple');

--musteri_ismi Amy olan ile urun_ismi Palm olan verileri listeleyiniz
select musteri_isim, urun_isim FROM musteriler WHERE musteri_isim = 'Amy' and urun_isim = 'Palm';
select musteri_isim, urun_isim FROM musteriler WHERE musteri_isim = 'Amy' and urun_isim = 'Apple';
select musteri_isim, urun_isim FROM musteriler WHERE musteri_isim = 'Mark' and urun_isim = 'Orange';

-- NOT IN
select * from musteriler;
-- apple orange disindakileri gonderir not in kullansak
select musteri_isim, urun_isim from musteriler where urun_isim not in ('Orange','Apple');

-- BETWEEN CONDITION
--urun id degerleri 20 ile 40 arasinda olan tum verileri listeleyiniz 20 ile 40 samil
select * from musteriler where urun_id>=20 and urun_id <=40;

-- BETWEEN ile:
select * from musteriler where urun_id between 20 and 40;

--NOT BETWEEn
--urun id degerleri 20 ile 40 arasinda olmayanlan tum verileri listeleyiniz 20 ile 40 samil
select * from musteriler where urun_id not between 20 and 40;
select * from musteriler where urun_id < 20 or urun_id > 40;


/*
Practice 6
- id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
- D ile Y arasındaki personel bilgilerini listeleyiniz
- D ile Y arasında olmayan personel bilgilerini listeleyiniz
- Maaşı 70000 ve ismi Sena olan personeli listeleyiniz
*/
CREATE table personel4
(
id char(4),
isim varchar(50),
maas int
);

insert into personel4 values('1001', 'Ali Can', 70000);
insert into personel4 values('1002', 'Veli Mert', 85000);
insert into personel4 values('1003', 'Ayşe Tan', 65000);
insert into personel4 values('1004', 'Derya Soylu', 95000);
insert into personel4 values('1005', 'Yavuz Bal', 80000);
insert into personel4 values('1006', 'Sena Beyaz', 100000)

select * from personel4;
-- id'si 1003 ile 1005 arasında olan personel bilgilerini listeleyiniz
select * from personel4 where id between '1003' and '1005'; -- if the numbers are written in char we should call 
--them with char in ''

-- D ile Y arasındaki personel bilgilerini listeleyiniz,alfabetik siralamaya gore
-- yani d ile y harfleri arasindaki harflerle baslayan isimleri
select * from personel4 where isim between 'D' and 'Y'; -- saglikli bir yontem degil
select * from personel4 where isim between 'Derya Soylu' and 'Yavuz Bal';

-- D ile Y arasında olmayan personel bilgilerini listeleyiniz
select * from personel4 where isim not between 'Derya Soylu' and 'Yavuz Bal';
select * from personel4 where isim not between 'D' and 'Y'; -- saglikli degil

-- Maaşı 70000 ve ismi Sena olan personeli listeleyiniz
select * from personel4 where isim = 'Sena Beyaz' OR maas = 70000;
select * from personel4 where isim like 'Sena%' OR maas = 70000; -- another way, we'll see later

--SUBQUERY (Alt Sorgu)

CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);

INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 1000, 'Vakko');


CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

select * from calisanlar2;
select * from markalar;
--calisan sayisi 15kdan cok olaanmarkalarin isimlerini ve bu markda calisanlarin isimlerini ve maasini 
select isyeri,isim,maas from calisanlar2 
where isyeri in (select marka_isim from markalar where calisan_sayisi>15000);
-- parentez icinden elemani iki tane olan bir liste cikar, ve in kodu da iki elemanin neticelerini cikarir

--marka id'si 101'den buyuk olan marka calisanlarinin isim,maas ver sehirlerini listeleyiniz
select isim,maas,sehir from calisanlar2 
where isyeri in (select marka_isim from markalar where marka_id > 101);

--AGGREGATE METHOD KULLANIMI(SUM(),COUNT(),MIN(),MAX(),AVG()) ** Ancak, sorgu tek bir deger donduruyor olmalidir

-- calisanlar tablosundaki en yuksek maasi listeleyiniz
select max(maas) from calisanlar2;
select max(maas) as en_yuksek_maas from calisanlar2;
--en dusuk maas
select min(maas) from calisanlar2;
select min(maas) as en_dusuk_maas from calisanlar2;
--calisanlar tablosunda kac kisi oldugunu listeleyin:
select count(isim) from calisanlar2;
select count(*) from calisanlar2; -- satir 
select count(isim) as kisi_sayisi from calisanlar2;

-- calisanlar tablosundaki maas ortalamasini listeleyiniz
select avg(maas) from calisanlar2;
select avg(maas) as maas_ortalama from calisanlar2;
--avg()methodda cikansonucu yuvarlamak icin:
select round(avg(maas)) from calisanlar2;
select round(avg(maas),2) from calisanlar2;
select round(avg(maas),2) as maas_ortalamasi from calisanlar2;

-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz
select * from markalar;
SELECT marka_id, marka_isim,
(SELECT count(sehir) FROM calisanlar2 where marka_isim=isyeri) as sehir_sayisi
FROM markalar; -- = koymamizin sebebi, eger calisanlar tablosunda olan bir isyeri marka isimde olmazsa almasin diye
-- ya da tum isyerini sayi toplamini saydirir hepsine

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select marka_isim,calisan_sayisi,(select sum(maas) from calisanlar2 where marka_isim = isyeri) as toplam_maas
from markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz
select marka_isim,calisan_sayisi,
(select max(maas) from calisanlar2 where marka_isim = isyeri) as en_yuksek_maas,
(select min(maas) from calisanlar2 where marka_isim = isyeri) as en_dusuk_maas from markalar;

--EXISTS CONDITION -> Eger iki tablodaki sutunlar ayni ise EXISTS CONDITION kullanilir
CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan
(
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart;
select * from nisan;

/*
MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız
*/
select urun_id,musteri_isim from mart
where exists (select urun_id from nisan where mart.urun_id = nisan.urun_id);

/*
Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız
*/
SELECT urun_isim,musteri_isim FROM nisan
WHERE exists (SELECT urun_isim FROM mart where mart.urun_isim=nisan.urun_isim)

/*
Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız
*/
SELECT urun_isim,musteri_isim FROM nisan
WHERE not exists (SELECT urun_isim FROM mart where mart.urun_isim=nisan.urun_isim)

--DML --> UPDATE -- 
-- SUNTAX
	-- Eger bir soruda bir veriyi degistiriniz gibi bir soruyla karsilasirsak
	-- once UPDATE tablo_adi
	-- SET sutun_adi





