#include <cw32f030.h>
#include <cw32f030_gpio.h>
#include <cw32f030_rcc.h>
#include <base_types.h>

int main()
{
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
        delay1ms(100);
    }

    return 0;
}