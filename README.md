# PSProTips

PowerShell Setup - Tab Completions, Aliases, Tips and Tricks.

In PowerShell, your profile script is located in a file referred
to by the `$PROFILE` environment variable.

Tools like Rancher Desktop include command-line integrations for
PowerShell that provide support for Tab Completions.

For example, the `kubectl` CLI command has a `completion` subcommand.

```powershell
kubectl.exe -h | bash -c 'grep -i complet'
  completion      Output shell completion code for the specified shell (bash, zsh, fish, or powershell)
```

For commands that implement the PowerShell native completion mechanism,
we simply need to `source` the resulting PowerShell script.

For bash completion, there is existing code that provides a bridge between
bash completion files and PowerShell completion code: <https://github.com/tillig/ps-bash-completions>

## Powershell Profile Configuration

To implement this in your setup, you'll need to copy or merge in
my PowerShell profile script.

The directory structure in the directory where your profile script
is located will look like the following:

.── Microsoft.PowerShell_profile.ps1
├── completions
    ├── Aliases.ps1
    ├── cargo.bash
    ├── git.bash
    ├── helm.ps1
    ├── kubectx.bash
    ├── kubens.bash
    ├── kubernetes.ps1
    ├── nerdctl.ps1
    └── rustup.ps1

The code in the `PowerShell_profile.ps1` file looks for the files
in the `completions` directory, and if they have the extension `.ps1` they
are treated one way, and if they have a `.bash` extension, they will
be used to register bash completion using the `ps-bash-completions` mechanism
referenced above.

I have tested the `kubectl` and `helm` and `nerdctl` completions and they work well.

## Aliases

Because we are already including anything that has a `.ps1` extension upon
loading the PowerShell profile, I also used the file `Aliases.ps1` to
consolidate aliases in one place.

## [Caveat Emptor](https://www.findlaw.com/consumer/consumer-transactions/what-does-caveat-emptor-mean-.html)

NOTE: Among the `bash` completions, `git` works perfectly with this mechanism (allowing you
to auto-complete git subcommands, branch names, etc.) however, some bash completion
scripts do not work out of the box and I have not debugged the issue.

If you do find the reason, please file a pull request against my repository and share with
the development team!
