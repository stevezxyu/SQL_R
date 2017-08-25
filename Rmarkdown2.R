#Rhttp://rmarkdown.rstudio.com/ 此套件可以輸出html, word, pdf檔
#1.更新最新RStudio
#2.左上方"+" -> R Markdown安裝
#3.寫Tittle, Author, 選擇輸出類型
#4.output: html_document 可更改輸出檔案類型
#5.Knit匯出檔案

#plot()  顯示散布圖
#summary()  顯示統計值
#```{r}  顯示程式碼

#```{r echo=FALSE}  不顯示程式碼
#```{r results='hide'} 隱藏結果

#```{r warnning=FALSE} 把warnning隱藏
#as.integer("Hello")  顯示Warnning
#```

#```{r error=TRUE} 把error顯示
#1 + "Hello"
#```

#```{r message=FALSE, warning=FALSE}  其他的資訊和warnning都隱藏
#library(ggplot2)
#ggplot(cars, aes( x = speed))+
#  geom_histogram()
#```

#[CRAN] http://rmarkdown.rstudio.com/  增加超連結;直接放網址也可以

#![](http://8comic.se/wp-content/uploads/2015/09/%E9%80%B2%E6%93%8A%E7%9A%84%E5%B7%A8%E4%BA%BA.jpg)  放網路上的圖片