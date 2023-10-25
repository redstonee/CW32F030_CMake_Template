ENTRY(Reset_Handler)

_estack = 0x20002000;
_Min_Heap_Size = 0x200;
_Min_Stack_Size = 0x200;

MEMORY{
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 0x00010000
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 0x00002000
}

SECTIONS{
    .isr_vector : {
        . = ALIGN(8);
        KEEP(*(.isr_vector))
        . = ALIGN(8);
    } > FLASH

    .text : {
        . = ALIGN(8);
        *(.text)
        *(.text*)
        *(.glue_7)
        *(.glue_7t)
        *(.eh_frame)

        KEEP(*(.init))
        KEEP(*(.fini))
        . = ALIGN(8);
        _etext = .;
    } > FLASH

    .rodata : {
        . = ALIGN(8);
        *(.rodata)
        *(.rodata*)
        . = ALIGN(8);
    } > FLASH

    .ARM.extab : {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } > FLASH

    .ARM : {
        __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
    } > FLASH

    .preinit_array : {
        PROVIDE_HIDDEN (__preinit_array_start = .);
        KEEP (*(.preinit_array*))
        PROVIDE_HIDDEN (__preinit_array_end = .);
    } > FLASH

    .init_array : {
        PROVIDE_HIDDEN (__init_array_start = .);
        KEEP (*(SORT(.init_array.*)))
        KEEP (*(.init_array*))
        PROVIDE_HIDDEN (__init_array_end = .);
    } > FLASH

    .fini_array : {
        PROVIDE_HIDDEN (__fini_array_start = .);
        KEEP (*(.fini_array*))
        KEEP (*(SORT(.fini_array.*)))
        PROVIDE_HIDDEN (__fini_array_end = .);
    } > FLASH

    _sidata = LOADADDR(.data);

    .data : {
        . = ALIGN(8);
        _sdata = .;
        *(.data)
        *(.data*)

        . = ALIGN(8);
        _edata = .;
    } > RAM AT > FLASH

    .= ALIGN(4);
    .bss : {
        _sbss = .;
        __bss_start__ = _sbss;
        *(.bss)
        *(.bss*)
        *(COMMON)

        . = ALIGN(4);
        _ebss = .;
        __bss_end__ = _ebss;
    } > RAM

    .user_heap_stack : {
        . = ALIGN(4);
        PROVIDE ( end = . );
        PROVIDE ( _end = . );
        . = . + _Min_Heap_Size;
        . = . + _Min_Stack_Size;
        . = ALIGN(4);
    } > RAM

    .ARM.attributes 0 : {
        *(.ARM.attributes)
    }

}

