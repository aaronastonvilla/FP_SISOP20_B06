
_clear:     file format elf32-i386


Disassembly of section .text:

00000000 <clear>:
#include "types.h"
#include "user.h"

void clear(int ascii){
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	83 ec 08             	sub    $0x8,%esp
    // algoritmanya yaitu print enter ("\n")
    // dari ASCII A sampai Z
    // secara rekursif

    if(ascii=='Z')
   a:	83 7d 08 5a          	cmpl   $0x5a,0x8(%ebp)
   e:	74 26                	je     36 <clear+0x36>
        return;
    
    printf(1,"\n");
  10:	83 ec 08             	sub    $0x8,%esp
  13:	68 0d 0f 00 00       	push   $0xf0d
  18:	6a 01                	push   $0x1
  1a:	e8 d3 05 00 00       	call   5f2 <printf>
  1f:	83 c4 10             	add    $0x10,%esp
    
    clear(ascii+1);
  22:	8b 45 08             	mov    0x8(%ebp),%eax
  25:	83 c0 01             	add    $0x1,%eax
  28:	83 ec 0c             	sub    $0xc,%esp
  2b:	50                   	push   %eax
  2c:	e8 cf ff ff ff       	call   0 <clear>
  31:	83 c4 10             	add    $0x10,%esp
  34:	eb 01                	jmp    37 <clear+0x37>
        return;
  36:	90                   	nop
}
  37:	c9                   	leave  
  38:	c3                   	ret    

00000039 <main>:

int main(void){
  39:	f3 0f 1e fb          	endbr32 
  3d:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  41:	83 e4 f0             	and    $0xfffffff0,%esp
  44:	ff 71 fc             	pushl  -0x4(%ecx)
  47:	55                   	push   %ebp
  48:	89 e5                	mov    %esp,%ebp
  4a:	51                   	push   %ecx
  4b:	83 ec 04             	sub    $0x4,%esp
    clear('A');
  4e:	83 ec 0c             	sub    $0xc,%esp
  51:	6a 41                	push   $0x41
  53:	e8 a8 ff ff ff       	call   0 <clear>
  58:	83 c4 10             	add    $0x10,%esp
    exit();
  5b:	e8 c6 03 00 00       	call   426 <exit>

00000060 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	57                   	push   %edi
  64:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  65:	8b 4d 08             	mov    0x8(%ebp),%ecx
  68:	8b 55 10             	mov    0x10(%ebp),%edx
  6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  6e:	89 cb                	mov    %ecx,%ebx
  70:	89 df                	mov    %ebx,%edi
  72:	89 d1                	mov    %edx,%ecx
  74:	fc                   	cld    
  75:	f3 aa                	rep stos %al,%es:(%edi)
  77:	89 ca                	mov    %ecx,%edx
  79:	89 fb                	mov    %edi,%ebx
  7b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  7e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  81:	90                   	nop
  82:	5b                   	pop    %ebx
  83:	5f                   	pop    %edi
  84:	5d                   	pop    %ebp
  85:	c3                   	ret    

00000086 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  86:	f3 0f 1e fb          	endbr32 
  8a:	55                   	push   %ebp
  8b:	89 e5                	mov    %esp,%ebp
  8d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  90:	8b 45 08             	mov    0x8(%ebp),%eax
  93:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  96:	90                   	nop
  97:	8b 55 0c             	mov    0xc(%ebp),%edx
  9a:	8d 42 01             	lea    0x1(%edx),%eax
  9d:	89 45 0c             	mov    %eax,0xc(%ebp)
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	8d 48 01             	lea    0x1(%eax),%ecx
  a6:	89 4d 08             	mov    %ecx,0x8(%ebp)
  a9:	0f b6 12             	movzbl (%edx),%edx
  ac:	88 10                	mov    %dl,(%eax)
  ae:	0f b6 00             	movzbl (%eax),%eax
  b1:	84 c0                	test   %al,%al
  b3:	75 e2                	jne    97 <strcpy+0x11>
    ;
  return os;
  b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  b8:	c9                   	leave  
  b9:	c3                   	ret    

000000ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ba:	f3 0f 1e fb          	endbr32 
  be:	55                   	push   %ebp
  bf:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c1:	eb 08                	jmp    cb <strcmp+0x11>
    p++, q++;
  c3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  cb:	8b 45 08             	mov    0x8(%ebp),%eax
  ce:	0f b6 00             	movzbl (%eax),%eax
  d1:	84 c0                	test   %al,%al
  d3:	74 10                	je     e5 <strcmp+0x2b>
  d5:	8b 45 08             	mov    0x8(%ebp),%eax
  d8:	0f b6 10             	movzbl (%eax),%edx
  db:	8b 45 0c             	mov    0xc(%ebp),%eax
  de:	0f b6 00             	movzbl (%eax),%eax
  e1:	38 c2                	cmp    %al,%dl
  e3:	74 de                	je     c3 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
  e5:	8b 45 08             	mov    0x8(%ebp),%eax
  e8:	0f b6 00             	movzbl (%eax),%eax
  eb:	0f b6 d0             	movzbl %al,%edx
  ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  f1:	0f b6 00             	movzbl (%eax),%eax
  f4:	0f b6 c0             	movzbl %al,%eax
  f7:	29 c2                	sub    %eax,%edx
  f9:	89 d0                	mov    %edx,%eax
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    

000000fd <strlen>:

uint
strlen(char *s)
{
  fd:	f3 0f 1e fb          	endbr32 
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 107:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10e:	eb 04                	jmp    114 <strlen+0x17>
 110:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 114:	8b 55 fc             	mov    -0x4(%ebp),%edx
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	01 d0                	add    %edx,%eax
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	84 c0                	test   %al,%al
 121:	75 ed                	jne    110 <strlen+0x13>
    ;
  return n;
 123:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 126:	c9                   	leave  
 127:	c3                   	ret    

00000128 <memset>:

void*
memset(void *dst, int c, uint n)
{
 128:	f3 0f 1e fb          	endbr32 
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 12f:	8b 45 10             	mov    0x10(%ebp),%eax
 132:	50                   	push   %eax
 133:	ff 75 0c             	pushl  0xc(%ebp)
 136:	ff 75 08             	pushl  0x8(%ebp)
 139:	e8 22 ff ff ff       	call   60 <stosb>
 13e:	83 c4 0c             	add    $0xc,%esp
  return dst;
 141:	8b 45 08             	mov    0x8(%ebp),%eax
}
 144:	c9                   	leave  
 145:	c3                   	ret    

00000146 <strchr>:

char*
strchr(const char *s, char c)
{
 146:	f3 0f 1e fb          	endbr32 
 14a:	55                   	push   %ebp
 14b:	89 e5                	mov    %esp,%ebp
 14d:	83 ec 04             	sub    $0x4,%esp
 150:	8b 45 0c             	mov    0xc(%ebp),%eax
 153:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 156:	eb 14                	jmp    16c <strchr+0x26>
    if(*s == c)
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	0f b6 00             	movzbl (%eax),%eax
 15e:	38 45 fc             	cmp    %al,-0x4(%ebp)
 161:	75 05                	jne    168 <strchr+0x22>
      return (char*)s;
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	eb 13                	jmp    17b <strchr+0x35>
  for(; *s; s++)
 168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	0f b6 00             	movzbl (%eax),%eax
 172:	84 c0                	test   %al,%al
 174:	75 e2                	jne    158 <strchr+0x12>
  return 0;
 176:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17b:	c9                   	leave  
 17c:	c3                   	ret    

0000017d <gets>:

char*
gets(char *buf, int max)
{
 17d:	f3 0f 1e fb          	endbr32 
 181:	55                   	push   %ebp
 182:	89 e5                	mov    %esp,%ebp
 184:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 187:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 18e:	eb 42                	jmp    1d2 <gets+0x55>
    cc = read(0, &c, 1);
 190:	83 ec 04             	sub    $0x4,%esp
 193:	6a 01                	push   $0x1
 195:	8d 45 ef             	lea    -0x11(%ebp),%eax
 198:	50                   	push   %eax
 199:	6a 00                	push   $0x0
 19b:	e8 9e 02 00 00       	call   43e <read>
 1a0:	83 c4 10             	add    $0x10,%esp
 1a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1aa:	7e 33                	jle    1df <gets+0x62>
      break;
    buf[i++] = c;
 1ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1af:	8d 50 01             	lea    0x1(%eax),%edx
 1b2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b5:	89 c2                	mov    %eax,%edx
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	01 c2                	add    %eax,%edx
 1bc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c0:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1c2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c6:	3c 0a                	cmp    $0xa,%al
 1c8:	74 16                	je     1e0 <gets+0x63>
 1ca:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ce:	3c 0d                	cmp    $0xd,%al
 1d0:	74 0e                	je     1e0 <gets+0x63>
  for(i=0; i+1 < max; ){
 1d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d5:	83 c0 01             	add    $0x1,%eax
 1d8:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1db:	7f b3                	jg     190 <gets+0x13>
 1dd:	eb 01                	jmp    1e0 <gets+0x63>
      break;
 1df:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	01 d0                	add    %edx,%eax
 1e8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ee:	c9                   	leave  
 1ef:	c3                   	ret    

000001f0 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
 1f0:	f3 0f 1e fb          	endbr32 
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
 1fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 201:	eb 43                	jmp    246 <fgets+0x56>
    int cc = read(fd, &c, 1);
 203:	83 ec 04             	sub    $0x4,%esp
 206:	6a 01                	push   $0x1
 208:	8d 45 ef             	lea    -0x11(%ebp),%eax
 20b:	50                   	push   %eax
 20c:	ff 75 10             	pushl  0x10(%ebp)
 20f:	e8 2a 02 00 00       	call   43e <read>
 214:	83 c4 10             	add    $0x10,%esp
 217:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 21a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 21e:	7e 33                	jle    253 <fgets+0x63>
      break;
    buf[i++] = c;
 220:	8b 45 f4             	mov    -0xc(%ebp),%eax
 223:	8d 50 01             	lea    0x1(%eax),%edx
 226:	89 55 f4             	mov    %edx,-0xc(%ebp)
 229:	89 c2                	mov    %eax,%edx
 22b:	8b 45 08             	mov    0x8(%ebp),%eax
 22e:	01 c2                	add    %eax,%edx
 230:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 234:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 236:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 23a:	3c 0a                	cmp    $0xa,%al
 23c:	74 16                	je     254 <fgets+0x64>
 23e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 242:	3c 0d                	cmp    $0xd,%al
 244:	74 0e                	je     254 <fgets+0x64>
  for(i = 0; i + 1 < size;){
 246:	8b 45 f4             	mov    -0xc(%ebp),%eax
 249:	83 c0 01             	add    $0x1,%eax
 24c:	39 45 0c             	cmp    %eax,0xc(%ebp)
 24f:	7f b2                	jg     203 <fgets+0x13>
 251:	eb 01                	jmp    254 <fgets+0x64>
      break;
 253:	90                   	nop
      break;
  }
  buf[i] = '\0';
 254:	8b 55 f4             	mov    -0xc(%ebp),%edx
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	01 d0                	add    %edx,%eax
 25c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 25f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 262:	c9                   	leave  
 263:	c3                   	ret    

00000264 <stat>:

int
stat(char *n, struct stat *st)
{
 264:	f3 0f 1e fb          	endbr32 
 268:	55                   	push   %ebp
 269:	89 e5                	mov    %esp,%ebp
 26b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 26e:	83 ec 08             	sub    $0x8,%esp
 271:	6a 00                	push   $0x0
 273:	ff 75 08             	pushl  0x8(%ebp)
 276:	e8 eb 01 00 00       	call   466 <open>
 27b:	83 c4 10             	add    $0x10,%esp
 27e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 281:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 285:	79 07                	jns    28e <stat+0x2a>
    return -1;
 287:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 28c:	eb 25                	jmp    2b3 <stat+0x4f>
  r = fstat(fd, st);
 28e:	83 ec 08             	sub    $0x8,%esp
 291:	ff 75 0c             	pushl  0xc(%ebp)
 294:	ff 75 f4             	pushl  -0xc(%ebp)
 297:	e8 e2 01 00 00       	call   47e <fstat>
 29c:	83 c4 10             	add    $0x10,%esp
 29f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2a2:	83 ec 0c             	sub    $0xc,%esp
 2a5:	ff 75 f4             	pushl  -0xc(%ebp)
 2a8:	e8 a1 01 00 00       	call   44e <close>
 2ad:	83 c4 10             	add    $0x10,%esp
  return r;
 2b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2b3:	c9                   	leave  
 2b4:	c3                   	ret    

000002b5 <atoi>:

int
atoi(const char *s)
{
 2b5:	f3 0f 1e fb          	endbr32 
 2b9:	55                   	push   %ebp
 2ba:	89 e5                	mov    %esp,%ebp
 2bc:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 2bf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 2c6:	eb 04                	jmp    2cc <atoi+0x17>
 2c8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2cc:	8b 45 08             	mov    0x8(%ebp),%eax
 2cf:	0f b6 00             	movzbl (%eax),%eax
 2d2:	3c 20                	cmp    $0x20,%al
 2d4:	74 f2                	je     2c8 <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
 2d9:	0f b6 00             	movzbl (%eax),%eax
 2dc:	3c 2d                	cmp    $0x2d,%al
 2de:	75 07                	jne    2e7 <atoi+0x32>
 2e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2e5:	eb 05                	jmp    2ec <atoi+0x37>
 2e7:	b8 01 00 00 00       	mov    $0x1,%eax
 2ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 2ef:	8b 45 08             	mov    0x8(%ebp),%eax
 2f2:	0f b6 00             	movzbl (%eax),%eax
 2f5:	3c 2b                	cmp    $0x2b,%al
 2f7:	74 0a                	je     303 <atoi+0x4e>
 2f9:	8b 45 08             	mov    0x8(%ebp),%eax
 2fc:	0f b6 00             	movzbl (%eax),%eax
 2ff:	3c 2d                	cmp    $0x2d,%al
 301:	75 2b                	jne    32e <atoi+0x79>
    s++;
 303:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 307:	eb 25                	jmp    32e <atoi+0x79>
    n = n*10 + *s++ - '0';
 309:	8b 55 fc             	mov    -0x4(%ebp),%edx
 30c:	89 d0                	mov    %edx,%eax
 30e:	c1 e0 02             	shl    $0x2,%eax
 311:	01 d0                	add    %edx,%eax
 313:	01 c0                	add    %eax,%eax
 315:	89 c1                	mov    %eax,%ecx
 317:	8b 45 08             	mov    0x8(%ebp),%eax
 31a:	8d 50 01             	lea    0x1(%eax),%edx
 31d:	89 55 08             	mov    %edx,0x8(%ebp)
 320:	0f b6 00             	movzbl (%eax),%eax
 323:	0f be c0             	movsbl %al,%eax
 326:	01 c8                	add    %ecx,%eax
 328:	83 e8 30             	sub    $0x30,%eax
 32b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
 331:	0f b6 00             	movzbl (%eax),%eax
 334:	3c 2f                	cmp    $0x2f,%al
 336:	7e 0a                	jle    342 <atoi+0x8d>
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	0f b6 00             	movzbl (%eax),%eax
 33e:	3c 39                	cmp    $0x39,%al
 340:	7e c7                	jle    309 <atoi+0x54>
  return sign*n;
 342:	8b 45 f8             	mov    -0x8(%ebp),%eax
 345:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 349:	c9                   	leave  
 34a:	c3                   	ret    

0000034b <atoo>:

int
atoo(const char *s)
{
 34b:	f3 0f 1e fb          	endbr32 
 34f:	55                   	push   %ebp
 350:	89 e5                	mov    %esp,%ebp
 352:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 355:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 35c:	eb 04                	jmp    362 <atoo+0x17>
 35e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 362:	8b 45 08             	mov    0x8(%ebp),%eax
 365:	0f b6 00             	movzbl (%eax),%eax
 368:	3c 20                	cmp    $0x20,%al
 36a:	74 f2                	je     35e <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
 36c:	8b 45 08             	mov    0x8(%ebp),%eax
 36f:	0f b6 00             	movzbl (%eax),%eax
 372:	3c 2d                	cmp    $0x2d,%al
 374:	75 07                	jne    37d <atoo+0x32>
 376:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 37b:	eb 05                	jmp    382 <atoo+0x37>
 37d:	b8 01 00 00 00       	mov    $0x1,%eax
 382:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 385:	8b 45 08             	mov    0x8(%ebp),%eax
 388:	0f b6 00             	movzbl (%eax),%eax
 38b:	3c 2b                	cmp    $0x2b,%al
 38d:	74 0a                	je     399 <atoo+0x4e>
 38f:	8b 45 08             	mov    0x8(%ebp),%eax
 392:	0f b6 00             	movzbl (%eax),%eax
 395:	3c 2d                	cmp    $0x2d,%al
 397:	75 27                	jne    3c0 <atoo+0x75>
    s++;
 399:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 39d:	eb 21                	jmp    3c0 <atoo+0x75>
    n = n*8 + *s++ - '0';
 39f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3a2:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 3a9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ac:	8d 50 01             	lea    0x1(%eax),%edx
 3af:	89 55 08             	mov    %edx,0x8(%ebp)
 3b2:	0f b6 00             	movzbl (%eax),%eax
 3b5:	0f be c0             	movsbl %al,%eax
 3b8:	01 c8                	add    %ecx,%eax
 3ba:	83 e8 30             	sub    $0x30,%eax
 3bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
 3c0:	8b 45 08             	mov    0x8(%ebp),%eax
 3c3:	0f b6 00             	movzbl (%eax),%eax
 3c6:	3c 2f                	cmp    $0x2f,%al
 3c8:	7e 0a                	jle    3d4 <atoo+0x89>
 3ca:	8b 45 08             	mov    0x8(%ebp),%eax
 3cd:	0f b6 00             	movzbl (%eax),%eax
 3d0:	3c 37                	cmp    $0x37,%al
 3d2:	7e cb                	jle    39f <atoo+0x54>
  return sign*n;
 3d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3d7:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 3db:	c9                   	leave  
 3dc:	c3                   	ret    

000003dd <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 3dd:	f3 0f 1e fb          	endbr32 
 3e1:	55                   	push   %ebp
 3e2:	89 e5                	mov    %esp,%ebp
 3e4:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3e7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3ed:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3f3:	eb 17                	jmp    40c <memmove+0x2f>
    *dst++ = *src++;
 3f5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3f8:	8d 42 01             	lea    0x1(%edx),%eax
 3fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
 3fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 401:	8d 48 01             	lea    0x1(%eax),%ecx
 404:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 407:	0f b6 12             	movzbl (%edx),%edx
 40a:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 40c:	8b 45 10             	mov    0x10(%ebp),%eax
 40f:	8d 50 ff             	lea    -0x1(%eax),%edx
 412:	89 55 10             	mov    %edx,0x10(%ebp)
 415:	85 c0                	test   %eax,%eax
 417:	7f dc                	jg     3f5 <memmove+0x18>
  return vdst;
 419:	8b 45 08             	mov    0x8(%ebp),%eax
}
 41c:	c9                   	leave  
 41d:	c3                   	ret    

0000041e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 41e:	b8 01 00 00 00       	mov    $0x1,%eax
 423:	cd 40                	int    $0x40
 425:	c3                   	ret    

00000426 <exit>:
SYSCALL(exit)
 426:	b8 02 00 00 00       	mov    $0x2,%eax
 42b:	cd 40                	int    $0x40
 42d:	c3                   	ret    

0000042e <wait>:
SYSCALL(wait)
 42e:	b8 03 00 00 00       	mov    $0x3,%eax
 433:	cd 40                	int    $0x40
 435:	c3                   	ret    

00000436 <pipe>:
SYSCALL(pipe)
 436:	b8 04 00 00 00       	mov    $0x4,%eax
 43b:	cd 40                	int    $0x40
 43d:	c3                   	ret    

0000043e <read>:
SYSCALL(read)
 43e:	b8 05 00 00 00       	mov    $0x5,%eax
 443:	cd 40                	int    $0x40
 445:	c3                   	ret    

00000446 <write>:
SYSCALL(write)
 446:	b8 10 00 00 00       	mov    $0x10,%eax
 44b:	cd 40                	int    $0x40
 44d:	c3                   	ret    

0000044e <close>:
SYSCALL(close)
 44e:	b8 15 00 00 00       	mov    $0x15,%eax
 453:	cd 40                	int    $0x40
 455:	c3                   	ret    

00000456 <kill>:
SYSCALL(kill)
 456:	b8 06 00 00 00       	mov    $0x6,%eax
 45b:	cd 40                	int    $0x40
 45d:	c3                   	ret    

0000045e <exec>:
SYSCALL(exec)
 45e:	b8 07 00 00 00       	mov    $0x7,%eax
 463:	cd 40                	int    $0x40
 465:	c3                   	ret    

00000466 <open>:
SYSCALL(open)
 466:	b8 0f 00 00 00       	mov    $0xf,%eax
 46b:	cd 40                	int    $0x40
 46d:	c3                   	ret    

0000046e <mknod>:
SYSCALL(mknod)
 46e:	b8 11 00 00 00       	mov    $0x11,%eax
 473:	cd 40                	int    $0x40
 475:	c3                   	ret    

00000476 <unlink>:
SYSCALL(unlink)
 476:	b8 12 00 00 00       	mov    $0x12,%eax
 47b:	cd 40                	int    $0x40
 47d:	c3                   	ret    

0000047e <fstat>:
SYSCALL(fstat)
 47e:	b8 08 00 00 00       	mov    $0x8,%eax
 483:	cd 40                	int    $0x40
 485:	c3                   	ret    

00000486 <link>:
SYSCALL(link)
 486:	b8 13 00 00 00       	mov    $0x13,%eax
 48b:	cd 40                	int    $0x40
 48d:	c3                   	ret    

0000048e <mkdir>:
SYSCALL(mkdir)
 48e:	b8 14 00 00 00       	mov    $0x14,%eax
 493:	cd 40                	int    $0x40
 495:	c3                   	ret    

00000496 <chdir>:
SYSCALL(chdir)
 496:	b8 09 00 00 00       	mov    $0x9,%eax
 49b:	cd 40                	int    $0x40
 49d:	c3                   	ret    

0000049e <dup>:
SYSCALL(dup)
 49e:	b8 0a 00 00 00       	mov    $0xa,%eax
 4a3:	cd 40                	int    $0x40
 4a5:	c3                   	ret    

000004a6 <getpid>:
SYSCALL(getpid)
 4a6:	b8 0b 00 00 00       	mov    $0xb,%eax
 4ab:	cd 40                	int    $0x40
 4ad:	c3                   	ret    

000004ae <sbrk>:
SYSCALL(sbrk)
 4ae:	b8 0c 00 00 00       	mov    $0xc,%eax
 4b3:	cd 40                	int    $0x40
 4b5:	c3                   	ret    

000004b6 <sleep>:
SYSCALL(sleep)
 4b6:	b8 0d 00 00 00       	mov    $0xd,%eax
 4bb:	cd 40                	int    $0x40
 4bd:	c3                   	ret    

000004be <uptime>:
SYSCALL(uptime)
 4be:	b8 0e 00 00 00       	mov    $0xe,%eax
 4c3:	cd 40                	int    $0x40
 4c5:	c3                   	ret    

000004c6 <halt>:
SYSCALL(halt)
 4c6:	b8 16 00 00 00       	mov    $0x16,%eax
 4cb:	cd 40                	int    $0x40
 4cd:	c3                   	ret    

000004ce <date>:
SYSCALL(date)
 4ce:	b8 17 00 00 00       	mov    $0x17,%eax
 4d3:	cd 40                	int    $0x40
 4d5:	c3                   	ret    

000004d6 <getuid>:
SYSCALL(getuid)
 4d6:	b8 18 00 00 00       	mov    $0x18,%eax
 4db:	cd 40                	int    $0x40
 4dd:	c3                   	ret    

000004de <getgid>:
SYSCALL(getgid)
 4de:	b8 19 00 00 00       	mov    $0x19,%eax
 4e3:	cd 40                	int    $0x40
 4e5:	c3                   	ret    

000004e6 <getppid>:
SYSCALL(getppid)
 4e6:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4eb:	cd 40                	int    $0x40
 4ed:	c3                   	ret    

000004ee <setuid>:
SYSCALL(setuid)
 4ee:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4f3:	cd 40                	int    $0x40
 4f5:	c3                   	ret    

000004f6 <setgid>:
SYSCALL(setgid)
 4f6:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4fb:	cd 40                	int    $0x40
 4fd:	c3                   	ret    

000004fe <getprocs>:
SYSCALL(getprocs)
 4fe:	b8 1d 00 00 00       	mov    $0x1d,%eax
 503:	cd 40                	int    $0x40
 505:	c3                   	ret    

00000506 <setpriority>:
SYSCALL(setpriority)
 506:	b8 1e 00 00 00       	mov    $0x1e,%eax
 50b:	cd 40                	int    $0x40
 50d:	c3                   	ret    

0000050e <chown>:
SYSCALL(chown)
 50e:	b8 1f 00 00 00       	mov    $0x1f,%eax
 513:	cd 40                	int    $0x40
 515:	c3                   	ret    

00000516 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 516:	f3 0f 1e fb          	endbr32 
 51a:	55                   	push   %ebp
 51b:	89 e5                	mov    %esp,%ebp
 51d:	83 ec 18             	sub    $0x18,%esp
 520:	8b 45 0c             	mov    0xc(%ebp),%eax
 523:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 526:	83 ec 04             	sub    $0x4,%esp
 529:	6a 01                	push   $0x1
 52b:	8d 45 f4             	lea    -0xc(%ebp),%eax
 52e:	50                   	push   %eax
 52f:	ff 75 08             	pushl  0x8(%ebp)
 532:	e8 0f ff ff ff       	call   446 <write>
 537:	83 c4 10             	add    $0x10,%esp
}
 53a:	90                   	nop
 53b:	c9                   	leave  
 53c:	c3                   	ret    

0000053d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 53d:	f3 0f 1e fb          	endbr32 
 541:	55                   	push   %ebp
 542:	89 e5                	mov    %esp,%ebp
 544:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 547:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 54e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 552:	74 17                	je     56b <printint+0x2e>
 554:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 558:	79 11                	jns    56b <printint+0x2e>
    neg = 1;
 55a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 561:	8b 45 0c             	mov    0xc(%ebp),%eax
 564:	f7 d8                	neg    %eax
 566:	89 45 ec             	mov    %eax,-0x14(%ebp)
 569:	eb 06                	jmp    571 <printint+0x34>
  } else {
    x = xx;
 56b:	8b 45 0c             	mov    0xc(%ebp),%eax
 56e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 571:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 578:	8b 4d 10             	mov    0x10(%ebp),%ecx
 57b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 57e:	ba 00 00 00 00       	mov    $0x0,%edx
 583:	f7 f1                	div    %ecx
 585:	89 d1                	mov    %edx,%ecx
 587:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58a:	8d 50 01             	lea    0x1(%eax),%edx
 58d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 590:	0f b6 91 60 13 00 00 	movzbl 0x1360(%ecx),%edx
 597:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 59b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 59e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5a1:	ba 00 00 00 00       	mov    $0x0,%edx
 5a6:	f7 f1                	div    %ecx
 5a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5ab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5af:	75 c7                	jne    578 <printint+0x3b>
  if(neg)
 5b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5b5:	74 2d                	je     5e4 <printint+0xa7>
    buf[i++] = '-';
 5b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ba:	8d 50 01             	lea    0x1(%eax),%edx
 5bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5c0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5c5:	eb 1d                	jmp    5e4 <printint+0xa7>
    putc(fd, buf[i]);
 5c7:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5cd:	01 d0                	add    %edx,%eax
 5cf:	0f b6 00             	movzbl (%eax),%eax
 5d2:	0f be c0             	movsbl %al,%eax
 5d5:	83 ec 08             	sub    $0x8,%esp
 5d8:	50                   	push   %eax
 5d9:	ff 75 08             	pushl  0x8(%ebp)
 5dc:	e8 35 ff ff ff       	call   516 <putc>
 5e1:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5e4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ec:	79 d9                	jns    5c7 <printint+0x8a>
}
 5ee:	90                   	nop
 5ef:	90                   	nop
 5f0:	c9                   	leave  
 5f1:	c3                   	ret    

000005f2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5f2:	f3 0f 1e fb          	endbr32 
 5f6:	55                   	push   %ebp
 5f7:	89 e5                	mov    %esp,%ebp
 5f9:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 603:	8d 45 0c             	lea    0xc(%ebp),%eax
 606:	83 c0 04             	add    $0x4,%eax
 609:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 60c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 613:	e9 59 01 00 00       	jmp    771 <printf+0x17f>
    c = fmt[i] & 0xff;
 618:	8b 55 0c             	mov    0xc(%ebp),%edx
 61b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61e:	01 d0                	add    %edx,%eax
 620:	0f b6 00             	movzbl (%eax),%eax
 623:	0f be c0             	movsbl %al,%eax
 626:	25 ff 00 00 00       	and    $0xff,%eax
 62b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 62e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 632:	75 2c                	jne    660 <printf+0x6e>
      if(c == '%'){
 634:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 638:	75 0c                	jne    646 <printf+0x54>
        state = '%';
 63a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 641:	e9 27 01 00 00       	jmp    76d <printf+0x17b>
      } else {
        putc(fd, c);
 646:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 649:	0f be c0             	movsbl %al,%eax
 64c:	83 ec 08             	sub    $0x8,%esp
 64f:	50                   	push   %eax
 650:	ff 75 08             	pushl  0x8(%ebp)
 653:	e8 be fe ff ff       	call   516 <putc>
 658:	83 c4 10             	add    $0x10,%esp
 65b:	e9 0d 01 00 00       	jmp    76d <printf+0x17b>
      }
    } else if(state == '%'){
 660:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 664:	0f 85 03 01 00 00    	jne    76d <printf+0x17b>
      if(c == 'd'){
 66a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 66e:	75 1e                	jne    68e <printf+0x9c>
        printint(fd, *ap, 10, 1);
 670:	8b 45 e8             	mov    -0x18(%ebp),%eax
 673:	8b 00                	mov    (%eax),%eax
 675:	6a 01                	push   $0x1
 677:	6a 0a                	push   $0xa
 679:	50                   	push   %eax
 67a:	ff 75 08             	pushl  0x8(%ebp)
 67d:	e8 bb fe ff ff       	call   53d <printint>
 682:	83 c4 10             	add    $0x10,%esp
        ap++;
 685:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 689:	e9 d8 00 00 00       	jmp    766 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 68e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 692:	74 06                	je     69a <printf+0xa8>
 694:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 698:	75 1e                	jne    6b8 <printf+0xc6>
        printint(fd, *ap, 16, 0);
 69a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 69d:	8b 00                	mov    (%eax),%eax
 69f:	6a 00                	push   $0x0
 6a1:	6a 10                	push   $0x10
 6a3:	50                   	push   %eax
 6a4:	ff 75 08             	pushl  0x8(%ebp)
 6a7:	e8 91 fe ff ff       	call   53d <printint>
 6ac:	83 c4 10             	add    $0x10,%esp
        ap++;
 6af:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6b3:	e9 ae 00 00 00       	jmp    766 <printf+0x174>
      } else if(c == 's'){
 6b8:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6bc:	75 43                	jne    701 <printf+0x10f>
        s = (char*)*ap;
 6be:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6c1:	8b 00                	mov    (%eax),%eax
 6c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6c6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6ce:	75 25                	jne    6f5 <printf+0x103>
          s = "(null)";
 6d0:	c7 45 f4 0f 0f 00 00 	movl   $0xf0f,-0xc(%ebp)
        while(*s != 0){
 6d7:	eb 1c                	jmp    6f5 <printf+0x103>
          putc(fd, *s);
 6d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6dc:	0f b6 00             	movzbl (%eax),%eax
 6df:	0f be c0             	movsbl %al,%eax
 6e2:	83 ec 08             	sub    $0x8,%esp
 6e5:	50                   	push   %eax
 6e6:	ff 75 08             	pushl  0x8(%ebp)
 6e9:	e8 28 fe ff ff       	call   516 <putc>
 6ee:	83 c4 10             	add    $0x10,%esp
          s++;
 6f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f8:	0f b6 00             	movzbl (%eax),%eax
 6fb:	84 c0                	test   %al,%al
 6fd:	75 da                	jne    6d9 <printf+0xe7>
 6ff:	eb 65                	jmp    766 <printf+0x174>
        }
      } else if(c == 'c'){
 701:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 705:	75 1d                	jne    724 <printf+0x132>
        putc(fd, *ap);
 707:	8b 45 e8             	mov    -0x18(%ebp),%eax
 70a:	8b 00                	mov    (%eax),%eax
 70c:	0f be c0             	movsbl %al,%eax
 70f:	83 ec 08             	sub    $0x8,%esp
 712:	50                   	push   %eax
 713:	ff 75 08             	pushl  0x8(%ebp)
 716:	e8 fb fd ff ff       	call   516 <putc>
 71b:	83 c4 10             	add    $0x10,%esp
        ap++;
 71e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 722:	eb 42                	jmp    766 <printf+0x174>
      } else if(c == '%'){
 724:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 728:	75 17                	jne    741 <printf+0x14f>
        putc(fd, c);
 72a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 72d:	0f be c0             	movsbl %al,%eax
 730:	83 ec 08             	sub    $0x8,%esp
 733:	50                   	push   %eax
 734:	ff 75 08             	pushl  0x8(%ebp)
 737:	e8 da fd ff ff       	call   516 <putc>
 73c:	83 c4 10             	add    $0x10,%esp
 73f:	eb 25                	jmp    766 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 741:	83 ec 08             	sub    $0x8,%esp
 744:	6a 25                	push   $0x25
 746:	ff 75 08             	pushl  0x8(%ebp)
 749:	e8 c8 fd ff ff       	call   516 <putc>
 74e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 751:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 754:	0f be c0             	movsbl %al,%eax
 757:	83 ec 08             	sub    $0x8,%esp
 75a:	50                   	push   %eax
 75b:	ff 75 08             	pushl  0x8(%ebp)
 75e:	e8 b3 fd ff ff       	call   516 <putc>
 763:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 766:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 76d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 771:	8b 55 0c             	mov    0xc(%ebp),%edx
 774:	8b 45 f0             	mov    -0x10(%ebp),%eax
 777:	01 d0                	add    %edx,%eax
 779:	0f b6 00             	movzbl (%eax),%eax
 77c:	84 c0                	test   %al,%al
 77e:	0f 85 94 fe ff ff    	jne    618 <printf+0x26>
    }
  }
}
 784:	90                   	nop
 785:	90                   	nop
 786:	c9                   	leave  
 787:	c3                   	ret    

00000788 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 788:	f3 0f 1e fb          	endbr32 
 78c:	55                   	push   %ebp
 78d:	89 e5                	mov    %esp,%ebp
 78f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 792:	8b 45 08             	mov    0x8(%ebp),%eax
 795:	83 e8 08             	sub    $0x8,%eax
 798:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79b:	a1 88 13 00 00       	mov    0x1388,%eax
 7a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7a3:	eb 24                	jmp    7c9 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a8:	8b 00                	mov    (%eax),%eax
 7aa:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 7ad:	72 12                	jb     7c1 <free+0x39>
 7af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7b5:	77 24                	ja     7db <free+0x53>
 7b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ba:	8b 00                	mov    (%eax),%eax
 7bc:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7bf:	72 1a                	jb     7db <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c4:	8b 00                	mov    (%eax),%eax
 7c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7cc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7cf:	76 d4                	jbe    7a5 <free+0x1d>
 7d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d4:	8b 00                	mov    (%eax),%eax
 7d6:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7d9:	73 ca                	jae    7a5 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7de:	8b 40 04             	mov    0x4(%eax),%eax
 7e1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7eb:	01 c2                	add    %eax,%edx
 7ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f0:	8b 00                	mov    (%eax),%eax
 7f2:	39 c2                	cmp    %eax,%edx
 7f4:	75 24                	jne    81a <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 7f6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f9:	8b 50 04             	mov    0x4(%eax),%edx
 7fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ff:	8b 00                	mov    (%eax),%eax
 801:	8b 40 04             	mov    0x4(%eax),%eax
 804:	01 c2                	add    %eax,%edx
 806:	8b 45 f8             	mov    -0x8(%ebp),%eax
 809:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 80c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80f:	8b 00                	mov    (%eax),%eax
 811:	8b 10                	mov    (%eax),%edx
 813:	8b 45 f8             	mov    -0x8(%ebp),%eax
 816:	89 10                	mov    %edx,(%eax)
 818:	eb 0a                	jmp    824 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 81a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81d:	8b 10                	mov    (%eax),%edx
 81f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 822:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 824:	8b 45 fc             	mov    -0x4(%ebp),%eax
 827:	8b 40 04             	mov    0x4(%eax),%eax
 82a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 831:	8b 45 fc             	mov    -0x4(%ebp),%eax
 834:	01 d0                	add    %edx,%eax
 836:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 839:	75 20                	jne    85b <free+0xd3>
    p->s.size += bp->s.size;
 83b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83e:	8b 50 04             	mov    0x4(%eax),%edx
 841:	8b 45 f8             	mov    -0x8(%ebp),%eax
 844:	8b 40 04             	mov    0x4(%eax),%eax
 847:	01 c2                	add    %eax,%edx
 849:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 84f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 852:	8b 10                	mov    (%eax),%edx
 854:	8b 45 fc             	mov    -0x4(%ebp),%eax
 857:	89 10                	mov    %edx,(%eax)
 859:	eb 08                	jmp    863 <free+0xdb>
  } else
    p->s.ptr = bp;
 85b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 861:	89 10                	mov    %edx,(%eax)
  freep = p;
 863:	8b 45 fc             	mov    -0x4(%ebp),%eax
 866:	a3 88 13 00 00       	mov    %eax,0x1388
}
 86b:	90                   	nop
 86c:	c9                   	leave  
 86d:	c3                   	ret    

0000086e <morecore>:

static Header*
morecore(uint nu)
{
 86e:	f3 0f 1e fb          	endbr32 
 872:	55                   	push   %ebp
 873:	89 e5                	mov    %esp,%ebp
 875:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 878:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 87f:	77 07                	ja     888 <morecore+0x1a>
    nu = 4096;
 881:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 888:	8b 45 08             	mov    0x8(%ebp),%eax
 88b:	c1 e0 03             	shl    $0x3,%eax
 88e:	83 ec 0c             	sub    $0xc,%esp
 891:	50                   	push   %eax
 892:	e8 17 fc ff ff       	call   4ae <sbrk>
 897:	83 c4 10             	add    $0x10,%esp
 89a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 89d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8a1:	75 07                	jne    8aa <morecore+0x3c>
    return 0;
 8a3:	b8 00 00 00 00       	mov    $0x0,%eax
 8a8:	eb 26                	jmp    8d0 <morecore+0x62>
  hp = (Header*)p;
 8aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b3:	8b 55 08             	mov    0x8(%ebp),%edx
 8b6:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8bc:	83 c0 08             	add    $0x8,%eax
 8bf:	83 ec 0c             	sub    $0xc,%esp
 8c2:	50                   	push   %eax
 8c3:	e8 c0 fe ff ff       	call   788 <free>
 8c8:	83 c4 10             	add    $0x10,%esp
  return freep;
 8cb:	a1 88 13 00 00       	mov    0x1388,%eax
}
 8d0:	c9                   	leave  
 8d1:	c3                   	ret    

000008d2 <malloc>:

void*
malloc(uint nbytes)
{
 8d2:	f3 0f 1e fb          	endbr32 
 8d6:	55                   	push   %ebp
 8d7:	89 e5                	mov    %esp,%ebp
 8d9:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8dc:	8b 45 08             	mov    0x8(%ebp),%eax
 8df:	83 c0 07             	add    $0x7,%eax
 8e2:	c1 e8 03             	shr    $0x3,%eax
 8e5:	83 c0 01             	add    $0x1,%eax
 8e8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8eb:	a1 88 13 00 00       	mov    0x1388,%eax
 8f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8f7:	75 23                	jne    91c <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 8f9:	c7 45 f0 80 13 00 00 	movl   $0x1380,-0x10(%ebp)
 900:	8b 45 f0             	mov    -0x10(%ebp),%eax
 903:	a3 88 13 00 00       	mov    %eax,0x1388
 908:	a1 88 13 00 00       	mov    0x1388,%eax
 90d:	a3 80 13 00 00       	mov    %eax,0x1380
    base.s.size = 0;
 912:	c7 05 84 13 00 00 00 	movl   $0x0,0x1384
 919:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 91c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 91f:	8b 00                	mov    (%eax),%eax
 921:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 924:	8b 45 f4             	mov    -0xc(%ebp),%eax
 927:	8b 40 04             	mov    0x4(%eax),%eax
 92a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 92d:	77 4d                	ja     97c <malloc+0xaa>
      if(p->s.size == nunits)
 92f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 932:	8b 40 04             	mov    0x4(%eax),%eax
 935:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 938:	75 0c                	jne    946 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 93a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93d:	8b 10                	mov    (%eax),%edx
 93f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 942:	89 10                	mov    %edx,(%eax)
 944:	eb 26                	jmp    96c <malloc+0x9a>
      else {
        p->s.size -= nunits;
 946:	8b 45 f4             	mov    -0xc(%ebp),%eax
 949:	8b 40 04             	mov    0x4(%eax),%eax
 94c:	2b 45 ec             	sub    -0x14(%ebp),%eax
 94f:	89 c2                	mov    %eax,%edx
 951:	8b 45 f4             	mov    -0xc(%ebp),%eax
 954:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 957:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95a:	8b 40 04             	mov    0x4(%eax),%eax
 95d:	c1 e0 03             	shl    $0x3,%eax
 960:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 963:	8b 45 f4             	mov    -0xc(%ebp),%eax
 966:	8b 55 ec             	mov    -0x14(%ebp),%edx
 969:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 96c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 96f:	a3 88 13 00 00       	mov    %eax,0x1388
      return (void*)(p + 1);
 974:	8b 45 f4             	mov    -0xc(%ebp),%eax
 977:	83 c0 08             	add    $0x8,%eax
 97a:	eb 3b                	jmp    9b7 <malloc+0xe5>
    }
    if(p == freep)
 97c:	a1 88 13 00 00       	mov    0x1388,%eax
 981:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 984:	75 1e                	jne    9a4 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 986:	83 ec 0c             	sub    $0xc,%esp
 989:	ff 75 ec             	pushl  -0x14(%ebp)
 98c:	e8 dd fe ff ff       	call   86e <morecore>
 991:	83 c4 10             	add    $0x10,%esp
 994:	89 45 f4             	mov    %eax,-0xc(%ebp)
 997:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 99b:	75 07                	jne    9a4 <malloc+0xd2>
        return 0;
 99d:	b8 00 00 00 00       	mov    $0x0,%eax
 9a2:	eb 13                	jmp    9b7 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ad:	8b 00                	mov    (%eax),%eax
 9af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9b2:	e9 6d ff ff ff       	jmp    924 <malloc+0x52>
  }
}
 9b7:	c9                   	leave  
 9b8:	c3                   	ret    

000009b9 <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
 9b9:	f3 0f 1e fb          	endbr32 
 9bd:	55                   	push   %ebp
 9be:	89 e5                	mov    %esp,%ebp
 9c0:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 9c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 9ca:	a1 e0 13 00 00       	mov    0x13e0,%eax
 9cf:	83 ec 04             	sub    $0x4,%esp
 9d2:	50                   	push   %eax
 9d3:	6a 20                	push   $0x20
 9d5:	68 c0 13 00 00       	push   $0x13c0
 9da:	e8 11 f8 ff ff       	call   1f0 <fgets>
 9df:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 9e2:	83 ec 0c             	sub    $0xc,%esp
 9e5:	68 c0 13 00 00       	push   $0x13c0
 9ea:	e8 0e f7 ff ff       	call   fd <strlen>
 9ef:	83 c4 10             	add    $0x10,%esp
 9f2:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 9f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9f8:	83 e8 01             	sub    $0x1,%eax
 9fb:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 a02:	3c 0a                	cmp    $0xa,%al
 a04:	74 11                	je     a17 <get_id+0x5e>
 a06:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a09:	83 e8 01             	sub    $0x1,%eax
 a0c:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 a13:	3c 0d                	cmp    $0xd,%al
 a15:	75 0d                	jne    a24 <get_id+0x6b>
        current_line[len - 1] = 0;
 a17:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a1a:	83 e8 01             	sub    $0x1,%eax
 a1d:	c6 80 c0 13 00 00 00 	movb   $0x0,0x13c0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 a24:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 a2b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 a32:	eb 6c                	jmp    aa0 <get_id+0xe7>
        if(current_line[i] == ' '){
 a34:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a37:	05 c0 13 00 00       	add    $0x13c0,%eax
 a3c:	0f b6 00             	movzbl (%eax),%eax
 a3f:	3c 20                	cmp    $0x20,%al
 a41:	75 30                	jne    a73 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 a43:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a47:	75 16                	jne    a5f <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 a49:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a4f:	8d 50 01             	lea    0x1(%eax),%edx
 a52:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a55:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 a5b:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 a5f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a62:	05 c0 13 00 00       	add    $0x13c0,%eax
 a67:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 a6a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a71:	eb 29                	jmp    a9c <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 a73:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a77:	75 23                	jne    a9c <get_id+0xe3>
 a79:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 a7d:	7f 1d                	jg     a9c <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 a7f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 a86:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a89:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a8c:	8d 50 01             	lea    0x1(%eax),%edx
 a8f:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a92:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 a98:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 a9c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 aa0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 aa3:	05 c0 13 00 00       	add    $0x13c0,%eax
 aa8:	0f b6 00             	movzbl (%eax),%eax
 aab:	84 c0                	test   %al,%al
 aad:	75 85                	jne    a34 <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 aaf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 ab3:	75 07                	jne    abc <get_id+0x103>
        return -1;
 ab5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 aba:	eb 35                	jmp    af1 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
 abc:	8b 45 dc             	mov    -0x24(%ebp),%eax
 abf:	a3 a0 13 00 00       	mov    %eax,0x13a0
    current_id.uid_user = atoi(tokens[1]);
 ac4:	8b 45 e0             	mov    -0x20(%ebp),%eax
 ac7:	83 ec 0c             	sub    $0xc,%esp
 aca:	50                   	push   %eax
 acb:	e8 e5 f7 ff ff       	call   2b5 <atoi>
 ad0:	83 c4 10             	add    $0x10,%esp
 ad3:	a3 a4 13 00 00       	mov    %eax,0x13a4
    current_id.gid_user = atoi(tokens[2]);
 ad8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 adb:	83 ec 0c             	sub    $0xc,%esp
 ade:	50                   	push   %eax
 adf:	e8 d1 f7 ff ff       	call   2b5 <atoi>
 ae4:	83 c4 10             	add    $0x10,%esp
 ae7:	a3 a8 13 00 00       	mov    %eax,0x13a8

    return 0;
 aec:	b8 00 00 00 00       	mov    $0x0,%eax
}
 af1:	c9                   	leave  
 af2:	c3                   	ret    

00000af3 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
 af3:	f3 0f 1e fb          	endbr32 
 af7:	55                   	push   %ebp
 af8:	89 e5                	mov    %esp,%ebp
 afa:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 afd:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b02:	85 c0                	test   %eax,%eax
 b04:	75 31                	jne    b37 <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
 b06:	83 ec 08             	sub    $0x8,%esp
 b09:	6a 00                	push   $0x0
 b0b:	68 16 0f 00 00       	push   $0xf16
 b10:	e8 51 f9 ff ff       	call   466 <open>
 b15:	83 c4 10             	add    $0x10,%esp
 b18:	a3 e0 13 00 00       	mov    %eax,0x13e0

        if(dir < 0){        // kalau gagal membuka file
 b1d:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b22:	85 c0                	test   %eax,%eax
 b24:	79 11                	jns    b37 <getid+0x44>
            dir = 0;
 b26:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 b2d:	00 00 00 
            return 0;
 b30:	b8 00 00 00 00       	mov    $0x0,%eax
 b35:	eb 16                	jmp    b4d <getid+0x5a>
        }
    }

    if(get_id() == -1) 
 b37:	e8 7d fe ff ff       	call   9b9 <get_id>
 b3c:	83 f8 ff             	cmp    $0xffffffff,%eax
 b3f:	75 07                	jne    b48 <getid+0x55>
        return 0;
 b41:	b8 00 00 00 00       	mov    $0x0,%eax
 b46:	eb 05                	jmp    b4d <getid+0x5a>
    
    return &current_id;
 b48:	b8 a0 13 00 00       	mov    $0x13a0,%eax
}
 b4d:	c9                   	leave  
 b4e:	c3                   	ret    

00000b4f <setid>:

// open file_ids
void setid(void){
 b4f:	f3 0f 1e fb          	endbr32 
 b53:	55                   	push   %ebp
 b54:	89 e5                	mov    %esp,%ebp
 b56:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b59:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b5e:	85 c0                	test   %eax,%eax
 b60:	74 1b                	je     b7d <setid+0x2e>
        close(dir);
 b62:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b67:	83 ec 0c             	sub    $0xc,%esp
 b6a:	50                   	push   %eax
 b6b:	e8 de f8 ff ff       	call   44e <close>
 b70:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 b73:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 b7a:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
 b7d:	83 ec 08             	sub    $0x8,%esp
 b80:	6a 00                	push   $0x0
 b82:	68 16 0f 00 00       	push   $0xf16
 b87:	e8 da f8 ff ff       	call   466 <open>
 b8c:	83 c4 10             	add    $0x10,%esp
 b8f:	a3 e0 13 00 00       	mov    %eax,0x13e0

    if (dir < 0)
 b94:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b99:	85 c0                	test   %eax,%eax
 b9b:	79 0a                	jns    ba7 <setid+0x58>
        dir = 0;
 b9d:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 ba4:	00 00 00 
}
 ba7:	90                   	nop
 ba8:	c9                   	leave  
 ba9:	c3                   	ret    

00000baa <endid>:

// tutup file_ids
void endid (void){
 baa:	f3 0f 1e fb          	endbr32 
 bae:	55                   	push   %ebp
 baf:	89 e5                	mov    %esp,%ebp
 bb1:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 bb4:	a1 e0 13 00 00       	mov    0x13e0,%eax
 bb9:	85 c0                	test   %eax,%eax
 bbb:	74 1b                	je     bd8 <endid+0x2e>
        close(dir);
 bbd:	a1 e0 13 00 00       	mov    0x13e0,%eax
 bc2:	83 ec 0c             	sub    $0xc,%esp
 bc5:	50                   	push   %eax
 bc6:	e8 83 f8 ff ff       	call   44e <close>
 bcb:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 bce:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 bd5:	00 00 00 
    }
}
 bd8:	90                   	nop
 bd9:	c9                   	leave  
 bda:	c3                   	ret    

00000bdb <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
 bdb:	f3 0f 1e fb          	endbr32 
 bdf:	55                   	push   %ebp
 be0:	89 e5                	mov    %esp,%ebp
 be2:	83 ec 08             	sub    $0x8,%esp
    setid();
 be5:	e8 65 ff ff ff       	call   b4f <setid>

    while (getid()){
 bea:	eb 24                	jmp    c10 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
 bec:	a1 a0 13 00 00       	mov    0x13a0,%eax
 bf1:	83 ec 08             	sub    $0x8,%esp
 bf4:	50                   	push   %eax
 bf5:	ff 75 08             	pushl  0x8(%ebp)
 bf8:	e8 bd f4 ff ff       	call   ba <strcmp>
 bfd:	83 c4 10             	add    $0x10,%esp
 c00:	85 c0                	test   %eax,%eax
 c02:	75 0c                	jne    c10 <cek_nama+0x35>
            endid();
 c04:	e8 a1 ff ff ff       	call   baa <endid>
            return &current_id;
 c09:	b8 a0 13 00 00       	mov    $0x13a0,%eax
 c0e:	eb 13                	jmp    c23 <cek_nama+0x48>
    while (getid()){
 c10:	e8 de fe ff ff       	call   af3 <getid>
 c15:	85 c0                	test   %eax,%eax
 c17:	75 d3                	jne    bec <cek_nama+0x11>
        }
    }
    endid();
 c19:	e8 8c ff ff ff       	call   baa <endid>
    return 0;
 c1e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c23:	c9                   	leave  
 c24:	c3                   	ret    

00000c25 <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
 c25:	f3 0f 1e fb          	endbr32 
 c29:	55                   	push   %ebp
 c2a:	89 e5                	mov    %esp,%ebp
 c2c:	83 ec 08             	sub    $0x8,%esp
    setid();
 c2f:	e8 1b ff ff ff       	call   b4f <setid>

    while (getid()){
 c34:	eb 16                	jmp    c4c <cek_uid+0x27>
        if(current_id.uid_user == uid){
 c36:	a1 a4 13 00 00       	mov    0x13a4,%eax
 c3b:	39 45 08             	cmp    %eax,0x8(%ebp)
 c3e:	75 0c                	jne    c4c <cek_uid+0x27>
            endid();
 c40:	e8 65 ff ff ff       	call   baa <endid>
            return &current_id;
 c45:	b8 a0 13 00 00       	mov    $0x13a0,%eax
 c4a:	eb 13                	jmp    c5f <cek_uid+0x3a>
    while (getid()){
 c4c:	e8 a2 fe ff ff       	call   af3 <getid>
 c51:	85 c0                	test   %eax,%eax
 c53:	75 e1                	jne    c36 <cek_uid+0x11>
        }
    }
    endid();
 c55:	e8 50 ff ff ff       	call   baa <endid>
    return 0;
 c5a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c5f:	c9                   	leave  
 c60:	c3                   	ret    

00000c61 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
 c61:	f3 0f 1e fb          	endbr32 
 c65:	55                   	push   %ebp
 c66:	89 e5                	mov    %esp,%ebp
 c68:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 c6b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 c72:	a1 e0 13 00 00       	mov    0x13e0,%eax
 c77:	83 ec 04             	sub    $0x4,%esp
 c7a:	50                   	push   %eax
 c7b:	6a 20                	push   $0x20
 c7d:	68 c0 13 00 00       	push   $0x13c0
 c82:	e8 69 f5 ff ff       	call   1f0 <fgets>
 c87:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 c8a:	83 ec 0c             	sub    $0xc,%esp
 c8d:	68 c0 13 00 00       	push   $0x13c0
 c92:	e8 66 f4 ff ff       	call   fd <strlen>
 c97:	83 c4 10             	add    $0x10,%esp
 c9a:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 c9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ca0:	83 e8 01             	sub    $0x1,%eax
 ca3:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 caa:	3c 0a                	cmp    $0xa,%al
 cac:	74 11                	je     cbf <get_group+0x5e>
 cae:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cb1:	83 e8 01             	sub    $0x1,%eax
 cb4:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 cbb:	3c 0d                	cmp    $0xd,%al
 cbd:	75 0d                	jne    ccc <get_group+0x6b>
        current_line[len - 1] = 0;
 cbf:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cc2:	83 e8 01             	sub    $0x1,%eax
 cc5:	c6 80 c0 13 00 00 00 	movb   $0x0,0x13c0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 ccc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 cd3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 cda:	eb 6c                	jmp    d48 <get_group+0xe7>
        if(current_line[i] == ' '){
 cdc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 cdf:	05 c0 13 00 00       	add    $0x13c0,%eax
 ce4:	0f b6 00             	movzbl (%eax),%eax
 ce7:	3c 20                	cmp    $0x20,%al
 ce9:	75 30                	jne    d1b <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 ceb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 cef:	75 16                	jne    d07 <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 cf1:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 cf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cf7:	8d 50 01             	lea    0x1(%eax),%edx
 cfa:	89 55 f0             	mov    %edx,-0x10(%ebp)
 cfd:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 d03:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 d07:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d0a:	05 c0 13 00 00       	add    $0x13c0,%eax
 d0f:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 d12:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 d19:	eb 29                	jmp    d44 <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 d1b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d1f:	75 23                	jne    d44 <get_group+0xe3>
 d21:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 d25:	7f 1d                	jg     d44 <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 d27:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 d2e:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d31:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d34:	8d 50 01             	lea    0x1(%eax),%edx
 d37:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d3a:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 d40:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 d44:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 d48:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d4b:	05 c0 13 00 00       	add    $0x13c0,%eax
 d50:	0f b6 00             	movzbl (%eax),%eax
 d53:	84 c0                	test   %al,%al
 d55:	75 85                	jne    cdc <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 d57:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 d5b:	75 07                	jne    d64 <get_group+0x103>
        return -1;
 d5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d62:	eb 21                	jmp    d85 <get_group+0x124>
    
    current_group.nama_group = tokens[0];
 d64:	8b 45 dc             	mov    -0x24(%ebp),%eax
 d67:	a3 ac 13 00 00       	mov    %eax,0x13ac
    current_group.gid = atoi(tokens[1]);
 d6c:	8b 45 e0             	mov    -0x20(%ebp),%eax
 d6f:	83 ec 0c             	sub    $0xc,%esp
 d72:	50                   	push   %eax
 d73:	e8 3d f5 ff ff       	call   2b5 <atoi>
 d78:	83 c4 10             	add    $0x10,%esp
 d7b:	a3 b0 13 00 00       	mov    %eax,0x13b0

    return 0;
 d80:	b8 00 00 00 00       	mov    $0x0,%eax
}
 d85:	c9                   	leave  
 d86:	c3                   	ret    

00000d87 <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
 d87:	f3 0f 1e fb          	endbr32 
 d8b:	55                   	push   %ebp
 d8c:	89 e5                	mov    %esp,%ebp
 d8e:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 d91:	a1 e0 13 00 00       	mov    0x13e0,%eax
 d96:	85 c0                	test   %eax,%eax
 d98:	75 31                	jne    dcb <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
 d9a:	83 ec 08             	sub    $0x8,%esp
 d9d:	6a 00                	push   $0x0
 d9f:	68 1e 0f 00 00       	push   $0xf1e
 da4:	e8 bd f6 ff ff       	call   466 <open>
 da9:	83 c4 10             	add    $0x10,%esp
 dac:	a3 e0 13 00 00       	mov    %eax,0x13e0

        if(dir < 0){        // kalau gagal membuka file
 db1:	a1 e0 13 00 00       	mov    0x13e0,%eax
 db6:	85 c0                	test   %eax,%eax
 db8:	79 11                	jns    dcb <getgroup+0x44>
            dir = 0;
 dba:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 dc1:	00 00 00 
            return 0;
 dc4:	b8 00 00 00 00       	mov    $0x0,%eax
 dc9:	eb 16                	jmp    de1 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
 dcb:	e8 91 fe ff ff       	call   c61 <get_group>
 dd0:	83 f8 ff             	cmp    $0xffffffff,%eax
 dd3:	75 07                	jne    ddc <getgroup+0x55>
        return 0;
 dd5:	b8 00 00 00 00       	mov    $0x0,%eax
 dda:	eb 05                	jmp    de1 <getgroup+0x5a>
    
    return &current_group;
 ddc:	b8 ac 13 00 00       	mov    $0x13ac,%eax
}
 de1:	c9                   	leave  
 de2:	c3                   	ret    

00000de3 <setgroup>:

// open file_ids
void setgroup(void){
 de3:	f3 0f 1e fb          	endbr32 
 de7:	55                   	push   %ebp
 de8:	89 e5                	mov    %esp,%ebp
 dea:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 ded:	a1 e0 13 00 00       	mov    0x13e0,%eax
 df2:	85 c0                	test   %eax,%eax
 df4:	74 1b                	je     e11 <setgroup+0x2e>
        close(dir);
 df6:	a1 e0 13 00 00       	mov    0x13e0,%eax
 dfb:	83 ec 0c             	sub    $0xc,%esp
 dfe:	50                   	push   %eax
 dff:	e8 4a f6 ff ff       	call   44e <close>
 e04:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e07:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 e0e:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
 e11:	83 ec 08             	sub    $0x8,%esp
 e14:	6a 00                	push   $0x0
 e16:	68 1e 0f 00 00       	push   $0xf1e
 e1b:	e8 46 f6 ff ff       	call   466 <open>
 e20:	83 c4 10             	add    $0x10,%esp
 e23:	a3 e0 13 00 00       	mov    %eax,0x13e0

    if (dir < 0)
 e28:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e2d:	85 c0                	test   %eax,%eax
 e2f:	79 0a                	jns    e3b <setgroup+0x58>
        dir = 0;
 e31:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 e38:	00 00 00 
}
 e3b:	90                   	nop
 e3c:	c9                   	leave  
 e3d:	c3                   	ret    

00000e3e <endgroup>:

// tutup file_ids
void endgroup (void){
 e3e:	f3 0f 1e fb          	endbr32 
 e42:	55                   	push   %ebp
 e43:	89 e5                	mov    %esp,%ebp
 e45:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e48:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e4d:	85 c0                	test   %eax,%eax
 e4f:	74 1b                	je     e6c <endgroup+0x2e>
        close(dir);
 e51:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e56:	83 ec 0c             	sub    $0xc,%esp
 e59:	50                   	push   %eax
 e5a:	e8 ef f5 ff ff       	call   44e <close>
 e5f:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e62:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 e69:	00 00 00 
    }
}
 e6c:	90                   	nop
 e6d:	c9                   	leave  
 e6e:	c3                   	ret    

00000e6f <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
 e6f:	f3 0f 1e fb          	endbr32 
 e73:	55                   	push   %ebp
 e74:	89 e5                	mov    %esp,%ebp
 e76:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 e79:	e8 65 ff ff ff       	call   de3 <setgroup>

    while (getgroup()){
 e7e:	eb 3c                	jmp    ebc <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
 e80:	a1 ac 13 00 00       	mov    0x13ac,%eax
 e85:	83 ec 08             	sub    $0x8,%esp
 e88:	50                   	push   %eax
 e89:	ff 75 08             	pushl  0x8(%ebp)
 e8c:	e8 29 f2 ff ff       	call   ba <strcmp>
 e91:	83 c4 10             	add    $0x10,%esp
 e94:	85 c0                	test   %eax,%eax
 e96:	75 24                	jne    ebc <cek_nama_group+0x4d>
            endgroup();
 e98:	e8 a1 ff ff ff       	call   e3e <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
 e9d:	a1 ac 13 00 00       	mov    0x13ac,%eax
 ea2:	83 ec 04             	sub    $0x4,%esp
 ea5:	50                   	push   %eax
 ea6:	68 29 0f 00 00       	push   $0xf29
 eab:	6a 01                	push   $0x1
 ead:	e8 40 f7 ff ff       	call   5f2 <printf>
 eb2:	83 c4 10             	add    $0x10,%esp
            return &current_group;
 eb5:	b8 ac 13 00 00       	mov    $0x13ac,%eax
 eba:	eb 13                	jmp    ecf <cek_nama_group+0x60>
    while (getgroup()){
 ebc:	e8 c6 fe ff ff       	call   d87 <getgroup>
 ec1:	85 c0                	test   %eax,%eax
 ec3:	75 bb                	jne    e80 <cek_nama_group+0x11>
        }
    }
    endgroup();
 ec5:	e8 74 ff ff ff       	call   e3e <endgroup>
    return 0;
 eca:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ecf:	c9                   	leave  
 ed0:	c3                   	ret    

00000ed1 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
 ed1:	f3 0f 1e fb          	endbr32 
 ed5:	55                   	push   %ebp
 ed6:	89 e5                	mov    %esp,%ebp
 ed8:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 edb:	e8 03 ff ff ff       	call   de3 <setgroup>

    while (getgroup()){
 ee0:	eb 16                	jmp    ef8 <cek_gid+0x27>
        if(current_group.gid == gid){
 ee2:	a1 b0 13 00 00       	mov    0x13b0,%eax
 ee7:	39 45 08             	cmp    %eax,0x8(%ebp)
 eea:	75 0c                	jne    ef8 <cek_gid+0x27>
            endgroup();
 eec:	e8 4d ff ff ff       	call   e3e <endgroup>
            return &current_group;
 ef1:	b8 ac 13 00 00       	mov    $0x13ac,%eax
 ef6:	eb 13                	jmp    f0b <cek_gid+0x3a>
    while (getgroup()){
 ef8:	e8 8a fe ff ff       	call   d87 <getgroup>
 efd:	85 c0                	test   %eax,%eax
 eff:	75 e1                	jne    ee2 <cek_gid+0x11>
        }
    }
    endgroup();
 f01:	e8 38 ff ff ff       	call   e3e <endgroup>
    return 0;
 f06:	b8 00 00 00 00       	mov    $0x0,%eax
}
 f0b:	c9                   	leave  
 f0c:	c3                   	ret    
