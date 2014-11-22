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
#define VB_PIXELWIDTH 6
#define VB_PIXELHEIGHT 6

/* Subroutines: */
void usage_error();
void general_error(char* message);

int main(int argc, char** argv)
{
	ALLEGRO_DISPLAY* display;
	ALLEGRO_EVENT_QUEUE* queue;
	ALLEGRO_EVENT event;
	ALLEGRO_FONT* font;
	
	ALLEGRO_MOUSE_STATE mouse;
	
	ALLEGRO_FILE* picture;
	
	uint8_t* data;
	uint8_t* paint_data;
	uint8_t width;
	uint8_t height;
	
	uint8_t i,j;
	uint16_t k;
	
	uint8_t running;
	uint8_t painting;
	uint8_t save;
	
	uint16_t datasize;
	uint16_t bytesize;
	
	uint16_t displaywidth;
	uint16_t displayheight;
	
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
	
	/* Memory allocation for image: */
	data = (uint8_t*) malloc(bytesize);
	paint_data = (uint8_t*) malloc(bytesize);
	if(data == NULL || paint_data == NULL) general_error("Out of Memory");
	
	/* File reading (if exists): */
	picture = al_fopen(filename,"r");
	if(picture == NULL){
		memset((void*)data,0,bytesize);
	}else{
		if(al_fread(picture,(void*)data,bytesize)!=bytesize)
			general_error("Read Error");
		al_fclose(picture);
	}
	
	/* Display initialization: */
	displaywidth = (width + 2) * VB_PIXELWIDTH;
	displayheight = (height + 2) * VB_PIXELHEIGHT + 10 * VB_PIXELHEIGHT;
	
	display = al_create_display(displaywidth,displayheight);
	if(display == NULL) general_error("Display Creation Error");
	
	/* Font initialization: */
	font = al_load_ttf_font("munro/Munro.ttf",10,ALLEGRO_TTF_MONOCHROME);
	if(font == NULL) general_error("Font Loading Error");
	
	/* Event Queue initialization: */
	queue = al_create_event_queue();
	al_register_event_source(queue,al_get_keyboard_event_source());
	al_register_event_source(queue,al_get_mouse_event_source());
	al_register_event_source(queue,al_get_display_event_source(display));
	
	
	
	/* Main execution cycle: */
	running = 1;
	painting = 0;
	save = 0;
	
	while(running)
	{
		/* Draw Frame: */
		al_draw_filled_rectangle(0,0,displaywidth,
			displayheight - 10 * VB_PIXELHEIGHT,
			al_map_rgb(255,253,208)); /* Cream frame */
		
		/* Draw Save Button: */
		al_draw_filled_rectangle(0,displayheight - 10 * VB_PIXELHEIGHT,
			displaywidth/2,displayheight,al_map_rgb(189,236,182));
		al_draw_text(font,al_map_rgb(30,89,69),displaywidth/4,
			displayheight - 5*VB_PIXELHEIGHT,ALLEGRO_ALIGN_CENTRE |
			ALLEGRO_ALIGN_INTEGER,"save");
		
		/* Draw pixels: */
		for(i=0;i<width;i++){
			for(j=0;j<height;j++){
				k = j*width + i;
				if(GETBIT(data[k/8],k%8)){
					al_draw_filled_rectangle(
						(1+i)*VB_PIXELWIDTH,
						(1+j)*VB_PIXELHEIGHT,
						(2+i)*VB_PIXELWIDTH,
						(2+j)*VB_PIXELHEIGHT,
						al_map_rgb(0,0,0));
				}else{
					al_draw_filled_rectangle(
						(1+i)*VB_PIXELWIDTH,
						(1+j)*VB_PIXELHEIGHT,
						(2+i)*VB_PIXELWIDTH,
						(2+j)*VB_PIXELHEIGHT,
						al_map_rgb(255,255,255));
				}
			}
		}
		
		/* Edit pixels: */
		if(painting){
			al_get_mouse_state(&mouse);
			if(mouse.x > VB_PIXELWIDTH &&
				mouse.x < (width+1)*VB_PIXELWIDTH &&
				mouse.y > VB_PIXELHEIGHT &&
				mouse.y < (height+1)*VB_PIXELHEIGHT){
				
				i = (mouse.x / VB_PIXELWIDTH) - 1;
				j = (mouse.y / VB_PIXELHEIGHT) - 1;
				k = j*width + i;
				if(GETBIT(paint_data[k/8],k%8)){
					data[k/8] = RESETBIT(data[k/8],k%8);
				}else{
					data[k/8] = SETBIT(data[k/8],k%8);
				}
			}
		}
		
		/* Save current image: */
		if(save){
			picture = al_fopen(filename,"w");
			if(picture == NULL) general_error("Error saving file");
			
			al_fwrite(picture,data,bytesize);
			
			al_fclose(picture);
		}
		
		/* Event Processing: */
		if(al_get_next_event(queue,&event)){
			switch(event.type){
				case ALLEGRO_EVENT_MOUSE_BUTTON_DOWN:
					if(event.mouse.y > (height + 2) *
						VB_PIXELHEIGHT && event.mouse.y
						< displayheight){
						if(event.mouse.x < displaywidth/2)
							save = 1;
						else
							running = 0;
					}else{
						memcpy(paint_data,data,bytesize);
						painting = 1;
					}
					break;
				case ALLEGRO_EVENT_MOUSE_BUTTON_UP:
					painting = 0;
					break;
				case ALLEGRO_EVENT_DISPLAY_CLOSE:
					running = 0;
					break;
				default:
					break;
			}
		}
		
		al_flip_display();
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
