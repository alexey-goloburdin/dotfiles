alias n=nvim
alias b=bat
alias open=explorer.exe
#alias romashka=$HOME/code/romashka/.venv/bin/romashka

# Password generator
pwgen() {
  local len=${1:-20}
  LC_ALL=C tr -dc 'A-Za-z0-9@#%^&*()_+=-{}[]:;<>,.?/' < /dev/urandom | head -c "$len" | xargs echo
}

alias python3=/home/sterx/.python3.13/bin/python3.13
