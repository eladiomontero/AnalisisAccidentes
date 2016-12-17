setwd("C:\\Users\\eladiomontero\\Documents\\GitHub\\AnalisisAccidentes")
accidentesData = read.table("accidentes.csv", stringsAsFactors = T, header = T, sep = ",")
names(accidentesData) = c("a_Accidente","claseDeAccidente","tipoDeAccidente","ano","mes","dia","hora","horaRecodificada","provincia","canton","distrito","gam?","ruta","clasificacionRuta","kilometro","tipoRuta","ruralOUrbano","calzadaVertical","calzadaHorizontal","formaDeCalzada","tipoDeCalzada","condicionDeCalzada","estadoDeCalzada","condicionDeIluminacion","codtie","tipoInterseccion","codigoDeCirculacion","delegacion")
library(caret)

summary(accidentesData)
accidentesData$ilesos = as.numeric(accidentesData$claseDeAccidente) - 1
accidentesData$ano = factor(accidentesData$ano)


plot(accidentesData$claseDeAccidente)
qplot(claseDeAccidente, hora, data = accidentesData, geom = c("boxplot"), fill = claseDeAccidente)
qplot(hora, fill = claseDeAccidente, data = accidentesData)




