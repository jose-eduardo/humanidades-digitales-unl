
#para automatizar el convertir un texto en marco de datos y guardarlo como archivo .CSV
setwd("~/Dropbox/Span 991-Lectura distante/Stylo")
input.dir<-"primary_set"
library("dplyr")



relativas <- function(arguments1, arguments2){
  text.v<-scan(paste(arguments1, arguments2, sep="/"), what="character", sep="\n")
  novel.lines.A<- text.v
  length(novel.lines.A)
  novel.A<-paste(novel.lines.A, collapse=" ")
  novel.lower.A<-tolower(novel.A)
  novel.words.l<-strsplit(novel.lower.A, "\\W")
  novel.word.v<-unlist(novel.words.l)
  not.blanks.A <- which(novel.word.v!="")
  novel.word.v<- novel.word.v[not.blanks.A]
  novel.freqs.t<-table(novel.word.v)
  sorted.novel.freqs.t<-sort(novel.freqs.t , decreasing=T)
  sorted.novel.rel.freqs.t<-100*(sorted.novel.freqs.t/sum(sorted.novel.freqs.t))
  df<-as.data.frame(sorted.novel.rel.freqs.t)
#para Linux, poner la siguiente linea--arregla problema de nombres
#de columnas con dplyr
  #  df<-tibble::rownames_to_column(df, "Palabras")

colnames(df)<-c("Palabras", "Frecuencia")
  return(df)
}




sicardi.df<-relativas(input.dir, "Sicardi_Paloche-nl0031.txt")
sicardi2.df<-relativas(input.dir, "Sicardi_Extrano-nl0029.txt")
cambaceres.df<-relativas(input.dir, "Cambaceres_Musica-nl0034.txt")
anonimo.df<-relativas(input.dir, "anonimo.txt")

#añadimos una columna más con el nombre del autor para identificar cada data frame
sicardi.df["Autor"]<-"Sicardi"
sicardi2.df["Autor"]<-"Sicardi2"
cambaceres.df["Autor"]<-"Cabaceres"
anonimo.df["Autor"]<-"anonimo"

#usamos rbind para unir todos los data frames en uno solo
newdf.df<-rbind(sicardi.df, sicardi2.df, cambaceres.df, anonimo.df)

#de aqui en adelante seguimos a Jockers en su capítulo 11--aunque podríamos tener otras alternativas


result <- xtabs(Frecuencia ~ Autor+Palabras, data=newdf.df)


final.m<-apply(result, 2, as.numeric)
smaller.m <- final.m[,apply(final.m,2,mean)>=.10]
rownames(smaller.m)<-rownames(result)

# Create a distance object
dm<-dist(smaller.m)
# Perform a cluster analysis on the distance object
cluster <- hclust(dm)
# Get the book file names to use as labels.
cluster$labels<-rownames(smaller.m)

# Plot the results as a dendrogram for inspection.
plot(cluster)






