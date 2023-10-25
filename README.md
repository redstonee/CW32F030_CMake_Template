# CW32F030_CMake_Template
A template project for CW32F030 with CMake  

This project contains the Standard library for CW32F030 from Creative Wisdom (or WHXY), and a simple blinky example.

I know nothing about Assembly, so I transplanted the startup file and the link script file with the reference of those for STM32, so there might be some bug which I haven't found yet.  

It's really a pity that WHXY doesn't provide an ISP tool independent from Keil or IAR, so you probably need to flash the chip with Keil or IAR now. Following is a method to flash the chip with Keil:
* Ensure the output executable file has the extension `.axf`, which is set in `CMakeLists.txt`, because Keil can only flash `.axf` files.  
*However, `.axf` files are actually same as `.elf` files, so the output file can be renamed to `.axf` directly.*
* Open a Keil project whose target device is CW32F030.
* Go to `Output` Tab in `Options for Target`.
* Select the `build` folder of this project with the button "Select Folder for Objects", and set the `Name of Executable` to the output executable filename.
* Click `OK` to close the dialog.
* Click `Download` to flash the chip.
