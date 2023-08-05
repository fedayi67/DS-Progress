-- UNION -> Kullaniminda sutun sayilari ve data tipleri ayni olmak zorunda
drop table if exists peronel; --> Eger tablo varsa tabloyu sil

CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50),  
maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel;

--Maasi 4000'den cok olan isci isimlerini ve 5000 liradan fazla maas alinan sehirleri gosteren sorguyu yaziniz
select isim as isim_sehir, maas from personel where maas > 4000
UNION
select sehir,maas from personel where maas > 5000 order by isim_sehir;

/*
Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
bir tabloda gosteren sorgu yaziniz
*/

select * from personel;
select isim as isim_sehir, maas from personel where isim = 'Mehmet Ozturk'
UNION
select sehir,maas from personel where sehir = 'Istanbul'

-- we drop the personel table and create again for the next example, as the next one has a primary key in it

CREATE TABLE personel
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

CREATE TABLE personel_bilgi  
(
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY (id) REFERENCES personel(id)
);

INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel;
--id’si 123456789 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin
select sehir as sehir_tel,maas as maas_cocuksayisi from personel where id = '123456789' 
union
select tel ,cocuk_sayisi from personel_bilgi where id = '123456789'

--UNION ALL - > if there are same row of information multiple times while unioning, 
-- if we use the union it only writes it once, but if we use union all it mention as many times
-- as there is
select * from personel;
--personel tabblosundan maasi 5000den az olan tum isimleri ve maaslari bulunuz
select isim,maas from personel where maas<5000
union
select isim,maas from personel where maas<5000;

select isim,maas from personel where maas<5000
union all
select isim,maas from personel where maas<5000;

select * from personel;
select * from personel_bilgi;
--INTERSECT OPERATOR

--Personel tablosundan istanbul veya ankarada calisanlar ile personel bilgi tablosundan 2 veya 3 cocugu olanlarin ortak id'lerini listeleyiniz
select id from personel where sehir in ('Istanbul','Ankara')
intersect
select id from personel_bilgi where cocuk_sayisi in (2,3)

--Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
select isim from personel where sirket = 'Honda'
intersect
select isim from personel where sirket = 'Ford'
intersect
select isim from personel where sirket = 'Tofas';

--EXCEPT OPERATOR(MINUS)
--5000’den az maas alip Honda’da calismayanlari yazdirin
--1. yol: solution with except
select isim,maas,sirket from personel where maas < 5000
except
select isim,maas,sirket from personel where sirket = 'Honda';
--ikinci yol solution with not equal to + and
select isim,maas,sirket from personel where maas < 5000 and sirket <>'Honda';


select * from personel;
select * from personel_bilgi;
--Ismi Mehmet Ozturk olup Istanbul’da calismayanlarin isimlerini ve sehirlerini listeleyin
select isim,sehir from personel where isim = 'Mehmet Ozturk'
except
select isim,sehir from personel where sehir = 'Istanbul';
-- asagidaki ile farki, except all kullaninca tekrari da alir ama except tekrari almiyor
select isim,sehir from personel where isim = 'Mehmet Ozturk'
except all
select isim,sehir from personel where sehir = 'Istanbul';

--2. yol
select isim,sehir from personel where isim = 'Mehmet Ozturk' and sehir <> 'Istanbul';

--JOINS
--INNER JOINS

CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota');  
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford');  
INSERT INTO sirketler VALUES(103, 'Hyundai');
CREATE TABLE siparisler  (
siparis_id int,  
sirket_id int,  
siparis_tarihi date
);
INSERT INTO siparisler VALUES(11, 101, '2020-04-17');  
INSERT INTO siparisler VALUES(22, 102, '2020-04-18'); 
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');  
INSERT INTO siparisler VALUES(44, 104, '2020-04-20');  
INSERT INTO siparisler VALUES(55, 105, '2020-04-21');

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun
select * from siparisler;
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
-- the syntax is like: first the table then dot then field
from sirketler inner join siparisler 
ON sirketler.sirket_id = siparisler.sirket_id; -- ON sartlar icin kullanilir


/*
NOTE:
1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
*/

--LEFT JOIN
select * from siparisler;
-- sirkette olup, sipariste olmayan
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler left join siparisler 
ON sirketler.sirket_id = siparisler.sirket_id;

-- sipariste olup, sirkette olmayan
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from siparisler left join sirketler 
ON sirketler.sirket_id = siparisler.sirket_id;

--RIGHT JOIN
-- sipariste olup, sirkette olmayan
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from sirketler right join siparisler 
ON sirketler.sirket_id = siparisler.sirket_id;

-- sirkette olup, sipariste olmayan
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from siparisler right join sirketler 
ON sirketler.sirket_id = siparisler.sirket_id;

--FULL JOIN
select sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
from siparisler full join sirketler 
ON sirketler.sirket_id = siparisler.sirket_id;

--SELF JOIN

CREATE TABLE personel5  (
id int,
isim varchar(20),  
title varchar(60),  
  yonetici_id int
);
INSERT INTO personel5 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel5 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel5 VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personel5 VALUES(4, 'Fatma Can', 'CEO', 5);

-- her personelin yanina yonetici ismini yazdiran bir tablo olusturun
select * from personel5;
select p1.isim as personal_isim,p2.isim as yonetici_isim
from personel5 p1 join personel5 p2
ON p1.yonetici_id = p2.id;

-- LIKE Condition
-- ismi v ile baslayan personeli listeleyiniz
select * from personel5;
select * from personel5 where isim like 'V%';

-- ismin sonu n ile biten personelin tum bilgilerini listeleyiniz
select * from personel5 where isim like '%n';

-- isminin icinde tm olan personelin tum bilgilerini listeleyiniz
select * from personel5 where isim like '%tm%';










