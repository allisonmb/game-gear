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
	.globl _GG_loadBGPalette
	.globl _SMS_loadSTMcompressedTileMapatAddr
	.globl _SMS_loadPSGaidencompressedTilesatAddr
	.globl _SMS_waitForVBlank
	.globl _SMS_VDPturnOnFeature
	.globl _SMS_SRAM
	.globl _SRAM_bank_to_be_mapped_on_slot2
	.globl _ROM_bank_to_be_mapped_on_slot0
	.globl _ROM_bank_to_be_mapped_on_slot1
	.globl _ROM_bank_to_be_mapped_on_slot2
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
;compileTest.c:6: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;compileTest.c:7: SMS_loadPSGaidencompressedTiles(DemoBG_psgcompr, SPLASH_TILES);
	ld	de, #0x4000
	ld	hl, #_DemoBG_psgcompr
	call	_SMS_loadPSGaidencompressedTilesatAddr
;compileTest.c:8: SMS_loadSTMcompressedTileMap(0, 0, DemoBG_stmcompr);
	ld	de, #_DemoBG_stmcompr
	ld	hl, #0x7800
	call	_SMS_loadSTMcompressedTileMapatAddr
;compileTest.c:9: GG_loadBGPalette(DemoBG_bin);
	ld	hl, #_DemoBG_bin
	call	_GG_loadBGPalette
;compileTest.c:11: SMS_displayOn();
	ld	hl, #0x0140
	call	_SMS_VDPturnOnFeature
00102$:
;compileTest.c:13: SMS_waitForVBlank();
	call	_SMS_waitForVBlank
	jp	00102$
00104$:
;compileTest.c:16: }
	ret
	.area _CODE
__str_0:
	.ascii "Brandon Barker"
	.db 0x00
__str_1:
	.ascii "Demo Screen"
	.db 0x00
__str_2:
	.ascii "Should display something simple"
	.db 0x00
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
