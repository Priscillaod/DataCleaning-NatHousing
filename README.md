**Nashville Housing Data Cleaning Project**



**Project Overview**

This project focuses on data cleaning using SQL to prepare the Nashville Housing dataset for further analysis.
The goal was to transform messy, incomplete real-world housing data into a clean, well-structured format that would support accurate insights and business decision-making.



**Business Objective**

- Ensure data consistency and integrity for future housing market analysis.
- Address missing values, duplicate records, and formatting inconsistencies.
- Standardize address fields to enable easier geographic analysis.
- Prepare a clean and analysis-ready database.


**Data Source**
- Dataset: Nashville Housing Data (Excel file).
- Source: Provided as part of a portfolio data cleaning exercise.



**Methodology & Step-by-Step Cleaning Process**

Initial Exploration
- Queried the full dataset to assess structure, completeness, and potential data quality issues.

Standardized Date Format
- Converted SaleDate field from datetime to date format for clarity and consistency.
- Created a new column SaleDateConverted.

Filled Missing Property Addresses
- Identified NULL values in PropertyAddress.
- Used self-join on ParcelID to populate missing addresses from matching records.

Split Property Address into Components
- Extracted street address and city into new columns: PropertySplitAddress and PropertySplitCity.

Split Owner Address into Components
- Used the PARSENAME function to separate OwnerAddress into street address, city, and state.

Standardized SoldAsVacant Values
- Standardized values in the SoldAsVacant field from 'Y'/'N' to 'Yes'/'No' for better readability.

Removed Duplicate Records
- Identified duplicates using ROW_NUMBER() based on critical fields.
- Deleted duplicate entries while retaining the original record.



**Final Deliverables**

- A cleaned Nashville Housing SQL table ready for analysis.
- Duplicates removed, missing addresses filled, addresses split into structured fields, and standardization applied across key categorical fields.


**Data Limitations**
- Some addresses with inconsistent formats were manually handled.
- Assumes ParcelID is a unique-enough identifier for matching addresses.


**Conclusion**

This project demonstrates the importance of systematic data cleaning as a foundational step in the data analysis process.
Through structured SQL techniques — including filling missing values, standardising formats, decomposing addresses, and removing duplicates — the Nashville Housing dataset was transformed from a messy, inconsistent collection into a clean, reliable, and analysis-ready dataset.

Effective data cleaning ensures that any future analyses, visualizations, or business insights generated from this dataset will be accurate, trustworthy, and actionable. By following a disciplined approach, we have significantly enhanced the quality and usability of the data, laying the groundwork for informed decision-making in real estate market analyses, urban planning, and investment strategy.


