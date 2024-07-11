# GroupProject_Ecommerce

## Overview
This project is a web-based e-commerce application developed using ASP.NET Web Forms. The application includes features such as user authentication, product browsing, shopping cart functionality, and search capabilities.

## Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Usage](#usage)
- [Class Documentation](#class-documentation)
  - [DBContext](#dbcontext)
  - [UserContext](#usercontext)
- [Directory Structure](#directory-structure)
- [License](#license)

## Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/GroupProject_Ecommerce.git
    ```

2. **Open the project in Visual Studio:**
   - Open Visual Studio.
   - Click on `File -> Open -> Project/Solution`.
   - Navigate to the cloned repository and select the `.sln` file.

3. **Set up the environment variables:**
   - Create a file named `.env` in the root directory of the project.
   - Add the following content to the `.env` file:
     ```
     DATABASE_URL = "Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=E:\Study\KTTMDT\Lap_KTTMDT\GroupProject_Ecommerce\GroupProject_Ecommerce\App_Data\Database.mdf;Integrated Security=True"
     ```

4. **Run the application:**
   - Press `F5` in Visual Studio to build and run the application.
## Images

-They are saved in Content/Images/...


## Usage

### Authentication


### Shopping Cart


### Search Functionality
- Users can search for products using the search box in the header.

## Class Documentation

### DBContext

This class handles data processing and database connectivity. Previously, it was called the connection class.

#### Constructor
- `DBContext()`
  - Initializes the database connection using the connection string from the environment variables.

#### Methods
- `GetData(string sql)`
  - Executes a SELECT query and returns the results as a `DataTable`.
- `ExecuteCommand(string sql)`
  - Executes an INSERT, UPDATE, or DELETE query and returns the number of affected rows.
- `ExecuteScalar(string sql)`
  - Executes a query that returns a single value.