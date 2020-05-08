
_echo:     file format elf32-i386


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
  13:	83 ec 10             	sub    $0x10,%esp
  16:	89 cb                	mov    %ecx,%ebx
  int i;

  for(i = 1; i < argc; i++)
  18:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  1f:	eb 3c                	jmp    5d <main+0x5d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  21:	8b 45 f4             	mov    -0xc(%ebp),%eax
  24:	83 c0 01             	add    $0x1,%eax
  27:	39 03                	cmp    %eax,(%ebx)
  29:	7e 07                	jle    32 <main+0x32>
  2b:	b9 16 0f 00 00       	mov    $0xf16,%ecx
  30:	eb 05                	jmp    37 <main+0x37>
  32:	b9 18 0f 00 00       	mov    $0xf18,%ecx
  37:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  41:	8b 43 04             	mov    0x4(%ebx),%eax
  44:	01 d0                	add    %edx,%eax
  46:	8b 00                	mov    (%eax),%eax
  48:	51                   	push   %ecx
  49:	50                   	push   %eax
  4a:	68 1a 0f 00 00       	push   $0xf1a
  4f:	6a 01                	push   $0x1
  51:	e8 a5 05 00 00       	call   5fb <printf>
  56:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++)
  59:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  60:	3b 03                	cmp    (%ebx),%eax
  62:	7c bd                	jl     21 <main+0x21>
  exit();
  64:	e8 c6 03 00 00       	call   42f <exit>

00000069 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  69:	55                   	push   %ebp
  6a:	89 e5                	mov    %esp,%ebp
  6c:	57                   	push   %edi
  6d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  71:	8b 55 10             	mov    0x10(%ebp),%edx
  74:	8b 45 0c             	mov    0xc(%ebp),%eax
  77:	89 cb                	mov    %ecx,%ebx
  79:	89 df                	mov    %ebx,%edi
  7b:	89 d1                	mov    %edx,%ecx
  7d:	fc                   	cld    
  7e:	f3 aa                	rep stos %al,%es:(%edi)
  80:	89 ca                	mov    %ecx,%edx
  82:	89 fb                	mov    %edi,%ebx
  84:	89 5d 08             	mov    %ebx,0x8(%ebp)
  87:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  8a:	90                   	nop
  8b:	5b                   	pop    %ebx
  8c:	5f                   	pop    %edi
  8d:	5d                   	pop    %ebp
  8e:	c3                   	ret    

0000008f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8f:	f3 0f 1e fb          	endbr32 
  93:	55                   	push   %ebp
  94:	89 e5                	mov    %esp,%ebp
  96:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  99:	8b 45 08             	mov    0x8(%ebp),%eax
  9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  9f:	90                   	nop
  a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  a3:	8d 42 01             	lea    0x1(%edx),%eax
  a6:	89 45 0c             	mov    %eax,0xc(%ebp)
  a9:	8b 45 08             	mov    0x8(%ebp),%eax
  ac:	8d 48 01             	lea    0x1(%eax),%ecx
  af:	89 4d 08             	mov    %ecx,0x8(%ebp)
  b2:	0f b6 12             	movzbl (%edx),%edx
  b5:	88 10                	mov    %dl,(%eax)
  b7:	0f b6 00             	movzbl (%eax),%eax
  ba:	84 c0                	test   %al,%al
  bc:	75 e2                	jne    a0 <strcpy+0x11>
    ;
  return os;
  be:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c1:	c9                   	leave  
  c2:	c3                   	ret    

000000c3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c3:	f3 0f 1e fb          	endbr32 
  c7:	55                   	push   %ebp
  c8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  ca:	eb 08                	jmp    d4 <strcmp+0x11>
    p++, q++;
  cc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	0f b6 00             	movzbl (%eax),%eax
  da:	84 c0                	test   %al,%al
  dc:	74 10                	je     ee <strcmp+0x2b>
  de:	8b 45 08             	mov    0x8(%ebp),%eax
  e1:	0f b6 10             	movzbl (%eax),%edx
  e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  e7:	0f b6 00             	movzbl (%eax),%eax
  ea:	38 c2                	cmp    %al,%dl
  ec:	74 de                	je     cc <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
  ee:	8b 45 08             	mov    0x8(%ebp),%eax
  f1:	0f b6 00             	movzbl (%eax),%eax
  f4:	0f b6 d0             	movzbl %al,%edx
  f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  fa:	0f b6 00             	movzbl (%eax),%eax
  fd:	0f b6 c0             	movzbl %al,%eax
 100:	29 c2                	sub    %eax,%edx
 102:	89 d0                	mov    %edx,%eax
}
 104:	5d                   	pop    %ebp
 105:	c3                   	ret    

00000106 <strlen>:

uint
strlen(char *s)
{
 106:	f3 0f 1e fb          	endbr32 
 10a:	55                   	push   %ebp
 10b:	89 e5                	mov    %esp,%ebp
 10d:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 110:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 117:	eb 04                	jmp    11d <strlen+0x17>
 119:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 11d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 120:	8b 45 08             	mov    0x8(%ebp),%eax
 123:	01 d0                	add    %edx,%eax
 125:	0f b6 00             	movzbl (%eax),%eax
 128:	84 c0                	test   %al,%al
 12a:	75 ed                	jne    119 <strlen+0x13>
    ;
  return n;
 12c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12f:	c9                   	leave  
 130:	c3                   	ret    

00000131 <memset>:

void*
memset(void *dst, int c, uint n)
{
 131:	f3 0f 1e fb          	endbr32 
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 138:	8b 45 10             	mov    0x10(%ebp),%eax
 13b:	50                   	push   %eax
 13c:	ff 75 0c             	pushl  0xc(%ebp)
 13f:	ff 75 08             	pushl  0x8(%ebp)
 142:	e8 22 ff ff ff       	call   69 <stosb>
 147:	83 c4 0c             	add    $0xc,%esp
  return dst;
 14a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 14d:	c9                   	leave  
 14e:	c3                   	ret    

0000014f <strchr>:

char*
strchr(const char *s, char c)
{
 14f:	f3 0f 1e fb          	endbr32 
 153:	55                   	push   %ebp
 154:	89 e5                	mov    %esp,%ebp
 156:	83 ec 04             	sub    $0x4,%esp
 159:	8b 45 0c             	mov    0xc(%ebp),%eax
 15c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 15f:	eb 14                	jmp    175 <strchr+0x26>
    if(*s == c)
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	0f b6 00             	movzbl (%eax),%eax
 167:	38 45 fc             	cmp    %al,-0x4(%ebp)
 16a:	75 05                	jne    171 <strchr+0x22>
      return (char*)s;
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	eb 13                	jmp    184 <strchr+0x35>
  for(; *s; s++)
 171:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 175:	8b 45 08             	mov    0x8(%ebp),%eax
 178:	0f b6 00             	movzbl (%eax),%eax
 17b:	84 c0                	test   %al,%al
 17d:	75 e2                	jne    161 <strchr+0x12>
  return 0;
 17f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 184:	c9                   	leave  
 185:	c3                   	ret    

00000186 <gets>:

char*
gets(char *buf, int max)
{
 186:	f3 0f 1e fb          	endbr32 
 18a:	55                   	push   %ebp
 18b:	89 e5                	mov    %esp,%ebp
 18d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 190:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 197:	eb 42                	jmp    1db <gets+0x55>
    cc = read(0, &c, 1);
 199:	83 ec 04             	sub    $0x4,%esp
 19c:	6a 01                	push   $0x1
 19e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1a1:	50                   	push   %eax
 1a2:	6a 00                	push   $0x0
 1a4:	e8 9e 02 00 00       	call   447 <read>
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1b3:	7e 33                	jle    1e8 <gets+0x62>
      break;
    buf[i++] = c;
 1b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b8:	8d 50 01             	lea    0x1(%eax),%edx
 1bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1be:	89 c2                	mov    %eax,%edx
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
 1c3:	01 c2                	add    %eax,%edx
 1c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1cb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1cf:	3c 0a                	cmp    $0xa,%al
 1d1:	74 16                	je     1e9 <gets+0x63>
 1d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d7:	3c 0d                	cmp    $0xd,%al
 1d9:	74 0e                	je     1e9 <gets+0x63>
  for(i=0; i+1 < max; ){
 1db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1de:	83 c0 01             	add    $0x1,%eax
 1e1:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1e4:	7f b3                	jg     199 <gets+0x13>
 1e6:	eb 01                	jmp    1e9 <gets+0x63>
      break;
 1e8:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	01 d0                	add    %edx,%eax
 1f1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1f4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f7:	c9                   	leave  
 1f8:	c3                   	ret    

000001f9 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
 1f9:	f3 0f 1e fb          	endbr32 
 1fd:	55                   	push   %ebp
 1fe:	89 e5                	mov    %esp,%ebp
 200:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
 203:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 20a:	eb 43                	jmp    24f <fgets+0x56>
    int cc = read(fd, &c, 1);
 20c:	83 ec 04             	sub    $0x4,%esp
 20f:	6a 01                	push   $0x1
 211:	8d 45 ef             	lea    -0x11(%ebp),%eax
 214:	50                   	push   %eax
 215:	ff 75 10             	pushl  0x10(%ebp)
 218:	e8 2a 02 00 00       	call   447 <read>
 21d:	83 c4 10             	add    $0x10,%esp
 220:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 223:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 227:	7e 33                	jle    25c <fgets+0x63>
      break;
    buf[i++] = c;
 229:	8b 45 f4             	mov    -0xc(%ebp),%eax
 22c:	8d 50 01             	lea    0x1(%eax),%edx
 22f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 232:	89 c2                	mov    %eax,%edx
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	01 c2                	add    %eax,%edx
 239:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 23d:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 23f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 243:	3c 0a                	cmp    $0xa,%al
 245:	74 16                	je     25d <fgets+0x64>
 247:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 24b:	3c 0d                	cmp    $0xd,%al
 24d:	74 0e                	je     25d <fgets+0x64>
  for(i = 0; i + 1 < size;){
 24f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 252:	83 c0 01             	add    $0x1,%eax
 255:	39 45 0c             	cmp    %eax,0xc(%ebp)
 258:	7f b2                	jg     20c <fgets+0x13>
 25a:	eb 01                	jmp    25d <fgets+0x64>
      break;
 25c:	90                   	nop
      break;
  }
  buf[i] = '\0';
 25d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 260:	8b 45 08             	mov    0x8(%ebp),%eax
 263:	01 d0                	add    %edx,%eax
 265:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 268:	8b 45 08             	mov    0x8(%ebp),%eax
}
 26b:	c9                   	leave  
 26c:	c3                   	ret    

0000026d <stat>:

int
stat(char *n, struct stat *st)
{
 26d:	f3 0f 1e fb          	endbr32 
 271:	55                   	push   %ebp
 272:	89 e5                	mov    %esp,%ebp
 274:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 277:	83 ec 08             	sub    $0x8,%esp
 27a:	6a 00                	push   $0x0
 27c:	ff 75 08             	pushl  0x8(%ebp)
 27f:	e8 eb 01 00 00       	call   46f <open>
 284:	83 c4 10             	add    $0x10,%esp
 287:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 28a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 28e:	79 07                	jns    297 <stat+0x2a>
    return -1;
 290:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 295:	eb 25                	jmp    2bc <stat+0x4f>
  r = fstat(fd, st);
 297:	83 ec 08             	sub    $0x8,%esp
 29a:	ff 75 0c             	pushl  0xc(%ebp)
 29d:	ff 75 f4             	pushl  -0xc(%ebp)
 2a0:	e8 e2 01 00 00       	call   487 <fstat>
 2a5:	83 c4 10             	add    $0x10,%esp
 2a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2ab:	83 ec 0c             	sub    $0xc,%esp
 2ae:	ff 75 f4             	pushl  -0xc(%ebp)
 2b1:	e8 a1 01 00 00       	call   457 <close>
 2b6:	83 c4 10             	add    $0x10,%esp
  return r;
 2b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2bc:	c9                   	leave  
 2bd:	c3                   	ret    

000002be <atoi>:

int
atoi(const char *s)
{
 2be:	f3 0f 1e fb          	endbr32 
 2c2:	55                   	push   %ebp
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 2c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 2cf:	eb 04                	jmp    2d5 <atoi+0x17>
 2d1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2d5:	8b 45 08             	mov    0x8(%ebp),%eax
 2d8:	0f b6 00             	movzbl (%eax),%eax
 2db:	3c 20                	cmp    $0x20,%al
 2dd:	74 f2                	je     2d1 <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
 2df:	8b 45 08             	mov    0x8(%ebp),%eax
 2e2:	0f b6 00             	movzbl (%eax),%eax
 2e5:	3c 2d                	cmp    $0x2d,%al
 2e7:	75 07                	jne    2f0 <atoi+0x32>
 2e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ee:	eb 05                	jmp    2f5 <atoi+0x37>
 2f0:	b8 01 00 00 00       	mov    $0x1,%eax
 2f5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 2f8:	8b 45 08             	mov    0x8(%ebp),%eax
 2fb:	0f b6 00             	movzbl (%eax),%eax
 2fe:	3c 2b                	cmp    $0x2b,%al
 300:	74 0a                	je     30c <atoi+0x4e>
 302:	8b 45 08             	mov    0x8(%ebp),%eax
 305:	0f b6 00             	movzbl (%eax),%eax
 308:	3c 2d                	cmp    $0x2d,%al
 30a:	75 2b                	jne    337 <atoi+0x79>
    s++;
 30c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 310:	eb 25                	jmp    337 <atoi+0x79>
    n = n*10 + *s++ - '0';
 312:	8b 55 fc             	mov    -0x4(%ebp),%edx
 315:	89 d0                	mov    %edx,%eax
 317:	c1 e0 02             	shl    $0x2,%eax
 31a:	01 d0                	add    %edx,%eax
 31c:	01 c0                	add    %eax,%eax
 31e:	89 c1                	mov    %eax,%ecx
 320:	8b 45 08             	mov    0x8(%ebp),%eax
 323:	8d 50 01             	lea    0x1(%eax),%edx
 326:	89 55 08             	mov    %edx,0x8(%ebp)
 329:	0f b6 00             	movzbl (%eax),%eax
 32c:	0f be c0             	movsbl %al,%eax
 32f:	01 c8                	add    %ecx,%eax
 331:	83 e8 30             	sub    $0x30,%eax
 334:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 337:	8b 45 08             	mov    0x8(%ebp),%eax
 33a:	0f b6 00             	movzbl (%eax),%eax
 33d:	3c 2f                	cmp    $0x2f,%al
 33f:	7e 0a                	jle    34b <atoi+0x8d>
 341:	8b 45 08             	mov    0x8(%ebp),%eax
 344:	0f b6 00             	movzbl (%eax),%eax
 347:	3c 39                	cmp    $0x39,%al
 349:	7e c7                	jle    312 <atoi+0x54>
  return sign*n;
 34b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 34e:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 352:	c9                   	leave  
 353:	c3                   	ret    

00000354 <atoo>:

int
atoo(const char *s)
{
 354:	f3 0f 1e fb          	endbr32 
 358:	55                   	push   %ebp
 359:	89 e5                	mov    %esp,%ebp
 35b:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 35e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 365:	eb 04                	jmp    36b <atoo+0x17>
 367:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 36b:	8b 45 08             	mov    0x8(%ebp),%eax
 36e:	0f b6 00             	movzbl (%eax),%eax
 371:	3c 20                	cmp    $0x20,%al
 373:	74 f2                	je     367 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
 375:	8b 45 08             	mov    0x8(%ebp),%eax
 378:	0f b6 00             	movzbl (%eax),%eax
 37b:	3c 2d                	cmp    $0x2d,%al
 37d:	75 07                	jne    386 <atoo+0x32>
 37f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 384:	eb 05                	jmp    38b <atoo+0x37>
 386:	b8 01 00 00 00       	mov    $0x1,%eax
 38b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 38e:	8b 45 08             	mov    0x8(%ebp),%eax
 391:	0f b6 00             	movzbl (%eax),%eax
 394:	3c 2b                	cmp    $0x2b,%al
 396:	74 0a                	je     3a2 <atoo+0x4e>
 398:	8b 45 08             	mov    0x8(%ebp),%eax
 39b:	0f b6 00             	movzbl (%eax),%eax
 39e:	3c 2d                	cmp    $0x2d,%al
 3a0:	75 27                	jne    3c9 <atoo+0x75>
    s++;
 3a2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 3a6:	eb 21                	jmp    3c9 <atoo+0x75>
    n = n*8 + *s++ - '0';
 3a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ab:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 3b2:	8b 45 08             	mov    0x8(%ebp),%eax
 3b5:	8d 50 01             	lea    0x1(%eax),%edx
 3b8:	89 55 08             	mov    %edx,0x8(%ebp)
 3bb:	0f b6 00             	movzbl (%eax),%eax
 3be:	0f be c0             	movsbl %al,%eax
 3c1:	01 c8                	add    %ecx,%eax
 3c3:	83 e8 30             	sub    $0x30,%eax
 3c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
 3c9:	8b 45 08             	mov    0x8(%ebp),%eax
 3cc:	0f b6 00             	movzbl (%eax),%eax
 3cf:	3c 2f                	cmp    $0x2f,%al
 3d1:	7e 0a                	jle    3dd <atoo+0x89>
 3d3:	8b 45 08             	mov    0x8(%ebp),%eax
 3d6:	0f b6 00             	movzbl (%eax),%eax
 3d9:	3c 37                	cmp    $0x37,%al
 3db:	7e cb                	jle    3a8 <atoo+0x54>
  return sign*n;
 3dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3e0:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 3e4:	c9                   	leave  
 3e5:	c3                   	ret    

000003e6 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 3e6:	f3 0f 1e fb          	endbr32 
 3ea:	55                   	push   %ebp
 3eb:	89 e5                	mov    %esp,%ebp
 3ed:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3f0:	8b 45 08             	mov    0x8(%ebp),%eax
 3f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3fc:	eb 17                	jmp    415 <memmove+0x2f>
    *dst++ = *src++;
 3fe:	8b 55 f8             	mov    -0x8(%ebp),%edx
 401:	8d 42 01             	lea    0x1(%edx),%eax
 404:	89 45 f8             	mov    %eax,-0x8(%ebp)
 407:	8b 45 fc             	mov    -0x4(%ebp),%eax
 40a:	8d 48 01             	lea    0x1(%eax),%ecx
 40d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 410:	0f b6 12             	movzbl (%edx),%edx
 413:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 415:	8b 45 10             	mov    0x10(%ebp),%eax
 418:	8d 50 ff             	lea    -0x1(%eax),%edx
 41b:	89 55 10             	mov    %edx,0x10(%ebp)
 41e:	85 c0                	test   %eax,%eax
 420:	7f dc                	jg     3fe <memmove+0x18>
  return vdst;
 422:	8b 45 08             	mov    0x8(%ebp),%eax
}
 425:	c9                   	leave  
 426:	c3                   	ret    

00000427 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 427:	b8 01 00 00 00       	mov    $0x1,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret    

0000042f <exit>:
SYSCALL(exit)
 42f:	b8 02 00 00 00       	mov    $0x2,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret    

00000437 <wait>:
SYSCALL(wait)
 437:	b8 03 00 00 00       	mov    $0x3,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret    

0000043f <pipe>:
SYSCALL(pipe)
 43f:	b8 04 00 00 00       	mov    $0x4,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret    

00000447 <read>:
SYSCALL(read)
 447:	b8 05 00 00 00       	mov    $0x5,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret    

0000044f <write>:
SYSCALL(write)
 44f:	b8 10 00 00 00       	mov    $0x10,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret    

00000457 <close>:
SYSCALL(close)
 457:	b8 15 00 00 00       	mov    $0x15,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret    

0000045f <kill>:
SYSCALL(kill)
 45f:	b8 06 00 00 00       	mov    $0x6,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret    

00000467 <exec>:
SYSCALL(exec)
 467:	b8 07 00 00 00       	mov    $0x7,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret    

0000046f <open>:
SYSCALL(open)
 46f:	b8 0f 00 00 00       	mov    $0xf,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret    

00000477 <mknod>:
SYSCALL(mknod)
 477:	b8 11 00 00 00       	mov    $0x11,%eax
 47c:	cd 40                	int    $0x40
 47e:	c3                   	ret    

0000047f <unlink>:
SYSCALL(unlink)
 47f:	b8 12 00 00 00       	mov    $0x12,%eax
 484:	cd 40                	int    $0x40
 486:	c3                   	ret    

00000487 <fstat>:
SYSCALL(fstat)
 487:	b8 08 00 00 00       	mov    $0x8,%eax
 48c:	cd 40                	int    $0x40
 48e:	c3                   	ret    

0000048f <link>:
SYSCALL(link)
 48f:	b8 13 00 00 00       	mov    $0x13,%eax
 494:	cd 40                	int    $0x40
 496:	c3                   	ret    

00000497 <mkdir>:
SYSCALL(mkdir)
 497:	b8 14 00 00 00       	mov    $0x14,%eax
 49c:	cd 40                	int    $0x40
 49e:	c3                   	ret    

0000049f <chdir>:
SYSCALL(chdir)
 49f:	b8 09 00 00 00       	mov    $0x9,%eax
 4a4:	cd 40                	int    $0x40
 4a6:	c3                   	ret    

000004a7 <dup>:
SYSCALL(dup)
 4a7:	b8 0a 00 00 00       	mov    $0xa,%eax
 4ac:	cd 40                	int    $0x40
 4ae:	c3                   	ret    

000004af <getpid>:
SYSCALL(getpid)
 4af:	b8 0b 00 00 00       	mov    $0xb,%eax
 4b4:	cd 40                	int    $0x40
 4b6:	c3                   	ret    

000004b7 <sbrk>:
SYSCALL(sbrk)
 4b7:	b8 0c 00 00 00       	mov    $0xc,%eax
 4bc:	cd 40                	int    $0x40
 4be:	c3                   	ret    

000004bf <sleep>:
SYSCALL(sleep)
 4bf:	b8 0d 00 00 00       	mov    $0xd,%eax
 4c4:	cd 40                	int    $0x40
 4c6:	c3                   	ret    

000004c7 <uptime>:
SYSCALL(uptime)
 4c7:	b8 0e 00 00 00       	mov    $0xe,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret    

000004cf <halt>:
SYSCALL(halt)
 4cf:	b8 16 00 00 00       	mov    $0x16,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret    

000004d7 <date>:
SYSCALL(date)
 4d7:	b8 17 00 00 00       	mov    $0x17,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret    

000004df <getuid>:
SYSCALL(getuid)
 4df:	b8 18 00 00 00       	mov    $0x18,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret    

000004e7 <getgid>:
SYSCALL(getgid)
 4e7:	b8 19 00 00 00       	mov    $0x19,%eax
 4ec:	cd 40                	int    $0x40
 4ee:	c3                   	ret    

000004ef <getppid>:
SYSCALL(getppid)
 4ef:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4f4:	cd 40                	int    $0x40
 4f6:	c3                   	ret    

000004f7 <setuid>:
SYSCALL(setuid)
 4f7:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4fc:	cd 40                	int    $0x40
 4fe:	c3                   	ret    

000004ff <setgid>:
SYSCALL(setgid)
 4ff:	b8 1c 00 00 00       	mov    $0x1c,%eax
 504:	cd 40                	int    $0x40
 506:	c3                   	ret    

00000507 <getprocs>:
SYSCALL(getprocs)
 507:	b8 1d 00 00 00       	mov    $0x1d,%eax
 50c:	cd 40                	int    $0x40
 50e:	c3                   	ret    

0000050f <setpriority>:
SYSCALL(setpriority)
 50f:	b8 1e 00 00 00       	mov    $0x1e,%eax
 514:	cd 40                	int    $0x40
 516:	c3                   	ret    

00000517 <chown>:
SYSCALL(chown)
 517:	b8 1f 00 00 00       	mov    $0x1f,%eax
 51c:	cd 40                	int    $0x40
 51e:	c3                   	ret    

0000051f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 51f:	f3 0f 1e fb          	endbr32 
 523:	55                   	push   %ebp
 524:	89 e5                	mov    %esp,%ebp
 526:	83 ec 18             	sub    $0x18,%esp
 529:	8b 45 0c             	mov    0xc(%ebp),%eax
 52c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 52f:	83 ec 04             	sub    $0x4,%esp
 532:	6a 01                	push   $0x1
 534:	8d 45 f4             	lea    -0xc(%ebp),%eax
 537:	50                   	push   %eax
 538:	ff 75 08             	pushl  0x8(%ebp)
 53b:	e8 0f ff ff ff       	call   44f <write>
 540:	83 c4 10             	add    $0x10,%esp
}
 543:	90                   	nop
 544:	c9                   	leave  
 545:	c3                   	ret    

00000546 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 546:	f3 0f 1e fb          	endbr32 
 54a:	55                   	push   %ebp
 54b:	89 e5                	mov    %esp,%ebp
 54d:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 550:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 557:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 55b:	74 17                	je     574 <printint+0x2e>
 55d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 561:	79 11                	jns    574 <printint+0x2e>
    neg = 1;
 563:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 56a:	8b 45 0c             	mov    0xc(%ebp),%eax
 56d:	f7 d8                	neg    %eax
 56f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 572:	eb 06                	jmp    57a <printint+0x34>
  } else {
    x = xx;
 574:	8b 45 0c             	mov    0xc(%ebp),%eax
 577:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 57a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 581:	8b 4d 10             	mov    0x10(%ebp),%ecx
 584:	8b 45 ec             	mov    -0x14(%ebp),%eax
 587:	ba 00 00 00 00       	mov    $0x0,%edx
 58c:	f7 f1                	div    %ecx
 58e:	89 d1                	mov    %edx,%ecx
 590:	8b 45 f4             	mov    -0xc(%ebp),%eax
 593:	8d 50 01             	lea    0x1(%eax),%edx
 596:	89 55 f4             	mov    %edx,-0xc(%ebp)
 599:	0f b6 91 54 13 00 00 	movzbl 0x1354(%ecx),%edx
 5a0:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 5a4:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5aa:	ba 00 00 00 00       	mov    $0x0,%edx
 5af:	f7 f1                	div    %ecx
 5b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5b4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5b8:	75 c7                	jne    581 <printint+0x3b>
  if(neg)
 5ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5be:	74 2d                	je     5ed <printint+0xa7>
    buf[i++] = '-';
 5c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c3:	8d 50 01             	lea    0x1(%eax),%edx
 5c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5c9:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5ce:	eb 1d                	jmp    5ed <printint+0xa7>
    putc(fd, buf[i]);
 5d0:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d6:	01 d0                	add    %edx,%eax
 5d8:	0f b6 00             	movzbl (%eax),%eax
 5db:	0f be c0             	movsbl %al,%eax
 5de:	83 ec 08             	sub    $0x8,%esp
 5e1:	50                   	push   %eax
 5e2:	ff 75 08             	pushl  0x8(%ebp)
 5e5:	e8 35 ff ff ff       	call   51f <putc>
 5ea:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5ed:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5f1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5f5:	79 d9                	jns    5d0 <printint+0x8a>
}
 5f7:	90                   	nop
 5f8:	90                   	nop
 5f9:	c9                   	leave  
 5fa:	c3                   	ret    

000005fb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5fb:	f3 0f 1e fb          	endbr32 
 5ff:	55                   	push   %ebp
 600:	89 e5                	mov    %esp,%ebp
 602:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 605:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 60c:	8d 45 0c             	lea    0xc(%ebp),%eax
 60f:	83 c0 04             	add    $0x4,%eax
 612:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 615:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 61c:	e9 59 01 00 00       	jmp    77a <printf+0x17f>
    c = fmt[i] & 0xff;
 621:	8b 55 0c             	mov    0xc(%ebp),%edx
 624:	8b 45 f0             	mov    -0x10(%ebp),%eax
 627:	01 d0                	add    %edx,%eax
 629:	0f b6 00             	movzbl (%eax),%eax
 62c:	0f be c0             	movsbl %al,%eax
 62f:	25 ff 00 00 00       	and    $0xff,%eax
 634:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 637:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 63b:	75 2c                	jne    669 <printf+0x6e>
      if(c == '%'){
 63d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 641:	75 0c                	jne    64f <printf+0x54>
        state = '%';
 643:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 64a:	e9 27 01 00 00       	jmp    776 <printf+0x17b>
      } else {
        putc(fd, c);
 64f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 652:	0f be c0             	movsbl %al,%eax
 655:	83 ec 08             	sub    $0x8,%esp
 658:	50                   	push   %eax
 659:	ff 75 08             	pushl  0x8(%ebp)
 65c:	e8 be fe ff ff       	call   51f <putc>
 661:	83 c4 10             	add    $0x10,%esp
 664:	e9 0d 01 00 00       	jmp    776 <printf+0x17b>
      }
    } else if(state == '%'){
 669:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 66d:	0f 85 03 01 00 00    	jne    776 <printf+0x17b>
      if(c == 'd'){
 673:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 677:	75 1e                	jne    697 <printf+0x9c>
        printint(fd, *ap, 10, 1);
 679:	8b 45 e8             	mov    -0x18(%ebp),%eax
 67c:	8b 00                	mov    (%eax),%eax
 67e:	6a 01                	push   $0x1
 680:	6a 0a                	push   $0xa
 682:	50                   	push   %eax
 683:	ff 75 08             	pushl  0x8(%ebp)
 686:	e8 bb fe ff ff       	call   546 <printint>
 68b:	83 c4 10             	add    $0x10,%esp
        ap++;
 68e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 692:	e9 d8 00 00 00       	jmp    76f <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 697:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 69b:	74 06                	je     6a3 <printf+0xa8>
 69d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6a1:	75 1e                	jne    6c1 <printf+0xc6>
        printint(fd, *ap, 16, 0);
 6a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a6:	8b 00                	mov    (%eax),%eax
 6a8:	6a 00                	push   $0x0
 6aa:	6a 10                	push   $0x10
 6ac:	50                   	push   %eax
 6ad:	ff 75 08             	pushl  0x8(%ebp)
 6b0:	e8 91 fe ff ff       	call   546 <printint>
 6b5:	83 c4 10             	add    $0x10,%esp
        ap++;
 6b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6bc:	e9 ae 00 00 00       	jmp    76f <printf+0x174>
      } else if(c == 's'){
 6c1:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6c5:	75 43                	jne    70a <printf+0x10f>
        s = (char*)*ap;
 6c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6ca:	8b 00                	mov    (%eax),%eax
 6cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6cf:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6d7:	75 25                	jne    6fe <printf+0x103>
          s = "(null)";
 6d9:	c7 45 f4 1f 0f 00 00 	movl   $0xf1f,-0xc(%ebp)
        while(*s != 0){
 6e0:	eb 1c                	jmp    6fe <printf+0x103>
          putc(fd, *s);
 6e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e5:	0f b6 00             	movzbl (%eax),%eax
 6e8:	0f be c0             	movsbl %al,%eax
 6eb:	83 ec 08             	sub    $0x8,%esp
 6ee:	50                   	push   %eax
 6ef:	ff 75 08             	pushl  0x8(%ebp)
 6f2:	e8 28 fe ff ff       	call   51f <putc>
 6f7:	83 c4 10             	add    $0x10,%esp
          s++;
 6fa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 701:	0f b6 00             	movzbl (%eax),%eax
 704:	84 c0                	test   %al,%al
 706:	75 da                	jne    6e2 <printf+0xe7>
 708:	eb 65                	jmp    76f <printf+0x174>
        }
      } else if(c == 'c'){
 70a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 70e:	75 1d                	jne    72d <printf+0x132>
        putc(fd, *ap);
 710:	8b 45 e8             	mov    -0x18(%ebp),%eax
 713:	8b 00                	mov    (%eax),%eax
 715:	0f be c0             	movsbl %al,%eax
 718:	83 ec 08             	sub    $0x8,%esp
 71b:	50                   	push   %eax
 71c:	ff 75 08             	pushl  0x8(%ebp)
 71f:	e8 fb fd ff ff       	call   51f <putc>
 724:	83 c4 10             	add    $0x10,%esp
        ap++;
 727:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 72b:	eb 42                	jmp    76f <printf+0x174>
      } else if(c == '%'){
 72d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 731:	75 17                	jne    74a <printf+0x14f>
        putc(fd, c);
 733:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 736:	0f be c0             	movsbl %al,%eax
 739:	83 ec 08             	sub    $0x8,%esp
 73c:	50                   	push   %eax
 73d:	ff 75 08             	pushl  0x8(%ebp)
 740:	e8 da fd ff ff       	call   51f <putc>
 745:	83 c4 10             	add    $0x10,%esp
 748:	eb 25                	jmp    76f <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 74a:	83 ec 08             	sub    $0x8,%esp
 74d:	6a 25                	push   $0x25
 74f:	ff 75 08             	pushl  0x8(%ebp)
 752:	e8 c8 fd ff ff       	call   51f <putc>
 757:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 75a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 75d:	0f be c0             	movsbl %al,%eax
 760:	83 ec 08             	sub    $0x8,%esp
 763:	50                   	push   %eax
 764:	ff 75 08             	pushl  0x8(%ebp)
 767:	e8 b3 fd ff ff       	call   51f <putc>
 76c:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 76f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 776:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 77a:	8b 55 0c             	mov    0xc(%ebp),%edx
 77d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 780:	01 d0                	add    %edx,%eax
 782:	0f b6 00             	movzbl (%eax),%eax
 785:	84 c0                	test   %al,%al
 787:	0f 85 94 fe ff ff    	jne    621 <printf+0x26>
    }
  }
}
 78d:	90                   	nop
 78e:	90                   	nop
 78f:	c9                   	leave  
 790:	c3                   	ret    

00000791 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 791:	f3 0f 1e fb          	endbr32 
 795:	55                   	push   %ebp
 796:	89 e5                	mov    %esp,%ebp
 798:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 79b:	8b 45 08             	mov    0x8(%ebp),%eax
 79e:	83 e8 08             	sub    $0x8,%eax
 7a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a4:	a1 88 13 00 00       	mov    0x1388,%eax
 7a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7ac:	eb 24                	jmp    7d2 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b1:	8b 00                	mov    (%eax),%eax
 7b3:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 7b6:	72 12                	jb     7ca <free+0x39>
 7b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7be:	77 24                	ja     7e4 <free+0x53>
 7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c3:	8b 00                	mov    (%eax),%eax
 7c5:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7c8:	72 1a                	jb     7e4 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cd:	8b 00                	mov    (%eax),%eax
 7cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7d8:	76 d4                	jbe    7ae <free+0x1d>
 7da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dd:	8b 00                	mov    (%eax),%eax
 7df:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7e2:	73 ca                	jae    7ae <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e7:	8b 40 04             	mov    0x4(%eax),%eax
 7ea:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f4:	01 c2                	add    %eax,%edx
 7f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f9:	8b 00                	mov    (%eax),%eax
 7fb:	39 c2                	cmp    %eax,%edx
 7fd:	75 24                	jne    823 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 7ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 802:	8b 50 04             	mov    0x4(%eax),%edx
 805:	8b 45 fc             	mov    -0x4(%ebp),%eax
 808:	8b 00                	mov    (%eax),%eax
 80a:	8b 40 04             	mov    0x4(%eax),%eax
 80d:	01 c2                	add    %eax,%edx
 80f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 812:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 815:	8b 45 fc             	mov    -0x4(%ebp),%eax
 818:	8b 00                	mov    (%eax),%eax
 81a:	8b 10                	mov    (%eax),%edx
 81c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81f:	89 10                	mov    %edx,(%eax)
 821:	eb 0a                	jmp    82d <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 823:	8b 45 fc             	mov    -0x4(%ebp),%eax
 826:	8b 10                	mov    (%eax),%edx
 828:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 82d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 830:	8b 40 04             	mov    0x4(%eax),%eax
 833:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 83a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83d:	01 d0                	add    %edx,%eax
 83f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 842:	75 20                	jne    864 <free+0xd3>
    p->s.size += bp->s.size;
 844:	8b 45 fc             	mov    -0x4(%ebp),%eax
 847:	8b 50 04             	mov    0x4(%eax),%edx
 84a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 84d:	8b 40 04             	mov    0x4(%eax),%eax
 850:	01 c2                	add    %eax,%edx
 852:	8b 45 fc             	mov    -0x4(%ebp),%eax
 855:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 858:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85b:	8b 10                	mov    (%eax),%edx
 85d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 860:	89 10                	mov    %edx,(%eax)
 862:	eb 08                	jmp    86c <free+0xdb>
  } else
    p->s.ptr = bp;
 864:	8b 45 fc             	mov    -0x4(%ebp),%eax
 867:	8b 55 f8             	mov    -0x8(%ebp),%edx
 86a:	89 10                	mov    %edx,(%eax)
  freep = p;
 86c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86f:	a3 88 13 00 00       	mov    %eax,0x1388
}
 874:	90                   	nop
 875:	c9                   	leave  
 876:	c3                   	ret    

00000877 <morecore>:

static Header*
morecore(uint nu)
{
 877:	f3 0f 1e fb          	endbr32 
 87b:	55                   	push   %ebp
 87c:	89 e5                	mov    %esp,%ebp
 87e:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 881:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 888:	77 07                	ja     891 <morecore+0x1a>
    nu = 4096;
 88a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 891:	8b 45 08             	mov    0x8(%ebp),%eax
 894:	c1 e0 03             	shl    $0x3,%eax
 897:	83 ec 0c             	sub    $0xc,%esp
 89a:	50                   	push   %eax
 89b:	e8 17 fc ff ff       	call   4b7 <sbrk>
 8a0:	83 c4 10             	add    $0x10,%esp
 8a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8a6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8aa:	75 07                	jne    8b3 <morecore+0x3c>
    return 0;
 8ac:	b8 00 00 00 00       	mov    $0x0,%eax
 8b1:	eb 26                	jmp    8d9 <morecore+0x62>
  hp = (Header*)p;
 8b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8bc:	8b 55 08             	mov    0x8(%ebp),%edx
 8bf:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c5:	83 c0 08             	add    $0x8,%eax
 8c8:	83 ec 0c             	sub    $0xc,%esp
 8cb:	50                   	push   %eax
 8cc:	e8 c0 fe ff ff       	call   791 <free>
 8d1:	83 c4 10             	add    $0x10,%esp
  return freep;
 8d4:	a1 88 13 00 00       	mov    0x1388,%eax
}
 8d9:	c9                   	leave  
 8da:	c3                   	ret    

000008db <malloc>:

void*
malloc(uint nbytes)
{
 8db:	f3 0f 1e fb          	endbr32 
 8df:	55                   	push   %ebp
 8e0:	89 e5                	mov    %esp,%ebp
 8e2:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e5:	8b 45 08             	mov    0x8(%ebp),%eax
 8e8:	83 c0 07             	add    $0x7,%eax
 8eb:	c1 e8 03             	shr    $0x3,%eax
 8ee:	83 c0 01             	add    $0x1,%eax
 8f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8f4:	a1 88 13 00 00       	mov    0x1388,%eax
 8f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 900:	75 23                	jne    925 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 902:	c7 45 f0 80 13 00 00 	movl   $0x1380,-0x10(%ebp)
 909:	8b 45 f0             	mov    -0x10(%ebp),%eax
 90c:	a3 88 13 00 00       	mov    %eax,0x1388
 911:	a1 88 13 00 00       	mov    0x1388,%eax
 916:	a3 80 13 00 00       	mov    %eax,0x1380
    base.s.size = 0;
 91b:	c7 05 84 13 00 00 00 	movl   $0x0,0x1384
 922:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 925:	8b 45 f0             	mov    -0x10(%ebp),%eax
 928:	8b 00                	mov    (%eax),%eax
 92a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 92d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 930:	8b 40 04             	mov    0x4(%eax),%eax
 933:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 936:	77 4d                	ja     985 <malloc+0xaa>
      if(p->s.size == nunits)
 938:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93b:	8b 40 04             	mov    0x4(%eax),%eax
 93e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 941:	75 0c                	jne    94f <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 943:	8b 45 f4             	mov    -0xc(%ebp),%eax
 946:	8b 10                	mov    (%eax),%edx
 948:	8b 45 f0             	mov    -0x10(%ebp),%eax
 94b:	89 10                	mov    %edx,(%eax)
 94d:	eb 26                	jmp    975 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 94f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 952:	8b 40 04             	mov    0x4(%eax),%eax
 955:	2b 45 ec             	sub    -0x14(%ebp),%eax
 958:	89 c2                	mov    %eax,%edx
 95a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 960:	8b 45 f4             	mov    -0xc(%ebp),%eax
 963:	8b 40 04             	mov    0x4(%eax),%eax
 966:	c1 e0 03             	shl    $0x3,%eax
 969:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 96c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 972:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 975:	8b 45 f0             	mov    -0x10(%ebp),%eax
 978:	a3 88 13 00 00       	mov    %eax,0x1388
      return (void*)(p + 1);
 97d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 980:	83 c0 08             	add    $0x8,%eax
 983:	eb 3b                	jmp    9c0 <malloc+0xe5>
    }
    if(p == freep)
 985:	a1 88 13 00 00       	mov    0x1388,%eax
 98a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 98d:	75 1e                	jne    9ad <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 98f:	83 ec 0c             	sub    $0xc,%esp
 992:	ff 75 ec             	pushl  -0x14(%ebp)
 995:	e8 dd fe ff ff       	call   877 <morecore>
 99a:	83 c4 10             	add    $0x10,%esp
 99d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9a4:	75 07                	jne    9ad <malloc+0xd2>
        return 0;
 9a6:	b8 00 00 00 00       	mov    $0x0,%eax
 9ab:	eb 13                	jmp    9c0 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b6:	8b 00                	mov    (%eax),%eax
 9b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9bb:	e9 6d ff ff ff       	jmp    92d <malloc+0x52>
  }
}
 9c0:	c9                   	leave  
 9c1:	c3                   	ret    

000009c2 <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
 9c2:	f3 0f 1e fb          	endbr32 
 9c6:	55                   	push   %ebp
 9c7:	89 e5                	mov    %esp,%ebp
 9c9:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 9cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 9d3:	a1 e0 13 00 00       	mov    0x13e0,%eax
 9d8:	83 ec 04             	sub    $0x4,%esp
 9db:	50                   	push   %eax
 9dc:	6a 20                	push   $0x20
 9de:	68 c0 13 00 00       	push   $0x13c0
 9e3:	e8 11 f8 ff ff       	call   1f9 <fgets>
 9e8:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 9eb:	83 ec 0c             	sub    $0xc,%esp
 9ee:	68 c0 13 00 00       	push   $0x13c0
 9f3:	e8 0e f7 ff ff       	call   106 <strlen>
 9f8:	83 c4 10             	add    $0x10,%esp
 9fb:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 9fe:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a01:	83 e8 01             	sub    $0x1,%eax
 a04:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 a0b:	3c 0a                	cmp    $0xa,%al
 a0d:	74 11                	je     a20 <get_id+0x5e>
 a0f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a12:	83 e8 01             	sub    $0x1,%eax
 a15:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 a1c:	3c 0d                	cmp    $0xd,%al
 a1e:	75 0d                	jne    a2d <get_id+0x6b>
        current_line[len - 1] = 0;
 a20:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a23:	83 e8 01             	sub    $0x1,%eax
 a26:	c6 80 c0 13 00 00 00 	movb   $0x0,0x13c0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 a2d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 a34:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 a3b:	eb 6c                	jmp    aa9 <get_id+0xe7>
        if(current_line[i] == ' '){
 a3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a40:	05 c0 13 00 00       	add    $0x13c0,%eax
 a45:	0f b6 00             	movzbl (%eax),%eax
 a48:	3c 20                	cmp    $0x20,%al
 a4a:	75 30                	jne    a7c <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 a4c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a50:	75 16                	jne    a68 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 a52:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a55:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a58:	8d 50 01             	lea    0x1(%eax),%edx
 a5b:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a5e:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 a64:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 a68:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a6b:	05 c0 13 00 00       	add    $0x13c0,%eax
 a70:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 a73:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a7a:	eb 29                	jmp    aa5 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 a7c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a80:	75 23                	jne    aa5 <get_id+0xe3>
 a82:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 a86:	7f 1d                	jg     aa5 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 a88:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 a8f:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a92:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a95:	8d 50 01             	lea    0x1(%eax),%edx
 a98:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a9b:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 aa1:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 aa5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 aa9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 aac:	05 c0 13 00 00       	add    $0x13c0,%eax
 ab1:	0f b6 00             	movzbl (%eax),%eax
 ab4:	84 c0                	test   %al,%al
 ab6:	75 85                	jne    a3d <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 ab8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 abc:	75 07                	jne    ac5 <get_id+0x103>
        return -1;
 abe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 ac3:	eb 35                	jmp    afa <get_id+0x138>
    
    current_id.nama_user = tokens[0];
 ac5:	8b 45 dc             	mov    -0x24(%ebp),%eax
 ac8:	a3 a0 13 00 00       	mov    %eax,0x13a0
    current_id.uid_user = atoi(tokens[1]);
 acd:	8b 45 e0             	mov    -0x20(%ebp),%eax
 ad0:	83 ec 0c             	sub    $0xc,%esp
 ad3:	50                   	push   %eax
 ad4:	e8 e5 f7 ff ff       	call   2be <atoi>
 ad9:	83 c4 10             	add    $0x10,%esp
 adc:	a3 a4 13 00 00       	mov    %eax,0x13a4
    current_id.gid_user = atoi(tokens[2]);
 ae1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 ae4:	83 ec 0c             	sub    $0xc,%esp
 ae7:	50                   	push   %eax
 ae8:	e8 d1 f7 ff ff       	call   2be <atoi>
 aed:	83 c4 10             	add    $0x10,%esp
 af0:	a3 a8 13 00 00       	mov    %eax,0x13a8

    return 0;
 af5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 afa:	c9                   	leave  
 afb:	c3                   	ret    

00000afc <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
 afc:	f3 0f 1e fb          	endbr32 
 b00:	55                   	push   %ebp
 b01:	89 e5                	mov    %esp,%ebp
 b03:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 b06:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b0b:	85 c0                	test   %eax,%eax
 b0d:	75 31                	jne    b40 <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
 b0f:	83 ec 08             	sub    $0x8,%esp
 b12:	6a 00                	push   $0x0
 b14:	68 26 0f 00 00       	push   $0xf26
 b19:	e8 51 f9 ff ff       	call   46f <open>
 b1e:	83 c4 10             	add    $0x10,%esp
 b21:	a3 e0 13 00 00       	mov    %eax,0x13e0

        if(dir < 0){        // kalau gagal membuka file
 b26:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b2b:	85 c0                	test   %eax,%eax
 b2d:	79 11                	jns    b40 <getid+0x44>
            dir = 0;
 b2f:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 b36:	00 00 00 
            return 0;
 b39:	b8 00 00 00 00       	mov    $0x0,%eax
 b3e:	eb 16                	jmp    b56 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
 b40:	e8 7d fe ff ff       	call   9c2 <get_id>
 b45:	83 f8 ff             	cmp    $0xffffffff,%eax
 b48:	75 07                	jne    b51 <getid+0x55>
        return 0;
 b4a:	b8 00 00 00 00       	mov    $0x0,%eax
 b4f:	eb 05                	jmp    b56 <getid+0x5a>
    
    return &current_id;
 b51:	b8 a0 13 00 00       	mov    $0x13a0,%eax
}
 b56:	c9                   	leave  
 b57:	c3                   	ret    

00000b58 <setid>:

// open file_ids
void setid(void){
 b58:	f3 0f 1e fb          	endbr32 
 b5c:	55                   	push   %ebp
 b5d:	89 e5                	mov    %esp,%ebp
 b5f:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b62:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b67:	85 c0                	test   %eax,%eax
 b69:	74 1b                	je     b86 <setid+0x2e>
        close(dir);
 b6b:	a1 e0 13 00 00       	mov    0x13e0,%eax
 b70:	83 ec 0c             	sub    $0xc,%esp
 b73:	50                   	push   %eax
 b74:	e8 de f8 ff ff       	call   457 <close>
 b79:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 b7c:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 b83:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
 b86:	83 ec 08             	sub    $0x8,%esp
 b89:	6a 00                	push   $0x0
 b8b:	68 26 0f 00 00       	push   $0xf26
 b90:	e8 da f8 ff ff       	call   46f <open>
 b95:	83 c4 10             	add    $0x10,%esp
 b98:	a3 e0 13 00 00       	mov    %eax,0x13e0

    if (dir < 0)
 b9d:	a1 e0 13 00 00       	mov    0x13e0,%eax
 ba2:	85 c0                	test   %eax,%eax
 ba4:	79 0a                	jns    bb0 <setid+0x58>
        dir = 0;
 ba6:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 bad:	00 00 00 
}
 bb0:	90                   	nop
 bb1:	c9                   	leave  
 bb2:	c3                   	ret    

00000bb3 <endid>:

// tutup file_ids
void endid (void){
 bb3:	f3 0f 1e fb          	endbr32 
 bb7:	55                   	push   %ebp
 bb8:	89 e5                	mov    %esp,%ebp
 bba:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 bbd:	a1 e0 13 00 00       	mov    0x13e0,%eax
 bc2:	85 c0                	test   %eax,%eax
 bc4:	74 1b                	je     be1 <endid+0x2e>
        close(dir);
 bc6:	a1 e0 13 00 00       	mov    0x13e0,%eax
 bcb:	83 ec 0c             	sub    $0xc,%esp
 bce:	50                   	push   %eax
 bcf:	e8 83 f8 ff ff       	call   457 <close>
 bd4:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 bd7:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 bde:	00 00 00 
    }
}
 be1:	90                   	nop
 be2:	c9                   	leave  
 be3:	c3                   	ret    

00000be4 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
 be4:	f3 0f 1e fb          	endbr32 
 be8:	55                   	push   %ebp
 be9:	89 e5                	mov    %esp,%ebp
 beb:	83 ec 08             	sub    $0x8,%esp
    setid();
 bee:	e8 65 ff ff ff       	call   b58 <setid>

    while (getid()){
 bf3:	eb 24                	jmp    c19 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
 bf5:	a1 a0 13 00 00       	mov    0x13a0,%eax
 bfa:	83 ec 08             	sub    $0x8,%esp
 bfd:	50                   	push   %eax
 bfe:	ff 75 08             	pushl  0x8(%ebp)
 c01:	e8 bd f4 ff ff       	call   c3 <strcmp>
 c06:	83 c4 10             	add    $0x10,%esp
 c09:	85 c0                	test   %eax,%eax
 c0b:	75 0c                	jne    c19 <cek_nama+0x35>
            endid();
 c0d:	e8 a1 ff ff ff       	call   bb3 <endid>
            return &current_id;
 c12:	b8 a0 13 00 00       	mov    $0x13a0,%eax
 c17:	eb 13                	jmp    c2c <cek_nama+0x48>
    while (getid()){
 c19:	e8 de fe ff ff       	call   afc <getid>
 c1e:	85 c0                	test   %eax,%eax
 c20:	75 d3                	jne    bf5 <cek_nama+0x11>
        }
    }
    endid();
 c22:	e8 8c ff ff ff       	call   bb3 <endid>
    return 0;
 c27:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c2c:	c9                   	leave  
 c2d:	c3                   	ret    

00000c2e <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
 c2e:	f3 0f 1e fb          	endbr32 
 c32:	55                   	push   %ebp
 c33:	89 e5                	mov    %esp,%ebp
 c35:	83 ec 08             	sub    $0x8,%esp
    setid();
 c38:	e8 1b ff ff ff       	call   b58 <setid>

    while (getid()){
 c3d:	eb 16                	jmp    c55 <cek_uid+0x27>
        if(current_id.uid_user == uid){
 c3f:	a1 a4 13 00 00       	mov    0x13a4,%eax
 c44:	39 45 08             	cmp    %eax,0x8(%ebp)
 c47:	75 0c                	jne    c55 <cek_uid+0x27>
            endid();
 c49:	e8 65 ff ff ff       	call   bb3 <endid>
            return &current_id;
 c4e:	b8 a0 13 00 00       	mov    $0x13a0,%eax
 c53:	eb 13                	jmp    c68 <cek_uid+0x3a>
    while (getid()){
 c55:	e8 a2 fe ff ff       	call   afc <getid>
 c5a:	85 c0                	test   %eax,%eax
 c5c:	75 e1                	jne    c3f <cek_uid+0x11>
        }
    }
    endid();
 c5e:	e8 50 ff ff ff       	call   bb3 <endid>
    return 0;
 c63:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c68:	c9                   	leave  
 c69:	c3                   	ret    

00000c6a <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
 c6a:	f3 0f 1e fb          	endbr32 
 c6e:	55                   	push   %ebp
 c6f:	89 e5                	mov    %esp,%ebp
 c71:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 c74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 c7b:	a1 e0 13 00 00       	mov    0x13e0,%eax
 c80:	83 ec 04             	sub    $0x4,%esp
 c83:	50                   	push   %eax
 c84:	6a 20                	push   $0x20
 c86:	68 c0 13 00 00       	push   $0x13c0
 c8b:	e8 69 f5 ff ff       	call   1f9 <fgets>
 c90:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 c93:	83 ec 0c             	sub    $0xc,%esp
 c96:	68 c0 13 00 00       	push   $0x13c0
 c9b:	e8 66 f4 ff ff       	call   106 <strlen>
 ca0:	83 c4 10             	add    $0x10,%esp
 ca3:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 ca6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ca9:	83 e8 01             	sub    $0x1,%eax
 cac:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 cb3:	3c 0a                	cmp    $0xa,%al
 cb5:	74 11                	je     cc8 <get_group+0x5e>
 cb7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cba:	83 e8 01             	sub    $0x1,%eax
 cbd:	0f b6 80 c0 13 00 00 	movzbl 0x13c0(%eax),%eax
 cc4:	3c 0d                	cmp    $0xd,%al
 cc6:	75 0d                	jne    cd5 <get_group+0x6b>
        current_line[len - 1] = 0;
 cc8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ccb:	83 e8 01             	sub    $0x1,%eax
 cce:	c6 80 c0 13 00 00 00 	movb   $0x0,0x13c0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 cd5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 cdc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 ce3:	eb 6c                	jmp    d51 <get_group+0xe7>
        if(current_line[i] == ' '){
 ce5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ce8:	05 c0 13 00 00       	add    $0x13c0,%eax
 ced:	0f b6 00             	movzbl (%eax),%eax
 cf0:	3c 20                	cmp    $0x20,%al
 cf2:	75 30                	jne    d24 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 cf4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 cf8:	75 16                	jne    d10 <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 cfa:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 cfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d00:	8d 50 01             	lea    0x1(%eax),%edx
 d03:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d06:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 d0c:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 d10:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d13:	05 c0 13 00 00       	add    $0x13c0,%eax
 d18:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 d1b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 d22:	eb 29                	jmp    d4d <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 d24:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d28:	75 23                	jne    d4d <get_group+0xe3>
 d2a:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 d2e:	7f 1d                	jg     d4d <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 d30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 d37:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d3d:	8d 50 01             	lea    0x1(%eax),%edx
 d40:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d43:	8d 91 c0 13 00 00    	lea    0x13c0(%ecx),%edx
 d49:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 d4d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 d51:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d54:	05 c0 13 00 00       	add    $0x13c0,%eax
 d59:	0f b6 00             	movzbl (%eax),%eax
 d5c:	84 c0                	test   %al,%al
 d5e:	75 85                	jne    ce5 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 d60:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 d64:	75 07                	jne    d6d <get_group+0x103>
        return -1;
 d66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d6b:	eb 21                	jmp    d8e <get_group+0x124>
    
    current_group.nama_group = tokens[0];
 d6d:	8b 45 dc             	mov    -0x24(%ebp),%eax
 d70:	a3 ac 13 00 00       	mov    %eax,0x13ac
    current_group.gid = atoi(tokens[1]);
 d75:	8b 45 e0             	mov    -0x20(%ebp),%eax
 d78:	83 ec 0c             	sub    $0xc,%esp
 d7b:	50                   	push   %eax
 d7c:	e8 3d f5 ff ff       	call   2be <atoi>
 d81:	83 c4 10             	add    $0x10,%esp
 d84:	a3 b0 13 00 00       	mov    %eax,0x13b0

    return 0;
 d89:	b8 00 00 00 00       	mov    $0x0,%eax
}
 d8e:	c9                   	leave  
 d8f:	c3                   	ret    

00000d90 <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
 d90:	f3 0f 1e fb          	endbr32 
 d94:	55                   	push   %ebp
 d95:	89 e5                	mov    %esp,%ebp
 d97:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 d9a:	a1 e0 13 00 00       	mov    0x13e0,%eax
 d9f:	85 c0                	test   %eax,%eax
 da1:	75 31                	jne    dd4 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
 da3:	83 ec 08             	sub    $0x8,%esp
 da6:	6a 00                	push   $0x0
 da8:	68 2e 0f 00 00       	push   $0xf2e
 dad:	e8 bd f6 ff ff       	call   46f <open>
 db2:	83 c4 10             	add    $0x10,%esp
 db5:	a3 e0 13 00 00       	mov    %eax,0x13e0

        if(dir < 0){        // kalau gagal membuka file
 dba:	a1 e0 13 00 00       	mov    0x13e0,%eax
 dbf:	85 c0                	test   %eax,%eax
 dc1:	79 11                	jns    dd4 <getgroup+0x44>
            dir = 0;
 dc3:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 dca:	00 00 00 
            return 0;
 dcd:	b8 00 00 00 00       	mov    $0x0,%eax
 dd2:	eb 16                	jmp    dea <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
 dd4:	e8 91 fe ff ff       	call   c6a <get_group>
 dd9:	83 f8 ff             	cmp    $0xffffffff,%eax
 ddc:	75 07                	jne    de5 <getgroup+0x55>
        return 0;
 dde:	b8 00 00 00 00       	mov    $0x0,%eax
 de3:	eb 05                	jmp    dea <getgroup+0x5a>
    
    return &current_group;
 de5:	b8 ac 13 00 00       	mov    $0x13ac,%eax
}
 dea:	c9                   	leave  
 deb:	c3                   	ret    

00000dec <setgroup>:

// open file_ids
void setgroup(void){
 dec:	f3 0f 1e fb          	endbr32 
 df0:	55                   	push   %ebp
 df1:	89 e5                	mov    %esp,%ebp
 df3:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 df6:	a1 e0 13 00 00       	mov    0x13e0,%eax
 dfb:	85 c0                	test   %eax,%eax
 dfd:	74 1b                	je     e1a <setgroup+0x2e>
        close(dir);
 dff:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e04:	83 ec 0c             	sub    $0xc,%esp
 e07:	50                   	push   %eax
 e08:	e8 4a f6 ff ff       	call   457 <close>
 e0d:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e10:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 e17:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
 e1a:	83 ec 08             	sub    $0x8,%esp
 e1d:	6a 00                	push   $0x0
 e1f:	68 2e 0f 00 00       	push   $0xf2e
 e24:	e8 46 f6 ff ff       	call   46f <open>
 e29:	83 c4 10             	add    $0x10,%esp
 e2c:	a3 e0 13 00 00       	mov    %eax,0x13e0

    if (dir < 0)
 e31:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e36:	85 c0                	test   %eax,%eax
 e38:	79 0a                	jns    e44 <setgroup+0x58>
        dir = 0;
 e3a:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 e41:	00 00 00 
}
 e44:	90                   	nop
 e45:	c9                   	leave  
 e46:	c3                   	ret    

00000e47 <endgroup>:

// tutup file_ids
void endgroup (void){
 e47:	f3 0f 1e fb          	endbr32 
 e4b:	55                   	push   %ebp
 e4c:	89 e5                	mov    %esp,%ebp
 e4e:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e51:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e56:	85 c0                	test   %eax,%eax
 e58:	74 1b                	je     e75 <endgroup+0x2e>
        close(dir);
 e5a:	a1 e0 13 00 00       	mov    0x13e0,%eax
 e5f:	83 ec 0c             	sub    $0xc,%esp
 e62:	50                   	push   %eax
 e63:	e8 ef f5 ff ff       	call   457 <close>
 e68:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e6b:	c7 05 e0 13 00 00 00 	movl   $0x0,0x13e0
 e72:	00 00 00 
    }
}
 e75:	90                   	nop
 e76:	c9                   	leave  
 e77:	c3                   	ret    

00000e78 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
 e78:	f3 0f 1e fb          	endbr32 
 e7c:	55                   	push   %ebp
 e7d:	89 e5                	mov    %esp,%ebp
 e7f:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 e82:	e8 65 ff ff ff       	call   dec <setgroup>

    while (getgroup()){
 e87:	eb 3c                	jmp    ec5 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
 e89:	a1 ac 13 00 00       	mov    0x13ac,%eax
 e8e:	83 ec 08             	sub    $0x8,%esp
 e91:	50                   	push   %eax
 e92:	ff 75 08             	pushl  0x8(%ebp)
 e95:	e8 29 f2 ff ff       	call   c3 <strcmp>
 e9a:	83 c4 10             	add    $0x10,%esp
 e9d:	85 c0                	test   %eax,%eax
 e9f:	75 24                	jne    ec5 <cek_nama_group+0x4d>
            endgroup();
 ea1:	e8 a1 ff ff ff       	call   e47 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
 ea6:	a1 ac 13 00 00       	mov    0x13ac,%eax
 eab:	83 ec 04             	sub    $0x4,%esp
 eae:	50                   	push   %eax
 eaf:	68 39 0f 00 00       	push   $0xf39
 eb4:	6a 01                	push   $0x1
 eb6:	e8 40 f7 ff ff       	call   5fb <printf>
 ebb:	83 c4 10             	add    $0x10,%esp
            return &current_group;
 ebe:	b8 ac 13 00 00       	mov    $0x13ac,%eax
 ec3:	eb 13                	jmp    ed8 <cek_nama_group+0x60>
    while (getgroup()){
 ec5:	e8 c6 fe ff ff       	call   d90 <getgroup>
 eca:	85 c0                	test   %eax,%eax
 ecc:	75 bb                	jne    e89 <cek_nama_group+0x11>
        }
    }
    endgroup();
 ece:	e8 74 ff ff ff       	call   e47 <endgroup>
    return 0;
 ed3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ed8:	c9                   	leave  
 ed9:	c3                   	ret    

00000eda <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
 eda:	f3 0f 1e fb          	endbr32 
 ede:	55                   	push   %ebp
 edf:	89 e5                	mov    %esp,%ebp
 ee1:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 ee4:	e8 03 ff ff ff       	call   dec <setgroup>

    while (getgroup()){
 ee9:	eb 16                	jmp    f01 <cek_gid+0x27>
        if(current_group.gid == gid){
 eeb:	a1 b0 13 00 00       	mov    0x13b0,%eax
 ef0:	39 45 08             	cmp    %eax,0x8(%ebp)
 ef3:	75 0c                	jne    f01 <cek_gid+0x27>
            endgroup();
 ef5:	e8 4d ff ff ff       	call   e47 <endgroup>
            return &current_group;
 efa:	b8 ac 13 00 00       	mov    $0x13ac,%eax
 eff:	eb 13                	jmp    f14 <cek_gid+0x3a>
    while (getgroup()){
 f01:	e8 8a fe ff ff       	call   d90 <getgroup>
 f06:	85 c0                	test   %eax,%eax
 f08:	75 e1                	jne    eeb <cek_gid+0x11>
        }
    }
    endgroup();
 f0a:	e8 38 ff ff ff       	call   e47 <endgroup>
    return 0;
 f0f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 f14:	c9                   	leave  
 f15:	c3                   	ret    
