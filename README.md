# quickvol
Shell script that automatically runs 26+ volatility modules on multiple memory images

Quickvol v1.1 is a script that will select .mem,.bin, or .img files and attempt to run them through some common

volatility plugins. I've only tested this on Ubuntu 14.10, so guarantees of functionality will end there.

It will create seperate working directories for each memory image, so it works best if all of the memory files were

appropriately named, and stored in one folder. 

First, you will need to define what folder the memory files are located in.  You can do this with the following quickvol -f /path/to/memory/folder. 

This should start the script, and its fist action would be to confirm that it has the correct /path/to/folder.

You can select 'y' to continute, or 'n' to end the script, and retype the correct path. 

The next prompt will ask you if you already know the correct OS profile volatility will use. 'y' will move you to the

next prompt, and 'n' will initiate an imageinfo for all images selected in your folder. 

You will be able to query the imageinfo results in the next prompt, where you select the profile volatility will use.

Once at the next prompt press 'o' to return the imageinfo results if needed, then select the number of the profile you

want to run. 

Once at the final prompt, you can decide which modules you want to actually run on the memory images, they have been

divided into pseudo-categories for convienience, but if you dont have any modules yet done, you can opt for option 9,

and run all modules, which should give you a good baseline of results to work through.  

If for some reason, you want to ensure that 'quickvol' has selected your memory images, you can run 'option 1 to echo

what quickvol currently has in its queue.
