#Como siempre Lo primero es colocarnos en el directorio para el libro y los archivos de Jockers
setwd("/MINE/Dropbox/R-Stuff/TextAnalysisWithR")


#Otra vez: ignoro las tildes (etc..) para que aquellos que tienen problemas con el "encoding"
#de su version de R puedan usar este archivo sin problemas

#En el capitulo 8, habiamos creado una funcion para llamada "make.file.word.l" que tomaba el vector con el nombre 
#de los archivos y la dirección o "path" del directorio y delvolvia una lista en la que todos los elementos 
#(palabras en nuestro caso) aparecen en orden. 

#Esa funcion nos permitia ver el contexto en el cual aparecia una palabra, mirando las palabras
#anteriores y posteriores a cada mencion del elemento

#Era un poco dificil de utilizar: era dificil saber a que texto en el vector se referia cada
#numero y ademas habia que localizar individualmente los indices de cada mencion de una palabra

#En el capitulo 9, Jockers crea una mejor funcion KWIC (Keyword in Context).

#Primero descubrimos que es posible guardar todas nuestras funciones en otro archivo para que
#este listas para ser ejecutadas inmediatamente.

#Así que copiamos las dos funciones que creamos en el capítulo anterior:


show.files <- function(file.name.v){
  for(i in 1:length(file.name.v)){
    cat(i, file.name.v[i], "\n", sep=" ")
  }
}

#y 


make.file.word.l<-function(files.v, input.dir){
  #set up an empty container
  text.word.vector.l<-list()
  # loop over the files
  for(i in 1:length(files.v)){
    # read the file in (notice that it is here that we need to know the input
    # directory
    text.v<-scan(paste(input.dir, files.v[i], sep="/"), what="character", sep="\n")
    #convert to single string
    text.v<-paste(text.v, collapse=" ")
    #lowercase and split on non-word characters
    text.lower.v <-tolower(text.v)
    text.words.v<-strsplit(text.lower.v, "\\W")
    text.words.v<-unlist(text.words.v)
    #remove the blanks
    text.words.v<- text.words.v[which(text.words.v!="")]
    #use the index id from the files.v vector as the "name" in the list
    #VEANSE mis comentarios sobre el doble bracket en cqapitulo 6
    text.word.vector.l[[files.v[i]]]<-text.words.v
  }
  return(text.word.vector.l)
}


#en nuevo archivo llamado "corpusFunctions.R"
#Alli guardaremos todas las funciones que vamos a crear.
#guardemos ese archivo en el subdirectorio de "TextAnalysisWithR" llamado "code"
#Prueba creando el archivo y poniendolo en el subdirectorio

#Ahora al principio de nuestros archivos de R, llamaremos esas funciones
#con el siguiente comando:

source("code/corpusFunctions.R")

#Vamos a crear un nuevo subdirectorio para guardar nnuestros resultados "results"

#Le decimos a R donde encontrar los textos que queremos y donde guardar la información que resulte
input.dir <- "data/plainText"
output.dir<- "results/"

#Reciclamos del capitulo 8 el proceso de obtener la infomacion con nuestras funciones
files.v <- dir(input.dir, ".*txt")
my.corpus.l <- make.file.word.l(files.v, input.dir)


#Ahora vamos a crear una maneras mas accesible y facil de obtener los contextos

#Si recordamos el problema del capitulo 8 era que al buscar el contexto primero
#habia que recordar que my.corpus.l[[1]] se referia a Austen y my.corpus.l[[2]] a
#Melville y luego saber los indices que queriamos, por ejemplo

my.corpus.l[[1]][2:4]
#resultaba en la primera mencion de "gutenberg" en el libro de Austen
#[1] "project"   "gutenberg" "ebook"  

#La nueva funcion, doitKWIC, la construiremos primero dejandole ver
#al usuario los textos que estan disponibles para busquedas, asignandole
#numero y preguntando al usuario cual quiere escoger

#Segundo preguntandole que palabra desea buscar y automaticamente encontrandola en el texto deseado

#Veamos como funciona. 
#Primero, vamos a aplicar esta funcion a my.corpus.l o nuestra lista de textos ya procesados
#Segundo utilizaremos la funcion show.files para mostrar los textos disponibles
#y luego utilizaremos una nueva funcion de R, "readlines" para preguntarle al usuario lo que quiiere hacer


#Escribamos la funcion y guardemosla en "corpusFunctios.R"
#De ser necesario volvamos allamar nuestro archivo de funciones
#como lo hicimos antes

source("code/corpusFunctions.R")

#Veamos la funcion:

doitKwic<-function(named.text.word.vector.l){
  #primero le pedimos que nos muestre los archivos de los cuales escoger
  show.files(names(named.text.word.vector.l))
  # despues le pedimos informacion al usuario
  file.id<- as.numeric(readline(
    "Which file would you like to examine? Enter a file number: \n"))
  context<- as.numeric(readline(
    #aqui le diremos cuatas palabras antes y despues de la palabra clave queremos que busque
    "How much context do you want to see, Enter a number: \n"))
  keyword<- tolower((readline("Enter a keyword: \n")))
  hits.v<-which(named.text.word.vector.l[[file.id]] == keyword)
  if(length(hits.v)>0){
    for(h in 1:length(hits.v)){
      start<-hits.v[h]-context
      if(start < 1){
        start<-1
      }
      end<-hits.v[h]+context
      cat(named.text.word.vector.l[[file.id]][start:end], "\n")
    }
  }
}


#Finalmente podemos aplicar esta funcion a my.files.l

doitKwic(my.corpus.l)















