#!/bin/bash

# remove old files
rm bin -rf
rm obj -rf
rm default.csproj -f
for file in *.cs; do 
    filename=`echo $file | sed 's/\(.*\.\)cs/\1/'`
    
    # check if there is a corresponding csx file
    if [ ! -f $filename'csx' ]; then
        echo "There is no corresponding .csx file for" $file
        echo "Please fix this error and rerun the script."
        echo "Terminating now."
        exit -1
    fi
    # check if corresponding csx file is bytewise equal to the cs file
    if ! cmp --silent $filename'csx' $filename'cs'; then
        echo $filename"csx and" $filename"cs are not equal"
        echo "Make sure you don't have any relevant edits in" $filename"cs."
        echo "Please fix this error and rerun the script."
        echo "Terminating now."
        exit -1
    fi
    
    rm $filename'cs' -f;
done # remove all cs files

# create .cs from .csx
for file in *.csx ; do 
    cp $file `echo $file | sed 's/\(.*\.\)csx/\1cs/'` ; 
done

# copy default project
cp ~/scripts/default.csproj .

# run script
dotnet run


# remove build and project files
rm bin -rf
rm obj -rf
rm default.csproj -f
for file in *.cs; do 
    filename=`echo $file | sed 's/\(.*\.\)cs/\1/'`
    
    # check if there is a corresponding csx file
    if [ ! -f $filename'csx' ]; then
        echo "There is no corresponding .csx file for" $file
        echo "Please fix this error and rerun the script."
        echo "Terminating now."
        exit -1
    fi
    # check if corresponding csx file is bytewise equal to the cs file
    if ! cmp --silent $filename'csx' $filename'cs'; then
        echo $filename"csx and" $filename"cs are not equal"
        echo "Make sure you don't have any relevant edits in" $filename"cs."
        echo "Please fix this error and rerun the script."
        echo "Terminating now."
        exit -1
    fi
    
    rm $filename'cs' -f;
done # remove all cs files
