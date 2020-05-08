
_testsetuid:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
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
  printf(1, "***** In %s: my uid is %d\n\n", argv[0], getuid());
  15:	e8 91 04 00 00       	call   4ab <getuid>
  1a:	8b 53 04             	mov    0x4(%ebx),%edx
  1d:	8b 12                	mov    (%edx),%edx
  1f:	50                   	push   %eax
  20:	52                   	push   %edx
  21:	68 e2 0e 00 00       	push   $0xee2
  26:	6a 01                	push   $0x1
  28:	e8 9a 05 00 00       	call   5c7 <printf>
  2d:	83 c4 10             	add    $0x10,%esp
  exit();
  30:	e8 c6 03 00 00       	call   3fb <exit>

00000035 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  35:	55                   	push   %ebp
  36:	89 e5                	mov    %esp,%ebp
  38:	57                   	push   %edi
  39:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  3a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  3d:	8b 55 10             	mov    0x10(%ebp),%edx
  40:	8b 45 0c             	mov    0xc(%ebp),%eax
  43:	89 cb                	mov    %ecx,%ebx
  45:	89 df                	mov    %ebx,%edi
  47:	89 d1                	mov    %edx,%ecx
  49:	fc                   	cld    
  4a:	f3 aa                	rep stos %al,%es:(%edi)
  4c:	89 ca                	mov    %ecx,%edx
  4e:	89 fb                	mov    %edi,%ebx
  50:	89 5d 08             	mov    %ebx,0x8(%ebp)
  53:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  56:	90                   	nop
  57:	5b                   	pop    %ebx
  58:	5f                   	pop    %edi
  59:	5d                   	pop    %ebp
  5a:	c3                   	ret    

0000005b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  5b:	f3 0f 1e fb          	endbr32 
  5f:	55                   	push   %ebp
  60:	89 e5                	mov    %esp,%ebp
  62:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  65:	8b 45 08             	mov    0x8(%ebp),%eax
  68:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  6b:	90                   	nop
  6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  6f:	8d 42 01             	lea    0x1(%edx),%eax
  72:	89 45 0c             	mov    %eax,0xc(%ebp)
  75:	8b 45 08             	mov    0x8(%ebp),%eax
  78:	8d 48 01             	lea    0x1(%eax),%ecx
  7b:	89 4d 08             	mov    %ecx,0x8(%ebp)
  7e:	0f b6 12             	movzbl (%edx),%edx
  81:	88 10                	mov    %dl,(%eax)
  83:	0f b6 00             	movzbl (%eax),%eax
  86:	84 c0                	test   %al,%al
  88:	75 e2                	jne    6c <strcpy+0x11>
    ;
  return os;
  8a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8d:	c9                   	leave  
  8e:	c3                   	ret    

0000008f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8f:	f3 0f 1e fb          	endbr32 
  93:	55                   	push   %ebp
  94:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  96:	eb 08                	jmp    a0 <strcmp+0x11>
    p++, q++;
  98:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  9c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	0f b6 00             	movzbl (%eax),%eax
  a6:	84 c0                	test   %al,%al
  a8:	74 10                	je     ba <strcmp+0x2b>
  aa:	8b 45 08             	mov    0x8(%ebp),%eax
  ad:	0f b6 10             	movzbl (%eax),%edx
  b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  b3:	0f b6 00             	movzbl (%eax),%eax
  b6:	38 c2                	cmp    %al,%dl
  b8:	74 de                	je     98 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
  ba:	8b 45 08             	mov    0x8(%ebp),%eax
  bd:	0f b6 00             	movzbl (%eax),%eax
  c0:	0f b6 d0             	movzbl %al,%edx
  c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  c6:	0f b6 00             	movzbl (%eax),%eax
  c9:	0f b6 c0             	movzbl %al,%eax
  cc:	29 c2                	sub    %eax,%edx
  ce:	89 d0                	mov    %edx,%eax
}
  d0:	5d                   	pop    %ebp
  d1:	c3                   	ret    

000000d2 <strlen>:

uint
strlen(char *s)
{
  d2:	f3 0f 1e fb          	endbr32 
  d6:	55                   	push   %ebp
  d7:	89 e5                	mov    %esp,%ebp
  d9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  e3:	eb 04                	jmp    e9 <strlen+0x17>
  e5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  e9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  ec:	8b 45 08             	mov    0x8(%ebp),%eax
  ef:	01 d0                	add    %edx,%eax
  f1:	0f b6 00             	movzbl (%eax),%eax
  f4:	84 c0                	test   %al,%al
  f6:	75 ed                	jne    e5 <strlen+0x13>
    ;
  return n;
  f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  fb:	c9                   	leave  
  fc:	c3                   	ret    

000000fd <memset>:

void*
memset(void *dst, int c, uint n)
{
  fd:	f3 0f 1e fb          	endbr32 
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 104:	8b 45 10             	mov    0x10(%ebp),%eax
 107:	50                   	push   %eax
 108:	ff 75 0c             	pushl  0xc(%ebp)
 10b:	ff 75 08             	pushl  0x8(%ebp)
 10e:	e8 22 ff ff ff       	call   35 <stosb>
 113:	83 c4 0c             	add    $0xc,%esp
  return dst;
 116:	8b 45 08             	mov    0x8(%ebp),%eax
}
 119:	c9                   	leave  
 11a:	c3                   	ret    

0000011b <strchr>:

char*
strchr(const char *s, char c)
{
 11b:	f3 0f 1e fb          	endbr32 
 11f:	55                   	push   %ebp
 120:	89 e5                	mov    %esp,%ebp
 122:	83 ec 04             	sub    $0x4,%esp
 125:	8b 45 0c             	mov    0xc(%ebp),%eax
 128:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 12b:	eb 14                	jmp    141 <strchr+0x26>
    if(*s == c)
 12d:	8b 45 08             	mov    0x8(%ebp),%eax
 130:	0f b6 00             	movzbl (%eax),%eax
 133:	38 45 fc             	cmp    %al,-0x4(%ebp)
 136:	75 05                	jne    13d <strchr+0x22>
      return (char*)s;
 138:	8b 45 08             	mov    0x8(%ebp),%eax
 13b:	eb 13                	jmp    150 <strchr+0x35>
  for(; *s; s++)
 13d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 141:	8b 45 08             	mov    0x8(%ebp),%eax
 144:	0f b6 00             	movzbl (%eax),%eax
 147:	84 c0                	test   %al,%al
 149:	75 e2                	jne    12d <strchr+0x12>
  return 0;
 14b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 150:	c9                   	leave  
 151:	c3                   	ret    

00000152 <gets>:

char*
gets(char *buf, int max)
{
 152:	f3 0f 1e fb          	endbr32 
 156:	55                   	push   %ebp
 157:	89 e5                	mov    %esp,%ebp
 159:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 163:	eb 42                	jmp    1a7 <gets+0x55>
    cc = read(0, &c, 1);
 165:	83 ec 04             	sub    $0x4,%esp
 168:	6a 01                	push   $0x1
 16a:	8d 45 ef             	lea    -0x11(%ebp),%eax
 16d:	50                   	push   %eax
 16e:	6a 00                	push   $0x0
 170:	e8 9e 02 00 00       	call   413 <read>
 175:	83 c4 10             	add    $0x10,%esp
 178:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 17b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 17f:	7e 33                	jle    1b4 <gets+0x62>
      break;
    buf[i++] = c;
 181:	8b 45 f4             	mov    -0xc(%ebp),%eax
 184:	8d 50 01             	lea    0x1(%eax),%edx
 187:	89 55 f4             	mov    %edx,-0xc(%ebp)
 18a:	89 c2                	mov    %eax,%edx
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	01 c2                	add    %eax,%edx
 191:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 195:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 197:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 19b:	3c 0a                	cmp    $0xa,%al
 19d:	74 16                	je     1b5 <gets+0x63>
 19f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a3:	3c 0d                	cmp    $0xd,%al
 1a5:	74 0e                	je     1b5 <gets+0x63>
  for(i=0; i+1 < max; ){
 1a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1aa:	83 c0 01             	add    $0x1,%eax
 1ad:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1b0:	7f b3                	jg     165 <gets+0x13>
 1b2:	eb 01                	jmp    1b5 <gets+0x63>
      break;
 1b4:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1b8:	8b 45 08             	mov    0x8(%ebp),%eax
 1bb:	01 d0                	add    %edx,%eax
 1bd:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1c3:	c9                   	leave  
 1c4:	c3                   	ret    

000001c5 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
 1c5:	f3 0f 1e fb          	endbr32 
 1c9:	55                   	push   %ebp
 1ca:	89 e5                	mov    %esp,%ebp
 1cc:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
 1cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1d6:	eb 43                	jmp    21b <fgets+0x56>
    int cc = read(fd, &c, 1);
 1d8:	83 ec 04             	sub    $0x4,%esp
 1db:	6a 01                	push   $0x1
 1dd:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1e0:	50                   	push   %eax
 1e1:	ff 75 10             	pushl  0x10(%ebp)
 1e4:	e8 2a 02 00 00       	call   413 <read>
 1e9:	83 c4 10             	add    $0x10,%esp
 1ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1f3:	7e 33                	jle    228 <fgets+0x63>
      break;
    buf[i++] = c;
 1f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f8:	8d 50 01             	lea    0x1(%eax),%edx
 1fb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1fe:	89 c2                	mov    %eax,%edx
 200:	8b 45 08             	mov    0x8(%ebp),%eax
 203:	01 c2                	add    %eax,%edx
 205:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 209:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 20b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 20f:	3c 0a                	cmp    $0xa,%al
 211:	74 16                	je     229 <fgets+0x64>
 213:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 217:	3c 0d                	cmp    $0xd,%al
 219:	74 0e                	je     229 <fgets+0x64>
  for(i = 0; i + 1 < size;){
 21b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 21e:	83 c0 01             	add    $0x1,%eax
 221:	39 45 0c             	cmp    %eax,0xc(%ebp)
 224:	7f b2                	jg     1d8 <fgets+0x13>
 226:	eb 01                	jmp    229 <fgets+0x64>
      break;
 228:	90                   	nop
      break;
  }
  buf[i] = '\0';
 229:	8b 55 f4             	mov    -0xc(%ebp),%edx
 22c:	8b 45 08             	mov    0x8(%ebp),%eax
 22f:	01 d0                	add    %edx,%eax
 231:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 234:	8b 45 08             	mov    0x8(%ebp),%eax
}
 237:	c9                   	leave  
 238:	c3                   	ret    

00000239 <stat>:

int
stat(char *n, struct stat *st)
{
 239:	f3 0f 1e fb          	endbr32 
 23d:	55                   	push   %ebp
 23e:	89 e5                	mov    %esp,%ebp
 240:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 243:	83 ec 08             	sub    $0x8,%esp
 246:	6a 00                	push   $0x0
 248:	ff 75 08             	pushl  0x8(%ebp)
 24b:	e8 eb 01 00 00       	call   43b <open>
 250:	83 c4 10             	add    $0x10,%esp
 253:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 256:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 25a:	79 07                	jns    263 <stat+0x2a>
    return -1;
 25c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 261:	eb 25                	jmp    288 <stat+0x4f>
  r = fstat(fd, st);
 263:	83 ec 08             	sub    $0x8,%esp
 266:	ff 75 0c             	pushl  0xc(%ebp)
 269:	ff 75 f4             	pushl  -0xc(%ebp)
 26c:	e8 e2 01 00 00       	call   453 <fstat>
 271:	83 c4 10             	add    $0x10,%esp
 274:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 277:	83 ec 0c             	sub    $0xc,%esp
 27a:	ff 75 f4             	pushl  -0xc(%ebp)
 27d:	e8 a1 01 00 00       	call   423 <close>
 282:	83 c4 10             	add    $0x10,%esp
  return r;
 285:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 288:	c9                   	leave  
 289:	c3                   	ret    

0000028a <atoi>:

int
atoi(const char *s)
{
 28a:	f3 0f 1e fb          	endbr32 
 28e:	55                   	push   %ebp
 28f:	89 e5                	mov    %esp,%ebp
 291:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 294:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 29b:	eb 04                	jmp    2a1 <atoi+0x17>
 29d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2a1:	8b 45 08             	mov    0x8(%ebp),%eax
 2a4:	0f b6 00             	movzbl (%eax),%eax
 2a7:	3c 20                	cmp    $0x20,%al
 2a9:	74 f2                	je     29d <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
 2ab:	8b 45 08             	mov    0x8(%ebp),%eax
 2ae:	0f b6 00             	movzbl (%eax),%eax
 2b1:	3c 2d                	cmp    $0x2d,%al
 2b3:	75 07                	jne    2bc <atoi+0x32>
 2b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ba:	eb 05                	jmp    2c1 <atoi+0x37>
 2bc:	b8 01 00 00 00       	mov    $0x1,%eax
 2c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 2c4:	8b 45 08             	mov    0x8(%ebp),%eax
 2c7:	0f b6 00             	movzbl (%eax),%eax
 2ca:	3c 2b                	cmp    $0x2b,%al
 2cc:	74 0a                	je     2d8 <atoi+0x4e>
 2ce:	8b 45 08             	mov    0x8(%ebp),%eax
 2d1:	0f b6 00             	movzbl (%eax),%eax
 2d4:	3c 2d                	cmp    $0x2d,%al
 2d6:	75 2b                	jne    303 <atoi+0x79>
    s++;
 2d8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 2dc:	eb 25                	jmp    303 <atoi+0x79>
    n = n*10 + *s++ - '0';
 2de:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2e1:	89 d0                	mov    %edx,%eax
 2e3:	c1 e0 02             	shl    $0x2,%eax
 2e6:	01 d0                	add    %edx,%eax
 2e8:	01 c0                	add    %eax,%eax
 2ea:	89 c1                	mov    %eax,%ecx
 2ec:	8b 45 08             	mov    0x8(%ebp),%eax
 2ef:	8d 50 01             	lea    0x1(%eax),%edx
 2f2:	89 55 08             	mov    %edx,0x8(%ebp)
 2f5:	0f b6 00             	movzbl (%eax),%eax
 2f8:	0f be c0             	movsbl %al,%eax
 2fb:	01 c8                	add    %ecx,%eax
 2fd:	83 e8 30             	sub    $0x30,%eax
 300:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	0f b6 00             	movzbl (%eax),%eax
 309:	3c 2f                	cmp    $0x2f,%al
 30b:	7e 0a                	jle    317 <atoi+0x8d>
 30d:	8b 45 08             	mov    0x8(%ebp),%eax
 310:	0f b6 00             	movzbl (%eax),%eax
 313:	3c 39                	cmp    $0x39,%al
 315:	7e c7                	jle    2de <atoi+0x54>
  return sign*n;
 317:	8b 45 f8             	mov    -0x8(%ebp),%eax
 31a:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 31e:	c9                   	leave  
 31f:	c3                   	ret    

00000320 <atoo>:

int
atoo(const char *s)
{
 320:	f3 0f 1e fb          	endbr32 
 324:	55                   	push   %ebp
 325:	89 e5                	mov    %esp,%ebp
 327:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 32a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 331:	eb 04                	jmp    337 <atoo+0x17>
 333:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 337:	8b 45 08             	mov    0x8(%ebp),%eax
 33a:	0f b6 00             	movzbl (%eax),%eax
 33d:	3c 20                	cmp    $0x20,%al
 33f:	74 f2                	je     333 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
 341:	8b 45 08             	mov    0x8(%ebp),%eax
 344:	0f b6 00             	movzbl (%eax),%eax
 347:	3c 2d                	cmp    $0x2d,%al
 349:	75 07                	jne    352 <atoo+0x32>
 34b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 350:	eb 05                	jmp    357 <atoo+0x37>
 352:	b8 01 00 00 00       	mov    $0x1,%eax
 357:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 35a:	8b 45 08             	mov    0x8(%ebp),%eax
 35d:	0f b6 00             	movzbl (%eax),%eax
 360:	3c 2b                	cmp    $0x2b,%al
 362:	74 0a                	je     36e <atoo+0x4e>
 364:	8b 45 08             	mov    0x8(%ebp),%eax
 367:	0f b6 00             	movzbl (%eax),%eax
 36a:	3c 2d                	cmp    $0x2d,%al
 36c:	75 27                	jne    395 <atoo+0x75>
    s++;
 36e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 372:	eb 21                	jmp    395 <atoo+0x75>
    n = n*8 + *s++ - '0';
 374:	8b 45 fc             	mov    -0x4(%ebp),%eax
 377:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 37e:	8b 45 08             	mov    0x8(%ebp),%eax
 381:	8d 50 01             	lea    0x1(%eax),%edx
 384:	89 55 08             	mov    %edx,0x8(%ebp)
 387:	0f b6 00             	movzbl (%eax),%eax
 38a:	0f be c0             	movsbl %al,%eax
 38d:	01 c8                	add    %ecx,%eax
 38f:	83 e8 30             	sub    $0x30,%eax
 392:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
 395:	8b 45 08             	mov    0x8(%ebp),%eax
 398:	0f b6 00             	movzbl (%eax),%eax
 39b:	3c 2f                	cmp    $0x2f,%al
 39d:	7e 0a                	jle    3a9 <atoo+0x89>
 39f:	8b 45 08             	mov    0x8(%ebp),%eax
 3a2:	0f b6 00             	movzbl (%eax),%eax
 3a5:	3c 37                	cmp    $0x37,%al
 3a7:	7e cb                	jle    374 <atoo+0x54>
  return sign*n;
 3a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3ac:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 3b0:	c9                   	leave  
 3b1:	c3                   	ret    

000003b2 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 3b2:	f3 0f 1e fb          	endbr32 
 3b6:	55                   	push   %ebp
 3b7:	89 e5                	mov    %esp,%ebp
 3b9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3bc:	8b 45 08             	mov    0x8(%ebp),%eax
 3bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3c8:	eb 17                	jmp    3e1 <memmove+0x2f>
    *dst++ = *src++;
 3ca:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3cd:	8d 42 01             	lea    0x1(%edx),%eax
 3d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
 3d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3d6:	8d 48 01             	lea    0x1(%eax),%ecx
 3d9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 3dc:	0f b6 12             	movzbl (%edx),%edx
 3df:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 3e1:	8b 45 10             	mov    0x10(%ebp),%eax
 3e4:	8d 50 ff             	lea    -0x1(%eax),%edx
 3e7:	89 55 10             	mov    %edx,0x10(%ebp)
 3ea:	85 c0                	test   %eax,%eax
 3ec:	7f dc                	jg     3ca <memmove+0x18>
  return vdst;
 3ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3f1:	c9                   	leave  
 3f2:	c3                   	ret    

000003f3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3f3:	b8 01 00 00 00       	mov    $0x1,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <exit>:
SYSCALL(exit)
 3fb:	b8 02 00 00 00       	mov    $0x2,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <wait>:
SYSCALL(wait)
 403:	b8 03 00 00 00       	mov    $0x3,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <pipe>:
SYSCALL(pipe)
 40b:	b8 04 00 00 00       	mov    $0x4,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <read>:
SYSCALL(read)
 413:	b8 05 00 00 00       	mov    $0x5,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <write>:
SYSCALL(write)
 41b:	b8 10 00 00 00       	mov    $0x10,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <close>:
SYSCALL(close)
 423:	b8 15 00 00 00       	mov    $0x15,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <kill>:
SYSCALL(kill)
 42b:	b8 06 00 00 00       	mov    $0x6,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <exec>:
SYSCALL(exec)
 433:	b8 07 00 00 00       	mov    $0x7,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <open>:
SYSCALL(open)
 43b:	b8 0f 00 00 00       	mov    $0xf,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <mknod>:
SYSCALL(mknod)
 443:	b8 11 00 00 00       	mov    $0x11,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <unlink>:
SYSCALL(unlink)
 44b:	b8 12 00 00 00       	mov    $0x12,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <fstat>:
SYSCALL(fstat)
 453:	b8 08 00 00 00       	mov    $0x8,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <link>:
SYSCALL(link)
 45b:	b8 13 00 00 00       	mov    $0x13,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <mkdir>:
SYSCALL(mkdir)
 463:	b8 14 00 00 00       	mov    $0x14,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <chdir>:
SYSCALL(chdir)
 46b:	b8 09 00 00 00       	mov    $0x9,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <dup>:
SYSCALL(dup)
 473:	b8 0a 00 00 00       	mov    $0xa,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <getpid>:
SYSCALL(getpid)
 47b:	b8 0b 00 00 00       	mov    $0xb,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <sbrk>:
SYSCALL(sbrk)
 483:	b8 0c 00 00 00       	mov    $0xc,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <sleep>:
SYSCALL(sleep)
 48b:	b8 0d 00 00 00       	mov    $0xd,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <uptime>:
SYSCALL(uptime)
 493:	b8 0e 00 00 00       	mov    $0xe,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <halt>:
SYSCALL(halt)
 49b:	b8 16 00 00 00       	mov    $0x16,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <date>:
SYSCALL(date)
 4a3:	b8 17 00 00 00       	mov    $0x17,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <getuid>:
SYSCALL(getuid)
 4ab:	b8 18 00 00 00       	mov    $0x18,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <getgid>:
SYSCALL(getgid)
 4b3:	b8 19 00 00 00       	mov    $0x19,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <getppid>:
SYSCALL(getppid)
 4bb:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <setuid>:
SYSCALL(setuid)
 4c3:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <setgid>:
SYSCALL(setgid)
 4cb:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <getprocs>:
SYSCALL(getprocs)
 4d3:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <setpriority>:
SYSCALL(setpriority)
 4db:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <chown>:
SYSCALL(chown)
 4e3:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4eb:	f3 0f 1e fb          	endbr32 
 4ef:	55                   	push   %ebp
 4f0:	89 e5                	mov    %esp,%ebp
 4f2:	83 ec 18             	sub    $0x18,%esp
 4f5:	8b 45 0c             	mov    0xc(%ebp),%eax
 4f8:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4fb:	83 ec 04             	sub    $0x4,%esp
 4fe:	6a 01                	push   $0x1
 500:	8d 45 f4             	lea    -0xc(%ebp),%eax
 503:	50                   	push   %eax
 504:	ff 75 08             	pushl  0x8(%ebp)
 507:	e8 0f ff ff ff       	call   41b <write>
 50c:	83 c4 10             	add    $0x10,%esp
}
 50f:	90                   	nop
 510:	c9                   	leave  
 511:	c3                   	ret    

00000512 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 512:	f3 0f 1e fb          	endbr32 
 516:	55                   	push   %ebp
 517:	89 e5                	mov    %esp,%ebp
 519:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 51c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 523:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 527:	74 17                	je     540 <printint+0x2e>
 529:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 52d:	79 11                	jns    540 <printint+0x2e>
    neg = 1;
 52f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 536:	8b 45 0c             	mov    0xc(%ebp),%eax
 539:	f7 d8                	neg    %eax
 53b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 53e:	eb 06                	jmp    546 <printint+0x34>
  } else {
    x = xx;
 540:	8b 45 0c             	mov    0xc(%ebp),%eax
 543:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 546:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 54d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 550:	8b 45 ec             	mov    -0x14(%ebp),%eax
 553:	ba 00 00 00 00       	mov    $0x0,%edx
 558:	f7 f1                	div    %ecx
 55a:	89 d1                	mov    %edx,%ecx
 55c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 55f:	8d 50 01             	lea    0x1(%eax),%edx
 562:	89 55 f4             	mov    %edx,-0xc(%ebp)
 565:	0f b6 91 30 13 00 00 	movzbl 0x1330(%ecx),%edx
 56c:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 570:	8b 4d 10             	mov    0x10(%ebp),%ecx
 573:	8b 45 ec             	mov    -0x14(%ebp),%eax
 576:	ba 00 00 00 00       	mov    $0x0,%edx
 57b:	f7 f1                	div    %ecx
 57d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 580:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 584:	75 c7                	jne    54d <printint+0x3b>
  if(neg)
 586:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 58a:	74 2d                	je     5b9 <printint+0xa7>
    buf[i++] = '-';
 58c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58f:	8d 50 01             	lea    0x1(%eax),%edx
 592:	89 55 f4             	mov    %edx,-0xc(%ebp)
 595:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 59a:	eb 1d                	jmp    5b9 <printint+0xa7>
    putc(fd, buf[i]);
 59c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 59f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a2:	01 d0                	add    %edx,%eax
 5a4:	0f b6 00             	movzbl (%eax),%eax
 5a7:	0f be c0             	movsbl %al,%eax
 5aa:	83 ec 08             	sub    $0x8,%esp
 5ad:	50                   	push   %eax
 5ae:	ff 75 08             	pushl  0x8(%ebp)
 5b1:	e8 35 ff ff ff       	call   4eb <putc>
 5b6:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5b9:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5c1:	79 d9                	jns    59c <printint+0x8a>
}
 5c3:	90                   	nop
 5c4:	90                   	nop
 5c5:	c9                   	leave  
 5c6:	c3                   	ret    

000005c7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5c7:	f3 0f 1e fb          	endbr32 
 5cb:	55                   	push   %ebp
 5cc:	89 e5                	mov    %esp,%ebp
 5ce:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5d8:	8d 45 0c             	lea    0xc(%ebp),%eax
 5db:	83 c0 04             	add    $0x4,%eax
 5de:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5e8:	e9 59 01 00 00       	jmp    746 <printf+0x17f>
    c = fmt[i] & 0xff;
 5ed:	8b 55 0c             	mov    0xc(%ebp),%edx
 5f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5f3:	01 d0                	add    %edx,%eax
 5f5:	0f b6 00             	movzbl (%eax),%eax
 5f8:	0f be c0             	movsbl %al,%eax
 5fb:	25 ff 00 00 00       	and    $0xff,%eax
 600:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 603:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 607:	75 2c                	jne    635 <printf+0x6e>
      if(c == '%'){
 609:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 60d:	75 0c                	jne    61b <printf+0x54>
        state = '%';
 60f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 616:	e9 27 01 00 00       	jmp    742 <printf+0x17b>
      } else {
        putc(fd, c);
 61b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 61e:	0f be c0             	movsbl %al,%eax
 621:	83 ec 08             	sub    $0x8,%esp
 624:	50                   	push   %eax
 625:	ff 75 08             	pushl  0x8(%ebp)
 628:	e8 be fe ff ff       	call   4eb <putc>
 62d:	83 c4 10             	add    $0x10,%esp
 630:	e9 0d 01 00 00       	jmp    742 <printf+0x17b>
      }
    } else if(state == '%'){
 635:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 639:	0f 85 03 01 00 00    	jne    742 <printf+0x17b>
      if(c == 'd'){
 63f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 643:	75 1e                	jne    663 <printf+0x9c>
        printint(fd, *ap, 10, 1);
 645:	8b 45 e8             	mov    -0x18(%ebp),%eax
 648:	8b 00                	mov    (%eax),%eax
 64a:	6a 01                	push   $0x1
 64c:	6a 0a                	push   $0xa
 64e:	50                   	push   %eax
 64f:	ff 75 08             	pushl  0x8(%ebp)
 652:	e8 bb fe ff ff       	call   512 <printint>
 657:	83 c4 10             	add    $0x10,%esp
        ap++;
 65a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 65e:	e9 d8 00 00 00       	jmp    73b <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 663:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 667:	74 06                	je     66f <printf+0xa8>
 669:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 66d:	75 1e                	jne    68d <printf+0xc6>
        printint(fd, *ap, 16, 0);
 66f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 672:	8b 00                	mov    (%eax),%eax
 674:	6a 00                	push   $0x0
 676:	6a 10                	push   $0x10
 678:	50                   	push   %eax
 679:	ff 75 08             	pushl  0x8(%ebp)
 67c:	e8 91 fe ff ff       	call   512 <printint>
 681:	83 c4 10             	add    $0x10,%esp
        ap++;
 684:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 688:	e9 ae 00 00 00       	jmp    73b <printf+0x174>
      } else if(c == 's'){
 68d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 691:	75 43                	jne    6d6 <printf+0x10f>
        s = (char*)*ap;
 693:	8b 45 e8             	mov    -0x18(%ebp),%eax
 696:	8b 00                	mov    (%eax),%eax
 698:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 69b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 69f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6a3:	75 25                	jne    6ca <printf+0x103>
          s = "(null)";
 6a5:	c7 45 f4 fe 0e 00 00 	movl   $0xefe,-0xc(%ebp)
        while(*s != 0){
 6ac:	eb 1c                	jmp    6ca <printf+0x103>
          putc(fd, *s);
 6ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6b1:	0f b6 00             	movzbl (%eax),%eax
 6b4:	0f be c0             	movsbl %al,%eax
 6b7:	83 ec 08             	sub    $0x8,%esp
 6ba:	50                   	push   %eax
 6bb:	ff 75 08             	pushl  0x8(%ebp)
 6be:	e8 28 fe ff ff       	call   4eb <putc>
 6c3:	83 c4 10             	add    $0x10,%esp
          s++;
 6c6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6cd:	0f b6 00             	movzbl (%eax),%eax
 6d0:	84 c0                	test   %al,%al
 6d2:	75 da                	jne    6ae <printf+0xe7>
 6d4:	eb 65                	jmp    73b <printf+0x174>
        }
      } else if(c == 'c'){
 6d6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6da:	75 1d                	jne    6f9 <printf+0x132>
        putc(fd, *ap);
 6dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6df:	8b 00                	mov    (%eax),%eax
 6e1:	0f be c0             	movsbl %al,%eax
 6e4:	83 ec 08             	sub    $0x8,%esp
 6e7:	50                   	push   %eax
 6e8:	ff 75 08             	pushl  0x8(%ebp)
 6eb:	e8 fb fd ff ff       	call   4eb <putc>
 6f0:	83 c4 10             	add    $0x10,%esp
        ap++;
 6f3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6f7:	eb 42                	jmp    73b <printf+0x174>
      } else if(c == '%'){
 6f9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6fd:	75 17                	jne    716 <printf+0x14f>
        putc(fd, c);
 6ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 702:	0f be c0             	movsbl %al,%eax
 705:	83 ec 08             	sub    $0x8,%esp
 708:	50                   	push   %eax
 709:	ff 75 08             	pushl  0x8(%ebp)
 70c:	e8 da fd ff ff       	call   4eb <putc>
 711:	83 c4 10             	add    $0x10,%esp
 714:	eb 25                	jmp    73b <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 716:	83 ec 08             	sub    $0x8,%esp
 719:	6a 25                	push   $0x25
 71b:	ff 75 08             	pushl  0x8(%ebp)
 71e:	e8 c8 fd ff ff       	call   4eb <putc>
 723:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 726:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 729:	0f be c0             	movsbl %al,%eax
 72c:	83 ec 08             	sub    $0x8,%esp
 72f:	50                   	push   %eax
 730:	ff 75 08             	pushl  0x8(%ebp)
 733:	e8 b3 fd ff ff       	call   4eb <putc>
 738:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 73b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 742:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 746:	8b 55 0c             	mov    0xc(%ebp),%edx
 749:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74c:	01 d0                	add    %edx,%eax
 74e:	0f b6 00             	movzbl (%eax),%eax
 751:	84 c0                	test   %al,%al
 753:	0f 85 94 fe ff ff    	jne    5ed <printf+0x26>
    }
  }
}
 759:	90                   	nop
 75a:	90                   	nop
 75b:	c9                   	leave  
 75c:	c3                   	ret    

0000075d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 75d:	f3 0f 1e fb          	endbr32 
 761:	55                   	push   %ebp
 762:	89 e5                	mov    %esp,%ebp
 764:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 767:	8b 45 08             	mov    0x8(%ebp),%eax
 76a:	83 e8 08             	sub    $0x8,%eax
 76d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 770:	a1 68 13 00 00       	mov    0x1368,%eax
 775:	89 45 fc             	mov    %eax,-0x4(%ebp)
 778:	eb 24                	jmp    79e <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77d:	8b 00                	mov    (%eax),%eax
 77f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 782:	72 12                	jb     796 <free+0x39>
 784:	8b 45 f8             	mov    -0x8(%ebp),%eax
 787:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 78a:	77 24                	ja     7b0 <free+0x53>
 78c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78f:	8b 00                	mov    (%eax),%eax
 791:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 794:	72 1a                	jb     7b0 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 796:	8b 45 fc             	mov    -0x4(%ebp),%eax
 799:	8b 00                	mov    (%eax),%eax
 79b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 79e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7a4:	76 d4                	jbe    77a <free+0x1d>
 7a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a9:	8b 00                	mov    (%eax),%eax
 7ab:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7ae:	73 ca                	jae    77a <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b3:	8b 40 04             	mov    0x4(%eax),%eax
 7b6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c0:	01 c2                	add    %eax,%edx
 7c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c5:	8b 00                	mov    (%eax),%eax
 7c7:	39 c2                	cmp    %eax,%edx
 7c9:	75 24                	jne    7ef <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 7cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ce:	8b 50 04             	mov    0x4(%eax),%edx
 7d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d4:	8b 00                	mov    (%eax),%eax
 7d6:	8b 40 04             	mov    0x4(%eax),%eax
 7d9:	01 c2                	add    %eax,%edx
 7db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7de:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e4:	8b 00                	mov    (%eax),%eax
 7e6:	8b 10                	mov    (%eax),%edx
 7e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7eb:	89 10                	mov    %edx,(%eax)
 7ed:	eb 0a                	jmp    7f9 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 7ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f2:	8b 10                	mov    (%eax),%edx
 7f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f7:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fc:	8b 40 04             	mov    0x4(%eax),%eax
 7ff:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 806:	8b 45 fc             	mov    -0x4(%ebp),%eax
 809:	01 d0                	add    %edx,%eax
 80b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 80e:	75 20                	jne    830 <free+0xd3>
    p->s.size += bp->s.size;
 810:	8b 45 fc             	mov    -0x4(%ebp),%eax
 813:	8b 50 04             	mov    0x4(%eax),%edx
 816:	8b 45 f8             	mov    -0x8(%ebp),%eax
 819:	8b 40 04             	mov    0x4(%eax),%eax
 81c:	01 c2                	add    %eax,%edx
 81e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 821:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 824:	8b 45 f8             	mov    -0x8(%ebp),%eax
 827:	8b 10                	mov    (%eax),%edx
 829:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82c:	89 10                	mov    %edx,(%eax)
 82e:	eb 08                	jmp    838 <free+0xdb>
  } else
    p->s.ptr = bp;
 830:	8b 45 fc             	mov    -0x4(%ebp),%eax
 833:	8b 55 f8             	mov    -0x8(%ebp),%edx
 836:	89 10                	mov    %edx,(%eax)
  freep = p;
 838:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83b:	a3 68 13 00 00       	mov    %eax,0x1368
}
 840:	90                   	nop
 841:	c9                   	leave  
 842:	c3                   	ret    

00000843 <morecore>:

static Header*
morecore(uint nu)
{
 843:	f3 0f 1e fb          	endbr32 
 847:	55                   	push   %ebp
 848:	89 e5                	mov    %esp,%ebp
 84a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 84d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 854:	77 07                	ja     85d <morecore+0x1a>
    nu = 4096;
 856:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 85d:	8b 45 08             	mov    0x8(%ebp),%eax
 860:	c1 e0 03             	shl    $0x3,%eax
 863:	83 ec 0c             	sub    $0xc,%esp
 866:	50                   	push   %eax
 867:	e8 17 fc ff ff       	call   483 <sbrk>
 86c:	83 c4 10             	add    $0x10,%esp
 86f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 872:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 876:	75 07                	jne    87f <morecore+0x3c>
    return 0;
 878:	b8 00 00 00 00       	mov    $0x0,%eax
 87d:	eb 26                	jmp    8a5 <morecore+0x62>
  hp = (Header*)p;
 87f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 882:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 885:	8b 45 f0             	mov    -0x10(%ebp),%eax
 888:	8b 55 08             	mov    0x8(%ebp),%edx
 88b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 88e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 891:	83 c0 08             	add    $0x8,%eax
 894:	83 ec 0c             	sub    $0xc,%esp
 897:	50                   	push   %eax
 898:	e8 c0 fe ff ff       	call   75d <free>
 89d:	83 c4 10             	add    $0x10,%esp
  return freep;
 8a0:	a1 68 13 00 00       	mov    0x1368,%eax
}
 8a5:	c9                   	leave  
 8a6:	c3                   	ret    

000008a7 <malloc>:

void*
malloc(uint nbytes)
{
 8a7:	f3 0f 1e fb          	endbr32 
 8ab:	55                   	push   %ebp
 8ac:	89 e5                	mov    %esp,%ebp
 8ae:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b1:	8b 45 08             	mov    0x8(%ebp),%eax
 8b4:	83 c0 07             	add    $0x7,%eax
 8b7:	c1 e8 03             	shr    $0x3,%eax
 8ba:	83 c0 01             	add    $0x1,%eax
 8bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8c0:	a1 68 13 00 00       	mov    0x1368,%eax
 8c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8c8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8cc:	75 23                	jne    8f1 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 8ce:	c7 45 f0 60 13 00 00 	movl   $0x1360,-0x10(%ebp)
 8d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d8:	a3 68 13 00 00       	mov    %eax,0x1368
 8dd:	a1 68 13 00 00       	mov    0x1368,%eax
 8e2:	a3 60 13 00 00       	mov    %eax,0x1360
    base.s.size = 0;
 8e7:	c7 05 64 13 00 00 00 	movl   $0x0,0x1364
 8ee:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f4:	8b 00                	mov    (%eax),%eax
 8f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fc:	8b 40 04             	mov    0x4(%eax),%eax
 8ff:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 902:	77 4d                	ja     951 <malloc+0xaa>
      if(p->s.size == nunits)
 904:	8b 45 f4             	mov    -0xc(%ebp),%eax
 907:	8b 40 04             	mov    0x4(%eax),%eax
 90a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 90d:	75 0c                	jne    91b <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 90f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 912:	8b 10                	mov    (%eax),%edx
 914:	8b 45 f0             	mov    -0x10(%ebp),%eax
 917:	89 10                	mov    %edx,(%eax)
 919:	eb 26                	jmp    941 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 91b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91e:	8b 40 04             	mov    0x4(%eax),%eax
 921:	2b 45 ec             	sub    -0x14(%ebp),%eax
 924:	89 c2                	mov    %eax,%edx
 926:	8b 45 f4             	mov    -0xc(%ebp),%eax
 929:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 92c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92f:	8b 40 04             	mov    0x4(%eax),%eax
 932:	c1 e0 03             	shl    $0x3,%eax
 935:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 938:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 93e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 941:	8b 45 f0             	mov    -0x10(%ebp),%eax
 944:	a3 68 13 00 00       	mov    %eax,0x1368
      return (void*)(p + 1);
 949:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94c:	83 c0 08             	add    $0x8,%eax
 94f:	eb 3b                	jmp    98c <malloc+0xe5>
    }
    if(p == freep)
 951:	a1 68 13 00 00       	mov    0x1368,%eax
 956:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 959:	75 1e                	jne    979 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 95b:	83 ec 0c             	sub    $0xc,%esp
 95e:	ff 75 ec             	pushl  -0x14(%ebp)
 961:	e8 dd fe ff ff       	call   843 <morecore>
 966:	83 c4 10             	add    $0x10,%esp
 969:	89 45 f4             	mov    %eax,-0xc(%ebp)
 96c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 970:	75 07                	jne    979 <malloc+0xd2>
        return 0;
 972:	b8 00 00 00 00       	mov    $0x0,%eax
 977:	eb 13                	jmp    98c <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 979:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 97f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 982:	8b 00                	mov    (%eax),%eax
 984:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 987:	e9 6d ff ff ff       	jmp    8f9 <malloc+0x52>
  }
}
 98c:	c9                   	leave  
 98d:	c3                   	ret    

0000098e <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
 98e:	f3 0f 1e fb          	endbr32 
 992:	55                   	push   %ebp
 993:	89 e5                	mov    %esp,%ebp
 995:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 998:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 99f:	a1 c0 13 00 00       	mov    0x13c0,%eax
 9a4:	83 ec 04             	sub    $0x4,%esp
 9a7:	50                   	push   %eax
 9a8:	6a 20                	push   $0x20
 9aa:	68 a0 13 00 00       	push   $0x13a0
 9af:	e8 11 f8 ff ff       	call   1c5 <fgets>
 9b4:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 9b7:	83 ec 0c             	sub    $0xc,%esp
 9ba:	68 a0 13 00 00       	push   $0x13a0
 9bf:	e8 0e f7 ff ff       	call   d2 <strlen>
 9c4:	83 c4 10             	add    $0x10,%esp
 9c7:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 9ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9cd:	83 e8 01             	sub    $0x1,%eax
 9d0:	0f b6 80 a0 13 00 00 	movzbl 0x13a0(%eax),%eax
 9d7:	3c 0a                	cmp    $0xa,%al
 9d9:	74 11                	je     9ec <get_id+0x5e>
 9db:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9de:	83 e8 01             	sub    $0x1,%eax
 9e1:	0f b6 80 a0 13 00 00 	movzbl 0x13a0(%eax),%eax
 9e8:	3c 0d                	cmp    $0xd,%al
 9ea:	75 0d                	jne    9f9 <get_id+0x6b>
        current_line[len - 1] = 0;
 9ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9ef:	83 e8 01             	sub    $0x1,%eax
 9f2:	c6 80 a0 13 00 00 00 	movb   $0x0,0x13a0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 9f9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 a00:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 a07:	eb 6c                	jmp    a75 <get_id+0xe7>
        if(current_line[i] == ' '){
 a09:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a0c:	05 a0 13 00 00       	add    $0x13a0,%eax
 a11:	0f b6 00             	movzbl (%eax),%eax
 a14:	3c 20                	cmp    $0x20,%al
 a16:	75 30                	jne    a48 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 a18:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a1c:	75 16                	jne    a34 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 a1e:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a21:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a24:	8d 50 01             	lea    0x1(%eax),%edx
 a27:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a2a:	8d 91 a0 13 00 00    	lea    0x13a0(%ecx),%edx
 a30:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 a34:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a37:	05 a0 13 00 00       	add    $0x13a0,%eax
 a3c:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 a3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a46:	eb 29                	jmp    a71 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 a48:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a4c:	75 23                	jne    a71 <get_id+0xe3>
 a4e:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 a52:	7f 1d                	jg     a71 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 a54:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 a5b:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a61:	8d 50 01             	lea    0x1(%eax),%edx
 a64:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a67:	8d 91 a0 13 00 00    	lea    0x13a0(%ecx),%edx
 a6d:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 a71:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 a75:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a78:	05 a0 13 00 00       	add    $0x13a0,%eax
 a7d:	0f b6 00             	movzbl (%eax),%eax
 a80:	84 c0                	test   %al,%al
 a82:	75 85                	jne    a09 <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 a84:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 a88:	75 07                	jne    a91 <get_id+0x103>
        return -1;
 a8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a8f:	eb 35                	jmp    ac6 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
 a91:	8b 45 dc             	mov    -0x24(%ebp),%eax
 a94:	a3 80 13 00 00       	mov    %eax,0x1380
    current_id.uid_user = atoi(tokens[1]);
 a99:	8b 45 e0             	mov    -0x20(%ebp),%eax
 a9c:	83 ec 0c             	sub    $0xc,%esp
 a9f:	50                   	push   %eax
 aa0:	e8 e5 f7 ff ff       	call   28a <atoi>
 aa5:	83 c4 10             	add    $0x10,%esp
 aa8:	a3 84 13 00 00       	mov    %eax,0x1384
    current_id.gid_user = atoi(tokens[2]);
 aad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 ab0:	83 ec 0c             	sub    $0xc,%esp
 ab3:	50                   	push   %eax
 ab4:	e8 d1 f7 ff ff       	call   28a <atoi>
 ab9:	83 c4 10             	add    $0x10,%esp
 abc:	a3 88 13 00 00       	mov    %eax,0x1388

    return 0;
 ac1:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ac6:	c9                   	leave  
 ac7:	c3                   	ret    

00000ac8 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
 ac8:	f3 0f 1e fb          	endbr32 
 acc:	55                   	push   %ebp
 acd:	89 e5                	mov    %esp,%ebp
 acf:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 ad2:	a1 c0 13 00 00       	mov    0x13c0,%eax
 ad7:	85 c0                	test   %eax,%eax
 ad9:	75 31                	jne    b0c <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
 adb:	83 ec 08             	sub    $0x8,%esp
 ade:	6a 00                	push   $0x0
 ae0:	68 05 0f 00 00       	push   $0xf05
 ae5:	e8 51 f9 ff ff       	call   43b <open>
 aea:	83 c4 10             	add    $0x10,%esp
 aed:	a3 c0 13 00 00       	mov    %eax,0x13c0

        if(dir < 0){        // kalau gagal membuka file
 af2:	a1 c0 13 00 00       	mov    0x13c0,%eax
 af7:	85 c0                	test   %eax,%eax
 af9:	79 11                	jns    b0c <getid+0x44>
            dir = 0;
 afb:	c7 05 c0 13 00 00 00 	movl   $0x0,0x13c0
 b02:	00 00 00 
            return 0;
 b05:	b8 00 00 00 00       	mov    $0x0,%eax
 b0a:	eb 16                	jmp    b22 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
 b0c:	e8 7d fe ff ff       	call   98e <get_id>
 b11:	83 f8 ff             	cmp    $0xffffffff,%eax
 b14:	75 07                	jne    b1d <getid+0x55>
        return 0;
 b16:	b8 00 00 00 00       	mov    $0x0,%eax
 b1b:	eb 05                	jmp    b22 <getid+0x5a>
    
    return &current_id;
 b1d:	b8 80 13 00 00       	mov    $0x1380,%eax
}
 b22:	c9                   	leave  
 b23:	c3                   	ret    

00000b24 <setid>:

// open file_ids
void setid(void){
 b24:	f3 0f 1e fb          	endbr32 
 b28:	55                   	push   %ebp
 b29:	89 e5                	mov    %esp,%ebp
 b2b:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b2e:	a1 c0 13 00 00       	mov    0x13c0,%eax
 b33:	85 c0                	test   %eax,%eax
 b35:	74 1b                	je     b52 <setid+0x2e>
        close(dir);
 b37:	a1 c0 13 00 00       	mov    0x13c0,%eax
 b3c:	83 ec 0c             	sub    $0xc,%esp
 b3f:	50                   	push   %eax
 b40:	e8 de f8 ff ff       	call   423 <close>
 b45:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 b48:	c7 05 c0 13 00 00 00 	movl   $0x0,0x13c0
 b4f:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
 b52:	83 ec 08             	sub    $0x8,%esp
 b55:	6a 00                	push   $0x0
 b57:	68 05 0f 00 00       	push   $0xf05
 b5c:	e8 da f8 ff ff       	call   43b <open>
 b61:	83 c4 10             	add    $0x10,%esp
 b64:	a3 c0 13 00 00       	mov    %eax,0x13c0

    if (dir < 0)
 b69:	a1 c0 13 00 00       	mov    0x13c0,%eax
 b6e:	85 c0                	test   %eax,%eax
 b70:	79 0a                	jns    b7c <setid+0x58>
        dir = 0;
 b72:	c7 05 c0 13 00 00 00 	movl   $0x0,0x13c0
 b79:	00 00 00 
}
 b7c:	90                   	nop
 b7d:	c9                   	leave  
 b7e:	c3                   	ret    

00000b7f <endid>:

// tutup file_ids
void endid (void){
 b7f:	f3 0f 1e fb          	endbr32 
 b83:	55                   	push   %ebp
 b84:	89 e5                	mov    %esp,%ebp
 b86:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b89:	a1 c0 13 00 00       	mov    0x13c0,%eax
 b8e:	85 c0                	test   %eax,%eax
 b90:	74 1b                	je     bad <endid+0x2e>
        close(dir);
 b92:	a1 c0 13 00 00       	mov    0x13c0,%eax
 b97:	83 ec 0c             	sub    $0xc,%esp
 b9a:	50                   	push   %eax
 b9b:	e8 83 f8 ff ff       	call   423 <close>
 ba0:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 ba3:	c7 05 c0 13 00 00 00 	movl   $0x0,0x13c0
 baa:	00 00 00 
    }
}
 bad:	90                   	nop
 bae:	c9                   	leave  
 baf:	c3                   	ret    

00000bb0 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
 bb0:	f3 0f 1e fb          	endbr32 
 bb4:	55                   	push   %ebp
 bb5:	89 e5                	mov    %esp,%ebp
 bb7:	83 ec 08             	sub    $0x8,%esp
    setid();
 bba:	e8 65 ff ff ff       	call   b24 <setid>

    while (getid()){
 bbf:	eb 24                	jmp    be5 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
 bc1:	a1 80 13 00 00       	mov    0x1380,%eax
 bc6:	83 ec 08             	sub    $0x8,%esp
 bc9:	50                   	push   %eax
 bca:	ff 75 08             	pushl  0x8(%ebp)
 bcd:	e8 bd f4 ff ff       	call   8f <strcmp>
 bd2:	83 c4 10             	add    $0x10,%esp
 bd5:	85 c0                	test   %eax,%eax
 bd7:	75 0c                	jne    be5 <cek_nama+0x35>
            endid();
 bd9:	e8 a1 ff ff ff       	call   b7f <endid>
            return &current_id;
 bde:	b8 80 13 00 00       	mov    $0x1380,%eax
 be3:	eb 13                	jmp    bf8 <cek_nama+0x48>
    while (getid()){
 be5:	e8 de fe ff ff       	call   ac8 <getid>
 bea:	85 c0                	test   %eax,%eax
 bec:	75 d3                	jne    bc1 <cek_nama+0x11>
        }
    }
    endid();
 bee:	e8 8c ff ff ff       	call   b7f <endid>
    return 0;
 bf3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 bf8:	c9                   	leave  
 bf9:	c3                   	ret    

00000bfa <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
 bfa:	f3 0f 1e fb          	endbr32 
 bfe:	55                   	push   %ebp
 bff:	89 e5                	mov    %esp,%ebp
 c01:	83 ec 08             	sub    $0x8,%esp
    setid();
 c04:	e8 1b ff ff ff       	call   b24 <setid>

    while (getid()){
 c09:	eb 16                	jmp    c21 <cek_uid+0x27>
        if(current_id.uid_user == uid){
 c0b:	a1 84 13 00 00       	mov    0x1384,%eax
 c10:	39 45 08             	cmp    %eax,0x8(%ebp)
 c13:	75 0c                	jne    c21 <cek_uid+0x27>
            endid();
 c15:	e8 65 ff ff ff       	call   b7f <endid>
            return &current_id;
 c1a:	b8 80 13 00 00       	mov    $0x1380,%eax
 c1f:	eb 13                	jmp    c34 <cek_uid+0x3a>
    while (getid()){
 c21:	e8 a2 fe ff ff       	call   ac8 <getid>
 c26:	85 c0                	test   %eax,%eax
 c28:	75 e1                	jne    c0b <cek_uid+0x11>
        }
    }
    endid();
 c2a:	e8 50 ff ff ff       	call   b7f <endid>
    return 0;
 c2f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c34:	c9                   	leave  
 c35:	c3                   	ret    

00000c36 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
 c36:	f3 0f 1e fb          	endbr32 
 c3a:	55                   	push   %ebp
 c3b:	89 e5                	mov    %esp,%ebp
 c3d:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 c40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 c47:	a1 c0 13 00 00       	mov    0x13c0,%eax
 c4c:	83 ec 04             	sub    $0x4,%esp
 c4f:	50                   	push   %eax
 c50:	6a 20                	push   $0x20
 c52:	68 a0 13 00 00       	push   $0x13a0
 c57:	e8 69 f5 ff ff       	call   1c5 <fgets>
 c5c:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 c5f:	83 ec 0c             	sub    $0xc,%esp
 c62:	68 a0 13 00 00       	push   $0x13a0
 c67:	e8 66 f4 ff ff       	call   d2 <strlen>
 c6c:	83 c4 10             	add    $0x10,%esp
 c6f:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 c72:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c75:	83 e8 01             	sub    $0x1,%eax
 c78:	0f b6 80 a0 13 00 00 	movzbl 0x13a0(%eax),%eax
 c7f:	3c 0a                	cmp    $0xa,%al
 c81:	74 11                	je     c94 <get_group+0x5e>
 c83:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c86:	83 e8 01             	sub    $0x1,%eax
 c89:	0f b6 80 a0 13 00 00 	movzbl 0x13a0(%eax),%eax
 c90:	3c 0d                	cmp    $0xd,%al
 c92:	75 0d                	jne    ca1 <get_group+0x6b>
        current_line[len - 1] = 0;
 c94:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c97:	83 e8 01             	sub    $0x1,%eax
 c9a:	c6 80 a0 13 00 00 00 	movb   $0x0,0x13a0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 ca1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 ca8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 caf:	eb 6c                	jmp    d1d <get_group+0xe7>
        if(current_line[i] == ' '){
 cb1:	8b 45 ec             	mov    -0x14(%ebp),%eax
 cb4:	05 a0 13 00 00       	add    $0x13a0,%eax
 cb9:	0f b6 00             	movzbl (%eax),%eax
 cbc:	3c 20                	cmp    $0x20,%al
 cbe:	75 30                	jne    cf0 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 cc0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 cc4:	75 16                	jne    cdc <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 cc6:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 cc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ccc:	8d 50 01             	lea    0x1(%eax),%edx
 ccf:	89 55 f0             	mov    %edx,-0x10(%ebp)
 cd2:	8d 91 a0 13 00 00    	lea    0x13a0(%ecx),%edx
 cd8:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 cdc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 cdf:	05 a0 13 00 00       	add    $0x13a0,%eax
 ce4:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 ce7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 cee:	eb 29                	jmp    d19 <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 cf0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 cf4:	75 23                	jne    d19 <get_group+0xe3>
 cf6:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 cfa:	7f 1d                	jg     d19 <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 cfc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 d03:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d06:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d09:	8d 50 01             	lea    0x1(%eax),%edx
 d0c:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d0f:	8d 91 a0 13 00 00    	lea    0x13a0(%ecx),%edx
 d15:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 d19:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 d1d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d20:	05 a0 13 00 00       	add    $0x13a0,%eax
 d25:	0f b6 00             	movzbl (%eax),%eax
 d28:	84 c0                	test   %al,%al
 d2a:	75 85                	jne    cb1 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 d2c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 d30:	75 07                	jne    d39 <get_group+0x103>
        return -1;
 d32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d37:	eb 21                	jmp    d5a <get_group+0x124>
    
    current_group.nama_group = tokens[0];
 d39:	8b 45 dc             	mov    -0x24(%ebp),%eax
 d3c:	a3 8c 13 00 00       	mov    %eax,0x138c
    current_group.gid = atoi(tokens[1]);
 d41:	8b 45 e0             	mov    -0x20(%ebp),%eax
 d44:	83 ec 0c             	sub    $0xc,%esp
 d47:	50                   	push   %eax
 d48:	e8 3d f5 ff ff       	call   28a <atoi>
 d4d:	83 c4 10             	add    $0x10,%esp
 d50:	a3 90 13 00 00       	mov    %eax,0x1390

    return 0;
 d55:	b8 00 00 00 00       	mov    $0x0,%eax
}
 d5a:	c9                   	leave  
 d5b:	c3                   	ret    

00000d5c <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
 d5c:	f3 0f 1e fb          	endbr32 
 d60:	55                   	push   %ebp
 d61:	89 e5                	mov    %esp,%ebp
 d63:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 d66:	a1 c0 13 00 00       	mov    0x13c0,%eax
 d6b:	85 c0                	test   %eax,%eax
 d6d:	75 31                	jne    da0 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
 d6f:	83 ec 08             	sub    $0x8,%esp
 d72:	6a 00                	push   $0x0
 d74:	68 0d 0f 00 00       	push   $0xf0d
 d79:	e8 bd f6 ff ff       	call   43b <open>
 d7e:	83 c4 10             	add    $0x10,%esp
 d81:	a3 c0 13 00 00       	mov    %eax,0x13c0

        if(dir < 0){        // kalau gagal membuka file
 d86:	a1 c0 13 00 00       	mov    0x13c0,%eax
 d8b:	85 c0                	test   %eax,%eax
 d8d:	79 11                	jns    da0 <getgroup+0x44>
            dir = 0;
 d8f:	c7 05 c0 13 00 00 00 	movl   $0x0,0x13c0
 d96:	00 00 00 
            return 0;
 d99:	b8 00 00 00 00       	mov    $0x0,%eax
 d9e:	eb 16                	jmp    db6 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
 da0:	e8 91 fe ff ff       	call   c36 <get_group>
 da5:	83 f8 ff             	cmp    $0xffffffff,%eax
 da8:	75 07                	jne    db1 <getgroup+0x55>
        return 0;
 daa:	b8 00 00 00 00       	mov    $0x0,%eax
 daf:	eb 05                	jmp    db6 <getgroup+0x5a>
    
    return &current_group;
 db1:	b8 8c 13 00 00       	mov    $0x138c,%eax
}
 db6:	c9                   	leave  
 db7:	c3                   	ret    

00000db8 <setgroup>:

// open file_ids
void setgroup(void){
 db8:	f3 0f 1e fb          	endbr32 
 dbc:	55                   	push   %ebp
 dbd:	89 e5                	mov    %esp,%ebp
 dbf:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 dc2:	a1 c0 13 00 00       	mov    0x13c0,%eax
 dc7:	85 c0                	test   %eax,%eax
 dc9:	74 1b                	je     de6 <setgroup+0x2e>
        close(dir);
 dcb:	a1 c0 13 00 00       	mov    0x13c0,%eax
 dd0:	83 ec 0c             	sub    $0xc,%esp
 dd3:	50                   	push   %eax
 dd4:	e8 4a f6 ff ff       	call   423 <close>
 dd9:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 ddc:	c7 05 c0 13 00 00 00 	movl   $0x0,0x13c0
 de3:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
 de6:	83 ec 08             	sub    $0x8,%esp
 de9:	6a 00                	push   $0x0
 deb:	68 0d 0f 00 00       	push   $0xf0d
 df0:	e8 46 f6 ff ff       	call   43b <open>
 df5:	83 c4 10             	add    $0x10,%esp
 df8:	a3 c0 13 00 00       	mov    %eax,0x13c0

    if (dir < 0)
 dfd:	a1 c0 13 00 00       	mov    0x13c0,%eax
 e02:	85 c0                	test   %eax,%eax
 e04:	79 0a                	jns    e10 <setgroup+0x58>
        dir = 0;
 e06:	c7 05 c0 13 00 00 00 	movl   $0x0,0x13c0
 e0d:	00 00 00 
}
 e10:	90                   	nop
 e11:	c9                   	leave  
 e12:	c3                   	ret    

00000e13 <endgroup>:

// tutup file_ids
void endgroup (void){
 e13:	f3 0f 1e fb          	endbr32 
 e17:	55                   	push   %ebp
 e18:	89 e5                	mov    %esp,%ebp
 e1a:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e1d:	a1 c0 13 00 00       	mov    0x13c0,%eax
 e22:	85 c0                	test   %eax,%eax
 e24:	74 1b                	je     e41 <endgroup+0x2e>
        close(dir);
 e26:	a1 c0 13 00 00       	mov    0x13c0,%eax
 e2b:	83 ec 0c             	sub    $0xc,%esp
 e2e:	50                   	push   %eax
 e2f:	e8 ef f5 ff ff       	call   423 <close>
 e34:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e37:	c7 05 c0 13 00 00 00 	movl   $0x0,0x13c0
 e3e:	00 00 00 
    }
}
 e41:	90                   	nop
 e42:	c9                   	leave  
 e43:	c3                   	ret    

00000e44 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
 e44:	f3 0f 1e fb          	endbr32 
 e48:	55                   	push   %ebp
 e49:	89 e5                	mov    %esp,%ebp
 e4b:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 e4e:	e8 65 ff ff ff       	call   db8 <setgroup>

    while (getgroup()){
 e53:	eb 3c                	jmp    e91 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
 e55:	a1 8c 13 00 00       	mov    0x138c,%eax
 e5a:	83 ec 08             	sub    $0x8,%esp
 e5d:	50                   	push   %eax
 e5e:	ff 75 08             	pushl  0x8(%ebp)
 e61:	e8 29 f2 ff ff       	call   8f <strcmp>
 e66:	83 c4 10             	add    $0x10,%esp
 e69:	85 c0                	test   %eax,%eax
 e6b:	75 24                	jne    e91 <cek_nama_group+0x4d>
            endgroup();
 e6d:	e8 a1 ff ff ff       	call   e13 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
 e72:	a1 8c 13 00 00       	mov    0x138c,%eax
 e77:	83 ec 04             	sub    $0x4,%esp
 e7a:	50                   	push   %eax
 e7b:	68 18 0f 00 00       	push   $0xf18
 e80:	6a 01                	push   $0x1
 e82:	e8 40 f7 ff ff       	call   5c7 <printf>
 e87:	83 c4 10             	add    $0x10,%esp
            return &current_group;
 e8a:	b8 8c 13 00 00       	mov    $0x138c,%eax
 e8f:	eb 13                	jmp    ea4 <cek_nama_group+0x60>
    while (getgroup()){
 e91:	e8 c6 fe ff ff       	call   d5c <getgroup>
 e96:	85 c0                	test   %eax,%eax
 e98:	75 bb                	jne    e55 <cek_nama_group+0x11>
        }
    }
    endgroup();
 e9a:	e8 74 ff ff ff       	call   e13 <endgroup>
    return 0;
 e9f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ea4:	c9                   	leave  
 ea5:	c3                   	ret    

00000ea6 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
 ea6:	f3 0f 1e fb          	endbr32 
 eaa:	55                   	push   %ebp
 eab:	89 e5                	mov    %esp,%ebp
 ead:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 eb0:	e8 03 ff ff ff       	call   db8 <setgroup>

    while (getgroup()){
 eb5:	eb 16                	jmp    ecd <cek_gid+0x27>
        if(current_group.gid == gid){
 eb7:	a1 90 13 00 00       	mov    0x1390,%eax
 ebc:	39 45 08             	cmp    %eax,0x8(%ebp)
 ebf:	75 0c                	jne    ecd <cek_gid+0x27>
            endgroup();
 ec1:	e8 4d ff ff ff       	call   e13 <endgroup>
            return &current_group;
 ec6:	b8 8c 13 00 00       	mov    $0x138c,%eax
 ecb:	eb 13                	jmp    ee0 <cek_gid+0x3a>
    while (getgroup()){
 ecd:	e8 8a fe ff ff       	call   d5c <getgroup>
 ed2:	85 c0                	test   %eax,%eax
 ed4:	75 e1                	jne    eb7 <cek_gid+0x11>
        }
    }
    endgroup();
 ed6:	e8 38 ff ff ff       	call   e13 <endgroup>
    return 0;
 edb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ee0:	c9                   	leave  
 ee1:	c3                   	ret    
