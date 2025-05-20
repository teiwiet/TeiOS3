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
