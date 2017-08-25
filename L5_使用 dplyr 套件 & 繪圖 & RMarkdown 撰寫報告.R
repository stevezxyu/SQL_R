# 使用 dplyr 套件整理資料
install.packages("dplyr")     # 若是沒主動安裝 DBI和lazyeval, 須在手動下載安裝這兩個套件 
install.packages("DBI")
install.packages("lazyeval")
library(dplyr)

# arrange()
# 新增出生年（birth_year）變數後以出生年排序
load(url("https://storage.googleapis.com/r_rookies/straw_hat_df.RData"))
straw_hat_df %>%
  mutate(birth_year = as.integer(format(Sys.Date(), "%Y")) - age) %>%
  arrange(birth_year) %>%
  arrange(desc(birth_year))

# summarise() 計算聚合變數平均年齡 mean_age
summarise(straw_hat_df, mean_age = mean(age))

# group_by() 依照性別計算平均年齡 mean_age
straw_hat_df %>%
  group_by(gender) %>%
  summarise(mean_age = mean(age))


# inner_join()

# 左表格 straw_hat_df
load(url("https://storage.googleapis.com/r_rookies/straw_hat_df.RData"))
# 右表格 straw_hat_devil_fruit
load(url("https://storage.googleapis.com/r_rookies/straw_hat_devil_fruit.RData"))

View(straw_hat_df)
View(straw_hat_devil_fruit)

# 內部連結
joined_df <- inner_join(straw_hat_df, straw_hat_devil_fruit)
View(joined_df)

# 左外部連結 (保留左邊的欄位)
joined_df <- left_join(straw_hat_df, straw_hat_devil_fruit)

# 右外部連結 (保留右邊的欄位)
joined_df <- right_join(straw_hat_df, straw_hat_devil_fruit)

# 全外部連結 (全部都保留)
joined_df <- full_join(straw_hat_df, straw_hat_devil_fruit)


# sqldf 套件
install.packages("sqldf")
library(sqldf)
sqldf("select * from straw_hat_df where gender = 'Female'")


# 簡單的繪圖（Base plotting system）
data()   # 顯示 R語言的 datasets 紀錄, 可以看有哪些玩具資料可以直接使用

?cars #help(cars)
?iris #help(iris)
?mtcars #help(mtcars)

# 使用函數觀察玩具資料
head(cars)
tail(cars)
dim(cars)
nrow(cars)
ncol(cars)
summary(cars)
str(cars)


# 散佈圖, 描述數值的關係
# plot() 繪製散佈圖
plot(cars$speed, cars$dist, main = "Car speed vs. braking distance", xlab = "Speed", ylab = "Dist")
# title("Car speed vs. braking distance")

# 線圖, 描述數值與時間的關係
# plot(..., type = "l") 繪製線圖
temperature <- round(runif(30) * 10 + 25)   # 僅有數字
dates <- as.Date("2017-06-01"):as.Date("2017-06-30")    # 轉換為 Date格式
dates <- as.Date(dates, origin = "1970-01-01")
plot(x = dates, y = temperature, type = "l")        # type = "l" 是折線圖

# hist() 繪製直方圖
par(mfrow = c(1, 2)) # 建立一個 1x2 的網格畫布
hist(cars$speed, main = "Distribution of speed variable", xlab = "Speed")
hist(cars$dist, main = "Distribution of dist variable", xlab = "Dist")

# 繪製標準常態分佈與均勻分布
# runif() 函數可以幫你產生 0 到 1之間均勻分配的隨機數
# rnorm() 函數可以幫你產生標準常態分配的隨機數
n <- 100
par(mfrow = c(2, 1)) # 建立一個 2x1 的網格畫布
hist(runif(n), main = paste("Distribution of", n, "uniformly distributed variables")) # 試著增加隨機數的個數 n
hist(rnorm(n), main = paste("Distribution of", n, "normally distributed variables")) # 試著增加隨機數的個數 n

# 盒鬚圖, 綜合直方圖和 group by的功能, 需要使用類別來顯示
# boxplot() 繪製盒鬚圖, 使用 ~ 運算子將類別變數納入
str(iris)
par(mfrow = c(2, 2))
boxplot(iris$Sepal.Length ~ iris$Species, main = "Sepal length by species")
boxplot(iris$Sepal.Width ~ iris$Species, main = "Sepal width by species")
boxplot(iris$Petal.Length ~ iris$Species, main = "Petal length by species")
boxplot(iris$Petal.Width ~ iris$Species, main = "Petal width by species")

# 函數圖
# curve() 繪製函數圖
curve(sin, from = -pi, to = pi)
grid()   # 增加網格狀

# 自訂的函數圖
sigmoid_func <- function(x){
  return(1 / (1 + exp(-x)))
}
curve(sigmoid_func, from = -10, to = 10)
abline(h = 0.5, lty = 2)
abline(v = 0, lty = 2)
grid()


# 長條圖
# barplot() 繪製長條圖
tbl_gear <- table(mtcars$gear)
barplot(tbl_gear, main = "Vehicle counts by gear types",
        xlab = "Gear", ylab = "Vehicle counts")

# table 是 R語言中的樞紐分析功能
table(barplot$gear)
barplot(table(mtcars$gear))
View(mtcars)

par(mfrow = c(1, 1))
sorted_mtcars <- mtcars[order(mtcars$hp), ]

# 長條圖（2）, 不只能呈現 count
vehicle_names <- row.names(mtcars)
barplot(mtcars$hp, names = vehicle_names,
        main = "Horse power of each vehicle", xlab = "Horse power",
        horiz = TRUE, las = 1, cex.names = 0.5)       # las = 1 , x軸與y軸呈現水平

# 在 bar 上方顯示數值
y_lim <- c(0, 1.2 * max(table(mtcars$gear)))
bar_plt <- barplot(table(mtcars$gear), main = "Vehicle counts by gear types", xlab = "Gear", ylab = "Vehicle counts", ylim = y_lim)
text(x = bar_plt, y = table(mtcars$gear), label = table(mtcars$gear), pos = 3)


# 氣泡圖
# 首先準備資料 country
install.packages("RMySQL")
library(RMySQL)
library(DBI)

con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "world",
                 host = "rsqltrain.ced04jhfjfgi.ap-northeast-1.rds.amazonaws.com",
                 port = 3306,
                 user = "trainstudent",
                 password = "csietrain")
country <- dbReadTable(con, "country")
dbDisconnect(con)

# 利用 symbols() 函數繪畫
symbols(country$GNP, country$LifeExpectancy, circles = sqrt(country$Population / pi),
        bg = factor(country$Continent), fg = "white",
        xlab = "Income", ylab = "Life Expectancy")

# 將 ylab 轉換成水平
?mtext
plot(cars, ylab = "")
mtext("Dist", side = 2, las = 1, line = 2)

