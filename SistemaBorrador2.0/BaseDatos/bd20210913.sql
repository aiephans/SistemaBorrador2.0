USE [SistemaBorrador2Db]
GO
/****** Object:  Table [dbo].[roles]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_roles] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 13-09-2021 21:51:25 ******/
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
SET IDENTITY_INSERT [dbo].[roles] ON 
GO
INSERT [dbo].[roles] ([id], [nombre]) VALUES (1, N'Administrador')
GO
INSERT [dbo].[roles] ([id], [nombre]) VALUES (2, N'Supervisor')
GO
INSERT [dbo].[roles] ([id], [nombre]) VALUES (3, N'Encargado de ventas')
GO
SET IDENTITY_INSERT [dbo].[roles] OFF
GO
SET IDENTITY_INSERT [dbo].[usuarios] ON 
GO
INSERT [dbo].[usuarios] ([id], [nombreUsuario], [nombres], [apellidos], [rolId], [password]) VALUES (1, N'admin', N'Hans', N'Lopez', 1, 0x02000000CC4CD184C7AD7C18BDFC5268DB6C272FE03EA5F8CFD3C4391BB13C69FC22C970562BD90ACDEDC0989DE23A048B9E0B0D)
GO
SET IDENTITY_INSERT [dbo].[usuarios] OFF
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD  CONSTRAINT [FK_usuarios_roles] FOREIGN KEY([rolId])
REFERENCES [dbo].[roles] ([id])
GO
ALTER TABLE [dbo].[usuarios] CHECK CONSTRAINT [FK_usuarios_roles]
GO
/****** Object:  StoredProcedure [dbo].[sp_actualizar_rol]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_actualizar_rol]
@id int,
@nombre varchar(50)
as
update roles set nombre = @nombre
where id=@id
GO
/****** Object:  StoredProcedure [dbo].[sp_actualizar_usuario]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_actualizar_usuario] 
@id int,
@nombres varchar(50),
@apellidos varchar(50),
@rolId int
as
update usuarios
set nombres = @nombres, apellidos = @apellidos, rolId = @rolId
where id = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_buscar_rol_por_id]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_buscar_rol_por_id]
@id int
as
select id,nombre from roles
where id=@id
GO
/****** Object:  StoredProcedure [dbo].[sp_cambio_password]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_cambio_password]
@id int,
@password varchar(50)
as
update usuarios set password = ENCRYPTBYPASSPHRASE('sistemaborrador!!',@password)
where id = @id
GO
/****** Object:  StoredProcedure [dbo].[sp_check_nombre_usuario]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_check_nombre_usuario] @nombreUsuario VARCHAR(50)
AS
SELECT COUNT(*) FROM usuarios
WHERE nombreUsuario=@nombreUsuario
GO
/****** Object:  StoredProcedure [dbo].[sp_check_usuario]    Script Date: 13-09-2021 21:51:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_eliminar_rol]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_eliminar_rol]
@id int
as
delete roles
where id=@id
GO
/****** Object:  StoredProcedure [dbo].[sp_eliminar_usuario]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_eliminar_usuario]
@id int
as
delete usuarios 
where id=@id
GO
/****** Object:  StoredProcedure [dbo].[sp_insertar_rol]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_insertar_rol]
@nombre varchar(50)
as
insert into roles (nombre)
values(@nombre)
GO
/****** Object:  StoredProcedure [dbo].[sp_insertar_usuario]    Script Date: 13-09-2021 21:51:25 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_obtener_roles]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_obtener_roles]
as
select id,nombre  from roles
GO
/****** Object:  StoredProcedure [dbo].[sp_obtener_usuario_por_id]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_obtener_usuario_por_id] @id int
AS
SELECT * FROM usuarios
WHERE id=@id
GO
/****** Object:  StoredProcedure [dbo].[sp_obtener_usuarios]    Script Date: 13-09-2021 21:51:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_obtener_usuarios]
AS
SELECT Id,nombreUsuario,nombres,apellidos,rolId from usuarios
GO
