# Set up the completions for my commonly used commands.
#

$completions_path = "$PSScriptRoot\completions"

$files = Get-ChildItem -Path $completions_path -Filter "*.ps1" -File
foreach ($file in $files) {
  Write-Host "Running PowerShell completion script: $($file.Name)"
  . ${completions_path}\$($file.Name)
}

# Additional self-compiled commands
# kubens and kubectx are here.
$env:PATH += ";$HOME\.bin;$HOME\.cargo\bin"

$enableBashCompletions = ($Null -ne (Get-Command bash -ErrorAction Ignore)) -or ($Null -ne (Get-Command git -ErrorAction Ignore))
if ($enableBashCompletions) {
  Import-Module -Name PSBashCompletions -Scope Global

  # Register-BashArgumentCompleter git "$completions_path\git-completions.bash"
  $files = Get-ChildItem -Path $completions_path -Filter "*.bash" -File
  foreach ($file in $files) {
    $name = $($file.Name)
    $command = $($name).Split(".")[0]
    Write-Host "Registering bash completion for $command at $name"
    Register-BashArgumentCompleter $command "${completions_path}/${name}"
  }
}
