using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Reflection;

namespace GroupProject_Ecommerce.Scripts
{
    public class DBContext
    {
        SqlConnection cn;

        // Method to open the database connection
        private void OpenConnection()
        {

            string connectionString = Environment.GetEnvironmentVariable("DATABASE_URL");
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

        // Modified method to execute an update/insert/delete command with parameters
        public int ExecuteCommand(SqlCommand cmd)
        {
            int result = 0;
            try
            {
                OpenConnection();
                cmd.Connection = cn;
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

        public DataTable GetDataWithParameters(string sql, Dictionary<string, object> parameters)
        {
            DataTable dt = new DataTable();
            try
            {
                OpenConnection();
                SqlCommand cmd = new SqlCommand(sql, cn);
                foreach (var param in parameters)
                {
                    cmd.Parameters.AddWithValue(param.Key, param.Value);
                }
                SqlDataAdapter da = new SqlDataAdapter(cmd);
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

        public T GetObjectByQuery<T>(string sql) where T : new()
        {
            T obj = new T();
            try
            {
                OpenConnection();
                SqlCommand cmd = new SqlCommand(sql, cn);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        foreach (PropertyInfo property in typeof(T).GetProperties())
                        {
                            if (!reader.IsDBNull(reader.GetOrdinal(property.Name)))
                            {
                                property.SetValue(obj, reader[property.Name]);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle the exception (optional)
                obj = default(T);
            }
            finally
            {
                CloseConnection();
            }

            return obj;
        }
        public int ExecuteCommandWithParameters(string sql, Dictionary<string, object> parameters)
        {
            int result = 0;
            try
            {
                OpenConnection();
                SqlCommand cmd = new SqlCommand(sql, cn);
                foreach (var param in parameters)
                {
                    cmd.Parameters.AddWithValue(param.Key, param.Value);
                }
                result = cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                // Handle the exception (optional)
                Console.WriteLine(ex.Message);
                result = 0;
            }
            finally
            {
                CloseConnection();
            }
            return result;
        }
    }
}
