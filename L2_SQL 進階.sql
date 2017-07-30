select
	Name,
    Population
    from world.country
    order by Population desc      # 未設定是 asc 遞增排序, desc 是遞減排序
    limit 10;
    
# 找出歐洲土地面積最小的 10 個國家
select
	Name,
    Continent,
    SurfaceArea
    from world.country
    where Continent = 'Europe'
    order by SurfaceArea
    limit 10;
    
# sum() 是聚合函數
# 回傳加總值
# 全世界總人口數
select
	Continent,
    sum(Population) as sum_pop    # as 可取暫代名稱
    from world.country
    group by Continent       # group by 各大洲的資料
	order by sum_pop desc;   # order by 要寫在 group by 後面

# DISTINCT() 函數
# 回傳相異值
# 快速找出變數的相異值
select
	distinct(Continent) as dist_cont
    from world.country;

# COUNT() 函數
# 計算有多少國家的人口超過 1 億
SELECT COUNT(*)
  FROM world.country
  WHERE Population > 100000000;

# SUBSTR() 函數
# 擷取某部分的文字
SELECT SUBSTR(Name, 1, 3) AS short_name,    # 從第1個英文字母擷取3個字母
	Name
    FROM world.country
    LIMIT 10;

# CONCAT() 函數
# 連結文字
select Region,
	Continent,
    concat(Region, ' ', Continent) as concat_reg
    from world.country;
    
# UPPER() 函數
# 轉換文字為大寫
select upper(Name) as Cap_Name
    , Name
    from world.country
    limit 10;

# 文字為小寫
select lower(Name) as Cap_Name
    , Name
    from world.country
    limit 10;
    
# LENGTH() 長度函數
# 計算地區名稱的長度數
select
	Region,
    Continent,
    length(Region) as concat_reg
    from world.country;
    
# COUNT() 函數加入 GROUP BY 敘述
# 計算各個 Continent 的國家數
select
	Continent,
    count(*) as no_countries
    from world.country
    group by Continent
    order by no_countries desc;
    
# COUNT() 函數加入 GROUP BY 敘述
# 計算各個 Region 人口超過 1 千萬的國家數
select
	Region,
    count(*) as no_countries
    from world.country
    where Population > 10000000
    group by Region
    order by no_countries desc;
    
# HAVING() 函數
# 針對聚合函數下條件
# 找出總人口數超過 1 億的洲（Continent）

/*錯誤*/
/*
SELECT Continent
       ,SUM(Population) AS Sum_of_Population
  FROM world.country
  GROUP BY Continent
  WHERE Sum_of_Population > 100000000;
*/

/*正確*/
select
	Continent,
    Sum(Population) as Sum_of_Population
    from world.country
    group by Continent
    having Sum_of_Population > 1000000;      # 使用聚合函數作篩選


# 一般分兩段寫
select Population
	from world.country
    where Name = 'United States';
    
select Name
	from world.country
	where Population > 278357000;
    

# 另一種方法, 做子查詢, 合併寫法
select Population
	from world.country
    where Name = 'United States';
# 上方code貼入子查詢的()
select Name
	from world.country
	where Population > (
		select Population
			from world.country
			where Name = 'United States'
    );

# 隨堂練習
# 找出跟 Azerbaijan 屬於同一個洲的國家
select name
	from world.country
    where Continent = (
		select Continent
			from world.country
            where name = 'Azerbaijan'
    );

# 老師解法
select 
	Continent
    from world.country
    where name = 'Azerbaijan';
# 上方code貼入子查詢的()
select
	name
    from world.country
    where Continent = (
		select 
			Continent
		from world.country
		where name = 'Azerbaijan'
    );

/* 
JOIN 描述
也許是關聯式資料庫最重要的技巧！
聯結的種類：
Inner Join（內部聯結）
Left Join（左外部聯結）
Right Join（右外部聯結）
Full Join（全外部聯結）（MySQL 不支援）
*/

# 內部聯結
# 取左表格（台灣、日本）跟右表格（台灣、南韓）的交集（台灣）
/*左表格*/
SELECT * FROM world.country
    WHERE Name IN ('Taiwan', 'Japan');

/*右表格*/
SELECT * FROM world.city
    WHERE CountryCode IN ('TWN', 'KOR');

# 取左表格（台灣、日本）跟右表格（台灣、南韓）的交集（台灣）
/*內部聯結*/
select 
	country.Code,                     # table名稱可以隨意取名
    city.Name
	from world.country country     # 取名 country
    inner join (
		select *
			from world.city
            where CountryCode in ('TWN', 'KOR')
    ) city     # 取名 city
	on country.Code = city.CountryCode           # 使用 on 來合併兩個欄位的準則
    where country.Code in ('TWN', 'JPN');        # 左表格和右表格有交集會重複擷取, 若是改為'JPN' 找不到值可交集, 就會變成僅留遺漏值'TWN'

# UNION 描述
# JOIN 是屬於水平合併
# UNION 是屬於垂直合併
SELECT Name
    FROM world.country
    WHERE Code = 'TWN'
UNION
SELECT Name
    FROM world.city
    WHERE CountryCode = 'TWN';


# 請寫出能夠產出以下結果的 SQL 查詢：
# 練習 1
select 
	Continent,
	Sum(Population) as Sum_of_Population
    from world.country
	where Continent in ('Asia', 'Europe', 'South America')
    group by Continent;          # 要把 Continent 做 group by
    
# 練習 2
select
	Continent,
    max(Population) as Max_Population
    from world.country
    group by Continent;

# 練習 3
# 找出跟阿根廷（Argentina）或澳大利亞（Australia）同一個洲的國家，並以國家名稱排序
select
	Continent
    from world.country
    where Name in ('Argentina', 'Australia');

select 
	Name,
    Continent
    from world.country
    where Continent in (
		select
			Continent
    		from world.country
			where Name in ('Argentina', 'Australia')
    );

# 練習 4
select
	city.Name as City,
    country.name as Country,
    country.Continent
    from (
		select
			CountryCode,
            Name
            from world.city
            where CountryCode = 'TWN'
    ) city
    left join (
		select
			Code,
            Name,
            Continent
            from world.country
            where Code = 'TWN'
    ) country
    on city.CountryCode = country.Code;

# 練習 5
# 做法 1
select
	city.Name as City,
    country.name as Country,
    country.Continent
    from (
		select
			CountryCode,
            Name
            from world.city
            where CountryCode = 'TWN'
    ) city
    left join (
		select
			Code,
            Name,
            Continent
            from world.country
            where Code = 'TWN'
    ) country
    on city.CountryCode = country.Code
union
select
	city.Name as City,
    country.name as Country,
    country.Continent
    from (
		select
			CountryCode,
            Name
            from world.city
            where CountryCode = 'USA'
    ) city
    left join (
		select
			Code,
            Name,
            Continent
            from world.country
            where Code = 'USA'
    ) country
    on city.CountryCode = country.Code;

# 做法 2
select
	city.Name as City,
    country.name as Country,
    country.Continent
    from (
		select
			CountryCode,
            Name
            from world.city
            where CountryCode in ('TWN', 'USA')
    ) city
    left join (
		select
			Code,
            Name,
            Continent
            from world.country
            where Code in ('TWN', 'USA')
    ) country
    on city.CountryCode = country.Code;

