			area finalproject, code, readonly	
			export __main
__main 		proc
	
			ldr r2, =0x40004C01 ; port 2
			ldr r3, =0x40004C20	; port 3
			ldr r4, =0x40004C21 ; Port 4
			ldr r5, =0x40004C40 ; Port 5
			ldr r6, =0x40004C41 ; Port 6 
			
			;P2
			mov r7, #0xF8 ; Pins 7, 6, 5, 4, and 3
			strb r7, [r2, #0x06] ; enable resitor Pins 7, 6, 5, 4, and 3 on Port 2
			strb r7, [r2, #0x02] ; enable pull up resitor Pins 7, 6, 5, 4, and 3 on Port 2
			
			;P3
			mov r7, #0xE0 ; Pins 7, 6, and 5
			strb r7, [r3, #0x04] ; set Pins 7, 6, and 5 on Port 3 to output 
			mov r7, #0x0C ; Pins 3 and 2
			strb r7, [r3, #0x06] ; enable resitor Pins 7, 6, 5, 4, and 3 on Port 2
			strb r7, [r3, #0x02] ; enable pull up resitor Pins 7, 6, 5, 4, and 3 on Port 2
			
			;P4
			mov r7, #0xFF ; all pins
			strb r7, [r4, #0x04] ; set all pins on Port 4 to output
			
			;P5
			mov r7, #0xF0 ; pins 7, 6, 5, and 4
			strb r7, [r5, #0x04] ; set Pins 7, 6, 5, and 4 on Port 3 to output 
			mov r7, #0x07 ; pins 2, 1 and 0
			strb r7, [r5, #0x06] ; enable resitor Pins 7, 6, 5, 4, and 3 on Port 2
			strb r7, [r5, #0x02] ; enable pull up resitor Pins 7, 6, 5, 4, and 3 on Port 2
			
			;P6
			mov r7, #0xF3
			strb r7, [r6, #0x04] ; set all pins on Port 4 to output
			
			
			mov r0, #0 
			strb r0, [r6, #0x02]
			BL LCDInit

secret		mov r0, #0 
repeat		ldrb r11, [r3, #0x00] ; load inputs from P4
			bic r11, #0xF3
			cmp r11, #0x08
			beq enter
			cmp r11, #0x04
			beq clear
			b repeat
			endp
								
enter 		function
			ldrb r9, [r2, #0x00]
			bic r9, #0x07
			mov r7, r9
			ldrb r9, [r5, #0x00]
			bic r9, #0xF8
			orr r7, r9
			;strb r7, [r12]
			;ldrb r7, [r12]
			BL LCDData
			BL read
stay1		ldrb r11, [r3, #0x00] ; load inputs from P4
			bic r11, #0xF7
			cmp r11, #0x08
			beq stay1
			b repeat
			endp

clear		function
			push{LR}
			mov r7, #0x01
			BL LCDCommand
			pop{LR}
			BX LR
			endp
			
;COMMMANDS
; BTHO   0x42, 0x54, 0x48, 0x4F
; Howdy! 
; Dance
read 		function		
			cmp r0, #21
			bge track3
			cmp r0, #11
			bge track2
;			cmp r0, #1
;			bge track1
			cmp r7, #'H'
			beq counter3
			cmp r7, #'B'
			beq counter2
;			cmp r7, #'D'
;			beq counter1
			mov r0, #0
			b stay1 
			endp
				
reset3		function
			mov r0, #0
			b counter3 
			endp
			
				
track3		function
			cmp r0, #23
			bge track3a
			cmp r7, #'H'
			beq stay1
			cmp r7, #'o'
			bne reset3			
			b counter3
			endp

track3a		function
			cmp r0, #24
			bge track3b
			cmp r7, #'w'
			bne reset3
			b counter3
			endp
				
track3b		function
			cmp r0, #25
			bge track3c
			cmp r7, #'d'
			bne reset3
			b counter3
			endp

track3c		function
			cmp r0, #26
			bge track3d
			cmp r7, #'y'
			bne reset3
			b counter3
			endp
				
				
track3d		function
			cmp r7, #'!'
			beq wave
			b reset3
			b stay1
			endp				

counter3 	function
			;BL LCDData
			cmp r0, #21
			bge	skip3
			mov r0, #21
skip3		add r0, #1
			b stay1
			endp
			


reset2		function
			mov r0, #0
			b counter2
			endp
				
track2		function
			cmp r0, #13
			bge track2a
			cmp r7, #'B'
			beq stay1
			cmp r7, #'T'
			bne reset2		
			b counter2
			endp

track2a		function
			cmp r0, #14
			bge track2b
			cmp r7, #'H'
			bne reset2
			b counter2
			endp
				
track2b		function
			cmp r7, #'O'
			beq song
			b secret
			b stay1
			endp							
				
counter2 	function
			cmp r0, #11
			bge	skip2
			mov r0, #11
skip2		add r0, #1
			b stay1
			endp
;counter3 	function
;			endp
				

song 		function
			mov r10, #6
song1		mov r12, #0x02
			strb r12, [r6, #0x02]
			BL delayNote2
			mov r12, #0x00
			strb r12, [r6, #0x02]
			BL delayNote2
			sub r10, #1
			cmp r10, #3
			bge song1
			;mov r0, #0
			
			B secret
			endp
				


CCW			function ; rotate shaft counter clockwise
			push {LR}
			mov r1, #64
continue2	mov r12, #0x90
			strb r12, [r6, #0x02]
			bl delay2
			mov r12, #0x30
			strb r12, [r6, #0x02]
			bl delay2
			mov r12, #0x60
			strb r12, [r6, #0x02]
			bl delay2
			mov r12, #0xC0
			strb r12, [r6, #0x02]
			bl delay2
			sub r1, #0x01
			cmp r1, #0
			bne continue2
			pop {LR}
			BX lr
			endp



CW		 	function ; rotate shaft clockwise
			push {LR}
			mov r1, #64
continue1	mov r12, #0xC0
			strb r12, [r6, #0x02]
			bl delay2
			mov r12, #0x60
			strb r12, [r6, #0x02]
			bl delay2
			mov r12, #0x30
			strb r12, [r6, #0x02]
			bl delay2
			mov r12, #0x90
			strb r12, [r6, #0x02]
			bl delay2
			sub r1, #1
			cmp r1, #0
			bne continue1
			pop {LR}
			BX LR
			endp				
								
wave		function
			BL CW
			BL CCW
			BL CW 
			BL CCW
			mov r12, #0x00
			strb r12, [r6,#0x02]
			B secret
			endp


				
LCDInit		function ; LCD Initialization
			push{LR}
			mov r7, #0x38 ; 2 lines, 8 bits
			BL LCDCommand ; Load the command stored in r2 to the LCD
			mov r7, #0x0E ; turn on display
			BL LCDCommand
			mov r7, #0x01 ; clear display
			BL LCDCommand
			mov r7, #0x06 ; shift cursor right
			BL LCDCommand
			pop{LR}
			BX LR
			endp
				
LCDCommand	function ; Execute commands to LCD. Command mode.
			strb r7, [r4, #0x02]
			mov r8, #0x80
			strb r8, [r3, #0x02]
			push {LR}
			BL delay
			pop {LR}
			mov r8, #0x00
			strb r8, [r3, #0x02]
			BX LR
			endp
				
LCDData		function ; execute writing to LCD. Writing mode.
			strb r7, [r4, #0x02]
			mov r8, #0xA0
			strb r8, [r3, #0x02]
			push {LR}
			BL delay
			pop {LR}
			mov r8, #0x20   
			strb r8, [r3, #0x02]
			
			BX LR
			endp
				
				
			
delay		function
			mov r9,#50 ; CHANGE BACK TO #50
yy			mov r10, #0xFF ; CHANGE BACK TO #0xFF
xx			subs r10, #1
			bne xx
			subs r9, #1
			bne yy	
			bx lr
			endp
				
delay2   	function ; delay
			mov r9, #10 ; origianl is 50
outer		mov r10, #255 ; original is 255
inner		subs r10, #1
			bne inner
			subs r9, #1
			bne outer
			bx lr
			endp				

delayNote1 	function
			mov r9, #0x40000
loop1		sub r9, #1
			cmp r9, #0
			bne loop1
			BX LR
			endp
				
delayNote2 function
			mov r9, #0x1A000
loop2		sub r9, #1
			cmp r9, #0
			bne loop2
			BX LR
			endp

			end