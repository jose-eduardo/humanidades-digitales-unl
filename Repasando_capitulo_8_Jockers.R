
##Lo primero es colocarnos en el directorio para el libro y los archivos de Jockers
setwd("/MINE/Dropbox/R-Stuff/TextAnalysisWithR")




#aquí usaremos una función ("dir") de R para mostrar lo que hay en un directorio

dir("/MINE/Dropbox/R-Stuff/TextAnalysisWithR/data/plainText")
dir("~")

#para presentarlo de manera más legible, el nombre de cada archivo por línea
#Jockers crea una función

#primero usa variables para que se pueda cambiar la info fácilmente más tarde


input.dir <- "data/plainText"
files.v <- dir(input.dir, "\\.txt$") #usa un patrón, como los que usamos con "gsub" para buscar sólo los archivos que terminan en .txt


#Crea la función, algo con lo que estamos ya familiarizados

show.files <- function(file.name.v){
  for(i in 1:length(file.name.v)){
    cat(i, file.name.v[i], "\n", sep=" ")
  }
}
#y la usamos
show.files(files.v)



#es lo mismo que decir
show.files(dir("/MINE/Dropbox/R-Stuff/TextAnalysisWithR/data/plainText", "\\.txt$"))



####Usamos el código que se creó en los capítulos 4 y 6 y ahora hacemos una función 


#
#Puedes copiar la función make.file.word.v.l del libro de Jockers



#algo nuevo en el libro de Jockers es la función "return", pero no para nosotros que ya sabemos que es una manera de enviar
#información de la variables locales afuera del "loop" 


# La función que hace Jockers toma el vector con el nombre de los archivos y la dirección o "path" del directorio 
# y devuelve una lista en la que todos los elementos aparecen en orden
# en un vector de palabras

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
    text.word.vector.l[[files.v[i]]]<-text.words.v
  }
  return(text.word.vector.l)
}


#al aplicar la función a nuestro directorio, Jockers guarda el resultado en una lista
my.corpus.l <- make.file.word.l(files.v, input.dir)

#ahora el primer elemento de esa lista es el libro de Austen y el segundo el de Melville

my.corpus.l[[1]]

my.corpus.l[[1]][1:100]


#por que el texto está en orden 
#podemos ver la primera oración de Pride and Prejudice
my.corpus.l[[1]][115:124]

#o la primera de "Moby Dick"
my.corpus.l[[2]][3924:3926]

#¿cómo encontrar la palabra que queremos?

positions.v <- which(my.corpus.l[[1]][]=="gutenberg")

#podemos guardar la posición que queremos
first.instance<-positions.v[1]

#y mirar las palabras que vienen antes o después
my.corpus.l[[1]][(first.instance-1):(first.instance+1)]


#o usar los números directamente
my.corpus.l[[1]][2:4]


##Este sistema no es muy eficaz--tendríamos que ir cambiando el índice para ver el contexto en que 
##la palabra aparece escrita. Una palabra como "view" puede aparecer hasta 20 veces.

#Podemos hacer una función que imprima todas
# las veces que aparece la palabra sin tener que ir
# una por una




#primera versión de función
#se puede usar "cat" en lugar de "print" también

contexto <- function(palabra_a_buscar){
  posiciones <- which(my.corpus.l[[1]][]==palabra_a_buscar)
  for (x in posiciones) {
    print(my.corpus.l[[1]][(x-1):(x+1)])
  }
}

#llamamos nuestra funcion para ver donde se localiza la palabra "view"
contexto("view")


#segunda versión

#dos parametros: numero de la novela, palabra a buscar
# Novelas: 1. Pride and Prejudice, 2. Moby Dick
#
contexto2 <- function(num_novela, palabra_a_buscar){
  num<-num_novela
  posiciones <- which(my.corpus.l[[num]][]==palabra_a_buscar)
  for (x in posiciones) {
    print(my.corpus.l[[num]][(x-1):(x+1)])
  }
}

#llamamos nuestra funcion 2 para ver donde se localiza la palabra "view"
contexto2(1, "view")






