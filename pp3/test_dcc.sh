programas_decaf=($(ls samples | grep -oP '.*\.decaf' | grep -oP '.*\.'))

output_folder=output_dcc
difs_folder=difs

if [ ! -d $difs_folder ]; then
	mkdir $difs_folder
fi

if [ ! -d $output_folder ]; then
	mkdir $output_folder
fi

for i in "${programas_decaf[@]}"
do
   : 
   # do whatever on $i
   (./dcc < "samples/"$i"decaf") > $output_folder/$i"out1" 2>&1
   tr < $output_folder/$i"out1" -d '\000' > $output_folder/$i"out"
   (diff --text $output_folder/$i"out" "samples/"$i"out") > $difs_folder/$i"diff"
   # (diff --text temp_file_out.txt "samples/"$i"out") > $difs_folder/$i"diff"
   # rm temp_file_out.txt
   rm $output_folder/$i"out1"
done