Open-HeliosVault

$BotToken = Get-Secret -Name TelegramAccessToken -Vault ScriptingVault -AsPlainText
$ChatID = Get-Secret -Name TelegramChatID -Vault ScriptingVault -AsPlainText

Close-HeliosVault

# which command are available?
get-command -Module PoshGram

#testing
Test-BotToken -BotToken $BotToken 

# send a message
Send-TelegramTextMessage -BotToken $BotToken -ChatID $ChatID -Message "Going strong"