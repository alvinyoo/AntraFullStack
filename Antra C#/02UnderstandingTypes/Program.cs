using System;

namespace _02UnderstandingTypes
{
    /**
   Test your Knowledge 
   1. What type would you choose for the following “numbers”? 
   A person’s telephone number
       unit
   A person’s height
       byte
   A person’s age
       byte
   A person’s gender (Male, Female, Prefer Not To Answer)
       char
   A person’s salary 
       uint
   A book’s ISBN
       uint
   A book’s price 
       ushort
   A book’s shipping weight 
       ushort
   A country’s population 
       float
   The number of stars in the universe 
       decimal
   The number of employees in each of the small or medium businesses in the 
   United Kingdom (up to about 50,000 employees per business) 
       ushort
   2. What are the difference between value type and reference type variables? What is 
   boxing and unboxing?
       1) Value type will direcly hold the value itself while reference type will hold the memory address or reference for this value;
       2) Value types are sorted in stack memory while reference types will be sorted in heap memory;
       3) Value type will not be collected by garbage collector while reference type will be colleted by garbage collector;
       4) Value type can be created by Struct or Enum while reference type can be created by class, interface or arry;
       5) Value type cannot accept null values, but reference types can.
       boxing: convert a value type to reference type;
       unboxing: convert a reference type back to value type.

   3. What is meant by the terms managed resource and unmanaged resource in .NET
       
   
   4. Whats the purpose of Garbage Collector in .NET?
       .NET's garbage collector manages the allocation and release of memory for your application


    1. What happens when you divide an int variable by 0? 
            A DivideByZeroException will be thrown, but dividing a floating-point value by zero doesn't throw an exception
    2. What happens when you divide a double variable by 0? 
        No DivideByZeroException.
    3. What happens when you overflow an int variable, that is, set it to a value beyond its range?
        The wrap will around from maximun back to minimum
    4. What is the difference between x = y++; and x = ++y;? 
        ++y happens prior to assignment (pre-increment), but y++ happens after assignment (post-increment).
        y++ executes the statement and then increments the value. ++y increments the value and then executes the statement.
    5. What is the difference between break, continue, and return when used inside a loop statement? 
        Break will end the loop and execute the rest part of the code; Continue will end the current loop iteration and return control to the loop statement;
        return wiil end all the code and output something.
    6. What are the three parts of a for statement and which of them are required? 
        The initialization (loop variant), the condition, and the advancement to the next iteration.
    7. What is the difference between the = and == operators? 
        "=" is used for assigning the value to a variable;
        "=="  is used for comparing two values. It returns 1 if both the values are equal otherwise returns 0.
    8. Does the following statement compile? for ( ; true; ) ; 
        IDK
    9. What does the underscore _ represent in a switch expression? 
        The underscore _ character replaces the default keyword to signify that it should match anything if reached.
    10. What interface must an object implement to be enumerated over by using the foreach statement? 
        The IEnumerable interface
   **/
    class Program
    {   
        static void Values()
        {
            Console.WriteLine("sbyte:  the number of bytes in memory: 1, the minimum and maximum values it can have: -128 to 127");
            Console.WriteLine("byte:  the number of bytes in memory: 1, the minimum and maximum values it can have: 0 to 255");
            Console.WriteLine("short:  the number of bytes in memory: 2, the minimum and maximum values it can have: -32,768 to 32767");
            Console.WriteLine("ushort:  the number of bytes in memory: 2, the minimum and maximum values it can have: 0 to 65,535");
            Console.WriteLine("int:  the number of bytes in memory: 4, the minimum and maximum values it can have: -2,147,483,648 to 2,147,483,647");
            Console.WriteLine("uint:  the number of bytes in memory: 4, the minimum and maximum values it can have: 0 to 4,294,967,295");
            Console.WriteLine("long:  the number of bytes in memory: 8, the minimum and maximum values it can have: -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807");
            Console.WriteLine("ulong:  the number of bytes in memory: 8, the minimum and maximum values it can have: 0 to 18,446,744,073,709,551,615");
            Console.WriteLine("float:  the number of bytes in memory: 4, the minimum and maximum values it can have: +_1.0e-45 to +_3.4e38");
            Console.WriteLine("double:  the number of bytes in memory: 8, the minimum and maximum values it can have: +_5e-324 to +_1.7e308");
            Console.WriteLine("decimal:  the number of bytes in memory: 16, the minimum and maximum values it can have: +_10e-28 to 7.9e28");
        }

        static void ConvertCenturies(int Centuries)
        {
            sbyte year = (sbyte)(Centuries * 100);
            ushort days = (ushort)(Centuries * 36524);
            int hours = (int)(Centuries * 876576);
            int minutes = (int)(Centuries * 52594560);
            uint seconds = (uint)(Centuries * 3155673600);
            long milliseconds = (long)(Centuries * 3155673600000);
            long microseconds = (long)(Centuries * 3155673600000000);
            ulong nanoseconds = (ulong)(Centuries * 3155673600000000000);

            Console.WriteLine($"{Centuries} centuries = {year} years = {days} days = {hours} hours = {minutes} minutes = {seconds} seconds = " +
                $"{milliseconds} milliseconds = {microseconds} microseconds = {nanoseconds} nanoseconds");
        }

        static void Main()
        {
            int centruies = 1;
            
            Values();
            ConvertCenturies(centruies);
        }
    }
}
