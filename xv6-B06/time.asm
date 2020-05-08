
_time:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int
main(int argc, char * argv[])
{
       0:	f3 0f 1e fb          	endbr32 
       4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       8:	83 e4 f0             	and    $0xfffffff0,%esp
       b:	ff 71 fc             	pushl  -0x4(%ecx)
       e:	55                   	push   %ebp
       f:	89 e5                	mov    %esp,%ebp
      11:	53                   	push   %ebx
      12:	51                   	push   %ecx
      13:	83 ec 20             	sub    $0x20,%esp
      16:	89 cb                	mov    %ecx,%ebx
    if (argc <= 0) {
      18:	83 3b 00             	cmpl   $0x0,(%ebx)
      1b:	7f 05                	jg     22 <main+0x22>
        exit();
      1d:	e8 37 05 00 00       	call   559 <exit>
    }
    uint start_time = 0, end_time = 0, pid = 0,
      22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      29:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      30:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
         elapsed_time = 0, sec = 0, milisec_ten = 0, milisec_hund = 0, milisec_thou = 0;
      37:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
      3e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      45:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
      4c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
      53:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
    if (argc == 1) {
      5a:	83 3b 01             	cmpl   $0x1,(%ebx)
      5d:	75 1d                	jne    7c <main+0x7c>
        printf(1, "%s ran in 0.000 seconds\n", argv[0]);
      5f:	8b 43 04             	mov    0x4(%ebx),%eax
      62:	8b 00                	mov    (%eax),%eax
      64:	83 ec 04             	sub    $0x4,%esp
      67:	50                   	push   %eax
      68:	68 40 10 00 00       	push   $0x1040
      6d:	6a 01                	push   $0x1
      6f:	e8 b1 06 00 00       	call   725 <printf>
      74:	83 c4 10             	add    $0x10,%esp
        exit();
      77:	e8 dd 04 00 00       	call   559 <exit>
    }
    start_time = uptime(); // start uptime
      7c:	e8 70 05 00 00       	call   5f1 <uptime>
      81:	89 45 f4             	mov    %eax,-0xc(%ebp)
    pid = fork(); // fork new process
      84:	e8 c8 04 00 00       	call   551 <fork>
      89:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if (pid > 0) {
      8c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      90:	74 0a                	je     9c <main+0x9c>
        pid = wait(); // wait for child to finish
      92:	e8 ca 04 00 00       	call   561 <wait>
      97:	89 45 ec             	mov    %eax,-0x14(%ebp)
      9a:	eb 26                	jmp    c2 <main+0xc2>
    }
    else if (pid == 0) {
      9c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
      a0:	75 20                	jne    c2 <main+0xc2>
        exec(argv[1], (argv+1)); // pointer arithmetic to skip first index of argv (always will be time)
      a2:	8b 43 04             	mov    0x4(%ebx),%eax
      a5:	8d 50 04             	lea    0x4(%eax),%edx
      a8:	8b 43 04             	mov    0x4(%ebx),%eax
      ab:	83 c0 04             	add    $0x4,%eax
      ae:	8b 00                	mov    (%eax),%eax
      b0:	83 ec 08             	sub    $0x8,%esp
      b3:	52                   	push   %edx
      b4:	50                   	push   %eax
      b5:	e8 d7 04 00 00       	call   591 <exec>
      ba:	83 c4 10             	add    $0x10,%esp
        exit();
      bd:	e8 97 04 00 00       	call   559 <exit>
    }
    end_time = uptime(); // record end time
      c2:	e8 2a 05 00 00       	call   5f1 <uptime>
      c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    elapsed_time = (end_time - start_time); // calc elapsed time
      ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
      cd:	2b 45 f4             	sub    -0xc(%ebp),%eax
      d0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    sec = (elapsed_time / 1000); // divide for whole seconds
      d3:	8b 45 e8             	mov    -0x18(%ebp),%eax
      d6:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
      db:	f7 e2                	mul    %edx
      dd:	89 d0                	mov    %edx,%eax
      df:	c1 e8 06             	shr    $0x6,%eax
      e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    milisec_ten = ((elapsed_time %= 1000) / 100); // mod and divide for miliseconds
      e5:	8b 4d e8             	mov    -0x18(%ebp),%ecx
      e8:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
      ed:	89 c8                	mov    %ecx,%eax
      ef:	f7 e2                	mul    %edx
      f1:	89 d0                	mov    %edx,%eax
      f3:	c1 e8 06             	shr    $0x6,%eax
      f6:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
      fc:	29 c1                	sub    %eax,%ecx
      fe:	89 c8                	mov    %ecx,%eax
     100:	89 45 e8             	mov    %eax,-0x18(%ebp)
     103:	8b 45 e8             	mov    -0x18(%ebp),%eax
     106:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
     10b:	f7 e2                	mul    %edx
     10d:	89 d0                	mov    %edx,%eax
     10f:	c1 e8 05             	shr    $0x5,%eax
     112:	89 45 e0             	mov    %eax,-0x20(%ebp)
    milisec_hund = ((elapsed_time %= 100) / 10);
     115:	8b 4d e8             	mov    -0x18(%ebp),%ecx
     118:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
     11d:	89 c8                	mov    %ecx,%eax
     11f:	f7 e2                	mul    %edx
     121:	89 d0                	mov    %edx,%eax
     123:	c1 e8 05             	shr    $0x5,%eax
     126:	6b c0 64             	imul   $0x64,%eax,%eax
     129:	29 c1                	sub    %eax,%ecx
     12b:	89 c8                	mov    %ecx,%eax
     12d:	89 45 e8             	mov    %eax,-0x18(%ebp)
     130:	8b 45 e8             	mov    -0x18(%ebp),%eax
     133:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
     138:	f7 e2                	mul    %edx
     13a:	89 d0                	mov    %edx,%eax
     13c:	c1 e8 03             	shr    $0x3,%eax
     13f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    milisec_thou = (elapsed_time %= 10);
     142:	8b 4d e8             	mov    -0x18(%ebp),%ecx
     145:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
     14a:	89 c8                	mov    %ecx,%eax
     14c:	f7 e2                	mul    %edx
     14e:	c1 ea 03             	shr    $0x3,%edx
     151:	89 d0                	mov    %edx,%eax
     153:	c1 e0 02             	shl    $0x2,%eax
     156:	01 d0                	add    %edx,%eax
     158:	01 c0                	add    %eax,%eax
     15a:	29 c1                	sub    %eax,%ecx
     15c:	89 c8                	mov    %ecx,%eax
     15e:	89 45 e8             	mov    %eax,-0x18(%ebp)
     161:	8b 45 e8             	mov    -0x18(%ebp),%eax
     164:	89 45 d8             	mov    %eax,-0x28(%ebp)

    printf(1, "%s ran in %d.%d%d%d seconds\n", argv[1], sec, milisec_ten, milisec_hund, milisec_thou);
     167:	8b 43 04             	mov    0x4(%ebx),%eax
     16a:	83 c0 04             	add    $0x4,%eax
     16d:	8b 00                	mov    (%eax),%eax
     16f:	83 ec 04             	sub    $0x4,%esp
     172:	ff 75 d8             	pushl  -0x28(%ebp)
     175:	ff 75 dc             	pushl  -0x24(%ebp)
     178:	ff 75 e0             	pushl  -0x20(%ebp)
     17b:	ff 75 e4             	pushl  -0x1c(%ebp)
     17e:	50                   	push   %eax
     17f:	68 59 10 00 00       	push   $0x1059
     184:	6a 01                	push   $0x1
     186:	e8 9a 05 00 00       	call   725 <printf>
     18b:	83 c4 20             	add    $0x20,%esp
    exit();
     18e:	e8 c6 03 00 00       	call   559 <exit>

00000193 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     193:	55                   	push   %ebp
     194:	89 e5                	mov    %esp,%ebp
     196:	57                   	push   %edi
     197:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     198:	8b 4d 08             	mov    0x8(%ebp),%ecx
     19b:	8b 55 10             	mov    0x10(%ebp),%edx
     19e:	8b 45 0c             	mov    0xc(%ebp),%eax
     1a1:	89 cb                	mov    %ecx,%ebx
     1a3:	89 df                	mov    %ebx,%edi
     1a5:	89 d1                	mov    %edx,%ecx
     1a7:	fc                   	cld    
     1a8:	f3 aa                	rep stos %al,%es:(%edi)
     1aa:	89 ca                	mov    %ecx,%edx
     1ac:	89 fb                	mov    %edi,%ebx
     1ae:	89 5d 08             	mov    %ebx,0x8(%ebp)
     1b1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     1b4:	90                   	nop
     1b5:	5b                   	pop    %ebx
     1b6:	5f                   	pop    %edi
     1b7:	5d                   	pop    %ebp
     1b8:	c3                   	ret    

000001b9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     1b9:	f3 0f 1e fb          	endbr32 
     1bd:	55                   	push   %ebp
     1be:	89 e5                	mov    %esp,%ebp
     1c0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     1c3:	8b 45 08             	mov    0x8(%ebp),%eax
     1c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     1c9:	90                   	nop
     1ca:	8b 55 0c             	mov    0xc(%ebp),%edx
     1cd:	8d 42 01             	lea    0x1(%edx),%eax
     1d0:	89 45 0c             	mov    %eax,0xc(%ebp)
     1d3:	8b 45 08             	mov    0x8(%ebp),%eax
     1d6:	8d 48 01             	lea    0x1(%eax),%ecx
     1d9:	89 4d 08             	mov    %ecx,0x8(%ebp)
     1dc:	0f b6 12             	movzbl (%edx),%edx
     1df:	88 10                	mov    %dl,(%eax)
     1e1:	0f b6 00             	movzbl (%eax),%eax
     1e4:	84 c0                	test   %al,%al
     1e6:	75 e2                	jne    1ca <strcpy+0x11>
    ;
  return os;
     1e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1eb:	c9                   	leave  
     1ec:	c3                   	ret    

000001ed <strcmp>:

int
strcmp(const char *p, const char *q)
{
     1ed:	f3 0f 1e fb          	endbr32 
     1f1:	55                   	push   %ebp
     1f2:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     1f4:	eb 08                	jmp    1fe <strcmp+0x11>
    p++, q++;
     1f6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1fa:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     1fe:	8b 45 08             	mov    0x8(%ebp),%eax
     201:	0f b6 00             	movzbl (%eax),%eax
     204:	84 c0                	test   %al,%al
     206:	74 10                	je     218 <strcmp+0x2b>
     208:	8b 45 08             	mov    0x8(%ebp),%eax
     20b:	0f b6 10             	movzbl (%eax),%edx
     20e:	8b 45 0c             	mov    0xc(%ebp),%eax
     211:	0f b6 00             	movzbl (%eax),%eax
     214:	38 c2                	cmp    %al,%dl
     216:	74 de                	je     1f6 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
     218:	8b 45 08             	mov    0x8(%ebp),%eax
     21b:	0f b6 00             	movzbl (%eax),%eax
     21e:	0f b6 d0             	movzbl %al,%edx
     221:	8b 45 0c             	mov    0xc(%ebp),%eax
     224:	0f b6 00             	movzbl (%eax),%eax
     227:	0f b6 c0             	movzbl %al,%eax
     22a:	29 c2                	sub    %eax,%edx
     22c:	89 d0                	mov    %edx,%eax
}
     22e:	5d                   	pop    %ebp
     22f:	c3                   	ret    

00000230 <strlen>:

uint
strlen(char *s)
{
     230:	f3 0f 1e fb          	endbr32 
     234:	55                   	push   %ebp
     235:	89 e5                	mov    %esp,%ebp
     237:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     23a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     241:	eb 04                	jmp    247 <strlen+0x17>
     243:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     247:	8b 55 fc             	mov    -0x4(%ebp),%edx
     24a:	8b 45 08             	mov    0x8(%ebp),%eax
     24d:	01 d0                	add    %edx,%eax
     24f:	0f b6 00             	movzbl (%eax),%eax
     252:	84 c0                	test   %al,%al
     254:	75 ed                	jne    243 <strlen+0x13>
    ;
  return n;
     256:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     259:	c9                   	leave  
     25a:	c3                   	ret    

0000025b <memset>:

void*
memset(void *dst, int c, uint n)
{
     25b:	f3 0f 1e fb          	endbr32 
     25f:	55                   	push   %ebp
     260:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     262:	8b 45 10             	mov    0x10(%ebp),%eax
     265:	50                   	push   %eax
     266:	ff 75 0c             	pushl  0xc(%ebp)
     269:	ff 75 08             	pushl  0x8(%ebp)
     26c:	e8 22 ff ff ff       	call   193 <stosb>
     271:	83 c4 0c             	add    $0xc,%esp
  return dst;
     274:	8b 45 08             	mov    0x8(%ebp),%eax
}
     277:	c9                   	leave  
     278:	c3                   	ret    

00000279 <strchr>:

char*
strchr(const char *s, char c)
{
     279:	f3 0f 1e fb          	endbr32 
     27d:	55                   	push   %ebp
     27e:	89 e5                	mov    %esp,%ebp
     280:	83 ec 04             	sub    $0x4,%esp
     283:	8b 45 0c             	mov    0xc(%ebp),%eax
     286:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     289:	eb 14                	jmp    29f <strchr+0x26>
    if(*s == c)
     28b:	8b 45 08             	mov    0x8(%ebp),%eax
     28e:	0f b6 00             	movzbl (%eax),%eax
     291:	38 45 fc             	cmp    %al,-0x4(%ebp)
     294:	75 05                	jne    29b <strchr+0x22>
      return (char*)s;
     296:	8b 45 08             	mov    0x8(%ebp),%eax
     299:	eb 13                	jmp    2ae <strchr+0x35>
  for(; *s; s++)
     29b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     29f:	8b 45 08             	mov    0x8(%ebp),%eax
     2a2:	0f b6 00             	movzbl (%eax),%eax
     2a5:	84 c0                	test   %al,%al
     2a7:	75 e2                	jne    28b <strchr+0x12>
  return 0;
     2a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2ae:	c9                   	leave  
     2af:	c3                   	ret    

000002b0 <gets>:

char*
gets(char *buf, int max)
{
     2b0:	f3 0f 1e fb          	endbr32 
     2b4:	55                   	push   %ebp
     2b5:	89 e5                	mov    %esp,%ebp
     2b7:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     2c1:	eb 42                	jmp    305 <gets+0x55>
    cc = read(0, &c, 1);
     2c3:	83 ec 04             	sub    $0x4,%esp
     2c6:	6a 01                	push   $0x1
     2c8:	8d 45 ef             	lea    -0x11(%ebp),%eax
     2cb:	50                   	push   %eax
     2cc:	6a 00                	push   $0x0
     2ce:	e8 9e 02 00 00       	call   571 <read>
     2d3:	83 c4 10             	add    $0x10,%esp
     2d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     2d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     2dd:	7e 33                	jle    312 <gets+0x62>
      break;
    buf[i++] = c;
     2df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2e2:	8d 50 01             	lea    0x1(%eax),%edx
     2e5:	89 55 f4             	mov    %edx,-0xc(%ebp)
     2e8:	89 c2                	mov    %eax,%edx
     2ea:	8b 45 08             	mov    0x8(%ebp),%eax
     2ed:	01 c2                	add    %eax,%edx
     2ef:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2f3:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     2f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     2f9:	3c 0a                	cmp    $0xa,%al
     2fb:	74 16                	je     313 <gets+0x63>
     2fd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     301:	3c 0d                	cmp    $0xd,%al
     303:	74 0e                	je     313 <gets+0x63>
  for(i=0; i+1 < max; ){
     305:	8b 45 f4             	mov    -0xc(%ebp),%eax
     308:	83 c0 01             	add    $0x1,%eax
     30b:	39 45 0c             	cmp    %eax,0xc(%ebp)
     30e:	7f b3                	jg     2c3 <gets+0x13>
     310:	eb 01                	jmp    313 <gets+0x63>
      break;
     312:	90                   	nop
      break;
  }
  buf[i] = '\0';
     313:	8b 55 f4             	mov    -0xc(%ebp),%edx
     316:	8b 45 08             	mov    0x8(%ebp),%eax
     319:	01 d0                	add    %edx,%eax
     31b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     31e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     321:	c9                   	leave  
     322:	c3                   	ret    

00000323 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
     323:	f3 0f 1e fb          	endbr32 
     327:	55                   	push   %ebp
     328:	89 e5                	mov    %esp,%ebp
     32a:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
     32d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     334:	eb 43                	jmp    379 <fgets+0x56>
    int cc = read(fd, &c, 1);
     336:	83 ec 04             	sub    $0x4,%esp
     339:	6a 01                	push   $0x1
     33b:	8d 45 ef             	lea    -0x11(%ebp),%eax
     33e:	50                   	push   %eax
     33f:	ff 75 10             	pushl  0x10(%ebp)
     342:	e8 2a 02 00 00       	call   571 <read>
     347:	83 c4 10             	add    $0x10,%esp
     34a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     34d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     351:	7e 33                	jle    386 <fgets+0x63>
      break;
    buf[i++] = c;
     353:	8b 45 f4             	mov    -0xc(%ebp),%eax
     356:	8d 50 01             	lea    0x1(%eax),%edx
     359:	89 55 f4             	mov    %edx,-0xc(%ebp)
     35c:	89 c2                	mov    %eax,%edx
     35e:	8b 45 08             	mov    0x8(%ebp),%eax
     361:	01 c2                	add    %eax,%edx
     363:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     367:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     369:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     36d:	3c 0a                	cmp    $0xa,%al
     36f:	74 16                	je     387 <fgets+0x64>
     371:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     375:	3c 0d                	cmp    $0xd,%al
     377:	74 0e                	je     387 <fgets+0x64>
  for(i = 0; i + 1 < size;){
     379:	8b 45 f4             	mov    -0xc(%ebp),%eax
     37c:	83 c0 01             	add    $0x1,%eax
     37f:	39 45 0c             	cmp    %eax,0xc(%ebp)
     382:	7f b2                	jg     336 <fgets+0x13>
     384:	eb 01                	jmp    387 <fgets+0x64>
      break;
     386:	90                   	nop
      break;
  }
  buf[i] = '\0';
     387:	8b 55 f4             	mov    -0xc(%ebp),%edx
     38a:	8b 45 08             	mov    0x8(%ebp),%eax
     38d:	01 d0                	add    %edx,%eax
     38f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     392:	8b 45 08             	mov    0x8(%ebp),%eax
}
     395:	c9                   	leave  
     396:	c3                   	ret    

00000397 <stat>:

int
stat(char *n, struct stat *st)
{
     397:	f3 0f 1e fb          	endbr32 
     39b:	55                   	push   %ebp
     39c:	89 e5                	mov    %esp,%ebp
     39e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3a1:	83 ec 08             	sub    $0x8,%esp
     3a4:	6a 00                	push   $0x0
     3a6:	ff 75 08             	pushl  0x8(%ebp)
     3a9:	e8 eb 01 00 00       	call   599 <open>
     3ae:	83 c4 10             	add    $0x10,%esp
     3b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     3b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3b8:	79 07                	jns    3c1 <stat+0x2a>
    return -1;
     3ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3bf:	eb 25                	jmp    3e6 <stat+0x4f>
  r = fstat(fd, st);
     3c1:	83 ec 08             	sub    $0x8,%esp
     3c4:	ff 75 0c             	pushl  0xc(%ebp)
     3c7:	ff 75 f4             	pushl  -0xc(%ebp)
     3ca:	e8 e2 01 00 00       	call   5b1 <fstat>
     3cf:	83 c4 10             	add    $0x10,%esp
     3d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     3d5:	83 ec 0c             	sub    $0xc,%esp
     3d8:	ff 75 f4             	pushl  -0xc(%ebp)
     3db:	e8 a1 01 00 00       	call   581 <close>
     3e0:	83 c4 10             	add    $0x10,%esp
  return r;
     3e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     3e6:	c9                   	leave  
     3e7:	c3                   	ret    

000003e8 <atoi>:

int
atoi(const char *s)
{
     3e8:	f3 0f 1e fb          	endbr32 
     3ec:	55                   	push   %ebp
     3ed:	89 e5                	mov    %esp,%ebp
     3ef:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     3f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     3f9:	eb 04                	jmp    3ff <atoi+0x17>
     3fb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3ff:	8b 45 08             	mov    0x8(%ebp),%eax
     402:	0f b6 00             	movzbl (%eax),%eax
     405:	3c 20                	cmp    $0x20,%al
     407:	74 f2                	je     3fb <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
     409:	8b 45 08             	mov    0x8(%ebp),%eax
     40c:	0f b6 00             	movzbl (%eax),%eax
     40f:	3c 2d                	cmp    $0x2d,%al
     411:	75 07                	jne    41a <atoi+0x32>
     413:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     418:	eb 05                	jmp    41f <atoi+0x37>
     41a:	b8 01 00 00 00       	mov    $0x1,%eax
     41f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     422:	8b 45 08             	mov    0x8(%ebp),%eax
     425:	0f b6 00             	movzbl (%eax),%eax
     428:	3c 2b                	cmp    $0x2b,%al
     42a:	74 0a                	je     436 <atoi+0x4e>
     42c:	8b 45 08             	mov    0x8(%ebp),%eax
     42f:	0f b6 00             	movzbl (%eax),%eax
     432:	3c 2d                	cmp    $0x2d,%al
     434:	75 2b                	jne    461 <atoi+0x79>
    s++;
     436:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     43a:	eb 25                	jmp    461 <atoi+0x79>
    n = n*10 + *s++ - '0';
     43c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     43f:	89 d0                	mov    %edx,%eax
     441:	c1 e0 02             	shl    $0x2,%eax
     444:	01 d0                	add    %edx,%eax
     446:	01 c0                	add    %eax,%eax
     448:	89 c1                	mov    %eax,%ecx
     44a:	8b 45 08             	mov    0x8(%ebp),%eax
     44d:	8d 50 01             	lea    0x1(%eax),%edx
     450:	89 55 08             	mov    %edx,0x8(%ebp)
     453:	0f b6 00             	movzbl (%eax),%eax
     456:	0f be c0             	movsbl %al,%eax
     459:	01 c8                	add    %ecx,%eax
     45b:	83 e8 30             	sub    $0x30,%eax
     45e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     461:	8b 45 08             	mov    0x8(%ebp),%eax
     464:	0f b6 00             	movzbl (%eax),%eax
     467:	3c 2f                	cmp    $0x2f,%al
     469:	7e 0a                	jle    475 <atoi+0x8d>
     46b:	8b 45 08             	mov    0x8(%ebp),%eax
     46e:	0f b6 00             	movzbl (%eax),%eax
     471:	3c 39                	cmp    $0x39,%al
     473:	7e c7                	jle    43c <atoi+0x54>
  return sign*n;
     475:	8b 45 f8             	mov    -0x8(%ebp),%eax
     478:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     47c:	c9                   	leave  
     47d:	c3                   	ret    

0000047e <atoo>:

int
atoo(const char *s)
{
     47e:	f3 0f 1e fb          	endbr32 
     482:	55                   	push   %ebp
     483:	89 e5                	mov    %esp,%ebp
     485:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     488:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     48f:	eb 04                	jmp    495 <atoo+0x17>
     491:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     495:	8b 45 08             	mov    0x8(%ebp),%eax
     498:	0f b6 00             	movzbl (%eax),%eax
     49b:	3c 20                	cmp    $0x20,%al
     49d:	74 f2                	je     491 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
     49f:	8b 45 08             	mov    0x8(%ebp),%eax
     4a2:	0f b6 00             	movzbl (%eax),%eax
     4a5:	3c 2d                	cmp    $0x2d,%al
     4a7:	75 07                	jne    4b0 <atoo+0x32>
     4a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     4ae:	eb 05                	jmp    4b5 <atoo+0x37>
     4b0:	b8 01 00 00 00       	mov    $0x1,%eax
     4b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     4b8:	8b 45 08             	mov    0x8(%ebp),%eax
     4bb:	0f b6 00             	movzbl (%eax),%eax
     4be:	3c 2b                	cmp    $0x2b,%al
     4c0:	74 0a                	je     4cc <atoo+0x4e>
     4c2:	8b 45 08             	mov    0x8(%ebp),%eax
     4c5:	0f b6 00             	movzbl (%eax),%eax
     4c8:	3c 2d                	cmp    $0x2d,%al
     4ca:	75 27                	jne    4f3 <atoo+0x75>
    s++;
     4cc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     4d0:	eb 21                	jmp    4f3 <atoo+0x75>
    n = n*8 + *s++ - '0';
     4d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     4d5:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     4dc:	8b 45 08             	mov    0x8(%ebp),%eax
     4df:	8d 50 01             	lea    0x1(%eax),%edx
     4e2:	89 55 08             	mov    %edx,0x8(%ebp)
     4e5:	0f b6 00             	movzbl (%eax),%eax
     4e8:	0f be c0             	movsbl %al,%eax
     4eb:	01 c8                	add    %ecx,%eax
     4ed:	83 e8 30             	sub    $0x30,%eax
     4f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
     4f3:	8b 45 08             	mov    0x8(%ebp),%eax
     4f6:	0f b6 00             	movzbl (%eax),%eax
     4f9:	3c 2f                	cmp    $0x2f,%al
     4fb:	7e 0a                	jle    507 <atoo+0x89>
     4fd:	8b 45 08             	mov    0x8(%ebp),%eax
     500:	0f b6 00             	movzbl (%eax),%eax
     503:	3c 37                	cmp    $0x37,%al
     505:	7e cb                	jle    4d2 <atoo+0x54>
  return sign*n;
     507:	8b 45 f8             	mov    -0x8(%ebp),%eax
     50a:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     50e:	c9                   	leave  
     50f:	c3                   	ret    

00000510 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     510:	f3 0f 1e fb          	endbr32 
     514:	55                   	push   %ebp
     515:	89 e5                	mov    %esp,%ebp
     517:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     51a:	8b 45 08             	mov    0x8(%ebp),%eax
     51d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     520:	8b 45 0c             	mov    0xc(%ebp),%eax
     523:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     526:	eb 17                	jmp    53f <memmove+0x2f>
    *dst++ = *src++;
     528:	8b 55 f8             	mov    -0x8(%ebp),%edx
     52b:	8d 42 01             	lea    0x1(%edx),%eax
     52e:	89 45 f8             	mov    %eax,-0x8(%ebp)
     531:	8b 45 fc             	mov    -0x4(%ebp),%eax
     534:	8d 48 01             	lea    0x1(%eax),%ecx
     537:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     53a:	0f b6 12             	movzbl (%edx),%edx
     53d:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     53f:	8b 45 10             	mov    0x10(%ebp),%eax
     542:	8d 50 ff             	lea    -0x1(%eax),%edx
     545:	89 55 10             	mov    %edx,0x10(%ebp)
     548:	85 c0                	test   %eax,%eax
     54a:	7f dc                	jg     528 <memmove+0x18>
  return vdst;
     54c:	8b 45 08             	mov    0x8(%ebp),%eax
}
     54f:	c9                   	leave  
     550:	c3                   	ret    

00000551 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     551:	b8 01 00 00 00       	mov    $0x1,%eax
     556:	cd 40                	int    $0x40
     558:	c3                   	ret    

00000559 <exit>:
SYSCALL(exit)
     559:	b8 02 00 00 00       	mov    $0x2,%eax
     55e:	cd 40                	int    $0x40
     560:	c3                   	ret    

00000561 <wait>:
SYSCALL(wait)
     561:	b8 03 00 00 00       	mov    $0x3,%eax
     566:	cd 40                	int    $0x40
     568:	c3                   	ret    

00000569 <pipe>:
SYSCALL(pipe)
     569:	b8 04 00 00 00       	mov    $0x4,%eax
     56e:	cd 40                	int    $0x40
     570:	c3                   	ret    

00000571 <read>:
SYSCALL(read)
     571:	b8 05 00 00 00       	mov    $0x5,%eax
     576:	cd 40                	int    $0x40
     578:	c3                   	ret    

00000579 <write>:
SYSCALL(write)
     579:	b8 10 00 00 00       	mov    $0x10,%eax
     57e:	cd 40                	int    $0x40
     580:	c3                   	ret    

00000581 <close>:
SYSCALL(close)
     581:	b8 15 00 00 00       	mov    $0x15,%eax
     586:	cd 40                	int    $0x40
     588:	c3                   	ret    

00000589 <kill>:
SYSCALL(kill)
     589:	b8 06 00 00 00       	mov    $0x6,%eax
     58e:	cd 40                	int    $0x40
     590:	c3                   	ret    

00000591 <exec>:
SYSCALL(exec)
     591:	b8 07 00 00 00       	mov    $0x7,%eax
     596:	cd 40                	int    $0x40
     598:	c3                   	ret    

00000599 <open>:
SYSCALL(open)
     599:	b8 0f 00 00 00       	mov    $0xf,%eax
     59e:	cd 40                	int    $0x40
     5a0:	c3                   	ret    

000005a1 <mknod>:
SYSCALL(mknod)
     5a1:	b8 11 00 00 00       	mov    $0x11,%eax
     5a6:	cd 40                	int    $0x40
     5a8:	c3                   	ret    

000005a9 <unlink>:
SYSCALL(unlink)
     5a9:	b8 12 00 00 00       	mov    $0x12,%eax
     5ae:	cd 40                	int    $0x40
     5b0:	c3                   	ret    

000005b1 <fstat>:
SYSCALL(fstat)
     5b1:	b8 08 00 00 00       	mov    $0x8,%eax
     5b6:	cd 40                	int    $0x40
     5b8:	c3                   	ret    

000005b9 <link>:
SYSCALL(link)
     5b9:	b8 13 00 00 00       	mov    $0x13,%eax
     5be:	cd 40                	int    $0x40
     5c0:	c3                   	ret    

000005c1 <mkdir>:
SYSCALL(mkdir)
     5c1:	b8 14 00 00 00       	mov    $0x14,%eax
     5c6:	cd 40                	int    $0x40
     5c8:	c3                   	ret    

000005c9 <chdir>:
SYSCALL(chdir)
     5c9:	b8 09 00 00 00       	mov    $0x9,%eax
     5ce:	cd 40                	int    $0x40
     5d0:	c3                   	ret    

000005d1 <dup>:
SYSCALL(dup)
     5d1:	b8 0a 00 00 00       	mov    $0xa,%eax
     5d6:	cd 40                	int    $0x40
     5d8:	c3                   	ret    

000005d9 <getpid>:
SYSCALL(getpid)
     5d9:	b8 0b 00 00 00       	mov    $0xb,%eax
     5de:	cd 40                	int    $0x40
     5e0:	c3                   	ret    

000005e1 <sbrk>:
SYSCALL(sbrk)
     5e1:	b8 0c 00 00 00       	mov    $0xc,%eax
     5e6:	cd 40                	int    $0x40
     5e8:	c3                   	ret    

000005e9 <sleep>:
SYSCALL(sleep)
     5e9:	b8 0d 00 00 00       	mov    $0xd,%eax
     5ee:	cd 40                	int    $0x40
     5f0:	c3                   	ret    

000005f1 <uptime>:
SYSCALL(uptime)
     5f1:	b8 0e 00 00 00       	mov    $0xe,%eax
     5f6:	cd 40                	int    $0x40
     5f8:	c3                   	ret    

000005f9 <halt>:
SYSCALL(halt)
     5f9:	b8 16 00 00 00       	mov    $0x16,%eax
     5fe:	cd 40                	int    $0x40
     600:	c3                   	ret    

00000601 <date>:
SYSCALL(date)
     601:	b8 17 00 00 00       	mov    $0x17,%eax
     606:	cd 40                	int    $0x40
     608:	c3                   	ret    

00000609 <getuid>:
SYSCALL(getuid)
     609:	b8 18 00 00 00       	mov    $0x18,%eax
     60e:	cd 40                	int    $0x40
     610:	c3                   	ret    

00000611 <getgid>:
SYSCALL(getgid)
     611:	b8 19 00 00 00       	mov    $0x19,%eax
     616:	cd 40                	int    $0x40
     618:	c3                   	ret    

00000619 <getppid>:
SYSCALL(getppid)
     619:	b8 1a 00 00 00       	mov    $0x1a,%eax
     61e:	cd 40                	int    $0x40
     620:	c3                   	ret    

00000621 <setuid>:
SYSCALL(setuid)
     621:	b8 1b 00 00 00       	mov    $0x1b,%eax
     626:	cd 40                	int    $0x40
     628:	c3                   	ret    

00000629 <setgid>:
SYSCALL(setgid)
     629:	b8 1c 00 00 00       	mov    $0x1c,%eax
     62e:	cd 40                	int    $0x40
     630:	c3                   	ret    

00000631 <getprocs>:
SYSCALL(getprocs)
     631:	b8 1d 00 00 00       	mov    $0x1d,%eax
     636:	cd 40                	int    $0x40
     638:	c3                   	ret    

00000639 <setpriority>:
SYSCALL(setpriority)
     639:	b8 1e 00 00 00       	mov    $0x1e,%eax
     63e:	cd 40                	int    $0x40
     640:	c3                   	ret    

00000641 <chown>:
SYSCALL(chown)
     641:	b8 1f 00 00 00       	mov    $0x1f,%eax
     646:	cd 40                	int    $0x40
     648:	c3                   	ret    

00000649 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     649:	f3 0f 1e fb          	endbr32 
     64d:	55                   	push   %ebp
     64e:	89 e5                	mov    %esp,%ebp
     650:	83 ec 18             	sub    $0x18,%esp
     653:	8b 45 0c             	mov    0xc(%ebp),%eax
     656:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     659:	83 ec 04             	sub    $0x4,%esp
     65c:	6a 01                	push   $0x1
     65e:	8d 45 f4             	lea    -0xc(%ebp),%eax
     661:	50                   	push   %eax
     662:	ff 75 08             	pushl  0x8(%ebp)
     665:	e8 0f ff ff ff       	call   579 <write>
     66a:	83 c4 10             	add    $0x10,%esp
}
     66d:	90                   	nop
     66e:	c9                   	leave  
     66f:	c3                   	ret    

00000670 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     670:	f3 0f 1e fb          	endbr32 
     674:	55                   	push   %ebp
     675:	89 e5                	mov    %esp,%ebp
     677:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     67a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     681:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     685:	74 17                	je     69e <printint+0x2e>
     687:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     68b:	79 11                	jns    69e <printint+0x2e>
    neg = 1;
     68d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     694:	8b 45 0c             	mov    0xc(%ebp),%eax
     697:	f7 d8                	neg    %eax
     699:	89 45 ec             	mov    %eax,-0x14(%ebp)
     69c:	eb 06                	jmp    6a4 <printint+0x34>
  } else {
    x = xx;
     69e:	8b 45 0c             	mov    0xc(%ebp),%eax
     6a1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6b1:	ba 00 00 00 00       	mov    $0x0,%edx
     6b6:	f7 f1                	div    %ecx
     6b8:	89 d1                	mov    %edx,%ecx
     6ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6bd:	8d 50 01             	lea    0x1(%eax),%edx
     6c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6c3:	0f b6 91 a8 14 00 00 	movzbl 0x14a8(%ecx),%edx
     6ca:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     6ce:	8b 4d 10             	mov    0x10(%ebp),%ecx
     6d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
     6d4:	ba 00 00 00 00       	mov    $0x0,%edx
     6d9:	f7 f1                	div    %ecx
     6db:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6de:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     6e2:	75 c7                	jne    6ab <printint+0x3b>
  if(neg)
     6e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6e8:	74 2d                	je     717 <printint+0xa7>
    buf[i++] = '-';
     6ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ed:	8d 50 01             	lea    0x1(%eax),%edx
     6f0:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6f3:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     6f8:	eb 1d                	jmp    717 <printint+0xa7>
    putc(fd, buf[i]);
     6fa:	8d 55 dc             	lea    -0x24(%ebp),%edx
     6fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     700:	01 d0                	add    %edx,%eax
     702:	0f b6 00             	movzbl (%eax),%eax
     705:	0f be c0             	movsbl %al,%eax
     708:	83 ec 08             	sub    $0x8,%esp
     70b:	50                   	push   %eax
     70c:	ff 75 08             	pushl  0x8(%ebp)
     70f:	e8 35 ff ff ff       	call   649 <putc>
     714:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     717:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     71b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     71f:	79 d9                	jns    6fa <printint+0x8a>
}
     721:	90                   	nop
     722:	90                   	nop
     723:	c9                   	leave  
     724:	c3                   	ret    

00000725 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     725:	f3 0f 1e fb          	endbr32 
     729:	55                   	push   %ebp
     72a:	89 e5                	mov    %esp,%ebp
     72c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     72f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     736:	8d 45 0c             	lea    0xc(%ebp),%eax
     739:	83 c0 04             	add    $0x4,%eax
     73c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     73f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     746:	e9 59 01 00 00       	jmp    8a4 <printf+0x17f>
    c = fmt[i] & 0xff;
     74b:	8b 55 0c             	mov    0xc(%ebp),%edx
     74e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     751:	01 d0                	add    %edx,%eax
     753:	0f b6 00             	movzbl (%eax),%eax
     756:	0f be c0             	movsbl %al,%eax
     759:	25 ff 00 00 00       	and    $0xff,%eax
     75e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     761:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     765:	75 2c                	jne    793 <printf+0x6e>
      if(c == '%'){
     767:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     76b:	75 0c                	jne    779 <printf+0x54>
        state = '%';
     76d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     774:	e9 27 01 00 00       	jmp    8a0 <printf+0x17b>
      } else {
        putc(fd, c);
     779:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     77c:	0f be c0             	movsbl %al,%eax
     77f:	83 ec 08             	sub    $0x8,%esp
     782:	50                   	push   %eax
     783:	ff 75 08             	pushl  0x8(%ebp)
     786:	e8 be fe ff ff       	call   649 <putc>
     78b:	83 c4 10             	add    $0x10,%esp
     78e:	e9 0d 01 00 00       	jmp    8a0 <printf+0x17b>
      }
    } else if(state == '%'){
     793:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     797:	0f 85 03 01 00 00    	jne    8a0 <printf+0x17b>
      if(c == 'd'){
     79d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7a1:	75 1e                	jne    7c1 <printf+0x9c>
        printint(fd, *ap, 10, 1);
     7a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7a6:	8b 00                	mov    (%eax),%eax
     7a8:	6a 01                	push   $0x1
     7aa:	6a 0a                	push   $0xa
     7ac:	50                   	push   %eax
     7ad:	ff 75 08             	pushl  0x8(%ebp)
     7b0:	e8 bb fe ff ff       	call   670 <printint>
     7b5:	83 c4 10             	add    $0x10,%esp
        ap++;
     7b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7bc:	e9 d8 00 00 00       	jmp    899 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
     7c1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     7c5:	74 06                	je     7cd <printf+0xa8>
     7c7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     7cb:	75 1e                	jne    7eb <printf+0xc6>
        printint(fd, *ap, 16, 0);
     7cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7d0:	8b 00                	mov    (%eax),%eax
     7d2:	6a 00                	push   $0x0
     7d4:	6a 10                	push   $0x10
     7d6:	50                   	push   %eax
     7d7:	ff 75 08             	pushl  0x8(%ebp)
     7da:	e8 91 fe ff ff       	call   670 <printint>
     7df:	83 c4 10             	add    $0x10,%esp
        ap++;
     7e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     7e6:	e9 ae 00 00 00       	jmp    899 <printf+0x174>
      } else if(c == 's'){
     7eb:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     7ef:	75 43                	jne    834 <printf+0x10f>
        s = (char*)*ap;
     7f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7f4:	8b 00                	mov    (%eax),%eax
     7f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     7f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     7fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     801:	75 25                	jne    828 <printf+0x103>
          s = "(null)";
     803:	c7 45 f4 76 10 00 00 	movl   $0x1076,-0xc(%ebp)
        while(*s != 0){
     80a:	eb 1c                	jmp    828 <printf+0x103>
          putc(fd, *s);
     80c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80f:	0f b6 00             	movzbl (%eax),%eax
     812:	0f be c0             	movsbl %al,%eax
     815:	83 ec 08             	sub    $0x8,%esp
     818:	50                   	push   %eax
     819:	ff 75 08             	pushl  0x8(%ebp)
     81c:	e8 28 fe ff ff       	call   649 <putc>
     821:	83 c4 10             	add    $0x10,%esp
          s++;
     824:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     828:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82b:	0f b6 00             	movzbl (%eax),%eax
     82e:	84 c0                	test   %al,%al
     830:	75 da                	jne    80c <printf+0xe7>
     832:	eb 65                	jmp    899 <printf+0x174>
        }
      } else if(c == 'c'){
     834:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     838:	75 1d                	jne    857 <printf+0x132>
        putc(fd, *ap);
     83a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     83d:	8b 00                	mov    (%eax),%eax
     83f:	0f be c0             	movsbl %al,%eax
     842:	83 ec 08             	sub    $0x8,%esp
     845:	50                   	push   %eax
     846:	ff 75 08             	pushl  0x8(%ebp)
     849:	e8 fb fd ff ff       	call   649 <putc>
     84e:	83 c4 10             	add    $0x10,%esp
        ap++;
     851:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     855:	eb 42                	jmp    899 <printf+0x174>
      } else if(c == '%'){
     857:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     85b:	75 17                	jne    874 <printf+0x14f>
        putc(fd, c);
     85d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     860:	0f be c0             	movsbl %al,%eax
     863:	83 ec 08             	sub    $0x8,%esp
     866:	50                   	push   %eax
     867:	ff 75 08             	pushl  0x8(%ebp)
     86a:	e8 da fd ff ff       	call   649 <putc>
     86f:	83 c4 10             	add    $0x10,%esp
     872:	eb 25                	jmp    899 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     874:	83 ec 08             	sub    $0x8,%esp
     877:	6a 25                	push   $0x25
     879:	ff 75 08             	pushl  0x8(%ebp)
     87c:	e8 c8 fd ff ff       	call   649 <putc>
     881:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     884:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     887:	0f be c0             	movsbl %al,%eax
     88a:	83 ec 08             	sub    $0x8,%esp
     88d:	50                   	push   %eax
     88e:	ff 75 08             	pushl  0x8(%ebp)
     891:	e8 b3 fd ff ff       	call   649 <putc>
     896:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     899:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     8a0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8a4:	8b 55 0c             	mov    0xc(%ebp),%edx
     8a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8aa:	01 d0                	add    %edx,%eax
     8ac:	0f b6 00             	movzbl (%eax),%eax
     8af:	84 c0                	test   %al,%al
     8b1:	0f 85 94 fe ff ff    	jne    74b <printf+0x26>
    }
  }
}
     8b7:	90                   	nop
     8b8:	90                   	nop
     8b9:	c9                   	leave  
     8ba:	c3                   	ret    

000008bb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     8bb:	f3 0f 1e fb          	endbr32 
     8bf:	55                   	push   %ebp
     8c0:	89 e5                	mov    %esp,%ebp
     8c2:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     8c5:	8b 45 08             	mov    0x8(%ebp),%eax
     8c8:	83 e8 08             	sub    $0x8,%eax
     8cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8ce:	a1 c8 14 00 00       	mov    0x14c8,%eax
     8d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8d6:	eb 24                	jmp    8fc <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     8d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8db:	8b 00                	mov    (%eax),%eax
     8dd:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     8e0:	72 12                	jb     8f4 <free+0x39>
     8e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8e5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     8e8:	77 24                	ja     90e <free+0x53>
     8ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8ed:	8b 00                	mov    (%eax),%eax
     8ef:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     8f2:	72 1a                	jb     90e <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     8f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     8f7:	8b 00                	mov    (%eax),%eax
     8f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
     8fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     8ff:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     902:	76 d4                	jbe    8d8 <free+0x1d>
     904:	8b 45 fc             	mov    -0x4(%ebp),%eax
     907:	8b 00                	mov    (%eax),%eax
     909:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     90c:	73 ca                	jae    8d8 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
     90e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     911:	8b 40 04             	mov    0x4(%eax),%eax
     914:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     91b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     91e:	01 c2                	add    %eax,%edx
     920:	8b 45 fc             	mov    -0x4(%ebp),%eax
     923:	8b 00                	mov    (%eax),%eax
     925:	39 c2                	cmp    %eax,%edx
     927:	75 24                	jne    94d <free+0x92>
    bp->s.size += p->s.ptr->s.size;
     929:	8b 45 f8             	mov    -0x8(%ebp),%eax
     92c:	8b 50 04             	mov    0x4(%eax),%edx
     92f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     932:	8b 00                	mov    (%eax),%eax
     934:	8b 40 04             	mov    0x4(%eax),%eax
     937:	01 c2                	add    %eax,%edx
     939:	8b 45 f8             	mov    -0x8(%ebp),%eax
     93c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     93f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     942:	8b 00                	mov    (%eax),%eax
     944:	8b 10                	mov    (%eax),%edx
     946:	8b 45 f8             	mov    -0x8(%ebp),%eax
     949:	89 10                	mov    %edx,(%eax)
     94b:	eb 0a                	jmp    957 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
     94d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     950:	8b 10                	mov    (%eax),%edx
     952:	8b 45 f8             	mov    -0x8(%ebp),%eax
     955:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     957:	8b 45 fc             	mov    -0x4(%ebp),%eax
     95a:	8b 40 04             	mov    0x4(%eax),%eax
     95d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     964:	8b 45 fc             	mov    -0x4(%ebp),%eax
     967:	01 d0                	add    %edx,%eax
     969:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     96c:	75 20                	jne    98e <free+0xd3>
    p->s.size += bp->s.size;
     96e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     971:	8b 50 04             	mov    0x4(%eax),%edx
     974:	8b 45 f8             	mov    -0x8(%ebp),%eax
     977:	8b 40 04             	mov    0x4(%eax),%eax
     97a:	01 c2                	add    %eax,%edx
     97c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     97f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     982:	8b 45 f8             	mov    -0x8(%ebp),%eax
     985:	8b 10                	mov    (%eax),%edx
     987:	8b 45 fc             	mov    -0x4(%ebp),%eax
     98a:	89 10                	mov    %edx,(%eax)
     98c:	eb 08                	jmp    996 <free+0xdb>
  } else
    p->s.ptr = bp;
     98e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     991:	8b 55 f8             	mov    -0x8(%ebp),%edx
     994:	89 10                	mov    %edx,(%eax)
  freep = p;
     996:	8b 45 fc             	mov    -0x4(%ebp),%eax
     999:	a3 c8 14 00 00       	mov    %eax,0x14c8
}
     99e:	90                   	nop
     99f:	c9                   	leave  
     9a0:	c3                   	ret    

000009a1 <morecore>:

static Header*
morecore(uint nu)
{
     9a1:	f3 0f 1e fb          	endbr32 
     9a5:	55                   	push   %ebp
     9a6:	89 e5                	mov    %esp,%ebp
     9a8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9ab:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     9b2:	77 07                	ja     9bb <morecore+0x1a>
    nu = 4096;
     9b4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     9bb:	8b 45 08             	mov    0x8(%ebp),%eax
     9be:	c1 e0 03             	shl    $0x3,%eax
     9c1:	83 ec 0c             	sub    $0xc,%esp
     9c4:	50                   	push   %eax
     9c5:	e8 17 fc ff ff       	call   5e1 <sbrk>
     9ca:	83 c4 10             	add    $0x10,%esp
     9cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     9d0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     9d4:	75 07                	jne    9dd <morecore+0x3c>
    return 0;
     9d6:	b8 00 00 00 00       	mov    $0x0,%eax
     9db:	eb 26                	jmp    a03 <morecore+0x62>
  hp = (Header*)p;
     9dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     9e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9e6:	8b 55 08             	mov    0x8(%ebp),%edx
     9e9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     9ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
     9ef:	83 c0 08             	add    $0x8,%eax
     9f2:	83 ec 0c             	sub    $0xc,%esp
     9f5:	50                   	push   %eax
     9f6:	e8 c0 fe ff ff       	call   8bb <free>
     9fb:	83 c4 10             	add    $0x10,%esp
  return freep;
     9fe:	a1 c8 14 00 00       	mov    0x14c8,%eax
}
     a03:	c9                   	leave  
     a04:	c3                   	ret    

00000a05 <malloc>:

void*
malloc(uint nbytes)
{
     a05:	f3 0f 1e fb          	endbr32 
     a09:	55                   	push   %ebp
     a0a:	89 e5                	mov    %esp,%ebp
     a0c:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a0f:	8b 45 08             	mov    0x8(%ebp),%eax
     a12:	83 c0 07             	add    $0x7,%eax
     a15:	c1 e8 03             	shr    $0x3,%eax
     a18:	83 c0 01             	add    $0x1,%eax
     a1b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a1e:	a1 c8 14 00 00       	mov    0x14c8,%eax
     a23:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a26:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a2a:	75 23                	jne    a4f <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
     a2c:	c7 45 f0 c0 14 00 00 	movl   $0x14c0,-0x10(%ebp)
     a33:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a36:	a3 c8 14 00 00       	mov    %eax,0x14c8
     a3b:	a1 c8 14 00 00       	mov    0x14c8,%eax
     a40:	a3 c0 14 00 00       	mov    %eax,0x14c0
    base.s.size = 0;
     a45:	c7 05 c4 14 00 00 00 	movl   $0x0,0x14c4
     a4c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     a4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a52:	8b 00                	mov    (%eax),%eax
     a54:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a5a:	8b 40 04             	mov    0x4(%eax),%eax
     a5d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a60:	77 4d                	ja     aaf <malloc+0xaa>
      if(p->s.size == nunits)
     a62:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a65:	8b 40 04             	mov    0x4(%eax),%eax
     a68:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     a6b:	75 0c                	jne    a79 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
     a6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a70:	8b 10                	mov    (%eax),%edx
     a72:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a75:	89 10                	mov    %edx,(%eax)
     a77:	eb 26                	jmp    a9f <malloc+0x9a>
      else {
        p->s.size -= nunits;
     a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a7c:	8b 40 04             	mov    0x4(%eax),%eax
     a7f:	2b 45 ec             	sub    -0x14(%ebp),%eax
     a82:	89 c2                	mov    %eax,%edx
     a84:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a87:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a8d:	8b 40 04             	mov    0x4(%eax),%eax
     a90:	c1 e0 03             	shl    $0x3,%eax
     a93:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     a96:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a99:	8b 55 ec             	mov    -0x14(%ebp),%edx
     a9c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     a9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aa2:	a3 c8 14 00 00       	mov    %eax,0x14c8
      return (void*)(p + 1);
     aa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aaa:	83 c0 08             	add    $0x8,%eax
     aad:	eb 3b                	jmp    aea <malloc+0xe5>
    }
    if(p == freep)
     aaf:	a1 c8 14 00 00       	mov    0x14c8,%eax
     ab4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     ab7:	75 1e                	jne    ad7 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
     ab9:	83 ec 0c             	sub    $0xc,%esp
     abc:	ff 75 ec             	pushl  -0x14(%ebp)
     abf:	e8 dd fe ff ff       	call   9a1 <morecore>
     ac4:	83 c4 10             	add    $0x10,%esp
     ac7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     aca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ace:	75 07                	jne    ad7 <malloc+0xd2>
        return 0;
     ad0:	b8 00 00 00 00       	mov    $0x0,%eax
     ad5:	eb 13                	jmp    aea <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ada:	89 45 f0             	mov    %eax,-0x10(%ebp)
     add:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae0:	8b 00                	mov    (%eax),%eax
     ae2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     ae5:	e9 6d ff ff ff       	jmp    a57 <malloc+0x52>
  }
}
     aea:	c9                   	leave  
     aeb:	c3                   	ret    

00000aec <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
     aec:	f3 0f 1e fb          	endbr32 
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     af6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     afd:	a1 20 15 00 00       	mov    0x1520,%eax
     b02:	83 ec 04             	sub    $0x4,%esp
     b05:	50                   	push   %eax
     b06:	6a 20                	push   $0x20
     b08:	68 00 15 00 00       	push   $0x1500
     b0d:	e8 11 f8 ff ff       	call   323 <fgets>
     b12:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     b15:	83 ec 0c             	sub    $0xc,%esp
     b18:	68 00 15 00 00       	push   $0x1500
     b1d:	e8 0e f7 ff ff       	call   230 <strlen>
     b22:	83 c4 10             	add    $0x10,%esp
     b25:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     b28:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b2b:	83 e8 01             	sub    $0x1,%eax
     b2e:	0f b6 80 00 15 00 00 	movzbl 0x1500(%eax),%eax
     b35:	3c 0a                	cmp    $0xa,%al
     b37:	74 11                	je     b4a <get_id+0x5e>
     b39:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b3c:	83 e8 01             	sub    $0x1,%eax
     b3f:	0f b6 80 00 15 00 00 	movzbl 0x1500(%eax),%eax
     b46:	3c 0d                	cmp    $0xd,%al
     b48:	75 0d                	jne    b57 <get_id+0x6b>
        current_line[len - 1] = 0;
     b4a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b4d:	83 e8 01             	sub    $0x1,%eax
     b50:	c6 80 00 15 00 00 00 	movb   $0x0,0x1500(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     b57:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     b5e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     b65:	eb 6c                	jmp    bd3 <get_id+0xe7>
        if(current_line[i] == ' '){
     b67:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b6a:	05 00 15 00 00       	add    $0x1500,%eax
     b6f:	0f b6 00             	movzbl (%eax),%eax
     b72:	3c 20                	cmp    $0x20,%al
     b74:	75 30                	jne    ba6 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     b76:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b7a:	75 16                	jne    b92 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     b7c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b82:	8d 50 01             	lea    0x1(%eax),%edx
     b85:	89 55 f0             	mov    %edx,-0x10(%ebp)
     b88:	8d 91 00 15 00 00    	lea    0x1500(%ecx),%edx
     b8e:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     b92:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b95:	05 00 15 00 00       	add    $0x1500,%eax
     b9a:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     b9d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ba4:	eb 29                	jmp    bcf <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     ba6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     baa:	75 23                	jne    bcf <get_id+0xe3>
     bac:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     bb0:	7f 1d                	jg     bcf <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     bb2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     bb9:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     bbc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bbf:	8d 50 01             	lea    0x1(%eax),%edx
     bc2:	89 55 f0             	mov    %edx,-0x10(%ebp)
     bc5:	8d 91 00 15 00 00    	lea    0x1500(%ecx),%edx
     bcb:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     bcf:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     bd3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bd6:	05 00 15 00 00       	add    $0x1500,%eax
     bdb:	0f b6 00             	movzbl (%eax),%eax
     bde:	84 c0                	test   %al,%al
     be0:	75 85                	jne    b67 <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     be2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     be6:	75 07                	jne    bef <get_id+0x103>
        return -1;
     be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     bed:	eb 35                	jmp    c24 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
     bef:	8b 45 dc             	mov    -0x24(%ebp),%eax
     bf2:	a3 e0 14 00 00       	mov    %eax,0x14e0
    current_id.uid_user = atoi(tokens[1]);
     bf7:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bfa:	83 ec 0c             	sub    $0xc,%esp
     bfd:	50                   	push   %eax
     bfe:	e8 e5 f7 ff ff       	call   3e8 <atoi>
     c03:	83 c4 10             	add    $0x10,%esp
     c06:	a3 e4 14 00 00       	mov    %eax,0x14e4
    current_id.gid_user = atoi(tokens[2]);
     c0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c0e:	83 ec 0c             	sub    $0xc,%esp
     c11:	50                   	push   %eax
     c12:	e8 d1 f7 ff ff       	call   3e8 <atoi>
     c17:	83 c4 10             	add    $0x10,%esp
     c1a:	a3 e8 14 00 00       	mov    %eax,0x14e8

    return 0;
     c1f:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c24:	c9                   	leave  
     c25:	c3                   	ret    

00000c26 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
     c26:	f3 0f 1e fb          	endbr32 
     c2a:	55                   	push   %ebp
     c2b:	89 e5                	mov    %esp,%ebp
     c2d:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     c30:	a1 20 15 00 00       	mov    0x1520,%eax
     c35:	85 c0                	test   %eax,%eax
     c37:	75 31                	jne    c6a <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
     c39:	83 ec 08             	sub    $0x8,%esp
     c3c:	6a 00                	push   $0x0
     c3e:	68 7d 10 00 00       	push   $0x107d
     c43:	e8 51 f9 ff ff       	call   599 <open>
     c48:	83 c4 10             	add    $0x10,%esp
     c4b:	a3 20 15 00 00       	mov    %eax,0x1520

        if(dir < 0){        // kalau gagal membuka file
     c50:	a1 20 15 00 00       	mov    0x1520,%eax
     c55:	85 c0                	test   %eax,%eax
     c57:	79 11                	jns    c6a <getid+0x44>
            dir = 0;
     c59:	c7 05 20 15 00 00 00 	movl   $0x0,0x1520
     c60:	00 00 00 
            return 0;
     c63:	b8 00 00 00 00       	mov    $0x0,%eax
     c68:	eb 16                	jmp    c80 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
     c6a:	e8 7d fe ff ff       	call   aec <get_id>
     c6f:	83 f8 ff             	cmp    $0xffffffff,%eax
     c72:	75 07                	jne    c7b <getid+0x55>
        return 0;
     c74:	b8 00 00 00 00       	mov    $0x0,%eax
     c79:	eb 05                	jmp    c80 <getid+0x5a>
    
    return &current_id;
     c7b:	b8 e0 14 00 00       	mov    $0x14e0,%eax
}
     c80:	c9                   	leave  
     c81:	c3                   	ret    

00000c82 <setid>:

// open file_ids
void setid(void){
     c82:	f3 0f 1e fb          	endbr32 
     c86:	55                   	push   %ebp
     c87:	89 e5                	mov    %esp,%ebp
     c89:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     c8c:	a1 20 15 00 00       	mov    0x1520,%eax
     c91:	85 c0                	test   %eax,%eax
     c93:	74 1b                	je     cb0 <setid+0x2e>
        close(dir);
     c95:	a1 20 15 00 00       	mov    0x1520,%eax
     c9a:	83 ec 0c             	sub    $0xc,%esp
     c9d:	50                   	push   %eax
     c9e:	e8 de f8 ff ff       	call   581 <close>
     ca3:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     ca6:	c7 05 20 15 00 00 00 	movl   $0x0,0x1520
     cad:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
     cb0:	83 ec 08             	sub    $0x8,%esp
     cb3:	6a 00                	push   $0x0
     cb5:	68 7d 10 00 00       	push   $0x107d
     cba:	e8 da f8 ff ff       	call   599 <open>
     cbf:	83 c4 10             	add    $0x10,%esp
     cc2:	a3 20 15 00 00       	mov    %eax,0x1520

    if (dir < 0)
     cc7:	a1 20 15 00 00       	mov    0x1520,%eax
     ccc:	85 c0                	test   %eax,%eax
     cce:	79 0a                	jns    cda <setid+0x58>
        dir = 0;
     cd0:	c7 05 20 15 00 00 00 	movl   $0x0,0x1520
     cd7:	00 00 00 
}
     cda:	90                   	nop
     cdb:	c9                   	leave  
     cdc:	c3                   	ret    

00000cdd <endid>:

// tutup file_ids
void endid (void){
     cdd:	f3 0f 1e fb          	endbr32 
     ce1:	55                   	push   %ebp
     ce2:	89 e5                	mov    %esp,%ebp
     ce4:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     ce7:	a1 20 15 00 00       	mov    0x1520,%eax
     cec:	85 c0                	test   %eax,%eax
     cee:	74 1b                	je     d0b <endid+0x2e>
        close(dir);
     cf0:	a1 20 15 00 00       	mov    0x1520,%eax
     cf5:	83 ec 0c             	sub    $0xc,%esp
     cf8:	50                   	push   %eax
     cf9:	e8 83 f8 ff ff       	call   581 <close>
     cfe:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     d01:	c7 05 20 15 00 00 00 	movl   $0x0,0x1520
     d08:	00 00 00 
    }
}
     d0b:	90                   	nop
     d0c:	c9                   	leave  
     d0d:	c3                   	ret    

00000d0e <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
     d0e:	f3 0f 1e fb          	endbr32 
     d12:	55                   	push   %ebp
     d13:	89 e5                	mov    %esp,%ebp
     d15:	83 ec 08             	sub    $0x8,%esp
    setid();
     d18:	e8 65 ff ff ff       	call   c82 <setid>

    while (getid()){
     d1d:	eb 24                	jmp    d43 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
     d1f:	a1 e0 14 00 00       	mov    0x14e0,%eax
     d24:	83 ec 08             	sub    $0x8,%esp
     d27:	50                   	push   %eax
     d28:	ff 75 08             	pushl  0x8(%ebp)
     d2b:	e8 bd f4 ff ff       	call   1ed <strcmp>
     d30:	83 c4 10             	add    $0x10,%esp
     d33:	85 c0                	test   %eax,%eax
     d35:	75 0c                	jne    d43 <cek_nama+0x35>
            endid();
     d37:	e8 a1 ff ff ff       	call   cdd <endid>
            return &current_id;
     d3c:	b8 e0 14 00 00       	mov    $0x14e0,%eax
     d41:	eb 13                	jmp    d56 <cek_nama+0x48>
    while (getid()){
     d43:	e8 de fe ff ff       	call   c26 <getid>
     d48:	85 c0                	test   %eax,%eax
     d4a:	75 d3                	jne    d1f <cek_nama+0x11>
        }
    }
    endid();
     d4c:	e8 8c ff ff ff       	call   cdd <endid>
    return 0;
     d51:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d56:	c9                   	leave  
     d57:	c3                   	ret    

00000d58 <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
     d58:	f3 0f 1e fb          	endbr32 
     d5c:	55                   	push   %ebp
     d5d:	89 e5                	mov    %esp,%ebp
     d5f:	83 ec 08             	sub    $0x8,%esp
    setid();
     d62:	e8 1b ff ff ff       	call   c82 <setid>

    while (getid()){
     d67:	eb 16                	jmp    d7f <cek_uid+0x27>
        if(current_id.uid_user == uid){
     d69:	a1 e4 14 00 00       	mov    0x14e4,%eax
     d6e:	39 45 08             	cmp    %eax,0x8(%ebp)
     d71:	75 0c                	jne    d7f <cek_uid+0x27>
            endid();
     d73:	e8 65 ff ff ff       	call   cdd <endid>
            return &current_id;
     d78:	b8 e0 14 00 00       	mov    $0x14e0,%eax
     d7d:	eb 13                	jmp    d92 <cek_uid+0x3a>
    while (getid()){
     d7f:	e8 a2 fe ff ff       	call   c26 <getid>
     d84:	85 c0                	test   %eax,%eax
     d86:	75 e1                	jne    d69 <cek_uid+0x11>
        }
    }
    endid();
     d88:	e8 50 ff ff ff       	call   cdd <endid>
    return 0;
     d8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
     d92:	c9                   	leave  
     d93:	c3                   	ret    

00000d94 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
     d94:	f3 0f 1e fb          	endbr32 
     d98:	55                   	push   %ebp
     d99:	89 e5                	mov    %esp,%ebp
     d9b:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     d9e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     da5:	a1 20 15 00 00       	mov    0x1520,%eax
     daa:	83 ec 04             	sub    $0x4,%esp
     dad:	50                   	push   %eax
     dae:	6a 20                	push   $0x20
     db0:	68 00 15 00 00       	push   $0x1500
     db5:	e8 69 f5 ff ff       	call   323 <fgets>
     dba:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     dbd:	83 ec 0c             	sub    $0xc,%esp
     dc0:	68 00 15 00 00       	push   $0x1500
     dc5:	e8 66 f4 ff ff       	call   230 <strlen>
     dca:	83 c4 10             	add    $0x10,%esp
     dcd:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     dd0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dd3:	83 e8 01             	sub    $0x1,%eax
     dd6:	0f b6 80 00 15 00 00 	movzbl 0x1500(%eax),%eax
     ddd:	3c 0a                	cmp    $0xa,%al
     ddf:	74 11                	je     df2 <get_group+0x5e>
     de1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     de4:	83 e8 01             	sub    $0x1,%eax
     de7:	0f b6 80 00 15 00 00 	movzbl 0x1500(%eax),%eax
     dee:	3c 0d                	cmp    $0xd,%al
     df0:	75 0d                	jne    dff <get_group+0x6b>
        current_line[len - 1] = 0;
     df2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     df5:	83 e8 01             	sub    $0x1,%eax
     df8:	c6 80 00 15 00 00 00 	movb   $0x0,0x1500(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     dff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     e06:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e0d:	eb 6c                	jmp    e7b <get_group+0xe7>
        if(current_line[i] == ' '){
     e0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e12:	05 00 15 00 00       	add    $0x1500,%eax
     e17:	0f b6 00             	movzbl (%eax),%eax
     e1a:	3c 20                	cmp    $0x20,%al
     e1c:	75 30                	jne    e4e <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     e1e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e22:	75 16                	jne    e3a <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     e24:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     e27:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e2a:	8d 50 01             	lea    0x1(%eax),%edx
     e2d:	89 55 f0             	mov    %edx,-0x10(%ebp)
     e30:	8d 91 00 15 00 00    	lea    0x1500(%ecx),%edx
     e36:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     e3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e3d:	05 00 15 00 00       	add    $0x1500,%eax
     e42:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     e45:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e4c:	eb 29                	jmp    e77 <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     e4e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e52:	75 23                	jne    e77 <get_group+0xe3>
     e54:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     e58:	7f 1d                	jg     e77 <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     e5a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     e61:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     e64:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e67:	8d 50 01             	lea    0x1(%eax),%edx
     e6a:	89 55 f0             	mov    %edx,-0x10(%ebp)
     e6d:	8d 91 00 15 00 00    	lea    0x1500(%ecx),%edx
     e73:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     e77:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     e7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e7e:	05 00 15 00 00       	add    $0x1500,%eax
     e83:	0f b6 00             	movzbl (%eax),%eax
     e86:	84 c0                	test   %al,%al
     e88:	75 85                	jne    e0f <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     e8a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     e8e:	75 07                	jne    e97 <get_group+0x103>
        return -1;
     e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     e95:	eb 21                	jmp    eb8 <get_group+0x124>
    
    current_group.nama_group = tokens[0];
     e97:	8b 45 dc             	mov    -0x24(%ebp),%eax
     e9a:	a3 ec 14 00 00       	mov    %eax,0x14ec
    current_group.gid = atoi(tokens[1]);
     e9f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ea2:	83 ec 0c             	sub    $0xc,%esp
     ea5:	50                   	push   %eax
     ea6:	e8 3d f5 ff ff       	call   3e8 <atoi>
     eab:	83 c4 10             	add    $0x10,%esp
     eae:	a3 f0 14 00 00       	mov    %eax,0x14f0

    return 0;
     eb3:	b8 00 00 00 00       	mov    $0x0,%eax
}
     eb8:	c9                   	leave  
     eb9:	c3                   	ret    

00000eba <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
     eba:	f3 0f 1e fb          	endbr32 
     ebe:	55                   	push   %ebp
     ebf:	89 e5                	mov    %esp,%ebp
     ec1:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     ec4:	a1 20 15 00 00       	mov    0x1520,%eax
     ec9:	85 c0                	test   %eax,%eax
     ecb:	75 31                	jne    efe <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
     ecd:	83 ec 08             	sub    $0x8,%esp
     ed0:	6a 00                	push   $0x0
     ed2:	68 85 10 00 00       	push   $0x1085
     ed7:	e8 bd f6 ff ff       	call   599 <open>
     edc:	83 c4 10             	add    $0x10,%esp
     edf:	a3 20 15 00 00       	mov    %eax,0x1520

        if(dir < 0){        // kalau gagal membuka file
     ee4:	a1 20 15 00 00       	mov    0x1520,%eax
     ee9:	85 c0                	test   %eax,%eax
     eeb:	79 11                	jns    efe <getgroup+0x44>
            dir = 0;
     eed:	c7 05 20 15 00 00 00 	movl   $0x0,0x1520
     ef4:	00 00 00 
            return 0;
     ef7:	b8 00 00 00 00       	mov    $0x0,%eax
     efc:	eb 16                	jmp    f14 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
     efe:	e8 91 fe ff ff       	call   d94 <get_group>
     f03:	83 f8 ff             	cmp    $0xffffffff,%eax
     f06:	75 07                	jne    f0f <getgroup+0x55>
        return 0;
     f08:	b8 00 00 00 00       	mov    $0x0,%eax
     f0d:	eb 05                	jmp    f14 <getgroup+0x5a>
    
    return &current_group;
     f0f:	b8 ec 14 00 00       	mov    $0x14ec,%eax
}
     f14:	c9                   	leave  
     f15:	c3                   	ret    

00000f16 <setgroup>:

// open file_ids
void setgroup(void){
     f16:	f3 0f 1e fb          	endbr32 
     f1a:	55                   	push   %ebp
     f1b:	89 e5                	mov    %esp,%ebp
     f1d:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     f20:	a1 20 15 00 00       	mov    0x1520,%eax
     f25:	85 c0                	test   %eax,%eax
     f27:	74 1b                	je     f44 <setgroup+0x2e>
        close(dir);
     f29:	a1 20 15 00 00       	mov    0x1520,%eax
     f2e:	83 ec 0c             	sub    $0xc,%esp
     f31:	50                   	push   %eax
     f32:	e8 4a f6 ff ff       	call   581 <close>
     f37:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     f3a:	c7 05 20 15 00 00 00 	movl   $0x0,0x1520
     f41:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
     f44:	83 ec 08             	sub    $0x8,%esp
     f47:	6a 00                	push   $0x0
     f49:	68 85 10 00 00       	push   $0x1085
     f4e:	e8 46 f6 ff ff       	call   599 <open>
     f53:	83 c4 10             	add    $0x10,%esp
     f56:	a3 20 15 00 00       	mov    %eax,0x1520

    if (dir < 0)
     f5b:	a1 20 15 00 00       	mov    0x1520,%eax
     f60:	85 c0                	test   %eax,%eax
     f62:	79 0a                	jns    f6e <setgroup+0x58>
        dir = 0;
     f64:	c7 05 20 15 00 00 00 	movl   $0x0,0x1520
     f6b:	00 00 00 
}
     f6e:	90                   	nop
     f6f:	c9                   	leave  
     f70:	c3                   	ret    

00000f71 <endgroup>:

// tutup file_ids
void endgroup (void){
     f71:	f3 0f 1e fb          	endbr32 
     f75:	55                   	push   %ebp
     f76:	89 e5                	mov    %esp,%ebp
     f78:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     f7b:	a1 20 15 00 00       	mov    0x1520,%eax
     f80:	85 c0                	test   %eax,%eax
     f82:	74 1b                	je     f9f <endgroup+0x2e>
        close(dir);
     f84:	a1 20 15 00 00       	mov    0x1520,%eax
     f89:	83 ec 0c             	sub    $0xc,%esp
     f8c:	50                   	push   %eax
     f8d:	e8 ef f5 ff ff       	call   581 <close>
     f92:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     f95:	c7 05 20 15 00 00 00 	movl   $0x0,0x1520
     f9c:	00 00 00 
    }
}
     f9f:	90                   	nop
     fa0:	c9                   	leave  
     fa1:	c3                   	ret    

00000fa2 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
     fa2:	f3 0f 1e fb          	endbr32 
     fa6:	55                   	push   %ebp
     fa7:	89 e5                	mov    %esp,%ebp
     fa9:	83 ec 08             	sub    $0x8,%esp
    setgroup();
     fac:	e8 65 ff ff ff       	call   f16 <setgroup>

    while (getgroup()){
     fb1:	eb 3c                	jmp    fef <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
     fb3:	a1 ec 14 00 00       	mov    0x14ec,%eax
     fb8:	83 ec 08             	sub    $0x8,%esp
     fbb:	50                   	push   %eax
     fbc:	ff 75 08             	pushl  0x8(%ebp)
     fbf:	e8 29 f2 ff ff       	call   1ed <strcmp>
     fc4:	83 c4 10             	add    $0x10,%esp
     fc7:	85 c0                	test   %eax,%eax
     fc9:	75 24                	jne    fef <cek_nama_group+0x4d>
            endgroup();
     fcb:	e8 a1 ff ff ff       	call   f71 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
     fd0:	a1 ec 14 00 00       	mov    0x14ec,%eax
     fd5:	83 ec 04             	sub    $0x4,%esp
     fd8:	50                   	push   %eax
     fd9:	68 90 10 00 00       	push   $0x1090
     fde:	6a 01                	push   $0x1
     fe0:	e8 40 f7 ff ff       	call   725 <printf>
     fe5:	83 c4 10             	add    $0x10,%esp
            return &current_group;
     fe8:	b8 ec 14 00 00       	mov    $0x14ec,%eax
     fed:	eb 13                	jmp    1002 <cek_nama_group+0x60>
    while (getgroup()){
     fef:	e8 c6 fe ff ff       	call   eba <getgroup>
     ff4:	85 c0                	test   %eax,%eax
     ff6:	75 bb                	jne    fb3 <cek_nama_group+0x11>
        }
    }
    endgroup();
     ff8:	e8 74 ff ff ff       	call   f71 <endgroup>
    return 0;
     ffd:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1002:	c9                   	leave  
    1003:	c3                   	ret    

00001004 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
    1004:	f3 0f 1e fb          	endbr32 
    1008:	55                   	push   %ebp
    1009:	89 e5                	mov    %esp,%ebp
    100b:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    100e:	e8 03 ff ff ff       	call   f16 <setgroup>

    while (getgroup()){
    1013:	eb 16                	jmp    102b <cek_gid+0x27>
        if(current_group.gid == gid){
    1015:	a1 f0 14 00 00       	mov    0x14f0,%eax
    101a:	39 45 08             	cmp    %eax,0x8(%ebp)
    101d:	75 0c                	jne    102b <cek_gid+0x27>
            endgroup();
    101f:	e8 4d ff ff ff       	call   f71 <endgroup>
            return &current_group;
    1024:	b8 ec 14 00 00       	mov    $0x14ec,%eax
    1029:	eb 13                	jmp    103e <cek_gid+0x3a>
    while (getgroup()){
    102b:	e8 8a fe ff ff       	call   eba <getgroup>
    1030:	85 c0                	test   %eax,%eax
    1032:	75 e1                	jne    1015 <cek_gid+0x11>
        }
    }
    endgroup();
    1034:	e8 38 ff ff ff       	call   f71 <endgroup>
    return 0;
    1039:	b8 00 00 00 00       	mov    $0x0,%eax
}
    103e:	c9                   	leave  
    103f:	c3                   	ret    
