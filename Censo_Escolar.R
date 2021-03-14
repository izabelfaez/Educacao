library("dplyr")
library("data.table")
library("dplyr")
library("xlsx")
library("writexl")

#NECESSARIO BAIXAR OS DADOS DO CENSO NO COMPUTADOR PRIMEIRAMENTE
#SALVAR COM UM NOME PADRAO PARA IDENTIFICAR OS ANOS
#AQUI ESTOU PEGANDO OS DADOS DE ALAGOAS --> UF 27 DA PLANILHA MATRICULAS NORDESTE

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

####################### ESCOLAS ###############

f<-function(x,pos) {
  dplyr::filter(x, CO_UF== 27)
}

#escolhendo os anos
ano <- c( '20')

#criando df para armazenar os dados
escolas <- data.frame()

#looping para pegar os anos
for(i in ano){
  
  #lendo a base - somente o escolhido na função
  df<-readr::read_delim_chunked(
    paste0("ESCOLAS",i,".csv"),
    readr::DataFrameCallback$new(f),
    chunk_size = 1000,
    delim = "|")
  
  #selecionando variaveis
  df<-df %>%
    select(CO_ENTIDADE,
           NO_ENTIDADE,
           TP_SITUACAO_FUNCIONAMENTO,
           CO_MUNICIPIO,
           TP_DEPENDENCIA,
           TP_LOCALIZACAO,
           IN_AGUA_POTAVEL,
           IN_AGUA_REDE_PUBLICA,
           IN_AGUA_POCO_ARTESIANO,
           IN_AGUA_CACIMBA,
           IN_AGUA_FONTE_RIO,
           IN_AGUA_INEXISTENTE,
           IN_ENERGIA_REDE_PUBLICA,
           IN_ENERGIA_GERADOR_FOSSIL,
           IN_ENERGIA_RENOVAVEL,
           IN_ENERGIA_INEXISTENTE,
           IN_ESGOTO_REDE_PUBLICA,
           IN_ESGOTO_FOSSA_SEPTICA,
           IN_ESGOTO_FOSSA_COMUM,
           IN_ESGOTO_FOSSA,
           IN_ESGOTO_INEXISTENTE,
           IN_LIXO_SERVICO_COLETA,
           IN_LIXO_QUEIMA,
           IN_LIXO_ENTERRA,
           IN_LIXO_DESTINO_FINAL_PUBLICO,
           IN_LIXO_DESCARTA_OUTRA_AREA,
           IN_TRATAMENTO_LIXO_SEPARACAO,
           IN_TRATAMENTO_LIXO_REUTILIZA,
           IN_TRATAMENTO_LIXO_RECICLAGEM,
           IN_TRATAMENTO_LIXO_INEXISTENTE,
           IN_ALMOXARIFADO,
           IN_AREA_VERDE,
           IN_AUDITORIO,
           IN_BANHEIRO,
           IN_BANHEIRO_EI,
           IN_BANHEIRO_PNE,
           IN_BANHEIRO_FUNCIONARIOS,
           IN_BANHEIRO_CHUVEIRO,
           IN_BIBLIOTECA,
           IN_BIBLIOTECA_SALA_LEITURA,
           IN_COZINHA,
           IN_DESPENSA,
           IN_DORMITORIO_ALUNO,
           IN_DORMITORIO_PROFESSOR,
           IN_LABORATORIO_CIENCIAS,
           IN_LABORATORIO_INFORMATICA,
           IN_PATIO_COBERTO,
           IN_PATIO_DESCOBERTO,
           IN_PARQUE_INFANTIL,
           IN_PISCINA,
           IN_QUADRA_ESPORTES,
           IN_QUADRA_ESPORTES_COBERTA,
           IN_QUADRA_ESPORTES_DESCOBERTA,
           IN_REFEITORIO,
           IN_SALA_ATELIE_ARTES,
           IN_SALA_MUSICA_CORAL,
           IN_SALA_ESTUDIO_DANCA,
           IN_SALA_MULTIUSO,
           IN_SALA_DIRETORIA,
           IN_SALA_LEITURA,
           IN_SALA_PROFESSOR,
           IN_SALA_REPOUSO_ALUNO,
           IN_SECRETARIA,
           IN_SALA_ATENDIMENTO_ESPECIAL,
           IN_TERREIRAO,
           IN_VIVEIRO,
           IN_DEPENDENCIAS_OUTRAS,
           QT_SALAS_UTILIZADAS_DENTRO,
           QT_SALAS_UTILIZADAS_FORA,
           QT_SALAS_UTILIZADAS,
           QT_SALAS_UTILIZA_CLIMATIZADAS,
           QT_SALAS_UTILIZADAS_ACESSIVEIS,
           IN_EQUIP_PARABOLICA,
           IN_COMPUTADOR,
           IN_EQUIP_COPIADORA,
           IN_EQUIP_IMPRESSORA,
           IN_EQUIP_IMPRESSORA_MULT,
           IN_EQUIP_SCANNER,
           IN_EQUIP_DVD,
           QT_EQUIP_DVD,
           IN_EQUIP_SOM,
           QT_EQUIP_SOM,
           IN_EQUIP_TV,
           QT_EQUIP_TV,
           IN_EQUIP_LOUSA_DIGITAL,
           QT_EQUIP_LOUSA_DIGITAL,
           IN_EQUIP_MULTIMIDIA,
           QT_EQUIP_MULTIMIDIA,
           IN_DESKTOP_ALUNO,
           QT_DESKTOP_ALUNO,
           IN_COMP_PORTATIL_ALUNO,
           QT_COMP_PORTATIL_ALUNO,
           IN_TABLET_ALUNO,
           QT_TABLET_ALUNO,
           IN_INTERNET,
           IN_INTERNET_ALUNOS,
           IN_INTERNET_ADMINISTRATIVO,
           IN_INTERNET_APRENDIZAGEM,
           IN_INTERNET_COMUNIDADE,
           IN_ACESSO_INTERNET_COMPUTADOR,
           IN_ACES_INTERNET_DISP_PESSOAIS,
           TP_REDE_LOCAL,
           IN_BANDA_LARGA,
           QT_PROF_ADMINISTRATIVOS,
           QT_PROF_SERVICOS_GERAIS,
           QT_PROF_BIBLIOTECARIO,
           QT_PROF_SAUDE,
           QT_PROF_COORDENADOR,
           QT_PROF_FONAUDIOLOGO,
           QT_PROF_NUTRICIONISTA,
           QT_PROF_PSICOLOGO,
           QT_PROF_ALIMENTACAO,
           QT_PROF_PEDAGOGIA,
           QT_PROF_SECRETARIO,
           QT_PROF_SEGURANCA,
           QT_PROF_MONITORES,
           IN_ALIMENTACAO
           )
  

  df$ano<-i
  
  #unindo as bases
  escolas <- rbind(escolas, df)
  
}

write.csv(escolas,"escolas.csv")


           