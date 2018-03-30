
@ Code section
.section    .text


	
.global main
main: 

	ldr	r0, =frameBufferInfo
	bl	initFbInfo	
	
	mov  r0, #200			@X
	mov  r1, #200			@Y
	
	ldr  r2, =mario
	
	bl	drawPic
	
done:	
	  
haltLoop$:
	b		haltLoop$

drawPic:
	push {r4- r10, lr}
	
	mov   r4, r0					@ X start coordinate
	mov   r5, r1					@ Y start coordinate
	mov   r6, r2					@ Image address
	
	mov   r7, #500					@ Initialize the length
	mov   r8, #500					@ Initialize the height
	
	
///////////////////////////////////////////////////////////////////////////////
	add   r7, r4, r7				@ Start X + image length				 //
	cmp   r7, #1024					@ Make sure it says in screen bounds 	 //
	movgt r7, #1024					@ 										 //

	add   r8, r5, r8				@ Start Y + image height 				 //
	cmp   r8, #768					@ Make sure image stays in screen bounds //
	movgt r8, #768					@  										 //
///////////////////////////////////////////////////////////////////////////////	
	
	
	mov   r9, #0					@ Pixel counter
	
loop1:
	mov	  r0, r4					@ Pass x coordinate into DrawPixel
	mov	  r1, r5					@ Pass y coordinate into DrawPixel
	
	ldr   r2, [r6, r9, lsl #2]		@ 
	bl    DrawPixel					@ 
	add   r9, #1
	add   r4, #1
	

				 
	cmp   r4, #700					@ 
	blt   loop1						@ 

	mov    r4, #200
	add    r5, #1
	
after: 								@ 
	cmp   r5, #700					@ 
	ble   loop1						@ 
	
	pop {r4-r10, pc}

drawBox:
	push {r4, r5, r6, r7}

	mov	 r4, r0			@ X coordinate
	mov	 r5, r1			@ Y coordinate

	mov  r6, #0			@ Initialize length counter
	mov  r7, #0			@ Initialize height counter
	
drawLoop:	
	cmp  r6, #600		@ Check if the desired length has been exceeded
	bgt	 reLoop			@ If so, branch to reLoop to reinitialize 
	
	cmp	 r7, #600		@ Check if the desired vertical length has been exceeded
	bgt	 done			@ If so, 
	
	mov	r0, r4			@ Pass X into the DrawPixel subroutine
	mov r1, r5			@ Pass Y into the DrawPixel subroutine
	mov r2, r2  		@ Pass the color into the DrawPixel subroutine

	bl	DrawPixel		@ Branch to DrawPixel
	
	add r6, #1			@ Increment length counter
	add r4, #1			@ X = X + 1
	
	b  drawLoop			@ Branch back to top of inner loop
	
reLoop:
	mov  r4, #200		@ Reinitialize X
	mov  r6, #0			@ Reinitialize length counter
	add  r7, #1
	add  r5, #1			@ Move one pixel down on the Y axis
	b    drawLoop		@ Branch back to the top of the loop

	pop	{r4, r5, r6, r7}
	bx	lr              


DrawPixel:
	push	{r4, r5}
	
	offset	.req	r4
	ldr		r5, =frameBufferInfo
	
	@ offset = (y * width) + x
	ldr		r3, [r5, #4]	@ r3 = width
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


charBuffer:
.rept		64
.byte		0
.endr
