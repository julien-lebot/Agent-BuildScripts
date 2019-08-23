$installationPath = & "$Env:programfiles `(x86`)\Microsoft Visual Studio\Installer\vswhere.exe" -products 'Microsoft.VisualStudio.Product.BuildTools' -property InstallationPath
if ($installationPath -and (test-path "$installationPath\Common7\Tools\vsdevcmd.bat")) {
  & "${env:COMSPEC}" /s /c "`"$installationPath\Common7\Tools\vsdevcmd.bat`" -no_logo && set" | foreach-object {
    $name, $value = $_ -split '=', 2
    set-content env:\"$name" $value
  }
}
ridk enable
inv agent.omnibus-build --base-dir=C:\.omnibus-ruby
