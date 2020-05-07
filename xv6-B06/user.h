#include "types.h"

struct stat;
struct rtcdate;
#ifdef BAGIAN_UPROC
struct uproc;
#endif
#ifdef BAGIAN_INODE
enum procstate;
struct proc;
#endif

// system calls
int fork(void);
int exit(void) __attribute__((noreturn));
int wait(void);
int pipe(int*);
int write(int, void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(char*, char**);
int open(char*, int);
int mknod(char*, short, short);
int unlink(char*);
int fstat(int fd, struct stat*);
int link(char*, char*);
int mkdir(char*);
int chdir(char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
int halt(void);
#ifdef BAGIAN_ID
int date(struct rtcdate*);
#endif
#ifdef BAGIAN_UPROC
uint getuid(void);
uint getgid(void);
uint getppid(void);
int setuid(uint);
int setgid(uint);
int getprocs(uint, struct uproc*);
#endif
#ifdef BAGIAN_INODE
int setpriority(int pid, int priority);
#endif
#ifdef LS_EXEC
int chown(char *pathname, int owner, int group);
#endif

// ulib.c
int stat(char*, struct stat*);
char* strcpy(char*, char*);
void *memmove(void*, void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void printf(int, char*, ...);
char* gets(char*, int max);
char* fgets(char*, int, int);
uint strlen(char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);
#ifdef LS_EXEC
int atoo(const char*);
#endif
