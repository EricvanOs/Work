$Path = 'K:\_CM\_Various Scripts\XML'

[XML]$AppConfig = Get-Content -Path (Join-Path -Path $Path -ChildPath 'ApplicationHost.config')


# Use a single slash for an absolute path or a double-slash for a relative path in XML code

#searching nodes

$AppConfig | Select-Xml -Xpath '//modules'  # have to expand propery node

$AppConfig | Select-Xml -Xpath '//modules'  | Select-Object -ExpandProperty node | Select-Object -Property OuterXml


$ThisNode = $AppConfig | Select-Xml -Xpath '//modules'  | Select-Object -ExpandProperty node

$ThisNode | Select-Object -Property *

$ThisNode | Select-Object -ExpandProperty ChildNodes


# searching attributes

$AppConfig | Select-XML -Xpath "//*[@name='StaticFileModule']"   

# Filtering and Wildcards

$AppConfig | Select-XML -XPath "//modules/*[@name='StaticFileModule']"

# Searching with multiple levels in the hierarchy

$AppConfig | Select-XML -Xpath "//*[*/@name='StaticFileModule']"

$AppConfig | Select-XML -XPath "//*[*/*/@name='StaticFileModule']"


