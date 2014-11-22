/* Includes: */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <allegro5/allegro.h>
#include <allegro5/allegro_primitives.h>
#include <allegro5/allegro_font.h>
#include <allegro5/allegro_ttf.h>

/* Macros: */
#define GETBIT(x,b) ((x & (1<<b)) >> b)
#define SETBIT(x,b) (x | (1<<b))
#define RESETBIT(x,b) (x & ~(1<<b))

/* Constants: */
#define VB_PIXELWIDTH 4
#define VB_PIXELHEIGHT 4

/* Subroutines: */
void usage_error();
void general_error(char* message);

int main(int argc, char** argv)
{
	ALLEGRO_DISPLAY* display;
	ALLEGRO_EVENT_QUEUE* queue;
	ALLEGRO_EVENT event;
	
	ALLEGRO_FILE* picture;
	
	uint8_t* data;
	uint8_t width;
	uint8_t height;
	
	uint8_t running;
	
	uint16_t datasize;
	uint16_t bytesize;
	
	char filename[256];
	
	if(argc<4) usage_error();
	
	if(sscanf(argv[1],"%hhu",&width)!=1) usage_error();
	if(sscanf(argv[2],"%hhu",&height)!=1) usage_error();
	if(sscanf(argv[3],"%255s",filename)!=1) usage_error();
	
	if(!al_init()) general_error("Allegro Initialization Error");
	if(!al_init_primitives_addon())
		general_error("Allegro Primitives Initialization Error");
	al_init_font_addon();
	if(!al_init_ttf_addon())
		general_error("Allegro TrueType Initialization Error");
	if(!al_install_keyboard())
		general_error("Allegro Keyboard Initialization Error");
	if(!al_install_mouse())
		general_error("Allegro Mouse Initialization Error");
	
	datasize = width * height;
	bytesize = datasize/8;
	if((datasize % 8) != 0){
		bytesize += 1;
	}
	
	data = (uint8_t*) malloc(bytesize);
	if(data == NULL) general_error("Out of Memory");
	
	picture = al_fopen(filename,"r");
	if(picture == NULL){
		memset((void*)data,0,bytesize);
	}else{
		if(al_fread(picture,(void*)data,bytesize)!=bytesize)
			general_error("Read Error");
		al_fclose(picture);
	}
	
	running = 1;
	
	while(running)
	{
		
	}
	
	
	exit(0);
}

void usage_error()
{
	puts("Usage: $visuabit <width> <height> <file>");
	exit(-1);
}

void general_error(char* message)
{
	printf("%s\n",message);
	exit(-1);
}
