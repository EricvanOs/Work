
# this will fail if the user running the command
# does not have permissions and privileges

Set-CorpComputerState -ComputerName LON-DC1 -State PowerOff -Force -Verbose

