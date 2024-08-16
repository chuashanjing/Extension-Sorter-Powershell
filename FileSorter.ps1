$folder = "<Full File Path of folder you want to sort>"
$contents = Get-ChildItem -Path "$folder" -File


function allExtensions(){
    $nameArray = @()
    $extensionArray = @()

    foreach($file in $contents){
        $fileName = $file.Name
        $split = $fileName.Split('.')
        $nameArray += $split[0]
        $extensionArray += $split[1]
    }

    
    CreateFolder $nameArray $extensionArray
}

function CreateFolder($nameArray, $extensionArray){
    
    foreach($ext in $extensionArray){
        $ext = $ext.ToUpper()
        $ready = $false

        if(Test-Path "$folder\$($ext)_Files"){
            Write-Output "$($ext)_Files exists"
            $ready = $true
        }
        else{
             New-Item -Path "$folder\$($ext)_Files" -ItemType Directory
             $ready = $true
        }
        
    }
    
    MoveFiles $ready $nameArray $extensionArray
    
}

function MoveFiles($ready, $nameArray, $extensionArray){
    
    for($i = 0; $i -lt $nameArray.Length; $i++){
        $ext = $extensionArray[$i].ToUpper()
        $fileName = "$($nameArray[$i]).$($extensionArray[$i])"
        $sourcePath = "$folder\$fileName"
        $destinationPath = "$folder\$($ext)_Files"
        
        if($ready){
            
            Move-Item -Path $sourcePath -Destination $destinationPath
            Write-Output "Moved $fileName to $($ext)_Files"
        
        }


    }

}


allExtensions