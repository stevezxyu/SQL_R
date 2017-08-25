# 讀取不同的資料格式
# 讀取 txt
url <- "https://storage.googleapis.com/r_rookies/iris.csv" # 在雲端上儲存了一份 csv 檔案
iris_csv_df <- read.table(url, sep = ",", header = TRUE,
                          colClasses = c("numeric", "numeric", "numeric",
                                         "numeric", "character"))    # 更改向量中元素的 type
#欄位屬性可以在讀取資料時設定，指定 colClasses = 這個參數，輸入一個字串向量。

head(iris_csv_df)
View(iris_csv_df)
str(iris_csv_df)

# tsv 是 tab-separated values 的縮寫
# sep = "\t" 告訴 R 語言變數之間的分隔符號是 tab 鍵
url <- "https://storage.googleapis.com/r_rookies/iris.tsv" # 在雲端上儲存了一份 tsv 檔案
iris_tsv_df <- read.table(url, sep = "\t", header = TRUE)
head(iris_tsv_df)

# \t, \n
writeLines("Hello R!")
writeLines("Hello \tR!")
writeLines("Hello \t\t\tR!")
writeLines("Hello \nR!")

# sep = ":" 這個參數告訴 R 語言變數之間的分隔符號為冒號
url <- "https://storage.googleapis.com/r_rookies/iris.txt" # 在雲端上儲存了一份 txt 檔案
iris_colon_sep_df <- read.table(url, sep = ":", header = TRUE)
head(iris_colon_sep_df)


# 載入 Excel 試算表
install.packages("readxl")
library(readxl)

download_path <- "~/Downloads/iris.xlsx"
iris_xlsx_df <- read_excel("C:/Users/user/Downloads/iris.xlsx")   # R 語言預設的路徑是採用/ , 而非 \


# 使用 haven() 套件中的 read_sas() 函數可以載入 SAS 資料集
install.packages("haven")
library(haven)

smoking_sas_data <- read_sas("http://storage.googleapis.com/r_rookies/smoking.sas7bdat")


# 載入 JSON
friends_json <- '{
  "genre": "Sitcom",
"seasons": 10,
"episodes": 236,
"stars": ["Jennifer Aniston", "Courteney Cox", "Lisa Kudrow", "Matt LeBlanc", "Matthew Perry", "David Schwimmer"]
}'

starring_json <- '[
  {"character": "Rachel Green", "star": "Jennifer Aniston"},
{"character": "Monica Geller", "star": "Courteney Cox"},
{"character": "Phoebe Buffay", "star": "Lisa Kudrow"},
{"character": "Joey Tribbiani", "star": "Matt LeBlanc"},
{"character": "Chandler Bing", "star": "Matthew Perry"},
{"character": "Ross Geller", "star": "David Schwimmer"}
]'

install.packages("jsonlite")
library(jsonlite)

friends_list <- fromJSON(friends_json)
friends_list$seasons   # 印出 List內 seasons的內容
paste("六人行有", friends_list$seasons, "季")
friends_df <- fromJSON(starring_json)   # 將 data.frame的資料回傳
View(friends_df)

class(friends_list)
nchar(friends_json)

# 使用 dplyr 套件整理資料
install.packages("dplyr")     # 若是沒主動安裝 DBI和lazyeval, 須在手動下載安裝這兩個套件 
install.packages("DBI")
install.packages("lazyeval")
library(dplyr)

# 選出女性船員
load(url("https://storage.googleapis.com/r_rookies/straw_hat_df.RData"))
filter(straw_hat_df, gender == "Female")
filter(straw_hat_df, gender == "Female" & age >= 30)

# select() 選擇資料框中的變數
load(url("https://storage.googleapis.com/r_rookies/straw_hat_df.RData"))
select(straw_hat_df, name, gender)

# 使用 %>% 運算子
# 可以操作成像是 SQL 的查詢指令
# 選出女性船員，但只回傳 name 變數
load(url("https://storage.googleapis.com/r_rookies/straw_hat_df.RData"))
straw_hat_df %>%
  filter(gender == "Female") %>%
  select(name)

View(straw_hat_df)   # 查看 data.frame內的資料內容

today_date <- Sys.Date()
class(today_date)    # 確認 type

today_year <- format(today_date, "%Y")
today_year_int <- as.integer(today_year)   # 字串轉換成整數
today_year_int   # 確認已轉換
birth_year <- today_year_int - straw_hat_df$age

# 縮短的寫法
birth_date <- Sys.Date() %>%
  format("%Y") %>%
  as.integer %>%
  `-` (straw_hat_df$age) %>%
  paste(straw_hat_df$birthday, sep ="-") %>%
  as.Date

straw_hat_df$birthDate <- birth_date  # 字串換換完整束後, 新增一個欄位
View(straw_hat_df)   # 確認 data.frame的內容是否有成功新增欄位
str(straw_hat_df)    # 確認資料的結構
max(straw_hat_df$birthDate)   # 找出最大值

# 新增出生年（birth_year）變數
# 利用系統日期減去年紀
straw_hat_df <- straw_hat_df %>%
  mutate(
    age_2_years_ago = age - 2
    )

