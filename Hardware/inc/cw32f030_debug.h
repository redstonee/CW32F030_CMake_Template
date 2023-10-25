/**
 * @file cw32f030_debug.h
 * @author your name (you@domain.com)
 * @brief 
 * @version 0.1
 * @date 2021-05-13
 * 
 * @copyright Copyright (c) 2021
 * 
 */

/*******************************************************************************
*
* �������ɺ�������Ϣ
* �人оԴ�뵼�����޹�˾������ʹ�����б�̴���ʾ���ķ�ר���İ�Ȩ���ɣ��������ɴ�
* ���ɸ��������ض���Ҫ�����Ƶ����ƹ��ܡ����ݲ��ܱ��ų����κη�����֤���人оԴ��
* �������޹�˾������򿪷��̺͹�Ӧ�̶Գ������֧�֣�����У����ṩ�κ���ʾ��
* ���ı�֤�������������������ڰ������й������ԡ�������ĳ���ض���;�ͷ���Ȩ�ı�֤
* ��������
* ���ۺ������Σ��人оԴ�뵼�����޹�˾������򿪷��̻�Ӧ�̾��������и����
* ��ʹ����֪�䷢���Ŀ�����ʱ��Ҳ����ˣ����ݵĶ�ʧ���𻵣�ֱ�ӵġ��ر�ġ�������
* ���ӵ��𺦣����κκ���Ծ����𺦣�������ҵ�����롢������Ԥ�ڿɽ�ʡ����
* ��ʧ��
* ĳЩ˾��Ͻ����������ֱ�ӵġ������Ļ����Ե������κε��ų������ƣ����ĳЩ��
* ȫ�������ų������ƿ��ܲ�������������
*
*******************************************************************************/

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __CW32F03x_DEBUG_H__
#define __CW32F03x_DEBUG_H__


#ifdef __cplusplus
 extern "C" {
#endif

/*****************************************************************************/
/* Include files                                                             */
/*****************************************************************************/

#include "base_types.h"
#include "cw32f030.h"

/*****************************************************************************/
/* Global pre-processor symbols/macros ('#define')                           */
/*****************************************************************************/
//============================================================
void DBGMCU_Config(uint32_t DBGMCU_Periph, FunctionalState NewState);


#define DBGMCU_ATIM_STOP                   ((uint32_t)0x00000001)
#define DBGMCU_GTIM1_STOP                  ((uint32_t)0x00000002)
#define DBGMCU_GTIM2_STOP                  ((uint32_t)0x00000004)
#define DBGMCU_GTIM3_STOP                  ((uint32_t)0x00000008)
#define DBGMCU_GTIM4_STOP                  ((uint32_t)0x00000010)
#define DBGMCU_BTIM123_STOP                ((uint32_t)0x00000020)
#define DBGMCU_AWT_STOP                    ((uint32_t)0x00000040)
#define DBGMCU_RTC_STOP                    ((uint32_t)0x00000100)
#define DBGMCU_IWDT_STOP                   ((uint32_t)0x00000200)
#define DBGMCU_WWDT_STOP                   ((uint32_t)0x00000400)                                            
#define IS_DBGMCU_PERIPH(PERIPH) ((((PERIPH) & 0xFFFFF880) == 0x00) && ((PERIPH) != 0x00))


//============================================================

#ifdef __cplusplus
}
#endif

#endif