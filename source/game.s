.align
.global makeCeiling
.global makeLeftWall
.global makeRightWall
.global makeTypeOneBrick

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

	cmp  r4, #904						@ Check to see if our X ahs reached a desired position
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

	cmp  r5, #904						@ Check to see if our X ahs reached a desired position
	ble  topLeftWall					@ If so, we fall through, if not, we retiterate



	pop {r4, r5, r6,pc}					@
	bx	 lr								@

	
makeRightWall:
	push  {r4, r5, r6,lr}
	
	mov   r4, #904
	mov   r5, #232
	ldr   r6, =rightWallTile
	
topRightWall:
	
	mov   r0, r4						@ Pass X into drawTile subroutine
	mov   r1, r5						@ Pass Y into drawTile subRoutine
	
	mov   r2, r6						@ Load image adress to pass into drawTile
	
	bl	 drawTile					    @ Branch and link to drawTile		
	
	add  r5, #32						@ Increment by 32 pixels in the X direction, this spaces our ouxels by the size of each cell

	cmp  r5, #904						@ Check to see if our X ahs reached a desired position
	ble  topRightWall					@ If so, we fall through, if not, we retiterate



	pop {r4, r5, r6,pc}					@
	bx	 lr								@

makeTypeOneBrick:
	push  {r4, r5, r6,lr}
	
	mov   r4, #232
	mov   r5, #392
	ldr   r6, =ceilingTile
	
topTOB:
	
	mov   r0, r4						@ Pass X into drawTile subroutine
	mov   r1, r5						@ Pass Y into drawTile subRoutine
	
	mov   r2, r6						@ Load image adress to pass into drawTile
	
	bl	 drawTile					    @ Branch and link to drawTile		
	
	add  r4, #32						@ Increment by 32 pixels in the X direction, this spaces our ouxels by the size of each cell

	cmp  r4, #872						@ Check to see if our X ahs reached a desired position
	ble  topTOB						    @ If so, we fall through, if not, we retiterate

	pop {r4, r5, r6,pc}					@
	bx	 lr								@
