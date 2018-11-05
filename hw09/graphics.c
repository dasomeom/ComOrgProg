/**
* @file graphics.c
* @author Dasom Eom
* @date 10. 30. 2018
* @brief A graphics library for drawing geometry, for Homework 9 of Georgia Tech
*        CS 2110, Fall 2018.
*/

// Please take a look at the header file below to understand what's required for
// each of the functions.
#include "graphics.h"

// Don't touch this. It's used for sorting for the drawFilledPolygon function.
int int_cmp(const void *a, const void *b)
{
    const int *ia = (const int *)a;
    const int *ib = (const int *)b;
    return *ia  - *ib;
}

Pixel noFilter(Pixel c) {
    // Don't touch this.
    return c;
}

// TODO: Complete according to the prototype in graphics.h
Pixel greyscaleFilter(Pixel c) {
    int r = c & 0x1F;
    int g = (c>>5) & 0x1F;
    int b = (c>>10) & 0x1F;
    int n = ((r*77)+(g*151)+(b*28)) >> 8;
    return (n <<10) | (n <<5)| n;


    /*
    Recall that a bitwise AND (&) of 1 and any other bit will be the
    other bit, and recall that a bitwise AND of 0 and any other bit will
    be 0.
    This means that when we AND a bit vector with our mask, wherever
    there is a 1 in the mask, the bit vector keeps its initial value, and
    wherever there is a 0 in the mask, the bit vector will become 0.
    */

}

// TODO: Complete according to the prototype in graphics.h
Pixel redOnlyFilter(Pixel c) {
    int r = c & 0x1F;
    return r;
}

// TODO: Complete according to the prototype in graphics.h
Pixel brighterFilter(Pixel c) {
    int r = c & 0x1F;
    int g = (c>>5) & 0x1F;
    int b = (c>>10) & 0x1F;
    int max = 0x1F;
    int rr = max - r;
    int gg = max - g;
    int bb = max - b;
    rr = r + (rr >> 1);
    gg = g + (gg >> 1);
    bb = b + (bb >> 1);
    return (bb <<10) | (gg <<5)| rr;
}


// TODO: Complete according to the prototype in graphics.h
void drawPixel(Screen *screen, Vector coordinates, Pixel pixel) {
    if (0 >coordinates.x || coordinates.x > screen->size.x-1
    ||  0 >coordinates.y || coordinates.y > screen->size.y-1 ) {
        return;
    }
    screen->buffer[((coordinates.y*(screen->size.x))+coordinates.x)] = pixel;
}

// TODO: Complete according to the prototype in graphics.h
void drawFilledRectangle(Screen *screen, Rectangle *rectangle) {
    for(int r = 0; r < rectangle->size.y; r++) {
        for (int c = 0; c < rectangle->size.x; c++) {
            Vector coor = {rectangle->top_left.x + c, rectangle->top_left.y + r};
            drawPixel(screen, coor, rectangle->color);
        }
    }
}

// TODO: Complete according to the prototype in graphics.h
void drawLine(Screen *screen, Line *line) {
    int bool = 0;
    int x = line->start.x;
    int y = line->start.y;
    int xx = line->end.x;
    int yy = line->end.y;
	int dx = abs(xx - x);
    int dy = abs(yy - y);
	int signx = 0;
    if(xx < x) {signx = -1;}
    else {signx = 1;}
    int signy = 0;
    if (yy < y) {signy = -1;}
    else {signy = 1;}

	if (dy > dx) {
	    bool = 1;
	    int temp = dx;
	    dx = dy;
	    dy = temp;
	}
    int e = 2 * dy - dx;
	for (int i = 1; i <= dx; i++) {
	    Vector coor = {x, y};
	    drawPixel(screen,coor, line->color);
	    while (e>= 0) {
	        if (bool == 1) { x = x + signx;}
	        else {y = y + signy;}
	        e = e - 2 * dx;
	    }

	    if (bool == 1) { y += signy; }
	    else { x += signx; }
        e = e + 2 * dy;
	}
	Vector coor2 = {xx, yy};
	drawPixel(screen,coor2,line->color);

}


// TODO: Complete according to the prototype in graphics.h
void drawPolygon(Screen *screen, Polygon *polygon) {
    for (int i = 0; i < polygon->num_vertices; i++) {
        int tmp = (i+1)%polygon->num_vertices;
        Line ab;
        ab.start = polygon->vertices[i];
        ab.end = polygon->vertices[tmp];
        ab.color = polygon->color;
        drawLine(screen, &ab);

        // polygon->color = (*polygon).color
    }
}

// TODO: Complete according to the prototype in graphics.h
void drawFilledPolygon(Screen *screen, Polygon *polygon) {
	int min_y = INT_MAX;
    int max_y = INT_MIN;

    for (int i = 0; i < polygon->num_vertices; i++) {
        if (min_y > polygon->vertices[i].y) { min_y = polygon->vertices[i].y; }
        else if (max_y < polygon->vertices[i].y) {max_y = polygon->vertices[i].y;}
    }
    // Now we iterate through the rows of our polygon
	for (int row = min_y; row <= max_y; row++) {
        // This variable contains the number of nodes found. We start with 0.
		int nNodes = 0;

        // This array will contain the X coords of the nodes we find.
        // Note that there are at most num_vertices of those. We allocate
        // that much room, but at any time only the first nNodes ints will
        // be our actual data.
        int nodeX[polygon->num_vertices];

        // This loop finds the nodes on this row. It intersects the line
        // segments between consecutive pairs of vertices with the horizontal
        // line corresponding to the row we're on. Don't worry about the
        // details, it just works.
		int j = polygon->num_vertices - 1;
		for (int i = 0; i < polygon->num_vertices; i++) {
			if ((polygon->vertices[i].y < row && polygon->vertices[j].y >= row) ||
				(polygon->vertices[j].y < row && polygon->vertices[i].y >= row)) {
				nodeX[nNodes++] = (polygon->vertices[i].x +
                    (row - polygon->vertices[i].y) *
                    (polygon->vertices[j].x - polygon->vertices[i].x) /
                    (polygon->vertices[j].y - polygon->vertices[i].y));
			}
			j = i;
		}

        //qsort(nodeX, nNodes, sizeof(int *), int_cmp);
        int eye =0;
        while (eye<nNodes-1) {
            if (nodeX[eye]>nodeX[eye+1]) {
                int swap=nodeX[eye];
                nodeX[eye]=nodeX[eye+1];
                nodeX[eye+1]=swap;
                if (eye) eye--; }
            else {
                eye++; }
        }


        // ---------------------------------------------------------------------
        // TODO: Make a call to qsort here to sort the nodeX array we made,
        // from small to large x coordinate. Note that there are nNodes elements
        // that we want to sort, and each is an integer. We give you int_cmp
        // at the top of the file to use as the comparator for the qsort call,
        // so you can just pass it to qsort and not need to write your own
        // comparator.
        // ---------------------------------------------------------------------
        // ---------------------------------------------------------------------
        // END OF TODO
        // ---------------------------------------------------------------------



        // ---------------------------------------------------------------------
        // TODO: Now we fill the x coordinates corresponding to the interior of
        // the polygon. Note that after every node we switch sides on the
        // polygon, that is, if we are on the outside, when we pass a node we
        // end up on the inside, and if are inside, we end up on the outside.
        // As a result, all you need to do is start at the 0th node, iterate
        // through all of the even-indexed nodes, and fill until the next node.
        // For example, you need to fill between nodes 0-1, between nodes 2-3,
        // nodes 4-5 etc. but not between nodes 1-2, or nodes 3-4.
        // ---------------------------------------------------------------------
        for (int i=0; i<nNodes; i+=2) {
            if   (nodeX[i]>= screen->size.x) break;
            if   (nodeX[i+1]> 0) {
                if (nodeX[i]< 0) {nodeX[i]= 0;}
                if (nodeX[i+1]> screen->size.x) {nodeX[i+1]=screen->size.x;}
                for (int a = nodeX[i]; a < nodeX[i+1]; a++) {
                    Vector vec = {a, row};
                    drawPixel(screen, vec, polygon->color);
                }
            }
	    }


        // ---------------------------------------------------------------------
        // END OF TODO
        // ---------------------------------------------------------------------
	}
}

// TODO: Complete according to the prototype in graphics.h
void drawRectangle(Screen *screen, Rectangle *rectangle) {
    Polygon rect;
    rect.num_vertices = 4;
    rect.color = rectangle->color;


    Vector vertex_arr[4];
    vertex_arr[0] = (Vector) {rectangle->top_left.x, rectangle->top_left.y};
    vertex_arr[1]= (Vector){ rectangle->top_left.x, rectangle->top_left.y + rectangle->size.y - 1};
    vertex_arr[2] = (Vector){ rectangle->top_left.x + rectangle->size.x - 1, rectangle->top_left.y + rectangle->size.y - 1};
    vertex_arr[3] = (Vector){ rectangle->top_left.x + rectangle->size.x - 1, rectangle->top_left.y};
    rect.vertices = vertex_arr;
    drawPolygon(screen, &rect);
}

// TODO: Complete according to the prototype in graphics.h
void drawCircle(Screen *screen, Circle *circle) {
    int y = circle->radius;
    int x = 0;
    int d = 1 - y;
    int x0 = circle->center.x;
    int y0 = circle->center.y;
    while (x <= y) {
        Vector one = {x0 + x, y0 + y};
        drawPixel(screen, one, circle->color);

        Vector two = {x0 + x, y0 - y};
        drawPixel(screen, two, circle->color);

        Vector one2 = {x0 - x, y0 + y};
        drawPixel(screen, one2, circle->color);

        Vector one3 = {x0 - x, y0 - y};
        drawPixel(screen, one3, circle->color);

        Vector one4 = {x0 + y, y0 + x};
        drawPixel(screen, one4, circle->color);

        Vector one5 = {x0 + y, y0 - x};
        drawPixel(screen, one5, circle->color);

        Vector one6 = {x0 - y, y0 + x};
        drawPixel(screen, one6, circle->color);

        Vector one7 = {x0 - y, y0 - x};
        drawPixel(screen, one7, circle->color);

        if (d < 0) {
            d = d + 2 * x + 3;
            x += 1;
        } else {
            d = d + 2 * (x - y) + 5;
            x += 1;
            y -= 1;
        }


    }
}

// TODO: Complete according to the prototype in graphics.h
void drawFilledCircle(Screen *screen, Circle *circle) {
    int y = circle->radius;
    int x = 0;
    int d = 1 - y;
    int x0 = circle->center.x;
    int y0 = circle->center.y;
    Pixel aColor = circle->color;

    while(y >= x)
    {
        Line one;
        one.start = (Vector) {x0 + x, y0 + y};
        one.end = (Vector) {x0 + x, (y0 > y) ? (y0 - y) : 0};
        one.color = aColor;
        drawLine(screen, &one);

        if (x0 >= x) {
            Line two;
            two.start = (Vector) {x0 - x, y0 + y};
            two.end = (Vector) {x0 - x, (y0 > y) ? (y0 - y) : 0};
            two.color = aColor;
            drawLine(screen, &two);
        }

        Line three;
        three.start = (Vector) {x0 + y, y0 + x};
        three.end = (Vector) {x0 + y, (y0 > x) ? (y0 - x) : 0};
        three.color = aColor;
        drawLine(screen, &three);

        if (x0 >= y) {
            Line four;
            four.start = (Vector) {x0 - y, y0 + x};
            four.end = (Vector) {x0 - y, (y0 > x) ? (y0 - x) : 0};
            four.color = aColor;
            drawLine(screen, &four);
        }

        if (d<0) {
            d = d + 2 * x + 3;
            x += 1;
        } else {
            d = d + 2 * (x-y) + 5;
            x += 1;
            y -= 1;
        }
    }
}

// TODO: Complete according to the prototype in graphics.h
void drawImage(Screen *screen, Image *image, Pixel (*colorFilter)(Pixel)) {
    for(int r = 0; r < image->size.y; r++) {
        for (int c = 0; c < image->size.x; c++) {
            Vector coor = {image->top_left.x + c, image->top_left.y + r};
            Pixel pix = image->buffer[((r)*(image->size.x))+c];
            drawPixel(screen, coor, colorFilter(pix));

        }
    }
}

// TODO: Complete according to the prototype in graphics.
Image rotateImage(Image *image, int degrees) {
    Image ni;
    if ((degrees/90)% 4 == 0) {
        ni.top_left = (Vector) {image->top_left.x, image->top_left.y};
        ni.size = (Vector) {image->size.x, image->size.y};
        ni.buffer = (malloc((image->size.x * image->size.y) * sizeof(Pixel)));
        for(int i = 0; i < ((image->size.x) * (image->size.y)); i++) {
            ni.buffer[i] = image->buffer[i];
        }
    } else if ((degrees/90)% 4 == 1 || (degrees/90)% 4 == -3) {
        ni.top_left = (Vector) {image->top_left.x, image->top_left.y};
        ni.size = (Vector) {image->size.y, image->size.x};
        ni.buffer = (malloc((image->size.x * image->size.y) * sizeof(Pixel)));
        int aa = 0;
        for(int c = image->size.x - 1; c >= 0; c--) {
            for (int r = 0; r < image->size.y; r++) {
                ni.buffer[aa] = image->buffer[((r)*(image->size.x))+c];
                aa++;
            }
        }
    } else if ((degrees/90)% 4 == 2 || (degrees/90)% 4 == -2) {
        ni.top_left = (Vector) {image->top_left.x, image->top_left.y};
        ni.size = (Vector) {image->size.x, image->size.y};
        ni.buffer = (malloc((image->size.x * image->size.y) * sizeof(Pixel)));
        int k = (image->size.x) * (image->size.y) - 1;
        for(int i = 0; i < ((image->size.x) * (image->size.y)); i++) {
            ni.buffer[i] = image->buffer[k];
            k--;
        }
    } else {
        ni.top_left = (Vector) {image->top_left.x, image->top_left.y};
        ni.size = (Vector) {image->size.y, image->size.x};
        ni.buffer = (malloc((image->size.x * image->size.y) * sizeof(Pixel)));
        int aa = 0;
        for(int c = 0; c < image->size.x; c++) {
            for (int r = image->size.y - 1; r >= 0; r--) {
                ni.buffer[aa] = image->buffer[((r)*(image->size.x))+c];
                aa++;
            }
        }

    }
    return ni;

}
