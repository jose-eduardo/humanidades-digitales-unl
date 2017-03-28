
#para automatizar el convertir un texto en marco de datos y guardarlo como archivo .CSV

input.dir<-"data/plainText"

austen.df<-relativas(input.dir, "austen.txt")


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
  colnames(df)<-c("Palabras", "Frecuencia")
  return(df)
}





# Write CSV  
write.csv(austen.df, file = "MyData.csv")

# read csv file 
austen.df = read.csv("MyData.csv")  



