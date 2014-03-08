#!/bin/bash

unset pathListA
unset pathListB
unset outputFile

knownEntries="";
uknownEntries="";

function compare_lists {
	while read -r lineA; do
		found=false
		while read -r lineB && [ "$found" == "false" ]; do
			if [ "$lineA" == "$lineB" ]; then
				if [ "X${knownEntries}" == "X" ]; then
					knownEntries="${lineA}\n"
				else
					knownEntries+="${lineA}\n"
				fi
				#echo "known found:$lineA"
				found=true
			fi
		done < "$pathListB";
		if [ "$found" == "false" ]; then
			#echo "unknown found:$lineA"
			if [ "X${uknownEntries}" == "X" ]; then
					uknownEntries="${lineA}\n"
				else
					uknownEntries+="${lineA}\n"
			fi
		fi
	done < "$pathListA";
}

function export_to_file {
	#echo -e "-SIMILARITIES-" >> $outputFile
	echo -e "${knownEntries}" | sed '/^\s*$/d' >> $outputFile
	#echo -e "-DIFFERENCES-" >> $outputFile
	echo -e "${uknownEntries}" | sed '/^\s*$/d' >> $outputFile
}


#Check and validate the parameters
if [ $# -ne 3 ]; then 
    echo -e "[ERROR] parameters: \n\t\t\t--listA=[/path/to/listA]\n\t\t\t--listB=[/path/to/listB]\n\t\t\t--out=[/path/to/file]"

    echo -e "$# params"
    exit 1;
fi
case "$1" in
    --listA*)
        export pathListA=$(echo "$1" | awk -F"=" '{print $2}' | tr -d "'")
        ;;
    *)
        echo "[ERROR] parameters: \n\t\t\t--listA=[/path/to/listA]\n\t\t\t--listB=[/path/to/listB]\n\t\t\t--out=[/path/to/file]"
        exit 1
        ;;
esac
case "$2" in
    --listB*)
        export pathListB=$(echo "$2" | awk -F"=" '{print $2}' | tr -d "'")
        ;;
    *)
        echo "[ERROR] parameters: \n\t\t\t--listA=[/path/to/listA]\n\t\t\t--listB=[/path/to/listB]\n\t\t\t--out=[/path/to/file]"
        exit 1
        ;;
esac
case "$3" in
    --out*)
        export outputFile=$(echo "$3" | awk -F"=" '{print $2}' | tr -d "'")
        ;;
    *)
        echo "[ERROR] parameters: \n\t\t\t--listA=[/path/to/listA]\n\t\t\t--listB=[/path/to/listB]\n\t\t\t--out=[/path/to/file]"
        exit 1
        ;;
esac
#Check files
if [ ! -r $pathListA ]; then echo -e "[ERROR] ${pathListA} does not exist."; exit 2; fi
if [ ! -r $pathListB ]; then echo -e "[ERROR] ${pathListB} does not exist."; exit 3; fi
if [ -e $outputFile ]; then rm $outputFile; fi


compare_lists
export_to_file
if [ $? -eq 0 ]; then 
	echo "[SUCCESS] Output file created: ${outputFile}";
else
	echo "[FAIL] Something went wrong :-)";
fi
