library("tidyverse")
library("dplyr")
library("readxl")
library("openxlsx")
library("writexl")

#funcao para pegar as taxas de todos os anos

taxas_educacao <- function(ano) {
  
  #condicional para os anos
  if(ano!='15'){
    
    #link  
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/TDI_20',ano,'_ESCOLAS.zip')
    temp <- tempfile()
    temp2 <- tempfile()
    
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
    
    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('/TDI_20',ano,'_ESCOLAS/TDI_ESCOLAS_20',ano,'.xlsx')))
    
    #organizando a base para junÃ§Ã£o
    df<-df[-1:-6,]
    names(df)<-c(1:26)
    df<-subset(df,`3`=="AL")
    
  } else {
    
    #link 
    url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/distorcao_idade_serie/tdi_escolas_20',ano,'.zip')
    temp <- tempfile()
    temp2 <- tempfile()
    
    #baixando e deszipando o arquivo
    download.file(url, temp, mode = "wb")
    unzip(zipfile = temp, exdir = temp2)
    
    #lendo o arquivo
    df <- read.xlsx(file.path(temp2, paste0('/TDI_20',ano,'_ESCOLAS/TDI_ESCOLAS_20',ano,'.xlsx')))
    
    #organizando a base para junÃ§Ã£
    df<-df[-1:-6,]
    names(df)<-c(1:27)
    df$`3`<-NULL
    names(df)<-c(1:26)
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

#pegando o cabeÃ§alho
ano<-'19'

#link  
url<-paste0('http://download.inep.gov.br/informacoes_estatisticas/indicadores_educacionais/20',ano,'/TDI_20',ano,'_ESCOLAS.zip')
temp <- tempfile()
temp2 <- tempfile()

#baixando e deszipando o arquivo
download.file(url, temp, mode = "wb")
unzip(zipfile = temp, exdir = temp2)

#lendo o arquivo
df <- read.xlsx(file.path(temp2, paste0('/TDI_20',ano,'_ESCOLAS/TDI_ESCOLAS_20',ano,'.xlsx')))

#pegando as informaÃ§Ãµes para a primeira linha
linha <- data.frame(paste(df[4,],df[5,]))
names(linha)<-"linha"


#arrumando a primeira linha
linha$linha <- gsub(" NA", "", linha$linha)
linha$linha <- gsub("NA ", "", linha$linha)

linha<-as.data.frame(t(linha))

#nomeando a base
names(taxas)<-linha

#pivot
taxas<- taxas %>% 
  tidyr::pivot_longer(
    cols = 'Ensino Fundamental de 8 e 9 anos Total ':' 4ª Série', 
    names_to = "atributo", 
    values_to = "valor")

taxas$valor <- gsub("--", NA, taxas$valor)

taxas<-na.omit(taxas)

taxas$valor<-as.numeric(as.character(taxas$valor))

#baixando em csv
write_xlsx(taxas,"distorcao.xlsx")

