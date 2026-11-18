# Periodic Table Database

A relational database built in PostgreSQL alongside an interactive Bash script (`element.sh`) to query properties of chemical elements. Developed as part of the **freeCodeCamp Relational Database Certification**.

## Features & Database Normalization

- **Normalized Schema:** Structured into three related tables (`elements`, `properties`, and `types`) enforcing `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, and `NOT NULL` constraints.
- **Data Cleaning & Standardization:**
  - Renamed columns for clarity (`atomic_mass`, `melting_point_celsius`, `boiling_point_celsius`).
  - Formatted element symbols with proper capitalization (`INITCAP`).
  - Converted `atomic_mass` to `DECIMAL` and stripped unnecessary trailing zeros.
  - Added missing elements (Fluorine and Neon) and removed invalid test records.
- **CLI Query Script (`element.sh`):** Accepts an atomic number, symbol, or element name as an argument, validates input types, and outputs a formatted summary.

## Project Files

- `periodic_table.sql`: Full PostgreSQL database dump (schema and data).
- `element.sh`: Executable Bash script to query the database.

## Usage

1. **Restore the database:**
   ```bash
   psql -U postgres < periodic_table.sql
   ```

2. **Grant execution permissions and run the script:**
   ```bash
   chmod +x element.sh
   ./element.sh 1
   ./element.sh H
   ./element.sh Hydrogen
   ```

3. **Sample Output:**
   ```text
   The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
   ```
