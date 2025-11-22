--Banking management System Database
--In this bank db contain these table
-- 1. CUSTOMER
-- 2. ACCOUNT
-- 3. TRANSACTION
-- 4. FUND TRANSFER
-- 5. LOAN
-- 6. LOAN PAYMENT


--Fisrt we create Database

CREATE DATABASE BankingDB;

USE BankingDB;

DROP DATABASE BankingDB;

--1. Create Customer Table 
-- This table store customer details and concept use in this table are primary key, constraints and normalization.
CREATE TABLE Customer(
       customer_Id int Identity(1,1) primary key, --Identity use for autoIncrement
       cust_name varchar(50) not null,
       email varchar(50) unique,
       phone varchar(15) unique,
       Dob date,
       addhar_no bigint unique not null,
       Pan_no varchar(30) unique not null,
       cust_address varchar(300),
);

--2. Create Account table
-- This store All account related to customer
-- show one-to-many relationship (one customer -> multiple accounts)
 CREATE TABLE Account(
        account_no bigint primary key,
        customer_id int not null;
        account_type varchar,
        balance decimal(18,2)  check (balance >=0),
        createdAt DATETIME default GETDATE()

        foreign key (customer_id) 
        references Customer(customer_Id) 
        on delete cascade
        on update cascade
         
 );

-- 3. Create Transaction table
-- store all deposit / withdrawals
-- transaction concept , check constraint and indexing on txn_date.
CREATE TABLE Transactions(
       txn_id varchar(50) primary key,
       acconut_number bigint not null,
       txn_type varchar(15) not null check(txn_type in ('credit','debit')), --credit/debit
       amount decimal(18,2) check(amount > 0),
       txn_date DATETIME2 DEFAULT SYSDATETIME(),
       description_ varchar(200)
       
       foreign key (account_number)
       references Account(account_no)
       on delete cascade
       on update cascade
);

--4. Create Found Transfer table
-- used to record money transfer between two account
-- self-referencing FK , complex constraints
CREATE TABLE FundTransfer(
       transfer_id bigint identity(1,1)  primary key,
       from_account bigint not null,
       to_account bigint not null,
       amount decimal(18,2) check (amount > 0),
       transfer_time DATETIME2 default SYSDATETIME(),

       foreign key(from_account) 
       references Account(account_no)
       on delete cascade
       on update cascade

       foreign key(to_account)
       references Account(account_no)
       on delete cascade
       on update cascade
);

--5. Create Loan table
-- Loan information for customer
-- another banking feature and relationship
CREATE TABLE Loan(
       loan_id int identity(1,1) primary key,
       customer_id int not null,
       loan_type varchar(50) not null,
       principal_amount decimal(18,2) check(principal_amount > 0),
       interest_rate decimal(5,2),
       issue_date DATETIME2 default SYSDATETIME(),

       foreign key(customer_id)
       references Customer(customer_Id)
       on delete cascade
       on update cascade
);

--6.create loan payment table
-- track EMI payment for loan
-- 
CREATE TABLE Loan_payment(
   payment_id int identity(1,1) primary key,
   loan_id int not null, 
   amount_paid decimal(18,2) check( amount_paid > 0),
   payment_date DATETIME2 default SYSDATETIME()

   foreign key (loan_id)
   references Loan(loan_id)
   on delete cascade
   on update cascade
);