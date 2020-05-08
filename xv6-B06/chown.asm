
_chown:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

#ifdef LS_EXEC
#include "user.h"
#include "ids.h"

int main(int argc, char **argv) {
       0:	f3 0f 1e fb          	endbr32 
       4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       8:	83 e4 f0             	and    $0xfffffff0,%esp
       b:	ff 71 fc             	pushl  -0x4(%ecx)
       e:	55                   	push   %ebp
       f:	89 e5                	mov    %esp,%ebp
      11:	51                   	push   %ecx
      12:	83 ec 24             	sub    $0x24,%esp
      15:	89 c8                	mov    %ecx,%eax
    if (argc != 3) {
      17:	83 38 03             	cmpl   $0x3,(%eax)
      1a:	74 29                	je     45 <main+0x45>
        printf(1, "Untuk menggunakan chown:\n");
      1c:	83 ec 08             	sub    $0x8,%esp
      1f:	68 58 10 00 00       	push   $0x1058
      24:	6a 01                	push   $0x1
      26:	e8 10 07 00 00       	call   73b <printf>
      2b:	83 c4 10             	add    $0x10,%esp
        printf(1, "chown nama_user:nama_group nama_file.\n");
      2e:	83 ec 08             	sub    $0x8,%esp
      31:	68 74 10 00 00       	push   $0x1074
      36:	6a 01                	push   $0x1
      38:	e8 fe 06 00 00       	call   73b <printf>
      3d:	83 c4 10             	add    $0x10,%esp
        exit();
      40:	e8 2a 05 00 00       	call   56f <exit>
    }

    char *path = argv[2];
      45:	8b 50 04             	mov    0x4(%eax),%edx
      48:	8b 52 08             	mov    0x8(%edx),%edx
      4b:	89 55 e8             	mov    %edx,-0x18(%ebp)
    char *user = argv[1];
      4e:	8b 50 04             	mov    0x4(%eax),%edx
      51:	8b 52 04             	mov    0x4(%edx),%edx
      54:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    char *group;
    int group_id, user_id;

    // kalau misal di chown ada nama group
    // maka string dipisah
    if ((group = strchr(argv[1], ':'))){
      57:	8b 40 04             	mov    0x4(%eax),%eax
      5a:	83 c0 04             	add    $0x4,%eax
      5d:	8b 00                	mov    (%eax),%eax
      5f:	83 ec 08             	sub    $0x8,%esp
      62:	6a 3a                	push   $0x3a
      64:	50                   	push   %eax
      65:	e8 25 02 00 00       	call   28f <strchr>
      6a:	83 c4 10             	add    $0x10,%esp
      6d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      70:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      74:	74 0a                	je     80 <main+0x80>
        *group = 0;     // pointer dimana ':' ada menjadi akhir bagi
      76:	8b 45 f4             	mov    -0xc(%ebp),%eax
      79:	c6 00 00             	movb   $0x0,(%eax)
                        // string user (NULL)
        group++;      // pointer dipindah 1 char setelah ':'
      7c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }

    printf(1, "user: %s\ngroup: %s\n", user, group);
      80:	ff 75 f4             	pushl  -0xc(%ebp)
      83:	ff 75 e4             	pushl  -0x1c(%ebp)
      86:	68 9b 10 00 00       	push   $0x109b
      8b:	6a 01                	push   $0x1
      8d:	e8 a9 06 00 00       	call   73b <printf>
      92:	83 c4 10             	add    $0x10,%esp
    
    // ngambil uid
    struct ids_struct* uid_sekarang = 0;
      95:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    // uid_t uid = -1;

    if(user[0]){
      9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      9f:	0f b6 00             	movzbl (%eax),%eax
      a2:	84 c0                	test   %al,%al
      a4:	74 3a                	je     e0 <main+0xe0>
        uid_sekarang = cek_nama(user);
      a6:	83 ec 0c             	sub    $0xc,%esp
      a9:	ff 75 e4             	pushl  -0x1c(%ebp)
      ac:	e8 73 0c 00 00       	call   d24 <cek_nama>
      b1:	83 c4 10             	add    $0x10,%esp
      b4:	89 45 e0             	mov    %eax,-0x20(%ebp)

        if(uid_sekarang == 0){
      b7:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      bb:	75 1a                	jne    d7 <main+0xd7>
            printf(2, "User %s tidak ditemukan", user);
      bd:	83 ec 04             	sub    $0x4,%esp
      c0:	ff 75 e4             	pushl  -0x1c(%ebp)
      c3:	68 af 10 00 00       	push   $0x10af
      c8:	6a 02                	push   $0x2
      ca:	e8 6c 06 00 00       	call   73b <printf>
      cf:	83 c4 10             	add    $0x10,%esp
            exit();
      d2:	e8 98 04 00 00       	call   56f <exit>
        }

        user_id = uid_sekarang->uid_user;
      d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
      da:	8b 40 04             	mov    0x4(%eax),%eax
      dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    }

    // ngambil gid
    struct group_struct* gid_sekarang = 0;
      e0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)

    if(group){
      e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      eb:	74 3a                	je     127 <main+0x127>
        gid_sekarang = cek_nama_group(group);
      ed:	83 ec 0c             	sub    $0xc,%esp
      f0:	ff 75 f4             	pushl  -0xc(%ebp)
      f3:	e8 c0 0e 00 00       	call   fb8 <cek_nama_group>
      f8:	83 c4 10             	add    $0x10,%esp
      fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
        // printf(1, "group sekarang: %s\n", gid_sekarang->nama_group);
        // printf(1, "gid: %d\n", gid_sekarang->gid);
        
        if(gid_sekarang == 0){
      fe:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     102:	75 1a                	jne    11e <main+0x11e>
            printf(2, "Group %s tidak ditemukan\n", group);
     104:	83 ec 04             	sub    $0x4,%esp
     107:	ff 75 f4             	pushl  -0xc(%ebp)
     10a:	68 c7 10 00 00       	push   $0x10c7
     10f:	6a 02                	push   $0x2
     111:	e8 25 06 00 00       	call   73b <printf>
     116:	83 c4 10             	add    $0x10,%esp
            exit();
     119:	e8 51 04 00 00       	call   56f <exit>
        }

        group_id = gid_sekarang->gid;
     11e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     121:	8b 40 04             	mov    0x4(%eax),%eax
     124:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }

    printf(1, "uid: %d\n\ngid: %d\n", user_id, group_id);
     127:	ff 75 f0             	pushl  -0x10(%ebp)
     12a:	ff 75 ec             	pushl  -0x14(%ebp)
     12d:	68 e1 10 00 00       	push   $0x10e1
     132:	6a 01                	push   $0x1
     134:	e8 02 06 00 00       	call   73b <printf>
     139:	83 c4 10             	add    $0x10,%esp

    int run;
    run = chown(path, user_id, 69);
     13c:	83 ec 04             	sub    $0x4,%esp
     13f:	6a 45                	push   $0x45
     141:	ff 75 ec             	pushl  -0x14(%ebp)
     144:	ff 75 e8             	pushl  -0x18(%ebp)
     147:	e8 0b 05 00 00       	call   657 <chown>
     14c:	83 c4 10             	add    $0x10,%esp
     14f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    
    if (run < 0) {
     152:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
     156:	79 4c                	jns    1a4 <main+0x1a4>
        if (run == -1) {
     158:	83 7d d8 ff          	cmpl   $0xffffffff,-0x28(%ebp)
     15c:	75 14                	jne    172 <main+0x172>
            printf(1, "chown: Nama file salah!\n");
     15e:	83 ec 08             	sub    $0x8,%esp
     161:	68 f3 10 00 00       	push   $0x10f3
     166:	6a 01                	push   $0x1
     168:	e8 ce 05 00 00       	call   73b <printf>
     16d:	83 c4 10             	add    $0x10,%esp
     170:	eb 32                	jmp    1a4 <main+0x1a4>
        }
        else if (run == -2) {
     172:	83 7d d8 fe          	cmpl   $0xfffffffe,-0x28(%ebp)
     176:	75 14                	jne    18c <main+0x18c>
            printf(1, "chown: UID salah!\n");
     178:	83 ec 08             	sub    $0x8,%esp
     17b:	68 0c 11 00 00       	push   $0x110c
     180:	6a 01                	push   $0x1
     182:	e8 b4 05 00 00       	call   73b <printf>
     187:	83 c4 10             	add    $0x10,%esp
     18a:	eb 18                	jmp    1a4 <main+0x1a4>
        }
        else if (run == -3) {
     18c:	83 7d d8 fd          	cmpl   $0xfffffffd,-0x28(%ebp)
     190:	75 12                	jne    1a4 <main+0x1a4>
            printf(1, "chown: GID salah!.\n");
     192:	83 ec 08             	sub    $0x8,%esp
     195:	68 1f 11 00 00       	push   $0x111f
     19a:	6a 01                	push   $0x1
     19c:	e8 9a 05 00 00       	call   73b <printf>
     1a1:	83 c4 10             	add    $0x10,%esp
        }
    }   
    exit();
     1a4:	e8 c6 03 00 00       	call   56f <exit>

000001a9 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     1a9:	55                   	push   %ebp
     1aa:	89 e5                	mov    %esp,%ebp
     1ac:	57                   	push   %edi
     1ad:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     1ae:	8b 4d 08             	mov    0x8(%ebp),%ecx
     1b1:	8b 55 10             	mov    0x10(%ebp),%edx
     1b4:	8b 45 0c             	mov    0xc(%ebp),%eax
     1b7:	89 cb                	mov    %ecx,%ebx
     1b9:	89 df                	mov    %ebx,%edi
     1bb:	89 d1                	mov    %edx,%ecx
     1bd:	fc                   	cld    
     1be:	f3 aa                	rep stos %al,%es:(%edi)
     1c0:	89 ca                	mov    %ecx,%edx
     1c2:	89 fb                	mov    %edi,%ebx
     1c4:	89 5d 08             	mov    %ebx,0x8(%ebp)
     1c7:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     1ca:	90                   	nop
     1cb:	5b                   	pop    %ebx
     1cc:	5f                   	pop    %edi
     1cd:	5d                   	pop    %ebp
     1ce:	c3                   	ret    

000001cf <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     1cf:	f3 0f 1e fb          	endbr32 
     1d3:	55                   	push   %ebp
     1d4:	89 e5                	mov    %esp,%ebp
     1d6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     1d9:	8b 45 08             	mov    0x8(%ebp),%eax
     1dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     1df:	90                   	nop
     1e0:	8b 55 0c             	mov    0xc(%ebp),%edx
     1e3:	8d 42 01             	lea    0x1(%edx),%eax
     1e6:	89 45 0c             	mov    %eax,0xc(%ebp)
     1e9:	8b 45 08             	mov    0x8(%ebp),%eax
     1ec:	8d 48 01             	lea    0x1(%eax),%ecx
     1ef:	89 4d 08             	mov    %ecx,0x8(%ebp)
     1f2:	0f b6 12             	movzbl (%edx),%edx
     1f5:	88 10                	mov    %dl,(%eax)
     1f7:	0f b6 00             	movzbl (%eax),%eax
     1fa:	84 c0                	test   %al,%al
     1fc:	75 e2                	jne    1e0 <strcpy+0x11>
    ;
  return os;
     1fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     201:	c9                   	leave  
     202:	c3                   	ret    

00000203 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     203:	f3 0f 1e fb          	endbr32 
     207:	55                   	push   %ebp
     208:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     20a:	eb 08                	jmp    214 <strcmp+0x11>
    p++, q++;
     20c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     210:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     214:	8b 45 08             	mov    0x8(%ebp),%eax
     217:	0f b6 00             	movzbl (%eax),%eax
     21a:	84 c0                	test   %al,%al
     21c:	74 10                	je     22e <strcmp+0x2b>
     21e:	8b 45 08             	mov    0x8(%ebp),%eax
     221:	0f b6 10             	movzbl (%eax),%edx
     224:	8b 45 0c             	mov    0xc(%ebp),%eax
     227:	0f b6 00             	movzbl (%eax),%eax
     22a:	38 c2                	cmp    %al,%dl
     22c:	74 de                	je     20c <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
     22e:	8b 45 08             	mov    0x8(%ebp),%eax
     231:	0f b6 00             	movzbl (%eax),%eax
     234:	0f b6 d0             	movzbl %al,%edx
     237:	8b 45 0c             	mov    0xc(%ebp),%eax
     23a:	0f b6 00             	movzbl (%eax),%eax
     23d:	0f b6 c0             	movzbl %al,%eax
     240:	29 c2                	sub    %eax,%edx
     242:	89 d0                	mov    %edx,%eax
}
     244:	5d                   	pop    %ebp
     245:	c3                   	ret    

00000246 <strlen>:

uint
strlen(char *s)
{
     246:	f3 0f 1e fb          	endbr32 
     24a:	55                   	push   %ebp
     24b:	89 e5                	mov    %esp,%ebp
     24d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     250:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     257:	eb 04                	jmp    25d <strlen+0x17>
     259:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     25d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     260:	8b 45 08             	mov    0x8(%ebp),%eax
     263:	01 d0                	add    %edx,%eax
     265:	0f b6 00             	movzbl (%eax),%eax
     268:	84 c0                	test   %al,%al
     26a:	75 ed                	jne    259 <strlen+0x13>
    ;
  return n;
     26c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     26f:	c9                   	leave  
     270:	c3                   	ret    

00000271 <memset>:

void*
memset(void *dst, int c, uint n)
{
     271:	f3 0f 1e fb          	endbr32 
     275:	55                   	push   %ebp
     276:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     278:	8b 45 10             	mov    0x10(%ebp),%eax
     27b:	50                   	push   %eax
     27c:	ff 75 0c             	pushl  0xc(%ebp)
     27f:	ff 75 08             	pushl  0x8(%ebp)
     282:	e8 22 ff ff ff       	call   1a9 <stosb>
     287:	83 c4 0c             	add    $0xc,%esp
  return dst;
     28a:	8b 45 08             	mov    0x8(%ebp),%eax
}
     28d:	c9                   	leave  
     28e:	c3                   	ret    

0000028f <strchr>:

char*
strchr(const char *s, char c)
{
     28f:	f3 0f 1e fb          	endbr32 
     293:	55                   	push   %ebp
     294:	89 e5                	mov    %esp,%ebp
     296:	83 ec 04             	sub    $0x4,%esp
     299:	8b 45 0c             	mov    0xc(%ebp),%eax
     29c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     29f:	eb 14                	jmp    2b5 <strchr+0x26>
    if(*s == c)
     2a1:	8b 45 08             	mov    0x8(%ebp),%eax
     2a4:	0f b6 00             	movzbl (%eax),%eax
     2a7:	38 45 fc             	cmp    %al,-0x4(%ebp)
     2aa:	75 05                	jne    2b1 <strchr+0x22>
      return (char*)s;
     2ac:	8b 45 08             	mov    0x8(%ebp),%eax
     2af:	eb 13                	jmp    2c4 <strchr+0x35>
  for(; *s; s++)
     2b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2b5:	8b 45 08             	mov    0x8(%ebp),%eax
     2b8:	0f b6 00             	movzbl (%eax),%eax
     2bb:	84 c0                	test   %al,%al
     2bd:	75 e2                	jne    2a1 <strchr+0x12>
  return 0;
     2bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2c4:	c9                   	leave  
     2c5:	c3                   	ret    

000002c6 <gets>:

char*
gets(char *buf, int max)
{
     2c6:	f3 0f 1e fb          	endbr32 
     2ca:	55                   	push   %ebp
     2cb:	89 e5                	mov    %esp,%ebp
     2cd:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2d7:	eb 42                	jmp    31b <gets+0x55>
    cc = read(0, &c, 1);
     2d9:	83 ec 04             	sub    $0x4,%esp
     2dc:	6a 01                	push   $0x1
     2de:	8d 45 ef             	lea    -0x11(%ebp),%eax
     2e1:	50                   	push   %eax
     2e2:	6a 00                	push   $0x0
     2e4:	e8 9e 02 00 00       	call   587 <read>
     2e9:	83 c4 10             	add    $0x10,%esp
     2ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     2ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     2f3:	7e 33                	jle    328 <gets+0x62>
      break;
    buf[i++] = c;
     2f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2f8:	8d 50 01             	lea    0x1(%eax),%edx
     2fb:	89 55 f4             	mov    %edx,-0xc(%ebp)
     2fe:	89 c2                	mov    %eax,%edx
     300:	8b 45 08             	mov    0x8(%ebp),%eax
     303:	01 c2                	add    %eax,%edx
     305:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     309:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     30b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     30f:	3c 0a                	cmp    $0xa,%al
     311:	74 16                	je     329 <gets+0x63>
     313:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     317:	3c 0d                	cmp    $0xd,%al
     319:	74 0e                	je     329 <gets+0x63>
  for(i=0; i+1 < max; ){
     31b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     31e:	83 c0 01             	add    $0x1,%eax
     321:	39 45 0c             	cmp    %eax,0xc(%ebp)
     324:	7f b3                	jg     2d9 <gets+0x13>
     326:	eb 01                	jmp    329 <gets+0x63>
      break;
     328:	90                   	nop
      break;
  }
  buf[i] = '\0';
     329:	8b 55 f4             	mov    -0xc(%ebp),%edx
     32c:	8b 45 08             	mov    0x8(%ebp),%eax
     32f:	01 d0                	add    %edx,%eax
     331:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     334:	8b 45 08             	mov    0x8(%ebp),%eax
}
     337:	c9                   	leave  
     338:	c3                   	ret    

00000339 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
     339:	f3 0f 1e fb          	endbr32 
     33d:	55                   	push   %ebp
     33e:	89 e5                	mov    %esp,%ebp
     340:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
     343:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     34a:	eb 43                	jmp    38f <fgets+0x56>
    int cc = read(fd, &c, 1);
     34c:	83 ec 04             	sub    $0x4,%esp
     34f:	6a 01                	push   $0x1
     351:	8d 45 ef             	lea    -0x11(%ebp),%eax
     354:	50                   	push   %eax
     355:	ff 75 10             	pushl  0x10(%ebp)
     358:	e8 2a 02 00 00       	call   587 <read>
     35d:	83 c4 10             	add    $0x10,%esp
     360:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     363:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     367:	7e 33                	jle    39c <fgets+0x63>
      break;
    buf[i++] = c;
     369:	8b 45 f4             	mov    -0xc(%ebp),%eax
     36c:	8d 50 01             	lea    0x1(%eax),%edx
     36f:	89 55 f4             	mov    %edx,-0xc(%ebp)
     372:	89 c2                	mov    %eax,%edx
     374:	8b 45 08             	mov    0x8(%ebp),%eax
     377:	01 c2                	add    %eax,%edx
     379:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     37d:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     37f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     383:	3c 0a                	cmp    $0xa,%al
     385:	74 16                	je     39d <fgets+0x64>
     387:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     38b:	3c 0d                	cmp    $0xd,%al
     38d:	74 0e                	je     39d <fgets+0x64>
  for(i = 0; i + 1 < size;){
     38f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     392:	83 c0 01             	add    $0x1,%eax
     395:	39 45 0c             	cmp    %eax,0xc(%ebp)
     398:	7f b2                	jg     34c <fgets+0x13>
     39a:	eb 01                	jmp    39d <fgets+0x64>
      break;
     39c:	90                   	nop
      break;
  }
  buf[i] = '\0';
     39d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3a0:	8b 45 08             	mov    0x8(%ebp),%eax
     3a3:	01 d0                	add    %edx,%eax
     3a5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     3a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3ab:	c9                   	leave  
     3ac:	c3                   	ret    

000003ad <stat>:

int
stat(char *n, struct stat *st)
{
     3ad:	f3 0f 1e fb          	endbr32 
     3b1:	55                   	push   %ebp
     3b2:	89 e5                	mov    %esp,%ebp
     3b4:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3b7:	83 ec 08             	sub    $0x8,%esp
     3ba:	6a 00                	push   $0x0
     3bc:	ff 75 08             	pushl  0x8(%ebp)
     3bf:	e8 eb 01 00 00       	call   5af <open>
     3c4:	83 c4 10             	add    $0x10,%esp
     3c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     3ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3ce:	79 07                	jns    3d7 <stat+0x2a>
    return -1;
     3d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3d5:	eb 25                	jmp    3fc <stat+0x4f>
  r = fstat(fd, st);
     3d7:	83 ec 08             	sub    $0x8,%esp
     3da:	ff 75 0c             	pushl  0xc(%ebp)
     3dd:	ff 75 f4             	pushl  -0xc(%ebp)
     3e0:	e8 e2 01 00 00       	call   5c7 <fstat>
     3e5:	83 c4 10             	add    $0x10,%esp
     3e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     3eb:	83 ec 0c             	sub    $0xc,%esp
     3ee:	ff 75 f4             	pushl  -0xc(%ebp)
     3f1:	e8 a1 01 00 00       	call   597 <close>
     3f6:	83 c4 10             	add    $0x10,%esp
  return r;
     3f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     3fc:	c9                   	leave  
     3fd:	c3                   	ret    

000003fe <atoi>:

int
atoi(const char *s)
{
     3fe:	f3 0f 1e fb          	endbr32 
     402:	55                   	push   %ebp
     403:	89 e5                	mov    %esp,%ebp
     405:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     408:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     40f:	eb 04                	jmp    415 <atoi+0x17>
     411:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     415:	8b 45 08             	mov    0x8(%ebp),%eax
     418:	0f b6 00             	movzbl (%eax),%eax
     41b:	3c 20                	cmp    $0x20,%al
     41d:	74 f2                	je     411 <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
     41f:	8b 45 08             	mov    0x8(%ebp),%eax
     422:	0f b6 00             	movzbl (%eax),%eax
     425:	3c 2d                	cmp    $0x2d,%al
     427:	75 07                	jne    430 <atoi+0x32>
     429:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     42e:	eb 05                	jmp    435 <atoi+0x37>
     430:	b8 01 00 00 00       	mov    $0x1,%eax
     435:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     438:	8b 45 08             	mov    0x8(%ebp),%eax
     43b:	0f b6 00             	movzbl (%eax),%eax
     43e:	3c 2b                	cmp    $0x2b,%al
     440:	74 0a                	je     44c <atoi+0x4e>
     442:	8b 45 08             	mov    0x8(%ebp),%eax
     445:	0f b6 00             	movzbl (%eax),%eax
     448:	3c 2d                	cmp    $0x2d,%al
     44a:	75 2b                	jne    477 <atoi+0x79>
    s++;
     44c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     450:	eb 25                	jmp    477 <atoi+0x79>
    n = n*10 + *s++ - '0';
     452:	8b 55 fc             	mov    -0x4(%ebp),%edx
     455:	89 d0                	mov    %edx,%eax
     457:	c1 e0 02             	shl    $0x2,%eax
     45a:	01 d0                	add    %edx,%eax
     45c:	01 c0                	add    %eax,%eax
     45e:	89 c1                	mov    %eax,%ecx
     460:	8b 45 08             	mov    0x8(%ebp),%eax
     463:	8d 50 01             	lea    0x1(%eax),%edx
     466:	89 55 08             	mov    %edx,0x8(%ebp)
     469:	0f b6 00             	movzbl (%eax),%eax
     46c:	0f be c0             	movsbl %al,%eax
     46f:	01 c8                	add    %ecx,%eax
     471:	83 e8 30             	sub    $0x30,%eax
     474:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     477:	8b 45 08             	mov    0x8(%ebp),%eax
     47a:	0f b6 00             	movzbl (%eax),%eax
     47d:	3c 2f                	cmp    $0x2f,%al
     47f:	7e 0a                	jle    48b <atoi+0x8d>
     481:	8b 45 08             	mov    0x8(%ebp),%eax
     484:	0f b6 00             	movzbl (%eax),%eax
     487:	3c 39                	cmp    $0x39,%al
     489:	7e c7                	jle    452 <atoi+0x54>
  return sign*n;
     48b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     48e:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     492:	c9                   	leave  
     493:	c3                   	ret    

00000494 <atoo>:

int
atoo(const char *s)
{
     494:	f3 0f 1e fb          	endbr32 
     498:	55                   	push   %ebp
     499:	89 e5                	mov    %esp,%ebp
     49b:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     49e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     4a5:	eb 04                	jmp    4ab <atoo+0x17>
     4a7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     4ab:	8b 45 08             	mov    0x8(%ebp),%eax
     4ae:	0f b6 00             	movzbl (%eax),%eax
     4b1:	3c 20                	cmp    $0x20,%al
     4b3:	74 f2                	je     4a7 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
     4b5:	8b 45 08             	mov    0x8(%ebp),%eax
     4b8:	0f b6 00             	movzbl (%eax),%eax
     4bb:	3c 2d                	cmp    $0x2d,%al
     4bd:	75 07                	jne    4c6 <atoo+0x32>
     4bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     4c4:	eb 05                	jmp    4cb <atoo+0x37>
     4c6:	b8 01 00 00 00       	mov    $0x1,%eax
     4cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     4ce:	8b 45 08             	mov    0x8(%ebp),%eax
     4d1:	0f b6 00             	movzbl (%eax),%eax
     4d4:	3c 2b                	cmp    $0x2b,%al
     4d6:	74 0a                	je     4e2 <atoo+0x4e>
     4d8:	8b 45 08             	mov    0x8(%ebp),%eax
     4db:	0f b6 00             	movzbl (%eax),%eax
     4de:	3c 2d                	cmp    $0x2d,%al
     4e0:	75 27                	jne    509 <atoo+0x75>
    s++;
     4e2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     4e6:	eb 21                	jmp    509 <atoo+0x75>
    n = n*8 + *s++ - '0';
     4e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4eb:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     4f2:	8b 45 08             	mov    0x8(%ebp),%eax
     4f5:	8d 50 01             	lea    0x1(%eax),%edx
     4f8:	89 55 08             	mov    %edx,0x8(%ebp)
     4fb:	0f b6 00             	movzbl (%eax),%eax
     4fe:	0f be c0             	movsbl %al,%eax
     501:	01 c8                	add    %ecx,%eax
     503:	83 e8 30             	sub    $0x30,%eax
     506:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
     509:	8b 45 08             	mov    0x8(%ebp),%eax
     50c:	0f b6 00             	movzbl (%eax),%eax
     50f:	3c 2f                	cmp    $0x2f,%al
     511:	7e 0a                	jle    51d <atoo+0x89>
     513:	8b 45 08             	mov    0x8(%ebp),%eax
     516:	0f b6 00             	movzbl (%eax),%eax
     519:	3c 37                	cmp    $0x37,%al
     51b:	7e cb                	jle    4e8 <atoo+0x54>
  return sign*n;
     51d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     520:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     524:	c9                   	leave  
     525:	c3                   	ret    

00000526 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     526:	f3 0f 1e fb          	endbr32 
     52a:	55                   	push   %ebp
     52b:	89 e5                	mov    %esp,%ebp
     52d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     530:	8b 45 08             	mov    0x8(%ebp),%eax
     533:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     536:	8b 45 0c             	mov    0xc(%ebp),%eax
     539:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     53c:	eb 17                	jmp    555 <memmove+0x2f>
    *dst++ = *src++;
     53e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     541:	8d 42 01             	lea    0x1(%edx),%eax
     544:	89 45 f8             	mov    %eax,-0x8(%ebp)
     547:	8b 45 fc             	mov    -0x4(%ebp),%eax
     54a:	8d 48 01             	lea    0x1(%eax),%ecx
     54d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     550:	0f b6 12             	movzbl (%edx),%edx
     553:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     555:	8b 45 10             	mov    0x10(%ebp),%eax
     558:	8d 50 ff             	lea    -0x1(%eax),%edx
     55b:	89 55 10             	mov    %edx,0x10(%ebp)
     55e:	85 c0                	test   %eax,%eax
     560:	7f dc                	jg     53e <memmove+0x18>
  return vdst;
     562:	8b 45 08             	mov    0x8(%ebp),%eax
}
     565:	c9                   	leave  
     566:	c3                   	ret    

00000567 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     567:	b8 01 00 00 00       	mov    $0x1,%eax
     56c:	cd 40                	int    $0x40
     56e:	c3                   	ret    

0000056f <exit>:
SYSCALL(exit)
     56f:	b8 02 00 00 00       	mov    $0x2,%eax
     574:	cd 40                	int    $0x40
     576:	c3                   	ret    

00000577 <wait>:
SYSCALL(wait)
     577:	b8 03 00 00 00       	mov    $0x3,%eax
     57c:	cd 40                	int    $0x40
     57e:	c3                   	ret    

0000057f <pipe>:
SYSCALL(pipe)
     57f:	b8 04 00 00 00       	mov    $0x4,%eax
     584:	cd 40                	int    $0x40
     586:	c3                   	ret    

00000587 <read>:
SYSCALL(read)
     587:	b8 05 00 00 00       	mov    $0x5,%eax
     58c:	cd 40                	int    $0x40
     58e:	c3                   	ret    

0000058f <write>:
SYSCALL(write)
     58f:	b8 10 00 00 00       	mov    $0x10,%eax
     594:	cd 40                	int    $0x40
     596:	c3                   	ret    

00000597 <close>:
SYSCALL(close)
     597:	b8 15 00 00 00       	mov    $0x15,%eax
     59c:	cd 40                	int    $0x40
     59e:	c3                   	ret    

0000059f <kill>:
SYSCALL(kill)
     59f:	b8 06 00 00 00       	mov    $0x6,%eax
     5a4:	cd 40                	int    $0x40
     5a6:	c3                   	ret    

000005a7 <exec>:
SYSCALL(exec)
     5a7:	b8 07 00 00 00       	mov    $0x7,%eax
     5ac:	cd 40                	int    $0x40
     5ae:	c3                   	ret    

000005af <open>:
SYSCALL(open)
     5af:	b8 0f 00 00 00       	mov    $0xf,%eax
     5b4:	cd 40                	int    $0x40
     5b6:	c3                   	ret    

000005b7 <mknod>:
SYSCALL(mknod)
     5b7:	b8 11 00 00 00       	mov    $0x11,%eax
     5bc:	cd 40                	int    $0x40
     5be:	c3                   	ret    

000005bf <unlink>:
SYSCALL(unlink)
     5bf:	b8 12 00 00 00       	mov    $0x12,%eax
     5c4:	cd 40                	int    $0x40
     5c6:	c3                   	ret    

000005c7 <fstat>:
SYSCALL(fstat)
     5c7:	b8 08 00 00 00       	mov    $0x8,%eax
     5cc:	cd 40                	int    $0x40
     5ce:	c3                   	ret    

000005cf <link>:
SYSCALL(link)
     5cf:	b8 13 00 00 00       	mov    $0x13,%eax
     5d4:	cd 40                	int    $0x40
     5d6:	c3                   	ret    

000005d7 <mkdir>:
SYSCALL(mkdir)
     5d7:	b8 14 00 00 00       	mov    $0x14,%eax
     5dc:	cd 40                	int    $0x40
     5de:	c3                   	ret    

000005df <chdir>:
SYSCALL(chdir)
     5df:	b8 09 00 00 00       	mov    $0x9,%eax
     5e4:	cd 40                	int    $0x40
     5e6:	c3                   	ret    

000005e7 <dup>:
SYSCALL(dup)
     5e7:	b8 0a 00 00 00       	mov    $0xa,%eax
     5ec:	cd 40                	int    $0x40
     5ee:	c3                   	ret    

000005ef <getpid>:
SYSCALL(getpid)
     5ef:	b8 0b 00 00 00       	mov    $0xb,%eax
     5f4:	cd 40                	int    $0x40
     5f6:	c3                   	ret    

000005f7 <sbrk>:
SYSCALL(sbrk)
     5f7:	b8 0c 00 00 00       	mov    $0xc,%eax
     5fc:	cd 40                	int    $0x40
     5fe:	c3                   	ret    

000005ff <sleep>:
SYSCALL(sleep)
     5ff:	b8 0d 00 00 00       	mov    $0xd,%eax
     604:	cd 40                	int    $0x40
     606:	c3                   	ret    

00000607 <uptime>:
SYSCALL(uptime)
     607:	b8 0e 00 00 00       	mov    $0xe,%eax
     60c:	cd 40                	int    $0x40
     60e:	c3                   	ret    

0000060f <halt>:
SYSCALL(halt)
     60f:	b8 16 00 00 00       	mov    $0x16,%eax
     614:	cd 40                	int    $0x40
     616:	c3                   	ret    

00000617 <date>:
SYSCALL(date)
     617:	b8 17 00 00 00       	mov    $0x17,%eax
     61c:	cd 40                	int    $0x40
     61e:	c3                   	ret    

0000061f <getuid>:
SYSCALL(getuid)
     61f:	b8 18 00 00 00       	mov    $0x18,%eax
     624:	cd 40                	int    $0x40
     626:	c3                   	ret    

00000627 <getgid>:
SYSCALL(getgid)
     627:	b8 19 00 00 00       	mov    $0x19,%eax
     62c:	cd 40                	int    $0x40
     62e:	c3                   	ret    

0000062f <getppid>:
SYSCALL(getppid)
     62f:	b8 1a 00 00 00       	mov    $0x1a,%eax
     634:	cd 40                	int    $0x40
     636:	c3                   	ret    

00000637 <setuid>:
SYSCALL(setuid)
     637:	b8 1b 00 00 00       	mov    $0x1b,%eax
     63c:	cd 40                	int    $0x40
     63e:	c3                   	ret    

0000063f <setgid>:
SYSCALL(setgid)
     63f:	b8 1c 00 00 00       	mov    $0x1c,%eax
     644:	cd 40                	int    $0x40
     646:	c3                   	ret    

00000647 <getprocs>:
SYSCALL(getprocs)
     647:	b8 1d 00 00 00       	mov    $0x1d,%eax
     64c:	cd 40                	int    $0x40
     64e:	c3                   	ret    

0000064f <setpriority>:
SYSCALL(setpriority)
     64f:	b8 1e 00 00 00       	mov    $0x1e,%eax
     654:	cd 40                	int    $0x40
     656:	c3                   	ret    

00000657 <chown>:
SYSCALL(chown)
     657:	b8 1f 00 00 00       	mov    $0x1f,%eax
     65c:	cd 40                	int    $0x40
     65e:	c3                   	ret    

0000065f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     65f:	f3 0f 1e fb          	endbr32 
     663:	55                   	push   %ebp
     664:	89 e5                	mov    %esp,%ebp
     666:	83 ec 18             	sub    $0x18,%esp
     669:	8b 45 0c             	mov    0xc(%ebp),%eax
     66c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     66f:	83 ec 04             	sub    $0x4,%esp
     672:	6a 01                	push   $0x1
     674:	8d 45 f4             	lea    -0xc(%ebp),%eax
     677:	50                   	push   %eax
     678:	ff 75 08             	pushl  0x8(%ebp)
     67b:	e8 0f ff ff ff       	call   58f <write>
     680:	83 c4 10             	add    $0x10,%esp
}
     683:	90                   	nop
     684:	c9                   	leave  
     685:	c3                   	ret    

00000686 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     686:	f3 0f 1e fb          	endbr32 
     68a:	55                   	push   %ebp
     68b:	89 e5                	mov    %esp,%ebp
     68d:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     690:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     697:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     69b:	74 17                	je     6b4 <printint+0x2e>
     69d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6a1:	79 11                	jns    6b4 <printint+0x2e>
    neg = 1;
     6a3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6aa:	8b 45 0c             	mov    0xc(%ebp),%eax
     6ad:	f7 d8                	neg    %eax
     6af:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6b2:	eb 06                	jmp    6ba <printint+0x34>
  } else {
    x = xx;
     6b4:	8b 45 0c             	mov    0xc(%ebp),%eax
     6b7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6c1:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6c7:	ba 00 00 00 00       	mov    $0x0,%edx
     6cc:	f7 f1                	div    %ecx
     6ce:	89 d1                	mov    %edx,%ecx
     6d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d3:	8d 50 01             	lea    0x1(%eax),%edx
     6d6:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6d9:	0f b6 91 64 15 00 00 	movzbl 0x1564(%ecx),%edx
     6e0:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     6e4:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6ea:	ba 00 00 00 00       	mov    $0x0,%edx
     6ef:	f7 f1                	div    %ecx
     6f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6f8:	75 c7                	jne    6c1 <printint+0x3b>
  if(neg)
     6fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6fe:	74 2d                	je     72d <printint+0xa7>
    buf[i++] = '-';
     700:	8b 45 f4             	mov    -0xc(%ebp),%eax
     703:	8d 50 01             	lea    0x1(%eax),%edx
     706:	89 55 f4             	mov    %edx,-0xc(%ebp)
     709:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     70e:	eb 1d                	jmp    72d <printint+0xa7>
    putc(fd, buf[i]);
     710:	8d 55 dc             	lea    -0x24(%ebp),%edx
     713:	8b 45 f4             	mov    -0xc(%ebp),%eax
     716:	01 d0                	add    %edx,%eax
     718:	0f b6 00             	movzbl (%eax),%eax
     71b:	0f be c0             	movsbl %al,%eax
     71e:	83 ec 08             	sub    $0x8,%esp
     721:	50                   	push   %eax
     722:	ff 75 08             	pushl  0x8(%ebp)
     725:	e8 35 ff ff ff       	call   65f <putc>
     72a:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     72d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     731:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     735:	79 d9                	jns    710 <printint+0x8a>
}
     737:	90                   	nop
     738:	90                   	nop
     739:	c9                   	leave  
     73a:	c3                   	ret    

0000073b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     73b:	f3 0f 1e fb          	endbr32 
     73f:	55                   	push   %ebp
     740:	89 e5                	mov    %esp,%ebp
     742:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     745:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     74c:	8d 45 0c             	lea    0xc(%ebp),%eax
     74f:	83 c0 04             	add    $0x4,%eax
     752:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     755:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     75c:	e9 59 01 00 00       	jmp    8ba <printf+0x17f>
    c = fmt[i] & 0xff;
     761:	8b 55 0c             	mov    0xc(%ebp),%edx
     764:	8b 45 f0             	mov    -0x10(%ebp),%eax
     767:	01 d0                	add    %edx,%eax
     769:	0f b6 00             	movzbl (%eax),%eax
     76c:	0f be c0             	movsbl %al,%eax
     76f:	25 ff 00 00 00       	and    $0xff,%eax
     774:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     777:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     77b:	75 2c                	jne    7a9 <printf+0x6e>
      if(c == '%'){
     77d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     781:	75 0c                	jne    78f <printf+0x54>
        state = '%';
     783:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     78a:	e9 27 01 00 00       	jmp    8b6 <printf+0x17b>
      } else {
        putc(fd, c);
     78f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     792:	0f be c0             	movsbl %al,%eax
     795:	83 ec 08             	sub    $0x8,%esp
     798:	50                   	push   %eax
     799:	ff 75 08             	pushl  0x8(%ebp)
     79c:	e8 be fe ff ff       	call   65f <putc>
     7a1:	83 c4 10             	add    $0x10,%esp
     7a4:	e9 0d 01 00 00       	jmp    8b6 <printf+0x17b>
      }
    } else if(state == '%'){
     7a9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7ad:	0f 85 03 01 00 00    	jne    8b6 <printf+0x17b>
      if(c == 'd'){
     7b3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7b7:	75 1e                	jne    7d7 <printf+0x9c>
        printint(fd, *ap, 10, 1);
     7b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7bc:	8b 00                	mov    (%eax),%eax
     7be:	6a 01                	push   $0x1
     7c0:	6a 0a                	push   $0xa
     7c2:	50                   	push   %eax
     7c3:	ff 75 08             	pushl  0x8(%ebp)
     7c6:	e8 bb fe ff ff       	call   686 <printint>
     7cb:	83 c4 10             	add    $0x10,%esp
        ap++;
     7ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7d2:	e9 d8 00 00 00       	jmp    8af <printf+0x174>
      } else if(c == 'x' || c == 'p'){
     7d7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7db:	74 06                	je     7e3 <printf+0xa8>
     7dd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7e1:	75 1e                	jne    801 <printf+0xc6>
        printint(fd, *ap, 16, 0);
     7e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7e6:	8b 00                	mov    (%eax),%eax
     7e8:	6a 00                	push   $0x0
     7ea:	6a 10                	push   $0x10
     7ec:	50                   	push   %eax
     7ed:	ff 75 08             	pushl  0x8(%ebp)
     7f0:	e8 91 fe ff ff       	call   686 <printint>
     7f5:	83 c4 10             	add    $0x10,%esp
        ap++;
     7f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7fc:	e9 ae 00 00 00       	jmp    8af <printf+0x174>
      } else if(c == 's'){
     801:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     805:	75 43                	jne    84a <printf+0x10f>
        s = (char*)*ap;
     807:	8b 45 e8             	mov    -0x18(%ebp),%eax
     80a:	8b 00                	mov    (%eax),%eax
     80c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     80f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     813:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     817:	75 25                	jne    83e <printf+0x103>
          s = "(null)";
     819:	c7 45 f4 33 11 00 00 	movl   $0x1133,-0xc(%ebp)
        while(*s != 0){
     820:	eb 1c                	jmp    83e <printf+0x103>
          putc(fd, *s);
     822:	8b 45 f4             	mov    -0xc(%ebp),%eax
     825:	0f b6 00             	movzbl (%eax),%eax
     828:	0f be c0             	movsbl %al,%eax
     82b:	83 ec 08             	sub    $0x8,%esp
     82e:	50                   	push   %eax
     82f:	ff 75 08             	pushl  0x8(%ebp)
     832:	e8 28 fe ff ff       	call   65f <putc>
     837:	83 c4 10             	add    $0x10,%esp
          s++;
     83a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     83e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     841:	0f b6 00             	movzbl (%eax),%eax
     844:	84 c0                	test   %al,%al
     846:	75 da                	jne    822 <printf+0xe7>
     848:	eb 65                	jmp    8af <printf+0x174>
        }
      } else if(c == 'c'){
     84a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     84e:	75 1d                	jne    86d <printf+0x132>
        putc(fd, *ap);
     850:	8b 45 e8             	mov    -0x18(%ebp),%eax
     853:	8b 00                	mov    (%eax),%eax
     855:	0f be c0             	movsbl %al,%eax
     858:	83 ec 08             	sub    $0x8,%esp
     85b:	50                   	push   %eax
     85c:	ff 75 08             	pushl  0x8(%ebp)
     85f:	e8 fb fd ff ff       	call   65f <putc>
     864:	83 c4 10             	add    $0x10,%esp
        ap++;
     867:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     86b:	eb 42                	jmp    8af <printf+0x174>
      } else if(c == '%'){
     86d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     871:	75 17                	jne    88a <printf+0x14f>
        putc(fd, c);
     873:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     876:	0f be c0             	movsbl %al,%eax
     879:	83 ec 08             	sub    $0x8,%esp
     87c:	50                   	push   %eax
     87d:	ff 75 08             	pushl  0x8(%ebp)
     880:	e8 da fd ff ff       	call   65f <putc>
     885:	83 c4 10             	add    $0x10,%esp
     888:	eb 25                	jmp    8af <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     88a:	83 ec 08             	sub    $0x8,%esp
     88d:	6a 25                	push   $0x25
     88f:	ff 75 08             	pushl  0x8(%ebp)
     892:	e8 c8 fd ff ff       	call   65f <putc>
     897:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     89a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     89d:	0f be c0             	movsbl %al,%eax
     8a0:	83 ec 08             	sub    $0x8,%esp
     8a3:	50                   	push   %eax
     8a4:	ff 75 08             	pushl  0x8(%ebp)
     8a7:	e8 b3 fd ff ff       	call   65f <putc>
     8ac:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     8b6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8ba:	8b 55 0c             	mov    0xc(%ebp),%edx
     8bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8c0:	01 d0                	add    %edx,%eax
     8c2:	0f b6 00             	movzbl (%eax),%eax
     8c5:	84 c0                	test   %al,%al
     8c7:	0f 85 94 fe ff ff    	jne    761 <printf+0x26>
    }
  }
}
     8cd:	90                   	nop
     8ce:	90                   	nop
     8cf:	c9                   	leave  
     8d0:	c3                   	ret    

000008d1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8d1:	f3 0f 1e fb          	endbr32 
     8d5:	55                   	push   %ebp
     8d6:	89 e5                	mov    %esp,%ebp
     8d8:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8db:	8b 45 08             	mov    0x8(%ebp),%eax
     8de:	83 e8 08             	sub    $0x8,%eax
     8e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8e4:	a1 88 15 00 00       	mov    0x1588,%eax
     8e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8ec:	eb 24                	jmp    912 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     8ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8f1:	8b 00                	mov    (%eax),%eax
     8f3:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     8f6:	72 12                	jb     90a <free+0x39>
     8f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8fb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8fe:	77 24                	ja     924 <free+0x53>
     900:	8b 45 fc             	mov    -0x4(%ebp),%eax
     903:	8b 00                	mov    (%eax),%eax
     905:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     908:	72 1a                	jb     924 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     90a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     90d:	8b 00                	mov    (%eax),%eax
     90f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     912:	8b 45 f8             	mov    -0x8(%ebp),%eax
     915:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     918:	76 d4                	jbe    8ee <free+0x1d>
     91a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     91d:	8b 00                	mov    (%eax),%eax
     91f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     922:	73 ca                	jae    8ee <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
     924:	8b 45 f8             	mov    -0x8(%ebp),%eax
     927:	8b 40 04             	mov    0x4(%eax),%eax
     92a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     931:	8b 45 f8             	mov    -0x8(%ebp),%eax
     934:	01 c2                	add    %eax,%edx
     936:	8b 45 fc             	mov    -0x4(%ebp),%eax
     939:	8b 00                	mov    (%eax),%eax
     93b:	39 c2                	cmp    %eax,%edx
     93d:	75 24                	jne    963 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
     93f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     942:	8b 50 04             	mov    0x4(%eax),%edx
     945:	8b 45 fc             	mov    -0x4(%ebp),%eax
     948:	8b 00                	mov    (%eax),%eax
     94a:	8b 40 04             	mov    0x4(%eax),%eax
     94d:	01 c2                	add    %eax,%edx
     94f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     952:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     955:	8b 45 fc             	mov    -0x4(%ebp),%eax
     958:	8b 00                	mov    (%eax),%eax
     95a:	8b 10                	mov    (%eax),%edx
     95c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     95f:	89 10                	mov    %edx,(%eax)
     961:	eb 0a                	jmp    96d <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
     963:	8b 45 fc             	mov    -0x4(%ebp),%eax
     966:	8b 10                	mov    (%eax),%edx
     968:	8b 45 f8             	mov    -0x8(%ebp),%eax
     96b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     96d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     970:	8b 40 04             	mov    0x4(%eax),%eax
     973:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     97a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97d:	01 d0                	add    %edx,%eax
     97f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     982:	75 20                	jne    9a4 <free+0xd3>
    p->s.size += bp->s.size;
     984:	8b 45 fc             	mov    -0x4(%ebp),%eax
     987:	8b 50 04             	mov    0x4(%eax),%edx
     98a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     98d:	8b 40 04             	mov    0x4(%eax),%eax
     990:	01 c2                	add    %eax,%edx
     992:	8b 45 fc             	mov    -0x4(%ebp),%eax
     995:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     998:	8b 45 f8             	mov    -0x8(%ebp),%eax
     99b:	8b 10                	mov    (%eax),%edx
     99d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a0:	89 10                	mov    %edx,(%eax)
     9a2:	eb 08                	jmp    9ac <free+0xdb>
  } else
    p->s.ptr = bp;
     9a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9aa:	89 10                	mov    %edx,(%eax)
  freep = p;
     9ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9af:	a3 88 15 00 00       	mov    %eax,0x1588
}
     9b4:	90                   	nop
     9b5:	c9                   	leave  
     9b6:	c3                   	ret    

000009b7 <morecore>:

static Header*
morecore(uint nu)
{
     9b7:	f3 0f 1e fb          	endbr32 
     9bb:	55                   	push   %ebp
     9bc:	89 e5                	mov    %esp,%ebp
     9be:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9c1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9c8:	77 07                	ja     9d1 <morecore+0x1a>
    nu = 4096;
     9ca:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9d1:	8b 45 08             	mov    0x8(%ebp),%eax
     9d4:	c1 e0 03             	shl    $0x3,%eax
     9d7:	83 ec 0c             	sub    $0xc,%esp
     9da:	50                   	push   %eax
     9db:	e8 17 fc ff ff       	call   5f7 <sbrk>
     9e0:	83 c4 10             	add    $0x10,%esp
     9e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9e6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9ea:	75 07                	jne    9f3 <morecore+0x3c>
    return 0;
     9ec:	b8 00 00 00 00       	mov    $0x0,%eax
     9f1:	eb 26                	jmp    a19 <morecore+0x62>
  hp = (Header*)p;
     9f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     9f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9fc:	8b 55 08             	mov    0x8(%ebp),%edx
     9ff:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a02:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a05:	83 c0 08             	add    $0x8,%eax
     a08:	83 ec 0c             	sub    $0xc,%esp
     a0b:	50                   	push   %eax
     a0c:	e8 c0 fe ff ff       	call   8d1 <free>
     a11:	83 c4 10             	add    $0x10,%esp
  return freep;
     a14:	a1 88 15 00 00       	mov    0x1588,%eax
}
     a19:	c9                   	leave  
     a1a:	c3                   	ret    

00000a1b <malloc>:

void*
malloc(uint nbytes)
{
     a1b:	f3 0f 1e fb          	endbr32 
     a1f:	55                   	push   %ebp
     a20:	89 e5                	mov    %esp,%ebp
     a22:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a25:	8b 45 08             	mov    0x8(%ebp),%eax
     a28:	83 c0 07             	add    $0x7,%eax
     a2b:	c1 e8 03             	shr    $0x3,%eax
     a2e:	83 c0 01             	add    $0x1,%eax
     a31:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a34:	a1 88 15 00 00       	mov    0x1588,%eax
     a39:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a3c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a40:	75 23                	jne    a65 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
     a42:	c7 45 f0 80 15 00 00 	movl   $0x1580,-0x10(%ebp)
     a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a4c:	a3 88 15 00 00       	mov    %eax,0x1588
     a51:	a1 88 15 00 00       	mov    0x1588,%eax
     a56:	a3 80 15 00 00       	mov    %eax,0x1580
    base.s.size = 0;
     a5b:	c7 05 84 15 00 00 00 	movl   $0x0,0x1584
     a62:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a65:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a68:	8b 00                	mov    (%eax),%eax
     a6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a70:	8b 40 04             	mov    0x4(%eax),%eax
     a73:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a76:	77 4d                	ja     ac5 <malloc+0xaa>
      if(p->s.size == nunits)
     a78:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7b:	8b 40 04             	mov    0x4(%eax),%eax
     a7e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a81:	75 0c                	jne    a8f <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
     a83:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a86:	8b 10                	mov    (%eax),%edx
     a88:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a8b:	89 10                	mov    %edx,(%eax)
     a8d:	eb 26                	jmp    ab5 <malloc+0x9a>
      else {
        p->s.size -= nunits;
     a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a92:	8b 40 04             	mov    0x4(%eax),%eax
     a95:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a98:	89 c2                	mov    %eax,%edx
     a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa3:	8b 40 04             	mov    0x4(%eax),%eax
     aa6:	c1 e0 03             	shl    $0x3,%eax
     aa9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     aac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aaf:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ab2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     ab5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ab8:	a3 88 15 00 00       	mov    %eax,0x1588
      return (void*)(p + 1);
     abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac0:	83 c0 08             	add    $0x8,%eax
     ac3:	eb 3b                	jmp    b00 <malloc+0xe5>
    }
    if(p == freep)
     ac5:	a1 88 15 00 00       	mov    0x1588,%eax
     aca:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     acd:	75 1e                	jne    aed <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
     acf:	83 ec 0c             	sub    $0xc,%esp
     ad2:	ff 75 ec             	pushl  -0x14(%ebp)
     ad5:	e8 dd fe ff ff       	call   9b7 <morecore>
     ada:	83 c4 10             	add    $0x10,%esp
     add:	89 45 f4             	mov    %eax,-0xc(%ebp)
     ae0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ae4:	75 07                	jne    aed <malloc+0xd2>
        return 0;
     ae6:	b8 00 00 00 00       	mov    $0x0,%eax
     aeb:	eb 13                	jmp    b00 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     af3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     af6:	8b 00                	mov    (%eax),%eax
     af8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     afb:	e9 6d ff ff ff       	jmp    a6d <malloc+0x52>
  }
}
     b00:	c9                   	leave  
     b01:	c3                   	ret    

00000b02 <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
     b02:	f3 0f 1e fb          	endbr32 
     b06:	55                   	push   %ebp
     b07:	89 e5                	mov    %esp,%ebp
     b09:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     b0c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     b13:	a1 e0 15 00 00       	mov    0x15e0,%eax
     b18:	83 ec 04             	sub    $0x4,%esp
     b1b:	50                   	push   %eax
     b1c:	6a 20                	push   $0x20
     b1e:	68 c0 15 00 00       	push   $0x15c0
     b23:	e8 11 f8 ff ff       	call   339 <fgets>
     b28:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     b2b:	83 ec 0c             	sub    $0xc,%esp
     b2e:	68 c0 15 00 00       	push   $0x15c0
     b33:	e8 0e f7 ff ff       	call   246 <strlen>
     b38:	83 c4 10             	add    $0x10,%esp
     b3b:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     b3e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b41:	83 e8 01             	sub    $0x1,%eax
     b44:	0f b6 80 c0 15 00 00 	movzbl 0x15c0(%eax),%eax
     b4b:	3c 0a                	cmp    $0xa,%al
     b4d:	74 11                	je     b60 <get_id+0x5e>
     b4f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b52:	83 e8 01             	sub    $0x1,%eax
     b55:	0f b6 80 c0 15 00 00 	movzbl 0x15c0(%eax),%eax
     b5c:	3c 0d                	cmp    $0xd,%al
     b5e:	75 0d                	jne    b6d <get_id+0x6b>
        current_line[len - 1] = 0;
     b60:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b63:	83 e8 01             	sub    $0x1,%eax
     b66:	c6 80 c0 15 00 00 00 	movb   $0x0,0x15c0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     b6d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     b74:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     b7b:	eb 6c                	jmp    be9 <get_id+0xe7>
        if(current_line[i] == ' '){
     b7d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b80:	05 c0 15 00 00       	add    $0x15c0,%eax
     b85:	0f b6 00             	movzbl (%eax),%eax
     b88:	3c 20                	cmp    $0x20,%al
     b8a:	75 30                	jne    bbc <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     b8c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b90:	75 16                	jne    ba8 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     b92:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     b95:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b98:	8d 50 01             	lea    0x1(%eax),%edx
     b9b:	89 55 f0             	mov    %edx,-0x10(%ebp)
     b9e:	8d 91 c0 15 00 00    	lea    0x15c0(%ecx),%edx
     ba4:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     ba8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bab:	05 c0 15 00 00       	add    $0x15c0,%eax
     bb0:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     bb3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     bba:	eb 29                	jmp    be5 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     bbc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bc0:	75 23                	jne    be5 <get_id+0xe3>
     bc2:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     bc6:	7f 1d                	jg     be5 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     bc8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     bcf:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     bd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd5:	8d 50 01             	lea    0x1(%eax),%edx
     bd8:	89 55 f0             	mov    %edx,-0x10(%ebp)
     bdb:	8d 91 c0 15 00 00    	lea    0x15c0(%ecx),%edx
     be1:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     be5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     be9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bec:	05 c0 15 00 00       	add    $0x15c0,%eax
     bf1:	0f b6 00             	movzbl (%eax),%eax
     bf4:	84 c0                	test   %al,%al
     bf6:	75 85                	jne    b7d <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     bf8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bfc:	75 07                	jne    c05 <get_id+0x103>
        return -1;
     bfe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c03:	eb 35                	jmp    c3a <get_id+0x138>
    
    current_id.nama_user = tokens[0];
     c05:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c08:	a3 a0 15 00 00       	mov    %eax,0x15a0
    current_id.uid_user = atoi(tokens[1]);
     c0d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c10:	83 ec 0c             	sub    $0xc,%esp
     c13:	50                   	push   %eax
     c14:	e8 e5 f7 ff ff       	call   3fe <atoi>
     c19:	83 c4 10             	add    $0x10,%esp
     c1c:	a3 a4 15 00 00       	mov    %eax,0x15a4
    current_id.gid_user = atoi(tokens[2]);
     c21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c24:	83 ec 0c             	sub    $0xc,%esp
     c27:	50                   	push   %eax
     c28:	e8 d1 f7 ff ff       	call   3fe <atoi>
     c2d:	83 c4 10             	add    $0x10,%esp
     c30:	a3 a8 15 00 00       	mov    %eax,0x15a8

    return 0;
     c35:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c3a:	c9                   	leave  
     c3b:	c3                   	ret    

00000c3c <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
     c3c:	f3 0f 1e fb          	endbr32 
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     c46:	a1 e0 15 00 00       	mov    0x15e0,%eax
     c4b:	85 c0                	test   %eax,%eax
     c4d:	75 31                	jne    c80 <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
     c4f:	83 ec 08             	sub    $0x8,%esp
     c52:	6a 00                	push   $0x0
     c54:	68 3a 11 00 00       	push   $0x113a
     c59:	e8 51 f9 ff ff       	call   5af <open>
     c5e:	83 c4 10             	add    $0x10,%esp
     c61:	a3 e0 15 00 00       	mov    %eax,0x15e0

        if(dir < 0){        // kalau gagal membuka file
     c66:	a1 e0 15 00 00       	mov    0x15e0,%eax
     c6b:	85 c0                	test   %eax,%eax
     c6d:	79 11                	jns    c80 <getid+0x44>
            dir = 0;
     c6f:	c7 05 e0 15 00 00 00 	movl   $0x0,0x15e0
     c76:	00 00 00 
            return 0;
     c79:	b8 00 00 00 00       	mov    $0x0,%eax
     c7e:	eb 16                	jmp    c96 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
     c80:	e8 7d fe ff ff       	call   b02 <get_id>
     c85:	83 f8 ff             	cmp    $0xffffffff,%eax
     c88:	75 07                	jne    c91 <getid+0x55>
        return 0;
     c8a:	b8 00 00 00 00       	mov    $0x0,%eax
     c8f:	eb 05                	jmp    c96 <getid+0x5a>
    
    return &current_id;
     c91:	b8 a0 15 00 00       	mov    $0x15a0,%eax
}
     c96:	c9                   	leave  
     c97:	c3                   	ret    

00000c98 <setid>:

// open file_ids
void setid(void){
     c98:	f3 0f 1e fb          	endbr32 
     c9c:	55                   	push   %ebp
     c9d:	89 e5                	mov    %esp,%ebp
     c9f:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     ca2:	a1 e0 15 00 00       	mov    0x15e0,%eax
     ca7:	85 c0                	test   %eax,%eax
     ca9:	74 1b                	je     cc6 <setid+0x2e>
        close(dir);
     cab:	a1 e0 15 00 00       	mov    0x15e0,%eax
     cb0:	83 ec 0c             	sub    $0xc,%esp
     cb3:	50                   	push   %eax
     cb4:	e8 de f8 ff ff       	call   597 <close>
     cb9:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     cbc:	c7 05 e0 15 00 00 00 	movl   $0x0,0x15e0
     cc3:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
     cc6:	83 ec 08             	sub    $0x8,%esp
     cc9:	6a 00                	push   $0x0
     ccb:	68 3a 11 00 00       	push   $0x113a
     cd0:	e8 da f8 ff ff       	call   5af <open>
     cd5:	83 c4 10             	add    $0x10,%esp
     cd8:	a3 e0 15 00 00       	mov    %eax,0x15e0

    if (dir < 0)
     cdd:	a1 e0 15 00 00       	mov    0x15e0,%eax
     ce2:	85 c0                	test   %eax,%eax
     ce4:	79 0a                	jns    cf0 <setid+0x58>
        dir = 0;
     ce6:	c7 05 e0 15 00 00 00 	movl   $0x0,0x15e0
     ced:	00 00 00 
}
     cf0:	90                   	nop
     cf1:	c9                   	leave  
     cf2:	c3                   	ret    

00000cf3 <endid>:

// tutup file_ids
void endid (void){
     cf3:	f3 0f 1e fb          	endbr32 
     cf7:	55                   	push   %ebp
     cf8:	89 e5                	mov    %esp,%ebp
     cfa:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     cfd:	a1 e0 15 00 00       	mov    0x15e0,%eax
     d02:	85 c0                	test   %eax,%eax
     d04:	74 1b                	je     d21 <endid+0x2e>
        close(dir);
     d06:	a1 e0 15 00 00       	mov    0x15e0,%eax
     d0b:	83 ec 0c             	sub    $0xc,%esp
     d0e:	50                   	push   %eax
     d0f:	e8 83 f8 ff ff       	call   597 <close>
     d14:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     d17:	c7 05 e0 15 00 00 00 	movl   $0x0,0x15e0
     d1e:	00 00 00 
    }
}
     d21:	90                   	nop
     d22:	c9                   	leave  
     d23:	c3                   	ret    

00000d24 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
     d24:	f3 0f 1e fb          	endbr32 
     d28:	55                   	push   %ebp
     d29:	89 e5                	mov    %esp,%ebp
     d2b:	83 ec 08             	sub    $0x8,%esp
    setid();
     d2e:	e8 65 ff ff ff       	call   c98 <setid>

    while (getid()){
     d33:	eb 24                	jmp    d59 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
     d35:	a1 a0 15 00 00       	mov    0x15a0,%eax
     d3a:	83 ec 08             	sub    $0x8,%esp
     d3d:	50                   	push   %eax
     d3e:	ff 75 08             	pushl  0x8(%ebp)
     d41:	e8 bd f4 ff ff       	call   203 <strcmp>
     d46:	83 c4 10             	add    $0x10,%esp
     d49:	85 c0                	test   %eax,%eax
     d4b:	75 0c                	jne    d59 <cek_nama+0x35>
            endid();
     d4d:	e8 a1 ff ff ff       	call   cf3 <endid>
            return &current_id;
     d52:	b8 a0 15 00 00       	mov    $0x15a0,%eax
     d57:	eb 13                	jmp    d6c <cek_nama+0x48>
    while (getid()){
     d59:	e8 de fe ff ff       	call   c3c <getid>
     d5e:	85 c0                	test   %eax,%eax
     d60:	75 d3                	jne    d35 <cek_nama+0x11>
        }
    }
    endid();
     d62:	e8 8c ff ff ff       	call   cf3 <endid>
    return 0;
     d67:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d6c:	c9                   	leave  
     d6d:	c3                   	ret    

00000d6e <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
     d6e:	f3 0f 1e fb          	endbr32 
     d72:	55                   	push   %ebp
     d73:	89 e5                	mov    %esp,%ebp
     d75:	83 ec 08             	sub    $0x8,%esp
    setid();
     d78:	e8 1b ff ff ff       	call   c98 <setid>

    while (getid()){
     d7d:	eb 16                	jmp    d95 <cek_uid+0x27>
        if(current_id.uid_user == uid){
     d7f:	a1 a4 15 00 00       	mov    0x15a4,%eax
     d84:	39 45 08             	cmp    %eax,0x8(%ebp)
     d87:	75 0c                	jne    d95 <cek_uid+0x27>
            endid();
     d89:	e8 65 ff ff ff       	call   cf3 <endid>
            return &current_id;
     d8e:	b8 a0 15 00 00       	mov    $0x15a0,%eax
     d93:	eb 13                	jmp    da8 <cek_uid+0x3a>
    while (getid()){
     d95:	e8 a2 fe ff ff       	call   c3c <getid>
     d9a:	85 c0                	test   %eax,%eax
     d9c:	75 e1                	jne    d7f <cek_uid+0x11>
        }
    }
    endid();
     d9e:	e8 50 ff ff ff       	call   cf3 <endid>
    return 0;
     da3:	b8 00 00 00 00       	mov    $0x0,%eax
}
     da8:	c9                   	leave  
     da9:	c3                   	ret    

00000daa <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
     daa:	f3 0f 1e fb          	endbr32 
     dae:	55                   	push   %ebp
     daf:	89 e5                	mov    %esp,%ebp
     db1:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     db4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     dbb:	a1 e0 15 00 00       	mov    0x15e0,%eax
     dc0:	83 ec 04             	sub    $0x4,%esp
     dc3:	50                   	push   %eax
     dc4:	6a 20                	push   $0x20
     dc6:	68 c0 15 00 00       	push   $0x15c0
     dcb:	e8 69 f5 ff ff       	call   339 <fgets>
     dd0:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     dd3:	83 ec 0c             	sub    $0xc,%esp
     dd6:	68 c0 15 00 00       	push   $0x15c0
     ddb:	e8 66 f4 ff ff       	call   246 <strlen>
     de0:	83 c4 10             	add    $0x10,%esp
     de3:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     de6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     de9:	83 e8 01             	sub    $0x1,%eax
     dec:	0f b6 80 c0 15 00 00 	movzbl 0x15c0(%eax),%eax
     df3:	3c 0a                	cmp    $0xa,%al
     df5:	74 11                	je     e08 <get_group+0x5e>
     df7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dfa:	83 e8 01             	sub    $0x1,%eax
     dfd:	0f b6 80 c0 15 00 00 	movzbl 0x15c0(%eax),%eax
     e04:	3c 0d                	cmp    $0xd,%al
     e06:	75 0d                	jne    e15 <get_group+0x6b>
        current_line[len - 1] = 0;
     e08:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e0b:	83 e8 01             	sub    $0x1,%eax
     e0e:	c6 80 c0 15 00 00 00 	movb   $0x0,0x15c0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     e15:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     e1c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e23:	eb 6c                	jmp    e91 <get_group+0xe7>
        if(current_line[i] == ' '){
     e25:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e28:	05 c0 15 00 00       	add    $0x15c0,%eax
     e2d:	0f b6 00             	movzbl (%eax),%eax
     e30:	3c 20                	cmp    $0x20,%al
     e32:	75 30                	jne    e64 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     e34:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e38:	75 16                	jne    e50 <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     e3a:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     e3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e40:	8d 50 01             	lea    0x1(%eax),%edx
     e43:	89 55 f0             	mov    %edx,-0x10(%ebp)
     e46:	8d 91 c0 15 00 00    	lea    0x15c0(%ecx),%edx
     e4c:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     e50:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e53:	05 c0 15 00 00       	add    $0x15c0,%eax
     e58:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     e5b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e62:	eb 29                	jmp    e8d <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     e64:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e68:	75 23                	jne    e8d <get_group+0xe3>
     e6a:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     e6e:	7f 1d                	jg     e8d <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     e70:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     e77:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     e7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e7d:	8d 50 01             	lea    0x1(%eax),%edx
     e80:	89 55 f0             	mov    %edx,-0x10(%ebp)
     e83:	8d 91 c0 15 00 00    	lea    0x15c0(%ecx),%edx
     e89:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     e8d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     e91:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e94:	05 c0 15 00 00       	add    $0x15c0,%eax
     e99:	0f b6 00             	movzbl (%eax),%eax
     e9c:	84 c0                	test   %al,%al
     e9e:	75 85                	jne    e25 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     ea0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ea4:	75 07                	jne    ead <get_group+0x103>
        return -1;
     ea6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     eab:	eb 21                	jmp    ece <get_group+0x124>
    
    current_group.nama_group = tokens[0];
     ead:	8b 45 dc             	mov    -0x24(%ebp),%eax
     eb0:	a3 ac 15 00 00       	mov    %eax,0x15ac
    current_group.gid = atoi(tokens[1]);
     eb5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     eb8:	83 ec 0c             	sub    $0xc,%esp
     ebb:	50                   	push   %eax
     ebc:	e8 3d f5 ff ff       	call   3fe <atoi>
     ec1:	83 c4 10             	add    $0x10,%esp
     ec4:	a3 b0 15 00 00       	mov    %eax,0x15b0

    return 0;
     ec9:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ece:	c9                   	leave  
     ecf:	c3                   	ret    

00000ed0 <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
     ed0:	f3 0f 1e fb          	endbr32 
     ed4:	55                   	push   %ebp
     ed5:	89 e5                	mov    %esp,%ebp
     ed7:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     eda:	a1 e0 15 00 00       	mov    0x15e0,%eax
     edf:	85 c0                	test   %eax,%eax
     ee1:	75 31                	jne    f14 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
     ee3:	83 ec 08             	sub    $0x8,%esp
     ee6:	6a 00                	push   $0x0
     ee8:	68 42 11 00 00       	push   $0x1142
     eed:	e8 bd f6 ff ff       	call   5af <open>
     ef2:	83 c4 10             	add    $0x10,%esp
     ef5:	a3 e0 15 00 00       	mov    %eax,0x15e0

        if(dir < 0){        // kalau gagal membuka file
     efa:	a1 e0 15 00 00       	mov    0x15e0,%eax
     eff:	85 c0                	test   %eax,%eax
     f01:	79 11                	jns    f14 <getgroup+0x44>
            dir = 0;
     f03:	c7 05 e0 15 00 00 00 	movl   $0x0,0x15e0
     f0a:	00 00 00 
            return 0;
     f0d:	b8 00 00 00 00       	mov    $0x0,%eax
     f12:	eb 16                	jmp    f2a <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
     f14:	e8 91 fe ff ff       	call   daa <get_group>
     f19:	83 f8 ff             	cmp    $0xffffffff,%eax
     f1c:	75 07                	jne    f25 <getgroup+0x55>
        return 0;
     f1e:	b8 00 00 00 00       	mov    $0x0,%eax
     f23:	eb 05                	jmp    f2a <getgroup+0x5a>
    
    return &current_group;
     f25:	b8 ac 15 00 00       	mov    $0x15ac,%eax
}
     f2a:	c9                   	leave  
     f2b:	c3                   	ret    

00000f2c <setgroup>:

// open file_ids
void setgroup(void){
     f2c:	f3 0f 1e fb          	endbr32 
     f30:	55                   	push   %ebp
     f31:	89 e5                	mov    %esp,%ebp
     f33:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     f36:	a1 e0 15 00 00       	mov    0x15e0,%eax
     f3b:	85 c0                	test   %eax,%eax
     f3d:	74 1b                	je     f5a <setgroup+0x2e>
        close(dir);
     f3f:	a1 e0 15 00 00       	mov    0x15e0,%eax
     f44:	83 ec 0c             	sub    $0xc,%esp
     f47:	50                   	push   %eax
     f48:	e8 4a f6 ff ff       	call   597 <close>
     f4d:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     f50:	c7 05 e0 15 00 00 00 	movl   $0x0,0x15e0
     f57:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
     f5a:	83 ec 08             	sub    $0x8,%esp
     f5d:	6a 00                	push   $0x0
     f5f:	68 42 11 00 00       	push   $0x1142
     f64:	e8 46 f6 ff ff       	call   5af <open>
     f69:	83 c4 10             	add    $0x10,%esp
     f6c:	a3 e0 15 00 00       	mov    %eax,0x15e0

    if (dir < 0)
     f71:	a1 e0 15 00 00       	mov    0x15e0,%eax
     f76:	85 c0                	test   %eax,%eax
     f78:	79 0a                	jns    f84 <setgroup+0x58>
        dir = 0;
     f7a:	c7 05 e0 15 00 00 00 	movl   $0x0,0x15e0
     f81:	00 00 00 
}
     f84:	90                   	nop
     f85:	c9                   	leave  
     f86:	c3                   	ret    

00000f87 <endgroup>:

// tutup file_ids
void endgroup (void){
     f87:	f3 0f 1e fb          	endbr32 
     f8b:	55                   	push   %ebp
     f8c:	89 e5                	mov    %esp,%ebp
     f8e:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     f91:	a1 e0 15 00 00       	mov    0x15e0,%eax
     f96:	85 c0                	test   %eax,%eax
     f98:	74 1b                	je     fb5 <endgroup+0x2e>
        close(dir);
     f9a:	a1 e0 15 00 00       	mov    0x15e0,%eax
     f9f:	83 ec 0c             	sub    $0xc,%esp
     fa2:	50                   	push   %eax
     fa3:	e8 ef f5 ff ff       	call   597 <close>
     fa8:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     fab:	c7 05 e0 15 00 00 00 	movl   $0x0,0x15e0
     fb2:	00 00 00 
    }
}
     fb5:	90                   	nop
     fb6:	c9                   	leave  
     fb7:	c3                   	ret    

00000fb8 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
     fb8:	f3 0f 1e fb          	endbr32 
     fbc:	55                   	push   %ebp
     fbd:	89 e5                	mov    %esp,%ebp
     fbf:	83 ec 08             	sub    $0x8,%esp
    setgroup();
     fc2:	e8 65 ff ff ff       	call   f2c <setgroup>

    while (getgroup()){
     fc7:	eb 3c                	jmp    1005 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
     fc9:	a1 ac 15 00 00       	mov    0x15ac,%eax
     fce:	83 ec 08             	sub    $0x8,%esp
     fd1:	50                   	push   %eax
     fd2:	ff 75 08             	pushl  0x8(%ebp)
     fd5:	e8 29 f2 ff ff       	call   203 <strcmp>
     fda:	83 c4 10             	add    $0x10,%esp
     fdd:	85 c0                	test   %eax,%eax
     fdf:	75 24                	jne    1005 <cek_nama_group+0x4d>
            endgroup();
     fe1:	e8 a1 ff ff ff       	call   f87 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
     fe6:	a1 ac 15 00 00       	mov    0x15ac,%eax
     feb:	83 ec 04             	sub    $0x4,%esp
     fee:	50                   	push   %eax
     fef:	68 4d 11 00 00       	push   $0x114d
     ff4:	6a 01                	push   $0x1
     ff6:	e8 40 f7 ff ff       	call   73b <printf>
     ffb:	83 c4 10             	add    $0x10,%esp
            return &current_group;
     ffe:	b8 ac 15 00 00       	mov    $0x15ac,%eax
    1003:	eb 13                	jmp    1018 <cek_nama_group+0x60>
    while (getgroup()){
    1005:	e8 c6 fe ff ff       	call   ed0 <getgroup>
    100a:	85 c0                	test   %eax,%eax
    100c:	75 bb                	jne    fc9 <cek_nama_group+0x11>
        }
    }
    endgroup();
    100e:	e8 74 ff ff ff       	call   f87 <endgroup>
    return 0;
    1013:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1018:	c9                   	leave  
    1019:	c3                   	ret    

0000101a <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
    101a:	f3 0f 1e fb          	endbr32 
    101e:	55                   	push   %ebp
    101f:	89 e5                	mov    %esp,%ebp
    1021:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    1024:	e8 03 ff ff ff       	call   f2c <setgroup>

    while (getgroup()){
    1029:	eb 16                	jmp    1041 <cek_gid+0x27>
        if(current_group.gid == gid){
    102b:	a1 b0 15 00 00       	mov    0x15b0,%eax
    1030:	39 45 08             	cmp    %eax,0x8(%ebp)
    1033:	75 0c                	jne    1041 <cek_gid+0x27>
            endgroup();
    1035:	e8 4d ff ff ff       	call   f87 <endgroup>
            return &current_group;
    103a:	b8 ac 15 00 00       	mov    $0x15ac,%eax
    103f:	eb 13                	jmp    1054 <cek_gid+0x3a>
    while (getgroup()){
    1041:	e8 8a fe ff ff       	call   ed0 <getgroup>
    1046:	85 c0                	test   %eax,%eax
    1048:	75 e1                	jne    102b <cek_gid+0x11>
        }
    }
    endgroup();
    104a:	e8 38 ff ff ff       	call   f87 <endgroup>
    return 0;
    104f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1054:	c9                   	leave  
    1055:	c3                   	ret    
