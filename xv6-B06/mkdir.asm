
_mkdir:     file format elf32-i386


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

  if(argc < 2){
  18:	83 3b 01             	cmpl   $0x1,(%ebx)
  1b:	7f 17                	jg     34 <main+0x34>
    printf(2, "Usage: mkdir files...\n");
  1d:	83 ec 08             	sub    $0x8,%esp
  20:	68 41 0f 00 00       	push   $0xf41
  25:	6a 02                	push   $0x2
  27:	e8 fa 05 00 00       	call   626 <printf>
  2c:	83 c4 10             	add    $0x10,%esp
    exit();
  2f:	e8 26 04 00 00       	call   45a <exit>
  }

  for(i = 1; i < argc; i++){
  34:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  3b:	eb 4b                	jmp    88 <main+0x88>
    if(mkdir(argv[i]) < 0){
  3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  40:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  47:	8b 43 04             	mov    0x4(%ebx),%eax
  4a:	01 d0                	add    %edx,%eax
  4c:	8b 00                	mov    (%eax),%eax
  4e:	83 ec 0c             	sub    $0xc,%esp
  51:	50                   	push   %eax
  52:	e8 6b 04 00 00       	call   4c2 <mkdir>
  57:	83 c4 10             	add    $0x10,%esp
  5a:	85 c0                	test   %eax,%eax
  5c:	79 26                	jns    84 <main+0x84>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  61:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  68:	8b 43 04             	mov    0x4(%ebx),%eax
  6b:	01 d0                	add    %edx,%eax
  6d:	8b 00                	mov    (%eax),%eax
  6f:	83 ec 04             	sub    $0x4,%esp
  72:	50                   	push   %eax
  73:	68 58 0f 00 00       	push   $0xf58
  78:	6a 02                	push   $0x2
  7a:	e8 a7 05 00 00       	call   626 <printf>
  7f:	83 c4 10             	add    $0x10,%esp
      break;
  82:	eb 0b                	jmp    8f <main+0x8f>
  for(i = 1; i < argc; i++){
  84:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  88:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8b:	3b 03                	cmp    (%ebx),%eax
  8d:	7c ae                	jl     3d <main+0x3d>
    }
  }

  exit();
  8f:	e8 c6 03 00 00       	call   45a <exit>

00000094 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  94:	55                   	push   %ebp
  95:	89 e5                	mov    %esp,%ebp
  97:	57                   	push   %edi
  98:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  99:	8b 4d 08             	mov    0x8(%ebp),%ecx
  9c:	8b 55 10             	mov    0x10(%ebp),%edx
  9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  a2:	89 cb                	mov    %ecx,%ebx
  a4:	89 df                	mov    %ebx,%edi
  a6:	89 d1                	mov    %edx,%ecx
  a8:	fc                   	cld    
  a9:	f3 aa                	rep stos %al,%es:(%edi)
  ab:	89 ca                	mov    %ecx,%edx
  ad:	89 fb                	mov    %edi,%ebx
  af:	89 5d 08             	mov    %ebx,0x8(%ebp)
  b2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b5:	90                   	nop
  b6:	5b                   	pop    %ebx
  b7:	5f                   	pop    %edi
  b8:	5d                   	pop    %ebp
  b9:	c3                   	ret    

000000ba <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  ba:	f3 0f 1e fb          	endbr32 
  be:	55                   	push   %ebp
  bf:	89 e5                	mov    %esp,%ebp
  c1:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  c4:	8b 45 08             	mov    0x8(%ebp),%eax
  c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  ca:	90                   	nop
  cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  ce:	8d 42 01             	lea    0x1(%edx),%eax
  d1:	89 45 0c             	mov    %eax,0xc(%ebp)
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	8d 48 01             	lea    0x1(%eax),%ecx
  da:	89 4d 08             	mov    %ecx,0x8(%ebp)
  dd:	0f b6 12             	movzbl (%edx),%edx
  e0:	88 10                	mov    %dl,(%eax)
  e2:	0f b6 00             	movzbl (%eax),%eax
  e5:	84 c0                	test   %al,%al
  e7:	75 e2                	jne    cb <strcpy+0x11>
    ;
  return os;
  e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ec:	c9                   	leave  
  ed:	c3                   	ret    

000000ee <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ee:	f3 0f 1e fb          	endbr32 
  f2:	55                   	push   %ebp
  f3:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  f5:	eb 08                	jmp    ff <strcmp+0x11>
    p++, q++;
  f7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  fb:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  ff:	8b 45 08             	mov    0x8(%ebp),%eax
 102:	0f b6 00             	movzbl (%eax),%eax
 105:	84 c0                	test   %al,%al
 107:	74 10                	je     119 <strcmp+0x2b>
 109:	8b 45 08             	mov    0x8(%ebp),%eax
 10c:	0f b6 10             	movzbl (%eax),%edx
 10f:	8b 45 0c             	mov    0xc(%ebp),%eax
 112:	0f b6 00             	movzbl (%eax),%eax
 115:	38 c2                	cmp    %al,%dl
 117:	74 de                	je     f7 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
 119:	8b 45 08             	mov    0x8(%ebp),%eax
 11c:	0f b6 00             	movzbl (%eax),%eax
 11f:	0f b6 d0             	movzbl %al,%edx
 122:	8b 45 0c             	mov    0xc(%ebp),%eax
 125:	0f b6 00             	movzbl (%eax),%eax
 128:	0f b6 c0             	movzbl %al,%eax
 12b:	29 c2                	sub    %eax,%edx
 12d:	89 d0                	mov    %edx,%eax
}
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret    

00000131 <strlen>:

uint
strlen(char *s)
{
 131:	f3 0f 1e fb          	endbr32 
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 13b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 142:	eb 04                	jmp    148 <strlen+0x17>
 144:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 148:	8b 55 fc             	mov    -0x4(%ebp),%edx
 14b:	8b 45 08             	mov    0x8(%ebp),%eax
 14e:	01 d0                	add    %edx,%eax
 150:	0f b6 00             	movzbl (%eax),%eax
 153:	84 c0                	test   %al,%al
 155:	75 ed                	jne    144 <strlen+0x13>
    ;
  return n;
 157:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 15a:	c9                   	leave  
 15b:	c3                   	ret    

0000015c <memset>:

void*
memset(void *dst, int c, uint n)
{
 15c:	f3 0f 1e fb          	endbr32 
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 163:	8b 45 10             	mov    0x10(%ebp),%eax
 166:	50                   	push   %eax
 167:	ff 75 0c             	pushl  0xc(%ebp)
 16a:	ff 75 08             	pushl  0x8(%ebp)
 16d:	e8 22 ff ff ff       	call   94 <stosb>
 172:	83 c4 0c             	add    $0xc,%esp
  return dst;
 175:	8b 45 08             	mov    0x8(%ebp),%eax
}
 178:	c9                   	leave  
 179:	c3                   	ret    

0000017a <strchr>:

char*
strchr(const char *s, char c)
{
 17a:	f3 0f 1e fb          	endbr32 
 17e:	55                   	push   %ebp
 17f:	89 e5                	mov    %esp,%ebp
 181:	83 ec 04             	sub    $0x4,%esp
 184:	8b 45 0c             	mov    0xc(%ebp),%eax
 187:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 18a:	eb 14                	jmp    1a0 <strchr+0x26>
    if(*s == c)
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	0f b6 00             	movzbl (%eax),%eax
 192:	38 45 fc             	cmp    %al,-0x4(%ebp)
 195:	75 05                	jne    19c <strchr+0x22>
      return (char*)s;
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	eb 13                	jmp    1af <strchr+0x35>
  for(; *s; s++)
 19c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1a0:	8b 45 08             	mov    0x8(%ebp),%eax
 1a3:	0f b6 00             	movzbl (%eax),%eax
 1a6:	84 c0                	test   %al,%al
 1a8:	75 e2                	jne    18c <strchr+0x12>
  return 0;
 1aa:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1af:	c9                   	leave  
 1b0:	c3                   	ret    

000001b1 <gets>:

char*
gets(char *buf, int max)
{
 1b1:	f3 0f 1e fb          	endbr32 
 1b5:	55                   	push   %ebp
 1b6:	89 e5                	mov    %esp,%ebp
 1b8:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1c2:	eb 42                	jmp    206 <gets+0x55>
    cc = read(0, &c, 1);
 1c4:	83 ec 04             	sub    $0x4,%esp
 1c7:	6a 01                	push   $0x1
 1c9:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1cc:	50                   	push   %eax
 1cd:	6a 00                	push   $0x0
 1cf:	e8 9e 02 00 00       	call   472 <read>
 1d4:	83 c4 10             	add    $0x10,%esp
 1d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1da:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1de:	7e 33                	jle    213 <gets+0x62>
      break;
    buf[i++] = c;
 1e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e3:	8d 50 01             	lea    0x1(%eax),%edx
 1e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1e9:	89 c2                	mov    %eax,%edx
 1eb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ee:	01 c2                	add    %eax,%edx
 1f0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1f6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1fa:	3c 0a                	cmp    $0xa,%al
 1fc:	74 16                	je     214 <gets+0x63>
 1fe:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 202:	3c 0d                	cmp    $0xd,%al
 204:	74 0e                	je     214 <gets+0x63>
  for(i=0; i+1 < max; ){
 206:	8b 45 f4             	mov    -0xc(%ebp),%eax
 209:	83 c0 01             	add    $0x1,%eax
 20c:	39 45 0c             	cmp    %eax,0xc(%ebp)
 20f:	7f b3                	jg     1c4 <gets+0x13>
 211:	eb 01                	jmp    214 <gets+0x63>
      break;
 213:	90                   	nop
      break;
  }
  buf[i] = '\0';
 214:	8b 55 f4             	mov    -0xc(%ebp),%edx
 217:	8b 45 08             	mov    0x8(%ebp),%eax
 21a:	01 d0                	add    %edx,%eax
 21c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 21f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 222:	c9                   	leave  
 223:	c3                   	ret    

00000224 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
 224:	f3 0f 1e fb          	endbr32 
 228:	55                   	push   %ebp
 229:	89 e5                	mov    %esp,%ebp
 22b:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
 22e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 235:	eb 43                	jmp    27a <fgets+0x56>
    int cc = read(fd, &c, 1);
 237:	83 ec 04             	sub    $0x4,%esp
 23a:	6a 01                	push   $0x1
 23c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 23f:	50                   	push   %eax
 240:	ff 75 10             	pushl  0x10(%ebp)
 243:	e8 2a 02 00 00       	call   472 <read>
 248:	83 c4 10             	add    $0x10,%esp
 24b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 24e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 252:	7e 33                	jle    287 <fgets+0x63>
      break;
    buf[i++] = c;
 254:	8b 45 f4             	mov    -0xc(%ebp),%eax
 257:	8d 50 01             	lea    0x1(%eax),%edx
 25a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 25d:	89 c2                	mov    %eax,%edx
 25f:	8b 45 08             	mov    0x8(%ebp),%eax
 262:	01 c2                	add    %eax,%edx
 264:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 268:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 26a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26e:	3c 0a                	cmp    $0xa,%al
 270:	74 16                	je     288 <fgets+0x64>
 272:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 276:	3c 0d                	cmp    $0xd,%al
 278:	74 0e                	je     288 <fgets+0x64>
  for(i = 0; i + 1 < size;){
 27a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27d:	83 c0 01             	add    $0x1,%eax
 280:	39 45 0c             	cmp    %eax,0xc(%ebp)
 283:	7f b2                	jg     237 <fgets+0x13>
 285:	eb 01                	jmp    288 <fgets+0x64>
      break;
 287:	90                   	nop
      break;
  }
  buf[i] = '\0';
 288:	8b 55 f4             	mov    -0xc(%ebp),%edx
 28b:	8b 45 08             	mov    0x8(%ebp),%eax
 28e:	01 d0                	add    %edx,%eax
 290:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 293:	8b 45 08             	mov    0x8(%ebp),%eax
}
 296:	c9                   	leave  
 297:	c3                   	ret    

00000298 <stat>:

int
stat(char *n, struct stat *st)
{
 298:	f3 0f 1e fb          	endbr32 
 29c:	55                   	push   %ebp
 29d:	89 e5                	mov    %esp,%ebp
 29f:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a2:	83 ec 08             	sub    $0x8,%esp
 2a5:	6a 00                	push   $0x0
 2a7:	ff 75 08             	pushl  0x8(%ebp)
 2aa:	e8 eb 01 00 00       	call   49a <open>
 2af:	83 c4 10             	add    $0x10,%esp
 2b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b9:	79 07                	jns    2c2 <stat+0x2a>
    return -1;
 2bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2c0:	eb 25                	jmp    2e7 <stat+0x4f>
  r = fstat(fd, st);
 2c2:	83 ec 08             	sub    $0x8,%esp
 2c5:	ff 75 0c             	pushl  0xc(%ebp)
 2c8:	ff 75 f4             	pushl  -0xc(%ebp)
 2cb:	e8 e2 01 00 00       	call   4b2 <fstat>
 2d0:	83 c4 10             	add    $0x10,%esp
 2d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d6:	83 ec 0c             	sub    $0xc,%esp
 2d9:	ff 75 f4             	pushl  -0xc(%ebp)
 2dc:	e8 a1 01 00 00       	call   482 <close>
 2e1:	83 c4 10             	add    $0x10,%esp
  return r;
 2e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e7:	c9                   	leave  
 2e8:	c3                   	ret    

000002e9 <atoi>:

int
atoi(const char *s)
{
 2e9:	f3 0f 1e fb          	endbr32 
 2ed:	55                   	push   %ebp
 2ee:	89 e5                	mov    %esp,%ebp
 2f0:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 2f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 2fa:	eb 04                	jmp    300 <atoi+0x17>
 2fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 300:	8b 45 08             	mov    0x8(%ebp),%eax
 303:	0f b6 00             	movzbl (%eax),%eax
 306:	3c 20                	cmp    $0x20,%al
 308:	74 f2                	je     2fc <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
 30a:	8b 45 08             	mov    0x8(%ebp),%eax
 30d:	0f b6 00             	movzbl (%eax),%eax
 310:	3c 2d                	cmp    $0x2d,%al
 312:	75 07                	jne    31b <atoi+0x32>
 314:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 319:	eb 05                	jmp    320 <atoi+0x37>
 31b:	b8 01 00 00 00       	mov    $0x1,%eax
 320:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 323:	8b 45 08             	mov    0x8(%ebp),%eax
 326:	0f b6 00             	movzbl (%eax),%eax
 329:	3c 2b                	cmp    $0x2b,%al
 32b:	74 0a                	je     337 <atoi+0x4e>
 32d:	8b 45 08             	mov    0x8(%ebp),%eax
 330:	0f b6 00             	movzbl (%eax),%eax
 333:	3c 2d                	cmp    $0x2d,%al
 335:	75 2b                	jne    362 <atoi+0x79>
    s++;
 337:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 33b:	eb 25                	jmp    362 <atoi+0x79>
    n = n*10 + *s++ - '0';
 33d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 340:	89 d0                	mov    %edx,%eax
 342:	c1 e0 02             	shl    $0x2,%eax
 345:	01 d0                	add    %edx,%eax
 347:	01 c0                	add    %eax,%eax
 349:	89 c1                	mov    %eax,%ecx
 34b:	8b 45 08             	mov    0x8(%ebp),%eax
 34e:	8d 50 01             	lea    0x1(%eax),%edx
 351:	89 55 08             	mov    %edx,0x8(%ebp)
 354:	0f b6 00             	movzbl (%eax),%eax
 357:	0f be c0             	movsbl %al,%eax
 35a:	01 c8                	add    %ecx,%eax
 35c:	83 e8 30             	sub    $0x30,%eax
 35f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 362:	8b 45 08             	mov    0x8(%ebp),%eax
 365:	0f b6 00             	movzbl (%eax),%eax
 368:	3c 2f                	cmp    $0x2f,%al
 36a:	7e 0a                	jle    376 <atoi+0x8d>
 36c:	8b 45 08             	mov    0x8(%ebp),%eax
 36f:	0f b6 00             	movzbl (%eax),%eax
 372:	3c 39                	cmp    $0x39,%al
 374:	7e c7                	jle    33d <atoi+0x54>
  return sign*n;
 376:	8b 45 f8             	mov    -0x8(%ebp),%eax
 379:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 37d:	c9                   	leave  
 37e:	c3                   	ret    

0000037f <atoo>:

int
atoo(const char *s)
{
 37f:	f3 0f 1e fb          	endbr32 
 383:	55                   	push   %ebp
 384:	89 e5                	mov    %esp,%ebp
 386:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 389:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 390:	eb 04                	jmp    396 <atoo+0x17>
 392:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 396:	8b 45 08             	mov    0x8(%ebp),%eax
 399:	0f b6 00             	movzbl (%eax),%eax
 39c:	3c 20                	cmp    $0x20,%al
 39e:	74 f2                	je     392 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
 3a0:	8b 45 08             	mov    0x8(%ebp),%eax
 3a3:	0f b6 00             	movzbl (%eax),%eax
 3a6:	3c 2d                	cmp    $0x2d,%al
 3a8:	75 07                	jne    3b1 <atoo+0x32>
 3aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3af:	eb 05                	jmp    3b6 <atoo+0x37>
 3b1:	b8 01 00 00 00       	mov    $0x1,%eax
 3b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 3b9:	8b 45 08             	mov    0x8(%ebp),%eax
 3bc:	0f b6 00             	movzbl (%eax),%eax
 3bf:	3c 2b                	cmp    $0x2b,%al
 3c1:	74 0a                	je     3cd <atoo+0x4e>
 3c3:	8b 45 08             	mov    0x8(%ebp),%eax
 3c6:	0f b6 00             	movzbl (%eax),%eax
 3c9:	3c 2d                	cmp    $0x2d,%al
 3cb:	75 27                	jne    3f4 <atoo+0x75>
    s++;
 3cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 3d1:	eb 21                	jmp    3f4 <atoo+0x75>
    n = n*8 + *s++ - '0';
 3d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3d6:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 3dd:	8b 45 08             	mov    0x8(%ebp),%eax
 3e0:	8d 50 01             	lea    0x1(%eax),%edx
 3e3:	89 55 08             	mov    %edx,0x8(%ebp)
 3e6:	0f b6 00             	movzbl (%eax),%eax
 3e9:	0f be c0             	movsbl %al,%eax
 3ec:	01 c8                	add    %ecx,%eax
 3ee:	83 e8 30             	sub    $0x30,%eax
 3f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	0f b6 00             	movzbl (%eax),%eax
 3fa:	3c 2f                	cmp    $0x2f,%al
 3fc:	7e 0a                	jle    408 <atoo+0x89>
 3fe:	8b 45 08             	mov    0x8(%ebp),%eax
 401:	0f b6 00             	movzbl (%eax),%eax
 404:	3c 37                	cmp    $0x37,%al
 406:	7e cb                	jle    3d3 <atoo+0x54>
  return sign*n;
 408:	8b 45 f8             	mov    -0x8(%ebp),%eax
 40b:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 40f:	c9                   	leave  
 410:	c3                   	ret    

00000411 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 411:	f3 0f 1e fb          	endbr32 
 415:	55                   	push   %ebp
 416:	89 e5                	mov    %esp,%ebp
 418:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 41b:	8b 45 08             	mov    0x8(%ebp),%eax
 41e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 421:	8b 45 0c             	mov    0xc(%ebp),%eax
 424:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 427:	eb 17                	jmp    440 <memmove+0x2f>
    *dst++ = *src++;
 429:	8b 55 f8             	mov    -0x8(%ebp),%edx
 42c:	8d 42 01             	lea    0x1(%edx),%eax
 42f:	89 45 f8             	mov    %eax,-0x8(%ebp)
 432:	8b 45 fc             	mov    -0x4(%ebp),%eax
 435:	8d 48 01             	lea    0x1(%eax),%ecx
 438:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 43b:	0f b6 12             	movzbl (%edx),%edx
 43e:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 440:	8b 45 10             	mov    0x10(%ebp),%eax
 443:	8d 50 ff             	lea    -0x1(%eax),%edx
 446:	89 55 10             	mov    %edx,0x10(%ebp)
 449:	85 c0                	test   %eax,%eax
 44b:	7f dc                	jg     429 <memmove+0x18>
  return vdst;
 44d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 450:	c9                   	leave  
 451:	c3                   	ret    

00000452 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 452:	b8 01 00 00 00       	mov    $0x1,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <exit>:
SYSCALL(exit)
 45a:	b8 02 00 00 00       	mov    $0x2,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <wait>:
SYSCALL(wait)
 462:	b8 03 00 00 00       	mov    $0x3,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <pipe>:
SYSCALL(pipe)
 46a:	b8 04 00 00 00       	mov    $0x4,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <read>:
SYSCALL(read)
 472:	b8 05 00 00 00       	mov    $0x5,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <write>:
SYSCALL(write)
 47a:	b8 10 00 00 00       	mov    $0x10,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <close>:
SYSCALL(close)
 482:	b8 15 00 00 00       	mov    $0x15,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <kill>:
SYSCALL(kill)
 48a:	b8 06 00 00 00       	mov    $0x6,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <exec>:
SYSCALL(exec)
 492:	b8 07 00 00 00       	mov    $0x7,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <open>:
SYSCALL(open)
 49a:	b8 0f 00 00 00       	mov    $0xf,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <mknod>:
SYSCALL(mknod)
 4a2:	b8 11 00 00 00       	mov    $0x11,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <unlink>:
SYSCALL(unlink)
 4aa:	b8 12 00 00 00       	mov    $0x12,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <fstat>:
SYSCALL(fstat)
 4b2:	b8 08 00 00 00       	mov    $0x8,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <link>:
SYSCALL(link)
 4ba:	b8 13 00 00 00       	mov    $0x13,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <mkdir>:
SYSCALL(mkdir)
 4c2:	b8 14 00 00 00       	mov    $0x14,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <chdir>:
SYSCALL(chdir)
 4ca:	b8 09 00 00 00       	mov    $0x9,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <dup>:
SYSCALL(dup)
 4d2:	b8 0a 00 00 00       	mov    $0xa,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <getpid>:
SYSCALL(getpid)
 4da:	b8 0b 00 00 00       	mov    $0xb,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <sbrk>:
SYSCALL(sbrk)
 4e2:	b8 0c 00 00 00       	mov    $0xc,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <sleep>:
SYSCALL(sleep)
 4ea:	b8 0d 00 00 00       	mov    $0xd,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <uptime>:
SYSCALL(uptime)
 4f2:	b8 0e 00 00 00       	mov    $0xe,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <halt>:
SYSCALL(halt)
 4fa:	b8 16 00 00 00       	mov    $0x16,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <date>:
SYSCALL(date)
 502:	b8 17 00 00 00       	mov    $0x17,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <getuid>:
SYSCALL(getuid)
 50a:	b8 18 00 00 00       	mov    $0x18,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <getgid>:
SYSCALL(getgid)
 512:	b8 19 00 00 00       	mov    $0x19,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <getppid>:
SYSCALL(getppid)
 51a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <setuid>:
SYSCALL(setuid)
 522:	b8 1b 00 00 00       	mov    $0x1b,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <setgid>:
SYSCALL(setgid)
 52a:	b8 1c 00 00 00       	mov    $0x1c,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <getprocs>:
SYSCALL(getprocs)
 532:	b8 1d 00 00 00       	mov    $0x1d,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <setpriority>:
SYSCALL(setpriority)
 53a:	b8 1e 00 00 00       	mov    $0x1e,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <chown>:
SYSCALL(chown)
 542:	b8 1f 00 00 00       	mov    $0x1f,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 54a:	f3 0f 1e fb          	endbr32 
 54e:	55                   	push   %ebp
 54f:	89 e5                	mov    %esp,%ebp
 551:	83 ec 18             	sub    $0x18,%esp
 554:	8b 45 0c             	mov    0xc(%ebp),%eax
 557:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 55a:	83 ec 04             	sub    $0x4,%esp
 55d:	6a 01                	push   $0x1
 55f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 562:	50                   	push   %eax
 563:	ff 75 08             	pushl  0x8(%ebp)
 566:	e8 0f ff ff ff       	call   47a <write>
 56b:	83 c4 10             	add    $0x10,%esp
}
 56e:	90                   	nop
 56f:	c9                   	leave  
 570:	c3                   	ret    

00000571 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 571:	f3 0f 1e fb          	endbr32 
 575:	55                   	push   %ebp
 576:	89 e5                	mov    %esp,%ebp
 578:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 57b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 582:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 586:	74 17                	je     59f <printint+0x2e>
 588:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 58c:	79 11                	jns    59f <printint+0x2e>
    neg = 1;
 58e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 595:	8b 45 0c             	mov    0xc(%ebp),%eax
 598:	f7 d8                	neg    %eax
 59a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 59d:	eb 06                	jmp    5a5 <printint+0x34>
  } else {
    x = xx;
 59f:	8b 45 0c             	mov    0xc(%ebp),%eax
 5a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 5a5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 5ac:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5af:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5b2:	ba 00 00 00 00       	mov    $0x0,%edx
 5b7:	f7 f1                	div    %ecx
 5b9:	89 d1                	mov    %edx,%ecx
 5bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5be:	8d 50 01             	lea    0x1(%eax),%edx
 5c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5c4:	0f b6 91 a8 13 00 00 	movzbl 0x13a8(%ecx),%edx
 5cb:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 5cf:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5d2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5d5:	ba 00 00 00 00       	mov    $0x0,%edx
 5da:	f7 f1                	div    %ecx
 5dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5df:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5e3:	75 c7                	jne    5ac <printint+0x3b>
  if(neg)
 5e5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5e9:	74 2d                	je     618 <printint+0xa7>
    buf[i++] = '-';
 5eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ee:	8d 50 01             	lea    0x1(%eax),%edx
 5f1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5f4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5f9:	eb 1d                	jmp    618 <printint+0xa7>
    putc(fd, buf[i]);
 5fb:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 601:	01 d0                	add    %edx,%eax
 603:	0f b6 00             	movzbl (%eax),%eax
 606:	0f be c0             	movsbl %al,%eax
 609:	83 ec 08             	sub    $0x8,%esp
 60c:	50                   	push   %eax
 60d:	ff 75 08             	pushl  0x8(%ebp)
 610:	e8 35 ff ff ff       	call   54a <putc>
 615:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 618:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 61c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 620:	79 d9                	jns    5fb <printint+0x8a>
}
 622:	90                   	nop
 623:	90                   	nop
 624:	c9                   	leave  
 625:	c3                   	ret    

00000626 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 626:	f3 0f 1e fb          	endbr32 
 62a:	55                   	push   %ebp
 62b:	89 e5                	mov    %esp,%ebp
 62d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 630:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 637:	8d 45 0c             	lea    0xc(%ebp),%eax
 63a:	83 c0 04             	add    $0x4,%eax
 63d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 640:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 647:	e9 59 01 00 00       	jmp    7a5 <printf+0x17f>
    c = fmt[i] & 0xff;
 64c:	8b 55 0c             	mov    0xc(%ebp),%edx
 64f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 652:	01 d0                	add    %edx,%eax
 654:	0f b6 00             	movzbl (%eax),%eax
 657:	0f be c0             	movsbl %al,%eax
 65a:	25 ff 00 00 00       	and    $0xff,%eax
 65f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 662:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 666:	75 2c                	jne    694 <printf+0x6e>
      if(c == '%'){
 668:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 66c:	75 0c                	jne    67a <printf+0x54>
        state = '%';
 66e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 675:	e9 27 01 00 00       	jmp    7a1 <printf+0x17b>
      } else {
        putc(fd, c);
 67a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 67d:	0f be c0             	movsbl %al,%eax
 680:	83 ec 08             	sub    $0x8,%esp
 683:	50                   	push   %eax
 684:	ff 75 08             	pushl  0x8(%ebp)
 687:	e8 be fe ff ff       	call   54a <putc>
 68c:	83 c4 10             	add    $0x10,%esp
 68f:	e9 0d 01 00 00       	jmp    7a1 <printf+0x17b>
      }
    } else if(state == '%'){
 694:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 698:	0f 85 03 01 00 00    	jne    7a1 <printf+0x17b>
      if(c == 'd'){
 69e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 6a2:	75 1e                	jne    6c2 <printf+0x9c>
        printint(fd, *ap, 10, 1);
 6a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a7:	8b 00                	mov    (%eax),%eax
 6a9:	6a 01                	push   $0x1
 6ab:	6a 0a                	push   $0xa
 6ad:	50                   	push   %eax
 6ae:	ff 75 08             	pushl  0x8(%ebp)
 6b1:	e8 bb fe ff ff       	call   571 <printint>
 6b6:	83 c4 10             	add    $0x10,%esp
        ap++;
 6b9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6bd:	e9 d8 00 00 00       	jmp    79a <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 6c2:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6c6:	74 06                	je     6ce <printf+0xa8>
 6c8:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6cc:	75 1e                	jne    6ec <printf+0xc6>
        printint(fd, *ap, 16, 0);
 6ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6d1:	8b 00                	mov    (%eax),%eax
 6d3:	6a 00                	push   $0x0
 6d5:	6a 10                	push   $0x10
 6d7:	50                   	push   %eax
 6d8:	ff 75 08             	pushl  0x8(%ebp)
 6db:	e8 91 fe ff ff       	call   571 <printint>
 6e0:	83 c4 10             	add    $0x10,%esp
        ap++;
 6e3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6e7:	e9 ae 00 00 00       	jmp    79a <printf+0x174>
      } else if(c == 's'){
 6ec:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6f0:	75 43                	jne    735 <printf+0x10f>
        s = (char*)*ap;
 6f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6f5:	8b 00                	mov    (%eax),%eax
 6f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6fa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 702:	75 25                	jne    729 <printf+0x103>
          s = "(null)";
 704:	c7 45 f4 74 0f 00 00 	movl   $0xf74,-0xc(%ebp)
        while(*s != 0){
 70b:	eb 1c                	jmp    729 <printf+0x103>
          putc(fd, *s);
 70d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 710:	0f b6 00             	movzbl (%eax),%eax
 713:	0f be c0             	movsbl %al,%eax
 716:	83 ec 08             	sub    $0x8,%esp
 719:	50                   	push   %eax
 71a:	ff 75 08             	pushl  0x8(%ebp)
 71d:	e8 28 fe ff ff       	call   54a <putc>
 722:	83 c4 10             	add    $0x10,%esp
          s++;
 725:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 729:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72c:	0f b6 00             	movzbl (%eax),%eax
 72f:	84 c0                	test   %al,%al
 731:	75 da                	jne    70d <printf+0xe7>
 733:	eb 65                	jmp    79a <printf+0x174>
        }
      } else if(c == 'c'){
 735:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 739:	75 1d                	jne    758 <printf+0x132>
        putc(fd, *ap);
 73b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 73e:	8b 00                	mov    (%eax),%eax
 740:	0f be c0             	movsbl %al,%eax
 743:	83 ec 08             	sub    $0x8,%esp
 746:	50                   	push   %eax
 747:	ff 75 08             	pushl  0x8(%ebp)
 74a:	e8 fb fd ff ff       	call   54a <putc>
 74f:	83 c4 10             	add    $0x10,%esp
        ap++;
 752:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 756:	eb 42                	jmp    79a <printf+0x174>
      } else if(c == '%'){
 758:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 75c:	75 17                	jne    775 <printf+0x14f>
        putc(fd, c);
 75e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 761:	0f be c0             	movsbl %al,%eax
 764:	83 ec 08             	sub    $0x8,%esp
 767:	50                   	push   %eax
 768:	ff 75 08             	pushl  0x8(%ebp)
 76b:	e8 da fd ff ff       	call   54a <putc>
 770:	83 c4 10             	add    $0x10,%esp
 773:	eb 25                	jmp    79a <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 775:	83 ec 08             	sub    $0x8,%esp
 778:	6a 25                	push   $0x25
 77a:	ff 75 08             	pushl  0x8(%ebp)
 77d:	e8 c8 fd ff ff       	call   54a <putc>
 782:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 785:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 788:	0f be c0             	movsbl %al,%eax
 78b:	83 ec 08             	sub    $0x8,%esp
 78e:	50                   	push   %eax
 78f:	ff 75 08             	pushl  0x8(%ebp)
 792:	e8 b3 fd ff ff       	call   54a <putc>
 797:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 79a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 7a1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 7a5:	8b 55 0c             	mov    0xc(%ebp),%edx
 7a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ab:	01 d0                	add    %edx,%eax
 7ad:	0f b6 00             	movzbl (%eax),%eax
 7b0:	84 c0                	test   %al,%al
 7b2:	0f 85 94 fe ff ff    	jne    64c <printf+0x26>
    }
  }
}
 7b8:	90                   	nop
 7b9:	90                   	nop
 7ba:	c9                   	leave  
 7bb:	c3                   	ret    

000007bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7bc:	f3 0f 1e fb          	endbr32 
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7c6:	8b 45 08             	mov    0x8(%ebp),%eax
 7c9:	83 e8 08             	sub    $0x8,%eax
 7cc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7cf:	a1 c8 13 00 00       	mov    0x13c8,%eax
 7d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7d7:	eb 24                	jmp    7fd <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dc:	8b 00                	mov    (%eax),%eax
 7de:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 7e1:	72 12                	jb     7f5 <free+0x39>
 7e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7e9:	77 24                	ja     80f <free+0x53>
 7eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ee:	8b 00                	mov    (%eax),%eax
 7f0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7f3:	72 1a                	jb     80f <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f8:	8b 00                	mov    (%eax),%eax
 7fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 800:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 803:	76 d4                	jbe    7d9 <free+0x1d>
 805:	8b 45 fc             	mov    -0x4(%ebp),%eax
 808:	8b 00                	mov    (%eax),%eax
 80a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 80d:	73 ca                	jae    7d9 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 80f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 812:	8b 40 04             	mov    0x4(%eax),%eax
 815:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 81c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81f:	01 c2                	add    %eax,%edx
 821:	8b 45 fc             	mov    -0x4(%ebp),%eax
 824:	8b 00                	mov    (%eax),%eax
 826:	39 c2                	cmp    %eax,%edx
 828:	75 24                	jne    84e <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 82a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82d:	8b 50 04             	mov    0x4(%eax),%edx
 830:	8b 45 fc             	mov    -0x4(%ebp),%eax
 833:	8b 00                	mov    (%eax),%eax
 835:	8b 40 04             	mov    0x4(%eax),%eax
 838:	01 c2                	add    %eax,%edx
 83a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 83d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 840:	8b 45 fc             	mov    -0x4(%ebp),%eax
 843:	8b 00                	mov    (%eax),%eax
 845:	8b 10                	mov    (%eax),%edx
 847:	8b 45 f8             	mov    -0x8(%ebp),%eax
 84a:	89 10                	mov    %edx,(%eax)
 84c:	eb 0a                	jmp    858 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 84e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 851:	8b 10                	mov    (%eax),%edx
 853:	8b 45 f8             	mov    -0x8(%ebp),%eax
 856:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 858:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85b:	8b 40 04             	mov    0x4(%eax),%eax
 85e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 865:	8b 45 fc             	mov    -0x4(%ebp),%eax
 868:	01 d0                	add    %edx,%eax
 86a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 86d:	75 20                	jne    88f <free+0xd3>
    p->s.size += bp->s.size;
 86f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 872:	8b 50 04             	mov    0x4(%eax),%edx
 875:	8b 45 f8             	mov    -0x8(%ebp),%eax
 878:	8b 40 04             	mov    0x4(%eax),%eax
 87b:	01 c2                	add    %eax,%edx
 87d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 880:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 883:	8b 45 f8             	mov    -0x8(%ebp),%eax
 886:	8b 10                	mov    (%eax),%edx
 888:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88b:	89 10                	mov    %edx,(%eax)
 88d:	eb 08                	jmp    897 <free+0xdb>
  } else
    p->s.ptr = bp;
 88f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 892:	8b 55 f8             	mov    -0x8(%ebp),%edx
 895:	89 10                	mov    %edx,(%eax)
  freep = p;
 897:	8b 45 fc             	mov    -0x4(%ebp),%eax
 89a:	a3 c8 13 00 00       	mov    %eax,0x13c8
}
 89f:	90                   	nop
 8a0:	c9                   	leave  
 8a1:	c3                   	ret    

000008a2 <morecore>:

static Header*
morecore(uint nu)
{
 8a2:	f3 0f 1e fb          	endbr32 
 8a6:	55                   	push   %ebp
 8a7:	89 e5                	mov    %esp,%ebp
 8a9:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 8ac:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 8b3:	77 07                	ja     8bc <morecore+0x1a>
    nu = 4096;
 8b5:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 8bc:	8b 45 08             	mov    0x8(%ebp),%eax
 8bf:	c1 e0 03             	shl    $0x3,%eax
 8c2:	83 ec 0c             	sub    $0xc,%esp
 8c5:	50                   	push   %eax
 8c6:	e8 17 fc ff ff       	call   4e2 <sbrk>
 8cb:	83 c4 10             	add    $0x10,%esp
 8ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8d1:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8d5:	75 07                	jne    8de <morecore+0x3c>
    return 0;
 8d7:	b8 00 00 00 00       	mov    $0x0,%eax
 8dc:	eb 26                	jmp    904 <morecore+0x62>
  hp = (Header*)p;
 8de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e7:	8b 55 08             	mov    0x8(%ebp),%edx
 8ea:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f0:	83 c0 08             	add    $0x8,%eax
 8f3:	83 ec 0c             	sub    $0xc,%esp
 8f6:	50                   	push   %eax
 8f7:	e8 c0 fe ff ff       	call   7bc <free>
 8fc:	83 c4 10             	add    $0x10,%esp
  return freep;
 8ff:	a1 c8 13 00 00       	mov    0x13c8,%eax
}
 904:	c9                   	leave  
 905:	c3                   	ret    

00000906 <malloc>:

void*
malloc(uint nbytes)
{
 906:	f3 0f 1e fb          	endbr32 
 90a:	55                   	push   %ebp
 90b:	89 e5                	mov    %esp,%ebp
 90d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 910:	8b 45 08             	mov    0x8(%ebp),%eax
 913:	83 c0 07             	add    $0x7,%eax
 916:	c1 e8 03             	shr    $0x3,%eax
 919:	83 c0 01             	add    $0x1,%eax
 91c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 91f:	a1 c8 13 00 00       	mov    0x13c8,%eax
 924:	89 45 f0             	mov    %eax,-0x10(%ebp)
 927:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 92b:	75 23                	jne    950 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 92d:	c7 45 f0 c0 13 00 00 	movl   $0x13c0,-0x10(%ebp)
 934:	8b 45 f0             	mov    -0x10(%ebp),%eax
 937:	a3 c8 13 00 00       	mov    %eax,0x13c8
 93c:	a1 c8 13 00 00       	mov    0x13c8,%eax
 941:	a3 c0 13 00 00       	mov    %eax,0x13c0
    base.s.size = 0;
 946:	c7 05 c4 13 00 00 00 	movl   $0x0,0x13c4
 94d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 950:	8b 45 f0             	mov    -0x10(%ebp),%eax
 953:	8b 00                	mov    (%eax),%eax
 955:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 958:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95b:	8b 40 04             	mov    0x4(%eax),%eax
 95e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 961:	77 4d                	ja     9b0 <malloc+0xaa>
      if(p->s.size == nunits)
 963:	8b 45 f4             	mov    -0xc(%ebp),%eax
 966:	8b 40 04             	mov    0x4(%eax),%eax
 969:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 96c:	75 0c                	jne    97a <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 96e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 971:	8b 10                	mov    (%eax),%edx
 973:	8b 45 f0             	mov    -0x10(%ebp),%eax
 976:	89 10                	mov    %edx,(%eax)
 978:	eb 26                	jmp    9a0 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 97a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 97d:	8b 40 04             	mov    0x4(%eax),%eax
 980:	2b 45 ec             	sub    -0x14(%ebp),%eax
 983:	89 c2                	mov    %eax,%edx
 985:	8b 45 f4             	mov    -0xc(%ebp),%eax
 988:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 98b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 98e:	8b 40 04             	mov    0x4(%eax),%eax
 991:	c1 e0 03             	shl    $0x3,%eax
 994:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 997:	8b 45 f4             	mov    -0xc(%ebp),%eax
 99a:	8b 55 ec             	mov    -0x14(%ebp),%edx
 99d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 9a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9a3:	a3 c8 13 00 00       	mov    %eax,0x13c8
      return (void*)(p + 1);
 9a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ab:	83 c0 08             	add    $0x8,%eax
 9ae:	eb 3b                	jmp    9eb <malloc+0xe5>
    }
    if(p == freep)
 9b0:	a1 c8 13 00 00       	mov    0x13c8,%eax
 9b5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 9b8:	75 1e                	jne    9d8 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 9ba:	83 ec 0c             	sub    $0xc,%esp
 9bd:	ff 75 ec             	pushl  -0x14(%ebp)
 9c0:	e8 dd fe ff ff       	call   8a2 <morecore>
 9c5:	83 c4 10             	add    $0x10,%esp
 9c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9cf:	75 07                	jne    9d8 <malloc+0xd2>
        return 0;
 9d1:	b8 00 00 00 00       	mov    $0x0,%eax
 9d6:	eb 13                	jmp    9eb <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9db:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e1:	8b 00                	mov    (%eax),%eax
 9e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9e6:	e9 6d ff ff ff       	jmp    958 <malloc+0x52>
  }
}
 9eb:	c9                   	leave  
 9ec:	c3                   	ret    

000009ed <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
 9ed:	f3 0f 1e fb          	endbr32 
 9f1:	55                   	push   %ebp
 9f2:	89 e5                	mov    %esp,%ebp
 9f4:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 9f7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 9fe:	a1 20 14 00 00       	mov    0x1420,%eax
 a03:	83 ec 04             	sub    $0x4,%esp
 a06:	50                   	push   %eax
 a07:	6a 20                	push   $0x20
 a09:	68 00 14 00 00       	push   $0x1400
 a0e:	e8 11 f8 ff ff       	call   224 <fgets>
 a13:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 a16:	83 ec 0c             	sub    $0xc,%esp
 a19:	68 00 14 00 00       	push   $0x1400
 a1e:	e8 0e f7 ff ff       	call   131 <strlen>
 a23:	83 c4 10             	add    $0x10,%esp
 a26:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 a29:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a2c:	83 e8 01             	sub    $0x1,%eax
 a2f:	0f b6 80 00 14 00 00 	movzbl 0x1400(%eax),%eax
 a36:	3c 0a                	cmp    $0xa,%al
 a38:	74 11                	je     a4b <get_id+0x5e>
 a3a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a3d:	83 e8 01             	sub    $0x1,%eax
 a40:	0f b6 80 00 14 00 00 	movzbl 0x1400(%eax),%eax
 a47:	3c 0d                	cmp    $0xd,%al
 a49:	75 0d                	jne    a58 <get_id+0x6b>
        current_line[len - 1] = 0;
 a4b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a4e:	83 e8 01             	sub    $0x1,%eax
 a51:	c6 80 00 14 00 00 00 	movb   $0x0,0x1400(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 a58:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 a5f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 a66:	eb 6c                	jmp    ad4 <get_id+0xe7>
        if(current_line[i] == ' '){
 a68:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a6b:	05 00 14 00 00       	add    $0x1400,%eax
 a70:	0f b6 00             	movzbl (%eax),%eax
 a73:	3c 20                	cmp    $0x20,%al
 a75:	75 30                	jne    aa7 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 a77:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a7b:	75 16                	jne    a93 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 a7d:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 a80:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a83:	8d 50 01             	lea    0x1(%eax),%edx
 a86:	89 55 f0             	mov    %edx,-0x10(%ebp)
 a89:	8d 91 00 14 00 00    	lea    0x1400(%ecx),%edx
 a8f:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 a93:	8b 45 ec             	mov    -0x14(%ebp),%eax
 a96:	05 00 14 00 00       	add    $0x1400,%eax
 a9b:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 a9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 aa5:	eb 29                	jmp    ad0 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 aa7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 aab:	75 23                	jne    ad0 <get_id+0xe3>
 aad:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 ab1:	7f 1d                	jg     ad0 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 ab3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 aba:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 abd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ac0:	8d 50 01             	lea    0x1(%eax),%edx
 ac3:	89 55 f0             	mov    %edx,-0x10(%ebp)
 ac6:	8d 91 00 14 00 00    	lea    0x1400(%ecx),%edx
 acc:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 ad0:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 ad4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 ad7:	05 00 14 00 00       	add    $0x1400,%eax
 adc:	0f b6 00             	movzbl (%eax),%eax
 adf:	84 c0                	test   %al,%al
 ae1:	75 85                	jne    a68 <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 ae3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 ae7:	75 07                	jne    af0 <get_id+0x103>
        return -1;
 ae9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 aee:	eb 35                	jmp    b25 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
 af0:	8b 45 dc             	mov    -0x24(%ebp),%eax
 af3:	a3 e0 13 00 00       	mov    %eax,0x13e0
    current_id.uid_user = atoi(tokens[1]);
 af8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 afb:	83 ec 0c             	sub    $0xc,%esp
 afe:	50                   	push   %eax
 aff:	e8 e5 f7 ff ff       	call   2e9 <atoi>
 b04:	83 c4 10             	add    $0x10,%esp
 b07:	a3 e4 13 00 00       	mov    %eax,0x13e4
    current_id.gid_user = atoi(tokens[2]);
 b0c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 b0f:	83 ec 0c             	sub    $0xc,%esp
 b12:	50                   	push   %eax
 b13:	e8 d1 f7 ff ff       	call   2e9 <atoi>
 b18:	83 c4 10             	add    $0x10,%esp
 b1b:	a3 e8 13 00 00       	mov    %eax,0x13e8

    return 0;
 b20:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b25:	c9                   	leave  
 b26:	c3                   	ret    

00000b27 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
 b27:	f3 0f 1e fb          	endbr32 
 b2b:	55                   	push   %ebp
 b2c:	89 e5                	mov    %esp,%ebp
 b2e:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 b31:	a1 20 14 00 00       	mov    0x1420,%eax
 b36:	85 c0                	test   %eax,%eax
 b38:	75 31                	jne    b6b <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
 b3a:	83 ec 08             	sub    $0x8,%esp
 b3d:	6a 00                	push   $0x0
 b3f:	68 7b 0f 00 00       	push   $0xf7b
 b44:	e8 51 f9 ff ff       	call   49a <open>
 b49:	83 c4 10             	add    $0x10,%esp
 b4c:	a3 20 14 00 00       	mov    %eax,0x1420

        if(dir < 0){        // kalau gagal membuka file
 b51:	a1 20 14 00 00       	mov    0x1420,%eax
 b56:	85 c0                	test   %eax,%eax
 b58:	79 11                	jns    b6b <getid+0x44>
            dir = 0;
 b5a:	c7 05 20 14 00 00 00 	movl   $0x0,0x1420
 b61:	00 00 00 
            return 0;
 b64:	b8 00 00 00 00       	mov    $0x0,%eax
 b69:	eb 16                	jmp    b81 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
 b6b:	e8 7d fe ff ff       	call   9ed <get_id>
 b70:	83 f8 ff             	cmp    $0xffffffff,%eax
 b73:	75 07                	jne    b7c <getid+0x55>
        return 0;
 b75:	b8 00 00 00 00       	mov    $0x0,%eax
 b7a:	eb 05                	jmp    b81 <getid+0x5a>
    
    return &current_id;
 b7c:	b8 e0 13 00 00       	mov    $0x13e0,%eax
}
 b81:	c9                   	leave  
 b82:	c3                   	ret    

00000b83 <setid>:

// open file_ids
void setid(void){
 b83:	f3 0f 1e fb          	endbr32 
 b87:	55                   	push   %ebp
 b88:	89 e5                	mov    %esp,%ebp
 b8a:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 b8d:	a1 20 14 00 00       	mov    0x1420,%eax
 b92:	85 c0                	test   %eax,%eax
 b94:	74 1b                	je     bb1 <setid+0x2e>
        close(dir);
 b96:	a1 20 14 00 00       	mov    0x1420,%eax
 b9b:	83 ec 0c             	sub    $0xc,%esp
 b9e:	50                   	push   %eax
 b9f:	e8 de f8 ff ff       	call   482 <close>
 ba4:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 ba7:	c7 05 20 14 00 00 00 	movl   $0x0,0x1420
 bae:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
 bb1:	83 ec 08             	sub    $0x8,%esp
 bb4:	6a 00                	push   $0x0
 bb6:	68 7b 0f 00 00       	push   $0xf7b
 bbb:	e8 da f8 ff ff       	call   49a <open>
 bc0:	83 c4 10             	add    $0x10,%esp
 bc3:	a3 20 14 00 00       	mov    %eax,0x1420

    if (dir < 0)
 bc8:	a1 20 14 00 00       	mov    0x1420,%eax
 bcd:	85 c0                	test   %eax,%eax
 bcf:	79 0a                	jns    bdb <setid+0x58>
        dir = 0;
 bd1:	c7 05 20 14 00 00 00 	movl   $0x0,0x1420
 bd8:	00 00 00 
}
 bdb:	90                   	nop
 bdc:	c9                   	leave  
 bdd:	c3                   	ret    

00000bde <endid>:

// tutup file_ids
void endid (void){
 bde:	f3 0f 1e fb          	endbr32 
 be2:	55                   	push   %ebp
 be3:	89 e5                	mov    %esp,%ebp
 be5:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 be8:	a1 20 14 00 00       	mov    0x1420,%eax
 bed:	85 c0                	test   %eax,%eax
 bef:	74 1b                	je     c0c <endid+0x2e>
        close(dir);
 bf1:	a1 20 14 00 00       	mov    0x1420,%eax
 bf6:	83 ec 0c             	sub    $0xc,%esp
 bf9:	50                   	push   %eax
 bfa:	e8 83 f8 ff ff       	call   482 <close>
 bff:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 c02:	c7 05 20 14 00 00 00 	movl   $0x0,0x1420
 c09:	00 00 00 
    }
}
 c0c:	90                   	nop
 c0d:	c9                   	leave  
 c0e:	c3                   	ret    

00000c0f <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
 c0f:	f3 0f 1e fb          	endbr32 
 c13:	55                   	push   %ebp
 c14:	89 e5                	mov    %esp,%ebp
 c16:	83 ec 08             	sub    $0x8,%esp
    setid();
 c19:	e8 65 ff ff ff       	call   b83 <setid>

    while (getid()){
 c1e:	eb 24                	jmp    c44 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
 c20:	a1 e0 13 00 00       	mov    0x13e0,%eax
 c25:	83 ec 08             	sub    $0x8,%esp
 c28:	50                   	push   %eax
 c29:	ff 75 08             	pushl  0x8(%ebp)
 c2c:	e8 bd f4 ff ff       	call   ee <strcmp>
 c31:	83 c4 10             	add    $0x10,%esp
 c34:	85 c0                	test   %eax,%eax
 c36:	75 0c                	jne    c44 <cek_nama+0x35>
            endid();
 c38:	e8 a1 ff ff ff       	call   bde <endid>
            return &current_id;
 c3d:	b8 e0 13 00 00       	mov    $0x13e0,%eax
 c42:	eb 13                	jmp    c57 <cek_nama+0x48>
    while (getid()){
 c44:	e8 de fe ff ff       	call   b27 <getid>
 c49:	85 c0                	test   %eax,%eax
 c4b:	75 d3                	jne    c20 <cek_nama+0x11>
        }
    }
    endid();
 c4d:	e8 8c ff ff ff       	call   bde <endid>
    return 0;
 c52:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c57:	c9                   	leave  
 c58:	c3                   	ret    

00000c59 <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
 c59:	f3 0f 1e fb          	endbr32 
 c5d:	55                   	push   %ebp
 c5e:	89 e5                	mov    %esp,%ebp
 c60:	83 ec 08             	sub    $0x8,%esp
    setid();
 c63:	e8 1b ff ff ff       	call   b83 <setid>

    while (getid()){
 c68:	eb 16                	jmp    c80 <cek_uid+0x27>
        if(current_id.uid_user == uid){
 c6a:	a1 e4 13 00 00       	mov    0x13e4,%eax
 c6f:	39 45 08             	cmp    %eax,0x8(%ebp)
 c72:	75 0c                	jne    c80 <cek_uid+0x27>
            endid();
 c74:	e8 65 ff ff ff       	call   bde <endid>
            return &current_id;
 c79:	b8 e0 13 00 00       	mov    $0x13e0,%eax
 c7e:	eb 13                	jmp    c93 <cek_uid+0x3a>
    while (getid()){
 c80:	e8 a2 fe ff ff       	call   b27 <getid>
 c85:	85 c0                	test   %eax,%eax
 c87:	75 e1                	jne    c6a <cek_uid+0x11>
        }
    }
    endid();
 c89:	e8 50 ff ff ff       	call   bde <endid>
    return 0;
 c8e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 c93:	c9                   	leave  
 c94:	c3                   	ret    

00000c95 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
 c95:	f3 0f 1e fb          	endbr32 
 c99:	55                   	push   %ebp
 c9a:	89 e5                	mov    %esp,%ebp
 c9c:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 c9f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 ca6:	a1 20 14 00 00       	mov    0x1420,%eax
 cab:	83 ec 04             	sub    $0x4,%esp
 cae:	50                   	push   %eax
 caf:	6a 20                	push   $0x20
 cb1:	68 00 14 00 00       	push   $0x1400
 cb6:	e8 69 f5 ff ff       	call   224 <fgets>
 cbb:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 cbe:	83 ec 0c             	sub    $0xc,%esp
 cc1:	68 00 14 00 00       	push   $0x1400
 cc6:	e8 66 f4 ff ff       	call   131 <strlen>
 ccb:	83 c4 10             	add    $0x10,%esp
 cce:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 cd1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cd4:	83 e8 01             	sub    $0x1,%eax
 cd7:	0f b6 80 00 14 00 00 	movzbl 0x1400(%eax),%eax
 cde:	3c 0a                	cmp    $0xa,%al
 ce0:	74 11                	je     cf3 <get_group+0x5e>
 ce2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ce5:	83 e8 01             	sub    $0x1,%eax
 ce8:	0f b6 80 00 14 00 00 	movzbl 0x1400(%eax),%eax
 cef:	3c 0d                	cmp    $0xd,%al
 cf1:	75 0d                	jne    d00 <get_group+0x6b>
        current_line[len - 1] = 0;
 cf3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 cf6:	83 e8 01             	sub    $0x1,%eax
 cf9:	c6 80 00 14 00 00 00 	movb   $0x0,0x1400(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 d00:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 d07:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 d0e:	eb 6c                	jmp    d7c <get_group+0xe7>
        if(current_line[i] == ' '){
 d10:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d13:	05 00 14 00 00       	add    $0x1400,%eax
 d18:	0f b6 00             	movzbl (%eax),%eax
 d1b:	3c 20                	cmp    $0x20,%al
 d1d:	75 30                	jne    d4f <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 d1f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d23:	75 16                	jne    d3b <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 d25:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d28:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d2b:	8d 50 01             	lea    0x1(%eax),%edx
 d2e:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d31:	8d 91 00 14 00 00    	lea    0x1400(%ecx),%edx
 d37:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 d3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d3e:	05 00 14 00 00       	add    $0x1400,%eax
 d43:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 d46:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 d4d:	eb 29                	jmp    d78 <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 d4f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d53:	75 23                	jne    d78 <get_group+0xe3>
 d55:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 d59:	7f 1d                	jg     d78 <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 d5b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 d62:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d65:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d68:	8d 50 01             	lea    0x1(%eax),%edx
 d6b:	89 55 f0             	mov    %edx,-0x10(%ebp)
 d6e:	8d 91 00 14 00 00    	lea    0x1400(%ecx),%edx
 d74:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 d78:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 d7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d7f:	05 00 14 00 00       	add    $0x1400,%eax
 d84:	0f b6 00             	movzbl (%eax),%eax
 d87:	84 c0                	test   %al,%al
 d89:	75 85                	jne    d10 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 d8b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 d8f:	75 07                	jne    d98 <get_group+0x103>
        return -1;
 d91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d96:	eb 21                	jmp    db9 <get_group+0x124>
    
    current_group.nama_group = tokens[0];
 d98:	8b 45 dc             	mov    -0x24(%ebp),%eax
 d9b:	a3 ec 13 00 00       	mov    %eax,0x13ec
    current_group.gid = atoi(tokens[1]);
 da0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 da3:	83 ec 0c             	sub    $0xc,%esp
 da6:	50                   	push   %eax
 da7:	e8 3d f5 ff ff       	call   2e9 <atoi>
 dac:	83 c4 10             	add    $0x10,%esp
 daf:	a3 f0 13 00 00       	mov    %eax,0x13f0

    return 0;
 db4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 db9:	c9                   	leave  
 dba:	c3                   	ret    

00000dbb <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
 dbb:	f3 0f 1e fb          	endbr32 
 dbf:	55                   	push   %ebp
 dc0:	89 e5                	mov    %esp,%ebp
 dc2:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 dc5:	a1 20 14 00 00       	mov    0x1420,%eax
 dca:	85 c0                	test   %eax,%eax
 dcc:	75 31                	jne    dff <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
 dce:	83 ec 08             	sub    $0x8,%esp
 dd1:	6a 00                	push   $0x0
 dd3:	68 83 0f 00 00       	push   $0xf83
 dd8:	e8 bd f6 ff ff       	call   49a <open>
 ddd:	83 c4 10             	add    $0x10,%esp
 de0:	a3 20 14 00 00       	mov    %eax,0x1420

        if(dir < 0){        // kalau gagal membuka file
 de5:	a1 20 14 00 00       	mov    0x1420,%eax
 dea:	85 c0                	test   %eax,%eax
 dec:	79 11                	jns    dff <getgroup+0x44>
            dir = 0;
 dee:	c7 05 20 14 00 00 00 	movl   $0x0,0x1420
 df5:	00 00 00 
            return 0;
 df8:	b8 00 00 00 00       	mov    $0x0,%eax
 dfd:	eb 16                	jmp    e15 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
 dff:	e8 91 fe ff ff       	call   c95 <get_group>
 e04:	83 f8 ff             	cmp    $0xffffffff,%eax
 e07:	75 07                	jne    e10 <getgroup+0x55>
        return 0;
 e09:	b8 00 00 00 00       	mov    $0x0,%eax
 e0e:	eb 05                	jmp    e15 <getgroup+0x5a>
    
    return &current_group;
 e10:	b8 ec 13 00 00       	mov    $0x13ec,%eax
}
 e15:	c9                   	leave  
 e16:	c3                   	ret    

00000e17 <setgroup>:

// open file_ids
void setgroup(void){
 e17:	f3 0f 1e fb          	endbr32 
 e1b:	55                   	push   %ebp
 e1c:	89 e5                	mov    %esp,%ebp
 e1e:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e21:	a1 20 14 00 00       	mov    0x1420,%eax
 e26:	85 c0                	test   %eax,%eax
 e28:	74 1b                	je     e45 <setgroup+0x2e>
        close(dir);
 e2a:	a1 20 14 00 00       	mov    0x1420,%eax
 e2f:	83 ec 0c             	sub    $0xc,%esp
 e32:	50                   	push   %eax
 e33:	e8 4a f6 ff ff       	call   482 <close>
 e38:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e3b:	c7 05 20 14 00 00 00 	movl   $0x0,0x1420
 e42:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
 e45:	83 ec 08             	sub    $0x8,%esp
 e48:	6a 00                	push   $0x0
 e4a:	68 83 0f 00 00       	push   $0xf83
 e4f:	e8 46 f6 ff ff       	call   49a <open>
 e54:	83 c4 10             	add    $0x10,%esp
 e57:	a3 20 14 00 00       	mov    %eax,0x1420

    if (dir < 0)
 e5c:	a1 20 14 00 00       	mov    0x1420,%eax
 e61:	85 c0                	test   %eax,%eax
 e63:	79 0a                	jns    e6f <setgroup+0x58>
        dir = 0;
 e65:	c7 05 20 14 00 00 00 	movl   $0x0,0x1420
 e6c:	00 00 00 
}
 e6f:	90                   	nop
 e70:	c9                   	leave  
 e71:	c3                   	ret    

00000e72 <endgroup>:

// tutup file_ids
void endgroup (void){
 e72:	f3 0f 1e fb          	endbr32 
 e76:	55                   	push   %ebp
 e77:	89 e5                	mov    %esp,%ebp
 e79:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e7c:	a1 20 14 00 00       	mov    0x1420,%eax
 e81:	85 c0                	test   %eax,%eax
 e83:	74 1b                	je     ea0 <endgroup+0x2e>
        close(dir);
 e85:	a1 20 14 00 00       	mov    0x1420,%eax
 e8a:	83 ec 0c             	sub    $0xc,%esp
 e8d:	50                   	push   %eax
 e8e:	e8 ef f5 ff ff       	call   482 <close>
 e93:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 e96:	c7 05 20 14 00 00 00 	movl   $0x0,0x1420
 e9d:	00 00 00 
    }
}
 ea0:	90                   	nop
 ea1:	c9                   	leave  
 ea2:	c3                   	ret    

00000ea3 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
 ea3:	f3 0f 1e fb          	endbr32 
 ea7:	55                   	push   %ebp
 ea8:	89 e5                	mov    %esp,%ebp
 eaa:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 ead:	e8 65 ff ff ff       	call   e17 <setgroup>

    while (getgroup()){
 eb2:	eb 3c                	jmp    ef0 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
 eb4:	a1 ec 13 00 00       	mov    0x13ec,%eax
 eb9:	83 ec 08             	sub    $0x8,%esp
 ebc:	50                   	push   %eax
 ebd:	ff 75 08             	pushl  0x8(%ebp)
 ec0:	e8 29 f2 ff ff       	call   ee <strcmp>
 ec5:	83 c4 10             	add    $0x10,%esp
 ec8:	85 c0                	test   %eax,%eax
 eca:	75 24                	jne    ef0 <cek_nama_group+0x4d>
            endgroup();
 ecc:	e8 a1 ff ff ff       	call   e72 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
 ed1:	a1 ec 13 00 00       	mov    0x13ec,%eax
 ed6:	83 ec 04             	sub    $0x4,%esp
 ed9:	50                   	push   %eax
 eda:	68 8e 0f 00 00       	push   $0xf8e
 edf:	6a 01                	push   $0x1
 ee1:	e8 40 f7 ff ff       	call   626 <printf>
 ee6:	83 c4 10             	add    $0x10,%esp
            return &current_group;
 ee9:	b8 ec 13 00 00       	mov    $0x13ec,%eax
 eee:	eb 13                	jmp    f03 <cek_nama_group+0x60>
    while (getgroup()){
 ef0:	e8 c6 fe ff ff       	call   dbb <getgroup>
 ef5:	85 c0                	test   %eax,%eax
 ef7:	75 bb                	jne    eb4 <cek_nama_group+0x11>
        }
    }
    endgroup();
 ef9:	e8 74 ff ff ff       	call   e72 <endgroup>
    return 0;
 efe:	b8 00 00 00 00       	mov    $0x0,%eax
}
 f03:	c9                   	leave  
 f04:	c3                   	ret    

00000f05 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
 f05:	f3 0f 1e fb          	endbr32 
 f09:	55                   	push   %ebp
 f0a:	89 e5                	mov    %esp,%ebp
 f0c:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 f0f:	e8 03 ff ff ff       	call   e17 <setgroup>

    while (getgroup()){
 f14:	eb 16                	jmp    f2c <cek_gid+0x27>
        if(current_group.gid == gid){
 f16:	a1 f0 13 00 00       	mov    0x13f0,%eax
 f1b:	39 45 08             	cmp    %eax,0x8(%ebp)
 f1e:	75 0c                	jne    f2c <cek_gid+0x27>
            endgroup();
 f20:	e8 4d ff ff ff       	call   e72 <endgroup>
            return &current_group;
 f25:	b8 ec 13 00 00       	mov    $0x13ec,%eax
 f2a:	eb 13                	jmp    f3f <cek_gid+0x3a>
    while (getgroup()){
 f2c:	e8 8a fe ff ff       	call   dbb <getgroup>
 f31:	85 c0                	test   %eax,%eax
 f33:	75 e1                	jne    f16 <cek_gid+0x11>
        }
    }
    endgroup();
 f35:	e8 38 ff ff ff       	call   e72 <endgroup>
    return 0;
 f3a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 f3f:	c9                   	leave  
 f40:	c3                   	ret    
