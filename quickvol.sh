#!/bin/bash
# This file is part of the CMob Automation Suite! - 92nd Information Operations Squadron: Special Projects
#Authored by Gregory Rivas and Richard Beauchamp
#For more information, Please contact Greg or Richard
#
#
vis1="Windows Vista SP0 x64"
vis2="Windows Vista SP0 x86"
vis3="Windows Vista SP1 x64"
vis4="Windows Vista SP1 x86"
vis5="Windows Vista SP2 x64"
vis6="Windows Vista SP2 x86"
s31="Windows 2003 SP0 x86"
s32="Windows 2003 SP1 x64"
s33="Windows 2003 SP1 x86"
s34="Windows 2003 SP2 x64"
s35="Windows 2003 SP2 x86"
s81="Windows 2008 R2 SP0 x64"
s82="Windows 2008 R2 SP1 x64"
s83="Windows 2008 SP1 x64"
s84="Windows 2008 SP1 x86"
s85="Windows 2008 SP2 x64"
s86="Windows 2008 SP2 x86"
sev1="Windows 7 SP0 x64"
sev2="Windows 7 SP0 x86"
sev3="Windows 7 SP1 x64"
sev4="Windows 7 SP1 x86"
xp1="Windows XP SP1 x64"
xp2="Windows XP SP2 x64"
xp3="Windows XP SP2 x86"
xp4="Windows XP SP3 x86"
OSDetect=(imageinfo)
PsModules=(pslist psscan pstree psxview)
NetworkModules=(sockets sockscan connscan connections)
Netscan=(netscan)
Registry=(hivelist hivescan timeliner userassist shimcache shellbags)
UserInfo=(cmdscan clipboard consoles)
DllInfo=(ldrmodules dlllist)
Misc=(iehistory apihooks malfind driverscan filescan symlinkscan)
all=(pslist psscan pstree psxview sockets sockscan connscan connections netscan hivelist hivescan timeliner userassist shimcache shellbags cmdscan clipboard consoles apihooks malfind ldrmodules dlllist iehistory driverscan filescan symlinkscan)

ModuleRunner () {
	[ ! -d $1-Vol ] && mkdir -p $1-Vol
	echo ""
	File=$1
	/bin/echo -e "attempting to run \e[1;32m$2\e[0m on \e[1;32m${File[@]##*/}\e[0m"
	OSver=$(echo ${OSTable[${1}]})
	vol.py -f $1 --profile=$OSver $2 > $1-Vol/$2.txt
	/bin/echo -e "\e[1;32mdone!\e[0m Info saved in $1-Vol/$2.txt"
	#echo "vol.py -f $1 --profile=$OSver $2 > $1-Vol/$2.txt"
}
help=$(printf "Normal Usage: \e[1;34mquickvol -f /path/to/folder\e[0m For help: \e[1;34mquickvol -h\e[0m")
declare -A OSTable
NumArgs=$#
if [ $NumArgs -eq 0 ]; then
	echo $help
fi
while getopts ":f:h" opt; do
	case $opt in
		f) path=$OPTARG >&2 ; echo ""
			present=$(pwd)
			cd "$path"
			PreMem=(./*.mem)
			PreBin=(./*.bin)
			PreImg=(./*.img)
			PreVMem=(./*.vmem)
			PreDmp=(./*.dmp)
			MemArray=("${PreMem[@]}" "${PreImg[@]}" "${PreBin[@]}" "${PreVMem[@]}" "${PreDmp[@]}")
			badnames=("./\*.mem" "./\*.img" "./\*.bin" "./\*.vmem" "./\*.dmp")
			
			for del in ${badnames[@]}
				do 
					MemArray=(${MemArray[@]/$del})
				done
			FileNames="${MemArray[@]##*/}"
			/bin/echo -e "Using ... \e[1;32m$path/\e[0m"
			/bin/echo -e "found \e[1;32m${#MemArray[@]}\e[0m memory dump(s) here, with the name(s)" "\e[1;32m${FileNames[@]}\e[0m"
			while true ; do
				/bin/echo -e "Is this the right Location? \e[1;34m[y]\e[0m"
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
			echo "              Determine Profile               "
			echo "----------------------------------------------"
			/bin/echo -e "Select \e[1;34my\e[0m if the Profile OS is already known, and you would like to select it from a list, otherwise \e[1;34mn\e[0m to run imageinfo on memory file(s). \e[1;34m[n]\e[0m"
			while true ; do
				read yn
				yn=${yn:-n}
				case $yn in
					[Yy]* ) echo ""
						echo "----------------------------------------------"
						echo "             Available Profiles               "
						echo "----------------------------------------------"
						/bin/echo -e "1) \e[1;34mVistaSP0x64\e[0m      - A Profile for $vis1" 
						/bin/echo -e "2) \e[1;34mVistaSP0x86\e[0m      - A Profile for $vis2"
						/bin/echo -e "3) \e[1;34mVistaSP1x64\e[0m      - A Profile for $vis3"
						/bin/echo -e "4) \e[1;34mVistaSP1x86\e[0m      - A Profile for $vis4"
						/bin/echo -e "5) \e[1;34mVistaSP2x64\e[0m      - A Profile for $vis5"
						/bin/echo -e "6) \e[1;34mVistaSP2x86\e[0m      - A Profile for $vis6"
						/bin/echo -e "7) \e[1;34mWin2003SP0x86\e[0m    - A Profile for $s31"
						/bin/echo -e "8) \e[1;34mWin2003SP1x64\e[0m    - A Profile for $s32"
						/bin/echo -e "9) \e[1;34mWin2003SP1x86\e[0m    - A Profile for $s33"
						/bin/echo -e "10) \e[1;34mWin2003SP2x64\e[0m   - A Profile for $s34"
						/bin/echo -e "11) \e[1;34mWin2003SP2x86\e[0m   - A Profile for $s35"
						/bin/echo -e "12) \e[1;34mWin2008R2SP0x64\e[0m - A Profile for $s81"
						/bin/echo -e "13) \e[1;34mWin2008R2SP1x64\e[0m - A Profile for $s82"
						/bin/echo -e "14) \e[1;34mWin2008SP1x64\e[0m   - A Profile for $s83"
						/bin/echo -e "15) \e[1;34mWin2008SP1x86\e[0m   - A Profile for $s84"
						/bin/echo -e "16) \e[1;34mWin2008SP2x64\e[0m   - A Profile for $s85"
						/bin/echo -e "17) \e[1;34mWin2008SP2x86\e[0m   - A Profile for $s86"
						/bin/echo -e "18) \e[1;34mWin7SP0x64\e[0m      - A Profile for $sev1"
						/bin/echo -e "19) \e[1;34mWin7SP0x86\e[0m      - A Profile for $sev2"
						/bin/echo -e "20) \e[1;34mWin7SP1x64\e[0m      - A Profile for $sev3"
						/bin/echo -e "21) \e[1;34mWin7SP1x86\e[0m      - A Profile for $sev4"
						/bin/echo -e "22) \e[1;34mWinXPSP1x64\e[0m     - A Profile for $xp1"
						/bin/echo -e "23) \e[1;34mWinXPSP2x64\e[0m     - A Profile for $xp2"
						/bin/echo -e "24) \e[1;34mWinXPSP2x86\e[0m     - A Profile for $xp3"
						/bin/echo -e "25) \e[1;34mWinXPSP3x86\e[0m     - A Profile for $xp4"
						/bin/echo -e "q) \e[1;34mQuit\e[0m     	    - Exits \e[1;36mquickvol\e[0m"
						/bin/echo -e "============================================================"
						for e in ${MemArray[@]}; do
							/bin/echo -e "Please select the number for the OS Profile that \e[1;36mquickvol\e[0m should use for \e[1;32m${e[@]##*/}\e[0m"
							while true; do
								read o
								o=${o:-42}
								case $o in 
									1) version="VistaSP0x64" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP0 x64\e[0m" ; break;;
									2) version="VistaSP0x86" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP0 x86\e[0m" ; break  ;;
									3) version="VistaSP1x64" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP1 x64\e[0m" ; break ;;
									4) version="VistaSP1x86" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP1 x86\e[0m" ; break ;;
									5) version="VistaSP2x64" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP2 x64\e[0m" ; break ;;
									6) version="VistaSP2x86" ; /bin/echo -e "using ... \e[1;32mWindows Vista SP2 x86\e[0m" ; break ;;
									7) version="Win2003SP0x86" ; /bin/echo -e "using ... \e[1;32mWindows 2003 SP0 x86\e[0m" ; break ;;
									8) version="Win2003SP1x64" ; /bin/echo -e "using ... \e[1;32mWindows 2003 SP1 x64\e[0m" ; break ;;
									9) version="Win2003SP1x86" ; /bin/echo -e "using ... \e[1;32mWindows 2003 SP1 x86\e[0m" ; break ;;
									10) version="Win2003SP2x64" ; /bin/echo -e "using ... \e[1;32mWindows 2003 SP1 x64\e[0m" ; break ;;
									11) version="Win2003SP2x86" ; /bin/echo -e "using ... \e[1;32mWindows 2003 SP2 x64\e[0m" ; break ;;
									12) version="Win2008R2SP0x64" ; /bin/echo -e "using ... \e[1;32mWindows 2008 R2 SP0 x64\e[0m" ; break ;;
									13) version="Win2008R2SP1x64" ; /bin/echo -e "using ... \e[1;32mWindows 2008 R2 SP1 x64\e[0m" ; break ;;
									14) version="Win2008SP1x64" ; /bin/echo -e "using ... \e[1;32mWindows 2008 SP1 x64\e[0m" ; break ;;
									15) version="Win2008SP1x86" ; /bin/echo -e "using ... \e[1;32mWindows 2008 SP1 x86\e[0m" ; break ;;
									16) version="Win2008SP2x64" ; /bin/echo -e "using ... \e[1;32mWindows 2008 SP2 x64\e[0m" ; break ;;
									17) version="Win2008SP2x86" ; /bin/echo -e "using ... \e[1;32mWindows 2008 SP2 x86\e[0m" ; break ;;
									18) version="Win7SP0x64" ; /bin/echo -e "using ... \e[1;32mWindows 7 SP0 x64\e[0m" ; break ;;
									19) version="Win7SP0x86" ; /bin/echo -e "using ... \e[1;32mWindows 7 SP0 x86\e[0m" ; break ;;
									20) version="Win7SP1x64" ; /bin/echo -e "using ... \e[1;32mWindows 7 SP1 x64\e[0m" ; break ;;
									21) version="Win7SP1x86" ; /bin/echo -e "using ... \e[1;32mWindows 7 SP1 x86\e[0m" ; break ;;
									22) version="WinXPSP1x64" ; /bin/echo -e "using ... \e[1;32mWindows XP SP1 x64\e[0m" ; break ;;
									23) version="WinXPSP2x64" ; /bin/echo -e "using ... \e[1;32mWindows XP SP2 x64\e[0m" ; break ;;
									24) version="WinXPSP2x86" ; /bin/echo -e "using ... \e[1;32mWindows XP SP2 x86\e[0m" ; break ;;
									25) version="WinXPSP3x86" ; /bin/echo -e "using ... \e[1;32mWindows XP SP3 x86\e[0m" ; break ;;
									[Qq]*) exit ;;		
									*) echo "Please enter a valid number" ;;
								esac
							done
							echo ""
							OSTable+=( [$e]=$version )
						done ; break ;;
					[Nn]* ) echo ""; 
						for e in ${MemArray[@]} ; do
							[ ! -d $i-Vol ] && mkdir -p $e-Vol
							/bin/echo -e "Attempting to run \e[1;32mimageinfo\e[0m on \e[1;32m${e[@]##*/}\e[0m"
							vol.py -f $e imageinfo > $e-Vol/imageinfo.txt
							/bin/echo -e "\e[1;32mDone!\e[0m Info saved in  $e-Vol/imageinfo.txt"
							#echo "vol.py -f $i $OSver $m > $i-Vol/$m.txt"
							ImgInfoRaw=$(cat $e-Vol/imageinfo.txt | cut -d ":" -f 2 | head -3 | tail -n -2 | cut -d "(" -f 1 | tr -d ",")
							ImgInfoArr=($ImgInfoRaw)
							/bin/echo -e "Found: \e[1;32m${ImgInfoArr[@]}\e[0m"
							OSTable+=( [$e]=${ImgInfoArr[@]} )
							echo ""
						done
						echo "----------------------------------------------"
						echo "              Automatic or Manual             "
						echo "----------------------------------------------"
						/bin/echo -e "Select \e[1;34mY\e[0m to use Volatility's top suggestions for these images or \e[1;34mN\e[0m to select them manually. \e[1;34m[Y]\e[0m"
						while true; do
							read yn
							yn=${yn:-y}
							case $yn in
								[Yy]* ) for key in ${!OSTable[@]} ; do
										var1=$(echo ${OSTable[${key}]})
										var1=($var1)
										var1=${var1[0]}
										OSTable[${key}]=$var1
									done ; break ;;
								[Nn]* ) for key in ${!OSTable[@]} ; do
										verArr=(${OSTable[${key}]})
										count=0
										versionArr=()
										keyArr=()
										echo ""
										for value in ${verArr[@]} ; do
											let count++
											case $value in
												VistaSP0x64) version=$vis1 ;;
												VistaSP0x86) version=$vis2 ;;
												VistaSP1x64) version=$vis3 ;;
												VistaSP1x86) version=$vis4 ;;
												VistaSP2x64) version=$vis5 ;;
												VistaSP2x86) version=$vis6 ;;
												Win2003SP0x86) version=$s31 ;;
												Win2003SP1x64) version=$s32 ;;
												Win2003SP1x86) version=$s33 ;;
												Win2003SP2x64) version=$s34 ;;
												Win2003SP2x86) version=$s35 ;;
												Win2008R2SP0x64) version=$s81 ;;
												Win2008R2SP1x64) version=$s82 ;;
												Win2008SP1x64) version=$s83 ;;
												Win2008SP1x86) version=$s84 ;;
												Win2008SP2x64) version=$s85 ;;
												Win2008SP2x86) version=$s86 ;;
												Win7SP0x64) version=$sev1 ;;
												Win7SP0x86) version=$sev2 ;;
												Win7SP1x64) version=$sev3 ;;
												Win7SP1x86) version=$sev4 ;;
												WinXPSP1x64) version=$xp1 ;;
												WinXPSP2x64) version=$xp2 ;;
												WinXPSP2x86) version=$xp3 ;;
												WinXPSP3x86) version=$xp4 ;;
											esac
											/bin/echo -e "$count) \e[1;34m$value\e[0m      - A Profile for $version"
											versionArr+=( [$count]=$version )
											keyArr+=( [$count]=$value )
										done
										/bin/echo -e "Please select the number for the OS Profile that \e[1;36mquickvol\e[0m should use for \e[1;32m${key[@]##*/}\e[0m"
										while true; do
											read o
											o=${o:-42}
											if [ $o -le $count ] && [ $o -ge 1 ] ; then
												OSTable[${key}]=${keyArr[${o}]}
												/bin/echo -e "using ... \e[1;32m${versionArr[${o}]}\e[0m"
												break
											else
												echo ""
												echo "Please enter a valid number"
											fi
										done
									done ; break ;;
								[Qq]* ) exit ;;
								* ) echo "Please answer y or n";;
							esac
						done ; break ;;
					[Qq]* ) exit ;;
					* ) echo "Please answer y or n" ;;
				esac
			done
			while true; do
				echo "----------------------------------------------"
				echo "                 Modules to Run               "
				echo "----------------------------------------------"
				echo "What should be done with the file(s)?"
				/bin/echo -e "1. \e[1;34mEcho selected files and profiles\e[0m"
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
				while true ; do
					read n
					n=${n:-42}
					case $n in 
						1) echo ""
						   /bin/echo -e "found \e[1;32m${#MemArray[@]}\e[0m file(s) here" ;
						   for i in ${!OSTable[@]} ; do
							/bin/echo -e "\e[1;32m$i\e[0m using the \e[1;32m${OSTable[${i}]}\e[0m profile"
						   done ;;
						2) Modules=${PsModules[@]} ;;
						3) Modules=${NetworkModules[@]} ;;
						4) Modules=${NetScan[@]} ;;
						5) Modules=${Registry[@]} ;;
						6) Modules=${UserInfo[@]} ;;
						7) Modules=${DllInfo[@]} ;;
						8) Modules=${Misc[@]} ;;
						9) Modules=${all[@]} ;;
						[Qq]* ) exit ;;		
						*) echo "Please enter a valid number" ;;
					esac
					if [ $n -ge 2 ] && [ $n -le 9 ]; then		
						for i in ${!OSTable[@]} ; do
							for m in ${Modules[@]} ; do
								ModuleRunner $i $m
							done
						done
						if [ $n -eq 9 ]; then
							exit
						fi
						break						
					fi
				done
			done ; cd "$present" ;;

		h)  echo "" ;/bin/echo -e  "	\e[1;36mQuickvol v1.1\e[0m is a script that will select \e[1;34m.mem\e[0m, \e[1;34m.vmem\e[0m, \e[1;34m.bin\e[0m, or \e[1;34m.img\e[0m files and attempt to run them through some common volatility scans. It will create seperate working directories for each memory image, so it works best if all of the memory files were appropriately named, and stored in one folder. 
	First, you will need to define what folder the memory files are located in.  You can do this with the following; \e[1;34mquickvol -f /path/to/memory/folder\e[0m. This should start the script, and its fist action would be to confirm that it has the correct \e[1;34m/path/to/folder\e[0m. It will also attempt to scan the folder for any memory files. You can select \e[1;34my\e[0m to continute, or \e[1;34mn\e[0m to end the script, and retype the correct path. 
	The next prompt will ask you if you already know the correct OS profile volatility will use. \e[1;34my\e[0m will move you to the next prompt, and \e[1;34mn\e[0m will initiate an imageinfo for all images selected in your folder. Once the query is done, you will have a choice to select the profile from a list generated by volatility, or allow \e[1;36mquickvol\e[0m to select the best available profile for you.
	At the final prompt, you can decide which modules you want to actually run on the memory images, they have been divided into pseudo-categories for convienience, but if you dont have any modules yet done, you can opt for \e[1;34moption 9\e[0m, and run all modules, which should give you a good baseline of results to work through.  If for some reason, you want to ensure that \e[1;36mquickvol\e[0m has selected your memory images, you can run \e[1;34moption 1\e[0m to echo what files \e[1;36mquickvol\e[0m currently has in its queue, and their associated profiles."; echo ""; echo $help; exit ;;
		\?) /bin/echo -e "Invalid Option: \e[0;31m-$OPTARG\e[0m, use \e[1;34m-f\e[0m or \e[1;34m-h\e[0m" ; exit ;;
		:)  /bin/echo -e "Option \e[1;34m-$OPTARG\e[0m requires an argument, use \e[1;34m-$OPTARG /path/to/memory/folder\e[0m" ; exit ;;

	esac
done
