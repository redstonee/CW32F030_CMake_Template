#include <cw32f030.h>
#include <cw32f030_gpio.h>
#include <cw32f030_rcc.h>
#include <cw32f030_flash.h>
#include <base_types.h>

void SystemClock_Config()
{

    RCC_HSI_Enable(RCC_HSIOSC_DIV6); // HSI=48MHz, DIV6 -> 8MHz

    RCC_PLL_Enable(RCC_PLLSOURCE_HSI, 8000000, 8); // 8MHz -> 64MHz

    RCC_HCLKPRS_Config(RCC_HCLK_DIV1);
    RCC_PCLKPRS_Config(RCC_PCLK_DIV1);
    RCC_AHBPeriphClk_Enable(RCC_AHB_PERIPH_FLASH, ENABLE);
    FLASH_SetLatency(FLASH_Latency_3);
    RCC_SysClk_Switch(RCC_SYSCLKSRC_PLL);
    RCC_SystemCoreClockUpdate(64000000);
}

int main()
{
    SystemClock_Config();

    RCC_AHBPeriphClk_Enable(RCC_AHB_PERIPH_GPIOC, ENABLE);

    GPIO_InitTypeDef is;
    is.Mode = GPIO_MODE_OUTPUT_PP;
    is.Speed = GPIO_SPEED_HIGH;
    is.IT = GPIO_IT_NONE;
    is.Pins = GPIO_PIN_13;

    GPIO_Init(CW_GPIOC, &is);

    while (1)
    {
        GPIO_TogglePin(CW_GPIOC, GPIO_PIN_13);
        delay1ms(500);
    }

    return 0;
}