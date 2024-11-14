"""
=============================================================================
File:           employeeGenerator.py
Purpose:        Generates synthetic employee data for testing and development
                purposes. Creates 50 random employee profiles with realistic
                personal information including names, addresses, SSNs, and
                other demographic data.

How to run:     python employeeGenerator.py
                Output is printed to stdout and can be redirected to a file:
                python employeeGenerator.py > employees.csv

Dependencies:   Python 3.6+
                - random
                - datetime
                - string

Author:         Tom Kinsella
Email:          tkinsella@sisng.io
Organization:   Private Project

Creation Date:  2024-10-26
Last Updated:   2024-10-26
Version:        1.0.1

License:        MIT License
                Copyright (c) 2024 [Your Name]
                See LICENSE file for full license text

Notes:
    - Generates 50 unique employee profiles
    - All data is randomly generated and not based on real persons
    - Date ranges:
        * Birth dates: 65 to 18 years from current date
        * Start dates: 2024-01-01 to 2024-10-26
=============================================================================
"""

import random
from datetime import datetime, timedelta
import string

# Helper function to generate random dates
def random_date(start_date, end_date):
    time_between = end_date - start_date
    days_between = time_between.days
    random_days = random.randrange(days_between)
    return start_date + timedelta(days=random_days)

# Generate 50 unique employee numbers
def generate_employee_number():
    letters = ''.join(random.choices(string.ascii_uppercase, k=2))
    numbers = ''.join(random.choices(string.digits, k=6))
    return f"{letters}{numbers}"

# Generate random SSN
def generate_ssn():
    area = random.randint(100, 999)
    group = random.randint(10, 99)
    serial = random.randint(1000, 9999)
    return f"{area}-{group}-{serial}"

# Generate random driver's license
def generate_drivers_license():
    return f"WDL{random.randint(100,999)}{'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[random.randint(0,25)]}{random.randint(0,9)}{'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[random.randint(0,25)]}{random.randint(0,9)}{'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[random.randint(0,25)]}"

# Lists for generating random names
first_names = ["James", "Mary", "John", "Patricia", "Robert", "Jennifer", "Michael", "Linda", "William", "Elizabeth", "David", "Barbara", "Richard", "Susan", "Joseph", "Jessica", "Thomas", "Sarah", "Charles", "Karen", "Christopher", "Nancy", "Daniel", "Lisa", "Matthew", "Betty", "Anthony", "Margaret", "Donald", "Sandra", "Mark", "Ashley", "Paul", "Kimberly", "Steven", "Emily", "Andrew", "Donna", "Kenneth", "Michelle", "Joshua", "Dorothy", "Kevin", "Carol", "Brian", "Amanda", "George", "Melissa", "Edward", "Deborah"]
middle_names = ["Alexander", "Marie", "William", "Elizabeth", "James", "Anne", "Joseph", "Grace", "Michael", "Rose", "David", "Lynn", "Robert", "Mae", "Thomas", "Jane", "Charles", "Louise", "Daniel", "Ruth", "Richard", "Ellen", "John", "Catherine"]
last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzales", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts"]
streets = ["Main St", "Oak Ave", "Maple Dr", "Cedar Ln", "Pine St", "Elm St", "Washington Ave", "Park Ave", "Lake St", "River Rd"]
cities = ["Springfield", "Franklin", "Clinton", "Greenville", "Bristol", "Salem", "Madison", "Georgetown", "Arlington", "Burlington"]
states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
marital_statuses = ["Single", "Married", "Divorced", "Widowed"]
genders = ["Male", "Female", "Non-Binary"]
email_domains = ["gmail.com", "yahoo.com", "hotmail.com", "outlook.com"]

# Generate CSV header
csv_data = "Employee_Number,First_Name,Middle_Name,Last_Name,Date_of_Birth,Gender,Marital_Status,SSN,Drivers_License,Start_Date,Address,City,State,Zip_Code,Phone_Number,Email\n"

# Generate unique employee numbers
employee_numbers = set()
while len(employee_numbers) < 50:
    employee_numbers.add(generate_employee_number())

# Calculate date ranges
today = datetime(2024, 10, 26)  # Current date from system parameters
earliest_birth_date = today - timedelta(days=365*65)  # 65 years ago
latest_birth_date = today - timedelta(days=365*18)  # 18 years ago
start_date_begin = datetime(2024, 1, 1)
start_date_end = datetime(2024, 10, 26)

# Generate 50 employee profiles
for emp_num in employee_numbers:
    first_name = random.choice(first_names)
    middle_name = random.choice(middle_names)
    last_name = random.choice(last_names)
    dob = random_date(earliest_birth_date, latest_birth_date).strftime("%Y-%m-%d")
    gender = random.choice(genders)
    marital_status = random.choice(marital_statuses)
    ssn = generate_ssn()
    dl = generate_drivers_license()
    start_date = random_date(start_date_begin, start_date_end).strftime("%Y-%m-%d")
    street_num = random.randint(100, 9999)
    street = random.choice(streets)
    city = random.choice(cities)
    state = random.choice(states)
    zip_code = random.randint(10000, 99999)
    phone_area = random.randint(200, 999)
    phone_prefix = random.randint(200, 999)
    phone_suffix = random.randint(1000, 9999)
    email = f"{first_name.lower()}.{last_name.lower()}@{random.choice(email_domains)}"
    
    # Create CSV row
    csv_row = f"{emp_num},{first_name},{middle_name},{last_name},{dob},{gender},{marital_status},{ssn},{dl},{start_date},{street_num} {street},{city},{state},{zip_code},{phone_area}-{phone_prefix}-{phone_suffix},{email}\n"
    csv_data += csv_row

print(csv_data)
