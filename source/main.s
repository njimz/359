@ Code section
.section    .text
.global DrawTile



.global main
main:
	ldr	r0, =frameBufferInfo
	bl	initFbInfo	
 
	mov r4, #0								@ i index
	mov r5, #0								@ j index
	
	mov r6, #200 							@ x coord
	mov r7, #100							@ y coord

top:
	mov	r0,	r4				 				@ i index
	mov	r1,	r5								@ j index
  
    bl  calcOffset							@ Branch to calculate offset
	
	mov r8, r0								@ Pass offset into DrawInitialGrid

	mov	r0,	r6								@ Pass x into DrawInitialGrid
	mov	r1,	r7								@ Pass y into DrawInitialGrid
	mov r2, r8								@ Pass the offset into DrawInitialGrid
	ldr r3, =startState						@ Pass the StartStateArray into DrawInitialGrid
	
	bl  DrawInitialGrid						@ Branch to DrawInitialGrid

	add  r6, #32							@ Increment by 32 pixels in the X direction, this spaces our pixels by the size of each cell
	cmp  r6, #872							@ Check if x pixels have reached the max value
	bgt  next								@ If so, branch to next
	ble  check								@ If not check index values
	
next:
	mov  r6, #200							@ Reinitialize the x value
	add  r7, #32							@ Increment the y value
	
	cmp  r7, #904							@ Check to see if our X ahs reached a desired position
	ble  check								@ If so, we fall through, if not, we retiterate

check:
	add r4, #1								@ Increment the i index
		
	cmp r4, #21								@ Check if i has reached a max
	bgt checkIndeces						@ If so, branch to checkIndeces 
	ble top									@ If no, reiterate the overall loop
	
checkIndeces:
	add r5, #1
	mov r4, #0
	
	cmp r5, #22
	bgt done 
	blt top
	
done:
	haltLoop$:
	b 	  haltLoop$

	  
calcOffset:
	push {r4- r10, lr}						@	
	mov   r4, r0							@ Desired 'i' index 
    mov   r5, r1							@ Desired 'j' index
    
    mov   r6, #4							@ Size of element
	mov   r7, #22							@ Total 'j' index of our array
	
	mul   r8, r7, r5 						@ ((m*i)
    add   r8, r4							@ ((m*i)+j)*(element-size)
    lsl   r8, #2
	
	mov   r0, r8							@	
	pop  {r4-r10, pc}						@
	
	
DrawInitialGrid:
	push {r4- r10, lr}						@


	mov   r4, r0							@ X start coordinate
	mov   r5, r1							@ Y start coordinate
	mov   r6, r2							@ Offset
	mov   r7, r3							@ initial state
				
	ldr   r8, [r7, r6]						@

topGrid:									@
	cmp   r8, #0
	beq   printBackground					@
	bne   else			

printBackground:							
	ldr   r10, =backgroundTile				@	
	
	mov	  r0, r4							@ Pass x coordinate into DrawTile
	mov	  r1, r5							@ Pass y coordinate into DrawTile
	mov   r2, r10							@ Pass ascii value into DrawTile
	
	bl    DrawTile							@ Branch and link to DrawTile
	b     done24							@
	
else:
	cmp   r8, #10							@
	beq   printCeiling
	bne   else1	
												
printCeiling:
	ldr   r10, =ceilingTile					@
	
	mov	  r0, r4							@ Pass x coordinate into DrawPixel
	mov	  r1, r5							@ Pass y coordinate into DrawPixel
	mov   r2, r10							@ 
	
	bl    DrawTile							@ 
	b     done24
	
else1:
	cmp   r8, #12							@
	beq   printRightWall
	bne   else2	
												
printRightWall:
	ldr   r10, =rightWallTile				@
	
	mov	  r0, r4							@ Pass x coordinate into DrawPixel
	mov	  r1, r5							@ Pass y coordinate into DrawPixel
	mov   r2, r10							@ 
	
	bl    DrawTile							@ 
	b     done24

else2:
	cmp   r8, #11							@
	beq   printLeftWall
	bne   else3	
												
printLeftWall:
	ldr   r10, =leftWallTile					@
	
	mov	  r0, r4							@ Pass x coordinate into DrawPixel
	mov	  r1, r5							@ Pass y coordinate into DrawPixel
	mov   r2, r10							@ 
	
	bl    DrawTile							@ 
	b     done24


else3:
	cmp   r8, #1							@
	beq   printBrickOne
	bne   else4	
												
printBrickOne:
	ldr   r10, =brick1				@
	
	mov	  r0, r4							@ Pass x coordinate into DrawPixel
	mov	  r1, r5							@ Pass y coordinate into DrawPixel
	mov   r2, r10							@ 
	
	bl    DrawTile							@ 
	b     done24
	
else4:	
	cmp   r8, #2							@
	beq   printBrickTwo
	bne   else5	
												
printBrickTwo:
	ldr   r10, =brick2				@
	
	mov	  r0, r4							@ Pass x coordinate into DrawPixel
	mov	  r1, r5							@ Pass y coordinate into DrawPixel
	mov   r2, r10							@ 
	
	bl    DrawTile							@ 
	b     done24

else5:
	cmp   r8, #3							@
	beq   printBrickThree
	bne   done24
												
printBrickThree:
	ldr   r10, =brick3				@
	
	mov	  r0, r4							@ Pass x coordinate into DrawPixel
	mov	  r1, r5							@ Pass y coordinate into DrawPixel
	mov   r2, r10							@ 
	
	bl    DrawTile							@ 
	b     done24

done24:
	
	pop   {r4-r10, pc}						@
	bx     lr	 							@


DrawTile:
	push {r4- r10, lr}						@
	
	mov   r4, r0							@ X start coordinate
	mov   r5, r1							@ Y start coordinate
	mov   r6, r2							@ Image address
	
	add   r7, r4, #32						@ Initialize the length
	add   r8, r5, #32						@ Initialize the height

	mov   r9, #0							@ Pixel counter
	mov	  r10, r4							@ r10 = r4, so we can reinitialize r4
	
loop1:
	mov	  r0, r4							@ Pass x coordinate into DrawPixel
	mov	  r1, r5							@ Pass y coordinate into DrawPixel
	
	ldr   r2, [r6, r9, lsl #2]				@ 
	bl    DrawPixel1						@ 
	add   r9, #1							@
	add   r4, #1							@
	

				 
	cmp   r4, r7							@ Hard coded for easier alterations later on
	blt   loop1								@ 

	mov    r4, r10							@ Hard coded for easier alterations later on
	add    r5, #1							@
			
	cmp   r5, r8							@ Hard coded for easier alterations later on
	blt   loop1								@ 
	
	pop   {r4-r10, pc}						@
	bx     lr	 							@



//////////////////////////////////////////
//										//
//										//
//										//
//										//
//////////////////////////////////////////
DrawPixel1:
	push	{r4, r5}						@
	
	offset	.req	r4						@
	ldr		r5, =frameBufferInfo
	
	@ offset = (y * width) + x
	ldr		r3, [r5, #4]	@ r3 = width	@ 
	mul		r1, r3
	add		offset, r0, r1
	
	@ offset *= 4 (32 bits per pixel/8 = 4 bytes per pixel)
	lsl		offset, #2
	
	@ store the colour (word) at frame buffer pointer + offset
	ldr		r0, [r5]						@r0 = frame buffer pointer
	str		r2, [r0, offset]
	
	pop		{r4, r5}
	bx		lr


.data
.align 4
font:	.incbin "font.bin"


.align
.global	frameBufferInfo
frameBufferInfo:
	.int	0		@ frame buffer pointer
	.int	0		@ screen width
	.int	0		@ screen height

.align 4	
startState:
	.int	 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,   0  
	.int	 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,   0 
	.int	 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,   0 
	.int	 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,   0 
	.int	10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,  10
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12  
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12 
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12 
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12 
	.int	11,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  12  
	.int	11,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  12
	.int	11,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1,  1  ,1,  1,  1,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
	.int	11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  12
