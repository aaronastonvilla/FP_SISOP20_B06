
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  13:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
  15:	83 3b 03             	cmpl   $0x3,(%ebx)
  18:	74 17                	je     31 <main+0x31>
    printf(2, "Usage: ln old new\n");
  1a:	83 ec 08             	sub    $0x8,%esp
  1d:	68 25 0f 00 00       	push   $0xf25
  22:	6a 02                	push   $0x2
  24:	e8 e1 05 00 00       	call   60a <printf>
  29:	83 c4 10             	add    $0x10,%esp
    exit();
  2c:	e8 0d 04 00 00       	call   43e <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  31:	8b 43 04             	mov    0x4(%ebx),%eax
  34:	83 c0 08             	add    $0x8,%eax
  37:	8b 10                	mov    (%eax),%edx
  39:	8b 43 04             	mov    0x4(%ebx),%eax
  3c:	83 c0 04             	add    $0x4,%eax
  3f:	8b 00                	mov    (%eax),%eax
  41:	83 ec 08             	sub    $0x8,%esp
  44:	52                   	push   %edx
  45:	50                   	push   %eax
  46:	e8 53 04 00 00       	call   49e <link>
  4b:	83 c4 10             	add    $0x10,%esp
  4e:	85 c0                	test   %eax,%eax
  50:	79 21                	jns    73 <main+0x73>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  52:	8b 43 04             	mov    0x4(%ebx),%eax
  55:	83 c0 08             	add    $0x8,%eax
  58:	8b 10                	mov    (%eax),%edx
  5a:	8b 43 04             	mov    0x4(%ebx),%eax
  5d:	83 c0 04             	add    $0x4,%eax
  60:	8b 00                	mov    (%eax),%eax
  62:	52                   	push   %edx
  63:	50                   	push   %eax
  64:	68 38 0f 00 00       	push   $0xf38
  69:	6a 02                	push   $0x2
  6b:	e8 9a 05 00 00       	call   60a <printf>
  70:	83 c4 10             	add    $0x10,%esp
  exit();
  73:	e8 c6 03 00 00       	call   43e <exit>

00000078 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  78:	55                   	push   %ebp
  79:	89 e5                	mov    %esp,%ebp
  7b:	57                   	push   %edi
  7c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  7d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80:	8b 55 10             	mov    0x10(%ebp),%edx
  83:	8b 45 0c             	mov    0xc(%ebp),%eax
  86:	89 cb                	mov    %ecx,%ebx
  88:	89 df                	mov    %ebx,%edi
  8a:	89 d1                	mov    %edx,%ecx
  8c:	fc                   	cld    
  8d:	f3 aa                	rep stos %al,%es:(%edi)
  8f:	89 ca                	mov    %ecx,%edx
  91:	89 fb                	mov    %edi,%ebx
  93:	89 5d 08             	mov    %ebx,0x8(%ebp)
  96:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  99:	90                   	nop
  9a:	5b                   	pop    %ebx
  9b:	5f                   	pop    %edi
  9c:	5d                   	pop    %ebp
  9d:	c3                   	ret    

0000009e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  9e:	f3 0f 1e fb          	endbr32 
  a2:	55                   	push   %ebp
  a3:	89 e5                	mov    %esp,%ebp
  a5:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a8:	8b 45 08             	mov    0x8(%ebp),%eax
  ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  ae:	90                   	nop
  af:	8b 55 0c             	mov    0xc(%ebp),%edx
  b2:	8d 42 01             	lea    0x1(%edx),%eax
  b5:	89 45 0c             	mov    %eax,0xc(%ebp)
  b8:	8b 45 08             	mov    0x8(%ebp),%eax
  bb:	8d 48 01             	lea    0x1(%eax),%ecx
  be:	89 4d 08             	mov    %ecx,0x8(%ebp)
  c1:	0f b6 12             	movzbl (%edx),%edx
  c4:	88 10                	mov    %dl,(%eax)
  c6:	0f b6 00             	movzbl (%eax),%eax
  c9:	84 c0                	test   %al,%al
  cb:	75 e2                	jne    af <strcpy+0x11>
    ;
  return os;
  cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d0:	c9                   	leave  
  d1:	c3                   	ret    

000000d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d2:	f3 0f 1e fb          	endbr32 
  d6:	55                   	push   %ebp
  d7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  d9:	eb 08                	jmp    e3 <strcmp+0x11>
    p++, q++;
  db:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  df:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	0f b6 00             	movzbl (%eax),%eax
  e9:	84 c0                	test   %al,%al
  eb:	74 10                	je     fd <strcmp+0x2b>
  ed:	8b 45 08             	mov    0x8(%ebp),%eax
  f0:	0f b6 10             	movzbl (%eax),%edx
  f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  f6:	0f b6 00             	movzbl (%eax),%eax
  f9:	38 c2                	cmp    %al,%dl
  fb:	74 de                	je     db <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
 100:	0f b6 00             	movzbl (%eax),%eax
 103:	0f b6 d0             	movzbl %al,%edx
 106:	8b 45 0c             	mov    0xc(%ebp),%eax
 109:	0f b6 00             	movzbl (%eax),%eax
 10c:	0f b6 c0             	movzbl %al,%eax
 10f:	29 c2                	sub    %eax,%edx
 111:	89 d0                	mov    %edx,%eax
}
 113:	5d                   	pop    %ebp
 114:	c3                   	ret    

00000115 <strlen>:

uint
strlen(char *s)
{
 115:	f3 0f 1e fb          	endbr32 
 119:	55                   	push   %ebp
 11a:	89 e5                	mov    %esp,%ebp
 11c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 11f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 126:	eb 04                	jmp    12c <strlen+0x17>
 128:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 12c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 12f:	8b 45 08             	mov    0x8(%ebp),%eax
 132:	01 d0                	add    %edx,%eax
 134:	0f b6 00             	movzbl (%eax),%eax
 137:	84 c0                	test   %al,%al
 139:	75 ed                	jne    128 <strlen+0x13>
    ;
  return n;
 13b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 13e:	c9                   	leave  
 13f:	c3                   	ret    

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 147:	8b 45 10             	mov    0x10(%ebp),%eax
 14a:	50                   	push   %eax
 14b:	ff 75 0c             	pushl  0xc(%ebp)
 14e:	ff 75 08             	pushl  0x8(%ebp)
 151:	e8 22 ff ff ff       	call   78 <stosb>
 156:	83 c4 0c             	add    $0xc,%esp
  return dst;
 159:	8b 45 08             	mov    0x8(%ebp),%eax
}
 15c:	c9                   	leave  
 15d:	c3                   	ret    

0000015e <strchr>:

char*
strchr(const char *s, char c)
{
 15e:	f3 0f 1e fb          	endbr32 
 162:	55                   	push   %ebp
 163:	89 e5                	mov    %esp,%ebp
 165:	83 ec 04             	sub    $0x4,%esp
 168:	8b 45 0c             	mov    0xc(%ebp),%eax
 16b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 16e:	eb 14                	jmp    184 <strchr+0x26>
    if(*s == c)
 170:	8b 45 08             	mov    0x8(%ebp),%eax
 173:	0f b6 00             	movzbl (%eax),%eax
 176:	38 45 fc             	cmp    %al,-0x4(%ebp)
 179:	75 05                	jne    180 <strchr+0x22>
      return (char*)s;
 17b:	8b 45 08             	mov    0x8(%ebp),%eax
 17e:	eb 13                	jmp    193 <strchr+0x35>
  for(; *s; s++)
 180:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	0f b6 00             	movzbl (%eax),%eax
 18a:	84 c0                	test   %al,%al
 18c:	75 e2                	jne    170 <strchr+0x12>
  return 0;
 18e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 193:	c9                   	leave  
 194:	c3                   	ret    

00000195 <gets>:

char*
gets(char *buf, int max)
{
 195:	f3 0f 1e fb          	endbr32 
 199:	55                   	push   %ebp
 19a:	89 e5                	mov    %esp,%ebp
 19c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a6:	eb 42                	jmp    1ea <gets+0x55>
    cc = read(0, &c, 1);
 1a8:	83 ec 04             	sub    $0x4,%esp
 1ab:	6a 01                	push   $0x1
 1ad:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 9e 02 00 00       	call   456 <read>
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c2:	7e 33                	jle    1f7 <gets+0x62>
      break;
    buf[i++] = c;
 1c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c7:	8d 50 01             	lea    0x1(%eax),%edx
 1ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1cd:	89 c2                	mov    %eax,%edx
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	01 c2                	add    %eax,%edx
 1d4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1da:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1de:	3c 0a                	cmp    $0xa,%al
 1e0:	74 16                	je     1f8 <gets+0x63>
 1e2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e6:	3c 0d                	cmp    $0xd,%al
 1e8:	74 0e                	je     1f8 <gets+0x63>
  for(i=0; i+1 < max; ){
 1ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ed:	83 c0 01             	add    $0x1,%eax
 1f0:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1f3:	7f b3                	jg     1a8 <gets+0x13>
 1f5:	eb 01                	jmp    1f8 <gets+0x63>
      break;
 1f7:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	01 d0                	add    %edx,%eax
 200:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 203:	8b 45 08             	mov    0x8(%ebp),%eax
}
 206:	c9                   	leave  
 207:	c3                   	ret    

00000208 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
 208:	f3 0f 1e fb          	endbr32 
 20c:	55                   	push   %ebp
 20d:	89 e5                	mov    %esp,%ebp
 20f:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
 212:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 219:	eb 43                	jmp    25e <fgets+0x56>
    int cc = read(fd, &c, 1);
 21b:	83 ec 04             	sub    $0x4,%esp
 21e:	6a 01                	push   $0x1
 220:	8d 45 ef             	lea    -0x11(%ebp),%eax
 223:	50                   	push   %eax
 224:	ff 75 10             	pushl  0x10(%ebp)
 227:	e8 2a 02 00 00       	call   456 <read>
 22c:	83 c4 10             	add    $0x10,%esp
 22f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 232:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 236:	7e 33                	jle    26b <fgets+0x63>
      break;
    buf[i++] = c;
 238:	8b 45 f4             	mov    -0xc(%ebp),%eax
 23b:	8d 50 01             	lea    0x1(%eax),%edx
 23e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 241:	89 c2                	mov    %eax,%edx
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	01 c2                	add    %eax,%edx
 248:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 24c:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 24e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 252:	3c 0a                	cmp    $0xa,%al
 254:	74 16                	je     26c <fgets+0x64>
 256:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25a:	3c 0d                	cmp    $0xd,%al
 25c:	74 0e                	je     26c <fgets+0x64>
  for(i = 0; i + 1 < size;){
 25e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 261:	83 c0 01             	add    $0x1,%eax
 264:	39 45 0c             	cmp    %eax,0xc(%ebp)
 267:	7f b2                	jg     21b <fgets+0x13>
 269:	eb 01                	jmp    26c <fgets+0x64>
      break;
 26b:	90                   	nop
      break;
  }
  buf[i] = '\0';
 26c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 26f:	8b 45 08             	mov    0x8(%ebp),%eax
 272:	01 d0                	add    %edx,%eax
 274:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 277:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27a:	c9                   	leave  
 27b:	c3                   	ret    

0000027c <stat>:

int
stat(char *n, struct stat *st)
{
 27c:	f3 0f 1e fb          	endbr32 
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 286:	83 ec 08             	sub    $0x8,%esp
 289:	6a 00                	push   $0x0
 28b:	ff 75 08             	pushl  0x8(%ebp)
 28e:	e8 eb 01 00 00       	call   47e <open>
 293:	83 c4 10             	add    $0x10,%esp
 296:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 299:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 29d:	79 07                	jns    2a6 <stat+0x2a>
    return -1;
 29f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a4:	eb 25                	jmp    2cb <stat+0x4f>
  r = fstat(fd, st);
 2a6:	83 ec 08             	sub    $0x8,%esp
 2a9:	ff 75 0c             	pushl  0xc(%ebp)
 2ac:	ff 75 f4             	pushl  -0xc(%ebp)
 2af:	e8 e2 01 00 00       	call   496 <fstat>
 2b4:	83 c4 10             	add    $0x10,%esp
 2b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2ba:	83 ec 0c             	sub    $0xc,%esp
 2bd:	ff 75 f4             	pushl  -0xc(%ebp)
 2c0:	e8 a1 01 00 00       	call   466 <close>
 2c5:	83 c4 10             	add    $0x10,%esp
  return r;
 2c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2cb:	c9                   	leave  
 2cc:	c3                   	ret    

000002cd <atoi>:

int
atoi(const char *s)
{
 2cd:	f3 0f 1e fb          	endbr32 
 2d1:	55                   	push   %ebp
 2d2:	89 e5                	mov    %esp,%ebp
 2d4:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 2d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 2de:	eb 04                	jmp    2e4 <atoi+0x17>
 2e0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2e4:	8b 45 08             	mov    0x8(%ebp),%eax
 2e7:	0f b6 00             	movzbl (%eax),%eax
 2ea:	3c 20                	cmp    $0x20,%al
 2ec:	74 f2                	je     2e0 <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
 2ee:	8b 45 08             	mov    0x8(%ebp),%eax
 2f1:	0f b6 00             	movzbl (%eax),%eax
 2f4:	3c 2d                	cmp    $0x2d,%al
 2f6:	75 07                	jne    2ff <atoi+0x32>
 2f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2fd:	eb 05                	jmp    304 <atoi+0x37>
 2ff:	b8 01 00 00 00       	mov    $0x1,%eax
 304:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 307:	8b 45 08             	mov    0x8(%ebp),%eax
 30a:	0f b6 00             	movzbl (%eax),%eax
 30d:	3c 2b                	cmp    $0x2b,%al
 30f:	74 0a                	je     31b <atoi+0x4e>
 311:	8b 45 08             	mov    0x8(%ebp),%eax
 314:	0f b6 00             	movzbl (%eax),%eax
 317:	3c 2d                	cmp    $0x2d,%al
 319:	75 2b                	jne    346 <atoi+0x79>
    s++;
 31b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 31f:	eb 25                	jmp    346 <atoi+0x79>
    n = n*10 + *s++ - '0';
 321:	8b 55 fc             	mov    -0x4(%ebp),%edx
 324:	89 d0                	mov    %edx,%eax
 326:	c1 e0 02             	shl    $0x2,%eax
 329:	01 d0                	add    %edx,%eax
 32b:	01 c0                	add    %eax,%eax
 32d:	89 c1                	mov    %eax,%ecx
 32f:	8b 45 08             	mov    0x8(%ebp),%eax
 332:	8d 50 01             	lea    0x1(%eax),%edx
 335:	89 55 08             	mov    %edx,0x8(%ebp)
 338:	0f b6 00             	movzbl (%eax),%eax
 33b:	0f be c0             	movsbl %al,%eax
 33e:	01 c8                	add    %ecx,%eax
 340:	83 e8 30             	sub    $0x30,%eax
 343:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 346:	8b 45 08             	mov    0x8(%ebp),%eax
 349:	0f b6 00             	movzbl (%eax),%eax
 34c:	3c 2f                	cmp    $0x2f,%al
 34e:	7e 0a                	jle    35a <atoi+0x8d>
 350:	8b 45 08             	mov    0x8(%ebp),%eax
 353:	0f b6 00             	movzbl (%eax),%eax
 356:	3c 39                	cmp    $0x39,%al
 358:	7e c7                	jle    321 <atoi+0x54>
  return sign*n;
 35a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 35d:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 361:	c9                   	leave  
 362:	c3                   	ret    

00000363 <atoo>:

int
atoo(const char *s)
{
 363:	f3 0f 1e fb          	endbr32 
 367:	55                   	push   %ebp
 368:	89 e5                	mov    %esp,%ebp
 36a:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 36d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 374:	eb 04                	jmp    37a <atoo+0x17>
 376:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 37a:	8b 45 08             	mov    0x8(%ebp),%eax
 37d:	0f b6 00             	movzbl (%eax),%eax
 380:	3c 20                	cmp    $0x20,%al
 382:	74 f2                	je     376 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
 384:	8b 45 08             	mov    0x8(%ebp),%eax
 387:	0f b6 00             	movzbl (%eax),%eax
 38a:	3c 2d                	cmp    $0x2d,%al
 38c:	75 07                	jne    395 <atoo+0x32>
 38e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 393:	eb 05                	jmp    39a <atoo+0x37>
 395:	b8 01 00 00 00       	mov    $0x1,%eax
 39a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 39d:	8b 45 08             	mov    0x8(%ebp),%eax
 3a0:	0f b6 00             	movzbl (%eax),%eax
 3a3:	3c 2b                	cmp    $0x2b,%al
 3a5:	74 0a                	je     3b1 <atoo+0x4e>
 3a7:	8b 45 08             	mov    0x8(%ebp),%eax
 3aa:	0f b6 00             	movzbl (%eax),%eax
 3ad:	3c 2d                	cmp    $0x2d,%al
 3af:	75 27                	jne    3d8 <atoo+0x75>
    s++;
 3b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 3b5:	eb 21                	jmp    3d8 <atoo+0x75>
    n = n*8 + *s++ - '0';
 3b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ba:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 3c1:	8b 45 08             	mov    0x8(%ebp),%eax
 3c4:	8d 50 01             	lea    0x1(%eax),%edx
 3c7:	89 55 08             	mov    %edx,0x8(%ebp)
 3ca:	0f b6 00             	movzbl (%eax),%eax
 3cd:	0f be c0             	movsbl %al,%eax
 3d0:	01 c8                	add    %ecx,%eax
 3d2:	83 e8 30             	sub    $0x30,%eax
 3d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
 3d8:	8b 45 08             	mov    0x8(%ebp),%eax
 3db:	0f b6 00             	movzbl (%eax),%eax
 3de:	3c 2f                	cmp    $0x2f,%al
 3e0:	7e 0a                	jle    3ec <atoo+0x89>
 3e2:	8b 45 08             	mov    0x8(%ebp),%eax
 3e5:	0f b6 00             	movzbl (%eax),%eax
 3e8:	3c 37                	cmp    $0x37,%al
 3ea:	7e cb                	jle    3b7 <atoo+0x54>
  return sign*n;
 3ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3ef:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 3f3:	c9                   	leave  
 3f4:	c3                   	ret    

000003f5 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 3f5:	f3 0f 1e fb          	endbr32 
 3f9:	55                   	push   %ebp
 3fa:	89 e5                	mov    %esp,%ebp
 3fc:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3ff:	8b 45 08             	mov    0x8(%ebp),%eax
 402:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 405:	8b 45 0c             	mov    0xc(%ebp),%eax
 408:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 40b:	eb 17                	jmp    424 <memmove+0x2f>
    *dst++ = *src++;
 40d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 410:	8d 42 01             	lea    0x1(%edx),%eax
 413:	89 45 f8             	mov    %eax,-0x8(%ebp)
 416:	8b 45 fc             	mov    -0x4(%ebp),%eax
 419:	8d 48 01             	lea    0x1(%eax),%ecx
 41c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 41f:	0f b6 12             	movzbl (%edx),%edx
 422:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 424:	8b 45 10             	mov    0x10(%ebp),%eax
 427:	8d 50 ff             	lea    -0x1(%eax),%edx
 42a:	89 55 10             	mov    %edx,0x10(%ebp)
 42d:	85 c0                	test   %eax,%eax
 42f:	7f dc                	jg     40d <memmove+0x18>
  return vdst;
 431:	8b 45 08             	mov    0x8(%ebp),%eax
}
 434:	c9                   	leave  
 435:	c3                   	ret    

00000436 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 436:	b8 01 00 00 00       	mov    $0x1,%eax
 43b:	cd 40                	int    $0x40
 43d:	c3                   	ret    

0000043e <exit>:
SYSCALL(exit)
 43e:	b8 02 00 00 00       	mov    $0x2,%eax
 443:	cd 40                	int    $0x40
 445:	c3                   	ret    

00000446 <wait>:
SYSCALL(wait)
 446:	b8 03 00 00 00       	mov    $0x3,%eax
 44b:	cd 40                	int    $0x40
 44d:	c3                   	ret    

0000044e <pipe>:
SYSCALL(pipe)
 44e:	b8 04 00 00 00       	mov    $0x4,%eax
 453:	cd 40                	int    $0x40
 455:	c3                   	ret    

00000456 <read>:
SYSCALL(read)
 456:	b8 05 00 00 00       	mov    $0x5,%eax
 45b:	cd 40                	int    $0x40
 45d:	c3                   	ret    

0000045e <write>:
SYSCALL(write)
 45e:	b8 10 00 00 00       	mov    $0x10,%eax
 463:	cd 40                	int    $0x40
 465:	c3                   	ret    

00000466 <close>:
SYSCALL(close)
 466:	b8 15 00 00 00       	mov    $0x15,%eax
 46b:	cd 40                	int    $0x40
 46d:	c3                   	ret    

0000046e <kill>:
SYSCALL(kill)
 46e:	b8 06 00 00 00       	mov    $0x6,%eax
 473:	cd 40                	int    $0x40
 475:	c3                   	ret    

00000476 <exec>:
SYSCALL(exec)
 476:	b8 07 00 00 00       	mov    $0x7,%eax
 47b:	cd 40                	int    $0x40
 47d:	c3                   	ret    

0000047e <open>:
SYSCALL(open)
 47e:	b8 0f 00 00 00       	mov    $0xf,%eax
 483:	cd 40                	int    $0x40
 485:	c3                   	ret    

00000486 <mknod>:
SYSCALL(mknod)
 486:	b8 11 00 00 00       	mov    $0x11,%eax
 48b:	cd 40                	int    $0x40
 48d:	c3                   	ret    

0000048e <unlink>:
SYSCALL(unlink)
 48e:	b8 12 00 00 00       	mov    $0x12,%eax
 493:	cd 40                	int    $0x40
 495:	c3                   	ret    

00000496 <fstat>:
SYSCALL(fstat)
 496:	b8 08 00 00 00       	mov    $0x8,%eax
 49b:	cd 40                	int    $0x40
 49d:	c3                   	ret    

0000049e <link>:
SYSCALL(link)
 49e:	b8 13 00 00 00       	mov    $0x13,%eax
 4a3:	cd 40                	int    $0x40
 4a5:	c3                   	ret    

000004a6 <mkdir>:
SYSCALL(mkdir)
 4a6:	b8 14 00 00 00       	mov    $0x14,%eax
 4ab:	cd 40                	int    $0x40
 4ad:	c3                   	ret    

000004ae <chdir>:
SYSCALL(chdir)
 4ae:	b8 09 00 00 00       	mov    $0x9,%eax
 4b3:	cd 40                	int    $0x40
 4b5:	c3                   	ret    

000004b6 <dup>:
SYSCALL(dup)
 4b6:	b8 0a 00 00 00       	mov    $0xa,%eax
 4bb:	cd 40                	int    $0x40
 4bd:	c3                   	ret    

000004be <getpid>:
SYSCALL(getpid)
 4be:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c3:	cd 40                	int    $0x40
 4c5:	c3                   	ret    

000004c6 <sbrk>:
SYSCALL(sbrk)
 4c6:	b8 0c 00 00 00       	mov    $0xc,%eax
 4cb:	cd 40                	int    $0x40
 4cd:	c3                   	ret    

000004ce <sleep>:
SYSCALL(sleep)
 4ce:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d3:	cd 40                	int    $0x40
 4d5:	c3                   	ret    

000004d6 <uptime>:
SYSCALL(uptime)
 4d6:	b8 0e 00 00 00       	mov    $0xe,%eax
 4db:	cd 40                	int    $0x40
 4dd:	c3                   	ret    

000004de <halt>:
SYSCALL(halt)
 4de:	b8 16 00 00 00       	mov    $0x16,%eax
 4e3:	cd 40                	int    $0x40
 4e5:	c3                   	ret    

000004e6 <date>:
SYSCALL(date)
 4e6:	b8 17 00 00 00       	mov    $0x17,%eax
 4eb:	cd 40                	int    $0x40
 4ed:	c3                   	ret    

000004ee <getuid>:
SYSCALL(getuid)
 4ee:	b8 18 00 00 00       	mov    $0x18,%eax
 4f3:	cd 40                	int    $0x40
 4f5:	c3                   	ret    

000004f6 <getgid>:
SYSCALL(getgid)
 4f6:	b8 19 00 00 00       	mov    $0x19,%eax
 4fb:	cd 40                	int    $0x40
 4fd:	c3                   	ret    

000004fe <getppid>:
SYSCALL(getppid)
 4fe:	b8 1a 00 00 00       	mov    $0x1a,%eax
 503:	cd 40                	int    $0x40
 505:	c3                   	ret    

00000506 <setuid>:
SYSCALL(setuid)
 506:	b8 1b 00 00 00       	mov    $0x1b,%eax
 50b:	cd 40                	int    $0x40
 50d:	c3                   	ret    

0000050e <setgid>:
SYSCALL(setgid)
 50e:	b8 1c 00 00 00       	mov    $0x1c,%eax
 513:	cd 40                	int    $0x40
 515:	c3                   	ret    

00000516 <getprocs>:
SYSCALL(getprocs)
 516:	b8 1d 00 00 00       	mov    $0x1d,%eax
 51b:	cd 40                	int    $0x40
 51d:	c3                   	ret    

0000051e <setpriority>:
SYSCALL(setpriority)
 51e:	b8 1e 00 00 00       	mov    $0x1e,%eax
 523:	cd 40                	int    $0x40
 525:	c3                   	ret    

00000526 <chown>:
SYSCALL(chown)
 526:	b8 1f 00 00 00       	mov    $0x1f,%eax
 52b:	cd 40                	int    $0x40
 52d:	c3                   	ret    

0000052e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 52e:	f3 0f 1e fb          	endbr32 
 532:	55                   	push   %ebp
 533:	89 e5                	mov    %esp,%ebp
 535:	83 ec 18             	sub    $0x18,%esp
 538:	8b 45 0c             	mov    0xc(%ebp),%eax
 53b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 53e:	83 ec 04             	sub    $0x4,%esp
 541:	6a 01                	push   $0x1
 543:	8d 45 f4             	lea    -0xc(%ebp),%eax
 546:	50                   	push   %eax
 547:	ff 75 08             	pushl  0x8(%ebp)
 54a:	e8 0f ff ff ff       	call   45e <write>
 54f:	83 c4 10             	add    $0x10,%esp
}
 552:	90                   	nop
 553:	c9                   	leave  
 554:	c3                   	ret    

00000555 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 555:	f3 0f 1e fb          	endbr32 
 559:	55                   	push   %ebp
 55a:	89 e5                	mov    %esp,%ebp
 55c:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 55f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 566:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 56a:	74 17                	je     583 <printint+0x2e>
 56c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 570:	79 11                	jns    583 <printint+0x2e>
    neg = 1;
 572:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 579:	8b 45 0c             	mov    0xc(%ebp),%eax
 57c:	f7 d8                	neg    %eax
 57e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 581:	eb 06                	jmp    589 <printint+0x34>
  } else {
    x = xx;
 583:	8b 45 0c             	mov    0xc(%ebp),%eax
 586:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 589:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 590:	8b 4d 10             	mov    0x10(%ebp),%ecx
 593:	8b 45 ec             	mov    -0x14(%ebp),%eax
 596:	ba 00 00 00 00       	mov    $0x0,%edx
 59b:	f7 f1                	div    %ecx
 59d:	89 d1                	mov    %edx,%ecx
 59f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a2:	8d 50 01             	lea    0x1(%eax),%edx
 5a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5a8:	0f b6 91 80 13 00 00 	movzbl 0x1380(%ecx),%edx
 5af:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 5b3:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5b9:	ba 00 00 00 00       	mov    $0x0,%edx
 5be:	f7 f1                	div    %ecx
 5c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5c7:	75 c7                	jne    590 <printint+0x3b>
  if(neg)
 5c9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5cd:	74 2d                	je     5fc <printint+0xa7>
    buf[i++] = '-';
 5cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d2:	8d 50 01             	lea    0x1(%eax),%edx
 5d5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5d8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5dd:	eb 1d                	jmp    5fc <printint+0xa7>
    putc(fd, buf[i]);
 5df:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e5:	01 d0                	add    %edx,%eax
 5e7:	0f b6 00             	movzbl (%eax),%eax
 5ea:	0f be c0             	movsbl %al,%eax
 5ed:	83 ec 08             	sub    $0x8,%esp
 5f0:	50                   	push   %eax
 5f1:	ff 75 08             	pushl  0x8(%ebp)
 5f4:	e8 35 ff ff ff       	call   52e <putc>
 5f9:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5fc:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 600:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 604:	79 d9                	jns    5df <printint+0x8a>
}
 606:	90                   	nop
 607:	90                   	nop
 608:	c9                   	leave  
 609:	c3                   	ret    

0000060a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 60a:	f3 0f 1e fb          	endbr32 
 60e:	55                   	push   %ebp
 60f:	89 e5                	mov    %esp,%ebp
 611:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 614:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 61b:	8d 45 0c             	lea    0xc(%ebp),%eax
 61e:	83 c0 04             	add    $0x4,%eax
 621:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 624:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 62b:	e9 59 01 00 00       	jmp    789 <printf+0x17f>
    c = fmt[i] & 0xff;
 630:	8b 55 0c             	mov    0xc(%ebp),%edx
 633:	8b 45 f0             	mov    -0x10(%ebp),%eax
 636:	01 d0                	add    %edx,%eax
 638:	0f b6 00             	movzbl (%eax),%eax
 63b:	0f be c0             	movsbl %al,%eax
 63e:	25 ff 00 00 00       	and    $0xff,%eax
 643:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 646:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 64a:	75 2c                	jne    678 <printf+0x6e>
      if(c == '%'){
 64c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 650:	75 0c                	jne    65e <printf+0x54>
        state = '%';
 652:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 659:	e9 27 01 00 00       	jmp    785 <printf+0x17b>
      } else {
        putc(fd, c);
 65e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 661:	0f be c0             	movsbl %al,%eax
 664:	83 ec 08             	sub    $0x8,%esp
 667:	50                   	push   %eax
 668:	ff 75 08             	pushl  0x8(%ebp)
 66b:	e8 be fe ff ff       	call   52e <putc>
 670:	83 c4 10             	add    $0x10,%esp
 673:	e9 0d 01 00 00       	jmp    785 <printf+0x17b>
      }
    } else if(state == '%'){
 678:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 67c:	0f 85 03 01 00 00    	jne    785 <printf+0x17b>
      if(c == 'd'){
 682:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 686:	75 1e                	jne    6a6 <printf+0x9c>
        printint(fd, *ap, 10, 1);
 688:	8b 45 e8             	mov    -0x18(%ebp),%eax
 68b:	8b 00                	mov    (%eax),%eax
 68d:	6a 01                	push   $0x1
 68f:	6a 0a                	push   $0xa
 691:	50                   	push   %eax
 692:	ff 75 08             	pushl  0x8(%ebp)
 695:	e8 bb fe ff ff       	call   555 <printint>
 69a:	83 c4 10             	add    $0x10,%esp
        ap++;
 69d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6a1:	e9 d8 00 00 00       	jmp    77e <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 6a6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6aa:	74 06                	je     6b2 <printf+0xa8>
 6ac:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6b0:	75 1e                	jne    6d0 <printf+0xc6>
        printint(fd, *ap, 16, 0);
 6b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6b5:	8b 00                	mov    (%eax),%eax
 6b7:	6a 00                	push   $0x0
 6b9:	6a 10                	push   $0x10
 6bb:	50                   	push   %eax
 6bc:	ff 75 08             	pushl  0x8(%ebp)
 6bf:	e8 91 fe ff ff       	call   555 <printint>
 6c4:	83 c4 10             	add    $0x10,%esp
        ap++;
 6c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6cb:	e9 ae 00 00 00       	jmp    77e <printf+0x174>
      } else if(c == 's'){
 6d0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6d4:	75 43                	jne    719 <printf+0x10f>
        s = (char*)*ap;
 6d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6d9:	8b 00                	mov    (%eax),%eax
 6db:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6de:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6e6:	75 25                	jne    70d <printf+0x103>
          s = "(null)";
 6e8:	c7 45 f4 4c 0f 00 00 	movl   $0xf4c,-0xc(%ebp)
        while(*s != 0){
 6ef:	eb 1c                	jmp    70d <printf+0x103>
          putc(fd, *s);
 6f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f4:	0f b6 00             	movzbl (%eax),%eax
 6f7:	0f be c0             	movsbl %al,%eax
 6fa:	83 ec 08             	sub    $0x8,%esp
 6fd:	50                   	push   %eax
 6fe:	ff 75 08             	pushl  0x8(%ebp)
 701:	e8 28 fe ff ff       	call   52e <putc>
 706:	83 c4 10             	add    $0x10,%esp
          s++;
 709:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 70d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 710:	0f b6 00             	movzbl (%eax),%eax
 713:	84 c0                	test   %al,%al
 715:	75 da                	jne    6f1 <printf+0xe7>
 717:	eb 65                	jmp    77e <printf+0x174>
        }
      } else if(c == 'c'){
 719:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 71d:	75 1d                	jne    73c <printf+0x132>
        putc(fd, *ap);
 71f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 722:	8b 00                	mov    (%eax),%eax
 724:	0f be c0             	movsbl %al,%eax
 727:	83 ec 08             	sub    $0x8,%esp
 72a:	50                   	push   %eax
 72b:	ff 75 08             	pushl  0x8(%ebp)
 72e:	e8 fb fd ff ff       	call   52e <putc>
 733:	83 c4 10             	add    $0x10,%esp
        ap++;
 736:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 73a:	eb 42                	jmp    77e <printf+0x174>
      } else if(c == '%'){
 73c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 740:	75 17                	jne    759 <printf+0x14f>
        putc(fd, c);
 742:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 745:	0f be c0             	movsbl %al,%eax
 748:	83 ec 08             	sub    $0x8,%esp
 74b:	50                   	push   %eax
 74c:	ff 75 08             	pushl  0x8(%ebp)
 74f:	e8 da fd ff ff       	call   52e <putc>
 754:	83 c4 10             	add    $0x10,%esp
 757:	eb 25                	jmp    77e <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 759:	83 ec 08             	sub    $0x8,%esp
 75c:	6a 25                	push   $0x25
 75e:	ff 75 08             	pushl  0x8(%ebp)
 761:	e8 c8 fd ff ff       	call   52e <putc>
 766:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 769:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 76c:	0f be c0             	movsbl %al,%eax
 76f:	83 ec 08             	sub    $0x8,%esp
 772:	50                   	push   %eax
 773:	ff 75 08             	pushl  0x8(%ebp)
 776:	e8 b3 fd ff ff       	call   52e <putc>
 77b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 77e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 785:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 789:	8b 55 0c             	mov    0xc(%ebp),%edx
 78c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78f:	01 d0                	add    %edx,%eax
 791:	0f b6 00             	movzbl (%eax),%eax
 794:	84 c0                	test   %al,%al
 796:	0f 85 94 fe ff ff    	jne    630 <printf+0x26>
    }
  }
}
 79c:	90                   	nop
 79d:	90                   	nop
 79e:	c9                   	leave  
 79f:	c3                   	ret    

000007a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a0:	f3 0f 1e fb          	endbr32 
 7a4:	55                   	push   %ebp
 7a5:	89 e5                	mov    %esp,%ebp
 7a7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7aa:	8b 45 08             	mov    0x8(%ebp),%eax
 7ad:	83 e8 08             	sub    $0x8,%eax
 7b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b3:	a1 a8 13 00 00       	mov    0x13a8,%eax
 7b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7bb:	eb 24                	jmp    7e1 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c0:	8b 00                	mov    (%eax),%eax
 7c2:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 7c5:	72 12                	jb     7d9 <free+0x39>
 7c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7cd:	77 24                	ja     7f3 <free+0x53>
 7cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d2:	8b 00                	mov    (%eax),%eax
 7d4:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7d7:	72 1a                	jb     7f3 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dc:	8b 00                	mov    (%eax),%eax
 7de:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7e7:	76 d4                	jbe    7bd <free+0x1d>
 7e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ec:	8b 00                	mov    (%eax),%eax
 7ee:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7f1:	73 ca                	jae    7bd <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f6:	8b 40 04             	mov    0x4(%eax),%eax
 7f9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 800:	8b 45 f8             	mov    -0x8(%ebp),%eax
 803:	01 c2                	add    %eax,%edx
 805:	8b 45 fc             	mov    -0x4(%ebp),%eax
 808:	8b 00                	mov    (%eax),%eax
 80a:	39 c2                	cmp    %eax,%edx
 80c:	75 24                	jne    832 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 80e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 811:	8b 50 04             	mov    0x4(%eax),%edx
 814:	8b 45 fc             	mov    -0x4(%ebp),%eax
 817:	8b 00                	mov    (%eax),%eax
 819:	8b 40 04             	mov    0x4(%eax),%eax
 81c:	01 c2                	add    %eax,%edx
 81e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 821:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 824:	8b 45 fc             	mov    -0x4(%ebp),%eax
 827:	8b 00                	mov    (%eax),%eax
 829:	8b 10                	mov    (%eax),%edx
 82b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82e:	89 10                	mov    %edx,(%eax)
 830:	eb 0a                	jmp    83c <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 832:	8b 45 fc             	mov    -0x4(%ebp),%eax
 835:	8b 10                	mov    (%eax),%edx
 837:	8b 45 f8             	mov    -0x8(%ebp),%eax
 83a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 83c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83f:	8b 40 04             	mov    0x4(%eax),%eax
 842:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 849:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84c:	01 d0                	add    %edx,%eax
 84e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 851:	75 20                	jne    873 <free+0xd3>
    p->s.size += bp->s.size;
 853:	8b 45 fc             	mov    -0x4(%ebp),%eax
 856:	8b 50 04             	mov    0x4(%eax),%edx
 859:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85c:	8b 40 04             	mov    0x4(%eax),%eax
 85f:	01 c2                	add    %eax,%edx
 861:	8b 45 fc             	mov    -0x4(%ebp),%eax
 864:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 867:	8b 45 f8             	mov    -0x8(%ebp),%eax
 86a:	8b 10                	mov    (%eax),%edx
 86c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86f:	89 10                	mov    %edx,(%eax)
 871:	eb 08                	jmp    87b <free+0xdb>
  } else
    p->s.ptr = bp;
 873:	8b 45 fc             	mov    -0x4(%ebp),%eax
 876:	8b 55 f8             	mov    -0x8(%ebp),%edx
 879:	89 10                	mov    %edx,(%eax)
  freep = p;
 87b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87e:	a3 a8 13 00 00       	mov    %eax,0x13a8
}
 883:	90                   	nop
 884:	c9                   	leave  
 885:	c3                   	ret    

00000886 <morecore>:

static Header*
morecore(uint nu)
{
 886:	f3 0f 1e fb          	endbr32 
 88a:	55                   	push   %ebp
 88b:	89 e5                	mov    %esp,%ebp
 88d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 890:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 897:	77 07                	ja     8a0 <morecore+0x1a>
    nu = 4096;
 899:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 8a0:	8b 45 08             	mov    0x8(%ebp),%eax
 8a3:	c1 e0 03             	shl    $0x3,%eax
 8a6:	83 ec 0c             	sub    $0xc,%esp
 8a9:	50                   	push   %eax
 8aa:	e8 17 fc ff ff       	call   4c6 <sbrk>
 8af:	83 c4 10             	add    $0x10,%esp
 8b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8b5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8b9:	75 07                	jne    8c2 <morecore+0x3c>
    return 0;
 8bb:	b8 00 00 00 00       	mov    $0x0,%eax
 8c0:	eb 26                	jmp    8e8 <morecore+0x62>
  hp = (Header*)p;
 8c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8cb:	8b 55 08             	mov    0x8(%ebp),%edx
 8ce:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d4:	83 c0 08             	add    $0x8,%eax
 8d7:	83 ec 0c             	sub    $0xc,%esp
 8da:	50                   	push   %eax
 8db:	e8 c0 fe ff ff       	call   7a0 <free>
 8e0:	83 c4 10             	add    $0x10,%esp
  return freep;
 8e3:	a1 a8 13 00 00       	mov    0x13a8,%eax
}
 8e8:	c9                   	leave  
 8e9:	c3                   	ret    

000008ea <malloc>:

void*
malloc(uint nbytes)
{
 8ea:	f3 0f 1e fb          	endbr32 
 8ee:	55                   	push   %ebp
 8ef:	89 e5                	mov    %esp,%ebp
 8f1:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f4:	8b 45 08             	mov    0x8(%ebp),%eax
 8f7:	83 c0 07             	add    $0x7,%eax
 8fa:	c1 e8 03             	shr    $0x3,%eax
 8fd:	83 c0 01             	add    $0x1,%eax
 900:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 903:	a1 a8 13 00 00       	mov    0x13a8,%eax
 908:	89 45 f0             	mov    %eax,-0x10(%ebp)
 90b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 90f:	75 23                	jne    934 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 911:	c7 45 f0 a0 13 00 00 	movl   $0x13a0,-0x10(%ebp)
 918:	8b 45 f0             	mov    -0x10(%ebp),%eax
 91b:	a3 a8 13 00 00       	mov    %eax,0x13a8
 920:	a1 a8 13 00 00       	mov    0x13a8,%eax
 925:	a3 a0 13 00 00       	mov    %eax,0x13a0
    base.s.size = 0;
 92a:	c7 05 a4 13 00 00 00 	movl   $0x0,0x13a4
 931:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 934:	8b 45 f0             	mov    -0x10(%ebp),%eax
 937:	8b 00                	mov    (%eax),%eax
 939:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 93c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93f:	8b 40 04             	mov    0x4(%eax),%eax
 942:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 945:	77 4d                	ja     994 <malloc+0xaa>
      if(p->s.size == nunits)
 947:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94a:	8b 40 04             	mov    0x4(%eax),%eax
 94d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 950:	75 0c                	jne    95e <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 952:	8b 45 f4             	mov    -0xc(%ebp),%eax
 955:	8b 10                	mov    (%eax),%edx
 957:	8b 45 f0             	mov    -0x10(%ebp),%eax
 95a:	89 10                	mov    %edx,(%eax)
 95c:	eb 26                	jmp    984 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 95e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 961:	8b 40 04             	mov    0x4(%eax),%eax
 964:	2b 45 ec             	sub    -0x14(%ebp),%eax
 967:	89 c2                	mov    %eax,%edx
 969:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 96f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 972:	8b 40 04             	mov    0x4(%eax),%eax
 975:	c1 e0 03             	shl    $0x3,%eax
 978:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 97b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97e:	8b 55 ec             	mov    -0x14(%ebp),%edx
 981:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 984:	8b 45 f0             	mov    -0x10(%ebp),%eax
 987:	a3 a8 13 00 00       	mov    %eax,0x13a8
      return (void*)(p + 1);
 98c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 98f:	83 c0 08             	add    $0x8,%eax
 992:	eb 3b                	jmp    9cf <malloc+0xe5>
    }
    if(p == freep)
 994:	a1 a8 13 00 00       	mov    0x13a8,%eax
 999:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 99c:	75 1e                	jne    9bc <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 99e:	83 ec 0c             	sub    $0xc,%esp
 9a1:	ff 75 ec             	pushl  -0x14(%ebp)
 9a4:	e8 dd fe ff ff       	call   886 <morecore>
 9a9:	83 c4 10             	add    $0x10,%esp
 9ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9b3:	75 07                	jne    9bc <malloc+0xd2>
        return 0;
 9b5:	b8 00 00 00 00       	mov    $0x0,%eax
 9ba:	eb 13                	jmp    9cf <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9c5:	8b 00                	mov    (%eax),%eax
 9c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9ca:	e9 6d ff ff ff       	jmp    93c <malloc+0x52>
  }
}
 9cf:	c9                   	leave  
 9d0:	c3                   	ret    

000009d1 <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
 9d1:	f3 0f 1e fb          	endbr32 
 9d5:	55                   	push   %ebp
 9d6:	89 e5                	mov    %esp,%ebp
 9d8:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 9db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 9e2:	a1 00 14 00 00       	mov    0x1400,%eax
 9e7:	83 ec 04             	sub    $0x4,%esp
 9ea:	50                   	push   %eax
 9eb:	6a 20                	push   $0x20
 9ed:	68 e0 13 00 00       	push   $0x13e0
 9f2:	e8 11 f8 ff ff       	call   208 <fgets>
 9f7:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 9fa:	83 ec 0c             	sub    $0xc,%esp
 9fd:	68 e0 13 00 00       	push   $0x13e0
 a02:	e8 0e f7 ff ff       	call   115 <strlen>
 a07:	83 c4 10             	add    $0x10,%esp
 a0a:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 a0d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a10:	83 e8 01             	sub    $0x1,%eax
 a13:	0f b6 80 e0 13 00 00 	movzbl 0x13e0(%eax),%eax
 a1a:	3c 0a                	cmp    $0xa,%al
 a1c:	74 11                	je     a2f <get_id+0x5e>
 a1e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a21:	83 e8 01             	sub    $0x1,%eax
 a24:	0f b6 80 e0 13 00 00 	movzbl 0x13e0(%eax),%eax
 a2b:	3c 0d                	cmp    $0xd,%al
 a2d:	75 0d                	jne    a3c <get_id+0x6b>
        current_line[len - 1] = 0;
 a2f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a32:	83 e8 01             	sub    $0x1,%eax
 a35:	c6 80 e0 13 00 00 00 	movb   $0x0,0x13e0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 a3c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 a43:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 a4a:	eb 6c                	jmp    ab8 <get_id+0xe7>
        if(current_line[i] == ' '){
 a4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a4f:	05 e0 13 00 00       	add    $0x13e0,%eax
 a54:	0f b6 00             	movzbl (%eax),%eax
 a57:	3c 20                	cmp    $0x20,%al
 a59:	75 30                	jne    a8b <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 a5b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a5f:	75 16                	jne    a77 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 a61:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a64:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a67:	8d 50 01             	lea    0x1(%eax),%edx
 a6a:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a6d:	8d 91 e0 13 00 00    	lea    0x13e0(%ecx),%edx
 a73:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 a77:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a7a:	05 e0 13 00 00       	add    $0x13e0,%eax
 a7f:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 a82:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a89:	eb 29                	jmp    ab4 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 a8b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a8f:	75 23                	jne    ab4 <get_id+0xe3>
 a91:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 a95:	7f 1d                	jg     ab4 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 a97:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 a9e:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 aa1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aa4:	8d 50 01             	lea    0x1(%eax),%edx
 aa7:	89 55 f0             	mov    %edx,-0x10(%ebp)
 aaa:	8d 91 e0 13 00 00    	lea    0x13e0(%ecx),%edx
 ab0:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 ab4:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 ab8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 abb:	05 e0 13 00 00       	add    $0x13e0,%eax
 ac0:	0f b6 00             	movzbl (%eax),%eax
 ac3:	84 c0                	test   %al,%al
 ac5:	75 85                	jne    a4c <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 ac7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 acb:	75 07                	jne    ad4 <get_id+0x103>
        return -1;
 acd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ad2:	eb 35                	jmp    b09 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
 ad4:	8b 45 dc             	mov    -0x24(%ebp),%eax
 ad7:	a3 c0 13 00 00       	mov    %eax,0x13c0
    current_id.uid_user = atoi(tokens[1]);
 adc:	8b 45 e0             	mov    -0x20(%ebp),%eax
 adf:	83 ec 0c             	sub    $0xc,%esp
 ae2:	50                   	push   %eax
 ae3:	e8 e5 f7 ff ff       	call   2cd <atoi>
 ae8:	83 c4 10             	add    $0x10,%esp
 aeb:	a3 c4 13 00 00       	mov    %eax,0x13c4
    current_id.gid_user = atoi(tokens[2]);
 af0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 af3:	83 ec 0c             	sub    $0xc,%esp
 af6:	50                   	push   %eax
 af7:	e8 d1 f7 ff ff       	call   2cd <atoi>
 afc:	83 c4 10             	add    $0x10,%esp
 aff:	a3 c8 13 00 00       	mov    %eax,0x13c8

    return 0;
 b04:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b09:	c9                   	leave  
 b0a:	c3                   	ret    

00000b0b <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
 b0b:	f3 0f 1e fb          	endbr32 
 b0f:	55                   	push   %ebp
 b10:	89 e5                	mov    %esp,%ebp
 b12:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 b15:	a1 00 14 00 00       	mov    0x1400,%eax
 b1a:	85 c0                	test   %eax,%eax
 b1c:	75 31                	jne    b4f <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
 b1e:	83 ec 08             	sub    $0x8,%esp
 b21:	6a 00                	push   $0x0
 b23:	68 53 0f 00 00       	push   $0xf53
 b28:	e8 51 f9 ff ff       	call   47e <open>
 b2d:	83 c4 10             	add    $0x10,%esp
 b30:	a3 00 14 00 00       	mov    %eax,0x1400

        if(dir < 0){        // kalau gagal membuka file
 b35:	a1 00 14 00 00       	mov    0x1400,%eax
 b3a:	85 c0                	test   %eax,%eax
 b3c:	79 11                	jns    b4f <getid+0x44>
            dir = 0;
 b3e:	c7 05 00 14 00 00 00 	movl   $0x0,0x1400
 b45:	00 00 00 
            return 0;
 b48:	b8 00 00 00 00       	mov    $0x0,%eax
 b4d:	eb 16                	jmp    b65 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
 b4f:	e8 7d fe ff ff       	call   9d1 <get_id>
 b54:	83 f8 ff             	cmp    $0xffffffff,%eax
 b57:	75 07                	jne    b60 <getid+0x55>
        return 0;
 b59:	b8 00 00 00 00       	mov    $0x0,%eax
 b5e:	eb 05                	jmp    b65 <getid+0x5a>
    
    return &current_id;
 b60:	b8 c0 13 00 00       	mov    $0x13c0,%eax
}
 b65:	c9                   	leave  
 b66:	c3                   	ret    

00000b67 <setid>:

// open file_ids
void setid(void){
 b67:	f3 0f 1e fb          	endbr32 
 b6b:	55                   	push   %ebp
 b6c:	89 e5                	mov    %esp,%ebp
 b6e:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b71:	a1 00 14 00 00       	mov    0x1400,%eax
 b76:	85 c0                	test   %eax,%eax
 b78:	74 1b                	je     b95 <setid+0x2e>
        close(dir);
 b7a:	a1 00 14 00 00       	mov    0x1400,%eax
 b7f:	83 ec 0c             	sub    $0xc,%esp
 b82:	50                   	push   %eax
 b83:	e8 de f8 ff ff       	call   466 <close>
 b88:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 b8b:	c7 05 00 14 00 00 00 	movl   $0x0,0x1400
 b92:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
 b95:	83 ec 08             	sub    $0x8,%esp
 b98:	6a 00                	push   $0x0
 b9a:	68 53 0f 00 00       	push   $0xf53
 b9f:	e8 da f8 ff ff       	call   47e <open>
 ba4:	83 c4 10             	add    $0x10,%esp
 ba7:	a3 00 14 00 00       	mov    %eax,0x1400

    if (dir < 0)
 bac:	a1 00 14 00 00       	mov    0x1400,%eax
 bb1:	85 c0                	test   %eax,%eax
 bb3:	79 0a                	jns    bbf <setid+0x58>
        dir = 0;
 bb5:	c7 05 00 14 00 00 00 	movl   $0x0,0x1400
 bbc:	00 00 00 
}
 bbf:	90                   	nop
 bc0:	c9                   	leave  
 bc1:	c3                   	ret    

00000bc2 <endid>:

// tutup file_ids
void endid (void){
 bc2:	f3 0f 1e fb          	endbr32 
 bc6:	55                   	push   %ebp
 bc7:	89 e5                	mov    %esp,%ebp
 bc9:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 bcc:	a1 00 14 00 00       	mov    0x1400,%eax
 bd1:	85 c0                	test   %eax,%eax
 bd3:	74 1b                	je     bf0 <endid+0x2e>
        close(dir);
 bd5:	a1 00 14 00 00       	mov    0x1400,%eax
 bda:	83 ec 0c             	sub    $0xc,%esp
 bdd:	50                   	push   %eax
 bde:	e8 83 f8 ff ff       	call   466 <close>
 be3:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 be6:	c7 05 00 14 00 00 00 	movl   $0x0,0x1400
 bed:	00 00 00 
    }
}
 bf0:	90                   	nop
 bf1:	c9                   	leave  
 bf2:	c3                   	ret    

00000bf3 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
 bf3:	f3 0f 1e fb          	endbr32 
 bf7:	55                   	push   %ebp
 bf8:	89 e5                	mov    %esp,%ebp
 bfa:	83 ec 08             	sub    $0x8,%esp
    setid();
 bfd:	e8 65 ff ff ff       	call   b67 <setid>

    while (getid()){
 c02:	eb 24                	jmp    c28 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
 c04:	a1 c0 13 00 00       	mov    0x13c0,%eax
 c09:	83 ec 08             	sub    $0x8,%esp
 c0c:	50                   	push   %eax
 c0d:	ff 75 08             	pushl  0x8(%ebp)
 c10:	e8 bd f4 ff ff       	call   d2 <strcmp>
 c15:	83 c4 10             	add    $0x10,%esp
 c18:	85 c0                	test   %eax,%eax
 c1a:	75 0c                	jne    c28 <cek_nama+0x35>
            endid();
 c1c:	e8 a1 ff ff ff       	call   bc2 <endid>
            return &current_id;
 c21:	b8 c0 13 00 00       	mov    $0x13c0,%eax
 c26:	eb 13                	jmp    c3b <cek_nama+0x48>
    while (getid()){
 c28:	e8 de fe ff ff       	call   b0b <getid>
 c2d:	85 c0                	test   %eax,%eax
 c2f:	75 d3                	jne    c04 <cek_nama+0x11>
        }
    }
    endid();
 c31:	e8 8c ff ff ff       	call   bc2 <endid>
    return 0;
 c36:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c3b:	c9                   	leave  
 c3c:	c3                   	ret    

00000c3d <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
 c3d:	f3 0f 1e fb          	endbr32 
 c41:	55                   	push   %ebp
 c42:	89 e5                	mov    %esp,%ebp
 c44:	83 ec 08             	sub    $0x8,%esp
    setid();
 c47:	e8 1b ff ff ff       	call   b67 <setid>

    while (getid()){
 c4c:	eb 16                	jmp    c64 <cek_uid+0x27>
        if(current_id.uid_user == uid){
 c4e:	a1 c4 13 00 00       	mov    0x13c4,%eax
 c53:	39 45 08             	cmp    %eax,0x8(%ebp)
 c56:	75 0c                	jne    c64 <cek_uid+0x27>
            endid();
 c58:	e8 65 ff ff ff       	call   bc2 <endid>
            return &current_id;
 c5d:	b8 c0 13 00 00       	mov    $0x13c0,%eax
 c62:	eb 13                	jmp    c77 <cek_uid+0x3a>
    while (getid()){
 c64:	e8 a2 fe ff ff       	call   b0b <getid>
 c69:	85 c0                	test   %eax,%eax
 c6b:	75 e1                	jne    c4e <cek_uid+0x11>
        }
    }
    endid();
 c6d:	e8 50 ff ff ff       	call   bc2 <endid>
    return 0;
 c72:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c77:	c9                   	leave  
 c78:	c3                   	ret    

00000c79 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
 c79:	f3 0f 1e fb          	endbr32 
 c7d:	55                   	push   %ebp
 c7e:	89 e5                	mov    %esp,%ebp
 c80:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 c83:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 c8a:	a1 00 14 00 00       	mov    0x1400,%eax
 c8f:	83 ec 04             	sub    $0x4,%esp
 c92:	50                   	push   %eax
 c93:	6a 20                	push   $0x20
 c95:	68 e0 13 00 00       	push   $0x13e0
 c9a:	e8 69 f5 ff ff       	call   208 <fgets>
 c9f:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 ca2:	83 ec 0c             	sub    $0xc,%esp
 ca5:	68 e0 13 00 00       	push   $0x13e0
 caa:	e8 66 f4 ff ff       	call   115 <strlen>
 caf:	83 c4 10             	add    $0x10,%esp
 cb2:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 cb5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cb8:	83 e8 01             	sub    $0x1,%eax
 cbb:	0f b6 80 e0 13 00 00 	movzbl 0x13e0(%eax),%eax
 cc2:	3c 0a                	cmp    $0xa,%al
 cc4:	74 11                	je     cd7 <get_group+0x5e>
 cc6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cc9:	83 e8 01             	sub    $0x1,%eax
 ccc:	0f b6 80 e0 13 00 00 	movzbl 0x13e0(%eax),%eax
 cd3:	3c 0d                	cmp    $0xd,%al
 cd5:	75 0d                	jne    ce4 <get_group+0x6b>
        current_line[len - 1] = 0;
 cd7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cda:	83 e8 01             	sub    $0x1,%eax
 cdd:	c6 80 e0 13 00 00 00 	movb   $0x0,0x13e0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 ce4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 ceb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 cf2:	eb 6c                	jmp    d60 <get_group+0xe7>
        if(current_line[i] == ' '){
 cf4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 cf7:	05 e0 13 00 00       	add    $0x13e0,%eax
 cfc:	0f b6 00             	movzbl (%eax),%eax
 cff:	3c 20                	cmp    $0x20,%al
 d01:	75 30                	jne    d33 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 d03:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d07:	75 16                	jne    d1f <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 d09:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d0f:	8d 50 01             	lea    0x1(%eax),%edx
 d12:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d15:	8d 91 e0 13 00 00    	lea    0x13e0(%ecx),%edx
 d1b:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 d1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d22:	05 e0 13 00 00       	add    $0x13e0,%eax
 d27:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 d2a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 d31:	eb 29                	jmp    d5c <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 d33:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d37:	75 23                	jne    d5c <get_group+0xe3>
 d39:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 d3d:	7f 1d                	jg     d5c <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 d3f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 d46:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d49:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d4c:	8d 50 01             	lea    0x1(%eax),%edx
 d4f:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d52:	8d 91 e0 13 00 00    	lea    0x13e0(%ecx),%edx
 d58:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 d5c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 d60:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d63:	05 e0 13 00 00       	add    $0x13e0,%eax
 d68:	0f b6 00             	movzbl (%eax),%eax
 d6b:	84 c0                	test   %al,%al
 d6d:	75 85                	jne    cf4 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 d6f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 d73:	75 07                	jne    d7c <get_group+0x103>
        return -1;
 d75:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d7a:	eb 21                	jmp    d9d <get_group+0x124>
    
    current_group.nama_group = tokens[0];
 d7c:	8b 45 dc             	mov    -0x24(%ebp),%eax
 d7f:	a3 cc 13 00 00       	mov    %eax,0x13cc
    current_group.gid = atoi(tokens[1]);
 d84:	8b 45 e0             	mov    -0x20(%ebp),%eax
 d87:	83 ec 0c             	sub    $0xc,%esp
 d8a:	50                   	push   %eax
 d8b:	e8 3d f5 ff ff       	call   2cd <atoi>
 d90:	83 c4 10             	add    $0x10,%esp
 d93:	a3 d0 13 00 00       	mov    %eax,0x13d0

    return 0;
 d98:	b8 00 00 00 00       	mov    $0x0,%eax
}
 d9d:	c9                   	leave  
 d9e:	c3                   	ret    

00000d9f <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
 d9f:	f3 0f 1e fb          	endbr32 
 da3:	55                   	push   %ebp
 da4:	89 e5                	mov    %esp,%ebp
 da6:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 da9:	a1 00 14 00 00       	mov    0x1400,%eax
 dae:	85 c0                	test   %eax,%eax
 db0:	75 31                	jne    de3 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
 db2:	83 ec 08             	sub    $0x8,%esp
 db5:	6a 00                	push   $0x0
 db7:	68 5b 0f 00 00       	push   $0xf5b
 dbc:	e8 bd f6 ff ff       	call   47e <open>
 dc1:	83 c4 10             	add    $0x10,%esp
 dc4:	a3 00 14 00 00       	mov    %eax,0x1400

        if(dir < 0){        // kalau gagal membuka file
 dc9:	a1 00 14 00 00       	mov    0x1400,%eax
 dce:	85 c0                	test   %eax,%eax
 dd0:	79 11                	jns    de3 <getgroup+0x44>
            dir = 0;
 dd2:	c7 05 00 14 00 00 00 	movl   $0x0,0x1400
 dd9:	00 00 00 
            return 0;
 ddc:	b8 00 00 00 00       	mov    $0x0,%eax
 de1:	eb 16                	jmp    df9 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
 de3:	e8 91 fe ff ff       	call   c79 <get_group>
 de8:	83 f8 ff             	cmp    $0xffffffff,%eax
 deb:	75 07                	jne    df4 <getgroup+0x55>
        return 0;
 ded:	b8 00 00 00 00       	mov    $0x0,%eax
 df2:	eb 05                	jmp    df9 <getgroup+0x5a>
    
    return &current_group;
 df4:	b8 cc 13 00 00       	mov    $0x13cc,%eax
}
 df9:	c9                   	leave  
 dfa:	c3                   	ret    

00000dfb <setgroup>:

// open file_ids
void setgroup(void){
 dfb:	f3 0f 1e fb          	endbr32 
 dff:	55                   	push   %ebp
 e00:	89 e5                	mov    %esp,%ebp
 e02:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e05:	a1 00 14 00 00       	mov    0x1400,%eax
 e0a:	85 c0                	test   %eax,%eax
 e0c:	74 1b                	je     e29 <setgroup+0x2e>
        close(dir);
 e0e:	a1 00 14 00 00       	mov    0x1400,%eax
 e13:	83 ec 0c             	sub    $0xc,%esp
 e16:	50                   	push   %eax
 e17:	e8 4a f6 ff ff       	call   466 <close>
 e1c:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e1f:	c7 05 00 14 00 00 00 	movl   $0x0,0x1400
 e26:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
 e29:	83 ec 08             	sub    $0x8,%esp
 e2c:	6a 00                	push   $0x0
 e2e:	68 5b 0f 00 00       	push   $0xf5b
 e33:	e8 46 f6 ff ff       	call   47e <open>
 e38:	83 c4 10             	add    $0x10,%esp
 e3b:	a3 00 14 00 00       	mov    %eax,0x1400

    if (dir < 0)
 e40:	a1 00 14 00 00       	mov    0x1400,%eax
 e45:	85 c0                	test   %eax,%eax
 e47:	79 0a                	jns    e53 <setgroup+0x58>
        dir = 0;
 e49:	c7 05 00 14 00 00 00 	movl   $0x0,0x1400
 e50:	00 00 00 
}
 e53:	90                   	nop
 e54:	c9                   	leave  
 e55:	c3                   	ret    

00000e56 <endgroup>:

// tutup file_ids
void endgroup (void){
 e56:	f3 0f 1e fb          	endbr32 
 e5a:	55                   	push   %ebp
 e5b:	89 e5                	mov    %esp,%ebp
 e5d:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e60:	a1 00 14 00 00       	mov    0x1400,%eax
 e65:	85 c0                	test   %eax,%eax
 e67:	74 1b                	je     e84 <endgroup+0x2e>
        close(dir);
 e69:	a1 00 14 00 00       	mov    0x1400,%eax
 e6e:	83 ec 0c             	sub    $0xc,%esp
 e71:	50                   	push   %eax
 e72:	e8 ef f5 ff ff       	call   466 <close>
 e77:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e7a:	c7 05 00 14 00 00 00 	movl   $0x0,0x1400
 e81:	00 00 00 
    }
}
 e84:	90                   	nop
 e85:	c9                   	leave  
 e86:	c3                   	ret    

00000e87 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
 e87:	f3 0f 1e fb          	endbr32 
 e8b:	55                   	push   %ebp
 e8c:	89 e5                	mov    %esp,%ebp
 e8e:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 e91:	e8 65 ff ff ff       	call   dfb <setgroup>

    while (getgroup()){
 e96:	eb 3c                	jmp    ed4 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
 e98:	a1 cc 13 00 00       	mov    0x13cc,%eax
 e9d:	83 ec 08             	sub    $0x8,%esp
 ea0:	50                   	push   %eax
 ea1:	ff 75 08             	pushl  0x8(%ebp)
 ea4:	e8 29 f2 ff ff       	call   d2 <strcmp>
 ea9:	83 c4 10             	add    $0x10,%esp
 eac:	85 c0                	test   %eax,%eax
 eae:	75 24                	jne    ed4 <cek_nama_group+0x4d>
            endgroup();
 eb0:	e8 a1 ff ff ff       	call   e56 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
 eb5:	a1 cc 13 00 00       	mov    0x13cc,%eax
 eba:	83 ec 04             	sub    $0x4,%esp
 ebd:	50                   	push   %eax
 ebe:	68 66 0f 00 00       	push   $0xf66
 ec3:	6a 01                	push   $0x1
 ec5:	e8 40 f7 ff ff       	call   60a <printf>
 eca:	83 c4 10             	add    $0x10,%esp
            return &current_group;
 ecd:	b8 cc 13 00 00       	mov    $0x13cc,%eax
 ed2:	eb 13                	jmp    ee7 <cek_nama_group+0x60>
    while (getgroup()){
 ed4:	e8 c6 fe ff ff       	call   d9f <getgroup>
 ed9:	85 c0                	test   %eax,%eax
 edb:	75 bb                	jne    e98 <cek_nama_group+0x11>
        }
    }
    endgroup();
 edd:	e8 74 ff ff ff       	call   e56 <endgroup>
    return 0;
 ee2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ee7:	c9                   	leave  
 ee8:	c3                   	ret    

00000ee9 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
 ee9:	f3 0f 1e fb          	endbr32 
 eed:	55                   	push   %ebp
 eee:	89 e5                	mov    %esp,%ebp
 ef0:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 ef3:	e8 03 ff ff ff       	call   dfb <setgroup>

    while (getgroup()){
 ef8:	eb 16                	jmp    f10 <cek_gid+0x27>
        if(current_group.gid == gid){
 efa:	a1 d0 13 00 00       	mov    0x13d0,%eax
 eff:	39 45 08             	cmp    %eax,0x8(%ebp)
 f02:	75 0c                	jne    f10 <cek_gid+0x27>
            endgroup();
 f04:	e8 4d ff ff ff       	call   e56 <endgroup>
            return &current_group;
 f09:	b8 cc 13 00 00       	mov    $0x13cc,%eax
 f0e:	eb 13                	jmp    f23 <cek_gid+0x3a>
    while (getgroup()){
 f10:	e8 8a fe ff ff       	call   d9f <getgroup>
 f15:	85 c0                	test   %eax,%eax
 f17:	75 e1                	jne    efa <cek_gid+0x11>
        }
    }
    endgroup();
 f19:	e8 38 ff ff ff       	call   e56 <endgroup>
    return 0;
 f1e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 f23:	c9                   	leave  
 f24:	c3                   	ret    
