using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Core.Ultity
{
    public class SplitStringtoWord
    {
        public SplitStringtoWord()
        { }
        private static int a = 0;
         private static int count = 0;
        public static int CountPage(string s, int len)
        {
            a = 0;
            for (int i = 0; i < s.Length; i++)
            {
                if (i < len)
                {
                    if (s[i] == ' ')
                    {
                        a = a + 1;
                    }
                }
                else { break; }
            }
            return a;
        }
        public static string _SplitStringContent(string s,int len)
        {
            s = s.Split(new string[] { "<div class=\"excerpt\">" }, StringSplitOptions.None)[1];
            s = s.Split(new string[] { "</div>" }, StringSplitOptions.None)[0];
             string a = "";
            if (s.Length < len)
            {
                a = s;
            }
            else
            {
                int sokitu = CountPage(s, len);
                count = 0;

                for (int i = 0; i < s.Length; i++)
                {

                    if (s[i] == ' ')
                    {
                        count = count + 1;
                    }
                    if (count < sokitu)
                    {
                        a = a + s[i];
                    }
                    else
                    {
                        a = a + "...";
                        break;
                    }
                }
            }

            return "<div class=\"excerpt\">" + a + "</div>";
        }
        
       
        public static string SplittoWord(string s, int len)
        {
          
            string a = "";
            if (!string.IsNullOrEmpty(s))
            {
                if (s.Length < len)
                {
                    a = s;
                }
                else
                {
                    int sokitu = CountPage(s, len);
                    count = 0;

                    for (int i = 0; i < s.Length; i++)
                    {

                        if (s[i] == ' ')
                        {
                            count = count + 1;
                        }
                        if (count < sokitu)
                        {
                            a = a + s[i];
                        }
                        else
                        {
                            a = a + "...";
                            break;
                        }
                    }
                }
            }           
            return a;
        }
    }
}