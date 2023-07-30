

$ServicesFilePath="C:\Users\triet\Desktop\PSproject\Services.csv"
$ServicesList=Import-Csv -Path $ServicesFilePath -Delimiter ','
$LogPath="C\users\triet\desktop\psproject"
$LogFile="Services-$(Get-Date -Format "yyyy-MM-dd hh-mm").txt"
foreach($Service in $ServicesList){
    $CurrentServiceStatus=(Get-Service -Name $Service.Name).status
    if($Service.Status -ne $CurrentServiceStatus){
        $Log="Service : $($Service.Name) is currently $CurrentServiceStatus, should be $($Service.Status)"
        Write-Output $Log
        $Log="Setting $($Service.Name) to $($Service.Status)"
        Write-Output $Log
        
        if($Service.Status -eq "Stopped"){
            Stop-Service -Name $Service.Name -Force
        }
        else{
        Set-Service -Name $Service.Name -Status $Service.Status}

        $AfterServiceStatus=(Get-Service -Name $Service.Name).Status
        if($Service.Status -eq $AfterServiceStatus){
            $Log="Action was succesful Service $($Service.Name) is now $AfterServiceStatus"
            Write-Output $Log 
            }else{
            $Log="Action failed Service $($Service.Name) is still $AfterServiceStatus, should be $($Service.Status)"
            Write-Output $Log
             }
    }
}