DROP SCHEMA IF EXISTS Delicatessen CASCADE;
CREATE SCHEMA Delicatessen;
SET search_path TO Delicatessen;

CREATE TABLE Cliente (
  telCli        VARCHAR(20)       PRIMARY KEY,
  nomeCli       VARCHAR(100)      NOT NULL
);

CREATE TABLE Produto (
  descProd      VARCHAR(100)      NOT NULL,
  paísOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  tipo          VARCHAR(30)       NOT NULL,
  produção      VARCHAR(20)       NOT NULL CHECK (produção IN ('artesanal', 'industrial')),

  CONSTRAINT PK_PRODUTO PRIMARY KEY (descProd, paísOri, cidOri, regOri)
);

CREATE TABLE Acessório (
  nomeAcess     VARCHAR(50)       PRIMARY KEY,
  função        VARCHAR(100)      NOT NULL
);

CREATE TABLE Queijo (
  descProd      VARCHAR(100)      NOT NULL,
  paísOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  sabor         VARCHAR(30)       NOT NULL,
  maturação     INT               NOT NULL CHECK (maturação >= 0),

  CONSTRAINT PK_QUEIJO PRIMARY KEY (descProd, paísOri, cidOri, regOri),
  CONSTRAINT FK_QUEIJO_PRODUTO FOREIGN KEY (descProd, paísOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paísOri, cidOri, regOri) ON DELETE CASCADE
);

CREATE TABLE Bebida (
  descProd      VARCHAR(100)      NOT NULL,
  paísOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  teor          DECIMAL(4,2)      NOT NULL,

  CONSTRAINT PK_BEBIDA PRIMARY KEY (descProd, paísOri, cidOri, regOri),
  CONSTRAINT FK_BEBIDA_PRODUTO FOREIGN KEY (descProd, paísOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paísOri, cidOri, regOri) ON DELETE CASCADE
);

CREATE TABLE Pedido (
  codPed        INT               PRIMARY KEY,
  data          DATE              NOT NULL,
  telCli        VARCHAR(20),
  
  CONSTRAINT FK_PEDIDO_CLIENTE FOREIGN KEY (telCli) 
    REFERENCES Cliente(telCli) ON DELETE SET NULL
);

CREATE TABLE ItemPedido (
  codPed        INT,
  descProd      VARCHAR(100)      NOT NULL,
  paísOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  quantidade    INT               NOT NULL CHECK (quantidade > 0),
  condição      VARCHAR(50),

  CONSTRAINT PK_ITEM_PEDIDO PRIMARY KEY (codPed, descProd, paísOri, cidOri, regOri),
  CONSTRAINT FK_ITEM_PEDIDO_MAPA FOREIGN KEY (codPed)
    REFERENCES Pedido(codPed) ON DELETE CASCADE,
  CONSTRAINT FK_ITEM_PEDIDO_PROD FOREIGN KEY (descProd, paísOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paísOri, cidOri, regOri)
);

CREATE TABLE Preparação (
  descProd      VARCHAR(100)      NOT NULL,
  paísOri       VARCHAR(50)       NOT NULL,
  cidOri        VARCHAR(50)       NOT NULL,
  regOri        VARCHAR(50)       NOT NULL,
  nomeAcess     VARCHAR(50)       NOT NULL,

  CONSTRAINT PK_PREPARACAO PRIMARY KEY (descProd, paísOri, cidOri, regOri, nomeAcess),
  CONSTRAINT FK_PREPARACAO_PROD FOREIGN KEY (descProd, paísOri, cidOri, regOri) 
    REFERENCES Produto(descProd, paísOri, cidOri, regOri) ON DELETE CASCADE,
  CONSTRAINT FK_PREPARACAO_ACESS FOREIGN KEY (nomeAcess)
    REFERENCES Acessório(nomeAcess) ON DELETE CASCADE
);