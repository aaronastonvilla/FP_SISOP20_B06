
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
       0:	f3 0f 1e fb          	endbr32 
       4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       8:	83 e4 f0             	and    $0xfffffff0,%esp
       b:	ff 71 fc             	pushl  -0x4(%ecx)
       e:	55                   	push   %ebp
       f:	89 e5                	mov    %esp,%ebp
      11:	51                   	push   %ecx
      12:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
      18:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
      1f:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
      26:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
      2c:	83 ec 08             	sub    $0x8,%esp
      2f:	68 03 10 00 00       	push   $0x1003
      34:	6a 01                	push   $0x1
      36:	e8 ad 06 00 00       	call   6e8 <printf>
      3b:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
      3e:	83 ec 04             	sub    $0x4,%esp
      41:	68 00 02 00 00       	push   $0x200
      46:	6a 61                	push   $0x61
      48:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
      4e:	50                   	push   %eax
      4f:	e8 ca 01 00 00       	call   21e <memset>
      54:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
      57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      5e:	eb 0d                	jmp    6d <main+0x6d>
    if(fork() > 0)
      60:	e8 af 04 00 00       	call   514 <fork>
      65:	85 c0                	test   %eax,%eax
      67:	7f 0c                	jg     75 <main+0x75>
  for(i = 0; i < 4; i++)
      69:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      6d:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
      71:	7e ed                	jle    60 <main+0x60>
      73:	eb 01                	jmp    76 <main+0x76>
      break;
      75:	90                   	nop

  printf(1, "write %d\n", i);
      76:	83 ec 04             	sub    $0x4,%esp
      79:	ff 75 f4             	pushl  -0xc(%ebp)
      7c:	68 16 10 00 00       	push   $0x1016
      81:	6a 01                	push   $0x1
      83:	e8 60 06 00 00       	call   6e8 <printf>
      88:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
      8b:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
      8f:	89 c2                	mov    %eax,%edx
      91:	8b 45 f4             	mov    -0xc(%ebp),%eax
      94:	01 d0                	add    %edx,%eax
      96:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
      99:	83 ec 08             	sub    $0x8,%esp
      9c:	68 02 02 00 00       	push   $0x202
      a1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
      a4:	50                   	push   %eax
      a5:	e8 b2 04 00 00       	call   55c <open>
      aa:	83 c4 10             	add    $0x10,%esp
      ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
      b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      b7:	eb 1e                	jmp    d7 <main+0xd7>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
      b9:	83 ec 04             	sub    $0x4,%esp
      bc:	68 00 02 00 00       	push   $0x200
      c1:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
      c7:	50                   	push   %eax
      c8:	ff 75 f0             	pushl  -0x10(%ebp)
      cb:	e8 6c 04 00 00       	call   53c <write>
      d0:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++)
      d3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      d7:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
      db:	7e dc                	jle    b9 <main+0xb9>
  close(fd);
      dd:	83 ec 0c             	sub    $0xc,%esp
      e0:	ff 75 f0             	pushl  -0x10(%ebp)
      e3:	e8 5c 04 00 00       	call   544 <close>
      e8:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
      eb:	83 ec 08             	sub    $0x8,%esp
      ee:	68 20 10 00 00       	push   $0x1020
      f3:	6a 01                	push   $0x1
      f5:	e8 ee 05 00 00       	call   6e8 <printf>
      fa:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
      fd:	83 ec 08             	sub    $0x8,%esp
     100:	6a 00                	push   $0x0
     102:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     105:	50                   	push   %eax
     106:	e8 51 04 00 00       	call   55c <open>
     10b:	83 c4 10             	add    $0x10,%esp
     10e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
     111:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     118:	eb 1e                	jmp    138 <main+0x138>
    read(fd, data, sizeof(data));
     11a:	83 ec 04             	sub    $0x4,%esp
     11d:	68 00 02 00 00       	push   $0x200
     122:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
     128:	50                   	push   %eax
     129:	ff 75 f0             	pushl  -0x10(%ebp)
     12c:	e8 03 04 00 00       	call   534 <read>
     131:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < 20; i++)
     134:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     138:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
     13c:	7e dc                	jle    11a <main+0x11a>
  close(fd);
     13e:	83 ec 0c             	sub    $0xc,%esp
     141:	ff 75 f0             	pushl  -0x10(%ebp)
     144:	e8 fb 03 00 00       	call   544 <close>
     149:	83 c4 10             	add    $0x10,%esp

  wait();
     14c:	e8 d3 03 00 00       	call   524 <wait>
  
  exit();
     151:	e8 c6 03 00 00       	call   51c <exit>

00000156 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     156:	55                   	push   %ebp
     157:	89 e5                	mov    %esp,%ebp
     159:	57                   	push   %edi
     15a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     15b:	8b 4d 08             	mov    0x8(%ebp),%ecx
     15e:	8b 55 10             	mov    0x10(%ebp),%edx
     161:	8b 45 0c             	mov    0xc(%ebp),%eax
     164:	89 cb                	mov    %ecx,%ebx
     166:	89 df                	mov    %ebx,%edi
     168:	89 d1                	mov    %edx,%ecx
     16a:	fc                   	cld    
     16b:	f3 aa                	rep stos %al,%es:(%edi)
     16d:	89 ca                	mov    %ecx,%edx
     16f:	89 fb                	mov    %edi,%ebx
     171:	89 5d 08             	mov    %ebx,0x8(%ebp)
     174:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     177:	90                   	nop
     178:	5b                   	pop    %ebx
     179:	5f                   	pop    %edi
     17a:	5d                   	pop    %ebp
     17b:	c3                   	ret    

0000017c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     17c:	f3 0f 1e fb          	endbr32 
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     186:	8b 45 08             	mov    0x8(%ebp),%eax
     189:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     18c:	90                   	nop
     18d:	8b 55 0c             	mov    0xc(%ebp),%edx
     190:	8d 42 01             	lea    0x1(%edx),%eax
     193:	89 45 0c             	mov    %eax,0xc(%ebp)
     196:	8b 45 08             	mov    0x8(%ebp),%eax
     199:	8d 48 01             	lea    0x1(%eax),%ecx
     19c:	89 4d 08             	mov    %ecx,0x8(%ebp)
     19f:	0f b6 12             	movzbl (%edx),%edx
     1a2:	88 10                	mov    %dl,(%eax)
     1a4:	0f b6 00             	movzbl (%eax),%eax
     1a7:	84 c0                	test   %al,%al
     1a9:	75 e2                	jne    18d <strcpy+0x11>
    ;
  return os;
     1ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1ae:	c9                   	leave  
     1af:	c3                   	ret    

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1b0:	f3 0f 1e fb          	endbr32 
     1b4:	55                   	push   %ebp
     1b5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     1b7:	eb 08                	jmp    1c1 <strcmp+0x11>
    p++, q++;
     1b9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1bd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     1c1:	8b 45 08             	mov    0x8(%ebp),%eax
     1c4:	0f b6 00             	movzbl (%eax),%eax
     1c7:	84 c0                	test   %al,%al
     1c9:	74 10                	je     1db <strcmp+0x2b>
     1cb:	8b 45 08             	mov    0x8(%ebp),%eax
     1ce:	0f b6 10             	movzbl (%eax),%edx
     1d1:	8b 45 0c             	mov    0xc(%ebp),%eax
     1d4:	0f b6 00             	movzbl (%eax),%eax
     1d7:	38 c2                	cmp    %al,%dl
     1d9:	74 de                	je     1b9 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
     1db:	8b 45 08             	mov    0x8(%ebp),%eax
     1de:	0f b6 00             	movzbl (%eax),%eax
     1e1:	0f b6 d0             	movzbl %al,%edx
     1e4:	8b 45 0c             	mov    0xc(%ebp),%eax
     1e7:	0f b6 00             	movzbl (%eax),%eax
     1ea:	0f b6 c0             	movzbl %al,%eax
     1ed:	29 c2                	sub    %eax,%edx
     1ef:	89 d0                	mov    %edx,%eax
}
     1f1:	5d                   	pop    %ebp
     1f2:	c3                   	ret    

000001f3 <strlen>:

uint
strlen(char *s)
{
     1f3:	f3 0f 1e fb          	endbr32 
     1f7:	55                   	push   %ebp
     1f8:	89 e5                	mov    %esp,%ebp
     1fa:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     1fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     204:	eb 04                	jmp    20a <strlen+0x17>
     206:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     20a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     20d:	8b 45 08             	mov    0x8(%ebp),%eax
     210:	01 d0                	add    %edx,%eax
     212:	0f b6 00             	movzbl (%eax),%eax
     215:	84 c0                	test   %al,%al
     217:	75 ed                	jne    206 <strlen+0x13>
    ;
  return n;
     219:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     21c:	c9                   	leave  
     21d:	c3                   	ret    

0000021e <memset>:

void*
memset(void *dst, int c, uint n)
{
     21e:	f3 0f 1e fb          	endbr32 
     222:	55                   	push   %ebp
     223:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     225:	8b 45 10             	mov    0x10(%ebp),%eax
     228:	50                   	push   %eax
     229:	ff 75 0c             	pushl  0xc(%ebp)
     22c:	ff 75 08             	pushl  0x8(%ebp)
     22f:	e8 22 ff ff ff       	call   156 <stosb>
     234:	83 c4 0c             	add    $0xc,%esp
  return dst;
     237:	8b 45 08             	mov    0x8(%ebp),%eax
}
     23a:	c9                   	leave  
     23b:	c3                   	ret    

0000023c <strchr>:

char*
strchr(const char *s, char c)
{
     23c:	f3 0f 1e fb          	endbr32 
     240:	55                   	push   %ebp
     241:	89 e5                	mov    %esp,%ebp
     243:	83 ec 04             	sub    $0x4,%esp
     246:	8b 45 0c             	mov    0xc(%ebp),%eax
     249:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     24c:	eb 14                	jmp    262 <strchr+0x26>
    if(*s == c)
     24e:	8b 45 08             	mov    0x8(%ebp),%eax
     251:	0f b6 00             	movzbl (%eax),%eax
     254:	38 45 fc             	cmp    %al,-0x4(%ebp)
     257:	75 05                	jne    25e <strchr+0x22>
      return (char*)s;
     259:	8b 45 08             	mov    0x8(%ebp),%eax
     25c:	eb 13                	jmp    271 <strchr+0x35>
  for(; *s; s++)
     25e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     262:	8b 45 08             	mov    0x8(%ebp),%eax
     265:	0f b6 00             	movzbl (%eax),%eax
     268:	84 c0                	test   %al,%al
     26a:	75 e2                	jne    24e <strchr+0x12>
  return 0;
     26c:	b8 00 00 00 00       	mov    $0x0,%eax
}
     271:	c9                   	leave  
     272:	c3                   	ret    

00000273 <gets>:

char*
gets(char *buf, int max)
{
     273:	f3 0f 1e fb          	endbr32 
     277:	55                   	push   %ebp
     278:	89 e5                	mov    %esp,%ebp
     27a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     27d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     284:	eb 42                	jmp    2c8 <gets+0x55>
    cc = read(0, &c, 1);
     286:	83 ec 04             	sub    $0x4,%esp
     289:	6a 01                	push   $0x1
     28b:	8d 45 ef             	lea    -0x11(%ebp),%eax
     28e:	50                   	push   %eax
     28f:	6a 00                	push   $0x0
     291:	e8 9e 02 00 00       	call   534 <read>
     296:	83 c4 10             	add    $0x10,%esp
     299:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     29c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     2a0:	7e 33                	jle    2d5 <gets+0x62>
      break;
    buf[i++] = c;
     2a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2a5:	8d 50 01             	lea    0x1(%eax),%edx
     2a8:	89 55 f4             	mov    %edx,-0xc(%ebp)
     2ab:	89 c2                	mov    %eax,%edx
     2ad:	8b 45 08             	mov    0x8(%ebp),%eax
     2b0:	01 c2                	add    %eax,%edx
     2b2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2b6:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     2b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2bc:	3c 0a                	cmp    $0xa,%al
     2be:	74 16                	je     2d6 <gets+0x63>
     2c0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2c4:	3c 0d                	cmp    $0xd,%al
     2c6:	74 0e                	je     2d6 <gets+0x63>
  for(i=0; i+1 < max; ){
     2c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2cb:	83 c0 01             	add    $0x1,%eax
     2ce:	39 45 0c             	cmp    %eax,0xc(%ebp)
     2d1:	7f b3                	jg     286 <gets+0x13>
     2d3:	eb 01                	jmp    2d6 <gets+0x63>
      break;
     2d5:	90                   	nop
      break;
  }
  buf[i] = '\0';
     2d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     2d9:	8b 45 08             	mov    0x8(%ebp),%eax
     2dc:	01 d0                	add    %edx,%eax
     2de:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     2e1:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2e4:	c9                   	leave  
     2e5:	c3                   	ret    

000002e6 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
     2e6:	f3 0f 1e fb          	endbr32 
     2ea:	55                   	push   %ebp
     2eb:	89 e5                	mov    %esp,%ebp
     2ed:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
     2f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2f7:	eb 43                	jmp    33c <fgets+0x56>
    int cc = read(fd, &c, 1);
     2f9:	83 ec 04             	sub    $0x4,%esp
     2fc:	6a 01                	push   $0x1
     2fe:	8d 45 ef             	lea    -0x11(%ebp),%eax
     301:	50                   	push   %eax
     302:	ff 75 10             	pushl  0x10(%ebp)
     305:	e8 2a 02 00 00       	call   534 <read>
     30a:	83 c4 10             	add    $0x10,%esp
     30d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     310:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     314:	7e 33                	jle    349 <fgets+0x63>
      break;
    buf[i++] = c;
     316:	8b 45 f4             	mov    -0xc(%ebp),%eax
     319:	8d 50 01             	lea    0x1(%eax),%edx
     31c:	89 55 f4             	mov    %edx,-0xc(%ebp)
     31f:	89 c2                	mov    %eax,%edx
     321:	8b 45 08             	mov    0x8(%ebp),%eax
     324:	01 c2                	add    %eax,%edx
     326:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     32a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     32c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     330:	3c 0a                	cmp    $0xa,%al
     332:	74 16                	je     34a <fgets+0x64>
     334:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     338:	3c 0d                	cmp    $0xd,%al
     33a:	74 0e                	je     34a <fgets+0x64>
  for(i = 0; i + 1 < size;){
     33c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     33f:	83 c0 01             	add    $0x1,%eax
     342:	39 45 0c             	cmp    %eax,0xc(%ebp)
     345:	7f b2                	jg     2f9 <fgets+0x13>
     347:	eb 01                	jmp    34a <fgets+0x64>
      break;
     349:	90                   	nop
      break;
  }
  buf[i] = '\0';
     34a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     34d:	8b 45 08             	mov    0x8(%ebp),%eax
     350:	01 d0                	add    %edx,%eax
     352:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     355:	8b 45 08             	mov    0x8(%ebp),%eax
}
     358:	c9                   	leave  
     359:	c3                   	ret    

0000035a <stat>:

int
stat(char *n, struct stat *st)
{
     35a:	f3 0f 1e fb          	endbr32 
     35e:	55                   	push   %ebp
     35f:	89 e5                	mov    %esp,%ebp
     361:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     364:	83 ec 08             	sub    $0x8,%esp
     367:	6a 00                	push   $0x0
     369:	ff 75 08             	pushl  0x8(%ebp)
     36c:	e8 eb 01 00 00       	call   55c <open>
     371:	83 c4 10             	add    $0x10,%esp
     374:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     377:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     37b:	79 07                	jns    384 <stat+0x2a>
    return -1;
     37d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     382:	eb 25                	jmp    3a9 <stat+0x4f>
  r = fstat(fd, st);
     384:	83 ec 08             	sub    $0x8,%esp
     387:	ff 75 0c             	pushl  0xc(%ebp)
     38a:	ff 75 f4             	pushl  -0xc(%ebp)
     38d:	e8 e2 01 00 00       	call   574 <fstat>
     392:	83 c4 10             	add    $0x10,%esp
     395:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     398:	83 ec 0c             	sub    $0xc,%esp
     39b:	ff 75 f4             	pushl  -0xc(%ebp)
     39e:	e8 a1 01 00 00       	call   544 <close>
     3a3:	83 c4 10             	add    $0x10,%esp
  return r;
     3a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     3a9:	c9                   	leave  
     3aa:	c3                   	ret    

000003ab <atoi>:

int
atoi(const char *s)
{
     3ab:	f3 0f 1e fb          	endbr32 
     3af:	55                   	push   %ebp
     3b0:	89 e5                	mov    %esp,%ebp
     3b2:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     3b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     3bc:	eb 04                	jmp    3c2 <atoi+0x17>
     3be:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3c2:	8b 45 08             	mov    0x8(%ebp),%eax
     3c5:	0f b6 00             	movzbl (%eax),%eax
     3c8:	3c 20                	cmp    $0x20,%al
     3ca:	74 f2                	je     3be <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
     3cc:	8b 45 08             	mov    0x8(%ebp),%eax
     3cf:	0f b6 00             	movzbl (%eax),%eax
     3d2:	3c 2d                	cmp    $0x2d,%al
     3d4:	75 07                	jne    3dd <atoi+0x32>
     3d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3db:	eb 05                	jmp    3e2 <atoi+0x37>
     3dd:	b8 01 00 00 00       	mov    $0x1,%eax
     3e2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     3e5:	8b 45 08             	mov    0x8(%ebp),%eax
     3e8:	0f b6 00             	movzbl (%eax),%eax
     3eb:	3c 2b                	cmp    $0x2b,%al
     3ed:	74 0a                	je     3f9 <atoi+0x4e>
     3ef:	8b 45 08             	mov    0x8(%ebp),%eax
     3f2:	0f b6 00             	movzbl (%eax),%eax
     3f5:	3c 2d                	cmp    $0x2d,%al
     3f7:	75 2b                	jne    424 <atoi+0x79>
    s++;
     3f9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     3fd:	eb 25                	jmp    424 <atoi+0x79>
    n = n*10 + *s++ - '0';
     3ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
     402:	89 d0                	mov    %edx,%eax
     404:	c1 e0 02             	shl    $0x2,%eax
     407:	01 d0                	add    %edx,%eax
     409:	01 c0                	add    %eax,%eax
     40b:	89 c1                	mov    %eax,%ecx
     40d:	8b 45 08             	mov    0x8(%ebp),%eax
     410:	8d 50 01             	lea    0x1(%eax),%edx
     413:	89 55 08             	mov    %edx,0x8(%ebp)
     416:	0f b6 00             	movzbl (%eax),%eax
     419:	0f be c0             	movsbl %al,%eax
     41c:	01 c8                	add    %ecx,%eax
     41e:	83 e8 30             	sub    $0x30,%eax
     421:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     424:	8b 45 08             	mov    0x8(%ebp),%eax
     427:	0f b6 00             	movzbl (%eax),%eax
     42a:	3c 2f                	cmp    $0x2f,%al
     42c:	7e 0a                	jle    438 <atoi+0x8d>
     42e:	8b 45 08             	mov    0x8(%ebp),%eax
     431:	0f b6 00             	movzbl (%eax),%eax
     434:	3c 39                	cmp    $0x39,%al
     436:	7e c7                	jle    3ff <atoi+0x54>
  return sign*n;
     438:	8b 45 f8             	mov    -0x8(%ebp),%eax
     43b:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     43f:	c9                   	leave  
     440:	c3                   	ret    

00000441 <atoo>:

int
atoo(const char *s)
{
     441:	f3 0f 1e fb          	endbr32 
     445:	55                   	push   %ebp
     446:	89 e5                	mov    %esp,%ebp
     448:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     44b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     452:	eb 04                	jmp    458 <atoo+0x17>
     454:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     458:	8b 45 08             	mov    0x8(%ebp),%eax
     45b:	0f b6 00             	movzbl (%eax),%eax
     45e:	3c 20                	cmp    $0x20,%al
     460:	74 f2                	je     454 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
     462:	8b 45 08             	mov    0x8(%ebp),%eax
     465:	0f b6 00             	movzbl (%eax),%eax
     468:	3c 2d                	cmp    $0x2d,%al
     46a:	75 07                	jne    473 <atoo+0x32>
     46c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     471:	eb 05                	jmp    478 <atoo+0x37>
     473:	b8 01 00 00 00       	mov    $0x1,%eax
     478:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     47b:	8b 45 08             	mov    0x8(%ebp),%eax
     47e:	0f b6 00             	movzbl (%eax),%eax
     481:	3c 2b                	cmp    $0x2b,%al
     483:	74 0a                	je     48f <atoo+0x4e>
     485:	8b 45 08             	mov    0x8(%ebp),%eax
     488:	0f b6 00             	movzbl (%eax),%eax
     48b:	3c 2d                	cmp    $0x2d,%al
     48d:	75 27                	jne    4b6 <atoo+0x75>
    s++;
     48f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     493:	eb 21                	jmp    4b6 <atoo+0x75>
    n = n*8 + *s++ - '0';
     495:	8b 45 fc             	mov    -0x4(%ebp),%eax
     498:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     49f:	8b 45 08             	mov    0x8(%ebp),%eax
     4a2:	8d 50 01             	lea    0x1(%eax),%edx
     4a5:	89 55 08             	mov    %edx,0x8(%ebp)
     4a8:	0f b6 00             	movzbl (%eax),%eax
     4ab:	0f be c0             	movsbl %al,%eax
     4ae:	01 c8                	add    %ecx,%eax
     4b0:	83 e8 30             	sub    $0x30,%eax
     4b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
     4b6:	8b 45 08             	mov    0x8(%ebp),%eax
     4b9:	0f b6 00             	movzbl (%eax),%eax
     4bc:	3c 2f                	cmp    $0x2f,%al
     4be:	7e 0a                	jle    4ca <atoo+0x89>
     4c0:	8b 45 08             	mov    0x8(%ebp),%eax
     4c3:	0f b6 00             	movzbl (%eax),%eax
     4c6:	3c 37                	cmp    $0x37,%al
     4c8:	7e cb                	jle    495 <atoo+0x54>
  return sign*n;
     4ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4cd:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     4d1:	c9                   	leave  
     4d2:	c3                   	ret    

000004d3 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     4d3:	f3 0f 1e fb          	endbr32 
     4d7:	55                   	push   %ebp
     4d8:	89 e5                	mov    %esp,%ebp
     4da:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     4dd:	8b 45 08             	mov    0x8(%ebp),%eax
     4e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     4e3:	8b 45 0c             	mov    0xc(%ebp),%eax
     4e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     4e9:	eb 17                	jmp    502 <memmove+0x2f>
    *dst++ = *src++;
     4eb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     4ee:	8d 42 01             	lea    0x1(%edx),%eax
     4f1:	89 45 f8             	mov    %eax,-0x8(%ebp)
     4f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4f7:	8d 48 01             	lea    0x1(%eax),%ecx
     4fa:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     4fd:	0f b6 12             	movzbl (%edx),%edx
     500:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     502:	8b 45 10             	mov    0x10(%ebp),%eax
     505:	8d 50 ff             	lea    -0x1(%eax),%edx
     508:	89 55 10             	mov    %edx,0x10(%ebp)
     50b:	85 c0                	test   %eax,%eax
     50d:	7f dc                	jg     4eb <memmove+0x18>
  return vdst;
     50f:	8b 45 08             	mov    0x8(%ebp),%eax
}
     512:	c9                   	leave  
     513:	c3                   	ret    

00000514 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     514:	b8 01 00 00 00       	mov    $0x1,%eax
     519:	cd 40                	int    $0x40
     51b:	c3                   	ret    

0000051c <exit>:
SYSCALL(exit)
     51c:	b8 02 00 00 00       	mov    $0x2,%eax
     521:	cd 40                	int    $0x40
     523:	c3                   	ret    

00000524 <wait>:
SYSCALL(wait)
     524:	b8 03 00 00 00       	mov    $0x3,%eax
     529:	cd 40                	int    $0x40
     52b:	c3                   	ret    

0000052c <pipe>:
SYSCALL(pipe)
     52c:	b8 04 00 00 00       	mov    $0x4,%eax
     531:	cd 40                	int    $0x40
     533:	c3                   	ret    

00000534 <read>:
SYSCALL(read)
     534:	b8 05 00 00 00       	mov    $0x5,%eax
     539:	cd 40                	int    $0x40
     53b:	c3                   	ret    

0000053c <write>:
SYSCALL(write)
     53c:	b8 10 00 00 00       	mov    $0x10,%eax
     541:	cd 40                	int    $0x40
     543:	c3                   	ret    

00000544 <close>:
SYSCALL(close)
     544:	b8 15 00 00 00       	mov    $0x15,%eax
     549:	cd 40                	int    $0x40
     54b:	c3                   	ret    

0000054c <kill>:
SYSCALL(kill)
     54c:	b8 06 00 00 00       	mov    $0x6,%eax
     551:	cd 40                	int    $0x40
     553:	c3                   	ret    

00000554 <exec>:
SYSCALL(exec)
     554:	b8 07 00 00 00       	mov    $0x7,%eax
     559:	cd 40                	int    $0x40
     55b:	c3                   	ret    

0000055c <open>:
SYSCALL(open)
     55c:	b8 0f 00 00 00       	mov    $0xf,%eax
     561:	cd 40                	int    $0x40
     563:	c3                   	ret    

00000564 <mknod>:
SYSCALL(mknod)
     564:	b8 11 00 00 00       	mov    $0x11,%eax
     569:	cd 40                	int    $0x40
     56b:	c3                   	ret    

0000056c <unlink>:
SYSCALL(unlink)
     56c:	b8 12 00 00 00       	mov    $0x12,%eax
     571:	cd 40                	int    $0x40
     573:	c3                   	ret    

00000574 <fstat>:
SYSCALL(fstat)
     574:	b8 08 00 00 00       	mov    $0x8,%eax
     579:	cd 40                	int    $0x40
     57b:	c3                   	ret    

0000057c <link>:
SYSCALL(link)
     57c:	b8 13 00 00 00       	mov    $0x13,%eax
     581:	cd 40                	int    $0x40
     583:	c3                   	ret    

00000584 <mkdir>:
SYSCALL(mkdir)
     584:	b8 14 00 00 00       	mov    $0x14,%eax
     589:	cd 40                	int    $0x40
     58b:	c3                   	ret    

0000058c <chdir>:
SYSCALL(chdir)
     58c:	b8 09 00 00 00       	mov    $0x9,%eax
     591:	cd 40                	int    $0x40
     593:	c3                   	ret    

00000594 <dup>:
SYSCALL(dup)
     594:	b8 0a 00 00 00       	mov    $0xa,%eax
     599:	cd 40                	int    $0x40
     59b:	c3                   	ret    

0000059c <getpid>:
SYSCALL(getpid)
     59c:	b8 0b 00 00 00       	mov    $0xb,%eax
     5a1:	cd 40                	int    $0x40
     5a3:	c3                   	ret    

000005a4 <sbrk>:
SYSCALL(sbrk)
     5a4:	b8 0c 00 00 00       	mov    $0xc,%eax
     5a9:	cd 40                	int    $0x40
     5ab:	c3                   	ret    

000005ac <sleep>:
SYSCALL(sleep)
     5ac:	b8 0d 00 00 00       	mov    $0xd,%eax
     5b1:	cd 40                	int    $0x40
     5b3:	c3                   	ret    

000005b4 <uptime>:
SYSCALL(uptime)
     5b4:	b8 0e 00 00 00       	mov    $0xe,%eax
     5b9:	cd 40                	int    $0x40
     5bb:	c3                   	ret    

000005bc <halt>:
SYSCALL(halt)
     5bc:	b8 16 00 00 00       	mov    $0x16,%eax
     5c1:	cd 40                	int    $0x40
     5c3:	c3                   	ret    

000005c4 <date>:
SYSCALL(date)
     5c4:	b8 17 00 00 00       	mov    $0x17,%eax
     5c9:	cd 40                	int    $0x40
     5cb:	c3                   	ret    

000005cc <getuid>:
SYSCALL(getuid)
     5cc:	b8 18 00 00 00       	mov    $0x18,%eax
     5d1:	cd 40                	int    $0x40
     5d3:	c3                   	ret    

000005d4 <getgid>:
SYSCALL(getgid)
     5d4:	b8 19 00 00 00       	mov    $0x19,%eax
     5d9:	cd 40                	int    $0x40
     5db:	c3                   	ret    

000005dc <getppid>:
SYSCALL(getppid)
     5dc:	b8 1a 00 00 00       	mov    $0x1a,%eax
     5e1:	cd 40                	int    $0x40
     5e3:	c3                   	ret    

000005e4 <setuid>:
SYSCALL(setuid)
     5e4:	b8 1b 00 00 00       	mov    $0x1b,%eax
     5e9:	cd 40                	int    $0x40
     5eb:	c3                   	ret    

000005ec <setgid>:
SYSCALL(setgid)
     5ec:	b8 1c 00 00 00       	mov    $0x1c,%eax
     5f1:	cd 40                	int    $0x40
     5f3:	c3                   	ret    

000005f4 <getprocs>:
SYSCALL(getprocs)
     5f4:	b8 1d 00 00 00       	mov    $0x1d,%eax
     5f9:	cd 40                	int    $0x40
     5fb:	c3                   	ret    

000005fc <setpriority>:
SYSCALL(setpriority)
     5fc:	b8 1e 00 00 00       	mov    $0x1e,%eax
     601:	cd 40                	int    $0x40
     603:	c3                   	ret    

00000604 <chown>:
SYSCALL(chown)
     604:	b8 1f 00 00 00       	mov    $0x1f,%eax
     609:	cd 40                	int    $0x40
     60b:	c3                   	ret    

0000060c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     60c:	f3 0f 1e fb          	endbr32 
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	83 ec 18             	sub    $0x18,%esp
     616:	8b 45 0c             	mov    0xc(%ebp),%eax
     619:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     61c:	83 ec 04             	sub    $0x4,%esp
     61f:	6a 01                	push   $0x1
     621:	8d 45 f4             	lea    -0xc(%ebp),%eax
     624:	50                   	push   %eax
     625:	ff 75 08             	pushl  0x8(%ebp)
     628:	e8 0f ff ff ff       	call   53c <write>
     62d:	83 c4 10             	add    $0x10,%esp
}
     630:	90                   	nop
     631:	c9                   	leave  
     632:	c3                   	ret    

00000633 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     633:	f3 0f 1e fb          	endbr32 
     637:	55                   	push   %ebp
     638:	89 e5                	mov    %esp,%ebp
     63a:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     63d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     644:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     648:	74 17                	je     661 <printint+0x2e>
     64a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     64e:	79 11                	jns    661 <printint+0x2e>
    neg = 1;
     650:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     657:	8b 45 0c             	mov    0xc(%ebp),%eax
     65a:	f7 d8                	neg    %eax
     65c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     65f:	eb 06                	jmp    667 <printint+0x34>
  } else {
    x = xx;
     661:	8b 45 0c             	mov    0xc(%ebp),%eax
     664:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     667:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     66e:	8b 4d 10             	mov    0x10(%ebp),%ecx
     671:	8b 45 ec             	mov    -0x14(%ebp),%eax
     674:	ba 00 00 00 00       	mov    $0x0,%edx
     679:	f7 f1                	div    %ecx
     67b:	89 d1                	mov    %edx,%ecx
     67d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     680:	8d 50 01             	lea    0x1(%eax),%edx
     683:	89 55 f4             	mov    %edx,-0xc(%ebp)
     686:	0f b6 91 54 14 00 00 	movzbl 0x1454(%ecx),%edx
     68d:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     691:	8b 4d 10             	mov    0x10(%ebp),%ecx
     694:	8b 45 ec             	mov    -0x14(%ebp),%eax
     697:	ba 00 00 00 00       	mov    $0x0,%edx
     69c:	f7 f1                	div    %ecx
     69e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6a5:	75 c7                	jne    66e <printint+0x3b>
  if(neg)
     6a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6ab:	74 2d                	je     6da <printint+0xa7>
    buf[i++] = '-';
     6ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6b0:	8d 50 01             	lea    0x1(%eax),%edx
     6b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6b6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     6bb:	eb 1d                	jmp    6da <printint+0xa7>
    putc(fd, buf[i]);
     6bd:	8d 55 dc             	lea    -0x24(%ebp),%edx
     6c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c3:	01 d0                	add    %edx,%eax
     6c5:	0f b6 00             	movzbl (%eax),%eax
     6c8:	0f be c0             	movsbl %al,%eax
     6cb:	83 ec 08             	sub    $0x8,%esp
     6ce:	50                   	push   %eax
     6cf:	ff 75 08             	pushl  0x8(%ebp)
     6d2:	e8 35 ff ff ff       	call   60c <putc>
     6d7:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     6da:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     6de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6e2:	79 d9                	jns    6bd <printint+0x8a>
}
     6e4:	90                   	nop
     6e5:	90                   	nop
     6e6:	c9                   	leave  
     6e7:	c3                   	ret    

000006e8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     6e8:	f3 0f 1e fb          	endbr32 
     6ec:	55                   	push   %ebp
     6ed:	89 e5                	mov    %esp,%ebp
     6ef:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     6f2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     6f9:	8d 45 0c             	lea    0xc(%ebp),%eax
     6fc:	83 c0 04             	add    $0x4,%eax
     6ff:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     702:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     709:	e9 59 01 00 00       	jmp    867 <printf+0x17f>
    c = fmt[i] & 0xff;
     70e:	8b 55 0c             	mov    0xc(%ebp),%edx
     711:	8b 45 f0             	mov    -0x10(%ebp),%eax
     714:	01 d0                	add    %edx,%eax
     716:	0f b6 00             	movzbl (%eax),%eax
     719:	0f be c0             	movsbl %al,%eax
     71c:	25 ff 00 00 00       	and    $0xff,%eax
     721:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     724:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     728:	75 2c                	jne    756 <printf+0x6e>
      if(c == '%'){
     72a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     72e:	75 0c                	jne    73c <printf+0x54>
        state = '%';
     730:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     737:	e9 27 01 00 00       	jmp    863 <printf+0x17b>
      } else {
        putc(fd, c);
     73c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     73f:	0f be c0             	movsbl %al,%eax
     742:	83 ec 08             	sub    $0x8,%esp
     745:	50                   	push   %eax
     746:	ff 75 08             	pushl  0x8(%ebp)
     749:	e8 be fe ff ff       	call   60c <putc>
     74e:	83 c4 10             	add    $0x10,%esp
     751:	e9 0d 01 00 00       	jmp    863 <printf+0x17b>
      }
    } else if(state == '%'){
     756:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     75a:	0f 85 03 01 00 00    	jne    863 <printf+0x17b>
      if(c == 'd'){
     760:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     764:	75 1e                	jne    784 <printf+0x9c>
        printint(fd, *ap, 10, 1);
     766:	8b 45 e8             	mov    -0x18(%ebp),%eax
     769:	8b 00                	mov    (%eax),%eax
     76b:	6a 01                	push   $0x1
     76d:	6a 0a                	push   $0xa
     76f:	50                   	push   %eax
     770:	ff 75 08             	pushl  0x8(%ebp)
     773:	e8 bb fe ff ff       	call   633 <printint>
     778:	83 c4 10             	add    $0x10,%esp
        ap++;
     77b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     77f:	e9 d8 00 00 00       	jmp    85c <printf+0x174>
      } else if(c == 'x' || c == 'p'){
     784:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     788:	74 06                	je     790 <printf+0xa8>
     78a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     78e:	75 1e                	jne    7ae <printf+0xc6>
        printint(fd, *ap, 16, 0);
     790:	8b 45 e8             	mov    -0x18(%ebp),%eax
     793:	8b 00                	mov    (%eax),%eax
     795:	6a 00                	push   $0x0
     797:	6a 10                	push   $0x10
     799:	50                   	push   %eax
     79a:	ff 75 08             	pushl  0x8(%ebp)
     79d:	e8 91 fe ff ff       	call   633 <printint>
     7a2:	83 c4 10             	add    $0x10,%esp
        ap++;
     7a5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7a9:	e9 ae 00 00 00       	jmp    85c <printf+0x174>
      } else if(c == 's'){
     7ae:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     7b2:	75 43                	jne    7f7 <printf+0x10f>
        s = (char*)*ap;
     7b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7b7:	8b 00                	mov    (%eax),%eax
     7b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     7bc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     7c0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7c4:	75 25                	jne    7eb <printf+0x103>
          s = "(null)";
     7c6:	c7 45 f4 26 10 00 00 	movl   $0x1026,-0xc(%ebp)
        while(*s != 0){
     7cd:	eb 1c                	jmp    7eb <printf+0x103>
          putc(fd, *s);
     7cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d2:	0f b6 00             	movzbl (%eax),%eax
     7d5:	0f be c0             	movsbl %al,%eax
     7d8:	83 ec 08             	sub    $0x8,%esp
     7db:	50                   	push   %eax
     7dc:	ff 75 08             	pushl  0x8(%ebp)
     7df:	e8 28 fe ff ff       	call   60c <putc>
     7e4:	83 c4 10             	add    $0x10,%esp
          s++;
     7e7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     7eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ee:	0f b6 00             	movzbl (%eax),%eax
     7f1:	84 c0                	test   %al,%al
     7f3:	75 da                	jne    7cf <printf+0xe7>
     7f5:	eb 65                	jmp    85c <printf+0x174>
        }
      } else if(c == 'c'){
     7f7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     7fb:	75 1d                	jne    81a <printf+0x132>
        putc(fd, *ap);
     7fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     800:	8b 00                	mov    (%eax),%eax
     802:	0f be c0             	movsbl %al,%eax
     805:	83 ec 08             	sub    $0x8,%esp
     808:	50                   	push   %eax
     809:	ff 75 08             	pushl  0x8(%ebp)
     80c:	e8 fb fd ff ff       	call   60c <putc>
     811:	83 c4 10             	add    $0x10,%esp
        ap++;
     814:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     818:	eb 42                	jmp    85c <printf+0x174>
      } else if(c == '%'){
     81a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     81e:	75 17                	jne    837 <printf+0x14f>
        putc(fd, c);
     820:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     823:	0f be c0             	movsbl %al,%eax
     826:	83 ec 08             	sub    $0x8,%esp
     829:	50                   	push   %eax
     82a:	ff 75 08             	pushl  0x8(%ebp)
     82d:	e8 da fd ff ff       	call   60c <putc>
     832:	83 c4 10             	add    $0x10,%esp
     835:	eb 25                	jmp    85c <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     837:	83 ec 08             	sub    $0x8,%esp
     83a:	6a 25                	push   $0x25
     83c:	ff 75 08             	pushl  0x8(%ebp)
     83f:	e8 c8 fd ff ff       	call   60c <putc>
     844:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     847:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     84a:	0f be c0             	movsbl %al,%eax
     84d:	83 ec 08             	sub    $0x8,%esp
     850:	50                   	push   %eax
     851:	ff 75 08             	pushl  0x8(%ebp)
     854:	e8 b3 fd ff ff       	call   60c <putc>
     859:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     85c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     863:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     867:	8b 55 0c             	mov    0xc(%ebp),%edx
     86a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     86d:	01 d0                	add    %edx,%eax
     86f:	0f b6 00             	movzbl (%eax),%eax
     872:	84 c0                	test   %al,%al
     874:	0f 85 94 fe ff ff    	jne    70e <printf+0x26>
    }
  }
}
     87a:	90                   	nop
     87b:	90                   	nop
     87c:	c9                   	leave  
     87d:	c3                   	ret    

0000087e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     87e:	f3 0f 1e fb          	endbr32 
     882:	55                   	push   %ebp
     883:	89 e5                	mov    %esp,%ebp
     885:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     888:	8b 45 08             	mov    0x8(%ebp),%eax
     88b:	83 e8 08             	sub    $0x8,%eax
     88e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     891:	a1 88 14 00 00       	mov    0x1488,%eax
     896:	89 45 fc             	mov    %eax,-0x4(%ebp)
     899:	eb 24                	jmp    8bf <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     89b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     89e:	8b 00                	mov    (%eax),%eax
     8a0:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     8a3:	72 12                	jb     8b7 <free+0x39>
     8a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8a8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8ab:	77 24                	ja     8d1 <free+0x53>
     8ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8b0:	8b 00                	mov    (%eax),%eax
     8b2:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     8b5:	72 1a                	jb     8d1 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ba:	8b 00                	mov    (%eax),%eax
     8bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8c5:	76 d4                	jbe    89b <free+0x1d>
     8c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ca:	8b 00                	mov    (%eax),%eax
     8cc:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     8cf:	73 ca                	jae    89b <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
     8d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8d4:	8b 40 04             	mov    0x4(%eax),%eax
     8d7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     8de:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8e1:	01 c2                	add    %eax,%edx
     8e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8e6:	8b 00                	mov    (%eax),%eax
     8e8:	39 c2                	cmp    %eax,%edx
     8ea:	75 24                	jne    910 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
     8ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8ef:	8b 50 04             	mov    0x4(%eax),%edx
     8f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8f5:	8b 00                	mov    (%eax),%eax
     8f7:	8b 40 04             	mov    0x4(%eax),%eax
     8fa:	01 c2                	add    %eax,%edx
     8fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8ff:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     902:	8b 45 fc             	mov    -0x4(%ebp),%eax
     905:	8b 00                	mov    (%eax),%eax
     907:	8b 10                	mov    (%eax),%edx
     909:	8b 45 f8             	mov    -0x8(%ebp),%eax
     90c:	89 10                	mov    %edx,(%eax)
     90e:	eb 0a                	jmp    91a <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
     910:	8b 45 fc             	mov    -0x4(%ebp),%eax
     913:	8b 10                	mov    (%eax),%edx
     915:	8b 45 f8             	mov    -0x8(%ebp),%eax
     918:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     91a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     91d:	8b 40 04             	mov    0x4(%eax),%eax
     920:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     927:	8b 45 fc             	mov    -0x4(%ebp),%eax
     92a:	01 d0                	add    %edx,%eax
     92c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     92f:	75 20                	jne    951 <free+0xd3>
    p->s.size += bp->s.size;
     931:	8b 45 fc             	mov    -0x4(%ebp),%eax
     934:	8b 50 04             	mov    0x4(%eax),%edx
     937:	8b 45 f8             	mov    -0x8(%ebp),%eax
     93a:	8b 40 04             	mov    0x4(%eax),%eax
     93d:	01 c2                	add    %eax,%edx
     93f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     942:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     945:	8b 45 f8             	mov    -0x8(%ebp),%eax
     948:	8b 10                	mov    (%eax),%edx
     94a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     94d:	89 10                	mov    %edx,(%eax)
     94f:	eb 08                	jmp    959 <free+0xdb>
  } else
    p->s.ptr = bp;
     951:	8b 45 fc             	mov    -0x4(%ebp),%eax
     954:	8b 55 f8             	mov    -0x8(%ebp),%edx
     957:	89 10                	mov    %edx,(%eax)
  freep = p;
     959:	8b 45 fc             	mov    -0x4(%ebp),%eax
     95c:	a3 88 14 00 00       	mov    %eax,0x1488
}
     961:	90                   	nop
     962:	c9                   	leave  
     963:	c3                   	ret    

00000964 <morecore>:

static Header*
morecore(uint nu)
{
     964:	f3 0f 1e fb          	endbr32 
     968:	55                   	push   %ebp
     969:	89 e5                	mov    %esp,%ebp
     96b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     96e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     975:	77 07                	ja     97e <morecore+0x1a>
    nu = 4096;
     977:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     97e:	8b 45 08             	mov    0x8(%ebp),%eax
     981:	c1 e0 03             	shl    $0x3,%eax
     984:	83 ec 0c             	sub    $0xc,%esp
     987:	50                   	push   %eax
     988:	e8 17 fc ff ff       	call   5a4 <sbrk>
     98d:	83 c4 10             	add    $0x10,%esp
     990:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     993:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     997:	75 07                	jne    9a0 <morecore+0x3c>
    return 0;
     999:	b8 00 00 00 00       	mov    $0x0,%eax
     99e:	eb 26                	jmp    9c6 <morecore+0x62>
  hp = (Header*)p;
     9a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     9a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9a9:	8b 55 08             	mov    0x8(%ebp),%edx
     9ac:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     9af:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9b2:	83 c0 08             	add    $0x8,%eax
     9b5:	83 ec 0c             	sub    $0xc,%esp
     9b8:	50                   	push   %eax
     9b9:	e8 c0 fe ff ff       	call   87e <free>
     9be:	83 c4 10             	add    $0x10,%esp
  return freep;
     9c1:	a1 88 14 00 00       	mov    0x1488,%eax
}
     9c6:	c9                   	leave  
     9c7:	c3                   	ret    

000009c8 <malloc>:

void*
malloc(uint nbytes)
{
     9c8:	f3 0f 1e fb          	endbr32 
     9cc:	55                   	push   %ebp
     9cd:	89 e5                	mov    %esp,%ebp
     9cf:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     9d2:	8b 45 08             	mov    0x8(%ebp),%eax
     9d5:	83 c0 07             	add    $0x7,%eax
     9d8:	c1 e8 03             	shr    $0x3,%eax
     9db:	83 c0 01             	add    $0x1,%eax
     9de:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     9e1:	a1 88 14 00 00       	mov    0x1488,%eax
     9e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
     9e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     9ed:	75 23                	jne    a12 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
     9ef:	c7 45 f0 80 14 00 00 	movl   $0x1480,-0x10(%ebp)
     9f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9f9:	a3 88 14 00 00       	mov    %eax,0x1488
     9fe:	a1 88 14 00 00       	mov    0x1488,%eax
     a03:	a3 80 14 00 00       	mov    %eax,0x1480
    base.s.size = 0;
     a08:	c7 05 84 14 00 00 00 	movl   $0x0,0x1484
     a0f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a12:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a15:	8b 00                	mov    (%eax),%eax
     a17:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a1d:	8b 40 04             	mov    0x4(%eax),%eax
     a20:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a23:	77 4d                	ja     a72 <malloc+0xaa>
      if(p->s.size == nunits)
     a25:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a28:	8b 40 04             	mov    0x4(%eax),%eax
     a2b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a2e:	75 0c                	jne    a3c <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
     a30:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a33:	8b 10                	mov    (%eax),%edx
     a35:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a38:	89 10                	mov    %edx,(%eax)
     a3a:	eb 26                	jmp    a62 <malloc+0x9a>
      else {
        p->s.size -= nunits;
     a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a3f:	8b 40 04             	mov    0x4(%eax),%eax
     a42:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a45:	89 c2                	mov    %eax,%edx
     a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a4a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a50:	8b 40 04             	mov    0x4(%eax),%eax
     a53:	c1 e0 03             	shl    $0x3,%eax
     a56:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a5c:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a5f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     a62:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a65:	a3 88 14 00 00       	mov    %eax,0x1488
      return (void*)(p + 1);
     a6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a6d:	83 c0 08             	add    $0x8,%eax
     a70:	eb 3b                	jmp    aad <malloc+0xe5>
    }
    if(p == freep)
     a72:	a1 88 14 00 00       	mov    0x1488,%eax
     a77:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     a7a:	75 1e                	jne    a9a <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
     a7c:	83 ec 0c             	sub    $0xc,%esp
     a7f:	ff 75 ec             	pushl  -0x14(%ebp)
     a82:	e8 dd fe ff ff       	call   964 <morecore>
     a87:	83 c4 10             	add    $0x10,%esp
     a8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
     a8d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     a91:	75 07                	jne    a9a <malloc+0xd2>
        return 0;
     a93:	b8 00 00 00 00       	mov    $0x0,%eax
     a98:	eb 13                	jmp    aad <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     aa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa3:	8b 00                	mov    (%eax),%eax
     aa5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     aa8:	e9 6d ff ff ff       	jmp    a1a <malloc+0x52>
  }
}
     aad:	c9                   	leave  
     aae:	c3                   	ret    

00000aaf <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
     aaf:	f3 0f 1e fb          	endbr32 
     ab3:	55                   	push   %ebp
     ab4:	89 e5                	mov    %esp,%ebp
     ab6:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     ab9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     ac0:	a1 e0 14 00 00       	mov    0x14e0,%eax
     ac5:	83 ec 04             	sub    $0x4,%esp
     ac8:	50                   	push   %eax
     ac9:	6a 20                	push   $0x20
     acb:	68 c0 14 00 00       	push   $0x14c0
     ad0:	e8 11 f8 ff ff       	call   2e6 <fgets>
     ad5:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     ad8:	83 ec 0c             	sub    $0xc,%esp
     adb:	68 c0 14 00 00       	push   $0x14c0
     ae0:	e8 0e f7 ff ff       	call   1f3 <strlen>
     ae5:	83 c4 10             	add    $0x10,%esp
     ae8:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     aeb:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aee:	83 e8 01             	sub    $0x1,%eax
     af1:	0f b6 80 c0 14 00 00 	movzbl 0x14c0(%eax),%eax
     af8:	3c 0a                	cmp    $0xa,%al
     afa:	74 11                	je     b0d <get_id+0x5e>
     afc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     aff:	83 e8 01             	sub    $0x1,%eax
     b02:	0f b6 80 c0 14 00 00 	movzbl 0x14c0(%eax),%eax
     b09:	3c 0d                	cmp    $0xd,%al
     b0b:	75 0d                	jne    b1a <get_id+0x6b>
        current_line[len - 1] = 0;
     b0d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b10:	83 e8 01             	sub    $0x1,%eax
     b13:	c6 80 c0 14 00 00 00 	movb   $0x0,0x14c0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     b1a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     b21:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     b28:	eb 6c                	jmp    b96 <get_id+0xe7>
        if(current_line[i] == ' '){
     b2a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b2d:	05 c0 14 00 00       	add    $0x14c0,%eax
     b32:	0f b6 00             	movzbl (%eax),%eax
     b35:	3c 20                	cmp    $0x20,%al
     b37:	75 30                	jne    b69 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     b39:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b3d:	75 16                	jne    b55 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     b3f:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     b42:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b45:	8d 50 01             	lea    0x1(%eax),%edx
     b48:	89 55 f0             	mov    %edx,-0x10(%ebp)
     b4b:	8d 91 c0 14 00 00    	lea    0x14c0(%ecx),%edx
     b51:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     b55:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b58:	05 c0 14 00 00       	add    $0x14c0,%eax
     b5d:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     b60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     b67:	eb 29                	jmp    b92 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     b69:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b6d:	75 23                	jne    b92 <get_id+0xe3>
     b6f:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     b73:	7f 1d                	jg     b92 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     b75:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     b7c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b82:	8d 50 01             	lea    0x1(%eax),%edx
     b85:	89 55 f0             	mov    %edx,-0x10(%ebp)
     b88:	8d 91 c0 14 00 00    	lea    0x14c0(%ecx),%edx
     b8e:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     b92:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     b96:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b99:	05 c0 14 00 00       	add    $0x14c0,%eax
     b9e:	0f b6 00             	movzbl (%eax),%eax
     ba1:	84 c0                	test   %al,%al
     ba3:	75 85                	jne    b2a <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     ba5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ba9:	75 07                	jne    bb2 <get_id+0x103>
        return -1;
     bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     bb0:	eb 35                	jmp    be7 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
     bb2:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bb5:	a3 a0 14 00 00       	mov    %eax,0x14a0
    current_id.uid_user = atoi(tokens[1]);
     bba:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bbd:	83 ec 0c             	sub    $0xc,%esp
     bc0:	50                   	push   %eax
     bc1:	e8 e5 f7 ff ff       	call   3ab <atoi>
     bc6:	83 c4 10             	add    $0x10,%esp
     bc9:	a3 a4 14 00 00       	mov    %eax,0x14a4
    current_id.gid_user = atoi(tokens[2]);
     bce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     bd1:	83 ec 0c             	sub    $0xc,%esp
     bd4:	50                   	push   %eax
     bd5:	e8 d1 f7 ff ff       	call   3ab <atoi>
     bda:	83 c4 10             	add    $0x10,%esp
     bdd:	a3 a8 14 00 00       	mov    %eax,0x14a8

    return 0;
     be2:	b8 00 00 00 00       	mov    $0x0,%eax
}
     be7:	c9                   	leave  
     be8:	c3                   	ret    

00000be9 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
     be9:	f3 0f 1e fb          	endbr32 
     bed:	55                   	push   %ebp
     bee:	89 e5                	mov    %esp,%ebp
     bf0:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     bf3:	a1 e0 14 00 00       	mov    0x14e0,%eax
     bf8:	85 c0                	test   %eax,%eax
     bfa:	75 31                	jne    c2d <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
     bfc:	83 ec 08             	sub    $0x8,%esp
     bff:	6a 00                	push   $0x0
     c01:	68 2d 10 00 00       	push   $0x102d
     c06:	e8 51 f9 ff ff       	call   55c <open>
     c0b:	83 c4 10             	add    $0x10,%esp
     c0e:	a3 e0 14 00 00       	mov    %eax,0x14e0

        if(dir < 0){        // kalau gagal membuka file
     c13:	a1 e0 14 00 00       	mov    0x14e0,%eax
     c18:	85 c0                	test   %eax,%eax
     c1a:	79 11                	jns    c2d <getid+0x44>
            dir = 0;
     c1c:	c7 05 e0 14 00 00 00 	movl   $0x0,0x14e0
     c23:	00 00 00 
            return 0;
     c26:	b8 00 00 00 00       	mov    $0x0,%eax
     c2b:	eb 16                	jmp    c43 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
     c2d:	e8 7d fe ff ff       	call   aaf <get_id>
     c32:	83 f8 ff             	cmp    $0xffffffff,%eax
     c35:	75 07                	jne    c3e <getid+0x55>
        return 0;
     c37:	b8 00 00 00 00       	mov    $0x0,%eax
     c3c:	eb 05                	jmp    c43 <getid+0x5a>
    
    return &current_id;
     c3e:	b8 a0 14 00 00       	mov    $0x14a0,%eax
}
     c43:	c9                   	leave  
     c44:	c3                   	ret    

00000c45 <setid>:

// open file_ids
void setid(void){
     c45:	f3 0f 1e fb          	endbr32 
     c49:	55                   	push   %ebp
     c4a:	89 e5                	mov    %esp,%ebp
     c4c:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     c4f:	a1 e0 14 00 00       	mov    0x14e0,%eax
     c54:	85 c0                	test   %eax,%eax
     c56:	74 1b                	je     c73 <setid+0x2e>
        close(dir);
     c58:	a1 e0 14 00 00       	mov    0x14e0,%eax
     c5d:	83 ec 0c             	sub    $0xc,%esp
     c60:	50                   	push   %eax
     c61:	e8 de f8 ff ff       	call   544 <close>
     c66:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     c69:	c7 05 e0 14 00 00 00 	movl   $0x0,0x14e0
     c70:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
     c73:	83 ec 08             	sub    $0x8,%esp
     c76:	6a 00                	push   $0x0
     c78:	68 2d 10 00 00       	push   $0x102d
     c7d:	e8 da f8 ff ff       	call   55c <open>
     c82:	83 c4 10             	add    $0x10,%esp
     c85:	a3 e0 14 00 00       	mov    %eax,0x14e0

    if (dir < 0)
     c8a:	a1 e0 14 00 00       	mov    0x14e0,%eax
     c8f:	85 c0                	test   %eax,%eax
     c91:	79 0a                	jns    c9d <setid+0x58>
        dir = 0;
     c93:	c7 05 e0 14 00 00 00 	movl   $0x0,0x14e0
     c9a:	00 00 00 
}
     c9d:	90                   	nop
     c9e:	c9                   	leave  
     c9f:	c3                   	ret    

00000ca0 <endid>:

// tutup file_ids
void endid (void){
     ca0:	f3 0f 1e fb          	endbr32 
     ca4:	55                   	push   %ebp
     ca5:	89 e5                	mov    %esp,%ebp
     ca7:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     caa:	a1 e0 14 00 00       	mov    0x14e0,%eax
     caf:	85 c0                	test   %eax,%eax
     cb1:	74 1b                	je     cce <endid+0x2e>
        close(dir);
     cb3:	a1 e0 14 00 00       	mov    0x14e0,%eax
     cb8:	83 ec 0c             	sub    $0xc,%esp
     cbb:	50                   	push   %eax
     cbc:	e8 83 f8 ff ff       	call   544 <close>
     cc1:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     cc4:	c7 05 e0 14 00 00 00 	movl   $0x0,0x14e0
     ccb:	00 00 00 
    }
}
     cce:	90                   	nop
     ccf:	c9                   	leave  
     cd0:	c3                   	ret    

00000cd1 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
     cd1:	f3 0f 1e fb          	endbr32 
     cd5:	55                   	push   %ebp
     cd6:	89 e5                	mov    %esp,%ebp
     cd8:	83 ec 08             	sub    $0x8,%esp
    setid();
     cdb:	e8 65 ff ff ff       	call   c45 <setid>

    while (getid()){
     ce0:	eb 24                	jmp    d06 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
     ce2:	a1 a0 14 00 00       	mov    0x14a0,%eax
     ce7:	83 ec 08             	sub    $0x8,%esp
     cea:	50                   	push   %eax
     ceb:	ff 75 08             	pushl  0x8(%ebp)
     cee:	e8 bd f4 ff ff       	call   1b0 <strcmp>
     cf3:	83 c4 10             	add    $0x10,%esp
     cf6:	85 c0                	test   %eax,%eax
     cf8:	75 0c                	jne    d06 <cek_nama+0x35>
            endid();
     cfa:	e8 a1 ff ff ff       	call   ca0 <endid>
            return &current_id;
     cff:	b8 a0 14 00 00       	mov    $0x14a0,%eax
     d04:	eb 13                	jmp    d19 <cek_nama+0x48>
    while (getid()){
     d06:	e8 de fe ff ff       	call   be9 <getid>
     d0b:	85 c0                	test   %eax,%eax
     d0d:	75 d3                	jne    ce2 <cek_nama+0x11>
        }
    }
    endid();
     d0f:	e8 8c ff ff ff       	call   ca0 <endid>
    return 0;
     d14:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d19:	c9                   	leave  
     d1a:	c3                   	ret    

00000d1b <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
     d1b:	f3 0f 1e fb          	endbr32 
     d1f:	55                   	push   %ebp
     d20:	89 e5                	mov    %esp,%ebp
     d22:	83 ec 08             	sub    $0x8,%esp
    setid();
     d25:	e8 1b ff ff ff       	call   c45 <setid>

    while (getid()){
     d2a:	eb 16                	jmp    d42 <cek_uid+0x27>
        if(current_id.uid_user == uid){
     d2c:	a1 a4 14 00 00       	mov    0x14a4,%eax
     d31:	39 45 08             	cmp    %eax,0x8(%ebp)
     d34:	75 0c                	jne    d42 <cek_uid+0x27>
            endid();
     d36:	e8 65 ff ff ff       	call   ca0 <endid>
            return &current_id;
     d3b:	b8 a0 14 00 00       	mov    $0x14a0,%eax
     d40:	eb 13                	jmp    d55 <cek_uid+0x3a>
    while (getid()){
     d42:	e8 a2 fe ff ff       	call   be9 <getid>
     d47:	85 c0                	test   %eax,%eax
     d49:	75 e1                	jne    d2c <cek_uid+0x11>
        }
    }
    endid();
     d4b:	e8 50 ff ff ff       	call   ca0 <endid>
    return 0;
     d50:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d55:	c9                   	leave  
     d56:	c3                   	ret    

00000d57 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
     d57:	f3 0f 1e fb          	endbr32 
     d5b:	55                   	push   %ebp
     d5c:	89 e5                	mov    %esp,%ebp
     d5e:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     d61:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     d68:	a1 e0 14 00 00       	mov    0x14e0,%eax
     d6d:	83 ec 04             	sub    $0x4,%esp
     d70:	50                   	push   %eax
     d71:	6a 20                	push   $0x20
     d73:	68 c0 14 00 00       	push   $0x14c0
     d78:	e8 69 f5 ff ff       	call   2e6 <fgets>
     d7d:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     d80:	83 ec 0c             	sub    $0xc,%esp
     d83:	68 c0 14 00 00       	push   $0x14c0
     d88:	e8 66 f4 ff ff       	call   1f3 <strlen>
     d8d:	83 c4 10             	add    $0x10,%esp
     d90:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     d93:	8b 45 e8             	mov    -0x18(%ebp),%eax
     d96:	83 e8 01             	sub    $0x1,%eax
     d99:	0f b6 80 c0 14 00 00 	movzbl 0x14c0(%eax),%eax
     da0:	3c 0a                	cmp    $0xa,%al
     da2:	74 11                	je     db5 <get_group+0x5e>
     da4:	8b 45 e8             	mov    -0x18(%ebp),%eax
     da7:	83 e8 01             	sub    $0x1,%eax
     daa:	0f b6 80 c0 14 00 00 	movzbl 0x14c0(%eax),%eax
     db1:	3c 0d                	cmp    $0xd,%al
     db3:	75 0d                	jne    dc2 <get_group+0x6b>
        current_line[len - 1] = 0;
     db5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     db8:	83 e8 01             	sub    $0x1,%eax
     dbb:	c6 80 c0 14 00 00 00 	movb   $0x0,0x14c0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     dc2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     dc9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     dd0:	eb 6c                	jmp    e3e <get_group+0xe7>
        if(current_line[i] == ' '){
     dd2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     dd5:	05 c0 14 00 00       	add    $0x14c0,%eax
     dda:	0f b6 00             	movzbl (%eax),%eax
     ddd:	3c 20                	cmp    $0x20,%al
     ddf:	75 30                	jne    e11 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     de1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     de5:	75 16                	jne    dfd <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     de7:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     dea:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ded:	8d 50 01             	lea    0x1(%eax),%edx
     df0:	89 55 f0             	mov    %edx,-0x10(%ebp)
     df3:	8d 91 c0 14 00 00    	lea    0x14c0(%ecx),%edx
     df9:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     dfd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e00:	05 c0 14 00 00       	add    $0x14c0,%eax
     e05:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     e08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e0f:	eb 29                	jmp    e3a <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     e11:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e15:	75 23                	jne    e3a <get_group+0xe3>
     e17:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     e1b:	7f 1d                	jg     e3a <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     e1d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     e24:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     e27:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e2a:	8d 50 01             	lea    0x1(%eax),%edx
     e2d:	89 55 f0             	mov    %edx,-0x10(%ebp)
     e30:	8d 91 c0 14 00 00    	lea    0x14c0(%ecx),%edx
     e36:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     e3a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     e3e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e41:	05 c0 14 00 00       	add    $0x14c0,%eax
     e46:	0f b6 00             	movzbl (%eax),%eax
     e49:	84 c0                	test   %al,%al
     e4b:	75 85                	jne    dd2 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     e4d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     e51:	75 07                	jne    e5a <get_group+0x103>
        return -1;
     e53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e58:	eb 21                	jmp    e7b <get_group+0x124>
    
    current_group.nama_group = tokens[0];
     e5a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e5d:	a3 ac 14 00 00       	mov    %eax,0x14ac
    current_group.gid = atoi(tokens[1]);
     e62:	8b 45 e0             	mov    -0x20(%ebp),%eax
     e65:	83 ec 0c             	sub    $0xc,%esp
     e68:	50                   	push   %eax
     e69:	e8 3d f5 ff ff       	call   3ab <atoi>
     e6e:	83 c4 10             	add    $0x10,%esp
     e71:	a3 b0 14 00 00       	mov    %eax,0x14b0

    return 0;
     e76:	b8 00 00 00 00       	mov    $0x0,%eax
}
     e7b:	c9                   	leave  
     e7c:	c3                   	ret    

00000e7d <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
     e7d:	f3 0f 1e fb          	endbr32 
     e81:	55                   	push   %ebp
     e82:	89 e5                	mov    %esp,%ebp
     e84:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     e87:	a1 e0 14 00 00       	mov    0x14e0,%eax
     e8c:	85 c0                	test   %eax,%eax
     e8e:	75 31                	jne    ec1 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
     e90:	83 ec 08             	sub    $0x8,%esp
     e93:	6a 00                	push   $0x0
     e95:	68 35 10 00 00       	push   $0x1035
     e9a:	e8 bd f6 ff ff       	call   55c <open>
     e9f:	83 c4 10             	add    $0x10,%esp
     ea2:	a3 e0 14 00 00       	mov    %eax,0x14e0

        if(dir < 0){        // kalau gagal membuka file
     ea7:	a1 e0 14 00 00       	mov    0x14e0,%eax
     eac:	85 c0                	test   %eax,%eax
     eae:	79 11                	jns    ec1 <getgroup+0x44>
            dir = 0;
     eb0:	c7 05 e0 14 00 00 00 	movl   $0x0,0x14e0
     eb7:	00 00 00 
            return 0;
     eba:	b8 00 00 00 00       	mov    $0x0,%eax
     ebf:	eb 16                	jmp    ed7 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
     ec1:	e8 91 fe ff ff       	call   d57 <get_group>
     ec6:	83 f8 ff             	cmp    $0xffffffff,%eax
     ec9:	75 07                	jne    ed2 <getgroup+0x55>
        return 0;
     ecb:	b8 00 00 00 00       	mov    $0x0,%eax
     ed0:	eb 05                	jmp    ed7 <getgroup+0x5a>
    
    return &current_group;
     ed2:	b8 ac 14 00 00       	mov    $0x14ac,%eax
}
     ed7:	c9                   	leave  
     ed8:	c3                   	ret    

00000ed9 <setgroup>:

// open file_ids
void setgroup(void){
     ed9:	f3 0f 1e fb          	endbr32 
     edd:	55                   	push   %ebp
     ede:	89 e5                	mov    %esp,%ebp
     ee0:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     ee3:	a1 e0 14 00 00       	mov    0x14e0,%eax
     ee8:	85 c0                	test   %eax,%eax
     eea:	74 1b                	je     f07 <setgroup+0x2e>
        close(dir);
     eec:	a1 e0 14 00 00       	mov    0x14e0,%eax
     ef1:	83 ec 0c             	sub    $0xc,%esp
     ef4:	50                   	push   %eax
     ef5:	e8 4a f6 ff ff       	call   544 <close>
     efa:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     efd:	c7 05 e0 14 00 00 00 	movl   $0x0,0x14e0
     f04:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
     f07:	83 ec 08             	sub    $0x8,%esp
     f0a:	6a 00                	push   $0x0
     f0c:	68 35 10 00 00       	push   $0x1035
     f11:	e8 46 f6 ff ff       	call   55c <open>
     f16:	83 c4 10             	add    $0x10,%esp
     f19:	a3 e0 14 00 00       	mov    %eax,0x14e0

    if (dir < 0)
     f1e:	a1 e0 14 00 00       	mov    0x14e0,%eax
     f23:	85 c0                	test   %eax,%eax
     f25:	79 0a                	jns    f31 <setgroup+0x58>
        dir = 0;
     f27:	c7 05 e0 14 00 00 00 	movl   $0x0,0x14e0
     f2e:	00 00 00 
}
     f31:	90                   	nop
     f32:	c9                   	leave  
     f33:	c3                   	ret    

00000f34 <endgroup>:

// tutup file_ids
void endgroup (void){
     f34:	f3 0f 1e fb          	endbr32 
     f38:	55                   	push   %ebp
     f39:	89 e5                	mov    %esp,%ebp
     f3b:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     f3e:	a1 e0 14 00 00       	mov    0x14e0,%eax
     f43:	85 c0                	test   %eax,%eax
     f45:	74 1b                	je     f62 <endgroup+0x2e>
        close(dir);
     f47:	a1 e0 14 00 00       	mov    0x14e0,%eax
     f4c:	83 ec 0c             	sub    $0xc,%esp
     f4f:	50                   	push   %eax
     f50:	e8 ef f5 ff ff       	call   544 <close>
     f55:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     f58:	c7 05 e0 14 00 00 00 	movl   $0x0,0x14e0
     f5f:	00 00 00 
    }
}
     f62:	90                   	nop
     f63:	c9                   	leave  
     f64:	c3                   	ret    

00000f65 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
     f65:	f3 0f 1e fb          	endbr32 
     f69:	55                   	push   %ebp
     f6a:	89 e5                	mov    %esp,%ebp
     f6c:	83 ec 08             	sub    $0x8,%esp
    setgroup();
     f6f:	e8 65 ff ff ff       	call   ed9 <setgroup>

    while (getgroup()){
     f74:	eb 3c                	jmp    fb2 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
     f76:	a1 ac 14 00 00       	mov    0x14ac,%eax
     f7b:	83 ec 08             	sub    $0x8,%esp
     f7e:	50                   	push   %eax
     f7f:	ff 75 08             	pushl  0x8(%ebp)
     f82:	e8 29 f2 ff ff       	call   1b0 <strcmp>
     f87:	83 c4 10             	add    $0x10,%esp
     f8a:	85 c0                	test   %eax,%eax
     f8c:	75 24                	jne    fb2 <cek_nama_group+0x4d>
            endgroup();
     f8e:	e8 a1 ff ff ff       	call   f34 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
     f93:	a1 ac 14 00 00       	mov    0x14ac,%eax
     f98:	83 ec 04             	sub    $0x4,%esp
     f9b:	50                   	push   %eax
     f9c:	68 40 10 00 00       	push   $0x1040
     fa1:	6a 01                	push   $0x1
     fa3:	e8 40 f7 ff ff       	call   6e8 <printf>
     fa8:	83 c4 10             	add    $0x10,%esp
            return &current_group;
     fab:	b8 ac 14 00 00       	mov    $0x14ac,%eax
     fb0:	eb 13                	jmp    fc5 <cek_nama_group+0x60>
    while (getgroup()){
     fb2:	e8 c6 fe ff ff       	call   e7d <getgroup>
     fb7:	85 c0                	test   %eax,%eax
     fb9:	75 bb                	jne    f76 <cek_nama_group+0x11>
        }
    }
    endgroup();
     fbb:	e8 74 ff ff ff       	call   f34 <endgroup>
    return 0;
     fc0:	b8 00 00 00 00       	mov    $0x0,%eax
}
     fc5:	c9                   	leave  
     fc6:	c3                   	ret    

00000fc7 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
     fc7:	f3 0f 1e fb          	endbr32 
     fcb:	55                   	push   %ebp
     fcc:	89 e5                	mov    %esp,%ebp
     fce:	83 ec 08             	sub    $0x8,%esp
    setgroup();
     fd1:	e8 03 ff ff ff       	call   ed9 <setgroup>

    while (getgroup()){
     fd6:	eb 16                	jmp    fee <cek_gid+0x27>
        if(current_group.gid == gid){
     fd8:	a1 b0 14 00 00       	mov    0x14b0,%eax
     fdd:	39 45 08             	cmp    %eax,0x8(%ebp)
     fe0:	75 0c                	jne    fee <cek_gid+0x27>
            endgroup();
     fe2:	e8 4d ff ff ff       	call   f34 <endgroup>
            return &current_group;
     fe7:	b8 ac 14 00 00       	mov    $0x14ac,%eax
     fec:	eb 13                	jmp    1001 <cek_gid+0x3a>
    while (getgroup()){
     fee:	e8 8a fe ff ff       	call   e7d <getgroup>
     ff3:	85 c0                	test   %eax,%eax
     ff5:	75 e1                	jne    fd8 <cek_gid+0x11>
        }
    }
    endgroup();
     ff7:	e8 38 ff ff ff       	call   f34 <endgroup>
    return 0;
     ffc:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1001:	c9                   	leave  
    1002:	c3                   	ret    
