# 🏢 Hostel Management System

A database-driven hostel management system built with **Flutter**, **PHP**, and **MySQL**, designed exclusively for administrative use. This project enables hostel staff to manage student records, allocate rooms, track fee payments, and analyze hostel statistics with ease through a responsive mobile interface. Documentation of this project is included here.

---

## 📁 Repository Structure

This repository contains three folders:

1. **`hostel db api/`**  
   - Contains all **PHP APIs** required for frontend-backend communication.  
   - 📥 Copy and paste this folder into:  
     `C:\xampp\htdocs`

2. **`MySQL database/`**  
   - Includes the SQL dump for the **MySQL database schema and data**.  
   - 📥 Import this into **MySQL Workbench** or **phpMyAdmin**.  
   - Make sure the database name is: `hosteldb`

3. **`Flutter project/`**  
   - Contains the **entire frontend source code** of the app developed using **Flutter**.  
   - You can run and test the app on Android, iOS, or emulator.

---
## 📱 Screenshots

> _📌 Screenshots are resized for better visibility._

---

### 🏨 Hostel and Room Navigation

<img src="https://github.com/user-attachments/assets/fbf8de31-fab3-46bc-acb7-7f6814be15c0" width="500"/>
<img src="https://github.com/user-attachments/assets/e2cd24bd-0344-4a90-b3d5-0ff026560f46" width="500"/>
<img src="https://github.com/user-attachments/assets/799b6d17-84b1-43c4-be20-080e1b7f991a" width="500"/>

---

### 🧑‍🎓 Student Management

<img src="https://github.com/user-attachments/assets/c5875221-e401-4ce3-8d87-a3cdd149b3e6" width="500"/>
<img src="https://github.com/user-attachments/assets/a98f5950-bf4e-4dfd-aa9a-916b2fb61069" width="500"/>
<img src="https://github.com/user-attachments/assets/d7f81af3-ce51-492d-b99e-d37448a85182" width="500"/>
<img src="https://github.com/user-attachments/assets/78a91a4e-6925-4d05-90d8-b4a8589a7586" width="500"/>

---

### 🔍 Student Search

<img src="https://github.com/user-attachments/assets/2f4c3347-6678-4ae4-b384-f4d6e8366910" width="500"/>

---

### 💰 Fee Management

<img src="https://github.com/user-attachments/assets/5743aaed-08ad-4336-a263-c4397341b84c" width="500"/>

---

### 📊 Fee Analysis

<img src="https://github.com/user-attachments/assets/09721535-986f-4bfa-8736-65e879579597" width="500"/>

---

### 🧑‍🏫 Warden Management

<img src="https://github.com/user-attachments/assets/8594ce1b-dc0c-4874-98cf-780d166ab688" width="500"/>

## ⚙️ Features

- View hostel and room occupancy  
- Manage student records (Add, Edit, Delete)  
- Room allocation from only free rooms  
- Gender is auto-detected from room ID  
- Search students by name  
- View and update student fee status  
- Warden management screen  
- Pie chart for analyzing fee summary  
- Built entirely in Flutter (admin-only interface)

---

## 🛠️ Tech Stack

| Layer        | Technology           |
|--------------|----------------------|
| Frontend     | Flutter              |
| Backend API  | PHP                  |
| Database     | MySQL                |
| Tools        | phpMyAdmin, Postman, Git, GitHub |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK  
- PHP (e.g., via XAMPP)  
- MySQL Workbench or phpMyAdmin  
- VS Code / Android Studio

### Setup Steps

1. **Clone this repository:**
   ```bash
   git clone https://github.com/your-username/hostel-management-system.git
   cd hostel-management-system
