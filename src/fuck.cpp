#include <cw32f030.h>
#include <cw32f030_gpio.h>
#include <cw32f030_rcc.h>
#include <cw32f030_flash.h>
#include <cw32f030_uart.h>
#include <base_types.h>
#include <cstdlib>

void SystemClock_Config()
{

    // Use internal oscillator
    RCC_HSI_Enable(RCC_HSIOSC_DIV6);           // HSI = 48MHz, DIV6 -> 8MHz
    RCC_PLL_Enable(RCC_PLLSOURCE_HSI, 8e6, 8); // 8MHz -> 64MHz

    // Use external oscillator
    //  RCC_HSE_Enable(RCC_HSE_MODE_OSC, 8e6, RCC_HSE_DRIVER_NORMAL, RCC_HSE_FLT_CLOSE); // HSE = 8MHz
    //  RCC_PLL_Enable(RCC_PLLSOURCE_HSEOSC, 8e6, 8); // 8MHz -> 64MHz

    RCC_HCLKPRS_Config(RCC_HCLK_DIV1);
    RCC_PCLKPRS_Config(RCC_PCLK_DIV1);
    RCC_AHBPeriphClk_Enable(RCC_AHB_PERIPH_FLASH, ENABLE);
    FLASH_SetLatency(FLASH_Latency_3);
    RCC_SysClk_Switch(RCC_SYSCLKSRC_PLL);
    RCC_SystemCoreClockUpdate(64e6);

    RCC_AHBPeriphClk_Enable(RCC_AHB_PERIPH_GPIOC, ENABLE);
    RCC_AHBPeriphClk_Enable(RCC_AHB_PERIPH_GPIOA, ENABLE);
    RCC_APBPeriphClk_Enable1(RCC_APB1_PERIPH_UART2, ENABLE);
}

void GPIO_Config()
{
    PA03_AFx_UART2RXD();
    PA02_AFx_UART2TXD();

    GPIO_InitTypeDef is;
    is.Mode = GPIO_MODE_OUTPUT_PP;
    is.Speed = GPIO_SPEED_HIGH;
    is.IT = GPIO_IT_NONE;
    is.Pins = GPIO_PIN_13;
    GPIO_Init(CW_GPIOC, &is);

    is.Mode = GPIO_MODE_OUTPUT_PP;
    is.Pins = GPIO_PIN_2;
    GPIO_Init(CW_GPIOA, &is);

    is.Mode = GPIO_MODE_INPUT_PULLUP;
    is.Pins = GPIO_PIN_3;
    GPIO_Init(CW_GPIOA, &is);
}

void UART2_Config()
{

    USART_InitTypeDef is;
    USART_StructInit(&is);
    is.USART_UclkFreq = 64e6;
    USART_Init(CW_UART2, &is);
}

void UART_Println(UART_TypeDef *USARTx, char *str)
{
    while (*str)
    {
        USART_SendData_8bit(USARTx, *str++);
        while (USART_GetFlagStatus(USARTx, USART_FLAG_TXE) == RESET)
            ;
    }
    USART_SendData_8bit(USARTx, '\r');
    while (USART_GetFlagStatus(USARTx, USART_FLAG_TXE) == RESET)
        ;
    USART_SendData_8bit(USARTx, '\n');
    while (USART_GetFlagStatus(USARTx, USART_FLAG_TXE) == RESET)
        ;
}

int main()
{
    SystemClock_Config();
    GPIO_Config();
    UART2_Config();

    uint8_t c = 0;
    char fuckStr[20];
    while (1)
    {
        sprintf(fuckStr, "Fuck the World %d times!", ++c);
        GPIO_TogglePin(CW_GPIOC, GPIO_PIN_13);
        delay1ms(500);
        UART_Println(CW_UART2, fuckStr);
    }

    return 0;
}