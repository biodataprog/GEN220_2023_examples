
hello.sh - a script to print a message to the screen.
you can run it with 
`bash hello.sh`
or
set the permission of the script to be executable and then run it

```
chmod +x hello.sh # set permission to executable
./hello.sh # now run it by giving the path to the script to run (./)
```

Try some other commands
=====
* `date` prints the current date
* `who` see who is logged in
* `wc -l hello.sh` will print number lines in a file, in this case, the hello.sh file
* `who | wc -l` will take output from one command and PIPE (|) it to another program- this counts how many people are logged in
