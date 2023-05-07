--Source: https://www.kaggle.com/datasets/georgejnr/used-and-new-cars-datasets


--Rename table to 'CarsDataset'


--Drop unnecessary columns

Alter Table CarsDataset
DROP Column [F1], [MSRP]


--Break out Model column into Make and Model without the Year included

ALTER TABLE CarsDataset
ADD [MakeModel] nvarchar(255)

Update CarsDataSet
SET [MakeModel] = Substring([Model], Charindex(' ', [Model])+1, Len([Model]))

Alter Table CarsDataset
ADD [Make] nvarchar(255)

Update CarsDataSet
SET [Make] = Substring([Makemodel], 1, Charindex(' ', [Makemodel])-1)

Alter Table CarsDataset
ADD [Car Model] nvarchar(255)

Update CarsDataSet
SET [Car Model] = Substring([MakeModel], Charindex(' ', [Makemodel])+1, Len([MakeModel]))

ALTER Table CarsDataset
DROP Column [Model], [MakeModel]


--Mileage column: change 'not available' to 'null', remove commas, remove mi, change to integer

Update CarsDataSet set [Mileage] = Replace([Mileage],',','') FROM CarsDataset

Update CarsDataSet set [Mileage] = Replace([Mileage],' mi.','') FROM CarsDataset

Update CarsDataset set [Mileage] = Replace([Mileage],'Not available','0') FROM CarsDataset

Alter Table CarsDataSet
Alter Column [Mileage] int


--Status column: change all rows with 'certified' to 'Used'. *All rows with 'Certified' have Mileage > 0

Update CarsDataSet set [Status] = 'Used'
FROM CarsDataSet
WHERE [Status] LIKE '%Certified%'


--Price column: change to integer

Alter Table CarsDataSet
Alter Column [Price] bigint


--View revised dataset

select * FROM CarsDataset
WHERE [Year] = '2022'
