-- LIKE Condition
-- ismi v ile baslayan personeli listeleyiniz
select * from personel5;
select * from personel5 where isim like 'V%';

-- ismin sonu n ile biten personelin tum bilgilerini listeleyiniz
select * from personel5 where isim like '%n';

-- isminin icinde tm olan personelin tum bilgilerini listeleyiniz
select * from personel5 where isim like '%tm%';