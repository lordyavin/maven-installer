# Apache Maven Installer

## Building installer

To build [minimum installer](Product.wxs) run in PowerShell as Administrator:
```PowerShell
winget install WiXToolset.WiXToolset WiXToolset.WiXCLI
.\build.ps1 -version <maven-version>
```

## Credits
Thanks to [kurtanr](https://github.com/kurtanr) for providing [examples for WiX based Windows installers](https://github.com/kurtanr/WiXInstallerExamples).
