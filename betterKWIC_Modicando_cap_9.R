#Modificando doitKWIC

#Del capitulo 8 y9, viene lo siguiente

setwd("~/Dropbox/R-Stuff/TextAnalysisWithR")
source("code/corpusFunctions.R")

input.dir <- "data/plainText"
output.dir<- "results/"
files.v <- dir(input.dir, ".*txt")
my.corpus.l <- make.file.word.l(files.v, input.dir)

###########################################################################################################
# Basado en el doitKwic de Jockers. Esta version analiza todos los textos que han sido procesados
# identificandolos en el resultado y luego ofrece una tabla que informa cuantas veces aparecen duplicadas
# las palabras que se usan en el contexto de la palabra clave. 
#############################################################################################################


betterKwic<-function(named.text.word.vector.l){
  contexto<-vector()
  cat("####################################################################################", "\n")
  cat("This is a fucntion to look for a keyword within the context of the following texts", "\n")
  cat("---------------------------------------------------------------------------------", "\n")
  #primero le pedimos que nos muestre los archivos de los cuales escoger
  show.files(names(named.text.word.vector.l))
  cat("####################################################################################", "\n")
  # despues le pedimos informacion al usuario
  context<- as.numeric(readline(
    #aqui le diremos cuatas palabras antes y despues de la palabra clave queremos que busque
    "How much context do you want to see, Enter a number: \n"))
  keyword<- tolower((readline("Enter a keyword: \n")))
 
  for(i in 1:length(named.text.word.vector.l)){
    num<-i
    posiciones <- which(named.text.word.vector.l[[num]][]==keyword)
    for (x in posiciones) {
      cat("--------------------------", names(named.text.word.vector.l[num]), "----------------------", "\n")
      cat(named.text.word.vector.l[[num]][(x-context):(x+context)], "\n")
      
      contexto<-c(contexto, named.text.word.vector.l[[num]][(x-context):(x-1)], named.text.word.vector.l[[num]][(x+1):(x+context)])
    }
  }
  #esta seccion va a mostrar un gráfico de las palabras más comunes que aparecen en el contexto de la 
  #palabra clave
  remove<-c("the", "a","of","that","to","is","in","was", "but", "and", "it", "s", "i")
  #queremos eliminar las palabras mas comunes o que no nos interesan
  contexto<-contexto[!contexto %in% remove]
  #creamos una tabla de contingencia para saber cuantas veces se repite cada palabra
  contexto.t<-table(contexto)
  ordenado.contexto.t <- sort(contexto.t , decreasing=TRUE)
  #ordenamos la info de mas frecuente a menos y creamos una imagen
  print(ordenado.contexto.t[1:10])
  plot(ordenado.contexto.t[1:10])
}



betterKwic(my.corpus.l)
