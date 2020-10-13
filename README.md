# CURRENT

## welcome.sh

Checks if there is fortune installed, and if there is, shows one not too long; otherwise, just says hello.

Should be called before the powerlevel10k's instant prompt.

## my.sh

The main script setting some options, and initializing the theme.

In the case of powerlevel9k, theme customizations are defined in this file.
In the case of powerlevel10k, theme customizations are defined in `p10k.sh`.

## p10k.sh

Customizations of the powerlevel10k theme.

Should be called after ~/.p10k.zsh.

## aliases.sh

Some convenient aliases.

Should be called last.

## zshrc.sh

This is where the scripts above are called from.

Create a link ~/.zshrc -> zshrc.sh.

---

# LEGACY

## bashrc_my.sh

1. Copies itself to /etc/profile.d/ if needed (change if your bash uses another directory to autoload scripts).
1. Loads git's built-in scripts from /usr/share/git-core/contrib/completion/git-prompt.sh (change if your git is installed into a different directory).
1. Welcomes you with a fortune if one found (change or disable as needed).
1. Creates a colorful and informative git-oriented bash prompt.
1. Adds the following aliases:

  - gita (git add -i)
  - gitam (git commit --amend)
  - gitc (enter message and commit locally)
  - gitch \<commit\> (git checkout)
  - gitd \[\<old\>\] \[\<new\>\] (git diff)
  - gitl \<number of commits\> (git log --all --oneline --decorate --abbrev-commit --graph -n)
  - gitlb \<number of commits\> \<branch\> -- (git log --oneline --decorate --abbrev-commit --graph -n)
  - gitp (git push -u --tags origin master)
  - gitpb \<branch\> (git push -u --tags origin)
  - gitpl \[\<remote\>\] \[\<branch\>\] (git pull)
  - gits (git status -sb)
  - gitst (git stash)
  - gitsti (git stash --keep-index)
  - gitstl (git stash list)
  - gitstp (git stash pop)
  - gitstpi (git stash pop --index)
