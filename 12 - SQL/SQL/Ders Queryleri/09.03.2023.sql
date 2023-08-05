--DML--> UPDATE --
-- SYNTAX
	--Eger bir sorunda bir veriyi degistiriniz gibi bir soruyla karsilasirsak
	--Once UPDATET tablo_adi
	-- Set sutun adi
select * from personel4;

-- Personel tablosunda id si 1001 olan ogrencinin ismini Erol Evren olarak degistiriniz
UPDATE personel4
SET isim = 'Erol Evren' -- bunu run yapinca tum sutunu erol evrene degistirir
-- onun icin specific id si 1001 olan diye specify yapmamiz lazm
-- ama ondan once bir kez daha personel 4 tablosunu olusturmamiz lazim
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

UPDATE personel4
SET isim = 'Erol Evren'
WHERE id = '1001'; -- now it will chang ethe data with id 1001

CREATE TABLE hastaneler
(
id char(5) primary key, 
isim char(30),
sehir char(15),
ozel char(1)
); 
insert into hastaneler values('H101', 'Aci Madem Hastanesi', 'Istanbul', 'Y');
insert into hastaneler values('H102', 'HasZeki Hastanesi', 'Istanbul', 'N');
insert into hastaneler values('H103', 'Medikol Hastanesi', 'Izmir', 'Y');
insert into hastaneler values('H104', 'Memoryil Hastanesi', 'Ankara', 'Y');
CREATE TABLE hastalar(
  kimlik_no CHAR(11) PRIMARY Key,
  isim CHAR(50) ,
  teshis  CHAR(20)
  );
  insert INTO hastalar values('12345678901','Ali Can','Gizli Seker');
  insert INTO hastalar values('45678901121','Ayse Yilmaz','Hipertansiyon');
  insert INTO hastalar values('78901123451','Steve Jobs','Pankreatit');
  insert INTO hastalar values('12344321251','Tom Hanks','COVID 19');
   
create table bolumler(
bolum_id char(5),
bolum_adi char(20)
);
insert into bolumler values('DHL','Dahiliye');
insert into bolumler values('KBB','Kulak Burun Bogaz');
insert into bolumler values('NRJ','Noroloji');
insert into bolumler values('GAST','Gastoroloji');
insert into bolumler values('KARD','Kardioloji');
insert into bolumler values('PSK','Psikiyatri');
insert into bolumler values('GOZ','Goz Hastaliklari');
create table hasta_kayitlar(
kimlik_no char(11) Primary key,
hasta_ismi char(20),
hastane_adi char(50),
bolum_adi char(20),
teshis char(20)
);
insert into hasta_kayitlar values('1111','NO NAME','','','');
insert into hasta_kayitlar values('2222','NO NAME','','','');
insert into hasta_kayitlar values('3333','NO NAME','','','');
insert into hasta_kayitlar values('4444','NO NAME','','','');
insert into hasta_kayitlar values('5555','NO NAME','','','');

/*hasta_kayıtlar tablosundaki ‘3333’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : ‘Salvadore Dali’ ismi ile
hastane_adi: ‘John Hopins’
bolum_adi: ‘Noroloji’
teshis: ‘Parkinson’
kimlik_no: ‘99991111222’
*/

select * from hasta_kayitlar;
UPDATE hasta_kayitlar
set hasta_ismi = 'Salvadore Dali', 
	hastane_adi = 'John Hopins',
	bolum_adi = 'Noroloji',
	teshis = 'Parkinson',
	kimlik_no = '99991111222'
where kimlik_no = '3333';

/*
hasta_kayıtlar tablosundaki ‘1111’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : hastalar tablosundaki kimlik nosu ‘12345678901’ olan kişinin ismi ile
hastane_adi: hastaneler tablosundaki 'H104' bolum_id kodlu hastanenin ismi ile
bolum_adi: bolumler tablosundaki 'DHL' bolum_id kodlu bolum_adi ile
teshis: hastalar tablosundaki 'Ali Can' isimli hastanın teshis bilgisi ile
kimlik_no: hastalar tablosundaki 'Ali Can' isimli hastanın kimlik_no kodu ile
*/

update hasta_kayitlar
set hasta_ismi = (select isim from hastalar where kimlik_no = '12345678901'),
	hastane_adi = (select isim from hastaneler where id = 'H104'),
	bolum_adi = (select bolum_adi from  bolumler where bolum_id = 'DHL'),
	teshis = (select teshis from hastalar where isim = 'Ali Can'),
	kimlik_no = (select kimlik_no from hastalar where isim = 'Ali Can')
	where kimlik_no = '1111';
select * from hasta_kayitlar;

-- ALIES
select hasta_ismi as isim from hasta_kayitlar -- gecici olarak yeni bir isim atiyor

-- IS NULL CONDITION
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir'); 
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');  
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

select * from insanlar;

-- insanlar tablosunda name degeri null olan tum verileri listeleyiniz
select * from insanlar where name is null;

-- insanlar tablosunda name degeri null olmayan tum verileri listeleyiniz
select * from insanlar where name is not null;

-- insanlar tablosunda name degeri null olan verilerin yerine isim girilmemis yazdiralim

update insanlar 
set name = 'isim girilmemis'
where name is null;

-- ORDER BY Clause
--asc-> kucukten buyuge yada alfabetik olarak siralar. Default olarak yazmadan kullanilir
-- desc->buyukten kucuge yada tersten siralama yapar
-- onceki insanlar tablosunu drop yapalim ve yeni olusturalim
CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar;

-- insanlar tablosunda adres sutununu alfabetik olarak sirali sekilde tum verileri listeleyiniz
select * from insanlar order by adres; -- for asc we don't need to mention
select * from insanlar order by adres asc;

-- insanlar tablosundaki soyisim sutununu tersten siralayiniz
select * from insanlar order by soyisim desc;

--insanlar tablosunda isim ve soyisimleri isme gire natural siralama soyisme gore tersten siralayiniz
select * from insanlar order by isim asc, soyisim desc; -- here isim is the priority, if they are same then considers soyisim

-- in ORDER BY, after the command, we can write the number of field instead of name

-- isim ve soyisim sutunlarini soyisim kelime uzunluguna gore siralayiniz

select isim,soyisim from insanlar order by length (soyisim); -- az dan coga
select isim,soyisim from insanlar order by length (soyisim) desc; -- cok tan aza

-- isim ve soyisim sutunlarini birlestiriniz
select concat (isim,' ',soyisim) as isim_soyisim from insanlar order by length(isim);
select concat (isim,' ',soyisim) as isim_soyisim from insanlar order by length(isim)+length(soyisim);
select concat (isim,' ',soyisim,' ',adres) as isim_soyisim_adres from insanlar order by length(isim);
select ssn, concat (isim,' ',soyisim,' ',adres) as isim_soyisim_adres from insanlar order by length(isim);
 
-- in order to concat, we don't eed to use the word concat we can :
select isim||' '||soyisim as isim_soyisim
from insanlar
order by length (isim||soyisim)


-- GROUP BY
create table sirket(
isim varchar(20),    
sehir varchar(20),
maas int    
);
insert into sirket values ('erol','burdur',1000);
insert into sirket values ('erol','antalya',2000);
insert into sirket values ('erol','izmir',1500);
insert into sirket values ('ahmet','bursa',900);
insert into sirket values ('ahmet','izmir',2500);
insert into sirket values ('ahmet','istanbul',1800);
insert into sirket values ('mert','trabzon',1200);
insert into sirket values ('mert','istanbul',1000);
insert into sirket values ('mert','antep',2000);
insert into sirket values ('mert','tokat',3000);
insert into sirket values ('eda','antep',1200);
insert into sirket values ('eda','urfa',1500);
insert into sirket values ('erol','usak',2000);
insert into sirket values ('erol','burdur',900);

select * from sirket;

-- sirkette calisanlarin isimlerini listeleyiniz
select isim from sirket; -- tum isim sutununu getirir

select isim from sirket
group by isim;

select isim,sehir from sirket
group by isim,sehir order by isim;

-- GROUP BY commandi AGGREGATE METHODlarla kullanimi

select * from sirket;
-- sirkette calisanlarin toplam maasini listeleyiniz
select sum(maas) from sirket;
select isim,sum(maas) from sirket; -- asahidaki error verir:
/*ERROR:  column "sirket.isim" must appear in the GROUP BY clause or be used in an aggregate function
LINE 1: select isim,sum(maas) from sirket;*/
select isim,sum(maas) as toplam_maas from sirket
group by isim;

--sirkette calisanlarin en yuksek maas ve en dusuk maaslarini listeleyiniz
select isim, max(maas) as en_yuksek_maas, min(maas) as en_dusuk_maas,round(avg(maas)) as ortalama from sirket
group by isim;

select * from sirket;
--Tabloda kim kac ilde calistigini listeleyiniz
select isim,count(sehir) as calistigi_iller from sirket
group by isim order by isim;

--HAVING --> Sadece Group by komutu ile kullanılır. Gruplamadan sonra bir şart var ise WHERE komutu kullanamayız
            --Onun yerine aynı anlama gelen HAVING komutu kullanılır
			
--Toplam maası 7000'in altında olan kişileri listeleyiniz
SELECT isim,sum(maas) as toplam_maas FROM sirket
GROUP By isim
HAVING sum(maas)<7000;

--Toplam maası 7000'in ustunde olan kişileri listeleyiniz
SELECT isim,sum(maas) as toplam_maas FROM sirket
GROUP By isim
HAVING sum(maas)>7000;

--Sehirlere göre ortama maaslari 2000'in altındakileri ortalama maaşlarına göre büyükten küçüğe listeleyiniz
SELECT sehir,round(avg(maas)) as ortalama_maas FROM sirket 
GROUP by sehir
HAVING avg(maas)<2000 order by ortalama_maas desc;

--Sehirlere göre ortama maaslari 2000'in ustundekileri ortalama maaşlarına göre büyükten küçüğe listeleyiniz
SELECT sehir,round(avg(maas)) as ortalama_maas FROM sirket 
GROUP by sehir
HAVING avg(maas)>2000 order by ortalama_maas desc;







