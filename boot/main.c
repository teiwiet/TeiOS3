#include "graphics.h"

int start(){
	ClearScreen(0.0f/255.0f*16.0f,200.0f/255.0f*16.0f,80.0f/255.0f*16.0f);
	DrawCharacter(getArialCharacter,0,0,'A',font_arial_width,font_arial_height,0,0,255);
	while(1);
}
