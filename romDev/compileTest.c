#include "SMSlib/SMSlib.h"
#include "assets.h"

#define SPLASH_TILES 0
#define GATOR_TILES 256
unsigned char BallX, BallY, logo, release;

void initGame (void);
void loadAssets(void);
void moveBall (void);
void drawBall(void);

void main(void) {
    SMS_setSpriteMode(SPRITEMODE_NORMAL);
    loadAssets();
    initGame();
    SMS_displayOn();
    for(;;) {
        moveBall();
        SMS_initSprites();
        drawBall();
        SMS_waitForVBlank();
        SMS_copySpritestoSAT();
    }
    
}

SMS_EMBED_SEGA_ROM_HEADER(9999, 0);
SMS_EMBED_SDSC_HEADER(1, 0, 2024, 11, 26, "Brandon Barker", "Demo Screen", "Should display something simple");

void initGame (void) {
  BallX=50;
  BallY=96;
  logo = 0;
  release = 0;
}

void loadAssets(void) {
    SMS_loadPSGaidencompressedTiles(DemoBG_psgcompr, SPLASH_TILES);
    SMS_loadSTMcompressedTileMap(0, 0, DemoBG_stmcompr);
    GG_loadBGPalette(DemoBG_bin);
    SMS_loadPSGaidencompressedTiles(gator_psgcompr, GATOR_TILES);
    //SMS_loadSTMcompressedTileMap(0, 0, Ball_stmcompr);
    GG_loadSpritePalette(gator_bin);
}

void moveBall (void) {
#define MINBALLX  50
#define MAXBALLX 176
#define MINBALLY 24
#define MAXBALLY 136
  unsigned int ks=SMS_getKeysStatus();
  if ((ks & PORT_A_KEY_UP) && (BallY>MINBALLY)) {
    BallY-=1;
  } else if ((ks & PORT_A_KEY_DOWN) && (BallY<MAXBALLY)) {
    BallY+=1;
  }
  if ((ks & PORT_A_KEY_LEFT) && (BallX>MINBALLX)) {
    BallX-=1;
  } else if ((ks & PORT_A_KEY_RIGHT) && (BallX<MAXBALLX)) {
    BallX+=1;
  }
  if ((ks & PORT_A_KEY_1) && (release == 0)) {
    if (logo == 0) {
      SMS_loadPSGaidencompressedTiles(Nole_psgcompr, GATOR_TILES);
      GG_loadSpritePalette(Nole_bin);
    }
    else {
      SMS_loadPSGaidencompressedTiles(gator_psgcompr, GATOR_TILES);
      GG_loadSpritePalette(gator_bin);
    }
    logo = 1 - logo;
    release = 1;
  }
  ks = SMS_getKeysReleased();
  if (ks & PORT_A_KEY_1) {
    release = 0;
  }

}

void drawBall(void) {
  unsigned char x, y;
  for (y = 0; y < 4; y++) {
    for (x = 0; x < 4; x++) {
      SMS_addSprite(BallX + x * 8, BallY + y * 8, GATOR_TILES + y * 4 + x);
    }
  }
}