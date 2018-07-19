namespace Core.Ultity
{
    public class MvcPagingByFrameWork
    {
        public static string Paging(int pageCount, int pageIndex, string url, string keySearch)
        {
            string result = string.Empty;
            result = result + " <div class='row'>";
            result = result + "   <div class='col-xs-12'>";
            result = result + "     <div class='dataTables_paginate paging_simple_numbers' id='example1_paginate'>";

            int totalPage = pageCount;
            string pre_disabled = string.Empty;
            string next_disabled = string.Empty;
            if (pageIndex == 0)
            {
                pre_disabled = " disabled' style='pointer-events:none;'";
            }
            else
            {
                pre_disabled = "'";
            }
            if (pageIndex == totalPage - 1)
            {
                next_disabled = "disabled' style='pointer-events:none;'";
            }
            else
            {
                next_disabled = "'";
            }

            result = result + "            <ul class='pagination'>";
            result = result + " <li class='prev " + pre_disabled + ">";
            if (keySearch == null)
            {
                result = result + " <a href = '/" + url + "?page=" + pageIndex + "'>";
            }
            else
            {
                result = result + "  <a  href = '/" + url + "?page=" + pageIndex + "&key=" + keySearch + "'>";
            }

            result = result + "   <i class='ace-icon'></i>";
            result = result + "    Trang trước";
            result = result + "    </a>";
            result = result + "   </li>";

            if (totalPage >= 0)
            {
                for (int i = 0; i < totalPage; i++)
                {
                    if (pageIndex == i)
                    {
                        result = result + "           <li class='active'>";
                        if (keySearch == null)
                        {
                            result = result + " <a href = '/" + url + "?page=" + (i + 1) + "'>" + (i + 1) + "</a>";
                        }
                        else
                        {
                            result = result + " <a href = '/" + url + "?page=" + (i + 1) + "&key=" + keySearch + "'>" + (i + 1) + "</a>";
                        }
                        result = result + " </li>";
                    }
                    else
                    {
                        result = result + " <li>";
                        if (keySearch == null)
                        {
                            result = result + " <a href = '/" + url + "?page=" + (i + 1) + "'>" + (i + 1) + "</a>";
                        }
                        else
                        {
                            result = result + " <a href = '/" + url + "?page=" + (i + 1) + "&key=" + keySearch + "'>" + (i + 1) + "</a>";
                        }

                        result = result + " </li>";
                    }
                }
            }
            result = result + " <li class='next " + next_disabled + ">";
            if (keySearch == null)
            {
                result = result + " <a href = '/" + url + "?page=" + (pageIndex + 2) + "'>";
            }
            else
            {
                result = result + " <a href = '/" + url + "?page=" + (pageIndex + 2) + "&key=" + keySearch + "'>";
            }
            result = result + " Trang tiếp";
            result = result + " <i class='ace-icon'></i>";
            result = result + " </a>";
            result = result + " </li>";
            result = result + " </ul>";
            result = result + " </div>";
            result = result + " </div>";
            result = result + " </div>";
            return result.Replace("\'", "\"");
        }
    }
}