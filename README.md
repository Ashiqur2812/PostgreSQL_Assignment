# 📘 PostgreSQL Documentation 

## 1️⃣ PostgreSQL কী?

**PostgreSQL**একটি উন্নতমানের, ওপেন-সোর্স **অবজেক্ট-রিলেশনাল ডেটাবেইস ম্যানেজমেন্ট সিস্টেম (ORDBMS)**। এটি ১৯৮৬ সালে Ingres প্রোজেক্ট থেকে উৎপন্ন হয় এবং University of California, Berkeley তে এর ভিত্তি স্থাপন করা হয়।

###  PostgreSQL এর মূল বৈশিষ্ট্য:

-  **ACID কমপ্লায়েন্স**: এটি Atomicity, Consistency, Isolation, এবং Durability নিশ্চিত করে, যা কোনো ট্রানজ্যাকশন ডেটার নিরাপত্তা বজায় রাখে।
-**Extensibility**: আপনি চাইলে নিজস্ব ডেটা টাইপ, অপারেটর, ফাংশন, এবং ভাষা যুক্ত করতে পারেন।
-**Security & Role Management**: PostgreSQL শক্তিশালী ইউজার রোল ও পারমিশন মডেল সমর্থন করে।
-**Cross-platform support**: Windows, Linux, macOS সহ বিভিন্ন প্ল্যাটফর্মে এটি নির্বিঘ্নে চলে।
-**JSON এবং XML সাপোর্ট**: এটি আধুনিক NoSQL সুবিধারও সমর্থন দেয় (যেমন: JSONB টাইপ)।

###  বাস্তব উদাহরণ:
```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    date_of_birth DATE,
    gpa NUMERIC(3, 2)
);
```

এই টেবিলটি শিক্ষার্থীদের তথ্য সংরক্ষণে ব্যবহৃত হবে, যেখানে প্রতিটি শিক্ষার্থীর জন্য একটি ইউনিক ID, পূর্ণ নাম, জন্ম তারিখ, এবং GPA সংরক্ষিত থাকবে।

## 2️⃣ ডেটাবেইস স্কিমার উদ্দেশ্য কী?
স্কিমা (Schema) হলো একটি লজিক্যাল কনটেইনার যা ডেটাবেইস অবজেক্ট (যেমন টেবিল, ভিউ, ইনডেক্স, ট্রিগার, ফাংশন) সমূহকে সংগঠিত করে। এটি একটি "নেমস্পেস" হিসেবে কাজ করে, যা ডেটার শ্রেণিবিন্যাস, নিরাপত্তা, এবং অ্যাক্সেস কন্ট্রোলের ক্ষেত্রে গুরুত্বপূর্ণ ভূমিকা পালন করে।

🧠 কেন স্কিমা দরকার?
মডিউলার ডিজাইন: স্কিমা ব্যবহার করে আপনি ভিন্ন ভিন্ন বিজনেস ইউনিট বা অ্যাপ্লিকেশন মডিউল আলাদাভাবে সংগঠিত রাখতে পারেন।

নিরাপত্তা ও পারমিশন কন্ট্রোল: আপনি প্রতিটি স্কিমার জন্য আলাদা রোল/পারমিশন নির্ধারণ করতে পারেন, যা ডেটা সুরক্ষায় সহায়ক।

নেইম কনফ্লিক্ট এড়ানো: একই ডেটাবেইসে sales.orders এবং support.orders দুইটি টেবিল থাকতে পারে যেহেতু তারা আলাদা স্কিমায় আছে।

🔧 বাস্তব উদাহরণ:

-- একটি নতুন স্কিমা তৈরি:
```sql
CREATE SCHEMA accounting;
```

-- সেই স্কিমার মধ্যে একটি টেবিল:
```sql
CREATE TABLE accounting.invoices (
    invoice_id SERIAL PRIMARY KEY,
    client_name TEXT,
    amount_due NUMERIC
);
```
এই কাঠামোতে, invoices টেবিলটি শুধুমাত্র accounting স্কিমার অন্তর্গত এবং অন্যান্য স্কিমায় invoices নামের টেবিল থাকতে পারবে।

## 3️⃣ Primary Key এবং Foreign Key ব্যাখ্যা
Primary Key এবং Foreign Key PostgreSQL-এর relational architecture এর দুটি সবচেয়ে গুরুত্বপূর্ণ কনসেপ্ট। এরা ডেটার integrity এবং টেবিলগুলোর মধ্যে সম্পর্ক নির্ধারণ করে।

Primary Key:
এটি এমন একটি কলাম (বা কলাম সমষ্টি) যা টেবিলের প্রতিটি রেকর্ডকে ইউনিকভাবে সনাক্ত করে।

এটি কখনো NULL হতে পারে না এবং রেকর্ড ডুপ্লিকেট হতে দেয় না।

একটি টেবিলে শুধুমাত্র একটি Primary Key থাকতে পারে।

🔗 Foreign Key:
এটি একটি কলাম যা অন্য টেবিলের Primary Key এর সাথে সম্পর্কযুক্ত।

এটি parent-child relationship নির্ধারণে ব্যবহৃত হয়।

Foreign Key নিশ্চিত করে যে একটি child টেবিলের মান সবসময় parent টেবিলে বিদ্যমান থাকে (referential integrity)।

 বাস্তব উদাহরণ:

-- Parent টেবিল:
CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);


-- Child টেবিল:
```sql
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```
এই কাঠামোতে, employees টেবিলের dept_id কেবলমাত্র departments টেবিলের বৈধ dept_id মানই গ্রহণ করতে পারবে।

## 4️⃣ VARCHAR এবং CHAR এর মধ্যে পার্থক্য
PostgreSQL-এ VARCHAR এবং CHAR উভয়ই character string টাইপ, কিন্তু ব্যবহারিক দৃষ্টিকোণ থেকে তারা ভিন্ন।

🧬 মূল পার্থক্য:
বৈশিষ্ট্য	VARCHAR(n)	CHAR(n)
দৈর্ঘ্য	পরিবর্তনশীল (Variable-length)	নির্দিষ্ট (Fixed-length)
স্টোরেজ	শুধুমাত্র প্রয়োজনীয় বাইট ব্যবহার করে	পূর্ণ n ক্যারেক্টারের জায়গা সংরক্ষণ করে
পারফরম্যান্স	সাধারণত দ্রুত ও মেমোরি সাশ্রয়ী	নির্দিষ্ট দৈর্ঘ্যের জন্য উপযুক্ত
ট্রিমিং	শেষে অপ্রয়োজনীয় স্পেস রাখে না	স্পেস দিয়ে পূরণ করে

উদাহরণ:

CREATE TABLE users (
    username VARCHAR(50),    -- ব্যবহারকারীর নাম, ভ্যারিয়েবল দৈর্ঘ্যে
    status CHAR(1)           -- 'A', 'I' মতো স্থিতি মান
);

VARCHAR আদর্শ টেক্সট ইনপুটের জন্য ব্যবহৃত হয় এবং CHAR ব্যবহার হয় যেখানে character-length স্থির এবং পূর্বনির্ধারিত।

## 5️⃣ WHERE ক্লজের ভূমিকা
WHERE ক্লজ SQL এর একটি অত্যন্ত গুরুত্বপূর্ণ অংশ, যা আপনাকে টেবিল থেকে কেবলমাত্র সেই রেকর্ডগুলো সিলেক্ট করতে দেয় যেগুলো নির্দিষ্ট শর্ত পূরণ করে।

ব্যবহার ক্ষেত্র:
Data Filtering: সমস্ত রেকর্ডের পরিবর্তে নির্দিষ্ট রেকর্ড নির্বাচন।

সিকিউরিটি এবং পারফরম্যান্স: কম ডেটা প্রসেসিং, দ্রুত রেসপন্স টাইম।

UPDATE/DELETE অপারেশন সীমিত রাখা।

WHERE ক্লজ ব্যবহার হয়:
SELECT – নির্দিষ্ট রেকর্ড দেখা

UPDATE – নির্দিষ্ট রেকর্ড আপডেট করা

DELETE – নির্দিষ্ট রেকর্ড ডিলিট করা

উদাহরণ:

-- শুধুমাত্র ৩০ বছরের উপরে শিক্ষার্থীদের দেখা:
SELECT * FROM students WHERE age > 30;

-- যাদের নাম ‘Hasan’, তাদের GPA আপডেট:
UPDATE students SET gpa = 3.85 WHERE full_name = 'Hasan';

-- বয়স ১৮ এর নিচে এমন শিক্ষার্থীদের ডিলিট করা:
DELETE FROM students WHERE age < 18;
WHERE ক্লজে ব্যবহৃত অপারেটর:
তুলনা: =, !=, <, >, <=, >=

ধরণ অনুসন্ধান: LIKE, IN, BETWEEN

NULL চেক: IS NULL, IS NOT NULL

