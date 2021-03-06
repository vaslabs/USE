#!/bin/bash
play() {
    while read line; do
        link=$(./youtube-dl -s --get-url ytsearch:"$line")
        vlc "$link" 2>/dev/null
        #exit 0 
        
    done < $1
    
}

list_music() {
    friendName=$1
    friendID=$(fbcmd FRIENDS | grep "$friendName" | cut -d ' ' -f 1)
    list_musicID $friendID
}

list_musicID() {
    if [ -z "$1" ]; then
        friendID="me()"
    else
        friendID=$1
    fi
    tmpFile=$(mktemp)
    fbcmd FQL "SELECT music FROM user WHERE uid=$friendID" >$tmpFile
    lines=$(cat $tmpFile | wc -l)
    lines=$(($lines+1))
    cat $tmpFile | grep -A$lines music
    rm $tmpFile

}

stalk() {

    list_musicA=$(mktemp)
    list_musicB=$(mktemp)
    comparison=$(mktemp)
    flist=$(list_music "$1") 
    echo $flist | cut -d ' ' -f 3- | tr ',' '\n' | cut -d ' ' -f 2- >$list_musicA      
     mylist=$(list_musicID)
     echo $mylist | cut -d ' ' -f 3- | tr ',' '\n' | cut -d ' ' -f 2- >list_musicB >$list_musicB    
     ./compare_lists.sh --listA=$list_musicB --listB=$list_musicA --out=$comparison
    cat $list_musicA
    echo "==========="
    cat $list_musicB
     rm $list_musicA
     rm $list_musicB
     play $comparison
}

stalk $1

