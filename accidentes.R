setwd("C:\\Users\\eladiomontero\\Documents\\GitHub\\AnalisisAccidentes")
accidentesData = read.table("accidentes.csv", stringsAsFactors = T, header = T, sep = ",")
names(accidentesData) = c("a_Accidente","claseDeAccidente","tipoDeAccidente","ano","mes","dia","hora","horaRecodificada","provincia","canton","distrito","gam?","ruta","clasificacionRuta","kilometro","tipoRuta","ruralOUrbano","calzadaVertical","calzadaHorizontal","formaDeCalzada","tipoDeCalzada","condicionDeCalzada","estadoDeCalzada","condicionDeIluminacion","codtie","tipoInterseccion","codigoDeCirculacion","delegacion")
library(caret)

summary(accidentesData)
accidentesData$ilesos = as.numeric(accidentesData$claseDeAccidente) - 1
accidentesData$ilesos = as.factor(accidentesData$ilesos)
accidentesData$ano = factor(accidentesData$ano)


sapply(accidentesData, function(x) length(unique(x)))
plot(accidentesData$claseDeAccidente)
qplot(claseDeAccidente, hora, data = accidentesData, geom = c("boxplot"), fill = claseDeAccidente)
qplot(hora, fill = claseDeAccidente, data = accidentesData)
missmap(accidentesData, main = "Missing values")

trainIndex <- createDataPartition(accidentesData$claseDeAccidente, p = .7, 
                                  list = FALSE, 
                                  times = 1)
training = accidentesData[trainIndex,]
test = accidentesData[-trainIndex,]

#model = lm(ilesos ~ ., data = training)

model = glm(ilesos ~., family = binomial(link = "logit"), data = training)

modelControl = trainControl(method = "cv", number = 3, returnResamp = 'none', summaryFunction = twoClassSummary(), classProbs = TRUE)
model = train(training[, c(0,2:27)], training$ilesos,
              method = 'gbm',
              trControl = modelControl,
              metric = "ROC",
              preProcess = c("center", "scale"))




