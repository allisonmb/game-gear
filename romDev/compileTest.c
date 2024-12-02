#include "SMSlib/SMSlib.h"
#include "assets.h"

#define SPLASH_TILES 0

void main(void) {
    SMS_loadPSGaidencompressedTiles(DemoBG_psgcompr, SPLASH_TILES);
    SMS_loadSTMcompressedTileMap(0, 0, DemoBG_stmcompr);
    GG_loadBGPalette(DemoBG_bin);

    SMS_displayOn();
    for(;;) {
        SMS_waitForVBlank();
    }
    
}

SMS_EMBED_SEGA_ROM_HEADER(9999, 0);
SMS_EMBED_SDSC_HEADER(1, 0, 2024, 11, 26, "Brandon Barker", "Demo Screen", "Should display something simple");