/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000003474712904_0179125218_init();
    xilinxcorelib_ver_m_00000000001358910285_1256727229_init();
    xilinxcorelib_ver_m_00000000001687936702_1862936372_init();
    xilinxcorelib_ver_m_00000000000277421008_2735415552_init();
    xilinxcorelib_ver_m_00000000001603977570_4130213560_init();
    work_m_00000000002489990758_3134358385_init();
    work_m_00000000004044568484_3383896982_init();
    work_m_00000000000748096776_1222603414_init();
    work_m_00000000003046218141_2749254585_init();
    work_m_00000000000704643321_0886308060_init();
    xilinxcorelib_ver_m_00000000000277421008_3261753898_init();
    xilinxcorelib_ver_m_00000000001603977570_3309543896_init();
    work_m_00000000000403262735_1948799799_init();
    work_m_00000000001479693876_3694719983_init();
    work_m_00000000001710714106_1985558087_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000001710714106_1985558087");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
