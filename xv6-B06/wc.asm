
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
       0:	f3 0f 1e fb          	endbr32 
       4:	55                   	push   %ebp
       5:	89 e5                	mov    %esp,%ebp
       7:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
       a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
      11:	8b 45 e8             	mov    -0x18(%ebp),%eax
      14:	89 45 ec             	mov    %eax,-0x14(%ebp)
      17:	8b 45 ec             	mov    -0x14(%ebp),%eax
      1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
      1d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
      24:	eb 69                	jmp    8f <wc+0x8f>
    for(i=0; i<n; i++){
      26:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      2d:	eb 58                	jmp    87 <wc+0x87>
      c++;
      2f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
      33:	8b 45 f4             	mov    -0xc(%ebp),%eax
      36:	05 a0 15 00 00       	add    $0x15a0,%eax
      3b:	0f b6 00             	movzbl (%eax),%eax
      3e:	3c 0a                	cmp    $0xa,%al
      40:	75 04                	jne    46 <wc+0x46>
        l++;
      42:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      46:	8b 45 f4             	mov    -0xc(%ebp),%eax
      49:	05 a0 15 00 00       	add    $0x15a0,%eax
      4e:	0f b6 00             	movzbl (%eax),%eax
      51:	0f be c0             	movsbl %al,%eax
      54:	83 ec 08             	sub    $0x8,%esp
      57:	50                   	push   %eax
      58:	68 72 10 00 00       	push   $0x1072
      5d:	e8 49 02 00 00       	call   2ab <strchr>
      62:	83 c4 10             	add    $0x10,%esp
      65:	85 c0                	test   %eax,%eax
      67:	74 09                	je     72 <wc+0x72>
        inword = 0;
      69:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      70:	eb 11                	jmp    83 <wc+0x83>
      else if(!inword){
      72:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
      76:	75 0b                	jne    83 <wc+0x83>
        w++;
      78:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
      7c:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
      83:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      87:	8b 45 f4             	mov    -0xc(%ebp),%eax
      8a:	3b 45 e0             	cmp    -0x20(%ebp),%eax
      8d:	7c a0                	jl     2f <wc+0x2f>
  while((n = read(fd, buf, sizeof(buf))) > 0){
      8f:	83 ec 04             	sub    $0x4,%esp
      92:	68 00 02 00 00       	push   $0x200
      97:	68 a0 15 00 00       	push   $0x15a0
      9c:	ff 75 08             	pushl  0x8(%ebp)
      9f:	e8 ff 04 00 00       	call   5a3 <read>
      a4:	83 c4 10             	add    $0x10,%esp
      a7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      aa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      ae:	0f 8f 72 ff ff ff    	jg     26 <wc+0x26>
      }
    }
  }
  if(n < 0){
      b4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      b8:	79 17                	jns    d1 <wc+0xd1>
    printf(1, "wc: read error\n");
      ba:	83 ec 08             	sub    $0x8,%esp
      bd:	68 78 10 00 00       	push   $0x1078
      c2:	6a 01                	push   $0x1
      c4:	e8 8e 06 00 00       	call   757 <printf>
      c9:	83 c4 10             	add    $0x10,%esp
    exit();
      cc:	e8 ba 04 00 00       	call   58b <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
      d1:	83 ec 08             	sub    $0x8,%esp
      d4:	ff 75 0c             	pushl  0xc(%ebp)
      d7:	ff 75 e8             	pushl  -0x18(%ebp)
      da:	ff 75 ec             	pushl  -0x14(%ebp)
      dd:	ff 75 f0             	pushl  -0x10(%ebp)
      e0:	68 88 10 00 00       	push   $0x1088
      e5:	6a 01                	push   $0x1
      e7:	e8 6b 06 00 00       	call   757 <printf>
      ec:	83 c4 20             	add    $0x20,%esp
}
      ef:	90                   	nop
      f0:	c9                   	leave  
      f1:	c3                   	ret    

000000f2 <main>:

int
main(int argc, char *argv[])
{
      f2:	f3 0f 1e fb          	endbr32 
      f6:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      fa:	83 e4 f0             	and    $0xfffffff0,%esp
      fd:	ff 71 fc             	pushl  -0x4(%ecx)
     100:	55                   	push   %ebp
     101:	89 e5                	mov    %esp,%ebp
     103:	53                   	push   %ebx
     104:	51                   	push   %ecx
     105:	83 ec 10             	sub    $0x10,%esp
     108:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
     10a:	83 3b 01             	cmpl   $0x1,(%ebx)
     10d:	7f 17                	jg     126 <main+0x34>
    wc(0, "");
     10f:	83 ec 08             	sub    $0x8,%esp
     112:	68 95 10 00 00       	push   $0x1095
     117:	6a 00                	push   $0x0
     119:	e8 e2 fe ff ff       	call   0 <wc>
     11e:	83 c4 10             	add    $0x10,%esp
    exit();
     121:	e8 65 04 00 00       	call   58b <exit>
  }

  for(i = 1; i < argc; i++){
     126:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     12d:	e9 83 00 00 00       	jmp    1b5 <main+0xc3>
    if((fd = open(argv[i], 0)) < 0){
     132:	8b 45 f4             	mov    -0xc(%ebp),%eax
     135:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     13c:	8b 43 04             	mov    0x4(%ebx),%eax
     13f:	01 d0                	add    %edx,%eax
     141:	8b 00                	mov    (%eax),%eax
     143:	83 ec 08             	sub    $0x8,%esp
     146:	6a 00                	push   $0x0
     148:	50                   	push   %eax
     149:	e8 7d 04 00 00       	call   5cb <open>
     14e:	83 c4 10             	add    $0x10,%esp
     151:	89 45 f0             	mov    %eax,-0x10(%ebp)
     154:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     158:	79 29                	jns    183 <main+0x91>
      printf(1, "wc: cannot open %s\n", argv[i]);
     15a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     15d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     164:	8b 43 04             	mov    0x4(%ebx),%eax
     167:	01 d0                	add    %edx,%eax
     169:	8b 00                	mov    (%eax),%eax
     16b:	83 ec 04             	sub    $0x4,%esp
     16e:	50                   	push   %eax
     16f:	68 96 10 00 00       	push   $0x1096
     174:	6a 01                	push   $0x1
     176:	e8 dc 05 00 00       	call   757 <printf>
     17b:	83 c4 10             	add    $0x10,%esp
      exit();
     17e:	e8 08 04 00 00       	call   58b <exit>
    }
    wc(fd, argv[i]);
     183:	8b 45 f4             	mov    -0xc(%ebp),%eax
     186:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     18d:	8b 43 04             	mov    0x4(%ebx),%eax
     190:	01 d0                	add    %edx,%eax
     192:	8b 00                	mov    (%eax),%eax
     194:	83 ec 08             	sub    $0x8,%esp
     197:	50                   	push   %eax
     198:	ff 75 f0             	pushl  -0x10(%ebp)
     19b:	e8 60 fe ff ff       	call   0 <wc>
     1a0:	83 c4 10             	add    $0x10,%esp
    close(fd);
     1a3:	83 ec 0c             	sub    $0xc,%esp
     1a6:	ff 75 f0             	pushl  -0x10(%ebp)
     1a9:	e8 05 04 00 00       	call   5b3 <close>
     1ae:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
     1b1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1b8:	3b 03                	cmp    (%ebx),%eax
     1ba:	0f 8c 72 ff ff ff    	jl     132 <main+0x40>
  }
  exit();
     1c0:	e8 c6 03 00 00       	call   58b <exit>

000001c5 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     1c5:	55                   	push   %ebp
     1c6:	89 e5                	mov    %esp,%ebp
     1c8:	57                   	push   %edi
     1c9:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     1ca:	8b 4d 08             	mov    0x8(%ebp),%ecx
     1cd:	8b 55 10             	mov    0x10(%ebp),%edx
     1d0:	8b 45 0c             	mov    0xc(%ebp),%eax
     1d3:	89 cb                	mov    %ecx,%ebx
     1d5:	89 df                	mov    %ebx,%edi
     1d7:	89 d1                	mov    %edx,%ecx
     1d9:	fc                   	cld    
     1da:	f3 aa                	rep stos %al,%es:(%edi)
     1dc:	89 ca                	mov    %ecx,%edx
     1de:	89 fb                	mov    %edi,%ebx
     1e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
     1e3:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     1e6:	90                   	nop
     1e7:	5b                   	pop    %ebx
     1e8:	5f                   	pop    %edi
     1e9:	5d                   	pop    %ebp
     1ea:	c3                   	ret    

000001eb <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     1eb:	f3 0f 1e fb          	endbr32 
     1ef:	55                   	push   %ebp
     1f0:	89 e5                	mov    %esp,%ebp
     1f2:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     1f5:	8b 45 08             	mov    0x8(%ebp),%eax
     1f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     1fb:	90                   	nop
     1fc:	8b 55 0c             	mov    0xc(%ebp),%edx
     1ff:	8d 42 01             	lea    0x1(%edx),%eax
     202:	89 45 0c             	mov    %eax,0xc(%ebp)
     205:	8b 45 08             	mov    0x8(%ebp),%eax
     208:	8d 48 01             	lea    0x1(%eax),%ecx
     20b:	89 4d 08             	mov    %ecx,0x8(%ebp)
     20e:	0f b6 12             	movzbl (%edx),%edx
     211:	88 10                	mov    %dl,(%eax)
     213:	0f b6 00             	movzbl (%eax),%eax
     216:	84 c0                	test   %al,%al
     218:	75 e2                	jne    1fc <strcpy+0x11>
    ;
  return os;
     21a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     21d:	c9                   	leave  
     21e:	c3                   	ret    

0000021f <strcmp>:

int
strcmp(const char *p, const char *q)
{
     21f:	f3 0f 1e fb          	endbr32 
     223:	55                   	push   %ebp
     224:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     226:	eb 08                	jmp    230 <strcmp+0x11>
    p++, q++;
     228:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     22c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     230:	8b 45 08             	mov    0x8(%ebp),%eax
     233:	0f b6 00             	movzbl (%eax),%eax
     236:	84 c0                	test   %al,%al
     238:	74 10                	je     24a <strcmp+0x2b>
     23a:	8b 45 08             	mov    0x8(%ebp),%eax
     23d:	0f b6 10             	movzbl (%eax),%edx
     240:	8b 45 0c             	mov    0xc(%ebp),%eax
     243:	0f b6 00             	movzbl (%eax),%eax
     246:	38 c2                	cmp    %al,%dl
     248:	74 de                	je     228 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
     24a:	8b 45 08             	mov    0x8(%ebp),%eax
     24d:	0f b6 00             	movzbl (%eax),%eax
     250:	0f b6 d0             	movzbl %al,%edx
     253:	8b 45 0c             	mov    0xc(%ebp),%eax
     256:	0f b6 00             	movzbl (%eax),%eax
     259:	0f b6 c0             	movzbl %al,%eax
     25c:	29 c2                	sub    %eax,%edx
     25e:	89 d0                	mov    %edx,%eax
}
     260:	5d                   	pop    %ebp
     261:	c3                   	ret    

00000262 <strlen>:

uint
strlen(char *s)
{
     262:	f3 0f 1e fb          	endbr32 
     266:	55                   	push   %ebp
     267:	89 e5                	mov    %esp,%ebp
     269:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     26c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     273:	eb 04                	jmp    279 <strlen+0x17>
     275:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     279:	8b 55 fc             	mov    -0x4(%ebp),%edx
     27c:	8b 45 08             	mov    0x8(%ebp),%eax
     27f:	01 d0                	add    %edx,%eax
     281:	0f b6 00             	movzbl (%eax),%eax
     284:	84 c0                	test   %al,%al
     286:	75 ed                	jne    275 <strlen+0x13>
    ;
  return n;
     288:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     28b:	c9                   	leave  
     28c:	c3                   	ret    

0000028d <memset>:

void*
memset(void *dst, int c, uint n)
{
     28d:	f3 0f 1e fb          	endbr32 
     291:	55                   	push   %ebp
     292:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     294:	8b 45 10             	mov    0x10(%ebp),%eax
     297:	50                   	push   %eax
     298:	ff 75 0c             	pushl  0xc(%ebp)
     29b:	ff 75 08             	pushl  0x8(%ebp)
     29e:	e8 22 ff ff ff       	call   1c5 <stosb>
     2a3:	83 c4 0c             	add    $0xc,%esp
  return dst;
     2a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2a9:	c9                   	leave  
     2aa:	c3                   	ret    

000002ab <strchr>:

char*
strchr(const char *s, char c)
{
     2ab:	f3 0f 1e fb          	endbr32 
     2af:	55                   	push   %ebp
     2b0:	89 e5                	mov    %esp,%ebp
     2b2:	83 ec 04             	sub    $0x4,%esp
     2b5:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b8:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     2bb:	eb 14                	jmp    2d1 <strchr+0x26>
    if(*s == c)
     2bd:	8b 45 08             	mov    0x8(%ebp),%eax
     2c0:	0f b6 00             	movzbl (%eax),%eax
     2c3:	38 45 fc             	cmp    %al,-0x4(%ebp)
     2c6:	75 05                	jne    2cd <strchr+0x22>
      return (char*)s;
     2c8:	8b 45 08             	mov    0x8(%ebp),%eax
     2cb:	eb 13                	jmp    2e0 <strchr+0x35>
  for(; *s; s++)
     2cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2d1:	8b 45 08             	mov    0x8(%ebp),%eax
     2d4:	0f b6 00             	movzbl (%eax),%eax
     2d7:	84 c0                	test   %al,%al
     2d9:	75 e2                	jne    2bd <strchr+0x12>
  return 0;
     2db:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2e0:	c9                   	leave  
     2e1:	c3                   	ret    

000002e2 <gets>:

char*
gets(char *buf, int max)
{
     2e2:	f3 0f 1e fb          	endbr32 
     2e6:	55                   	push   %ebp
     2e7:	89 e5                	mov    %esp,%ebp
     2e9:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2f3:	eb 42                	jmp    337 <gets+0x55>
    cc = read(0, &c, 1);
     2f5:	83 ec 04             	sub    $0x4,%esp
     2f8:	6a 01                	push   $0x1
     2fa:	8d 45 ef             	lea    -0x11(%ebp),%eax
     2fd:	50                   	push   %eax
     2fe:	6a 00                	push   $0x0
     300:	e8 9e 02 00 00       	call   5a3 <read>
     305:	83 c4 10             	add    $0x10,%esp
     308:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     30b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     30f:	7e 33                	jle    344 <gets+0x62>
      break;
    buf[i++] = c;
     311:	8b 45 f4             	mov    -0xc(%ebp),%eax
     314:	8d 50 01             	lea    0x1(%eax),%edx
     317:	89 55 f4             	mov    %edx,-0xc(%ebp)
     31a:	89 c2                	mov    %eax,%edx
     31c:	8b 45 08             	mov    0x8(%ebp),%eax
     31f:	01 c2                	add    %eax,%edx
     321:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     325:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     327:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     32b:	3c 0a                	cmp    $0xa,%al
     32d:	74 16                	je     345 <gets+0x63>
     32f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     333:	3c 0d                	cmp    $0xd,%al
     335:	74 0e                	je     345 <gets+0x63>
  for(i=0; i+1 < max; ){
     337:	8b 45 f4             	mov    -0xc(%ebp),%eax
     33a:	83 c0 01             	add    $0x1,%eax
     33d:	39 45 0c             	cmp    %eax,0xc(%ebp)
     340:	7f b3                	jg     2f5 <gets+0x13>
     342:	eb 01                	jmp    345 <gets+0x63>
      break;
     344:	90                   	nop
      break;
  }
  buf[i] = '\0';
     345:	8b 55 f4             	mov    -0xc(%ebp),%edx
     348:	8b 45 08             	mov    0x8(%ebp),%eax
     34b:	01 d0                	add    %edx,%eax
     34d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     350:	8b 45 08             	mov    0x8(%ebp),%eax
}
     353:	c9                   	leave  
     354:	c3                   	ret    

00000355 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
     355:	f3 0f 1e fb          	endbr32 
     359:	55                   	push   %ebp
     35a:	89 e5                	mov    %esp,%ebp
     35c:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
     35f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     366:	eb 43                	jmp    3ab <fgets+0x56>
    int cc = read(fd, &c, 1);
     368:	83 ec 04             	sub    $0x4,%esp
     36b:	6a 01                	push   $0x1
     36d:	8d 45 ef             	lea    -0x11(%ebp),%eax
     370:	50                   	push   %eax
     371:	ff 75 10             	pushl  0x10(%ebp)
     374:	e8 2a 02 00 00       	call   5a3 <read>
     379:	83 c4 10             	add    $0x10,%esp
     37c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     37f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     383:	7e 33                	jle    3b8 <fgets+0x63>
      break;
    buf[i++] = c;
     385:	8b 45 f4             	mov    -0xc(%ebp),%eax
     388:	8d 50 01             	lea    0x1(%eax),%edx
     38b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     38e:	89 c2                	mov    %eax,%edx
     390:	8b 45 08             	mov    0x8(%ebp),%eax
     393:	01 c2                	add    %eax,%edx
     395:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     399:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     39b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     39f:	3c 0a                	cmp    $0xa,%al
     3a1:	74 16                	je     3b9 <fgets+0x64>
     3a3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3a7:	3c 0d                	cmp    $0xd,%al
     3a9:	74 0e                	je     3b9 <fgets+0x64>
  for(i = 0; i + 1 < size;){
     3ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3ae:	83 c0 01             	add    $0x1,%eax
     3b1:	39 45 0c             	cmp    %eax,0xc(%ebp)
     3b4:	7f b2                	jg     368 <fgets+0x13>
     3b6:	eb 01                	jmp    3b9 <fgets+0x64>
      break;
     3b8:	90                   	nop
      break;
  }
  buf[i] = '\0';
     3b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3bc:	8b 45 08             	mov    0x8(%ebp),%eax
     3bf:	01 d0                	add    %edx,%eax
     3c1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     3c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3c7:	c9                   	leave  
     3c8:	c3                   	ret    

000003c9 <stat>:

int
stat(char *n, struct stat *st)
{
     3c9:	f3 0f 1e fb          	endbr32 
     3cd:	55                   	push   %ebp
     3ce:	89 e5                	mov    %esp,%ebp
     3d0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3d3:	83 ec 08             	sub    $0x8,%esp
     3d6:	6a 00                	push   $0x0
     3d8:	ff 75 08             	pushl  0x8(%ebp)
     3db:	e8 eb 01 00 00       	call   5cb <open>
     3e0:	83 c4 10             	add    $0x10,%esp
     3e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     3e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3ea:	79 07                	jns    3f3 <stat+0x2a>
    return -1;
     3ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3f1:	eb 25                	jmp    418 <stat+0x4f>
  r = fstat(fd, st);
     3f3:	83 ec 08             	sub    $0x8,%esp
     3f6:	ff 75 0c             	pushl  0xc(%ebp)
     3f9:	ff 75 f4             	pushl  -0xc(%ebp)
     3fc:	e8 e2 01 00 00       	call   5e3 <fstat>
     401:	83 c4 10             	add    $0x10,%esp
     404:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     407:	83 ec 0c             	sub    $0xc,%esp
     40a:	ff 75 f4             	pushl  -0xc(%ebp)
     40d:	e8 a1 01 00 00       	call   5b3 <close>
     412:	83 c4 10             	add    $0x10,%esp
  return r;
     415:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     418:	c9                   	leave  
     419:	c3                   	ret    

0000041a <atoi>:

int
atoi(const char *s)
{
     41a:	f3 0f 1e fb          	endbr32 
     41e:	55                   	push   %ebp
     41f:	89 e5                	mov    %esp,%ebp
     421:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     424:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     42b:	eb 04                	jmp    431 <atoi+0x17>
     42d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     431:	8b 45 08             	mov    0x8(%ebp),%eax
     434:	0f b6 00             	movzbl (%eax),%eax
     437:	3c 20                	cmp    $0x20,%al
     439:	74 f2                	je     42d <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
     43b:	8b 45 08             	mov    0x8(%ebp),%eax
     43e:	0f b6 00             	movzbl (%eax),%eax
     441:	3c 2d                	cmp    $0x2d,%al
     443:	75 07                	jne    44c <atoi+0x32>
     445:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     44a:	eb 05                	jmp    451 <atoi+0x37>
     44c:	b8 01 00 00 00       	mov    $0x1,%eax
     451:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     454:	8b 45 08             	mov    0x8(%ebp),%eax
     457:	0f b6 00             	movzbl (%eax),%eax
     45a:	3c 2b                	cmp    $0x2b,%al
     45c:	74 0a                	je     468 <atoi+0x4e>
     45e:	8b 45 08             	mov    0x8(%ebp),%eax
     461:	0f b6 00             	movzbl (%eax),%eax
     464:	3c 2d                	cmp    $0x2d,%al
     466:	75 2b                	jne    493 <atoi+0x79>
    s++;
     468:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     46c:	eb 25                	jmp    493 <atoi+0x79>
    n = n*10 + *s++ - '0';
     46e:	8b 55 fc             	mov    -0x4(%ebp),%edx
     471:	89 d0                	mov    %edx,%eax
     473:	c1 e0 02             	shl    $0x2,%eax
     476:	01 d0                	add    %edx,%eax
     478:	01 c0                	add    %eax,%eax
     47a:	89 c1                	mov    %eax,%ecx
     47c:	8b 45 08             	mov    0x8(%ebp),%eax
     47f:	8d 50 01             	lea    0x1(%eax),%edx
     482:	89 55 08             	mov    %edx,0x8(%ebp)
     485:	0f b6 00             	movzbl (%eax),%eax
     488:	0f be c0             	movsbl %al,%eax
     48b:	01 c8                	add    %ecx,%eax
     48d:	83 e8 30             	sub    $0x30,%eax
     490:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     493:	8b 45 08             	mov    0x8(%ebp),%eax
     496:	0f b6 00             	movzbl (%eax),%eax
     499:	3c 2f                	cmp    $0x2f,%al
     49b:	7e 0a                	jle    4a7 <atoi+0x8d>
     49d:	8b 45 08             	mov    0x8(%ebp),%eax
     4a0:	0f b6 00             	movzbl (%eax),%eax
     4a3:	3c 39                	cmp    $0x39,%al
     4a5:	7e c7                	jle    46e <atoi+0x54>
  return sign*n;
     4a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4aa:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     4ae:	c9                   	leave  
     4af:	c3                   	ret    

000004b0 <atoo>:

int
atoo(const char *s)
{
     4b0:	f3 0f 1e fb          	endbr32 
     4b4:	55                   	push   %ebp
     4b5:	89 e5                	mov    %esp,%ebp
     4b7:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     4ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     4c1:	eb 04                	jmp    4c7 <atoo+0x17>
     4c3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     4c7:	8b 45 08             	mov    0x8(%ebp),%eax
     4ca:	0f b6 00             	movzbl (%eax),%eax
     4cd:	3c 20                	cmp    $0x20,%al
     4cf:	74 f2                	je     4c3 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
     4d1:	8b 45 08             	mov    0x8(%ebp),%eax
     4d4:	0f b6 00             	movzbl (%eax),%eax
     4d7:	3c 2d                	cmp    $0x2d,%al
     4d9:	75 07                	jne    4e2 <atoo+0x32>
     4db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     4e0:	eb 05                	jmp    4e7 <atoo+0x37>
     4e2:	b8 01 00 00 00       	mov    $0x1,%eax
     4e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     4ea:	8b 45 08             	mov    0x8(%ebp),%eax
     4ed:	0f b6 00             	movzbl (%eax),%eax
     4f0:	3c 2b                	cmp    $0x2b,%al
     4f2:	74 0a                	je     4fe <atoo+0x4e>
     4f4:	8b 45 08             	mov    0x8(%ebp),%eax
     4f7:	0f b6 00             	movzbl (%eax),%eax
     4fa:	3c 2d                	cmp    $0x2d,%al
     4fc:	75 27                	jne    525 <atoo+0x75>
    s++;
     4fe:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     502:	eb 21                	jmp    525 <atoo+0x75>
    n = n*8 + *s++ - '0';
     504:	8b 45 fc             	mov    -0x4(%ebp),%eax
     507:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     50e:	8b 45 08             	mov    0x8(%ebp),%eax
     511:	8d 50 01             	lea    0x1(%eax),%edx
     514:	89 55 08             	mov    %edx,0x8(%ebp)
     517:	0f b6 00             	movzbl (%eax),%eax
     51a:	0f be c0             	movsbl %al,%eax
     51d:	01 c8                	add    %ecx,%eax
     51f:	83 e8 30             	sub    $0x30,%eax
     522:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
     525:	8b 45 08             	mov    0x8(%ebp),%eax
     528:	0f b6 00             	movzbl (%eax),%eax
     52b:	3c 2f                	cmp    $0x2f,%al
     52d:	7e 0a                	jle    539 <atoo+0x89>
     52f:	8b 45 08             	mov    0x8(%ebp),%eax
     532:	0f b6 00             	movzbl (%eax),%eax
     535:	3c 37                	cmp    $0x37,%al
     537:	7e cb                	jle    504 <atoo+0x54>
  return sign*n;
     539:	8b 45 f8             	mov    -0x8(%ebp),%eax
     53c:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     540:	c9                   	leave  
     541:	c3                   	ret    

00000542 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     542:	f3 0f 1e fb          	endbr32 
     546:	55                   	push   %ebp
     547:	89 e5                	mov    %esp,%ebp
     549:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     54c:	8b 45 08             	mov    0x8(%ebp),%eax
     54f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     552:	8b 45 0c             	mov    0xc(%ebp),%eax
     555:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     558:	eb 17                	jmp    571 <memmove+0x2f>
    *dst++ = *src++;
     55a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     55d:	8d 42 01             	lea    0x1(%edx),%eax
     560:	89 45 f8             	mov    %eax,-0x8(%ebp)
     563:	8b 45 fc             	mov    -0x4(%ebp),%eax
     566:	8d 48 01             	lea    0x1(%eax),%ecx
     569:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     56c:	0f b6 12             	movzbl (%edx),%edx
     56f:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     571:	8b 45 10             	mov    0x10(%ebp),%eax
     574:	8d 50 ff             	lea    -0x1(%eax),%edx
     577:	89 55 10             	mov    %edx,0x10(%ebp)
     57a:	85 c0                	test   %eax,%eax
     57c:	7f dc                	jg     55a <memmove+0x18>
  return vdst;
     57e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     581:	c9                   	leave  
     582:	c3                   	ret    

00000583 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     583:	b8 01 00 00 00       	mov    $0x1,%eax
     588:	cd 40                	int    $0x40
     58a:	c3                   	ret    

0000058b <exit>:
SYSCALL(exit)
     58b:	b8 02 00 00 00       	mov    $0x2,%eax
     590:	cd 40                	int    $0x40
     592:	c3                   	ret    

00000593 <wait>:
SYSCALL(wait)
     593:	b8 03 00 00 00       	mov    $0x3,%eax
     598:	cd 40                	int    $0x40
     59a:	c3                   	ret    

0000059b <pipe>:
SYSCALL(pipe)
     59b:	b8 04 00 00 00       	mov    $0x4,%eax
     5a0:	cd 40                	int    $0x40
     5a2:	c3                   	ret    

000005a3 <read>:
SYSCALL(read)
     5a3:	b8 05 00 00 00       	mov    $0x5,%eax
     5a8:	cd 40                	int    $0x40
     5aa:	c3                   	ret    

000005ab <write>:
SYSCALL(write)
     5ab:	b8 10 00 00 00       	mov    $0x10,%eax
     5b0:	cd 40                	int    $0x40
     5b2:	c3                   	ret    

000005b3 <close>:
SYSCALL(close)
     5b3:	b8 15 00 00 00       	mov    $0x15,%eax
     5b8:	cd 40                	int    $0x40
     5ba:	c3                   	ret    

000005bb <kill>:
SYSCALL(kill)
     5bb:	b8 06 00 00 00       	mov    $0x6,%eax
     5c0:	cd 40                	int    $0x40
     5c2:	c3                   	ret    

000005c3 <exec>:
SYSCALL(exec)
     5c3:	b8 07 00 00 00       	mov    $0x7,%eax
     5c8:	cd 40                	int    $0x40
     5ca:	c3                   	ret    

000005cb <open>:
SYSCALL(open)
     5cb:	b8 0f 00 00 00       	mov    $0xf,%eax
     5d0:	cd 40                	int    $0x40
     5d2:	c3                   	ret    

000005d3 <mknod>:
SYSCALL(mknod)
     5d3:	b8 11 00 00 00       	mov    $0x11,%eax
     5d8:	cd 40                	int    $0x40
     5da:	c3                   	ret    

000005db <unlink>:
SYSCALL(unlink)
     5db:	b8 12 00 00 00       	mov    $0x12,%eax
     5e0:	cd 40                	int    $0x40
     5e2:	c3                   	ret    

000005e3 <fstat>:
SYSCALL(fstat)
     5e3:	b8 08 00 00 00       	mov    $0x8,%eax
     5e8:	cd 40                	int    $0x40
     5ea:	c3                   	ret    

000005eb <link>:
SYSCALL(link)
     5eb:	b8 13 00 00 00       	mov    $0x13,%eax
     5f0:	cd 40                	int    $0x40
     5f2:	c3                   	ret    

000005f3 <mkdir>:
SYSCALL(mkdir)
     5f3:	b8 14 00 00 00       	mov    $0x14,%eax
     5f8:	cd 40                	int    $0x40
     5fa:	c3                   	ret    

000005fb <chdir>:
SYSCALL(chdir)
     5fb:	b8 09 00 00 00       	mov    $0x9,%eax
     600:	cd 40                	int    $0x40
     602:	c3                   	ret    

00000603 <dup>:
SYSCALL(dup)
     603:	b8 0a 00 00 00       	mov    $0xa,%eax
     608:	cd 40                	int    $0x40
     60a:	c3                   	ret    

0000060b <getpid>:
SYSCALL(getpid)
     60b:	b8 0b 00 00 00       	mov    $0xb,%eax
     610:	cd 40                	int    $0x40
     612:	c3                   	ret    

00000613 <sbrk>:
SYSCALL(sbrk)
     613:	b8 0c 00 00 00       	mov    $0xc,%eax
     618:	cd 40                	int    $0x40
     61a:	c3                   	ret    

0000061b <sleep>:
SYSCALL(sleep)
     61b:	b8 0d 00 00 00       	mov    $0xd,%eax
     620:	cd 40                	int    $0x40
     622:	c3                   	ret    

00000623 <uptime>:
SYSCALL(uptime)
     623:	b8 0e 00 00 00       	mov    $0xe,%eax
     628:	cd 40                	int    $0x40
     62a:	c3                   	ret    

0000062b <halt>:
SYSCALL(halt)
     62b:	b8 16 00 00 00       	mov    $0x16,%eax
     630:	cd 40                	int    $0x40
     632:	c3                   	ret    

00000633 <date>:
SYSCALL(date)
     633:	b8 17 00 00 00       	mov    $0x17,%eax
     638:	cd 40                	int    $0x40
     63a:	c3                   	ret    

0000063b <getuid>:
SYSCALL(getuid)
     63b:	b8 18 00 00 00       	mov    $0x18,%eax
     640:	cd 40                	int    $0x40
     642:	c3                   	ret    

00000643 <getgid>:
SYSCALL(getgid)
     643:	b8 19 00 00 00       	mov    $0x19,%eax
     648:	cd 40                	int    $0x40
     64a:	c3                   	ret    

0000064b <getppid>:
SYSCALL(getppid)
     64b:	b8 1a 00 00 00       	mov    $0x1a,%eax
     650:	cd 40                	int    $0x40
     652:	c3                   	ret    

00000653 <setuid>:
SYSCALL(setuid)
     653:	b8 1b 00 00 00       	mov    $0x1b,%eax
     658:	cd 40                	int    $0x40
     65a:	c3                   	ret    

0000065b <setgid>:
SYSCALL(setgid)
     65b:	b8 1c 00 00 00       	mov    $0x1c,%eax
     660:	cd 40                	int    $0x40
     662:	c3                   	ret    

00000663 <getprocs>:
SYSCALL(getprocs)
     663:	b8 1d 00 00 00       	mov    $0x1d,%eax
     668:	cd 40                	int    $0x40
     66a:	c3                   	ret    

0000066b <setpriority>:
SYSCALL(setpriority)
     66b:	b8 1e 00 00 00       	mov    $0x1e,%eax
     670:	cd 40                	int    $0x40
     672:	c3                   	ret    

00000673 <chown>:
SYSCALL(chown)
     673:	b8 1f 00 00 00       	mov    $0x1f,%eax
     678:	cd 40                	int    $0x40
     67a:	c3                   	ret    

0000067b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     67b:	f3 0f 1e fb          	endbr32 
     67f:	55                   	push   %ebp
     680:	89 e5                	mov    %esp,%ebp
     682:	83 ec 18             	sub    $0x18,%esp
     685:	8b 45 0c             	mov    0xc(%ebp),%eax
     688:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     68b:	83 ec 04             	sub    $0x4,%esp
     68e:	6a 01                	push   $0x1
     690:	8d 45 f4             	lea    -0xc(%ebp),%eax
     693:	50                   	push   %eax
     694:	ff 75 08             	pushl  0x8(%ebp)
     697:	e8 0f ff ff ff       	call   5ab <write>
     69c:	83 c4 10             	add    $0x10,%esp
}
     69f:	90                   	nop
     6a0:	c9                   	leave  
     6a1:	c3                   	ret    

000006a2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6a2:	f3 0f 1e fb          	endbr32 
     6a6:	55                   	push   %ebp
     6a7:	89 e5                	mov    %esp,%ebp
     6a9:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     6b3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6b7:	74 17                	je     6d0 <printint+0x2e>
     6b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6bd:	79 11                	jns    6d0 <printint+0x2e>
    neg = 1;
     6bf:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6c6:	8b 45 0c             	mov    0xc(%ebp),%eax
     6c9:	f7 d8                	neg    %eax
     6cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6ce:	eb 06                	jmp    6d6 <printint+0x34>
  } else {
    x = xx;
     6d0:	8b 45 0c             	mov    0xc(%ebp),%eax
     6d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6e3:	ba 00 00 00 00       	mov    $0x0,%edx
     6e8:	f7 f1                	div    %ecx
     6ea:	89 d1                	mov    %edx,%ecx
     6ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ef:	8d 50 01             	lea    0x1(%eax),%edx
     6f2:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6f5:	0f b6 91 fc 14 00 00 	movzbl 0x14fc(%ecx),%edx
     6fc:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     700:	8b 4d 10             	mov    0x10(%ebp),%ecx
     703:	8b 45 ec             	mov    -0x14(%ebp),%eax
     706:	ba 00 00 00 00       	mov    $0x0,%edx
     70b:	f7 f1                	div    %ecx
     70d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     710:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     714:	75 c7                	jne    6dd <printint+0x3b>
  if(neg)
     716:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     71a:	74 2d                	je     749 <printint+0xa7>
    buf[i++] = '-';
     71c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     71f:	8d 50 01             	lea    0x1(%eax),%edx
     722:	89 55 f4             	mov    %edx,-0xc(%ebp)
     725:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     72a:	eb 1d                	jmp    749 <printint+0xa7>
    putc(fd, buf[i]);
     72c:	8d 55 dc             	lea    -0x24(%ebp),%edx
     72f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     732:	01 d0                	add    %edx,%eax
     734:	0f b6 00             	movzbl (%eax),%eax
     737:	0f be c0             	movsbl %al,%eax
     73a:	83 ec 08             	sub    $0x8,%esp
     73d:	50                   	push   %eax
     73e:	ff 75 08             	pushl  0x8(%ebp)
     741:	e8 35 ff ff ff       	call   67b <putc>
     746:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     749:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     74d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     751:	79 d9                	jns    72c <printint+0x8a>
}
     753:	90                   	nop
     754:	90                   	nop
     755:	c9                   	leave  
     756:	c3                   	ret    

00000757 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     757:	f3 0f 1e fb          	endbr32 
     75b:	55                   	push   %ebp
     75c:	89 e5                	mov    %esp,%ebp
     75e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     761:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     768:	8d 45 0c             	lea    0xc(%ebp),%eax
     76b:	83 c0 04             	add    $0x4,%eax
     76e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     771:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     778:	e9 59 01 00 00       	jmp    8d6 <printf+0x17f>
    c = fmt[i] & 0xff;
     77d:	8b 55 0c             	mov    0xc(%ebp),%edx
     780:	8b 45 f0             	mov    -0x10(%ebp),%eax
     783:	01 d0                	add    %edx,%eax
     785:	0f b6 00             	movzbl (%eax),%eax
     788:	0f be c0             	movsbl %al,%eax
     78b:	25 ff 00 00 00       	and    $0xff,%eax
     790:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     793:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     797:	75 2c                	jne    7c5 <printf+0x6e>
      if(c == '%'){
     799:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     79d:	75 0c                	jne    7ab <printf+0x54>
        state = '%';
     79f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     7a6:	e9 27 01 00 00       	jmp    8d2 <printf+0x17b>
      } else {
        putc(fd, c);
     7ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7ae:	0f be c0             	movsbl %al,%eax
     7b1:	83 ec 08             	sub    $0x8,%esp
     7b4:	50                   	push   %eax
     7b5:	ff 75 08             	pushl  0x8(%ebp)
     7b8:	e8 be fe ff ff       	call   67b <putc>
     7bd:	83 c4 10             	add    $0x10,%esp
     7c0:	e9 0d 01 00 00       	jmp    8d2 <printf+0x17b>
      }
    } else if(state == '%'){
     7c5:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7c9:	0f 85 03 01 00 00    	jne    8d2 <printf+0x17b>
      if(c == 'd'){
     7cf:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7d3:	75 1e                	jne    7f3 <printf+0x9c>
        printint(fd, *ap, 10, 1);
     7d5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7d8:	8b 00                	mov    (%eax),%eax
     7da:	6a 01                	push   $0x1
     7dc:	6a 0a                	push   $0xa
     7de:	50                   	push   %eax
     7df:	ff 75 08             	pushl  0x8(%ebp)
     7e2:	e8 bb fe ff ff       	call   6a2 <printint>
     7e7:	83 c4 10             	add    $0x10,%esp
        ap++;
     7ea:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7ee:	e9 d8 00 00 00       	jmp    8cb <printf+0x174>
      } else if(c == 'x' || c == 'p'){
     7f3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7f7:	74 06                	je     7ff <printf+0xa8>
     7f9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7fd:	75 1e                	jne    81d <printf+0xc6>
        printint(fd, *ap, 16, 0);
     7ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
     802:	8b 00                	mov    (%eax),%eax
     804:	6a 00                	push   $0x0
     806:	6a 10                	push   $0x10
     808:	50                   	push   %eax
     809:	ff 75 08             	pushl  0x8(%ebp)
     80c:	e8 91 fe ff ff       	call   6a2 <printint>
     811:	83 c4 10             	add    $0x10,%esp
        ap++;
     814:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     818:	e9 ae 00 00 00       	jmp    8cb <printf+0x174>
      } else if(c == 's'){
     81d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     821:	75 43                	jne    866 <printf+0x10f>
        s = (char*)*ap;
     823:	8b 45 e8             	mov    -0x18(%ebp),%eax
     826:	8b 00                	mov    (%eax),%eax
     828:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     82b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     82f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     833:	75 25                	jne    85a <printf+0x103>
          s = "(null)";
     835:	c7 45 f4 aa 10 00 00 	movl   $0x10aa,-0xc(%ebp)
        while(*s != 0){
     83c:	eb 1c                	jmp    85a <printf+0x103>
          putc(fd, *s);
     83e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     841:	0f b6 00             	movzbl (%eax),%eax
     844:	0f be c0             	movsbl %al,%eax
     847:	83 ec 08             	sub    $0x8,%esp
     84a:	50                   	push   %eax
     84b:	ff 75 08             	pushl  0x8(%ebp)
     84e:	e8 28 fe ff ff       	call   67b <putc>
     853:	83 c4 10             	add    $0x10,%esp
          s++;
     856:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     85a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     85d:	0f b6 00             	movzbl (%eax),%eax
     860:	84 c0                	test   %al,%al
     862:	75 da                	jne    83e <printf+0xe7>
     864:	eb 65                	jmp    8cb <printf+0x174>
        }
      } else if(c == 'c'){
     866:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     86a:	75 1d                	jne    889 <printf+0x132>
        putc(fd, *ap);
     86c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     86f:	8b 00                	mov    (%eax),%eax
     871:	0f be c0             	movsbl %al,%eax
     874:	83 ec 08             	sub    $0x8,%esp
     877:	50                   	push   %eax
     878:	ff 75 08             	pushl  0x8(%ebp)
     87b:	e8 fb fd ff ff       	call   67b <putc>
     880:	83 c4 10             	add    $0x10,%esp
        ap++;
     883:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     887:	eb 42                	jmp    8cb <printf+0x174>
      } else if(c == '%'){
     889:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     88d:	75 17                	jne    8a6 <printf+0x14f>
        putc(fd, c);
     88f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     892:	0f be c0             	movsbl %al,%eax
     895:	83 ec 08             	sub    $0x8,%esp
     898:	50                   	push   %eax
     899:	ff 75 08             	pushl  0x8(%ebp)
     89c:	e8 da fd ff ff       	call   67b <putc>
     8a1:	83 c4 10             	add    $0x10,%esp
     8a4:	eb 25                	jmp    8cb <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     8a6:	83 ec 08             	sub    $0x8,%esp
     8a9:	6a 25                	push   $0x25
     8ab:	ff 75 08             	pushl  0x8(%ebp)
     8ae:	e8 c8 fd ff ff       	call   67b <putc>
     8b3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     8b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8b9:	0f be c0             	movsbl %al,%eax
     8bc:	83 ec 08             	sub    $0x8,%esp
     8bf:	50                   	push   %eax
     8c0:	ff 75 08             	pushl  0x8(%ebp)
     8c3:	e8 b3 fd ff ff       	call   67b <putc>
     8c8:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     8d2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8d6:	8b 55 0c             	mov    0xc(%ebp),%edx
     8d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8dc:	01 d0                	add    %edx,%eax
     8de:	0f b6 00             	movzbl (%eax),%eax
     8e1:	84 c0                	test   %al,%al
     8e3:	0f 85 94 fe ff ff    	jne    77d <printf+0x26>
    }
  }
}
     8e9:	90                   	nop
     8ea:	90                   	nop
     8eb:	c9                   	leave  
     8ec:	c3                   	ret    

000008ed <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8ed:	f3 0f 1e fb          	endbr32 
     8f1:	55                   	push   %ebp
     8f2:	89 e5                	mov    %esp,%ebp
     8f4:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8f7:	8b 45 08             	mov    0x8(%ebp),%eax
     8fa:	83 e8 08             	sub    $0x8,%eax
     8fd:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     900:	a1 28 15 00 00       	mov    0x1528,%eax
     905:	89 45 fc             	mov    %eax,-0x4(%ebp)
     908:	eb 24                	jmp    92e <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     90a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     90d:	8b 00                	mov    (%eax),%eax
     90f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     912:	72 12                	jb     926 <free+0x39>
     914:	8b 45 f8             	mov    -0x8(%ebp),%eax
     917:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     91a:	77 24                	ja     940 <free+0x53>
     91c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     91f:	8b 00                	mov    (%eax),%eax
     921:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     924:	72 1a                	jb     940 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     926:	8b 45 fc             	mov    -0x4(%ebp),%eax
     929:	8b 00                	mov    (%eax),%eax
     92b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     92e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     931:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     934:	76 d4                	jbe    90a <free+0x1d>
     936:	8b 45 fc             	mov    -0x4(%ebp),%eax
     939:	8b 00                	mov    (%eax),%eax
     93b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     93e:	73 ca                	jae    90a <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
     940:	8b 45 f8             	mov    -0x8(%ebp),%eax
     943:	8b 40 04             	mov    0x4(%eax),%eax
     946:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     94d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     950:	01 c2                	add    %eax,%edx
     952:	8b 45 fc             	mov    -0x4(%ebp),%eax
     955:	8b 00                	mov    (%eax),%eax
     957:	39 c2                	cmp    %eax,%edx
     959:	75 24                	jne    97f <free+0x92>
    bp->s.size += p->s.ptr->s.size;
     95b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     95e:	8b 50 04             	mov    0x4(%eax),%edx
     961:	8b 45 fc             	mov    -0x4(%ebp),%eax
     964:	8b 00                	mov    (%eax),%eax
     966:	8b 40 04             	mov    0x4(%eax),%eax
     969:	01 c2                	add    %eax,%edx
     96b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     96e:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     971:	8b 45 fc             	mov    -0x4(%ebp),%eax
     974:	8b 00                	mov    (%eax),%eax
     976:	8b 10                	mov    (%eax),%edx
     978:	8b 45 f8             	mov    -0x8(%ebp),%eax
     97b:	89 10                	mov    %edx,(%eax)
     97d:	eb 0a                	jmp    989 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
     97f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     982:	8b 10                	mov    (%eax),%edx
     984:	8b 45 f8             	mov    -0x8(%ebp),%eax
     987:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     989:	8b 45 fc             	mov    -0x4(%ebp),%eax
     98c:	8b 40 04             	mov    0x4(%eax),%eax
     98f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     996:	8b 45 fc             	mov    -0x4(%ebp),%eax
     999:	01 d0                	add    %edx,%eax
     99b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     99e:	75 20                	jne    9c0 <free+0xd3>
    p->s.size += bp->s.size;
     9a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a3:	8b 50 04             	mov    0x4(%eax),%edx
     9a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9a9:	8b 40 04             	mov    0x4(%eax),%eax
     9ac:	01 c2                	add    %eax,%edx
     9ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9b1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     9b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9b7:	8b 10                	mov    (%eax),%edx
     9b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9bc:	89 10                	mov    %edx,(%eax)
     9be:	eb 08                	jmp    9c8 <free+0xdb>
  } else
    p->s.ptr = bp;
     9c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9c3:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9c6:	89 10                	mov    %edx,(%eax)
  freep = p;
     9c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9cb:	a3 28 15 00 00       	mov    %eax,0x1528
}
     9d0:	90                   	nop
     9d1:	c9                   	leave  
     9d2:	c3                   	ret    

000009d3 <morecore>:

static Header*
morecore(uint nu)
{
     9d3:	f3 0f 1e fb          	endbr32 
     9d7:	55                   	push   %ebp
     9d8:	89 e5                	mov    %esp,%ebp
     9da:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9dd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9e4:	77 07                	ja     9ed <morecore+0x1a>
    nu = 4096;
     9e6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9ed:	8b 45 08             	mov    0x8(%ebp),%eax
     9f0:	c1 e0 03             	shl    $0x3,%eax
     9f3:	83 ec 0c             	sub    $0xc,%esp
     9f6:	50                   	push   %eax
     9f7:	e8 17 fc ff ff       	call   613 <sbrk>
     9fc:	83 c4 10             	add    $0x10,%esp
     9ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     a02:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     a06:	75 07                	jne    a0f <morecore+0x3c>
    return 0;
     a08:	b8 00 00 00 00       	mov    $0x0,%eax
     a0d:	eb 26                	jmp    a35 <morecore+0x62>
  hp = (Header*)p;
     a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a12:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a15:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a18:	8b 55 08             	mov    0x8(%ebp),%edx
     a1b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a21:	83 c0 08             	add    $0x8,%eax
     a24:	83 ec 0c             	sub    $0xc,%esp
     a27:	50                   	push   %eax
     a28:	e8 c0 fe ff ff       	call   8ed <free>
     a2d:	83 c4 10             	add    $0x10,%esp
  return freep;
     a30:	a1 28 15 00 00       	mov    0x1528,%eax
}
     a35:	c9                   	leave  
     a36:	c3                   	ret    

00000a37 <malloc>:

void*
malloc(uint nbytes)
{
     a37:	f3 0f 1e fb          	endbr32 
     a3b:	55                   	push   %ebp
     a3c:	89 e5                	mov    %esp,%ebp
     a3e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a41:	8b 45 08             	mov    0x8(%ebp),%eax
     a44:	83 c0 07             	add    $0x7,%eax
     a47:	c1 e8 03             	shr    $0x3,%eax
     a4a:	83 c0 01             	add    $0x1,%eax
     a4d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a50:	a1 28 15 00 00       	mov    0x1528,%eax
     a55:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a5c:	75 23                	jne    a81 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
     a5e:	c7 45 f0 20 15 00 00 	movl   $0x1520,-0x10(%ebp)
     a65:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a68:	a3 28 15 00 00       	mov    %eax,0x1528
     a6d:	a1 28 15 00 00       	mov    0x1528,%eax
     a72:	a3 20 15 00 00       	mov    %eax,0x1520
    base.s.size = 0;
     a77:	c7 05 24 15 00 00 00 	movl   $0x0,0x1524
     a7e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a84:	8b 00                	mov    (%eax),%eax
     a86:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8c:	8b 40 04             	mov    0x4(%eax),%eax
     a8f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a92:	77 4d                	ja     ae1 <malloc+0xaa>
      if(p->s.size == nunits)
     a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a97:	8b 40 04             	mov    0x4(%eax),%eax
     a9a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a9d:	75 0c                	jne    aab <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
     a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa2:	8b 10                	mov    (%eax),%edx
     aa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aa7:	89 10                	mov    %edx,(%eax)
     aa9:	eb 26                	jmp    ad1 <malloc+0x9a>
      else {
        p->s.size -= nunits;
     aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aae:	8b 40 04             	mov    0x4(%eax),%eax
     ab1:	2b 45 ec             	sub    -0x14(%ebp),%eax
     ab4:	89 c2                	mov    %eax,%edx
     ab6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     abf:	8b 40 04             	mov    0x4(%eax),%eax
     ac2:	c1 e0 03             	shl    $0x3,%eax
     ac5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     acb:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ace:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     ad1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ad4:	a3 28 15 00 00       	mov    %eax,0x1528
      return (void*)(p + 1);
     ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     adc:	83 c0 08             	add    $0x8,%eax
     adf:	eb 3b                	jmp    b1c <malloc+0xe5>
    }
    if(p == freep)
     ae1:	a1 28 15 00 00       	mov    0x1528,%eax
     ae6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     ae9:	75 1e                	jne    b09 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
     aeb:	83 ec 0c             	sub    $0xc,%esp
     aee:	ff 75 ec             	pushl  -0x14(%ebp)
     af1:	e8 dd fe ff ff       	call   9d3 <morecore>
     af6:	83 c4 10             	add    $0x10,%esp
     af9:	89 45 f4             	mov    %eax,-0xc(%ebp)
     afc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b00:	75 07                	jne    b09 <malloc+0xd2>
        return 0;
     b02:	b8 00 00 00 00       	mov    $0x0,%eax
     b07:	eb 13                	jmp    b1c <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     b09:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b12:	8b 00                	mov    (%eax),%eax
     b14:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     b17:	e9 6d ff ff ff       	jmp    a89 <malloc+0x52>
  }
}
     b1c:	c9                   	leave  
     b1d:	c3                   	ret    

00000b1e <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
     b1e:	f3 0f 1e fb          	endbr32 
     b22:	55                   	push   %ebp
     b23:	89 e5                	mov    %esp,%ebp
     b25:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     b28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     b2f:	a1 80 15 00 00       	mov    0x1580,%eax
     b34:	83 ec 04             	sub    $0x4,%esp
     b37:	50                   	push   %eax
     b38:	6a 20                	push   $0x20
     b3a:	68 60 15 00 00       	push   $0x1560
     b3f:	e8 11 f8 ff ff       	call   355 <fgets>
     b44:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     b47:	83 ec 0c             	sub    $0xc,%esp
     b4a:	68 60 15 00 00       	push   $0x1560
     b4f:	e8 0e f7 ff ff       	call   262 <strlen>
     b54:	83 c4 10             	add    $0x10,%esp
     b57:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     b5a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b5d:	83 e8 01             	sub    $0x1,%eax
     b60:	0f b6 80 60 15 00 00 	movzbl 0x1560(%eax),%eax
     b67:	3c 0a                	cmp    $0xa,%al
     b69:	74 11                	je     b7c <get_id+0x5e>
     b6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b6e:	83 e8 01             	sub    $0x1,%eax
     b71:	0f b6 80 60 15 00 00 	movzbl 0x1560(%eax),%eax
     b78:	3c 0d                	cmp    $0xd,%al
     b7a:	75 0d                	jne    b89 <get_id+0x6b>
        current_line[len - 1] = 0;
     b7c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b7f:	83 e8 01             	sub    $0x1,%eax
     b82:	c6 80 60 15 00 00 00 	movb   $0x0,0x1560(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     b89:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     b90:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     b97:	eb 6c                	jmp    c05 <get_id+0xe7>
        if(current_line[i] == ' '){
     b99:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b9c:	05 60 15 00 00       	add    $0x1560,%eax
     ba1:	0f b6 00             	movzbl (%eax),%eax
     ba4:	3c 20                	cmp    $0x20,%al
     ba6:	75 30                	jne    bd8 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     ba8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bac:	75 16                	jne    bc4 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     bae:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     bb1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bb4:	8d 50 01             	lea    0x1(%eax),%edx
     bb7:	89 55 f0             	mov    %edx,-0x10(%ebp)
     bba:	8d 91 60 15 00 00    	lea    0x1560(%ecx),%edx
     bc0:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     bc4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bc7:	05 60 15 00 00       	add    $0x1560,%eax
     bcc:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     bcf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     bd6:	eb 29                	jmp    c01 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     bd8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bdc:	75 23                	jne    c01 <get_id+0xe3>
     bde:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     be2:	7f 1d                	jg     c01 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     be4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     beb:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     bee:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bf1:	8d 50 01             	lea    0x1(%eax),%edx
     bf4:	89 55 f0             	mov    %edx,-0x10(%ebp)
     bf7:	8d 91 60 15 00 00    	lea    0x1560(%ecx),%edx
     bfd:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     c01:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     c05:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c08:	05 60 15 00 00       	add    $0x1560,%eax
     c0d:	0f b6 00             	movzbl (%eax),%eax
     c10:	84 c0                	test   %al,%al
     c12:	75 85                	jne    b99 <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     c14:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c18:	75 07                	jne    c21 <get_id+0x103>
        return -1;
     c1a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c1f:	eb 35                	jmp    c56 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
     c21:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c24:	a3 40 15 00 00       	mov    %eax,0x1540
    current_id.uid_user = atoi(tokens[1]);
     c29:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c2c:	83 ec 0c             	sub    $0xc,%esp
     c2f:	50                   	push   %eax
     c30:	e8 e5 f7 ff ff       	call   41a <atoi>
     c35:	83 c4 10             	add    $0x10,%esp
     c38:	a3 44 15 00 00       	mov    %eax,0x1544
    current_id.gid_user = atoi(tokens[2]);
     c3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c40:	83 ec 0c             	sub    $0xc,%esp
     c43:	50                   	push   %eax
     c44:	e8 d1 f7 ff ff       	call   41a <atoi>
     c49:	83 c4 10             	add    $0x10,%esp
     c4c:	a3 48 15 00 00       	mov    %eax,0x1548

    return 0;
     c51:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c56:	c9                   	leave  
     c57:	c3                   	ret    

00000c58 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
     c58:	f3 0f 1e fb          	endbr32 
     c5c:	55                   	push   %ebp
     c5d:	89 e5                	mov    %esp,%ebp
     c5f:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     c62:	a1 80 15 00 00       	mov    0x1580,%eax
     c67:	85 c0                	test   %eax,%eax
     c69:	75 31                	jne    c9c <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
     c6b:	83 ec 08             	sub    $0x8,%esp
     c6e:	6a 00                	push   $0x0
     c70:	68 b1 10 00 00       	push   $0x10b1
     c75:	e8 51 f9 ff ff       	call   5cb <open>
     c7a:	83 c4 10             	add    $0x10,%esp
     c7d:	a3 80 15 00 00       	mov    %eax,0x1580

        if(dir < 0){        // kalau gagal membuka file
     c82:	a1 80 15 00 00       	mov    0x1580,%eax
     c87:	85 c0                	test   %eax,%eax
     c89:	79 11                	jns    c9c <getid+0x44>
            dir = 0;
     c8b:	c7 05 80 15 00 00 00 	movl   $0x0,0x1580
     c92:	00 00 00 
            return 0;
     c95:	b8 00 00 00 00       	mov    $0x0,%eax
     c9a:	eb 16                	jmp    cb2 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
     c9c:	e8 7d fe ff ff       	call   b1e <get_id>
     ca1:	83 f8 ff             	cmp    $0xffffffff,%eax
     ca4:	75 07                	jne    cad <getid+0x55>
        return 0;
     ca6:	b8 00 00 00 00       	mov    $0x0,%eax
     cab:	eb 05                	jmp    cb2 <getid+0x5a>
    
    return &current_id;
     cad:	b8 40 15 00 00       	mov    $0x1540,%eax
}
     cb2:	c9                   	leave  
     cb3:	c3                   	ret    

00000cb4 <setid>:

// open file_ids
void setid(void){
     cb4:	f3 0f 1e fb          	endbr32 
     cb8:	55                   	push   %ebp
     cb9:	89 e5                	mov    %esp,%ebp
     cbb:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     cbe:	a1 80 15 00 00       	mov    0x1580,%eax
     cc3:	85 c0                	test   %eax,%eax
     cc5:	74 1b                	je     ce2 <setid+0x2e>
        close(dir);
     cc7:	a1 80 15 00 00       	mov    0x1580,%eax
     ccc:	83 ec 0c             	sub    $0xc,%esp
     ccf:	50                   	push   %eax
     cd0:	e8 de f8 ff ff       	call   5b3 <close>
     cd5:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     cd8:	c7 05 80 15 00 00 00 	movl   $0x0,0x1580
     cdf:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
     ce2:	83 ec 08             	sub    $0x8,%esp
     ce5:	6a 00                	push   $0x0
     ce7:	68 b1 10 00 00       	push   $0x10b1
     cec:	e8 da f8 ff ff       	call   5cb <open>
     cf1:	83 c4 10             	add    $0x10,%esp
     cf4:	a3 80 15 00 00       	mov    %eax,0x1580

    if (dir < 0)
     cf9:	a1 80 15 00 00       	mov    0x1580,%eax
     cfe:	85 c0                	test   %eax,%eax
     d00:	79 0a                	jns    d0c <setid+0x58>
        dir = 0;
     d02:	c7 05 80 15 00 00 00 	movl   $0x0,0x1580
     d09:	00 00 00 
}
     d0c:	90                   	nop
     d0d:	c9                   	leave  
     d0e:	c3                   	ret    

00000d0f <endid>:

// tutup file_ids
void endid (void){
     d0f:	f3 0f 1e fb          	endbr32 
     d13:	55                   	push   %ebp
     d14:	89 e5                	mov    %esp,%ebp
     d16:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     d19:	a1 80 15 00 00       	mov    0x1580,%eax
     d1e:	85 c0                	test   %eax,%eax
     d20:	74 1b                	je     d3d <endid+0x2e>
        close(dir);
     d22:	a1 80 15 00 00       	mov    0x1580,%eax
     d27:	83 ec 0c             	sub    $0xc,%esp
     d2a:	50                   	push   %eax
     d2b:	e8 83 f8 ff ff       	call   5b3 <close>
     d30:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     d33:	c7 05 80 15 00 00 00 	movl   $0x0,0x1580
     d3a:	00 00 00 
    }
}
     d3d:	90                   	nop
     d3e:	c9                   	leave  
     d3f:	c3                   	ret    

00000d40 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
     d40:	f3 0f 1e fb          	endbr32 
     d44:	55                   	push   %ebp
     d45:	89 e5                	mov    %esp,%ebp
     d47:	83 ec 08             	sub    $0x8,%esp
    setid();
     d4a:	e8 65 ff ff ff       	call   cb4 <setid>

    while (getid()){
     d4f:	eb 24                	jmp    d75 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
     d51:	a1 40 15 00 00       	mov    0x1540,%eax
     d56:	83 ec 08             	sub    $0x8,%esp
     d59:	50                   	push   %eax
     d5a:	ff 75 08             	pushl  0x8(%ebp)
     d5d:	e8 bd f4 ff ff       	call   21f <strcmp>
     d62:	83 c4 10             	add    $0x10,%esp
     d65:	85 c0                	test   %eax,%eax
     d67:	75 0c                	jne    d75 <cek_nama+0x35>
            endid();
     d69:	e8 a1 ff ff ff       	call   d0f <endid>
            return &current_id;
     d6e:	b8 40 15 00 00       	mov    $0x1540,%eax
     d73:	eb 13                	jmp    d88 <cek_nama+0x48>
    while (getid()){
     d75:	e8 de fe ff ff       	call   c58 <getid>
     d7a:	85 c0                	test   %eax,%eax
     d7c:	75 d3                	jne    d51 <cek_nama+0x11>
        }
    }
    endid();
     d7e:	e8 8c ff ff ff       	call   d0f <endid>
    return 0;
     d83:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d88:	c9                   	leave  
     d89:	c3                   	ret    

00000d8a <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
     d8a:	f3 0f 1e fb          	endbr32 
     d8e:	55                   	push   %ebp
     d8f:	89 e5                	mov    %esp,%ebp
     d91:	83 ec 08             	sub    $0x8,%esp
    setid();
     d94:	e8 1b ff ff ff       	call   cb4 <setid>

    while (getid()){
     d99:	eb 16                	jmp    db1 <cek_uid+0x27>
        if(current_id.uid_user == uid){
     d9b:	a1 44 15 00 00       	mov    0x1544,%eax
     da0:	39 45 08             	cmp    %eax,0x8(%ebp)
     da3:	75 0c                	jne    db1 <cek_uid+0x27>
            endid();
     da5:	e8 65 ff ff ff       	call   d0f <endid>
            return &current_id;
     daa:	b8 40 15 00 00       	mov    $0x1540,%eax
     daf:	eb 13                	jmp    dc4 <cek_uid+0x3a>
    while (getid()){
     db1:	e8 a2 fe ff ff       	call   c58 <getid>
     db6:	85 c0                	test   %eax,%eax
     db8:	75 e1                	jne    d9b <cek_uid+0x11>
        }
    }
    endid();
     dba:	e8 50 ff ff ff       	call   d0f <endid>
    return 0;
     dbf:	b8 00 00 00 00       	mov    $0x0,%eax
}
     dc4:	c9                   	leave  
     dc5:	c3                   	ret    

00000dc6 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
     dc6:	f3 0f 1e fb          	endbr32 
     dca:	55                   	push   %ebp
     dcb:	89 e5                	mov    %esp,%ebp
     dcd:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     dd0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     dd7:	a1 80 15 00 00       	mov    0x1580,%eax
     ddc:	83 ec 04             	sub    $0x4,%esp
     ddf:	50                   	push   %eax
     de0:	6a 20                	push   $0x20
     de2:	68 60 15 00 00       	push   $0x1560
     de7:	e8 69 f5 ff ff       	call   355 <fgets>
     dec:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     def:	83 ec 0c             	sub    $0xc,%esp
     df2:	68 60 15 00 00       	push   $0x1560
     df7:	e8 66 f4 ff ff       	call   262 <strlen>
     dfc:	83 c4 10             	add    $0x10,%esp
     dff:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     e02:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e05:	83 e8 01             	sub    $0x1,%eax
     e08:	0f b6 80 60 15 00 00 	movzbl 0x1560(%eax),%eax
     e0f:	3c 0a                	cmp    $0xa,%al
     e11:	74 11                	je     e24 <get_group+0x5e>
     e13:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e16:	83 e8 01             	sub    $0x1,%eax
     e19:	0f b6 80 60 15 00 00 	movzbl 0x1560(%eax),%eax
     e20:	3c 0d                	cmp    $0xd,%al
     e22:	75 0d                	jne    e31 <get_group+0x6b>
        current_line[len - 1] = 0;
     e24:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e27:	83 e8 01             	sub    $0x1,%eax
     e2a:	c6 80 60 15 00 00 00 	movb   $0x0,0x1560(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     e31:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     e38:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e3f:	eb 6c                	jmp    ead <get_group+0xe7>
        if(current_line[i] == ' '){
     e41:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e44:	05 60 15 00 00       	add    $0x1560,%eax
     e49:	0f b6 00             	movzbl (%eax),%eax
     e4c:	3c 20                	cmp    $0x20,%al
     e4e:	75 30                	jne    e80 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     e50:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e54:	75 16                	jne    e6c <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     e56:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     e59:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e5c:	8d 50 01             	lea    0x1(%eax),%edx
     e5f:	89 55 f0             	mov    %edx,-0x10(%ebp)
     e62:	8d 91 60 15 00 00    	lea    0x1560(%ecx),%edx
     e68:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     e6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e6f:	05 60 15 00 00       	add    $0x1560,%eax
     e74:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     e77:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e7e:	eb 29                	jmp    ea9 <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     e80:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e84:	75 23                	jne    ea9 <get_group+0xe3>
     e86:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     e8a:	7f 1d                	jg     ea9 <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     e8c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     e93:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     e96:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e99:	8d 50 01             	lea    0x1(%eax),%edx
     e9c:	89 55 f0             	mov    %edx,-0x10(%ebp)
     e9f:	8d 91 60 15 00 00    	lea    0x1560(%ecx),%edx
     ea5:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     ea9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     ead:	8b 45 ec             	mov    -0x14(%ebp),%eax
     eb0:	05 60 15 00 00       	add    $0x1560,%eax
     eb5:	0f b6 00             	movzbl (%eax),%eax
     eb8:	84 c0                	test   %al,%al
     eba:	75 85                	jne    e41 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     ebc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ec0:	75 07                	jne    ec9 <get_group+0x103>
        return -1;
     ec2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     ec7:	eb 21                	jmp    eea <get_group+0x124>
    
    current_group.nama_group = tokens[0];
     ec9:	8b 45 dc             	mov    -0x24(%ebp),%eax
     ecc:	a3 4c 15 00 00       	mov    %eax,0x154c
    current_group.gid = atoi(tokens[1]);
     ed1:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ed4:	83 ec 0c             	sub    $0xc,%esp
     ed7:	50                   	push   %eax
     ed8:	e8 3d f5 ff ff       	call   41a <atoi>
     edd:	83 c4 10             	add    $0x10,%esp
     ee0:	a3 50 15 00 00       	mov    %eax,0x1550

    return 0;
     ee5:	b8 00 00 00 00       	mov    $0x0,%eax
}
     eea:	c9                   	leave  
     eeb:	c3                   	ret    

00000eec <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
     eec:	f3 0f 1e fb          	endbr32 
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     ef6:	a1 80 15 00 00       	mov    0x1580,%eax
     efb:	85 c0                	test   %eax,%eax
     efd:	75 31                	jne    f30 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
     eff:	83 ec 08             	sub    $0x8,%esp
     f02:	6a 00                	push   $0x0
     f04:	68 b9 10 00 00       	push   $0x10b9
     f09:	e8 bd f6 ff ff       	call   5cb <open>
     f0e:	83 c4 10             	add    $0x10,%esp
     f11:	a3 80 15 00 00       	mov    %eax,0x1580

        if(dir < 0){        // kalau gagal membuka file
     f16:	a1 80 15 00 00       	mov    0x1580,%eax
     f1b:	85 c0                	test   %eax,%eax
     f1d:	79 11                	jns    f30 <getgroup+0x44>
            dir = 0;
     f1f:	c7 05 80 15 00 00 00 	movl   $0x0,0x1580
     f26:	00 00 00 
            return 0;
     f29:	b8 00 00 00 00       	mov    $0x0,%eax
     f2e:	eb 16                	jmp    f46 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
     f30:	e8 91 fe ff ff       	call   dc6 <get_group>
     f35:	83 f8 ff             	cmp    $0xffffffff,%eax
     f38:	75 07                	jne    f41 <getgroup+0x55>
        return 0;
     f3a:	b8 00 00 00 00       	mov    $0x0,%eax
     f3f:	eb 05                	jmp    f46 <getgroup+0x5a>
    
    return &current_group;
     f41:	b8 4c 15 00 00       	mov    $0x154c,%eax
}
     f46:	c9                   	leave  
     f47:	c3                   	ret    

00000f48 <setgroup>:

// open file_ids
void setgroup(void){
     f48:	f3 0f 1e fb          	endbr32 
     f4c:	55                   	push   %ebp
     f4d:	89 e5                	mov    %esp,%ebp
     f4f:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     f52:	a1 80 15 00 00       	mov    0x1580,%eax
     f57:	85 c0                	test   %eax,%eax
     f59:	74 1b                	je     f76 <setgroup+0x2e>
        close(dir);
     f5b:	a1 80 15 00 00       	mov    0x1580,%eax
     f60:	83 ec 0c             	sub    $0xc,%esp
     f63:	50                   	push   %eax
     f64:	e8 4a f6 ff ff       	call   5b3 <close>
     f69:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     f6c:	c7 05 80 15 00 00 00 	movl   $0x0,0x1580
     f73:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
     f76:	83 ec 08             	sub    $0x8,%esp
     f79:	6a 00                	push   $0x0
     f7b:	68 b9 10 00 00       	push   $0x10b9
     f80:	e8 46 f6 ff ff       	call   5cb <open>
     f85:	83 c4 10             	add    $0x10,%esp
     f88:	a3 80 15 00 00       	mov    %eax,0x1580

    if (dir < 0)
     f8d:	a1 80 15 00 00       	mov    0x1580,%eax
     f92:	85 c0                	test   %eax,%eax
     f94:	79 0a                	jns    fa0 <setgroup+0x58>
        dir = 0;
     f96:	c7 05 80 15 00 00 00 	movl   $0x0,0x1580
     f9d:	00 00 00 
}
     fa0:	90                   	nop
     fa1:	c9                   	leave  
     fa2:	c3                   	ret    

00000fa3 <endgroup>:

// tutup file_ids
void endgroup (void){
     fa3:	f3 0f 1e fb          	endbr32 
     fa7:	55                   	push   %ebp
     fa8:	89 e5                	mov    %esp,%ebp
     faa:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     fad:	a1 80 15 00 00       	mov    0x1580,%eax
     fb2:	85 c0                	test   %eax,%eax
     fb4:	74 1b                	je     fd1 <endgroup+0x2e>
        close(dir);
     fb6:	a1 80 15 00 00       	mov    0x1580,%eax
     fbb:	83 ec 0c             	sub    $0xc,%esp
     fbe:	50                   	push   %eax
     fbf:	e8 ef f5 ff ff       	call   5b3 <close>
     fc4:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     fc7:	c7 05 80 15 00 00 00 	movl   $0x0,0x1580
     fce:	00 00 00 
    }
}
     fd1:	90                   	nop
     fd2:	c9                   	leave  
     fd3:	c3                   	ret    

00000fd4 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
     fd4:	f3 0f 1e fb          	endbr32 
     fd8:	55                   	push   %ebp
     fd9:	89 e5                	mov    %esp,%ebp
     fdb:	83 ec 08             	sub    $0x8,%esp
    setgroup();
     fde:	e8 65 ff ff ff       	call   f48 <setgroup>

    while (getgroup()){
     fe3:	eb 3c                	jmp    1021 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
     fe5:	a1 4c 15 00 00       	mov    0x154c,%eax
     fea:	83 ec 08             	sub    $0x8,%esp
     fed:	50                   	push   %eax
     fee:	ff 75 08             	pushl  0x8(%ebp)
     ff1:	e8 29 f2 ff ff       	call   21f <strcmp>
     ff6:	83 c4 10             	add    $0x10,%esp
     ff9:	85 c0                	test   %eax,%eax
     ffb:	75 24                	jne    1021 <cek_nama_group+0x4d>
            endgroup();
     ffd:	e8 a1 ff ff ff       	call   fa3 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
    1002:	a1 4c 15 00 00       	mov    0x154c,%eax
    1007:	83 ec 04             	sub    $0x4,%esp
    100a:	50                   	push   %eax
    100b:	68 c4 10 00 00       	push   $0x10c4
    1010:	6a 01                	push   $0x1
    1012:	e8 40 f7 ff ff       	call   757 <printf>
    1017:	83 c4 10             	add    $0x10,%esp
            return &current_group;
    101a:	b8 4c 15 00 00       	mov    $0x154c,%eax
    101f:	eb 13                	jmp    1034 <cek_nama_group+0x60>
    while (getgroup()){
    1021:	e8 c6 fe ff ff       	call   eec <getgroup>
    1026:	85 c0                	test   %eax,%eax
    1028:	75 bb                	jne    fe5 <cek_nama_group+0x11>
        }
    }
    endgroup();
    102a:	e8 74 ff ff ff       	call   fa3 <endgroup>
    return 0;
    102f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1034:	c9                   	leave  
    1035:	c3                   	ret    

00001036 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
    1036:	f3 0f 1e fb          	endbr32 
    103a:	55                   	push   %ebp
    103b:	89 e5                	mov    %esp,%ebp
    103d:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    1040:	e8 03 ff ff ff       	call   f48 <setgroup>

    while (getgroup()){
    1045:	eb 16                	jmp    105d <cek_gid+0x27>
        if(current_group.gid == gid){
    1047:	a1 50 15 00 00       	mov    0x1550,%eax
    104c:	39 45 08             	cmp    %eax,0x8(%ebp)
    104f:	75 0c                	jne    105d <cek_gid+0x27>
            endgroup();
    1051:	e8 4d ff ff ff       	call   fa3 <endgroup>
            return &current_group;
    1056:	b8 4c 15 00 00       	mov    $0x154c,%eax
    105b:	eb 13                	jmp    1070 <cek_gid+0x3a>
    while (getgroup()){
    105d:	e8 8a fe ff ff       	call   eec <getgroup>
    1062:	85 c0                	test   %eax,%eax
    1064:	75 e1                	jne    1047 <cek_gid+0x11>
        }
    }
    endgroup();
    1066:	e8 38 ff ff ff       	call   fa3 <endgroup>
    return 0;
    106b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1070:	c9                   	leave  
    1071:	c3                   	ret    
