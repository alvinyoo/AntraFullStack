using System;

namespace greetsUsers
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime currentTime = new DateTime();
            currentTime = DateTime.Now;
            int hour = currentTime.Hour;
            
            if (5 <= hour && hour <= 14)
            {
                Console.WriteLine("Good Morning!");
            }
            if (14 < hour && hour <= 18)
            {
                Console.WriteLine("Good Afternoon!");
            }
            if (18 < hour && hour <= 21)
            {
                Console.WriteLine("Good Evening!");
            }
            if (21 < hour | 5 > hour)
            {
                Console.WriteLine("Good Night!");
            }
        }
    }
}

