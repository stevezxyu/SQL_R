# 使用 R 語言與讀取資料庫表格
getwd()      # 回傳輸出檔案的位置
write.csv(cars, file = "cars.csv")    # 輸出為 csv的檔案

cars_df <- read.csv("cars.csv")       # 輸入 csv的檔案
plot(iris)   # 畫圖

# 下載 RMySQL 套件
# 載入 DBI 套件
install.packages("RMySQL")
library("DBI", lib.loc = "~/R/win-library/3.4")

# 利用 `dbConnect()` 建立連線
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "world",
                 host = "rsqltrain.ced04jhfjfgi.ap-northeast-1.rds.amazonaws.com",
                 port = 3306,
                 user = "trainstudent",
                 password = "csietrain")

# 列出資料庫中所有的表格
dbListTables(con)       # output table of database

# 中斷連線
dbDisconnect(con) # 重要！


# 使用 DBI 套件中的各種函數來完成我們的任務
# dbConnect() 是建立連線的函數
# dbListTables() 是列出資料庫中所有表格的函數
# dbDisconnect() 是中斷 R 語言與資料庫的連線（重要！）


country <- dbReadTable(con, "country")   # 將 country回傳成 dataframe
View(country)       # 輸出一個表格
dbDisconnect(con)   # 每次做完隨手做中斷連線, 不占流量
class(country)      # country的類別是一個 dataframe

# 其他函數功能
head(country)     # 回傳前6個 row
tail(country)     # 回傳前6個 column
dim(country)      # 回傳前6個 row和 column
summary(country)  # 敘述性統計
names(country)    # 回傳名稱
str(country)      # 告訴每個變數的type, 統計等等


# 實務上的作法絕大多數是讀取資料庫表格的部分資料
# dbGetQuery()
library(DBI)

con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "world",
                 host = "rsqltrain.ced04jhfjfgi.ap-northeast-1.rds.amazonaws.com",
                 port = 3306,
                 user = "trainstudent",
                 password = "csietrain")

twn <- dbGetQuery(con, statement = "SELECT * FROM country WHERE Name = 'Taiwan'")
                      # statement 內撰寫SQL條件語法做選取
twn

dbDisconnect(con)


# 練習
# 在 R 語言中將 country 表格的歐洲國家選出來存成一個名為 europe 的資料框
library(DBI)

con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "world",
                 host = "rsqltrain.ced04jhfjfgi.ap-northeast-1.rds.amazonaws.com",
                 port = 3306,
                 user = "trainstudent",
                 password = "csietrain")

europe_Query <- "SELECT * FROM country WHERE Continent ='Europe'"
europe <- dbGetQuery(con, statement = europe_Query)
dbDisconnect(con)

# 看看 europe
dim(europe)
head(europe)

