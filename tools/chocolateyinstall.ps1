$ErrorActionPreference = 'Stop';

[[AutomaticPackageNotesInstaller]]
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
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '6d34dcc39b09e2059d773dad0092b0cace80726e887fe1905e4a5cb92c521012'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart" 
  validExitCodes= @(0, 3010, 1641)
}


Install-ChocolateyPackage @packageArgs
