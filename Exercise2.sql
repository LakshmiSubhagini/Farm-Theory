---Loading Exercise 2 salesData table onto table named datatable2---
use practicedb;
create table datatable2 (selling_date varchar(100),customer_id
varchar(100),sku_name
varchar(100),sku_quantity
float,total_revenue
float);
use practicedb;
LOAD DATA INFILE 'D:/Farm theory/ex2datatable.csv'
INTO TABLE datatable2
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
use practicedb;
select * from datatable2;

---Loading Exercise 2 BuyingData table onto table named datatable3---
use practicedb;
create table datatable3 (buying_Date
varchar(100),sku_name
varchar(100),buying_price
int); 
use practicedb;
LOAD DATA INFILE 'D:/Farm theory/ex2datatable2.csv'
INTO TABLE datatable3
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
use practicedb;
select * from datatable3;
---1.Selling price of each sku = totalRevenue/skuQuantity---
use practicedb;
select distinct(selling_date),customer_id,sku_name,(total_revenue/sku_quantity) as sellingPrice from datatable2;
---end--
---2.Total customer Bill on respective dates---
use practicedb;
select selling_date,sum(total_revenue) as TotalCustomerBill from datatable2 group by selling_date;
---end--
---3.Left joining sales data table and buying data table (on sku name and selling date=(1+buying date))---
use practicedb;
alter table datatable2 modify column selling_date date; 
use practicedb;
update datatable2 set selling_date=str_to_date(selling_date,'%d-%m-%Y');
use practicedb;
alter table datatable3 modify column buying_Date date;
use practicedb;
update datatable3 set buying_Date=str_to_date(buying_Date,'%d-%m-%Y');
use practicedb;
select datatable2.selling_date,datatable2.customer_id,datatable2.sku_name,datatable2.sku_quantity,datatable2.total_revenue,datatable3.buying_price from datatable2 left join datatable3 on datatable2.sku_name=datatable3.sku_name and datatable2.selling_date=(1+datatable3.buying_Date);
---end---
---4.Gross Margin=1-(bp/sp) ---
use practicedb;
select distinct(datatable2.sku_name),(1-(datatable3.buying_price/(datatable2.total_revenue/datatable2.sku_quantity))) as GrossMargin from datatable2 inner join datatable3 on datatable2.sku_name=datatable3.sku_name;
---end---
---5.Highest selling gross margine sku on respective date---
use practicedb;
select datatable2.selling_date,datatable2.sku_name,(1-(datatable3.buying_price/(datatable2.total_revenue/datatable2.sku_quantity))) as MaximumGrossMargine from datatable2 inner join datatable3 on datatable2.sku_name=datatable3.sku_name order by (1-(datatable3.buying_price/(datatable2.total_revenue/datatable2.sku_quantity))) desc limit 1;
---end---
--6.--
use practicedb;
select datatable2.selling_date,datatable2.customer_id,datatable2.sku_name,datatable2.sku_quantity,datatable2.total_revenue,datatable3.buying_price from datatable2 left join datatable3 on datatable2.sku_name=datatable3.sku_name and datatable2.selling_date=datatable3.buying_Date;
---end---