#include "graphics.h"
int rgb(int r,int g,int b){
	// r = (int)(r/3);
	// g = (int)(g/2);
	// b = (int)(b/3);
	return r<<11|g<<5|b;
}

void Draw(int x,int y,int r,int g,int b){
	VBEInfoBlock* VBE = VBEInfoAddress;
	int index = y*VBE->width + x;
	*((unsigned short*) VBE->framebuffer + index) = rgb(r,g,b);
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
	for(int j = y;j<height;j++){
		for(int i = x;i<width;i++){
			Draw(x+i,y+j,r,g,b);
		}
	}
}

void DrawCharacter(int (*f)(int,int),int x,int y,char character,int font_width,int font_height,int r,int g,int b){
	for(int j=0;j<font_height;j++){
		int row = f((int)character,j);
		int bit_value = 0;
		int shift = font_width - 1;
		for(int i=0;i<font_width;i++){
			bit_value = (row >> shift) & 0b1;
			if(bit_value == 1){
				Draw(x+i,y+j,r,g,b);
			}
			shift--;
		}
	}
};
