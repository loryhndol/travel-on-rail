## Basics

Backend:

- Framework: Beego v2
- Database: MySQL 

Frontend:

- UI: Layui v2.6.8 + D3 v5

## Usage

#### MySQL

open and run `beego-travelOnRail/sql/create_schema.sql` & `beego-travelOnRail/sql/tb_data.sql`

admin's password: 123456

user's password: username

#### Terminal

to run the application: `go run main.go`

to build .exe: `go build`

## Detail

#### Demand

Focus on sale services. Decouple from complex railway systems.

#### Database Design

EER diagram

<img src="H:\beego-travelOnRail\EER.png" alt="50%"  />

#### Customer interface:

#### Company interface:

#### Implementation - Customer

interval = departure - arrival

Buy and search ticket

#### Implementation - Company

Monitor
