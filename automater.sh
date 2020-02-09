#!bin/bash
# TO-DO : init function
init(){
    var='\n#automater things :P\nif [ -f ~/.automater_workspaces ]; then\n. ~/.automater_workspaces\nfi'
    if [ -f /etc/bashrc ]; then
        `echo -e $var >> /etc/bashrc`
        else
            echo "make sure your bashrc file is correct 😩"
    fi
    echo "All set & ready to go , Enjoy your space 🦄 "
}

# TO-DO : main function
main(){
    if [ -e ~/.automater_workspaces ]; then
        echo "+Cooking your workspace 🍫"
        else
        `touch ~/.automater_workspaces`
    fi
}

# TO-DO : create function
create(){
    main
    apps=("$@")
    let lastItem=$#-1

    for i in `seq 2 $#`; do
            app+=${apps[i]}" "
    done
    
    ######## TO FIX ########
    if [  "grep -Fxq "$2" ~/.automater_workspaces" ]; then
        echo "++$2 workspace already exists 🤥"
    else
        `echo -e $2=${app} >> ~/.automater_workspaces`
        echo "++Your workspace is ready 🦊"
    fi
}
create $@
# TO-DO : delete function
# TO-DO : close function
# TO-DO : start function