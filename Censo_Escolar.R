#NECESSARIO BAIXAR OS DADOS DO CENSO ESCOLAR NO COMPUTADOR PRIMEIRAMENTE
#SALVAR COM UM NOME PADRAO PARA IDENTIFICAR OS ANOS
#AQUI ESTOU PEGANDO OS DADOS DE ALAGOAS --> UF 27 DA PLANILHA MATRICULAS NORDESTE

#ESSE SCRIPT UTILIZA OS DADOS DE MATRICULA - CALCULA QUANTIDADE DE MATRÍCULAS POR MUNICÍPIO, LOCALIZAÇÃO, DEPENDÊNCIA E ETAPA DE ENSINO DE 2015 A 2020#

library("dplyr")
library("data.table")
library("dplyr")
library("xlsx")
library("writexl")

#Selecionando Alagoas
f<-function(x,pos) {
  dplyr::filter(x, CO_UF== 27)
}

#escolhendo os anos
ano <- c('15','16','17','18','19','20')

#criando df para armazenar os dados
matriculas <- data.frame()

#looping para pegar os anos
for(i in ano){
  
  #lendo a base - somente o escolhido na funcao
  df<-readr::read_delim_chunked(
    paste0("MATRICULA_NORDESTE",i,".csv"),
    readr::DataFrameCallback$new(f),
    chunk_size = 1000,
    delim = "|")
  
  #selecionando variaveis
  df<-df %>%
    select(ID_MATRICULA,CO_ENTIDADE,NU_IDADE,TP_SEXO,TP_COR_RACA,CO_MUNICIPIO,TP_DEPENDENCIA,TP_ETAPA_ENSINO,TP_LOCALIZACAO)
  
  #calculando matriculas por municipio e localizacao
  df1<- df %>%
    group_by(CO_ENTIDADE,CO_MUNICIPIO,TP_LOCALIZACAO,TP_DEPENDENCIA,TP_ETAPA_ENSINO) %>%
    summarise(n())
  
  df1$ano<-i
  
  #unindo as bases
  matriculas <- rbind(matriculas, df1)
  
}

rm(df,df1,ano,i)  

write_xlsx(matriculas,"matricula_escolas.xlsx")
