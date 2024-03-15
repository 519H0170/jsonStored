use master
GO

IF DB_ID('DaiLyBanHang') IS NOT NULL
BEGIN
	DROP DATABASE DaiLyBanHang
END
GO

CREATE DATABASE DaiLyBanHang
GO

Use DaiLyBanHang
Go

Create Table Taikhoan(
   Id_Taikhoan   varchar(10)     not null,
   Tendangnhap   varchar(255)     not null,
   Matkhau       varchar(255)     not null,

   HovaTen       nvarchar(255)   not null,
   Sodienthoai   char(12)        not null,
   Diachi        nvarchar(255)   not null,

   Vaitro        nvarchar(255)   not null    -- Đại lý / Kế toán        
)
GO

Create Table HangHoa(
   MaHang         varchar(10)     not null,
   TenMatHang     nvarchar(255)   not null,
   GiaBan         Money           not null,
   GiaNhap        Money           not null,
   DonVi          nvarchar(255)   not null,
   TonKho         int             not null
)
GO

Create Table PhieuDatHang(
   SoPhieu        varchar(10)     not null,
   ID_NguoiDat    varchar(10)     not null,

   NgayDatHang    date            not null,
   NgayNhanHang   date                null,
   PT_ThanhToan   nvarchar(255)   not null,

   Trangthai      nvarchar(50)    not null,  -- On pending / On being shipped / Have arrived
)
GO

Create Table DanhSachDatHang(
   MaDanhSach     varchar(10)     not null,

   MaHangHoa      varchar(10)     not null,
   SoLuong        int             not null
)
GO

Create Table PhieuNhapKho(
   SoPhieu        varchar(10)     not null,
   MaHangHoa      varchar(10)     not null,
   IDNguoiNhap    varchar(10)     not null,

   SoLuong        int             not null,
   NgayNhapKho    date            not null
)
GO

Create Table PhieuXuatKho(
   SoPhieu        varchar(10)     not null,
   SoPhieuDat     varchar(10)     not null Unique,
   IDNguoiXuat    varchar(10)     not null,

   NgayXuatKho    date            not null
)
GO

-- Key
Alter Table Taikhoan
   Add Constraint pk_Taikhoan Primary Key(ID_Taikhoan)

Alter Table HangHoa
   Add Constraint pk_HangHoa Primary Key(MaHang)

Alter Table PhieuDatHang
   Add Constraint pk_PhieuDatHang  Primary Key(SoPhieu),
       Constraint fk_PhieuDatHang1 Foreign Key(ID_NguoiDat) References Taikhoan(Id_Taikhoan)

Alter Table DanhSachDatHang
   Add Constraint pk_DanhSachDatHang  Primary Key(MaDanhSach,MaHangHoa),
       Constraint fk_DanhSachDatHang1 Foreign Key(MaHangHoa) References HangHoa(MaHang),
       Constraint fk_DanhSachDatHang2 Foreign Key(MaDanhSach) References PhieuDatHang(SoPhieu)
	   
Alter Table PhieuNhapKho
   Add Constraint pk_PhieuNhapKho  Primary Key(SoPhieu,MaHangHoa,IDNguoiNhap),
       Constraint fk_PhieuNhapKho1  Foreign Key(MaHangHoa) References HangHoa(MaHang),
       Constraint fk_PhieuNhapKho2  Foreign Key(IDNguoiNhap) References TaiKhoan(ID_Taikhoan)
       

Alter Table PhieuXuatKho
   Add Constraint pk_PhieuXuatKho  Primary Key(SoPhieu),
      Constraint fk_PhieuXuatKho  Foreign Key(SoPhieuDat) References PhieuDatHang(SoPhieu)
Go
--Insert
Insert Into 
   Taikhoan(Id_Taikhoan,Tendangnhap,Matkhau,HovaTen,Sodienthoai,Diachi,Vaitro) 
      Values ('DEA01','daily01','daily123',N'Đại lý Số 1 Việt Nam','0908000001',N'Mặt tiền đường',N'Đại lý'),
             ('DEA02','daily02','daily123',N'Đại lý Số 2 Việt Nam','0908000002',N'Trong ngõ',N'Đại lý'),
             ('DEA03','daily03','daily123',N'Đại lý Số 3 Việt Nam','0908000003',N'Bên bờ sông',N'Đại lý'),
             ('DEA04','daily04','daily123',N'Đại lý Số 4 Việt Nam','0908000004',N'Bờ kè',N'Đại lý'),
             ('DEA05','daily05','daily123',N'Đại lý Số 5 Việt Nam','0908000005',N'Trên núi',N'Đại lý'),
             ('ACC01','ketoan01','ketoan123',N'Kế toán 01','18001009',N'Trụ sở chính',N'Kế toán'),
             ('ACC02','ketoan02','ketoan123',N'Kế toán 02','18001008',N'Trụ sở chính',N'Kế toán')
GO

Insert Into
   HangHoa(MaHang,TenMatHang,GiaBan,GiaNhap,DonVi,TonKho)
      Values ('HH001DEMO1',N'Japanese spirulina',109,90,N'Box',1000),
             ('HH002DEMO1',N'GH Creation EX',668,556,N'Box',1000),
             ('HH003DEMO1',N'Tinh dầu Blackmores Evening',514,428,N'Jar',1000),
             ('HH004DEMO1',N'Shiseido Pure White',560,466,N'Jar',1000),
             ('HH005DEMO1',N'Natrol Biotin : Hair Growing',308,256,N'Box',1000),
			 ('HH001DEMO2',N'Collagen Youtheory Type 1 2 & 3',551,460,N'Bottle',1000),
             ('HH002DEMO2',N'Ginkgo Biloba Healthy',204,170,N'Box',1000),
             ('HH003DEMO2',N'Rohto Vita 40 Nhật',65,50,N'Bottle',1000),
             ('HH004DEMO2',N'Kirkland Vitamin E 400 IU',399,332,N'Box',1000),
             ('HH005DEMO2',N'Ginkgo Biloba 120mg Trunature',465,388,N'Box',1000)
GO

Insert Into
   PhieuDatHang(SoPhieu,ID_NguoiDat,NgayDatHang,NgayNhanHang,PT_ThanhToan,Trangthai)
       Values('DH101','DEA01','01-01-2020',NULL,N'Momo',N'on pending'),('DH102','DEA02','02-14-2020',NULL,N'Momo',N'on pending'),('DH103','DEA03','03-16-2020',NULL,N'Banking',N'on pending'),
             ('DH104','DEA04','04-01-2020',NULL,N'Momo',N'on pending'),('DH105','DEA05','05-01-2020',NULL,N'Banking',N'on pending'),('DH106','DEA01','06-01-2020',NULL,N'Banking',N'on pending'),
             ('DH107','DEA02','07-21-2020',NULL,N'Momo',N'on pending'),('DH108','DEA03','08-02-2020',NULL,N'Banking',N'on pending'),('DH109','DEA04','09-05-2020',NULL,N'Banking',N'on pending'),
             ('DH110','DEA05','10-10-2020',NULL,N'Momo',N'on pending'),('DH111','DEA01','11-01-2020',NULL,N'Momo',N'on pending'),('DH112','DEA02','12-14-2020',NULL,N'Momo',N'on pending'),


             ('DH201','DEA01','01-02-2021',NULL,N'Momo',N'on pending'),('DH202','DEA02','02-11-2021',NULL,N'Momo',N'on pending'),('DH203','DEA03','03-03-2021',NULL,N'Banking',N'on pending'),
             ('DH204','DEA04','04-02-2021',NULL,N'Momo',N'on pending'),('DH205','DEA05','05-02-2021',NULL,N'Banking',N'on pending'),('DH206','DEA01','06-06-2021',NULL,N'Banking',N'on pending'),
             ('DH207','DEA02','07-22-2021',NULL,N'Momo',N'on pending'),('DH208','DEA03','08-08-2021',NULL,N'Banking',N'on pending'),('DH209','DEA04','09-02-2021',NULL,N'Banking',N'on pending'),
             ('DH210','DEA05','10-01-2021',NULL,N'Momo',N'on pending'),('DH211','DEA01','11-10-2021',NULL,N'Momo',N'on pending'),('DH212','DEA02','12-12-2021',NULL,N'Momo',N'on pending'),

             ('DH301','DEA01','01-01-2021',NULL,N'Momo',N'on pending'),('DH302','DEA02','02-01-2021',NULL,N'Momo',N'on pending'),('DH303','DEA03','03-01-2021',NULL,N'Momo',N'on pending')
GO

Insert Into
   DanhSachDatHang(MaDanhSach,MaHangHoa,SoLuong)
       Values('DH101','HH001DEMO1',50),('DH101','HH002DEMO1',40), ('DH101','HH003DEMO1',30),('DH101','HH004DEMO1',20),
             ('DH102','HH001DEMO1',50),('DH102','HH001DEMO2',30), ('DH103','HH002DEMO1',10),('DH103','HH002DEMO2',20),
             ('DH104','HH003DEMO1',30),('DH104','HH003DEMO2',60), ('DH105','HH004DEMO1',100),('DH105','HH004DEMO2',110),
             ('DH106','HH005DEMO1',40),('DH106','HH005DEMO2',10), ('DH107','HH002DEMO1',30),('DH107','HH001DEMO2',20),
             ('DH108','HH003DEMO1',45),('DH108','HH001DEMO2',15), ('DH109','HH002DEMO1',65),('DH109','HH003DEMO2',90),
             ('DH110','HH004DEMO1',70),('DH110','HH005DEMO2',30), ('DH111','HH001DEMO1',100),('DH111','HH003DEMO2',300), ('DH112','HH005DEMO1',70),('DH112','HH005DEMO2',30),

			 ('DH201','HH001DEMO1',10),('DH201','HH002DEMO1',30), ('DH201','HH003DEMO1',20),('DH201','HH004DEMO1',30),
             ('DH202','HH001DEMO1',40),('DH202','HH001DEMO2',40), ('DH203','HH002DEMO1',20),('DH203','HH002DEMO2',10),
             ('DH204','HH003DEMO1',33),('DH204','HH003DEMO2',66), ('DH205','HH004DEMO1',50),('DH205','HH004DEMO2',50),
             ('DH206','HH005DEMO1',30),('DH206','HH005DEMO2',20), ('DH207','HH002DEMO1',20),('DH207','HH001DEMO2',10),
             ('DH208','HH003DEMO1',40),('DH208','HH001DEMO2',10), ('DH209','HH002DEMO1',30),('DH209','HH003DEMO2',50),
             ('DH210','HH004DEMO1',30),('DH210','HH005DEMO2',50), ('DH211','HH001DEMO1',200),('DH211','HH003DEMO2',200), ('DH212','HH005DEMO1',30),('DH212','HH005DEMO2',30),

			 ('DH301','HH001DEMO1',100),('DH301','HH002DEMO1',30), ('DH301','HH003DEMO1',20),('DH301','HH004DEMO1',30),
             ('DH302','HH001DEMO1',40),('DH302','HH001DEMO2',40), ('DH303','HH002DEMO1',20),('DH303','HH003DEMO2',100)
GO
-- Procedure
Create Procedure loginResult(@username varchar(255),@password varchar(255))
As
Begin
   Declare @vaitro nvarchar(255)

   If Exists(Select Top 1 1 From Taikhoan Where Tendangnhap = @username)
   Begin
      If Exists(Select Top 1 1 From Taikhoan Where Tendangnhap = @username and Matkhau = @password)
	  Begin
	     Select @vaitro = Vaitro from Taikhoan  Where Tendangnhap = @username and Matkhau = @password
	     Select N'Hợp lệ'+','+@vaitro
	  End
	  Else
	  Begin
	     Select N'Sai mật khẩu'
	  End
   End
   Else
   Begin
      Select N'Sai tài khoản'
   End
End
-- Exec dbo.loginResult 'daily01','daily123'
GO
--Thêm hàng hóa mới
Create procedure themHangHoa(@tenhanghoa nvarchar(255),@gianhap money,@donvi nvarchar(255))
As
Begin
   Declare @mahanghoa varchar(10)
   Set @mahanghoa = ''

   While @mahanghoa = ''
   Begin
      Declare @tmpid varchar(10)
      Set @tmpid = 'HH'+ Upper( Left( Replace( Newid(),'-',''),8) )

      If Not Exists(Select Top 1 1 From HangHoa Where MaHang = @tmpid)
      Begin
         Set @mahanghoa = @tmpid
      End
   End
   
   Insert Into 
      HangHoa(MaHang,TenMatHang,GiaBan,GiaNhap,DonVi,TonKho)
         Values (@mahanghoa,@tenhanghoa,@gianhap*1.2,@gianhap,@donvi,0)
End
/*
Exec dbo.themHangHoa N'Táo Mỹ',90,N'kg'
Select * From HangHoa
GO
*/
Go
--Điều kiện để xuất kho
Create Procedure checkSoLuongHangHoa(@dondathang varchar(10))
AS
Begin
   Declare @tonkho int
   Declare @mahanghoa varchar(10)
   Declare @trangthai nvarchar(50)
   Declare @result varchar(255)
   Set @result =  ''

   Declare @soluong_can int
   Declare @num_item int
   Set @num_item = 0
   
   Select @num_item = Count(*) From DanhSachDatHang where MaDanhSach = @dondathang

   If @num_item != 0
   Begin
      Declare @i int
      Set @i  = 1
      While @i <= @num_item
      Begin
         Select @mahanghoa = Ds1.MaHangHoa
         From DanhSachDatHang DS1, 
             (Select MaHangHoa, ROW_NUMBER() OVER(ORDER BY DS2.MaHangHoa Asc) AS [row] 
             From DanhSachDatHang DS2 
             Where MaDanhSach = @dondathang) countRow
         Where DS1.MaDanhSach = @dondathang and countRow.[row] = @i and DS1.MaHangHoa = countRow.MaHangHoa
         Order BY DS1.MaHangHoa Asc
         
         Select @soluong_can = SoLuong From DanhSachDatHang Where MaDanhSach = @dondathang and MaHangHoa = @mahanghoa
         Select @tonkho = Tonkho From HangHoa Where MaHang = @mahanghoa
         
         If(@tonkho<@soluong_can)
         Begin
            Declare @tmp varchar(255);
            Select @tmp = Cast((@soluong_can-@tonkho) as varchar(255))
            If(@result='')
            Begin
               Set @result =  'Not Enough:'+ @mahanghoa +'-'+ @tmp
            End
            Else
            Begin
               Set @result =  @result+ ','+ @mahanghoa +'-'+ @tmp
            End
         End

         Set  @i = @i + 1
      End
   End
   
   If @result = ''
   Begin
      Set @result = 'Enough'
   End

   Select @result
End
-- Exec dbo.checkSoLuongHangHoa 'DH001'
Go

--Thêm đơn hàng mới
Create Procedure themPhieuDatHang(@manguoidat varchar(10),@ptthanhtoan nvarchar(255))
As
Begin
   Declare @sophieu varchar(10)
   Set @sophieu = ''

   While @sophieu = ''
   Begin
      Declare @tmpid varchar(10)
      Set @tmpid = 'DH'+ Upper( Left( Replace( Newid(),'-',''),8) )

      If Not Exists(Select Top 1 1 From PhieuDatHang Where SoPhieu = @tmpid)
      Begin
         Set @sophieu = @tmpid
      End
   End

   Insert Into
      PhieuDatHang(SoPhieu,ID_NguoiDat,NgayDatHang,PT_ThanhToan,Trangthai,NgayNhanHang)
         Values(@sophieu,@manguoidat,GETDATE(),@ptthanhtoan,N'On pending',NULL)

   Select @sophieu
End
-- Exec dbo.themPhieuDatHang 'DEA02',N'Banking'
GO

-- Tạo danh sách hàng hóa cho đơn hàng.
Create Procedure themDanhSachDatHang(@madanhsach varchar(10),@mahanghoa varchar(10),@quantity int)
AS
Begin
   Insert into DanhSachDatHang Values (@madanhsach,@mahanghoa,@quantity)
End
/*
 Exec dbo.themDanhSachDatHang 'DH002','DRK01',100
*/
Go

--Xuất kho khi còn đủ hàng trong kho
Create procedure themPhieuXuatKho(@dondathang varchar(10),@idketoan varchar(10),@ngayxuatkho date)
As
Begin
   Declare @sophieu varchar(10)
   Set @sophieu = ''

   While @sophieu = ''
   Begin
      Declare @tmpid varchar(10)
	  Set @tmpid = 'XK'+ Upper( Left( Replace( Newid(),'-',''),8) )

	  If Not Exists(Select Top 1 1 From PhieuXuatKho Where SoPhieu = @tmpid)
	  Begin
	     Set @sophieu = @tmpid
	  End
   End
   
   Declare @mahanghoa varchar(10)
   Declare @trangthai nvarchar(50)
   Declare @result varchar(255)
   Set @result =  ''

   Declare @soluong_can int
   Declare @num_item int
   Set @num_item = 0
   
   Select @num_item = Count(*) From DanhSachDatHang where MaDanhSach = @dondathang

   If @num_item != 0
   Begin
      Declare @i int
      Set @i  = 1
      While @i <= @num_item
      Begin
         Select @mahanghoa = Ds1.MaHangHoa
         From DanhSachDatHang DS1, 
             (Select MaHangHoa, ROW_NUMBER() OVER(ORDER BY DS2.MaHangHoa Asc) AS [row] 
             From DanhSachDatHang DS2 
             Where MaDanhSach = @dondathang) countRow
         Where DS1.MaDanhSach = @dondathang and countRow.[row] = @i and DS1.MaHangHoa = countRow.MaHangHoa
         Order BY DS1.MaHangHoa Asc
         
         Select @soluong_can = SoLuong From DanhSachDatHang Where MaDanhSach = @dondathang and MaHangHoa = @mahanghoa
         
         Update HangHoa Set TonKho = TonKho - @soluong_can Where MaHang = @mahanghoa
         Set @i = @i + 1
      End
   End

   Insert Into
      PhieuXuatKho(SoPhieu,SoPhieuDat,IDNguoiXuat,NgayXuatKho)
      Values(@sophieu,@dondathang,@idketoan,@ngayxuatkho)

   Update PhieuDatHang
      Set Trangthai = N'On being shipped'
      Where SoPhieu = @dondathang
End
/*
Exec dbo.themPhieuXuatKho 'DH002','12-31-2022'
Select* From PhieuXuatKho
Select * From PhieuDatHang Where SoPhieu = 'DH001' 
GO
*/
Go
-- Hàng tới nơi người đặt
Create Procedure nhanduocHang(@dondathang varchar(10))
As
Begin
   Declare @dateDelivery date
   
   Select @dateDelivery = NgayXuatKho From PhieuXuatKho Where SoPhieuDat = @dondathang
   if(GETDATE() >= @dateDelivery)
   Begin
      Update PhieuDatHang Set NgayNhanHang = GETDATE(), Trangthai='Have Arrived' Where SoPhieu = @dondathang     
   End
   Else
   Begin
      Update PhieuDatHang Set NgayNhanHang = DateAdd(day,1,@dateDelivery), Trangthai='Have Arrived' Where SoPhieu = @dondathang
   End
End
/*
Exec dbo.nhanduocHang 'DH002'
Select * From PhieuDatHang Where SoPhieu = 'DH001' 
GO
*/
Go
Create Procedure nhanduocHangV(@dondathang varchar(10))
As
Begin
   Declare @dateDelivery date
   
   Select @dateDelivery = NgayXuatKho From PhieuXuatKho Where SoPhieuDat = @dondathang
   Begin
      Update PhieuDatHang Set NgayNhanHang = DateAdd(day,1,@dateDelivery), Trangthai='Have Arrived' Where SoPhieu = @dondathang
   End
End
GO

-- Nhập kho
Create procedure taoPhieuNhapKho
As
Begin
   Declare @sophieu varchar(10)
   Set @sophieu = ''
   While @sophieu = ''
   Begin
      Declare @tmpid varchar(10)
	  Set @tmpid = 'NK'+ Upper( Left( Replace( Newid(),'-',''),8) )
	  If Not Exists(Select Top 1 1 From PhieuNhapKho Where SoPhieu = @tmpid)
	  Begin
	     Set @sophieu = @tmpid
	  End
   End

   Select @sophieu
End
GO

-- Thêm Phiếu nhập kho tại ngày hôm nay
Create procedure themPhieuNhapKho(@sophieu varchar(10),@mahanghoa varchar(10), @soluong int,@nguoinhap varchar(10))
As
Begin
   Update HangHoa
      Set TonKho = TonKho + @soluong
      Where MaHang = @mahanghoa
   
   Insert Into
      PhieuNhapKho(SoPhieu,MaHangHoa,IDNguoiNhap,SoLuong,NgayNhapKho)
         Values(@sophieu,@mahanghoa,@nguoinhap,@soluong,GETDATE())
End
Go

-- Thêm Phiếu nhập kho với ngày chọn
Create procedure themPhieuNhapKho_Date(@sophieu varchar(10),@mahanghoa varchar(10), @soluong int,@nguoinhap varchar(10),@date date)
As
Begin
   Update HangHoa
      Set TonKho = TonKho + @soluong
      Where MaHang = @mahanghoa
   
   Insert Into
      PhieuNhapKho(SoPhieu,MaHangHoa,IDNguoiNhap,SoLuong,NgayNhapKho)
         Values(@sophieu,@mahanghoa,@nguoinhap,@soluong,@date)
End
Go

-- Tổng Thu khi xuất hàng - Người mua xác nhận thanh toán
Create procedure EmportByMonth(@month int,@year int)
AS
Begin
Select Month(XK.NgayXuatKho)[Month],Year(XK.NgayXuatKho)[Year],Sum(Cast((HH.GiaBan*DS.SoLuong) as bigint))[Income]
From PhieuDatHang DH
left Join DanhSachDatHang DS on DS.MaDanhSach = DH.SoPhieu
left Join HangHoa HH on HH.MaHang = DS.MaHangHoa
left Join PhieuXuatKho XK on XK.SoPhieuDat = DH.SoPhieu
Where DH.Trangthai = 'Have Arrived' and Month(XK.NgayXuatKho)= @month and Year(XK.NgayXuatKho) = @year
Group by Month(XK.NgayXuatKho),Year(XK.NgayXuatKho)
End
Go

-- Tổng chi để nhập hàng
Create procedure ImportByMonth(@month int,@year int)
As
Begin
Select Month(NK.NgayNhapKho)[Month],Year(NK.NgayNhapKho)[Year],Sum(Cast((HH.GiaNhap*NK.SoLuong) as bigint))[Spend]
From PhieuNhapKho NK
Left join HangHoa HH on NK.MaHangHoa = HH.MaHang
Where Month(NK.NgayNhapKho) = @month and Year(NK.NgayNhapKho) = @year
Group by Month(NK.NgayNhapKho),Year(NK.NgayNhapKho)
End
GO
-- Thống kê hàng hóa
Create procedure thongkeHangHoaRaVao(@mahanghoa varchar(10),@month int,@year int)
As
Begin
   Declare @proIn int
   Declare @proOut int

   Select @proOut  = Sum(DS.SoLuong)
   From PhieuDatHang DH
   Left join DanhSachDatHang DS on DS.MaDanhSach = DH.SoPhieu
   Left Join HangHoa HH on HH.MaHang = DS.MaHangHoa
   Left Join PhieuXuatKho XK on XK.SoPhieuDat = DH.SoPhieu 
   Where DH.Trangthai!='on pending' and MONTH(XK.NgayXuatKho) = @month and YEAR(XK.NgayXuatKho) = @year and DS.MaHangHoa = @mahanghoa
   
   Select @proIn  = Sum(NK.SoLuong)
   From PhieuNhapKho NK
   Left Join HangHoa HH on HH.MaHang = NK.MaHangHoa
   Where MONTH(NK.NgayNhapKho) = @month and YEAR(NK.NgayNhapKho) = @year and NK.MaHangHoa = @mahanghoa
   
   If @proIn is null
   Begin
      Set @proIn = 0
   End
   If @proOut is null
   Begin
      Set @proOut = 0
   End
   Select @proOut [Out] ,@proIn [In]
End
GO

--Execute Procedure
Exec dbo.themPhieuXuatKho 'DH101','ACC01','01-30-2020'
Exec dbo.nhanduocHangV 'DH101'
Exec dbo.themPhieuXuatKho 'DH102','ACC01','02-18-2020'
Exec dbo.nhanduocHangV 'DH102'
Exec dbo.themPhieuXuatKho 'DH103','ACC02','03-30-2020'
Exec dbo.nhanduocHangV 'DH103'
Exec dbo.themPhieuXuatKho 'DH104','ACC02','04-11-2020'
Exec dbo.nhanduocHangV 'DH104'
Exec dbo.themPhieuXuatKho 'DH105','ACC01','05-14-2020'
Exec dbo.nhanduocHangV 'DH105'
Exec dbo.themPhieuXuatKho 'DH106','ACC02','06-29-2020'
Exec dbo.nhanduocHangV 'DH106'
Exec dbo.themPhieuXuatKho 'DH107','ACC01','07-30-2020'
Exec dbo.nhanduocHangV 'DH107'
Exec dbo.themPhieuXuatKho 'DH108','ACC01','08-30-2020'
Exec dbo.nhanduocHangV 'DH108'
Exec dbo.themPhieuXuatKho 'DH109','ACC02','09-09-2020'
Exec dbo.nhanduocHangV 'DH109'
Exec dbo.themPhieuXuatKho 'DH110','ACC01','10-20-2020'
Exec dbo.nhanduocHangV 'DH110'
Exec dbo.themPhieuXuatKho 'DH111','ACC01','11-11-2020'
Exec dbo.nhanduocHangV 'DH111'
Exec dbo.themPhieuXuatKho 'DH112','ACC02','12-30-2020'
Exec dbo.nhanduocHangV 'DH112'

Exec dbo.themPhieuXuatKho 'DH201','ACC01','01-11-2021'
Exec dbo.nhanduocHangV 'DH201'
Exec dbo.themPhieuXuatKho 'DH202','ACC01','02-16-2021'
Exec dbo.nhanduocHangV 'DH202'
Exec dbo.themPhieuXuatKho 'DH203','ACC02','03-29-2021'
Exec dbo.nhanduocHangV 'DH203'
Exec dbo.themPhieuXuatKho 'DH204','ACC02','04-14-2021'
Exec dbo.nhanduocHangV 'DH204'
Exec dbo.themPhieuXuatKho 'DH205','ACC01','05-20-2021'
Exec dbo.nhanduocHangV 'DH205'
Exec dbo.themPhieuXuatKho 'DH206','ACC02','06-26-2021'
Exec dbo.nhanduocHangV 'DH206'
Exec dbo.themPhieuXuatKho 'DH207','ACC01','07-29-2021'
Exec dbo.nhanduocHangV 'DH207'
Exec dbo.themPhieuXuatKho 'DH208','ACC01','08-27-2021'
Exec dbo.nhanduocHangV 'DH208'
Exec dbo.themPhieuXuatKho 'DH209','ACC02','09-19-2021'
Exec dbo.nhanduocHangV 'DH209'
Exec dbo.themPhieuXuatKho 'DH210','ACC01','10-21-2021'
Exec dbo.nhanduocHangV 'DH210'
Exec dbo.themPhieuXuatKho 'DH211','ACC01','11-12-2021'
Exec dbo.nhanduocHangV 'DH211'
Exec dbo.themPhieuXuatKho 'DH212','ACC02','12-28-2021'
Exec dbo.nhanduocHangV 'DH212'

Exec dbo.themHangHoa N'The Collagen EXR Shiseido',500,N'Bottle'
Exec dbo.themHangHoa N'Okinawa Fucoidan',1500,N'Bottle'

-- Exec dbo.taoPhieuNhapKho
--Exec dbo.themPhieuNhapKho 'NK0013H01Z','HH004DEMO1',100,'ACC02'
--Exec dbo.themPhieuNhapKho 'NK0013H01Z','HH005DEMO1',100,'ACC02'

Exec dbo.themPhieuNhapKho_Date 'NK101','HH001DEMO1',100,'ACC01','01-01-2020'
Exec dbo.themPhieuNhapKho_Date 'NK101','HH002DEMO1',50,'ACC01','01-01-2020'
Exec dbo.themPhieuNhapKho_Date 'NK102','HH003DEMO1',20,'ACC02','02-02-2020'
Exec dbo.themPhieuNhapKho_Date 'NK103','HH004DEMO1',40,'ACC01','03-06-2020'
Exec dbo.themPhieuNhapKho_Date 'NK104','HH005DEMO1',30,'ACC01','04-01-2020'
Exec dbo.themPhieuNhapKho_Date 'NK105','HH001DEMO2',100,'ACC01','05-11-2020'
Exec dbo.themPhieuNhapKho_Date 'NK106','HH002DEMO2',50,'ACC01','06-22-2020'
Exec dbo.themPhieuNhapKho_Date 'NK107','HH003DEMO2',150,'ACC02','07-24-2020'
Exec dbo.themPhieuNhapKho_Date 'NK108','HH004DEMO2',40,'ACC02','08-14-2020'
Exec dbo.themPhieuNhapKho_Date 'NK109','HH005DEMO2',30,'ACC01','09-07-2020'
Exec dbo.themPhieuNhapKho_Date 'NK110','HH001DEMO1',100,'ACC01','10-15-2020'
Exec dbo.themPhieuNhapKho_Date 'NK111','HH001DEMO2',50,'ACC02','11-27-2020'
Exec dbo.themPhieuNhapKho_Date 'NK112','HH002DEMO1',20,'ACC02','12-09-2020'

Exec dbo.themPhieuNhapKho_Date 'NK201','HH004DEMO2',10,'ACC01','01-03-2021'
Exec dbo.themPhieuNhapKho_Date 'NK202','HH005DEMO1',40,'ACC02','02-07-2021'
Exec dbo.themPhieuNhapKho_Date 'NK203','HH001DEMO2',60,'ACC02','03-05-2021'
Exec dbo.themPhieuNhapKho_Date 'NK204','HH001DEMO1',200,'ACC01','04-08-2021'
Exec dbo.themPhieuNhapKho_Date 'NK205','HH003DEMO2',100,'ACC02','05-11-2021'
Exec dbo.themPhieuNhapKho_Date 'NK206','HH004DEMO1',10,'ACC01','06-01-2021'
Exec dbo.themPhieuNhapKho_Date 'NK207','HH002DEMO2',20,'ACC01','07-17-2021'
Exec dbo.themPhieuNhapKho_Date 'NK208','HH005DEMO1',50,'ACC02','08-08-2021'
Exec dbo.themPhieuNhapKho_Date 'NK209','HH001DEMO2',40,'ACC02','09-02-2021'
Exec dbo.themPhieuNhapKho_Date 'NK210','HH001DEMO1',10,'ACC01','10-01-2021'
Exec dbo.themPhieuNhapKho_Date 'NK211','HH004DEMO2',60,'ACC01','11-11-2021'
Exec dbo.themPhieuNhapKho_Date 'NK212','HH002DEMO1',10,'ACC01','12-09-2021'
Go
/*
--Show all Bill on pending
Select DH.SoPhieu, HH.TenMatHang, HH.GiaBan, HH.DonVi, DS.SoLuong, DH.NgayDatHang
From PhieuDatHang DH
Left join DanhSachDatHang DS on SoPhieu = DS.MaDanhSach
Left join HangHoa HH on HH.MaHang = DS.MaHangHoa
Where DH.Trangthai = 'on pending'
Go

-- Show total price of bill on pending
Select DH.SoPhieu,Cast( (Sum(DS.SoLuong*HH.GiaBan)) as bigint) [Total]
From PhieuDatHang DH
Left join DanhSachDatHang DS on DH.SoPhieu = DS.MaDanhSach
Left join HangHoa HH on HH.MaHang = DS.MaHangHoa
Where DH.Trangthai = 'on pending'
Group by DH.SoPhieu
Go

-- Show item in bill 'billid'
Select DS.MaHangHoa,HH.TenMatHang, HH.GiaBan, HH.DonVi, DS.SoLuong
From PhieuDatHang DH
Left join DanhSachDatHang DS on DH.SoPhieu = DS.MaDanhSach
Left join HangHoa HH on HH.MaHang = DS.MaHangHoa
Where DH.SoPhieu = 'DH101'
Go

-- Show all Bills have Arrived
Select DH.SoPhieu, HH.TenMatHang, HH.GiaBan, HH.DonVi, DS.SoLuong, DH.NgayDatHang,DH.NgayNhanHang
From PhieuDatHang DH
Left join DanhSachDatHang DS on SoPhieu = DS.MaDanhSach
Left join HangHoa HH on HH.MaHang = DS.MaHangHoa
Where DH.Trangthai = 'Have Arrived'
Go

-- Người nhập phiếu xuất kho
Select TK.HovaTen
From PhieuXuatKho XK
Left Join Taikhoan TK on TK.Id_Taikhoan = XK.IDNguoiXuat 
Where SoPhieuDat = 'DH101'
GO

-- Giá trị các đơn đã ghi nhận thanh toán
Select DH.SoPhieu,Cast( (Sum(DS.SoLuong*HH.GiaBan)) as bigint) [Total]
From PhieuDatHang DH
Left join DanhSachDatHang DS on DH.SoPhieu = DS.MaDanhSach
Left join HangHoa HH on HH.MaHang = DS.MaHangHoa
Where DH.Trangthai = 'Have Arrived'
Group by DH.SoPhieu
Go

*/

-- Limit money lenght
-- Select Cast('9223372036854775807' as bigint) -- 2^63 - 1 

--Select * From HangHoa
--Go

--Select * From PhieuDatHang where Trangthai = 'On being shipped'

Select HH.MaHang,HH.TenMatHang,DS.SoLuong
From PhieuXuatKho XK 
Left Join PhieuDatHang DH on DH.SoPhieu  = XK.SoPhieuDat 
Left Join DanhSachDatHang DS on DS.MaDanhSach = DH.SoPhieu
Left Join HangHoa HH on HH.MaHang = DS.MaHangHoa
Where XK.SoPhieu = 'XKB6F30B25'
GO

Select * From PhieuXuatKho