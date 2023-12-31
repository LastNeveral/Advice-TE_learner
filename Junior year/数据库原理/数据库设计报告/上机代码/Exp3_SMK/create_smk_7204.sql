IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'smk')
	DROP DATABASE [smk]
GO

CREATE DATABASE [smk]  ON (NAME = N'smk_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Data\smk_Data.MDF' , SIZE = 1, FILEGROWTH = 10%) LOG ON (NAME = N'smk_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\data\smk_Log.LDF' , SIZE = 1, FILEGROWTH = 10%)
 COLLATE Chinese_PRC_CI_AS
GO

exec sp_dboption N'smk', N'autoclose', N'true'
GO

exec sp_dboption N'smk', N'bulkcopy', N'false'
GO

exec sp_dboption N'smk', N'trunc. log', N'true'
GO

exec sp_dboption N'smk', N'torn page detection', N'true'
GO

exec sp_dboption N'smk', N'read only', N'false'
GO

exec sp_dboption N'smk', N'dbo use', N'false'
GO

exec sp_dboption N'smk', N'single', N'false'
GO

exec sp_dboption N'smk', N'autoshrink', N'true'
GO

exec sp_dboption N'smk', N'ANSI null default', N'false'
GO

exec sp_dboption N'smk', N'recursive triggers', N'false'
GO

exec sp_dboption N'smk', N'ANSI nulls', N'false'
GO

exec sp_dboption N'smk', N'concat null yields null', N'false'
GO

exec sp_dboption N'smk', N'cursor close on commit', N'false'
GO

exec sp_dboption N'smk', N'default to local cursor', N'false'
GO

exec sp_dboption N'smk', N'quoted identifier', N'false'
GO

exec sp_dboption N'smk', N'ANSI warnings', N'false'
GO

exec sp_dboption N'smk', N'auto create statistics', N'true'
GO

exec sp_dboption N'smk', N'auto update statistics', N'true'
GO

use [smk]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_sale_customer]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[sale] DROP CONSTRAINT FK_sale_customer
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_sale_product]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[sale] DROP CONSTRAINT FK_sale_product
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sale]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[sale]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[area]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[area]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[customer]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[customer]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[prodsort]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[prodsort]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[product]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[product]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sUser]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[sUser]
GO

CREATE TABLE [dbo].[area] (
	[编号] [nchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[省份] [nchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[城市] [nchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[县] [nchar] (10) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[customer] (
	[顾客编号] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[姓名] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[性别] [char] (2) COLLATE Chinese_PRC_CI_AS NULL ,
	[身份] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[城市] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[县] [char] (10) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[prodsort] (
	[编号] [nchar] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[分类] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[子类] [char] (20) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[product] (
	[商品编号] [char] (10) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[商品名称] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[分类] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[子类] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[单价] [float] NULL ,
	[库存数量] [int] NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[sUser] (
	[用户名] [nchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[密码] [nchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[级别] [nchar] (10) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[sale] (
	[销售编号] [int] IDENTITY (1, 1) NOT NULL ,
	[日期] [datetime] NULL ,
	[顾客编号] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[商品编号] [char] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[数量] [int] NULL ,
	[金额] [float] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[area] WITH NOCHECK ADD 
	CONSTRAINT [PK_area] PRIMARY KEY  CLUSTERED 
	(
		[编号]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[customer] WITH NOCHECK ADD 
	CONSTRAINT [PK_customer] PRIMARY KEY  CLUSTERED 
	(
		[顾客编号]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[prodsort] WITH NOCHECK ADD 
	CONSTRAINT [PK_prodsort] PRIMARY KEY  CLUSTERED 
	(
		[编号]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[product] WITH NOCHECK ADD 
	CONSTRAINT [PK_product] PRIMARY KEY  CLUSTERED 
	(
		[商品编号]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[sale] WITH NOCHECK ADD 
	CONSTRAINT [PK_sale] PRIMARY KEY  CLUSTERED 
	(
		[销售编号]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[sale] ADD 
	CONSTRAINT [FK_sale_customer] FOREIGN KEY 
	(
		[顾客编号]
	) REFERENCES [dbo].[customer] (
		[顾客编号]
	),
	CONSTRAINT [FK_sale_product] FOREIGN KEY 
	(
		[商品编号]
	) REFERENCES [dbo].[product] (
		[商品编号]
	)
GO

