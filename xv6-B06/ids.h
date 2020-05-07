#include "types.h"

#define PANJANG_LINE 32
#define JUMLAH_TOKEN 3
#define IDS_FILE "id_file"
#define GROUP_FILE "group_file"

struct ids_struct
{
    char* nama_user;
    uid_t uid_user;
    gid_t gid_user;
};

struct group_struct
{
    char* nama_group;
    uid_t gid;
};

// ids
struct ids_struct* cek_nama(const char* nama_id);
struct ids_struct* cek_uid(uid_t uid);
struct ids_struct* getid(void);
void setid(void);
void endid (void);

// group
struct group_struct* getgroup(void);
void setgroup(void);
void endgroup (void);
struct group_struct* cek_nama_group(const char* nama_group);
struct group_struct* cek_gid(gid_t gid);