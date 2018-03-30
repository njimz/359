.align
.global makeBackground
.global makeCeiling
.global makeLeftWall
.global makeRightWall
.global makeTypeOneBrick
.global makeTypeTwoBrick
.global makeTypeThreeBrick


makeBackground:
	push  {r4, r5, r6,lr}
	
	mov   r4, #200
	mov   r5, #200
	ldr   r6, =backgroundTile
	
topBackground:
	
	mov   r0, r4						@ Pass X into drawTile subroutine
	mov   r1, r5						@ Pass Y into drawTile subRoutine
	
	mov   r2, r6						@ Load image adress to pass into drawTile
	
	bl	 drawTile					    @ Branch and link to drawTile		
	
	add  r4, #32						@ Increment by 32 pixels in the X direction, this spaces our ouxels by the size of each cell

	cmp  r4, #872						@ Check to see if our X ahs reached a desired position
	ble  topBackground					@ If so, we fall through, if not, we retiterate
	
	mov  r4, #200
	add  r5, #32
	cmp  r5, #872
	ble  topBackground

	pop {r4, r5, r6,pc}					@
	bx	 lr								@
	
	
makeCeiling:
	push  {r4, r5, r6,lr}
	
	mov   r4, #200
	mov   r5, #200
	ldr   r6, =ceilingTile
	
topCeiling:
	
	mov   r0, r4						@ Pass X into drawTile subroutine
	mov   r1, r5						@ Pass Y into drawTile subRoutine
	
	mov   r2, r6						@ Load image adress to pass into drawTile
	
	bl	 drawTile					    @ Branch and link to drawTile		
	
	add  r4, #32						@ Increment by 32 pixels in the X direction, this spaces our ouxels by the size of each cell

	cmp  r4, #872						@ Check to see if our X ahs reached a desired position
	ble  topCeiling						@ If so, we fall through, if not, we retiterate

	pop {r4, r5, r6,pc}					@
	bx	 lr								@


makeLeftWall:
	push  {r4, r5, r6,lr}
	
	mov   r4, #200
	mov   r5, #232
	ldr   r6, =leftWallTile
	
topLeftWall:
	
	mov   r0, r4						@ Pass X into drawTile subroutine
	mov   r1, r5						@ Pass Y into drawTile subRoutine
	
	mov   r2, r6						@ Load image adress to pass into drawTile
	
	bl	 drawTile					    @ Branch and link to drawTile		
	
	add  r5, #32						@ Increment by 32 pixels in the X direction, this spaces our ouxels by the size of each cell

	cmp  r5, #872						@ Check to see if our X ahs reached a desired position
	ble  topLeftWall					@ If so, we fall through, if not, we retiterate



	pop {r4, r5, r6,pc}					@
	bx	 lr								@

	
makeRightWall:
	push  {r4, r5, r6,lr}
	
	mov   r4, #872
	mov   r5, #232
	ldr   r6, =rightWallTile
	
topRightWall:
	
	mov   r0, r4						@ Pass X into drawTile subroutine
	mov   r1, r5						@ Pass Y into drawTile subRoutine
	
	mov   r2, r6						@ Load image adress to pass into drawTile
	
	bl	 drawTile					    @ Branch and link to drawTile		
	
	add  r5, #32						@ Increment by 32 pixels in the X direction, this spaces our ouxels by the size of each cell

	cmp  r5, #872						@ Check to see if our X ahs reached a desired position
	ble  topRightWall					@ If so, we fall through, if not, we retiterate



	pop {r4, r5, r6,pc}					@
	bx	 lr								@

makeTypeOneBrick:
	push  {r4, r5, r6,lr}
	
	mov   r4, #232
	mov   r5, #392
	ldr   r6, =brick1
	
topTOB:
	cmp   r5, r7
	
	
	mov   r0, r4						@ Pass X into drawTile subroutine
	mov   r1, r5						@ Pass Y into drawTile subRoutine
	
	mov   r2, r6						@ Load image adress to pass into drawTile
	
	bl	 drawBrick					    @ Branch and link to drawTile		
	
	add  r4, #64						@ Increment by 32 pixels in the X direction, this spaces our ouxels by the size of each cell

	cmp  r4, #840						@ Check to see if our X ahs reached a desired position
	ble  topTOB		
										
										@ If so, we fall through, if not, we retiterate

	pop {r4, r5, r6, pc}				@
	bx	 lr								@

makeTypeTwoBrick:
	push  {r4, r5, r6,lr}
	
	mov   r4, #232
	mov   r5, #424
	ldr   r6, =brick2
	
topTTwB:
	cmp   r5, r7
	
	
	mov   r0, r4						@ Pass X into drawTile subroutine
	mov   r1, r5						@ Pass Y into drawTile subRoutine
	
	mov   r2, r6						@ Load image adress to pass into drawTile
	
	bl	 drawBrick					    @ Branch and link to drawTile		
	
	add  r4, #64						@ Increment by 32 pixels in the X direction, this spaces our ouxels by the size of each cell

	cmp  r4, #840						@ Check to see if our X ahs reached a desired position
	ble  topTTwB		
										
										@ If so, we fall through, if not, we retiterate

	pop {r4, r5, r6, pc}				@
	bx	 lr								@

makeTypeThreeBrick:
	push  {r4, r5, r6,lr}
	
	mov   r4, #232
	mov   r5, #456
	ldr   r6, =brick3
	
topTThB:
	cmp   r5, r7
	
	
	mov   r0, r4						@ Pass X into drawTile subroutine
	mov   r1, r5						@ Pass Y into drawTile subRoutine
	
	mov   r2, r6						@ Load image adress to pass into drawTile
	
	bl	 drawBrick					    @ Branch and link to drawTile		
	
	add  r4, #64						@ Increment by 32 pixels in the X direction, this spaces our ouxels by the size of each cell

	cmp  r4, #840						@ Check to see if our X ahs reached a desired position
	ble  topTThB		
										
										@ If so, we fall through, if not, we retiterate

	pop {r4, r5, r6, pc}				@
	bx	 lr								@
drawBrick:
	push {r4- r10, lr}
	
	mov   r4, r0						@ X start coordinate
	mov   r5, r1						@ Y start coordinate
	mov   r6, r2						@ Image address
	
	add   r7, r4, #64					@ Initialize the length
	add   r8, r5, #32					@ Initialize the height

	mov   r9, #0						@ Pixel counter
	mov	  r10, r4						@ r10 = r4, so we can reinitialize r4
	
loop1:
	mov	  r0, r4						@ Pass x coordinate into DrawPixel
	mov	  r1, r5						@ Pass y coordinate into DrawPixel
	
	ldr   r2, [r6, r9, lsl #2]			@ 
	bl    DrawPixel						@ 
	add   r9, #1
	add   r4, #1
	

				 
	cmp   r4, r7						@ Hard coded for easier alterations later on
	blt   loop1							@ 

	mov    r4, r10						@ Hard coded for easier alterations later on
	add    r5, #1						@
			
	cmp   r5, r8						@ Hard coded for easier alterations later on
	blt   loop1							@ 
	
	pop   {r4-r10, pc}
	bx     lr	 
