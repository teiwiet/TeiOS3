#include "graphics.h"

int start(){
	char s[] = "TURN INTO SOMETHING BEAUTIFUL";
	char* ptr = s;
	while(1){
		ClearScreen(0.0f/255.0f*16.0f,200.0f/255.0f*16.0f,80.0f/255.0f*16.0f);
		DrawString(getArialCharacter,0,0,ptr,font_arial_width,font_arial_height,255,0,0);
		Flush();
	};
}
