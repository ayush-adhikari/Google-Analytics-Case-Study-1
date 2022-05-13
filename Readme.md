# Google Data Analytics Capstone Project (Divvy_Trips)

This case study was completed as a part of the capstone project of Google Data Analysis Project.
The entire process was divided into 6 phases ie.
	1) Ask
	2) Prepare
	3) Process
	4) Analyse
	5) Share
	6) Act

### 1) Ask (Objectives)

Answers to three questions were asked by the company shareholders and the queestion I had to answer was
		" How do annual members and casual riders use Cyclistic bikes differently? "

### 2) Prepare

Relevant data from the Data Source (https://divvy-tripdata.s3.amazonaws.com/index.html) was gathered.
As it was the clients own website, its credibilty was not doubted.
The data was segregated on the basis of months.
It was cleaned as there were a lot of discrepancies in it. The details are mentioned in the powerpoint file attached.
File for the sql code is present in this file - "data cleaning.sql".

### 3) Process

SQL Server was chosen as the DBMS to go forward with. After importing each field was checked for anomalies and if found were deleted.
Two fields were created to assist the analysis phase. These were the 'total ride_length in mins' field and the 'weekday' field.
Table manipulations scripts can be found here - "table manipulation.sql".

### 4) Analyze

In this phase, queries were created to uncover trends that were highlighted in the data visualisations.
The sql scripts can be found here - "data analysis.sql".

### 5) Share

Visualisations were created using Tableau Desktop and the workbook file can be found here - "Case_Study_1.twbx".
These visualisations are also included in the ppt.

### 6) Act

A powerpoint presentation was compiled - Comparison of Ride Pattern of Membership Holders and Casual Riders.pptx.
All the findings and key takeaways are mentioned there.




