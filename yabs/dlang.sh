echo dub build: $PWD
hr ─
dub build -- && { hr ─ ; echo "Finished."; } || { hr ─ ; echo "Failed."; } 