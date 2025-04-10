# 🚗 Car Rental System - Mini Project

## 📚 Course
**Advanced Internet Programming**  
**Semester**: 2nd Semester  
**Project Type**: Mini Project  
**Developed By**: Abhijeet Prajapati  
**College**: CHandigarh University

---

## 📌 Project Overview

This is a **web-based Car Rental System** developed using **Java, JSP, Servlets, JDBC**, and **MySQL**. It allows users to register, log in, and view available cars, while providing an admin panel to manage cars (Add/Edit/Delete). It demonstrates session management, database interaction, and modular architecture using servlets and JSPs.

---

## 🎯 Features

### 👤 User Module
- Register new users
- Login with session tracking
- View available cars
- Logout

### 🛠️ Admin Module
- Admin login
- Dashboard to manage car listings
- Add new cars
- Edit car details
- Delete cars
- Logout

---

## 🧰 Technologies Used

| Technology        | Description                       |
|------------------|-----------------------------------|
| Java             | Backend programming language      |
| JSP & Servlets   | Frontend & Controller             |
| MySQL            | Relational Database               |
| JDBC             | Java Database Connectivity        |
| Apache Tomcat    | Servlet Container (localhost)     |
| HTML, CSS        | Styling and basic layout          |
| NetBeans         | IDE for development               |

---

## 🗃️ Project Structure

```mermaid 
flowchart TD
    A[User/Admin Opens index.jsp] --> B{Choose Option}
    
    B --> C[User Register] --> C1[register.jsp] --> C2[RegisterServlet]
    C2 -->|Insert User| DB[(MySQL Database)]
    C2 -->|Redirect| D1[login.jsp]

    B --> D[User Login] --> D1[login.jsp] --> D2[LoginServlet]
    D2 -->|Validate User| DB
    D2 -->|Success| E1[userDashboard.jsp]
    D2 -->|Fail| D1

    B --> F[Admin Login] --> F1[adminLogin.jsp] --> F2[AdminLoginServlet]
    F2 -->|Validate Admin| DB
    F2 -->|Success| G1[adminDashboard.jsp]
    F2 -->|Fail| F1

    E1 -->|View Cars| DB
    G1 -->|Manage Cars| DB
    G1 -->|Add/Edit/Delete Cars| DB

    E1 --> H[Logout] --> I[LogoutServlet] --> A

    G1 --> H2[Logout] --> I

    style DB fill:#f9f,stroke:#333,stroke-width:2px
    style E1 fill:#bbf,stroke:#333
    style G1 fill:#ffb,stroke:#333
    style A fill:#aff,stroke:#333
```