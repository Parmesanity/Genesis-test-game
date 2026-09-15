// Sega Genesis Minimal Boot Code in C
volatile unsigned short* const VDP_DATA = (unsigned short*)0x00C00000;
volatile unsigned long*  const VDP_CTRL = (unsigned long*)0x00C00004;

void main() {
    // Set background color via VDP (Write to CRAM)
    *VDP_CTRL = 0xC0000000;
    *VDP_DATA = 0x0E22; // Blue background color

    while(1) {
        // Infinite game loop
    }
}
