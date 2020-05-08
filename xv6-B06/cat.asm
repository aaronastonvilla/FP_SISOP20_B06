
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   a:	eb 15                	jmp    21 <cat+0x21>
    write(1, buf, n);
   c:	83 ec 04             	sub    $0x4,%esp
   f:	ff 75 f4             	pushl  -0xc(%ebp)
  12:	68 e0 14 00 00       	push   $0x14e0
  17:	6a 01                	push   $0x1
  19:	e8 df 04 00 00       	call   4fd <write>
  1e:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf, sizeof(buf))) > 0)
  21:	83 ec 04             	sub    $0x4,%esp
  24:	68 00 02 00 00       	push   $0x200
  29:	68 e0 14 00 00       	push   $0x14e0
  2e:	ff 75 08             	pushl  0x8(%ebp)
  31:	e8 bf 04 00 00       	call   4f5 <read>
  36:	83 c4 10             	add    $0x10,%esp
  39:	89 45 f4             	mov    %eax,-0xc(%ebp)
  3c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  40:	7f ca                	jg     c <cat+0xc>
  if(n < 0){
  42:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  46:	79 17                	jns    5f <cat+0x5f>
    printf(1, "cat: read error\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 c4 0f 00 00       	push   $0xfc4
  50:	6a 01                	push   $0x1
  52:	e8 52 06 00 00       	call   6a9 <printf>
  57:	83 c4 10             	add    $0x10,%esp
    exit();
  5a:	e8 7e 04 00 00       	call   4dd <exit>
  }
}
  5f:	90                   	nop
  60:	c9                   	leave  
  61:	c3                   	ret    

00000062 <main>:

int
main(int argc, char *argv[])
{
  62:	f3 0f 1e fb          	endbr32 
  66:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  6a:	83 e4 f0             	and    $0xfffffff0,%esp
  6d:	ff 71 fc             	pushl  -0x4(%ecx)
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	51                   	push   %ecx
  75:	83 ec 10             	sub    $0x10,%esp
  78:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  7a:	83 3b 01             	cmpl   $0x1,(%ebx)
  7d:	7f 12                	jg     91 <main+0x2f>
    cat(0);
  7f:	83 ec 0c             	sub    $0xc,%esp
  82:	6a 00                	push   $0x0
  84:	e8 77 ff ff ff       	call   0 <cat>
  89:	83 c4 10             	add    $0x10,%esp
    exit();
  8c:	e8 4c 04 00 00       	call   4dd <exit>
  }

  for(i = 1; i < argc; i++){
  91:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  98:	eb 71                	jmp    10b <main+0xa9>
    if((fd = open(argv[i], 0)) < 0){
  9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  9d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  a4:	8b 43 04             	mov    0x4(%ebx),%eax
  a7:	01 d0                	add    %edx,%eax
  a9:	8b 00                	mov    (%eax),%eax
  ab:	83 ec 08             	sub    $0x8,%esp
  ae:	6a 00                	push   $0x0
  b0:	50                   	push   %eax
  b1:	e8 67 04 00 00       	call   51d <open>
  b6:	83 c4 10             	add    $0x10,%esp
  b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  c0:	79 29                	jns    eb <main+0x89>
      printf(1, "cat: cannot open %s\n", argv[i]);
  c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  cc:	8b 43 04             	mov    0x4(%ebx),%eax
  cf:	01 d0                	add    %edx,%eax
  d1:	8b 00                	mov    (%eax),%eax
  d3:	83 ec 04             	sub    $0x4,%esp
  d6:	50                   	push   %eax
  d7:	68 d5 0f 00 00       	push   $0xfd5
  dc:	6a 01                	push   $0x1
  de:	e8 c6 05 00 00       	call   6a9 <printf>
  e3:	83 c4 10             	add    $0x10,%esp
      exit();
  e6:	e8 f2 03 00 00       	call   4dd <exit>
    }
    cat(fd);
  eb:	83 ec 0c             	sub    $0xc,%esp
  ee:	ff 75 f0             	pushl  -0x10(%ebp)
  f1:	e8 0a ff ff ff       	call   0 <cat>
  f6:	83 c4 10             	add    $0x10,%esp
    close(fd);
  f9:	83 ec 0c             	sub    $0xc,%esp
  fc:	ff 75 f0             	pushl  -0x10(%ebp)
  ff:	e8 01 04 00 00       	call   505 <close>
 104:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
 107:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 10b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 10e:	3b 03                	cmp    (%ebx),%eax
 110:	7c 88                	jl     9a <main+0x38>
  }
  exit();
 112:	e8 c6 03 00 00       	call   4dd <exit>

00000117 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 117:	55                   	push   %ebp
 118:	89 e5                	mov    %esp,%ebp
 11a:	57                   	push   %edi
 11b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 11c:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11f:	8b 55 10             	mov    0x10(%ebp),%edx
 122:	8b 45 0c             	mov    0xc(%ebp),%eax
 125:	89 cb                	mov    %ecx,%ebx
 127:	89 df                	mov    %ebx,%edi
 129:	89 d1                	mov    %edx,%ecx
 12b:	fc                   	cld    
 12c:	f3 aa                	rep stos %al,%es:(%edi)
 12e:	89 ca                	mov    %ecx,%edx
 130:	89 fb                	mov    %edi,%ebx
 132:	89 5d 08             	mov    %ebx,0x8(%ebp)
 135:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 138:	90                   	nop
 139:	5b                   	pop    %ebx
 13a:	5f                   	pop    %edi
 13b:	5d                   	pop    %ebp
 13c:	c3                   	ret    

0000013d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 13d:	f3 0f 1e fb          	endbr32 
 141:	55                   	push   %ebp
 142:	89 e5                	mov    %esp,%ebp
 144:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 147:	8b 45 08             	mov    0x8(%ebp),%eax
 14a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 14d:	90                   	nop
 14e:	8b 55 0c             	mov    0xc(%ebp),%edx
 151:	8d 42 01             	lea    0x1(%edx),%eax
 154:	89 45 0c             	mov    %eax,0xc(%ebp)
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	8d 48 01             	lea    0x1(%eax),%ecx
 15d:	89 4d 08             	mov    %ecx,0x8(%ebp)
 160:	0f b6 12             	movzbl (%edx),%edx
 163:	88 10                	mov    %dl,(%eax)
 165:	0f b6 00             	movzbl (%eax),%eax
 168:	84 c0                	test   %al,%al
 16a:	75 e2                	jne    14e <strcpy+0x11>
    ;
  return os;
 16c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 16f:	c9                   	leave  
 170:	c3                   	ret    

00000171 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 171:	f3 0f 1e fb          	endbr32 
 175:	55                   	push   %ebp
 176:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 178:	eb 08                	jmp    182 <strcmp+0x11>
    p++, q++;
 17a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 182:	8b 45 08             	mov    0x8(%ebp),%eax
 185:	0f b6 00             	movzbl (%eax),%eax
 188:	84 c0                	test   %al,%al
 18a:	74 10                	je     19c <strcmp+0x2b>
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	0f b6 10             	movzbl (%eax),%edx
 192:	8b 45 0c             	mov    0xc(%ebp),%eax
 195:	0f b6 00             	movzbl (%eax),%eax
 198:	38 c2                	cmp    %al,%dl
 19a:	74 de                	je     17a <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	0f b6 00             	movzbl (%eax),%eax
 1a2:	0f b6 d0             	movzbl %al,%edx
 1a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a8:	0f b6 00             	movzbl (%eax),%eax
 1ab:	0f b6 c0             	movzbl %al,%eax
 1ae:	29 c2                	sub    %eax,%edx
 1b0:	89 d0                	mov    %edx,%eax
}
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    

000001b4 <strlen>:

uint
strlen(char *s)
{
 1b4:	f3 0f 1e fb          	endbr32 
 1b8:	55                   	push   %ebp
 1b9:	89 e5                	mov    %esp,%ebp
 1bb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c5:	eb 04                	jmp    1cb <strlen+0x17>
 1c7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ce:	8b 45 08             	mov    0x8(%ebp),%eax
 1d1:	01 d0                	add    %edx,%eax
 1d3:	0f b6 00             	movzbl (%eax),%eax
 1d6:	84 c0                	test   %al,%al
 1d8:	75 ed                	jne    1c7 <strlen+0x13>
    ;
  return n;
 1da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1dd:	c9                   	leave  
 1de:	c3                   	ret    

000001df <memset>:

void*
memset(void *dst, int c, uint n)
{
 1df:	f3 0f 1e fb          	endbr32 
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1e6:	8b 45 10             	mov    0x10(%ebp),%eax
 1e9:	50                   	push   %eax
 1ea:	ff 75 0c             	pushl  0xc(%ebp)
 1ed:	ff 75 08             	pushl  0x8(%ebp)
 1f0:	e8 22 ff ff ff       	call   117 <stosb>
 1f5:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1fb:	c9                   	leave  
 1fc:	c3                   	ret    

000001fd <strchr>:

char*
strchr(const char *s, char c)
{
 1fd:	f3 0f 1e fb          	endbr32 
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 04             	sub    $0x4,%esp
 207:	8b 45 0c             	mov    0xc(%ebp),%eax
 20a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 20d:	eb 14                	jmp    223 <strchr+0x26>
    if(*s == c)
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	0f b6 00             	movzbl (%eax),%eax
 215:	38 45 fc             	cmp    %al,-0x4(%ebp)
 218:	75 05                	jne    21f <strchr+0x22>
      return (char*)s;
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	eb 13                	jmp    232 <strchr+0x35>
  for(; *s; s++)
 21f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 00             	movzbl (%eax),%eax
 229:	84 c0                	test   %al,%al
 22b:	75 e2                	jne    20f <strchr+0x12>
  return 0;
 22d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 232:	c9                   	leave  
 233:	c3                   	ret    

00000234 <gets>:

char*
gets(char *buf, int max)
{
 234:	f3 0f 1e fb          	endbr32 
 238:	55                   	push   %ebp
 239:	89 e5                	mov    %esp,%ebp
 23b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 245:	eb 42                	jmp    289 <gets+0x55>
    cc = read(0, &c, 1);
 247:	83 ec 04             	sub    $0x4,%esp
 24a:	6a 01                	push   $0x1
 24c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 24f:	50                   	push   %eax
 250:	6a 00                	push   $0x0
 252:	e8 9e 02 00 00       	call   4f5 <read>
 257:	83 c4 10             	add    $0x10,%esp
 25a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 25d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 261:	7e 33                	jle    296 <gets+0x62>
      break;
    buf[i++] = c;
 263:	8b 45 f4             	mov    -0xc(%ebp),%eax
 266:	8d 50 01             	lea    0x1(%eax),%edx
 269:	89 55 f4             	mov    %edx,-0xc(%ebp)
 26c:	89 c2                	mov    %eax,%edx
 26e:	8b 45 08             	mov    0x8(%ebp),%eax
 271:	01 c2                	add    %eax,%edx
 273:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 277:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 279:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 27d:	3c 0a                	cmp    $0xa,%al
 27f:	74 16                	je     297 <gets+0x63>
 281:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 285:	3c 0d                	cmp    $0xd,%al
 287:	74 0e                	je     297 <gets+0x63>
  for(i=0; i+1 < max; ){
 289:	8b 45 f4             	mov    -0xc(%ebp),%eax
 28c:	83 c0 01             	add    $0x1,%eax
 28f:	39 45 0c             	cmp    %eax,0xc(%ebp)
 292:	7f b3                	jg     247 <gets+0x13>
 294:	eb 01                	jmp    297 <gets+0x63>
      break;
 296:	90                   	nop
      break;
  }
  buf[i] = '\0';
 297:	8b 55 f4             	mov    -0xc(%ebp),%edx
 29a:	8b 45 08             	mov    0x8(%ebp),%eax
 29d:	01 d0                	add    %edx,%eax
 29f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a5:	c9                   	leave  
 2a6:	c3                   	ret    

000002a7 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
 2a7:	f3 0f 1e fb          	endbr32 
 2ab:	55                   	push   %ebp
 2ac:	89 e5                	mov    %esp,%ebp
 2ae:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
 2b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2b8:	eb 43                	jmp    2fd <fgets+0x56>
    int cc = read(fd, &c, 1);
 2ba:	83 ec 04             	sub    $0x4,%esp
 2bd:	6a 01                	push   $0x1
 2bf:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2c2:	50                   	push   %eax
 2c3:	ff 75 10             	pushl  0x10(%ebp)
 2c6:	e8 2a 02 00 00       	call   4f5 <read>
 2cb:	83 c4 10             	add    $0x10,%esp
 2ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2d1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2d5:	7e 33                	jle    30a <fgets+0x63>
      break;
    buf[i++] = c;
 2d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2da:	8d 50 01             	lea    0x1(%eax),%edx
 2dd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2e0:	89 c2                	mov    %eax,%edx
 2e2:	8b 45 08             	mov    0x8(%ebp),%eax
 2e5:	01 c2                	add    %eax,%edx
 2e7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2eb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 2ed:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2f1:	3c 0a                	cmp    $0xa,%al
 2f3:	74 16                	je     30b <fgets+0x64>
 2f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2f9:	3c 0d                	cmp    $0xd,%al
 2fb:	74 0e                	je     30b <fgets+0x64>
  for(i = 0; i + 1 < size;){
 2fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 300:	83 c0 01             	add    $0x1,%eax
 303:	39 45 0c             	cmp    %eax,0xc(%ebp)
 306:	7f b2                	jg     2ba <fgets+0x13>
 308:	eb 01                	jmp    30b <fgets+0x64>
      break;
 30a:	90                   	nop
      break;
  }
  buf[i] = '\0';
 30b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 30e:	8b 45 08             	mov    0x8(%ebp),%eax
 311:	01 d0                	add    %edx,%eax
 313:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 316:	8b 45 08             	mov    0x8(%ebp),%eax
}
 319:	c9                   	leave  
 31a:	c3                   	ret    

0000031b <stat>:

int
stat(char *n, struct stat *st)
{
 31b:	f3 0f 1e fb          	endbr32 
 31f:	55                   	push   %ebp
 320:	89 e5                	mov    %esp,%ebp
 322:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 325:	83 ec 08             	sub    $0x8,%esp
 328:	6a 00                	push   $0x0
 32a:	ff 75 08             	pushl  0x8(%ebp)
 32d:	e8 eb 01 00 00       	call   51d <open>
 332:	83 c4 10             	add    $0x10,%esp
 335:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 338:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 33c:	79 07                	jns    345 <stat+0x2a>
    return -1;
 33e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 343:	eb 25                	jmp    36a <stat+0x4f>
  r = fstat(fd, st);
 345:	83 ec 08             	sub    $0x8,%esp
 348:	ff 75 0c             	pushl  0xc(%ebp)
 34b:	ff 75 f4             	pushl  -0xc(%ebp)
 34e:	e8 e2 01 00 00       	call   535 <fstat>
 353:	83 c4 10             	add    $0x10,%esp
 356:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 359:	83 ec 0c             	sub    $0xc,%esp
 35c:	ff 75 f4             	pushl  -0xc(%ebp)
 35f:	e8 a1 01 00 00       	call   505 <close>
 364:	83 c4 10             	add    $0x10,%esp
  return r;
 367:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 36a:	c9                   	leave  
 36b:	c3                   	ret    

0000036c <atoi>:

int
atoi(const char *s)
{
 36c:	f3 0f 1e fb          	endbr32 
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 376:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 37d:	eb 04                	jmp    383 <atoi+0x17>
 37f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 383:	8b 45 08             	mov    0x8(%ebp),%eax
 386:	0f b6 00             	movzbl (%eax),%eax
 389:	3c 20                	cmp    $0x20,%al
 38b:	74 f2                	je     37f <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
 38d:	8b 45 08             	mov    0x8(%ebp),%eax
 390:	0f b6 00             	movzbl (%eax),%eax
 393:	3c 2d                	cmp    $0x2d,%al
 395:	75 07                	jne    39e <atoi+0x32>
 397:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 39c:	eb 05                	jmp    3a3 <atoi+0x37>
 39e:	b8 01 00 00 00       	mov    $0x1,%eax
 3a3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 3a6:	8b 45 08             	mov    0x8(%ebp),%eax
 3a9:	0f b6 00             	movzbl (%eax),%eax
 3ac:	3c 2b                	cmp    $0x2b,%al
 3ae:	74 0a                	je     3ba <atoi+0x4e>
 3b0:	8b 45 08             	mov    0x8(%ebp),%eax
 3b3:	0f b6 00             	movzbl (%eax),%eax
 3b6:	3c 2d                	cmp    $0x2d,%al
 3b8:	75 2b                	jne    3e5 <atoi+0x79>
    s++;
 3ba:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
 3be:	eb 25                	jmp    3e5 <atoi+0x79>
    n = n*10 + *s++ - '0';
 3c0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3c3:	89 d0                	mov    %edx,%eax
 3c5:	c1 e0 02             	shl    $0x2,%eax
 3c8:	01 d0                	add    %edx,%eax
 3ca:	01 c0                	add    %eax,%eax
 3cc:	89 c1                	mov    %eax,%ecx
 3ce:	8b 45 08             	mov    0x8(%ebp),%eax
 3d1:	8d 50 01             	lea    0x1(%eax),%edx
 3d4:	89 55 08             	mov    %edx,0x8(%ebp)
 3d7:	0f b6 00             	movzbl (%eax),%eax
 3da:	0f be c0             	movsbl %al,%eax
 3dd:	01 c8                	add    %ecx,%eax
 3df:	83 e8 30             	sub    $0x30,%eax
 3e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3e5:	8b 45 08             	mov    0x8(%ebp),%eax
 3e8:	0f b6 00             	movzbl (%eax),%eax
 3eb:	3c 2f                	cmp    $0x2f,%al
 3ed:	7e 0a                	jle    3f9 <atoi+0x8d>
 3ef:	8b 45 08             	mov    0x8(%ebp),%eax
 3f2:	0f b6 00             	movzbl (%eax),%eax
 3f5:	3c 39                	cmp    $0x39,%al
 3f7:	7e c7                	jle    3c0 <atoi+0x54>
  return sign*n;
 3f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 3fc:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 400:	c9                   	leave  
 401:	c3                   	ret    

00000402 <atoo>:

int
atoo(const char *s)
{
 402:	f3 0f 1e fb          	endbr32 
 406:	55                   	push   %ebp
 407:	89 e5                	mov    %esp,%ebp
 409:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
 40c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
 413:	eb 04                	jmp    419 <atoo+0x17>
 415:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 419:	8b 45 08             	mov    0x8(%ebp),%eax
 41c:	0f b6 00             	movzbl (%eax),%eax
 41f:	3c 20                	cmp    $0x20,%al
 421:	74 f2                	je     415 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
 423:	8b 45 08             	mov    0x8(%ebp),%eax
 426:	0f b6 00             	movzbl (%eax),%eax
 429:	3c 2d                	cmp    $0x2d,%al
 42b:	75 07                	jne    434 <atoo+0x32>
 42d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 432:	eb 05                	jmp    439 <atoo+0x37>
 434:	b8 01 00 00 00       	mov    $0x1,%eax
 439:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
 43c:	8b 45 08             	mov    0x8(%ebp),%eax
 43f:	0f b6 00             	movzbl (%eax),%eax
 442:	3c 2b                	cmp    $0x2b,%al
 444:	74 0a                	je     450 <atoo+0x4e>
 446:	8b 45 08             	mov    0x8(%ebp),%eax
 449:	0f b6 00             	movzbl (%eax),%eax
 44c:	3c 2d                	cmp    $0x2d,%al
 44e:	75 27                	jne    477 <atoo+0x75>
    s++;
 450:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
 454:	eb 21                	jmp    477 <atoo+0x75>
    n = n*8 + *s++ - '0';
 456:	8b 45 fc             	mov    -0x4(%ebp),%eax
 459:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
 460:	8b 45 08             	mov    0x8(%ebp),%eax
 463:	8d 50 01             	lea    0x1(%eax),%edx
 466:	89 55 08             	mov    %edx,0x8(%ebp)
 469:	0f b6 00             	movzbl (%eax),%eax
 46c:	0f be c0             	movsbl %al,%eax
 46f:	01 c8                	add    %ecx,%eax
 471:	83 e8 30             	sub    $0x30,%eax
 474:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
 477:	8b 45 08             	mov    0x8(%ebp),%eax
 47a:	0f b6 00             	movzbl (%eax),%eax
 47d:	3c 2f                	cmp    $0x2f,%al
 47f:	7e 0a                	jle    48b <atoo+0x89>
 481:	8b 45 08             	mov    0x8(%ebp),%eax
 484:	0f b6 00             	movzbl (%eax),%eax
 487:	3c 37                	cmp    $0x37,%al
 489:	7e cb                	jle    456 <atoo+0x54>
  return sign*n;
 48b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 48e:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
 492:	c9                   	leave  
 493:	c3                   	ret    

00000494 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
 494:	f3 0f 1e fb          	endbr32 
 498:	55                   	push   %ebp
 499:	89 e5                	mov    %esp,%ebp
 49b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 49e:	8b 45 08             	mov    0x8(%ebp),%eax
 4a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 4a4:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 4aa:	eb 17                	jmp    4c3 <memmove+0x2f>
    *dst++ = *src++;
 4ac:	8b 55 f8             	mov    -0x8(%ebp),%edx
 4af:	8d 42 01             	lea    0x1(%edx),%eax
 4b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
 4b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 4b8:	8d 48 01             	lea    0x1(%eax),%ecx
 4bb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 4be:	0f b6 12             	movzbl (%edx),%edx
 4c1:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 4c3:	8b 45 10             	mov    0x10(%ebp),%eax
 4c6:	8d 50 ff             	lea    -0x1(%eax),%edx
 4c9:	89 55 10             	mov    %edx,0x10(%ebp)
 4cc:	85 c0                	test   %eax,%eax
 4ce:	7f dc                	jg     4ac <memmove+0x18>
  return vdst;
 4d0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4d3:	c9                   	leave  
 4d4:	c3                   	ret    

000004d5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4d5:	b8 01 00 00 00       	mov    $0x1,%eax
 4da:	cd 40                	int    $0x40
 4dc:	c3                   	ret    

000004dd <exit>:
SYSCALL(exit)
 4dd:	b8 02 00 00 00       	mov    $0x2,%eax
 4e2:	cd 40                	int    $0x40
 4e4:	c3                   	ret    

000004e5 <wait>:
SYSCALL(wait)
 4e5:	b8 03 00 00 00       	mov    $0x3,%eax
 4ea:	cd 40                	int    $0x40
 4ec:	c3                   	ret    

000004ed <pipe>:
SYSCALL(pipe)
 4ed:	b8 04 00 00 00       	mov    $0x4,%eax
 4f2:	cd 40                	int    $0x40
 4f4:	c3                   	ret    

000004f5 <read>:
SYSCALL(read)
 4f5:	b8 05 00 00 00       	mov    $0x5,%eax
 4fa:	cd 40                	int    $0x40
 4fc:	c3                   	ret    

000004fd <write>:
SYSCALL(write)
 4fd:	b8 10 00 00 00       	mov    $0x10,%eax
 502:	cd 40                	int    $0x40
 504:	c3                   	ret    

00000505 <close>:
SYSCALL(close)
 505:	b8 15 00 00 00       	mov    $0x15,%eax
 50a:	cd 40                	int    $0x40
 50c:	c3                   	ret    

0000050d <kill>:
SYSCALL(kill)
 50d:	b8 06 00 00 00       	mov    $0x6,%eax
 512:	cd 40                	int    $0x40
 514:	c3                   	ret    

00000515 <exec>:
SYSCALL(exec)
 515:	b8 07 00 00 00       	mov    $0x7,%eax
 51a:	cd 40                	int    $0x40
 51c:	c3                   	ret    

0000051d <open>:
SYSCALL(open)
 51d:	b8 0f 00 00 00       	mov    $0xf,%eax
 522:	cd 40                	int    $0x40
 524:	c3                   	ret    

00000525 <mknod>:
SYSCALL(mknod)
 525:	b8 11 00 00 00       	mov    $0x11,%eax
 52a:	cd 40                	int    $0x40
 52c:	c3                   	ret    

0000052d <unlink>:
SYSCALL(unlink)
 52d:	b8 12 00 00 00       	mov    $0x12,%eax
 532:	cd 40                	int    $0x40
 534:	c3                   	ret    

00000535 <fstat>:
SYSCALL(fstat)
 535:	b8 08 00 00 00       	mov    $0x8,%eax
 53a:	cd 40                	int    $0x40
 53c:	c3                   	ret    

0000053d <link>:
SYSCALL(link)
 53d:	b8 13 00 00 00       	mov    $0x13,%eax
 542:	cd 40                	int    $0x40
 544:	c3                   	ret    

00000545 <mkdir>:
SYSCALL(mkdir)
 545:	b8 14 00 00 00       	mov    $0x14,%eax
 54a:	cd 40                	int    $0x40
 54c:	c3                   	ret    

0000054d <chdir>:
SYSCALL(chdir)
 54d:	b8 09 00 00 00       	mov    $0x9,%eax
 552:	cd 40                	int    $0x40
 554:	c3                   	ret    

00000555 <dup>:
SYSCALL(dup)
 555:	b8 0a 00 00 00       	mov    $0xa,%eax
 55a:	cd 40                	int    $0x40
 55c:	c3                   	ret    

0000055d <getpid>:
SYSCALL(getpid)
 55d:	b8 0b 00 00 00       	mov    $0xb,%eax
 562:	cd 40                	int    $0x40
 564:	c3                   	ret    

00000565 <sbrk>:
SYSCALL(sbrk)
 565:	b8 0c 00 00 00       	mov    $0xc,%eax
 56a:	cd 40                	int    $0x40
 56c:	c3                   	ret    

0000056d <sleep>:
SYSCALL(sleep)
 56d:	b8 0d 00 00 00       	mov    $0xd,%eax
 572:	cd 40                	int    $0x40
 574:	c3                   	ret    

00000575 <uptime>:
SYSCALL(uptime)
 575:	b8 0e 00 00 00       	mov    $0xe,%eax
 57a:	cd 40                	int    $0x40
 57c:	c3                   	ret    

0000057d <halt>:
SYSCALL(halt)
 57d:	b8 16 00 00 00       	mov    $0x16,%eax
 582:	cd 40                	int    $0x40
 584:	c3                   	ret    

00000585 <date>:
SYSCALL(date)
 585:	b8 17 00 00 00       	mov    $0x17,%eax
 58a:	cd 40                	int    $0x40
 58c:	c3                   	ret    

0000058d <getuid>:
SYSCALL(getuid)
 58d:	b8 18 00 00 00       	mov    $0x18,%eax
 592:	cd 40                	int    $0x40
 594:	c3                   	ret    

00000595 <getgid>:
SYSCALL(getgid)
 595:	b8 19 00 00 00       	mov    $0x19,%eax
 59a:	cd 40                	int    $0x40
 59c:	c3                   	ret    

0000059d <getppid>:
SYSCALL(getppid)
 59d:	b8 1a 00 00 00       	mov    $0x1a,%eax
 5a2:	cd 40                	int    $0x40
 5a4:	c3                   	ret    

000005a5 <setuid>:
SYSCALL(setuid)
 5a5:	b8 1b 00 00 00       	mov    $0x1b,%eax
 5aa:	cd 40                	int    $0x40
 5ac:	c3                   	ret    

000005ad <setgid>:
SYSCALL(setgid)
 5ad:	b8 1c 00 00 00       	mov    $0x1c,%eax
 5b2:	cd 40                	int    $0x40
 5b4:	c3                   	ret    

000005b5 <getprocs>:
SYSCALL(getprocs)
 5b5:	b8 1d 00 00 00       	mov    $0x1d,%eax
 5ba:	cd 40                	int    $0x40
 5bc:	c3                   	ret    

000005bd <setpriority>:
SYSCALL(setpriority)
 5bd:	b8 1e 00 00 00       	mov    $0x1e,%eax
 5c2:	cd 40                	int    $0x40
 5c4:	c3                   	ret    

000005c5 <chown>:
SYSCALL(chown)
 5c5:	b8 1f 00 00 00       	mov    $0x1f,%eax
 5ca:	cd 40                	int    $0x40
 5cc:	c3                   	ret    

000005cd <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 5cd:	f3 0f 1e fb          	endbr32 
 5d1:	55                   	push   %ebp
 5d2:	89 e5                	mov    %esp,%ebp
 5d4:	83 ec 18             	sub    $0x18,%esp
 5d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 5da:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 5dd:	83 ec 04             	sub    $0x4,%esp
 5e0:	6a 01                	push   $0x1
 5e2:	8d 45 f4             	lea    -0xc(%ebp),%eax
 5e5:	50                   	push   %eax
 5e6:	ff 75 08             	pushl  0x8(%ebp)
 5e9:	e8 0f ff ff ff       	call   4fd <write>
 5ee:	83 c4 10             	add    $0x10,%esp
}
 5f1:	90                   	nop
 5f2:	c9                   	leave  
 5f3:	c3                   	ret    

000005f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5f4:	f3 0f 1e fb          	endbr32 
 5f8:	55                   	push   %ebp
 5f9:	89 e5                	mov    %esp,%ebp
 5fb:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 605:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 609:	74 17                	je     622 <printint+0x2e>
 60b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 60f:	79 11                	jns    622 <printint+0x2e>
    neg = 1;
 611:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 618:	8b 45 0c             	mov    0xc(%ebp),%eax
 61b:	f7 d8                	neg    %eax
 61d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 620:	eb 06                	jmp    628 <printint+0x34>
  } else {
    x = xx;
 622:	8b 45 0c             	mov    0xc(%ebp),%eax
 625:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 628:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 62f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 632:	8b 45 ec             	mov    -0x14(%ebp),%eax
 635:	ba 00 00 00 00       	mov    $0x0,%edx
 63a:	f7 f1                	div    %ecx
 63c:	89 d1                	mov    %edx,%ecx
 63e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 641:	8d 50 01             	lea    0x1(%eax),%edx
 644:	89 55 f4             	mov    %edx,-0xc(%ebp)
 647:	0f b6 91 3c 14 00 00 	movzbl 0x143c(%ecx),%edx
 64e:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 652:	8b 4d 10             	mov    0x10(%ebp),%ecx
 655:	8b 45 ec             	mov    -0x14(%ebp),%eax
 658:	ba 00 00 00 00       	mov    $0x0,%edx
 65d:	f7 f1                	div    %ecx
 65f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 662:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 666:	75 c7                	jne    62f <printint+0x3b>
  if(neg)
 668:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 66c:	74 2d                	je     69b <printint+0xa7>
    buf[i++] = '-';
 66e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 671:	8d 50 01             	lea    0x1(%eax),%edx
 674:	89 55 f4             	mov    %edx,-0xc(%ebp)
 677:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 67c:	eb 1d                	jmp    69b <printint+0xa7>
    putc(fd, buf[i]);
 67e:	8d 55 dc             	lea    -0x24(%ebp),%edx
 681:	8b 45 f4             	mov    -0xc(%ebp),%eax
 684:	01 d0                	add    %edx,%eax
 686:	0f b6 00             	movzbl (%eax),%eax
 689:	0f be c0             	movsbl %al,%eax
 68c:	83 ec 08             	sub    $0x8,%esp
 68f:	50                   	push   %eax
 690:	ff 75 08             	pushl  0x8(%ebp)
 693:	e8 35 ff ff ff       	call   5cd <putc>
 698:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 69b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 69f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6a3:	79 d9                	jns    67e <printint+0x8a>
}
 6a5:	90                   	nop
 6a6:	90                   	nop
 6a7:	c9                   	leave  
 6a8:	c3                   	ret    

000006a9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6a9:	f3 0f 1e fb          	endbr32 
 6ad:	55                   	push   %ebp
 6ae:	89 e5                	mov    %esp,%ebp
 6b0:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6ba:	8d 45 0c             	lea    0xc(%ebp),%eax
 6bd:	83 c0 04             	add    $0x4,%eax
 6c0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 6c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 6ca:	e9 59 01 00 00       	jmp    828 <printf+0x17f>
    c = fmt[i] & 0xff;
 6cf:	8b 55 0c             	mov    0xc(%ebp),%edx
 6d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d5:	01 d0                	add    %edx,%eax
 6d7:	0f b6 00             	movzbl (%eax),%eax
 6da:	0f be c0             	movsbl %al,%eax
 6dd:	25 ff 00 00 00       	and    $0xff,%eax
 6e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 6e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6e9:	75 2c                	jne    717 <printf+0x6e>
      if(c == '%'){
 6eb:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6ef:	75 0c                	jne    6fd <printf+0x54>
        state = '%';
 6f1:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 6f8:	e9 27 01 00 00       	jmp    824 <printf+0x17b>
      } else {
        putc(fd, c);
 6fd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 700:	0f be c0             	movsbl %al,%eax
 703:	83 ec 08             	sub    $0x8,%esp
 706:	50                   	push   %eax
 707:	ff 75 08             	pushl  0x8(%ebp)
 70a:	e8 be fe ff ff       	call   5cd <putc>
 70f:	83 c4 10             	add    $0x10,%esp
 712:	e9 0d 01 00 00       	jmp    824 <printf+0x17b>
      }
    } else if(state == '%'){
 717:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 71b:	0f 85 03 01 00 00    	jne    824 <printf+0x17b>
      if(c == 'd'){
 721:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 725:	75 1e                	jne    745 <printf+0x9c>
        printint(fd, *ap, 10, 1);
 727:	8b 45 e8             	mov    -0x18(%ebp),%eax
 72a:	8b 00                	mov    (%eax),%eax
 72c:	6a 01                	push   $0x1
 72e:	6a 0a                	push   $0xa
 730:	50                   	push   %eax
 731:	ff 75 08             	pushl  0x8(%ebp)
 734:	e8 bb fe ff ff       	call   5f4 <printint>
 739:	83 c4 10             	add    $0x10,%esp
        ap++;
 73c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 740:	e9 d8 00 00 00       	jmp    81d <printf+0x174>
      } else if(c == 'x' || c == 'p'){
 745:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 749:	74 06                	je     751 <printf+0xa8>
 74b:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 74f:	75 1e                	jne    76f <printf+0xc6>
        printint(fd, *ap, 16, 0);
 751:	8b 45 e8             	mov    -0x18(%ebp),%eax
 754:	8b 00                	mov    (%eax),%eax
 756:	6a 00                	push   $0x0
 758:	6a 10                	push   $0x10
 75a:	50                   	push   %eax
 75b:	ff 75 08             	pushl  0x8(%ebp)
 75e:	e8 91 fe ff ff       	call   5f4 <printint>
 763:	83 c4 10             	add    $0x10,%esp
        ap++;
 766:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 76a:	e9 ae 00 00 00       	jmp    81d <printf+0x174>
      } else if(c == 's'){
 76f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 773:	75 43                	jne    7b8 <printf+0x10f>
        s = (char*)*ap;
 775:	8b 45 e8             	mov    -0x18(%ebp),%eax
 778:	8b 00                	mov    (%eax),%eax
 77a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 77d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 781:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 785:	75 25                	jne    7ac <printf+0x103>
          s = "(null)";
 787:	c7 45 f4 ea 0f 00 00 	movl   $0xfea,-0xc(%ebp)
        while(*s != 0){
 78e:	eb 1c                	jmp    7ac <printf+0x103>
          putc(fd, *s);
 790:	8b 45 f4             	mov    -0xc(%ebp),%eax
 793:	0f b6 00             	movzbl (%eax),%eax
 796:	0f be c0             	movsbl %al,%eax
 799:	83 ec 08             	sub    $0x8,%esp
 79c:	50                   	push   %eax
 79d:	ff 75 08             	pushl  0x8(%ebp)
 7a0:	e8 28 fe ff ff       	call   5cd <putc>
 7a5:	83 c4 10             	add    $0x10,%esp
          s++;
 7a8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 7ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7af:	0f b6 00             	movzbl (%eax),%eax
 7b2:	84 c0                	test   %al,%al
 7b4:	75 da                	jne    790 <printf+0xe7>
 7b6:	eb 65                	jmp    81d <printf+0x174>
        }
      } else if(c == 'c'){
 7b8:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7bc:	75 1d                	jne    7db <printf+0x132>
        putc(fd, *ap);
 7be:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7c1:	8b 00                	mov    (%eax),%eax
 7c3:	0f be c0             	movsbl %al,%eax
 7c6:	83 ec 08             	sub    $0x8,%esp
 7c9:	50                   	push   %eax
 7ca:	ff 75 08             	pushl  0x8(%ebp)
 7cd:	e8 fb fd ff ff       	call   5cd <putc>
 7d2:	83 c4 10             	add    $0x10,%esp
        ap++;
 7d5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7d9:	eb 42                	jmp    81d <printf+0x174>
      } else if(c == '%'){
 7db:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7df:	75 17                	jne    7f8 <printf+0x14f>
        putc(fd, c);
 7e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7e4:	0f be c0             	movsbl %al,%eax
 7e7:	83 ec 08             	sub    $0x8,%esp
 7ea:	50                   	push   %eax
 7eb:	ff 75 08             	pushl  0x8(%ebp)
 7ee:	e8 da fd ff ff       	call   5cd <putc>
 7f3:	83 c4 10             	add    $0x10,%esp
 7f6:	eb 25                	jmp    81d <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7f8:	83 ec 08             	sub    $0x8,%esp
 7fb:	6a 25                	push   $0x25
 7fd:	ff 75 08             	pushl  0x8(%ebp)
 800:	e8 c8 fd ff ff       	call   5cd <putc>
 805:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 808:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 80b:	0f be c0             	movsbl %al,%eax
 80e:	83 ec 08             	sub    $0x8,%esp
 811:	50                   	push   %eax
 812:	ff 75 08             	pushl  0x8(%ebp)
 815:	e8 b3 fd ff ff       	call   5cd <putc>
 81a:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 81d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 824:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 828:	8b 55 0c             	mov    0xc(%ebp),%edx
 82b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82e:	01 d0                	add    %edx,%eax
 830:	0f b6 00             	movzbl (%eax),%eax
 833:	84 c0                	test   %al,%al
 835:	0f 85 94 fe ff ff    	jne    6cf <printf+0x26>
    }
  }
}
 83b:	90                   	nop
 83c:	90                   	nop
 83d:	c9                   	leave  
 83e:	c3                   	ret    

0000083f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 83f:	f3 0f 1e fb          	endbr32 
 843:	55                   	push   %ebp
 844:	89 e5                	mov    %esp,%ebp
 846:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 849:	8b 45 08             	mov    0x8(%ebp),%eax
 84c:	83 e8 08             	sub    $0x8,%eax
 84f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 852:	a1 68 14 00 00       	mov    0x1468,%eax
 857:	89 45 fc             	mov    %eax,-0x4(%ebp)
 85a:	eb 24                	jmp    880 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85f:	8b 00                	mov    (%eax),%eax
 861:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 864:	72 12                	jb     878 <free+0x39>
 866:	8b 45 f8             	mov    -0x8(%ebp),%eax
 869:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 86c:	77 24                	ja     892 <free+0x53>
 86e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 871:	8b 00                	mov    (%eax),%eax
 873:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 876:	72 1a                	jb     892 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 878:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87b:	8b 00                	mov    (%eax),%eax
 87d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 880:	8b 45 f8             	mov    -0x8(%ebp),%eax
 883:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 886:	76 d4                	jbe    85c <free+0x1d>
 888:	8b 45 fc             	mov    -0x4(%ebp),%eax
 88b:	8b 00                	mov    (%eax),%eax
 88d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 890:	73 ca                	jae    85c <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
 892:	8b 45 f8             	mov    -0x8(%ebp),%eax
 895:	8b 40 04             	mov    0x4(%eax),%eax
 898:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 89f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a2:	01 c2                	add    %eax,%edx
 8a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a7:	8b 00                	mov    (%eax),%eax
 8a9:	39 c2                	cmp    %eax,%edx
 8ab:	75 24                	jne    8d1 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
 8ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b0:	8b 50 04             	mov    0x4(%eax),%edx
 8b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b6:	8b 00                	mov    (%eax),%eax
 8b8:	8b 40 04             	mov    0x4(%eax),%eax
 8bb:	01 c2                	add    %eax,%edx
 8bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c0:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c6:	8b 00                	mov    (%eax),%eax
 8c8:	8b 10                	mov    (%eax),%edx
 8ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8cd:	89 10                	mov    %edx,(%eax)
 8cf:	eb 0a                	jmp    8db <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
 8d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8d4:	8b 10                	mov    (%eax),%edx
 8d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d9:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 8db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8de:	8b 40 04             	mov    0x4(%eax),%eax
 8e1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8eb:	01 d0                	add    %edx,%eax
 8ed:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 8f0:	75 20                	jne    912 <free+0xd3>
    p->s.size += bp->s.size;
 8f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f5:	8b 50 04             	mov    0x4(%eax),%edx
 8f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8fb:	8b 40 04             	mov    0x4(%eax),%eax
 8fe:	01 c2                	add    %eax,%edx
 900:	8b 45 fc             	mov    -0x4(%ebp),%eax
 903:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 906:	8b 45 f8             	mov    -0x8(%ebp),%eax
 909:	8b 10                	mov    (%eax),%edx
 90b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90e:	89 10                	mov    %edx,(%eax)
 910:	eb 08                	jmp    91a <free+0xdb>
  } else
    p->s.ptr = bp;
 912:	8b 45 fc             	mov    -0x4(%ebp),%eax
 915:	8b 55 f8             	mov    -0x8(%ebp),%edx
 918:	89 10                	mov    %edx,(%eax)
  freep = p;
 91a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91d:	a3 68 14 00 00       	mov    %eax,0x1468
}
 922:	90                   	nop
 923:	c9                   	leave  
 924:	c3                   	ret    

00000925 <morecore>:

static Header*
morecore(uint nu)
{
 925:	f3 0f 1e fb          	endbr32 
 929:	55                   	push   %ebp
 92a:	89 e5                	mov    %esp,%ebp
 92c:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 92f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 936:	77 07                	ja     93f <morecore+0x1a>
    nu = 4096;
 938:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 93f:	8b 45 08             	mov    0x8(%ebp),%eax
 942:	c1 e0 03             	shl    $0x3,%eax
 945:	83 ec 0c             	sub    $0xc,%esp
 948:	50                   	push   %eax
 949:	e8 17 fc ff ff       	call   565 <sbrk>
 94e:	83 c4 10             	add    $0x10,%esp
 951:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 954:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 958:	75 07                	jne    961 <morecore+0x3c>
    return 0;
 95a:	b8 00 00 00 00       	mov    $0x0,%eax
 95f:	eb 26                	jmp    987 <morecore+0x62>
  hp = (Header*)p;
 961:	8b 45 f4             	mov    -0xc(%ebp),%eax
 964:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 967:	8b 45 f0             	mov    -0x10(%ebp),%eax
 96a:	8b 55 08             	mov    0x8(%ebp),%edx
 96d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 970:	8b 45 f0             	mov    -0x10(%ebp),%eax
 973:	83 c0 08             	add    $0x8,%eax
 976:	83 ec 0c             	sub    $0xc,%esp
 979:	50                   	push   %eax
 97a:	e8 c0 fe ff ff       	call   83f <free>
 97f:	83 c4 10             	add    $0x10,%esp
  return freep;
 982:	a1 68 14 00 00       	mov    0x1468,%eax
}
 987:	c9                   	leave  
 988:	c3                   	ret    

00000989 <malloc>:

void*
malloc(uint nbytes)
{
 989:	f3 0f 1e fb          	endbr32 
 98d:	55                   	push   %ebp
 98e:	89 e5                	mov    %esp,%ebp
 990:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 993:	8b 45 08             	mov    0x8(%ebp),%eax
 996:	83 c0 07             	add    $0x7,%eax
 999:	c1 e8 03             	shr    $0x3,%eax
 99c:	83 c0 01             	add    $0x1,%eax
 99f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9a2:	a1 68 14 00 00       	mov    0x1468,%eax
 9a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9ae:	75 23                	jne    9d3 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
 9b0:	c7 45 f0 60 14 00 00 	movl   $0x1460,-0x10(%ebp)
 9b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ba:	a3 68 14 00 00       	mov    %eax,0x1468
 9bf:	a1 68 14 00 00       	mov    0x1468,%eax
 9c4:	a3 60 14 00 00       	mov    %eax,0x1460
    base.s.size = 0;
 9c9:	c7 05 64 14 00 00 00 	movl   $0x0,0x1464
 9d0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9d6:	8b 00                	mov    (%eax),%eax
 9d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9de:	8b 40 04             	mov    0x4(%eax),%eax
 9e1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 9e4:	77 4d                	ja     a33 <malloc+0xaa>
      if(p->s.size == nunits)
 9e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9e9:	8b 40 04             	mov    0x4(%eax),%eax
 9ec:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 9ef:	75 0c                	jne    9fd <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
 9f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f4:	8b 10                	mov    (%eax),%edx
 9f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9f9:	89 10                	mov    %edx,(%eax)
 9fb:	eb 26                	jmp    a23 <malloc+0x9a>
      else {
        p->s.size -= nunits;
 9fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a00:	8b 40 04             	mov    0x4(%eax),%eax
 a03:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a06:	89 c2                	mov    %eax,%edx
 a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a11:	8b 40 04             	mov    0x4(%eax),%eax
 a14:	c1 e0 03             	shl    $0x3,%eax
 a17:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a20:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a23:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a26:	a3 68 14 00 00       	mov    %eax,0x1468
      return (void*)(p + 1);
 a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2e:	83 c0 08             	add    $0x8,%eax
 a31:	eb 3b                	jmp    a6e <malloc+0xe5>
    }
    if(p == freep)
 a33:	a1 68 14 00 00       	mov    0x1468,%eax
 a38:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a3b:	75 1e                	jne    a5b <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
 a3d:	83 ec 0c             	sub    $0xc,%esp
 a40:	ff 75 ec             	pushl  -0x14(%ebp)
 a43:	e8 dd fe ff ff       	call   925 <morecore>
 a48:	83 c4 10             	add    $0x10,%esp
 a4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a4e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a52:	75 07                	jne    a5b <malloc+0xd2>
        return 0;
 a54:	b8 00 00 00 00       	mov    $0x0,%eax
 a59:	eb 13                	jmp    a6e <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a64:	8b 00                	mov    (%eax),%eax
 a66:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a69:	e9 6d ff ff ff       	jmp    9db <malloc+0x52>
  }
}
 a6e:	c9                   	leave  
 a6f:	c3                   	ret    

00000a70 <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
 a70:	f3 0f 1e fb          	endbr32 
 a74:	55                   	push   %ebp
 a75:	89 e5                	mov    %esp,%ebp
 a77:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 a7a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 a81:	a1 c0 14 00 00       	mov    0x14c0,%eax
 a86:	83 ec 04             	sub    $0x4,%esp
 a89:	50                   	push   %eax
 a8a:	6a 20                	push   $0x20
 a8c:	68 a0 14 00 00       	push   $0x14a0
 a91:	e8 11 f8 ff ff       	call   2a7 <fgets>
 a96:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 a99:	83 ec 0c             	sub    $0xc,%esp
 a9c:	68 a0 14 00 00       	push   $0x14a0
 aa1:	e8 0e f7 ff ff       	call   1b4 <strlen>
 aa6:	83 c4 10             	add    $0x10,%esp
 aa9:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 aac:	8b 45 e8             	mov    -0x18(%ebp),%eax
 aaf:	83 e8 01             	sub    $0x1,%eax
 ab2:	0f b6 80 a0 14 00 00 	movzbl 0x14a0(%eax),%eax
 ab9:	3c 0a                	cmp    $0xa,%al
 abb:	74 11                	je     ace <get_id+0x5e>
 abd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ac0:	83 e8 01             	sub    $0x1,%eax
 ac3:	0f b6 80 a0 14 00 00 	movzbl 0x14a0(%eax),%eax
 aca:	3c 0d                	cmp    $0xd,%al
 acc:	75 0d                	jne    adb <get_id+0x6b>
        current_line[len - 1] = 0;
 ace:	8b 45 e8             	mov    -0x18(%ebp),%eax
 ad1:	83 e8 01             	sub    $0x1,%eax
 ad4:	c6 80 a0 14 00 00 00 	movb   $0x0,0x14a0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 adb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 ae2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 ae9:	eb 6c                	jmp    b57 <get_id+0xe7>
        if(current_line[i] == ' '){
 aeb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 aee:	05 a0 14 00 00       	add    $0x14a0,%eax
 af3:	0f b6 00             	movzbl (%eax),%eax
 af6:	3c 20                	cmp    $0x20,%al
 af8:	75 30                	jne    b2a <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 afa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 afe:	75 16                	jne    b16 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 b00:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 b03:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b06:	8d 50 01             	lea    0x1(%eax),%edx
 b09:	89 55 f0             	mov    %edx,-0x10(%ebp)
 b0c:	8d 91 a0 14 00 00    	lea    0x14a0(%ecx),%edx
 b12:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 b16:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b19:	05 a0 14 00 00       	add    $0x14a0,%eax
 b1e:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 b21:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 b28:	eb 29                	jmp    b53 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 b2a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b2e:	75 23                	jne    b53 <get_id+0xe3>
 b30:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 b34:	7f 1d                	jg     b53 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 b36:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 b3d:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 b40:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b43:	8d 50 01             	lea    0x1(%eax),%edx
 b46:	89 55 f0             	mov    %edx,-0x10(%ebp)
 b49:	8d 91 a0 14 00 00    	lea    0x14a0(%ecx),%edx
 b4f:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 b53:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 b57:	8b 45 ec             	mov    -0x14(%ebp),%eax
 b5a:	05 a0 14 00 00       	add    $0x14a0,%eax
 b5f:	0f b6 00             	movzbl (%eax),%eax
 b62:	84 c0                	test   %al,%al
 b64:	75 85                	jne    aeb <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 b66:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 b6a:	75 07                	jne    b73 <get_id+0x103>
        return -1;
 b6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 b71:	eb 35                	jmp    ba8 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
 b73:	8b 45 dc             	mov    -0x24(%ebp),%eax
 b76:	a3 80 14 00 00       	mov    %eax,0x1480
    current_id.uid_user = atoi(tokens[1]);
 b7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
 b7e:	83 ec 0c             	sub    $0xc,%esp
 b81:	50                   	push   %eax
 b82:	e8 e5 f7 ff ff       	call   36c <atoi>
 b87:	83 c4 10             	add    $0x10,%esp
 b8a:	a3 84 14 00 00       	mov    %eax,0x1484
    current_id.gid_user = atoi(tokens[2]);
 b8f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 b92:	83 ec 0c             	sub    $0xc,%esp
 b95:	50                   	push   %eax
 b96:	e8 d1 f7 ff ff       	call   36c <atoi>
 b9b:	83 c4 10             	add    $0x10,%esp
 b9e:	a3 88 14 00 00       	mov    %eax,0x1488

    return 0;
 ba3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 ba8:	c9                   	leave  
 ba9:	c3                   	ret    

00000baa <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
 baa:	f3 0f 1e fb          	endbr32 
 bae:	55                   	push   %ebp
 baf:	89 e5                	mov    %esp,%ebp
 bb1:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 bb4:	a1 c0 14 00 00       	mov    0x14c0,%eax
 bb9:	85 c0                	test   %eax,%eax
 bbb:	75 31                	jne    bee <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
 bbd:	83 ec 08             	sub    $0x8,%esp
 bc0:	6a 00                	push   $0x0
 bc2:	68 f1 0f 00 00       	push   $0xff1
 bc7:	e8 51 f9 ff ff       	call   51d <open>
 bcc:	83 c4 10             	add    $0x10,%esp
 bcf:	a3 c0 14 00 00       	mov    %eax,0x14c0

        if(dir < 0){        // kalau gagal membuka file
 bd4:	a1 c0 14 00 00       	mov    0x14c0,%eax
 bd9:	85 c0                	test   %eax,%eax
 bdb:	79 11                	jns    bee <getid+0x44>
            dir = 0;
 bdd:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 be4:	00 00 00 
            return 0;
 be7:	b8 00 00 00 00       	mov    $0x0,%eax
 bec:	eb 16                	jmp    c04 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
 bee:	e8 7d fe ff ff       	call   a70 <get_id>
 bf3:	83 f8 ff             	cmp    $0xffffffff,%eax
 bf6:	75 07                	jne    bff <getid+0x55>
        return 0;
 bf8:	b8 00 00 00 00       	mov    $0x0,%eax
 bfd:	eb 05                	jmp    c04 <getid+0x5a>
    
    return &current_id;
 bff:	b8 80 14 00 00       	mov    $0x1480,%eax
}
 c04:	c9                   	leave  
 c05:	c3                   	ret    

00000c06 <setid>:

// open file_ids
void setid(void){
 c06:	f3 0f 1e fb          	endbr32 
 c0a:	55                   	push   %ebp
 c0b:	89 e5                	mov    %esp,%ebp
 c0d:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 c10:	a1 c0 14 00 00       	mov    0x14c0,%eax
 c15:	85 c0                	test   %eax,%eax
 c17:	74 1b                	je     c34 <setid+0x2e>
        close(dir);
 c19:	a1 c0 14 00 00       	mov    0x14c0,%eax
 c1e:	83 ec 0c             	sub    $0xc,%esp
 c21:	50                   	push   %eax
 c22:	e8 de f8 ff ff       	call   505 <close>
 c27:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 c2a:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 c31:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
 c34:	83 ec 08             	sub    $0x8,%esp
 c37:	6a 00                	push   $0x0
 c39:	68 f1 0f 00 00       	push   $0xff1
 c3e:	e8 da f8 ff ff       	call   51d <open>
 c43:	83 c4 10             	add    $0x10,%esp
 c46:	a3 c0 14 00 00       	mov    %eax,0x14c0

    if (dir < 0)
 c4b:	a1 c0 14 00 00       	mov    0x14c0,%eax
 c50:	85 c0                	test   %eax,%eax
 c52:	79 0a                	jns    c5e <setid+0x58>
        dir = 0;
 c54:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 c5b:	00 00 00 
}
 c5e:	90                   	nop
 c5f:	c9                   	leave  
 c60:	c3                   	ret    

00000c61 <endid>:

// tutup file_ids
void endid (void){
 c61:	f3 0f 1e fb          	endbr32 
 c65:	55                   	push   %ebp
 c66:	89 e5                	mov    %esp,%ebp
 c68:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 c6b:	a1 c0 14 00 00       	mov    0x14c0,%eax
 c70:	85 c0                	test   %eax,%eax
 c72:	74 1b                	je     c8f <endid+0x2e>
        close(dir);
 c74:	a1 c0 14 00 00       	mov    0x14c0,%eax
 c79:	83 ec 0c             	sub    $0xc,%esp
 c7c:	50                   	push   %eax
 c7d:	e8 83 f8 ff ff       	call   505 <close>
 c82:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 c85:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 c8c:	00 00 00 
    }
}
 c8f:	90                   	nop
 c90:	c9                   	leave  
 c91:	c3                   	ret    

00000c92 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
 c92:	f3 0f 1e fb          	endbr32 
 c96:	55                   	push   %ebp
 c97:	89 e5                	mov    %esp,%ebp
 c99:	83 ec 08             	sub    $0x8,%esp
    setid();
 c9c:	e8 65 ff ff ff       	call   c06 <setid>

    while (getid()){
 ca1:	eb 24                	jmp    cc7 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
 ca3:	a1 80 14 00 00       	mov    0x1480,%eax
 ca8:	83 ec 08             	sub    $0x8,%esp
 cab:	50                   	push   %eax
 cac:	ff 75 08             	pushl  0x8(%ebp)
 caf:	e8 bd f4 ff ff       	call   171 <strcmp>
 cb4:	83 c4 10             	add    $0x10,%esp
 cb7:	85 c0                	test   %eax,%eax
 cb9:	75 0c                	jne    cc7 <cek_nama+0x35>
            endid();
 cbb:	e8 a1 ff ff ff       	call   c61 <endid>
            return &current_id;
 cc0:	b8 80 14 00 00       	mov    $0x1480,%eax
 cc5:	eb 13                	jmp    cda <cek_nama+0x48>
    while (getid()){
 cc7:	e8 de fe ff ff       	call   baa <getid>
 ccc:	85 c0                	test   %eax,%eax
 cce:	75 d3                	jne    ca3 <cek_nama+0x11>
        }
    }
    endid();
 cd0:	e8 8c ff ff ff       	call   c61 <endid>
    return 0;
 cd5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 cda:	c9                   	leave  
 cdb:	c3                   	ret    

00000cdc <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
 cdc:	f3 0f 1e fb          	endbr32 
 ce0:	55                   	push   %ebp
 ce1:	89 e5                	mov    %esp,%ebp
 ce3:	83 ec 08             	sub    $0x8,%esp
    setid();
 ce6:	e8 1b ff ff ff       	call   c06 <setid>

    while (getid()){
 ceb:	eb 16                	jmp    d03 <cek_uid+0x27>
        if(current_id.uid_user == uid){
 ced:	a1 84 14 00 00       	mov    0x1484,%eax
 cf2:	39 45 08             	cmp    %eax,0x8(%ebp)
 cf5:	75 0c                	jne    d03 <cek_uid+0x27>
            endid();
 cf7:	e8 65 ff ff ff       	call   c61 <endid>
            return &current_id;
 cfc:	b8 80 14 00 00       	mov    $0x1480,%eax
 d01:	eb 13                	jmp    d16 <cek_uid+0x3a>
    while (getid()){
 d03:	e8 a2 fe ff ff       	call   baa <getid>
 d08:	85 c0                	test   %eax,%eax
 d0a:	75 e1                	jne    ced <cek_uid+0x11>
        }
    }
    endid();
 d0c:	e8 50 ff ff ff       	call   c61 <endid>
    return 0;
 d11:	b8 00 00 00 00       	mov    $0x0,%eax
}
 d16:	c9                   	leave  
 d17:	c3                   	ret    

00000d18 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
 d18:	f3 0f 1e fb          	endbr32 
 d1c:	55                   	push   %ebp
 d1d:	89 e5                	mov    %esp,%ebp
 d1f:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
 d22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
 d29:	a1 c0 14 00 00       	mov    0x14c0,%eax
 d2e:	83 ec 04             	sub    $0x4,%esp
 d31:	50                   	push   %eax
 d32:	6a 20                	push   $0x20
 d34:	68 a0 14 00 00       	push   $0x14a0
 d39:	e8 69 f5 ff ff       	call   2a7 <fgets>
 d3e:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
 d41:	83 ec 0c             	sub    $0xc,%esp
 d44:	68 a0 14 00 00       	push   $0x14a0
 d49:	e8 66 f4 ff ff       	call   1b4 <strlen>
 d4e:	83 c4 10             	add    $0x10,%esp
 d51:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
 d54:	8b 45 e8             	mov    -0x18(%ebp),%eax
 d57:	83 e8 01             	sub    $0x1,%eax
 d5a:	0f b6 80 a0 14 00 00 	movzbl 0x14a0(%eax),%eax
 d61:	3c 0a                	cmp    $0xa,%al
 d63:	74 11                	je     d76 <get_group+0x5e>
 d65:	8b 45 e8             	mov    -0x18(%ebp),%eax
 d68:	83 e8 01             	sub    $0x1,%eax
 d6b:	0f b6 80 a0 14 00 00 	movzbl 0x14a0(%eax),%eax
 d72:	3c 0d                	cmp    $0xd,%al
 d74:	75 0d                	jne    d83 <get_group+0x6b>
        current_line[len - 1] = 0;
 d76:	8b 45 e8             	mov    -0x18(%ebp),%eax
 d79:	83 e8 01             	sub    $0x1,%eax
 d7c:	c6 80 a0 14 00 00 00 	movb   $0x0,0x14a0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
 d83:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
 d8a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 d91:	eb 6c                	jmp    dff <get_group+0xe7>
        if(current_line[i] == ' '){
 d93:	8b 45 ec             	mov    -0x14(%ebp),%eax
 d96:	05 a0 14 00 00       	add    $0x14a0,%eax
 d9b:	0f b6 00             	movzbl (%eax),%eax
 d9e:	3c 20                	cmp    $0x20,%al
 da0:	75 30                	jne    dd2 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
 da2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 da6:	75 16                	jne    dbe <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
 da8:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 dab:	8b 45 f0             	mov    -0x10(%ebp),%eax
 dae:	8d 50 01             	lea    0x1(%eax),%edx
 db1:	89 55 f0             	mov    %edx,-0x10(%ebp)
 db4:	8d 91 a0 14 00 00    	lea    0x14a0(%ecx),%edx
 dba:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
 dbe:	8b 45 ec             	mov    -0x14(%ebp),%eax
 dc1:	05 a0 14 00 00       	add    $0x14a0,%eax
 dc6:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
 dc9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 dd0:	eb 29                	jmp    dfb <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
 dd2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 dd6:	75 23                	jne    dfb <get_group+0xe3>
 dd8:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
 ddc:	7f 1d                	jg     dfb <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
 dde:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
 de5:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 de8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 deb:	8d 50 01             	lea    0x1(%eax),%edx
 dee:	89 55 f0             	mov    %edx,-0x10(%ebp)
 df1:	8d 91 a0 14 00 00    	lea    0x14a0(%ecx),%edx
 df7:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
 dfb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 dff:	8b 45 ec             	mov    -0x14(%ebp),%eax
 e02:	05 a0 14 00 00       	add    $0x14a0,%eax
 e07:	0f b6 00             	movzbl (%eax),%eax
 e0a:	84 c0                	test   %al,%al
 e0c:	75 85                	jne    d93 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
 e0e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 e12:	75 07                	jne    e1b <get_group+0x103>
        return -1;
 e14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 e19:	eb 21                	jmp    e3c <get_group+0x124>
    
    current_group.nama_group = tokens[0];
 e1b:	8b 45 dc             	mov    -0x24(%ebp),%eax
 e1e:	a3 8c 14 00 00       	mov    %eax,0x148c
    current_group.gid = atoi(tokens[1]);
 e23:	8b 45 e0             	mov    -0x20(%ebp),%eax
 e26:	83 ec 0c             	sub    $0xc,%esp
 e29:	50                   	push   %eax
 e2a:	e8 3d f5 ff ff       	call   36c <atoi>
 e2f:	83 c4 10             	add    $0x10,%esp
 e32:	a3 90 14 00 00       	mov    %eax,0x1490

    return 0;
 e37:	b8 00 00 00 00       	mov    $0x0,%eax
}
 e3c:	c9                   	leave  
 e3d:	c3                   	ret    

00000e3e <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
 e3e:	f3 0f 1e fb          	endbr32 
 e42:	55                   	push   %ebp
 e43:	89 e5                	mov    %esp,%ebp
 e45:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
 e48:	a1 c0 14 00 00       	mov    0x14c0,%eax
 e4d:	85 c0                	test   %eax,%eax
 e4f:	75 31                	jne    e82 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
 e51:	83 ec 08             	sub    $0x8,%esp
 e54:	6a 00                	push   $0x0
 e56:	68 f9 0f 00 00       	push   $0xff9
 e5b:	e8 bd f6 ff ff       	call   51d <open>
 e60:	83 c4 10             	add    $0x10,%esp
 e63:	a3 c0 14 00 00       	mov    %eax,0x14c0

        if(dir < 0){        // kalau gagal membuka file
 e68:	a1 c0 14 00 00       	mov    0x14c0,%eax
 e6d:	85 c0                	test   %eax,%eax
 e6f:	79 11                	jns    e82 <getgroup+0x44>
            dir = 0;
 e71:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 e78:	00 00 00 
            return 0;
 e7b:	b8 00 00 00 00       	mov    $0x0,%eax
 e80:	eb 16                	jmp    e98 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
 e82:	e8 91 fe ff ff       	call   d18 <get_group>
 e87:	83 f8 ff             	cmp    $0xffffffff,%eax
 e8a:	75 07                	jne    e93 <getgroup+0x55>
        return 0;
 e8c:	b8 00 00 00 00       	mov    $0x0,%eax
 e91:	eb 05                	jmp    e98 <getgroup+0x5a>
    
    return &current_group;
 e93:	b8 8c 14 00 00       	mov    $0x148c,%eax
}
 e98:	c9                   	leave  
 e99:	c3                   	ret    

00000e9a <setgroup>:

// open file_ids
void setgroup(void){
 e9a:	f3 0f 1e fb          	endbr32 
 e9e:	55                   	push   %ebp
 e9f:	89 e5                	mov    %esp,%ebp
 ea1:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 ea4:	a1 c0 14 00 00       	mov    0x14c0,%eax
 ea9:	85 c0                	test   %eax,%eax
 eab:	74 1b                	je     ec8 <setgroup+0x2e>
        close(dir);
 ead:	a1 c0 14 00 00       	mov    0x14c0,%eax
 eb2:	83 ec 0c             	sub    $0xc,%esp
 eb5:	50                   	push   %eax
 eb6:	e8 4a f6 ff ff       	call   505 <close>
 ebb:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 ebe:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 ec5:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
 ec8:	83 ec 08             	sub    $0x8,%esp
 ecb:	6a 00                	push   $0x0
 ecd:	68 f9 0f 00 00       	push   $0xff9
 ed2:	e8 46 f6 ff ff       	call   51d <open>
 ed7:	83 c4 10             	add    $0x10,%esp
 eda:	a3 c0 14 00 00       	mov    %eax,0x14c0

    if (dir < 0)
 edf:	a1 c0 14 00 00       	mov    0x14c0,%eax
 ee4:	85 c0                	test   %eax,%eax
 ee6:	79 0a                	jns    ef2 <setgroup+0x58>
        dir = 0;
 ee8:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 eef:	00 00 00 
}
 ef2:	90                   	nop
 ef3:	c9                   	leave  
 ef4:	c3                   	ret    

00000ef5 <endgroup>:

// tutup file_ids
void endgroup (void){
 ef5:	f3 0f 1e fb          	endbr32 
 ef9:	55                   	push   %ebp
 efa:	89 e5                	mov    %esp,%ebp
 efc:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
 eff:	a1 c0 14 00 00       	mov    0x14c0,%eax
 f04:	85 c0                	test   %eax,%eax
 f06:	74 1b                	je     f23 <endgroup+0x2e>
        close(dir);
 f08:	a1 c0 14 00 00       	mov    0x14c0,%eax
 f0d:	83 ec 0c             	sub    $0xc,%esp
 f10:	50                   	push   %eax
 f11:	e8 ef f5 ff ff       	call   505 <close>
 f16:	83 c4 10             	add    $0x10,%esp
        dir = 0;
 f19:	c7 05 c0 14 00 00 00 	movl   $0x0,0x14c0
 f20:	00 00 00 
    }
}
 f23:	90                   	nop
 f24:	c9                   	leave  
 f25:	c3                   	ret    

00000f26 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
 f26:	f3 0f 1e fb          	endbr32 
 f2a:	55                   	push   %ebp
 f2b:	89 e5                	mov    %esp,%ebp
 f2d:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 f30:	e8 65 ff ff ff       	call   e9a <setgroup>

    while (getgroup()){
 f35:	eb 3c                	jmp    f73 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
 f37:	a1 8c 14 00 00       	mov    0x148c,%eax
 f3c:	83 ec 08             	sub    $0x8,%esp
 f3f:	50                   	push   %eax
 f40:	ff 75 08             	pushl  0x8(%ebp)
 f43:	e8 29 f2 ff ff       	call   171 <strcmp>
 f48:	83 c4 10             	add    $0x10,%esp
 f4b:	85 c0                	test   %eax,%eax
 f4d:	75 24                	jne    f73 <cek_nama_group+0x4d>
            endgroup();
 f4f:	e8 a1 ff ff ff       	call   ef5 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
 f54:	a1 8c 14 00 00       	mov    0x148c,%eax
 f59:	83 ec 04             	sub    $0x4,%esp
 f5c:	50                   	push   %eax
 f5d:	68 04 10 00 00       	push   $0x1004
 f62:	6a 01                	push   $0x1
 f64:	e8 40 f7 ff ff       	call   6a9 <printf>
 f69:	83 c4 10             	add    $0x10,%esp
            return &current_group;
 f6c:	b8 8c 14 00 00       	mov    $0x148c,%eax
 f71:	eb 13                	jmp    f86 <cek_nama_group+0x60>
    while (getgroup()){
 f73:	e8 c6 fe ff ff       	call   e3e <getgroup>
 f78:	85 c0                	test   %eax,%eax
 f7a:	75 bb                	jne    f37 <cek_nama_group+0x11>
        }
    }
    endgroup();
 f7c:	e8 74 ff ff ff       	call   ef5 <endgroup>
    return 0;
 f81:	b8 00 00 00 00       	mov    $0x0,%eax
}
 f86:	c9                   	leave  
 f87:	c3                   	ret    

00000f88 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
 f88:	f3 0f 1e fb          	endbr32 
 f8c:	55                   	push   %ebp
 f8d:	89 e5                	mov    %esp,%ebp
 f8f:	83 ec 08             	sub    $0x8,%esp
    setgroup();
 f92:	e8 03 ff ff ff       	call   e9a <setgroup>

    while (getgroup()){
 f97:	eb 16                	jmp    faf <cek_gid+0x27>
        if(current_group.gid == gid){
 f99:	a1 90 14 00 00       	mov    0x1490,%eax
 f9e:	39 45 08             	cmp    %eax,0x8(%ebp)
 fa1:	75 0c                	jne    faf <cek_gid+0x27>
            endgroup();
 fa3:	e8 4d ff ff ff       	call   ef5 <endgroup>
            return &current_group;
 fa8:	b8 8c 14 00 00       	mov    $0x148c,%eax
 fad:	eb 13                	jmp    fc2 <cek_gid+0x3a>
    while (getgroup()){
 faf:	e8 8a fe ff ff       	call   e3e <getgroup>
 fb4:	85 c0                	test   %eax,%eax
 fb6:	75 e1                	jne    f99 <cek_gid+0x11>
        }
    }
    endgroup();
 fb8:	e8 38 ff ff ff       	call   ef5 <endgroup>
    return 0;
 fbd:	b8 00 00 00 00       	mov    $0x0,%eax
}
 fc2:	c9                   	leave  
 fc3:	c3                   	ret    
