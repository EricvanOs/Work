
using System.Collections.ObjectModel;
using System.Management.Automation;

namespace ConsoleApp3
{
    internal class Program
    {
        static void Main(string[] args)
        {
            PowerShell ps = PowerShell.Create();
            ps.AddScript(File.ReadAllText(@"C:\Scripts\script01.ps1"));
            Collection<PSObject> results = ps.Invoke();
            foreach (PSObject result in results)
            {
                PSMemberInfoCollection<PSMemberInfo> memberInfos = result.Members;
                Console.WriteLine(memberInfos["Id"].Value);
            }
        }
    }
}




using System.Collections.ObjectModel;
using System.Management.Automation;

namespace ConsoleApp3
{
    internal class Program
    {
        static void Main(string[] args)
        {
            PowerShell ps = PowerShell.Create();
            ps.AddCommand("Get-Process");
            ps.AddParameter("Name", "msedge");
            Collection<PSObject> results = ps.Invoke();
            foreach (PSObject result in results)
            {
                PSMemberInfoCollection<PSMemberInfo> memberInfos = result.Members;
                Console.WriteLine(memberInfos["id"].Value);
            }
        }
    }
}




using CliWrap;
using CliWrap.Buffered;

namespace ConsoleApp2
{
    public class Program
    {
        public static async Task Main(string[] args)
        {
            var dbDailyTasks = await Cli.Wrap("powershell")
                .WithWorkingDirectory(@"C:\Scripts")
                .WithArguments(new[] { @"C:\Scripts\script01.ps1" })
                .ExecuteBufferedAsync();

            Console.WriteLine(dbDailyTasks.StandardOutput);
            Console.WriteLine(dbDailyTasks.StandardError);
            Console.ReadLine();
        }
    }
}




using CliWrap;
using CliWrap.Buffered;

namespace ConsoleApp2
{
    public class Program
    {
        public static async Task Main(string[] args)
        {
            var dbDailyTasks = await Cli.Wrap("powershell")
                .WithArguments(new string[] { "Get-Process", "-Name", "\"msedge\"" })
                .ExecuteBufferedAsync();

            Console.WriteLine(dbDailyTasks.StandardOutput);
            Console.WriteLine(dbDailyTasks.StandardError);
            Console.ReadLine();
        }
    }
}
