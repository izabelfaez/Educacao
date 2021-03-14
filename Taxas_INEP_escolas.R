
library("tidyverse")
library("dplyr")
library("readxl")
library("openxlsx")
library("writexl")


#funcao para pegar as taxas de todos os anos

taxas_educacao <- function(ano) {
  
  #condicional para os anos
  if(ano=='19'){
    
    #link  
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/tx_rend_escolas_20',ano,'.zip')
    temp <- tempfile()
    temp2 <- tempfile()
    
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
    
    #lendo o arquivo
    
    df <- read.xlsx(file.path(temp2, paste0('/tx_rend_escolas_20',ano,'/tx_rend_escolas_20',ano,'.xlsx')))
    
    #organizando a base para junção
    df<-df[-1:-7,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else if (ano=='18') {
    
    #link 
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/TX_REND_ESCOLAS_20',ano,'.zip')
    temp <- tempfile()
    temp2 <- tempfile()
    
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
    
    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('/TX_REND_ESCOLAS_20',ano,'/TX_REND_ESCOLAS_20',ano,'.xlsx')))
    
    #organizando a base para junção
    df<-df[-1:-7,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else if (ano=='17'||ano=='16') {
    
    #link
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/TAXA_REND_20',ano,'_ESCOLAS.zip')
    temp <- tempfile()
    temp2 <- tempfile()
    
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
    
    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('/TAXA_REND_20',ano,'_ESCOLAS/TX_REND_ESCOLAS_20',ano,'.xlsx')))
    
    #organizando a base para junção
    df<-df[-1:-7,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else {
    
    #link
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/taxa_rendimento/tx_rendimento_escolas_20',ano,'.zip')
    temp <- tempfile()
    temp2 <- tempfile()
    
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
    
    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('/TAXA_REND_20',ano,'_ESCOLAS/TX_REND_ESCOLAS_20',ano,'.xlsx')))
    
    #organizando a base para junção
    df<-df[-1:-7,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    

  }
  
  return(df)
}

#selecionando os anos
ano<-c('15','16','17','18','19')


#criando a base para armazenar os dados
taxas <- data.frame()

#looping para pegar os dados
for (i in ano) {
  df<-taxas_educacao(i)
  taxas<-rbind(taxas,df)
}


#pegando o cabeçalho
ano<-'19'

#link  
url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/tx_rend_escolas_20',ano,'.zip')
temp <- tempfile()
temp2 <- tempfile()

#baixando e deszipando o arquivo
download.file(url, temp, mode = "wb")
unzip(zipfile = temp, exdir = temp2)

#lendo o arquivo
df <- read.xlsx(file.path(temp2, paste0('/tx_rend_escolas_20',ano,'/tx_rend_escolas_20',ano,'.xlsx')))

#pegando as informações para a primeira linha
linha <- data.frame(t(df[4,]))
names(linha)<-"linha"
linha<- linha %>% fill(linha)

linha1 <- data.frame(paste(df[5,],df[6,]))
names(linha1)<-"linha1"

#arrumando a primeira linha
linha1$linha1 <- gsub(" NA", "", linha1$linha1)
linha1$linha1 <- gsub("NA ", "", linha1$linha1)

linha<-cbind(linha,linha1)

linha<-data.frame(paste(linha[,1],linha[,2]))
names(linha)<-"linha"

linha$linha <- gsub(" NA", "", linha$linha)
linha$linha <- gsub("NA ", "", linha$linha)

linha<-as.data.frame(t(linha))

#nomeando a base
names(taxas)<-linha

#pivot

taxas<- taxas %>% 
  tidyr::pivot_longer(
    cols = 'Taxa de Aprova��o Ensino Fundamental de 8 e 9 anos Total':'Taxa de Abandono N�o-Seriado', 
    names_to = "atributo", 
    values_to = "valor")

taxas$valor <- gsub("--", NA, taxas$valor)

taxas<-na.omit(taxas)

taxas$valor<-as.numeric(as.character(taxas$valor))

setwd('C:/Users/User/Desktop/Drive/Educacao/Painel_Censo_Escolar')

#baixando em csv
write_xlsx(taxas,"taxas.xlsx")
