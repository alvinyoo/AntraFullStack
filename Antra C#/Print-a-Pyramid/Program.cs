using System;

namespace Print_a_Pyramid
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("input numbers of rows: ");
            int rows = int.Parse(Console.ReadLine());

            for (byte i = 1; i <= rows; i++)
            {
                for (byte j = 1; j < rows - i; j++)
                {
                    Console.Write(" ");
                }
                for (byte j = 1; j <= 2 * i - 1; j++)
                {
                    Console.Write("*");
                }
                Console.WriteLine();
            }
        }
    }
}
