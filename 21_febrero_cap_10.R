#Como siempre Lo primero es colocarnos en el directorio para el libro y los archivos de Jockers
setwd("/MINE/Dropbox/R-Stuff/TextAnalysisWithR")


#Este capitulo 10 de Jockers intenta mas ser una introduccion breve a como utilizar TEI para mineria
#textual que proveer una tecnica nueva. De hecho en terminos de lo que se hace con el texto no hay
#nada que no se haya visto en otros capitulos, asi que pasemos al tema de TEI



#Veamos un ejemplo de un poema de Ruben Dario codificado en TEI. Se puede ver
#que cada seccion nos provee una informacion relevante al poema que ayuda a identificar
#el origen y el tipo de contenido, es decir, nos da mas metadatos que podemos
#utilizar para un tipo de analisis a escala mayor. La informacion sobre la fecha en que fue
#escrito o publlicado el poema y la coleccion a que pertenece pueden ser muy utiles para comparar
#a otros poemas del autor. 


#<div2 type="poem">
#  <head>MARGARITA</head>
#  <date>1896</date>
#  <book.t>Prosas profanas</book.t>
#  <lg type="stanza">
#  <l>¿Recuerdas que querías ser una Margarita </l>
#  <l>Gautier? Fijo en mi mente tu extraño rostro está,</l>
#  <l>cuando cenamos juntos, en la primera cita,</l>
#  <l>en una noche alegre que nunca volverá.</l>
#  <l>Tus labios escarlatas de púrpura maldita</l>
#  <l>sorbían el champaña del fino baccarat;</l>
#  <l>tus dedos deshojaban la blanca margarita,</l>
#  <l>«Sí... no... sí... no...» ¡y sabías que te adoraba ya!</l>
#  <l>Después, ¡oh flor de Histeria!, llorabas y reías;</l>
#  <l>tus besos y tus lágrimas tuve en mi boca yo; </l>
#  <l>tus risas, tus fragancias, tus quejas, eran mías.</l>
#  <l>Y en una tarde triste de los más dulces días,</l>
#  <l>la Muerte, la celosa, por ver si me querías,</l>
#  <l>¡como a una margarita de amor, te deshojó!</l>
#  </lg>
#  </div2>#

#Para obtener las ventajas que nos da TEI dbemmos ser capaces de leer la informacion en R y buscar
#la seccion del documento que queremos (o los "nodes"). 
#
#Hasta ahora solo hemos leido documentos simples, para leer uno marcado con TEI necesitamos incluir unas
#funciones especiales en R que se encuentran en el "package" XML. 
#
install.packages(XML)

#Una vez instalado, lo invocamos

library(XML)

#Una vez hecho esto podemos leer un documento, en este caso una version de MOBBBY DICK que esta preparada en TEI
#un guardar la informacion en un vector
#
doc <- xmlTreeParse("data/XML1/melville1.xml", useInternalNodes=TRUE)

#Puedes ejecutar

doc

#y veras que ahora tenemos todo el documento en TEI guardado en esa variable

#Cada documento de TEI es diferente y hasta se pueden inventar etiquetas (podria usar "fecha", por ejemplo,
#para indicar esa informacion en el poema de Dario que vimos antes), asi que hay que prestar atencion a las
#caracteristicas de cada estructura y el orden en que esta para obtener la informacion deseada

#Por ejemplo los capitulos de Moby Dick estan en cerrados en un apartado <div>, identificado
#como "chapter" y el numero del capitulo. En el documento se usa la siguiente jeraquia


#<div1 type="chapter" n="1" id="\_75784">
#  <head>Loomings</head>
#  <p rend="fiction">Call me Ishmael. Some years ago-
#  never mind how long precisely- having little. . .

#De modo que si queremmos dividir la novlea por capitulos tenemos que indicarle a R
#que busque dentro de un documente, el nivel correspondiente
#El comando "/d:TEI//d:div1[@type='chapter']" indica "vaya a un documento que empieza con la etiqueta
#TEI y busque la etiqueta <div1> que esta identificada como el tipo 'chapter' y guarde cada
#capitulo individualmente"


chapters.ns.l<-getNodeSet(doc,"/d:TEI//d:div1[@type='chapter']", namespace = c(d = "http://www.tei-c.org/ns/1.0"))

#Ahora si queremos ver el capitulo 1, que se titula "Loomings", de Moby Dick podemos escribir

chapters.ns.l[[1]]

#Notese que en esta lista dentro de cada capitulo contiene una parte de TEI. Por ejemplo, el primer
#elemento de un capitulo es el <head> que contiene el titulo

#Veamos ese elemento para el capitulo 5

chapters.ns.l[[5]][1]

#El segundo elemento es la division <p> o parrafo que contiene el primer parrafo del capitulo

chapters.ns.l[[5]][2]

#Una mejor manera de obtener el titulo es utilizar "xmlElementsByTagName" y pedirle que
#busque el nodo <head>
  
chap.title <- xmlElementsByTagName(chapters.ns.l[[1]], "head")
chap.title

#Dentro del nodo ,head> solo queremos saber su valor, no el nombre del nodo asi que podemos sacarlo usando "xmlValue"

xmlValue(chap.title[[1]])


#Ahora es posible obtener la informacion de cada capitulo utilizando un "loop" que es mas sencillo
#que los que hemos usado anteriormente

#Lo siguientes similar a lo que hemos visto en otros capitulos, pero utilizando TEI


chapter.freqs.l<-list()
chapter.raws.l<-list()



for(i in 1:length(chapters.ns.l)){
  # se obtiene la informacion del titulo
  chap.title<-xmlValue(xmlElementsByTagName(chapters.ns.l[[i]], "head")[[1]])
  # se obtiene los parrafos
  paras.ns<-xmlElementsByTagName(chapters.ns.l[[i]], "p")
  #se combinan los parrafos
  chap.words.v<-paste(sapply(paras.ns, xmlValue), collapse=" ")
  # el resto lo hemos visto antes
  words.lower.v <-tolower(chap.words.v)
  words.l<-strsplit(words.lower.v, "\\W")
  word.v<-unlist(words.l)
  word.v<- word.v[which(word.v!="")]
  chapter.freqs.t<-table(word.v)
  chapter.raws.l[[chap.title]]<- chapter.freqs.t
  chapter.freqs.l[[chap.title]]<-100*(chapter.freqs.t/sum(chapter.freqs.t))
}

#algunos ejercicios que vimos en otros capitulos funcionan de igual manera

whales<-do.call(rbind, lapply(chapter.freqs.l, '[', 'whale'))
ahabs<-do.call(rbind, lapply(chapter.freqs.l, '[', 'ahab'))
whales.ahabs<-cbind(whales, ahabs)
whales.ahabs[which(is.na(whales.ahabs))]<-0
colnames(whales.ahabs)<-c("whale", "ahab")

#una representacion grafica
barplot(whales.ahabs, beside=T, col="grey")

#una correlacion entre palabras
whales.ahabs.df<-as.data.frame(whales.ahabs)
cor.test(whales.ahabs.df$whale, whales.ahabs.df$ahab)


#Pareceria que no hemos logrado nada que no hayamos hecho antes al utilizar en TEI
#pero sus ventajas se veran cuando estemos trabajando con muchos textos en el proximo capitulo






















  
  