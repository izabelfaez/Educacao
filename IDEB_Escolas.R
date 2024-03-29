library("data.table")
library("dplyr")
library("openxlsx")
library("tidyverse")
library("writexl")



#selecionando os IDEBs desejandos
baixar<-c("anos_iniciais","anos_finais","ensino_medio")

#criando df para armazenar os dados
ideb<-data.frame()

for (i in baixar) {
  
  #url do download
  url <- paste0('http://download.inep.gov.br/educacao_basica/portal_ideb/planilhas_para_download/2019/divulgacao_',i,'_escolas_2019.zip')
  
  temp <- tempfile()
  temp2 <- tempfile()
  
  #baixando e deszipando o arquivo
  download.file(url, temp, mode = "wb",cacheOK = F)
  unzip(zipfile = temp, exdir = temp2)
  
  #lendo o arquivo
  df <- read.xlsx(file.path(temp2, paste0("divulgacao_",i,"_escolas_2019/divulgacao_",i,"_escolas_2019.xlsx")))
  
  #tratamento inicial
  df<-df[-1:-6,]
  names(df) <- df[1,]
  df <- df[-1,]
  
  #Selecionando a UF desejada
  df<-subset(df,SG_UF=="AL")
  
  #Selecionando as variáveis desejadas (apenas o IDEB)
  if(i=="ensino_medio") {
    
    df$i2015<-""
    df$ma2015<-""
    df$p2015<-""
    df$m2015<-""
    
    df<-data.frame(df$CO_MUNICIPIO,df$ID_ESCOLA,df$NO_ESCOLA,
                   df$REDE,df$i2015,df$VL_OBSERVADO_2017,df$VL_OBSERVADO_2019,
                   df$ma2015,df$VL_NOTA_MATEMATICA_2017,df$VL_NOTA_MATEMATICA_2019,
                   df$p2015,df$VL_NOTA_PORTUGUES_2017,df$VL_NOTA_PORTUGUES_2019,
                   df$m2015,df$VL_NOTA_MEDIA_2017,df$VL_NOTA_MEDIA_2019)
    
  } else {
    
    df<-data.frame(df$CO_MUNICIPIO,df$ID_ESCOLA,df$NO_ESCOLA,df$REDE,df$VL_OBSERVADO_2015,
                   df$VL_OBSERVADO_2017,df$VL_OBSERVADO_2019,df$VL_NOTA_MATEMATICA_2015,
                   df$VL_NOTA_MATEMATICA_2017,df$VL_NOTA_MATEMATICA_2019,
                   df$VL_NOTA_PORTUGUES_2015,df$VL_NOTA_PORTUGUES_2017,df$VL_NOTA_PORTUGUES_2019,
                   df$VL_NOTA_MEDIA_2015,df$VL_NOTA_MEDIA_2017,df$VL_NOTA_MEDIA_2019)
    
  }
  
  #Renomeando colunas
  names(df)<-c("Mun","cod_escola","Nome_Escola","Rede","ideb_2015","ideb_2017","ideb_2019",
               "mate_2015","mate_2017","mate_2019","port_2015","port_2017","port_2019",
               "medi_2015","medi_2017","medi_2019") 
  
  
  #tratando os dados
  df$serie<-i
  
  df<-df %>% gather(key="ano",value="valor",ideb_2015,ideb_2017,ideb_2019,mate_2015,
                    mate_2017,mate_2019,port_2015,
                    port_2017,port_2019,medi_2015,medi_2017,medi_2019,
                    -Mun,-cod_escola,-Nome_Escola, -Rede,-serie)
  #juntando as bases
  ideb<-rbind(ideb,df)
  
}

#tratamento final
ideb$var<-substr(ideb$ano,1,4)
ideb$ano<-substr(ideb$ano,6,9)

ideb<-subset(ideb,Rede=="Estadual")

ideb$serie[which(ideb$serie=="anos_iniciais")]<-"anos iniciais"
ideb$serie[which(ideb$serie=="anos_finais")]<-"anos finais"
ideb$serie[which(ideb$serie=="ensino_medio")]<-"ensino medio"

ideb$ideb<-as.numeric(as.character(ideb$ideb))

ideb<-na.omit(ideb)


#baixando o csv pronto
write_xlsx(ideb,"ideb_escola.xlsx")
