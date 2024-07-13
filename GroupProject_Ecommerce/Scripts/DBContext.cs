using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace GroupProject_Ecommerce.Scripts
{
    public class DBContext
    {
        SqlConnection cn;

        // Constructor to initialize the connection string
    

        // Method to open the database connection
        private void OpenConnection()
        {
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=E:\C#\GroupProject_Ecommerce\GroupProject_Ecommerce\App_Data\Database.mdf;Integrated Security=True";
            /*            string connectionString = Environment.GetEnvironmentVariable("DATABASE_URL");*/
            cn = new SqlConnection(connectionString);
            cn.Open();
        }
        private void CloseConnection()
        {
            cn.Close();
        }
        public DataTable GetData(string sql)
        {
            DataTable dt = new DataTable();
            try
            {
                OpenConnection();
                SqlDataAdapter da = new SqlDataAdapter(sql, cn);
                da.Fill(dt);
            }
            catch (Exception ex)
            {
                dt = null;
            }
            finally
            {
                CloseConnection();
            }
            return dt;
        }
        public int Update(string sql)
        {
            int result = 0;
            try
            {
                OpenConnection();
                SqlCommand cmd = new SqlCommand(sql, cn);
                result = cmd.ExecuteNonQuery();

            }
            catch
            {
                result = 0;

            }
            finally
            {
                CloseConnection();
            }
            return result;
        }

        // Method to execute an update/insert/delete command
        public int ExecuteCommand(string sql)
        {
            int result = 0;
            try
            {
                OpenConnection();
                SqlCommand cmd = new SqlCommand(sql, cn);
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                // Handle the exception (optional)
                result = 0;
            }
            finally
            {
                CloseConnection();
            }
            return result;
        }

        // Method to execute a scalar command (e.g., getting a single value)
        public object ExecuteScalar(string sql)
        {
            object result = null;
            try
            {
                OpenConnection();
                SqlCommand cmd = new SqlCommand(sql, cn);
                result = cmd.ExecuteScalar();
            }
            catch (Exception ex)
            {
                // Handle the exception (optional)
                result = null;
            }
            finally
            {
                CloseConnection();
            }
            return result;
        }
    }
}