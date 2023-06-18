# https://www.powershellcenter.com/2022/07/15/new-mgchat/

# Graph Explorer is one of the best ways to start as it helps find information about the needed endpoint and permissions.

# The Endpoint used to create chat is https://graph.microsoft.com/v1.0/chats

Connect-MgGraph -Scopes  'Chat.ReadBasic, Chat.Read, Chat.ReadWrite'

Get-MgChat


Import-Module Microsoft.Graph.Teams

$params = @{
	ChatType = "oneOnOne"
	Members = @(
		@{
			"@odata.type" = "#microsoft.graph.aadUserConversationMember"
			Roles = @(
				"owner"
			)
			"User@odata.bind" = "https://graph.microsoft.com/v1.0/users('xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx')"
		}
		@{
			"@odata.type" = "#microsoft.graph.aadUserConversationMember"
			Roles = @(
				"owner"
			)
			"User@odata.bind" = "https://graph.microsoft.com/v1.0/users('yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyy')"
		}
	)
}

$myChatSession = New-MgChat -BodyParameter $params





$Body = @{
    ContentType = 'html'
    Content = @'
    <img height="200" src="../hostedContents/1/$value" width="200" style="vertical-align:bottom; width:700px; height:700px">
    <Strong>I am a nice bot</Strong>
'@
}

$HostedContents = @(
    @{
        "@microsoft.graph.temporaryId" = "1"
        ContentBytes = [System.IO.File]::ReadAllBytes("C:\Users\f.malaeb\Pictures\ShellBot.png")
        ContentType = "image/png"
    }
)


New-MgChatMessage -ChatId $myChatSession.id -Body $Body -HostedContents $HostedContents