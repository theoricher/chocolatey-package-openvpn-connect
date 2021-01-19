$ErrorActionPreference = 'Stop';


$packageName= 'openvpnconnect'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$fileLocation = Join-Path $toolsDir 'NAME_OF_EMBEDDED_INSTALLER_FILE'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = 'https://swupdate.openvpn.net/downloads/connect/openvpn-connect-3.2.2.1455_signed_x86.msi'
  url64bit      = 'https://swupdate.openvpn.net/downloads/connect/openvpn-connect-3.2.2.1455_signed.msi'
  #file         = $fileLocation

  softwareName  = 'OpenVPN Connect'

  checksum      = '16ddae747917395ec45a3578ab38eee9d69a72827cd35b04dcd8e15f75ef2446'
  checksumType  = 'sha256'
  checksum64    = '6d34dcc39b09e2059d773dad0092b0cace80726e887fe1905e4a5cb92c521012'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart" 
  validExitCodes= @(0, 3010, 1641)
}

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# Load custom functions
. "$toolsDir\utils\utils.ps1"
$trustedPublisherCertificate = "$toolsDir\openvpn_trusted_publisher.cer"
$trustedPublisherCertificateHash = '8f53adb36f1c61c50e11b8bdbef8d0ffb9b26665a69d81246551a0b455e72ec0b26a34dc9b65cb3750baf5d8a6d19896c3b4a31b578b15ab7086377955509fad'
Write-Host "Adding OpenVPN to the Trusted Publishers (needed to have a silent install of the TAP driver)..."
AddTrustedPublisherCertificate -file "$trustedPublisherCertificate"

Install-ChocolateyPackage @packageArgs

Write-Host "Removing OpenVPN from the Trusted Publishers..."
RemoveTrustedPublisherCertificate -file "$trustedPublisherCertificate"