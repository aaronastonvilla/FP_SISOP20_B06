#include "ids.h"
#include "fcntl.h"
#include "user.h"

static struct ids_struct current_id;
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);

    int len = strlen(current_line);

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
        current_line[len - 1] = 0;
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
    int i;
    for (i = 0; current_line[i]; ++i){
        if(current_line[i] == ' '){
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
                tokens[token_selanjutnya++] = current_line + i;
            
            current_line[i] = 0;
            ok = 0;
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
            ok = 1;     // copy semua isi current line kedalam tokens
            tokens[token_selanjutnya++] = current_line + i;
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
        return -1;
    
    current_id.nama_user = tokens[0];
    current_id.uid_user = atoi(tokens[1]);
    current_id.gid_user = atoi(tokens[2]);

    return 0;
}

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
    if (dir == 0){
        dir = open(IDS_FILE, O_RDONLY);

        if(dir < 0){        // kalau gagal membuka file
            dir = 0;
            return 0;
        }
    }

    if(get_id() == -1) 
        return 0;
    
    return &current_id;
}

// open file_ids
void setid(void){
    if (dir != 0){
        close(dir);
        dir = 0;
    }

    dir = open(IDS_FILE, O_RDONLY);

    if (dir < 0)
        dir = 0;
}

// tutup file_ids
void endid (void){
    if (dir != 0){
        close(dir);
        dir = 0;
    }
}

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
    setid();

    while (getid()){
        if(strcmp (nama_id, current_id.nama_user) == 0){
            endid();
            return &current_id;
        }
    }
    endid();
    return 0;
}

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
    setid();

    while (getid()){
        if(current_id.uid_user == uid){
            endid();
            return &current_id;
        }
    }
    endid();
    return 0;
}



// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);

    int len = strlen(current_line);

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
        current_line[len - 1] = 0;
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
    int i;
    for (i = 0; current_line[i]; ++i){
        if(current_line[i] == ' '){
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
                tokens[token_selanjutnya++] = current_line + i;
            
            current_line[i] = 0;
            ok = 0;
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
            ok = 1;     // copy semua isi current line kedalam tokens
            tokens[token_selanjutnya++] = current_line + i;
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
        return -1;
    
    current_group.nama_group = tokens[0];
    current_group.gid = atoi(tokens[1]);

    return 0;
}

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
    if (dir == 0){
        dir = open(GROUP_FILE, O_RDONLY);

        if(dir < 0){        // kalau gagal membuka file
            dir = 0;
            return 0;
        }
    }

    if(get_group() == -1) 
        return 0;
    
    return &current_group;
}

// open file_ids
void setgroup(void){
    if (dir != 0){
        close(dir);
        dir = 0;
    }

    dir = open(GROUP_FILE, O_RDONLY);

    if (dir < 0)
        dir = 0;
}

// tutup file_ids
void endgroup (void){
    if (dir != 0){
        close(dir);
        dir = 0;
    }
}

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
    setgroup();

    while (getgroup()){
        if(strcmp (nama_group, current_group.nama_group) == 0){
            endgroup();
            printf(1, "curr_group: %s\n", current_group.nama_group);
            return &current_group;
        }
    }
    endgroup();
    return 0;
}

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
    setgroup();

    while (getgroup()){
        if(current_group.gid == gid){
            endgroup();
            return &current_group;
        }
    }
    endgroup();
    return 0;
}
