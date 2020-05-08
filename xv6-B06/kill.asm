
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  13:	83 ec 10             	sub    $0x10,%esp
  16:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
  18:	83 3b 01             	cmpl   $0x1,(%ebx)
  1b:	7f 17                	jg     34 <main+0x34>
    printf(2, "usage: kill pid...\n");
  1d:	83 ec 08             	sub    $0x8,%esp
  20:	68 23 0f 00 00       	push   $0xf23
  25:	6a 02                	push   $0x2
  27:	e8 dc 05 00 00       	call   608 <printf>
  2c:	83 c4 10             	add    $0x10,%esp
    exit();
  2f:	e8 08 04 00 00       	call   43c <exit>
  }
  for(i=1; i<argc; i++)
  34:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  3b:	eb 2d                	jmp    6a <main+0x6a>
    kill(atoi(argv[i]));
  3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  40:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  47:	8b 43 04             	mov    0x4(%ebx),%eax
  4a:	01 d0                	add    %edx,%eax
  4c:	8b 00                	mov    (%eax),%eax
  4e:	83 ec 0c             	sub    $0xc,%esp
  51:	50                   	push   %eax
  52:	e8 74 02 00 00       	call   2cb <atoi>
  57:	83 c4 10             	add    $0x10,%esp
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	50                   	push   %eax
  5e:	e8 09 04 00 00       	call   46c <kill>
  63:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
  66:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  6d:	3b 03                	cmp    (%ebx),%eax
  6f:	7c cc                	jl     3d <main+0x3d>
  exit();
  71:	e8 c6 03 00 00       	call   43c <exit>

00000076 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  76:	55                   	push   %ebp
  77:	89 e5                	mov    %esp,%ebp
  79:	57                   	push   %edi
  7a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  7b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7e:	8b 55 10             	mov    0x10(%ebp),%edx
  81:	8b 45 0c             	mov    0xc(%ebp),%eax
  84:	89 cb                	mov    %ecx,%ebx
  86:	89 df                	mov    %ebx,%edi
  88:	89 d1                	mov    %edx,%ecx
  8a:	fc                   	cld    
  8b:	f3 aa                	rep stos %al,%es:(%edi)
  8d:	89 ca                	mov    %ecx,%edx
  8f:	89 fb                	mov    %edi,%ebx
  91:	89 5d 08             	mov    %ebx,0x8(%ebp)
  94:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  97:	90                   	nop
  98:	5b                   	pop    %ebx
  99:	5f                   	pop    %edi
  9a:	5d                   	pop    %ebp
  9b:	c3                   	ret    

0000009c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  9c:	f3 0f 1e fb          	endbr32 
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a6:	8b 45 08             	mov    0x8(%ebp),%eax
  a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  ac:	90                   	nop
  ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  b0:	8d 42 01             	lea    0x1(%edx),%eax
  b3:	89 45 0c             	mov    %eax,0xc(%ebp)
  b6:	8b 45 08             	mov    0x8(%ebp),%eax
  b9:	8d 48 01             	lea    0x1(%eax),%ecx
  bc:	89 4d 08             	mov    %ecx,0x8(%ebp)
  bf:	0f b6 12             	movzbl (%edx),%edx
  c2:	88 10                	mov    %dl,(%eax)
  c4:	0f b6 00             	movzbl (%eax),%eax
  c7:	84 c0                	test   %al,%al
  c9:	75 e2                	jne    ad <strcpy+0x11>
    ;
  return os;
  cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ce:	c9                   	leave  
  cf:	c3                   	ret    

000000d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d0:	f3 0f 1e fb          	endbr32 
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  d7:	eb 08                	jmp    e1 <strcmp+0x11>
    p++, q++;
  d9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  dd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  e1:	8b 45 08             	mov    0x8(%ebp),%eax
  e4:	0f b6 00             	movzbl (%eax),%eax
  e7:	84 c0                	test   %al,%al
  e9:	74 10                	je     fb <strcmp+0x2b>
  eb:	8b 45 08             	mov    0x8(%ebp),%eax
  ee:	0f b6 10             	movzbl (%eax),%edx
  f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	38 c2                	cmp    %al,%dl
  f9:	74 de                	je     d9 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
  fb:	8b 45 08             	mov    0x8(%ebp),%eax
  fe:	0f b6 00             	movzbl (%eax),%eax
 101:	0f b6 d0             	movzbl %al,%edx
 104:	8b 45 0c             	mov    0xc(%ebp),%eax
 107:	0f b6 00             	movzbl (%eax),%eax
 10a:	0f b6 c0             	movzbl %al,%eax
 10d:	29 c2                	sub    %eax,%edx
 10f:	89 d0                	mov    %edx,%eax
}
 111:	5d                   	pop    %ebp
 112:	c3                   	ret    

00000113 <strlen>:

uint
strlen(char *s)
{
 113:	f3 0f 1e fb          	endbr32 
 117:	55                   	push   %ebp
 118:	89 e5                	mov    %esp,%ebp
 11a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 11d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 124:	eb 04                	jmp    12a <strlen+0x17>
 126:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 12a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 12d:	8b 45 08             	mov    0x8(%ebp),%eax
 130:	01 d0                	add    %edx,%eax
 132:	0f b6 00             	movzbl (%eax),%eax
 135:	84 c0                	test   %al,%al
 137:	75 ed                	jne    126 <strlen+0x13>
    ;
  return n;
 139:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 13c:	c9                   	leave  
 13d:	c3                   	ret    

0000013e <memset>:

void*
memset(void *dst, int c, uint n)
{
 13e:	f3 0f 1e fb          	endbr32 
 142:	55                   	push   %ebp
 143:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 145:	8b 45 10             	mov    0x10(%ebp),%eax
 148:	50                   	push   %eax
 149:	ff 75 0c             	pushl  0xc(%ebp)
 14c:	ff 75 08             	pushl  0x8(%ebp)
 14f:	e8 22 ff ff ff       	call   76 <stosb>
 154:	83 c4 0c             	add    $0xc,%esp
  return dst;
 157:	8b 45 08             	mov    0x8(%ebp),%eax
}
 15a:	c9                   	leave  
 15b:	c3                   	ret    

0000015c <strchr>:

char*
strchr(const char *s, char c)
{
 15c:	f3 0f 1e fb          	endbr32 
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 04             	sub    $0x4,%esp
 166:	8b 45 0c             	mov    0xc(%ebp),%eax
 169:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 16c:	eb 14                	jmp    182 <strchr+0x26>
    if(*s == c)
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	0f b6 00             	movzbl (%eax),%eax
 174:	38 45 fc             	cmp    %al,-0x4(%ebp)
 177:	75 05                	jne    17e <strchr+0x22>
      return (char*)s;
 179:	8b 45 08             	mov    0x8(%ebp),%eax
 17c:	eb 13                	jmp    191 <strchr+0x35>
  for(; *s; s++)
 17e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 182:	8b 45 08             	mov    0x8(%ebp),%eax
 185:	0f b6 00             	movzbl (%eax),%eax
 188:	84 c0                	test   %al,%al
 18a:	75 e2                	jne    16e <strchr+0x12>
  return 0;
 18c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 191:	c9                   	leave  
 192:	c3                   	ret    

00000193 <gets>:

char*
gets(char *buf, int max)
{
 193:	f3 0f 1e fb          	endbr32 
 197:	55                   	push   %ebp
 198:	89 e5                	mov    %esp,%ebp
 19a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a4:	eb 42                	jmp    1e8 <gets+0x55>
    cc = read(0, &c, 1);
 1a6:	83 ec 04             	sub    $0x4,%esp
 1a9:	6a 01                	push   $0x1
 1ab:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1ae:	50                   	push   %eax
 1af:	6a 00                	push   $0x0
 1b1:	e8 9e 02 00 00       	call   454 <read>
 1b6:	83 c4 10             	add    $0x10,%esp
 1b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c0:	7e 33                	jle    1f5 <gets+0x62>
      break;
    buf[i++] = c;
 1c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c5:	8d 50 01             	lea    0x1(%eax),%edx
 1c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1cb:	89 c2                	mov    %eax,%edx
 1cd:	8b 45 08             	mov    0x8(%ebp),%eax
 1d0:	01 c2                	add    %eax,%edx
 1d2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1d8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1dc:	3c 0a                	cmp    $0xa,%al
 1de:	74 16                	je     1f6 <gets+0x63>
 1e0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e4:	3c 0d                	cmp    $0xd,%al
 1e6:	74 0e                	je     1f6 <gets+0x63>
  for(i=0; i+1 < max; ){
 1e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1eb:	83 c0 01             	add    $0x1,%eax
 1ee:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1f1:	7f b3                	jg     1a6 <gets+0x13>
 1f3:	eb 01                	jmp    1f6 <gets+0x63>
      break;
 1f5:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1f6:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	01 d0                	add    %edx,%eax
 1fe:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 201:	8b 45 08             	mov    0x8(%ebp),%eax
}
 204:	c9                   	leave  
 205:	c3                   	ret    

00000206 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
 206:	f3 0f 1e fb          	endbr32 
 20a:	55                   	push   %ebp
 20b:	89 e5                	mov    %esp,%ebp
 20d:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
 210:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 217:	eb 43                	jmp    25c <fgets+0x56>
    int cc = read(fd, &c, 1);
 219:	83 ec 04             	sub    $0x4,%esp
 21c:	6a 01                	push   $0x1
 21e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 221:	50                   	push   %eax
 222:	ff 75 10             	pushl  0x10(%ebp)
 225:	e8 2a 02 00 00       	call   454 <read>
 22a:	83 c4 10             	add    $0x10,%esp
 22d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 230:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 234:	7e 33                	jle    269 <fgets+0x63>
      break;
    buf[i++] = c;
 236:	8b 45 f4             	mov    -0xc(%ebp),%eax
 239:	8d 50 01             	lea    0x1(%eax),%edx
 23c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 23f:	89 c2                	mov    %eax,%edx
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	01 c2                	add    %eax,%edx
 246:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 24a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 24c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 250:	3c 0a                	cmp    $0xa,%al
 252:	74 16                	je     26a <fgets+0x64>
 254:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 258:	3c 0d                	cmp    $0xd,%al
 25a:	74 0e                	je     26a <fgets+0x64>
  for(i = 0; i + 1 < size;){
 25c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25f:	83 c0 01             	add    $0x1,%eax
 262:	39 45 0c             	cmp    %eax,0xc(%ebp)
 265:	7f b2                	jg     219 <fgets+0x13>
 267:	eb 01                	jmp    26a <fgets+0x64>
      break;
 269:	90                   	nop
      break;
  }
  buf[i] = '\0';
 26a:	8b 55 f4             	mov    -0xc(%ebp),%edx
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	01 d0                	add    %edx,%eax
 272:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 275:	8b 45 08             	mov    0x8(%ebp),%eax
}
 278:	c9                   	leave  
 279:	c3                   	ret    

0000027a <stat>:

int
stat(char *n, struct stat *st)
{
 27a:	f3 0f 1e fb          	endbr32 
 27e:	55                   	push   %ebp
 27f:	89 e5                	mov    %esp,%ebp
 281:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 284:	83 ec 08             	sub    $0x8,%esp
 287:	6a 00                	push   $0x0
 289:	ff 75 08             	pushl  0x8(%ebp)
 28c:	e8 eb 01 00 00       	call   47c <open>
 291:	83 c4 10             	add    $0x10,%esp
 294:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 297:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 29b:	79 07                	jns    2a4 <stat+0x2a>
    return -1;
 29d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a2:	eb 25                	jmp    2c9 <stat+0x4f>
  r = fstat(fd, st);
 2a4:	83 ec 08             	sub    $0x8,%esp
 2a7:	ff 75 0c             	pushl  0xc(%ebp)
 2aa:	ff 75 f4             	pushl  -0xc(%ebp)
 2ad:	e8 e2 01 00 00       	call   494 <fstat>
 2b2:	83 c4 10             	add    $0x10,%esp
 2b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2b8:	83 ec 0c             	sub    $0xc,%esp
 2bb:	ff 75 f4             	pushl  -0xc(%ebp)
 2be:	e8 a1 01 00 00       	call   464 <close>
 2c3:	83 c4 10             	add    $0x10,%esp
  return r;
 2c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2c9:	c9                   	leave  
 2ca:	c3                   	ret    

000002cb <atoi>:

int
atoi(const char *s)
{
 2cb:	f3 0f 1e fb          	endbr32 
 2cf:	55                   	push   %ebp
 2d0:	89 e5                	mov    %esp,%ebp
 2d2:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 2d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 2dc:	eb 04                	jmp    2e2 <atoi+0x17>
 2de:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2e2:	8b 45 08             	mov    0x8(%ebp),%eax
 2e5:	0f b6 00             	movzbl (%eax),%eax
 2e8:	3c 20                	cmp    $0x20,%al
 2ea:	74 f2                	je     2de <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
 2ec:	8b 45 08             	mov    0x8(%ebp),%eax
 2ef:	0f b6 00             	movzbl (%eax),%eax
 2f2:	3c 2d                	cmp    $0x2d,%al
 2f4:	75 07                	jne    2fd <atoi+0x32>
 2f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2fb:	eb 05                	jmp    302 <atoi+0x37>
 2fd:	b8 01 00 00 00       	mov    $0x1,%eax
 302:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 305:	8b 45 08             	mov    0x8(%ebp),%eax
 308:	0f b6 00             	movzbl (%eax),%eax
 30b:	3c 2b                	cmp    $0x2b,%al
 30d:	74 0a                	je     319 <atoi+0x4e>
 30f:	8b 45 08             	mov    0x8(%ebp),%eax
 312:	0f b6 00             	movzbl (%eax),%eax
 315:	3c 2d                	cmp    $0x2d,%al
 317:	75 2b                	jne    344 <atoi+0x79>
    s++;
 319:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 31d:	eb 25                	jmp    344 <atoi+0x79>
    n = n*10 + *s++ - '0';
 31f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 322:	89 d0                	mov    %edx,%eax
 324:	c1 e0 02             	shl    $0x2,%eax
 327:	01 d0                	add    %edx,%eax
 329:	01 c0                	add    %eax,%eax
 32b:	89 c1                	mov    %eax,%ecx
 32d:	8b 45 08             	mov    0x8(%ebp),%eax
 330:	8d 50 01             	lea    0x1(%eax),%edx
 333:	89 55 08             	mov    %edx,0x8(%ebp)
 336:	0f b6 00             	movzbl (%eax),%eax
 339:	0f be c0             	movsbl %al,%eax
 33c:	01 c8                	add    %ecx,%eax
 33e:	83 e8 30             	sub    $0x30,%eax
 341:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 344:	8b 45 08             	mov    0x8(%ebp),%eax
 347:	0f b6 00             	movzbl (%eax),%eax
 34a:	3c 2f                	cmp    $0x2f,%al
 34c:	7e 0a                	jle    358 <atoi+0x8d>
 34e:	8b 45 08             	mov    0x8(%ebp),%eax
 351:	0f b6 00             	movzbl (%eax),%eax
 354:	3c 39                	cmp    $0x39,%al
 356:	7e c7                	jle    31f <atoi+0x54>
  return sign*n;
 358:	8b 45 f8             	mov    -0x8(%ebp),%eax
 35b:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 35f:	c9                   	leave  
 360:	c3                   	ret    

00000361 <atoo>:

int
atoo(const char *s)
{
 361:	f3 0f 1e fb          	endbr32 
 365:	55                   	push   %ebp
 366:	89 e5                	mov    %esp,%ebp
 368:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 36b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 372:	eb 04                	jmp    378 <atoo+0x17>
 374:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 378:	8b 45 08             	mov    0x8(%ebp),%eax
 37b:	0f b6 00             	movzbl (%eax),%eax
 37e:	3c 20                	cmp    $0x20,%al
 380:	74 f2                	je     374 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
 382:	8b 45 08             	mov    0x8(%ebp),%eax
 385:	0f b6 00             	movzbl (%eax),%eax
 388:	3c 2d                	cmp    $0x2d,%al
 38a:	75 07                	jne    393 <atoo+0x32>
 38c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 391:	eb 05                	jmp    398 <atoo+0x37>
 393:	b8 01 00 00 00       	mov    $0x1,%eax
 398:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 39b:	8b 45 08             	mov    0x8(%ebp),%eax
 39e:	0f b6 00             	movzbl (%eax),%eax
 3a1:	3c 2b                	cmp    $0x2b,%al
 3a3:	74 0a                	je     3af <atoo+0x4e>
 3a5:	8b 45 08             	mov    0x8(%ebp),%eax
 3a8:	0f b6 00             	movzbl (%eax),%eax
 3ab:	3c 2d                	cmp    $0x2d,%al
 3ad:	75 27                	jne    3d6 <atoo+0x75>
    s++;
 3af:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 3b3:	eb 21                	jmp    3d6 <atoo+0x75>
    n = n*8 + *s++ - '0';
 3b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3b8:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 3bf:	8b 45 08             	mov    0x8(%ebp),%eax
 3c2:	8d 50 01             	lea    0x1(%eax),%edx
 3c5:	89 55 08             	mov    %edx,0x8(%ebp)
 3c8:	0f b6 00             	movzbl (%eax),%eax
 3cb:	0f be c0             	movsbl %al,%eax
 3ce:	01 c8                	add    %ecx,%eax
 3d0:	83 e8 30             	sub    $0x30,%eax
 3d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
 3d6:	8b 45 08             	mov    0x8(%ebp),%eax
 3d9:	0f b6 00             	movzbl (%eax),%eax
 3dc:	3c 2f                	cmp    $0x2f,%al
 3de:	7e 0a                	jle    3ea <atoo+0x89>
 3e0:	8b 45 08             	mov    0x8(%ebp),%eax
 3e3:	0f b6 00             	movzbl (%eax),%eax
 3e6:	3c 37                	cmp    $0x37,%al
 3e8:	7e cb                	jle    3b5 <atoo+0x54>
  return sign*n;
 3ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3ed:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 3f1:	c9                   	leave  
 3f2:	c3                   	ret    

000003f3 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 3f3:	f3 0f 1e fb          	endbr32 
 3f7:	55                   	push   %ebp
 3f8:	89 e5                	mov    %esp,%ebp
 3fa:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3fd:	8b 45 08             	mov    0x8(%ebp),%eax
 400:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 403:	8b 45 0c             	mov    0xc(%ebp),%eax
 406:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 409:	eb 17                	jmp    422 <memmove+0x2f>
    *dst++ = *src++;
 40b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 40e:	8d 42 01             	lea    0x1(%edx),%eax
 411:	89 45 f8             	mov    %eax,-0x8(%ebp)
 414:	8b 45 fc             	mov    -0x4(%ebp),%eax
 417:	8d 48 01             	lea    0x1(%eax),%ecx
 41a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 41d:	0f b6 12             	movzbl (%edx),%edx
 420:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 422:	8b 45 10             	mov    0x10(%ebp),%eax
 425:	8d 50 ff             	lea    -0x1(%eax),%edx
 428:	89 55 10             	mov    %edx,0x10(%ebp)
 42b:	85 c0                	test   %eax,%eax
 42d:	7f dc                	jg     40b <memmove+0x18>
  return vdst;
 42f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 432:	c9                   	leave  
 433:	c3                   	ret    

00000434 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 434:	b8 01 00 00 00       	mov    $0x1,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <exit>:
SYSCALL(exit)
 43c:	b8 02 00 00 00       	mov    $0x2,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <wait>:
SYSCALL(wait)
 444:	b8 03 00 00 00       	mov    $0x3,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <pipe>:
SYSCALL(pipe)
 44c:	b8 04 00 00 00       	mov    $0x4,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <read>:
SYSCALL(read)
 454:	b8 05 00 00 00       	mov    $0x5,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <write>:
SYSCALL(write)
 45c:	b8 10 00 00 00       	mov    $0x10,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <close>:
SYSCALL(close)
 464:	b8 15 00 00 00       	mov    $0x15,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <kill>:
SYSCALL(kill)
 46c:	b8 06 00 00 00       	mov    $0x6,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <exec>:
SYSCALL(exec)
 474:	b8 07 00 00 00       	mov    $0x7,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <open>:
SYSCALL(open)
 47c:	b8 0f 00 00 00       	mov    $0xf,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <mknod>:
SYSCALL(mknod)
 484:	b8 11 00 00 00       	mov    $0x11,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <unlink>:
SYSCALL(unlink)
 48c:	b8 12 00 00 00       	mov    $0x12,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <fstat>:
SYSCALL(fstat)
 494:	b8 08 00 00 00       	mov    $0x8,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <link>:
SYSCALL(link)
 49c:	b8 13 00 00 00       	mov    $0x13,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <mkdir>:
SYSCALL(mkdir)
 4a4:	b8 14 00 00 00       	mov    $0x14,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    

000004ac <chdir>:
SYSCALL(chdir)
 4ac:	b8 09 00 00 00       	mov    $0x9,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <dup>:
SYSCALL(dup)
 4b4:	b8 0a 00 00 00       	mov    $0xa,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <getpid>:
SYSCALL(getpid)
 4bc:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c1:	cd 40                	int    $0x40
 4c3:	c3                   	ret    

000004c4 <sbrk>:
SYSCALL(sbrk)
 4c4:	b8 0c 00 00 00       	mov    $0xc,%eax
 4c9:	cd 40                	int    $0x40
 4cb:	c3                   	ret    

000004cc <sleep>:
SYSCALL(sleep)
 4cc:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d1:	cd 40                	int    $0x40
 4d3:	c3                   	ret    

000004d4 <uptime>:
SYSCALL(uptime)
 4d4:	b8 0e 00 00 00       	mov    $0xe,%eax
 4d9:	cd 40                	int    $0x40
 4db:	c3                   	ret    

000004dc <halt>:
SYSCALL(halt)
 4dc:	b8 16 00 00 00       	mov    $0x16,%eax
 4e1:	cd 40                	int    $0x40
 4e3:	c3                   	ret    

000004e4 <date>:
SYSCALL(date)
 4e4:	b8 17 00 00 00       	mov    $0x17,%eax
 4e9:	cd 40                	int    $0x40
 4eb:	c3                   	ret    

000004ec <getuid>:
SYSCALL(getuid)
 4ec:	b8 18 00 00 00       	mov    $0x18,%eax
 4f1:	cd 40                	int    $0x40
 4f3:	c3                   	ret    

000004f4 <getgid>:
SYSCALL(getgid)
 4f4:	b8 19 00 00 00       	mov    $0x19,%eax
 4f9:	cd 40                	int    $0x40
 4fb:	c3                   	ret    

000004fc <getppid>:
SYSCALL(getppid)
 4fc:	b8 1a 00 00 00       	mov    $0x1a,%eax
 501:	cd 40                	int    $0x40
 503:	c3                   	ret    

00000504 <setuid>:
SYSCALL(setuid)
 504:	b8 1b 00 00 00       	mov    $0x1b,%eax
 509:	cd 40                	int    $0x40
 50b:	c3                   	ret    

0000050c <setgid>:
SYSCALL(setgid)
 50c:	b8 1c 00 00 00       	mov    $0x1c,%eax
 511:	cd 40                	int    $0x40
 513:	c3                   	ret    

00000514 <getprocs>:
SYSCALL(getprocs)
 514:	b8 1d 00 00 00       	mov    $0x1d,%eax
 519:	cd 40                	int    $0x40
 51b:	c3                   	ret    

0000051c <setpriority>:
SYSCALL(setpriority)
 51c:	b8 1e 00 00 00       	mov    $0x1e,%eax
 521:	cd 40                	int    $0x40
 523:	c3                   	ret    

00000524 <chown>:
SYSCALL(chown)
 524:	b8 1f 00 00 00       	mov    $0x1f,%eax
 529:	cd 40                	int    $0x40
 52b:	c3                   	ret    

0000052c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 52c:	f3 0f 1e fb          	endbr32 
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	83 ec 18             	sub    $0x18,%esp
 536:	8b 45 0c             	mov    0xc(%ebp),%eax
 539:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 53c:	83 ec 04             	sub    $0x4,%esp
 53f:	6a 01                	push   $0x1
 541:	8d 45 f4             	lea    -0xc(%ebp),%eax
 544:	50                   	push   %eax
 545:	ff 75 08             	pushl  0x8(%ebp)
 548:	e8 0f ff ff ff       	call   45c <write>
 54d:	83 c4 10             	add    $0x10,%esp
}
 550:	90                   	nop
 551:	c9                   	leave  
 552:	c3                   	ret    

00000553 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 553:	f3 0f 1e fb          	endbr32 
 557:	55                   	push   %ebp
 558:	89 e5                	mov    %esp,%ebp
 55a:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 55d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 564:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 568:	74 17                	je     581 <printint+0x2e>
 56a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 56e:	79 11                	jns    581 <printint+0x2e>
    neg = 1;
 570:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 577:	8b 45 0c             	mov    0xc(%ebp),%eax
 57a:	f7 d8                	neg    %eax
 57c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 57f:	eb 06                	jmp    587 <printint+0x34>
  } else {
    x = xx;
 581:	8b 45 0c             	mov    0xc(%ebp),%eax
 584:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 587:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 58e:	8b 4d 10             	mov    0x10(%ebp),%ecx
 591:	8b 45 ec             	mov    -0x14(%ebp),%eax
 594:	ba 00 00 00 00       	mov    $0x0,%edx
 599:	f7 f1                	div    %ecx
 59b:	89 d1                	mov    %edx,%ecx
 59d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a0:	8d 50 01             	lea    0x1(%eax),%edx
 5a3:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5a6:	0f b6 91 6c 13 00 00 	movzbl 0x136c(%ecx),%edx
 5ad:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 5b1:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5b7:	ba 00 00 00 00       	mov    $0x0,%edx
 5bc:	f7 f1                	div    %ecx
 5be:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5c5:	75 c7                	jne    58e <printint+0x3b>
  if(neg)
 5c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5cb:	74 2d                	je     5fa <printint+0xa7>
    buf[i++] = '-';
 5cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d0:	8d 50 01             	lea    0x1(%eax),%edx
 5d3:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5d6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5db:	eb 1d                	jmp    5fa <printint+0xa7>
    putc(fd, buf[i]);
 5dd:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e3:	01 d0                	add    %edx,%eax
 5e5:	0f b6 00             	movzbl (%eax),%eax
 5e8:	0f be c0             	movsbl %al,%eax
 5eb:	83 ec 08             	sub    $0x8,%esp
 5ee:	50                   	push   %eax
 5ef:	ff 75 08             	pushl  0x8(%ebp)
 5f2:	e8 35 ff ff ff       	call   52c <putc>
 5f7:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5fa:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 602:	79 d9                	jns    5dd <printint+0x8a>
}
 604:	90                   	nop
 605:	90                   	nop
 606:	c9                   	leave  
 607:	c3                   	ret    

00000608 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 608:	f3 0f 1e fb          	endbr32 
 60c:	55                   	push   %ebp
 60d:	89 e5                	mov    %esp,%ebp
 60f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 612:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 619:	8d 45 0c             	lea    0xc(%ebp),%eax
 61c:	83 c0 04             	add    $0x4,%eax
 61f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 622:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 629:	e9 59 01 00 00       	jmp    787 <printf+0x17f>
    c = fmt[i] & 0xff;
 62e:	8b 55 0c             	mov    0xc(%ebp),%edx
 631:	8b 45 f0             	mov    -0x10(%ebp),%eax
 634:	01 d0                	add    %edx,%eax
 636:	0f b6 00             	movzbl (%eax),%eax
 639:	0f be c0             	movsbl %al,%eax
 63c:	25 ff 00 00 00       	and    $0xff,%eax
 641:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 644:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 648:	75 2c                	jne    676 <printf+0x6e>
      if(c == '%'){
 64a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 64e:	75 0c                	jne    65c <printf+0x54>
        state = '%';
 650:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 657:	e9 27 01 00 00       	jmp    783 <printf+0x17b>
      } else {
        putc(fd, c);
 65c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 65f:	0f be c0             	movsbl %al,%eax
 662:	83 ec 08             	sub    $0x8,%esp
 665:	50                   	push   %eax
 666:	ff 75 08             	pushl  0x8(%ebp)
 669:	e8 be fe ff ff       	call   52c <putc>
 66e:	83 c4 10             	add    $0x10,%esp
 671:	e9 0d 01 00 00       	jmp    783 <printf+0x17b>
      }
    } else if(state == '%'){
 676:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 67a:	0f 85 03 01 00 00    	jne    783 <printf+0x17b>
      if(c == 'd'){
 680:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 684:	75 1e                	jne    6a4 <printf+0x9c>
        printint(fd, *ap, 10, 1);
 686:	8b 45 e8             	mov    -0x18(%ebp),%eax
 689:	8b 00                	mov    (%eax),%eax
 68b:	6a 01                	push   $0x1
 68d:	6a 0a                	push   $0xa
 68f:	50                   	push   %eax
 690:	ff 75 08             	pushl  0x8(%ebp)
 693:	e8 bb fe ff ff       	call   553 <printint>
 698:	83 c4 10             	add    $0x10,%esp
        ap++;
 69b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 69f:	e9 d8 00 00 00       	jmp    77c <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 6a4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6a8:	74 06                	je     6b0 <printf+0xa8>
 6aa:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6ae:	75 1e                	jne    6ce <printf+0xc6>
        printint(fd, *ap, 16, 0);
 6b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6b3:	8b 00                	mov    (%eax),%eax
 6b5:	6a 00                	push   $0x0
 6b7:	6a 10                	push   $0x10
 6b9:	50                   	push   %eax
 6ba:	ff 75 08             	pushl  0x8(%ebp)
 6bd:	e8 91 fe ff ff       	call   553 <printint>
 6c2:	83 c4 10             	add    $0x10,%esp
        ap++;
 6c5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6c9:	e9 ae 00 00 00       	jmp    77c <printf+0x174>
      } else if(c == 's'){
 6ce:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6d2:	75 43                	jne    717 <printf+0x10f>
        s = (char*)*ap;
 6d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6dc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6e4:	75 25                	jne    70b <printf+0x103>
          s = "(null)";
 6e6:	c7 45 f4 37 0f 00 00 	movl   $0xf37,-0xc(%ebp)
        while(*s != 0){
 6ed:	eb 1c                	jmp    70b <printf+0x103>
          putc(fd, *s);
 6ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f2:	0f b6 00             	movzbl (%eax),%eax
 6f5:	0f be c0             	movsbl %al,%eax
 6f8:	83 ec 08             	sub    $0x8,%esp
 6fb:	50                   	push   %eax
 6fc:	ff 75 08             	pushl  0x8(%ebp)
 6ff:	e8 28 fe ff ff       	call   52c <putc>
 704:	83 c4 10             	add    $0x10,%esp
          s++;
 707:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 70b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 70e:	0f b6 00             	movzbl (%eax),%eax
 711:	84 c0                	test   %al,%al
 713:	75 da                	jne    6ef <printf+0xe7>
 715:	eb 65                	jmp    77c <printf+0x174>
        }
      } else if(c == 'c'){
 717:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 71b:	75 1d                	jne    73a <printf+0x132>
        putc(fd, *ap);
 71d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 720:	8b 00                	mov    (%eax),%eax
 722:	0f be c0             	movsbl %al,%eax
 725:	83 ec 08             	sub    $0x8,%esp
 728:	50                   	push   %eax
 729:	ff 75 08             	pushl  0x8(%ebp)
 72c:	e8 fb fd ff ff       	call   52c <putc>
 731:	83 c4 10             	add    $0x10,%esp
        ap++;
 734:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 738:	eb 42                	jmp    77c <printf+0x174>
      } else if(c == '%'){
 73a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 73e:	75 17                	jne    757 <printf+0x14f>
        putc(fd, c);
 740:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 743:	0f be c0             	movsbl %al,%eax
 746:	83 ec 08             	sub    $0x8,%esp
 749:	50                   	push   %eax
 74a:	ff 75 08             	pushl  0x8(%ebp)
 74d:	e8 da fd ff ff       	call   52c <putc>
 752:	83 c4 10             	add    $0x10,%esp
 755:	eb 25                	jmp    77c <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 757:	83 ec 08             	sub    $0x8,%esp
 75a:	6a 25                	push   $0x25
 75c:	ff 75 08             	pushl  0x8(%ebp)
 75f:	e8 c8 fd ff ff       	call   52c <putc>
 764:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 767:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 76a:	0f be c0             	movsbl %al,%eax
 76d:	83 ec 08             	sub    $0x8,%esp
 770:	50                   	push   %eax
 771:	ff 75 08             	pushl  0x8(%ebp)
 774:	e8 b3 fd ff ff       	call   52c <putc>
 779:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 77c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 783:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 787:	8b 55 0c             	mov    0xc(%ebp),%edx
 78a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78d:	01 d0                	add    %edx,%eax
 78f:	0f b6 00             	movzbl (%eax),%eax
 792:	84 c0                	test   %al,%al
 794:	0f 85 94 fe ff ff    	jne    62e <printf+0x26>
    }
  }
}
 79a:	90                   	nop
 79b:	90                   	nop
 79c:	c9                   	leave  
 79d:	c3                   	ret    

0000079e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 79e:	f3 0f 1e fb          	endbr32 
 7a2:	55                   	push   %ebp
 7a3:	89 e5                	mov    %esp,%ebp
 7a5:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7a8:	8b 45 08             	mov    0x8(%ebp),%eax
 7ab:	83 e8 08             	sub    $0x8,%eax
 7ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b1:	a1 88 13 00 00       	mov    0x1388,%eax
 7b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7b9:	eb 24                	jmp    7df <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7be:	8b 00                	mov    (%eax),%eax
 7c0:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 7c3:	72 12                	jb     7d7 <free+0x39>
 7c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7cb:	77 24                	ja     7f1 <free+0x53>
 7cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d0:	8b 00                	mov    (%eax),%eax
 7d2:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7d5:	72 1a                	jb     7f1 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7da:	8b 00                	mov    (%eax),%eax
 7dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7df:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7e5:	76 d4                	jbe    7bb <free+0x1d>
 7e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ea:	8b 00                	mov    (%eax),%eax
 7ec:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7ef:	73 ca                	jae    7bb <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f4:	8b 40 04             	mov    0x4(%eax),%eax
 7f7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 801:	01 c2                	add    %eax,%edx
 803:	8b 45 fc             	mov    -0x4(%ebp),%eax
 806:	8b 00                	mov    (%eax),%eax
 808:	39 c2                	cmp    %eax,%edx
 80a:	75 24                	jne    830 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 80c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80f:	8b 50 04             	mov    0x4(%eax),%edx
 812:	8b 45 fc             	mov    -0x4(%ebp),%eax
 815:	8b 00                	mov    (%eax),%eax
 817:	8b 40 04             	mov    0x4(%eax),%eax
 81a:	01 c2                	add    %eax,%edx
 81c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 822:	8b 45 fc             	mov    -0x4(%ebp),%eax
 825:	8b 00                	mov    (%eax),%eax
 827:	8b 10                	mov    (%eax),%edx
 829:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82c:	89 10                	mov    %edx,(%eax)
 82e:	eb 0a                	jmp    83a <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 830:	8b 45 fc             	mov    -0x4(%ebp),%eax
 833:	8b 10                	mov    (%eax),%edx
 835:	8b 45 f8             	mov    -0x8(%ebp),%eax
 838:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 83a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83d:	8b 40 04             	mov    0x4(%eax),%eax
 840:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 847:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84a:	01 d0                	add    %edx,%eax
 84c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 84f:	75 20                	jne    871 <free+0xd3>
    p->s.size += bp->s.size;
 851:	8b 45 fc             	mov    -0x4(%ebp),%eax
 854:	8b 50 04             	mov    0x4(%eax),%edx
 857:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85a:	8b 40 04             	mov    0x4(%eax),%eax
 85d:	01 c2                	add    %eax,%edx
 85f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 862:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 865:	8b 45 f8             	mov    -0x8(%ebp),%eax
 868:	8b 10                	mov    (%eax),%edx
 86a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86d:	89 10                	mov    %edx,(%eax)
 86f:	eb 08                	jmp    879 <free+0xdb>
  } else
    p->s.ptr = bp;
 871:	8b 45 fc             	mov    -0x4(%ebp),%eax
 874:	8b 55 f8             	mov    -0x8(%ebp),%edx
 877:	89 10                	mov    %edx,(%eax)
  freep = p;
 879:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87c:	a3 88 13 00 00       	mov    %eax,0x1388
}
 881:	90                   	nop
 882:	c9                   	leave  
 883:	c3                   	ret    

00000884 <morecore>:

static Header*
morecore(uint nu)
{
 884:	f3 0f 1e fb          	endbr32 
 888:	55                   	push   %ebp
 889:	89 e5                	mov    %esp,%ebp
 88b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 88e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 895:	77 07                	ja     89e <morecore+0x1a>
    nu = 4096;
 897:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 89e:	8b 45 08             	mov    0x8(%ebp),%eax
 8a1:	c1 e0 03             	shl    $0x3,%eax
 8a4:	83 ec 0c             	sub    $0xc,%esp
 8a7:	50                   	push   %eax
 8a8:	e8 17 fc ff ff       	call   4c4 <sbrk>
 8ad:	83 c4 10             	add    $0x10,%esp
 8b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8b3:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8b7:	75 07                	jne    8c0 <morecore+0x3c>
    return 0;
 8b9:	b8 00 00 00 00       	mov    $0x0,%eax
 8be:	eb 26                	jmp    8e6 <morecore+0x62>
  hp = (Header*)p;
 8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c9:	8b 55 08             	mov    0x8(%ebp),%edx
 8cc:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d2:	83 c0 08             	add    $0x8,%eax
 8d5:	83 ec 0c             	sub    $0xc,%esp
 8d8:	50                   	push   %eax
 8d9:	e8 c0 fe ff ff       	call   79e <free>
 8de:	83 c4 10             	add    $0x10,%esp
  return freep;
 8e1:	a1 88 13 00 00       	mov    0x1388,%eax
}
 8e6:	c9                   	leave  
 8e7:	c3                   	ret    

000008e8 <malloc>:

void*
malloc(uint nbytes)
{
 8e8:	f3 0f 1e fb          	endbr32 
 8ec:	55                   	push   %ebp
 8ed:	89 e5                	mov    %esp,%ebp
 8ef:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f2:	8b 45 08             	mov    0x8(%ebp),%eax
 8f5:	83 c0 07             	add    $0x7,%eax
 8f8:	c1 e8 03             	shr    $0x3,%eax
 8fb:	83 c0 01             	add    $0x1,%eax
 8fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 901:	a1 88 13 00 00       	mov    0x1388,%eax
 906:	89 45 f0             	mov    %eax,-0x10(%ebp)
 909:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 90d:	75 23                	jne    932 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 90f:	c7 45 f0 80 13 00 00 	movl   $0x1380,-0x10(%ebp)
 916:	8b 45 f0             	mov    -0x10(%ebp),%eax
 919:	a3 88 13 00 00       	mov    %eax,0x1388
 91e:	a1 88 13 00 00       	mov    0x1388,%eax
 923:	a3 80 13 00 00       	mov    %eax,0x1380
    base.s.size = 0;
 928:	c7 05 84 13 00 00 00 	movl   $0x0,0x1384
 92f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 932:	8b 45 f0             	mov    -0x10(%ebp),%eax
 935:	8b 00                	mov    (%eax),%eax
 937:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 93a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93d:	8b 40 04             	mov    0x4(%eax),%eax
 940:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 943:	77 4d                	ja     992 <malloc+0xaa>
      if(p->s.size == nunits)
 945:	8b 45 f4             	mov    -0xc(%ebp),%eax
 948:	8b 40 04             	mov    0x4(%eax),%eax
 94b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 94e:	75 0c                	jne    95c <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 950:	8b 45 f4             	mov    -0xc(%ebp),%eax
 953:	8b 10                	mov    (%eax),%edx
 955:	8b 45 f0             	mov    -0x10(%ebp),%eax
 958:	89 10                	mov    %edx,(%eax)
 95a:	eb 26                	jmp    982 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 95c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95f:	8b 40 04             	mov    0x4(%eax),%eax
 962:	2b 45 ec             	sub    -0x14(%ebp),%eax
 965:	89 c2                	mov    %eax,%edx
 967:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 96d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 970:	8b 40 04             	mov    0x4(%eax),%eax
 973:	c1 e0 03             	shl    $0x3,%eax
 976:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 979:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 97f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 982:	8b 45 f0             	mov    -0x10(%ebp),%eax
 985:	a3 88 13 00 00       	mov    %eax,0x1388
      return (void*)(p + 1);
 98a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 98d:	83 c0 08             	add    $0x8,%eax
 990:	eb 3b                	jmp    9cd <malloc+0xe5>
    }
    if(p == freep)
 992:	a1 88 13 00 00       	mov    0x1388,%eax
 997:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 99a:	75 1e                	jne    9ba <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 99c:	83 ec 0c             	sub    $0xc,%esp
 99f:	ff 75 ec             	pushl  -0x14(%ebp)
 9a2:	e8 dd fe ff ff       	call   884 <morecore>
 9a7:	83 c4 10             	add    $0x10,%esp
 9aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9b1:	75 07                	jne    9ba <malloc+0xd2>
        return 0;
 9b3:	b8 00 00 00 00       	mov    $0x0,%eax
 9b8:	eb 13                	jmp    9cd <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c3:	8b 00                	mov    (%eax),%eax
 9c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9c8:	e9 6d ff ff ff       	jmp    93a <malloc+0x52>
  }
}
 9cd:	c9                   	leave  
 9ce:	c3                   	ret    

000009cf <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
 9cf:	f3 0f 1e fb          	endbr32 
 9d3:	55                   	push   %ebp
 9d4:	89 e5                	mov    %esp,%ebp
 9d6:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 9d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 9e0:	a1 e0 13 00 00       	mov    0x13e0,%eax
 9e5:	83 ec 04             	sub    $0x4,%esp
 9e8:	50                   	push   %eax
 9e9:	6a 20                	push   $0x20
 9eb:	68 c0 13 00 00       	push   $0x13c0
 9f0:	e8 11 f8 ff ff       	call   206 <fgets>
 9f5:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 9f8:	83 ec 0c             	sub    $0xc,%esp
 9fb:	68 c0 13 00 00       	push   $0x13c0
 a00:	e8 0e f7 ff ff       	call   113 <strlen>
 a05:	83 c4 10             	add    $0x10,%esp
 a08:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 a0b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a0e:	83 e8 01             	sub    $0x1,%eax
 a11:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 a18:	3c 0a                	cmp    $0xa,%al
 a1a:	74 11                	je     a2d <get_id+0x5e>
 a1c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a1f:	83 e8 01             	sub    $0x1,%eax
 a22:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 a29:	3c 0d                	cmp    $0xd,%al
 a2b:	75 0d                	jne    a3a <get_id+0x6b>
        current_line[len - 1] = 0;
 a2d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a30:	83 e8 01             	sub    $0x1,%eax
 a33:	c6 80 c0 13 00 00 00 	movb   $0x0,0x13c0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 a3a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 a41:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 a48:	eb 6c                	jmp    ab6 <get_id+0xe7>
        if(current_line[i] == ' '){
 a4a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a4d:	05 c0 13 00 00       	add    $0x13c0,%eax
 a52:	0f b6 00             	movzbl (%eax),%eax
 a55:	3c 20                	cmp    $0x20,%al
 a57:	75 30                	jne    a89 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 a59:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a5d:	75 16                	jne    a75 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 a5f:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a62:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a65:	8d 50 01             	lea    0x1(%eax),%edx
 a68:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a6b:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 a71:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 a75:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a78:	05 c0 13 00 00       	add    $0x13c0,%eax
 a7d:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 a80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a87:	eb 29                	jmp    ab2 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 a89:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a8d:	75 23                	jne    ab2 <get_id+0xe3>
 a8f:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 a93:	7f 1d                	jg     ab2 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 a95:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 a9c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aa2:	8d 50 01             	lea    0x1(%eax),%edx
 aa5:	89 55 f0             	mov    %edx,-0x10(%ebp)
 aa8:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 aae:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 ab2:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 ab6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ab9:	05 c0 13 00 00       	add    $0x13c0,%eax
 abe:	0f b6 00             	movzbl (%eax),%eax
 ac1:	84 c0                	test   %al,%al
 ac3:	75 85                	jne    a4a <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 ac5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 ac9:	75 07                	jne    ad2 <get_id+0x103>
        return -1;
 acb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ad0:	eb 35                	jmp    b07 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
 ad2:	8b 45 dc             	mov    -0x24(%ebp),%eax
 ad5:	a3 a0 13 00 00       	mov    %eax,0x13a0
    current_id.uid_user = atoi(tokens[1]);
 ada:	8b 45 e0             	mov    -0x20(%ebp),%eax
 add:	83 ec 0c             	sub    $0xc,%esp
 ae0:	50                   	push   %eax
 ae1:	e8 e5 f7 ff ff       	call   2cb <atoi>
 ae6:	83 c4 10             	add    $0x10,%esp
 ae9:	a3 a4 13 00 00       	mov    %eax,0x13a4
    current_id.gid_user = atoi(tokens[2]);
 aee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 af1:	83 ec 0c             	sub    $0xc,%esp
 af4:	50                   	push   %eax
 af5:	e8 d1 f7 ff ff       	call   2cb <atoi>
 afa:	83 c4 10             	add    $0x10,%esp
 afd:	a3 a8 13 00 00       	mov    %eax,0x13a8

    return 0;
 b02:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b07:	c9                   	leave  
 b08:	c3                   	ret    

00000b09 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
 b09:	f3 0f 1e fb          	endbr32 
 b0d:	55                   	push   %ebp
 b0e:	89 e5                	mov    %esp,%ebp
 b10:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 b13:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b18:	85 c0                	test   %eax,%eax
 b1a:	75 31                	jne    b4d <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
 b1c:	83 ec 08             	sub    $0x8,%esp
 b1f:	6a 00                	push   $0x0
 b21:	68 3e 0f 00 00       	push   $0xf3e
 b26:	e8 51 f9 ff ff       	call   47c <open>
 b2b:	83 c4 10             	add    $0x10,%esp
 b2e:	a3 e0 13 00 00       	mov    %eax,0x13e0

        if(dir < 0){        // kalau gagal membuka file
 b33:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b38:	85 c0                	test   %eax,%eax
 b3a:	79 11                	jns    b4d <getid+0x44>
            dir = 0;
 b3c:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 b43:	00 00 00 
            return 0;
 b46:	b8 00 00 00 00       	mov    $0x0,%eax
 b4b:	eb 16                	jmp    b63 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
 b4d:	e8 7d fe ff ff       	call   9cf <get_id>
 b52:	83 f8 ff             	cmp    $0xffffffff,%eax
 b55:	75 07                	jne    b5e <getid+0x55>
        return 0;
 b57:	b8 00 00 00 00       	mov    $0x0,%eax
 b5c:	eb 05                	jmp    b63 <getid+0x5a>
    
    return &current_id;
 b5e:	b8 a0 13 00 00       	mov    $0x13a0,%eax
}
 b63:	c9                   	leave  
 b64:	c3                   	ret    

00000b65 <setid>:

// open file_ids
void setid(void){
 b65:	f3 0f 1e fb          	endbr32 
 b69:	55                   	push   %ebp
 b6a:	89 e5                	mov    %esp,%ebp
 b6c:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b6f:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b74:	85 c0                	test   %eax,%eax
 b76:	74 1b                	je     b93 <setid+0x2e>
        close(dir);
 b78:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b7d:	83 ec 0c             	sub    $0xc,%esp
 b80:	50                   	push   %eax
 b81:	e8 de f8 ff ff       	call   464 <close>
 b86:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 b89:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 b90:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
 b93:	83 ec 08             	sub    $0x8,%esp
 b96:	6a 00                	push   $0x0
 b98:	68 3e 0f 00 00       	push   $0xf3e
 b9d:	e8 da f8 ff ff       	call   47c <open>
 ba2:	83 c4 10             	add    $0x10,%esp
 ba5:	a3 e0 13 00 00       	mov    %eax,0x13e0

    if (dir < 0)
 baa:	a1 e0 13 00 00       	mov    0x13e0,%eax
 baf:	85 c0                	test   %eax,%eax
 bb1:	79 0a                	jns    bbd <setid+0x58>
        dir = 0;
 bb3:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 bba:	00 00 00 
}
 bbd:	90                   	nop
 bbe:	c9                   	leave  
 bbf:	c3                   	ret    

00000bc0 <endid>:

// tutup file_ids
void endid (void){
 bc0:	f3 0f 1e fb          	endbr32 
 bc4:	55                   	push   %ebp
 bc5:	89 e5                	mov    %esp,%ebp
 bc7:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 bca:	a1 e0 13 00 00       	mov    0x13e0,%eax
 bcf:	85 c0                	test   %eax,%eax
 bd1:	74 1b                	je     bee <endid+0x2e>
        close(dir);
 bd3:	a1 e0 13 00 00       	mov    0x13e0,%eax
 bd8:	83 ec 0c             	sub    $0xc,%esp
 bdb:	50                   	push   %eax
 bdc:	e8 83 f8 ff ff       	call   464 <close>
 be1:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 be4:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 beb:	00 00 00 
    }
}
 bee:	90                   	nop
 bef:	c9                   	leave  
 bf0:	c3                   	ret    

00000bf1 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
 bf1:	f3 0f 1e fb          	endbr32 
 bf5:	55                   	push   %ebp
 bf6:	89 e5                	mov    %esp,%ebp
 bf8:	83 ec 08             	sub    $0x8,%esp
    setid();
 bfb:	e8 65 ff ff ff       	call   b65 <setid>

    while (getid()){
 c00:	eb 24                	jmp    c26 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
 c02:	a1 a0 13 00 00       	mov    0x13a0,%eax
 c07:	83 ec 08             	sub    $0x8,%esp
 c0a:	50                   	push   %eax
 c0b:	ff 75 08             	pushl  0x8(%ebp)
 c0e:	e8 bd f4 ff ff       	call   d0 <strcmp>
 c13:	83 c4 10             	add    $0x10,%esp
 c16:	85 c0                	test   %eax,%eax
 c18:	75 0c                	jne    c26 <cek_nama+0x35>
            endid();
 c1a:	e8 a1 ff ff ff       	call   bc0 <endid>
            return &current_id;
 c1f:	b8 a0 13 00 00       	mov    $0x13a0,%eax
 c24:	eb 13                	jmp    c39 <cek_nama+0x48>
    while (getid()){
 c26:	e8 de fe ff ff       	call   b09 <getid>
 c2b:	85 c0                	test   %eax,%eax
 c2d:	75 d3                	jne    c02 <cek_nama+0x11>
        }
    }
    endid();
 c2f:	e8 8c ff ff ff       	call   bc0 <endid>
    return 0;
 c34:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c39:	c9                   	leave  
 c3a:	c3                   	ret    

00000c3b <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
 c3b:	f3 0f 1e fb          	endbr32 
 c3f:	55                   	push   %ebp
 c40:	89 e5                	mov    %esp,%ebp
 c42:	83 ec 08             	sub    $0x8,%esp
    setid();
 c45:	e8 1b ff ff ff       	call   b65 <setid>

    while (getid()){
 c4a:	eb 16                	jmp    c62 <cek_uid+0x27>
        if(current_id.uid_user == uid){
 c4c:	a1 a4 13 00 00       	mov    0x13a4,%eax
 c51:	39 45 08             	cmp    %eax,0x8(%ebp)
 c54:	75 0c                	jne    c62 <cek_uid+0x27>
            endid();
 c56:	e8 65 ff ff ff       	call   bc0 <endid>
            return &current_id;
 c5b:	b8 a0 13 00 00       	mov    $0x13a0,%eax
 c60:	eb 13                	jmp    c75 <cek_uid+0x3a>
    while (getid()){
 c62:	e8 a2 fe ff ff       	call   b09 <getid>
 c67:	85 c0                	test   %eax,%eax
 c69:	75 e1                	jne    c4c <cek_uid+0x11>
        }
    }
    endid();
 c6b:	e8 50 ff ff ff       	call   bc0 <endid>
    return 0;
 c70:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c75:	c9                   	leave  
 c76:	c3                   	ret    

00000c77 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
 c77:	f3 0f 1e fb          	endbr32 
 c7b:	55                   	push   %ebp
 c7c:	89 e5                	mov    %esp,%ebp
 c7e:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 c81:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 c88:	a1 e0 13 00 00       	mov    0x13e0,%eax
 c8d:	83 ec 04             	sub    $0x4,%esp
 c90:	50                   	push   %eax
 c91:	6a 20                	push   $0x20
 c93:	68 c0 13 00 00       	push   $0x13c0
 c98:	e8 69 f5 ff ff       	call   206 <fgets>
 c9d:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 ca0:	83 ec 0c             	sub    $0xc,%esp
 ca3:	68 c0 13 00 00       	push   $0x13c0
 ca8:	e8 66 f4 ff ff       	call   113 <strlen>
 cad:	83 c4 10             	add    $0x10,%esp
 cb0:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 cb3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cb6:	83 e8 01             	sub    $0x1,%eax
 cb9:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 cc0:	3c 0a                	cmp    $0xa,%al
 cc2:	74 11                	je     cd5 <get_group+0x5e>
 cc4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cc7:	83 e8 01             	sub    $0x1,%eax
 cca:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 cd1:	3c 0d                	cmp    $0xd,%al
 cd3:	75 0d                	jne    ce2 <get_group+0x6b>
        current_line[len - 1] = 0;
 cd5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cd8:	83 e8 01             	sub    $0x1,%eax
 cdb:	c6 80 c0 13 00 00 00 	movb   $0x0,0x13c0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 ce2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 ce9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 cf0:	eb 6c                	jmp    d5e <get_group+0xe7>
        if(current_line[i] == ' '){
 cf2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 cf5:	05 c0 13 00 00       	add    $0x13c0,%eax
 cfa:	0f b6 00             	movzbl (%eax),%eax
 cfd:	3c 20                	cmp    $0x20,%al
 cff:	75 30                	jne    d31 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 d01:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d05:	75 16                	jne    d1d <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 d07:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d0d:	8d 50 01             	lea    0x1(%eax),%edx
 d10:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d13:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 d19:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 d1d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d20:	05 c0 13 00 00       	add    $0x13c0,%eax
 d25:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 d28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 d2f:	eb 29                	jmp    d5a <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 d31:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d35:	75 23                	jne    d5a <get_group+0xe3>
 d37:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 d3b:	7f 1d                	jg     d5a <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 d3d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 d44:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d47:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d4a:	8d 50 01             	lea    0x1(%eax),%edx
 d4d:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d50:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 d56:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 d5a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 d5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d61:	05 c0 13 00 00       	add    $0x13c0,%eax
 d66:	0f b6 00             	movzbl (%eax),%eax
 d69:	84 c0                	test   %al,%al
 d6b:	75 85                	jne    cf2 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 d6d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 d71:	75 07                	jne    d7a <get_group+0x103>
        return -1;
 d73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d78:	eb 21                	jmp    d9b <get_group+0x124>
    
    current_group.nama_group = tokens[0];
 d7a:	8b 45 dc             	mov    -0x24(%ebp),%eax
 d7d:	a3 ac 13 00 00       	mov    %eax,0x13ac
    current_group.gid = atoi(tokens[1]);
 d82:	8b 45 e0             	mov    -0x20(%ebp),%eax
 d85:	83 ec 0c             	sub    $0xc,%esp
 d88:	50                   	push   %eax
 d89:	e8 3d f5 ff ff       	call   2cb <atoi>
 d8e:	83 c4 10             	add    $0x10,%esp
 d91:	a3 b0 13 00 00       	mov    %eax,0x13b0

    return 0;
 d96:	b8 00 00 00 00       	mov    $0x0,%eax
}
 d9b:	c9                   	leave  
 d9c:	c3                   	ret    

00000d9d <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
 d9d:	f3 0f 1e fb          	endbr32 
 da1:	55                   	push   %ebp
 da2:	89 e5                	mov    %esp,%ebp
 da4:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 da7:	a1 e0 13 00 00       	mov    0x13e0,%eax
 dac:	85 c0                	test   %eax,%eax
 dae:	75 31                	jne    de1 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
 db0:	83 ec 08             	sub    $0x8,%esp
 db3:	6a 00                	push   $0x0
 db5:	68 46 0f 00 00       	push   $0xf46
 dba:	e8 bd f6 ff ff       	call   47c <open>
 dbf:	83 c4 10             	add    $0x10,%esp
 dc2:	a3 e0 13 00 00       	mov    %eax,0x13e0

        if(dir < 0){        // kalau gagal membuka file
 dc7:	a1 e0 13 00 00       	mov    0x13e0,%eax
 dcc:	85 c0                	test   %eax,%eax
 dce:	79 11                	jns    de1 <getgroup+0x44>
            dir = 0;
 dd0:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 dd7:	00 00 00 
            return 0;
 dda:	b8 00 00 00 00       	mov    $0x0,%eax
 ddf:	eb 16                	jmp    df7 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
 de1:	e8 91 fe ff ff       	call   c77 <get_group>
 de6:	83 f8 ff             	cmp    $0xffffffff,%eax
 de9:	75 07                	jne    df2 <getgroup+0x55>
        return 0;
 deb:	b8 00 00 00 00       	mov    $0x0,%eax
 df0:	eb 05                	jmp    df7 <getgroup+0x5a>
    
    return &current_group;
 df2:	b8 ac 13 00 00       	mov    $0x13ac,%eax
}
 df7:	c9                   	leave  
 df8:	c3                   	ret    

00000df9 <setgroup>:

// open file_ids
void setgroup(void){
 df9:	f3 0f 1e fb          	endbr32 
 dfd:	55                   	push   %ebp
 dfe:	89 e5                	mov    %esp,%ebp
 e00:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e03:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e08:	85 c0                	test   %eax,%eax
 e0a:	74 1b                	je     e27 <setgroup+0x2e>
        close(dir);
 e0c:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e11:	83 ec 0c             	sub    $0xc,%esp
 e14:	50                   	push   %eax
 e15:	e8 4a f6 ff ff       	call   464 <close>
 e1a:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e1d:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 e24:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
 e27:	83 ec 08             	sub    $0x8,%esp
 e2a:	6a 00                	push   $0x0
 e2c:	68 46 0f 00 00       	push   $0xf46
 e31:	e8 46 f6 ff ff       	call   47c <open>
 e36:	83 c4 10             	add    $0x10,%esp
 e39:	a3 e0 13 00 00       	mov    %eax,0x13e0

    if (dir < 0)
 e3e:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e43:	85 c0                	test   %eax,%eax
 e45:	79 0a                	jns    e51 <setgroup+0x58>
        dir = 0;
 e47:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 e4e:	00 00 00 
}
 e51:	90                   	nop
 e52:	c9                   	leave  
 e53:	c3                   	ret    

00000e54 <endgroup>:

// tutup file_ids
void endgroup (void){
 e54:	f3 0f 1e fb          	endbr32 
 e58:	55                   	push   %ebp
 e59:	89 e5                	mov    %esp,%ebp
 e5b:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e5e:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e63:	85 c0                	test   %eax,%eax
 e65:	74 1b                	je     e82 <endgroup+0x2e>
        close(dir);
 e67:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e6c:	83 ec 0c             	sub    $0xc,%esp
 e6f:	50                   	push   %eax
 e70:	e8 ef f5 ff ff       	call   464 <close>
 e75:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e78:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 e7f:	00 00 00 
    }
}
 e82:	90                   	nop
 e83:	c9                   	leave  
 e84:	c3                   	ret    

00000e85 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
 e85:	f3 0f 1e fb          	endbr32 
 e89:	55                   	push   %ebp
 e8a:	89 e5                	mov    %esp,%ebp
 e8c:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 e8f:	e8 65 ff ff ff       	call   df9 <setgroup>

    while (getgroup()){
 e94:	eb 3c                	jmp    ed2 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
 e96:	a1 ac 13 00 00       	mov    0x13ac,%eax
 e9b:	83 ec 08             	sub    $0x8,%esp
 e9e:	50                   	push   %eax
 e9f:	ff 75 08             	pushl  0x8(%ebp)
 ea2:	e8 29 f2 ff ff       	call   d0 <strcmp>
 ea7:	83 c4 10             	add    $0x10,%esp
 eaa:	85 c0                	test   %eax,%eax
 eac:	75 24                	jne    ed2 <cek_nama_group+0x4d>
            endgroup();
 eae:	e8 a1 ff ff ff       	call   e54 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
 eb3:	a1 ac 13 00 00       	mov    0x13ac,%eax
 eb8:	83 ec 04             	sub    $0x4,%esp
 ebb:	50                   	push   %eax
 ebc:	68 51 0f 00 00       	push   $0xf51
 ec1:	6a 01                	push   $0x1
 ec3:	e8 40 f7 ff ff       	call   608 <printf>
 ec8:	83 c4 10             	add    $0x10,%esp
            return &current_group;
 ecb:	b8 ac 13 00 00       	mov    $0x13ac,%eax
 ed0:	eb 13                	jmp    ee5 <cek_nama_group+0x60>
    while (getgroup()){
 ed2:	e8 c6 fe ff ff       	call   d9d <getgroup>
 ed7:	85 c0                	test   %eax,%eax
 ed9:	75 bb                	jne    e96 <cek_nama_group+0x11>
        }
    }
    endgroup();
 edb:	e8 74 ff ff ff       	call   e54 <endgroup>
    return 0;
 ee0:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ee5:	c9                   	leave  
 ee6:	c3                   	ret    

00000ee7 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
 ee7:	f3 0f 1e fb          	endbr32 
 eeb:	55                   	push   %ebp
 eec:	89 e5                	mov    %esp,%ebp
 eee:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 ef1:	e8 03 ff ff ff       	call   df9 <setgroup>

    while (getgroup()){
 ef6:	eb 16                	jmp    f0e <cek_gid+0x27>
        if(current_group.gid == gid){
 ef8:	a1 b0 13 00 00       	mov    0x13b0,%eax
 efd:	39 45 08             	cmp    %eax,0x8(%ebp)
 f00:	75 0c                	jne    f0e <cek_gid+0x27>
            endgroup();
 f02:	e8 4d ff ff ff       	call   e54 <endgroup>
            return &current_group;
 f07:	b8 ac 13 00 00       	mov    $0x13ac,%eax
 f0c:	eb 13                	jmp    f21 <cek_gid+0x3a>
    while (getgroup()){
 f0e:	e8 8a fe ff ff       	call   d9d <getgroup>
 f13:	85 c0                	test   %eax,%eax
 f15:	75 e1                	jne    ef8 <cek_gid+0x11>
        }
    }
    endgroup();
 f17:	e8 38 ff ff ff       	call   e54 <endgroup>
    return 0;
 f1c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 f21:	c9                   	leave  
 f22:	c3                   	ret    
