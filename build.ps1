param(
    [Parameter(Mandatory)] $version
)
$ErrorActionPreference = "Stop"
If(-Not (Test-Path .\apache-maven-$version-bin.zip)){
    Invoke-WebRequest https://dlcdn.apache.org/maven/maven-3/$version/binaries/apache-maven-$version-bin.zip -OutFile .\apache-maven-$version-bin.zip
    Invoke-WebRequest https://downloads.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-$version-bin.zip.sha512 -OutFile .\apache-maven-$version-bin.zip.sha512
}
$actualHash = (Get-FileHash -Algorithm SHA512 .\apache-maven-$version-bin.zip).Hash
$expectedHash = (Get-Content .\apache-maven-$version-bin.zip.sha512)
Write-Host $actualHash ":" $expectedHash
If (-Not ($actualHash -eq $expectedHash))
{
    Write-Error "Checksum of ZIP mismatches: Aborting ..."
    Exit -1
}
If(Test-Path .\distro) {
    Remove-Item -Recurse -Force .\distro
}
Expand-Archive -Path .\apache-maven-$version-bin.zip -DestinationPath .
Rename-Item -Path .\apache-maven-$version -NewName .\distro
wix build .\apache-maven.wxs -o .\apache-maven-$version.msi
