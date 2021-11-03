using System;

namespace guessedNumber
{
    class guess
    {
        static void Main(string[] args)
        {
            Console.WriteLine("input your number:");
            int guessedNumber = int.Parse(Console.ReadLine());

            int correctNumber = new Random().Next(3) + 1;

            if (guessedNumber > correctNumber)
            {
                Console.WriteLine("you need guess a smaller one");
            }
            else if (guessedNumber < correctNumber)
            {
                Console.WriteLine("you need guess a greater one");
            }
            else
            {
                Console.WriteLine("Congratulations! You got the right number!");
            }
        }
    }
}
