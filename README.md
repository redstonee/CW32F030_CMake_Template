# CW32F030_CMake_Template
A template project for CW32F030 with CMake  

This project contains the Standard library for CW32F030 from Creative Wisdom (or WHXY), and a simple blinky example.

I know nothing about Assembly, so I transplanted the startup file and the link script file with the reference of those for STM32, so there might be some bug which I haven't found yet.  

The chip can be flashed using pyOCD, and debugging is also supported(even though idk how to implement).

* Make sure pyOCD is installed, which can be done by `pip install pyocd`.
* Copy everything *under* [Pack](./Pack) folder to the pack folder of pyOCD, which is `%appdata%\..\Local\cmsis-pack-manager\cmsis-pack-manager\` in Windows.
* Merge the target config from [index_cw32.json](./index_cw32.json) into the target index file of pyOCD, which is `%appdata%\..\Local\cmsis-pack-manager\cmsis-pack-manager\index.json` in Windows.
* Run `pyocd pack install cw32f030` to update the pack index.
* Connect the board and run `pyocd erase --chip --target cw32f030c8` in the project folder to see if it works properly.
