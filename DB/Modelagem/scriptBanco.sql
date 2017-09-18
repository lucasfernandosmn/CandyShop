USE [master]
GO
/****** Object:  Database [CandyShop]    Script Date: 18/09/2017 10:08:18 ******/
CREATE DATABASE [CandyShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CandyShop', FILENAME = N'C:\Users\user\CandyShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CandyShop_log', FILENAME = N'C:\Users\user\CandyShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CandyShop] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CandyShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CandyShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CandyShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CandyShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CandyShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CandyShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [CandyShop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CandyShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CandyShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CandyShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CandyShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CandyShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CandyShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CandyShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CandyShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CandyShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CandyShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CandyShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CandyShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CandyShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CandyShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CandyShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CandyShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CandyShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CandyShop] SET  MULTI_USER 
GO
ALTER DATABASE [CandyShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CandyShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CandyShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CandyShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CandyShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CandyShop] SET QUERY_STORE = OFF
GO
USE [CandyShop]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [CandyShop]
GO
/****** Object:  Table [dbo].[Compra]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compra](
	[IdCompra] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioCompra] [varchar](14) NULL,
	[DataCompra] [datetime] NULL,
 CONSTRAINT [PK_IdCompra] PRIMARY KEY CLUSTERED 
(
	[IdCompra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompraProduto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompraProduto](
	[IdProduto] [int] NULL,
	[IdCompra] [int] NULL,
	[QtdeProduto] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pagamento]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pagamento](
	[IdPagamento] [int] IDENTITY(1,1) NOT NULL,
	[Cpf] [varchar](14) NULL,
	[DataPagamento] [datetime] NULL,
	[ValorPagamento] [decimal](18, 0) NULL,
 CONSTRAINT [PK_IdPagamento] PRIMARY KEY CLUSTERED 
(
	[IdPagamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produto](
	[IdProduto] [int] IDENTITY(1,1) NOT NULL,
	[NomeProduto] [varchar](40) NULL,
	[PrecoProduto] [decimal](18, 2) NULL,
	[QtdeProduto] [int] NULL,
	[Ativo] [varchar](1) NULL,
	[Categoria] [varchar](50) NULL,
 CONSTRAINT [PK_Produto] PRIMARY KEY CLUSTERED 
(
	[IdProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[Cpf] [varchar](14) NOT NULL,
	[NomeUsuario] [varchar](50) NULL,
	[SenhaUsuario] [varchar](12) NULL,
	[SaldoUsuario] [decimal](18, 2) NULL,
	[Ativo] [varchar](1) NULL,
 CONSTRAINT [PK_Cpf] PRIMARY KEY CLUSTERED 
(
	[Cpf] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Compra]  WITH CHECK ADD  CONSTRAINT [FK_UsuarioCompra] FOREIGN KEY([UsuarioCompra])
REFERENCES [dbo].[Usuario] ([Cpf])
GO
ALTER TABLE [dbo].[Compra] CHECK CONSTRAINT [FK_UsuarioCompra]
GO
ALTER TABLE [dbo].[CompraProduto]  WITH CHECK ADD  CONSTRAINT [FK_IdCompraProduto] FOREIGN KEY([IdProduto])
REFERENCES [dbo].[Produto] ([IdProduto])
GO
ALTER TABLE [dbo].[CompraProduto] CHECK CONSTRAINT [FK_IdCompraProduto]
GO
ALTER TABLE [dbo].[CompraProduto]  WITH CHECK ADD  CONSTRAINT [FK_IdCompraProduto2] FOREIGN KEY([IdCompra])
REFERENCES [dbo].[Compra] ([IdCompra])
GO
ALTER TABLE [dbo].[CompraProduto] CHECK CONSTRAINT [FK_IdCompraProduto2]
GO
ALTER TABLE [dbo].[Pagamento]  WITH CHECK ADD  CONSTRAINT [FK_Cpf] FOREIGN KEY([Cpf])
REFERENCES [dbo].[Usuario] ([Cpf])
GO
ALTER TABLE [dbo].[Pagamento] CHECK CONSTRAINT [FK_Cpf]
GO
/****** Object:  StoredProcedure [dbo].[GCS_DelCompra]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--temporariamente inutilizada
CREATE PROCEDURE [dbo].[GCS_DelCompra]
	@IdCompra INT

	AS

	/*
	Documentação
	Arquivo Fonte.....: Compra.sql
	Objetivo..........: Deletar uma compra
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_DelCompra]

	*/

	BEGIN
	
		DELETE FROM [dbo].[Compra] WHERE
			IdCompra = @IdCompra
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_DelCompraProduto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_DelCompraProduto]
	@IdCompra int,
	@IdProduto int

	AS

	/*
	Documentação
	Arquivo Fonte.....: CompraProduto.sql
	Objetivo..........: Excluir um item da compra
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_DelCompraProduto]

	*/

	BEGIN
		DELETE CompraProduto WHERE
			IdCompra = @IdCompra and IdProduto = @IdProduto		
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_DelPagamento]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_DelPagamento]
	@IdPagamento int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Pagamento.sql
	Objetivo..........: Deletar um pagamento
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_DelPagamento]

	*/

	BEGIN
	
		DELETE [dbo].[Pagamento] 
			WHERE IdPagamento = @IdPagamento

	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_DelProduto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_DelProduto]
	@IdProduto int
	AS

	/*
	Documentação
	Arquivo Fonte.....: Produto.sql
	Objetivo..........: Deletar Produtos 
	Autor.............: SMN - João Guilherme
 	Data..............: 01/01/2017
	Ex................: EXEC [dbo].[GKSSP_DelProduto]

	*/

	BEGIN
	DELETE [dbo].[Produto]
		WHERE IdProduto = @IdProduto
		IF @@ERROR <> 0
					RETURN 1
		RETURN 0		
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_DelUsuario]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_DelUsuario]
	@Cpf varchar(14)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Deletar cadatro de usuario
	Autor.............: SMN - João Guilherme
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_DelUsuario]

	*/

	BEGIN
		DELETE [dbo].[Usuario] 
			WHERE Cpf = @Cpf
			IF @@ERROR <> 0
				RETURN 1

		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_DesUsuario]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_DesUsuario]
	@Cpf varchar(14)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Deletar cadatro de usuario
	Autor.............: SMN - João Guilherme
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_DelUsuario]

	*/

	BEGIN
		UPDATE [dbo].[Usuario] 
			SET Ativo = 'N'
			WHERE Cpf = @Cpf
			IF @@ERROR <> 0
				RETURN 1

		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_InsCompra]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_InsCompra]
	@UsuarioCompra VARCHAR(14),
	@DataCompra DATE

	AS

	/*
	Documentação
	Arquivo Fonte.....: Compra.sql
	Objetivo..........: Inserir uma compra
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_InsCompra] 

	*/

	BEGIN
		INSERT INTO [dbo].[Compra] (UsuarioCompra, DataCompra)
			VALUES(@UsuarioCompra, @DataCompra)	
			
			if @@ERROR <> 0 
				RETURN 1
		RETURN 0	
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_InsCompraProduto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_InsCompraProduto]
	@IdProduto int,
	@IdCompra int,
	@QtdeProduto int

	AS

	/*
	Documentação
	Arquivo Fonte.....: CompraProduto.sql
	Objetivo..........: Inserir um produto e a quantidade dele numa venda.
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_InsCompraProduto]

	*/

	BEGIN	
		INSERT INTO CompraProduto (IdProduto, IdCompra, QtdeProduto)
			VALUES (@IdProduto, @IdCompra, @QtdeProduto)
			
			if @@ERROR <> 0 
				RETURN 1
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_InsPagamento]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_InsPagamento]	
	@Cpf varchar(14),
	@DataPagamento datetime,
	@ValorPagamento decimal

	AS

	/*
	Documentação
	Arquivo Fonte.....: Pagamento.sql
	Objetivo..........: Inserir um pagamento
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/0/2017
	Ex................: EXEC [dbo].[GCS_InsPagamento]

	*/

	BEGIN
		INSERT INTO [dbo].[Pagamento] (Cpf, DataPagamento, ValorPagamento)
			VALUES (@Cpf, @DataPagamento, @ValorPagamento)			
		
		-- Somar o pagamento feito ao saldo do usuario em questão
		UPDATE [dbo].[Usuario] 
			SET SaldoUsuario += @ValorPagamento			
			WHERE Cpf = @Cpf
		
			IF @@ERROR <> 0 
				RETURN 1
		RETURN 0
		
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_InsProduto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_InsProduto]
	@NomeProduto varchar(40),
	@PrecoProduto decimal,
	@QtdeProduto int,
	@Ativo varchar(1),
	@Categoria varchar(50)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Produto.sql
	Objetivo..........: Inserir Produtos
	Autor.............: SMN - João Guilherme
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_InsProduto]

	*/

	BEGIN
	
		INSERT INTO [dbo].[Produto] (NomeProduto,PrecoProduto,QtdeProduto,Ativo,Categoria)
			VALUES (@NomeProduto,@PrecoProduto,@QtdeProduto,@Ativo,@Categoria)

				IF @@ERROR <> 0
					RETURN 1
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_InsUsuario]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_InsUsuario]
	@NomeUsuario varchar(50),
	@SenhaUsuario varchar(12) = 'password',
	@SaldoUsuario decimal(18,2) = 0,
	@CpfUsuario varchar(14),
	@Ativo varchar(1) = 'A'
	AS

	/*
	Documentação
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Inserir Usuarios 
	Autor.............: SMN - João Guilherme
 	Data..............: 06/09/2017
	Ex................: 
	
	BEGIN TRANSACTION
	EXEC [dbo].[GCS_InsUsuario]
		@NomeUsuario = 'Cu',
		@SaldoUsuario = 10,
		@CpfUsuario = '123.123.123-12'
	ROLLBACK TRANSACTION

	Editado Por.......: SMN - Rafael Morais
	Objetivo..........: Adicionar a o campo de cpf na proceure 
	Data..............: 07/09/2017
	
	*/
	
	BEGIN
		INSERT INTO [dbo].[Usuario](Cpf,NomeUsuario,SenhaUsuario,SaldoUsuario,Ativo)
			VALUES (@CpfUsuario,@NomeUsuario,@SenhaUsuario,@SaldoUsuario,@Ativo)		
			
				IF @@ERROR <> 0
					RETURN 1
		RETURN 0	
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisCompra]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisCompra]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Compra.sql
	Objetivo..........: Listar todas as compras feitas 
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_LisCompra]

	Editado Por.......: SMN - João Guilherme
	Objetivo..........: Alterando o select 
	Data..............: 14/09/2017

	*/

	BEGIN
		SELECT	c.IdCompra,
				c.UsuarioCompra ,
				u.NomeUsuario as 'nomeUsuario',
				c.DataCompra 
		 FROM [dbo].[Compra] c WITH(NOLOCK)
		 INNER JOIN Usuario u on u.Cpf = c.UsuarioCompra
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisCompraNomeUsuario]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisCompraNomeUsuario]
	@Nome varchar(50)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Compra.sql
	Objetivo..........: Encontrar as compras que um usuário fez pelo seu nome
	Autor.............: SMN - Lucas Fernando
 	Data..............: 14/09/2017
	Ex................: EXEC [dbo].[GCS_LisCompraNomeUsuario]

	*/

	BEGIN
		SELECT	c.IdCompra,
				c.UsuarioCompra as 'nomeUsuario',
				u.NomeUsuario,
				c.DataCompra 
		 FROM [dbo].[Compra] c WITH(NOLOCK)
		 INNER JOIN Usuario u on u.Cpf = c.UsuarioCompra
		 WHERE u.NomeUsuario = '%' + @Nome + '%' 
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisCompraProduto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisCompraProduto]
	
	AS

	/*
	Documentação
	Arquivo Fonte.....: Lista.sql
	Objetivo..........: Listar produtos de uma compra específica
	Autor.............: SMN - Rafael Morais
 	Data..............: 01/01/2017
	Ex................: EXEC [dbo].[GCS_LisCompraProduto]

	Editado Por.......: SMN - João Guilherme
	Objetivo..........: Alterando o select 
	Data..............: 12/09/2017
	*/

	BEGIN
		SELECT	cp.IdCompra,
				cp.QtdeProduto,
				p.IdProduto,
				p.NomeProduto,
				p.PrecoProduto,
				p.Ativo
		 FROM CompraProduto cp WITH(NOLOCK)
		 INNER JOIN Produto p on p.IdProduto = cp.IdProduto
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisCompraProdutoIdVenda]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisCompraProdutoIdVenda]
	@IdCompra int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Lista.sql
	Objetivo..........: Listar produtos de uma compra específica
	Autor.............: SMN - Rafael Morais
 	Data..............: 01/01/2017
	Ex................: EXEC [dbo].[GCS_LisCompraProduto]

	Editado Por.......: SMN - João Guilherme
	Objetivo..........: Alterando o select 
	Data..............: 12/09/2017
	*/

	BEGIN
		SELECT	cp.IdCompra,
				cp.QtdeProduto,
				p.IdProduto,
				p.NomeProduto,
				p.PrecoProduto,
				p.Ativo
		 FROM CompraProduto cp WITH(NOLOCK)
		 INNER JOIN Produto p on p.IdProduto = cp.IdProduto
		 WHERE cp.IdCompra = @IdCompra
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisCpfCompra]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisCpfCompra]
	@Cpf varchar(14)
	
	AS

	/*
	Documentação
	Arquivo Fonte.....: Compra.sql
	Objetivo..........: Listar as compras feitas por um usuario
	Autor.............: SMN - Rafael Morais
 	Data..............: 07/07/2017
	Ex................: EXEC [dbo].[GCS_LisCpfCompra]

	*/

	BEGIN
	
		SELECT	c.IdCompra,
				c.UsuarioCompra as 'nomeUsuario',
				u.NomeUsuario,
				c.DataCompra 
		 FROM [dbo].[Compra] c WITH(NOLOCK)
		 INNER JOIN Usuario u on u.Cpf = c.UsuarioCompra
		 WHERE c.UsuarioCompra = @Cpf
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisCpfPagamento]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisCpfPagamento]
	@Cpf VARCHAR(14)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Pagamento.sql
	Objetivo..........: Listar os pagamentos de um usuario
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_LisCpfPagamento]

	*/

	BEGIN
	
		SELECT * FROM [dbo].[Pagamento] WITH(NOLOCK)
			WHERE Cpf = @Cpf

	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisPagamento]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisPagamento]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Pagamento.sql
	Objetivo..........: Listar todos os pagamentos feitos por todos usuarios
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_LisPagamento]

	Editado Por.......: SMN - João Guilherme
	Objetivo..........: Alterando o select 
	Data..............: 13/09/2017
	*/

	BEGIN
	
		SELECT IdPagamento,
				Cpf,
				DataPagamento,
				ValorPagamento
				FROM [dbo].[Pagamento] WITH(NOLOCK)
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisProduto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisProduto]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Produto.sql
	Objetivo..........: Listar todos os produtos
	Autor.............: SMN - Rafael Morais
 	Data..............: 07/07/2017
	Ex................: EXEC [dbo].[GCS_LisProduto]

	Editado Por.......: SMN - João Guilherme
	Objetivo..........: Alterando o select 
	Data..............: 12/09/2017
	*/

	BEGIN
	
		SELECT IdProduto,
				NomeProduto,
				PrecoProduto,
				QtdeProduto,
				Ativo,
				Categoria
			 FROM Produto WITH(NOLOCK)
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisProdutoAbaixoValor]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisProdutoAbaixoValor]
	@Valor decimal(18,2)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Produt.sql
	Objetivo..........: Listar os produtos abaixo do valor que será passado âtravés de um parâmetro
	Autor.............: SMN - Lucas Fernando
 	Data..............: 14/09/2017
	Ex................: EXEC [dbo].[GCS_LisProdutoAbaixoValor]

	*/

	BEGIN
	SELECT * 
		FROM Produto
		WHERE PrecoProduto <= @Valor	
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisProdutoAcimaValor]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisProdutoAcimaValor]
	@valor decimal(18,2)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Produto.sql
	Objetivo..........: Listar os produtos que estão acima de um certo valor
	Autor.............: SMN - Lucas Fernando
 	Data..............: 14/09/2017
	Ex................: EXEC [dbo].[GCS_LisProdutoAcimaValor]

	*/

	BEGIN
	SELECT * 
		FROM Produto
		WHERE PrecoProduto >= @valor
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisProdutoCategoria]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisProdutoCategoria]
	@Categoria varchar(50)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Produto.sql
	Objetivo..........: Listar os produtos de acordo com a sua categoria
	Autor.............: SMN - Lucas Fernando
 	Data..............: 14/09/2017
	Ex................: EXEC [dbo].[GCS_LisProdutoCategoria]

	*/

	BEGIN
		SELECT * 
			FROM Produto
			WHERE Categoria like '%' + @Categoria + '@%'
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisProdutoInativo]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisProdutoInativo]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Produto.sql
	Objetivo..........: Listar todos os produtos que estão inativos
	Autor.............: SMN - Lucas Fernando
 	Data..............: 14/09/2017
	Ex................: EXEC [dbo].[GCS_LisProduto]

	*/

	BEGIN
		SELECT IdProduto,
				NomeProduto,
				PrecoProduto,
				QtdeProduto,
				Ativo,
				Categoria
			 FROM Produto WITH(NOLOCK)
			 WHERE Ativo = 'N'
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisProdutoValorCres]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisProdutoValorCres]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Produto.sql
	Objetivo..........: Listar os produtos pela ordem de preço crescente	
	Autor.............: SMN - Lucas Fernando
 	Data..............: 14/09/2017
	Ex................: EXEC [dbo].[GCS_LisProdutoValor]

	*/

	BEGIN
		SELECT * 
			FROM Produto
			ORDER BY PrecoProduto
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisProdutoValorDesc]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_LisProdutoValorDesc]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Produto.sql
	Objetivo..........: Listar os produtos em ordem decrescente de valor
	Autor.............: SMN - Lucas Fernando
 	Data..............: 14/09/2017
	Ex................: EXEC [dbo].[GCS_LisProdutoValorDesc]

	*/

	BEGIN
	SELECT * 
		FROM Produto
		ORDER BY PrecoProduto desc
END
GO
/****** Object:  StoredProcedure [dbo].[GCS_LisUsuario]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	
CREATE PROCEDURE [dbo].[GCS_LisUsuario]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Listar todos os usuario
	Autor.............: SMN - Rafael Morais
 	Data..............: 07/07/2017
	Ex................: EXEC [dbo].[GCS_LisUsuario]

	Editado Por.......: SMN - João Guilherme
	Objetivo..........: Alterando o select 
	Data..............: 12/09/2017
	*/

	BEGIN
		SELECT	Cpf,
				SenhaUsuario,
				SaldoUsuario,
				NomeUsuario,
				Ativo
				 FROM [dbo].[Usuario]
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_SelCompra]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_SelCompra]
	@IdCompra int
	
	AS

	/*
	Documentação
	Arquivo Fonte.....: Compra.sql
	Objetivo..........: Selecionar uma compra
	Autor.............: SMN - Rafael Morais
 	Data..............: 07/07/2017
	Ex................: EXEC [dbo].[GCS_SelCompra]

	*/

	BEGIN
		SELECT TOP 1 1 
		 FROM [dbo].[Compra] WITH(NOLOCK)
		 WHERE IdCompra = @IdCompra
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_SelPagamento]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_SelPagamento]
	@IdPagamento int

	AS

	/*
	Documentação
	Arquivo Fonte.....: Pagamento.sql
	Objetivo..........: Selecionar um pagamento
	Autor.............: SMN - Rafael Morais
 	Data..............: 07/07/2017
	Ex................: EXEC [dbo].[GCS_SelPagamento]

	*/

	BEGIN
	
		SELECT * FROM [dbo].[Pagamento]	WITH(NOLOCK)
			WHERE IdPagamento = @IdPagamento

	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_SelProduto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_SelProduto]
	@NomeProduto VARCHAR(50)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Produto.sql
	Objetivo..........: Selecionar Produtos
	Autor.............: SMN - João Guilherme
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_SelProduto]

	*/

	BEGIN
		SELECT TOP 1 1
		 FROM [dbo].[Produto] WITH(NOLOCK)
			WHERE NomeProduto like '%' + @NomeProduto + '%'
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_SelUsuario]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_SelUsuario]
	@Cpf varchar(14)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Selecionar Usuarios
	Autor.............: SMN - João Guilherme
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_SelUsuario]

	*/

	BEGIN
		SELECT * FROM [dbo].[Usuario] WITH(NOLOCK)
			WHERE Cpf = @Cpf
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_SelUsuarioSaldo]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_SelUsuarioSaldo]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Selecionar usuarios com saldo negativo
	Autor.............: SMN - João Guilherme
 	Data..............: 14/09/2017
	Ex................: EXEC [dbo].[GCS_SelUsuarioSaldo]

	*/

	BEGIN
		SELECT	Cpf,
				NomeUsuario,
				SaldoUsuario,
				Ativo	
				FROM [dbo].[Usuario]
		WHERE SaldoUsuario < 0
		
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_SelUsuariosDivida]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_SelUsuariosDivida]

	AS

	/*
	Documentação
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Selecionar usuarios com saldo negativo
	Autor.............: SMN - Lucas Fernando
 	Data..............: 05/09/2017
	Ex................: EXEC [dbo].[GCS_SelUsuariosDivida]

	*/

	BEGIN
		SELECT  Cpf,
				SenhaUsuario,
				SaldoUsuario,
				NomeUsuario,
				Ativo
			FROM [dbo].[Usuario]
			WHERE SaldoUsuario < 0
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_UpdCompra]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_UpdCompra]
	@UsuarioCompra VARCHAR(14),
	@IdCompra INT,
	@DataCompra DATE

	AS

	/*
	Documentação
	Arquivo Fonte.....: Compra.sql
	Objetivo..........: Editar uma compra
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_UpdCompra]

	*/

	BEGIN	
		UPDATE [dbo].[Compra] SET 
			UsuarioCompra = @UsuarioCompra,			
			DataCompra = @DataCompra
			WHERE
				IdCompra = @IdCompra
			
			if @@ERROR <> 0 
				RETURN 1
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_UpdCompraProduto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_UpdCompraProduto]
	@IdCompra int,
	@IdProduto int, 
	@QtdeProduto int

	AS

	/*
	Documentação
	Arquivo Fonte.....: ArquivoFonte.sql
	Objetivo..........: Objetivo
	Autor.............: SMN - Rafael Morais
 	Data..............: 01/01/2017
	Ex................: EXEC [dbo].[GCS_UpdCompraProduto]

	*/

	BEGIN
		
		UPDATE [dbo].[CompraProduto] 
			SET IdProduto = @IdProduto,
				QtdeProduto = @QtdeProduto
 			
			WHERE IdCompra = @IdCompra

			if @@ERROR <> 0 
				RETURN 1
		RETURN 0

	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_UpdPagamento]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_UpdPagamento]
	@IdPagamento int,	
	@DataPagamento datetime,
	@ValorPagamento decimal

	AS

	/*
	Documentação
	Arquivo Fonte.....: Pagamento.sql
	Objetivo..........: Editar um pagamento
	Autor.............: SMN - Rafael Morais
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_UpdPagamento]

	*/

	BEGIN
	
		UPDATE [dbo].[Pagamento] 
			SET	DataPagamento = @DataPagamento,
				ValorPagamento = @ValorPagamento		
				WHERE IdPagamento = @IdPagamento
			
			IF @@ERROR <> 0 
				RETURN 1
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_UpdProduto]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_UpdProduto]
	@IdProduto int,
	@NomeProduto varchar(40),
	@PrecoProduto decimal,
	@QtdeProduto int,
	@Ativo varchar(1),
	@Categoria varchar(50)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Produto.sql
	Objetivo..........: Editar Poodutos
	Autor.............: SMN - João Guilherme
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_UpdProduto]

	*/

	BEGIN
		UPDATE [dbo].[Produto]
		SET	NomeProduto = @NomeProduto,
			PrecoProduto = @PrecoProduto,
			QtdeProduto = @QtdeProduto,
			Ativo = @Ativo,
			Categoria = @Categoria
		WHERE IdProduto = @IdProduto

		IF @@ERROR <> 0
					RETURN 1
		RETURN 0
	END
GO
/****** Object:  StoredProcedure [dbo].[GCS_UpdUsuario]    Script Date: 18/09/2017 10:08:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GCS_UpdUsuario]
	@Cpf varchar(14),
	@NomeUsuario varchar(50),
	@SenhaUsuario varchar(12),
	@SaldoUsuario decimal,
	@Ativo varchar(1)
	AS

	/*
	Documentação
	Arquivo Fonte.....: Usuario.sql
	Objetivo..........: Editar informaçoes do usuario
	Autor.............: SMN - João Guilherme
 	Data..............: 06/09/2017
	Ex................: EXEC [dbo].[GCS_UpdUsuario]

	*/

	BEGIN
	
		UPDATE [dbo].[Usuario]
			SET NomeUsuario = @NomeUsuario,
				SenhaUsuario = @SenhaUsuario,
				SaldoUsuario = @SaldoUsuario,
				Ativo = @Ativo
				WHERE Cpf = @Cpf

				IF @@ERROR <> 0 
					RETURN 1

			RETURN 0
	END
GO
USE [master]
GO
ALTER DATABASE [CandyShop] SET  READ_WRITE 
GO
