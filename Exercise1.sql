---Loading Exercise 1 table onto table named datatable1---
create database practicedb;
use practicedb;
create table datatable1 (Customer varchar(100),SKUId varchar(100),SKU
varchar(100),SP int,QUANTITY int);

use practicedb;
LOAD DATA INFILE 'D:/Farm theory/ex1datatable.csv'
INTO TABLE datatable1
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
use practicedb;
select * from datatable1;
---Loading Exercise 1 table containing columns like SKU,SP,BP,Volume onto table named datatable4---
use practicedb;
create table datatable4 (SKU
 varchar(100),BuyingPrice int,SellingPrice int,Volume
int);
use practicedb;
LOAD DATA INFILE 'D:/Farm theory/ex1datatable2.csv'
INTO TABLE datatable4
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
use practicedb;
select * from datatable4;
---Loading Exercise 1 supplier table onto table named datatable5---
use practicedb;
create table datatable5 (sku varchar(100),supplier varchar(100));
LOAD DATA INFILE 'D:Farm theory/ex1datatable3.csv'
INTO TABLE datatable5
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
use practicedb;
select *from datatable5;
--1.Average Selling Price of each SKU
use practicedb;
select SKU,avg(SP) as average_sp_of_sku from datatable1 group by SKU order by SKU;
--end---
--2.Gross Margin of eack SKU's--
use practicedb;
select SKU,1-(datatable4.BuyingPrice/datatable4.SellingPrice) as GrossMargin from datatable4 order by SKU;
---end---
--3.Map respective supplier names infront of SKU'S--
use practicedb;
select distinct(datatable1.SKU),datatable5.supplier from datatable1 left join datatable5 on datatable1.SKU = datatable5.sku order by datatable1.SKU;
---end--
--4.SKU's with BP > 65 and SP > 65--
use practicedb;
select distinct(datatable4.SKU) from datatable4 where datatable4.BuyingPrice>65 and datatable4.SellingPrice>60;
---end---
--5.SKU's with GrossMargin% >10%(10%=10/100=0.1) or GrossMargin<0---
use practicedb;
select SKU,((SellingPrice*Volume)-(BuyingPrice*Volume))/(SellingPrice*Volume) as GrossMarginPercentage from datatable4 where ((SellingPrice*Volume)-(BuyingPrice*Volume))/(SellingPrice*Volume)<0.1 or ((SellingPrice*Volume)-(BuyingPrice*Volume))/(SellingPrice*Volume)<0;
---end---
--7.Customer with maximum orders----
use practicedb;
select max(Customer) as CustomerWithMaximumOrders from datatable1;
---end--
--8.Overall Gross Margin % (avg of Gross Margin %)---
use practicedb;
select avg((((SellingPrice*Volume)-(BuyingPrice*Volume))/(SellingPrice*Volume))*100) as OverallGrossMarginPercentage from datatable4;
---end---