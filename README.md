bashrc_my
=========

1. Copies itself to /etc/profile.d/ if needed (change if your bash uses another directory to autoload scripts).
1. Loads git's built-in scripts from /usr/share/git-core/contrib/completion/git-prompt.sh (change if your git is installed into a different directory).
1. Welcomes you with a fortune if one found (change or disable as needed).
1. Creates a colorful and informative git-oriented bash prompt.
1. Adds the following aliases:

  - gita (git add -i)
  - gitc (enter message and commit locally)
  - gitch \<commit\> (git checkout)
  - gitd \[\<old\>\] \[\<new\>\] (git diff)
  - gitl \<number of commits\> (git log --all --oneline --decorate --abbrev-commit --graph -n)
  - gitp (git push -u --tags origin master)
  - gitpl \[\<remote\>\] \[\<branch\>\] (git pull)
  - gits (git status -sb)
  - gitst (git stash)
  - gitsti (git stash --keep-index)
  - gitstl (git stash list)
  - gitstp (git stash pop)
  - gitstpi (git stash pop --index)
