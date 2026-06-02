# Interactive aliases & abbreviations.

status is-interactive; or return

# --- navigation --------------------------------------------------------------
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'

# --- system ------------------------------------------------------------------
abbr -a c clear
abbr -a path 'string split : -- $PATH'

# --- btop --------------------------------------------------------------------
if command -q btop
    abbr -a top 'btop -p 0'
    abbr -a psi 'btop -p 1'
end

# --- brew -----------------------------------------------------------------
if command -q brew
    abbr -a bruc 'brew update && brew upgrade && brew cleanup'
end

# --- lazygit -----------------------------------------------------------------
if command -q lazygit
    abbr -a lg lazygit
end

# --- bat — alias (not abbr) so history records `cat`. -----------------------
if command -q bat
    alias cat 'bat --paging=never --style=plain'
end

# --- eza — flags repeated verbatim per entry for easy diffing. ---------------
if command -q eza
    alias ls eza
    alias lsi 'eza --group-directories-first --icons'
    alias ll 'eza --group-directories-first --icons -l'
    alias la 'eza --group-directories-first --icons -al'
    alias l 'eza --group-directories-first --icons -aal'
end

# --- zoxide — alias (not abbr) so history records `cd`. ---------------------
if command -q zoxide
    alias cd z
    alias cdi zi
end

# --- git ---------------------------------------------------------------------
abbr -a g git
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a gap 'git add --patch'
abbr -a gb 'git branch'
abbr -a gba 'git branch --all'
abbr -a gbr 'git branch --remote'
abbr -a gbl 'git blame -w'
abbr -a gc 'git commit --verbose'
abbr -a gcm 'git commit --verbose --message'
abbr -a gca 'git commit --verbose --amend'
abbr -a gcf 'git config --list'
abbr -a gcfg 'git config --list --global'
abbr -a gcl 'git clone --recurse-submodules'
abbr -a gclf 'git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'
abbr -a gco 'git checkout'
abbr -a gcob 'git checkout -b'
abbr -a gcoB 'git checkout -B'
abbr -a gcp 'git cherry-pick'
abbr -a gcpa 'git cherry-pick --abort'
abbr -a gcpc 'git cherry-pick --continue'
abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'
abbr -a gf 'git fetch'
abbr -a gfa 'git fetch --all --tags --prune --jobs=10'
abbr -a gfo 'git fetch origin'
abbr -a gl 'git pull'
abbr -a glg 'git log --stat'
abbr -a glgg 'git log --graph'
abbr -a glo 'git log --oneline --decorate'
abbr -a glog 'git log --oneline --decorate --graph'
abbr -a gloga 'git log --oneline --decorate --graph --all'
abbr -a glol 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
abbr -a glola 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
abbr -a glols 'git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
abbr -a gm 'git merge'
abbr -a gma 'git merge --abort'
abbr -a gmc 'git merge --continue'
abbr -a gmff 'git merge --ff-only'
abbr -a gms 'git merge --squash'
abbr -a gp 'git push'
abbr -a gpf 'git push --force'
abbr -a glrv 'git pull --rebase -v'
abbr -a gr 'git remote'
abbr -a gra 'git remote add'
abbr -a grh 'git reset'
abbr -a grhh 'git reset --hard'
abbr -a grm 'git rm'
abbr -a grmc 'git rm --cached'
abbr -a grv 'git remote --verbose'
abbr -a gsh 'git show'
abbr -a gst 'git status'
abbr -a gsb 'git status --short --branch'
abbr -a gsta 'git stash push'
abbr -a gstaa 'git stash apply'
abbr -a gstall 'git stash --all'
abbr -a gstc 'git stash clear'
abbr -a gstd 'git stash drop'
abbr -a gstl 'git stash list'
abbr -a gstp 'git stash pop'
abbr -a gsts 'git stash show --patch'
abbr -a gwipe 'git reset --hard && git clean --force -dfx'
