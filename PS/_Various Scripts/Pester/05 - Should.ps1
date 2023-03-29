BeforeAll {
    function Get-User {
        @{
            Name = "Jakub"
            Age = 31
        }
    }
}

Describe "describe" {
    It "user" {
        $user = Get-User

        $user | Should -Not -BeNullOrEmpty -ErrorAction Stop
        $user.Name | Should -Be "Tomas"
        $user.Age | Should -Be 27

    }
}