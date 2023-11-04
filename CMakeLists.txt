cmake_minimum_required(VERSION 3.20)

# Set the toolchain location if using Windows
set(TOOLCHAIN_PREFIX "D:/SDKs/gcc-arm-5.4 2016q3")

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/toolchain-arm-none-eabi.cmake)

project(fuckCW32)

enable_language(ASM)
enable_language(C)
enable_language(CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(OUTPUT_EXE_NAME ${CMAKE_PROJECT_NAME}.elf)

# Set the source directories
set(HW_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/Hardware/src)
set(USER_SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/src)

# Set the include directories
include_directories(${CMAKE_CURRENT_LIST_DIR}/Hardware/inc)
include_directories(${CMAKE_CURRENT_LIST_DIR}/include)
include_directories(${CMAKE_CURRENT_LIST_DIR}/INT)
include_directories(${CMAKE_CURRENT_LIST_DIR}/CMSIS/Core/Include)
include_directories(${CMAKE_CURRENT_LIST_DIR}/Device)



# Add source files

set (HW_SRCS
        ${HW_SRC_DIR}/cw32f030_adc.c
        ${HW_SRC_DIR}/cw32f030_atim.c
        ${HW_SRC_DIR}/cw32f030_adc.c
        ${HW_SRC_DIR}/cw32f030_atim.c
        ${HW_SRC_DIR}/cw32f030_awt.c
        ${HW_SRC_DIR}/cw32f030_btim.c
        ${HW_SRC_DIR}/cw32f030_crc.c
        ${HW_SRC_DIR}/cw32f030_debug.c
        ${HW_SRC_DIR}/cw32f030_digitalsign.c
        ${HW_SRC_DIR}/cw32f030_dma.c
        ${HW_SRC_DIR}/cw32f030_flash.c
        ${HW_SRC_DIR}/cw32f030_gpio.c
        ${HW_SRC_DIR}/cw32f030_gtim.c
        ${HW_SRC_DIR}/cw32f030_i2c.c
        ${HW_SRC_DIR}/cw32f030_iwdt.c
        ${HW_SRC_DIR}/cw32f030_lvd.c
        ${HW_SRC_DIR}/cw32f030_pwr.c
        ${HW_SRC_DIR}/cw32f030_ram.c
        ${HW_SRC_DIR}/cw32f030_rcc.c
        ${HW_SRC_DIR}/cw32f030_rtc.c
        ${HW_SRC_DIR}/cw32f030_spi.c
        ${HW_SRC_DIR}/cw32f030_systick.c
        ${HW_SRC_DIR}/cw32f030_uart.c
        ${HW_SRC_DIR}/cw32f030_vc.c
        ${HW_SRC_DIR}/cw32f030_wwdt.c
        ${HW_SRC_DIR}/system_cw32f030.c

)

set (USER_SRCS
        ${USER_SRC_DIR}/fuck.cpp
)

set(STARTUP_SRC 
        ${CMAKE_CURRENT_LIST_DIR}/startup_cw32f030.s
)

set(INTERRUPTS_SRC
        ${CMAKE_CURRENT_LIST_DIR}/INT/interrupts_cw32f030.c
)

add_executable(${OUTPUT_EXE_NAME}
        ${HW_SRCS}
        ${USER_SRCS}
        ${STARTUP_SRC}
        ${INTERRUPTS_SRC}
        ${SYSTEM_SRC}
)

add_compile_definitions(
        USE_STDPERIPH_DRIVER
)

set(LD_SCRIPT_PATH ${CMAKE_CURRENT_LIST_DIR}/ldscript.ld)
get_filename_component(LD_SCRIPT_PATH_ABS ${LD_SCRIPT_PATH} ABSOLUTE)

set_target_properties(${OUTPUT_EXE_NAME} PROPERTIES
        CXX_STANDARD 17
        CXX_STANDARD_REQUIRED ON
        LINK_DEPENDS ${LD_SCRIPT_PATH_ABS}
        LINK_FLAGS "-T \"${LD_SCRIPT_PATH_ABS}\""
)


add_custom_target(
        showSize ALL
        ${TOOLCHAIN_PREFIX}/bin/${TOOLCHAIN}-size "${CMAKE_CURRENT_BINARY_DIR}/${OUTPUT_EXE_NAME}"
        DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${OUTPUT_EXE_NAME})

find_program(PYOCD_FOUND pyocd)

if(PYOCD_FOUND)
        add_custom_target(BuildAndFlash COMMAND DEPENDS flash-cmd)
        add_custom_command(
                USES_TERMINAL 
                OUTPUT flash-cmd
                COMMAND pyocd load ${CMAKE_CURRENT_BINARY_DIR}/${OUTPUT_EXE_NAME} -t cw32f030c8 # Modify this to match your target
                DEPENDS showSize
        )
else()
        message(WARNING "pyocd not found, flashing will not be available")
endif()