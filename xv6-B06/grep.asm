
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	f3 0f 1e fb          	endbr32 
       4:	55                   	push   %ebp
       5:	89 e5                	mov    %esp,%ebp
       7:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
       a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      11:	e9 ae 00 00 00       	jmp    c4 <grep+0xc4>
    m += n;
      16:	8b 45 ec             	mov    -0x14(%ebp),%eax
      19:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
      1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
      1f:	05 80 17 00 00       	add    $0x1780,%eax
      24:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
      27:	c7 45 f0 80 17 00 00 	movl   $0x1780,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
      2e:	eb 44                	jmp    74 <grep+0x74>
      *q = 0;
      30:	8b 45 e8             	mov    -0x18(%ebp),%eax
      33:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
      36:	83 ec 08             	sub    $0x8,%esp
      39:	ff 75 f0             	pushl  -0x10(%ebp)
      3c:	ff 75 08             	pushl  0x8(%ebp)
      3f:	e8 97 01 00 00       	call   1db <match>
      44:	83 c4 10             	add    $0x10,%esp
      47:	85 c0                	test   %eax,%eax
      49:	74 20                	je     6b <grep+0x6b>
        *q = '\n';
      4b:	8b 45 e8             	mov    -0x18(%ebp),%eax
      4e:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
      51:	8b 45 e8             	mov    -0x18(%ebp),%eax
      54:	83 c0 01             	add    $0x1,%eax
      57:	2b 45 f0             	sub    -0x10(%ebp),%eax
      5a:	83 ec 04             	sub    $0x4,%esp
      5d:	50                   	push   %eax
      5e:	ff 75 f0             	pushl  -0x10(%ebp)
      61:	6a 01                	push   $0x1
      63:	e8 c1 06 00 00       	call   729 <write>
      68:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
      6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
      6e:	83 c0 01             	add    $0x1,%eax
      71:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
      74:	83 ec 08             	sub    $0x8,%esp
      77:	6a 0a                	push   $0xa
      79:	ff 75 f0             	pushl  -0x10(%ebp)
      7c:	e8 a8 03 00 00       	call   429 <strchr>
      81:	83 c4 10             	add    $0x10,%esp
      84:	89 45 e8             	mov    %eax,-0x18(%ebp)
      87:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
      8b:	75 a3                	jne    30 <grep+0x30>
    }
    if(p == buf)
      8d:	81 7d f0 80 17 00 00 	cmpl   $0x1780,-0x10(%ebp)
      94:	75 07                	jne    9d <grep+0x9d>
      m = 0;
      96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
      9d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      a1:	7e 21                	jle    c4 <grep+0xc4>
      m -= p - buf;
      a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a6:	2d 80 17 00 00       	sub    $0x1780,%eax
      ab:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
      ae:	83 ec 04             	sub    $0x4,%esp
      b1:	ff 75 f4             	pushl  -0xc(%ebp)
      b4:	ff 75 f0             	pushl  -0x10(%ebp)
      b7:	68 80 17 00 00       	push   $0x1780
      bc:	e8 ff 05 00 00       	call   6c0 <memmove>
      c1:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
      c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
      c7:	ba ff 03 00 00       	mov    $0x3ff,%edx
      cc:	29 c2                	sub    %eax,%edx
      ce:	89 d0                	mov    %edx,%eax
      d0:	89 c2                	mov    %eax,%edx
      d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
      d5:	05 80 17 00 00       	add    $0x1780,%eax
      da:	83 ec 04             	sub    $0x4,%esp
      dd:	52                   	push   %edx
      de:	50                   	push   %eax
      df:	ff 75 0c             	pushl  0xc(%ebp)
      e2:	e8 3a 06 00 00       	call   721 <read>
      e7:	83 c4 10             	add    $0x10,%esp
      ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
      ed:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      f1:	0f 8f 1f ff ff ff    	jg     16 <grep+0x16>
    }
  }
}
      f7:	90                   	nop
      f8:	90                   	nop
      f9:	c9                   	leave  
      fa:	c3                   	ret    

000000fb <main>:

int
main(int argc, char *argv[])
{
      fb:	f3 0f 1e fb          	endbr32 
      ff:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     103:	83 e4 f0             	and    $0xfffffff0,%esp
     106:	ff 71 fc             	pushl  -0x4(%ecx)
     109:	55                   	push   %ebp
     10a:	89 e5                	mov    %esp,%ebp
     10c:	53                   	push   %ebx
     10d:	51                   	push   %ecx
     10e:	83 ec 10             	sub    $0x10,%esp
     111:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
     113:	83 3b 01             	cmpl   $0x1,(%ebx)
     116:	7f 17                	jg     12f <main+0x34>
    printf(2, "usage: grep pattern [file ...]\n");
     118:	83 ec 08             	sub    $0x8,%esp
     11b:	68 f0 11 00 00       	push   $0x11f0
     120:	6a 02                	push   $0x2
     122:	e8 ae 07 00 00       	call   8d5 <printf>
     127:	83 c4 10             	add    $0x10,%esp
    exit();
     12a:	e8 da 05 00 00       	call   709 <exit>
  }
  pattern = argv[1];
     12f:	8b 43 04             	mov    0x4(%ebx),%eax
     132:	8b 40 04             	mov    0x4(%eax),%eax
     135:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  if(argc <= 2){
     138:	83 3b 02             	cmpl   $0x2,(%ebx)
     13b:	7f 15                	jg     152 <main+0x57>
    grep(pattern, 0);
     13d:	83 ec 08             	sub    $0x8,%esp
     140:	6a 00                	push   $0x0
     142:	ff 75 f0             	pushl  -0x10(%ebp)
     145:	e8 b6 fe ff ff       	call   0 <grep>
     14a:	83 c4 10             	add    $0x10,%esp
    exit();
     14d:	e8 b7 05 00 00       	call   709 <exit>
  }

  for(i = 2; i < argc; i++){
     152:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
     159:	eb 74                	jmp    1cf <main+0xd4>
    if((fd = open(argv[i], 0)) < 0){
     15b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     15e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     165:	8b 43 04             	mov    0x4(%ebx),%eax
     168:	01 d0                	add    %edx,%eax
     16a:	8b 00                	mov    (%eax),%eax
     16c:	83 ec 08             	sub    $0x8,%esp
     16f:	6a 00                	push   $0x0
     171:	50                   	push   %eax
     172:	e8 d2 05 00 00       	call   749 <open>
     177:	83 c4 10             	add    $0x10,%esp
     17a:	89 45 ec             	mov    %eax,-0x14(%ebp)
     17d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     181:	79 29                	jns    1ac <main+0xb1>
      printf(1, "grep: cannot open %s\n", argv[i]);
     183:	8b 45 f4             	mov    -0xc(%ebp),%eax
     186:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     18d:	8b 43 04             	mov    0x4(%ebx),%eax
     190:	01 d0                	add    %edx,%eax
     192:	8b 00                	mov    (%eax),%eax
     194:	83 ec 04             	sub    $0x4,%esp
     197:	50                   	push   %eax
     198:	68 10 12 00 00       	push   $0x1210
     19d:	6a 01                	push   $0x1
     19f:	e8 31 07 00 00       	call   8d5 <printf>
     1a4:	83 c4 10             	add    $0x10,%esp
      exit();
     1a7:	e8 5d 05 00 00       	call   709 <exit>
    }
    grep(pattern, fd);
     1ac:	83 ec 08             	sub    $0x8,%esp
     1af:	ff 75 ec             	pushl  -0x14(%ebp)
     1b2:	ff 75 f0             	pushl  -0x10(%ebp)
     1b5:	e8 46 fe ff ff       	call   0 <grep>
     1ba:	83 c4 10             	add    $0x10,%esp
    close(fd);
     1bd:	83 ec 0c             	sub    $0xc,%esp
     1c0:	ff 75 ec             	pushl  -0x14(%ebp)
     1c3:	e8 69 05 00 00       	call   731 <close>
     1c8:	83 c4 10             	add    $0x10,%esp
  for(i = 2; i < argc; i++){
     1cb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1d2:	3b 03                	cmp    (%ebx),%eax
     1d4:	7c 85                	jl     15b <main+0x60>
  }
  exit();
     1d6:	e8 2e 05 00 00       	call   709 <exit>

000001db <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     1db:	f3 0f 1e fb          	endbr32 
     1df:	55                   	push   %ebp
     1e0:	89 e5                	mov    %esp,%ebp
     1e2:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
     1e5:	8b 45 08             	mov    0x8(%ebp),%eax
     1e8:	0f b6 00             	movzbl (%eax),%eax
     1eb:	3c 5e                	cmp    $0x5e,%al
     1ed:	75 17                	jne    206 <match+0x2b>
    return matchhere(re+1, text);
     1ef:	8b 45 08             	mov    0x8(%ebp),%eax
     1f2:	83 c0 01             	add    $0x1,%eax
     1f5:	83 ec 08             	sub    $0x8,%esp
     1f8:	ff 75 0c             	pushl  0xc(%ebp)
     1fb:	50                   	push   %eax
     1fc:	e8 38 00 00 00       	call   239 <matchhere>
     201:	83 c4 10             	add    $0x10,%esp
     204:	eb 31                	jmp    237 <match+0x5c>
  do{  // must look at empty string
    if(matchhere(re, text))
     206:	83 ec 08             	sub    $0x8,%esp
     209:	ff 75 0c             	pushl  0xc(%ebp)
     20c:	ff 75 08             	pushl  0x8(%ebp)
     20f:	e8 25 00 00 00       	call   239 <matchhere>
     214:	83 c4 10             	add    $0x10,%esp
     217:	85 c0                	test   %eax,%eax
     219:	74 07                	je     222 <match+0x47>
      return 1;
     21b:	b8 01 00 00 00       	mov    $0x1,%eax
     220:	eb 15                	jmp    237 <match+0x5c>
  }while(*text++ != '\0');
     222:	8b 45 0c             	mov    0xc(%ebp),%eax
     225:	8d 50 01             	lea    0x1(%eax),%edx
     228:	89 55 0c             	mov    %edx,0xc(%ebp)
     22b:	0f b6 00             	movzbl (%eax),%eax
     22e:	84 c0                	test   %al,%al
     230:	75 d4                	jne    206 <match+0x2b>
  return 0;
     232:	b8 00 00 00 00       	mov    $0x0,%eax
}
     237:	c9                   	leave  
     238:	c3                   	ret    

00000239 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     239:	f3 0f 1e fb          	endbr32 
     23d:	55                   	push   %ebp
     23e:	89 e5                	mov    %esp,%ebp
     240:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
     243:	8b 45 08             	mov    0x8(%ebp),%eax
     246:	0f b6 00             	movzbl (%eax),%eax
     249:	84 c0                	test   %al,%al
     24b:	75 0a                	jne    257 <matchhere+0x1e>
    return 1;
     24d:	b8 01 00 00 00       	mov    $0x1,%eax
     252:	e9 99 00 00 00       	jmp    2f0 <matchhere+0xb7>
  if(re[1] == '*')
     257:	8b 45 08             	mov    0x8(%ebp),%eax
     25a:	83 c0 01             	add    $0x1,%eax
     25d:	0f b6 00             	movzbl (%eax),%eax
     260:	3c 2a                	cmp    $0x2a,%al
     262:	75 21                	jne    285 <matchhere+0x4c>
    return matchstar(re[0], re+2, text);
     264:	8b 45 08             	mov    0x8(%ebp),%eax
     267:	8d 50 02             	lea    0x2(%eax),%edx
     26a:	8b 45 08             	mov    0x8(%ebp),%eax
     26d:	0f b6 00             	movzbl (%eax),%eax
     270:	0f be c0             	movsbl %al,%eax
     273:	83 ec 04             	sub    $0x4,%esp
     276:	ff 75 0c             	pushl  0xc(%ebp)
     279:	52                   	push   %edx
     27a:	50                   	push   %eax
     27b:	e8 72 00 00 00       	call   2f2 <matchstar>
     280:	83 c4 10             	add    $0x10,%esp
     283:	eb 6b                	jmp    2f0 <matchhere+0xb7>
  if(re[0] == '$' && re[1] == '\0')
     285:	8b 45 08             	mov    0x8(%ebp),%eax
     288:	0f b6 00             	movzbl (%eax),%eax
     28b:	3c 24                	cmp    $0x24,%al
     28d:	75 1d                	jne    2ac <matchhere+0x73>
     28f:	8b 45 08             	mov    0x8(%ebp),%eax
     292:	83 c0 01             	add    $0x1,%eax
     295:	0f b6 00             	movzbl (%eax),%eax
     298:	84 c0                	test   %al,%al
     29a:	75 10                	jne    2ac <matchhere+0x73>
    return *text == '\0';
     29c:	8b 45 0c             	mov    0xc(%ebp),%eax
     29f:	0f b6 00             	movzbl (%eax),%eax
     2a2:	84 c0                	test   %al,%al
     2a4:	0f 94 c0             	sete   %al
     2a7:	0f b6 c0             	movzbl %al,%eax
     2aa:	eb 44                	jmp    2f0 <matchhere+0xb7>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     2ac:	8b 45 0c             	mov    0xc(%ebp),%eax
     2af:	0f b6 00             	movzbl (%eax),%eax
     2b2:	84 c0                	test   %al,%al
     2b4:	74 35                	je     2eb <matchhere+0xb2>
     2b6:	8b 45 08             	mov    0x8(%ebp),%eax
     2b9:	0f b6 00             	movzbl (%eax),%eax
     2bc:	3c 2e                	cmp    $0x2e,%al
     2be:	74 10                	je     2d0 <matchhere+0x97>
     2c0:	8b 45 08             	mov    0x8(%ebp),%eax
     2c3:	0f b6 10             	movzbl (%eax),%edx
     2c6:	8b 45 0c             	mov    0xc(%ebp),%eax
     2c9:	0f b6 00             	movzbl (%eax),%eax
     2cc:	38 c2                	cmp    %al,%dl
     2ce:	75 1b                	jne    2eb <matchhere+0xb2>
    return matchhere(re+1, text+1);
     2d0:	8b 45 0c             	mov    0xc(%ebp),%eax
     2d3:	8d 50 01             	lea    0x1(%eax),%edx
     2d6:	8b 45 08             	mov    0x8(%ebp),%eax
     2d9:	83 c0 01             	add    $0x1,%eax
     2dc:	83 ec 08             	sub    $0x8,%esp
     2df:	52                   	push   %edx
     2e0:	50                   	push   %eax
     2e1:	e8 53 ff ff ff       	call   239 <matchhere>
     2e6:	83 c4 10             	add    $0x10,%esp
     2e9:	eb 05                	jmp    2f0 <matchhere+0xb7>
  return 0;
     2eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2f0:	c9                   	leave  
     2f1:	c3                   	ret    

000002f2 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     2f2:	f3 0f 1e fb          	endbr32 
     2f6:	55                   	push   %ebp
     2f7:	89 e5                	mov    %esp,%ebp
     2f9:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
     2fc:	83 ec 08             	sub    $0x8,%esp
     2ff:	ff 75 10             	pushl  0x10(%ebp)
     302:	ff 75 0c             	pushl  0xc(%ebp)
     305:	e8 2f ff ff ff       	call   239 <matchhere>
     30a:	83 c4 10             	add    $0x10,%esp
     30d:	85 c0                	test   %eax,%eax
     30f:	74 07                	je     318 <matchstar+0x26>
      return 1;
     311:	b8 01 00 00 00       	mov    $0x1,%eax
     316:	eb 29                	jmp    341 <matchstar+0x4f>
  }while(*text!='\0' && (*text++==c || c=='.'));
     318:	8b 45 10             	mov    0x10(%ebp),%eax
     31b:	0f b6 00             	movzbl (%eax),%eax
     31e:	84 c0                	test   %al,%al
     320:	74 1a                	je     33c <matchstar+0x4a>
     322:	8b 45 10             	mov    0x10(%ebp),%eax
     325:	8d 50 01             	lea    0x1(%eax),%edx
     328:	89 55 10             	mov    %edx,0x10(%ebp)
     32b:	0f b6 00             	movzbl (%eax),%eax
     32e:	0f be c0             	movsbl %al,%eax
     331:	39 45 08             	cmp    %eax,0x8(%ebp)
     334:	74 c6                	je     2fc <matchstar+0xa>
     336:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
     33a:	74 c0                	je     2fc <matchstar+0xa>
  return 0;
     33c:	b8 00 00 00 00       	mov    $0x0,%eax
}
     341:	c9                   	leave  
     342:	c3                   	ret    

00000343 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     343:	55                   	push   %ebp
     344:	89 e5                	mov    %esp,%ebp
     346:	57                   	push   %edi
     347:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     348:	8b 4d 08             	mov    0x8(%ebp),%ecx
     34b:	8b 55 10             	mov    0x10(%ebp),%edx
     34e:	8b 45 0c             	mov    0xc(%ebp),%eax
     351:	89 cb                	mov    %ecx,%ebx
     353:	89 df                	mov    %ebx,%edi
     355:	89 d1                	mov    %edx,%ecx
     357:	fc                   	cld    
     358:	f3 aa                	rep stos %al,%es:(%edi)
     35a:	89 ca                	mov    %ecx,%edx
     35c:	89 fb                	mov    %edi,%ebx
     35e:	89 5d 08             	mov    %ebx,0x8(%ebp)
     361:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     364:	90                   	nop
     365:	5b                   	pop    %ebx
     366:	5f                   	pop    %edi
     367:	5d                   	pop    %ebp
     368:	c3                   	ret    

00000369 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     369:	f3 0f 1e fb          	endbr32 
     36d:	55                   	push   %ebp
     36e:	89 e5                	mov    %esp,%ebp
     370:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     373:	8b 45 08             	mov    0x8(%ebp),%eax
     376:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     379:	90                   	nop
     37a:	8b 55 0c             	mov    0xc(%ebp),%edx
     37d:	8d 42 01             	lea    0x1(%edx),%eax
     380:	89 45 0c             	mov    %eax,0xc(%ebp)
     383:	8b 45 08             	mov    0x8(%ebp),%eax
     386:	8d 48 01             	lea    0x1(%eax),%ecx
     389:	89 4d 08             	mov    %ecx,0x8(%ebp)
     38c:	0f b6 12             	movzbl (%edx),%edx
     38f:	88 10                	mov    %dl,(%eax)
     391:	0f b6 00             	movzbl (%eax),%eax
     394:	84 c0                	test   %al,%al
     396:	75 e2                	jne    37a <strcpy+0x11>
    ;
  return os;
     398:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     39b:	c9                   	leave  
     39c:	c3                   	ret    

0000039d <strcmp>:

int
strcmp(const char *p, const char *q)
{
     39d:	f3 0f 1e fb          	endbr32 
     3a1:	55                   	push   %ebp
     3a2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     3a4:	eb 08                	jmp    3ae <strcmp+0x11>
    p++, q++;
     3a6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3aa:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     3ae:	8b 45 08             	mov    0x8(%ebp),%eax
     3b1:	0f b6 00             	movzbl (%eax),%eax
     3b4:	84 c0                	test   %al,%al
     3b6:	74 10                	je     3c8 <strcmp+0x2b>
     3b8:	8b 45 08             	mov    0x8(%ebp),%eax
     3bb:	0f b6 10             	movzbl (%eax),%edx
     3be:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c1:	0f b6 00             	movzbl (%eax),%eax
     3c4:	38 c2                	cmp    %al,%dl
     3c6:	74 de                	je     3a6 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
     3c8:	8b 45 08             	mov    0x8(%ebp),%eax
     3cb:	0f b6 00             	movzbl (%eax),%eax
     3ce:	0f b6 d0             	movzbl %al,%edx
     3d1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3d4:	0f b6 00             	movzbl (%eax),%eax
     3d7:	0f b6 c0             	movzbl %al,%eax
     3da:	29 c2                	sub    %eax,%edx
     3dc:	89 d0                	mov    %edx,%eax
}
     3de:	5d                   	pop    %ebp
     3df:	c3                   	ret    

000003e0 <strlen>:

uint
strlen(char *s)
{
     3e0:	f3 0f 1e fb          	endbr32 
     3e4:	55                   	push   %ebp
     3e5:	89 e5                	mov    %esp,%ebp
     3e7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     3ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     3f1:	eb 04                	jmp    3f7 <strlen+0x17>
     3f3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     3f7:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3fa:	8b 45 08             	mov    0x8(%ebp),%eax
     3fd:	01 d0                	add    %edx,%eax
     3ff:	0f b6 00             	movzbl (%eax),%eax
     402:	84 c0                	test   %al,%al
     404:	75 ed                	jne    3f3 <strlen+0x13>
    ;
  return n;
     406:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     409:	c9                   	leave  
     40a:	c3                   	ret    

0000040b <memset>:

void*
memset(void *dst, int c, uint n)
{
     40b:	f3 0f 1e fb          	endbr32 
     40f:	55                   	push   %ebp
     410:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     412:	8b 45 10             	mov    0x10(%ebp),%eax
     415:	50                   	push   %eax
     416:	ff 75 0c             	pushl  0xc(%ebp)
     419:	ff 75 08             	pushl  0x8(%ebp)
     41c:	e8 22 ff ff ff       	call   343 <stosb>
     421:	83 c4 0c             	add    $0xc,%esp
  return dst;
     424:	8b 45 08             	mov    0x8(%ebp),%eax
}
     427:	c9                   	leave  
     428:	c3                   	ret    

00000429 <strchr>:

char*
strchr(const char *s, char c)
{
     429:	f3 0f 1e fb          	endbr32 
     42d:	55                   	push   %ebp
     42e:	89 e5                	mov    %esp,%ebp
     430:	83 ec 04             	sub    $0x4,%esp
     433:	8b 45 0c             	mov    0xc(%ebp),%eax
     436:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     439:	eb 14                	jmp    44f <strchr+0x26>
    if(*s == c)
     43b:	8b 45 08             	mov    0x8(%ebp),%eax
     43e:	0f b6 00             	movzbl (%eax),%eax
     441:	38 45 fc             	cmp    %al,-0x4(%ebp)
     444:	75 05                	jne    44b <strchr+0x22>
      return (char*)s;
     446:	8b 45 08             	mov    0x8(%ebp),%eax
     449:	eb 13                	jmp    45e <strchr+0x35>
  for(; *s; s++)
     44b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     44f:	8b 45 08             	mov    0x8(%ebp),%eax
     452:	0f b6 00             	movzbl (%eax),%eax
     455:	84 c0                	test   %al,%al
     457:	75 e2                	jne    43b <strchr+0x12>
  return 0;
     459:	b8 00 00 00 00       	mov    $0x0,%eax
}
     45e:	c9                   	leave  
     45f:	c3                   	ret    

00000460 <gets>:

char*
gets(char *buf, int max)
{
     460:	f3 0f 1e fb          	endbr32 
     464:	55                   	push   %ebp
     465:	89 e5                	mov    %esp,%ebp
     467:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     46a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     471:	eb 42                	jmp    4b5 <gets+0x55>
    cc = read(0, &c, 1);
     473:	83 ec 04             	sub    $0x4,%esp
     476:	6a 01                	push   $0x1
     478:	8d 45 ef             	lea    -0x11(%ebp),%eax
     47b:	50                   	push   %eax
     47c:	6a 00                	push   $0x0
     47e:	e8 9e 02 00 00       	call   721 <read>
     483:	83 c4 10             	add    $0x10,%esp
     486:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     489:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     48d:	7e 33                	jle    4c2 <gets+0x62>
      break;
    buf[i++] = c;
     48f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     492:	8d 50 01             	lea    0x1(%eax),%edx
     495:	89 55 f4             	mov    %edx,-0xc(%ebp)
     498:	89 c2                	mov    %eax,%edx
     49a:	8b 45 08             	mov    0x8(%ebp),%eax
     49d:	01 c2                	add    %eax,%edx
     49f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4a3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     4a5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4a9:	3c 0a                	cmp    $0xa,%al
     4ab:	74 16                	je     4c3 <gets+0x63>
     4ad:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4b1:	3c 0d                	cmp    $0xd,%al
     4b3:	74 0e                	je     4c3 <gets+0x63>
  for(i=0; i+1 < max; ){
     4b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4b8:	83 c0 01             	add    $0x1,%eax
     4bb:	39 45 0c             	cmp    %eax,0xc(%ebp)
     4be:	7f b3                	jg     473 <gets+0x13>
     4c0:	eb 01                	jmp    4c3 <gets+0x63>
      break;
     4c2:	90                   	nop
      break;
  }
  buf[i] = '\0';
     4c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     4c6:	8b 45 08             	mov    0x8(%ebp),%eax
     4c9:	01 d0                	add    %edx,%eax
     4cb:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     4ce:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4d1:	c9                   	leave  
     4d2:	c3                   	ret    

000004d3 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
     4d3:	f3 0f 1e fb          	endbr32 
     4d7:	55                   	push   %ebp
     4d8:	89 e5                	mov    %esp,%ebp
     4da:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
     4dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4e4:	eb 43                	jmp    529 <fgets+0x56>
    int cc = read(fd, &c, 1);
     4e6:	83 ec 04             	sub    $0x4,%esp
     4e9:	6a 01                	push   $0x1
     4eb:	8d 45 ef             	lea    -0x11(%ebp),%eax
     4ee:	50                   	push   %eax
     4ef:	ff 75 10             	pushl  0x10(%ebp)
     4f2:	e8 2a 02 00 00       	call   721 <read>
     4f7:	83 c4 10             	add    $0x10,%esp
     4fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     4fd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     501:	7e 33                	jle    536 <fgets+0x63>
      break;
    buf[i++] = c;
     503:	8b 45 f4             	mov    -0xc(%ebp),%eax
     506:	8d 50 01             	lea    0x1(%eax),%edx
     509:	89 55 f4             	mov    %edx,-0xc(%ebp)
     50c:	89 c2                	mov    %eax,%edx
     50e:	8b 45 08             	mov    0x8(%ebp),%eax
     511:	01 c2                	add    %eax,%edx
     513:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     517:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     519:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     51d:	3c 0a                	cmp    $0xa,%al
     51f:	74 16                	je     537 <fgets+0x64>
     521:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     525:	3c 0d                	cmp    $0xd,%al
     527:	74 0e                	je     537 <fgets+0x64>
  for(i = 0; i + 1 < size;){
     529:	8b 45 f4             	mov    -0xc(%ebp),%eax
     52c:	83 c0 01             	add    $0x1,%eax
     52f:	39 45 0c             	cmp    %eax,0xc(%ebp)
     532:	7f b2                	jg     4e6 <fgets+0x13>
     534:	eb 01                	jmp    537 <fgets+0x64>
      break;
     536:	90                   	nop
      break;
  }
  buf[i] = '\0';
     537:	8b 55 f4             	mov    -0xc(%ebp),%edx
     53a:	8b 45 08             	mov    0x8(%ebp),%eax
     53d:	01 d0                	add    %edx,%eax
     53f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     542:	8b 45 08             	mov    0x8(%ebp),%eax
}
     545:	c9                   	leave  
     546:	c3                   	ret    

00000547 <stat>:

int
stat(char *n, struct stat *st)
{
     547:	f3 0f 1e fb          	endbr32 
     54b:	55                   	push   %ebp
     54c:	89 e5                	mov    %esp,%ebp
     54e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     551:	83 ec 08             	sub    $0x8,%esp
     554:	6a 00                	push   $0x0
     556:	ff 75 08             	pushl  0x8(%ebp)
     559:	e8 eb 01 00 00       	call   749 <open>
     55e:	83 c4 10             	add    $0x10,%esp
     561:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     564:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     568:	79 07                	jns    571 <stat+0x2a>
    return -1;
     56a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     56f:	eb 25                	jmp    596 <stat+0x4f>
  r = fstat(fd, st);
     571:	83 ec 08             	sub    $0x8,%esp
     574:	ff 75 0c             	pushl  0xc(%ebp)
     577:	ff 75 f4             	pushl  -0xc(%ebp)
     57a:	e8 e2 01 00 00       	call   761 <fstat>
     57f:	83 c4 10             	add    $0x10,%esp
     582:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     585:	83 ec 0c             	sub    $0xc,%esp
     588:	ff 75 f4             	pushl  -0xc(%ebp)
     58b:	e8 a1 01 00 00       	call   731 <close>
     590:	83 c4 10             	add    $0x10,%esp
  return r;
     593:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     596:	c9                   	leave  
     597:	c3                   	ret    

00000598 <atoi>:

int
atoi(const char *s)
{
     598:	f3 0f 1e fb          	endbr32 
     59c:	55                   	push   %ebp
     59d:	89 e5                	mov    %esp,%ebp
     59f:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     5a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     5a9:	eb 04                	jmp    5af <atoi+0x17>
     5ab:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     5af:	8b 45 08             	mov    0x8(%ebp),%eax
     5b2:	0f b6 00             	movzbl (%eax),%eax
     5b5:	3c 20                	cmp    $0x20,%al
     5b7:	74 f2                	je     5ab <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
     5b9:	8b 45 08             	mov    0x8(%ebp),%eax
     5bc:	0f b6 00             	movzbl (%eax),%eax
     5bf:	3c 2d                	cmp    $0x2d,%al
     5c1:	75 07                	jne    5ca <atoi+0x32>
     5c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     5c8:	eb 05                	jmp    5cf <atoi+0x37>
     5ca:	b8 01 00 00 00       	mov    $0x1,%eax
     5cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     5d2:	8b 45 08             	mov    0x8(%ebp),%eax
     5d5:	0f b6 00             	movzbl (%eax),%eax
     5d8:	3c 2b                	cmp    $0x2b,%al
     5da:	74 0a                	je     5e6 <atoi+0x4e>
     5dc:	8b 45 08             	mov    0x8(%ebp),%eax
     5df:	0f b6 00             	movzbl (%eax),%eax
     5e2:	3c 2d                	cmp    $0x2d,%al
     5e4:	75 2b                	jne    611 <atoi+0x79>
    s++;
     5e6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     5ea:	eb 25                	jmp    611 <atoi+0x79>
    n = n*10 + *s++ - '0';
     5ec:	8b 55 fc             	mov    -0x4(%ebp),%edx
     5ef:	89 d0                	mov    %edx,%eax
     5f1:	c1 e0 02             	shl    $0x2,%eax
     5f4:	01 d0                	add    %edx,%eax
     5f6:	01 c0                	add    %eax,%eax
     5f8:	89 c1                	mov    %eax,%ecx
     5fa:	8b 45 08             	mov    0x8(%ebp),%eax
     5fd:	8d 50 01             	lea    0x1(%eax),%edx
     600:	89 55 08             	mov    %edx,0x8(%ebp)
     603:	0f b6 00             	movzbl (%eax),%eax
     606:	0f be c0             	movsbl %al,%eax
     609:	01 c8                	add    %ecx,%eax
     60b:	83 e8 30             	sub    $0x30,%eax
     60e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     611:	8b 45 08             	mov    0x8(%ebp),%eax
     614:	0f b6 00             	movzbl (%eax),%eax
     617:	3c 2f                	cmp    $0x2f,%al
     619:	7e 0a                	jle    625 <atoi+0x8d>
     61b:	8b 45 08             	mov    0x8(%ebp),%eax
     61e:	0f b6 00             	movzbl (%eax),%eax
     621:	3c 39                	cmp    $0x39,%al
     623:	7e c7                	jle    5ec <atoi+0x54>
  return sign*n;
     625:	8b 45 f8             	mov    -0x8(%ebp),%eax
     628:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     62c:	c9                   	leave  
     62d:	c3                   	ret    

0000062e <atoo>:

int
atoo(const char *s)
{
     62e:	f3 0f 1e fb          	endbr32 
     632:	55                   	push   %ebp
     633:	89 e5                	mov    %esp,%ebp
     635:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     638:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     63f:	eb 04                	jmp    645 <atoo+0x17>
     641:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     645:	8b 45 08             	mov    0x8(%ebp),%eax
     648:	0f b6 00             	movzbl (%eax),%eax
     64b:	3c 20                	cmp    $0x20,%al
     64d:	74 f2                	je     641 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
     64f:	8b 45 08             	mov    0x8(%ebp),%eax
     652:	0f b6 00             	movzbl (%eax),%eax
     655:	3c 2d                	cmp    $0x2d,%al
     657:	75 07                	jne    660 <atoo+0x32>
     659:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     65e:	eb 05                	jmp    665 <atoo+0x37>
     660:	b8 01 00 00 00       	mov    $0x1,%eax
     665:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     668:	8b 45 08             	mov    0x8(%ebp),%eax
     66b:	0f b6 00             	movzbl (%eax),%eax
     66e:	3c 2b                	cmp    $0x2b,%al
     670:	74 0a                	je     67c <atoo+0x4e>
     672:	8b 45 08             	mov    0x8(%ebp),%eax
     675:	0f b6 00             	movzbl (%eax),%eax
     678:	3c 2d                	cmp    $0x2d,%al
     67a:	75 27                	jne    6a3 <atoo+0x75>
    s++;
     67c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     680:	eb 21                	jmp    6a3 <atoo+0x75>
    n = n*8 + *s++ - '0';
     682:	8b 45 fc             	mov    -0x4(%ebp),%eax
     685:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     68c:	8b 45 08             	mov    0x8(%ebp),%eax
     68f:	8d 50 01             	lea    0x1(%eax),%edx
     692:	89 55 08             	mov    %edx,0x8(%ebp)
     695:	0f b6 00             	movzbl (%eax),%eax
     698:	0f be c0             	movsbl %al,%eax
     69b:	01 c8                	add    %ecx,%eax
     69d:	83 e8 30             	sub    $0x30,%eax
     6a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
     6a3:	8b 45 08             	mov    0x8(%ebp),%eax
     6a6:	0f b6 00             	movzbl (%eax),%eax
     6a9:	3c 2f                	cmp    $0x2f,%al
     6ab:	7e 0a                	jle    6b7 <atoo+0x89>
     6ad:	8b 45 08             	mov    0x8(%ebp),%eax
     6b0:	0f b6 00             	movzbl (%eax),%eax
     6b3:	3c 37                	cmp    $0x37,%al
     6b5:	7e cb                	jle    682 <atoo+0x54>
  return sign*n;
     6b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ba:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     6be:	c9                   	leave  
     6bf:	c3                   	ret    

000006c0 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     6c0:	f3 0f 1e fb          	endbr32 
     6c4:	55                   	push   %ebp
     6c5:	89 e5                	mov    %esp,%ebp
     6c7:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     6ca:	8b 45 08             	mov    0x8(%ebp),%eax
     6cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     6d0:	8b 45 0c             	mov    0xc(%ebp),%eax
     6d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     6d6:	eb 17                	jmp    6ef <memmove+0x2f>
    *dst++ = *src++;
     6d8:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6db:	8d 42 01             	lea    0x1(%edx),%eax
     6de:	89 45 f8             	mov    %eax,-0x8(%ebp)
     6e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e4:	8d 48 01             	lea    0x1(%eax),%ecx
     6e7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     6ea:	0f b6 12             	movzbl (%edx),%edx
     6ed:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     6ef:	8b 45 10             	mov    0x10(%ebp),%eax
     6f2:	8d 50 ff             	lea    -0x1(%eax),%edx
     6f5:	89 55 10             	mov    %edx,0x10(%ebp)
     6f8:	85 c0                	test   %eax,%eax
     6fa:	7f dc                	jg     6d8 <memmove+0x18>
  return vdst;
     6fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
     6ff:	c9                   	leave  
     700:	c3                   	ret    

00000701 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     701:	b8 01 00 00 00       	mov    $0x1,%eax
     706:	cd 40                	int    $0x40
     708:	c3                   	ret    

00000709 <exit>:
SYSCALL(exit)
     709:	b8 02 00 00 00       	mov    $0x2,%eax
     70e:	cd 40                	int    $0x40
     710:	c3                   	ret    

00000711 <wait>:
SYSCALL(wait)
     711:	b8 03 00 00 00       	mov    $0x3,%eax
     716:	cd 40                	int    $0x40
     718:	c3                   	ret    

00000719 <pipe>:
SYSCALL(pipe)
     719:	b8 04 00 00 00       	mov    $0x4,%eax
     71e:	cd 40                	int    $0x40
     720:	c3                   	ret    

00000721 <read>:
SYSCALL(read)
     721:	b8 05 00 00 00       	mov    $0x5,%eax
     726:	cd 40                	int    $0x40
     728:	c3                   	ret    

00000729 <write>:
SYSCALL(write)
     729:	b8 10 00 00 00       	mov    $0x10,%eax
     72e:	cd 40                	int    $0x40
     730:	c3                   	ret    

00000731 <close>:
SYSCALL(close)
     731:	b8 15 00 00 00       	mov    $0x15,%eax
     736:	cd 40                	int    $0x40
     738:	c3                   	ret    

00000739 <kill>:
SYSCALL(kill)
     739:	b8 06 00 00 00       	mov    $0x6,%eax
     73e:	cd 40                	int    $0x40
     740:	c3                   	ret    

00000741 <exec>:
SYSCALL(exec)
     741:	b8 07 00 00 00       	mov    $0x7,%eax
     746:	cd 40                	int    $0x40
     748:	c3                   	ret    

00000749 <open>:
SYSCALL(open)
     749:	b8 0f 00 00 00       	mov    $0xf,%eax
     74e:	cd 40                	int    $0x40
     750:	c3                   	ret    

00000751 <mknod>:
SYSCALL(mknod)
     751:	b8 11 00 00 00       	mov    $0x11,%eax
     756:	cd 40                	int    $0x40
     758:	c3                   	ret    

00000759 <unlink>:
SYSCALL(unlink)
     759:	b8 12 00 00 00       	mov    $0x12,%eax
     75e:	cd 40                	int    $0x40
     760:	c3                   	ret    

00000761 <fstat>:
SYSCALL(fstat)
     761:	b8 08 00 00 00       	mov    $0x8,%eax
     766:	cd 40                	int    $0x40
     768:	c3                   	ret    

00000769 <link>:
SYSCALL(link)
     769:	b8 13 00 00 00       	mov    $0x13,%eax
     76e:	cd 40                	int    $0x40
     770:	c3                   	ret    

00000771 <mkdir>:
SYSCALL(mkdir)
     771:	b8 14 00 00 00       	mov    $0x14,%eax
     776:	cd 40                	int    $0x40
     778:	c3                   	ret    

00000779 <chdir>:
SYSCALL(chdir)
     779:	b8 09 00 00 00       	mov    $0x9,%eax
     77e:	cd 40                	int    $0x40
     780:	c3                   	ret    

00000781 <dup>:
SYSCALL(dup)
     781:	b8 0a 00 00 00       	mov    $0xa,%eax
     786:	cd 40                	int    $0x40
     788:	c3                   	ret    

00000789 <getpid>:
SYSCALL(getpid)
     789:	b8 0b 00 00 00       	mov    $0xb,%eax
     78e:	cd 40                	int    $0x40
     790:	c3                   	ret    

00000791 <sbrk>:
SYSCALL(sbrk)
     791:	b8 0c 00 00 00       	mov    $0xc,%eax
     796:	cd 40                	int    $0x40
     798:	c3                   	ret    

00000799 <sleep>:
SYSCALL(sleep)
     799:	b8 0d 00 00 00       	mov    $0xd,%eax
     79e:	cd 40                	int    $0x40
     7a0:	c3                   	ret    

000007a1 <uptime>:
SYSCALL(uptime)
     7a1:	b8 0e 00 00 00       	mov    $0xe,%eax
     7a6:	cd 40                	int    $0x40
     7a8:	c3                   	ret    

000007a9 <halt>:
SYSCALL(halt)
     7a9:	b8 16 00 00 00       	mov    $0x16,%eax
     7ae:	cd 40                	int    $0x40
     7b0:	c3                   	ret    

000007b1 <date>:
SYSCALL(date)
     7b1:	b8 17 00 00 00       	mov    $0x17,%eax
     7b6:	cd 40                	int    $0x40
     7b8:	c3                   	ret    

000007b9 <getuid>:
SYSCALL(getuid)
     7b9:	b8 18 00 00 00       	mov    $0x18,%eax
     7be:	cd 40                	int    $0x40
     7c0:	c3                   	ret    

000007c1 <getgid>:
SYSCALL(getgid)
     7c1:	b8 19 00 00 00       	mov    $0x19,%eax
     7c6:	cd 40                	int    $0x40
     7c8:	c3                   	ret    

000007c9 <getppid>:
SYSCALL(getppid)
     7c9:	b8 1a 00 00 00       	mov    $0x1a,%eax
     7ce:	cd 40                	int    $0x40
     7d0:	c3                   	ret    

000007d1 <setuid>:
SYSCALL(setuid)
     7d1:	b8 1b 00 00 00       	mov    $0x1b,%eax
     7d6:	cd 40                	int    $0x40
     7d8:	c3                   	ret    

000007d9 <setgid>:
SYSCALL(setgid)
     7d9:	b8 1c 00 00 00       	mov    $0x1c,%eax
     7de:	cd 40                	int    $0x40
     7e0:	c3                   	ret    

000007e1 <getprocs>:
SYSCALL(getprocs)
     7e1:	b8 1d 00 00 00       	mov    $0x1d,%eax
     7e6:	cd 40                	int    $0x40
     7e8:	c3                   	ret    

000007e9 <setpriority>:
SYSCALL(setpriority)
     7e9:	b8 1e 00 00 00       	mov    $0x1e,%eax
     7ee:	cd 40                	int    $0x40
     7f0:	c3                   	ret    

000007f1 <chown>:
SYSCALL(chown)
     7f1:	b8 1f 00 00 00       	mov    $0x1f,%eax
     7f6:	cd 40                	int    $0x40
     7f8:	c3                   	ret    

000007f9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     7f9:	f3 0f 1e fb          	endbr32 
     7fd:	55                   	push   %ebp
     7fe:	89 e5                	mov    %esp,%ebp
     800:	83 ec 18             	sub    $0x18,%esp
     803:	8b 45 0c             	mov    0xc(%ebp),%eax
     806:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     809:	83 ec 04             	sub    $0x4,%esp
     80c:	6a 01                	push   $0x1
     80e:	8d 45 f4             	lea    -0xc(%ebp),%eax
     811:	50                   	push   %eax
     812:	ff 75 08             	pushl  0x8(%ebp)
     815:	e8 0f ff ff ff       	call   729 <write>
     81a:	83 c4 10             	add    $0x10,%esp
}
     81d:	90                   	nop
     81e:	c9                   	leave  
     81f:	c3                   	ret    

00000820 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     820:	f3 0f 1e fb          	endbr32 
     824:	55                   	push   %ebp
     825:	89 e5                	mov    %esp,%ebp
     827:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     82a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     831:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     835:	74 17                	je     84e <printint+0x2e>
     837:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     83b:	79 11                	jns    84e <printint+0x2e>
    neg = 1;
     83d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     844:	8b 45 0c             	mov    0xc(%ebp),%eax
     847:	f7 d8                	neg    %eax
     849:	89 45 ec             	mov    %eax,-0x14(%ebp)
     84c:	eb 06                	jmp    854 <printint+0x34>
  } else {
    x = xx;
     84e:	8b 45 0c             	mov    0xc(%ebp),%eax
     851:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     854:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     85b:	8b 4d 10             	mov    0x10(%ebp),%ecx
     85e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     861:	ba 00 00 00 00       	mov    $0x0,%edx
     866:	f7 f1                	div    %ecx
     868:	89 d1                	mov    %edx,%ecx
     86a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86d:	8d 50 01             	lea    0x1(%eax),%edx
     870:	89 55 f4             	mov    %edx,-0xc(%ebp)
     873:	0f b6 91 d8 16 00 00 	movzbl 0x16d8(%ecx),%edx
     87a:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     87e:	8b 4d 10             	mov    0x10(%ebp),%ecx
     881:	8b 45 ec             	mov    -0x14(%ebp),%eax
     884:	ba 00 00 00 00       	mov    $0x0,%edx
     889:	f7 f1                	div    %ecx
     88b:	89 45 ec             	mov    %eax,-0x14(%ebp)
     88e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     892:	75 c7                	jne    85b <printint+0x3b>
  if(neg)
     894:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     898:	74 2d                	je     8c7 <printint+0xa7>
    buf[i++] = '-';
     89a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     89d:	8d 50 01             	lea    0x1(%eax),%edx
     8a0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     8a3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     8a8:	eb 1d                	jmp    8c7 <printint+0xa7>
    putc(fd, buf[i]);
     8aa:	8d 55 dc             	lea    -0x24(%ebp),%edx
     8ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8b0:	01 d0                	add    %edx,%eax
     8b2:	0f b6 00             	movzbl (%eax),%eax
     8b5:	0f be c0             	movsbl %al,%eax
     8b8:	83 ec 08             	sub    $0x8,%esp
     8bb:	50                   	push   %eax
     8bc:	ff 75 08             	pushl  0x8(%ebp)
     8bf:	e8 35 ff ff ff       	call   7f9 <putc>
     8c4:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     8c7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     8cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8cf:	79 d9                	jns    8aa <printint+0x8a>
}
     8d1:	90                   	nop
     8d2:	90                   	nop
     8d3:	c9                   	leave  
     8d4:	c3                   	ret    

000008d5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     8d5:	f3 0f 1e fb          	endbr32 
     8d9:	55                   	push   %ebp
     8da:	89 e5                	mov    %esp,%ebp
     8dc:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     8df:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     8e6:	8d 45 0c             	lea    0xc(%ebp),%eax
     8e9:	83 c0 04             	add    $0x4,%eax
     8ec:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     8ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     8f6:	e9 59 01 00 00       	jmp    a54 <printf+0x17f>
    c = fmt[i] & 0xff;
     8fb:	8b 55 0c             	mov    0xc(%ebp),%edx
     8fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     901:	01 d0                	add    %edx,%eax
     903:	0f b6 00             	movzbl (%eax),%eax
     906:	0f be c0             	movsbl %al,%eax
     909:	25 ff 00 00 00       	and    $0xff,%eax
     90e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     911:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     915:	75 2c                	jne    943 <printf+0x6e>
      if(c == '%'){
     917:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     91b:	75 0c                	jne    929 <printf+0x54>
        state = '%';
     91d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     924:	e9 27 01 00 00       	jmp    a50 <printf+0x17b>
      } else {
        putc(fd, c);
     929:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     92c:	0f be c0             	movsbl %al,%eax
     92f:	83 ec 08             	sub    $0x8,%esp
     932:	50                   	push   %eax
     933:	ff 75 08             	pushl  0x8(%ebp)
     936:	e8 be fe ff ff       	call   7f9 <putc>
     93b:	83 c4 10             	add    $0x10,%esp
     93e:	e9 0d 01 00 00       	jmp    a50 <printf+0x17b>
      }
    } else if(state == '%'){
     943:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     947:	0f 85 03 01 00 00    	jne    a50 <printf+0x17b>
      if(c == 'd'){
     94d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     951:	75 1e                	jne    971 <printf+0x9c>
        printint(fd, *ap, 10, 1);
     953:	8b 45 e8             	mov    -0x18(%ebp),%eax
     956:	8b 00                	mov    (%eax),%eax
     958:	6a 01                	push   $0x1
     95a:	6a 0a                	push   $0xa
     95c:	50                   	push   %eax
     95d:	ff 75 08             	pushl  0x8(%ebp)
     960:	e8 bb fe ff ff       	call   820 <printint>
     965:	83 c4 10             	add    $0x10,%esp
        ap++;
     968:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     96c:	e9 d8 00 00 00       	jmp    a49 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
     971:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     975:	74 06                	je     97d <printf+0xa8>
     977:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     97b:	75 1e                	jne    99b <printf+0xc6>
        printint(fd, *ap, 16, 0);
     97d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     980:	8b 00                	mov    (%eax),%eax
     982:	6a 00                	push   $0x0
     984:	6a 10                	push   $0x10
     986:	50                   	push   %eax
     987:	ff 75 08             	pushl  0x8(%ebp)
     98a:	e8 91 fe ff ff       	call   820 <printint>
     98f:	83 c4 10             	add    $0x10,%esp
        ap++;
     992:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     996:	e9 ae 00 00 00       	jmp    a49 <printf+0x174>
      } else if(c == 's'){
     99b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     99f:	75 43                	jne    9e4 <printf+0x10f>
        s = (char*)*ap;
     9a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9a4:	8b 00                	mov    (%eax),%eax
     9a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     9a9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     9ad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     9b1:	75 25                	jne    9d8 <printf+0x103>
          s = "(null)";
     9b3:	c7 45 f4 26 12 00 00 	movl   $0x1226,-0xc(%ebp)
        while(*s != 0){
     9ba:	eb 1c                	jmp    9d8 <printf+0x103>
          putc(fd, *s);
     9bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9bf:	0f b6 00             	movzbl (%eax),%eax
     9c2:	0f be c0             	movsbl %al,%eax
     9c5:	83 ec 08             	sub    $0x8,%esp
     9c8:	50                   	push   %eax
     9c9:	ff 75 08             	pushl  0x8(%ebp)
     9cc:	e8 28 fe ff ff       	call   7f9 <putc>
     9d1:	83 c4 10             	add    $0x10,%esp
          s++;
     9d4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     9d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9db:	0f b6 00             	movzbl (%eax),%eax
     9de:	84 c0                	test   %al,%al
     9e0:	75 da                	jne    9bc <printf+0xe7>
     9e2:	eb 65                	jmp    a49 <printf+0x174>
        }
      } else if(c == 'c'){
     9e4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     9e8:	75 1d                	jne    a07 <printf+0x132>
        putc(fd, *ap);
     9ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9ed:	8b 00                	mov    (%eax),%eax
     9ef:	0f be c0             	movsbl %al,%eax
     9f2:	83 ec 08             	sub    $0x8,%esp
     9f5:	50                   	push   %eax
     9f6:	ff 75 08             	pushl  0x8(%ebp)
     9f9:	e8 fb fd ff ff       	call   7f9 <putc>
     9fe:	83 c4 10             	add    $0x10,%esp
        ap++;
     a01:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     a05:	eb 42                	jmp    a49 <printf+0x174>
      } else if(c == '%'){
     a07:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     a0b:	75 17                	jne    a24 <printf+0x14f>
        putc(fd, c);
     a0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a10:	0f be c0             	movsbl %al,%eax
     a13:	83 ec 08             	sub    $0x8,%esp
     a16:	50                   	push   %eax
     a17:	ff 75 08             	pushl  0x8(%ebp)
     a1a:	e8 da fd ff ff       	call   7f9 <putc>
     a1f:	83 c4 10             	add    $0x10,%esp
     a22:	eb 25                	jmp    a49 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     a24:	83 ec 08             	sub    $0x8,%esp
     a27:	6a 25                	push   $0x25
     a29:	ff 75 08             	pushl  0x8(%ebp)
     a2c:	e8 c8 fd ff ff       	call   7f9 <putc>
     a31:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     a34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a37:	0f be c0             	movsbl %al,%eax
     a3a:	83 ec 08             	sub    $0x8,%esp
     a3d:	50                   	push   %eax
     a3e:	ff 75 08             	pushl  0x8(%ebp)
     a41:	e8 b3 fd ff ff       	call   7f9 <putc>
     a46:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     a49:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     a50:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     a54:	8b 55 0c             	mov    0xc(%ebp),%edx
     a57:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a5a:	01 d0                	add    %edx,%eax
     a5c:	0f b6 00             	movzbl (%eax),%eax
     a5f:	84 c0                	test   %al,%al
     a61:	0f 85 94 fe ff ff    	jne    8fb <printf+0x26>
    }
  }
}
     a67:	90                   	nop
     a68:	90                   	nop
     a69:	c9                   	leave  
     a6a:	c3                   	ret    

00000a6b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     a6b:	f3 0f 1e fb          	endbr32 
     a6f:	55                   	push   %ebp
     a70:	89 e5                	mov    %esp,%ebp
     a72:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     a75:	8b 45 08             	mov    0x8(%ebp),%eax
     a78:	83 e8 08             	sub    $0x8,%eax
     a7b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     a7e:	a1 08 17 00 00       	mov    0x1708,%eax
     a83:	89 45 fc             	mov    %eax,-0x4(%ebp)
     a86:	eb 24                	jmp    aac <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     a88:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a8b:	8b 00                	mov    (%eax),%eax
     a8d:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     a90:	72 12                	jb     aa4 <free+0x39>
     a92:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a95:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     a98:	77 24                	ja     abe <free+0x53>
     a9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a9d:	8b 00                	mov    (%eax),%eax
     a9f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     aa2:	72 1a                	jb     abe <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     aa4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aa7:	8b 00                	mov    (%eax),%eax
     aa9:	89 45 fc             	mov    %eax,-0x4(%ebp)
     aac:	8b 45 f8             	mov    -0x8(%ebp),%eax
     aaf:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     ab2:	76 d4                	jbe    a88 <free+0x1d>
     ab4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ab7:	8b 00                	mov    (%eax),%eax
     ab9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     abc:	73 ca                	jae    a88 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
     abe:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ac1:	8b 40 04             	mov    0x4(%eax),%eax
     ac4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     acb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ace:	01 c2                	add    %eax,%edx
     ad0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ad3:	8b 00                	mov    (%eax),%eax
     ad5:	39 c2                	cmp    %eax,%edx
     ad7:	75 24                	jne    afd <free+0x92>
    bp->s.size += p->s.ptr->s.size;
     ad9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     adc:	8b 50 04             	mov    0x4(%eax),%edx
     adf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ae2:	8b 00                	mov    (%eax),%eax
     ae4:	8b 40 04             	mov    0x4(%eax),%eax
     ae7:	01 c2                	add    %eax,%edx
     ae9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     aec:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     aef:	8b 45 fc             	mov    -0x4(%ebp),%eax
     af2:	8b 00                	mov    (%eax),%eax
     af4:	8b 10                	mov    (%eax),%edx
     af6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     af9:	89 10                	mov    %edx,(%eax)
     afb:	eb 0a                	jmp    b07 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
     afd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b00:	8b 10                	mov    (%eax),%edx
     b02:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b05:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     b07:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b0a:	8b 40 04             	mov    0x4(%eax),%eax
     b0d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     b14:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b17:	01 d0                	add    %edx,%eax
     b19:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     b1c:	75 20                	jne    b3e <free+0xd3>
    p->s.size += bp->s.size;
     b1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b21:	8b 50 04             	mov    0x4(%eax),%edx
     b24:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b27:	8b 40 04             	mov    0x4(%eax),%eax
     b2a:	01 c2                	add    %eax,%edx
     b2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b2f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     b32:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b35:	8b 10                	mov    (%eax),%edx
     b37:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b3a:	89 10                	mov    %edx,(%eax)
     b3c:	eb 08                	jmp    b46 <free+0xdb>
  } else
    p->s.ptr = bp;
     b3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b41:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b44:	89 10                	mov    %edx,(%eax)
  freep = p;
     b46:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b49:	a3 08 17 00 00       	mov    %eax,0x1708
}
     b4e:	90                   	nop
     b4f:	c9                   	leave  
     b50:	c3                   	ret    

00000b51 <morecore>:

static Header*
morecore(uint nu)
{
     b51:	f3 0f 1e fb          	endbr32 
     b55:	55                   	push   %ebp
     b56:	89 e5                	mov    %esp,%ebp
     b58:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     b5b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     b62:	77 07                	ja     b6b <morecore+0x1a>
    nu = 4096;
     b64:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     b6b:	8b 45 08             	mov    0x8(%ebp),%eax
     b6e:	c1 e0 03             	shl    $0x3,%eax
     b71:	83 ec 0c             	sub    $0xc,%esp
     b74:	50                   	push   %eax
     b75:	e8 17 fc ff ff       	call   791 <sbrk>
     b7a:	83 c4 10             	add    $0x10,%esp
     b7d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     b80:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     b84:	75 07                	jne    b8d <morecore+0x3c>
    return 0;
     b86:	b8 00 00 00 00       	mov    $0x0,%eax
     b8b:	eb 26                	jmp    bb3 <morecore+0x62>
  hp = (Header*)p;
     b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     b93:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b96:	8b 55 08             	mov    0x8(%ebp),%edx
     b99:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     b9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b9f:	83 c0 08             	add    $0x8,%eax
     ba2:	83 ec 0c             	sub    $0xc,%esp
     ba5:	50                   	push   %eax
     ba6:	e8 c0 fe ff ff       	call   a6b <free>
     bab:	83 c4 10             	add    $0x10,%esp
  return freep;
     bae:	a1 08 17 00 00       	mov    0x1708,%eax
}
     bb3:	c9                   	leave  
     bb4:	c3                   	ret    

00000bb5 <malloc>:

void*
malloc(uint nbytes)
{
     bb5:	f3 0f 1e fb          	endbr32 
     bb9:	55                   	push   %ebp
     bba:	89 e5                	mov    %esp,%ebp
     bbc:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     bbf:	8b 45 08             	mov    0x8(%ebp),%eax
     bc2:	83 c0 07             	add    $0x7,%eax
     bc5:	c1 e8 03             	shr    $0x3,%eax
     bc8:	83 c0 01             	add    $0x1,%eax
     bcb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     bce:	a1 08 17 00 00       	mov    0x1708,%eax
     bd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
     bd6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     bda:	75 23                	jne    bff <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
     bdc:	c7 45 f0 00 17 00 00 	movl   $0x1700,-0x10(%ebp)
     be3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     be6:	a3 08 17 00 00       	mov    %eax,0x1708
     beb:	a1 08 17 00 00       	mov    0x1708,%eax
     bf0:	a3 00 17 00 00       	mov    %eax,0x1700
    base.s.size = 0;
     bf5:	c7 05 04 17 00 00 00 	movl   $0x0,0x1704
     bfc:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     bff:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c02:	8b 00                	mov    (%eax),%eax
     c04:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     c07:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c0a:	8b 40 04             	mov    0x4(%eax),%eax
     c0d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     c10:	77 4d                	ja     c5f <malloc+0xaa>
      if(p->s.size == nunits)
     c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c15:	8b 40 04             	mov    0x4(%eax),%eax
     c18:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     c1b:	75 0c                	jne    c29 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
     c1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c20:	8b 10                	mov    (%eax),%edx
     c22:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c25:	89 10                	mov    %edx,(%eax)
     c27:	eb 26                	jmp    c4f <malloc+0x9a>
      else {
        p->s.size -= nunits;
     c29:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c2c:	8b 40 04             	mov    0x4(%eax),%eax
     c2f:	2b 45 ec             	sub    -0x14(%ebp),%eax
     c32:	89 c2                	mov    %eax,%edx
     c34:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c37:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     c3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c3d:	8b 40 04             	mov    0x4(%eax),%eax
     c40:	c1 e0 03             	shl    $0x3,%eax
     c43:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     c46:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c49:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c4c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     c4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c52:	a3 08 17 00 00       	mov    %eax,0x1708
      return (void*)(p + 1);
     c57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5a:	83 c0 08             	add    $0x8,%eax
     c5d:	eb 3b                	jmp    c9a <malloc+0xe5>
    }
    if(p == freep)
     c5f:	a1 08 17 00 00       	mov    0x1708,%eax
     c64:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     c67:	75 1e                	jne    c87 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
     c69:	83 ec 0c             	sub    $0xc,%esp
     c6c:	ff 75 ec             	pushl  -0x14(%ebp)
     c6f:	e8 dd fe ff ff       	call   b51 <morecore>
     c74:	83 c4 10             	add    $0x10,%esp
     c77:	89 45 f4             	mov    %eax,-0xc(%ebp)
     c7a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c7e:	75 07                	jne    c87 <malloc+0xd2>
        return 0;
     c80:	b8 00 00 00 00       	mov    $0x0,%eax
     c85:	eb 13                	jmp    c9a <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c8a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c90:	8b 00                	mov    (%eax),%eax
     c92:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     c95:	e9 6d ff ff ff       	jmp    c07 <malloc+0x52>
  }
}
     c9a:	c9                   	leave  
     c9b:	c3                   	ret    

00000c9c <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
     c9c:	f3 0f 1e fb          	endbr32 
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     ca6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     cad:	a1 60 17 00 00       	mov    0x1760,%eax
     cb2:	83 ec 04             	sub    $0x4,%esp
     cb5:	50                   	push   %eax
     cb6:	6a 20                	push   $0x20
     cb8:	68 40 17 00 00       	push   $0x1740
     cbd:	e8 11 f8 ff ff       	call   4d3 <fgets>
     cc2:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     cc5:	83 ec 0c             	sub    $0xc,%esp
     cc8:	68 40 17 00 00       	push   $0x1740
     ccd:	e8 0e f7 ff ff       	call   3e0 <strlen>
     cd2:	83 c4 10             	add    $0x10,%esp
     cd5:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     cd8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cdb:	83 e8 01             	sub    $0x1,%eax
     cde:	0f b6 80 40 17 00 00 	movzbl 0x1740(%eax),%eax
     ce5:	3c 0a                	cmp    $0xa,%al
     ce7:	74 11                	je     cfa <get_id+0x5e>
     ce9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cec:	83 e8 01             	sub    $0x1,%eax
     cef:	0f b6 80 40 17 00 00 	movzbl 0x1740(%eax),%eax
     cf6:	3c 0d                	cmp    $0xd,%al
     cf8:	75 0d                	jne    d07 <get_id+0x6b>
        current_line[len - 1] = 0;
     cfa:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cfd:	83 e8 01             	sub    $0x1,%eax
     d00:	c6 80 40 17 00 00 00 	movb   $0x0,0x1740(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     d07:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     d0e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     d15:	eb 6c                	jmp    d83 <get_id+0xe7>
        if(current_line[i] == ' '){
     d17:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d1a:	05 40 17 00 00       	add    $0x1740,%eax
     d1f:	0f b6 00             	movzbl (%eax),%eax
     d22:	3c 20                	cmp    $0x20,%al
     d24:	75 30                	jne    d56 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     d26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d2a:	75 16                	jne    d42 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     d2c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     d2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d32:	8d 50 01             	lea    0x1(%eax),%edx
     d35:	89 55 f0             	mov    %edx,-0x10(%ebp)
     d38:	8d 91 40 17 00 00    	lea    0x1740(%ecx),%edx
     d3e:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     d42:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d45:	05 40 17 00 00       	add    $0x1740,%eax
     d4a:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     d4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d54:	eb 29                	jmp    d7f <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     d56:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d5a:	75 23                	jne    d7f <get_id+0xe3>
     d5c:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     d60:	7f 1d                	jg     d7f <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     d62:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     d69:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     d6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d6f:	8d 50 01             	lea    0x1(%eax),%edx
     d72:	89 55 f0             	mov    %edx,-0x10(%ebp)
     d75:	8d 91 40 17 00 00    	lea    0x1740(%ecx),%edx
     d7b:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     d7f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     d83:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d86:	05 40 17 00 00       	add    $0x1740,%eax
     d8b:	0f b6 00             	movzbl (%eax),%eax
     d8e:	84 c0                	test   %al,%al
     d90:	75 85                	jne    d17 <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     d92:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     d96:	75 07                	jne    d9f <get_id+0x103>
        return -1;
     d98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     d9d:	eb 35                	jmp    dd4 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
     d9f:	8b 45 dc             	mov    -0x24(%ebp),%eax
     da2:	a3 20 17 00 00       	mov    %eax,0x1720
    current_id.uid_user = atoi(tokens[1]);
     da7:	8b 45 e0             	mov    -0x20(%ebp),%eax
     daa:	83 ec 0c             	sub    $0xc,%esp
     dad:	50                   	push   %eax
     dae:	e8 e5 f7 ff ff       	call   598 <atoi>
     db3:	83 c4 10             	add    $0x10,%esp
     db6:	a3 24 17 00 00       	mov    %eax,0x1724
    current_id.gid_user = atoi(tokens[2]);
     dbb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     dbe:	83 ec 0c             	sub    $0xc,%esp
     dc1:	50                   	push   %eax
     dc2:	e8 d1 f7 ff ff       	call   598 <atoi>
     dc7:	83 c4 10             	add    $0x10,%esp
     dca:	a3 28 17 00 00       	mov    %eax,0x1728

    return 0;
     dcf:	b8 00 00 00 00       	mov    $0x0,%eax
}
     dd4:	c9                   	leave  
     dd5:	c3                   	ret    

00000dd6 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
     dd6:	f3 0f 1e fb          	endbr32 
     dda:	55                   	push   %ebp
     ddb:	89 e5                	mov    %esp,%ebp
     ddd:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     de0:	a1 60 17 00 00       	mov    0x1760,%eax
     de5:	85 c0                	test   %eax,%eax
     de7:	75 31                	jne    e1a <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
     de9:	83 ec 08             	sub    $0x8,%esp
     dec:	6a 00                	push   $0x0
     dee:	68 2d 12 00 00       	push   $0x122d
     df3:	e8 51 f9 ff ff       	call   749 <open>
     df8:	83 c4 10             	add    $0x10,%esp
     dfb:	a3 60 17 00 00       	mov    %eax,0x1760

        if(dir < 0){        // kalau gagal membuka file
     e00:	a1 60 17 00 00       	mov    0x1760,%eax
     e05:	85 c0                	test   %eax,%eax
     e07:	79 11                	jns    e1a <getid+0x44>
            dir = 0;
     e09:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
     e10:	00 00 00 
            return 0;
     e13:	b8 00 00 00 00       	mov    $0x0,%eax
     e18:	eb 16                	jmp    e30 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
     e1a:	e8 7d fe ff ff       	call   c9c <get_id>
     e1f:	83 f8 ff             	cmp    $0xffffffff,%eax
     e22:	75 07                	jne    e2b <getid+0x55>
        return 0;
     e24:	b8 00 00 00 00       	mov    $0x0,%eax
     e29:	eb 05                	jmp    e30 <getid+0x5a>
    
    return &current_id;
     e2b:	b8 20 17 00 00       	mov    $0x1720,%eax
}
     e30:	c9                   	leave  
     e31:	c3                   	ret    

00000e32 <setid>:

// open file_ids
void setid(void){
     e32:	f3 0f 1e fb          	endbr32 
     e36:	55                   	push   %ebp
     e37:	89 e5                	mov    %esp,%ebp
     e39:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     e3c:	a1 60 17 00 00       	mov    0x1760,%eax
     e41:	85 c0                	test   %eax,%eax
     e43:	74 1b                	je     e60 <setid+0x2e>
        close(dir);
     e45:	a1 60 17 00 00       	mov    0x1760,%eax
     e4a:	83 ec 0c             	sub    $0xc,%esp
     e4d:	50                   	push   %eax
     e4e:	e8 de f8 ff ff       	call   731 <close>
     e53:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     e56:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
     e5d:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
     e60:	83 ec 08             	sub    $0x8,%esp
     e63:	6a 00                	push   $0x0
     e65:	68 2d 12 00 00       	push   $0x122d
     e6a:	e8 da f8 ff ff       	call   749 <open>
     e6f:	83 c4 10             	add    $0x10,%esp
     e72:	a3 60 17 00 00       	mov    %eax,0x1760

    if (dir < 0)
     e77:	a1 60 17 00 00       	mov    0x1760,%eax
     e7c:	85 c0                	test   %eax,%eax
     e7e:	79 0a                	jns    e8a <setid+0x58>
        dir = 0;
     e80:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
     e87:	00 00 00 
}
     e8a:	90                   	nop
     e8b:	c9                   	leave  
     e8c:	c3                   	ret    

00000e8d <endid>:

// tutup file_ids
void endid (void){
     e8d:	f3 0f 1e fb          	endbr32 
     e91:	55                   	push   %ebp
     e92:	89 e5                	mov    %esp,%ebp
     e94:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     e97:	a1 60 17 00 00       	mov    0x1760,%eax
     e9c:	85 c0                	test   %eax,%eax
     e9e:	74 1b                	je     ebb <endid+0x2e>
        close(dir);
     ea0:	a1 60 17 00 00       	mov    0x1760,%eax
     ea5:	83 ec 0c             	sub    $0xc,%esp
     ea8:	50                   	push   %eax
     ea9:	e8 83 f8 ff ff       	call   731 <close>
     eae:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     eb1:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
     eb8:	00 00 00 
    }
}
     ebb:	90                   	nop
     ebc:	c9                   	leave  
     ebd:	c3                   	ret    

00000ebe <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
     ebe:	f3 0f 1e fb          	endbr32 
     ec2:	55                   	push   %ebp
     ec3:	89 e5                	mov    %esp,%ebp
     ec5:	83 ec 08             	sub    $0x8,%esp
    setid();
     ec8:	e8 65 ff ff ff       	call   e32 <setid>

    while (getid()){
     ecd:	eb 24                	jmp    ef3 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
     ecf:	a1 20 17 00 00       	mov    0x1720,%eax
     ed4:	83 ec 08             	sub    $0x8,%esp
     ed7:	50                   	push   %eax
     ed8:	ff 75 08             	pushl  0x8(%ebp)
     edb:	e8 bd f4 ff ff       	call   39d <strcmp>
     ee0:	83 c4 10             	add    $0x10,%esp
     ee3:	85 c0                	test   %eax,%eax
     ee5:	75 0c                	jne    ef3 <cek_nama+0x35>
            endid();
     ee7:	e8 a1 ff ff ff       	call   e8d <endid>
            return &current_id;
     eec:	b8 20 17 00 00       	mov    $0x1720,%eax
     ef1:	eb 13                	jmp    f06 <cek_nama+0x48>
    while (getid()){
     ef3:	e8 de fe ff ff       	call   dd6 <getid>
     ef8:	85 c0                	test   %eax,%eax
     efa:	75 d3                	jne    ecf <cek_nama+0x11>
        }
    }
    endid();
     efc:	e8 8c ff ff ff       	call   e8d <endid>
    return 0;
     f01:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f06:	c9                   	leave  
     f07:	c3                   	ret    

00000f08 <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
     f08:	f3 0f 1e fb          	endbr32 
     f0c:	55                   	push   %ebp
     f0d:	89 e5                	mov    %esp,%ebp
     f0f:	83 ec 08             	sub    $0x8,%esp
    setid();
     f12:	e8 1b ff ff ff       	call   e32 <setid>

    while (getid()){
     f17:	eb 16                	jmp    f2f <cek_uid+0x27>
        if(current_id.uid_user == uid){
     f19:	a1 24 17 00 00       	mov    0x1724,%eax
     f1e:	39 45 08             	cmp    %eax,0x8(%ebp)
     f21:	75 0c                	jne    f2f <cek_uid+0x27>
            endid();
     f23:	e8 65 ff ff ff       	call   e8d <endid>
            return &current_id;
     f28:	b8 20 17 00 00       	mov    $0x1720,%eax
     f2d:	eb 13                	jmp    f42 <cek_uid+0x3a>
    while (getid()){
     f2f:	e8 a2 fe ff ff       	call   dd6 <getid>
     f34:	85 c0                	test   %eax,%eax
     f36:	75 e1                	jne    f19 <cek_uid+0x11>
        }
    }
    endid();
     f38:	e8 50 ff ff ff       	call   e8d <endid>
    return 0;
     f3d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f42:	c9                   	leave  
     f43:	c3                   	ret    

00000f44 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
     f44:	f3 0f 1e fb          	endbr32 
     f48:	55                   	push   %ebp
     f49:	89 e5                	mov    %esp,%ebp
     f4b:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     f4e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     f55:	a1 60 17 00 00       	mov    0x1760,%eax
     f5a:	83 ec 04             	sub    $0x4,%esp
     f5d:	50                   	push   %eax
     f5e:	6a 20                	push   $0x20
     f60:	68 40 17 00 00       	push   $0x1740
     f65:	e8 69 f5 ff ff       	call   4d3 <fgets>
     f6a:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     f6d:	83 ec 0c             	sub    $0xc,%esp
     f70:	68 40 17 00 00       	push   $0x1740
     f75:	e8 66 f4 ff ff       	call   3e0 <strlen>
     f7a:	83 c4 10             	add    $0x10,%esp
     f7d:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     f80:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f83:	83 e8 01             	sub    $0x1,%eax
     f86:	0f b6 80 40 17 00 00 	movzbl 0x1740(%eax),%eax
     f8d:	3c 0a                	cmp    $0xa,%al
     f8f:	74 11                	je     fa2 <get_group+0x5e>
     f91:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f94:	83 e8 01             	sub    $0x1,%eax
     f97:	0f b6 80 40 17 00 00 	movzbl 0x1740(%eax),%eax
     f9e:	3c 0d                	cmp    $0xd,%al
     fa0:	75 0d                	jne    faf <get_group+0x6b>
        current_line[len - 1] = 0;
     fa2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     fa5:	83 e8 01             	sub    $0x1,%eax
     fa8:	c6 80 40 17 00 00 00 	movb   $0x0,0x1740(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     faf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     fb6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     fbd:	eb 6c                	jmp    102b <get_group+0xe7>
        if(current_line[i] == ' '){
     fbf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fc2:	05 40 17 00 00       	add    $0x1740,%eax
     fc7:	0f b6 00             	movzbl (%eax),%eax
     fca:	3c 20                	cmp    $0x20,%al
     fcc:	75 30                	jne    ffe <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     fce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     fd2:	75 16                	jne    fea <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     fd4:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     fd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fda:	8d 50 01             	lea    0x1(%eax),%edx
     fdd:	89 55 f0             	mov    %edx,-0x10(%ebp)
     fe0:	8d 91 40 17 00 00    	lea    0x1740(%ecx),%edx
     fe6:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     fea:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fed:	05 40 17 00 00       	add    $0x1740,%eax
     ff2:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     ff5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ffc:	eb 29                	jmp    1027 <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     ffe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1002:	75 23                	jne    1027 <get_group+0xe3>
    1004:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1008:	7f 1d                	jg     1027 <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
    100a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
    1011:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1014:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1017:	8d 50 01             	lea    0x1(%eax),%edx
    101a:	89 55 f0             	mov    %edx,-0x10(%ebp)
    101d:	8d 91 40 17 00 00    	lea    0x1740(%ecx),%edx
    1023:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
    1027:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    102b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    102e:	05 40 17 00 00       	add    $0x1740,%eax
    1033:	0f b6 00             	movzbl (%eax),%eax
    1036:	84 c0                	test   %al,%al
    1038:	75 85                	jne    fbf <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
    103a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    103e:	75 07                	jne    1047 <get_group+0x103>
        return -1;
    1040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1045:	eb 21                	jmp    1068 <get_group+0x124>
    
    current_group.nama_group = tokens[0];
    1047:	8b 45 dc             	mov    -0x24(%ebp),%eax
    104a:	a3 2c 17 00 00       	mov    %eax,0x172c
    current_group.gid = atoi(tokens[1]);
    104f:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1052:	83 ec 0c             	sub    $0xc,%esp
    1055:	50                   	push   %eax
    1056:	e8 3d f5 ff ff       	call   598 <atoi>
    105b:	83 c4 10             	add    $0x10,%esp
    105e:	a3 30 17 00 00       	mov    %eax,0x1730

    return 0;
    1063:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1068:	c9                   	leave  
    1069:	c3                   	ret    

0000106a <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
    106a:	f3 0f 1e fb          	endbr32 
    106e:	55                   	push   %ebp
    106f:	89 e5                	mov    %esp,%ebp
    1071:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
    1074:	a1 60 17 00 00       	mov    0x1760,%eax
    1079:	85 c0                	test   %eax,%eax
    107b:	75 31                	jne    10ae <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
    107d:	83 ec 08             	sub    $0x8,%esp
    1080:	6a 00                	push   $0x0
    1082:	68 35 12 00 00       	push   $0x1235
    1087:	e8 bd f6 ff ff       	call   749 <open>
    108c:	83 c4 10             	add    $0x10,%esp
    108f:	a3 60 17 00 00       	mov    %eax,0x1760

        if(dir < 0){        // kalau gagal membuka file
    1094:	a1 60 17 00 00       	mov    0x1760,%eax
    1099:	85 c0                	test   %eax,%eax
    109b:	79 11                	jns    10ae <getgroup+0x44>
            dir = 0;
    109d:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
    10a4:	00 00 00 
            return 0;
    10a7:	b8 00 00 00 00       	mov    $0x0,%eax
    10ac:	eb 16                	jmp    10c4 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
    10ae:	e8 91 fe ff ff       	call   f44 <get_group>
    10b3:	83 f8 ff             	cmp    $0xffffffff,%eax
    10b6:	75 07                	jne    10bf <getgroup+0x55>
        return 0;
    10b8:	b8 00 00 00 00       	mov    $0x0,%eax
    10bd:	eb 05                	jmp    10c4 <getgroup+0x5a>
    
    return &current_group;
    10bf:	b8 2c 17 00 00       	mov    $0x172c,%eax
}
    10c4:	c9                   	leave  
    10c5:	c3                   	ret    

000010c6 <setgroup>:

// open file_ids
void setgroup(void){
    10c6:	f3 0f 1e fb          	endbr32 
    10ca:	55                   	push   %ebp
    10cb:	89 e5                	mov    %esp,%ebp
    10cd:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    10d0:	a1 60 17 00 00       	mov    0x1760,%eax
    10d5:	85 c0                	test   %eax,%eax
    10d7:	74 1b                	je     10f4 <setgroup+0x2e>
        close(dir);
    10d9:	a1 60 17 00 00       	mov    0x1760,%eax
    10de:	83 ec 0c             	sub    $0xc,%esp
    10e1:	50                   	push   %eax
    10e2:	e8 4a f6 ff ff       	call   731 <close>
    10e7:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    10ea:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
    10f1:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
    10f4:	83 ec 08             	sub    $0x8,%esp
    10f7:	6a 00                	push   $0x0
    10f9:	68 35 12 00 00       	push   $0x1235
    10fe:	e8 46 f6 ff ff       	call   749 <open>
    1103:	83 c4 10             	add    $0x10,%esp
    1106:	a3 60 17 00 00       	mov    %eax,0x1760

    if (dir < 0)
    110b:	a1 60 17 00 00       	mov    0x1760,%eax
    1110:	85 c0                	test   %eax,%eax
    1112:	79 0a                	jns    111e <setgroup+0x58>
        dir = 0;
    1114:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
    111b:	00 00 00 
}
    111e:	90                   	nop
    111f:	c9                   	leave  
    1120:	c3                   	ret    

00001121 <endgroup>:

// tutup file_ids
void endgroup (void){
    1121:	f3 0f 1e fb          	endbr32 
    1125:	55                   	push   %ebp
    1126:	89 e5                	mov    %esp,%ebp
    1128:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    112b:	a1 60 17 00 00       	mov    0x1760,%eax
    1130:	85 c0                	test   %eax,%eax
    1132:	74 1b                	je     114f <endgroup+0x2e>
        close(dir);
    1134:	a1 60 17 00 00       	mov    0x1760,%eax
    1139:	83 ec 0c             	sub    $0xc,%esp
    113c:	50                   	push   %eax
    113d:	e8 ef f5 ff ff       	call   731 <close>
    1142:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1145:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
    114c:	00 00 00 
    }
}
    114f:	90                   	nop
    1150:	c9                   	leave  
    1151:	c3                   	ret    

00001152 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
    1152:	f3 0f 1e fb          	endbr32 
    1156:	55                   	push   %ebp
    1157:	89 e5                	mov    %esp,%ebp
    1159:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    115c:	e8 65 ff ff ff       	call   10c6 <setgroup>

    while (getgroup()){
    1161:	eb 3c                	jmp    119f <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
    1163:	a1 2c 17 00 00       	mov    0x172c,%eax
    1168:	83 ec 08             	sub    $0x8,%esp
    116b:	50                   	push   %eax
    116c:	ff 75 08             	pushl  0x8(%ebp)
    116f:	e8 29 f2 ff ff       	call   39d <strcmp>
    1174:	83 c4 10             	add    $0x10,%esp
    1177:	85 c0                	test   %eax,%eax
    1179:	75 24                	jne    119f <cek_nama_group+0x4d>
            endgroup();
    117b:	e8 a1 ff ff ff       	call   1121 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
    1180:	a1 2c 17 00 00       	mov    0x172c,%eax
    1185:	83 ec 04             	sub    $0x4,%esp
    1188:	50                   	push   %eax
    1189:	68 40 12 00 00       	push   $0x1240
    118e:	6a 01                	push   $0x1
    1190:	e8 40 f7 ff ff       	call   8d5 <printf>
    1195:	83 c4 10             	add    $0x10,%esp
            return &current_group;
    1198:	b8 2c 17 00 00       	mov    $0x172c,%eax
    119d:	eb 13                	jmp    11b2 <cek_nama_group+0x60>
    while (getgroup()){
    119f:	e8 c6 fe ff ff       	call   106a <getgroup>
    11a4:	85 c0                	test   %eax,%eax
    11a6:	75 bb                	jne    1163 <cek_nama_group+0x11>
        }
    }
    endgroup();
    11a8:	e8 74 ff ff ff       	call   1121 <endgroup>
    return 0;
    11ad:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11b2:	c9                   	leave  
    11b3:	c3                   	ret    

000011b4 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
    11b4:	f3 0f 1e fb          	endbr32 
    11b8:	55                   	push   %ebp
    11b9:	89 e5                	mov    %esp,%ebp
    11bb:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    11be:	e8 03 ff ff ff       	call   10c6 <setgroup>

    while (getgroup()){
    11c3:	eb 16                	jmp    11db <cek_gid+0x27>
        if(current_group.gid == gid){
    11c5:	a1 30 17 00 00       	mov    0x1730,%eax
    11ca:	39 45 08             	cmp    %eax,0x8(%ebp)
    11cd:	75 0c                	jne    11db <cek_gid+0x27>
            endgroup();
    11cf:	e8 4d ff ff ff       	call   1121 <endgroup>
            return &current_group;
    11d4:	b8 2c 17 00 00       	mov    $0x172c,%eax
    11d9:	eb 13                	jmp    11ee <cek_gid+0x3a>
    while (getgroup()){
    11db:	e8 8a fe ff ff       	call   106a <getgroup>
    11e0:	85 c0                	test   %eax,%eax
    11e2:	75 e1                	jne    11c5 <cek_gid+0x11>
        }
    }
    endgroup();
    11e4:	e8 38 ff ff ff       	call   1121 <endgroup>
    return 0;
    11e9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11ee:	c9                   	leave  
    11ef:	c3                   	ret    
