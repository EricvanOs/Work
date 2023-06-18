Connect-MgGraph -Scopes 'User.Read.All','Group.Read.All','Group.ReadWrite.All'

# create security group
$GroupParam = @{
    DisplayName = "SG-SecurityNoOwnerNoMember"
    GroupTypes = @(
    )
    SecurityEnabled     = $true
    IsAssignableToRole  = $false
    MailEnabled         = $false
    MailNickname        = (New-Guid).Guid.Substring(0,10)
}

New-MgGroup -BodyParameter $GroupParam

#clean up
Remove-MgGroup -GroupId (Get-MgGroup -All | Where-Object{$_.DisplayName -eq 'SG-SecurityNoOwnerNoMember'}).Id


# Create A Security Group with an Owners

$GroupParam = @{
    DisplayName = "SG-SecurityGroupWithOwner"
    GroupTypes = @(
    )
    SecurityEnabled     = $true
    IsAssignableToRole  = $false
    MailEnabled         = $false
    MailNickname        = (New-Guid).Guid.Substring(0,10)
    "Owners@odata.bind" = @(
        "https://graph.microsoft.com/v1.0/me",
        "https://graph.microsoft.com/v1.0/users/evanos@in-li.eu",
        "https://graph.microsoft.com/v1.0/users/1002e9f6-6269-417d-9bc8-e016527c540f"
    )
}

New-MgGroup -BodyParameter $GroupParam

#clean up
Remove-MgGroup -GroupId (Get-MgGroup -All | Where-Object{$_.DisplayName -eq 'SG-SecurityGroupWithOwner'}).Id

# Create A Group with an Owner and Members

$GroupParam = @{
    DisplayName = "SG-SecurityGroupWithOwnerAndMembers"
    GroupTypes = @(
    )
    SecurityEnabled     = $true
    IsAssignableToRole  = $false
    MailEnabled         = $false
    MailNickname        = (New-Guid).Guid.Substring(0,10)
    "Owners@odata.bind" = @(
        "https://graph.microsoft.com/v1.0/me",
        "https://graph.microsoft.com/v1.0/users/evanos@in-li.eu"
    )
    "Members@odata.bind" = @(
        "https://graph.microsoft.com/v1.0/me",
        "https://graph.microsoft.com/v1.0/users/Caesar@in-li.eu"
    )
}

New-MgGroup -BodyParameter $GroupParam

#clean up
Remove-MgGroup -GroupId (Get-MgGroup -All | Where-Object{$_.DisplayName -eq 'SG-SecurityGroupWithOwnerAndMembers'}).Id


# Create A Dynamic Security Group with Membership Rules -- lukt

$GroupParam = @{
    DisplayName = "SG-DynamicSecurityGroup"
    GroupTypes = @(
        'DynamicMembership'
    )
    SecurityEnabled     = $true
    IsAssignableToRole  = $false
    MailEnabled         = $false
    membershipRuleProcessingState = 'On'
    MembershipRule = '(user.accountEnabled -eq true) and (user.Country -eq "Italy")'
    MailNickname        = (New-Guid).Guid.Substring(0,10)
    "Owners@odata.bind" = @(
        "https://graph.microsoft.com/v1.0/me"
    )
}

New-MgGroup -BodyParameter $GroupParam

#clean up
Remove-MgGroup -GroupId (Get-MgGroup -All | Where-Object{$_.DisplayName -eq 'SG-DynamicSecurityGroup'}).Id



