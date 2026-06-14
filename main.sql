DROP SCHEMA IF EXISTS Delicatessen CASCADE;
CREATE SCHEMA Delicatessen;
SET search_path TO Delicatessen;

CREATE TABLE Cliente (
	telCli        VARCHAR(20)     NOT NULL,
	nomeCli       VARCHAR(100)    NOT NULL,

	CONSTRAINT PK_CLIENTE PRIMARY KEY (telCli, nomeCli)
);

CREATE TABLE Origem (
	paisOri       VARCHAR(50)     NOT NULL,
	cidOri        VARCHAR(50)     NOT NULL,
	regOri        VARCHAR(50)     NOT NULL,
	
	CONSTRAINT PK_ORIGEM PRIMARY KEY (paisOri, cidOri, regOri)
);

CREATE TABLE Produto (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  tipo          VARCHAR(30)       NOT NULL,
  producao      VARCHAR(20)       NOT NULL CHECK (producao IN ('artesanal', 'industrial')),

  CONSTRAINT PK_PRODUTO PRIMARY KEY (descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_PRODUTO FOREIGN KEY (paisOri, cidOri, regOri)
  	REFERENCES Origem(paisOri, cidOri, regOri)
);

CREATE TABLE Queijo (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  sabor         VARCHAR(30)       NOT NULL,
  textura       VARCHAR(30)       NOT NULL,
  maturacao     INT               NOT NULL CHECK (maturacao >= 0),

  CONSTRAINT PK_QUEIJO PRIMARY KEY (descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_QUEIJO_PRODUTO FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE
);

CREATE TABLE Paes (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  formato		VARCHAR(50)		  NOT NULL,
  
  CONSTRAINT PK_PAES PRIMARY KEY (descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_PAES_PRODUTO FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE
);

CREATE TABLE Bebida (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  teor          DECIMAL(4,2)      NOT NULL,
  aroma         VARCHAR(50)       NOT NULL,
  
  CONSTRAINT PK_BEBIDA PRIMARY KEY (descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_BEBIDA_PRODUTO FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE
);

CREATE TABLE Infusao (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  
  CONSTRAINT PK_INFUSAO PRIMARY KEY (descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_INFUSAO_PRODUTO FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE
);

CREATE TABLE Pedido (
  codPed        INT               PRIMARY KEY,
  data          DATE              NOT NULL,
  condicao      VARCHAR(100),
  telCli        VARCHAR(20),
  nomeCli       VARCHAR(100),

  CONSTRAINT FK_PEDIDO_CLIENTE FOREIGN KEY (telCli, nomeCli) 
    REFERENCES Cliente(telCli, nomeCli) ON DELETE SET NULL
);

CREATE TABLE ItemPedido (
  codPed        INT,
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  quantidade    INT               NOT NULL CHECK (quantidade > 0),
  preferencias	VARCHAR(100),		  
  condicao      VARCHAR(50),

  CONSTRAINT PK_ITEM_PEDIDO PRIMARY KEY (codPed, descProd, paisOri, cidOri, regOri),
  CONSTRAINT FK_ITEM_PEDIDO_MAPA FOREIGN KEY (codPed)
    REFERENCES Pedido(codPed) ON DELETE CASCADE,
  CONSTRAINT FK_ITEM_PEDIDO_PROD FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paisOri, cidOri, regOri)
);

CREATE TABLE Item (
  valItem 		DATE 		  	  NOT NULL, 
  numItem		INT				  NOT NULL,

  CONSTRAINT PK_ITEM PRIMARY KEY (valItem, numItem)
);

CREATE TABLE ItemVenda(
  valItem		DATE			  NOT NULL,
  numItem		INT				  NOT NULL,
  descProd		VARCHAR(100)	  NOT NULL,
  paisOri		VARCHAR(50)		  NOT NULL,
  cidOri		VARCHAR(50)		  NOT NULL,
  regOri		VARCHAR(50)		  NOT NULL,

  CONSTRAINT PK_ITEM_VENDA PRIMARY KEY (valItem, numItem),
  -- Item
  CONSTRAINT FK_ITEM_VENDA_ITEM FOREIGN KEY (valItem, numItem)
  	REFERENCES Item(valItem, numItem),
-- Produto
  CONSTRAINT FK_ITEM_VENDA_PRODUTO FOREIGN KEY (descProd, paisOri, cidOri, regOri)
  	REFERENCES Produto(descProd, paisOri, cidOri, regOri)
);

CREATE TABLE ItemPreparado(
  valItem		DATE			  NOT NULL,
  numItem		INT				  NOT NULL,
  codPed		INT				  NOT NULL,
  descProd 		VARCHAR(100)	  NOT NULL,
  paisOri		VARCHAR(50)		  NOT NULL,
  cidOri		VARCHAR(50)		  NOT NULL,
  regOri		VARCHAR(50)		  NOT NULL,
  data		    DATE			  NOT NULL,
  horario       TIME		      NOT NULL,
	
  CONSTRAINT PK_ITEM_PREPARADO PRIMARY KEY (valItem, numItem),
-- Item
  CONSTRAINT FK_ITEM_PREPARADO_ITEM FOREIGN KEY (valItem, numItem)
	REFERENCES Item(valItem, numItem),	
-- ItemPedido
  CONSTRAINT FK_ITEM_PREPARADO_ITEM_PEDIDO FOREIGN KEY (codPed, descProd, paisOri, cidOri, regOri)
  	REFERENCES ItemPedido(codPed, descProd, paisOri, cidOri, regOri)
);

CREATE TABLE Acessorio (
  nomeAcess     VARCHAR(50)       PRIMARY KEY,
  funcao        VARCHAR(100)      NOT NULL
);

CREATE TABLE Preparacao (
  descProd      VARCHAR(100)      NOT NULL,
  paisOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  nomeAcess     VARCHAR(50)       NOT NULL,
  tempo 		INT				  NOT NULL, -- EM MINUTOS
  modo			VARCHAR(50)		  NOT NULL, -- 

  CONSTRAINT PK_PREPARACAO PRIMARY KEY (descProd, paisOri, cidOri, regOri, nomeAcess),
  CONSTRAINT FK_PREPARACAO_INFUSAO FOREIGN KEY (descProd, paisOri, cidOri, regOri) 
    REFERENCES Infusao(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE,
  CONSTRAINT FK_PREPARACAO_ACESS FOREIGN KEY (nomeAcess)
    REFERENCES Acessorio(nomeAcess) ON DELETE CASCADE
);

CREATE TABLE Ornamentacao (
  descProdQ      VARCHAR(100)      NOT NULL,
  paisOriQ       VARCHAR(50)       NOT NULL,
  cidOriQ        VARCHAR(50)       NOT NULL,
  regOriQ        VARCHAR(50)       NOT NULL,
  descProdB      VARCHAR(100)      NOT NULL,
  paisOriB       VARCHAR(50)       NOT NULL,
  cidOriB        VARCHAR(50)       NOT NULL,
  regOriB        VARCHAR(50)       NOT NULL,

  CONSTRAINT PK_ORNAMENTACAO PRIMARY KEY (descProdQ, paisOriQ, cidOriQ, regOriQ, descProdB, paisOriB, cidOriB, regOriB),
  -- QUEIJO
  CONSTRAINT FK_ORNAMENTACAO_QUEIJO FOREIGN KEY (descProdQ, paisOriQ, cidOriQ, regOriQ)
  	REFERENCES Queijo(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE,
  -- BEBIDA
  CONSTRAINT FK_ORNAMENTACAO_BEBIDA FOREIGN KEY (descProdB, paisOriB, cidOriB, regOriB)
  	REFERENCES Bebida(descProd, paisOri, cidOri, regOri) ON DELETE CASCADE
);