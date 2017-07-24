show databases;    
# 預設的database, 使用"show"顯示出來
# 英文字母大小寫無差異
# ";"表示 Query動作已結束

use world;
show tables;
# 上課僅會使用到 city, country

# * 意指所有的欄位
select *
	from world.country;

select Code
	, Name
    , Continent
  from world.country;
  
# 其他用法, 實務上data不會只在同一個DB (不建議使用)
USE world;
SELECT *
  FROM country;  

select *
	from world.country
    limit 10;
	# limit 可限定輸出的資料列數, 僅回傳前10列筆資料 

select count(*)   # COUNT(*) 計算表格有幾列
	from world.country;
	# country 有239個row的資訊


# information_schema , schema是指規格
use information_schema;
show tables;

select count(*)
	from information_schema.COLUMNS
    # limit 10;
	where TABLE_NAME = "country";    # 紀錄 country的所有資訊
    # 印出所有資料的列數


# 計算衍生欄位
select *
    ,Population / SurfaceArea AS Density
	from world.country
	limit 10;

# 檢驗衍生欄位
select Population,
	SurfaceArea,
    Population / SurfaceArea As Pop_Density
	from world.country
    limit 10;

# 使用where, 把 Taiwan 選出來
select *
	from world.country
    where Name = "Taiwan";     # ""內是一個string
	# SQL中無指派的命令, 所以等於是一個"="

# 選擇多個國家，使用 IN 這個關鍵字
select *
	from world.country
	# where Name in ('Taiwan', 'Japan', 'South Korea', 'China');
	where Name not in ('Taiwan', 'Japan', 'South Korea', 'China');     # 負面表列，使用 NOT IN 這個關鍵字

select *
	from world.country
	# where Population > 200000000;        # 用數字篩選
    where Population between 100 and 10000;      # 使用 BETWEEN 找出人口介於 100 與 1 萬的國家
    
# 使用 LIKE 與 % 對字串進行模糊比對
# United 開頭的國家
select *
	from world.country
	# where Name like 'United%';      # United + 字串
	# where Name like '%land';        # 字串 + land
    where Name like 'T%n';            # T + 字串 + n
    
# 找出剛好由四個字母組成的國家
select *
	from world.country
    where Name like '____'
    and Continent = 'Asia';           # 使用 AND 交集兩個以上的條件
    
# 
select *
	from world.country
    where Population > 100000000
    or Population < 10000;            # 使用 OR 聯集兩個以上的條件


# 請寫出能夠產出以下結果的 SQL 查詢：
# 練習 1
select 
	Name
    , Continent
    , Region
	from world.country
    where Region = 'Eastern Asia';

# 練習 2
select 
	Name
    , Continent
    from world.country
    where Name in ('Spain','Italy','Malta');

select 
	Name
    , Continent
    from world.country
    where Name like "_____"
    and Continent = "Europe";

# 練習 3
select 
	Name
    ,Population
    ,Population / SurfaceArea as Density
    from world.country
    where Population > 200000000;
    
select 
	Name
    ,Population
    ,Population / SurfaceArea as Density
    from world.country
    where Name in ('China', 'Indonesia', 'India', 'United States');
