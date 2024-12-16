# SSH Environment Manager

Manage multiple ssh environments, switch between them, create new envs, inject envs to ssh machines.

# Installation

```bash
curl -sSf https://raw.githubusercontent.com/gndps/generic_envs/refs/heads/main/ssh/install_sshenv.sh | bash
```

# Usage
## Profile 
Sshenv manages environments using profiles. Each ssh keypair needs to be initialized into a profile for it to be managed by sshenv.

## Initialize profile
An existing ssh key pair (id_rsa public/private or any other encryption) can be initialized as a profile using:
```
sshenv init myprofile
```

Then the initialized profile can be seen like:
```
sshenv list
```

This creates a copy of the keypair in a folder named `myprofile` in `~/.ssh/archive`
>>>
    * myprofile
      other_profile
>>>

## Switch profile
```
sshenv switch
```

>>>
      myprofile
    * other_profile
>>>
This deletes any keypair in `~/.ssh` and copy the next profile keypair files to `~/.ssh`.
It will only work if all the keypairs in `~/.ssh` are initialized as profiles, i.e. backed up as profiles, otherwise an error will be printed. So any accidental deletion of keys never gets triggered unless `sshenv clear -f` is used.

## Activate profile
Similar to switch, but this takes the profile name as argument
```
sshenv activate other_profile
```

>>>
      myprofile
    * other_profile
>>>

# Usage Doc / Help
```
sshenv -h

Usage: sshenv.sh [command] [arguments]
Commands:
  init [profile_name]     Initialize a new sshenv profile (using ~/.ssh/id_rsa, id_rsa.pub) and activate it
  activate [profile_name] Activate SSH key-pair from the archive
  list                    List all archived sshenv profiles
  delete                  Delete the current sshenv profile (it does not delete ~/.ssh/id_rsa, id_rsa.pub)
  switch                  Switch to the next sshenv profile
  new [-f]                Generate a new SSH key-pair (requires -f to overwrite existing keys if not saved)
  clear [-f]              Clear SSH keys from the default location (requires -f to overwrite existing keys if not saved)
  copy [profile_name]     Copy public key for profile or default key in ~/.ssh to clipboard
  locate                  Print the name of the default SSH key file in ~/.ssh directory
  inject                  Copy sshenv profiles to a remote machine
                              Usage: sshenv inject --host <host> --profiles <profile1> <profile2> ...
                              Special profile 'self' copies sshenv script to ~/.ssh/sshenv on remote
```

# Tips
Most frequently used command is sshenv switch, whose alias is already included in the sshenv file.
```
alias sdfv="sshenv switch"
alias sdf="sshenv"
```

So currently active ssh profile can be seen using `sdf`. And next profile can be activated using `sdfv`.