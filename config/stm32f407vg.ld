/* Linker script for STM32F407VG */
MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 1M
    RAM (xrw)  : ORIGIN = 0x20000000, LENGTH = 192K
}

SECTIONS
{
    .text : {
        *(.isr_vector)
        *(.text*)
        *(.rodata*)
        _etext = .;
    } > FLASH

    .data : AT (_etext) {
        _sdata = .;
        *(.data*)
        _edata = .;
    } > RAM

    .bss : {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    } > RAM

    .stack : {
        . = ALIGN(8);
        _estack = .;
    } > RAM
}
