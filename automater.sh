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
    for i in `seq 2 $#`; do
            app+=" "${apps[i]}
    done

    if grep -q $2 ~/.automater_workspaces; then
        echo "++$2 workspace already exists 🤥"
    else
        `echo -e $2=${app} >> ~/.automater_workspaces`
        echo "++Your workspace is ready 🦊"
    fi
}
# create $@
# TO-DO : openning apps
launch(){
    ## getting the line off workspace ##
    workSpaceLineNumber=`awk "/$2/{ print NR; exit }" ~/.automater_workspaces`
    ## getting worspace apps (q quits when line number is NUM , d deletes it instead of printing it)##
    result=`sed "${workSpaceLineNumber}q;d" ~/.automater_workspaces`
    ## eliminating spaces ##
    IFS=' ' read -ra apps <<< "$result"
    ## openning apps ##
    for i in `seq 1 ${#apps[@]}`; do
        if [ ! -z ${apps[i]} ]; then
            result=$(resolve ${apps[i]})
            if [ ! "$result" ]; then
                    echo "++the app ${apps[i]} do not exist 😩 "
                    continue
                else
                    echo "++found ${apps[i]} opening ..🌪 "
                    `open -a ${apps[i]}`
            fi
        fi
    done
    echo "Done 😎 "
}
# TO-DO : start function
start(){
        main
        if grep -q $2 ~/.automater_workspaces; then
            ## openning apps ##
            launch $@
        else
            echo "++$2 workspace do not exist 🤥 , please create your workspace"
        fi
}
# start $@
# TO-DO : resolving app name and verification
resolve(){
    app=`cd /Applications/ && find . -iname *$1* -type d -maxdepth 1 && cd`
    if [[ $app ]]; then
            echo $app
        else
            return 0
    fi
}
# start $@
# TO-DO : delete function
# TO-DO : close function