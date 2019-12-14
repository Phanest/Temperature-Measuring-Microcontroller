
_SHT_Reset:

;Project.c,60 :: 		void SHT_Reset() {
;Project.c,61 :: 		SCL = 0;                               // SCL low
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,62 :: 		SDA_Direction = 1;                     // define SDA as input
	BSF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Project.c,63 :: 		for (i2 = 1; i2 <= 18; i2++)              // repeat 18 times
	MOVLW      1
	MOVWF      _i2+0
L_SHT_Reset0:
	MOVF       _i2+0, 0
	SUBLW      18
	BTFSS      STATUS+0, 0
	GOTO       L_SHT_Reset1
;Project.c,64 :: 		SCL = ~SCL;                          // invert SCL
	MOVLW
	XORWF      RC3_bit+0, 1
;Project.c,63 :: 		for (i2 = 1; i2 <= 18; i2++)              // repeat 18 times
	INCF       _i2+0, 1
;Project.c,64 :: 		SCL = ~SCL;                          // invert SCL
	GOTO       L_SHT_Reset0
L_SHT_Reset1:
;Project.c,65 :: 		}
L_end_SHT_Reset:
	RETURN
; end of _SHT_Reset

_Transmission_Start:

;Project.c,67 :: 		void Transmission_Start() {
;Project.c,68 :: 		SDA_Direction = 1;                     // define SDA as input
	BSF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Project.c,69 :: 		SCL = 1;                               // SCL high
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,70 :: 		Delay_1us();                           // 1us delay
	CALL       _Delay_1us+0
;Project.c,71 :: 		SDA_Direction = 0;                     // define SDA as output
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Project.c,72 :: 		SDA = 0;                               // SDA low
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;Project.c,73 :: 		Delay_1us();                           // 1us delay
	CALL       _Delay_1us+0
;Project.c,74 :: 		SCL = 0;                               // SCL low
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,75 :: 		Delay_1us();                           // 1us delay
	CALL       _Delay_1us+0
;Project.c,76 :: 		SCL = 1;                               // SCL high
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,77 :: 		Delay_1us();                           // 1us delay
	CALL       _Delay_1us+0
;Project.c,78 :: 		SDA_Direction = 1;                     // define SDA as input
	BSF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Project.c,79 :: 		Delay_1us();                           // 1us delay
	CALL       _Delay_1us+0
;Project.c,80 :: 		SCL = 0;                               // SCL low
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,81 :: 		}
L_end_Transmission_Start:
	RETURN
; end of _Transmission_Start

_MCU_ACK:

;Project.c,84 :: 		void MCU_ACK() {
;Project.c,85 :: 		SDA_Direction = 0;     // define SDA as output
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Project.c,86 :: 		SDA = 0;               // SDA low
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;Project.c,87 :: 		SCL = 1;               // SCL high
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,88 :: 		Delay_1us();           // 1us delay
	CALL       _Delay_1us+0
;Project.c,89 :: 		SCL = 0;               // SCL low
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,90 :: 		Delay_1us();           // 1us delay
	CALL       _Delay_1us+0
;Project.c,91 :: 		SDA_Direction = 1;     // define SDA as input
	BSF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Project.c,92 :: 		}
L_end_MCU_ACK:
	RETURN
; end of _MCU_ACK

_Measure:

;Project.c,95 :: 		long int Measure(short num) {
;Project.c,98 :: 		j2 = num;                           // j2 = command (0x03 or 0x05)
	MOVF       FARG_Measure_num+0, 0
	MOVWF      _j2+0
;Project.c,99 :: 		SHT_Reset();                       // procedure for reseting SHT11
	CALL       _SHT_Reset+0
;Project.c,100 :: 		Transmission_Start();              // procedure for starting transmission
	CALL       _Transmission_Start+0
;Project.c,101 :: 		k = 0;                             // k = 0
	CLRF       _k+0
	CLRF       _k+1
	CLRF       _k+2
	CLRF       _k+3
;Project.c,102 :: 		SDA_Direction = 0;                 // define SDA as output
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Project.c,103 :: 		SCL = 0;                           // SCL low
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,104 :: 		for(i2 = 1; i2 <= 8; i2++) {          // repeat 8 times
	MOVLW      1
	MOVWF      _i2+0
L_Measure3:
	MOVF       _i2+0, 0
	SUBLW      8
	BTFSS      STATUS+0, 0
	GOTO       L_Measure4
;Project.c,105 :: 		if (j2.F7 == 1)                   // if bit 7 = 1
	BTFSS      _j2+0, 7
	GOTO       L_Measure6
;Project.c,106 :: 		SDA_Direction = 1;              // define SDA as input
	BSF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
	GOTO       L_Measure7
L_Measure6:
;Project.c,108 :: 		SDA_Direction = 0;              // define SDA as output
	BCF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Project.c,109 :: 		SDA = 0;                        // SDA low
	BCF        RC4_bit+0, BitPos(RC4_bit+0)
;Project.c,110 :: 		}
L_Measure7:
;Project.c,111 :: 		Delay_1us();                     // 1us delay
	CALL       _Delay_1us+0
;Project.c,112 :: 		SCL = 1;                         // SCL high
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,113 :: 		Delay_1us();                     // 1us delay
	CALL       _Delay_1us+0
;Project.c,114 :: 		SCL = 0;                         // SCL low
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,115 :: 		j2 <<= 1;                         // move contents of j2 one place left
	RLF        _j2+0, 1
	BCF        _j2+0, 0
;Project.c,104 :: 		for(i2 = 1; i2 <= 8; i2++) {          // repeat 8 times
	INCF       _i2+0, 1
;Project.c,116 :: 		}
	GOTO       L_Measure3
L_Measure4:
;Project.c,118 :: 		SDA_Direction = 1;                 // define SDA as input
	BSF        TRISC4_bit+0, BitPos(TRISC4_bit+0)
;Project.c,119 :: 		SCL = 1;                           // SCL high
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,120 :: 		Delay_1us();                       // 1us delay
	CALL       _Delay_1us+0
;Project.c,121 :: 		SCL = 0;                           // SCL low
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,122 :: 		Delay_1us();                       // 1us delay
	CALL       _Delay_1us+0
;Project.c,123 :: 		while (SDA == 1)                   // while SDA is high, do nothing
L_Measure8:
	BTFSS      RC4_bit+0, BitPos(RC4_bit+0)
	GOTO       L_Measure9
;Project.c,124 :: 		Delay_1us();                     // 1us delay
	CALL       _Delay_1us+0
	GOTO       L_Measure8
L_Measure9:
;Project.c,126 :: 		for (i2 = 1; i2 <=16; i2++) {         // repeat 16 times
	MOVLW      1
	MOVWF      _i2+0
L_Measure10:
	MOVF       _i2+0, 0
	SUBLW      16
	BTFSS      STATUS+0, 0
	GOTO       L_Measure11
;Project.c,127 :: 		k <<= 1;                         // move contents of k one place left
	RLF        _k+0, 1
	RLF        _k+1, 1
	RLF        _k+2, 1
	RLF        _k+3, 1
	BCF        _k+0, 0
;Project.c,128 :: 		SCL = 1;                         // SCL high
	BSF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,129 :: 		if (SDA == 1)                    // if SDA is high
	BTFSS      RC4_bit+0, BitPos(RC4_bit+0)
	GOTO       L_Measure13
;Project.c,130 :: 		k = k | 0x0001;
	BSF        _k+0, 0
L_Measure13:
;Project.c,131 :: 		SCL = 0;
	BCF        RC3_bit+0, BitPos(RC3_bit+0)
;Project.c,132 :: 		if (i2 == 8)                      // if counter i2 = 8 then
	MOVF       _i2+0, 0
	XORLW      8
	BTFSS      STATUS+0, 2
	GOTO       L_Measure14
;Project.c,133 :: 		MCU_ACK();                     // MCU acknowledge
	CALL       _MCU_ACK+0
L_Measure14:
;Project.c,126 :: 		for (i2 = 1; i2 <=16; i2++) {         // repeat 16 times
	INCF       _i2+0, 1
;Project.c,134 :: 		}
	GOTO       L_Measure10
L_Measure11:
;Project.c,136 :: 		SOt = k;
	MOVF       _k+0, 0
	MOVWF      _SOt+0
	MOVF       _k+1, 0
	MOVWF      _SOt+1
	MOVF       _k+2, 0
	MOVWF      _SOt+2
	MOVF       _k+3, 0
	MOVWF      _SOt+3
;Project.c,138 :: 		if(SOt > D1)                     // if temperature is positive
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _k+3, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Measure183
	MOVF       _k+2, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Measure183
	MOVF       _k+1, 0
	SUBLW      15
	BTFSS      STATUS+0, 2
	GOTO       L__Measure183
	MOVF       _k+0, 0
	SUBLW      160
L__Measure183:
	BTFSC      STATUS+0, 0
	GOTO       L_Measure15
;Project.c,139 :: 		Ta_res = SOt * D2 - D1;        // calculate temperature
	MOVLW      160
	MOVWF      R0+0
	MOVLW      15
	MOVWF      R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVF       _SOt+0, 0
	MOVWF      _Ta_res+0
	MOVF       _SOt+1, 0
	MOVWF      _Ta_res+1
	MOVF       _SOt+2, 0
	MOVWF      _Ta_res+2
	MOVF       _SOt+3, 0
	MOVWF      _Ta_res+3
	MOVF       R0+0, 0
	SUBWF      _Ta_res+0, 1
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+1, 0
	SUBWF      _Ta_res+1, 1
	MOVF       R0+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+2, 0
	SUBWF      _Ta_res+2, 1
	MOVF       R0+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+3, 0
	SUBWF      _Ta_res+3, 1
	GOTO       L_Measure16
L_Measure15:
;Project.c,141 :: 		Ta_res = D1 - SOt * D2;        // calculate temperature
	MOVLW      160
	MOVWF      R4+0
	MOVLW      15
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _SOt+0, 0
	MOVWF      R0+0
	MOVF       _SOt+1, 0
	MOVWF      R0+1
	MOVF       _SOt+2, 0
	MOVWF      R0+2
	MOVF       _SOt+3, 0
	MOVWF      R0+3
	MOVF       R4+0, 0
	MOVWF      _Ta_res+0
	MOVF       R4+1, 0
	MOVWF      _Ta_res+1
	MOVF       R4+2, 0
	MOVWF      _Ta_res+2
	MOVF       R4+3, 0
	MOVWF      _Ta_res+3
	MOVF       R0+0, 0
	SUBWF      _Ta_res+0, 1
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+1, 0
	SUBWF      _Ta_res+1, 1
	MOVF       R0+2, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+2, 0
	SUBWF      _Ta_res+2, 1
	MOVF       R0+3, 0
	BTFSS      STATUS+0, 0
	INCFSZ     R0+3, 0
	SUBWF      _Ta_res+3, 1
L_Measure16:
;Project.c,143 :: 		temperature = (int) floor( Ta_res );
	MOVF       _Ta_res+0, 0
	MOVWF      R0+0
	MOVF       _Ta_res+1, 0
	MOVWF      R0+1
	MOVF       _Ta_res+2, 0
	MOVWF      R0+2
	MOVF       _Ta_res+3, 0
	MOVWF      R0+3
	CALL       _longint2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_floor_x+0
	MOVF       R0+1, 0
	MOVWF      FARG_floor_x+1
	MOVF       R0+2, 0
	MOVWF      FARG_floor_x+2
	MOVF       R0+3, 0
	MOVWF      FARG_floor_x+3
	CALL       _floor+0
	CALL       _double2int+0
;Project.c,145 :: 		return temperature/100;
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVLW      0
	BTFSC      R0+1, 7
	MOVLW      255
	MOVWF      R0+2
	MOVWF      R0+3
;Project.c,147 :: 		}
L_end_Measure:
	RETURN
; end of _Measure

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Project.c,149 :: 		void interrupt()
;Project.c,152 :: 		count++;
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
;Project.c,153 :: 		TMR0 = 0;
	CLRF       TMR0+0
;Project.c,154 :: 		INTCON = 0XA0;
	MOVLW      160
	MOVWF      INTCON+0
;Project.c,156 :: 		}
L_end_interrupt:
L__interrupt185:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_Render_C:

;Project.c,160 :: 		void Render_C(int x, int y, int colour)
;Project.c,162 :: 		int i = 0;
	CLRF       Render_C_i_L0+0
	CLRF       Render_C_i_L0+1
;Project.c,164 :: 		for(i = 0; i<5; i++)
	CLRF       Render_C_i_L0+0
	CLRF       Render_C_i_L0+1
L_Render_C17:
	MOVLW      128
	XORWF      Render_C_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_C187
	MOVLW      5
	SUBWF      Render_C_i_L0+0, 0
L__Render_C187:
	BTFSC      STATUS+0, 0
	GOTO       L_Render_C18
;Project.c,165 :: 		Glcd_Dot( x, y+i, colour);
	MOVF       FARG_Render_C_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       Render_C_i_L0+0, 0
	ADDWF      FARG_Render_C_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Render_C_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,164 :: 		for(i = 0; i<5; i++)
	INCF       Render_C_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Render_C_i_L0+1, 1
;Project.c,165 :: 		Glcd_Dot( x, y+i, colour);
	GOTO       L_Render_C17
L_Render_C18:
;Project.c,167 :: 		Glcd_Dot( x+1, y, colour);
	INCF       FARG_Render_C_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Render_C_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Render_C_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,168 :: 		Glcd_Dot( x+2, y, colour);
	MOVLW      2
	ADDWF      FARG_Render_C_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Render_C_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Render_C_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,170 :: 		Glcd_Dot( x+1, y+4, colour);
	INCF       FARG_Render_C_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      4
	ADDWF      FARG_Render_C_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Render_C_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,171 :: 		Glcd_Dot( x+2, y+4, colour);
	MOVLW      2
	ADDWF      FARG_Render_C_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      4
	ADDWF      FARG_Render_C_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Render_C_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,173 :: 		}
L_end_Render_C:
	RETURN
; end of _Render_C

_Render_Minus:

;Project.c,175 :: 		void Render_Minus(int x, int y, int colour)
;Project.c,178 :: 		Glcd_Dot( x, y, colour);
	MOVF       FARG_Render_Minus_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Render_Minus_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Render_Minus_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,179 :: 		Glcd_Dot( x+1, y, colour);
	INCF       FARG_Render_Minus_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Render_Minus_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Render_Minus_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,180 :: 		Glcd_Dot( x+2, y, colour);
	MOVLW      2
	ADDWF      FARG_Render_Minus_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Render_Minus_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Render_Minus_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,182 :: 		}
L_end_Render_Minus:
	RETURN
; end of _Render_Minus

_Number:

;Project.c,184 :: 		void Number(int num, int x, int y, int colour)
;Project.c,186 :: 		int i = 0;
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
;Project.c,188 :: 		if( num == 0)
	MOVLW      0
	XORWF      FARG_Number_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number190
	MOVLW      0
	XORWF      FARG_Number_num+0, 0
L__Number190:
	BTFSS      STATUS+0, 2
	GOTO       L_Number20
;Project.c,190 :: 		for(i = 0; i < 3; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number21:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number191
	MOVLW      3
	SUBWF      Number_i_L0+0, 0
L__Number191:
	BTFSC      STATUS+0, 0
	GOTO       L_Number22
;Project.c,192 :: 		Glcd_Dot( x + i, y, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,194 :: 		Glcd_Dot( x + i, y + 4, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      4
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,190 :: 		for(i = 0; i < 3; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,195 :: 		}
	GOTO       L_Number21
L_Number22:
;Project.c,197 :: 		for(i = 1; i < 4; i++)
	MOVLW      1
	MOVWF      Number_i_L0+0
	MOVLW      0
	MOVWF      Number_i_L0+1
L_Number24:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number192
	MOVLW      4
	SUBWF      Number_i_L0+0, 0
L__Number192:
	BTFSC      STATUS+0, 0
	GOTO       L_Number25
;Project.c,199 :: 		Glcd_Dot( x, y + i, colour);
	MOVF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,201 :: 		Glcd_Dot( x + 2, y + i, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,197 :: 		for(i = 1; i < 4; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,203 :: 		}
	GOTO       L_Number24
L_Number25:
;Project.c,204 :: 		}
	GOTO       L_Number27
L_Number20:
;Project.c,205 :: 		else if( num == 1)
	MOVLW      0
	XORWF      FARG_Number_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number193
	MOVLW      1
	XORWF      FARG_Number_num+0, 0
L__Number193:
	BTFSS      STATUS+0, 2
	GOTO       L_Number28
;Project.c,208 :: 		Glcd_Dot( x, y+1, colour);
	MOVF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	INCF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,210 :: 		Glcd_Dot( x+1, y, colour);
	INCF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,212 :: 		for( i = 0; i < 5; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number29:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number194
	MOVLW      5
	SUBWF      Number_i_L0+0, 0
L__Number194:
	BTFSC      STATUS+0, 0
	GOTO       L_Number30
;Project.c,213 :: 		Glcd_Dot( x+2, y+i, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,212 :: 		for( i = 0; i < 5; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,213 :: 		Glcd_Dot( x+2, y+i, colour);
	GOTO       L_Number29
L_Number30:
;Project.c,216 :: 		}
	GOTO       L_Number32
L_Number28:
;Project.c,217 :: 		else if( num == 2)
	MOVLW      0
	XORWF      FARG_Number_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number195
	MOVLW      2
	XORWF      FARG_Number_num+0, 0
L__Number195:
	BTFSS      STATUS+0, 2
	GOTO       L_Number33
;Project.c,219 :: 		for( i = 0; i < 3; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number34:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number196
	MOVLW      3
	SUBWF      Number_i_L0+0, 0
L__Number196:
	BTFSC      STATUS+0, 0
	GOTO       L_Number35
;Project.c,220 :: 		Glcd_Dot( x+i, y, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,219 :: 		for( i = 0; i < 3; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,220 :: 		Glcd_Dot( x+i, y, colour);
	GOTO       L_Number34
L_Number35:
;Project.c,222 :: 		for( i = 0; i < 3; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number37:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number197
	MOVLW      3
	SUBWF      Number_i_L0+0, 0
L__Number197:
	BTFSC      STATUS+0, 0
	GOTO       L_Number38
;Project.c,223 :: 		Glcd_Dot( x+2-i, y+1+i, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       Number_i_L0+0, 0
	SUBWF      FARG_Glcd_Dot_x_pos+0, 1
	INCF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Glcd_Dot_y_pos+0, 1
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,222 :: 		for( i = 0; i < 3; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,223 :: 		Glcd_Dot( x+2-i, y+1+i, colour);
	GOTO       L_Number37
L_Number38:
;Project.c,225 :: 		for( i = 0; i < 3; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number40:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number198
	MOVLW      3
	SUBWF      Number_i_L0+0, 0
L__Number198:
	BTFSC      STATUS+0, 0
	GOTO       L_Number41
;Project.c,226 :: 		Glcd_Dot( x+i, y+4, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      4
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,225 :: 		for( i = 0; i < 3; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,226 :: 		Glcd_Dot( x+i, y+4, colour);
	GOTO       L_Number40
L_Number41:
;Project.c,228 :: 		}
	GOTO       L_Number43
L_Number33:
;Project.c,229 :: 		else if( num == 3)
	MOVLW      0
	XORWF      FARG_Number_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number199
	MOVLW      3
	XORWF      FARG_Number_num+0, 0
L__Number199:
	BTFSS      STATUS+0, 2
	GOTO       L_Number44
;Project.c,232 :: 		for(i = 0; i < 5; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number45:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number200
	MOVLW      5
	SUBWF      Number_i_L0+0, 0
L__Number200:
	BTFSC      STATUS+0, 0
	GOTO       L_Number46
;Project.c,233 :: 		Glcd_Dot( x+2, y+i, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,232 :: 		for(i = 0; i < 5; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,233 :: 		Glcd_Dot( x+2, y+i, colour);
	GOTO       L_Number45
L_Number46:
;Project.c,235 :: 		for(i = 0; i<2; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number48:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number201
	MOVLW      2
	SUBWF      Number_i_L0+0, 0
L__Number201:
	BTFSC      STATUS+0, 0
	GOTO       L_Number49
;Project.c,237 :: 		Glcd_Dot( x+i, y, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,239 :: 		Glcd_Dot( x+i, y+2, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      2
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,241 :: 		Glcd_Dot( x+i, y+4, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      4
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,235 :: 		for(i = 0; i<2; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,243 :: 		}
	GOTO       L_Number48
L_Number49:
;Project.c,245 :: 		}
	GOTO       L_Number51
L_Number44:
;Project.c,246 :: 		else if( num == 4)
	MOVLW      0
	XORWF      FARG_Number_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number202
	MOVLW      4
	XORWF      FARG_Number_num+0, 0
L__Number202:
	BTFSS      STATUS+0, 2
	GOTO       L_Number52
;Project.c,249 :: 		for(i = 0; i < 2; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number53:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number203
	MOVLW      2
	SUBWF      Number_i_L0+0, 0
L__Number203:
	BTFSC      STATUS+0, 0
	GOTO       L_Number54
;Project.c,251 :: 		Glcd_Dot( x, y+i, colour);
	MOVF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,253 :: 		Glcd_Dot( x+2, y+1+i, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	INCF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Glcd_Dot_y_pos+0, 1
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,255 :: 		Glcd_Dot( x+i, y+2, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      2
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,249 :: 		for(i = 0; i < 2; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,258 :: 		}
	GOTO       L_Number53
L_Number54:
;Project.c,260 :: 		Glcd_Dot( x+2, y+3, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      3
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,262 :: 		Glcd_Dot( x+2, y+4, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      4
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,264 :: 		}
	GOTO       L_Number56
L_Number52:
;Project.c,265 :: 		else if( num == 5)
	MOVLW      0
	XORWF      FARG_Number_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number204
	MOVLW      5
	XORWF      FARG_Number_num+0, 0
L__Number204:
	BTFSS      STATUS+0, 2
	GOTO       L_Number57
;Project.c,267 :: 		for(i = 0; i < 3; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number58:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number205
	MOVLW      3
	SUBWF      Number_i_L0+0, 0
L__Number205:
	BTFSC      STATUS+0, 0
	GOTO       L_Number59
;Project.c,269 :: 		Glcd_Dot( x+i, y, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,271 :: 		Glcd_Dot( x+i, y+4, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      4
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,273 :: 		Glcd_Dot( x+i, y+2, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      2
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,267 :: 		for(i = 0; i < 3; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,275 :: 		}
	GOTO       L_Number58
L_Number59:
;Project.c,277 :: 		Glcd_Dot( x, y+1, colour);
	MOVF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	INCF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,279 :: 		Glcd_Dot( x+2, y+3, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      3
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,281 :: 		}
	GOTO       L_Number61
L_Number57:
;Project.c,282 :: 		else if( num == 6)
	MOVLW      0
	XORWF      FARG_Number_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number206
	MOVLW      6
	XORWF      FARG_Number_num+0, 0
L__Number206:
	BTFSS      STATUS+0, 2
	GOTO       L_Number62
;Project.c,284 :: 		for(i = 0; i < 5; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number63:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number207
	MOVLW      5
	SUBWF      Number_i_L0+0, 0
L__Number207:
	BTFSC      STATUS+0, 0
	GOTO       L_Number64
;Project.c,285 :: 		Glcd_Dot( x, y+i, colour);
	MOVF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,284 :: 		for(i = 0; i < 5; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,285 :: 		Glcd_Dot( x, y+i, colour);
	GOTO       L_Number63
L_Number64:
;Project.c,287 :: 		for(i = 0; i < 3; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number66:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number208
	MOVLW      3
	SUBWF      Number_i_L0+0, 0
L__Number208:
	BTFSC      STATUS+0, 0
	GOTO       L_Number67
;Project.c,288 :: 		Glcd_Dot( x+2, y+2+i, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      2
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Glcd_Dot_y_pos+0, 1
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,287 :: 		for(i = 0; i < 3; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,288 :: 		Glcd_Dot( x+2, y+2+i, colour);
	GOTO       L_Number66
L_Number67:
;Project.c,290 :: 		Glcd_Dot( x+1, y+2, colour);
	INCF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      2
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,292 :: 		Glcd_Dot( x+1, y+4, colour);
	INCF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      4
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,294 :: 		}
	GOTO       L_Number69
L_Number62:
;Project.c,295 :: 		else if( num == 7)
	MOVLW      0
	XORWF      FARG_Number_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number209
	MOVLW      7
	XORWF      FARG_Number_num+0, 0
L__Number209:
	BTFSS      STATUS+0, 2
	GOTO       L_Number70
;Project.c,297 :: 		Glcd_Dot( x, y, colour);
	MOVF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,299 :: 		Glcd_Dot( x+1, y, colour);
	INCF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,301 :: 		for(i = 0; i < 5; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number71:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number210
	MOVLW      5
	SUBWF      Number_i_L0+0, 0
L__Number210:
	BTFSC      STATUS+0, 0
	GOTO       L_Number72
;Project.c,302 :: 		Glcd_Dot( x+2, y+i, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,301 :: 		for(i = 0; i < 5; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,302 :: 		Glcd_Dot( x+2, y+i, colour);
	GOTO       L_Number71
L_Number72:
;Project.c,304 :: 		}
	GOTO       L_Number74
L_Number70:
;Project.c,305 :: 		else if( num == 8)
	MOVLW      0
	XORWF      FARG_Number_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number211
	MOVLW      8
	XORWF      FARG_Number_num+0, 0
L__Number211:
	BTFSS      STATUS+0, 2
	GOTO       L_Number75
;Project.c,307 :: 		for(i = 0; i<3; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number76:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number212
	MOVLW      3
	SUBWF      Number_i_L0+0, 0
L__Number212:
	BTFSC      STATUS+0, 0
	GOTO       L_Number77
;Project.c,309 :: 		Glcd_Dot( x+i, y, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,311 :: 		Glcd_Dot( x+i, y+2, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      2
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,313 :: 		Glcd_Dot( x+i, y+4, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      4
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,307 :: 		for(i = 0; i<3; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,315 :: 		}
	GOTO       L_Number76
L_Number77:
;Project.c,317 :: 		Glcd_Dot( x, y+1, colour);
	MOVF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	INCF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,318 :: 		Glcd_Dot( x, y+3, colour);
	MOVF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      3
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,320 :: 		Glcd_Dot( x+2, y+1, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	INCF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,321 :: 		Glcd_Dot( x+2, y+3, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      3
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,323 :: 		}
	GOTO       L_Number79
L_Number75:
;Project.c,324 :: 		else if( num == 9)
	MOVLW      0
	XORWF      FARG_Number_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number213
	MOVLW      9
	XORWF      FARG_Number_num+0, 0
L__Number213:
	BTFSS      STATUS+0, 2
	GOTO       L_Number80
;Project.c,327 :: 		for(i = 0; i < 3; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number81:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number214
	MOVLW      3
	SUBWF      Number_i_L0+0, 0
L__Number214:
	BTFSC      STATUS+0, 0
	GOTO       L_Number82
;Project.c,329 :: 		Glcd_Dot( x+i, y, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,331 :: 		Glcd_Dot( x+i, y+2, colour);
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      2
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,327 :: 		for(i = 0; i < 3; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,333 :: 		}
	GOTO       L_Number81
L_Number82:
;Project.c,335 :: 		Glcd_Dot( x, y+1, colour);
	MOVF       FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	INCF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,337 :: 		Glcd_Dot( x+2, y+1, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	INCF       FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,339 :: 		for( i = 0; i<2; i++)
	CLRF       Number_i_L0+0
	CLRF       Number_i_L0+1
L_Number84:
	MOVLW      128
	XORWF      Number_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Number215
	MOVLW      2
	SUBWF      Number_i_L0+0, 0
L__Number215:
	BTFSC      STATUS+0, 0
	GOTO       L_Number85
;Project.c,340 :: 		Glcd_Dot( x+2, y+3+i, colour);
	MOVLW      2
	ADDWF      FARG_Number_x+0, 0
	MOVWF      FARG_Glcd_Dot_x_pos+0
	MOVLW      3
	ADDWF      FARG_Number_y+0, 0
	MOVWF      FARG_Glcd_Dot_y_pos+0
	MOVF       Number_i_L0+0, 0
	ADDWF      FARG_Glcd_Dot_y_pos+0, 1
	MOVF       FARG_Number_colour+0, 0
	MOVWF      FARG_Glcd_Dot_color+0
	CALL       _Glcd_Dot+0
;Project.c,339 :: 		for( i = 0; i<2; i++)
	INCF       Number_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       Number_i_L0+1, 1
;Project.c,340 :: 		Glcd_Dot( x+2, y+3+i, colour);
	GOTO       L_Number84
L_Number85:
;Project.c,342 :: 		}
L_Number80:
L_Number79:
L_Number74:
L_Number69:
L_Number61:
L_Number56:
L_Number51:
L_Number43:
L_Number32:
L_Number27:
;Project.c,344 :: 		}
L_end_Number:
	RETURN
; end of _Number

_reverse:

;Project.c,346 :: 		int reverse( int number)
;Project.c,349 :: 		int sum = 0;
	CLRF       reverse_sum_L0+0
	CLRF       reverse_sum_L0+1
;Project.c,351 :: 		while(number != 0)
L_reverse87:
	MOVLW      0
	XORWF      FARG_reverse_number+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__reverse217
	MOVLW      0
	XORWF      FARG_reverse_number+0, 0
L__reverse217:
	BTFSC      STATUS+0, 2
	GOTO       L_reverse88
;Project.c,353 :: 		sum *= 10;
	MOVF       reverse_sum_L0+0, 0
	MOVWF      R0+0
	MOVF       reverse_sum_L0+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__reverse+0
	MOVF       R0+1, 0
	MOVWF      FLOC__reverse+1
	MOVF       FLOC__reverse+0, 0
	MOVWF      reverse_sum_L0+0
	MOVF       FLOC__reverse+1, 0
	MOVWF      reverse_sum_L0+1
;Project.c,355 :: 		sum += number%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_reverse_number+0, 0
	MOVWF      R0+0
	MOVF       FARG_reverse_number+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      FLOC__reverse+0, 0
	MOVWF      reverse_sum_L0+0
	MOVF       FLOC__reverse+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      reverse_sum_L0+1
;Project.c,357 :: 		number = number/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_reverse_number+0, 0
	MOVWF      R0+0
	MOVF       FARG_reverse_number+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_reverse_number+0
	MOVF       R0+1, 0
	MOVWF      FARG_reverse_number+1
;Project.c,359 :: 		}
	GOTO       L_reverse87
L_reverse88:
;Project.c,361 :: 		return sum;
	MOVF       reverse_sum_L0+0, 0
	MOVWF      R0+0
	MOVF       reverse_sum_L0+1, 0
	MOVWF      R0+1
;Project.c,363 :: 		}
L_end_reverse:
	RETURN
; end of _reverse

_PrintNumber:

;Project.c,365 :: 		void PrintNumber( int x, int y, int number, int colour)
;Project.c,367 :: 		if(number > 9)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_PrintNumber_number+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__PrintNumber219
	MOVF       FARG_PrintNumber_number+0, 0
	SUBLW      9
L__PrintNumber219:
	BTFSC      STATUS+0, 0
	GOTO       L_PrintNumber89
;Project.c,369 :: 		Number( number % 10, x-3, y, colour);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_PrintNumber_number+0, 0
	MOVWF      R0+0
	MOVF       FARG_PrintNumber_number+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_Number_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_Number_num+1
	MOVLW      3
	SUBWF      FARG_PrintNumber_x+0, 0
	MOVWF      FARG_Number_x+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FARG_PrintNumber_x+1, 0
	MOVWF      FARG_Number_x+1
	MOVF       FARG_PrintNumber_y+0, 0
	MOVWF      FARG_Number_y+0
	MOVF       FARG_PrintNumber_y+1, 0
	MOVWF      FARG_Number_y+1
	MOVF       FARG_PrintNumber_colour+0, 0
	MOVWF      FARG_Number_colour+0
	MOVF       FARG_PrintNumber_colour+1, 0
	MOVWF      FARG_Number_colour+1
	CALL       _Number+0
;Project.c,371 :: 		number /= 10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_PrintNumber_number+0, 0
	MOVWF      R0+0
	MOVF       FARG_PrintNumber_number+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_PrintNumber_number+0
	MOVF       R0+1, 0
	MOVWF      FARG_PrintNumber_number+1
;Project.c,373 :: 		Number( Number % 10, x+1, y, colour);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_Number_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_Number_num+1
	MOVF       FARG_PrintNumber_x+0, 0
	ADDLW      1
	MOVWF      FARG_Number_x+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      FARG_PrintNumber_x+1, 0
	MOVWF      FARG_Number_x+1
	MOVF       FARG_PrintNumber_y+0, 0
	MOVWF      FARG_Number_y+0
	MOVF       FARG_PrintNumber_y+1, 0
	MOVWF      FARG_Number_y+1
	MOVF       FARG_PrintNumber_colour+0, 0
	MOVWF      FARG_Number_colour+0
	MOVF       FARG_PrintNumber_colour+1, 0
	MOVWF      FARG_Number_colour+1
	CALL       _Number+0
;Project.c,375 :: 		}
	GOTO       L_PrintNumber90
L_PrintNumber89:
;Project.c,379 :: 		Number( number % 10, x, y, colour);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_PrintNumber_number+0, 0
	MOVWF      R0+0
	MOVF       FARG_PrintNumber_number+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_Number_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_Number_num+1
	MOVF       FARG_PrintNumber_x+0, 0
	MOVWF      FARG_Number_x+0
	MOVF       FARG_PrintNumber_x+1, 0
	MOVWF      FARG_Number_x+1
	MOVF       FARG_PrintNumber_y+0, 0
	MOVWF      FARG_Number_y+0
	MOVF       FARG_PrintNumber_y+1, 0
	MOVWF      FARG_Number_y+1
	MOVF       FARG_PrintNumber_colour+0, 0
	MOVWF      FARG_Number_colour+0
	MOVF       FARG_PrintNumber_colour+1, 0
	MOVWF      FARG_Number_colour+1
	CALL       _Number+0
;Project.c,381 :: 		}
L_PrintNumber90:
;Project.c,383 :: 		}
L_end_PrintNumber:
	RETURN
; end of _PrintNumber

_PrintHours:

;Project.c,385 :: 		void PrintHours( int start, int end, int colour)
;Project.c,387 :: 		int i = 0;
	CLRF       PrintHours_i_L0+0
	CLRF       PrintHours_i_L0+1
	CLRF       PrintHours_origin_L0+0
	CLRF       PrintHours_origin_L0+1
	MOVLW      11
	MOVWF      PrintHours_move_L0+0
	MOVLW      0
	MOVWF      PrintHours_move_L0+1
	CLRF       PrintHours_num_L0+0
	CLRF       PrintHours_num_L0+1
;Project.c,395 :: 		for( i = start; i<=end; i++)
	MOVF       FARG_PrintHours_start+0, 0
	MOVWF      PrintHours_i_L0+0
	MOVF       FARG_PrintHours_start+1, 0
	MOVWF      PrintHours_i_L0+1
L_PrintHours91:
	MOVLW      128
	XORWF      FARG_PrintHours_end+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      PrintHours_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__PrintHours221
	MOVF       PrintHours_i_L0+0, 0
	SUBWF      FARG_PrintHours_end+0, 0
L__PrintHours221:
	BTFSS      STATUS+0, 0
	GOTO       L_PrintHours92
;Project.c,398 :: 		if(i >= 10)
	MOVLW      128
	XORWF      PrintHours_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__PrintHours222
	MOVLW      10
	SUBWF      PrintHours_i_L0+0, 0
L__PrintHours222:
	BTFSS      STATUS+0, 0
	GOTO       L_PrintHours94
;Project.c,399 :: 		num = reverse( i*10 + 1 );
	MOVF       PrintHours_i_L0+0, 0
	MOVWF      R0+0
	MOVF       PrintHours_i_L0+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	ADDLW      1
	MOVWF      FARG_reverse_number+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_reverse_number+1
	CALL       _reverse+0
	MOVF       R0+0, 0
	MOVWF      PrintHours_num_L0+0
	MOVF       R0+1, 0
	MOVWF      PrintHours_num_L0+1
	GOTO       L_PrintHours95
L_PrintHours94:
;Project.c,401 :: 		num = reverse( i );
	MOVF       PrintHours_i_L0+0, 0
	MOVWF      FARG_reverse_number+0
	MOVF       PrintHours_i_L0+1, 0
	MOVWF      FARG_reverse_number+1
	CALL       _reverse+0
	MOVF       R0+0, 0
	MOVWF      PrintHours_num_L0+0
	MOVF       R0+1, 0
	MOVWF      PrintHours_num_L0+1
L_PrintHours95:
;Project.c,403 :: 		PrintNumber( (int) (origin + move)/2 , 47, num, 2);
	MOVF       PrintHours_move_L0+0, 0
	ADDWF      PrintHours_origin_L0+0, 0
	MOVWF      FARG_PrintNumber_x+0
	MOVF       PrintHours_origin_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      PrintHours_move_L0+1, 0
	MOVWF      FARG_PrintNumber_x+1
	RRF        FARG_PrintNumber_x+1, 1
	RRF        FARG_PrintNumber_x+0, 1
	BCF        FARG_PrintNumber_x+1, 7
	BTFSC      FARG_PrintNumber_x+1, 6
	BSF        FARG_PrintNumber_x+1, 7
	MOVLW      47
	MOVWF      FARG_PrintNumber_y+0
	MOVLW      0
	MOVWF      FARG_PrintNumber_y+1
	MOVF       PrintHours_num_L0+0, 0
	MOVWF      FARG_PrintNumber_number+0
	MOVF       PrintHours_num_L0+1, 0
	MOVWF      FARG_PrintNumber_number+1
	MOVLW      2
	MOVWF      FARG_PrintNumber_colour+0
	MOVLW      0
	MOVWF      FARG_PrintNumber_colour+1
	CALL       _PrintNumber+0
;Project.c,405 :: 		origin = move + 2;
	MOVLW      2
	ADDWF      PrintHours_move_L0+0, 0
	MOVWF      R0+0
	MOVF       PrintHours_move_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      PrintHours_origin_L0+0
	MOVF       R0+1, 0
	MOVWF      PrintHours_origin_L0+1
;Project.c,407 :: 		move = origin + 11;
	MOVLW      11
	ADDWF      R0+0, 0
	MOVWF      PrintHours_move_L0+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      PrintHours_move_L0+1
;Project.c,395 :: 		for( i = start; i<=end; i++)
	INCF       PrintHours_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       PrintHours_i_L0+1, 1
;Project.c,410 :: 		}
	GOTO       L_PrintHours91
L_PrintHours92:
;Project.c,413 :: 		}
L_end_PrintHours:
	RETURN
; end of _PrintHours

_PrintTemperature:

;Project.c,415 :: 		int PrintTemperature( int start, int temperature)
;Project.c,418 :: 		int num = reverse( abs( temperature ) * 10 + 1 );
	MOVF       FARG_PrintTemperature_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_PrintTemperature_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       R0+0, 0
	ADDLW      1
	MOVWF      FARG_reverse_number+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_reverse_number+1
	CALL       _reverse+0
	MOVF       R0+0, 0
	MOVWF      PrintTemperature_num_L0+0
	MOVF       R0+1, 0
	MOVWF      PrintTemperature_num_L0+1
;Project.c,420 :: 		if( abs(temperature) <= 9)
	MOVF       FARG_PrintTemperature_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_PrintTemperature_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__PrintTemperature224
	MOVF       R0+0, 0
	SUBLW      9
L__PrintTemperature224:
	BTFSS      STATUS+0, 0
	GOTO       L_PrintTemperature96
;Project.c,421 :: 		num = reverse( abs( temperature ) );
	MOVF       FARG_PrintTemperature_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_PrintTemperature_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	MOVWF      FARG_reverse_number+0
	MOVF       R0+1, 0
	MOVWF      FARG_reverse_number+1
	CALL       _reverse+0
	MOVF       R0+0, 0
	MOVWF      PrintTemperature_num_L0+0
	MOVF       R0+1, 0
	MOVWF      PrintTemperature_num_L0+1
L_PrintTemperature96:
;Project.c,423 :: 		if(temperature == 0)
	MOVLW      0
	XORWF      FARG_PrintTemperature_temperature+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__PrintTemperature225
	MOVLW      0
	XORWF      FARG_PrintTemperature_temperature+0, 0
L__PrintTemperature225:
	BTFSS      STATUS+0, 2
	GOTO       L_PrintTemperature97
;Project.c,426 :: 		PrintNumber( (int) ( (start + 2) + ( start + 2 + 11) )/2, 31 /* Check */, num, 2);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_PrintNumber_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_PrintNumber_x+1
	RRF        FARG_PrintNumber_x+1, 1
	RRF        FARG_PrintNumber_x+0, 1
	BCF        FARG_PrintNumber_x+1, 7
	BTFSC      FARG_PrintNumber_x+1, 6
	BSF        FARG_PrintNumber_x+1, 7
	MOVLW      31
	MOVWF      FARG_PrintNumber_y+0
	MOVLW      0
	MOVWF      FARG_PrintNumber_y+1
	MOVF       PrintTemperature_num_L0+0, 0
	MOVWF      FARG_PrintNumber_number+0
	MOVF       PrintTemperature_num_L0+1, 0
	MOVWF      FARG_PrintNumber_number+1
	MOVLW      2
	MOVWF      FARG_PrintNumber_colour+0
	MOVLW      0
	MOVWF      FARG_PrintNumber_colour+1
	CALL       _PrintNumber+0
;Project.c,428 :: 		Render_C( (int) ( (start + 2) + ( start + 2 + 11) ) / 2 + 1, 38, 2);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_Render_C_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_Render_C_x+1
	RRF        FARG_Render_C_x+1, 1
	RRF        FARG_Render_C_x+0, 1
	BCF        FARG_Render_C_x+1, 7
	BTFSC      FARG_Render_C_x+1, 6
	BSF        FARG_Render_C_x+1, 7
	INCF       FARG_Render_C_x+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_Render_C_x+1, 1
	MOVLW      38
	MOVWF      FARG_Render_C_y+0
	MOVLW      0
	MOVWF      FARG_Render_C_y+1
	MOVLW      2
	MOVWF      FARG_Render_C_colour+0
	MOVLW      0
	MOVWF      FARG_Render_C_colour+1
	CALL       _Render_C+0
;Project.c,430 :: 		return (start + 2 + 11);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	GOTO       L_end_PrintTemperature
;Project.c,432 :: 		}
L_PrintTemperature97:
;Project.c,436 :: 		if( abs(temperature) < 15)
	MOVF       FARG_PrintTemperature_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_PrintTemperature_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__PrintTemperature226
	MOVLW      15
	SUBWF      R0+0, 0
L__PrintTemperature226:
	BTFSC      STATUS+0, 0
	GOTO       L_PrintTemperature98
;Project.c,439 :: 		if(temperature > 0)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_PrintTemperature_temperature+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__PrintTemperature227
	MOVF       FARG_PrintTemperature_temperature+0, 0
	SUBLW      0
L__PrintTemperature227:
	BTFSC      STATUS+0, 0
	GOTO       L_PrintTemperature99
;Project.c,443 :: 		PrintNumber( (int) ( (start + 2) + ( start + 2 + 11) )/2, 44 - ( temperature + 1 + 11) , num, 2);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_PrintNumber_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_PrintNumber_x+1
	RRF        FARG_PrintNumber_x+1, 1
	RRF        FARG_PrintNumber_x+0, 1
	BCF        FARG_PrintNumber_x+1, 7
	BTFSC      FARG_PrintNumber_x+1, 6
	BSF        FARG_PrintNumber_x+1, 7
	MOVF       FARG_PrintTemperature_temperature+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      FARG_PrintTemperature_temperature+1, 0
	MOVWF      R0+1
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	SUBLW      44
	MOVWF      FARG_PrintNumber_y+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_PrintNumber_y+1
	SUBWF      FARG_PrintNumber_y+1, 1
	MOVF       PrintTemperature_num_L0+0, 0
	MOVWF      FARG_PrintNumber_number+0
	MOVF       PrintTemperature_num_L0+1, 0
	MOVWF      FARG_PrintNumber_number+1
	MOVLW      2
	MOVWF      FARG_PrintNumber_colour+0
	MOVLW      0
	MOVWF      FARG_PrintNumber_colour+1
	CALL       _PrintNumber+0
;Project.c,445 :: 		Render_C( (int) ( (start + 2) + ( start + 2 + 11) ) / 2 + 1, 44 - ( temperature + 1 + 5), 2);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_Render_C_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_Render_C_x+1
	RRF        FARG_Render_C_x+1, 1
	RRF        FARG_Render_C_x+0, 1
	BCF        FARG_Render_C_x+1, 7
	BTFSC      FARG_Render_C_x+1, 6
	BSF        FARG_Render_C_x+1, 7
	INCF       FARG_Render_C_x+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_Render_C_x+1, 1
	MOVF       FARG_PrintTemperature_temperature+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      FARG_PrintTemperature_temperature+1, 0
	MOVWF      R0+1
	MOVLW      5
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	SUBLW      44
	MOVWF      FARG_Render_C_y+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       FARG_Render_C_y+1
	SUBWF      FARG_Render_C_y+1, 1
	MOVLW      2
	MOVWF      FARG_Render_C_colour+0
	MOVLW      0
	MOVWF      FARG_Render_C_colour+1
	CALL       _Render_C+0
;Project.c,447 :: 		return ( start + 2 + 11);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	GOTO       L_end_PrintTemperature
;Project.c,449 :: 		}
L_PrintTemperature99:
;Project.c,453 :: 		Render_Minus( (int) ( (start + 2) + ( start + 2 + 11) )/2 + 1, 44 + 7, 2);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_Render_Minus_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_Render_Minus_x+1
	RRF        FARG_Render_Minus_x+1, 1
	RRF        FARG_Render_Minus_x+0, 1
	BCF        FARG_Render_Minus_x+1, 7
	BTFSC      FARG_Render_Minus_x+1, 6
	BSF        FARG_Render_Minus_x+1, 7
	INCF       FARG_Render_Minus_x+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_Render_Minus_x+1, 1
	MOVLW      51
	MOVWF      FARG_Render_Minus_y+0
	MOVLW      0
	MOVWF      FARG_Render_Minus_y+1
	MOVLW      2
	MOVWF      FARG_Render_Minus_colour+0
	MOVLW      0
	MOVWF      FARG_Render_Minus_colour+1
	CALL       _Render_Minus+0
;Project.c,455 :: 		PrintNumber( (int) ( (start + 2) + ( start + 2 + 11) )/2, 44 + 9, num, 2);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_PrintNumber_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_PrintNumber_x+1
	RRF        FARG_PrintNumber_x+1, 1
	RRF        FARG_PrintNumber_x+0, 1
	BCF        FARG_PrintNumber_x+1, 7
	BTFSC      FARG_PrintNumber_x+1, 6
	BSF        FARG_PrintNumber_x+1, 7
	MOVLW      53
	MOVWF      FARG_PrintNumber_y+0
	MOVLW      0
	MOVWF      FARG_PrintNumber_y+1
	MOVF       PrintTemperature_num_L0+0, 0
	MOVWF      FARG_PrintNumber_number+0
	MOVF       PrintTemperature_num_L0+1, 0
	MOVWF      FARG_PrintNumber_number+1
	MOVLW      2
	MOVWF      FARG_PrintNumber_colour+0
	MOVLW      0
	MOVWF      FARG_PrintNumber_colour+1
	CALL       _PrintNumber+0
;Project.c,457 :: 		Render_C( (int) ( (start + 2) + ( start + 2 + 11) ) / 2 + 1, 44 + 15, 2);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_Render_C_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_Render_C_x+1
	RRF        FARG_Render_C_x+1, 1
	RRF        FARG_Render_C_x+0, 1
	BCF        FARG_Render_C_x+1, 7
	BTFSC      FARG_Render_C_x+1, 6
	BSF        FARG_Render_C_x+1, 7
	INCF       FARG_Render_C_x+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_Render_C_x+1, 1
	MOVLW      59
	MOVWF      FARG_Render_C_y+0
	MOVLW      0
	MOVWF      FARG_Render_C_y+1
	MOVLW      2
	MOVWF      FARG_Render_C_colour+0
	MOVLW      0
	MOVWF      FARG_Render_C_colour+1
	CALL       _Render_C+0
;Project.c,459 :: 		return ( start + 2 + 11);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	GOTO       L_end_PrintTemperature
;Project.c,463 :: 		}
L_PrintTemperature98:
;Project.c,467 :: 		if(temperature > 0)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_PrintTemperature_temperature+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__PrintTemperature228
	MOVF       FARG_PrintTemperature_temperature+0, 0
	SUBLW      0
L__PrintTemperature228:
	BTFSC      STATUS+0, 0
	GOTO       L_PrintTemperature102
;Project.c,470 :: 		PrintNumber( (int) ( (start + 2) + ( start + 2 + 11) )/2, (int) (44 + (44 - temperature) ) / 2 - 5 , num, 2); //Check
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_PrintNumber_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_PrintNumber_x+1
	RRF        FARG_PrintNumber_x+1, 1
	RRF        FARG_PrintNumber_x+0, 1
	BCF        FARG_PrintNumber_x+1, 7
	BTFSC      FARG_PrintNumber_x+1, 6
	BSF        FARG_PrintNumber_x+1, 7
	MOVF       FARG_PrintTemperature_temperature+0, 0
	SUBLW      44
	MOVWF      R0+0
	MOVF       FARG_PrintTemperature_temperature+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R0+1
	SUBWF      R0+1, 1
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_PrintNumber_y+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_PrintNumber_y+1
	RRF        FARG_PrintNumber_y+1, 1
	RRF        FARG_PrintNumber_y+0, 1
	BCF        FARG_PrintNumber_y+1, 7
	BTFSC      FARG_PrintNumber_y+1, 6
	BSF        FARG_PrintNumber_y+1, 7
	MOVLW      5
	SUBWF      FARG_PrintNumber_y+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_PrintNumber_y+1, 1
	MOVF       PrintTemperature_num_L0+0, 0
	MOVWF      FARG_PrintNumber_number+0
	MOVF       PrintTemperature_num_L0+1, 0
	MOVWF      FARG_PrintNumber_number+1
	MOVLW      2
	MOVWF      FARG_PrintNumber_colour+0
	MOVLW      0
	MOVWF      FARG_PrintNumber_colour+1
	CALL       _PrintNumber+0
;Project.c,472 :: 		Render_C( (int) ( (start + 2) + ( start + 2 + 11) ) / 2 + 1, (int) (44 + (44 - temperature) ) / 2 + 1, 2);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_Render_C_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_Render_C_x+1
	RRF        FARG_Render_C_x+1, 1
	RRF        FARG_Render_C_x+0, 1
	BCF        FARG_Render_C_x+1, 7
	BTFSC      FARG_Render_C_x+1, 6
	BSF        FARG_Render_C_x+1, 7
	INCF       FARG_Render_C_x+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_Render_C_x+1, 1
	MOVF       FARG_PrintTemperature_temperature+0, 0
	SUBLW      44
	MOVWF      R0+0
	MOVF       FARG_PrintTemperature_temperature+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R0+1
	SUBWF      R0+1, 1
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Render_C_y+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_Render_C_y+1
	RRF        FARG_Render_C_y+1, 1
	RRF        FARG_Render_C_y+0, 1
	BCF        FARG_Render_C_y+1, 7
	BTFSC      FARG_Render_C_y+1, 6
	BSF        FARG_Render_C_y+1, 7
	INCF       FARG_Render_C_y+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_Render_C_y+1, 1
	MOVLW      2
	MOVWF      FARG_Render_C_colour+0
	MOVLW      0
	MOVWF      FARG_Render_C_colour+1
	CALL       _Render_C+0
;Project.c,474 :: 		return ( start + 2 + 11);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	GOTO       L_end_PrintTemperature
;Project.c,476 :: 		}
L_PrintTemperature102:
;Project.c,481 :: 		PrintNumber( (int) ( (start + 2) + ( start + 2 + 11) )/2, 44 + 9, num, 2);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_PrintNumber_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_PrintNumber_x+1
	RRF        FARG_PrintNumber_x+1, 1
	RRF        FARG_PrintNumber_x+0, 1
	BCF        FARG_PrintNumber_x+1, 7
	BTFSC      FARG_PrintNumber_x+1, 6
	BSF        FARG_PrintNumber_x+1, 7
	MOVLW      53
	MOVWF      FARG_PrintNumber_y+0
	MOVLW      0
	MOVWF      FARG_PrintNumber_y+1
	MOVF       PrintTemperature_num_L0+0, 0
	MOVWF      FARG_PrintNumber_number+0
	MOVF       PrintTemperature_num_L0+1, 0
	MOVWF      FARG_PrintNumber_number+1
	MOVLW      2
	MOVWF      FARG_PrintNumber_colour+0
	MOVLW      0
	MOVWF      FARG_PrintNumber_colour+1
	CALL       _PrintNumber+0
;Project.c,483 :: 		Render_C( (int) ( (start + 2) + ( start + 2 + 11) ) / 2 + 1, 44 + 15, 2);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R2+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R2+1
	MOVLW      11
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      FARG_Render_C_x+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      FARG_Render_C_x+1
	RRF        FARG_Render_C_x+1, 1
	RRF        FARG_Render_C_x+0, 1
	BCF        FARG_Render_C_x+1, 7
	BTFSC      FARG_Render_C_x+1, 6
	BSF        FARG_Render_C_x+1, 7
	INCF       FARG_Render_C_x+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_Render_C_x+1, 1
	MOVLW      59
	MOVWF      FARG_Render_C_y+0
	MOVLW      0
	MOVWF      FARG_Render_C_y+1
	MOVLW      2
	MOVWF      FARG_Render_C_colour+0
	MOVLW      0
	MOVWF      FARG_Render_C_colour+1
	CALL       _Render_C+0
;Project.c,485 :: 		return ( start + 2 + 11);
	MOVLW      2
	ADDWF      FARG_PrintTemperature_start+0, 0
	MOVWF      R0+0
	MOVF       FARG_PrintTemperature_start+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVLW      11
	ADDWF      R0+0, 1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
;Project.c,493 :: 		}
L_end_PrintTemperature:
	RETURN
; end of _PrintTemperature

_initialize:

;Project.c,495 :: 		void initialize()
;Project.c,497 :: 		KP_R0 = 0;
	BCF        PORTA+0, 0
;Project.c,498 :: 		KP_R1 = 0;
	BCF        PORTA+0, 1
;Project.c,499 :: 		KP_R2 = 0;
	BCF        PORTA+0, 2
;Project.c,500 :: 		KP_R3 = 0;
	BCF        PORTA+0, 3
;Project.c,501 :: 		KP_R4 = 0;
	BCF        PORTA+0, 4
;Project.c,502 :: 		KP_R5 = 0;
	BCF        PORTA+0, 5
;Project.c,504 :: 		}
L_end_initialize:
	RETURN
; end of _initialize

_Key:

;Project.c,506 :: 		unsigned char Key()
;Project.c,509 :: 		if(KP_R0 == 1)
	BTFSS      PORTA+0, 0
	GOTO       L_Key104
;Project.c,510 :: 		return 'U';
	MOVLW      85
	MOVWF      R0+0
	GOTO       L_end_Key
L_Key104:
;Project.c,511 :: 		else if(KP_R1 == 1)
	BTFSS      PORTA+0, 1
	GOTO       L_Key106
;Project.c,512 :: 		return 'L';
	MOVLW      76
	MOVWF      R0+0
	GOTO       L_end_Key
L_Key106:
;Project.c,513 :: 		else if(KP_R2 == 1)
	BTFSS      PORTA+0, 2
	GOTO       L_Key108
;Project.c,514 :: 		return 'R';
	MOVLW      82
	MOVWF      R0+0
	GOTO       L_end_Key
L_Key108:
;Project.c,515 :: 		else if(KP_R3 == 1)
	BTFSS      PORTA+0, 3
	GOTO       L_Key110
;Project.c,516 :: 		return 'D';
	MOVLW      68
	MOVWF      R0+0
	GOTO       L_end_Key
L_Key110:
;Project.c,517 :: 		else if(KP_R4 == 1)
	BTFSS      PORTA+0, 4
	GOTO       L_Key112
;Project.c,518 :: 		return 'O';
	MOVLW      79
	MOVWF      R0+0
	GOTO       L_end_Key
L_Key112:
;Project.c,519 :: 		else if(KP_R5 == 1)
	BTFSS      PORTA+0, 5
	GOTO       L_Key114
;Project.c,520 :: 		return 'C';
	MOVLW      67
	MOVWF      R0+0
	GOTO       L_end_Key
L_Key114:
;Project.c,522 :: 		return '1';
	MOVLW      49
	MOVWF      R0+0
;Project.c,524 :: 		}
L_end_Key:
	RETURN
; end of _Key

_KeyClick:

;Project.c,526 :: 		unsigned char KeyClick()
;Project.c,528 :: 		unsigned char Key = '1';
	MOVLW      49
	MOVWF      KeyClick_Key_L0+0
;Project.c,530 :: 		initialize();
	CALL       _initialize+0
;Project.c,532 :: 		while( (Key = Key()) == '1' );
L_KeyClick116:
	CALL       _Key+0
	MOVF       R0+0, 0
	MOVWF      KeyClick_Key_L0+0
	MOVF       R0+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_KeyClick117
	GOTO       L_KeyClick116
L_KeyClick117:
;Project.c,534 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_KeyClick118:
	DECFSZ     R13+0, 1
	GOTO       L_KeyClick118
	DECFSZ     R12+0, 1
	GOTO       L_KeyClick118
	DECFSZ     R11+0, 1
	GOTO       L_KeyClick118
	NOP
;Project.c,536 :: 		return Key;
	MOVF       KeyClick_Key_L0+0, 0
	MOVWF      R0+0
;Project.c,538 :: 		}
L_end_KeyClick:
	RETURN
; end of _KeyClick

_Render_Block:

;Project.c,540 :: 		void Render_Block(int temperature, int index)
;Project.c,543 :: 		if(temperature == -2000000)
	MOVLW      0
	BTFSC      FARG_Render_Block_temperature+1, 7
	MOVLW      255
	MOVWF      R0+0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block233
	MOVF       R0+0, 0
	XORLW      225
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block233
	MOVF       FARG_Render_Block_temperature+1, 0
	XORLW      123
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block233
	MOVLW      128
	XORWF      FARG_Render_Block_temperature+0, 0
L__Render_Block233:
	BTFSS      STATUS+0, 2
	GOTO       L_Render_Block119
;Project.c,545 :: 		return;
	GOTO       L_end_Render_Block
;Project.c,547 :: 		}
L_Render_Block119:
;Project.c,548 :: 		else if( temperature > 1)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_Render_Block_temperature+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block234
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      1
L__Render_Block234:
	BTFSC      STATUS+0, 0
	GOTO       L_Render_Block121
;Project.c,551 :: 		switch(index)
	GOTO       L_Render_Block122
;Project.c,553 :: 		case 1:
L_Render_Block124:
;Project.c,554 :: 		Glcd_Box( 0, 44-temperature /* Height Inverse */, 11, 44 /* Bottom */, 1);
	CLRF       FARG_Glcd_Box_x_upper_left+0
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      11
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,555 :: 		break;
	GOTO       L_Render_Block123
;Project.c,556 :: 		case 2:
L_Render_Block125:
;Project.c,557 :: 		Glcd_Box( 13, 44-temperature /* Height Inverse */, 24, 44 /* Bottom */, 1);
	MOVLW      13
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      24
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,558 :: 		break;
	GOTO       L_Render_Block123
;Project.c,559 :: 		case 3:
L_Render_Block126:
;Project.c,560 :: 		Glcd_Box( 26, 44-temperature /* Height Inverse */, 37, 44 /* Bottom */, 1);
	MOVLW      26
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      37
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,561 :: 		break;
	GOTO       L_Render_Block123
;Project.c,562 :: 		case 4:
L_Render_Block127:
;Project.c,563 :: 		Glcd_Box( 39, 44-temperature /* Height Inverse */, 50, 44 /* Bottom */, 1);
	MOVLW      39
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      50
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,564 :: 		break;
	GOTO       L_Render_Block123
;Project.c,565 :: 		case 5:
L_Render_Block128:
;Project.c,566 :: 		Glcd_Box( 52, 44-temperature /* Height Inverse */, 63, 44 /* Bottom */, 1);
	MOVLW      52
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      63
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,567 :: 		break;
	GOTO       L_Render_Block123
;Project.c,568 :: 		case 6:
L_Render_Block129:
;Project.c,569 :: 		Glcd_Box( 65, 44-temperature /* Height Inverse */, 76, 44 /* Bottom */, 1);
	MOVLW      65
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      76
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,570 :: 		break;
	GOTO       L_Render_Block123
;Project.c,571 :: 		case 7:
L_Render_Block130:
;Project.c,572 :: 		Glcd_Box( 78, 44-temperature /* Height Inverse */, 89, 44 /* Bottom */, 1);
	MOVLW      78
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      89
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,573 :: 		break;
	GOTO       L_Render_Block123
;Project.c,574 :: 		case 8:
L_Render_Block131:
;Project.c,575 :: 		Glcd_Box( 91, 44-temperature /* Height Inverse */, 102, 44 /* Bottom */, 1);
	MOVLW      91
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      102
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,576 :: 		break;
	GOTO       L_Render_Block123
;Project.c,577 :: 		case 9:
L_Render_Block132:
;Project.c,578 :: 		Glcd_Box( 104, 44-temperature /* Height Inverse */, 115, 44 /* Bottom */, 1);
	MOVLW      104
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      115
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,579 :: 		break;
	GOTO       L_Render_Block123
;Project.c,580 :: 		case 10:
L_Render_Block133:
;Project.c,581 :: 		Glcd_Box( 117, 44-temperature /* Height Inverse */, 128, 44 /* Bottom */, 1);
	MOVLW      117
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVF       FARG_Render_Block_temperature+0, 0
	SUBLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      128
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,582 :: 		break;
	GOTO       L_Render_Block123
;Project.c,584 :: 		}
L_Render_Block122:
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block235
	MOVLW      1
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block235:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block124
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block236
	MOVLW      2
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block236:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block125
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block237
	MOVLW      3
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block237:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block126
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block238
	MOVLW      4
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block238:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block127
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block239
	MOVLW      5
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block239:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block128
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block240
	MOVLW      6
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block240:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block129
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block241
	MOVLW      7
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block241:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block130
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block242
	MOVLW      8
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block242:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block131
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block243
	MOVLW      9
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block243:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block132
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block244
	MOVLW      10
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block244:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block133
L_Render_Block123:
;Project.c,586 :: 		}
	GOTO       L_Render_Block134
L_Render_Block121:
;Project.c,589 :: 		switch(index)
	GOTO       L_Render_Block135
;Project.c,591 :: 		case 1:
L_Render_Block137:
;Project.c,592 :: 		Glcd_Box( 0, 44 /* Height Inverse */, 11, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
	MOVF       FARG_Render_Block_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_Render_Block_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	CLRF       FARG_Glcd_Box_x_upper_left+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      11
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,593 :: 		break;
	GOTO       L_Render_Block136
;Project.c,594 :: 		case 2:
L_Render_Block138:
;Project.c,595 :: 		Glcd_Box( 13, 44 /* Height Inverse */, 24, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
	MOVF       FARG_Render_Block_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_Render_Block_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      13
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      24
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,596 :: 		break;
	GOTO       L_Render_Block136
;Project.c,597 :: 		case 3:
L_Render_Block139:
;Project.c,598 :: 		Glcd_Box( 26, 44 /* Height Inverse */, 37, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
	MOVF       FARG_Render_Block_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_Render_Block_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      26
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      37
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,599 :: 		break;
	GOTO       L_Render_Block136
;Project.c,600 :: 		case 4:
L_Render_Block140:
;Project.c,601 :: 		Glcd_Box( 39, 44 /* Height Inverse */, 50, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
	MOVF       FARG_Render_Block_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_Render_Block_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      39
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      50
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,602 :: 		break;
	GOTO       L_Render_Block136
;Project.c,603 :: 		case 5:
L_Render_Block141:
;Project.c,604 :: 		Glcd_Box( 52, 44 /* Height Inverse */, 63, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
	MOVF       FARG_Render_Block_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_Render_Block_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      52
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      63
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,605 :: 		break;
	GOTO       L_Render_Block136
;Project.c,606 :: 		case 6:
L_Render_Block142:
;Project.c,607 :: 		Glcd_Box( 65, 44 /* Height Inverse */, 76, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
	MOVF       FARG_Render_Block_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_Render_Block_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      65
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      76
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,608 :: 		break;
	GOTO       L_Render_Block136
;Project.c,609 :: 		case 7:
L_Render_Block143:
;Project.c,610 :: 		Glcd_Box( 78, 44 /* Height Inverse */, 89, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
	MOVF       FARG_Render_Block_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_Render_Block_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      78
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      89
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,611 :: 		break;
	GOTO       L_Render_Block136
;Project.c,612 :: 		case 8:
L_Render_Block144:
;Project.c,613 :: 		Glcd_Box( 91, 44 /* Height Inverse */, 102, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
	MOVF       FARG_Render_Block_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_Render_Block_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      91
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      102
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,614 :: 		break;
	GOTO       L_Render_Block136
;Project.c,615 :: 		case 9:
L_Render_Block145:
;Project.c,616 :: 		Glcd_Box( 104, 44 /* Height Inverse */, 115, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
	MOVF       FARG_Render_Block_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_Render_Block_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      104
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      115
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,617 :: 		break;
	GOTO       L_Render_Block136
;Project.c,618 :: 		case 10:
L_Render_Block146:
;Project.c,619 :: 		Glcd_Box( 117, 44 /* Height Inverse */, 128, 44+abs(temperature) /* If Temp is > 1 Bottom */, 1);
	MOVF       FARG_Render_Block_temperature+0, 0
	MOVWF      FARG_abs_a+0
	MOVF       FARG_Render_Block_temperature+1, 0
	MOVWF      FARG_abs_a+1
	CALL       _abs+0
	MOVF       R0+0, 0
	ADDLW      44
	MOVWF      FARG_Glcd_Box_y_bottom_right+0
	MOVLW      117
	MOVWF      FARG_Glcd_Box_x_upper_left+0
	MOVLW      44
	MOVWF      FARG_Glcd_Box_y_upper_left+0
	MOVLW      128
	MOVWF      FARG_Glcd_Box_x_bottom_right+0
	MOVLW      1
	MOVWF      FARG_Glcd_Box_color+0
	CALL       _Glcd_Box+0
;Project.c,620 :: 		break;
	GOTO       L_Render_Block136
;Project.c,622 :: 		}
L_Render_Block135:
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block245
	MOVLW      1
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block245:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block137
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block246
	MOVLW      2
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block246:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block138
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block247
	MOVLW      3
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block247:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block139
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block248
	MOVLW      4
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block248:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block140
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block249
	MOVLW      5
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block249:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block141
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block250
	MOVLW      6
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block250:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block142
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block251
	MOVLW      7
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block251:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block143
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block252
	MOVLW      8
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block252:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block144
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block253
	MOVLW      9
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block253:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block145
	MOVLW      0
	XORWF      FARG_Render_Block_index+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Render_Block254
	MOVLW      10
	XORWF      FARG_Render_Block_index+0, 0
L__Render_Block254:
	BTFSC      STATUS+0, 2
	GOTO       L_Render_Block146
L_Render_Block136:
;Project.c,624 :: 		}
L_Render_Block134:
;Project.c,626 :: 		}
L_end_Render_Block:
	RETURN
; end of _Render_Block

_main:

;Project.c,629 :: 		void main() {
;Project.c,631 :: 		int i = 0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
	CLRF       main_pre_L0+0
	CLRF       main_pre_L0+1
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
	MOVLW      254
	MOVWF      main_origin_L0+0
	MOVLW      255
	MOVWF      main_origin_L0+1
;Project.c,639 :: 		SelectMenu = 0;
	CLRF       _SelectMenu+0
	CLRF       _SelectMenu+1
;Project.c,641 :: 		Current = 0;
	CLRF       _Current+0
	CLRF       _Current+1
;Project.c,644 :: 		count = 9192;
	MOVLW      232
	MOVWF      _count+0
	MOVLW      35
	MOVWF      _count+1
;Project.c,645 :: 		TMR0 = 0;
	CLRF       TMR0+0
;Project.c,646 :: 		OPTION_REG = 0x07;
	MOVLW      7
	MOVWF      OPTION_REG+0
;Project.c,647 :: 		INTCON = 0XA0;
	MOVLW      160
	MOVWF      INTCON+0
;Project.c,649 :: 		ANSEL  = 0;                                    // Configure AN pins as digital
	CLRF       ANSEL+0
;Project.c,650 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;Project.c,651 :: 		C1ON_bit = 0;                                  // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;Project.c,652 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;Project.c,654 :: 		TRISC = 0;
	CLRF       TRISC+0
;Project.c,656 :: 		SCL_Direction = 0;                 // SCL is output
	BCF        TRISC3_bit+0, BitPos(TRISC3_bit+0)
;Project.c,658 :: 		Glcd_Init();
	CALL       _Glcd_Init+0
;Project.c,659 :: 		Glcd_Fill( 0x00 );
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Project.c,665 :: 		for(i = 0; i < 24; i++)
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main147:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main256
	MOVLW      24
	SUBWF      main_i_L0+0, 0
L__main256:
	BTFSC      STATUS+0, 0
	GOTO       L_main148
;Project.c,666 :: 		hourlyTemperature[i] = -2000000;
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVF       main_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _hourlyTemperature+0
	MOVWF      FSR
	MOVLW      128
	MOVWF      INDF+0
	MOVLW      123
	INCF       FSR, 1
	MOVWF      INDF+0
;Project.c,665 :: 		for(i = 0; i < 24; i++)
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;Project.c,666 :: 		hourlyTemperature[i] = -2000000;
	GOTO       L_main147
L_main148:
;Project.c,669 :: 		i = 0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;Project.c,676 :: 		Glcd_Fill( 0x00 );
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Project.c,678 :: 		Glcd_H_Line( 0, 128, 44, 1 );
	CLRF       FARG_Glcd_H_Line_x_start+0
	MOVLW      128
	MOVWF      FARG_Glcd_H_Line_x_end+0
	MOVLW      44
	MOVWF      FARG_Glcd_H_Line_y_pos+0
	MOVLW      1
	MOVWF      FARG_Glcd_H_Line_color+0
	CALL       _Glcd_H_Line+0
;Project.c,680 :: 		for(j = 0; j < 10; j++)
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
L_main150:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main257
	MOVLW      10
	SUBWF      main_j_L0+0, 0
L__main257:
	BTFSC      STATUS+0, 0
	GOTO       L_main151
;Project.c,683 :: 		Render_Block( hourlyTemperature[j] , j+1);
	MOVF       main_j_L0+0, 0
	MOVWF      R0+0
	MOVF       main_j_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _hourlyTemperature+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Render_Block_temperature+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_Render_Block_temperature+1
	MOVF       main_j_L0+0, 0
	ADDLW      1
	MOVWF      FARG_Render_Block_index+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_j_L0+1, 0
	MOVWF      FARG_Render_Block_index+1
	CALL       _Render_Block+0
;Project.c,685 :: 		origin = PrintTemperature( origin, hourlyTemperature[j] );
	MOVF       main_origin_L0+0, 0
	MOVWF      FARG_PrintTemperature_start+0
	MOVF       main_origin_L0+1, 0
	MOVWF      FARG_PrintTemperature_start+1
	MOVF       main_j_L0+0, 0
	MOVWF      R0+0
	MOVF       main_j_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _hourlyTemperature+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_PrintTemperature_temperature+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_PrintTemperature_temperature+1
	CALL       _PrintTemperature+0
	MOVF       R0+0, 0
	MOVWF      main_origin_L0+0
	MOVF       R0+1, 0
	MOVWF      main_origin_L0+1
;Project.c,680 :: 		for(j = 0; j < 10; j++)
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;Project.c,687 :: 		}
	GOTO       L_main150
L_main151:
;Project.c,689 :: 		PrintHours( 0, 9, 2);
	CLRF       FARG_PrintHours_start+0
	CLRF       FARG_PrintHours_start+1
	MOVLW      9
	MOVWF      FARG_PrintHours_end+0
	MOVLW      0
	MOVWF      FARG_PrintHours_end+1
	MOVLW      2
	MOVWF      FARG_PrintHours_colour+0
	MOVLW      0
	MOVWF      FARG_PrintHours_colour+1
	CALL       _PrintHours+0
;Project.c,693 :: 		origin = -2;
	MOVLW      254
	MOVWF      main_origin_L0+0
	MOVLW      255
	MOVWF      main_origin_L0+1
;Project.c,696 :: 		while(1)
L_main153:
;Project.c,698 :: 		pre = i;
	MOVF       main_i_L0+0, 0
	MOVWF      main_pre_L0+0
	MOVF       main_i_L0+1, 0
	MOVWF      main_pre_L0+1
;Project.c,699 :: 		key = KeyClick();
	CALL       _KeyClick+0
	MOVF       R0+0, 0
	MOVWF      main_key_L0+0
;Project.c,703 :: 		if( count > 9192 )
	MOVF       _count+1, 0
	SUBLW      35
	BTFSS      STATUS+0, 2
	GOTO       L__main258
	MOVF       _count+0, 0
	SUBLW      232
L__main258:
	BTFSC      STATUS+0, 0
	GOTO       L_main155
;Project.c,705 :: 		INTCON = 0X00;
	CLRF       INTCON+0
;Project.c,707 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main156:
	DECFSZ     R13+0, 1
	GOTO       L_main156
	DECFSZ     R12+0, 1
	GOTO       L_main156
	DECFSZ     R11+0, 1
	GOTO       L_main156
	NOP
;Project.c,709 :: 		hourlyTemperature[ Current ] = Measure( 0x03 );
	MOVF       _Current+0, 0
	MOVWF      R0+0
	MOVF       _Current+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _hourlyTemperature+0
	MOVWF      FLOC__main+0
	MOVLW      3
	MOVWF      FARG_Measure_num+0
	CALL       _Measure+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	MOVF       R0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;Project.c,711 :: 		Current++;
	INCF       _Current+0, 1
	BTFSC      STATUS+0, 2
	INCF       _Current+1, 1
;Project.c,713 :: 		count = 0;
	CLRF       _count+0
	CLRF       _count+1
;Project.c,715 :: 		INTCON = 0XA0;
	MOVLW      160
	MOVWF      INTCON+0
;Project.c,717 :: 		}
L_main155:
;Project.c,720 :: 		if(key == 'R')
	MOVF       main_key_L0+0, 0
	XORLW      82
	BTFSS      STATUS+0, 2
	GOTO       L_main157
;Project.c,722 :: 		if(i < 2)
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main259
	MOVLW      2
	SUBWF      main_i_L0+0, 0
L__main259:
	BTFSC      STATUS+0, 0
	GOTO       L_main158
;Project.c,723 :: 		i++;
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
L_main158:
;Project.c,724 :: 		}
	GOTO       L_main159
L_main157:
;Project.c,725 :: 		else if(key == 'L')
	MOVF       main_key_L0+0, 0
	XORLW      76
	BTFSS      STATUS+0, 2
	GOTO       L_main160
;Project.c,727 :: 		if(i > 0)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main260
	MOVF       main_i_L0+0, 0
	SUBLW      0
L__main260:
	BTFSC      STATUS+0, 0
	GOTO       L_main161
;Project.c,728 :: 		i--;
	MOVLW      1
	SUBWF      main_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_i_L0+1, 1
L_main161:
;Project.c,729 :: 		}
	GOTO       L_main162
L_main160:
;Project.c,730 :: 		else if(key == 'C')
	MOVF       main_key_L0+0, 0
	XORLW      67
	BTFSS      STATUS+0, 2
	GOTO       L_main163
;Project.c,731 :: 		return;
	GOTO       L_end_main
L_main163:
L_main162:
L_main159:
;Project.c,733 :: 		if(pre == i)
	MOVF       main_pre_L0+1, 0
	XORWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main261
	MOVF       main_i_L0+0, 0
	XORWF      main_pre_L0+0, 0
L__main261:
	BTFSS      STATUS+0, 2
	GOTO       L_main164
;Project.c,734 :: 		continue;
	GOTO       L_main153
L_main164:
;Project.c,736 :: 		if(i == 0)
	MOVLW      0
	XORWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main262
	MOVLW      0
	XORWF      main_i_L0+0, 0
L__main262:
	BTFSS      STATUS+0, 2
	GOTO       L_main165
;Project.c,740 :: 		j = 0;
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
;Project.c,742 :: 		Glcd_Fill( 0x00 );
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Project.c,744 :: 		Glcd_H_Line( 0, 128, 44, 1 );
	CLRF       FARG_Glcd_H_Line_x_start+0
	MOVLW      128
	MOVWF      FARG_Glcd_H_Line_x_end+0
	MOVLW      44
	MOVWF      FARG_Glcd_H_Line_y_pos+0
	MOVLW      1
	MOVWF      FARG_Glcd_H_Line_color+0
	CALL       _Glcd_H_Line+0
;Project.c,746 :: 		for(j = 0; j < 10; j++)
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
L_main166:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main263
	MOVLW      10
	SUBWF      main_j_L0+0, 0
L__main263:
	BTFSC      STATUS+0, 0
	GOTO       L_main167
;Project.c,749 :: 		Render_Block( hourlyTemperature[j] , j+1);
	MOVF       main_j_L0+0, 0
	MOVWF      R0+0
	MOVF       main_j_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _hourlyTemperature+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Render_Block_temperature+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_Render_Block_temperature+1
	MOVF       main_j_L0+0, 0
	ADDLW      1
	MOVWF      FARG_Render_Block_index+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_j_L0+1, 0
	MOVWF      FARG_Render_Block_index+1
	CALL       _Render_Block+0
;Project.c,751 :: 		origin = PrintTemperature( origin, hourlyTemperature[j] );
	MOVF       main_origin_L0+0, 0
	MOVWF      FARG_PrintTemperature_start+0
	MOVF       main_origin_L0+1, 0
	MOVWF      FARG_PrintTemperature_start+1
	MOVF       main_j_L0+0, 0
	MOVWF      R0+0
	MOVF       main_j_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _hourlyTemperature+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_PrintTemperature_temperature+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_PrintTemperature_temperature+1
	CALL       _PrintTemperature+0
	MOVF       R0+0, 0
	MOVWF      main_origin_L0+0
	MOVF       R0+1, 0
	MOVWF      main_origin_L0+1
;Project.c,746 :: 		for(j = 0; j < 10; j++)
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;Project.c,753 :: 		}
	GOTO       L_main166
L_main167:
;Project.c,755 :: 		PrintHours( 0, 9, 2);
	CLRF       FARG_PrintHours_start+0
	CLRF       FARG_PrintHours_start+1
	MOVLW      9
	MOVWF      FARG_PrintHours_end+0
	MOVLW      0
	MOVWF      FARG_PrintHours_end+1
	MOVLW      2
	MOVWF      FARG_PrintHours_colour+0
	MOVLW      0
	MOVWF      FARG_PrintHours_colour+1
	CALL       _PrintHours+0
;Project.c,759 :: 		}
	GOTO       L_main169
L_main165:
;Project.c,760 :: 		else if(i == 1)
	MOVLW      0
	XORWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main264
	MOVLW      1
	XORWF      main_i_L0+0, 0
L__main264:
	BTFSS      STATUS+0, 2
	GOTO       L_main170
;Project.c,766 :: 		Glcd_Fill( 0x00 );
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Project.c,768 :: 		Glcd_H_Line( 0, 128, 44, 1 );
	CLRF       FARG_Glcd_H_Line_x_start+0
	MOVLW      128
	MOVWF      FARG_Glcd_H_Line_x_end+0
	MOVLW      44
	MOVWF      FARG_Glcd_H_Line_y_pos+0
	MOVLW      1
	MOVWF      FARG_Glcd_H_Line_color+0
	CALL       _Glcd_H_Line+0
;Project.c,770 :: 		for(j = 0; j < 10; j++)
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
L_main171:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main265
	MOVLW      10
	SUBWF      main_j_L0+0, 0
L__main265:
	BTFSC      STATUS+0, 0
	GOTO       L_main172
;Project.c,773 :: 		Render_Block( hourlyTemperature[j+10], j+1);
	MOVLW      10
	ADDWF      main_j_L0+0, 0
	MOVWF      R3+0
	MOVF       main_j_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _hourlyTemperature+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Render_Block_temperature+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_Render_Block_temperature+1
	MOVF       main_j_L0+0, 0
	ADDLW      1
	MOVWF      FARG_Render_Block_index+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_j_L0+1, 0
	MOVWF      FARG_Render_Block_index+1
	CALL       _Render_Block+0
;Project.c,775 :: 		origin = PrintTemperature( origin, hourlyTemperature[j+10] );
	MOVF       main_origin_L0+0, 0
	MOVWF      FARG_PrintTemperature_start+0
	MOVF       main_origin_L0+1, 0
	MOVWF      FARG_PrintTemperature_start+1
	MOVLW      10
	ADDWF      main_j_L0+0, 0
	MOVWF      R3+0
	MOVF       main_j_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _hourlyTemperature+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_PrintTemperature_temperature+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_PrintTemperature_temperature+1
	CALL       _PrintTemperature+0
	MOVF       R0+0, 0
	MOVWF      main_origin_L0+0
	MOVF       R0+1, 0
	MOVWF      main_origin_L0+1
;Project.c,770 :: 		for(j = 0; j < 10; j++)
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;Project.c,777 :: 		}
	GOTO       L_main171
L_main172:
;Project.c,779 :: 		PrintHours( 10, 19, 2);
	MOVLW      10
	MOVWF      FARG_PrintHours_start+0
	MOVLW      0
	MOVWF      FARG_PrintHours_start+1
	MOVLW      19
	MOVWF      FARG_PrintHours_end+0
	MOVLW      0
	MOVWF      FARG_PrintHours_end+1
	MOVLW      2
	MOVWF      FARG_PrintHours_colour+0
	MOVLW      0
	MOVWF      FARG_PrintHours_colour+1
	CALL       _PrintHours+0
;Project.c,783 :: 		}
	GOTO       L_main174
L_main170:
;Project.c,784 :: 		else if( i == 2)
	MOVLW      0
	XORWF      main_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main266
	MOVLW      2
	XORWF      main_i_L0+0, 0
L__main266:
	BTFSS      STATUS+0, 2
	GOTO       L_main175
;Project.c,789 :: 		Glcd_Fill( 0x00 );
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Project.c,791 :: 		Glcd_H_Line( 0, 128, 44, 1 );
	CLRF       FARG_Glcd_H_Line_x_start+0
	MOVLW      128
	MOVWF      FARG_Glcd_H_Line_x_end+0
	MOVLW      44
	MOVWF      FARG_Glcd_H_Line_y_pos+0
	MOVLW      1
	MOVWF      FARG_Glcd_H_Line_color+0
	CALL       _Glcd_H_Line+0
;Project.c,793 :: 		for(j = 0; j < 4; j++)
	CLRF       main_j_L0+0
	CLRF       main_j_L0+1
L_main176:
	MOVLW      128
	XORWF      main_j_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main267
	MOVLW      4
	SUBWF      main_j_L0+0, 0
L__main267:
	BTFSC      STATUS+0, 0
	GOTO       L_main177
;Project.c,796 :: 		Render_Block( hourlyTemperature[j+20], j+1);
	MOVLW      20
	ADDWF      main_j_L0+0, 0
	MOVWF      R3+0
	MOVF       main_j_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _hourlyTemperature+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Render_Block_temperature+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_Render_Block_temperature+1
	MOVF       main_j_L0+0, 0
	ADDLW      1
	MOVWF      FARG_Render_Block_index+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_j_L0+1, 0
	MOVWF      FARG_Render_Block_index+1
	CALL       _Render_Block+0
;Project.c,798 :: 		origin = PrintTemperature( origin, hourlyTemperature[j+20] );
	MOVF       main_origin_L0+0, 0
	MOVWF      FARG_PrintTemperature_start+0
	MOVF       main_origin_L0+1, 0
	MOVWF      FARG_PrintTemperature_start+1
	MOVLW      20
	ADDWF      main_j_L0+0, 0
	MOVWF      R3+0
	MOVF       main_j_L0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R3+1
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _hourlyTemperature+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_PrintTemperature_temperature+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      FARG_PrintTemperature_temperature+1
	CALL       _PrintTemperature+0
	MOVF       R0+0, 0
	MOVWF      main_origin_L0+0
	MOVF       R0+1, 0
	MOVWF      main_origin_L0+1
;Project.c,793 :: 		for(j = 0; j < 4; j++)
	INCF       main_j_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_j_L0+1, 1
;Project.c,799 :: 		}
	GOTO       L_main176
L_main177:
;Project.c,801 :: 		PrintHours( 20, 23, 2);
	MOVLW      20
	MOVWF      FARG_PrintHours_start+0
	MOVLW      0
	MOVWF      FARG_PrintHours_start+1
	MOVLW      23
	MOVWF      FARG_PrintHours_end+0
	MOVLW      0
	MOVWF      FARG_PrintHours_end+1
	MOVLW      2
	MOVWF      FARG_PrintHours_colour+0
	MOVLW      0
	MOVWF      FARG_PrintHours_colour+1
	CALL       _PrintHours+0
;Project.c,805 :: 		}
L_main175:
L_main174:
L_main169:
;Project.c,807 :: 		origin = -2;
	MOVLW      254
	MOVWF      main_origin_L0+0
	MOVLW      255
	MOVWF      main_origin_L0+1
;Project.c,809 :: 		}
	GOTO       L_main153
;Project.c,811 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
