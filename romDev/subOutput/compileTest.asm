;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.4.0 #14620 (MINGW64)
;--------------------------------------------------------
	.module compileTest
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___SMS__SDSC_signature
	.globl ___SMS__SDSC_descr
	.globl ___SMS__SDSC_name
	.globl ___SMS__SDSC_author
	.globl ___SMS__SEGA_signature
	.globl _main
	.globl _SMS_getKeysReleased
	.globl _SMS_getKeysStatus
	.globl _GG_loadSpritePalette
	.globl _GG_loadBGPalette
	.globl _SMS_copySpritestoSAT
	.globl _SMS_addSprite_f
	.globl _SMS_initSprites
	.globl _SMS_loadSTMcompressedTileMapatAddr
	.globl _SMS_loadPSGaidencompressedTilesatAddr
	.globl _SMS_waitForVBlank
	.globl _SMS_setSpriteMode
	.globl _SMS_VDPturnOnFeature
	.globl _release
	.globl _logo
	.globl _BallY
	.globl _BallX
	.globl _SMS_SRAM
	.globl _SRAM_bank_to_be_mapped_on_slot2
	.globl _ROM_bank_to_be_mapped_on_slot0
	.globl _ROM_bank_to_be_mapped_on_slot1
	.globl _ROM_bank_to_be_mapped_on_slot2
	.globl _initGame
	.globl _loadAssets
	.globl _moveBall
	.globl _drawBall
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_SMS_VDPControlPort	=	0x00bf
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ROM_bank_to_be_mapped_on_slot2	=	0xffff
_ROM_bank_to_be_mapped_on_slot1	=	0xfffe
_ROM_bank_to_be_mapped_on_slot0	=	0xfffd
_SRAM_bank_to_be_mapped_on_slot2	=	0xfffc
_SMS_SRAM	=	0x8000
_BallX::
	.ds 1
_BallY::
	.ds 1
_logo::
	.ds 1
_release::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;compileTest.c:13: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;compileTest.c:14: SMS_setSpriteMode(SPRITEMODE_NORMAL);
	ld	l, #0x00
;	spillPairReg hl
;	spillPairReg hl
	call	_SMS_setSpriteMode
;compileTest.c:15: loadAssets();
	call	_loadAssets
;compileTest.c:16: initGame();
	call	_initGame
;compileTest.c:17: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
00102$:
;compileTest.c:19: moveBall();
	call	_moveBall
;compileTest.c:20: SMS_initSprites();
	call	_SMS_initSprites
;compileTest.c:21: drawBall();
	call	_drawBall
;compileTest.c:22: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
;compileTest.c:23: SMS_copySpritestoSAT();
	call	_SMS_copySpritestoSAT
	jp	00102$
00104$:
;compileTest.c:26: }
	ret
;compileTest.c:31: void initGame (void) {
;	---------------------------------
; Function initGame
; ---------------------------------
_initGame::
;compileTest.c:32: BallX=50;
	ld	iy, #_BallX
	ld	0 (iy), #0x32
;compileTest.c:33: BallY=96;
	ld	iy, #_BallY
	ld	0 (iy), #0x60
;compileTest.c:34: logo = 0;
	ld	iy, #_logo
	ld	0 (iy), #0x00
;compileTest.c:35: release = 0;
	ld	iy, #_release
	ld	0 (iy), #0x00
00101$:
;compileTest.c:36: }
	ret
__str_0:
	.ascii "Brandon Barker"
	.db 0x00
__str_1:
	.ascii "Demo Screen"
	.db 0x00
__str_2:
	.ascii "Should display something simple"
	.db 0x00
;compileTest.c:38: void loadAssets(void) {
;	---------------------------------
; Function loadAssets
; ---------------------------------
_loadAssets::
;compileTest.c:39: SMS_loadPSGaidencompressedTiles(DemoBG_psgcompr, SPLASH_TILES);
	ld	de, #0x4000
	ld	hl, #_DemoBG_psgcompr
	call	_SMS_loadPSGaidencompressedTilesatAddr
;compileTest.c:40: SMS_loadSTMcompressedTileMap(0, 0, DemoBG_stmcompr);
	ld	de, #_DemoBG_stmcompr
	ld	hl, #0x7800
	call	_SMS_loadSTMcompressedTileMapatAddr
;compileTest.c:41: GG_loadBGPalette(DemoBG_bin);
	ld	hl, #_DemoBG_bin
	call	_GG_loadBGPalette
;compileTest.c:42: SMS_loadPSGaidencompressedTiles(gator_psgcompr, GATOR_TILES);
	ld	de, #0x6000
	ld	hl, #_gator_psgcompr
	call	_SMS_loadPSGaidencompressedTilesatAddr
;compileTest.c:44: GG_loadSpritePalette(gator_bin);
	ld	hl, #_gator_bin
	jp	_GG_loadSpritePalette
00101$:
;compileTest.c:45: }
	ret
;compileTest.c:47: void moveBall (void) {
;	---------------------------------
; Function moveBall
; ---------------------------------
_moveBall::
;compileTest.c:52: unsigned int ks=SMS_getKeysStatus();
	call	_SMS_getKeysStatus
;compileTest.c:54: BallY-=1;
	ld	a, (_BallY+0)
	ld	c, a
;compileTest.c:53: if ((ks & PORT_A_KEY_UP) && (BallY>MINBALLY)) {
	bit	0, e
	jp	NZ,00209$
	jp	00105$
00209$:
	ld	a, #0x18
	ld	iy, #_BallY
	sub	a, 0 (iy)
	jp	NC, 00105$
;compileTest.c:54: BallY-=1;
	ld	hl, #_BallY
	ld	a, c
	add	a, #0xff
	ld	(hl), a
	jp	00106$
00105$:
;compileTest.c:55: } else if ((ks & PORT_A_KEY_DOWN) && (BallY<MAXBALLY)) {
	bit	1, e
	jp	NZ,00210$
	jp	00106$
00210$:
	ld	a, (_BallY+0)
	sub	a, #0x88
	jp	NC, 00106$
;compileTest.c:56: BallY+=1;
	ld	a, c
	inc	a
	ld	(_BallY+0), a
00106$:
;compileTest.c:59: BallX-=1;
	ld	a, (_BallX+0)
	ld	c, a
;compileTest.c:58: if ((ks & PORT_A_KEY_LEFT) && (BallX>MINBALLX)) {
	bit	2, e
	jp	NZ,00211$
	jp	00112$
00211$:
	ld	a, #0x32
	ld	iy, #_BallX
	sub	a, 0 (iy)
	jp	NC, 00112$
;compileTest.c:59: BallX-=1;
	ld	hl, #_BallX
	ld	a, c
	add	a, #0xff
	ld	(hl), a
	jp	00113$
00112$:
;compileTest.c:60: } else if ((ks & PORT_A_KEY_RIGHT) && (BallX<MAXBALLX)) {
	bit	3, e
	jp	NZ,00212$
	jp	00113$
00212$:
	ld	a, (_BallX+0)
	sub	a, #0xb0
	jp	NC, 00113$
;compileTest.c:61: BallX+=1;
	ld	a, c
	inc	a
	ld	(_BallX+0), a
00113$:
;compileTest.c:63: if ((ks & PORT_A_KEY_1) && (release == 0)) {
	bit	4, e
	jp	NZ,00213$
	jp	00119$
00213$:
	ld	a, (_release+0)
	or	a, a
	jp	NZ, 00119$
;compileTest.c:64: if (logo == 0) {
	ld	a, (_logo+0)
	or	a, a
	jp	NZ, 00116$
;compileTest.c:65: SMS_loadPSGaidencompressedTiles(Nole_psgcompr, GATOR_TILES);
	ld	de, #0x6000
	ld	hl, #_Nole_psgcompr
	call	_SMS_loadPSGaidencompressedTilesatAddr
;compileTest.c:66: GG_loadSpritePalette(Nole_bin);
	ld	hl, #_Nole_bin
	call	_GG_loadSpritePalette
	jp	00117$
00116$:
;compileTest.c:69: SMS_loadPSGaidencompressedTiles(gator_psgcompr, GATOR_TILES);
	ld	de, #0x6000
	ld	hl, #_gator_psgcompr
	call	_SMS_loadPSGaidencompressedTilesatAddr
;compileTest.c:70: GG_loadSpritePalette(gator_bin);
	ld	hl, #_gator_bin
	call	_GG_loadSpritePalette
00117$:
;compileTest.c:72: logo = 1 - logo;
	ld	a, (_logo+0)
	ld	c, a
	ld	hl, #_logo
	ld	a, #0x01
	sub	a, c
	ld	(hl), a
;compileTest.c:73: release = 1;
	ld	iy, #_release
	ld	0 (iy), #0x01
00119$:
;compileTest.c:75: ks = SMS_getKeysReleased();
	call	_SMS_getKeysReleased
;compileTest.c:76: if (ks & PORT_A_KEY_1) {
	bit	4, e
	jp	NZ,00214$
	jp	00123$
00214$:
;compileTest.c:77: release = 0;
	ld	iy, #_release
	ld	0 (iy), #0x00
00123$:
;compileTest.c:80: }
	ret
;compileTest.c:82: void drawBall(void) {
;	---------------------------------
; Function drawBall
; ---------------------------------
_drawBall::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
;compileTest.c:84: for (y = 0; y < 4; y++) {
	ld	-2 (ix), #0x00
;compileTest.c:85: for (x = 0; x < 4; x++) {
00109$:
	ld	-1 (ix), #0x00
00103$:
;compileTest.c:86: SMS_addSprite(BallX + x * 8, BallY + y * 8, GATOR_TILES + y * 4 + x);
	ld	a, (_BallX+0)
	ld	c, a
	ld	b, #0x00
	ld	a, -1 (ix)
	ld	-4 (ix), a
	ld	-3 (ix), #0x00
	pop	hl
	push	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	xor	a, a
	ld	b, l
	ld	c, #0x00
	ld	l, -2 (ix)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	e, l
	ld	d, h
	ex	de, hl
	add	hl, hl
	add	hl, hl
	ex	de, hl
	ld	a, d
	inc	a
	ld	d, a
	ld	a, e
	add	a, -4 (ix)
	ld	e, a
	ld	a, d
	adc	a, -3 (ix)
	ld	d, a
	ld	d, #0x00
	ld	a, e
	or	a, c
	ld	e, a
	ld	a, d
	or	a, b
	ld	d, a
	ld	a, (_BallY+0)
	ld	c, a
	ld	b, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	call	_SMS_addSprite_f
;compileTest.c:85: for (x = 0; x < 4; x++) {
	inc	-1 (ix)
	ld	a, -1 (ix)
	sub	a, #0x04
	jp	C, 00103$
;compileTest.c:84: for (y = 0; y < 4; y++) {
	inc	-2 (ix)
	ld	a, -2 (ix)
	sub	a, #0x04
	jp	C, 00109$
00107$:
;compileTest.c:89: }
	ld	sp, ix
	pop	ix
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
	.org 0x7FF0
___SMS__SEGA_signature:
	.db #0x54	; 84	'T'
	.db #0x4d	; 77	'M'
	.db #0x52	; 82	'R'
	.db #0x20	; 32
	.db #0x53	; 83	'S'
	.db #0x45	; 69	'E'
	.db #0x47	; 71	'G'
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x99	; 153
	.db #0x99	; 153
	.db #0x00	; 0
	.db #0x7c	; 124
	.org 0x7FD1
___SMS__SDSC_author:
	.ascii "Brandon Barker"
	.db 0x00
	.org 0x7FC5
___SMS__SDSC_name:
	.ascii "Demo Screen"
	.db 0x00
	.org 0x7FA5
___SMS__SDSC_descr:
	.ascii "Should display something simple"
	.db 0x00
	.org 0x7FE0
___SMS__SDSC_signature:
	.db #0x53	; 83	'S'
	.db #0x44	; 68	'D'
	.db #0x53	; 83	'S'
	.db #0x43	; 67	'C'
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x11	; 17
	.db #0x24	; 36
	.db #0x20	; 32
	.db #0xd1	; 209
	.db #0x7f	; 127
	.db #0xc5	; 197
	.db #0x7f	; 127
	.db #0xa5	; 165
	.db #0x7f	; 127
