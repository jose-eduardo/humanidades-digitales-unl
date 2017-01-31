##NOTA: No estoy colocando tildes por si alguien tiene problemas para verlos en su sistema


##REPASO de conceptos básicos aprendidos en el curso de "lectura distante"

#ASIGNACION DE VALOR


#Se le puede asignar un valor a una variable con el signo (<) y el guión (-):
numero <- 300

#Los valores pueden ser numéricos ("numeric")

miembros.de.familia_1 <- 5

#letras ("character")

apellido_paterno <- "Gonzalez"

#o lógico ("logical")

miembro_vive_en_eeuu <- FALSE


#Puedo sumar /dividir / multiplicar
miembros.de.familia_1 <- (miembros.de.familia_1 + 4) / 2 


#Si quiero guardar el nuevo valor tengo que pedir que el nuevo valor sea asignado de manera
#permanente con la siguiente expresión

miembros.de.familia_1 <- miembros.de.familia_1 * 4

#VECTORES

#En lugar de tener información similar en diferentes variables, podemos asignarlas a un vector

miembros.de.familia <- c(3, 5, 7)   

#La letra "c" indica concadenar/concatenar todos los valores  

#Si queremos ver sólo el valor de la familia 1, escribimos:

miembros.de.familia[1] 
#[1] 3

#Lo mismo con las otras familias:
miembros.de.familia[2]
#[1] 5
miembros.de.familia[3]
#[1] 7

#Pregunta: Siguiendo el modelo anterior, ¿cómo se puede hacer un vector que 
#contenga los apellidos paternos de tres diferentes familias?

#SUCESIÓN O SECUENCIA ('sequences')
#Estas se crean con el símbolo (:)

#Así que podemos asignarlas a una variable:

A <- 1:5
B <- 5:10

#O utilizarlas para leer parte de los elementos de un vector

objetos<-c("mesa", "libro", "lapiz", "plato", "servilleta", "zapato", "pelota")

#Puedo ver los elementos del 3 al 6 usando una secuencia. Los números nos dan los índices para localizar elementos.

objetos[3:6]

#Por supuesto que para nuestros propósitos, cada linea de un texto sera un elemento de un vector. 
#en el siguiente fragmento de un poema, he colocado cada verso en un vector
poema<-c("Son los Centauros. Cubren la llanura. Les siente", "La montana. De lejos, forman son de torrente", "Que cae; su galope al aire que reposa", "Despierta, y estremece la hoja de laurel-rosa.", "Son los Centauros. Unos enormes, rudos; otros", "Alegres y saltantes como jovenes potros;", "Unos con largas barbas como los padres-rios", "Otros imberbes, agiles y de piafantes brios", "Y de robustos musculos, brazos y lomos aptos", "Para portar las ninfas rosadas en los raptos.")

#si queremos saber cuantas líneas tiene nuestro texto (o cuál es el tamaño de un vector)
length(poema)

#Podemos ver sólo los versos 4 al 7 usando el índice de los versos que queremos
poema[4:7]


#LISTAS


#Una lista es diferente de un vector porque podemos colocar diferentes tipos de elementos en ella
numeros_y_palabras.l<-list(23, 34, "agua", "casa")

#si usamos el comando "str" y vemos la estructura de la lista que acabamos de crear
#y así podemos ver la diferencia con el vector

str(numeros_y_palabras.l)

#si sólo queremos ver un componente de la lista
numeros_y_palabras.l[[2]]
#notese el uso de dos pares de corchetes para accesar el contenido a diferencia de los vectores
#si usamos solo un par de corchetes, podriamos ver el contenido pero no manipularlo directamente


#Otra característica de la lista es que puede tener muchos elementos dentro de cada componente de la lista
#Por ejemplo, si creamos dos vectores

n = c(2, 3, 5) 
s = c("aa", "bb", "cc", "dd", "ee") 

# y los guardamos en una lista
una_lista.l = list(n, s)   
#cada vector es un componente de la lista x 
#el primer elemento de la lista 
una_lista.l[[1]]

#contiene 3 elementos
#y el segundo
una_lista.l[[2]]
#contiene cinco "palabras"

#o podemos ver el cuarto elemento 
una_lista.l[[2]][4]



#pero usar número para nombrar los vectores que componen la lista puede ser
#confuso, así que puedo usar nombres

lista_2 = list(numeros=10:20, palabras=c("agua", "casa", "camino", "perro"))

#ahora puedo ver los elementos en "números" de la siguiente manera

lista_2[["numeros"]]

#o así

lista_2$numeros


#Si quisiera cambiar uno de los elementos en la lista puedo asignarle un valor nuevo
#Por ejemplo, el cuarto elemento en "palabras" es "perro" y quiero cambiarlo
# a "ventana"

lista_2[["palabras"]][4]<-"ventana"

#Ahora el resultado es diferente
lista_2[["palabras"]][4]


###LOOPS

#En un "loop" se prueba la validez lógica de una condición y se ejecuta 
#una expresión si la condición es verdadera


primera_variable<-6
segunda_variable<-5

if (primera_variable > segunda_variable) {
  print("la condicion es cierta")
}


#FOR nos ayuda a repetir una tarea varias veces

#Por ejemplo, digamos que tenemos un grupo de nombres
grupo_de_personas<-c("Pedro", "Manuel", "Isabel")


#Una manera de hacerlo es contar cuántos nombres hay e ir cambiando el elemento del vector que se quiere imprimir

for (numero in 1:length(grupo_de_personas)){
  print(paste("Hola", grupo_de_personas[numero]))
}

#UNA MEJOR MANERA es dejar que el FOR ya busque cuantos elementos hay en el vector

for (nombre in grupo_de_personas){
  print(paste("Hola", nombre))
}



#FUNCIONES


#Podemos crear nuestras propias funciones con una serie de comandos que queremos que se ejecuten
#o apliquen a los datos que le damos.

repetir<-function(x, y){
  resultado<-x
  for (i in 1:y) {
    print(resultado)
  }
}


repetir("hola", 5)
























