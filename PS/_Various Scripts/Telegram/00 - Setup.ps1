# how to install - whatch video

# you get
# Telegram Access Token 
5478454225:AAGIyyyyhpppZl0QaW_7sTYJeUyv4622R7Y

# GroupId (xHelios) : include minus-sign
-6462898898

# install telegram desktop edition as well (not needed, but handy)

# to test use in browser
https://api.telegram.org/bot{TOKEN}/getUpdates

# and send message
https://api.telegram.org/bot{TOKEN}/sendmessage?chat_id={GroupID}&text=Hello+World


# install poshgram module
install -module PoshGram

# add secrets to vault
Open-HeliosVault

Set-Secret -Name TelegramAccessToken -Secret "5478454225:AAGIyyyyhpppZl0QaW_7sTYJeUyv4622R7Y" -Vault ScriptingVault
Set-Secret -Name TelegramChatID  -Secret '-6462898898' -Vault ScriptingVault

Close-HeliosVault

