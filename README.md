# Corporate Relational Database Design & Optimization

[![UFRRJ](https://img.shields.io/badge/UFRRJ-Computer%20Science-blue)](https://portal.ufrrj.br/)
[![License](https://img.shields.io/badge/license-MIT-green)](#)

## 🎓 Academic Context & Overview
This project was developed as a collaborative academic assignment for the **Universidade Federal Rural do Rio de Janeiro (UFRRJ)**. 

The core objective was to simulate a real-world data engineering scenario by designing a robust Relational Database Management System (RDBMS) for a fictional corporation. The project covers the entire database lifecycle: from conceptual data modeling and schema architecture to data population and query execution optimization. 

---

## 🛠️ Tech Stack & Skills Demonstrated
*   **Languages & Tools:** SQL (DDL, DML, DQL), RDBMS (e.g., PostgreSQL / MySQL / Oracle).
*   **Data Modeling:** Entity-Relationship Diagrams (ERD), defining Primary/Foreign Keys, and enforcing referential integrity.
*   **Database Normalization:** Ensuring strict adherence to 1NF, 2NF, and 3NF to eliminate data redundancy and anomalies.
*   **Query Optimization:** Architecting and revising over 20 complex queries to ensure rapid execution and efficient resource utilization.

---

## 🚀 Pipeline & Methodology

### 1. Schema Architecture & Normalization
*   **Design:** Architected a high-integrity schema structured around the operational needs of a corporate entity (e.g., managing employees, departments, projects, and resources).
*   **Constraints:** Enforced strict data constraints (`NOT NULL`, `UNIQUE`, `CHECK`) and cascading rules to maintain absolute data consistency across related tables.
*   **Normalization:** The entire schema was systematically normalized up to the Third Normal Form (3NF), minimizing duplicated data and preventing update/deletion anomalies.

### 2. Data Population
*   **Mock Data Generation:** Developed robust `INSERT` scripts to populate the tables with realistic corporate data.
*   **Volume & Testing:** Sized the mock datasets appropriately to accurately stress-test the relationships and prepare the environment for performance benchmarking.

### 3. Query Execution & Optimization
*   **Comprehensive Querying:** Designed over 20 specialized SQL queries, ranging from simple aggregations to complex multi-table `JOIN`s, subqueries, and window functions.
*   **Performance Tuning:** Each query was heavily revised for speed and efficiency, ensuring optimal execution plans by leveraging appropriate indexing strategies and avoiding common bottlenecks like Cartesian products.

