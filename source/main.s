@ Code section
.section    .text


	
.global main
main: 
	ldr	r0, =frameBufferInfo
	bl	initFbInfo	

	mov  r0, #500
	mov  r1, #500
	ldr  r2, =#0xFFF30FF

	b    drawImage

done:	
	  
haltLoop$:
	b		haltLoop$
	

		
drawImage:
	push {r4, r5}

	mov	 r8, r0			@ X coordinate
	mov	 r9, r1			@ Y coordinate

	mov  r6, #0			@ Initialize length counter
	mov  r7, #0			@ Initialize
drawLoop:	
	cmp  r6, #32		@ Check if the desired length has been exceeded
	bgt	 reLoop			@ If so, branch to reLoop to reinitialize 
	
	cmp	 r7, #32		@ Check if the desired vertical length has been exceeded
	bgt	 done			@ If so, 
	
	mov	r0, r8			@ Pass X into the DrawPixel subroutine
	mov r1, r9			@ Pass Y into the DrawPixel subroutine
	mov r2, r2			@ Pass the color into the DrawPixel subroutine

	bl	DrawPixel		@
	
	add r6, #1			@ Increment length counter
	add r8, #1			@ X = X + 1
	

	b  drawLoop			@ Branch back to top of inner loop
	
reLoop:
	mov  r8, #500		@ Reinitialize X
	mov  r6, #0			@ Reinitialize length counter
	add  r7, #1
	add  r9, #1			@ Move one pixel down on the Y axis
	b    drawLoop		@ Branch back to the top of the loop

	pop	{r4, r5}
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
