
--hastalar tablosundnan kimlik nosu 12345678901 ismi listeleyiniz
select * from hastalar;
select isim from hastalar where kimlik_no = '12345678901'

--hastaneler tablosundaki 'H104' bolum_id kodlu hastanenin ismi ile
select * from hastaneler;
select isim from hastaneler where id = 'H104'

-- bolumler tablosundaki 'DHL' bolum_id kodlu bolum_adi ile
select * from bolumler;
select bolum_adi from  bolumler where bolum_id = 'DHL'

--hastalar tablosundaki 'Ali Can' isimli hastanın teshis bilgisi ile
select * from hastalar;
select teshis from hastalar where isim = 'Ali Can'

--hastalar tablosundaki 'Ali Can' isimli hastanın kimlik_no kodu ile
select * from hastalar;
select kimlik_no from hastalar where isim = 'Ali Can'
