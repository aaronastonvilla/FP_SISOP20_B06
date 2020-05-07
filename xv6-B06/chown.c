// CHOWN:
// Argumen: chown UID:GROUP file

#ifdef LS_EXEC
#include "user.h"
#include "ids.h"

int main(int argc, char **argv) {
    if (argc != 3) {
        printf(1, "Untuk menggunakan chown:\n");
        printf(1, "chown nama_user:nama_group nama_file.\n");
        exit();
    }

    char *path = argv[2];
    char *user = argv[1];
    char *group;
    int group_id, user_id;

    // kalau misal di chown ada nama group
    // maka string dipisah
    if ((group = strchr(argv[1], ':'))){
        *group = 0;     // pointer dimana ':' ada menjadi akhir bagi
                        // string user (NULL)
        group++;      // pointer dipindah 1 char setelah ':'
    }

    printf(1, "user: %s\ngroup: %s\n", user, group);
    
    // ngambil uid
    struct ids_struct* uid_sekarang = 0;
    // uid_t uid = -1;

    if(user[0]){
        uid_sekarang = cek_nama(user);

        if(uid_sekarang == 0){
            printf(2, "User %s tidak ditemukan", user);
            exit();
        }

        user_id = uid_sekarang->uid_user;
    }

    // ngambil gid
    struct group_struct* gid_sekarang = 0;

    if(group){
        gid_sekarang = cek_nama_group(group);
        // printf(1, "group sekarang: %s\n", gid_sekarang->nama_group);
        // printf(1, "gid: %d\n", gid_sekarang->gid);
        
        if(gid_sekarang == 0){
            printf(2, "Group %s tidak ditemukan\n", group);
            exit();
        }

        group_id = gid_sekarang->gid;
    }

    printf(1, "uid: %d\n\ngid: %d\n", user_id, group_id);

    int run;
    run = chown(path, user_id, 69);
    
    if (run < 0) {
        if (run == -1) {
            printf(1, "chown: Nama file salah!\n");
        }
        else if (run == -2) {
            printf(1, "chown: UID salah!\n");
        }
        else if (run == -3) {
            printf(1, "chown: GID salah!.\n");
        }
    }   
    exit();
}
#endif
