unit uCIVGlobalConstants;

interface

const
  // component constants
  CIV_COMPONENT_NAME                        = 'Icom Communications Interface V Component';
  CIV_COMPONENT_VERSION                     = 'v24.11';
  CIV_COMPONENT_PAGE                        = 'Icom CI-V';
  CIV_PORT_DEFAULT_PORT_NO                  = 3;
  CIV_PORT_DEFAULT_BAUD_RATE                = 19200;

  // protocol constants
  CIV_COMPUTER_ADDRESS                                        = AnsiChar(#$E0);
  CIV_PACKET_BEGIN                                            = AnsiString(#$FE#$FE);
  CIV_PACKET_END                                              = AnsiChar(#$FD);

  // radio commands
  CIV_COMMAND_TRANSF_OPERATING_FREQ_DATA                      = AnsiChar(#$00);
  CIV_COMMAND_TRANSF_OPERATING_MODE_DATA                      = AnsiChar(#$01);
  CIV_COMMAND_READ_LOW_UP_FREQ_DATA                           = AnsiChar(#$02);
  CIV_COMMAND_READ_OPERATING_FREQ_DATA                        = AnsiChar(#$03);
  CIV_COMMAND_READ_OPERATING_MODE_DATA                        = AnsiChar(#$04);
  CIV_COMMAND_WRITE_OPERATING_FREQ_DATA_VFO                   = AnsiChar(#$05);
  CIV_COMMAND_WRITE_OPERATING_MODE_DATA_VFO                   = AnsiChar(#$06);
  CIV_COMMAND_SELECT_VFO_MODE                                 = AnsiChar(#$07);
    // sub commands - CIV_COMMAND_SELECT_VFO_MODE
    CIV_SUB_CMD_VFO_MODE_SELECT_VFO_A                         = AnsiChar(#$00);
    CIV_SUB_CMD_VFO_MODE_SELECT_VFO_B                         = AnsiChar(#$01);
    CIV_SUB_CMD_VFO_MODE_EQ_VFO_AB                            = AnsiChar(#$A0);
    CIV_SUB_CMD_VFO_MODE_EXCH_VFO_AB_MAIN_SUB                 = AnsiChar(#$B0);
    CIV_SUB_CMD_VFO_MODE_EQ_VFO_MAIN_SUB                      = AnsiChar(#$B1);
    CIV_SUB_CMD_VFO_MODE_DUAL_WATCH_OFF                       = AnsiChar(#$C0);
    CIV_SUB_CMD_VFO_MODE_DUAL_WATCH_ON                        = AnsiChar(#$C1);
    CIV_SUB_CMD_VFO_MODE_SELECT_MAIN_BAND                     = AnsiChar(#$D0);
    CIV_SUB_CMD_VFO_MODE_SELECT_SUB_BAND                      = AnsiChar(#$D1);
    CIV_SUB_CMD_VFO_MODE_SELECT_FRONT_WINDOW                  = AnsiChar(#$E0);  // IC-R7100 Only!
      // sub commands - CIV_SUB_CMD_VFO_MODE_SELECT_FRONT_WINDOW
      CIV_SUB_CMD_FRONT_WINDOW_0                              = AnsiChar(#$00);
      CIV_SUB_CMD_FRONT_WINDOW_1                              = AnsiChar(#$01);
  CIV_COMMAND_SELECT_MEMORY_MODE                              = AnsiChar(#$08);
    // sub commands - CIV_COMMAND_SELECT_MEMORY_MODE
    CIV_SUB_CMD_SELECT_MEMORY_BANK                            = AnsiChar(#$A0);  // IC-R8500 (0 to 24) IC-7000 (1 to 5)
  CIV_COMMAND_WRITE_DISPLAY_TO_SELECTED_MEMORY                = AnsiChar(#$09);
  CIV_COMMAND_TRANSFER_MEMORY_TO_VFO                          = AnsiChar(#$0A);
  CIV_COMMAND_CLEAR_SELECTED_MEMORY                           = AnsiChar(#$0B);
  CIV_COMMAND_READ_DUPLEX_OFFSET_FREQUENCY                    = AnsiChar(#$0C);
  CIV_COMMAND_WRITE_DUPLEX_OFFSET_FREQUENCY                   = AnsiChar(#$0D);
  CIV_COMMAND_SCAN_OPERATIONS                                 = AnsiChar(#$0E);
    // sub commands - CIV_COMMAND_SCAN_OPERATIONS
    CIV_SUB_CMD_STOP_SCAN                                     = AnsiChar(#$00);
    CIV_SUB_CMD_START_PROGRAMMED_OR_MEMORY_SCAN               = AnsiChar(#$01);
    CIV_SUB_CMD_START_PROGRAMMED_SCAN                         = AnsiChar(#$02);
    CIV_SUB_CMD_START_DELTAF_SCAN                             = AnsiChar(#$03);
    CIV_SUB_CMD_START_AUTO_MEM_WRITE_SCAN                     = AnsiChar(#$04);
    CIV_SUB_CMD_START_FINE_PROG_SCAN                          = AnsiChar(#$12);
    CIV_SUB_CMD_START_FINE_DELTAF_SCAN                        = AnsiChar(#$13);
    CIV_SUB_CMD_START_MEMORY_SCAN                             = AnsiChar(#$22);
    CIV_SUB_CMD_START_SELECTED_NUMBER_MEMORY_SCAN             = AnsiChar(#$23);
    CIV_SUB_CMD_START_SELECTED_MODE_MEMORY_SCAN               = AnsiChar(#$24);
    CIV_SUB_CMD_START_PRIORITY_WINDOW_SCAN                    = AnsiChar(#$42);
    CIV_SUB_CMD_UNFIX_CENTER_FREQ_DELTAF_SCAN                 = AnsiChar(#$A0);
    CIV_SUB_CMD_FIX_CENTER_FREQ_DELTAF_SCAN                   = AnsiChar(#$AA);
    CIV_SUB_CMD_SET_DELTAF_2DOT5_KHZ                          = AnsiChar(#$A1);
    CIV_SUB_CMD_SET_DELTAF_5_KHZ                              = AnsiChar(#$A2);
    CIV_SUB_CMD_SET_DELTAF_10_KHZ                             = AnsiChar(#$A3);
    CIV_SUB_CMD_SET_DELTAF_20_KHZ                             = AnsiChar(#$A4);
    CIV_SUB_CMD_SET_DELTAF_50_KHZ                             = AnsiChar(#$A5);
    CIV_SUB_CMD_SET_DELTAF_500_KHZ                            = AnsiChar(#$A6);  // IC-756Pro, IC-756ProII
    CIV_SUB_CMD_SET_DELTAF_1000_KHZ                           = AnsiChar(#$A7);  // IC-756Pro, IC-756ProII
    CIV_SUB_CMD_INCLUDE_MEMORY_FOR_SCAN                       = AnsiChar(#$B0);
      // sub commands - CIV_SUB_CMD_INCLUDE_MEMORY_FOR_SCAN
      CIV_SUB_CMD_MEMORY_GROUP_1                              = AnsiChar(#$01);  // IC-7800 Only!
      CIV_SUB_CMD_MEMORY_GROUP_2                              = AnsiChar(#$02);  // IC-7800 Only!
      CIV_SUB_CMD_MEMORY_GROUP_3                              = AnsiChar(#$03);  // IC-7800 Only!
    CIV_SUB_CMD_EXCLUDE_MEMORY_FOR_SCAN                       = AnsiChar(#$B1);
    CIV_SUB_CMD_SET_SCAN_NUMBER                               = AnsiChar(#$B2);  // ??????
    CIV_SUB_CMD_SET_VSC_OFF                                   = AnsiChar(#$C0);
    CIV_SUB_CMD_SET_VSC_ON                                    = AnsiChar(#$C1);
    CIV_SUB_CMD_SET_SCAN_RESUME_FOREVER                       = AnsiChar(#$D0);  // IC-R9000, IC-R8500, IC-7000, IC-910 Scan Resume Off
    CIV_SUB_CMD_SET_SCAN_RESUME_0FF                           = AnsiChar(#$D1);  // IC-R9000, IC-R8500
    CIV_SUB_CMD_SET_SCAN_RESUME_B                             = AnsiChar(#$D2);  // IC-R9000
    CIV_SUB_CMD_SET_SCAN_RESUME_A                             = AnsiChar(#$D3);  // IC-R9000 and IC-R8500 - Delay, IC-7000 Scan Resume Off, IC-910 Scan Resume On
  CIV_COMMAND_SPLIT_OPERATION                                 = AnsiChar(#$0F);
    // sub commands - CIV_COMMAND_SPLIT_OPERATION
    CIV_SUB_CMD_CANCEL_SPLIT_FREQ                             = AnsiChar(#$00);
    CIV_SUB_CMD_START_SPLIT_FREQ                              = AnsiChar(#$01);
    CIV_SUB_CMD_CANCEL_DUPLEX_OP                              = AnsiChar(#$10);
    CIV_SUB_CMD_SELECT_DUPLEX_MINUS_OP                        = AnsiChar(#$11);
    CIV_SUB_CMD_SELECT_DUPLEX_PLUS_OP                         = AnsiChar(#$12);
  CIV_COMMAND_TUNNING_STEPS                                   = AnsiChar(#$10);
    // sub commands - CIV_COMMAND_TUNNING_STEPS
    CIV_SUB_CMD_TUNNING_STEP_MINIMUM                          = AnsiChar(#$00);
    CIV_SUB_CMD_TUNNING_STEP_1                                = AnsiChar(#$01);
    CIV_SUB_CMD_TUNNING_STEP_2                                = AnsiChar(#$02);
    CIV_SUB_CMD_TUNNING_STEP_3                                = AnsiChar(#$03);
    CIV_SUB_CMD_TUNNING_STEP_4                                = AnsiChar(#$04);
    CIV_SUB_CMD_TUNNING_STEP_5                                = AnsiChar(#$05);
    CIV_SUB_CMD_TUNNING_STEP_6                                = AnsiChar(#$06);
    CIV_SUB_CMD_TUNNING_STEP_7                                = AnsiChar(#$07);
    CIV_SUB_CMD_TUNNING_STEP_8                                = AnsiChar(#$08);
    CIV_SUB_CMD_TUNNING_STEP_9                                = AnsiChar(#$09);
    CIV_SUB_CMD_TUNNING_STEP_10                               = AnsiChar(#$10);
    CIV_SUB_CMD_TUNNING_STEP_11                               = AnsiChar(#$11);
    CIV_SUB_CMD_TUNNING_STEP_12                               = AnsiChar(#$12);
    CIV_SUB_CMD_TUNNING_STEP_13                               = AnsiChar(#$13);
  CIV_COMMAND_ATTENUATOR_STATUS                               = AnsiChar(#$11);
    // sub commands - CIV_COMMAND_ATTENUATOR_STATUS
    CIV_SUB_CMD_ATTENUATOR_OFF                                = AnsiChar(#$00);
    CIV_SUB_CMD_ATTENUATOR_3                                  = AnsiChar(#$01);   // IC-7800
    CIV_SUB_CMD_ATTENUATOR_6                                  = AnsiChar(#$02);   // IC-7800
    CIV_SUB_CMD_ATTENUATOR_9                                  = AnsiChar(#$03);   // IC-7800
    CIV_SUB_CMD_ATTENUATOR_12_1                               = AnsiChar(#$04);   // IC-7800
    CIV_SUB_CMD_ATTENUATOR_15                                 = AnsiChar(#$05);   // IC-7800
    CIV_SUB_CMD_ATTENUATOR_18_1                               = AnsiChar(#$06);   // IC-756Pro and IC-756ProII, IC-7800 18dB attenuator
    CIV_SUB_CMD_ATTENUATOR_21                                 = AnsiChar(#$07);   // IC-7800
    CIV_SUB_CMD_ATTENUATOR_10                                 = AnsiChar(#$10);
    CIV_SUB_CMD_ATTENUATOR_12_2                               = AnsiChar(#$12);   // IC-756Pro, IC-756ProII and IC-756ProIII, IC-7000
    CIV_SUB_CMD_ATTENUATOR_18_2                               = AnsiChar(#$18);   // IC-756Pro, IC-756ProII
    CIV_SUB_CMD_ATTENUATOR_20                                 = AnsiChar(#$20);
    CIV_SUB_CMD_ATTENUATOR_30                                 = AnsiChar(#$30);   // IC-R8500
  CIV_COMMAND_ANTENNA_STATUS                                  = AnsiChar(#$12);
    // sub commands - CIV_COMMAND_ANTENNA_STATUS
    CIV_SUB_CMD_SELECT_ANTENNA_1                              = AnsiChar(#$00);   // IC-R9000 -Turns antenna switch off
    CIV_SUB_CMD_SELECT_ANTENNA_2                              = AnsiChar(#$01);
    CIV_SUB_CMD_SELECT_ANTENNA_3                              = AnsiChar(#$02);   // ??? Check DF4OR notes
    CIV_SUB_CMD_SELECT_ANTENNA_4                              = AnsiChar(#$04);   // Require subcommands
      // sub commands - CIV_SUB_CMD_SELECT_ANTENNA
      CIV_SUB_CMD_SELECT_ANTENNA_RXA_OFF                      = AnsiChar(#$00);   // IC-756, IC-756Pro, IC-7800
      CIV_SUB_CMD_SELECT_ANTENNA_RXA_ON                       = AnsiChar(#$01);   // IC-756, IC-756Pro, IC-7800
  CIV_COMMAND_SPEECH                                          = AnsiChar(#$13);
  CIV_COMMAND_LEVEL_SETTINGS                                  = AnsiChar(#$14);
    // sub commands - CIV_COMMAND_LEVEL_SETTINGS
    CIV_SUB_CMD_SETTING_AF_LEVEL                              = AnsiChar(#$01);
    CIV_SUB_CMD_SETTING_RF_LEVEL                              = AnsiChar(#$02);
    CIV_SUB_CMD_SETTING_SQL_LEVEL                             = AnsiChar(#$03);
    CIV_SUB_CMD_SETTING_IF_SHIFT_LEVEL                        = AnsiChar(#$04);   // IC-R8500
    CIV_SUB_CMD_SETTING_APF_LEVEL                             = AnsiChar(#$05);   // IC-R8500, IC-7800
    CIV_SUB_CMD_SETTING_NR_LEVEL                              = AnsiChar(#$06);
    CIV_SUB_CMD_SETTING_PBT_INNER_LEVEL                       = AnsiChar(#$07);
    CIV_SUB_CMD_SETTING_PBT_OUTER_LEVEL                       = AnsiChar(#$08);
    CIV_SUB_CMD_SETTING_CW_PITCH_LEVEL                        = AnsiChar(#$09);
    CIV_SUB_CMD_SETTING_RF_POWER_LEVEL                        = AnsiChar(#$0A);
    CIV_SUB_CMD_SETTING_MIC_GAIN_LEVEL                        = AnsiChar(#$0B);
    CIV_SUB_CMD_SETTING_KEY_SPEED                             = AnsiChar(#$0C);
    CIV_SUB_CMD_SETTING_NOTCH_FREQ                            = AnsiChar(#$0D);
    CIV_SUB_CMD_SETTING_COMPRESSOR_LEVEL                      = AnsiChar(#$0E);
    CIV_SUB_CMD_SETTING_BKIN_DELAY                            = AnsiChar(#$0F);
    CIV_SUB_CMD_SETTING_BALANCE_LEVEL                         = AnsiChar(#$10);
    CIV_SUB_CMD_SETTING_AGC_LEVEL                             = AnsiChar(#$11);   // IC-7800
    CIV_SUB_CMD_SETTING_NB_LEVEL                              = AnsiChar(#$12);   // IC-756Pro, IC-7000
    CIV_SUB_CMD_SETTING_DIGISEL_LEVEL                         = AnsiChar(#$13);   // IC-7800
    CIV_SUB_CMD_SETTING_DRIVE_LEVEL                           = AnsiChar(#$14);   // IC-7800
    CIV_SUB_CMD_SETTING_MONITOR_LEVEL                         = AnsiChar(#$15);   // IC-756ProIII, IC-7000, IC-7800
    CIV_SUB_CMD_SETTING_VOX_GAIN                              = AnsiChar(#$16);   // IC-756ProIII, IC-7000, IC-7800
    CIV_SUB_CMD_SETTING_ANTIVOX_GAIN                          = AnsiChar(#$17);   // IC-756ProIII, IC-7000, IC-7800
    CIV_SUB_CMD_SETTING_LCD_CONTRAST                          = AnsiChar(#$18);   // IC-756ProIII, IC-7000, IC-7800
    CIV_SUB_CMD_SETTING_LCD_BRIGHTNESS                        = AnsiChar(#$19);   // IC-756ProIII, IC-7000, IC-7800
    CIV_SUB_CMD_SETTING_NOTCH_FILTER_2                        = AnsiChar(#$1A);   // IC-7000
  CIV_COMMAND_LEVEL_READINGS                                  = AnsiChar(#$15);
    // sub commands - CIV_COMMAND_LEVEL_READINGS
    CIV_SUB_CMD_READING_SQUELCH_STATUS                        = AnsiChar(#$01);   // IC-746, IC-756, IC-7000
    CIV_SUB_CMD_READING_SIGNAL_STRENGTH                       = AnsiChar(#$02);   // IC-746, IC-756, IC-7000
    CIV_SUB_CMD_READING_RF_POWER_OUTPUT                       = AnsiChar(#$11);   // IC-746, IC-756, IC-7000
    CIV_SUB_CMD_READING_SWR_METER                             = AnsiChar(#$12);   // IC-746, IC-756, IC-7000
    CIV_SUB_CMD_READING_ALC_METER                             = AnsiChar(#$13);   // IC-746, IC-756, IC-7000
    CIV_SUB_CMD_READING_COMPRESSOR_METER                      = AnsiChar(#$14);   // IC-756ProIII, IC-7000
    CIV_SUB_CMD_READING_VD_VALUE                              = AnsiChar(#$15);   // IC-7800
    CIV_SUB_CMD_READING_ID_VALUE                              = AnsiChar(#$16);   // IC-7800
  CIV_COMMAND_ON_OFF_SETTINGS                                 = AnsiChar(#$16);
    // sub commands - CIV_COMMAND_ON_OFF_SETTINGS
    CIV_SUB_CMD_SET_PREAMP                                    = AnsiChar(#$02);
      // sub commands - CIV_SUB_CMD_SET_PREAMP
      CIV_SUB_CMD_SET_PREAMP_OFF                              = AnsiChar(#$00);
      CIV_SUB_CMD_SET_PREAMP_1                                = AnsiChar(#$01);
      CIV_SUB_CMD_SET_PREAMP_2                                = AnsiChar(#$02);
    CIV_SUB_CMD_SET_AGC_OFF                                   = AnsiChar(#$10);  // IC-R8500 Only!
    CIV_SUB_CMD_SET_AGC_ON                                    = AnsiChar(#$11);  // IC-R8500 Only!
    CIV_SUB_CMD_SET_AGC                                       = AnsiChar(#$12);
      // sub commands - CIV_SUB_CMD_SET_PREAMP
      CIV_SUB_CMD_SET_AGC_LEVEL_OFF                           = AnsiChar(#$00);
      CIV_SUB_CMD_SET_AGC_LEVEL_FAST                          = AnsiChar(#$01);
      CIV_SUB_CMD_SET_AGC_LEVEL_MIDDLE                        = AnsiChar(#$02);
      CIV_SUB_CMD_SET_AGC_LEVEL_SLOW                          = AnsiChar(#$03);
    CIV_SUB_CMD_SET_NB_OFF                                    = AnsiChar(#$20);  // IC-R8500 Only!
    CIV_SUB_CMD_SET_NB_ON                                     = AnsiChar(#$21);  // IC-R8500 Only!
    CIV_SUB_CMD_SET_NOISE_BLANKER                             = AnsiChar(#$22);
    CIV_SUB_CMD_SET_APF_OFF                                   = AnsiChar(#$30);  // IC-R8500 Only!
    CIV_SUB_CMD_SET_APF_ON                                    = AnsiChar(#$31);  // IC-R8500 Only!
    CIV_SUB_CMD_SET_AUTOPOWEROFF                              = AnsiChar(#$32);
    CIV_SUB_CMD_SET_NOISE_REDUCTION                           = AnsiChar(#$40);
    CIV_SUB_CMD_SET_AUTO_NOTCH                                = AnsiChar(#$41);
    CIV_SUB_CMD_SET_REPEATER_TONE                             = AnsiChar(#$42);
    CIV_SUB_CMD_SET_TONE_SQL                                  = AnsiChar(#$43);
    CIV_SUB_CMD_SET_COMPRESSOR                                = AnsiChar(#$44);
    CIV_SUB_CMD_SET_MONITOR                                   = AnsiChar(#$45);
    CIV_SUB_CMD_SET_VOX_CONTROL                               = AnsiChar(#$46);
    CIV_SUB_CMD_SET_BKIN_SETTING                              = AnsiChar(#$47);
      // sub commands - CIV_SUB_CMD_SET_BKIN
      CIV_SUB_CMD_SET_BKIN_OFF                                = AnsiChar(#$00);
      CIV_SUB_CMD_SET_BKIN_SEMI                               = AnsiChar(#$01);
      CIV_SUB_CMD_SET_BKIN_FULL                               = AnsiChar(#$02);
    CIV_SUB_CMD_SET_MANUAL_NOTCH                              = AnsiChar(#$48);
    CIV_SUB_CMD_SET_RTTY_FILTER                               = AnsiChar(#$49);  // IC-756Pro
    CIV_SUB_CMD_SET_AFC                                       = AnsiChar(#$4A);  // IC-910 Only!
    CIV_SUB_CMD_SET_DTCS                                      = AnsiChar(#$4B);  // IC-746, IC-7000
    CIV_SUB_CMD_SET_VSC                                       = AnsiChar(#$4C);  // IC-746, IC-7000
    CIV_SUB_CMD_SET_MANUAL_AGC                                = AnsiChar(#$4D);  // IC-7800
    CIV_SUB_CMD_SET_DIGI_SEL                                  = AnsiChar(#$4E);  // IC-7800
    CIV_SUB_CMD_SET_TWIN_PEAK_FILTER                          = AnsiChar(#$4F);  // IC-7800, IC-756Pro3
    CIV_SUB_CMD_SET_DIAL_LOCK                                 = AnsiChar(#$50);  // IC-7800, IC-756Pro3, IC-7000
    CIV_SUB_CMD_SET_MANUAL_NOTCH_IC7K                         = AnsiChar(#$51);  // IC-7000 Only!
      // sub commands - CIV_SUB_CMD_SET
      CIV_SUB_CMD_SET_OFF                                     = AnsiChar(#$00);
      CIV_SUB_CMD_SET_ON                                      = AnsiChar(#$01);
  CIV_COMMAND_SEND_CW_STRING                                  = AnsiChar(#$17);  // IC-775DSP
  CIV_COMMAND_TURN_RECEIVER_POWER                             = AnsiChar(#$18);
      // sub commands - CIV_COMMAND_CONTROL_RECEIVER_POWER
      // CIV_SUB_CMD_POWER_OFF                                   = AnsiChar(#$00);
      // CIV_SUB_CMD_POWER_ON                                    = AnsiChar(#$01);


  CIV_COMMAND_MEMORY_CONTENTS               = AnsiChar(#$1A);
    // radio subcommands - CIV_COMMAND_MEMORY_CONTENTS subcommands
    CIV_MEMORY_READ_WRITE                   = AnsiChar(#$00);
    CIV_MEMORY_BAND_STACK_REG               = AnsiChar(#$01);
    CIV_MEMORY_KEYER                        = AnsiChar(#$02);
    CIV_MEMORY_SELECTED_FILTER              = AnsiChar(#$03);
    CIV_MEMORY_AGC_TIMER                    = AnsiChar(#$04);
    CIV_MEMORY_SETUP_VALUES                 = AnsiChar(#$05);

  // radio responses
  CIV_COMMAND_OK                            = AnsiChar(#$FB);
  CIV_COMMAND_NOT_OK                        = AnsiChar(#$FA);

  // commands with no response
  CIV_RESPONSELESS_COMMANDS                 = [CIV_COMMAND_TRANSF_OPERATING_FREQ_DATA,
                                               CIV_COMMAND_TRANSF_OPERATING_MODE_DATA];

  // packet key positions
  CIV_PACKET_POSITION_SENDER                = 03;
  CIV_PACKET_POSITION_RECEIVER              = 04;
  CIV_PACKET_POSITION_COMMAND               = 05;
  CIV_PACKET_POSITION_SUBCOMMAND            = 06;
  CIV_PACKET_POSITION_BLANK                 = 10;

  // packet blank memory position
  CIV_PACKET_MEMORY_BLANK                   = AnsiChar(#$FF);

  // DTCS Polarity
  CIV_DTCS_POLARITY_TN_RN                   = 00;
  CIV_DTCS_POLARITY_TN_RR                   = 01;
  CIV_DTCS_POLARITY_TR_RN                   = 10;
  CIV_DTCS_POLARITY_TR_RR                   = 11;

implementation

end.
