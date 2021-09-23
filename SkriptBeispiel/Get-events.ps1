<#
.Synopsis
   Kurzbeschreibung des Skrips
.DESCRIPTION
   Lange Beschreibung des Skriptes welches verwendet werden kann zum abfragen von Anmeldebezogenen Events.
.EXAMPLE
   Get-events.ps1 -EventId 4625 -Newest 2

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
   24255 Sep 23 13:24  FailureA... Microsoft-Windows...         4625 Fehler beim Anmelden eines Kontos....
   24254 Sep 23 13:24  FailureA... Microsoft-Windows...         4625 Fehler beim Anmelden eines Kontos....
.EXAMPLE
   Get-events.ps1 -EventId 4625 -Newest 2 -Verbose
   AUSFÜHRLICH: Optionaler Hinweiß: Der User hat die EventID 4625 benutzt

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
   24255 Sep 23 13:24  FailureA... Microsoft-Windows...         4625 Fehler beim Anmelden eines Kontos....
   24254 Sep 23 13:24  FailureA... Microsoft-Windows...         4625 Fehler beim Anmelden eines Kontos....
#>
[cmdletBinding()]
param(

[ValidateScript({Test-NetConnection -ComputerName $PSItem -CommonTCPPort WinRM -InformationLevel quiet})]
[string]$ComputerName = "localhost",

[ValidateSet(4624,4625,4634)]
[Parameter(Mandatory=$true)]
[int]$EventId,

[ValidateRange(5,10)]
[int]$Newest = 5

)

#Kommentarzeile  

<#
    Kommentarbereich
#>

#write-Verbose gibt optionale Meldungen aus wenn das Skript mit dem Parameter -Verbose gestartet wird
Write-Verbose -Message "Optionaler Hinweiß: Der User hat die EventID $EventID benutzt"

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventId -eq $EventId | Select-Object -First $Newest

