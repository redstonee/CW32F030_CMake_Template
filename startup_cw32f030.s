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
    .word MemManage_Handler
    .word BusFault_Handler
    .word UsageFault_Handler
    .word 0
    .word 0
    .word 0
    .word 0
    .word SVC_Handler
    .word DebugMon_Handler
    .word 0
    .word PendSV_Handler
    .word SysTick_Handler
    
    .word IWDG_IRQHandler /* Independent Watchdog */
    .word PVD_IRQHandler /* PVD through EXTI Line detect */
    .word 0
    .word FLASH_IRQHandler /* FLASH */
    .word RCC_IRQHandler /* RCC */
    .word EXTI0_1_IRQHandler /* EXTI Line 0 and 1 */
    .word EXTI2_3_IRQHandler /* EXTI Line 2 and 3 */
    .word EXTI4_15_IRQHandler /* EXTI Line 4 to 15 */
    .word 0
    .word 0
    .word 0
    .word 0
    .word ADC1_IRQHandler /* ADC1 */
    .word TIM1_BRK_UP_TRG_COM_IRQHandler /* TIM1 Break, Update, Trigger and Commutation */
    .word TIM1_CC_IRQHandler /* TIM1 Capture Compare */
    .word 0
    .word TIM3_IRQHandler /* TIM3 */
    .word 0
    .word 0
    .word TIM14_IRQHandler /* TIM14 */
    .word 0
    .word 0
    .word 0
    .word I2C1_IRQHandler /* I2C1 */
    .word SPI1_IRQHandler /* SPI1 */
    .word 0
    .word USART1_IRQHandler /* USART1 */
    .word USART2_IRQHandler /* USART2 */
    .word 0
    .word 0
    .word 0
    

    .weak NMI_Handler
    .thumb_set NMI_Handler,Default_Handler

    .weak HardFault_Handler
    .thumb_set HardFault_Handler,Default_Handler

    .weak MemManage_Handler
    .thumb_set MemManage_Handler,Default_Handler

    .weak BusFault_Handler
    .thumb_set BusFault_Handler,Default_Handler

    .weak UsageFault_Handler
    .thumb_set UsageFault_Handler,Default_Handler

    .weak SVC_Handler
    .thumb_set SVC_Handler,Default_Handler

    .weak DebugMon_Handler
    .thumb_set DebugMon_Handler,Default_Handler

    .weak PendSV_Handler
    .thumb_set PendSV_Handler,Default_Handler

    .weak SysTick_Handler
    .thumb_set SysTick_Handler,Default_Handler

    .weak IWDG_IRQHandler
    .thumb_set IWDG_IRQHandler,Default_Handler

    .weak PVD_IRQHandler
    .thumb_set PVD_IRQHandler,Default_Handler

    .weak FLASH_IRQHandler
    .thumb_set FLASH_IRQHandler,Default_Handler

    .weak RCC_IRQHandler
    .thumb_set RCC_IRQHandler,Default_Handler

    .weak EXTI0_1_IRQHandler
    .thumb_set EXTI0_1_IRQHandler,Default_Handler

    .weak EXTI2_3_IRQHandler
    .thumb_set EXTI2_3_IRQHandler,Default_Handler

    .weak EXTI4_15_IRQHandler
    .thumb_set EXTI4_15_IRQHandler,Default_Handler

    .weak ADC1_IRQHandler
    .thumb_set ADC1_IRQHandler,Default_Handler

    .weak TIM1_BRK_UP_TRG_COM_IRQHandler
    .thumb_set TIM1_BRK_UP_TRG_COM_IRQHandler,Default_Handler

    .weak TIM1_CC_IRQHandler
    .thumb_set TIM1_CC_IRQHandler,Default_Handler

    .weak TIM3_IRQHandler
    .thumb_set TIM3_IRQHandler,Default_Handler

    .weak TIM14_IRQHandler
    .thumb_set TIM14_IRQHandler,Default_Handler

    .weak I2C1_IRQHandler
    .thumb_set I2C1_IRQHandler,Default_Handler

    .weak SPI1_IRQHandler
    .thumb_set SPI1_IRQHandler,Default_Handler

    .weak USART1_IRQHandler
    .thumb_set USART1_IRQHandler,Default_Handler

    .weak USART2_IRQHandler
    .thumb_set USART2_IRQHandler,Default_Handler



