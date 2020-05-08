
_halt:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// halt the system.
#include "types.h"
#include "user.h"

int
main(void) {
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	83 e4 f0             	and    $0xfffffff0,%esp
  halt();
   a:	e8 6d 04 00 00       	call   47c <halt>
  return 0;
   f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  14:	c9                   	leave  
  15:	c3                   	ret    

00000016 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  16:	55                   	push   %ebp
  17:	89 e5                	mov    %esp,%ebp
  19:	57                   	push   %edi
  1a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  1b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1e:	8b 55 10             	mov    0x10(%ebp),%edx
  21:	8b 45 0c             	mov    0xc(%ebp),%eax
  24:	89 cb                	mov    %ecx,%ebx
  26:	89 df                	mov    %ebx,%edi
  28:	89 d1                	mov    %edx,%ecx
  2a:	fc                   	cld    
  2b:	f3 aa                	rep stos %al,%es:(%edi)
  2d:	89 ca                	mov    %ecx,%edx
  2f:	89 fb                	mov    %edi,%ebx
  31:	89 5d 08             	mov    %ebx,0x8(%ebp)
  34:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  37:	90                   	nop
  38:	5b                   	pop    %ebx
  39:	5f                   	pop    %edi
  3a:	5d                   	pop    %ebp
  3b:	c3                   	ret    

0000003c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  3c:	f3 0f 1e fb          	endbr32 
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  46:	8b 45 08             	mov    0x8(%ebp),%eax
  49:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  4c:	90                   	nop
  4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  50:	8d 42 01             	lea    0x1(%edx),%eax
  53:	89 45 0c             	mov    %eax,0xc(%ebp)
  56:	8b 45 08             	mov    0x8(%ebp),%eax
  59:	8d 48 01             	lea    0x1(%eax),%ecx
  5c:	89 4d 08             	mov    %ecx,0x8(%ebp)
  5f:	0f b6 12             	movzbl (%edx),%edx
  62:	88 10                	mov    %dl,(%eax)
  64:	0f b6 00             	movzbl (%eax),%eax
  67:	84 c0                	test   %al,%al
  69:	75 e2                	jne    4d <strcpy+0x11>
    ;
  return os;
  6b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  6e:	c9                   	leave  
  6f:	c3                   	ret    

00000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  70:	f3 0f 1e fb          	endbr32 
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  77:	eb 08                	jmp    81 <strcmp+0x11>
    p++, q++;
  79:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  7d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  81:	8b 45 08             	mov    0x8(%ebp),%eax
  84:	0f b6 00             	movzbl (%eax),%eax
  87:	84 c0                	test   %al,%al
  89:	74 10                	je     9b <strcmp+0x2b>
  8b:	8b 45 08             	mov    0x8(%ebp),%eax
  8e:	0f b6 10             	movzbl (%eax),%edx
  91:	8b 45 0c             	mov    0xc(%ebp),%eax
  94:	0f b6 00             	movzbl (%eax),%eax
  97:	38 c2                	cmp    %al,%dl
  99:	74 de                	je     79 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
  9b:	8b 45 08             	mov    0x8(%ebp),%eax
  9e:	0f b6 00             	movzbl (%eax),%eax
  a1:	0f b6 d0             	movzbl %al,%edx
  a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  a7:	0f b6 00             	movzbl (%eax),%eax
  aa:	0f b6 c0             	movzbl %al,%eax
  ad:	29 c2                	sub    %eax,%edx
  af:	89 d0                	mov    %edx,%eax
}
  b1:	5d                   	pop    %ebp
  b2:	c3                   	ret    

000000b3 <strlen>:

uint
strlen(char *s)
{
  b3:	f3 0f 1e fb          	endbr32 
  b7:	55                   	push   %ebp
  b8:	89 e5                	mov    %esp,%ebp
  ba:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  c4:	eb 04                	jmp    ca <strlen+0x17>
  c6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  cd:	8b 45 08             	mov    0x8(%ebp),%eax
  d0:	01 d0                	add    %edx,%eax
  d2:	0f b6 00             	movzbl (%eax),%eax
  d5:	84 c0                	test   %al,%al
  d7:	75 ed                	jne    c6 <strlen+0x13>
    ;
  return n;
  d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  dc:	c9                   	leave  
  dd:	c3                   	ret    

000000de <memset>:

void*
memset(void *dst, int c, uint n)
{
  de:	f3 0f 1e fb          	endbr32 
  e2:	55                   	push   %ebp
  e3:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  e5:	8b 45 10             	mov    0x10(%ebp),%eax
  e8:	50                   	push   %eax
  e9:	ff 75 0c             	pushl  0xc(%ebp)
  ec:	ff 75 08             	pushl  0x8(%ebp)
  ef:	e8 22 ff ff ff       	call   16 <stosb>
  f4:	83 c4 0c             	add    $0xc,%esp
  return dst;
  f7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  fa:	c9                   	leave  
  fb:	c3                   	ret    

000000fc <strchr>:

char*
strchr(const char *s, char c)
{
  fc:	f3 0f 1e fb          	endbr32 
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	83 ec 04             	sub    $0x4,%esp
 106:	8b 45 0c             	mov    0xc(%ebp),%eax
 109:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 10c:	eb 14                	jmp    122 <strchr+0x26>
    if(*s == c)
 10e:	8b 45 08             	mov    0x8(%ebp),%eax
 111:	0f b6 00             	movzbl (%eax),%eax
 114:	38 45 fc             	cmp    %al,-0x4(%ebp)
 117:	75 05                	jne    11e <strchr+0x22>
      return (char*)s;
 119:	8b 45 08             	mov    0x8(%ebp),%eax
 11c:	eb 13                	jmp    131 <strchr+0x35>
  for(; *s; s++)
 11e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 122:	8b 45 08             	mov    0x8(%ebp),%eax
 125:	0f b6 00             	movzbl (%eax),%eax
 128:	84 c0                	test   %al,%al
 12a:	75 e2                	jne    10e <strchr+0x12>
  return 0;
 12c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 131:	c9                   	leave  
 132:	c3                   	ret    

00000133 <gets>:

char*
gets(char *buf, int max)
{
 133:	f3 0f 1e fb          	endbr32 
 137:	55                   	push   %ebp
 138:	89 e5                	mov    %esp,%ebp
 13a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 144:	eb 42                	jmp    188 <gets+0x55>
    cc = read(0, &c, 1);
 146:	83 ec 04             	sub    $0x4,%esp
 149:	6a 01                	push   $0x1
 14b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 14e:	50                   	push   %eax
 14f:	6a 00                	push   $0x0
 151:	e8 9e 02 00 00       	call   3f4 <read>
 156:	83 c4 10             	add    $0x10,%esp
 159:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 15c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 160:	7e 33                	jle    195 <gets+0x62>
      break;
    buf[i++] = c;
 162:	8b 45 f4             	mov    -0xc(%ebp),%eax
 165:	8d 50 01             	lea    0x1(%eax),%edx
 168:	89 55 f4             	mov    %edx,-0xc(%ebp)
 16b:	89 c2                	mov    %eax,%edx
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	01 c2                	add    %eax,%edx
 172:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 176:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 178:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17c:	3c 0a                	cmp    $0xa,%al
 17e:	74 16                	je     196 <gets+0x63>
 180:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 184:	3c 0d                	cmp    $0xd,%al
 186:	74 0e                	je     196 <gets+0x63>
  for(i=0; i+1 < max; ){
 188:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18b:	83 c0 01             	add    $0x1,%eax
 18e:	39 45 0c             	cmp    %eax,0xc(%ebp)
 191:	7f b3                	jg     146 <gets+0x13>
 193:	eb 01                	jmp    196 <gets+0x63>
      break;
 195:	90                   	nop
      break;
  }
  buf[i] = '\0';
 196:	8b 55 f4             	mov    -0xc(%ebp),%edx
 199:	8b 45 08             	mov    0x8(%ebp),%eax
 19c:	01 d0                	add    %edx,%eax
 19e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a4:	c9                   	leave  
 1a5:	c3                   	ret    

000001a6 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
 1a6:	f3 0f 1e fb          	endbr32 
 1aa:	55                   	push   %ebp
 1ab:	89 e5                	mov    %esp,%ebp
 1ad:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
 1b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1b7:	eb 43                	jmp    1fc <fgets+0x56>
    int cc = read(fd, &c, 1);
 1b9:	83 ec 04             	sub    $0x4,%esp
 1bc:	6a 01                	push   $0x1
 1be:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1c1:	50                   	push   %eax
 1c2:	ff 75 10             	pushl  0x10(%ebp)
 1c5:	e8 2a 02 00 00       	call   3f4 <read>
 1ca:	83 c4 10             	add    $0x10,%esp
 1cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1d4:	7e 33                	jle    209 <fgets+0x63>
      break;
    buf[i++] = c;
 1d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d9:	8d 50 01             	lea    0x1(%eax),%edx
 1dc:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1df:	89 c2                	mov    %eax,%edx
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	01 c2                	add    %eax,%edx
 1e6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ea:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1ec:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f0:	3c 0a                	cmp    $0xa,%al
 1f2:	74 16                	je     20a <fgets+0x64>
 1f4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f8:	3c 0d                	cmp    $0xd,%al
 1fa:	74 0e                	je     20a <fgets+0x64>
  for(i = 0; i + 1 < size;){
 1fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ff:	83 c0 01             	add    $0x1,%eax
 202:	39 45 0c             	cmp    %eax,0xc(%ebp)
 205:	7f b2                	jg     1b9 <fgets+0x13>
 207:	eb 01                	jmp    20a <fgets+0x64>
      break;
 209:	90                   	nop
      break;
  }
  buf[i] = '\0';
 20a:	8b 55 f4             	mov    -0xc(%ebp),%edx
 20d:	8b 45 08             	mov    0x8(%ebp),%eax
 210:	01 d0                	add    %edx,%eax
 212:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 215:	8b 45 08             	mov    0x8(%ebp),%eax
}
 218:	c9                   	leave  
 219:	c3                   	ret    

0000021a <stat>:

int
stat(char *n, struct stat *st)
{
 21a:	f3 0f 1e fb          	endbr32 
 21e:	55                   	push   %ebp
 21f:	89 e5                	mov    %esp,%ebp
 221:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 224:	83 ec 08             	sub    $0x8,%esp
 227:	6a 00                	push   $0x0
 229:	ff 75 08             	pushl  0x8(%ebp)
 22c:	e8 eb 01 00 00       	call   41c <open>
 231:	83 c4 10             	add    $0x10,%esp
 234:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 237:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 23b:	79 07                	jns    244 <stat+0x2a>
    return -1;
 23d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 242:	eb 25                	jmp    269 <stat+0x4f>
  r = fstat(fd, st);
 244:	83 ec 08             	sub    $0x8,%esp
 247:	ff 75 0c             	pushl  0xc(%ebp)
 24a:	ff 75 f4             	pushl  -0xc(%ebp)
 24d:	e8 e2 01 00 00       	call   434 <fstat>
 252:	83 c4 10             	add    $0x10,%esp
 255:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 258:	83 ec 0c             	sub    $0xc,%esp
 25b:	ff 75 f4             	pushl  -0xc(%ebp)
 25e:	e8 a1 01 00 00       	call   404 <close>
 263:	83 c4 10             	add    $0x10,%esp
  return r;
 266:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 269:	c9                   	leave  
 26a:	c3                   	ret    

0000026b <atoi>:

int
atoi(const char *s)
{
 26b:	f3 0f 1e fb          	endbr32 
 26f:	55                   	push   %ebp
 270:	89 e5                	mov    %esp,%ebp
 272:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 275:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 27c:	eb 04                	jmp    282 <atoi+0x17>
 27e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 282:	8b 45 08             	mov    0x8(%ebp),%eax
 285:	0f b6 00             	movzbl (%eax),%eax
 288:	3c 20                	cmp    $0x20,%al
 28a:	74 f2                	je     27e <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	0f b6 00             	movzbl (%eax),%eax
 292:	3c 2d                	cmp    $0x2d,%al
 294:	75 07                	jne    29d <atoi+0x32>
 296:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 29b:	eb 05                	jmp    2a2 <atoi+0x37>
 29d:	b8 01 00 00 00       	mov    $0x1,%eax
 2a2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	0f b6 00             	movzbl (%eax),%eax
 2ab:	3c 2b                	cmp    $0x2b,%al
 2ad:	74 0a                	je     2b9 <atoi+0x4e>
 2af:	8b 45 08             	mov    0x8(%ebp),%eax
 2b2:	0f b6 00             	movzbl (%eax),%eax
 2b5:	3c 2d                	cmp    $0x2d,%al
 2b7:	75 2b                	jne    2e4 <atoi+0x79>
    s++;
 2b9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 2bd:	eb 25                	jmp    2e4 <atoi+0x79>
    n = n*10 + *s++ - '0';
 2bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2c2:	89 d0                	mov    %edx,%eax
 2c4:	c1 e0 02             	shl    $0x2,%eax
 2c7:	01 d0                	add    %edx,%eax
 2c9:	01 c0                	add    %eax,%eax
 2cb:	89 c1                	mov    %eax,%ecx
 2cd:	8b 45 08             	mov    0x8(%ebp),%eax
 2d0:	8d 50 01             	lea    0x1(%eax),%edx
 2d3:	89 55 08             	mov    %edx,0x8(%ebp)
 2d6:	0f b6 00             	movzbl (%eax),%eax
 2d9:	0f be c0             	movsbl %al,%eax
 2dc:	01 c8                	add    %ecx,%eax
 2de:	83 e8 30             	sub    $0x30,%eax
 2e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e4:	8b 45 08             	mov    0x8(%ebp),%eax
 2e7:	0f b6 00             	movzbl (%eax),%eax
 2ea:	3c 2f                	cmp    $0x2f,%al
 2ec:	7e 0a                	jle    2f8 <atoi+0x8d>
 2ee:	8b 45 08             	mov    0x8(%ebp),%eax
 2f1:	0f b6 00             	movzbl (%eax),%eax
 2f4:	3c 39                	cmp    $0x39,%al
 2f6:	7e c7                	jle    2bf <atoi+0x54>
  return sign*n;
 2f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2fb:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 2ff:	c9                   	leave  
 300:	c3                   	ret    

00000301 <atoo>:

int
atoo(const char *s)
{
 301:	f3 0f 1e fb          	endbr32 
 305:	55                   	push   %ebp
 306:	89 e5                	mov    %esp,%ebp
 308:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 30b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 312:	eb 04                	jmp    318 <atoo+0x17>
 314:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	0f b6 00             	movzbl (%eax),%eax
 31e:	3c 20                	cmp    $0x20,%al
 320:	74 f2                	je     314 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
 322:	8b 45 08             	mov    0x8(%ebp),%eax
 325:	0f b6 00             	movzbl (%eax),%eax
 328:	3c 2d                	cmp    $0x2d,%al
 32a:	75 07                	jne    333 <atoo+0x32>
 32c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 331:	eb 05                	jmp    338 <atoo+0x37>
 333:	b8 01 00 00 00       	mov    $0x1,%eax
 338:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 33b:	8b 45 08             	mov    0x8(%ebp),%eax
 33e:	0f b6 00             	movzbl (%eax),%eax
 341:	3c 2b                	cmp    $0x2b,%al
 343:	74 0a                	je     34f <atoo+0x4e>
 345:	8b 45 08             	mov    0x8(%ebp),%eax
 348:	0f b6 00             	movzbl (%eax),%eax
 34b:	3c 2d                	cmp    $0x2d,%al
 34d:	75 27                	jne    376 <atoo+0x75>
    s++;
 34f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 353:	eb 21                	jmp    376 <atoo+0x75>
    n = n*8 + *s++ - '0';
 355:	8b 45 fc             	mov    -0x4(%ebp),%eax
 358:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 35f:	8b 45 08             	mov    0x8(%ebp),%eax
 362:	8d 50 01             	lea    0x1(%eax),%edx
 365:	89 55 08             	mov    %edx,0x8(%ebp)
 368:	0f b6 00             	movzbl (%eax),%eax
 36b:	0f be c0             	movsbl %al,%eax
 36e:	01 c8                	add    %ecx,%eax
 370:	83 e8 30             	sub    $0x30,%eax
 373:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
 376:	8b 45 08             	mov    0x8(%ebp),%eax
 379:	0f b6 00             	movzbl (%eax),%eax
 37c:	3c 2f                	cmp    $0x2f,%al
 37e:	7e 0a                	jle    38a <atoo+0x89>
 380:	8b 45 08             	mov    0x8(%ebp),%eax
 383:	0f b6 00             	movzbl (%eax),%eax
 386:	3c 37                	cmp    $0x37,%al
 388:	7e cb                	jle    355 <atoo+0x54>
  return sign*n;
 38a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 38d:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 391:	c9                   	leave  
 392:	c3                   	ret    

00000393 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 393:	f3 0f 1e fb          	endbr32 
 397:	55                   	push   %ebp
 398:	89 e5                	mov    %esp,%ebp
 39a:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 39d:	8b 45 08             	mov    0x8(%ebp),%eax
 3a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3a9:	eb 17                	jmp    3c2 <memmove+0x2f>
    *dst++ = *src++;
 3ab:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3ae:	8d 42 01             	lea    0x1(%edx),%eax
 3b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
 3b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3b7:	8d 48 01             	lea    0x1(%eax),%ecx
 3ba:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 3bd:	0f b6 12             	movzbl (%edx),%edx
 3c0:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 3c2:	8b 45 10             	mov    0x10(%ebp),%eax
 3c5:	8d 50 ff             	lea    -0x1(%eax),%edx
 3c8:	89 55 10             	mov    %edx,0x10(%ebp)
 3cb:	85 c0                	test   %eax,%eax
 3cd:	7f dc                	jg     3ab <memmove+0x18>
  return vdst;
 3cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3d2:	c9                   	leave  
 3d3:	c3                   	ret    

000003d4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3d4:	b8 01 00 00 00       	mov    $0x1,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <exit>:
SYSCALL(exit)
 3dc:	b8 02 00 00 00       	mov    $0x2,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <wait>:
SYSCALL(wait)
 3e4:	b8 03 00 00 00       	mov    $0x3,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <pipe>:
SYSCALL(pipe)
 3ec:	b8 04 00 00 00       	mov    $0x4,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <read>:
SYSCALL(read)
 3f4:	b8 05 00 00 00       	mov    $0x5,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <write>:
SYSCALL(write)
 3fc:	b8 10 00 00 00       	mov    $0x10,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <close>:
SYSCALL(close)
 404:	b8 15 00 00 00       	mov    $0x15,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <kill>:
SYSCALL(kill)
 40c:	b8 06 00 00 00       	mov    $0x6,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <exec>:
SYSCALL(exec)
 414:	b8 07 00 00 00       	mov    $0x7,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <open>:
SYSCALL(open)
 41c:	b8 0f 00 00 00       	mov    $0xf,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <mknod>:
SYSCALL(mknod)
 424:	b8 11 00 00 00       	mov    $0x11,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <unlink>:
SYSCALL(unlink)
 42c:	b8 12 00 00 00       	mov    $0x12,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <fstat>:
SYSCALL(fstat)
 434:	b8 08 00 00 00       	mov    $0x8,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <link>:
SYSCALL(link)
 43c:	b8 13 00 00 00       	mov    $0x13,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <mkdir>:
SYSCALL(mkdir)
 444:	b8 14 00 00 00       	mov    $0x14,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <chdir>:
SYSCALL(chdir)
 44c:	b8 09 00 00 00       	mov    $0x9,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <dup>:
SYSCALL(dup)
 454:	b8 0a 00 00 00       	mov    $0xa,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <getpid>:
SYSCALL(getpid)
 45c:	b8 0b 00 00 00       	mov    $0xb,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <sbrk>:
SYSCALL(sbrk)
 464:	b8 0c 00 00 00       	mov    $0xc,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <sleep>:
SYSCALL(sleep)
 46c:	b8 0d 00 00 00       	mov    $0xd,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <uptime>:
SYSCALL(uptime)
 474:	b8 0e 00 00 00       	mov    $0xe,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <halt>:
SYSCALL(halt)
 47c:	b8 16 00 00 00       	mov    $0x16,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <date>:
SYSCALL(date)
 484:	b8 17 00 00 00       	mov    $0x17,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <getuid>:
SYSCALL(getuid)
 48c:	b8 18 00 00 00       	mov    $0x18,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <getgid>:
SYSCALL(getgid)
 494:	b8 19 00 00 00       	mov    $0x19,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <getppid>:
SYSCALL(getppid)
 49c:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <setuid>:
SYSCALL(setuid)
 4a4:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    

000004ac <setgid>:
SYSCALL(setgid)
 4ac:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <getprocs>:
SYSCALL(getprocs)
 4b4:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <setpriority>:
SYSCALL(setpriority)
 4bc:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4c1:	cd 40                	int    $0x40
 4c3:	c3                   	ret    

000004c4 <chown>:
SYSCALL(chown)
 4c4:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4c9:	cd 40                	int    $0x40
 4cb:	c3                   	ret    

000004cc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4cc:	f3 0f 1e fb          	endbr32 
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	83 ec 18             	sub    $0x18,%esp
 4d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4dc:	83 ec 04             	sub    $0x4,%esp
 4df:	6a 01                	push   $0x1
 4e1:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4e4:	50                   	push   %eax
 4e5:	ff 75 08             	pushl  0x8(%ebp)
 4e8:	e8 0f ff ff ff       	call   3fc <write>
 4ed:	83 c4 10             	add    $0x10,%esp
}
 4f0:	90                   	nop
 4f1:	c9                   	leave  
 4f2:	c3                   	ret    

000004f3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4f3:	f3 0f 1e fb          	endbr32 
 4f7:	55                   	push   %ebp
 4f8:	89 e5                	mov    %esp,%ebp
 4fa:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4fd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 504:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 508:	74 17                	je     521 <printint+0x2e>
 50a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 50e:	79 11                	jns    521 <printint+0x2e>
    neg = 1;
 510:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 517:	8b 45 0c             	mov    0xc(%ebp),%eax
 51a:	f7 d8                	neg    %eax
 51c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 51f:	eb 06                	jmp    527 <printint+0x34>
  } else {
    x = xx;
 521:	8b 45 0c             	mov    0xc(%ebp),%eax
 524:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 527:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 52e:	8b 4d 10             	mov    0x10(%ebp),%ecx
 531:	8b 45 ec             	mov    -0x14(%ebp),%eax
 534:	ba 00 00 00 00       	mov    $0x0,%edx
 539:	f7 f1                	div    %ecx
 53b:	89 d1                	mov    %edx,%ecx
 53d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 540:	8d 50 01             	lea    0x1(%eax),%edx
 543:	89 55 f4             	mov    %edx,-0xc(%ebp)
 546:	0f b6 91 f0 12 00 00 	movzbl 0x12f0(%ecx),%edx
 54d:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 551:	8b 4d 10             	mov    0x10(%ebp),%ecx
 554:	8b 45 ec             	mov    -0x14(%ebp),%eax
 557:	ba 00 00 00 00       	mov    $0x0,%edx
 55c:	f7 f1                	div    %ecx
 55e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 561:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 565:	75 c7                	jne    52e <printint+0x3b>
  if(neg)
 567:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 56b:	74 2d                	je     59a <printint+0xa7>
    buf[i++] = '-';
 56d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 570:	8d 50 01             	lea    0x1(%eax),%edx
 573:	89 55 f4             	mov    %edx,-0xc(%ebp)
 576:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 57b:	eb 1d                	jmp    59a <printint+0xa7>
    putc(fd, buf[i]);
 57d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 580:	8b 45 f4             	mov    -0xc(%ebp),%eax
 583:	01 d0                	add    %edx,%eax
 585:	0f b6 00             	movzbl (%eax),%eax
 588:	0f be c0             	movsbl %al,%eax
 58b:	83 ec 08             	sub    $0x8,%esp
 58e:	50                   	push   %eax
 58f:	ff 75 08             	pushl  0x8(%ebp)
 592:	e8 35 ff ff ff       	call   4cc <putc>
 597:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 59a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 59e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5a2:	79 d9                	jns    57d <printint+0x8a>
}
 5a4:	90                   	nop
 5a5:	90                   	nop
 5a6:	c9                   	leave  
 5a7:	c3                   	ret    

000005a8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5a8:	f3 0f 1e fb          	endbr32 
 5ac:	55                   	push   %ebp
 5ad:	89 e5                	mov    %esp,%ebp
 5af:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5b2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5b9:	8d 45 0c             	lea    0xc(%ebp),%eax
 5bc:	83 c0 04             	add    $0x4,%eax
 5bf:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5c9:	e9 59 01 00 00       	jmp    727 <printf+0x17f>
    c = fmt[i] & 0xff;
 5ce:	8b 55 0c             	mov    0xc(%ebp),%edx
 5d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5d4:	01 d0                	add    %edx,%eax
 5d6:	0f b6 00             	movzbl (%eax),%eax
 5d9:	0f be c0             	movsbl %al,%eax
 5dc:	25 ff 00 00 00       	and    $0xff,%eax
 5e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5e8:	75 2c                	jne    616 <printf+0x6e>
      if(c == '%'){
 5ea:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ee:	75 0c                	jne    5fc <printf+0x54>
        state = '%';
 5f0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5f7:	e9 27 01 00 00       	jmp    723 <printf+0x17b>
      } else {
        putc(fd, c);
 5fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ff:	0f be c0             	movsbl %al,%eax
 602:	83 ec 08             	sub    $0x8,%esp
 605:	50                   	push   %eax
 606:	ff 75 08             	pushl  0x8(%ebp)
 609:	e8 be fe ff ff       	call   4cc <putc>
 60e:	83 c4 10             	add    $0x10,%esp
 611:	e9 0d 01 00 00       	jmp    723 <printf+0x17b>
      }
    } else if(state == '%'){
 616:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 61a:	0f 85 03 01 00 00    	jne    723 <printf+0x17b>
      if(c == 'd'){
 620:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 624:	75 1e                	jne    644 <printf+0x9c>
        printint(fd, *ap, 10, 1);
 626:	8b 45 e8             	mov    -0x18(%ebp),%eax
 629:	8b 00                	mov    (%eax),%eax
 62b:	6a 01                	push   $0x1
 62d:	6a 0a                	push   $0xa
 62f:	50                   	push   %eax
 630:	ff 75 08             	pushl  0x8(%ebp)
 633:	e8 bb fe ff ff       	call   4f3 <printint>
 638:	83 c4 10             	add    $0x10,%esp
        ap++;
 63b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 63f:	e9 d8 00 00 00       	jmp    71c <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 644:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 648:	74 06                	je     650 <printf+0xa8>
 64a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 64e:	75 1e                	jne    66e <printf+0xc6>
        printint(fd, *ap, 16, 0);
 650:	8b 45 e8             	mov    -0x18(%ebp),%eax
 653:	8b 00                	mov    (%eax),%eax
 655:	6a 00                	push   $0x0
 657:	6a 10                	push   $0x10
 659:	50                   	push   %eax
 65a:	ff 75 08             	pushl  0x8(%ebp)
 65d:	e8 91 fe ff ff       	call   4f3 <printint>
 662:	83 c4 10             	add    $0x10,%esp
        ap++;
 665:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 669:	e9 ae 00 00 00       	jmp    71c <printf+0x174>
      } else if(c == 's'){
 66e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 672:	75 43                	jne    6b7 <printf+0x10f>
        s = (char*)*ap;
 674:	8b 45 e8             	mov    -0x18(%ebp),%eax
 677:	8b 00                	mov    (%eax),%eax
 679:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 67c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 680:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 684:	75 25                	jne    6ab <printf+0x103>
          s = "(null)";
 686:	c7 45 f4 c3 0e 00 00 	movl   $0xec3,-0xc(%ebp)
        while(*s != 0){
 68d:	eb 1c                	jmp    6ab <printf+0x103>
          putc(fd, *s);
 68f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 692:	0f b6 00             	movzbl (%eax),%eax
 695:	0f be c0             	movsbl %al,%eax
 698:	83 ec 08             	sub    $0x8,%esp
 69b:	50                   	push   %eax
 69c:	ff 75 08             	pushl  0x8(%ebp)
 69f:	e8 28 fe ff ff       	call   4cc <putc>
 6a4:	83 c4 10             	add    $0x10,%esp
          s++;
 6a7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ae:	0f b6 00             	movzbl (%eax),%eax
 6b1:	84 c0                	test   %al,%al
 6b3:	75 da                	jne    68f <printf+0xe7>
 6b5:	eb 65                	jmp    71c <printf+0x174>
        }
      } else if(c == 'c'){
 6b7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6bb:	75 1d                	jne    6da <printf+0x132>
        putc(fd, *ap);
 6bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6c0:	8b 00                	mov    (%eax),%eax
 6c2:	0f be c0             	movsbl %al,%eax
 6c5:	83 ec 08             	sub    $0x8,%esp
 6c8:	50                   	push   %eax
 6c9:	ff 75 08             	pushl  0x8(%ebp)
 6cc:	e8 fb fd ff ff       	call   4cc <putc>
 6d1:	83 c4 10             	add    $0x10,%esp
        ap++;
 6d4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6d8:	eb 42                	jmp    71c <printf+0x174>
      } else if(c == '%'){
 6da:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6de:	75 17                	jne    6f7 <printf+0x14f>
        putc(fd, c);
 6e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6e3:	0f be c0             	movsbl %al,%eax
 6e6:	83 ec 08             	sub    $0x8,%esp
 6e9:	50                   	push   %eax
 6ea:	ff 75 08             	pushl  0x8(%ebp)
 6ed:	e8 da fd ff ff       	call   4cc <putc>
 6f2:	83 c4 10             	add    $0x10,%esp
 6f5:	eb 25                	jmp    71c <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6f7:	83 ec 08             	sub    $0x8,%esp
 6fa:	6a 25                	push   $0x25
 6fc:	ff 75 08             	pushl  0x8(%ebp)
 6ff:	e8 c8 fd ff ff       	call   4cc <putc>
 704:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 707:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 70a:	0f be c0             	movsbl %al,%eax
 70d:	83 ec 08             	sub    $0x8,%esp
 710:	50                   	push   %eax
 711:	ff 75 08             	pushl  0x8(%ebp)
 714:	e8 b3 fd ff ff       	call   4cc <putc>
 719:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 71c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 723:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 727:	8b 55 0c             	mov    0xc(%ebp),%edx
 72a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72d:	01 d0                	add    %edx,%eax
 72f:	0f b6 00             	movzbl (%eax),%eax
 732:	84 c0                	test   %al,%al
 734:	0f 85 94 fe ff ff    	jne    5ce <printf+0x26>
    }
  }
}
 73a:	90                   	nop
 73b:	90                   	nop
 73c:	c9                   	leave  
 73d:	c3                   	ret    

0000073e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 73e:	f3 0f 1e fb          	endbr32 
 742:	55                   	push   %ebp
 743:	89 e5                	mov    %esp,%ebp
 745:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 748:	8b 45 08             	mov    0x8(%ebp),%eax
 74b:	83 e8 08             	sub    $0x8,%eax
 74e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	a1 28 13 00 00       	mov    0x1328,%eax
 756:	89 45 fc             	mov    %eax,-0x4(%ebp)
 759:	eb 24                	jmp    77f <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75e:	8b 00                	mov    (%eax),%eax
 760:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 763:	72 12                	jb     777 <free+0x39>
 765:	8b 45 f8             	mov    -0x8(%ebp),%eax
 768:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 76b:	77 24                	ja     791 <free+0x53>
 76d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 770:	8b 00                	mov    (%eax),%eax
 772:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 775:	72 1a                	jb     791 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 777:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77a:	8b 00                	mov    (%eax),%eax
 77c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 77f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 782:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 785:	76 d4                	jbe    75b <free+0x1d>
 787:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78a:	8b 00                	mov    (%eax),%eax
 78c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 78f:	73 ca                	jae    75b <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 791:	8b 45 f8             	mov    -0x8(%ebp),%eax
 794:	8b 40 04             	mov    0x4(%eax),%eax
 797:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 79e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a1:	01 c2                	add    %eax,%edx
 7a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a6:	8b 00                	mov    (%eax),%eax
 7a8:	39 c2                	cmp    %eax,%edx
 7aa:	75 24                	jne    7d0 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 7ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7af:	8b 50 04             	mov    0x4(%eax),%edx
 7b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b5:	8b 00                	mov    (%eax),%eax
 7b7:	8b 40 04             	mov    0x4(%eax),%eax
 7ba:	01 c2                	add    %eax,%edx
 7bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bf:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c5:	8b 00                	mov    (%eax),%eax
 7c7:	8b 10                	mov    (%eax),%edx
 7c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7cc:	89 10                	mov    %edx,(%eax)
 7ce:	eb 0a                	jmp    7da <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 7d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d3:	8b 10                	mov    (%eax),%edx
 7d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d8:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dd:	8b 40 04             	mov    0x4(%eax),%eax
 7e0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ea:	01 d0                	add    %edx,%eax
 7ec:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7ef:	75 20                	jne    811 <free+0xd3>
    p->s.size += bp->s.size;
 7f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f4:	8b 50 04             	mov    0x4(%eax),%edx
 7f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7fa:	8b 40 04             	mov    0x4(%eax),%eax
 7fd:	01 c2                	add    %eax,%edx
 7ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 802:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 805:	8b 45 f8             	mov    -0x8(%ebp),%eax
 808:	8b 10                	mov    (%eax),%edx
 80a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80d:	89 10                	mov    %edx,(%eax)
 80f:	eb 08                	jmp    819 <free+0xdb>
  } else
    p->s.ptr = bp;
 811:	8b 45 fc             	mov    -0x4(%ebp),%eax
 814:	8b 55 f8             	mov    -0x8(%ebp),%edx
 817:	89 10                	mov    %edx,(%eax)
  freep = p;
 819:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81c:	a3 28 13 00 00       	mov    %eax,0x1328
}
 821:	90                   	nop
 822:	c9                   	leave  
 823:	c3                   	ret    

00000824 <morecore>:

static Header*
morecore(uint nu)
{
 824:	f3 0f 1e fb          	endbr32 
 828:	55                   	push   %ebp
 829:	89 e5                	mov    %esp,%ebp
 82b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 82e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 835:	77 07                	ja     83e <morecore+0x1a>
    nu = 4096;
 837:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 83e:	8b 45 08             	mov    0x8(%ebp),%eax
 841:	c1 e0 03             	shl    $0x3,%eax
 844:	83 ec 0c             	sub    $0xc,%esp
 847:	50                   	push   %eax
 848:	e8 17 fc ff ff       	call   464 <sbrk>
 84d:	83 c4 10             	add    $0x10,%esp
 850:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 853:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 857:	75 07                	jne    860 <morecore+0x3c>
    return 0;
 859:	b8 00 00 00 00       	mov    $0x0,%eax
 85e:	eb 26                	jmp    886 <morecore+0x62>
  hp = (Header*)p;
 860:	8b 45 f4             	mov    -0xc(%ebp),%eax
 863:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 866:	8b 45 f0             	mov    -0x10(%ebp),%eax
 869:	8b 55 08             	mov    0x8(%ebp),%edx
 86c:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 86f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 872:	83 c0 08             	add    $0x8,%eax
 875:	83 ec 0c             	sub    $0xc,%esp
 878:	50                   	push   %eax
 879:	e8 c0 fe ff ff       	call   73e <free>
 87e:	83 c4 10             	add    $0x10,%esp
  return freep;
 881:	a1 28 13 00 00       	mov    0x1328,%eax
}
 886:	c9                   	leave  
 887:	c3                   	ret    

00000888 <malloc>:

void*
malloc(uint nbytes)
{
 888:	f3 0f 1e fb          	endbr32 
 88c:	55                   	push   %ebp
 88d:	89 e5                	mov    %esp,%ebp
 88f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 892:	8b 45 08             	mov    0x8(%ebp),%eax
 895:	83 c0 07             	add    $0x7,%eax
 898:	c1 e8 03             	shr    $0x3,%eax
 89b:	83 c0 01             	add    $0x1,%eax
 89e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8a1:	a1 28 13 00 00       	mov    0x1328,%eax
 8a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8a9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8ad:	75 23                	jne    8d2 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 8af:	c7 45 f0 20 13 00 00 	movl   $0x1320,-0x10(%ebp)
 8b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b9:	a3 28 13 00 00       	mov    %eax,0x1328
 8be:	a1 28 13 00 00       	mov    0x1328,%eax
 8c3:	a3 20 13 00 00       	mov    %eax,0x1320
    base.s.size = 0;
 8c8:	c7 05 24 13 00 00 00 	movl   $0x0,0x1324
 8cf:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d5:	8b 00                	mov    (%eax),%eax
 8d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8dd:	8b 40 04             	mov    0x4(%eax),%eax
 8e0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 8e3:	77 4d                	ja     932 <malloc+0xaa>
      if(p->s.size == nunits)
 8e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e8:	8b 40 04             	mov    0x4(%eax),%eax
 8eb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 8ee:	75 0c                	jne    8fc <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 8f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f3:	8b 10                	mov    (%eax),%edx
 8f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f8:	89 10                	mov    %edx,(%eax)
 8fa:	eb 26                	jmp    922 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 8fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ff:	8b 40 04             	mov    0x4(%eax),%eax
 902:	2b 45 ec             	sub    -0x14(%ebp),%eax
 905:	89 c2                	mov    %eax,%edx
 907:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 90d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 910:	8b 40 04             	mov    0x4(%eax),%eax
 913:	c1 e0 03             	shl    $0x3,%eax
 916:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 919:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 91f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 922:	8b 45 f0             	mov    -0x10(%ebp),%eax
 925:	a3 28 13 00 00       	mov    %eax,0x1328
      return (void*)(p + 1);
 92a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92d:	83 c0 08             	add    $0x8,%eax
 930:	eb 3b                	jmp    96d <malloc+0xe5>
    }
    if(p == freep)
 932:	a1 28 13 00 00       	mov    0x1328,%eax
 937:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 93a:	75 1e                	jne    95a <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 93c:	83 ec 0c             	sub    $0xc,%esp
 93f:	ff 75 ec             	pushl  -0x14(%ebp)
 942:	e8 dd fe ff ff       	call   824 <morecore>
 947:	83 c4 10             	add    $0x10,%esp
 94a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 94d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 951:	75 07                	jne    95a <malloc+0xd2>
        return 0;
 953:	b8 00 00 00 00       	mov    $0x0,%eax
 958:	eb 13                	jmp    96d <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 95a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 960:	8b 45 f4             	mov    -0xc(%ebp),%eax
 963:	8b 00                	mov    (%eax),%eax
 965:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 968:	e9 6d ff ff ff       	jmp    8da <malloc+0x52>
  }
}
 96d:	c9                   	leave  
 96e:	c3                   	ret    

0000096f <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
 96f:	f3 0f 1e fb          	endbr32 
 973:	55                   	push   %ebp
 974:	89 e5                	mov    %esp,%ebp
 976:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 979:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 980:	a1 80 13 00 00       	mov    0x1380,%eax
 985:	83 ec 04             	sub    $0x4,%esp
 988:	50                   	push   %eax
 989:	6a 20                	push   $0x20
 98b:	68 60 13 00 00       	push   $0x1360
 990:	e8 11 f8 ff ff       	call   1a6 <fgets>
 995:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 998:	83 ec 0c             	sub    $0xc,%esp
 99b:	68 60 13 00 00       	push   $0x1360
 9a0:	e8 0e f7 ff ff       	call   b3 <strlen>
 9a5:	83 c4 10             	add    $0x10,%esp
 9a8:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 9ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9ae:	83 e8 01             	sub    $0x1,%eax
 9b1:	0f b6 80 60 13 00 00 	movzbl 0x1360(%eax),%eax
 9b8:	3c 0a                	cmp    $0xa,%al
 9ba:	74 11                	je     9cd <get_id+0x5e>
 9bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9bf:	83 e8 01             	sub    $0x1,%eax
 9c2:	0f b6 80 60 13 00 00 	movzbl 0x1360(%eax),%eax
 9c9:	3c 0d                	cmp    $0xd,%al
 9cb:	75 0d                	jne    9da <get_id+0x6b>
        current_line[len - 1] = 0;
 9cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9d0:	83 e8 01             	sub    $0x1,%eax
 9d3:	c6 80 60 13 00 00 00 	movb   $0x0,0x1360(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 9da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 9e1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 9e8:	eb 6c                	jmp    a56 <get_id+0xe7>
        if(current_line[i] == ' '){
 9ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
 9ed:	05 60 13 00 00       	add    $0x1360,%eax
 9f2:	0f b6 00             	movzbl (%eax),%eax
 9f5:	3c 20                	cmp    $0x20,%al
 9f7:	75 30                	jne    a29 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 9f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9fd:	75 16                	jne    a15 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 9ff:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a02:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a05:	8d 50 01             	lea    0x1(%eax),%edx
 a08:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a0b:	8d 91 60 13 00 00    	lea    0x1360(%ecx),%edx
 a11:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 a15:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a18:	05 60 13 00 00       	add    $0x1360,%eax
 a1d:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 a20:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a27:	eb 29                	jmp    a52 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 a29:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a2d:	75 23                	jne    a52 <get_id+0xe3>
 a2f:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 a33:	7f 1d                	jg     a52 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 a35:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 a3c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a42:	8d 50 01             	lea    0x1(%eax),%edx
 a45:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a48:	8d 91 60 13 00 00    	lea    0x1360(%ecx),%edx
 a4e:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 a52:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 a56:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a59:	05 60 13 00 00       	add    $0x1360,%eax
 a5e:	0f b6 00             	movzbl (%eax),%eax
 a61:	84 c0                	test   %al,%al
 a63:	75 85                	jne    9ea <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 a65:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 a69:	75 07                	jne    a72 <get_id+0x103>
        return -1;
 a6b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a70:	eb 35                	jmp    aa7 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
 a72:	8b 45 dc             	mov    -0x24(%ebp),%eax
 a75:	a3 40 13 00 00       	mov    %eax,0x1340
    current_id.uid_user = atoi(tokens[1]);
 a7a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 a7d:	83 ec 0c             	sub    $0xc,%esp
 a80:	50                   	push   %eax
 a81:	e8 e5 f7 ff ff       	call   26b <atoi>
 a86:	83 c4 10             	add    $0x10,%esp
 a89:	a3 44 13 00 00       	mov    %eax,0x1344
    current_id.gid_user = atoi(tokens[2]);
 a8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 a91:	83 ec 0c             	sub    $0xc,%esp
 a94:	50                   	push   %eax
 a95:	e8 d1 f7 ff ff       	call   26b <atoi>
 a9a:	83 c4 10             	add    $0x10,%esp
 a9d:	a3 48 13 00 00       	mov    %eax,0x1348

    return 0;
 aa2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 aa7:	c9                   	leave  
 aa8:	c3                   	ret    

00000aa9 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
 aa9:	f3 0f 1e fb          	endbr32 
 aad:	55                   	push   %ebp
 aae:	89 e5                	mov    %esp,%ebp
 ab0:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 ab3:	a1 80 13 00 00       	mov    0x1380,%eax
 ab8:	85 c0                	test   %eax,%eax
 aba:	75 31                	jne    aed <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
 abc:	83 ec 08             	sub    $0x8,%esp
 abf:	6a 00                	push   $0x0
 ac1:	68 ca 0e 00 00       	push   $0xeca
 ac6:	e8 51 f9 ff ff       	call   41c <open>
 acb:	83 c4 10             	add    $0x10,%esp
 ace:	a3 80 13 00 00       	mov    %eax,0x1380

        if(dir < 0){        // kalau gagal membuka file
 ad3:	a1 80 13 00 00       	mov    0x1380,%eax
 ad8:	85 c0                	test   %eax,%eax
 ada:	79 11                	jns    aed <getid+0x44>
            dir = 0;
 adc:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 ae3:	00 00 00 
            return 0;
 ae6:	b8 00 00 00 00       	mov    $0x0,%eax
 aeb:	eb 16                	jmp    b03 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
 aed:	e8 7d fe ff ff       	call   96f <get_id>
 af2:	83 f8 ff             	cmp    $0xffffffff,%eax
 af5:	75 07                	jne    afe <getid+0x55>
        return 0;
 af7:	b8 00 00 00 00       	mov    $0x0,%eax
 afc:	eb 05                	jmp    b03 <getid+0x5a>
    
    return &current_id;
 afe:	b8 40 13 00 00       	mov    $0x1340,%eax
}
 b03:	c9                   	leave  
 b04:	c3                   	ret    

00000b05 <setid>:

// open file_ids
void setid(void){
 b05:	f3 0f 1e fb          	endbr32 
 b09:	55                   	push   %ebp
 b0a:	89 e5                	mov    %esp,%ebp
 b0c:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b0f:	a1 80 13 00 00       	mov    0x1380,%eax
 b14:	85 c0                	test   %eax,%eax
 b16:	74 1b                	je     b33 <setid+0x2e>
        close(dir);
 b18:	a1 80 13 00 00       	mov    0x1380,%eax
 b1d:	83 ec 0c             	sub    $0xc,%esp
 b20:	50                   	push   %eax
 b21:	e8 de f8 ff ff       	call   404 <close>
 b26:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 b29:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 b30:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
 b33:	83 ec 08             	sub    $0x8,%esp
 b36:	6a 00                	push   $0x0
 b38:	68 ca 0e 00 00       	push   $0xeca
 b3d:	e8 da f8 ff ff       	call   41c <open>
 b42:	83 c4 10             	add    $0x10,%esp
 b45:	a3 80 13 00 00       	mov    %eax,0x1380

    if (dir < 0)
 b4a:	a1 80 13 00 00       	mov    0x1380,%eax
 b4f:	85 c0                	test   %eax,%eax
 b51:	79 0a                	jns    b5d <setid+0x58>
        dir = 0;
 b53:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 b5a:	00 00 00 
}
 b5d:	90                   	nop
 b5e:	c9                   	leave  
 b5f:	c3                   	ret    

00000b60 <endid>:

// tutup file_ids
void endid (void){
 b60:	f3 0f 1e fb          	endbr32 
 b64:	55                   	push   %ebp
 b65:	89 e5                	mov    %esp,%ebp
 b67:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b6a:	a1 80 13 00 00       	mov    0x1380,%eax
 b6f:	85 c0                	test   %eax,%eax
 b71:	74 1b                	je     b8e <endid+0x2e>
        close(dir);
 b73:	a1 80 13 00 00       	mov    0x1380,%eax
 b78:	83 ec 0c             	sub    $0xc,%esp
 b7b:	50                   	push   %eax
 b7c:	e8 83 f8 ff ff       	call   404 <close>
 b81:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 b84:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 b8b:	00 00 00 
    }
}
 b8e:	90                   	nop
 b8f:	c9                   	leave  
 b90:	c3                   	ret    

00000b91 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
 b91:	f3 0f 1e fb          	endbr32 
 b95:	55                   	push   %ebp
 b96:	89 e5                	mov    %esp,%ebp
 b98:	83 ec 08             	sub    $0x8,%esp
    setid();
 b9b:	e8 65 ff ff ff       	call   b05 <setid>

    while (getid()){
 ba0:	eb 24                	jmp    bc6 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
 ba2:	a1 40 13 00 00       	mov    0x1340,%eax
 ba7:	83 ec 08             	sub    $0x8,%esp
 baa:	50                   	push   %eax
 bab:	ff 75 08             	pushl  0x8(%ebp)
 bae:	e8 bd f4 ff ff       	call   70 <strcmp>
 bb3:	83 c4 10             	add    $0x10,%esp
 bb6:	85 c0                	test   %eax,%eax
 bb8:	75 0c                	jne    bc6 <cek_nama+0x35>
            endid();
 bba:	e8 a1 ff ff ff       	call   b60 <endid>
            return &current_id;
 bbf:	b8 40 13 00 00       	mov    $0x1340,%eax
 bc4:	eb 13                	jmp    bd9 <cek_nama+0x48>
    while (getid()){
 bc6:	e8 de fe ff ff       	call   aa9 <getid>
 bcb:	85 c0                	test   %eax,%eax
 bcd:	75 d3                	jne    ba2 <cek_nama+0x11>
        }
    }
    endid();
 bcf:	e8 8c ff ff ff       	call   b60 <endid>
    return 0;
 bd4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 bd9:	c9                   	leave  
 bda:	c3                   	ret    

00000bdb <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
 bdb:	f3 0f 1e fb          	endbr32 
 bdf:	55                   	push   %ebp
 be0:	89 e5                	mov    %esp,%ebp
 be2:	83 ec 08             	sub    $0x8,%esp
    setid();
 be5:	e8 1b ff ff ff       	call   b05 <setid>

    while (getid()){
 bea:	eb 16                	jmp    c02 <cek_uid+0x27>
        if(current_id.uid_user == uid){
 bec:	a1 44 13 00 00       	mov    0x1344,%eax
 bf1:	39 45 08             	cmp    %eax,0x8(%ebp)
 bf4:	75 0c                	jne    c02 <cek_uid+0x27>
            endid();
 bf6:	e8 65 ff ff ff       	call   b60 <endid>
            return &current_id;
 bfb:	b8 40 13 00 00       	mov    $0x1340,%eax
 c00:	eb 13                	jmp    c15 <cek_uid+0x3a>
    while (getid()){
 c02:	e8 a2 fe ff ff       	call   aa9 <getid>
 c07:	85 c0                	test   %eax,%eax
 c09:	75 e1                	jne    bec <cek_uid+0x11>
        }
    }
    endid();
 c0b:	e8 50 ff ff ff       	call   b60 <endid>
    return 0;
 c10:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c15:	c9                   	leave  
 c16:	c3                   	ret    

00000c17 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
 c17:	f3 0f 1e fb          	endbr32 
 c1b:	55                   	push   %ebp
 c1c:	89 e5                	mov    %esp,%ebp
 c1e:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 c21:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 c28:	a1 80 13 00 00       	mov    0x1380,%eax
 c2d:	83 ec 04             	sub    $0x4,%esp
 c30:	50                   	push   %eax
 c31:	6a 20                	push   $0x20
 c33:	68 60 13 00 00       	push   $0x1360
 c38:	e8 69 f5 ff ff       	call   1a6 <fgets>
 c3d:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 c40:	83 ec 0c             	sub    $0xc,%esp
 c43:	68 60 13 00 00       	push   $0x1360
 c48:	e8 66 f4 ff ff       	call   b3 <strlen>
 c4d:	83 c4 10             	add    $0x10,%esp
 c50:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 c53:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c56:	83 e8 01             	sub    $0x1,%eax
 c59:	0f b6 80 60 13 00 00 	movzbl 0x1360(%eax),%eax
 c60:	3c 0a                	cmp    $0xa,%al
 c62:	74 11                	je     c75 <get_group+0x5e>
 c64:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c67:	83 e8 01             	sub    $0x1,%eax
 c6a:	0f b6 80 60 13 00 00 	movzbl 0x1360(%eax),%eax
 c71:	3c 0d                	cmp    $0xd,%al
 c73:	75 0d                	jne    c82 <get_group+0x6b>
        current_line[len - 1] = 0;
 c75:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c78:	83 e8 01             	sub    $0x1,%eax
 c7b:	c6 80 60 13 00 00 00 	movb   $0x0,0x1360(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 c82:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 c89:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 c90:	eb 6c                	jmp    cfe <get_group+0xe7>
        if(current_line[i] == ' '){
 c92:	8b 45 ec             	mov    -0x14(%ebp),%eax
 c95:	05 60 13 00 00       	add    $0x1360,%eax
 c9a:	0f b6 00             	movzbl (%eax),%eax
 c9d:	3c 20                	cmp    $0x20,%al
 c9f:	75 30                	jne    cd1 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 ca1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 ca5:	75 16                	jne    cbd <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 ca7:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 caa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cad:	8d 50 01             	lea    0x1(%eax),%edx
 cb0:	89 55 f0             	mov    %edx,-0x10(%ebp)
 cb3:	8d 91 60 13 00 00    	lea    0x1360(%ecx),%edx
 cb9:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 cbd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 cc0:	05 60 13 00 00       	add    $0x1360,%eax
 cc5:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 cc8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 ccf:	eb 29                	jmp    cfa <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 cd1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 cd5:	75 23                	jne    cfa <get_group+0xe3>
 cd7:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 cdb:	7f 1d                	jg     cfa <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 cdd:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 ce4:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 ce7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cea:	8d 50 01             	lea    0x1(%eax),%edx
 ced:	89 55 f0             	mov    %edx,-0x10(%ebp)
 cf0:	8d 91 60 13 00 00    	lea    0x1360(%ecx),%edx
 cf6:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 cfa:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 cfe:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d01:	05 60 13 00 00       	add    $0x1360,%eax
 d06:	0f b6 00             	movzbl (%eax),%eax
 d09:	84 c0                	test   %al,%al
 d0b:	75 85                	jne    c92 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 d0d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 d11:	75 07                	jne    d1a <get_group+0x103>
        return -1;
 d13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d18:	eb 21                	jmp    d3b <get_group+0x124>
    
    current_group.nama_group = tokens[0];
 d1a:	8b 45 dc             	mov    -0x24(%ebp),%eax
 d1d:	a3 4c 13 00 00       	mov    %eax,0x134c
    current_group.gid = atoi(tokens[1]);
 d22:	8b 45 e0             	mov    -0x20(%ebp),%eax
 d25:	83 ec 0c             	sub    $0xc,%esp
 d28:	50                   	push   %eax
 d29:	e8 3d f5 ff ff       	call   26b <atoi>
 d2e:	83 c4 10             	add    $0x10,%esp
 d31:	a3 50 13 00 00       	mov    %eax,0x1350

    return 0;
 d36:	b8 00 00 00 00       	mov    $0x0,%eax
}
 d3b:	c9                   	leave  
 d3c:	c3                   	ret    

00000d3d <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
 d3d:	f3 0f 1e fb          	endbr32 
 d41:	55                   	push   %ebp
 d42:	89 e5                	mov    %esp,%ebp
 d44:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 d47:	a1 80 13 00 00       	mov    0x1380,%eax
 d4c:	85 c0                	test   %eax,%eax
 d4e:	75 31                	jne    d81 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
 d50:	83 ec 08             	sub    $0x8,%esp
 d53:	6a 00                	push   $0x0
 d55:	68 d2 0e 00 00       	push   $0xed2
 d5a:	e8 bd f6 ff ff       	call   41c <open>
 d5f:	83 c4 10             	add    $0x10,%esp
 d62:	a3 80 13 00 00       	mov    %eax,0x1380

        if(dir < 0){        // kalau gagal membuka file
 d67:	a1 80 13 00 00       	mov    0x1380,%eax
 d6c:	85 c0                	test   %eax,%eax
 d6e:	79 11                	jns    d81 <getgroup+0x44>
            dir = 0;
 d70:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 d77:	00 00 00 
            return 0;
 d7a:	b8 00 00 00 00       	mov    $0x0,%eax
 d7f:	eb 16                	jmp    d97 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
 d81:	e8 91 fe ff ff       	call   c17 <get_group>
 d86:	83 f8 ff             	cmp    $0xffffffff,%eax
 d89:	75 07                	jne    d92 <getgroup+0x55>
        return 0;
 d8b:	b8 00 00 00 00       	mov    $0x0,%eax
 d90:	eb 05                	jmp    d97 <getgroup+0x5a>
    
    return &current_group;
 d92:	b8 4c 13 00 00       	mov    $0x134c,%eax
}
 d97:	c9                   	leave  
 d98:	c3                   	ret    

00000d99 <setgroup>:

// open file_ids
void setgroup(void){
 d99:	f3 0f 1e fb          	endbr32 
 d9d:	55                   	push   %ebp
 d9e:	89 e5                	mov    %esp,%ebp
 da0:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 da3:	a1 80 13 00 00       	mov    0x1380,%eax
 da8:	85 c0                	test   %eax,%eax
 daa:	74 1b                	je     dc7 <setgroup+0x2e>
        close(dir);
 dac:	a1 80 13 00 00       	mov    0x1380,%eax
 db1:	83 ec 0c             	sub    $0xc,%esp
 db4:	50                   	push   %eax
 db5:	e8 4a f6 ff ff       	call   404 <close>
 dba:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 dbd:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 dc4:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
 dc7:	83 ec 08             	sub    $0x8,%esp
 dca:	6a 00                	push   $0x0
 dcc:	68 d2 0e 00 00       	push   $0xed2
 dd1:	e8 46 f6 ff ff       	call   41c <open>
 dd6:	83 c4 10             	add    $0x10,%esp
 dd9:	a3 80 13 00 00       	mov    %eax,0x1380

    if (dir < 0)
 dde:	a1 80 13 00 00       	mov    0x1380,%eax
 de3:	85 c0                	test   %eax,%eax
 de5:	79 0a                	jns    df1 <setgroup+0x58>
        dir = 0;
 de7:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 dee:	00 00 00 
}
 df1:	90                   	nop
 df2:	c9                   	leave  
 df3:	c3                   	ret    

00000df4 <endgroup>:

// tutup file_ids
void endgroup (void){
 df4:	f3 0f 1e fb          	endbr32 
 df8:	55                   	push   %ebp
 df9:	89 e5                	mov    %esp,%ebp
 dfb:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 dfe:	a1 80 13 00 00       	mov    0x1380,%eax
 e03:	85 c0                	test   %eax,%eax
 e05:	74 1b                	je     e22 <endgroup+0x2e>
        close(dir);
 e07:	a1 80 13 00 00       	mov    0x1380,%eax
 e0c:	83 ec 0c             	sub    $0xc,%esp
 e0f:	50                   	push   %eax
 e10:	e8 ef f5 ff ff       	call   404 <close>
 e15:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e18:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 e1f:	00 00 00 
    }
}
 e22:	90                   	nop
 e23:	c9                   	leave  
 e24:	c3                   	ret    

00000e25 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
 e25:	f3 0f 1e fb          	endbr32 
 e29:	55                   	push   %ebp
 e2a:	89 e5                	mov    %esp,%ebp
 e2c:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 e2f:	e8 65 ff ff ff       	call   d99 <setgroup>

    while (getgroup()){
 e34:	eb 3c                	jmp    e72 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
 e36:	a1 4c 13 00 00       	mov    0x134c,%eax
 e3b:	83 ec 08             	sub    $0x8,%esp
 e3e:	50                   	push   %eax
 e3f:	ff 75 08             	pushl  0x8(%ebp)
 e42:	e8 29 f2 ff ff       	call   70 <strcmp>
 e47:	83 c4 10             	add    $0x10,%esp
 e4a:	85 c0                	test   %eax,%eax
 e4c:	75 24                	jne    e72 <cek_nama_group+0x4d>
            endgroup();
 e4e:	e8 a1 ff ff ff       	call   df4 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
 e53:	a1 4c 13 00 00       	mov    0x134c,%eax
 e58:	83 ec 04             	sub    $0x4,%esp
 e5b:	50                   	push   %eax
 e5c:	68 dd 0e 00 00       	push   $0xedd
 e61:	6a 01                	push   $0x1
 e63:	e8 40 f7 ff ff       	call   5a8 <printf>
 e68:	83 c4 10             	add    $0x10,%esp
            return &current_group;
 e6b:	b8 4c 13 00 00       	mov    $0x134c,%eax
 e70:	eb 13                	jmp    e85 <cek_nama_group+0x60>
    while (getgroup()){
 e72:	e8 c6 fe ff ff       	call   d3d <getgroup>
 e77:	85 c0                	test   %eax,%eax
 e79:	75 bb                	jne    e36 <cek_nama_group+0x11>
        }
    }
    endgroup();
 e7b:	e8 74 ff ff ff       	call   df4 <endgroup>
    return 0;
 e80:	b8 00 00 00 00       	mov    $0x0,%eax
}
 e85:	c9                   	leave  
 e86:	c3                   	ret    

00000e87 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
 e87:	f3 0f 1e fb          	endbr32 
 e8b:	55                   	push   %ebp
 e8c:	89 e5                	mov    %esp,%ebp
 e8e:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 e91:	e8 03 ff ff ff       	call   d99 <setgroup>

    while (getgroup()){
 e96:	eb 16                	jmp    eae <cek_gid+0x27>
        if(current_group.gid == gid){
 e98:	a1 50 13 00 00       	mov    0x1350,%eax
 e9d:	39 45 08             	cmp    %eax,0x8(%ebp)
 ea0:	75 0c                	jne    eae <cek_gid+0x27>
            endgroup();
 ea2:	e8 4d ff ff ff       	call   df4 <endgroup>
            return &current_group;
 ea7:	b8 4c 13 00 00       	mov    $0x134c,%eax
 eac:	eb 13                	jmp    ec1 <cek_gid+0x3a>
    while (getgroup()){
 eae:	e8 8a fe ff ff       	call   d3d <getgroup>
 eb3:	85 c0                	test   %eax,%eax
 eb5:	75 e1                	jne    e98 <cek_gid+0x11>
        }
    }
    endgroup();
 eb7:	e8 38 ff ff ff       	call   df4 <endgroup>
    return 0;
 ebc:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ec1:	c9                   	leave  
 ec2:	c3                   	ret    
