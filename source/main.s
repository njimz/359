
@ Code section
.section    .text

.global DrawTile
.global DrawPixel
.global DrawBrick
.global DrawCursor
.global DrawMenu
.global DrawBall

.global main
main: 

	ldr	r0, =frameBufferInfo
	bl	initFbInfo	
	
	bl  makeBackground
	bl  makeCeiling
	bl  makeLeftWall
	bl  makeRightWall
	bl  makeTypeOneBrick
	bl  makeTypeTwoBrick
	bl  makeTypeThreeBrick
	
 
haltLoop$:
	b		haltLoop$

//////////////////////////////////////////
//										//
//										//
//										//
//										//
//////////////////////////////////////////
DrawMenu:
	push 	{r4- r10, lr}
	
	mov   	r4, r0							@ X start coordinate
	mov   	r5, r1							@ Y start coordinate
	mov  	r6, r2							@ Image address
	
	add  	r7, r4, #400					@ Initialize the width
	add   	r8, r5, #640 					@ Initialize the height
	
	
	
	mov   	r9, #0							@ Pixel counter
	mov		r10, r4							@ r10 holds x start coord for Y iterations
	
menuLoop:
	mov	  	r0, r4							@ Pass x coordinate into DrawPixel
	mov	  	r1, r5							@ Pass y coordinate into DrawPixel
	
	ldr   	r2, [r6, r9, lsl #2]			@ 
	bl    	DrawPixel						@ 
	add   	r9, #1							@	
	add   	r4, #1							@
	

				 
	cmp   	r4, r7							@ 
	blt   	menuLoop						@ 

	mov		r4, r10							@ r10 moved into to r4 to reinitialize
	add    	r5, #1							@
	
	cmp		r5, r8							@ 
	blt		menuLoop						@ 
	
	pop		{r4-r10, pc}					@


//////////////////////////////////////////
//										//
//										//
//										//
//										//
//////////////////////////////////////////
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
	bl    DrawPixel							@ 
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
DrawBrick:
	push {r4- r10, lr}						@
	
	mov   r4, r0							@ X start coordinate
	mov   r5, r1							@ Y start coordinate
	mov   r6, r2							@ Image address
	
	add   r7, r4, #64						@ Initialize the length
	add   r8, r5, #32						@ Initialize the height

	mov   r9, #0							@ Pixel counter
	mov	  r10, r4							@ r10 = r4, so we can reinitialize r4
	
brickLoop:
	mov	  r0, r4							@ Pass x coordinate into DrawPixel
	mov	  r1, r5							@ Pass y coordinate into DrawPixel
	
	ldr   r2, [r6, r9, lsl #2]				@ 
	bl    DrawPixel							@ 
	add   r9, #1							@
	add   r4, #1							@
	

				 
	cmp   r4, r7							@ Hard coded for easier alterations later on
	blt   brickLoop							@ 

	mov    r4, r10							@ Hard coded for easier alterations later on
	add    r5, #1							@
			
	cmp   r5, r8							@ Hard coded for easier alterations later on
	blt   brickLoop							@ 
	
	pop   {r4-r10, pc}						@
	bx     lr	 							@


//////////////////////////////////////////
//										//
//										//
//										//
//										//
//////////////////////////////////////////
DrawCursor:
	push 	{r4- r10, lr}
	
	mov   	r4, r0							@ X start coordinate
	mov   	r5, r1							@ Y start coordinate
	mov  	r6, r2							@ Image address
	
	add   	r7, r4, #64						@ Initialize the width
	add   	r8, r5, #64 					@ Initialize the height
	
	mov   	r9, #0							@ Pixel counter
	mov		r10, r4							@ r10 holds x start coord for Y iterations
	
CursorLoop:
	mov	  	r0, r4							@ Pass x coordinate into DrawPixel
	mov	  	r1, r5							@ Pass y coordinate into DrawPixel
	
	ldr   	r2, [r6, r9, lsl #2]			@ 
	bl    	DrawPixel						@	 
	add   	r9, #1							@
	add   	r4, #1							@
	

				 
	cmp   	r4, r7							@ 
	blt   	CursorLoop						@ 

	mov		r4, r10							@ r10 returned to r4 for start x coord
	add    	r5, #1							@
	
	cmp		r5, r8							@ 
	blt		CursorLoop   					@ 
	
	pop		{r4-r10, pc}					@


//////////////////////////////////////////
//										//
//										//
//										//
//										//
//////////////////////////////////////////
DrawBall:
	push {r4- r10, lr}						@
	
	mov   r4, r0							@ X start coordinate
	mov   r5, r1							@ Y start coordinate
	mov   r6, r2							@ Image address
	
	add   r7, r4, #16						@ Initialize the length
	add   r8, r5, #16						@ Initialize the height

	mov   r9, #0							@ Pixel counter
	mov	  r10, r4							@ r10 = r4, so we can reinitialize r4
	
ballLoop:
	mov	  r0, r4							@ Pass x coordinate into DrawPixel
	mov	  r1, r5							@ Pass y coordinate into DrawPixel
	
	ldr   r2, [r6, r9, lsl #2]				@ 
	bl    DrawPixel							@ 
	add   r9, #1							@
	add   r4, #1							@
	

				 
	cmp   r4, r7							@ Hard coded for easier alterations later on
	blt   ballLoop							@ 

	mov    r4, r10							@ Hard coded for easier alterations later on
	add    r5, #1							@
			
	cmp   r5, r8							@ Hard coded for easier alterations later on
	blt   ballLoop							@ 
	
	pop   {r4-r10, pc}
	bx     lr	 


//////////////////////////////////////////
//										//
//										//
//										//
//										//
//////////////////////////////////////////
DrawPixel:
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
