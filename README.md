# ETL-pipeline-for-customer-transactions
ETL Pipeline for Customer Transactions

📌 Project Overview
This project is an end-to-end ETL (Extract, Transform, Load) pipeline for processing customer transactions. The goal is to ingest raw transaction data, clean and transform it, and store it in a MySQL database for further analysis. This enables data-driven decision-making by providing insights into customer behavior, sales trends, and revenue analysis.

🛠 Tech Stack
- Programming: Python (Pandas, NumPy, SQLAlchemy, Matplotlib)
- Database: MySQL, SQL Server
- ETL Tools: Python scripts for automated extraction and transformation
- Version Control: Git & GitHub
- Visualization: Tableau, Power BI
- Automation: Cron jobs for scheduled ETL execution

📂 Project Structure
```
📁 ETL-Customer-Transactions-Project
│── cleaned_customer_transactions.zip   Compressed dataset 
│── etl_automaton.ipynb                 Automated ETL script 
│── etl_pipeline_for_customer_transaction.ipynb  Manual ETL process 
│── queries.sql                          SQL queries for insights 
│── revenue_report.pdf                   PDF report with total revenue 
│── README.md                            Project documentation 
```

🚀 How to Run the Project

1️⃣ Download & Extract Dataset
1. Download cleaned_customer_transactions.zip from this repo.
2. Extract the file to get cleaned_customer_transactions.csv.

2️⃣ Set Up MySQL Database
1. Install MySQL and create a database:
   ```sql
   CREATE DATABASE customer_transaction;
   ```
2. Create the required table:
   ```sql
   CREATE TABLE customer_transactions (
       InvoiceNo VARCHAR(20),
       StockCode VARCHAR(20),
       Description VARCHAR(255),
       Quantity INT,
       InvoiceDate DATETIME,
       UnitPrice DOUBLE,
       CustomerID BIGINT,
       Country VARCHAR(50)
   );
   ```
3. Import cleaned_customer_transactions.csv into MySQL.

3️⃣ Run the ETL Pipeline
- Open etl_pipeline_for_customer_transaction.ipynb or etl_automaton.ipynb in Jupyter Notebook.
- Run all the cells to execute the ETL process.
- This will extract, transform, and load customer transactions into MySQL.

4️⃣ Run SQL Queries for Analysis
Execute queries from queries.sql to analyze data. Example:
```sql
SELECT ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue FROM customer_transactions;
```

5️⃣ Generate Revenue Report (PDF)
- Run etl_automaton.ipynb to generate a revenue report.
- The report will be saved as revenue_report.pdf.

📊 Key Insights
- Total Revenue: $9,747,747.93
- Top-Selling Product: WORLD WAR 2 GLIDERS ASSTD DESIGNS
- Most Valuable Customer: Customer ID 12345
- Peak Sales Month: December 2024
- Busiest Purchase Hours: Identified using MySQL queries

📜 SQL Queries Used
- Total revenue calculation
- Top-selling products by quantity and revenue
- Most valuable customers by spending
- Monthly revenue trends
- Customer segmentation based on purchase behavior

🔮 Future Enhancements
- Automate daily ETL execution using cron jobs
- Deploy real-time dashboards using Streamlit or Power BI
- Implement predictive analytics for sales forecasting
- Integrate APIs for real-time data updates
- Automate report delivery via email notifications

🤝 Contributing
Contributions are welcome! If you find issues or have improvements, feel free to open a pull request.

🌟 If you find this project helpful, don't forget to star ⭐ the repository!
