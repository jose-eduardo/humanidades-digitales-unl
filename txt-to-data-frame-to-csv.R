text.A<-scan("data/plainText/austen.txt", what="character", sep="\n")
start.A<-which(text.A == "CHAPTER 1")
end.A<-which(text.A == "THE END")
start.metadata.A<-text.A[1:start.A -1]
end.metadata.A<-text.A[(end.A+1):length(text.A)]
metadata.A<-c(start.metadata.A, end.metadata.A)
novel.lines.A<- text.A[start.A:end.A]
length(novel.lines.A)
novel.A<-paste(novel.lines.A, collapse=" ")
novel.lower.A<-tolower(novel.A)
austen.words.l<-strsplit(novel.lower.A, "\\W")
austen.word.v<-unlist(austen.words.l)
not.blanks.A <- which(austen.word.v!="")
austen.word.v<- austen.word.v[not.blanks.A]
austen.freqs.t<-table(austen.word.v)
sorted.austen.freqs.t<-sort(austen.freqs.t , decreasing=T)
sorted.austen.rel.freqs.t<-100*(sorted.austen.freqs.t/sum(sorted.austen.freqs.t))
