#!bin/bash

# TO-DO : main function
main(){
    if [ -e ~/.automater_workspaces ]; then
        echo "+Cooking your setup 🍫"
        else
        `touch ~/.automater_workspaces`
        `chmod -R 775 ~/.automater_workspaces`
    fi
}
# TO-DO : init function
init(){
    if [ "$#" -gt "1" ]; then
        check
        exit;
    fi

    var='\n#automater things :P\nif [ -f ~/.bash_aliases ]; then\n. ~/.bash_aliases\nfi'

    if grep -q 'automater things' /etc/bashrc; then
        echo "you are already good to go 🦋 "
        exit;
    fi

    if [ -f /etc/bashrc ]; then
        `touch ~/.bash_aliases`
        `cp ./workspaceAutomater/automater.sh /usr/local/bin`
        `echo alias automater="'bash /usr/local/bin/automater.sh'" >> ~/.bash_aliases`
        `echo -e $var >> /etc/bashrc`
        else
            echo "make sure your bashrc file is correct & you have right permissions 😩 "
            exit;
    fi
    main
    echo "All set & ready to go , restart your terminal & enjoy your work 🦄 "
}

# TO-DO : create function
create(){
    if [ "$#" -le "2" ]; then
        check
        exit;
    fi

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
# TO-DO : resolving app name and verification
resolve(){
    app=`cd /Applications/ && find . -iname *$1* -type d -maxdepth 1 && cd`
    if [[ $app ]]; then
            echo $app
        else
            return 0
    fi
}
# TO-DO : openning apps
launch(){
    ## getting the line of workspace ##
    workSpaceLineNumber=`awk "/$2/{ print NR; exit }" ~/.automater_workspaces`
    ## getting worKspace apps (q quits when line number is NUM , d deletes it instead of printing it)##
    result=`sed "${workSpaceLineNumber}q;d" ~/.automater_workspaces`
    ## eliminating spaces ##
    IFS='  ' read -r -a apps <<< "$result"
    ## openning apps ##
    for i in `seq 1 ${#apps[@]}`; do
        if [ ! -z ${apps[i]} ]; then
            result=$(resolve ${apps[i]})
            if [ ! "$result" ]; then
                    echo "++the app ${apps[i]} do not exist 😩 "
                    continue
                else
                    echo "++found ${apps[i]} opening ..🌪 "
                    ## TO FIX AT THE NEXT UPDATE v(app name) ##
                    v1="${result/\.\//}"
                    v2="${v1/\.app/}"
                    v3="${v2/ /\ }"
                    `open -a "${v3}"`
            fi
        fi
    done
    echo "Done 🥋 "
}
# TO-DO : start function
start(){
        if [ "$#" -gt "2" ]; then
            check
            exit;
         fi
        if grep -q $2 ~/.automater_workspaces; then
            ## openning apps ##
            launch $@
        else
            echo "++$2 workspace do not exist 🤥 , please create your workspace"
        fi
}
#command error
check(){
    if ! grep -q 'automater things' /etc/bashrc; then
        echo "Please run 'automater setup' first 🛠 "
        exit;
    fi
    echo "++Please use valid commands , refer to the documentation to learn more ⛑ "
}
#script index
case $1 in
        "create")
            create $@
        ;;
        "start")
            start $@
        ;;
        "setup")
            init $@
        ;;
        *)
            check
        ;;
esac
# TO-DO : delete function
# TO-DO : close function