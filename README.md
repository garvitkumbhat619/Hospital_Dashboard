#  Hospital Data Analytics Dashboard

> An end-to-end hospital management analytics system built with **Power BI** and **MySQL**, delivering insights across patient care, operations, finance, inventory, and staff performance through **5 interactive dashboards**.

---

##  Project Overview

This project transforms raw hospital operational data from MySQL into interactive Power BI dashboards, giving hospital management real-time visibility into patient care, staff performance, room utilization, billing, and inventory — all in one place.

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| Database | MySQL 8.0 |
| BI & Visualization | Microsoft Power BI Desktop |
| Data Connectivity | MySQL ODBC Connector |
| Query Language | SQL (Views / Joins) |
| Data Modeling | Star Schema (Power BI Relationships) |

---

##  Database Schema

### Patient & Clinical

| Table | Description |
|---|---|
| `patient` | Demographics — name, age, gender, blood group, admission/discharge dates, status |
| `doctor` | Profiles — specialization, department, experience, salary, availability |
| `appointment` | Patient–doctor appointment linkage |
| `surgery` | Surgical records with date, time, status, and notes |
| `satisfaction_score` | Patient feedback and star ratings |

### Operational

| Table | Description |
|---|---|
| `beds` | Bed assignment — patient, occupied_from/till, status |
| `rooms` | Room type, floor, capacity, daily charge, maintenance cost |
| `department` | Department name and total staff count |

### Financial & Inventory

| Table | Description |
|---|---|
| `hospital_bills` | Full billing — room, surgery, medicine, tests, doctor fees, discounts, payment status |
| `medical_stock` | Medicine inventory — cost/unit price, qty, expiry, batch number, reorder level |
| `supplier` | Supplier details linked to medicine stock |

---

##  Dashboards & Screenshots

<!-- Add screenshot below -->
![image](https://github.com/garvitkumbhat619/Hospital_Dashboard/blob/main/Dashboard%20snaps/Screenshot%202025-09-21%20052930.png)
![image](https://github.com/garvitkumbhat619/Hospital_Dashboard/blob/main/Dashboard%20snaps/Screenshot%202025-09-21%20052943.png)
![image](https://github.com/garvitkumbhat619/Hospital_Dashboard/blob/main/Dashboard%20snaps/Screenshot%202025-09-21%20193410.png)
![image](https://github.com/garvitkumbhat619/Hospital_Dashboard/blob/main/Dashboard%20snaps/Screenshot%202025-09-21%20053052.png)
![image](https://github.com/garvitkumbhat619/Hospital_Dashboard/blob/main/Dashboard%20snaps/Screenshot%202025-09-21%20053103.png)
![image](https://github.com/garvitkumbhat619/Hospital_Dashboard/blob/main/Dashboard%20snaps/Screenshot%202025-09-21%20053124.png)

---

##  KPIs & Metrics

### Patient
| KPI | Formula / Source |
|---|---|
| Total Patients | COUNT(patient_id) |
| Currently Admitted | Patients with active bed assignment |
| Avg Length of Stay | AVG(discharge_date − admission_date) |
| Satisfaction Score | AVG(satisfaction_rating) |
| Discharge Rate | Discharged / Total × 100 |

### Operational
| KPI | Formula / Source |
|---|---|
| Bed Occupancy Rate | Occupied beds / Total beds × 100 |
| Room Utilization by Type | Occupied rooms / Total rooms per type |
| Surgery Completion Rate | Completed / Scheduled × 100 |
| Doctor Availability Rate | Available doctors / Total doctors × 100 |

### Financial
| KPI | Formula / Source |
|---|---|
| Total Revenue | SUM(total_amount) |
| Net Revenue | total_amount − discount |
| Collection Efficiency | paid_amount / total_amount × 100 |
| Pending Receivables | SUM unpaid / partial bills |
| Avg Bill per Patient | Total revenue / Billed patients |

### Inventory
| KPI | Formula / Source |
|---|---|
| Total Stock Value | SUM(stock_qty × cost_price) |
| Below Reorder Level | stock_qty < reorder_level |
| Expiry Alerts (90 days) | expiry_date ≤ TODAY() + 90 |
| Gross Margin % | (unit_price − cost_price) / unit_price × 100 |

---

##  Summary of Findings

- **Discharge trends** show consistent monthly patterns with seasonal variations, enabling proactive capacity planning.
- **Surgery charges** are the dominant revenue source, consistently outpacing room, medicine, test, and doctor fee categories.
- **Most patients (31–60 age range)** represent the core demographic for hospital services, particularly for surgical and specialist care.
- **Satisfaction ratings are high**, with 4- and 5-star ratings being the most frequent, reflecting positive patient experience overall.
- **Appointments and surgeries** are evenly distributed across the week and month, indicating stable scheduling without major bottlenecks.
- **Medicine stock and sales quantities** are tightly tracked — spikes in medicine sales correlate with seasonal admission peaks.
- **ICU and private rooms** have significantly higher occupancy rates than general wards, suggesting higher demand for specialized accommodations.
- **Staff and doctor counts** remain stable throughout the dashboard period, maintaining consistent care capacity.
- **Most patient test results** return as "Normal," suggesting effective routine care and treatment protocols.
- **Some test result fields** appear as "Blank" or incomplete, indicating gaps in diagnostic data capture that need resolution.

---

##  Key Questions Explored

| # | Question |
|---|---|
| 1 | Why do surgery charges consistently dominate other revenue categories? |
| 2 | What causes monthly spikes in medicine sales and patient discharges? |
| 3 | Do age or demographic factors influence satisfaction scores and patient outcomes? |
| 4 | How does staff count affect patient throughput and satisfaction by department? |
| 5 | Is medicine stock depletion correlated with admission peaks or illness outbreaks? |
| 6 | What improvements can be made for departments or specialties with lower patient ratings? |
| 7 | Are available beds and room types matched to patient demand throughout the year? |
| 8 | How effective are follow-up appointments in improving discharge rates and test outcomes? |
| 9 | Do certain payment methods correlate with higher billed amounts or service utilization? |
| 10 | Are there gaps in diagnostic coverage for test results still marked as "Blank"? |

---

##  Data Model

Power BI star schema with `patient` as the central hub:

```
satisfaction_score ─┐
surgery            ─┤
hospital_bills     ─┼──► patient ──► appointment ──► doctor
beds               ─┘        │
                             └──► rooms ──► department

medical_stock ──► supplier
```

**Key Relationships:**
- `patient.patient_id` → `satisfaction_score`, `surgery`, `hospital_bills`, `beds` (1:1 or 1:Many)
- `beds.room_id` → `rooms.room_id` (Many:1)
- `rooms.department_id` → `department.department_id` (Many:1)
- `appointment.doctor_id` → `doctor.doctor_id` (Many:1)
- `medical_stock.supplier_id` → `supplier.supplier_id` (Many:1)

---

## 🧾 SQL Views

### `patient_info.sql`
Flattens 9 tables into a single Power BI-ready view — patient demographics, doctor assignment, bed/room details, department, satisfaction, surgery, and billing.

### `medical_stock.sql`
Joins medicine inventory with supplier data to produce a complete stock record with pricing, quantity, expiry, and reorder levels.

---

## ⚙️ Setup & Installation

**Prerequisites:** MySQL 8.0+, Power BI Desktop, MySQL ODBC Connector

```bash
# 1. Clone the repo
git clone https://github.com/yourusername/hospital-analytics-dashboard.git

# 2. Set up the database
mysql -u root -p < schema.sql
mysql -u root -p hospital_db < seed_data.sql
```

```sql
-- 3. Create SQL views
SOURCE patient_info.sql;
SOURCE medical_stock.sql;
```

**4. Connect Power BI:**
Open `Hospital_Dashboard.pbix` → **Home → Transform Data → Data Source Settings** → update server & credentials → **Refresh**

---

## 📁 Project Structure

```
hospital-analytics-dashboard/
│
├── Hospital_Dashboard.pbix    # Power BI file — all 5 dashboards
├── patient_info.sql           # SQL view — patient, clinical & billing
├── medical_stock.sql          # SQL view — inventory & supplier
├── schema.sql                 # Database DDL
├── seed_data.sql              # Sample data
├── screenshots/               # Dashboard screenshots
│   ├── patient_overview.png
│   ├── doctor_department.png
│   ├── bed_room_occupancy.png
│   ├── medical_stock.png
│   └── billing_financial.png
└── README.md
```

> *Built to bring data-driven decision making to healthcare.*
