# Hands-On Lab

Welcome to the Hands-On Lab for Data Science in Snowflake! This repository contains all the necessary files and instructions to set up and run the lab environment using Snowflake, Streamlit, and various Python packages.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Running the Demos](#running-the-demos)
- [Additional Resources](#additional-resources)


## Prerequisites

Before you begin, ensure you have the following:

- A Snowflake account with appropriate permissions.
- Python 3.11.9 installed on your machine.
- `pip` package manager.
- Access to the GitHub repository: [hol-notebook](https://github.com/Infostrux-Solutions/hol-notebook).

## Setup Instructions

1. **Clone the Repository**

   Clone the repository to your local machine:

   ```sh
   git clone https://github.com/Infostrux-Solutions/hol-notebook.git
   cd hol-notebook
   ```

2. **Set Up Snowflake Environment**

   Run the `setup.sql` script to set up the Snowflake environment:

   ```sh
   snowsql -f setup.sql
   ```

   This script will:
   - Create a new organization account.
   - Create a new database and warehouses.
   - Set up roles and permissions.
   - Create API and external access integrations.