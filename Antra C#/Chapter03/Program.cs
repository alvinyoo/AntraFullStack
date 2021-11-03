using System;

namespace Chapter03
{
    class FizzBuzz
    {
        static void Main(string[] args)
        {
            int MaxNum = 100;

            for (byte i = 1; i <= MaxNum; i++)
            {
                if (i % 3 == 0 && i % 5 == 0)
                {
                    Console.Write($"fizzbuzz, ");
                }
                else if (i % 3 == 0)
                {
                    Console.Write("fizz, ");
                }
                else if (i % 5 == 0) 
                {
                    Console.Write("buzz, ");
                }
                else
                {
                    Console.Write($"{i}, ");
                }
            }
        }
    }
}
