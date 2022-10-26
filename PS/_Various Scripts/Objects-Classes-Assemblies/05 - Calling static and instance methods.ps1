$code = @"
using System;
public class HelloWorld
{
    public static string SayHello(string name)
        {
        return (String.Format("Hello there {0}", name));
        }
    public string GetLuckyNumber(string name)
        {
        Random random = new Random();
        int randomNumber = random.Next(0, 100);
        string message = String.Format("{0}, your lucky" +
        " number for today is {1}",
        name, randomNumber);
        return message;
        }
}
"@



#add this code to current session
Add-Type -TypeDefinition $code


#call static method
[HelloWorld]::SayHello('Belle')


#call instance method

$obj = New-Object helloworld
$obj.GetLuckyNumber("Belle")

