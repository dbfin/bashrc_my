# CURRENT

## zshrc.sh

This is the main script to be called.

It does the following:

- Sets some common constants.
- Determines whether `powerlevel10k` or `powerlevel9k` is installed.
- Sets `zsh`-related parameters.
- Sources `welcome.sh` that shows a welcome message probably with a fortune.
- For `powerlevel10k` sources its instant prompt script, for `powerlevel9k` sources `p9k_pre.sh` instead.
- Sources `init.sh` that loads plugins/themes (local versions or using a plugin manager) and binds keys.
- For `powerlevel10k` sources `.p10k.zsh` if it exists (use `p10k configure` to create one).
- For `powerlevel10k` sources `p10k_post.sh`, for `powerlevel9k` sources `p9k_post`.
- Sources `aliases.sh` to create aliases.

Create a link `~/.zshrc` -> `zshrc.sh`.

## welcome.sh

Welcomes the user.

Checks if `fortune` is installed, and if it is, shows one not too long; otherwise, just says hello.

Should be called before the `powerlevel10k`'s instant prompt.

## p9k_pre.sh

Customizations of the `powerlevel9k` theme.

For `powerlevel9k` some settings need to be defined before the theme is sourced.

Should be called before `init.sh`.

## init.sh

Loads plugins and the theme, and binds keys.

For each plugin first checks whether it is installed locally, and if not, uses a plugin manager to load it. If `zshrc.sh` finds a theme, sources it, otherwise uses the plugin manager to load it as well.

Binds keys including `Ctrl+L` to clear scrollback and reset the terminal, `up` and `down` keys for plugin `history-substring-search` etc.

## p9k_post.sh, p10k_post.sh

Customizations of the `powerlevel9k` and `powerlevel10k` themes.

These change the default theme parameters, and, for `powerlevel10k`, those defined in `~/.p10k.zsh`.

Should be called after `init.sh`. Also, `p10k_post.sh` should be called after `~/.p10k.zsh`.

## aliases.sh

Some convenient aliases.

Should be called last.

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
