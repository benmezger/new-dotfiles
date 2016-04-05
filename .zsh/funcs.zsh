#!/bin/zsh

# generate git ignore
function gitignore(){
    curl -L -s https://www.gitignore.io/api/$@;
}

# start ipython notebook in the background
ipynb(){
	ipython notebook --pylab inline >/dev/null 2>&1 </dev/null &;
    disown;
}

# kill ipython notebook process
ipynbk(){
    kill $(ps aux | grep '[i]python notebook' | awk '{print $2}')
}

take(){
	mkdir -p $1
	cd $1
}

function copyfile {
	[[ "$#" != 1 ]] && return 1
	local file_to_copy=$1
	cat $file_to_copy | xsel --clipboard
}

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# change current mac-address
function new-macaddr(){
    sudo ifconfig $1 ether $(openssl rand -hex 6 | sed 's%\(..\)%\1:%g; s%.$%%')
}

function secure-dns(){
    # DNS info: opennicproject.org
    file='/etc/resolv.conf'
    dns=('82.211.31.248' '193.183.98.154' '5.9.49.12' '185.83.217.248')
    sudo /bin/su -c "cat /dev/null > $file"
    
    for d in $dns; do
        sudo /bin/su -c "echo 'nameserver $d' >> $file"
    done
}

function proxify(){
    export {http,https,ftp}_proxy="localhost:8118"
}
