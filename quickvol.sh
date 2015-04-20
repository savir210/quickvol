OSDetect=(imageinfo)
PsModules=(pslist psscan pstree psxview)
NetworkModules=(sockets sockscan connscan connections)
Netscan=(netscan)
Registry=(hivelist hivescan timeliner userassist shimcache shellbags)
UserInfo=(cmdscan clipboard consoles)
DllInfo=(ldrmodules dlllist)
Misc=(iehistory apihooks malfind driverscan filescan symlinkscan)
all=(pslist psscan pstree psxview sockets sockscan connscan connections netscan hivelist hivescan timeliner userassist shimcache shellbags cmdscan clipboard consoles apihooks malfind ldrmodules dlllist iehistory driverscan filescan symlinkscan)
help=$(printf "Normal Usage: \e[1;34mquickvol -f /path/to/folder\e[0m For help: \e[1;34mquickvol -h\e[0m")
NumArgs=$#
if [ $NumArgs -eq 0 ]; then
	echo $help
fi
while getopts ":f:h" opt; 
	do
		case $opt in
			f) path=$OPTARG >&2 ; echo ""
PreSelectArray=($path/*)
PreMem=($path/*.mem)
PreBin=($path/*.bin)
PreImg=($path/*.img)
PreVMem=($path/*.vmem)
MemArray=("${PreMem[@]}" "${PreImg[@]}" "${PreBin[@]}" "${PreVMem[@]}")
badnames=("$path/\*.mem" "$path/\*.img" "$path/\*.bin" "$path/\*.vmem")
for del in ${badnames[@]}
	do 
		MemArray=(${MemArray[@]/$del})
	done
FileNames="${MemArray[@]##*/}"
/bin/echo -e "using ... \e[1;32m$path/\e[0m"
/bin/echo -e "found \e[1;32m${#MemArray[@]}\e[0m memory dump(s) here, with the name(s)" "\e[1;32m${FileNames[@]}\e[0m"
while true; do
	/bin/echo -e "Is this right? \e[1;34m[y]\e[0m"
	read yn
	yn=${yn:-y}
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) exit;;
		* ) echo "Please answer y or n";;
		esac
	done

echo ""
echo "----------------------------------------------"
while true; do
	/bin/echo -e "Select \e[1;34my\e[0m if OS is already known, and you would like to select it from list, otherwise \e[1;34mn\e[0m to run imageinfo on memory file(s). \e[1;34m[y]\e[0m"
	read yn
	yn=${yn:-y}
	case $yn in
		[Yy]* ) break;;
		[Nn]* ) echo ""; 
				for e in ${MemArray[@]}
				do
					[ ! -d $i-Vol ] && mkdir -p $e-Vol
					/bin/echo -e "Attempting to run \e[1;32mimageinfo\e[0m on \e[1;32m${e[@]##*/}\e[0m";
					vol.py -f $e imageinfo > $e-Vol/imageinfo.txt
					/bin/echo -e "\e[1;32mDone!\e[0m Info saved in  $e-Vol/imageinfo.txt"
					#echo "vol.py -f $i $OSver $m > $i-Vol/$m.txt"
					ImgInfoRaw=$(cat $e-Vol/imageinfo.txt)
					ImgInfoName="${e[@]##*/}"
					ImgInfo+="\e[1;34m$ImgInfoName\e[0m-->${ImgInfoRaw[@]:45:90}|"
					echo ""
				done ; break;;
		[Ee]*) echo $ImgInfo;;
		[Qq]* ) exit;;
		* ) echo "Please answer y or n";;
		esac
	done
echo ""
echo "----------------------------------------------"
echo "             Available Profiles               "
echo "----------------------------------------------"
/bin/echo -e "1) \e[1;34mVistaSP0x64\e[0m      - A Profile for Windows Vista SP0 x64"
/bin/echo -e "2) \e[1;34mVistaSP0x86\e[0m      - A Profile for Windows Vista SP0 x86"
/bin/echo -e "3) \e[1;34mVistaSP1x64\e[0m      - A Profile for Windows Vista SP1 x64"
/bin/echo -e "4) \e[1;34mVistaSP1x86\e[0m      - A Profile for Windows Vista SP1 x86"
/bin/echo -e "5) \e[1;34mVistaSP2x64\e[0m      - A Profile for Windows Vista SP2 x64"
/bin/echo -e "6) \e[1;34mVistaSP2x86\e[0m      - A Profile for Windows Vista SP2 x86"
/bin/echo -e "7) \e[1;34mWin2003SP0x86\e[0m    - A Profile for Windows 2003 SP0 x86"
/bin/echo -e "8) \e[1;34mWin2003SP1x64\e[0m    - A Profile for Windows 2003 SP1 x64"
/bin/echo -e "9) \e[1;34mWin2003SP1x86\e[0m    - A Profile for Windows 2003 SP1 x86"
/bin/echo -e "10) \e[1;34mWin2003SP2x64\e[0m   - A Profile for Windows 2003 SP2 x64"
/bin/echo -e "11) \e[1;34mWin2003SP2x86\e[0m   - A Profile for Windows 2003 SP2 x86"
/bin/echo -e "12) \e[1;34mWin2008R2SP0x64\e[0m - A Profile for Windows 2008 R2 SP0 x64"
/bin/echo -e "13) \e[1;34mWin2008R2SP1x64\e[0m - A Profile for Windows 2008 R2 SP1 x64"
/bin/echo -e "14) \e[1;34mWin2008SP1x64\e[0m   - A Profile for Windows 2008 SP1 x64"
/bin/echo -e "15) \e[1;34mWin2008SP1x86\e[0m   - A Profile for Windows 2008 SP1 x86"
/bin/echo -e "16) \e[1;34mWin2008SP2x64\e[0m   - A Profile for Windows 2008 SP2 x64"
/bin/echo -e "17) \e[1;34mWin2008SP2x86\e[0m   - A Profile for Windows 2008 SP2 x86"
/bin/echo -e "18) \e[1;34mWin7SP0x64\e[0m      - A Profile for Windows 7 SP0 x64"
/bin/echo -e "19) \e[1;34mWin7SP0x86\e[0m      - A Profile for Windows 7 SP0 x86"
/bin/echo -e "20) \e[1;34mWin7SP1x64\e[0m      - A Profile for Windows 7 SP1 x64"
/bin/echo -e "21) \e[1;34mWin7SP1x86\e[0m      - A Profile for Windows 7 SP1 x86"
/bin/echo -e "22) \e[1;34mWinXPSP1x64\e[0m     - A Profile for Windows XP SP1 x64"
/bin/echo -e "23) \e[1;34mWinXPSP2x64\e[0m     - A Profile for Windows XP SP2 x64"
/bin/echo -e "24) \e[1;34mWinXPSP2x86\e[0m     - A Profile for Windows XP SP2 x86"
/bin/echo -e "25) \e[1;34mWinXPSP3x86\e[0m     - A Profile for Windows XP SP3 x86"
/bin/echo -e "o) \e[1;34mList 'imageinfo' findings\e[0m"
/bin/echo -e "q) \e[1;34mQuit\e[0m     	       - Exits \e[1;36mquickvol\e[0m"
/bin/echo -e "============================================================"
/bin/echo -e "Please select the number of the OS Profile that \e[1;36mquickvol\e[0m should use."
while true; do
	read o
	echo ""
	o=${o:-42}
	case $o in 
		1) OSver="--profile=VistaSP0x64" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP0 x64\e[0m" ; break ;;
		2) OSver="--profile=VistaSP0x86" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP0 x86\e[0m" ; break  ;;
		3) OSver="--profile=VistaSP1x64" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP1 x64\e[0m" ; break ;;
		4) OSver="--profile=VistaSP1x86" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP1 x86\e[0m" ; break ;;
		5) OSver="--profile=VistaSP2x64" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP2 x64\e[0m" ; break ;;
		6) OSver="--profile=VistaSP2x86" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP2 x86\e[0m" ; break ;;
		7) OSver="--profile=Win2003SP0x86" ; /bin/echo -e "using ... \e[1;32mWindows 2003 SP0 x86\e[0m" ; break ;;
		8) OSver="--profile=Win2003SP1x64" ; /bin/echo -e "using ... \e[1;32mWindows 2003 SP1 x64\e[0m" ; break ;;
		9) OSver="--profile=Win2003SP1x86" ; /bin/echo -e "using ... \e[1;32mWindows 2003 SP1 x86\e[0m" ; break ;;
		10) OSver="--profile=Win2003SP2x64" ; /bin/echo -e "using ... \e[1;32mWindows 2003 SP1 x64\e[0m" ; break ;;
		11) OSver="--profile=Win2003SP2x86" ; /bin/echo -e "using ... \e[1;32mWindows 2003 SP2 x64\e[0m" ; break ;;
		12) OSver="--profile=Win2008R2SP0x64" ; /bin/echo -e "using ... \e[1;32mWindows 2008 R2 SP0 x64\e[0m";break;;
		13) OSver="--profile=Win2008R2SP1x64" ; /bin/echo -e "using ... \e[1;32mWindows 2008 R2 SP1 x64\e[0m";break;;
		14) OSver="--profile=Win2008SP1x64" ; /bin/echo -e "using ... \e[1;32mWindows 2008 SP1 x64\e[0m" ; break ;;
		15) OSver="--profile=Win2008SP1x86" ; /bin/echo -e "using ... \e[1;32mWindows 2008 SP1 x86\e[0m" ; break ;;
		16) OSver="--profile=Win2008SP2x64" ; /bin/echo -e "using ... \e[1;32mWindows 2008 SP2 x64\e[0m" ; break ;;
		17) OSver="--profile=Win2008SP2x86" ; /bin/echo -e "using ... \e[1;32mWindows 2008 SP2 x86\e[0m" ; break ;;
		18) OSver="--profile=Win7SP0x64" ; /bin/echo -e "using ... \e[1;32mWindows 7 SP0 x64\e[0m" ; break ;;
		19) OSver="--profile=Win7SP0x86" ; /bin/echo -e "using ... \e[1;32mWindows 7 SP0 x86\e[0m" ; break ;;
		20) OSver="--profile=Win7SP1x64" ; /bin/echo -e "using ... \e[1;32mWindows 7 SP1 x64\e[0m" ; break ;;
		21) OSver="--profile=Win7SP1x86" ; /bin/echo -e "using ... \e[1;32mWindows 7 SP1 x86\e[0m" ; break ;;
		22) OSver="--profile=WinXPSP1x64" ; /bin/echo -e "using ... \e[1;32mWindows XP SP1 x64\e[0m" ; break ;;
		23) OSver="--profile=WinXPSP2x64" ; /bin/echo -e "using ... \e[1;32mWindows XP SP2 x64\e[0m" ; break ;;
		24) OSver="--profile=WinXPSP2x86" ; /bin/echo -e "using ... \e[1;32mWindows XP SP2 x86\e[0m" ; break ;;
		25) OSver="--profile=WinXPSP3x86" ; /bin/echo -e "using ... \e[1;32mWindows XP SP3 x86\e[0m" ; break ;;
		[Oo]*) 	OIFS=$IFS;
			IFS="|"
			for ((x=0; i<${#ImgInfo[@]}; ++i));
				do
					/bin/echo -e $ImgInfo;
				done
			IFS=$OIFS ;;
		[Qq]*) exit ;;		
		*) echo "Please enter a number" ;;
		esac
	done
while true; do
echo ""
echo "------------------------------------------------------------"
echo ""
echo "What should be done with the file(s)?"
/bin/echo -e "1. \e[1;34mEcho selected files\e[0m"
/bin/echo -e "2. \e[1;34mProcesses info\e[0m (pslist psscan pstree psxview)"
/bin/echo -e "3. \e[1;34mNetwork Info - 2003 & XP only\e[0m (sockets connections connscan sockscan)"
/bin/echo -e "4. \e[1;34mPost Vista Networking info\e[0m (netscan)"
/bin/echo -e "5. \e[1;34mRegistry\e[0m (hivelist hivescan timeliner userassist shimcache shellbags)"
/bin/echo -e "6. \e[1;34mRecent user input\e[0m (cmdscan clipboard consoles)"
/bin/echo -e "7. \e[1;34mDll Info\e[0m (ldrmodules dlllist)"
/bin/echo -e "8. \e[1;34mMiscellaneous\e[0m (iehistory apihooks malfind driverscan filescan symlinkscan)"
/bin/echo -e "9. \e[1;34mAll Modules listed\e[0m"
/bin/echo -e "Q. \e[1;34mQuit\e[0m"
/bin/echo -e "Please select the number of the task that \e[1;36mquickvol\e[0m should accomplish; Remember, you can Ctrl+c through unwanted modules without closing the program!"
	read n
	n=${n:-42}
	case $n in 
		1) echo "" ; /bin/echo -e "found \e[1;32m${#MemArray[@]}\e[0m file(s) here" ;
			for i in ${MemArray[@]}
			do
				/bin/echo -e "\e[1;32m$i\e[0m"
			done ;;
		2) for i in ${MemArray[@]}
			do
				for m in ${PsModules[@]}
					do
						[ ! -d $i-Vol ] && mkdir -p $i-Vol
						echo ""
						/bin/echo -e "attempting to run \e[1;32m$m\e[0m on \e[1;32m${i[@]##*/}\e[0m"
						vol.py -f $i $OSver $m > $i-Vol/$m.txt
						/bin/echo -e "\e[1;32mdone!\e[0m Info saved in $i-Vol/$m.txt"
						#echo "vol.py -f $i $OSver $m > $i-Vol/$m.txt"
					done ;
			done;;	
		3) for i in ${MemArray[@]}
			do
				for m in ${NetworkModules[@]}
					do
						[ ! -d $i-Vol ] && mkdir -p $i-Vol
						echo ""
						/bin/echo -e "attempting to run \e[1;32m$m\e[0m on \e[1;32m${i[@]##*/}\e[0m"
						vol.py -f $i $OSver $m > $i-Vol/$m.txt
						/bin/echo -e "\e[1;32mdone!\e[0m Info saved in $i-Vol/$m.txt"
						#echo "vol.py -f $i $OSver $m > $i-Vol/$m.txt"
					done ;			
			done ;;
		4) for i in ${MemArray[@]}
			do
				for m in ${Netscan[@]}
					do
						[ ! -d $i-Vol ] && mkdir -p $i-Vol
						echo ""
						/bin/echo -e "attempting to run \e[1;32m$m\e[0m on \e[1;32m${i[@]##*/}\e[0m"
						vol.py -f $i $OSver $m > $i-Vol/$m.txt
						/bin/echo -e "\e[1;32mdone!\e[0m Info saved in $i-Vol/$m.txt"
						#echo "vol.py -f $i $OSver $m > $i-Vol/$m.txt"
					done ;			
			done ;;
		5) for i in ${MemArray[@]}
			do
				for m in ${Registry[@]}
					do
						[ ! -d $i-Vol ] && mkdir -p $i-Vol
						echo ""
						/bin/echo -e "attempting to run \e[1;32m$m\e[0m on \e[1;32m${i[@]##*/}\e[0m"
						vol.py -f $i $OSver $m > $i-Vol/$m.txt
						/bin/echo -e "\e[1;32mdone!\e[0m Info saved in $i-Vol/$m.txt"
						#echo "vol.py -f $i $OSver $m > $i-Vol/$m.txt"
					done ;			
			done ;;
		6) for i in ${MemArray[@]}
			do
				for m in ${UserInfo[@]}
					do
						[ ! -d $i-Vol ] && mkdir -p $i-Vol
						echo ""
						/bin/echo -e "attempting to run \e[1;32m$m\e[0m on \e[1;32m${i[@]##*/}\e[0m"
						vol.py -f $i $OSver $m > $i-Vol/$m.txt
						/bin/echo -e "\e[1;32mdone!\e[0m Info saved in $i-Vol/$m.txt"
						#echo "vol.py -f $i $OSver $m > $i-Vol/$m.txt"
					done ;			
			done ;;
		7) for i in ${MemArray[@]}
			do
				for m in ${DllInfo[@]}
					do
						[ ! -d $i-Vol ] && mkdir -p $i-Vol
						echo ""
						/bin/echo -e "attempting to run \e[1;32m$m\e[0m on \e[1;32m${i[@]##*/}\e[0m"
						vol.py -f $i $OSver $m > $i-Vol/$m.txt
						/bin/echo -e "\e[1;32mdone!\e[0m Info saved in $i-Vol/$m.txt"
						#echo "vol.py -f $i $OSver $m > $i-Vol/$m.txt"
					done ;			
			done ;;
		8) for i in ${MemArray[@]}
			do
				for m in ${Misc[@]}
					do
						[ ! -d $i-Vol ] && mkdir -p $i-Vol
						echo ""
						/bin/echo -e "attempting to run \e[1;32m$m\e[0m on \e[1;32m${i[@]##*/}\e[0m"
						vol.py -f $i $OSver $m > $i-Vol/$m.txt
						/bin/echo -e "\e[1;32mdone!\e[0m Info saved in $i-Vol/$m.txt"
						#echo "vol.py -f $i $OSver $m > $i-Vol/$m.txt"
					done ;			
			done ;;
		9) for i in ${MemArray[@]}
			do
				for m in ${all[@]}
					do
						[ ! -d $i-Vol ] && mkdir -p $i-Vol
						echo ""
						/bin/echo -e "attempting to run \e[1;32m$m\e[0m on \e[1;32m${i[@]##*/}\e[0m"
						vol.py -f $i $OSver $m > $i-Vol/$m.txt
						/bin/echo -e "\e[1;32mdone!\e[0m Info saved in $i-Vol/$m.txt"
						#echo "vol.py -f $i $OSver $m > $i-Vol/$m.txt"
					done ;			
			done ;;
		[Qq]* ) exit ;;		
		*) echo "Please enter a number" ;;
		esac
	done ;;
			\?) /bin/echo -e "Invalid Option: \e[0;31m-$OPTARG\e[0m, use \e[1;34m-f\e[0m or \e[1;34m-h\e[0m" ; exit 1 ; >&2;;
			:) /bin/echo -e "Option \e[1;34m-$OPTARG\e[0m requires an argument, use \e[1;34m-f /path/to/memory/folder\e[0m" ; exit 1; >&2;;
			h) echo "" ;/bin/echo -e  "	\e[1;36mQuickvol v1.1\e[0m is a script that will select \e[1;34m.mem\e[0m, \e[1;34m.bin\e[0m, or \e[1;34m.img\e[0m files and attempt to run them through some common volatility scans. It will create seperate working directories for each memory image, so it works best if all of the memory files were appropriately named, and stored in one folder. 
	First, you will need to define what folder the memory files are located in.  You can do this with the following \e[1;34mquickvol -f /path/to/memory/folder\e[0m. This should start the script, and its fist action would be to confirm that it has the correct \e[1;34m/path/to/folder\e[0m. You can select \e[1;34my\e[0m to continute, or \e[1;34mn\e[0m to end the script, and retype the correct path. 
	The next prompt will ask you if you already know the correct OS profile volatility will use. \e[1;34my\e[0m will move you to the next prompt, and \e[1;34mn\e[0m will initiate an imageinfo for all images selected in your folder. You will be able to query the imageinfo results in the next prompt, where you select the profile volatility will use.
	Once at the next prompt press \e[1;34mo\e[0m to return the imageinfo results if needed, then select the number of the profile you want to run. Once at the final prompt, you can decide which modules you want to actually run on the memory images, they have been divided into pseudo-categories for convienience, but if you dont have any modules yet done, you can opt for \e[1;34moption 9\e[0m, and run all modules, which should give you a good baseline of results to work through.  If for some reason, you want to ensure that \e[1;36mquickvol\e[0m has selected your memory images, you can run \e[1;34moption 1\e[0m to echo what \e[1;36mquickvol\e[0m currently has in its queue."; echo ""; echo $help; exit 1;;
		esac
	done
