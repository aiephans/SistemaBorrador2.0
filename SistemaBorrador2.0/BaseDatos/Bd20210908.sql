USE [SistemaBorrador2Db]
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 08-09-2021 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuarios](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombreUsuario] [varchar](50) NOT NULL,
	[nombres] [varchar](50) NOT NULL,
	[apellidos] [varchar](50) NOT NULL,
	[rolId] [int] NOT NULL,
	[password] [varbinary](100) NOT NULL,
 CONSTRAINT [PK_usuarios] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[usuarios] ON 
GO
INSERT [dbo].[usuarios] ([id], [nombreUsuario], [nombres], [apellidos], [rolId], [password]) VALUES (1, N'admin', N'Hans', N'Lopez', 1, 0x02000000CC4CD184C7AD7C18BDFC5268DB6C272FE03EA5F8CFD3C4391BB13C69FC22C970562BD90ACDEDC0989DE23A048B9E0B0D)
GO
INSERT [dbo].[usuarios] ([id], [nombreUsuario], [nombres], [apellidos], [rolId], [password]) VALUES (2, N'jperez', N'Juan', N'Perez', 2, 0x02000000801AD47B68E5FE39DAE46DE9A9C09B33556E053AF9148F41913E12D3FE0D55E69C5982307C99F392CE85CEF9BEEE7D05)
GO
INSERT [dbo].[usuarios] ([id], [nombreUsuario], [nombres], [apellidos], [rolId], [password]) VALUES (1002, N'fmunoz', N'Francisco', N'Muñoz', 3, 0x02000000557BA4136329A5110F4CBCCB4A92142050F4DB150B4A2BCB2DB1A3AC23101747F0252CB31B015DC88372760128F3C2C9)
GO
INSERT [dbo].[usuarios] ([id], [nombreUsuario], [nombres], [apellidos], [rolId], [password]) VALUES (1003, N'apoblete', N'Albert', N'Poblete', 2, 0x0200000087A67EFAF5D391FBA0E4FEE9DCE5E8F1D138DB8A7DD83C7C682E5438B6B759C2A1489A7ADDF22F14F9D4214B0E5A11FD)
GO
INSERT [dbo].[usuarios] ([id], [nombreUsuario], [nombres], [apellidos], [rolId], [password]) VALUES (1004, N'jperezp', N'jose', N'Perez', 2, 0x020000006FADA78498B253D8E5721B86AF8F2F2AE6987FD99E030CB0E5A858D5D81D87942F123ADC46887119D433E3E4F3507B49)
GO
SET IDENTITY_INSERT [dbo].[usuarios] OFF
GO
/****** Object:  StoredProcedure [dbo].[sp_check_nombre_usuario]    Script Date: 08-09-2021 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_check_nombre_usuario] @nombreUsuario VARCHAR(50)
AS
SELECT COUNT(*) FROM usuarios
WHERE nombreUsuario=@nombreUsuario
GO
/****** Object:  StoredProcedure [dbo].[sp_check_usuario]    Script Date: 08-09-2021 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_check_usuario] @nombreUsuario varchar(50),@password varchar(50)
as
select count(*) from usuarios
where nombreUsuario =@nombreUsuario and 
CONVERT(VARCHAR(50), DECRYPTBYPASSPHRASE('sistemaborrador!!',password))=@password
GO
/****** Object:  StoredProcedure [dbo].[sp_insertar_usuario]    Script Date: 08-09-2021 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_insertar_usuario] 
@nombreUsuario VARCHAR(50),@nombres VARCHAR(50),@apellidos VARCHAR(50), @rolId int, @password VARCHAR(50)
AS
insert into usuarios (nombreUsuario,nombres,apellidos,rolId,password)
values
(
@nombreUsuario,
@nombres,
@apellidos,
@rolId,
ENCRYPTBYPASSPHRASE('sistemaborrador!!',@password)
)
GO
/****** Object:  StoredProcedure [dbo].[sp_obtener_usuario_por_id]    Script Date: 08-09-2021 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_obtener_usuario_por_id] @id int
AS
SELECT * FROM usuarios
WHERE id=@id
GO
/****** Object:  StoredProcedure [dbo].[sp_obtener_usuarios]    Script Date: 08-09-2021 11:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_obtener_usuarios]
AS
SELECT Id,nombreUsuario,nombres,apellidos,rolId from usuarios
GO
