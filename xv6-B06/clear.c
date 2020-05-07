#include "types.h"
#include "user.h"

void clear(int ascii){
    // algoritmanya yaitu print enter ("\n")
    // dari ASCII A sampai Z
    // secara rekursif

    if(ascii=='Z')
        return;
    
    printf(1,"\n");
    
    clear(ascii+1);
}

int main(void){
    clear('A');
    exit();
}
