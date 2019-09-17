﻿cls
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath

for ($a = 0; $a -lt 40; $a++) {
   $RandomWord = (48..57) + (65..90) + (97..122) | Get-Random -Count 1 | % {[char]$_}
   $RandomQuestion = Get-Random -InputObject("What+is+","Definition+of+","Pronunciation+of+","Thesaurus+","Examples+of+","prefixes+for+","suffixes+for+")
   Start-Process "microsoft-edge:http://www.bing.com/search?q=$RandomQuestion$RandomWord"  -WindowStyle Minimized
   start-sleep -Milliseconds 800
}
start-sleep -Milliseconds 2000

$CP = Get-Process -Name MicrosoftEdgeCP | Select -ExpandProperty Processname
$sh = Get-Process -Name MicrosoftEdgeSH | Select -ExpandProperty Processname

while ($cp.count -gt 0) {
    Stop-Process -Name MicrosoftEdgeCP -Force -PassThru
    Start-Sleep -Milliseconds 200
    $CP = Get-Process -Name MicrosoftEdgeCP -ErrorAction SilentlyContinue | Select Processname
}

while ($sh.count -gt 0) {
    Stop-Process -Name MicrosoftEdgeSH -Force -PassThru
    Start-Sleep -Milliseconds 200
    $sh = Get-Process -Name MicrosoftEdgeSH  -ErrorAction SilentlyContinue | Select Processname
}

Stop-process -name  MicrosoftEdge -Force -PassThru