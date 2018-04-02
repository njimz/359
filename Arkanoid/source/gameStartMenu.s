
@ Code section
.section .text

.global mainMenuStart


mainMenuStart:
	mov 	fp, sp
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}


	mov		r0,	#0x10000
	bl		delayMicroseconds
	mov		r0,	#0x10000
	bl		delayMicroseconds
	bl		drawStart
	bl		updateCursor	//needs to return something in r0

	pop		{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov		pc, lr




	@----------------------------------Menu Cursor-------------------------------------

	mov 	fp, sp
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}

	mov	r10, #1		// cursor location: 1 = restart, 0 = quit
					// initially set at start
updateCursor:
	@initialize variables
	mov		r5, #64				//width of image
	mov		r6, #64				//height of image
	mov		r7, #290			//x
	cmp		r10, #1				//Where the cursor is at
	moveq 	r8, #520			//y
	movne 	r8, #670			//490 for restart and 525 for quit

	@Set Address
	ldr 	r0, =menuCursor			//address for menuCursor

	@Set w and h
	ldr 	r1, =imageDimensions	 		// w and h
	str		r5, [r1]			// w = r5
	str		r6, [r1, #4]		// h = r6

	@Set x and y
	ldr 	r2, =xy				// x and y
	str		r7, [r2]			// x = r7
	str		r8, [r2, #4]		// y = r8

	@draw image
	bl	drawTile			//r0 = address for img, r1 = adderss for wh, r2 = address for xy

	@erase previous image
	cmp		r10, #1
	moveq	r8, #520		//y
	movne	r8, #670		//490 for restart and 525 for quit

	@Set Address
	ldr 	r0, =blackTile		//replace cursor with black tile

	@Set w and h
	ldr 	r1, =imageDimensions	 	// w and h
	str		r5, [r1]		// w = r5
	str		r6, [r1, #4]		// h = r6

	@Set x and y
	ldr 	r2, =xy			// x and y
	str		r7, [r2]		// x = r7
	str		r8, [r2, #4]		// y = r8

	@draw image
	bl	drawTile			//r0 = address for img, r1 = adderss for wh, r2 = address for xy


userInputMenu:
	bl	findButton
	cmp	r0, #4			//move up
	moveq	r10, #1
	beq	updateCursor
	cmp	r0, #5			//move down
	moveq	r10, #10
	beq	updateCursor

	cmp	r0, #8			// A pressed
	beq	returnInput

	cmp	r0, #3			// Start pressed
	moveq r10, #2
	beq	returnInput

	b	userInputMenu


returnInput:
	mov		r1, r10

	pop		{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov		pc, lr



	@----------------------------------START MENU-------------------------------------------
drawStart:
	mov 	fp, sp
	push	{r4, r5, r6, r7, r8, fp, lr}

	@initialize variables
	mov		r5, #704		//width of image
	mov		r6, #736		//height of image
	mov		r7, #200		//x: 848 is center
	mov		r8, #100		//y: 780 is center

	@Set address
	ldr 	r0, =backgroundBlck		//address for startMenu

	@Set w and h
	ldr 	r1, =imageDimensions 	// w and h
	str		r5, [r1]		// w = r5
	str		r6, [r1, #4]	// h = r6

	@Set x and y
	ldr 	r2, =xy			// x and y
	str		r7, [r2]		// x = r7
	str		r8, [r2, #4]	// y = r8

	@draw the image
	bl		drawTile			//r0 = address for img, r1 = adderss for wh, r2 = address for xy

	pop		{r4, r5, r6, r7, r8, fp, lr}
	mov		pc, lr

@ Data section
.section .data

imageDimensions:		.int 0, 0
xy:			.int 0, 0
