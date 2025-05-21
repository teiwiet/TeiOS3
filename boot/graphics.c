#include "graphics.h"

// r - 4 bits 
// g - 5 bits 
// b - 4 bits 
int rgb(int r,int g,int b){
	r = (int)(r/3);
	g = (int)(g/2);
	b = (int)(b/3);
	return r<<11|g<<5|b;
}

void Draw(int x,int y,int r,int g,int b){
	VBEInfoBlock* VBE = VBEInfoAddress;
	int index = y*VBE->width + x;
	*((unsigned int*) VBE->framebuffer + index) = rgb(r,g,b);
}

void ClearScreen(int r, int g, int b){
	VBEInfoBlock* VBE = VBEInfoAddress;
	for(int i = 0;i<VBE->height;i++){
		for(int j = 0;j<VBE->width;j++){
			Draw(j,i,r,g,b);
		}
	}
}

void DrawRect(int x, int y, int width, int height, int r, int g, int b){
	VBEInfoBlock* VBE = VBEInfoAddress;
	for(int i = y;i<height;i++){
		for(int j = x;j<width;j++){
			Draw(j,i,r,g,b);
		}
	}
}

void DrawCharacter(){

}
// #include "graphics.h"

// // r - 4 bits 
// // g - 5 bits 
// // b - 4 bits 
// int rgb(int r,int g,int b){
//     r = (int)(r/3);
//     g = (int)(g/2);
//     b = (int)(b/3);
//     return r<<11|g<<5|b;
// }

// void Draw(int x,int y,int r,int g,int b){
//     VBEInfoBlock* VBE = VBEInfoAddress;
//     int index = y*VBE->width + x;
//     *((unsigned int*) VBE->framebuffer + index) = rgb(r,g,b);
// }

// void ClearScreen(int r, int g, int b){
//     VBEInfoBlock* VBE = VBEInfoAddress;
//     for(int i = 0;i<VBE->height;i++){
//         for(int j = 0;j<VBE->width;j++){
//             Draw(j,i,r,g,b);
//         }
//     }
// }

// void DrawRect(int x, int y, int width, int height, int r, int g, int b){
//     VBEInfoBlock* VBE = VBEInfoAddress;
//     for(int i = y;i<height;i++){
//         for(int j = x;j<width;j++){
//             Draw(j,i,r,g,b);
//         }
//     }
// }

// // Font bitmap 8x16 (chỉ ví dụ một vài ký tự)
// const unsigned char font_8x16[256][16] = {
//     // Ký tự 'A'
//     {
//         0b00011000,
//         0b00100100,
//         0b01000010,
//         0b01111110,
//         0b01000010,
//         0b01000010,
//         0b01000010,
//         0b00000000,
//         0b00000000,
//         0b00000000,
//         0b00000000,
//         0b00000000,
//         0b00000000,
//         0b00000000,
//         0b00000000,
//         0b00000000
//     },
//     // Thêm ký tự khác...
// };

// void DrawCharacter(int x, int y, char c, int r, int g, int b) {
//     const unsigned char* char_bitmap = font_8x16[(unsigned char)c];
//     for (int row = 0; row < 16; row++) {
//         unsigned char line = char_bitmap[row];
//         for (int col = 0; col < 8; col++) {
//             if (line & (1 << (7 - col))) {
//                 Draw(x + col, y + row, r, g, b);
//             }
//         }
//     }
// }

// void DrawString(int x, int y, const char* str, int r, int g, int b) {
//     int cursor_x = x;
//     while (*str) {
//         DrawCharacter(cursor_x, y, *str, r, g, b);
//         cursor_x += 8; // Dịch vị trí theo độ rộng ký tự
//         str++;
//     }
// }
