---
title: "Интерактивные карты с GVis и leaflet"
author: "Julija Zolovkina"
date: "15 апреля 2017 г."
output: html_document
---
  
  ## Интерактивная картограмма
  Построена на [данных Всемирного банка по эффективности госпомощи стран](http://data.worldbank.org/topic/aid-effectiveness?view=chart).

---
```
#Загрузка пакетов
install.packages('WDI')
install.packages('googleVis')
install.packages('dtplyr')
install.packages('data.table')
install.packages('leaflet')
library('WDI')
library('googleVis')
library('dtplyr')
library('data.table')
library('leaflet')

# Загружаем файл с данными Эффективности госпомощи стран
fileURL <- 'https://github.com/Zolovkina/Lab_5/blob/master/Data5_1.csv'
if (!file.exists('./data')) dir.create('./data')
if (!file.exists('./data/Data5_1.csv')) {
  download.file(fileURL, './data/Data5_1.csv')
}

# импортируем в объект формата data.frame
DT <- data.table(read.csv('./data/Data5_1.csv', 
                          as.is = T))


# объект: таблица исходных данных
g.tbl <- gvisTable(data = DT, 
                   options = list(width = 220, height = 400))

# объект: интерактивная карта
g.chart <- gvisGeoChart(data = DT, 
                        locationvar = 'Region', 
                        colorvar = 'IncomeGroup', 
                        options = list(width = 500, 
                                       height = 400, 
                                       dataMode = 'regions'))

# размещаем таблицу и карту на одной панели (слева направо)
TG <- gvisMerge(g.tbl, g.chart, 
                horizontal = TRUE, 
                tableOptions = 'bgcolor=\"#CCCCCC\" cellspacing=10')



# вставляем результат в html-документ
print(TG, 'chart')
