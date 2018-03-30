
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
	push {r4, r5, r6, r7, r8, r9, r10}
	
	mov   r4, r0			@ X start coordinate
	mov   r5, r1			@ Y start coordinate
	mov   r6, r2			@
	
	mov   r7, #500			@ Initialize the length
	mov   r8, #500			@ Initialize the height
	
	add   r9, r4, r7		@
	cmp   r9, #1024			@
	movgt r9, #1024			@

	add   r10, r5, r8		@
	cmp   r10, #768			@
	movgt r10, #768			@
	
	mov   r7, r4						@ SHOULD BE A COUNTER
	mov   r8, r5
loop1:
	mov	  r0, r4			@
	mov	  r1, r5			@
	
	mov   r2, r6		@
	bl    DrawPixel			@

	add   r7, #1			@
	cmp   r7, r9			@
	blt   loop1				@
	
	add   r8, #1			@
	cmp   r8, r10			@
	blt   loop1				@

	pop {r4, r5, r6, r7, r8, r9, r10}
	bx  lr
		

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
	mov r2, r2  			@ Pass the color into the DrawPixel subroutine

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
