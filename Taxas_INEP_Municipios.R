library("tidyverse")
library("dplyr")
library("readxl")
library("openxlsx")


#funcao para pegar as taxas de todos os anos

taxas_educacao <- function(ano) {
  
  #condicional para os anos
  if(ano=='19'){
    
    #link  
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/tx_rend_municipios_20',ano,'.zip')
    temp <- tempfile()
    temp2 <- tempfile()
  
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
  
    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('/tx_rend_municipios_20',ano,'/tx_rend_municipios_20',ano,'.xlsx')))
  
    #organizando a base para junÃ§Ã£o
    df<-df[-1:-6,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else if (ano=='18') {
  
    #link 
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/TX_REND_MUNICIPIOS_20',ano,'.zip')
    temp <- tempfile()
    temp2 <- tempfile()
  
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
  
    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('/TX_REND_MUNICIPIOS_20',ano,'/TX_REND_MUNICIPIOS_20',ano,'.xlsx')))
    
    #organizando a base para junÃ§Ã£o
    df<-df[-1:-6,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else if (ano=='17'||ano=='16') {
  
    #link
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/TAXA_REND_20',ano,'_MUNICIPIOS.zip')
    temp <- tempfile()
    temp2 <- tempfile()
  
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
  
    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('/TAXA_REND_20',ano,'_MUNICIPIOS/TX_REND_MUNICIPIOS_20',ano,'.xlsx')))
    
    #organizando a base para junÃ§Ã£o
    df<-df[-1:-6,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else if (ano=='15') {
  
    #link
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/taxa_rendimento/tx_rendimento_municipios_20',ano,'.zip')
    temp <- tempfile()
    temp2 <- tempfile()

    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)

    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('/TAXA_REND_20',ano,'_MUNICIPIOS/TX_REND_MUN_20',ano,'.xlsx')))
    
    #organizando a base para junÃ§Ã£o
    df<-df[-1:-6,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else if (ano=='13'||ano=='14') {
    
    #link
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/taxa_rendimento/tx_rendimento_municipios_20',ano,'.zip')
    temp <- tempfile()
    temp2 <- tempfile()
  
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
  
    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('TAXAS RENDIMENTOS MUNICIPIOS 20',ano,'.xlsx')))
    
    #organizando a base para junÃ§Ã£o
    df<-df[-1:-6,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else if (ano=='12') {
    
    #link
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/taxas_rendimento/tx_rendimento_municipios_20',ano,'.zip')
    temp <- tempfile()
    temp2 <- tempfile()
  
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
  
    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('tx_rendimento_municipios_20',ano,'.xlsx')))
    
    #organizando a base para junÃ§Ã£o
    df<-df[-1:-6,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else if (ano=='11') {
    
    #link
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/20',ano,'/indicadores_educacionais/taxa_rendimento/20',ano,'/tx_rendimento_municipios_20',ano,'_2.zip')

    temp <- tempfile()
    temp2 <- tempfile()
  
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
  
    #lendo o arquivo
    df <- read_excel(file.path(temp2, paste0('tx_rendimento_municipios_20',ano,'.xls')))
   
    #organizando a base para junÃ§Ã£o 
    df<-df[-1:-6,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else if (ano=='08'||ano=='09') {
  
    #link
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/2011/indicadores_educacionais/taxa_rendimento/20',ano,'/tx_rendimento_municipios_20',ano,'.zip')
  
    temp <- tempfile()
    temp2 <- tempfile()
  
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
  
    #lendo o arquivo
    df <- read_excel(file.path(temp2, paste0('TX RENDIMENTOS MUNICIPIOS 20',ano,'.xls')))
    
    #organizando a base para junÃ§Ã£o
    df<-df[-1:-6,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else if (ano=='10') {
    
    #link
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/2011/indicadores_educacionais/taxa_rendimento/20',ano,'/tx_rendimento_municipios_20',ano,'.zip')
    
    temp <- tempfile()
    temp2 <- tempfile()
    
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
    
    #lendo o arquivo
    df <- read_excel(file.path(temp2, paste0('TX RENDIMENTO MUNICIPIOS 20',ano,'.xls')))
    
    #organizando a base para junÃ§Ã£o
    df<-df[-1:-6,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
    
  } else {
  
    #link
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/2011/indicadores_educacionais/taxa_rendimento/20',ano,'/tx_rendimento_municipios_20',ano,'.zip')
  
    temp <- tempfile()
    temp2 <- tempfile()
  
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
  
    #lendo o arquivo
    df <- read_excel(file.path(temp2, paste0('TX RENDIMENTO MUNICÍPIOS 20',ano,'.xls')))
    
    #organizando a base para junÃ§Ã£o
    df<-df[-1:-6,]
    names(df)<-c(1:61)
    df<-subset(df,`3`=="AL")
  }

  return(df)
}

#selecionando os anos
ano<-c('07','08','09','10','11','12','13','14','15','16','17','18','19')
#ano<-c('15','16','17','18','19')


#criando a base para armazenar os dados
taxas <- data.frame()

#looping para pegar os dados
for (i in ano) {
  df<-taxas_educacao(i)
  taxas<-rbind(taxas,df)
}


#pegando o cabeÃ§alho
ano<-'19'

#link  
url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/tx_rend_municipios_20',ano,'.zip')
temp <- tempfile()
temp2 <- tempfile()

#baixando e deszipando o arquivo
download.file(url, temp, mode = "wb")
unzip(zipfile = temp, exdir = temp2)

#lendo o arquivo
df <- read.xlsx(file.path(temp2, paste0('/tx_rend_municipios_20',ano,'/tx_rend_municipios_20',ano,'.xlsx')))

#pegando as informaÃ§Ãµes para a primeira linha
linha <- data.frame(paste(df[4,],df[6,]))
names(linha)<-"linha"

#arrumando a primeira linha
linha$linha <- gsub(" NA", "", linha$linha)
linha$linha <- gsub("NA ", "", linha$linha)

linha<-as.data.frame(t(linha))

#nomeando a base
names(taxas)<-linha

#selecionando as variaveis desejadas
taxas<-taxas %>% 
  select(`Código do Município`,`Ano`,`Localização`,`Dependência Administrativa`,`Taxa de Aprovação Total`,`Taxa de Reprovação Total`,`Taxa de Abandono Total`)


#arrumando a base final
taxas$`Taxa de Aprovação Total`<-as.numeric(as.character(taxas$`Taxa de Aprovação Total`))
taxas$`Taxa de Reprovação Total`<-as.numeric(as.character(taxas$`Taxa de Reprovação Total`))
taxas$`Taxa de Abandono Total`<-as.numeric(as.character(taxas$`Taxa de Abandono Total`))

#baixando em csv
write.csv(taxas,"taxas.csv")
