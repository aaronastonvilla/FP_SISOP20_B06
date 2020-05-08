
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

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
  12:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  15:	83 ec 08             	sub    $0x8,%esp
  18:	6a 02                	push   $0x2
  1a:	68 b5 0f 00 00       	push   $0xfb5
  1f:	e8 e7 04 00 00       	call   50b <open>
  24:	83 c4 10             	add    $0x10,%esp
  27:	85 c0                	test   %eax,%eax
  29:	79 26                	jns    51 <main+0x51>
    mknod("console", 1, 1);
  2b:	83 ec 04             	sub    $0x4,%esp
  2e:	6a 01                	push   $0x1
  30:	6a 01                	push   $0x1
  32:	68 b5 0f 00 00       	push   $0xfb5
  37:	e8 d7 04 00 00       	call   513 <mknod>
  3c:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  3f:	83 ec 08             	sub    $0x8,%esp
  42:	6a 02                	push   $0x2
  44:	68 b5 0f 00 00       	push   $0xfb5
  49:	e8 bd 04 00 00       	call   50b <open>
  4e:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  51:	83 ec 0c             	sub    $0xc,%esp
  54:	6a 00                	push   $0x0
  56:	e8 e8 04 00 00       	call   543 <dup>
  5b:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  5e:	83 ec 0c             	sub    $0xc,%esp
  61:	6a 00                	push   $0x0
  63:	e8 db 04 00 00       	call   543 <dup>
  68:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  6b:	83 ec 08             	sub    $0x8,%esp
  6e:	68 bd 0f 00 00       	push   $0xfbd
  73:	6a 01                	push   $0x1
  75:	e8 1d 06 00 00       	call   697 <printf>
  7a:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  7d:	e8 41 04 00 00       	call   4c3 <fork>
  82:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  85:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  89:	79 17                	jns    a2 <main+0xa2>
      printf(1, "init: fork failed\n");
  8b:	83 ec 08             	sub    $0x8,%esp
  8e:	68 d0 0f 00 00       	push   $0xfd0
  93:	6a 01                	push   $0x1
  95:	e8 fd 05 00 00       	call   697 <printf>
  9a:	83 c4 10             	add    $0x10,%esp
      exit();
  9d:	e8 29 04 00 00       	call   4cb <exit>
    }
    if(pid == 0){
  a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  a6:	75 3e                	jne    e6 <main+0xe6>
      exec("sh", argv);
  a8:	83 ec 08             	sub    $0x8,%esp
  ab:	68 30 14 00 00       	push   $0x1430
  b0:	68 b2 0f 00 00       	push   $0xfb2
  b5:	e8 49 04 00 00       	call   503 <exec>
  ba:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  bd:	83 ec 08             	sub    $0x8,%esp
  c0:	68 e3 0f 00 00       	push   $0xfe3
  c5:	6a 01                	push   $0x1
  c7:	e8 cb 05 00 00       	call   697 <printf>
  cc:	83 c4 10             	add    $0x10,%esp
      exit();
  cf:	e8 f7 03 00 00       	call   4cb <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  d4:	83 ec 08             	sub    $0x8,%esp
  d7:	68 f9 0f 00 00       	push   $0xff9
  dc:	6a 01                	push   $0x1
  de:	e8 b4 05 00 00       	call   697 <printf>
  e3:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
  e6:	e8 e8 03 00 00       	call   4d3 <wait>
  eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  f2:	0f 88 73 ff ff ff    	js     6b <main+0x6b>
  f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  fe:	75 d4                	jne    d4 <main+0xd4>
    printf(1, "init: starting sh\n");
 100:	e9 66 ff ff ff       	jmp    6b <main+0x6b>

00000105 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 105:	55                   	push   %ebp
 106:	89 e5                	mov    %esp,%ebp
 108:	57                   	push   %edi
 109:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 10a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 10d:	8b 55 10             	mov    0x10(%ebp),%edx
 110:	8b 45 0c             	mov    0xc(%ebp),%eax
 113:	89 cb                	mov    %ecx,%ebx
 115:	89 df                	mov    %ebx,%edi
 117:	89 d1                	mov    %edx,%ecx
 119:	fc                   	cld    
 11a:	f3 aa                	rep stos %al,%es:(%edi)
 11c:	89 ca                	mov    %ecx,%edx
 11e:	89 fb                	mov    %edi,%ebx
 120:	89 5d 08             	mov    %ebx,0x8(%ebp)
 123:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 126:	90                   	nop
 127:	5b                   	pop    %ebx
 128:	5f                   	pop    %edi
 129:	5d                   	pop    %ebp
 12a:	c3                   	ret    

0000012b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 12b:	f3 0f 1e fb          	endbr32 
 12f:	55                   	push   %ebp
 130:	89 e5                	mov    %esp,%ebp
 132:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 135:	8b 45 08             	mov    0x8(%ebp),%eax
 138:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 13b:	90                   	nop
 13c:	8b 55 0c             	mov    0xc(%ebp),%edx
 13f:	8d 42 01             	lea    0x1(%edx),%eax
 142:	89 45 0c             	mov    %eax,0xc(%ebp)
 145:	8b 45 08             	mov    0x8(%ebp),%eax
 148:	8d 48 01             	lea    0x1(%eax),%ecx
 14b:	89 4d 08             	mov    %ecx,0x8(%ebp)
 14e:	0f b6 12             	movzbl (%edx),%edx
 151:	88 10                	mov    %dl,(%eax)
 153:	0f b6 00             	movzbl (%eax),%eax
 156:	84 c0                	test   %al,%al
 158:	75 e2                	jne    13c <strcpy+0x11>
    ;
  return os;
 15a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 15d:	c9                   	leave  
 15e:	c3                   	ret    

0000015f <strcmp>:

int
strcmp(const char *p, const char *q)
{
 15f:	f3 0f 1e fb          	endbr32 
 163:	55                   	push   %ebp
 164:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 166:	eb 08                	jmp    170 <strcmp+0x11>
    p++, q++;
 168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 170:	8b 45 08             	mov    0x8(%ebp),%eax
 173:	0f b6 00             	movzbl (%eax),%eax
 176:	84 c0                	test   %al,%al
 178:	74 10                	je     18a <strcmp+0x2b>
 17a:	8b 45 08             	mov    0x8(%ebp),%eax
 17d:	0f b6 10             	movzbl (%eax),%edx
 180:	8b 45 0c             	mov    0xc(%ebp),%eax
 183:	0f b6 00             	movzbl (%eax),%eax
 186:	38 c2                	cmp    %al,%dl
 188:	74 de                	je     168 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
 18a:	8b 45 08             	mov    0x8(%ebp),%eax
 18d:	0f b6 00             	movzbl (%eax),%eax
 190:	0f b6 d0             	movzbl %al,%edx
 193:	8b 45 0c             	mov    0xc(%ebp),%eax
 196:	0f b6 00             	movzbl (%eax),%eax
 199:	0f b6 c0             	movzbl %al,%eax
 19c:	29 c2                	sub    %eax,%edx
 19e:	89 d0                	mov    %edx,%eax
}
 1a0:	5d                   	pop    %ebp
 1a1:	c3                   	ret    

000001a2 <strlen>:

uint
strlen(char *s)
{
 1a2:	f3 0f 1e fb          	endbr32 
 1a6:	55                   	push   %ebp
 1a7:	89 e5                	mov    %esp,%ebp
 1a9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b3:	eb 04                	jmp    1b9 <strlen+0x17>
 1b5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1bc:	8b 45 08             	mov    0x8(%ebp),%eax
 1bf:	01 d0                	add    %edx,%eax
 1c1:	0f b6 00             	movzbl (%eax),%eax
 1c4:	84 c0                	test   %al,%al
 1c6:	75 ed                	jne    1b5 <strlen+0x13>
    ;
  return n;
 1c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1cb:	c9                   	leave  
 1cc:	c3                   	ret    

000001cd <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cd:	f3 0f 1e fb          	endbr32 
 1d1:	55                   	push   %ebp
 1d2:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1d4:	8b 45 10             	mov    0x10(%ebp),%eax
 1d7:	50                   	push   %eax
 1d8:	ff 75 0c             	pushl  0xc(%ebp)
 1db:	ff 75 08             	pushl  0x8(%ebp)
 1de:	e8 22 ff ff ff       	call   105 <stosb>
 1e3:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e9:	c9                   	leave  
 1ea:	c3                   	ret    

000001eb <strchr>:

char*
strchr(const char *s, char c)
{
 1eb:	f3 0f 1e fb          	endbr32 
 1ef:	55                   	push   %ebp
 1f0:	89 e5                	mov    %esp,%ebp
 1f2:	83 ec 04             	sub    $0x4,%esp
 1f5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1fb:	eb 14                	jmp    211 <strchr+0x26>
    if(*s == c)
 1fd:	8b 45 08             	mov    0x8(%ebp),%eax
 200:	0f b6 00             	movzbl (%eax),%eax
 203:	38 45 fc             	cmp    %al,-0x4(%ebp)
 206:	75 05                	jne    20d <strchr+0x22>
      return (char*)s;
 208:	8b 45 08             	mov    0x8(%ebp),%eax
 20b:	eb 13                	jmp    220 <strchr+0x35>
  for(; *s; s++)
 20d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 211:	8b 45 08             	mov    0x8(%ebp),%eax
 214:	0f b6 00             	movzbl (%eax),%eax
 217:	84 c0                	test   %al,%al
 219:	75 e2                	jne    1fd <strchr+0x12>
  return 0;
 21b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 220:	c9                   	leave  
 221:	c3                   	ret    

00000222 <gets>:

char*
gets(char *buf, int max)
{
 222:	f3 0f 1e fb          	endbr32 
 226:	55                   	push   %ebp
 227:	89 e5                	mov    %esp,%ebp
 229:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 22c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 233:	eb 42                	jmp    277 <gets+0x55>
    cc = read(0, &c, 1);
 235:	83 ec 04             	sub    $0x4,%esp
 238:	6a 01                	push   $0x1
 23a:	8d 45 ef             	lea    -0x11(%ebp),%eax
 23d:	50                   	push   %eax
 23e:	6a 00                	push   $0x0
 240:	e8 9e 02 00 00       	call   4e3 <read>
 245:	83 c4 10             	add    $0x10,%esp
 248:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 24b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 24f:	7e 33                	jle    284 <gets+0x62>
      break;
    buf[i++] = c;
 251:	8b 45 f4             	mov    -0xc(%ebp),%eax
 254:	8d 50 01             	lea    0x1(%eax),%edx
 257:	89 55 f4             	mov    %edx,-0xc(%ebp)
 25a:	89 c2                	mov    %eax,%edx
 25c:	8b 45 08             	mov    0x8(%ebp),%eax
 25f:	01 c2                	add    %eax,%edx
 261:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 265:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 267:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26b:	3c 0a                	cmp    $0xa,%al
 26d:	74 16                	je     285 <gets+0x63>
 26f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 273:	3c 0d                	cmp    $0xd,%al
 275:	74 0e                	je     285 <gets+0x63>
  for(i=0; i+1 < max; ){
 277:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27a:	83 c0 01             	add    $0x1,%eax
 27d:	39 45 0c             	cmp    %eax,0xc(%ebp)
 280:	7f b3                	jg     235 <gets+0x13>
 282:	eb 01                	jmp    285 <gets+0x63>
      break;
 284:	90                   	nop
      break;
  }
  buf[i] = '\0';
 285:	8b 55 f4             	mov    -0xc(%ebp),%edx
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	01 d0                	add    %edx,%eax
 28d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 290:	8b 45 08             	mov    0x8(%ebp),%eax
}
 293:	c9                   	leave  
 294:	c3                   	ret    

00000295 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
 295:	f3 0f 1e fb          	endbr32 
 299:	55                   	push   %ebp
 29a:	89 e5                	mov    %esp,%ebp
 29c:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
 29f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2a6:	eb 43                	jmp    2eb <fgets+0x56>
    int cc = read(fd, &c, 1);
 2a8:	83 ec 04             	sub    $0x4,%esp
 2ab:	6a 01                	push   $0x1
 2ad:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2b0:	50                   	push   %eax
 2b1:	ff 75 10             	pushl  0x10(%ebp)
 2b4:	e8 2a 02 00 00       	call   4e3 <read>
 2b9:	83 c4 10             	add    $0x10,%esp
 2bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2c3:	7e 33                	jle    2f8 <fgets+0x63>
      break;
    buf[i++] = c;
 2c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2c8:	8d 50 01             	lea    0x1(%eax),%edx
 2cb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2ce:	89 c2                	mov    %eax,%edx
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
 2d3:	01 c2                	add    %eax,%edx
 2d5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2d9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2db:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2df:	3c 0a                	cmp    $0xa,%al
 2e1:	74 16                	je     2f9 <fgets+0x64>
 2e3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2e7:	3c 0d                	cmp    $0xd,%al
 2e9:	74 0e                	je     2f9 <fgets+0x64>
  for(i = 0; i + 1 < size;){
 2eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2ee:	83 c0 01             	add    $0x1,%eax
 2f1:	39 45 0c             	cmp    %eax,0xc(%ebp)
 2f4:	7f b2                	jg     2a8 <fgets+0x13>
 2f6:	eb 01                	jmp    2f9 <fgets+0x64>
      break;
 2f8:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2fc:	8b 45 08             	mov    0x8(%ebp),%eax
 2ff:	01 d0                	add    %edx,%eax
 301:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 304:	8b 45 08             	mov    0x8(%ebp),%eax
}
 307:	c9                   	leave  
 308:	c3                   	ret    

00000309 <stat>:

int
stat(char *n, struct stat *st)
{
 309:	f3 0f 1e fb          	endbr32 
 30d:	55                   	push   %ebp
 30e:	89 e5                	mov    %esp,%ebp
 310:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 313:	83 ec 08             	sub    $0x8,%esp
 316:	6a 00                	push   $0x0
 318:	ff 75 08             	pushl  0x8(%ebp)
 31b:	e8 eb 01 00 00       	call   50b <open>
 320:	83 c4 10             	add    $0x10,%esp
 323:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 326:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 32a:	79 07                	jns    333 <stat+0x2a>
    return -1;
 32c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 331:	eb 25                	jmp    358 <stat+0x4f>
  r = fstat(fd, st);
 333:	83 ec 08             	sub    $0x8,%esp
 336:	ff 75 0c             	pushl  0xc(%ebp)
 339:	ff 75 f4             	pushl  -0xc(%ebp)
 33c:	e8 e2 01 00 00       	call   523 <fstat>
 341:	83 c4 10             	add    $0x10,%esp
 344:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 347:	83 ec 0c             	sub    $0xc,%esp
 34a:	ff 75 f4             	pushl  -0xc(%ebp)
 34d:	e8 a1 01 00 00       	call   4f3 <close>
 352:	83 c4 10             	add    $0x10,%esp
  return r;
 355:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 358:	c9                   	leave  
 359:	c3                   	ret    

0000035a <atoi>:

int
atoi(const char *s)
{
 35a:	f3 0f 1e fb          	endbr32 
 35e:	55                   	push   %ebp
 35f:	89 e5                	mov    %esp,%ebp
 361:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 364:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 36b:	eb 04                	jmp    371 <atoi+0x17>
 36d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 371:	8b 45 08             	mov    0x8(%ebp),%eax
 374:	0f b6 00             	movzbl (%eax),%eax
 377:	3c 20                	cmp    $0x20,%al
 379:	74 f2                	je     36d <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
 37b:	8b 45 08             	mov    0x8(%ebp),%eax
 37e:	0f b6 00             	movzbl (%eax),%eax
 381:	3c 2d                	cmp    $0x2d,%al
 383:	75 07                	jne    38c <atoi+0x32>
 385:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 38a:	eb 05                	jmp    391 <atoi+0x37>
 38c:	b8 01 00 00 00       	mov    $0x1,%eax
 391:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 394:	8b 45 08             	mov    0x8(%ebp),%eax
 397:	0f b6 00             	movzbl (%eax),%eax
 39a:	3c 2b                	cmp    $0x2b,%al
 39c:	74 0a                	je     3a8 <atoi+0x4e>
 39e:	8b 45 08             	mov    0x8(%ebp),%eax
 3a1:	0f b6 00             	movzbl (%eax),%eax
 3a4:	3c 2d                	cmp    $0x2d,%al
 3a6:	75 2b                	jne    3d3 <atoi+0x79>
    s++;
 3a8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 3ac:	eb 25                	jmp    3d3 <atoi+0x79>
    n = n*10 + *s++ - '0';
 3ae:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3b1:	89 d0                	mov    %edx,%eax
 3b3:	c1 e0 02             	shl    $0x2,%eax
 3b6:	01 d0                	add    %edx,%eax
 3b8:	01 c0                	add    %eax,%eax
 3ba:	89 c1                	mov    %eax,%ecx
 3bc:	8b 45 08             	mov    0x8(%ebp),%eax
 3bf:	8d 50 01             	lea    0x1(%eax),%edx
 3c2:	89 55 08             	mov    %edx,0x8(%ebp)
 3c5:	0f b6 00             	movzbl (%eax),%eax
 3c8:	0f be c0             	movsbl %al,%eax
 3cb:	01 c8                	add    %ecx,%eax
 3cd:	83 e8 30             	sub    $0x30,%eax
 3d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3d3:	8b 45 08             	mov    0x8(%ebp),%eax
 3d6:	0f b6 00             	movzbl (%eax),%eax
 3d9:	3c 2f                	cmp    $0x2f,%al
 3db:	7e 0a                	jle    3e7 <atoi+0x8d>
 3dd:	8b 45 08             	mov    0x8(%ebp),%eax
 3e0:	0f b6 00             	movzbl (%eax),%eax
 3e3:	3c 39                	cmp    $0x39,%al
 3e5:	7e c7                	jle    3ae <atoi+0x54>
  return sign*n;
 3e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3ea:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 3ee:	c9                   	leave  
 3ef:	c3                   	ret    

000003f0 <atoo>:

int
atoo(const char *s)
{
 3f0:	f3 0f 1e fb          	endbr32 
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 3fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 401:	eb 04                	jmp    407 <atoo+0x17>
 403:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 407:	8b 45 08             	mov    0x8(%ebp),%eax
 40a:	0f b6 00             	movzbl (%eax),%eax
 40d:	3c 20                	cmp    $0x20,%al
 40f:	74 f2                	je     403 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
 411:	8b 45 08             	mov    0x8(%ebp),%eax
 414:	0f b6 00             	movzbl (%eax),%eax
 417:	3c 2d                	cmp    $0x2d,%al
 419:	75 07                	jne    422 <atoo+0x32>
 41b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 420:	eb 05                	jmp    427 <atoo+0x37>
 422:	b8 01 00 00 00       	mov    $0x1,%eax
 427:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 42a:	8b 45 08             	mov    0x8(%ebp),%eax
 42d:	0f b6 00             	movzbl (%eax),%eax
 430:	3c 2b                	cmp    $0x2b,%al
 432:	74 0a                	je     43e <atoo+0x4e>
 434:	8b 45 08             	mov    0x8(%ebp),%eax
 437:	0f b6 00             	movzbl (%eax),%eax
 43a:	3c 2d                	cmp    $0x2d,%al
 43c:	75 27                	jne    465 <atoo+0x75>
    s++;
 43e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 442:	eb 21                	jmp    465 <atoo+0x75>
    n = n*8 + *s++ - '0';
 444:	8b 45 fc             	mov    -0x4(%ebp),%eax
 447:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 44e:	8b 45 08             	mov    0x8(%ebp),%eax
 451:	8d 50 01             	lea    0x1(%eax),%edx
 454:	89 55 08             	mov    %edx,0x8(%ebp)
 457:	0f b6 00             	movzbl (%eax),%eax
 45a:	0f be c0             	movsbl %al,%eax
 45d:	01 c8                	add    %ecx,%eax
 45f:	83 e8 30             	sub    $0x30,%eax
 462:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
 465:	8b 45 08             	mov    0x8(%ebp),%eax
 468:	0f b6 00             	movzbl (%eax),%eax
 46b:	3c 2f                	cmp    $0x2f,%al
 46d:	7e 0a                	jle    479 <atoo+0x89>
 46f:	8b 45 08             	mov    0x8(%ebp),%eax
 472:	0f b6 00             	movzbl (%eax),%eax
 475:	3c 37                	cmp    $0x37,%al
 477:	7e cb                	jle    444 <atoo+0x54>
  return sign*n;
 479:	8b 45 f8             	mov    -0x8(%ebp),%eax
 47c:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 480:	c9                   	leave  
 481:	c3                   	ret    

00000482 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 482:	f3 0f 1e fb          	endbr32 
 486:	55                   	push   %ebp
 487:	89 e5                	mov    %esp,%ebp
 489:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 48c:	8b 45 08             	mov    0x8(%ebp),%eax
 48f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 492:	8b 45 0c             	mov    0xc(%ebp),%eax
 495:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 498:	eb 17                	jmp    4b1 <memmove+0x2f>
    *dst++ = *src++;
 49a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 49d:	8d 42 01             	lea    0x1(%edx),%eax
 4a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
 4a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 4a6:	8d 48 01             	lea    0x1(%eax),%ecx
 4a9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 4ac:	0f b6 12             	movzbl (%edx),%edx
 4af:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 4b1:	8b 45 10             	mov    0x10(%ebp),%eax
 4b4:	8d 50 ff             	lea    -0x1(%eax),%edx
 4b7:	89 55 10             	mov    %edx,0x10(%ebp)
 4ba:	85 c0                	test   %eax,%eax
 4bc:	7f dc                	jg     49a <memmove+0x18>
  return vdst;
 4be:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4c1:	c9                   	leave  
 4c2:	c3                   	ret    

000004c3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4c3:	b8 01 00 00 00       	mov    $0x1,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <exit>:
SYSCALL(exit)
 4cb:	b8 02 00 00 00       	mov    $0x2,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <wait>:
SYSCALL(wait)
 4d3:	b8 03 00 00 00       	mov    $0x3,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <pipe>:
SYSCALL(pipe)
 4db:	b8 04 00 00 00       	mov    $0x4,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <read>:
SYSCALL(read)
 4e3:	b8 05 00 00 00       	mov    $0x5,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <write>:
SYSCALL(write)
 4eb:	b8 10 00 00 00       	mov    $0x10,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <close>:
SYSCALL(close)
 4f3:	b8 15 00 00 00       	mov    $0x15,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <kill>:
SYSCALL(kill)
 4fb:	b8 06 00 00 00       	mov    $0x6,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <exec>:
SYSCALL(exec)
 503:	b8 07 00 00 00       	mov    $0x7,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <open>:
SYSCALL(open)
 50b:	b8 0f 00 00 00       	mov    $0xf,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <mknod>:
SYSCALL(mknod)
 513:	b8 11 00 00 00       	mov    $0x11,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <unlink>:
SYSCALL(unlink)
 51b:	b8 12 00 00 00       	mov    $0x12,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <fstat>:
SYSCALL(fstat)
 523:	b8 08 00 00 00       	mov    $0x8,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <link>:
SYSCALL(link)
 52b:	b8 13 00 00 00       	mov    $0x13,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <mkdir>:
SYSCALL(mkdir)
 533:	b8 14 00 00 00       	mov    $0x14,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <chdir>:
SYSCALL(chdir)
 53b:	b8 09 00 00 00       	mov    $0x9,%eax
 540:	cd 40                	int    $0x40
 542:	c3                   	ret    

00000543 <dup>:
SYSCALL(dup)
 543:	b8 0a 00 00 00       	mov    $0xa,%eax
 548:	cd 40                	int    $0x40
 54a:	c3                   	ret    

0000054b <getpid>:
SYSCALL(getpid)
 54b:	b8 0b 00 00 00       	mov    $0xb,%eax
 550:	cd 40                	int    $0x40
 552:	c3                   	ret    

00000553 <sbrk>:
SYSCALL(sbrk)
 553:	b8 0c 00 00 00       	mov    $0xc,%eax
 558:	cd 40                	int    $0x40
 55a:	c3                   	ret    

0000055b <sleep>:
SYSCALL(sleep)
 55b:	b8 0d 00 00 00       	mov    $0xd,%eax
 560:	cd 40                	int    $0x40
 562:	c3                   	ret    

00000563 <uptime>:
SYSCALL(uptime)
 563:	b8 0e 00 00 00       	mov    $0xe,%eax
 568:	cd 40                	int    $0x40
 56a:	c3                   	ret    

0000056b <halt>:
SYSCALL(halt)
 56b:	b8 16 00 00 00       	mov    $0x16,%eax
 570:	cd 40                	int    $0x40
 572:	c3                   	ret    

00000573 <date>:
SYSCALL(date)
 573:	b8 17 00 00 00       	mov    $0x17,%eax
 578:	cd 40                	int    $0x40
 57a:	c3                   	ret    

0000057b <getuid>:
SYSCALL(getuid)
 57b:	b8 18 00 00 00       	mov    $0x18,%eax
 580:	cd 40                	int    $0x40
 582:	c3                   	ret    

00000583 <getgid>:
SYSCALL(getgid)
 583:	b8 19 00 00 00       	mov    $0x19,%eax
 588:	cd 40                	int    $0x40
 58a:	c3                   	ret    

0000058b <getppid>:
SYSCALL(getppid)
 58b:	b8 1a 00 00 00       	mov    $0x1a,%eax
 590:	cd 40                	int    $0x40
 592:	c3                   	ret    

00000593 <setuid>:
SYSCALL(setuid)
 593:	b8 1b 00 00 00       	mov    $0x1b,%eax
 598:	cd 40                	int    $0x40
 59a:	c3                   	ret    

0000059b <setgid>:
SYSCALL(setgid)
 59b:	b8 1c 00 00 00       	mov    $0x1c,%eax
 5a0:	cd 40                	int    $0x40
 5a2:	c3                   	ret    

000005a3 <getprocs>:
SYSCALL(getprocs)
 5a3:	b8 1d 00 00 00       	mov    $0x1d,%eax
 5a8:	cd 40                	int    $0x40
 5aa:	c3                   	ret    

000005ab <setpriority>:
SYSCALL(setpriority)
 5ab:	b8 1e 00 00 00       	mov    $0x1e,%eax
 5b0:	cd 40                	int    $0x40
 5b2:	c3                   	ret    

000005b3 <chown>:
SYSCALL(chown)
 5b3:	b8 1f 00 00 00       	mov    $0x1f,%eax
 5b8:	cd 40                	int    $0x40
 5ba:	c3                   	ret    

000005bb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5bb:	f3 0f 1e fb          	endbr32 
 5bf:	55                   	push   %ebp
 5c0:	89 e5                	mov    %esp,%ebp
 5c2:	83 ec 18             	sub    $0x18,%esp
 5c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 5c8:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5cb:	83 ec 04             	sub    $0x4,%esp
 5ce:	6a 01                	push   $0x1
 5d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5d3:	50                   	push   %eax
 5d4:	ff 75 08             	pushl  0x8(%ebp)
 5d7:	e8 0f ff ff ff       	call   4eb <write>
 5dc:	83 c4 10             	add    $0x10,%esp
}
 5df:	90                   	nop
 5e0:	c9                   	leave  
 5e1:	c3                   	ret    

000005e2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5e2:	f3 0f 1e fb          	endbr32 
 5e6:	55                   	push   %ebp
 5e7:	89 e5                	mov    %esp,%ebp
 5e9:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 5f3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 5f7:	74 17                	je     610 <printint+0x2e>
 5f9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 5fd:	79 11                	jns    610 <printint+0x2e>
    neg = 1;
 5ff:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 606:	8b 45 0c             	mov    0xc(%ebp),%eax
 609:	f7 d8                	neg    %eax
 60b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 60e:	eb 06                	jmp    616 <printint+0x34>
  } else {
    x = xx;
 610:	8b 45 0c             	mov    0xc(%ebp),%eax
 613:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 616:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 61d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 620:	8b 45 ec             	mov    -0x14(%ebp),%eax
 623:	ba 00 00 00 00       	mov    $0x0,%edx
 628:	f7 f1                	div    %ecx
 62a:	89 d1                	mov    %edx,%ecx
 62c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 62f:	8d 50 01             	lea    0x1(%eax),%edx
 632:	89 55 f4             	mov    %edx,-0xc(%ebp)
 635:	0f b6 91 38 14 00 00 	movzbl 0x1438(%ecx),%edx
 63c:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 640:	8b 4d 10             	mov    0x10(%ebp),%ecx
 643:	8b 45 ec             	mov    -0x14(%ebp),%eax
 646:	ba 00 00 00 00       	mov    $0x0,%edx
 64b:	f7 f1                	div    %ecx
 64d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 650:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 654:	75 c7                	jne    61d <printint+0x3b>
  if(neg)
 656:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 65a:	74 2d                	je     689 <printint+0xa7>
    buf[i++] = '-';
 65c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 65f:	8d 50 01             	lea    0x1(%eax),%edx
 662:	89 55 f4             	mov    %edx,-0xc(%ebp)
 665:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 66a:	eb 1d                	jmp    689 <printint+0xa7>
    putc(fd, buf[i]);
 66c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 66f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 672:	01 d0                	add    %edx,%eax
 674:	0f b6 00             	movzbl (%eax),%eax
 677:	0f be c0             	movsbl %al,%eax
 67a:	83 ec 08             	sub    $0x8,%esp
 67d:	50                   	push   %eax
 67e:	ff 75 08             	pushl  0x8(%ebp)
 681:	e8 35 ff ff ff       	call   5bb <putc>
 686:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 689:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 68d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 691:	79 d9                	jns    66c <printint+0x8a>
}
 693:	90                   	nop
 694:	90                   	nop
 695:	c9                   	leave  
 696:	c3                   	ret    

00000697 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 697:	f3 0f 1e fb          	endbr32 
 69b:	55                   	push   %ebp
 69c:	89 e5                	mov    %esp,%ebp
 69e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6a8:	8d 45 0c             	lea    0xc(%ebp),%eax
 6ab:	83 c0 04             	add    $0x4,%eax
 6ae:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 6b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6b8:	e9 59 01 00 00       	jmp    816 <printf+0x17f>
    c = fmt[i] & 0xff;
 6bd:	8b 55 0c             	mov    0xc(%ebp),%edx
 6c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c3:	01 d0                	add    %edx,%eax
 6c5:	0f b6 00             	movzbl (%eax),%eax
 6c8:	0f be c0             	movsbl %al,%eax
 6cb:	25 ff 00 00 00       	and    $0xff,%eax
 6d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6d7:	75 2c                	jne    705 <printf+0x6e>
      if(c == '%'){
 6d9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6dd:	75 0c                	jne    6eb <printf+0x54>
        state = '%';
 6df:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6e6:	e9 27 01 00 00       	jmp    812 <printf+0x17b>
      } else {
        putc(fd, c);
 6eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6ee:	0f be c0             	movsbl %al,%eax
 6f1:	83 ec 08             	sub    $0x8,%esp
 6f4:	50                   	push   %eax
 6f5:	ff 75 08             	pushl  0x8(%ebp)
 6f8:	e8 be fe ff ff       	call   5bb <putc>
 6fd:	83 c4 10             	add    $0x10,%esp
 700:	e9 0d 01 00 00       	jmp    812 <printf+0x17b>
      }
    } else if(state == '%'){
 705:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 709:	0f 85 03 01 00 00    	jne    812 <printf+0x17b>
      if(c == 'd'){
 70f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 713:	75 1e                	jne    733 <printf+0x9c>
        printint(fd, *ap, 10, 1);
 715:	8b 45 e8             	mov    -0x18(%ebp),%eax
 718:	8b 00                	mov    (%eax),%eax
 71a:	6a 01                	push   $0x1
 71c:	6a 0a                	push   $0xa
 71e:	50                   	push   %eax
 71f:	ff 75 08             	pushl  0x8(%ebp)
 722:	e8 bb fe ff ff       	call   5e2 <printint>
 727:	83 c4 10             	add    $0x10,%esp
        ap++;
 72a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 72e:	e9 d8 00 00 00       	jmp    80b <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 733:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 737:	74 06                	je     73f <printf+0xa8>
 739:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 73d:	75 1e                	jne    75d <printf+0xc6>
        printint(fd, *ap, 16, 0);
 73f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 742:	8b 00                	mov    (%eax),%eax
 744:	6a 00                	push   $0x0
 746:	6a 10                	push   $0x10
 748:	50                   	push   %eax
 749:	ff 75 08             	pushl  0x8(%ebp)
 74c:	e8 91 fe ff ff       	call   5e2 <printint>
 751:	83 c4 10             	add    $0x10,%esp
        ap++;
 754:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 758:	e9 ae 00 00 00       	jmp    80b <printf+0x174>
      } else if(c == 's'){
 75d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 761:	75 43                	jne    7a6 <printf+0x10f>
        s = (char*)*ap;
 763:	8b 45 e8             	mov    -0x18(%ebp),%eax
 766:	8b 00                	mov    (%eax),%eax
 768:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 76b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 76f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 773:	75 25                	jne    79a <printf+0x103>
          s = "(null)";
 775:	c7 45 f4 02 10 00 00 	movl   $0x1002,-0xc(%ebp)
        while(*s != 0){
 77c:	eb 1c                	jmp    79a <printf+0x103>
          putc(fd, *s);
 77e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 781:	0f b6 00             	movzbl (%eax),%eax
 784:	0f be c0             	movsbl %al,%eax
 787:	83 ec 08             	sub    $0x8,%esp
 78a:	50                   	push   %eax
 78b:	ff 75 08             	pushl  0x8(%ebp)
 78e:	e8 28 fe ff ff       	call   5bb <putc>
 793:	83 c4 10             	add    $0x10,%esp
          s++;
 796:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79d:	0f b6 00             	movzbl (%eax),%eax
 7a0:	84 c0                	test   %al,%al
 7a2:	75 da                	jne    77e <printf+0xe7>
 7a4:	eb 65                	jmp    80b <printf+0x174>
        }
      } else if(c == 'c'){
 7a6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7aa:	75 1d                	jne    7c9 <printf+0x132>
        putc(fd, *ap);
 7ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7af:	8b 00                	mov    (%eax),%eax
 7b1:	0f be c0             	movsbl %al,%eax
 7b4:	83 ec 08             	sub    $0x8,%esp
 7b7:	50                   	push   %eax
 7b8:	ff 75 08             	pushl  0x8(%ebp)
 7bb:	e8 fb fd ff ff       	call   5bb <putc>
 7c0:	83 c4 10             	add    $0x10,%esp
        ap++;
 7c3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7c7:	eb 42                	jmp    80b <printf+0x174>
      } else if(c == '%'){
 7c9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7cd:	75 17                	jne    7e6 <printf+0x14f>
        putc(fd, c);
 7cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7d2:	0f be c0             	movsbl %al,%eax
 7d5:	83 ec 08             	sub    $0x8,%esp
 7d8:	50                   	push   %eax
 7d9:	ff 75 08             	pushl  0x8(%ebp)
 7dc:	e8 da fd ff ff       	call   5bb <putc>
 7e1:	83 c4 10             	add    $0x10,%esp
 7e4:	eb 25                	jmp    80b <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7e6:	83 ec 08             	sub    $0x8,%esp
 7e9:	6a 25                	push   $0x25
 7eb:	ff 75 08             	pushl  0x8(%ebp)
 7ee:	e8 c8 fd ff ff       	call   5bb <putc>
 7f3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 7f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7f9:	0f be c0             	movsbl %al,%eax
 7fc:	83 ec 08             	sub    $0x8,%esp
 7ff:	50                   	push   %eax
 800:	ff 75 08             	pushl  0x8(%ebp)
 803:	e8 b3 fd ff ff       	call   5bb <putc>
 808:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 80b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 812:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 816:	8b 55 0c             	mov    0xc(%ebp),%edx
 819:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81c:	01 d0                	add    %edx,%eax
 81e:	0f b6 00             	movzbl (%eax),%eax
 821:	84 c0                	test   %al,%al
 823:	0f 85 94 fe ff ff    	jne    6bd <printf+0x26>
    }
  }
}
 829:	90                   	nop
 82a:	90                   	nop
 82b:	c9                   	leave  
 82c:	c3                   	ret    

0000082d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 82d:	f3 0f 1e fb          	endbr32 
 831:	55                   	push   %ebp
 832:	89 e5                	mov    %esp,%ebp
 834:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 837:	8b 45 08             	mov    0x8(%ebp),%eax
 83a:	83 e8 08             	sub    $0x8,%eax
 83d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 840:	a1 68 14 00 00       	mov    0x1468,%eax
 845:	89 45 fc             	mov    %eax,-0x4(%ebp)
 848:	eb 24                	jmp    86e <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 84a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84d:	8b 00                	mov    (%eax),%eax
 84f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 852:	72 12                	jb     866 <free+0x39>
 854:	8b 45 f8             	mov    -0x8(%ebp),%eax
 857:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 85a:	77 24                	ja     880 <free+0x53>
 85c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85f:	8b 00                	mov    (%eax),%eax
 861:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 864:	72 1a                	jb     880 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 866:	8b 45 fc             	mov    -0x4(%ebp),%eax
 869:	8b 00                	mov    (%eax),%eax
 86b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 86e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 871:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 874:	76 d4                	jbe    84a <free+0x1d>
 876:	8b 45 fc             	mov    -0x4(%ebp),%eax
 879:	8b 00                	mov    (%eax),%eax
 87b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 87e:	73 ca                	jae    84a <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 880:	8b 45 f8             	mov    -0x8(%ebp),%eax
 883:	8b 40 04             	mov    0x4(%eax),%eax
 886:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 88d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 890:	01 c2                	add    %eax,%edx
 892:	8b 45 fc             	mov    -0x4(%ebp),%eax
 895:	8b 00                	mov    (%eax),%eax
 897:	39 c2                	cmp    %eax,%edx
 899:	75 24                	jne    8bf <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 89b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89e:	8b 50 04             	mov    0x4(%eax),%edx
 8a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a4:	8b 00                	mov    (%eax),%eax
 8a6:	8b 40 04             	mov    0x4(%eax),%eax
 8a9:	01 c2                	add    %eax,%edx
 8ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ae:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b4:	8b 00                	mov    (%eax),%eax
 8b6:	8b 10                	mov    (%eax),%edx
 8b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8bb:	89 10                	mov    %edx,(%eax)
 8bd:	eb 0a                	jmp    8c9 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 8bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c2:	8b 10                	mov    (%eax),%edx
 8c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c7:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8cc:	8b 40 04             	mov    0x4(%eax),%eax
 8cf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d9:	01 d0                	add    %edx,%eax
 8db:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 8de:	75 20                	jne    900 <free+0xd3>
    p->s.size += bp->s.size;
 8e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e3:	8b 50 04             	mov    0x4(%eax),%edx
 8e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e9:	8b 40 04             	mov    0x4(%eax),%eax
 8ec:	01 c2                	add    %eax,%edx
 8ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f7:	8b 10                	mov    (%eax),%edx
 8f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fc:	89 10                	mov    %edx,(%eax)
 8fe:	eb 08                	jmp    908 <free+0xdb>
  } else
    p->s.ptr = bp;
 900:	8b 45 fc             	mov    -0x4(%ebp),%eax
 903:	8b 55 f8             	mov    -0x8(%ebp),%edx
 906:	89 10                	mov    %edx,(%eax)
  freep = p;
 908:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90b:	a3 68 14 00 00       	mov    %eax,0x1468
}
 910:	90                   	nop
 911:	c9                   	leave  
 912:	c3                   	ret    

00000913 <morecore>:

static Header*
morecore(uint nu)
{
 913:	f3 0f 1e fb          	endbr32 
 917:	55                   	push   %ebp
 918:	89 e5                	mov    %esp,%ebp
 91a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 91d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 924:	77 07                	ja     92d <morecore+0x1a>
    nu = 4096;
 926:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 92d:	8b 45 08             	mov    0x8(%ebp),%eax
 930:	c1 e0 03             	shl    $0x3,%eax
 933:	83 ec 0c             	sub    $0xc,%esp
 936:	50                   	push   %eax
 937:	e8 17 fc ff ff       	call   553 <sbrk>
 93c:	83 c4 10             	add    $0x10,%esp
 93f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 942:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 946:	75 07                	jne    94f <morecore+0x3c>
    return 0;
 948:	b8 00 00 00 00       	mov    $0x0,%eax
 94d:	eb 26                	jmp    975 <morecore+0x62>
  hp = (Header*)p;
 94f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 952:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 955:	8b 45 f0             	mov    -0x10(%ebp),%eax
 958:	8b 55 08             	mov    0x8(%ebp),%edx
 95b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 95e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 961:	83 c0 08             	add    $0x8,%eax
 964:	83 ec 0c             	sub    $0xc,%esp
 967:	50                   	push   %eax
 968:	e8 c0 fe ff ff       	call   82d <free>
 96d:	83 c4 10             	add    $0x10,%esp
  return freep;
 970:	a1 68 14 00 00       	mov    0x1468,%eax
}
 975:	c9                   	leave  
 976:	c3                   	ret    

00000977 <malloc>:

void*
malloc(uint nbytes)
{
 977:	f3 0f 1e fb          	endbr32 
 97b:	55                   	push   %ebp
 97c:	89 e5                	mov    %esp,%ebp
 97e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 981:	8b 45 08             	mov    0x8(%ebp),%eax
 984:	83 c0 07             	add    $0x7,%eax
 987:	c1 e8 03             	shr    $0x3,%eax
 98a:	83 c0 01             	add    $0x1,%eax
 98d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 990:	a1 68 14 00 00       	mov    0x1468,%eax
 995:	89 45 f0             	mov    %eax,-0x10(%ebp)
 998:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 99c:	75 23                	jne    9c1 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 99e:	c7 45 f0 60 14 00 00 	movl   $0x1460,-0x10(%ebp)
 9a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9a8:	a3 68 14 00 00       	mov    %eax,0x1468
 9ad:	a1 68 14 00 00       	mov    0x1468,%eax
 9b2:	a3 60 14 00 00       	mov    %eax,0x1460
    base.s.size = 0;
 9b7:	c7 05 64 14 00 00 00 	movl   $0x0,0x1464
 9be:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9c4:	8b 00                	mov    (%eax),%eax
 9c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9cc:	8b 40 04             	mov    0x4(%eax),%eax
 9cf:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 9d2:	77 4d                	ja     a21 <malloc+0xaa>
      if(p->s.size == nunits)
 9d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d7:	8b 40 04             	mov    0x4(%eax),%eax
 9da:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 9dd:	75 0c                	jne    9eb <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 9df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e2:	8b 10                	mov    (%eax),%edx
 9e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9e7:	89 10                	mov    %edx,(%eax)
 9e9:	eb 26                	jmp    a11 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 9eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ee:	8b 40 04             	mov    0x4(%eax),%eax
 9f1:	2b 45 ec             	sub    -0x14(%ebp),%eax
 9f4:	89 c2                	mov    %eax,%edx
 9f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 9fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ff:	8b 40 04             	mov    0x4(%eax),%eax
 a02:	c1 e0 03             	shl    $0x3,%eax
 a05:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a0e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a11:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a14:	a3 68 14 00 00       	mov    %eax,0x1468
      return (void*)(p + 1);
 a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1c:	83 c0 08             	add    $0x8,%eax
 a1f:	eb 3b                	jmp    a5c <malloc+0xe5>
    }
    if(p == freep)
 a21:	a1 68 14 00 00       	mov    0x1468,%eax
 a26:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a29:	75 1e                	jne    a49 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 a2b:	83 ec 0c             	sub    $0xc,%esp
 a2e:	ff 75 ec             	pushl  -0x14(%ebp)
 a31:	e8 dd fe ff ff       	call   913 <morecore>
 a36:	83 c4 10             	add    $0x10,%esp
 a39:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a3c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a40:	75 07                	jne    a49 <malloc+0xd2>
        return 0;
 a42:	b8 00 00 00 00       	mov    $0x0,%eax
 a47:	eb 13                	jmp    a5c <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a52:	8b 00                	mov    (%eax),%eax
 a54:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a57:	e9 6d ff ff ff       	jmp    9c9 <malloc+0x52>
  }
}
 a5c:	c9                   	leave  
 a5d:	c3                   	ret    

00000a5e <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
 a5e:	f3 0f 1e fb          	endbr32 
 a62:	55                   	push   %ebp
 a63:	89 e5                	mov    %esp,%ebp
 a65:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 a68:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 a6f:	a1 c0 14 00 00       	mov    0x14c0,%eax
 a74:	83 ec 04             	sub    $0x4,%esp
 a77:	50                   	push   %eax
 a78:	6a 20                	push   $0x20
 a7a:	68 a0 14 00 00       	push   $0x14a0
 a7f:	e8 11 f8 ff ff       	call   295 <fgets>
 a84:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 a87:	83 ec 0c             	sub    $0xc,%esp
 a8a:	68 a0 14 00 00       	push   $0x14a0
 a8f:	e8 0e f7 ff ff       	call   1a2 <strlen>
 a94:	83 c4 10             	add    $0x10,%esp
 a97:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 a9a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 a9d:	83 e8 01             	sub    $0x1,%eax
 aa0:	0f b6 80 a0 14 00 00 	movzbl 0x14a0(%eax),%eax
 aa7:	3c 0a                	cmp    $0xa,%al
 aa9:	74 11                	je     abc <get_id+0x5e>
 aab:	8b 45 e8             	mov    -0x18(%ebp),%eax
 aae:	83 e8 01             	sub    $0x1,%eax
 ab1:	0f b6 80 a0 14 00 00 	movzbl 0x14a0(%eax),%eax
 ab8:	3c 0d                	cmp    $0xd,%al
 aba:	75 0d                	jne    ac9 <get_id+0x6b>
        current_line[len - 1] = 0;
 abc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 abf:	83 e8 01             	sub    $0x1,%eax
 ac2:	c6 80 a0 14 00 00 00 	movb   $0x0,0x14a0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 ac9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 ad0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 ad7:	eb 6c                	jmp    b45 <get_id+0xe7>
        if(current_line[i] == ' '){
 ad9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 adc:	05 a0 14 00 00       	add    $0x14a0,%eax
 ae1:	0f b6 00             	movzbl (%eax),%eax
 ae4:	3c 20                	cmp    $0x20,%al
 ae6:	75 30                	jne    b18 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 ae8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 aec:	75 16                	jne    b04 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 aee:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 af1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 af4:	8d 50 01             	lea    0x1(%eax),%edx
 af7:	89 55 f0             	mov    %edx,-0x10(%ebp)
 afa:	8d 91 a0 14 00 00    	lea    0x14a0(%ecx),%edx
 b00:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 b04:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b07:	05 a0 14 00 00       	add    $0x14a0,%eax
 b0c:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 b0f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 b16:	eb 29                	jmp    b41 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 b18:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b1c:	75 23                	jne    b41 <get_id+0xe3>
 b1e:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 b22:	7f 1d                	jg     b41 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 b24:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 b2b:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 b2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b31:	8d 50 01             	lea    0x1(%eax),%edx
 b34:	89 55 f0             	mov    %edx,-0x10(%ebp)
 b37:	8d 91 a0 14 00 00    	lea    0x14a0(%ecx),%edx
 b3d:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 b41:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 b45:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b48:	05 a0 14 00 00       	add    $0x14a0,%eax
 b4d:	0f b6 00             	movzbl (%eax),%eax
 b50:	84 c0                	test   %al,%al
 b52:	75 85                	jne    ad9 <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 b54:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 b58:	75 07                	jne    b61 <get_id+0x103>
        return -1;
 b5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b5f:	eb 35                	jmp    b96 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
 b61:	8b 45 dc             	mov    -0x24(%ebp),%eax
 b64:	a3 80 14 00 00       	mov    %eax,0x1480
    current_id.uid_user = atoi(tokens[1]);
 b69:	8b 45 e0             	mov    -0x20(%ebp),%eax
 b6c:	83 ec 0c             	sub    $0xc,%esp
 b6f:	50                   	push   %eax
 b70:	e8 e5 f7 ff ff       	call   35a <atoi>
 b75:	83 c4 10             	add    $0x10,%esp
 b78:	a3 84 14 00 00       	mov    %eax,0x1484
    current_id.gid_user = atoi(tokens[2]);
 b7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 b80:	83 ec 0c             	sub    $0xc,%esp
 b83:	50                   	push   %eax
 b84:	e8 d1 f7 ff ff       	call   35a <atoi>
 b89:	83 c4 10             	add    $0x10,%esp
 b8c:	a3 88 14 00 00       	mov    %eax,0x1488

    return 0;
 b91:	b8 00 00 00 00       	mov    $0x0,%eax
}
 b96:	c9                   	leave  
 b97:	c3                   	ret    

00000b98 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
 b98:	f3 0f 1e fb          	endbr32 
 b9c:	55                   	push   %ebp
 b9d:	89 e5                	mov    %esp,%ebp
 b9f:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 ba2:	a1 c0 14 00 00       	mov    0x14c0,%eax
 ba7:	85 c0                	test   %eax,%eax
 ba9:	75 31                	jne    bdc <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
 bab:	83 ec 08             	sub    $0x8,%esp
 bae:	6a 00                	push   $0x0
 bb0:	68 09 10 00 00       	push   $0x1009
 bb5:	e8 51 f9 ff ff       	call   50b <open>
 bba:	83 c4 10             	add    $0x10,%esp
 bbd:	a3 c0 14 00 00       	mov    %eax,0x14c0

        if(dir < 0){        // kalau gagal membuka file
 bc2:	a1 c0 14 00 00       	mov    0x14c0,%eax
 bc7:	85 c0                	test   %eax,%eax
 bc9:	79 11                	jns    bdc <getid+0x44>
            dir = 0;
 bcb:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 bd2:	00 00 00 
            return 0;
 bd5:	b8 00 00 00 00       	mov    $0x0,%eax
 bda:	eb 16                	jmp    bf2 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
 bdc:	e8 7d fe ff ff       	call   a5e <get_id>
 be1:	83 f8 ff             	cmp    $0xffffffff,%eax
 be4:	75 07                	jne    bed <getid+0x55>
        return 0;
 be6:	b8 00 00 00 00       	mov    $0x0,%eax
 beb:	eb 05                	jmp    bf2 <getid+0x5a>
    
    return &current_id;
 bed:	b8 80 14 00 00       	mov    $0x1480,%eax
}
 bf2:	c9                   	leave  
 bf3:	c3                   	ret    

00000bf4 <setid>:

// open file_ids
void setid(void){
 bf4:	f3 0f 1e fb          	endbr32 
 bf8:	55                   	push   %ebp
 bf9:	89 e5                	mov    %esp,%ebp
 bfb:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 bfe:	a1 c0 14 00 00       	mov    0x14c0,%eax
 c03:	85 c0                	test   %eax,%eax
 c05:	74 1b                	je     c22 <setid+0x2e>
        close(dir);
 c07:	a1 c0 14 00 00       	mov    0x14c0,%eax
 c0c:	83 ec 0c             	sub    $0xc,%esp
 c0f:	50                   	push   %eax
 c10:	e8 de f8 ff ff       	call   4f3 <close>
 c15:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 c18:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 c1f:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
 c22:	83 ec 08             	sub    $0x8,%esp
 c25:	6a 00                	push   $0x0
 c27:	68 09 10 00 00       	push   $0x1009
 c2c:	e8 da f8 ff ff       	call   50b <open>
 c31:	83 c4 10             	add    $0x10,%esp
 c34:	a3 c0 14 00 00       	mov    %eax,0x14c0

    if (dir < 0)
 c39:	a1 c0 14 00 00       	mov    0x14c0,%eax
 c3e:	85 c0                	test   %eax,%eax
 c40:	79 0a                	jns    c4c <setid+0x58>
        dir = 0;
 c42:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 c49:	00 00 00 
}
 c4c:	90                   	nop
 c4d:	c9                   	leave  
 c4e:	c3                   	ret    

00000c4f <endid>:

// tutup file_ids
void endid (void){
 c4f:	f3 0f 1e fb          	endbr32 
 c53:	55                   	push   %ebp
 c54:	89 e5                	mov    %esp,%ebp
 c56:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 c59:	a1 c0 14 00 00       	mov    0x14c0,%eax
 c5e:	85 c0                	test   %eax,%eax
 c60:	74 1b                	je     c7d <endid+0x2e>
        close(dir);
 c62:	a1 c0 14 00 00       	mov    0x14c0,%eax
 c67:	83 ec 0c             	sub    $0xc,%esp
 c6a:	50                   	push   %eax
 c6b:	e8 83 f8 ff ff       	call   4f3 <close>
 c70:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 c73:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 c7a:	00 00 00 
    }
}
 c7d:	90                   	nop
 c7e:	c9                   	leave  
 c7f:	c3                   	ret    

00000c80 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
 c80:	f3 0f 1e fb          	endbr32 
 c84:	55                   	push   %ebp
 c85:	89 e5                	mov    %esp,%ebp
 c87:	83 ec 08             	sub    $0x8,%esp
    setid();
 c8a:	e8 65 ff ff ff       	call   bf4 <setid>

    while (getid()){
 c8f:	eb 24                	jmp    cb5 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
 c91:	a1 80 14 00 00       	mov    0x1480,%eax
 c96:	83 ec 08             	sub    $0x8,%esp
 c99:	50                   	push   %eax
 c9a:	ff 75 08             	pushl  0x8(%ebp)
 c9d:	e8 bd f4 ff ff       	call   15f <strcmp>
 ca2:	83 c4 10             	add    $0x10,%esp
 ca5:	85 c0                	test   %eax,%eax
 ca7:	75 0c                	jne    cb5 <cek_nama+0x35>
            endid();
 ca9:	e8 a1 ff ff ff       	call   c4f <endid>
            return &current_id;
 cae:	b8 80 14 00 00       	mov    $0x1480,%eax
 cb3:	eb 13                	jmp    cc8 <cek_nama+0x48>
    while (getid()){
 cb5:	e8 de fe ff ff       	call   b98 <getid>
 cba:	85 c0                	test   %eax,%eax
 cbc:	75 d3                	jne    c91 <cek_nama+0x11>
        }
    }
    endid();
 cbe:	e8 8c ff ff ff       	call   c4f <endid>
    return 0;
 cc3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 cc8:	c9                   	leave  
 cc9:	c3                   	ret    

00000cca <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
 cca:	f3 0f 1e fb          	endbr32 
 cce:	55                   	push   %ebp
 ccf:	89 e5                	mov    %esp,%ebp
 cd1:	83 ec 08             	sub    $0x8,%esp
    setid();
 cd4:	e8 1b ff ff ff       	call   bf4 <setid>

    while (getid()){
 cd9:	eb 16                	jmp    cf1 <cek_uid+0x27>
        if(current_id.uid_user == uid){
 cdb:	a1 84 14 00 00       	mov    0x1484,%eax
 ce0:	39 45 08             	cmp    %eax,0x8(%ebp)
 ce3:	75 0c                	jne    cf1 <cek_uid+0x27>
            endid();
 ce5:	e8 65 ff ff ff       	call   c4f <endid>
            return &current_id;
 cea:	b8 80 14 00 00       	mov    $0x1480,%eax
 cef:	eb 13                	jmp    d04 <cek_uid+0x3a>
    while (getid()){
 cf1:	e8 a2 fe ff ff       	call   b98 <getid>
 cf6:	85 c0                	test   %eax,%eax
 cf8:	75 e1                	jne    cdb <cek_uid+0x11>
        }
    }
    endid();
 cfa:	e8 50 ff ff ff       	call   c4f <endid>
    return 0;
 cff:	b8 00 00 00 00       	mov    $0x0,%eax
}
 d04:	c9                   	leave  
 d05:	c3                   	ret    

00000d06 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
 d06:	f3 0f 1e fb          	endbr32 
 d0a:	55                   	push   %ebp
 d0b:	89 e5                	mov    %esp,%ebp
 d0d:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 d10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 d17:	a1 c0 14 00 00       	mov    0x14c0,%eax
 d1c:	83 ec 04             	sub    $0x4,%esp
 d1f:	50                   	push   %eax
 d20:	6a 20                	push   $0x20
 d22:	68 a0 14 00 00       	push   $0x14a0
 d27:	e8 69 f5 ff ff       	call   295 <fgets>
 d2c:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 d2f:	83 ec 0c             	sub    $0xc,%esp
 d32:	68 a0 14 00 00       	push   $0x14a0
 d37:	e8 66 f4 ff ff       	call   1a2 <strlen>
 d3c:	83 c4 10             	add    $0x10,%esp
 d3f:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 d42:	8b 45 e8             	mov    -0x18(%ebp),%eax
 d45:	83 e8 01             	sub    $0x1,%eax
 d48:	0f b6 80 a0 14 00 00 	movzbl 0x14a0(%eax),%eax
 d4f:	3c 0a                	cmp    $0xa,%al
 d51:	74 11                	je     d64 <get_group+0x5e>
 d53:	8b 45 e8             	mov    -0x18(%ebp),%eax
 d56:	83 e8 01             	sub    $0x1,%eax
 d59:	0f b6 80 a0 14 00 00 	movzbl 0x14a0(%eax),%eax
 d60:	3c 0d                	cmp    $0xd,%al
 d62:	75 0d                	jne    d71 <get_group+0x6b>
        current_line[len - 1] = 0;
 d64:	8b 45 e8             	mov    -0x18(%ebp),%eax
 d67:	83 e8 01             	sub    $0x1,%eax
 d6a:	c6 80 a0 14 00 00 00 	movb   $0x0,0x14a0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 d71:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 d78:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 d7f:	eb 6c                	jmp    ded <get_group+0xe7>
        if(current_line[i] == ' '){
 d81:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d84:	05 a0 14 00 00       	add    $0x14a0,%eax
 d89:	0f b6 00             	movzbl (%eax),%eax
 d8c:	3c 20                	cmp    $0x20,%al
 d8e:	75 30                	jne    dc0 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 d90:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 d94:	75 16                	jne    dac <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 d96:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 d99:	8b 45 f0             	mov    -0x10(%ebp),%eax
 d9c:	8d 50 01             	lea    0x1(%eax),%edx
 d9f:	89 55 f0             	mov    %edx,-0x10(%ebp)
 da2:	8d 91 a0 14 00 00    	lea    0x14a0(%ecx),%edx
 da8:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 dac:	8b 45 ec             	mov    -0x14(%ebp),%eax
 daf:	05 a0 14 00 00       	add    $0x14a0,%eax
 db4:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 db7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 dbe:	eb 29                	jmp    de9 <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 dc0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 dc4:	75 23                	jne    de9 <get_group+0xe3>
 dc6:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 dca:	7f 1d                	jg     de9 <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 dcc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 dd3:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 dd9:	8d 50 01             	lea    0x1(%eax),%edx
 ddc:	89 55 f0             	mov    %edx,-0x10(%ebp)
 ddf:	8d 91 a0 14 00 00    	lea    0x14a0(%ecx),%edx
 de5:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 de9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 ded:	8b 45 ec             	mov    -0x14(%ebp),%eax
 df0:	05 a0 14 00 00       	add    $0x14a0,%eax
 df5:	0f b6 00             	movzbl (%eax),%eax
 df8:	84 c0                	test   %al,%al
 dfa:	75 85                	jne    d81 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 dfc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 e00:	75 07                	jne    e09 <get_group+0x103>
        return -1;
 e02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 e07:	eb 21                	jmp    e2a <get_group+0x124>
    
    current_group.nama_group = tokens[0];
 e09:	8b 45 dc             	mov    -0x24(%ebp),%eax
 e0c:	a3 8c 14 00 00       	mov    %eax,0x148c
    current_group.gid = atoi(tokens[1]);
 e11:	8b 45 e0             	mov    -0x20(%ebp),%eax
 e14:	83 ec 0c             	sub    $0xc,%esp
 e17:	50                   	push   %eax
 e18:	e8 3d f5 ff ff       	call   35a <atoi>
 e1d:	83 c4 10             	add    $0x10,%esp
 e20:	a3 90 14 00 00       	mov    %eax,0x1490

    return 0;
 e25:	b8 00 00 00 00       	mov    $0x0,%eax
}
 e2a:	c9                   	leave  
 e2b:	c3                   	ret    

00000e2c <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
 e2c:	f3 0f 1e fb          	endbr32 
 e30:	55                   	push   %ebp
 e31:	89 e5                	mov    %esp,%ebp
 e33:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 e36:	a1 c0 14 00 00       	mov    0x14c0,%eax
 e3b:	85 c0                	test   %eax,%eax
 e3d:	75 31                	jne    e70 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
 e3f:	83 ec 08             	sub    $0x8,%esp
 e42:	6a 00                	push   $0x0
 e44:	68 11 10 00 00       	push   $0x1011
 e49:	e8 bd f6 ff ff       	call   50b <open>
 e4e:	83 c4 10             	add    $0x10,%esp
 e51:	a3 c0 14 00 00       	mov    %eax,0x14c0

        if(dir < 0){        // kalau gagal membuka file
 e56:	a1 c0 14 00 00       	mov    0x14c0,%eax
 e5b:	85 c0                	test   %eax,%eax
 e5d:	79 11                	jns    e70 <getgroup+0x44>
            dir = 0;
 e5f:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 e66:	00 00 00 
            return 0;
 e69:	b8 00 00 00 00       	mov    $0x0,%eax
 e6e:	eb 16                	jmp    e86 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
 e70:	e8 91 fe ff ff       	call   d06 <get_group>
 e75:	83 f8 ff             	cmp    $0xffffffff,%eax
 e78:	75 07                	jne    e81 <getgroup+0x55>
        return 0;
 e7a:	b8 00 00 00 00       	mov    $0x0,%eax
 e7f:	eb 05                	jmp    e86 <getgroup+0x5a>
    
    return &current_group;
 e81:	b8 8c 14 00 00       	mov    $0x148c,%eax
}
 e86:	c9                   	leave  
 e87:	c3                   	ret    

00000e88 <setgroup>:

// open file_ids
void setgroup(void){
 e88:	f3 0f 1e fb          	endbr32 
 e8c:	55                   	push   %ebp
 e8d:	89 e5                	mov    %esp,%ebp
 e8f:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 e92:	a1 c0 14 00 00       	mov    0x14c0,%eax
 e97:	85 c0                	test   %eax,%eax
 e99:	74 1b                	je     eb6 <setgroup+0x2e>
        close(dir);
 e9b:	a1 c0 14 00 00       	mov    0x14c0,%eax
 ea0:	83 ec 0c             	sub    $0xc,%esp
 ea3:	50                   	push   %eax
 ea4:	e8 4a f6 ff ff       	call   4f3 <close>
 ea9:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 eac:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 eb3:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
 eb6:	83 ec 08             	sub    $0x8,%esp
 eb9:	6a 00                	push   $0x0
 ebb:	68 11 10 00 00       	push   $0x1011
 ec0:	e8 46 f6 ff ff       	call   50b <open>
 ec5:	83 c4 10             	add    $0x10,%esp
 ec8:	a3 c0 14 00 00       	mov    %eax,0x14c0

    if (dir < 0)
 ecd:	a1 c0 14 00 00       	mov    0x14c0,%eax
 ed2:	85 c0                	test   %eax,%eax
 ed4:	79 0a                	jns    ee0 <setgroup+0x58>
        dir = 0;
 ed6:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 edd:	00 00 00 
}
 ee0:	90                   	nop
 ee1:	c9                   	leave  
 ee2:	c3                   	ret    

00000ee3 <endgroup>:

// tutup file_ids
void endgroup (void){
 ee3:	f3 0f 1e fb          	endbr32 
 ee7:	55                   	push   %ebp
 ee8:	89 e5                	mov    %esp,%ebp
 eea:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 eed:	a1 c0 14 00 00       	mov    0x14c0,%eax
 ef2:	85 c0                	test   %eax,%eax
 ef4:	74 1b                	je     f11 <endgroup+0x2e>
        close(dir);
 ef6:	a1 c0 14 00 00       	mov    0x14c0,%eax
 efb:	83 ec 0c             	sub    $0xc,%esp
 efe:	50                   	push   %eax
 eff:	e8 ef f5 ff ff       	call   4f3 <close>
 f04:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 f07:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 f0e:	00 00 00 
    }
}
 f11:	90                   	nop
 f12:	c9                   	leave  
 f13:	c3                   	ret    

00000f14 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
 f14:	f3 0f 1e fb          	endbr32 
 f18:	55                   	push   %ebp
 f19:	89 e5                	mov    %esp,%ebp
 f1b:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 f1e:	e8 65 ff ff ff       	call   e88 <setgroup>

    while (getgroup()){
 f23:	eb 3c                	jmp    f61 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
 f25:	a1 8c 14 00 00       	mov    0x148c,%eax
 f2a:	83 ec 08             	sub    $0x8,%esp
 f2d:	50                   	push   %eax
 f2e:	ff 75 08             	pushl  0x8(%ebp)
 f31:	e8 29 f2 ff ff       	call   15f <strcmp>
 f36:	83 c4 10             	add    $0x10,%esp
 f39:	85 c0                	test   %eax,%eax
 f3b:	75 24                	jne    f61 <cek_nama_group+0x4d>
            endgroup();
 f3d:	e8 a1 ff ff ff       	call   ee3 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
 f42:	a1 8c 14 00 00       	mov    0x148c,%eax
 f47:	83 ec 04             	sub    $0x4,%esp
 f4a:	50                   	push   %eax
 f4b:	68 1c 10 00 00       	push   $0x101c
 f50:	6a 01                	push   $0x1
 f52:	e8 40 f7 ff ff       	call   697 <printf>
 f57:	83 c4 10             	add    $0x10,%esp
            return &current_group;
 f5a:	b8 8c 14 00 00       	mov    $0x148c,%eax
 f5f:	eb 13                	jmp    f74 <cek_nama_group+0x60>
    while (getgroup()){
 f61:	e8 c6 fe ff ff       	call   e2c <getgroup>
 f66:	85 c0                	test   %eax,%eax
 f68:	75 bb                	jne    f25 <cek_nama_group+0x11>
        }
    }
    endgroup();
 f6a:	e8 74 ff ff ff       	call   ee3 <endgroup>
    return 0;
 f6f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 f74:	c9                   	leave  
 f75:	c3                   	ret    

00000f76 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
 f76:	f3 0f 1e fb          	endbr32 
 f7a:	55                   	push   %ebp
 f7b:	89 e5                	mov    %esp,%ebp
 f7d:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 f80:	e8 03 ff ff ff       	call   e88 <setgroup>

    while (getgroup()){
 f85:	eb 16                	jmp    f9d <cek_gid+0x27>
        if(current_group.gid == gid){
 f87:	a1 90 14 00 00       	mov    0x1490,%eax
 f8c:	39 45 08             	cmp    %eax,0x8(%ebp)
 f8f:	75 0c                	jne    f9d <cek_gid+0x27>
            endgroup();
 f91:	e8 4d ff ff ff       	call   ee3 <endgroup>
            return &current_group;
 f96:	b8 8c 14 00 00       	mov    $0x148c,%eax
 f9b:	eb 13                	jmp    fb0 <cek_gid+0x3a>
    while (getgroup()){
 f9d:	e8 8a fe ff ff       	call   e2c <getgroup>
 fa2:	85 c0                	test   %eax,%eax
 fa4:	75 e1                	jne    f87 <cek_gid+0x11>
        }
    }
    endgroup();
 fa6:	e8 38 ff ff ff       	call   ee3 <endgroup>
    return 0;
 fab:	b8 00 00 00 00       	mov    $0x0,%eax
}
 fb0:	c9                   	leave  
 fb1:	c3                   	ret    
