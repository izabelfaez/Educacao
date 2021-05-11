<h1 align="center">DADOS EDUCACIONAIS DIVERSOS</h1>

Scripts de dados educacionais



<h3>1. Censo_Escolar -  Gera dados de matrículas por município, localização, dependência e etapa de ensino de 2015 a 2020.</h3>

É preciso fazer o download dos microdados antes, você encontra eles em: https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/censo-escolar

Ao fazer o download os dados de encontram no formato CSV, na pasta DADOS, separados por região.

Salve os arquivos que vai usar com nome padrão, mudando apenas o ano. No meu caso usei o arquivo de MATRÍCULAS NORDESTE, e nomeei eles como MATRICULA_NORDESTEano.csv

Na linha 15 eu selecionei a UF desejada, é possível selecionar qualquer uma de interesse.


<h3>2. Distorção Idade Série -  Gera dados de Distorção idade série por escola de 2015 a 2019.</h3>

Nas linhas 29 e 50 é preciso selecionar a UF de interesse, estou pegando de Alagoas.

<h3>3. IDEB_Escolas -  Gera dados do IDEB e das provas do SAEB por escola para todos os niveis de ensino de 2015 a 2019.</h3>

Na linha 36 é preciso selecionar a UF de interesse

<h3>4. IDEB_Municípios -  Gera dados do IDEB por município para todos os níveis de ensino de 2015 a 2019.</h3>

Na linha 35 é preciso selecionar a UF de interesse

<h3>5. Notas ENEM - Gera nota média por matéria por município de residência e dependência de 2015 a 2019 </h3>

É preciso fazer o download dos microdados antes, você encontra eles em: https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem

Ao download os dados de encontram no formato CSV, na pasta DADOS, separados por região.

Salve os arquivos que vai usar com nome padrão, mudando apenas o ano.

Na linha 6 eu seleciono a UF de interesse. 

<h3>6. Taxas_INEP_Municipios - Gera base com taxas de Aprovação, Reprovação e Abandono por município, localização e dependência administrativa de 2007 a 2019 </h3>

Nas condicionais, antes de cada else if eu seleciono a UF


<h3>7. Taxas_INEP_Escolas - Gera base com taxas de Aprovação, Reprovação e Abandono por escola, localização e dependência administrativa de 2015 a 2019 </h3>

Nas condicionais, antes de cada else if eu seleciono a UF




