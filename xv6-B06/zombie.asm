
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	51                   	push   %ecx
  12:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  15:	e8 d4 03 00 00       	call   3ee <fork>
  1a:	85 c0                	test   %eax,%eax
  1c:	7e 0d                	jle    2b <main+0x2b>
    sleep(5);  // Let child exit before parent.
  1e:	83 ec 0c             	sub    $0xc,%esp
  21:	6a 05                	push   $0x5
  23:	e8 5e 04 00 00       	call   486 <sleep>
  28:	83 c4 10             	add    $0x10,%esp
  exit();
  2b:	e8 c6 03 00 00       	call   3f6 <exit>

00000030 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	57                   	push   %edi
  34:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  35:	8b 4d 08             	mov    0x8(%ebp),%ecx
  38:	8b 55 10             	mov    0x10(%ebp),%edx
  3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  3e:	89 cb                	mov    %ecx,%ebx
  40:	89 df                	mov    %ebx,%edi
  42:	89 d1                	mov    %edx,%ecx
  44:	fc                   	cld    
  45:	f3 aa                	rep stos %al,%es:(%edi)
  47:	89 ca                	mov    %ecx,%edx
  49:	89 fb                	mov    %edi,%ebx
  4b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  51:	90                   	nop
  52:	5b                   	pop    %ebx
  53:	5f                   	pop    %edi
  54:	5d                   	pop    %ebp
  55:	c3                   	ret    

00000056 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  56:	f3 0f 1e fb          	endbr32 
  5a:	55                   	push   %ebp
  5b:	89 e5                	mov    %esp,%ebp
  5d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  60:	8b 45 08             	mov    0x8(%ebp),%eax
  63:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  66:	90                   	nop
  67:	8b 55 0c             	mov    0xc(%ebp),%edx
  6a:	8d 42 01             	lea    0x1(%edx),%eax
  6d:	89 45 0c             	mov    %eax,0xc(%ebp)
  70:	8b 45 08             	mov    0x8(%ebp),%eax
  73:	8d 48 01             	lea    0x1(%eax),%ecx
  76:	89 4d 08             	mov    %ecx,0x8(%ebp)
  79:	0f b6 12             	movzbl (%edx),%edx
  7c:	88 10                	mov    %dl,(%eax)
  7e:	0f b6 00             	movzbl (%eax),%eax
  81:	84 c0                	test   %al,%al
  83:	75 e2                	jne    67 <strcpy+0x11>
    ;
  return os;
  85:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  88:	c9                   	leave  
  89:	c3                   	ret    

0000008a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8a:	f3 0f 1e fb          	endbr32 
  8e:	55                   	push   %ebp
  8f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  91:	eb 08                	jmp    9b <strcmp+0x11>
    p++, q++;
  93:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  97:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  9b:	8b 45 08             	mov    0x8(%ebp),%eax
  9e:	0f b6 00             	movzbl (%eax),%eax
  a1:	84 c0                	test   %al,%al
  a3:	74 10                	je     b5 <strcmp+0x2b>
  a5:	8b 45 08             	mov    0x8(%ebp),%eax
  a8:	0f b6 10             	movzbl (%eax),%edx
  ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  ae:	0f b6 00             	movzbl (%eax),%eax
  b1:	38 c2                	cmp    %al,%dl
  b3:	74 de                	je     93 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
  b5:	8b 45 08             	mov    0x8(%ebp),%eax
  b8:	0f b6 00             	movzbl (%eax),%eax
  bb:	0f b6 d0             	movzbl %al,%edx
  be:	8b 45 0c             	mov    0xc(%ebp),%eax
  c1:	0f b6 00             	movzbl (%eax),%eax
  c4:	0f b6 c0             	movzbl %al,%eax
  c7:	29 c2                	sub    %eax,%edx
  c9:	89 d0                	mov    %edx,%eax
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    

000000cd <strlen>:

uint
strlen(char *s)
{
  cd:	f3 0f 1e fb          	endbr32 
  d1:	55                   	push   %ebp
  d2:	89 e5                	mov    %esp,%ebp
  d4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  de:	eb 04                	jmp    e4 <strlen+0x17>
  e0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  e4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  e7:	8b 45 08             	mov    0x8(%ebp),%eax
  ea:	01 d0                	add    %edx,%eax
  ec:	0f b6 00             	movzbl (%eax),%eax
  ef:	84 c0                	test   %al,%al
  f1:	75 ed                	jne    e0 <strlen+0x13>
    ;
  return n;
  f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  f6:	c9                   	leave  
  f7:	c3                   	ret    

000000f8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f8:	f3 0f 1e fb          	endbr32 
  fc:	55                   	push   %ebp
  fd:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  ff:	8b 45 10             	mov    0x10(%ebp),%eax
 102:	50                   	push   %eax
 103:	ff 75 0c             	pushl  0xc(%ebp)
 106:	ff 75 08             	pushl  0x8(%ebp)
 109:	e8 22 ff ff ff       	call   30 <stosb>
 10e:	83 c4 0c             	add    $0xc,%esp
  return dst;
 111:	8b 45 08             	mov    0x8(%ebp),%eax
}
 114:	c9                   	leave  
 115:	c3                   	ret    

00000116 <strchr>:

char*
strchr(const char *s, char c)
{
 116:	f3 0f 1e fb          	endbr32 
 11a:	55                   	push   %ebp
 11b:	89 e5                	mov    %esp,%ebp
 11d:	83 ec 04             	sub    $0x4,%esp
 120:	8b 45 0c             	mov    0xc(%ebp),%eax
 123:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 126:	eb 14                	jmp    13c <strchr+0x26>
    if(*s == c)
 128:	8b 45 08             	mov    0x8(%ebp),%eax
 12b:	0f b6 00             	movzbl (%eax),%eax
 12e:	38 45 fc             	cmp    %al,-0x4(%ebp)
 131:	75 05                	jne    138 <strchr+0x22>
      return (char*)s;
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	eb 13                	jmp    14b <strchr+0x35>
  for(; *s; s++)
 138:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 13c:	8b 45 08             	mov    0x8(%ebp),%eax
 13f:	0f b6 00             	movzbl (%eax),%eax
 142:	84 c0                	test   %al,%al
 144:	75 e2                	jne    128 <strchr+0x12>
  return 0;
 146:	b8 00 00 00 00       	mov    $0x0,%eax
}
 14b:	c9                   	leave  
 14c:	c3                   	ret    

0000014d <gets>:

char*
gets(char *buf, int max)
{
 14d:	f3 0f 1e fb          	endbr32 
 151:	55                   	push   %ebp
 152:	89 e5                	mov    %esp,%ebp
 154:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 157:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 15e:	eb 42                	jmp    1a2 <gets+0x55>
    cc = read(0, &c, 1);
 160:	83 ec 04             	sub    $0x4,%esp
 163:	6a 01                	push   $0x1
 165:	8d 45 ef             	lea    -0x11(%ebp),%eax
 168:	50                   	push   %eax
 169:	6a 00                	push   $0x0
 16b:	e8 9e 02 00 00       	call   40e <read>
 170:	83 c4 10             	add    $0x10,%esp
 173:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 176:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 17a:	7e 33                	jle    1af <gets+0x62>
      break;
    buf[i++] = c;
 17c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17f:	8d 50 01             	lea    0x1(%eax),%edx
 182:	89 55 f4             	mov    %edx,-0xc(%ebp)
 185:	89 c2                	mov    %eax,%edx
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	01 c2                	add    %eax,%edx
 18c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 190:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 192:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 196:	3c 0a                	cmp    $0xa,%al
 198:	74 16                	je     1b0 <gets+0x63>
 19a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 19e:	3c 0d                	cmp    $0xd,%al
 1a0:	74 0e                	je     1b0 <gets+0x63>
  for(i=0; i+1 < max; ){
 1a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a5:	83 c0 01             	add    $0x1,%eax
 1a8:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1ab:	7f b3                	jg     160 <gets+0x13>
 1ad:	eb 01                	jmp    1b0 <gets+0x63>
      break;
 1af:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1b0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	01 d0                	add    %edx,%eax
 1b8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1be:	c9                   	leave  
 1bf:	c3                   	ret    

000001c0 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
 1c0:	f3 0f 1e fb          	endbr32 
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
 1ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1d1:	eb 43                	jmp    216 <fgets+0x56>
    int cc = read(fd, &c, 1);
 1d3:	83 ec 04             	sub    $0x4,%esp
 1d6:	6a 01                	push   $0x1
 1d8:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1db:	50                   	push   %eax
 1dc:	ff 75 10             	pushl  0x10(%ebp)
 1df:	e8 2a 02 00 00       	call   40e <read>
 1e4:	83 c4 10             	add    $0x10,%esp
 1e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1ee:	7e 33                	jle    223 <fgets+0x63>
      break;
    buf[i++] = c;
 1f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1f3:	8d 50 01             	lea    0x1(%eax),%edx
 1f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1f9:	89 c2                	mov    %eax,%edx
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	01 c2                	add    %eax,%edx
 200:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 204:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 206:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 20a:	3c 0a                	cmp    $0xa,%al
 20c:	74 16                	je     224 <fgets+0x64>
 20e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 212:	3c 0d                	cmp    $0xd,%al
 214:	74 0e                	je     224 <fgets+0x64>
  for(i = 0; i + 1 < size;){
 216:	8b 45 f4             	mov    -0xc(%ebp),%eax
 219:	83 c0 01             	add    $0x1,%eax
 21c:	39 45 0c             	cmp    %eax,0xc(%ebp)
 21f:	7f b2                	jg     1d3 <fgets+0x13>
 221:	eb 01                	jmp    224 <fgets+0x64>
      break;
 223:	90                   	nop
      break;
  }
  buf[i] = '\0';
 224:	8b 55 f4             	mov    -0xc(%ebp),%edx
 227:	8b 45 08             	mov    0x8(%ebp),%eax
 22a:	01 d0                	add    %edx,%eax
 22c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 232:	c9                   	leave  
 233:	c3                   	ret    

00000234 <stat>:

int
stat(char *n, struct stat *st)
{
 234:	f3 0f 1e fb          	endbr32 
 238:	55                   	push   %ebp
 239:	89 e5                	mov    %esp,%ebp
 23b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 23e:	83 ec 08             	sub    $0x8,%esp
 241:	6a 00                	push   $0x0
 243:	ff 75 08             	pushl  0x8(%ebp)
 246:	e8 eb 01 00 00       	call   436 <open>
 24b:	83 c4 10             	add    $0x10,%esp
 24e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 251:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 255:	79 07                	jns    25e <stat+0x2a>
    return -1;
 257:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 25c:	eb 25                	jmp    283 <stat+0x4f>
  r = fstat(fd, st);
 25e:	83 ec 08             	sub    $0x8,%esp
 261:	ff 75 0c             	pushl  0xc(%ebp)
 264:	ff 75 f4             	pushl  -0xc(%ebp)
 267:	e8 e2 01 00 00       	call   44e <fstat>
 26c:	83 c4 10             	add    $0x10,%esp
 26f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 272:	83 ec 0c             	sub    $0xc,%esp
 275:	ff 75 f4             	pushl  -0xc(%ebp)
 278:	e8 a1 01 00 00       	call   41e <close>
 27d:	83 c4 10             	add    $0x10,%esp
  return r;
 280:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 283:	c9                   	leave  
 284:	c3                   	ret    

00000285 <atoi>:

int
atoi(const char *s)
{
 285:	f3 0f 1e fb          	endbr32 
 289:	55                   	push   %ebp
 28a:	89 e5                	mov    %esp,%ebp
 28c:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 28f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 296:	eb 04                	jmp    29c <atoi+0x17>
 298:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 29c:	8b 45 08             	mov    0x8(%ebp),%eax
 29f:	0f b6 00             	movzbl (%eax),%eax
 2a2:	3c 20                	cmp    $0x20,%al
 2a4:	74 f2                	je     298 <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
 2a6:	8b 45 08             	mov    0x8(%ebp),%eax
 2a9:	0f b6 00             	movzbl (%eax),%eax
 2ac:	3c 2d                	cmp    $0x2d,%al
 2ae:	75 07                	jne    2b7 <atoi+0x32>
 2b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2b5:	eb 05                	jmp    2bc <atoi+0x37>
 2b7:	b8 01 00 00 00       	mov    $0x1,%eax
 2bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 2bf:	8b 45 08             	mov    0x8(%ebp),%eax
 2c2:	0f b6 00             	movzbl (%eax),%eax
 2c5:	3c 2b                	cmp    $0x2b,%al
 2c7:	74 0a                	je     2d3 <atoi+0x4e>
 2c9:	8b 45 08             	mov    0x8(%ebp),%eax
 2cc:	0f b6 00             	movzbl (%eax),%eax
 2cf:	3c 2d                	cmp    $0x2d,%al
 2d1:	75 2b                	jne    2fe <atoi+0x79>
    s++;
 2d3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 2d7:	eb 25                	jmp    2fe <atoi+0x79>
    n = n*10 + *s++ - '0';
 2d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2dc:	89 d0                	mov    %edx,%eax
 2de:	c1 e0 02             	shl    $0x2,%eax
 2e1:	01 d0                	add    %edx,%eax
 2e3:	01 c0                	add    %eax,%eax
 2e5:	89 c1                	mov    %eax,%ecx
 2e7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ea:	8d 50 01             	lea    0x1(%eax),%edx
 2ed:	89 55 08             	mov    %edx,0x8(%ebp)
 2f0:	0f b6 00             	movzbl (%eax),%eax
 2f3:	0f be c0             	movsbl %al,%eax
 2f6:	01 c8                	add    %ecx,%eax
 2f8:	83 e8 30             	sub    $0x30,%eax
 2fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2fe:	8b 45 08             	mov    0x8(%ebp),%eax
 301:	0f b6 00             	movzbl (%eax),%eax
 304:	3c 2f                	cmp    $0x2f,%al
 306:	7e 0a                	jle    312 <atoi+0x8d>
 308:	8b 45 08             	mov    0x8(%ebp),%eax
 30b:	0f b6 00             	movzbl (%eax),%eax
 30e:	3c 39                	cmp    $0x39,%al
 310:	7e c7                	jle    2d9 <atoi+0x54>
  return sign*n;
 312:	8b 45 f8             	mov    -0x8(%ebp),%eax
 315:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 319:	c9                   	leave  
 31a:	c3                   	ret    

0000031b <atoo>:

int
atoo(const char *s)
{
 31b:	f3 0f 1e fb          	endbr32 
 31f:	55                   	push   %ebp
 320:	89 e5                	mov    %esp,%ebp
 322:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 325:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 32c:	eb 04                	jmp    332 <atoo+0x17>
 32e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 332:	8b 45 08             	mov    0x8(%ebp),%eax
 335:	0f b6 00             	movzbl (%eax),%eax
 338:	3c 20                	cmp    $0x20,%al
 33a:	74 f2                	je     32e <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
 33c:	8b 45 08             	mov    0x8(%ebp),%eax
 33f:	0f b6 00             	movzbl (%eax),%eax
 342:	3c 2d                	cmp    $0x2d,%al
 344:	75 07                	jne    34d <atoo+0x32>
 346:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 34b:	eb 05                	jmp    352 <atoo+0x37>
 34d:	b8 01 00 00 00       	mov    $0x1,%eax
 352:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 355:	8b 45 08             	mov    0x8(%ebp),%eax
 358:	0f b6 00             	movzbl (%eax),%eax
 35b:	3c 2b                	cmp    $0x2b,%al
 35d:	74 0a                	je     369 <atoo+0x4e>
 35f:	8b 45 08             	mov    0x8(%ebp),%eax
 362:	0f b6 00             	movzbl (%eax),%eax
 365:	3c 2d                	cmp    $0x2d,%al
 367:	75 27                	jne    390 <atoo+0x75>
    s++;
 369:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 36d:	eb 21                	jmp    390 <atoo+0x75>
    n = n*8 + *s++ - '0';
 36f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 372:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 379:	8b 45 08             	mov    0x8(%ebp),%eax
 37c:	8d 50 01             	lea    0x1(%eax),%edx
 37f:	89 55 08             	mov    %edx,0x8(%ebp)
 382:	0f b6 00             	movzbl (%eax),%eax
 385:	0f be c0             	movsbl %al,%eax
 388:	01 c8                	add    %ecx,%eax
 38a:	83 e8 30             	sub    $0x30,%eax
 38d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
 390:	8b 45 08             	mov    0x8(%ebp),%eax
 393:	0f b6 00             	movzbl (%eax),%eax
 396:	3c 2f                	cmp    $0x2f,%al
 398:	7e 0a                	jle    3a4 <atoo+0x89>
 39a:	8b 45 08             	mov    0x8(%ebp),%eax
 39d:	0f b6 00             	movzbl (%eax),%eax
 3a0:	3c 37                	cmp    $0x37,%al
 3a2:	7e cb                	jle    36f <atoo+0x54>
  return sign*n;
 3a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3a7:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 3ab:	c9                   	leave  
 3ac:	c3                   	ret    

000003ad <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 3ad:	f3 0f 1e fb          	endbr32 
 3b1:	55                   	push   %ebp
 3b2:	89 e5                	mov    %esp,%ebp
 3b4:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 3b7:	8b 45 08             	mov    0x8(%ebp),%eax
 3ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3bd:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3c3:	eb 17                	jmp    3dc <memmove+0x2f>
    *dst++ = *src++;
 3c5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3c8:	8d 42 01             	lea    0x1(%edx),%eax
 3cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
 3ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3d1:	8d 48 01             	lea    0x1(%eax),%ecx
 3d4:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 3d7:	0f b6 12             	movzbl (%edx),%edx
 3da:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 3dc:	8b 45 10             	mov    0x10(%ebp),%eax
 3df:	8d 50 ff             	lea    -0x1(%eax),%edx
 3e2:	89 55 10             	mov    %edx,0x10(%ebp)
 3e5:	85 c0                	test   %eax,%eax
 3e7:	7f dc                	jg     3c5 <memmove+0x18>
  return vdst;
 3e9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3ec:	c9                   	leave  
 3ed:	c3                   	ret    

000003ee <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ee:	b8 01 00 00 00       	mov    $0x1,%eax
 3f3:	cd 40                	int    $0x40
 3f5:	c3                   	ret    

000003f6 <exit>:
SYSCALL(exit)
 3f6:	b8 02 00 00 00       	mov    $0x2,%eax
 3fb:	cd 40                	int    $0x40
 3fd:	c3                   	ret    

000003fe <wait>:
SYSCALL(wait)
 3fe:	b8 03 00 00 00       	mov    $0x3,%eax
 403:	cd 40                	int    $0x40
 405:	c3                   	ret    

00000406 <pipe>:
SYSCALL(pipe)
 406:	b8 04 00 00 00       	mov    $0x4,%eax
 40b:	cd 40                	int    $0x40
 40d:	c3                   	ret    

0000040e <read>:
SYSCALL(read)
 40e:	b8 05 00 00 00       	mov    $0x5,%eax
 413:	cd 40                	int    $0x40
 415:	c3                   	ret    

00000416 <write>:
SYSCALL(write)
 416:	b8 10 00 00 00       	mov    $0x10,%eax
 41b:	cd 40                	int    $0x40
 41d:	c3                   	ret    

0000041e <close>:
SYSCALL(close)
 41e:	b8 15 00 00 00       	mov    $0x15,%eax
 423:	cd 40                	int    $0x40
 425:	c3                   	ret    

00000426 <kill>:
SYSCALL(kill)
 426:	b8 06 00 00 00       	mov    $0x6,%eax
 42b:	cd 40                	int    $0x40
 42d:	c3                   	ret    

0000042e <exec>:
SYSCALL(exec)
 42e:	b8 07 00 00 00       	mov    $0x7,%eax
 433:	cd 40                	int    $0x40
 435:	c3                   	ret    

00000436 <open>:
SYSCALL(open)
 436:	b8 0f 00 00 00       	mov    $0xf,%eax
 43b:	cd 40                	int    $0x40
 43d:	c3                   	ret    

0000043e <mknod>:
SYSCALL(mknod)
 43e:	b8 11 00 00 00       	mov    $0x11,%eax
 443:	cd 40                	int    $0x40
 445:	c3                   	ret    

00000446 <unlink>:
SYSCALL(unlink)
 446:	b8 12 00 00 00       	mov    $0x12,%eax
 44b:	cd 40                	int    $0x40
 44d:	c3                   	ret    

0000044e <fstat>:
SYSCALL(fstat)
 44e:	b8 08 00 00 00       	mov    $0x8,%eax
 453:	cd 40                	int    $0x40
 455:	c3                   	ret    

00000456 <link>:
SYSCALL(link)
 456:	b8 13 00 00 00       	mov    $0x13,%eax
 45b:	cd 40                	int    $0x40
 45d:	c3                   	ret    

0000045e <mkdir>:
SYSCALL(mkdir)
 45e:	b8 14 00 00 00       	mov    $0x14,%eax
 463:	cd 40                	int    $0x40
 465:	c3                   	ret    

00000466 <chdir>:
SYSCALL(chdir)
 466:	b8 09 00 00 00       	mov    $0x9,%eax
 46b:	cd 40                	int    $0x40
 46d:	c3                   	ret    

0000046e <dup>:
SYSCALL(dup)
 46e:	b8 0a 00 00 00       	mov    $0xa,%eax
 473:	cd 40                	int    $0x40
 475:	c3                   	ret    

00000476 <getpid>:
SYSCALL(getpid)
 476:	b8 0b 00 00 00       	mov    $0xb,%eax
 47b:	cd 40                	int    $0x40
 47d:	c3                   	ret    

0000047e <sbrk>:
SYSCALL(sbrk)
 47e:	b8 0c 00 00 00       	mov    $0xc,%eax
 483:	cd 40                	int    $0x40
 485:	c3                   	ret    

00000486 <sleep>:
SYSCALL(sleep)
 486:	b8 0d 00 00 00       	mov    $0xd,%eax
 48b:	cd 40                	int    $0x40
 48d:	c3                   	ret    

0000048e <uptime>:
SYSCALL(uptime)
 48e:	b8 0e 00 00 00       	mov    $0xe,%eax
 493:	cd 40                	int    $0x40
 495:	c3                   	ret    

00000496 <halt>:
SYSCALL(halt)
 496:	b8 16 00 00 00       	mov    $0x16,%eax
 49b:	cd 40                	int    $0x40
 49d:	c3                   	ret    

0000049e <date>:
SYSCALL(date)
 49e:	b8 17 00 00 00       	mov    $0x17,%eax
 4a3:	cd 40                	int    $0x40
 4a5:	c3                   	ret    

000004a6 <getuid>:
SYSCALL(getuid)
 4a6:	b8 18 00 00 00       	mov    $0x18,%eax
 4ab:	cd 40                	int    $0x40
 4ad:	c3                   	ret    

000004ae <getgid>:
SYSCALL(getgid)
 4ae:	b8 19 00 00 00       	mov    $0x19,%eax
 4b3:	cd 40                	int    $0x40
 4b5:	c3                   	ret    

000004b6 <getppid>:
SYSCALL(getppid)
 4b6:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4bb:	cd 40                	int    $0x40
 4bd:	c3                   	ret    

000004be <setuid>:
SYSCALL(setuid)
 4be:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4c3:	cd 40                	int    $0x40
 4c5:	c3                   	ret    

000004c6 <setgid>:
SYSCALL(setgid)
 4c6:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4cb:	cd 40                	int    $0x40
 4cd:	c3                   	ret    

000004ce <getprocs>:
SYSCALL(getprocs)
 4ce:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4d3:	cd 40                	int    $0x40
 4d5:	c3                   	ret    

000004d6 <setpriority>:
SYSCALL(setpriority)
 4d6:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4db:	cd 40                	int    $0x40
 4dd:	c3                   	ret    

000004de <chown>:
SYSCALL(chown)
 4de:	b8 1f 00 00 00       	mov    $0x1f,%eax
 4e3:	cd 40                	int    $0x40
 4e5:	c3                   	ret    

000004e6 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4e6:	f3 0f 1e fb          	endbr32 
 4ea:	55                   	push   %ebp
 4eb:	89 e5                	mov    %esp,%ebp
 4ed:	83 ec 18             	sub    $0x18,%esp
 4f0:	8b 45 0c             	mov    0xc(%ebp),%eax
 4f3:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4f6:	83 ec 04             	sub    $0x4,%esp
 4f9:	6a 01                	push   $0x1
 4fb:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4fe:	50                   	push   %eax
 4ff:	ff 75 08             	pushl  0x8(%ebp)
 502:	e8 0f ff ff ff       	call   416 <write>
 507:	83 c4 10             	add    $0x10,%esp
}
 50a:	90                   	nop
 50b:	c9                   	leave  
 50c:	c3                   	ret    

0000050d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 50d:	f3 0f 1e fb          	endbr32 
 511:	55                   	push   %ebp
 512:	89 e5                	mov    %esp,%ebp
 514:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 517:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 51e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 522:	74 17                	je     53b <printint+0x2e>
 524:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 528:	79 11                	jns    53b <printint+0x2e>
    neg = 1;
 52a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 531:	8b 45 0c             	mov    0xc(%ebp),%eax
 534:	f7 d8                	neg    %eax
 536:	89 45 ec             	mov    %eax,-0x14(%ebp)
 539:	eb 06                	jmp    541 <printint+0x34>
  } else {
    x = xx;
 53b:	8b 45 0c             	mov    0xc(%ebp),%eax
 53e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 541:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 548:	8b 4d 10             	mov    0x10(%ebp),%ecx
 54b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 54e:	ba 00 00 00 00       	mov    $0x0,%edx
 553:	f7 f1                	div    %ecx
 555:	89 d1                	mov    %edx,%ecx
 557:	8b 45 f4             	mov    -0xc(%ebp),%eax
 55a:	8d 50 01             	lea    0x1(%eax),%edx
 55d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 560:	0f b6 91 0c 13 00 00 	movzbl 0x130c(%ecx),%edx
 567:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 56b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 56e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 571:	ba 00 00 00 00       	mov    $0x0,%edx
 576:	f7 f1                	div    %ecx
 578:	89 45 ec             	mov    %eax,-0x14(%ebp)
 57b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 57f:	75 c7                	jne    548 <printint+0x3b>
  if(neg)
 581:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 585:	74 2d                	je     5b4 <printint+0xa7>
    buf[i++] = '-';
 587:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58a:	8d 50 01             	lea    0x1(%eax),%edx
 58d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 590:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 595:	eb 1d                	jmp    5b4 <printint+0xa7>
    putc(fd, buf[i]);
 597:	8d 55 dc             	lea    -0x24(%ebp),%edx
 59a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59d:	01 d0                	add    %edx,%eax
 59f:	0f b6 00             	movzbl (%eax),%eax
 5a2:	0f be c0             	movsbl %al,%eax
 5a5:	83 ec 08             	sub    $0x8,%esp
 5a8:	50                   	push   %eax
 5a9:	ff 75 08             	pushl  0x8(%ebp)
 5ac:	e8 35 ff ff ff       	call   4e6 <putc>
 5b1:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5b4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5bc:	79 d9                	jns    597 <printint+0x8a>
}
 5be:	90                   	nop
 5bf:	90                   	nop
 5c0:	c9                   	leave  
 5c1:	c3                   	ret    

000005c2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5c2:	f3 0f 1e fb          	endbr32 
 5c6:	55                   	push   %ebp
 5c7:	89 e5                	mov    %esp,%ebp
 5c9:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5cc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 5d3:	8d 45 0c             	lea    0xc(%ebp),%eax
 5d6:	83 c0 04             	add    $0x4,%eax
 5d9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5e3:	e9 59 01 00 00       	jmp    741 <printf+0x17f>
    c = fmt[i] & 0xff;
 5e8:	8b 55 0c             	mov    0xc(%ebp),%edx
 5eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ee:	01 d0                	add    %edx,%eax
 5f0:	0f b6 00             	movzbl (%eax),%eax
 5f3:	0f be c0             	movsbl %al,%eax
 5f6:	25 ff 00 00 00       	and    $0xff,%eax
 5fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5fe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 602:	75 2c                	jne    630 <printf+0x6e>
      if(c == '%'){
 604:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 608:	75 0c                	jne    616 <printf+0x54>
        state = '%';
 60a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 611:	e9 27 01 00 00       	jmp    73d <printf+0x17b>
      } else {
        putc(fd, c);
 616:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 619:	0f be c0             	movsbl %al,%eax
 61c:	83 ec 08             	sub    $0x8,%esp
 61f:	50                   	push   %eax
 620:	ff 75 08             	pushl  0x8(%ebp)
 623:	e8 be fe ff ff       	call   4e6 <putc>
 628:	83 c4 10             	add    $0x10,%esp
 62b:	e9 0d 01 00 00       	jmp    73d <printf+0x17b>
      }
    } else if(state == '%'){
 630:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 634:	0f 85 03 01 00 00    	jne    73d <printf+0x17b>
      if(c == 'd'){
 63a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 63e:	75 1e                	jne    65e <printf+0x9c>
        printint(fd, *ap, 10, 1);
 640:	8b 45 e8             	mov    -0x18(%ebp),%eax
 643:	8b 00                	mov    (%eax),%eax
 645:	6a 01                	push   $0x1
 647:	6a 0a                	push   $0xa
 649:	50                   	push   %eax
 64a:	ff 75 08             	pushl  0x8(%ebp)
 64d:	e8 bb fe ff ff       	call   50d <printint>
 652:	83 c4 10             	add    $0x10,%esp
        ap++;
 655:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 659:	e9 d8 00 00 00       	jmp    736 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 65e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 662:	74 06                	je     66a <printf+0xa8>
 664:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 668:	75 1e                	jne    688 <printf+0xc6>
        printint(fd, *ap, 16, 0);
 66a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 66d:	8b 00                	mov    (%eax),%eax
 66f:	6a 00                	push   $0x0
 671:	6a 10                	push   $0x10
 673:	50                   	push   %eax
 674:	ff 75 08             	pushl  0x8(%ebp)
 677:	e8 91 fe ff ff       	call   50d <printint>
 67c:	83 c4 10             	add    $0x10,%esp
        ap++;
 67f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 683:	e9 ae 00 00 00       	jmp    736 <printf+0x174>
      } else if(c == 's'){
 688:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 68c:	75 43                	jne    6d1 <printf+0x10f>
        s = (char*)*ap;
 68e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 691:	8b 00                	mov    (%eax),%eax
 693:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 696:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 69a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 69e:	75 25                	jne    6c5 <printf+0x103>
          s = "(null)";
 6a0:	c7 45 f4 dd 0e 00 00 	movl   $0xedd,-0xc(%ebp)
        while(*s != 0){
 6a7:	eb 1c                	jmp    6c5 <printf+0x103>
          putc(fd, *s);
 6a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ac:	0f b6 00             	movzbl (%eax),%eax
 6af:	0f be c0             	movsbl %al,%eax
 6b2:	83 ec 08             	sub    $0x8,%esp
 6b5:	50                   	push   %eax
 6b6:	ff 75 08             	pushl  0x8(%ebp)
 6b9:	e8 28 fe ff ff       	call   4e6 <putc>
 6be:	83 c4 10             	add    $0x10,%esp
          s++;
 6c1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c8:	0f b6 00             	movzbl (%eax),%eax
 6cb:	84 c0                	test   %al,%al
 6cd:	75 da                	jne    6a9 <printf+0xe7>
 6cf:	eb 65                	jmp    736 <printf+0x174>
        }
      } else if(c == 'c'){
 6d1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6d5:	75 1d                	jne    6f4 <printf+0x132>
        putc(fd, *ap);
 6d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6da:	8b 00                	mov    (%eax),%eax
 6dc:	0f be c0             	movsbl %al,%eax
 6df:	83 ec 08             	sub    $0x8,%esp
 6e2:	50                   	push   %eax
 6e3:	ff 75 08             	pushl  0x8(%ebp)
 6e6:	e8 fb fd ff ff       	call   4e6 <putc>
 6eb:	83 c4 10             	add    $0x10,%esp
        ap++;
 6ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6f2:	eb 42                	jmp    736 <printf+0x174>
      } else if(c == '%'){
 6f4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6f8:	75 17                	jne    711 <printf+0x14f>
        putc(fd, c);
 6fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6fd:	0f be c0             	movsbl %al,%eax
 700:	83 ec 08             	sub    $0x8,%esp
 703:	50                   	push   %eax
 704:	ff 75 08             	pushl  0x8(%ebp)
 707:	e8 da fd ff ff       	call   4e6 <putc>
 70c:	83 c4 10             	add    $0x10,%esp
 70f:	eb 25                	jmp    736 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 711:	83 ec 08             	sub    $0x8,%esp
 714:	6a 25                	push   $0x25
 716:	ff 75 08             	pushl  0x8(%ebp)
 719:	e8 c8 fd ff ff       	call   4e6 <putc>
 71e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 721:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 724:	0f be c0             	movsbl %al,%eax
 727:	83 ec 08             	sub    $0x8,%esp
 72a:	50                   	push   %eax
 72b:	ff 75 08             	pushl  0x8(%ebp)
 72e:	e8 b3 fd ff ff       	call   4e6 <putc>
 733:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 736:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 73d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 741:	8b 55 0c             	mov    0xc(%ebp),%edx
 744:	8b 45 f0             	mov    -0x10(%ebp),%eax
 747:	01 d0                	add    %edx,%eax
 749:	0f b6 00             	movzbl (%eax),%eax
 74c:	84 c0                	test   %al,%al
 74e:	0f 85 94 fe ff ff    	jne    5e8 <printf+0x26>
    }
  }
}
 754:	90                   	nop
 755:	90                   	nop
 756:	c9                   	leave  
 757:	c3                   	ret    

00000758 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 758:	f3 0f 1e fb          	endbr32 
 75c:	55                   	push   %ebp
 75d:	89 e5                	mov    %esp,%ebp
 75f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 762:	8b 45 08             	mov    0x8(%ebp),%eax
 765:	83 e8 08             	sub    $0x8,%eax
 768:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76b:	a1 28 13 00 00       	mov    0x1328,%eax
 770:	89 45 fc             	mov    %eax,-0x4(%ebp)
 773:	eb 24                	jmp    799 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 775:	8b 45 fc             	mov    -0x4(%ebp),%eax
 778:	8b 00                	mov    (%eax),%eax
 77a:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 77d:	72 12                	jb     791 <free+0x39>
 77f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 782:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 785:	77 24                	ja     7ab <free+0x53>
 787:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78a:	8b 00                	mov    (%eax),%eax
 78c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 78f:	72 1a                	jb     7ab <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 791:	8b 45 fc             	mov    -0x4(%ebp),%eax
 794:	8b 00                	mov    (%eax),%eax
 796:	89 45 fc             	mov    %eax,-0x4(%ebp)
 799:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 79f:	76 d4                	jbe    775 <free+0x1d>
 7a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a4:	8b 00                	mov    (%eax),%eax
 7a6:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7a9:	73 ca                	jae    775 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ae:	8b 40 04             	mov    0x4(%eax),%eax
 7b1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bb:	01 c2                	add    %eax,%edx
 7bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c0:	8b 00                	mov    (%eax),%eax
 7c2:	39 c2                	cmp    %eax,%edx
 7c4:	75 24                	jne    7ea <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 7c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c9:	8b 50 04             	mov    0x4(%eax),%edx
 7cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cf:	8b 00                	mov    (%eax),%eax
 7d1:	8b 40 04             	mov    0x4(%eax),%eax
 7d4:	01 c2                	add    %eax,%edx
 7d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7df:	8b 00                	mov    (%eax),%eax
 7e1:	8b 10                	mov    (%eax),%edx
 7e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e6:	89 10                	mov    %edx,(%eax)
 7e8:	eb 0a                	jmp    7f4 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 7ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ed:	8b 10                	mov    (%eax),%edx
 7ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f7:	8b 40 04             	mov    0x4(%eax),%eax
 7fa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 801:	8b 45 fc             	mov    -0x4(%ebp),%eax
 804:	01 d0                	add    %edx,%eax
 806:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 809:	75 20                	jne    82b <free+0xd3>
    p->s.size += bp->s.size;
 80b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80e:	8b 50 04             	mov    0x4(%eax),%edx
 811:	8b 45 f8             	mov    -0x8(%ebp),%eax
 814:	8b 40 04             	mov    0x4(%eax),%eax
 817:	01 c2                	add    %eax,%edx
 819:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 81f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 822:	8b 10                	mov    (%eax),%edx
 824:	8b 45 fc             	mov    -0x4(%ebp),%eax
 827:	89 10                	mov    %edx,(%eax)
 829:	eb 08                	jmp    833 <free+0xdb>
  } else
    p->s.ptr = bp;
 82b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 831:	89 10                	mov    %edx,(%eax)
  freep = p;
 833:	8b 45 fc             	mov    -0x4(%ebp),%eax
 836:	a3 28 13 00 00       	mov    %eax,0x1328
}
 83b:	90                   	nop
 83c:	c9                   	leave  
 83d:	c3                   	ret    

0000083e <morecore>:

static Header*
morecore(uint nu)
{
 83e:	f3 0f 1e fb          	endbr32 
 842:	55                   	push   %ebp
 843:	89 e5                	mov    %esp,%ebp
 845:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 848:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 84f:	77 07                	ja     858 <morecore+0x1a>
    nu = 4096;
 851:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 858:	8b 45 08             	mov    0x8(%ebp),%eax
 85b:	c1 e0 03             	shl    $0x3,%eax
 85e:	83 ec 0c             	sub    $0xc,%esp
 861:	50                   	push   %eax
 862:	e8 17 fc ff ff       	call   47e <sbrk>
 867:	83 c4 10             	add    $0x10,%esp
 86a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 86d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 871:	75 07                	jne    87a <morecore+0x3c>
    return 0;
 873:	b8 00 00 00 00       	mov    $0x0,%eax
 878:	eb 26                	jmp    8a0 <morecore+0x62>
  hp = (Header*)p;
 87a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 880:	8b 45 f0             	mov    -0x10(%ebp),%eax
 883:	8b 55 08             	mov    0x8(%ebp),%edx
 886:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 889:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88c:	83 c0 08             	add    $0x8,%eax
 88f:	83 ec 0c             	sub    $0xc,%esp
 892:	50                   	push   %eax
 893:	e8 c0 fe ff ff       	call   758 <free>
 898:	83 c4 10             	add    $0x10,%esp
  return freep;
 89b:	a1 28 13 00 00       	mov    0x1328,%eax
}
 8a0:	c9                   	leave  
 8a1:	c3                   	ret    

000008a2 <malloc>:

void*
malloc(uint nbytes)
{
 8a2:	f3 0f 1e fb          	endbr32 
 8a6:	55                   	push   %ebp
 8a7:	89 e5                	mov    %esp,%ebp
 8a9:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ac:	8b 45 08             	mov    0x8(%ebp),%eax
 8af:	83 c0 07             	add    $0x7,%eax
 8b2:	c1 e8 03             	shr    $0x3,%eax
 8b5:	83 c0 01             	add    $0x1,%eax
 8b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8bb:	a1 28 13 00 00       	mov    0x1328,%eax
 8c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8c7:	75 23                	jne    8ec <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 8c9:	c7 45 f0 20 13 00 00 	movl   $0x1320,-0x10(%ebp)
 8d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d3:	a3 28 13 00 00       	mov    %eax,0x1328
 8d8:	a1 28 13 00 00       	mov    0x1328,%eax
 8dd:	a3 20 13 00 00       	mov    %eax,0x1320
    base.s.size = 0;
 8e2:	c7 05 24 13 00 00 00 	movl   $0x0,0x1324
 8e9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ef:	8b 00                	mov    (%eax),%eax
 8f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f7:	8b 40 04             	mov    0x4(%eax),%eax
 8fa:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 8fd:	77 4d                	ja     94c <malloc+0xaa>
      if(p->s.size == nunits)
 8ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 902:	8b 40 04             	mov    0x4(%eax),%eax
 905:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 908:	75 0c                	jne    916 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 90a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90d:	8b 10                	mov    (%eax),%edx
 90f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 912:	89 10                	mov    %edx,(%eax)
 914:	eb 26                	jmp    93c <malloc+0x9a>
      else {
        p->s.size -= nunits;
 916:	8b 45 f4             	mov    -0xc(%ebp),%eax
 919:	8b 40 04             	mov    0x4(%eax),%eax
 91c:	2b 45 ec             	sub    -0x14(%ebp),%eax
 91f:	89 c2                	mov    %eax,%edx
 921:	8b 45 f4             	mov    -0xc(%ebp),%eax
 924:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 927:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92a:	8b 40 04             	mov    0x4(%eax),%eax
 92d:	c1 e0 03             	shl    $0x3,%eax
 930:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 933:	8b 45 f4             	mov    -0xc(%ebp),%eax
 936:	8b 55 ec             	mov    -0x14(%ebp),%edx
 939:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 93c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 93f:	a3 28 13 00 00       	mov    %eax,0x1328
      return (void*)(p + 1);
 944:	8b 45 f4             	mov    -0xc(%ebp),%eax
 947:	83 c0 08             	add    $0x8,%eax
 94a:	eb 3b                	jmp    987 <malloc+0xe5>
    }
    if(p == freep)
 94c:	a1 28 13 00 00       	mov    0x1328,%eax
 951:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 954:	75 1e                	jne    974 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 956:	83 ec 0c             	sub    $0xc,%esp
 959:	ff 75 ec             	pushl  -0x14(%ebp)
 95c:	e8 dd fe ff ff       	call   83e <morecore>
 961:	83 c4 10             	add    $0x10,%esp
 964:	89 45 f4             	mov    %eax,-0xc(%ebp)
 967:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 96b:	75 07                	jne    974 <malloc+0xd2>
        return 0;
 96d:	b8 00 00 00 00       	mov    $0x0,%eax
 972:	eb 13                	jmp    987 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 974:	8b 45 f4             	mov    -0xc(%ebp),%eax
 977:	89 45 f0             	mov    %eax,-0x10(%ebp)
 97a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97d:	8b 00                	mov    (%eax),%eax
 97f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 982:	e9 6d ff ff ff       	jmp    8f4 <malloc+0x52>
  }
}
 987:	c9                   	leave  
 988:	c3                   	ret    

00000989 <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
 989:	f3 0f 1e fb          	endbr32 
 98d:	55                   	push   %ebp
 98e:	89 e5                	mov    %esp,%ebp
 990:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 993:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 99a:	a1 80 13 00 00       	mov    0x1380,%eax
 99f:	83 ec 04             	sub    $0x4,%esp
 9a2:	50                   	push   %eax
 9a3:	6a 20                	push   $0x20
 9a5:	68 60 13 00 00       	push   $0x1360
 9aa:	e8 11 f8 ff ff       	call   1c0 <fgets>
 9af:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 9b2:	83 ec 0c             	sub    $0xc,%esp
 9b5:	68 60 13 00 00       	push   $0x1360
 9ba:	e8 0e f7 ff ff       	call   cd <strlen>
 9bf:	83 c4 10             	add    $0x10,%esp
 9c2:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 9c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9c8:	83 e8 01             	sub    $0x1,%eax
 9cb:	0f b6 80 60 13 00 00 	movzbl 0x1360(%eax),%eax
 9d2:	3c 0a                	cmp    $0xa,%al
 9d4:	74 11                	je     9e7 <get_id+0x5e>
 9d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9d9:	83 e8 01             	sub    $0x1,%eax
 9dc:	0f b6 80 60 13 00 00 	movzbl 0x1360(%eax),%eax
 9e3:	3c 0d                	cmp    $0xd,%al
 9e5:	75 0d                	jne    9f4 <get_id+0x6b>
        current_line[len - 1] = 0;
 9e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9ea:	83 e8 01             	sub    $0x1,%eax
 9ed:	c6 80 60 13 00 00 00 	movb   $0x0,0x1360(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 9f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 9fb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 a02:	eb 6c                	jmp    a70 <get_id+0xe7>
        if(current_line[i] == ' '){
 a04:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a07:	05 60 13 00 00       	add    $0x1360,%eax
 a0c:	0f b6 00             	movzbl (%eax),%eax
 a0f:	3c 20                	cmp    $0x20,%al
 a11:	75 30                	jne    a43 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 a13:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a17:	75 16                	jne    a2f <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 a19:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a1f:	8d 50 01             	lea    0x1(%eax),%edx
 a22:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a25:	8d 91 60 13 00 00    	lea    0x1360(%ecx),%edx
 a2b:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 a2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a32:	05 60 13 00 00       	add    $0x1360,%eax
 a37:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 a3a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 a41:	eb 29                	jmp    a6c <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 a43:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a47:	75 23                	jne    a6c <get_id+0xe3>
 a49:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 a4d:	7f 1d                	jg     a6c <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 a4f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 a56:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a59:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a5c:	8d 50 01             	lea    0x1(%eax),%edx
 a5f:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a62:	8d 91 60 13 00 00    	lea    0x1360(%ecx),%edx
 a68:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 a6c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 a70:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a73:	05 60 13 00 00       	add    $0x1360,%eax
 a78:	0f b6 00             	movzbl (%eax),%eax
 a7b:	84 c0                	test   %al,%al
 a7d:	75 85                	jne    a04 <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 a7f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 a83:	75 07                	jne    a8c <get_id+0x103>
        return -1;
 a85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a8a:	eb 35                	jmp    ac1 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
 a8c:	8b 45 dc             	mov    -0x24(%ebp),%eax
 a8f:	a3 40 13 00 00       	mov    %eax,0x1340
    current_id.uid_user = atoi(tokens[1]);
 a94:	8b 45 e0             	mov    -0x20(%ebp),%eax
 a97:	83 ec 0c             	sub    $0xc,%esp
 a9a:	50                   	push   %eax
 a9b:	e8 e5 f7 ff ff       	call   285 <atoi>
 aa0:	83 c4 10             	add    $0x10,%esp
 aa3:	a3 44 13 00 00       	mov    %eax,0x1344
    current_id.gid_user = atoi(tokens[2]);
 aa8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 aab:	83 ec 0c             	sub    $0xc,%esp
 aae:	50                   	push   %eax
 aaf:	e8 d1 f7 ff ff       	call   285 <atoi>
 ab4:	83 c4 10             	add    $0x10,%esp
 ab7:	a3 48 13 00 00       	mov    %eax,0x1348

    return 0;
 abc:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ac1:	c9                   	leave  
 ac2:	c3                   	ret    

00000ac3 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
 ac3:	f3 0f 1e fb          	endbr32 
 ac7:	55                   	push   %ebp
 ac8:	89 e5                	mov    %esp,%ebp
 aca:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 acd:	a1 80 13 00 00       	mov    0x1380,%eax
 ad2:	85 c0                	test   %eax,%eax
 ad4:	75 31                	jne    b07 <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
 ad6:	83 ec 08             	sub    $0x8,%esp
 ad9:	6a 00                	push   $0x0
 adb:	68 e4 0e 00 00       	push   $0xee4
 ae0:	e8 51 f9 ff ff       	call   436 <open>
 ae5:	83 c4 10             	add    $0x10,%esp
 ae8:	a3 80 13 00 00       	mov    %eax,0x1380

        if(dir < 0){        // kalau gagal membuka file
 aed:	a1 80 13 00 00       	mov    0x1380,%eax
 af2:	85 c0                	test   %eax,%eax
 af4:	79 11                	jns    b07 <getid+0x44>
            dir = 0;
 af6:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 afd:	00 00 00 
            return 0;
 b00:	b8 00 00 00 00       	mov    $0x0,%eax
 b05:	eb 16                	jmp    b1d <getid+0x5a>
        }
    }

    if(get_id() == -1) 
 b07:	e8 7d fe ff ff       	call   989 <get_id>
 b0c:	83 f8 ff             	cmp    $0xffffffff,%eax
 b0f:	75 07                	jne    b18 <getid+0x55>
        return 0;
 b11:	b8 00 00 00 00       	mov    $0x0,%eax
 b16:	eb 05                	jmp    b1d <getid+0x5a>
    
    return &current_id;
 b18:	b8 40 13 00 00       	mov    $0x1340,%eax
}
 b1d:	c9                   	leave  
 b1e:	c3                   	ret    

00000b1f <setid>:

// open file_ids
void setid(void){
 b1f:	f3 0f 1e fb          	endbr32 
 b23:	55                   	push   %ebp
 b24:	89 e5                	mov    %esp,%ebp
 b26:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b29:	a1 80 13 00 00       	mov    0x1380,%eax
 b2e:	85 c0                	test   %eax,%eax
 b30:	74 1b                	je     b4d <setid+0x2e>
        close(dir);
 b32:	a1 80 13 00 00       	mov    0x1380,%eax
 b37:	83 ec 0c             	sub    $0xc,%esp
 b3a:	50                   	push   %eax
 b3b:	e8 de f8 ff ff       	call   41e <close>
 b40:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 b43:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 b4a:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
 b4d:	83 ec 08             	sub    $0x8,%esp
 b50:	6a 00                	push   $0x0
 b52:	68 e4 0e 00 00       	push   $0xee4
 b57:	e8 da f8 ff ff       	call   436 <open>
 b5c:	83 c4 10             	add    $0x10,%esp
 b5f:	a3 80 13 00 00       	mov    %eax,0x1380

    if (dir < 0)
 b64:	a1 80 13 00 00       	mov    0x1380,%eax
 b69:	85 c0                	test   %eax,%eax
 b6b:	79 0a                	jns    b77 <setid+0x58>
        dir = 0;
 b6d:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 b74:	00 00 00 
}
 b77:	90                   	nop
 b78:	c9                   	leave  
 b79:	c3                   	ret    

00000b7a <endid>:

// tutup file_ids
void endid (void){
 b7a:	f3 0f 1e fb          	endbr32 
 b7e:	55                   	push   %ebp
 b7f:	89 e5                	mov    %esp,%ebp
 b81:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b84:	a1 80 13 00 00       	mov    0x1380,%eax
 b89:	85 c0                	test   %eax,%eax
 b8b:	74 1b                	je     ba8 <endid+0x2e>
        close(dir);
 b8d:	a1 80 13 00 00       	mov    0x1380,%eax
 b92:	83 ec 0c             	sub    $0xc,%esp
 b95:	50                   	push   %eax
 b96:	e8 83 f8 ff ff       	call   41e <close>
 b9b:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 b9e:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 ba5:	00 00 00 
    }
}
 ba8:	90                   	nop
 ba9:	c9                   	leave  
 baa:	c3                   	ret    

00000bab <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
 bab:	f3 0f 1e fb          	endbr32 
 baf:	55                   	push   %ebp
 bb0:	89 e5                	mov    %esp,%ebp
 bb2:	83 ec 08             	sub    $0x8,%esp
    setid();
 bb5:	e8 65 ff ff ff       	call   b1f <setid>

    while (getid()){
 bba:	eb 24                	jmp    be0 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
 bbc:	a1 40 13 00 00       	mov    0x1340,%eax
 bc1:	83 ec 08             	sub    $0x8,%esp
 bc4:	50                   	push   %eax
 bc5:	ff 75 08             	pushl  0x8(%ebp)
 bc8:	e8 bd f4 ff ff       	call   8a <strcmp>
 bcd:	83 c4 10             	add    $0x10,%esp
 bd0:	85 c0                	test   %eax,%eax
 bd2:	75 0c                	jne    be0 <cek_nama+0x35>
            endid();
 bd4:	e8 a1 ff ff ff       	call   b7a <endid>
            return &current_id;
 bd9:	b8 40 13 00 00       	mov    $0x1340,%eax
 bde:	eb 13                	jmp    bf3 <cek_nama+0x48>
    while (getid()){
 be0:	e8 de fe ff ff       	call   ac3 <getid>
 be5:	85 c0                	test   %eax,%eax
 be7:	75 d3                	jne    bbc <cek_nama+0x11>
        }
    }
    endid();
 be9:	e8 8c ff ff ff       	call   b7a <endid>
    return 0;
 bee:	b8 00 00 00 00       	mov    $0x0,%eax
}
 bf3:	c9                   	leave  
 bf4:	c3                   	ret    

00000bf5 <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
 bf5:	f3 0f 1e fb          	endbr32 
 bf9:	55                   	push   %ebp
 bfa:	89 e5                	mov    %esp,%ebp
 bfc:	83 ec 08             	sub    $0x8,%esp
    setid();
 bff:	e8 1b ff ff ff       	call   b1f <setid>

    while (getid()){
 c04:	eb 16                	jmp    c1c <cek_uid+0x27>
        if(current_id.uid_user == uid){
 c06:	a1 44 13 00 00       	mov    0x1344,%eax
 c0b:	39 45 08             	cmp    %eax,0x8(%ebp)
 c0e:	75 0c                	jne    c1c <cek_uid+0x27>
            endid();
 c10:	e8 65 ff ff ff       	call   b7a <endid>
            return &current_id;
 c15:	b8 40 13 00 00       	mov    $0x1340,%eax
 c1a:	eb 13                	jmp    c2f <cek_uid+0x3a>
    while (getid()){
 c1c:	e8 a2 fe ff ff       	call   ac3 <getid>
 c21:	85 c0                	test   %eax,%eax
 c23:	75 e1                	jne    c06 <cek_uid+0x11>
        }
    }
    endid();
 c25:	e8 50 ff ff ff       	call   b7a <endid>
    return 0;
 c2a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c2f:	c9                   	leave  
 c30:	c3                   	ret    

00000c31 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
 c31:	f3 0f 1e fb          	endbr32 
 c35:	55                   	push   %ebp
 c36:	89 e5                	mov    %esp,%ebp
 c38:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 c3b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 c42:	a1 80 13 00 00       	mov    0x1380,%eax
 c47:	83 ec 04             	sub    $0x4,%esp
 c4a:	50                   	push   %eax
 c4b:	6a 20                	push   $0x20
 c4d:	68 60 13 00 00       	push   $0x1360
 c52:	e8 69 f5 ff ff       	call   1c0 <fgets>
 c57:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 c5a:	83 ec 0c             	sub    $0xc,%esp
 c5d:	68 60 13 00 00       	push   $0x1360
 c62:	e8 66 f4 ff ff       	call   cd <strlen>
 c67:	83 c4 10             	add    $0x10,%esp
 c6a:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 c6d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c70:	83 e8 01             	sub    $0x1,%eax
 c73:	0f b6 80 60 13 00 00 	movzbl 0x1360(%eax),%eax
 c7a:	3c 0a                	cmp    $0xa,%al
 c7c:	74 11                	je     c8f <get_group+0x5e>
 c7e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c81:	83 e8 01             	sub    $0x1,%eax
 c84:	0f b6 80 60 13 00 00 	movzbl 0x1360(%eax),%eax
 c8b:	3c 0d                	cmp    $0xd,%al
 c8d:	75 0d                	jne    c9c <get_group+0x6b>
        current_line[len - 1] = 0;
 c8f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 c92:	83 e8 01             	sub    $0x1,%eax
 c95:	c6 80 60 13 00 00 00 	movb   $0x0,0x1360(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 c9c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 ca3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 caa:	eb 6c                	jmp    d18 <get_group+0xe7>
        if(current_line[i] == ' '){
 cac:	8b 45 ec             	mov    -0x14(%ebp),%eax
 caf:	05 60 13 00 00       	add    $0x1360,%eax
 cb4:	0f b6 00             	movzbl (%eax),%eax
 cb7:	3c 20                	cmp    $0x20,%al
 cb9:	75 30                	jne    ceb <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 cbb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 cbf:	75 16                	jne    cd7 <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 cc1:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 cc4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 cc7:	8d 50 01             	lea    0x1(%eax),%edx
 cca:	89 55 f0             	mov    %edx,-0x10(%ebp)
 ccd:	8d 91 60 13 00 00    	lea    0x1360(%ecx),%edx
 cd3:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 cd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 cda:	05 60 13 00 00       	add    $0x1360,%eax
 cdf:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 ce2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 ce9:	eb 29                	jmp    d14 <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 ceb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 cef:	75 23                	jne    d14 <get_group+0xe3>
 cf1:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 cf5:	7f 1d                	jg     d14 <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 cf7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 cfe:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d01:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d04:	8d 50 01             	lea    0x1(%eax),%edx
 d07:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d0a:	8d 91 60 13 00 00    	lea    0x1360(%ecx),%edx
 d10:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 d14:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 d18:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d1b:	05 60 13 00 00       	add    $0x1360,%eax
 d20:	0f b6 00             	movzbl (%eax),%eax
 d23:	84 c0                	test   %al,%al
 d25:	75 85                	jne    cac <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 d27:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 d2b:	75 07                	jne    d34 <get_group+0x103>
        return -1;
 d2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d32:	eb 21                	jmp    d55 <get_group+0x124>
    
    current_group.nama_group = tokens[0];
 d34:	8b 45 dc             	mov    -0x24(%ebp),%eax
 d37:	a3 4c 13 00 00       	mov    %eax,0x134c
    current_group.gid = atoi(tokens[1]);
 d3c:	8b 45 e0             	mov    -0x20(%ebp),%eax
 d3f:	83 ec 0c             	sub    $0xc,%esp
 d42:	50                   	push   %eax
 d43:	e8 3d f5 ff ff       	call   285 <atoi>
 d48:	83 c4 10             	add    $0x10,%esp
 d4b:	a3 50 13 00 00       	mov    %eax,0x1350

    return 0;
 d50:	b8 00 00 00 00       	mov    $0x0,%eax
}
 d55:	c9                   	leave  
 d56:	c3                   	ret    

00000d57 <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
 d57:	f3 0f 1e fb          	endbr32 
 d5b:	55                   	push   %ebp
 d5c:	89 e5                	mov    %esp,%ebp
 d5e:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 d61:	a1 80 13 00 00       	mov    0x1380,%eax
 d66:	85 c0                	test   %eax,%eax
 d68:	75 31                	jne    d9b <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
 d6a:	83 ec 08             	sub    $0x8,%esp
 d6d:	6a 00                	push   $0x0
 d6f:	68 ec 0e 00 00       	push   $0xeec
 d74:	e8 bd f6 ff ff       	call   436 <open>
 d79:	83 c4 10             	add    $0x10,%esp
 d7c:	a3 80 13 00 00       	mov    %eax,0x1380

        if(dir < 0){        // kalau gagal membuka file
 d81:	a1 80 13 00 00       	mov    0x1380,%eax
 d86:	85 c0                	test   %eax,%eax
 d88:	79 11                	jns    d9b <getgroup+0x44>
            dir = 0;
 d8a:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 d91:	00 00 00 
            return 0;
 d94:	b8 00 00 00 00       	mov    $0x0,%eax
 d99:	eb 16                	jmp    db1 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
 d9b:	e8 91 fe ff ff       	call   c31 <get_group>
 da0:	83 f8 ff             	cmp    $0xffffffff,%eax
 da3:	75 07                	jne    dac <getgroup+0x55>
        return 0;
 da5:	b8 00 00 00 00       	mov    $0x0,%eax
 daa:	eb 05                	jmp    db1 <getgroup+0x5a>
    
    return &current_group;
 dac:	b8 4c 13 00 00       	mov    $0x134c,%eax
}
 db1:	c9                   	leave  
 db2:	c3                   	ret    

00000db3 <setgroup>:

// open file_ids
void setgroup(void){
 db3:	f3 0f 1e fb          	endbr32 
 db7:	55                   	push   %ebp
 db8:	89 e5                	mov    %esp,%ebp
 dba:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 dbd:	a1 80 13 00 00       	mov    0x1380,%eax
 dc2:	85 c0                	test   %eax,%eax
 dc4:	74 1b                	je     de1 <setgroup+0x2e>
        close(dir);
 dc6:	a1 80 13 00 00       	mov    0x1380,%eax
 dcb:	83 ec 0c             	sub    $0xc,%esp
 dce:	50                   	push   %eax
 dcf:	e8 4a f6 ff ff       	call   41e <close>
 dd4:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 dd7:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 dde:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
 de1:	83 ec 08             	sub    $0x8,%esp
 de4:	6a 00                	push   $0x0
 de6:	68 ec 0e 00 00       	push   $0xeec
 deb:	e8 46 f6 ff ff       	call   436 <open>
 df0:	83 c4 10             	add    $0x10,%esp
 df3:	a3 80 13 00 00       	mov    %eax,0x1380

    if (dir < 0)
 df8:	a1 80 13 00 00       	mov    0x1380,%eax
 dfd:	85 c0                	test   %eax,%eax
 dff:	79 0a                	jns    e0b <setgroup+0x58>
        dir = 0;
 e01:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 e08:	00 00 00 
}
 e0b:	90                   	nop
 e0c:	c9                   	leave  
 e0d:	c3                   	ret    

00000e0e <endgroup>:

// tutup file_ids
void endgroup (void){
 e0e:	f3 0f 1e fb          	endbr32 
 e12:	55                   	push   %ebp
 e13:	89 e5                	mov    %esp,%ebp
 e15:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e18:	a1 80 13 00 00       	mov    0x1380,%eax
 e1d:	85 c0                	test   %eax,%eax
 e1f:	74 1b                	je     e3c <endgroup+0x2e>
        close(dir);
 e21:	a1 80 13 00 00       	mov    0x1380,%eax
 e26:	83 ec 0c             	sub    $0xc,%esp
 e29:	50                   	push   %eax
 e2a:	e8 ef f5 ff ff       	call   41e <close>
 e2f:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e32:	c7 05 80 13 00 00 00 	movl   $0x0,0x1380
 e39:	00 00 00 
    }
}
 e3c:	90                   	nop
 e3d:	c9                   	leave  
 e3e:	c3                   	ret    

00000e3f <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
 e3f:	f3 0f 1e fb          	endbr32 
 e43:	55                   	push   %ebp
 e44:	89 e5                	mov    %esp,%ebp
 e46:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 e49:	e8 65 ff ff ff       	call   db3 <setgroup>

    while (getgroup()){
 e4e:	eb 3c                	jmp    e8c <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
 e50:	a1 4c 13 00 00       	mov    0x134c,%eax
 e55:	83 ec 08             	sub    $0x8,%esp
 e58:	50                   	push   %eax
 e59:	ff 75 08             	pushl  0x8(%ebp)
 e5c:	e8 29 f2 ff ff       	call   8a <strcmp>
 e61:	83 c4 10             	add    $0x10,%esp
 e64:	85 c0                	test   %eax,%eax
 e66:	75 24                	jne    e8c <cek_nama_group+0x4d>
            endgroup();
 e68:	e8 a1 ff ff ff       	call   e0e <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
 e6d:	a1 4c 13 00 00       	mov    0x134c,%eax
 e72:	83 ec 04             	sub    $0x4,%esp
 e75:	50                   	push   %eax
 e76:	68 f7 0e 00 00       	push   $0xef7
 e7b:	6a 01                	push   $0x1
 e7d:	e8 40 f7 ff ff       	call   5c2 <printf>
 e82:	83 c4 10             	add    $0x10,%esp
            return &current_group;
 e85:	b8 4c 13 00 00       	mov    $0x134c,%eax
 e8a:	eb 13                	jmp    e9f <cek_nama_group+0x60>
    while (getgroup()){
 e8c:	e8 c6 fe ff ff       	call   d57 <getgroup>
 e91:	85 c0                	test   %eax,%eax
 e93:	75 bb                	jne    e50 <cek_nama_group+0x11>
        }
    }
    endgroup();
 e95:	e8 74 ff ff ff       	call   e0e <endgroup>
    return 0;
 e9a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 e9f:	c9                   	leave  
 ea0:	c3                   	ret    

00000ea1 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
 ea1:	f3 0f 1e fb          	endbr32 
 ea5:	55                   	push   %ebp
 ea6:	89 e5                	mov    %esp,%ebp
 ea8:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 eab:	e8 03 ff ff ff       	call   db3 <setgroup>

    while (getgroup()){
 eb0:	eb 16                	jmp    ec8 <cek_gid+0x27>
        if(current_group.gid == gid){
 eb2:	a1 50 13 00 00       	mov    0x1350,%eax
 eb7:	39 45 08             	cmp    %eax,0x8(%ebp)
 eba:	75 0c                	jne    ec8 <cek_gid+0x27>
            endgroup();
 ebc:	e8 4d ff ff ff       	call   e0e <endgroup>
            return &current_group;
 ec1:	b8 4c 13 00 00       	mov    $0x134c,%eax
 ec6:	eb 13                	jmp    edb <cek_gid+0x3a>
    while (getgroup()){
 ec8:	e8 8a fe ff ff       	call   d57 <getgroup>
 ecd:	85 c0                	test   %eax,%eax
 ecf:	75 e1                	jne    eb2 <cek_gid+0x11>
        }
    }
    endgroup();
 ed1:	e8 38 ff ff ff       	call   e0e <endgroup>
    return 0;
 ed6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 edb:	c9                   	leave  
 edc:	c3                   	ret    
