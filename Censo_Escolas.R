library("data.table")
library("dplyr")
library("xlsx")
library("writexl")

#Selecionando Alagoas
f<-function(x,pos) {
  dplyr::filter(x, CO_UF== 27)
}

#escolhendo os anos
ano <- c('15','16','17','18','19')

#criando df para armazenar os dados
matriculas <- data.frame()

#looping para pegar os anos
for(i in ano){
  
  #lendo a base - somente o escolhido na função
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

df1<-matriculas

df1$TP_DEPENDENCIA[which(df1$TP_DEPENDENCIA=="1")]<-"Federal"
df1$TP_DEPENDENCIA[which(df1$TP_DEPENDENCIA=="2")]<-"Estadual"
df1$TP_DEPENDENCIA[which(df1$TP_DEPENDENCIA=="3")]<-"Municipal"
df1$TP_DEPENDENCIA[which(df1$TP_DEPENDENCIA=="4")]<-"Privada"

df1$TP_LOCALIZACAO[which(df1$TP_LOCALIZACAO=="1")]<-"Urbana"
df1$TP_LOCALIZACAO[which(df1$TP_LOCALIZACAO=="2")]<-"Rural"

df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="1")] <- "Educação Infantil - Creche"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="2")] <- "Educação Infantil - Pré-escola"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="4")] <- "Ensino Fundamental de 8 anos - 1ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="5")] <- "Ensino Fundamental de 8 anos - 2ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="6")] <- "Ensino Fundamental de 8 anos - 3ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="7")] <- "Ensino Fundamental de 8 anos - 4ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="8")] <- "Ensino Fundamental de 8 anos - 5ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="9")] <- "Ensino Fundamental de 8 anos - 6ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="10")] <- "Ensino Fundamental de 8 anos - 7ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="11")] <- "Ensino Fundamental de 8 anos - 8ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="14")] <- "Ensino Fundamental de 9 anos - 1º Ano"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="15")] <- "Ensino Fundamental de 9 anos - 2º Ano"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="16")] <- "Ensino Fundamental de 9 anos - 3º Ano"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="17")] <- "Ensino Fundamental de 9 anos - 4º Ano"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="18")] <- "Ensino Fundamental de 9 anos - 5º Ano"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="19")] <- "Ensino Fundamental de 9 anos - 6º Ano"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="20")] <- "Ensino Fundamental de 9 anos - 7º Ano"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="21")] <- "Ensino Fundamental de 9 anos - 8º Ano"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="41")] <- "Ensino Fundamental de 9 anos - 9º Ano"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="25")] <- "Ensino Médio - 1º ano/1ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="26")] <- "Ensino Médio - 2º ano/2ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="27")] <- "Ensino Médio - 3ºano/3ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="28")] <- "Ensino Médio - 4º ano/4ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="29")] <- "Ensino Médio - Não Seriada"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="30")] <- "Curso Técnico Integrado (Ensino Médio Integrado) 1ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="31")] <- "Curso Técnico Integrado (Ensino Médio Integrado) 2ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="32")] <- "Curso Técnico Integrado (Ensino Médio Integrado) 3ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="33")] <- "Curso Técnico Integrado (Ensino Médio Integrado) 4ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="34")] <- "Curso Técnico Integrado (Ensino Médio Integrado) Não Seriada"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="35")] <- "Ensino Médio - Modalidade Normal/Magistério 1ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="36")] <- "Ensino Médio - Modalidade Normal/Magistério 2ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="37")] <- "Ensino Médio - Modalidade Normal/Magistério 3ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="38")] <- "Ensino Médio - Modalidade Normal/Magistério 4ª Série"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="39")] <- "Curso Técnico - Concomitante"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="40")] <- "Curso Técnico - Subsequente"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="65")] <- "EJA - Ensino Fundamental - Projovem Urbano"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="67")] <- "Curso FIC integrado na modalidade EJA  - Nível Médio"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="68")] <- "Curso FIC Concomitante"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="69")] <- "EJA - Ensino Fundamental - Anos Iniciais"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="70")] <- "EJA - Ensino Fundamental - Anos Finais"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="71")] <- "EJA - Ensino Médio"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="72")] <- "EJA - Ensino Fundamental  - Anos iniciais e Anos finais5"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="73")] <- "Curso FIC integrado na modalidade EJA - Nível Fundamental (EJA integrada à Educação Profissional de Nível Fundamental)"
df1$TP_ETAPA_ENSINO[which(df1$TP_ETAPA_ENSINO=="74")] <- "Curso Técnico Integrado na Modalidade EJA (EJA integrada à Educação Profissional de Nível Médio)"


matriculas<-df1

rm(df,df1,ano,i)  

write.csv(matriculas,"matricula_escolas.csv")

write_xlsx(matriculas,"matricula_escolas.xlsx")

####################### ESCOLAS ###############

f<-function(x,pos) {
  dplyr::filter(x, CO_UF== 27)
}

#escolhendo os anos
ano <- c( '19')

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

####################DOCENTES##############

f<-function(x,pos) {
  dplyr::filter(x, CO_UF== 27)
}

#escolhendo os anos
ano <- c('15','16','17','18', '19')

#df para armazenar dados
docente<-data.frame()


#looping para pegar os anos
for(i in ano){
  
  #lendo a base - somente o escolhido na função
  df<-readr::read_delim_chunked(
    paste0("DOCENTES_NORDESTE",i,".csv"),
    readr::DataFrameCallback$new(f),
    chunk_size = 1000,
    delim = "|")
  
  #selecionando variaveis
  if(i=='19') {
    df<-df %>%
    select(CO_ENTIDADE,TP_TIPO_DOCENTE,TP_ETAPA_ENSINO,
           IN_DISC_LINGUA_PORTUGUESA,
           IN_DISC_EDUCACAO_FISICA,
           IN_DISC_ARTES,
           IN_DISC_LINGUA_INGLES,
           IN_DISC_LINGUA_ESPANHOL,
           IN_DISC_LINGUA_FRANCES,
           IN_DISC_LINGUA_OUTRA,
           IN_DISC_LIBRAS,
           IN_DISC_LINGUA_INDIGENA,
           IN_DISC_PORT_SEGUNDA_LINGUA,
           IN_DISC_CIENCIAS,
           IN_DISC_FISICA,
           IN_DISC_QUIMICA,
           IN_DISC_BIOLOGIA,
           IN_DISC_HISTORIA,
           IN_DISC_GEOGRAFIA,
           IN_DISC_SOCIOLOGIA,
           IN_DISC_FILOSOFIA,
           IN_DISC_ESTUDOS_SOCIAIS,
           IN_DISC_EST_SOCIAIS_SOCIOLOGIA,
           IN_DISC_INFORMATICA_COMPUTACAO,
           IN_DISC_ENSINO_RELIGIOSO,
           IN_DISC_PROFISSIONALIZANTE,
           IN_DISC_ESTAGIO_SUPERVISIONADO,
           IN_DISC_PEDAGOGICAS,
           IN_DISC_OUTRAS)
    
    df<- df %>%
      group_by(CO_ENTIDADE,TP_TIPO_DOCENTE,TP_ETAPA_ENSINO,
               IN_DISC_LINGUA_PORTUGUESA,
               IN_DISC_EDUCACAO_FISICA,
               IN_DISC_ARTES,
               IN_DISC_LINGUA_INGLES,
               IN_DISC_LINGUA_ESPANHOL,
               IN_DISC_LINGUA_FRANCES,
               IN_DISC_LINGUA_OUTRA,
               IN_DISC_LIBRAS,
               IN_DISC_LINGUA_INDIGENA,
               IN_DISC_PORT_SEGUNDA_LINGUA,
               IN_DISC_CIENCIAS,
               IN_DISC_FISICA,
               IN_DISC_QUIMICA,
               IN_DISC_BIOLOGIA,
               IN_DISC_HISTORIA,
               IN_DISC_GEOGRAFIA,
               IN_DISC_SOCIOLOGIA,
               IN_DISC_FILOSOFIA,
               IN_DISC_ESTUDOS_SOCIAIS,
               IN_DISC_EST_SOCIAIS_SOCIOLOGIA,
               IN_DISC_INFORMATICA_COMPUTACAO,
               IN_DISC_ENSINO_RELIGIOSO,
               IN_DISC_PROFISSIONALIZANTE,
               IN_DISC_ESTAGIO_SUPERVISIONADO,
               IN_DISC_PEDAGOGICAS,
               IN_DISC_OUTRAS
      ) %>%
      summarise(n())
    
  } else {
    
    df<-df %>%
      select(CO_ENTIDADE,TP_TIPO_DOCENTE,TP_ETAPA_ENSINO,
             IN_DISC_LINGUA_PORTUGUESA,
             IN_DISC_EDUCACAO_FISICA,
             IN_DISC_ARTES,
             IN_DISC_LINGUA_INGLES,
             IN_DISC_LINGUA_ESPANHOL,
             IN_DISC_LINGUA_FRANCES,
             IN_DISC_LINGUA_OUTRA,
             IN_DISC_LIBRAS,
             IN_DISC_LINGUA_INDIGENA,
             IN_DISC_CIENCIAS,
             IN_DISC_FISICA,
             IN_DISC_QUIMICA,
             IN_DISC_BIOLOGIA,
             IN_DISC_HISTORIA,
             IN_DISC_GEOGRAFIA,
             IN_DISC_SOCIOLOGIA,
             IN_DISC_FILOSOFIA,
             IN_DISC_ESTUDOS_SOCIAIS,
             IN_DISC_EST_SOCIAIS_SOCIOLOGIA,
             IN_DISC_INFORMATICA_COMPUTACAO,
             IN_DISC_ENSINO_RELIGIOSO,
             IN_DISC_PROFISSIONALIZANTE,
             IN_DISC_PEDAGOGICAS,
             IN_DISC_OUTRAS,
             IN_DISC_ATENDIMENTO_ESPECIAIS,
             IN_DISC_DIVER_SOCIO_CULTURAL)
    
    df<- df %>%
      group_by(CO_ENTIDADE,TP_TIPO_DOCENTE,TP_ETAPA_ENSINO,
               IN_DISC_LINGUA_PORTUGUESA,
               IN_DISC_EDUCACAO_FISICA,
               IN_DISC_ARTES,
               IN_DISC_LINGUA_INGLES,
               IN_DISC_LINGUA_ESPANHOL,
               IN_DISC_LINGUA_FRANCES,
               IN_DISC_LINGUA_OUTRA,
               IN_DISC_LIBRAS,
               IN_DISC_LINGUA_INDIGENA,
               IN_DISC_CIENCIAS,
               IN_DISC_FISICA,
               IN_DISC_QUIMICA,
               IN_DISC_BIOLOGIA,
               IN_DISC_HISTORIA,
               IN_DISC_GEOGRAFIA,
               IN_DISC_SOCIOLOGIA,
               IN_DISC_FILOSOFIA,
               IN_DISC_ESTUDOS_SOCIAIS,
               IN_DISC_EST_SOCIAIS_SOCIOLOGIA,
               IN_DISC_INFORMATICA_COMPUTACAO,
               IN_DISC_ENSINO_RELIGIOSO,
               IN_DISC_PROFISSIONALIZANTE,
               IN_DISC_PEDAGOGICAS,
               IN_DISC_OUTRAS,
               IN_DISC_ATENDIMENTO_ESPECIAIS,
               IN_DISC_DIVER_SOCIO_CULTURAL
      ) %>%
      summarise(n())
    
    
  }
  
  
  df$ano<-i
  
  #unindo as bases
  docente <- rbind(docente, df)
  
}


#baixando o csv pronto
write_xlsx(docente,"docente_escola.xlsx")

