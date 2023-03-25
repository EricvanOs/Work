[DSCLocalConfigurationManager()]
configuration AdatumLCMConfig
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Push'
            ConfigurationMode = 'ApplyandAutoCorrect'
        }
    }
} 
