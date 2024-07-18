using GroupProject_Ecommerce.Scripts;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace GroupProject_Ecommerce
{
    public partial class Default : System.Web.UI.Page
    {
        private int PageSize = 9; // Number of products per page
        private int CurrentPage
        {
            get
            {
                int page;
                return int.TryParse(Request.QueryString["page"], out page) ? page : 1;
            }
        }

        private int? SelectedCategoryId
        {
            get
            {
                int categoryId;
                return int.TryParse(Request.QueryString["category"], out categoryId) ? (int?)categoryId : null;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
                LoadProducts();
            }
        }

        private void LoadCategories()
        {
            DBContext db = new DBContext();
            DataTable dt = db.GetData("SELECT * FROM Categories");
            if (dt != null)
            {
                rptCategories.DataSource = dt;
                rptCategories.DataBind();
            }
        }

        private void LoadProducts()
        {
            DBContext db = new DBContext();
            string sql = "SELECT * FROM Products";
            Dictionary<string, object> parameters = new Dictionary<string, object>();

            if (SelectedCategoryId.HasValue)
            {
                sql += " WHERE ProductID IN (SELECT ProductID FROM ProductCategories WHERE CategoryID = @CategoryId)";
                parameters.Add("@CategoryId", SelectedCategoryId.Value);
            }

            string searchKey = Request.QueryString["key"];
            if (!string.IsNullOrEmpty(searchKey))
            {
                if (parameters.Count > 0)
                {
                    sql += " AND (ProductName LIKE @SearchKey OR Description LIKE @SearchKey)";
                }
                else
                {
                    sql += " WHERE ProductName LIKE @SearchKey OR Description LIKE @SearchKey";
                }
                parameters.Add("@SearchKey", "%" + searchKey + "%");
            }

            DataTable dt = db.GetDataWithParameters(sql, parameters);
            
            if (dt != null&& dt.Rows.Count > 0)
            {
                // Calculate pagination
                int totalRecords = dt.Rows.Count;
                int totalPages = (int)Math.Ceiling((double)totalRecords / PageSize);
                int startRow = (CurrentPage - 1) * PageSize;
                DataTable pagedTable = dt.AsEnumerable().Skip(startRow).Take(PageSize).CopyToDataTable();

                rptProducts.DataSource = pagedTable;
                rptProducts.DataBind();

                lblPageInfo.Text = $"Page {CurrentPage} of {totalPages}";
                lnkPrev.Enabled = CurrentPage > 1;
                lnkNext.Enabled = CurrentPage < totalPages;
            }
        }


        protected void Page_Command(object sender, CommandEventArgs e)
        {
            int newPage = CurrentPage;

            if (e.CommandArgument.ToString() == "Prev" && CurrentPage > 1)
            {
                newPage--;
            }
            else if (e.CommandArgument.ToString() == "Next")
            {
                newPage++;
            }

            string categoryParam = SelectedCategoryId.HasValue ? $"&category={SelectedCategoryId.Value}" : string.Empty;
            Response.Redirect($"Default.aspx?page={newPage}{categoryParam}");
        }

        protected void rptCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectCategory")
            {
                int categoryId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"Default.aspx?category={categoryId}&page=1");
            }
        }

        protected void ImageButton1_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            string productId = ((ImageButton)sender).CommandArgument;
            Response.Redirect("ProductDetail.aspx?productId=" + productId);
        }
    }
}
