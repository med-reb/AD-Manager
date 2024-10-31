#script ad client

$DC1 = "poulicroc"
$DC2 = "lab"

function client{

$cards = Get-NetAdapter | Select-Object Name
$networklist = ""


foreach ($card in $cards){
$networklist += ($card.Name)
$networklist += ("/")
}
$networklist = $networklist.Split("/")

$card1 = $networklist[0]
$card2 = $networklist[1]
$card3 = $networklist[2]
$card4 = $networklist[3]
$card5 = $networklist[4]
$card6 = $networklist[5]
$card7 = $networklist[6]
$card8 = $networklist[7]


function RestartComputer{

Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Redemarrer votre ordinateur" Height="300" Width="460" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Label Name="Label_Prenom" Content="Voulez vous redemarrer votre ordinateur ?" HorizontalAlignment="Left"  VerticalAlignment="Top" Margin="35,35,0,0" Width="460" Height="70" FontSize="18" FontFamily="Segoe UI Black"/>
        <Label Name="Label_Prenom2" Content="(Attention ça redemarre instantanément !)" HorizontalAlignment="Left"  VerticalAlignment="Top" Margin="70,70,0,0" Width="460" Height="100" FontSize="12" FontFamily="Segoe UI Black"/>
        <Button x:Name="Yes" Content="Oui" HorizontalAlignment="Left"  VerticalAlignment="Center" Margin="25,0,0,0" Width="200" Height="70" />
        <Button x:Name="No" Content="Non" HorizontalAlignment="Right"  VerticalAlignment="Center" Margin="0,0,25,0" Width="200" Height="70" />
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)





$Window.FindName("Yes").add_click({ 
    Restart-Computer -ComputerName $env:COMPUTERNAME
})


$Window.FindName("No").add_click({ 
    $Window.Close()
}) 
  

$Window.ShowDialog() | Out-Null
}

function RenameComputer{

#write-host("lancement du changement de nom d'ordinateur 2")
Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Client Management" Height="300" Width="460" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="ChangeName2" Content="Changer" HorizontalAlignment="Center"  VerticalAlignment="Bottom" Margin="0,0,0,10" Width="200" Height="70"/>
        <Label Name="Label_Prenom" Content="Nouveau nom d'ordinateur" HorizontalAlignment="Left"  VerticalAlignment="Bottom" Margin="95,0,0,150" Width="300" Height="70" FontSize="20" FontFamily="Segoe UI Black"/>
        <TextBox Name="TextBox_Prenom" HorizontalAlignment="Left"  VerticalAlignment="Bottom" Margin="80,0,0,150" Width="300" Height="35" FontSize="20"/>
        
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window2 = [Windows.Markup.XamlReader]::Load($FormXML)

$Window2.FindName("ChangeName2").add_click({ 
$changenickname = ($Window2.FindName("TextBox_Prenom")).text
#write-host $changenickname
if ($changenickname -eq ""){
$wshell = New-Object -ComObject Wscript.Shell

$wshell.Popup("Vous n'avez entré aucune valeur",30,"Changement du nom d'ordinateur",0x10)
}
else{
#=> CHANGEMENT DE NOM DU PC <=


$wshell = New-Object -ComObject Wscript.Shell

$wshell.Popup("Nom actuel : $env:computername
Nom après redemarrage : $changenickname
Le changement de nom d'ordinateur prendra effet après le redemarrage de l'ordinateur",30,"Changement du nom d'ordinateur",0x40)

RestartComputer


<#
$wshell = New-Object -ComObject Wscript.Shell

$wshell.Popup("Operation Completed",0,"Done",0x1)



la sainte commande : Restart-Computer -ComputerName $env:COMPUTERNAME


$wshell = New-Object -ComObject Wscript.Shell

$wshell.Popup("Nom actuel : $env:computername
Nom après redemarrage : $changenickname
Le changement de nom d'ordinateur prendra effet après le redemarrage de l'ordinateur")
#>

}
})




$Window2.ShowDialog() | Out-Null

}

function Network{



Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="WindowNet" Title="network oslm" Height="300" Width="460" ResizeMode="NoResize">
       
    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <StackPanel Margin="10">
             <ComboBox>
                <ComboBoxItem IsSelected="True">$card1</ComboBoxItem>
                <ComboBoxItem>$card2</ComboBoxItem>
                <ComboBoxItem>$card3</ComboBoxItem>
                <ComboBoxItem>$card4</ComboBoxItem>
                <ComboBoxItem>$card5</ComboBoxItem>
                <ComboBoxItem>$card6</ComboBoxItem>
                <ComboBoxItem>$card7</ComboBoxItem>
                <ComboBoxItem>$card8</ComboBoxItem>
            </ComboBox>
        </StackPanel>
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$WindowNet = [Windows.Markup.XamlReader]::Load($FormXML)
  

$WindowNet.ShowDialog() | Out-Null
}



function test{

Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Client Management" Height="300" Width="460" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="StartJoinDomain" Content="Rejoindre le domaine" HorizontalAlignment="Center"  VerticalAlignment="Top" Margin="0,10,0,0" Width="200" Height="70" />
        <Button x:Name="RenameComputer" Content="Renommer votre pc" HorizontalAlignment="Center"  VerticalAlignment="Center" Width="200" Height="70" />
        <Button x:Name="ChangeIpAddress" Content="Changer d'adresse ip" HorizontalAlignment="Center"  VerticalAlignment="Bottom" Margin="0,0,0,10" Width="200" Height="70" />
        <Button x:Name="Wizard" Content="1337" HorizontalAlignment="Right"  VerticalAlignment="Bottom" Margin="0,0,20,10" Width="50" Height="20" Background="#ffc821"/>
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)





$Window.FindName("StartJoinDomain").add_click({ 
})

$Window.FindName("RenameComputer").add_click({ 
    
    RenameComputer
}) 

$Window.FindName("ChangeIpAddress").add_click({ 
    Network
})  



$Window.ShowDialog() | Out-Null

}
test
}

function ad{
#Creation Domaine pour AD

#Page pour chaque bouton
function cree_user{

Add-Type -AssemblyName PresentationFramework

$ip = 0
$oulist = ""
foreach ($i in Get-ADOrganizationalUnit -Filter * | Select-Object Name){
$ip = $ip + 1

$oulist += ($i.Name)
$oulist += ("/")
}


$oulist = $oulist.Split("/")

$ou1 = $oulist[0]
$ou2 = $oulist[1]
$ou3 = $oulist[2]
$ou4 = $oulist[3]
$ou5 = $oulist[4]
$ou6 = $oulist[5]
$ou7 = $oulist[6]
$ou8 = $oulist[7]

$ip = 0
$grouplist = ""
foreach ($i in Get-ADGroup -Filter * | Select-Object Name){
$ip = $ip + 1

if ($ip -eq 3){
Write-Host($i.Name)
$grouplist += ($i.Name)
$grouplist += ("/")
}

if ($ip -eq 4){
Write-Host($i.Name)
$grouplist += ($i.Name)
$grouplist += ("/")
}

if ($ip -gt 53){
Write-Host($i.Name)
$grouplist += ($i.Name)
$grouplist += ("/")
}
}

$grouplist = $grouplist.Split("/")

$group1 = $grouplist[0]
$group2 = $grouplist[1]
$group3 = $grouplist[2]
$group4 = $grouplist[3]
$group5 = $grouplist[4]
$group6 = $grouplist[5]
$group7 = $grouplist[6]
$group8 = $grouplist[7]


[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Creation Utilisateur" Height="250" Width="460" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="Close2" Content="Créer" HorizontalAlignment="Left" Margin="327,10,0,0" VerticalAlignment="Top" Width="100" Height="54" />
        <Label Name="Label_username" Content="votre username:" HorizontalAlignment="Left" Margin="10,10,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_username" HorizontalAlignment="Left" Height="23" Margin="145,10,0,0" TextWrapping="Wrap" Text="votreusername" VerticalAlignment="Top" Width="160"/>
        <Label Name="Label_Password" Content="votre Password" HorizontalAlignment="Left" Margin="10,41,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_Password" HorizontalAlignment="Left" Margin="145,41,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
        <Label Name="Label_Nom" Content="votre Nom" HorizontalAlignment="Left" Margin="10,71,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_Nom" HorizontalAlignment="Left" Margin="145,71,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
        <Label Name="Label_Prenom" Content="votre Prenom" HorizontalAlignment="Left" Margin="10,102,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_Prenom" HorizontalAlignment="Left" Margin="145,102,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
        <Label Name="Label_OU" Content="votre OU" HorizontalAlignment="Left" Margin="10,133,0,0" VerticalAlignment="Top" Width="130"/>
        <StackPanel>
            <ComboBox Name="TextBox_ou" HorizontalAlignment="Left" Margin="145,133,0,0" VerticalAlignment="Top" Width="160" Height="23">
                    <ComboBoxItem IsSelected="True">$ou1</ComboBoxItem>
                    <ComboBoxItem>$ou2</ComboBoxItem>
                    <ComboBoxItem>$ou3</ComboBoxItem>
                    <ComboBoxItem>$ou4</ComboBoxItem>
                    <ComboBoxItem>$ou5</ComboBoxItem>
                    <ComboBoxItem>$ou6</ComboBoxItem>
                    <ComboBoxItem>$ou7</ComboBoxItem>
                    <ComboBoxItem>$ou8</ComboBoxItem>
            </ComboBox>
        </StackPanel>
        <Label Name="Label_group" Content="votre group" HorizontalAlignment="Left" Margin="10,164,0,0" VerticalAlignment="Top" Width="130"/>
        <StackPanel>
            <ComboBox Name="TextBox_group" HorizontalAlignment="Left" Margin="145,164,0,0" VerticalAlignment="Top" Width="160" Height="23">
                    <ComboBoxItem IsSelected="True">$group1</ComboBoxItem>
                    <ComboBoxItem>$group2</ComboBoxItem>
                    <ComboBoxItem>$group3</ComboBoxItem>
                    <ComboBoxItem>$group4</ComboBoxItem>
                    <ComboBoxItem>$group5</ComboBoxItem>
                    <ComboBoxItem>$group6</ComboBoxItem>
                    <ComboBoxItem>$group7</ComboBoxItem>
                    <ComboBoxItem>$group8</ComboBoxItem>
            </ComboBox>
        </StackPanel>
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)

$Window.FindName("Close2").add_click({ 
    $UserLogin = ($Window.FindName("TextBox_username")).Text
    $Password = ($Window.FindName("TextBox_Password")).Text
    $UserPrenom = ($Window.FindName("TextBox_Prenom")).Text
    $UserNom = ($Window.FindName("TextBox_Nom")).Text
    $OU = ($Window.findname("TextBox_ou")).Text
    $group = ($Window.findname("TextBox_group")).Text
    write-host($UserLogin)
    write-host($UserPrenom)
    write-host($UserNom)
    write-host($Password)
    write-host($OU)
    write-host($group)
    New-ADUser -Name $UserNom $UserPrenom -Username $UserLogin -AccountPassword(ConvertTo-SecureString $Password -AsPlainText -Force) -Path "OU=$OU,DC=$DC1,DC=$DC2"
    Add-ADGroupMember $group -member $UserLogin 
}) 

$Window.ShowDialog() | Out-Null

}
function cree_group{

Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Creation de group" Height="200" Width="500" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="Close2" Content="Créer" HorizontalAlignment="Left" Margin="327,10,0,0" VerticalAlignment="Top" Width="100" Height="54" />
        <Label Name="Label_group" Content="votre group" HorizontalAlignment="Left" Margin="10,35,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_group" HorizontalAlignment="Left" Margin="145,35,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
        <Label Name="Label_ou" Content="votre ou" HorizontalAlignment="Left" Margin="10,65,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_ou" HorizontalAlignment="Left" Margin="145,65,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)

$Window.FindName("Close2").add_click({ 
    $group = ($Window.FindName("TextBox_group")).Text
    $3OU = ($Window.FindName("TextBox_ou")).Text
    write-host($group)
    write-host($3OU)
    New-ADGroup -Name $group -Path "OU=$3OU,DC=$DC1,DC=$DC2" -GroupScope Global 
}) 

$Window.ShowDialog() | Out-Null

}
function cree_ou{

Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Creation d'OU" Height="200" Width="400" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="Close1" Content="Creer dans la racine" HorizontalAlignment="Left" Margin="145,10,0,0" VerticalAlignment="Top" Width="160" Height="55" />
        <Button x:Name="Close2" Content="Creer dans une seconde OU" HorizontalAlignment="Left" Margin="145,100,0,0" VerticalAlignment="Top" Width="160" Height="55" />
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)

$Window.FindName("Close1").add_click({
     ou_racine

}) 
$Window.FindName("Close2").add_click({
     ou_binary

}) 


$Window.ShowDialog() | Out-Null

}
function ou_racine{

Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Creation d'OU" Height="200" Width="450" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="Close1" Content="Créer" HorizontalAlignment="Left" Margin="327,10,0,0" VerticalAlignment="Top" Width="100" Height="54" />
        <Label Name="Label_racine" Content="votre ou" HorizontalAlignment="Left" Margin="10,35,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_racine" HorizontalAlignment="Left" Margin="145,35,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)

$Window.FindName("Close1").add_click({
    $ou = ($Window.FindName("TextBox_racine")).Text
    write-host($ou)
    New-ADOrganizationalUnit -Name $ou -Path "DC=$DC1,DC=$DC2"

}) 

$Window.ShowDialog() | Out-Null

}
function ou_binary{

Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Creation d'OU" Height="200" Width="450" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="Close1" Content="Créer" HorizontalAlignment="Left" Margin="327,10,0,0" VerticalAlignment="Top" Width="100" Height="54" />
        <Label Name="Label_primaire" Content="votre ou primaire" HorizontalAlignment="Left" Margin="10,35,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_primaire" HorizontalAlignment="Left" Margin="145,35,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
        <Label Name="Label_secondaire" Content="votre ou" HorizontalAlignment="Left" Margin="10,65,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_secondaire" HorizontalAlignment="Left" Margin="145,65,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)

$Window.FindName("Close1").add_click({
    $1OU = ($Window.FindName("TextBox_primaire")).Text
    $2OU = ($Window.FindName("TextBox_secondaire")).Text
    write-host($1OU)
    write-host($2OU)
    New-ADOrganizationalUnit -Name $2OU -Path "OU=$1OU,DC=$DC1,DC=$DC2"

}) 

$Window.ShowDialog() | Out-Null

}
function supp_user{

Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Suppression User" Height="200" Width="500" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="Close2" Content="Supprimer" HorizontalAlignment="Left" Margin="327,10,0,0" VerticalAlignment="Top" Width="100" Height="54" />
        <Label Name="Label_removeU" Content="votre user" HorizontalAlignment="Left" Margin="10,35,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_removeU" HorizontalAlignment="Left" Margin="145,35,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)

$Window.FindName("Close2").add_click({ 
    $remove_user = ($Window.FindName("TextBox_removeU")).Text
    write-host($remove_user)
    Remove-ADUser $remove_user -Confirm:$False
}) 

$Window.ShowDialog() | Out-Null

}
function supp_group{

Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Suppression group" Height="200" Width="500" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="Close2" Content="Supprimer" HorizontalAlignment="Left" Margin="327,10,0,0" VerticalAlignment="Top" Width="100" Height="54" />
        <Label Name="Label_removeU" Content="votre group" HorizontalAlignment="Left" Margin="10,35,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_removeG" HorizontalAlignment="Left" Margin="145,35,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)

$Window.FindName("Close2").add_click({ 
    $remove_group = ($Window.FindName("TextBox_removeG")).Text
    write-host($remove_group)
    Remove-ADGroup $remove_group -Confirm:$False
}) 

$Window.ShowDialog() | Out-Null

}
function supp_ou{

Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="Suppression User" Height="200" Width="500" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="Close2" Content="Supprimer" HorizontalAlignment="Left" Margin="327,10,0,0" VerticalAlignment="Top" Width="100" Height="54" />
        <Label Name="Label_removeOU" Content="votre OU" HorizontalAlignment="Left" Margin="10,35,0,0" VerticalAlignment="Top" Width="130"/>
        <TextBox Name="TextBox_removeOU" HorizontalAlignment="Left" Margin="145,35,0,0" VerticalAlignment="Top" Width="160" Height="23"/>
    </Grid>
</Window>
"@

$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)

$Window.FindName("Close2").add_click({ 
    $remove_ou = ($Window.FindName("TextBox_removeOU")).Text
    write-host($remove_ou)
    Remove-ADOrganizationalUnit -Identity "OU=$remove_ou,DC=$DC1,DC=$DC2"
}) 

$Window.ShowDialog() | Out-Null

}

#Fenetre primaire pour AD MANAGEMENT
Add-Type -AssemblyName PresentationFramework

[xml]$XML = @"
        <Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" 
        x:Name="Window" Title="AD Management" Height="700" Width="300" ResizeMode="NoResize">

    <Grid x:Name="LayoutRoot" Background="#FFC1C3CB">
        <Button x:Name="Close1" Content="Creer User" HorizontalAlignment="Center" Margin="0,86,0,0" VerticalAlignment="Top" Width="122" Height="54" />
        <Button x:Name="Close2" Content="Creer group" HorizontalAlignment="Center" Margin="0,159,0,0" VerticalAlignment="Top" Height="53" Width="122"/>
        <Button x:Name="Close3" Content="Creer OU" HorizontalAlignment="Center" Margin="0,232,0,0" VerticalAlignment="Top" Height="52" Width="122"/>
        <Button x:Name="Close4" Content="Supprimer user" HorizontalAlignment="Center" Margin="0,311,0,0" VerticalAlignment="Top" Height="52" Width="122"/>
        <Button x:Name="Close5" Content="Supprimer group" HorizontalAlignment="Center" Margin="0,385,0,0" VerticalAlignment="Top" Height="51" Width="122"/>
        <Button x:Name="Close6" Content="Supprimer OU" HorizontalAlignment="Center" Margin="0,458,0,0" VerticalAlignment="Top" Height="52" Width="122"/>
        <Label Content="   AD Management" HorizontalAlignment="Center" Margin="0,29,0,0" VerticalAlignment="Top" Width="196" Height="86" FontSize="20" FontFamily="Segoe UI Black"/>
    </Grid>
</Window>
"@
#Ouverture des autres fenetre
$FormXML = (New-Object System.Xml.XmlNodeReader $XML)
$Window = [Windows.Markup.XamlReader]::Load($FormXML)

$Window.FindName("Close1").add_click({ 
    cree_user
}) 
$Window.FindName("Close2").add_click({ 
    cree_group
}) 
$Window.FindName("Close3").add_click({ 
    cree_ou
}) 
$Window.FindName("Close4").add_click({ 
    supp_user
}) 
$Window.FindName("Close5").add_click({ 
    supp_group
}) 
$Window.FindName("Close6").add_click({ 
    supp_ou
}) 

$Window.ShowDialog() | Out-Null
}


ad
<#

$windowsversion = Get-ComputerInfo | select WindowsProductName
$productversion = $windowsversion.WindowsProductName.split(" ")

if($productversion[1] -eq "Server"){
ad
}
else{
client

}

#>