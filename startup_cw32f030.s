.syntax unified
.cpu cortex-m0plus
.fpu softvfp
.thumb

.global g_pfnVectors
.global Default_Handler

/* start address for the initialization values of the .data section. defined in linker script */
.word  _sidata
/* start address for the .data section. defined in linker script */
.word  _sdata
/* end address for the .data section. defined in linker script */
.word  _edata
/* start address for the .bss section. defined in linker script */
.word  _sbss
/* end address for the .bss section. defined in linker script */
.word  _ebss


.global _start
.global Reset_Handler



.section .text.Reset_Handler
.weak Reset_Handler
.type Reset_Handler, %function

Reset_Handler:
    /* Initialize the stack pointer */
    ldr r0, =_estack
    mov sp, r0

    /* Call the system clock initialization function */
    bl SystemInit

    /* Check if boot space corresponds to test memory */
    ldr r0, =0x00000004
    ldr r1, [R0]
    lsrs r1, r1, #24
    ldr r2, =0x1F
    cmp r1, r2
    bne ApplicationStart

    /* SYSCFG clock enable */

    LDR     R0,=0x40021018
    LDR     R1,=0x00000001
    STR     R1, [R0]

    /* Set CFGR1 register with flash memory remap at address 0 */

    LDR     R0,=0x40010000
    LDR     R1,=0x00000000
    STR     R1, [R0]

ApplicationStart:
/* Copy the data segment initializers from flash to SRAM */
    ldr r0, =_sdata
    ldr r1, =_edata
    ldr r2, =_sidata
    movs r3, #0
    b LoopCopyDataInit

CopyDataInit:
    ldr r4, [r2, r3]
    str r4, [r0, r3]
    adds r3, r3, #4

LoopCopyDataInit:
    adds r4, r0, r3
    cmp r4, r1
    bcc CopyDataInit
  
/* Zero fill the bss segment. */
    ldr r2, =_sbss
    ldr r4, =_ebss
    movs r3, #0
    b LoopFillZerobss

FillZerobss:
    str  r3, [r2]
    adds r2, r2, #4

LoopFillZerobss:
    cmp r2, r4
    bcc FillZerobss

    /* Call static constructors */
    bl __libc_init_array
    /* Call the application's entry point */
    bl main

LoopForever:
    b LoopForever

.size Reset_Handler, .-Reset_Handler

.section .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
    b Infinite_Loop

    .size Default_Handler, .-Default_Handler

    .section .isr_vector,"a",%progbits
    .type g_pfnVectors, %object
    .size g_pfnVectors, .-g_pfnVectors


g_pfnVectors:
    .word _estack
    .word Reset_Handler
    .word NMI_Handler
    .word HardFault_Handler
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word SVC_Handler
    .word 0
    .word 0
    .word PendSV_Handler
    .word SysTick_Handler
    
    .word WDT_IRQHandler /*Watchdog Timer */
    .word LVD_IRQHandler /*Low Voltage Detect */
    .word RTC_IRQHandler /*Real Time Clock */
    .word FLASHRAM_IRQHandler /*Flash Memory */
    .word RTC_IRQHandler /*Real Time Clock */
    .word GPIOA_IRQHandler /*GPIOA */
    .word GPIOB_IRQHandler /*GPIOB */
    .word GPIOC_IRQHandler /*GPIOC */
    .word GPIOF_IRQHandler /*GPIOF */
    .word DMACH1_IRQHandler /*DMA Channel 1 */
    .word DMACH23_IRQHandler /*DMA Channel 2 and 3 */
    .word DMACH45_IRQHandler /*DMA Channel 4 and 5 */
    .word ADC_IRQHandler /*ADC */
    .word ATIM_IRQHandler /*Advanced Timer */
    .word VC1_IRQHandler /*Voltage Comparator 1 */
    .word VC2_IRQHandler /*Voltage Comparator 2 */
    .word GTIM1_IRQHandler /*General Timer 1 */
    .word GTIM2_IRQHandler /*General Timer 2 */
    .word GTIM3_IRQHandler /*General Timer 3 */
    .word GTIM4_IRQHandler /*General Timer 4 */
    .word BTIM1_IRQHandler /*Basic Timer */
    .word BTIM2_IRQHandler /*Basic Timer */
    .word BTIM3_IRQHandler /*Basic Timer */
    .word I2C1_IRQHandler /*I2C1 */
    .word I2C2_IRQHandler /*I2C2 */
    .word SPI1_IRQHandler /*SPI1 */
    .word SPI2_IRQHandler /*SPI2 */
    .word UART1_IRQHandler /*UART1 */
    .word UART2_IRQHandler /*UART2 */
    .word UART3_IRQHandler /*UART3 */
    .word AWT_IRQHandler /*Auto Wakeup Timer */
    .word FAULT_IRQHandler /*Fault Handler */

    .weak NMI_Handler
    .thumb_set NMI_Handler,Default_Handler

    .weak HardFault_Handler
    .thumb_set HardFault_Handler,Default_Handler

    .weak SVC_Handler
    .thumb_set SVC_Handler,Default_Handler

    .weak PendSV_Handler
    .thumb_set PendSV_Handler,Default_Handler

    .weak SysTick_Handler
    .thumb_set SysTick_Handler,Default_Handler

    .weak WDT_IRQHandler
    .thumb_set WDT_IRQHandler,Default_Handler

    .weak LVD_IRQHandler
    .thumb_set LVD_IRQHandler,Default_Handler

    .weak RTC_IRQHandler
    .thumb_set RTC_IRQHandler,Default_Handler

    .weak FLASHRAM_IRQHandler
    .thumb_set FLASHRAM_IRQHandler,Default_Handler

    .weak RTC_IRQHandler
    .thumb_set RTC_IRQHandler,Default_Handler

    .weak GPIOA_IRQHandler
    .thumb_set GPIOA_IRQHandler,Default_Handler

    .weak GPIOB_IRQHandler
    .thumb_set GPIOB_IRQHandler,Default_Handler

    .weak GPIOC_IRQHandler
    .thumb_set GPIOC_IRQHandler,Default_Handler

    .weak GPIOF_IRQHandler
    .thumb_set GPIOF_IRQHandler,Default_Handler

    .weak DMACH1_IRQHandler
    .thumb_set DMACH1_IRQHandler,Default_Handler

    .weak DMACH23_IRQHandler
    .thumb_set DMACH23_IRQHandler,Default_Handler

    .weak DMACH45_IRQHandler
    .thumb_set DMACH45_IRQHandler,Default_Handler

    .weak ADC_IRQHandler
    .thumb_set ADC_IRQHandler,Default_Handler

    .weak ATIM_IRQHandler
    .thumb_set ATIM_IRQHandler,Default_Handler

    .weak VC1_IRQHandler
    .thumb_set VC1_IRQHandler,Default_Handler

    .weak VC2_IRQHandler
    .thumb_set VC2_IRQHandler,Default_Handler

    .weak GTIM1_IRQHandler
    .thumb_set GTIM1_IRQHandler,Default_Handler

    .weak GTIM2_IRQHandler
    .thumb_set GTIM2_IRQHandler,Default_Handler

    .weak GTIM3_IRQHandler
    .thumb_set GTIM3_IRQHandler,Default_Handler

    .weak GTIM4_IRQHandler
    .thumb_set GTIM4_IRQHandler,Default_Handler

    .weak BTIM1_IRQHandler
    .thumb_set BTIM1_IRQHandler,Default_Handler

    .weak BTIM2_IRQHandler
    .thumb_set BTIM2_IRQHandler,Default_Handler

    .weak BTIM3_IRQHandler
    .thumb_set BTIM3_IRQHandler,Default_Handler

    .weak I2C1_IRQHandler
    .thumb_set I2C1_IRQHandler,Default_Handler

    .weak I2C2_IRQHandler
    .thumb_set I2C2_IRQHandler,Default_Handler

    .weak SPI1_IRQHandler
    .thumb_set SPI1_IRQHandler,Default_Handler

    .weak SPI2_IRQHandler
    .thumb_set SPI2_IRQHandler,Default_Handler

    .weak UART1_IRQHandler
    .thumb_set UART1_IRQHandler,Default_Handler

    .weak UART2_IRQHandler
    .thumb_set UART2_IRQHandler,Default_Handler

    .weak UART3_IRQHandler
    .thumb_set UART3_IRQHandler,Default_Handler

    .weak AWT_IRQHandler
    .thumb_set AWT_IRQHandler,Default_Handler

    .weak FAULT_IRQHandler
    .thumb_set FAULT_IRQHandler,Default_Handler
