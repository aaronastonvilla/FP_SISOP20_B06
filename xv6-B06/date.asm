
_date:     file format elf32-i386


Disassembly of section .text:

00000000 <dayofweek>:
static char *days[] = {"Sun", "Mon", "Tue", "Wed",
  "Thu", "Fri", "Sat"};

int
dayofweek(int y, int m, int d)
{
       0:	f3 0f 1e fb          	endbr32 
       4:	55                   	push   %ebp
       5:	89 e5                	mov    %esp,%ebp
       7:	53                   	push   %ebx
  return (d+=m<3?y--:y-2,23*m/9+d+4+y/4-y/100+y/400)%7;
       8:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
       c:	7f 0b                	jg     19 <dayofweek+0x19>
       e:	8b 45 08             	mov    0x8(%ebp),%eax
      11:	8d 50 ff             	lea    -0x1(%eax),%edx
      14:	89 55 08             	mov    %edx,0x8(%ebp)
      17:	eb 06                	jmp    1f <dayofweek+0x1f>
      19:	8b 45 08             	mov    0x8(%ebp),%eax
      1c:	83 e8 02             	sub    $0x2,%eax
      1f:	01 45 10             	add    %eax,0x10(%ebp)
      22:	8b 45 0c             	mov    0xc(%ebp),%eax
      25:	6b c8 17             	imul   $0x17,%eax,%ecx
      28:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
      2d:	89 c8                	mov    %ecx,%eax
      2f:	f7 ea                	imul   %edx
      31:	d1 fa                	sar    %edx
      33:	89 c8                	mov    %ecx,%eax
      35:	c1 f8 1f             	sar    $0x1f,%eax
      38:	29 c2                	sub    %eax,%edx
      3a:	8b 45 10             	mov    0x10(%ebp),%eax
      3d:	01 d0                	add    %edx,%eax
      3f:	8d 48 04             	lea    0x4(%eax),%ecx
      42:	8b 45 08             	mov    0x8(%ebp),%eax
      45:	8d 50 03             	lea    0x3(%eax),%edx
      48:	85 c0                	test   %eax,%eax
      4a:	0f 48 c2             	cmovs  %edx,%eax
      4d:	c1 f8 02             	sar    $0x2,%eax
      50:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
      53:	8b 4d 08             	mov    0x8(%ebp),%ecx
      56:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
      5b:	89 c8                	mov    %ecx,%eax
      5d:	f7 ea                	imul   %edx
      5f:	89 d0                	mov    %edx,%eax
      61:	c1 f8 05             	sar    $0x5,%eax
      64:	c1 f9 1f             	sar    $0x1f,%ecx
      67:	89 ca                	mov    %ecx,%edx
      69:	29 c2                	sub    %eax,%edx
      6b:	89 d0                	mov    %edx,%eax
      6d:	01 c3                	add    %eax,%ebx
      6f:	8b 4d 08             	mov    0x8(%ebp),%ecx
      72:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
      77:	89 c8                	mov    %ecx,%eax
      79:	f7 ea                	imul   %edx
      7b:	c1 fa 07             	sar    $0x7,%edx
      7e:	89 c8                	mov    %ecx,%eax
      80:	c1 f8 1f             	sar    $0x1f,%eax
      83:	29 c2                	sub    %eax,%edx
      85:	89 d0                	mov    %edx,%eax
      87:	8d 0c 03             	lea    (%ebx,%eax,1),%ecx
      8a:	ba 93 24 49 92       	mov    $0x92492493,%edx
      8f:	89 c8                	mov    %ecx,%eax
      91:	f7 ea                	imul   %edx
      93:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
      96:	c1 f8 02             	sar    $0x2,%eax
      99:	89 c2                	mov    %eax,%edx
      9b:	89 c8                	mov    %ecx,%eax
      9d:	c1 f8 1f             	sar    $0x1f,%eax
      a0:	29 c2                	sub    %eax,%edx
      a2:	89 d0                	mov    %edx,%eax
      a4:	89 c2                	mov    %eax,%edx
      a6:	c1 e2 03             	shl    $0x3,%edx
      a9:	29 c2                	sub    %eax,%edx
      ab:	89 c8                	mov    %ecx,%eax
      ad:	29 d0                	sub    %edx,%eax
}
      af:	5b                   	pop    %ebx
      b0:	5d                   	pop    %ebp
      b1:	c3                   	ret    

000000b2 <main>:

int
main(int argc, char *argv[])
{
      b2:	f3 0f 1e fb          	endbr32 
      b6:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      ba:	83 e4 f0             	and    $0xfffffff0,%esp
      bd:	ff 71 fc             	pushl  -0x4(%ecx)
      c0:	55                   	push   %ebp
      c1:	89 e5                	mov    %esp,%ebp
      c3:	51                   	push   %ecx
      c4:	83 ec 24             	sub    $0x24,%esp
  int day;
  struct rtcdate r;

  if (date(&r)) {
      c7:	83 ec 0c             	sub    $0xc,%esp
      ca:	8d 45 dc             	lea    -0x24(%ebp),%eax
      cd:	50                   	push   %eax
      ce:	e8 82 05 00 00       	call   655 <date>
      d3:	83 c4 10             	add    $0x10,%esp
      d6:	85 c0                	test   %eax,%eax
      d8:	74 1b                	je     f5 <main+0x43>
    printf(2,"Error: date call failed. %s at line %d\n",
      da:	6a 1c                	push   $0x1c
      dc:	68 e5 10 00 00       	push   $0x10e5
      e1:	68 ec 10 00 00       	push   $0x10ec
      e6:	6a 02                	push   $0x2
      e8:	e8 8c 06 00 00       	call   779 <printf>
      ed:	83 c4 10             	add    $0x10,%esp
	__FILE__, __LINE__);
    exit();
      f0:	e8 b8 04 00 00       	call   5ad <exit>
  }

  day = dayofweek(r.year, r.month, r.day);
      f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
      f8:	89 c1                	mov    %eax,%ecx
      fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
      fd:	89 c2                	mov    %eax,%edx
      ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
     102:	83 ec 04             	sub    $0x4,%esp
     105:	51                   	push   %ecx
     106:	52                   	push   %edx
     107:	50                   	push   %eax
     108:	e8 f3 fe ff ff       	call   0 <dayofweek>
     10d:	83 c4 10             	add    $0x10,%esp
     110:	89 45 f4             	mov    %eax,-0xc(%ebp)

  printf(1, "%s %s %d", days[day], months[r.month], r.day);
     113:	8b 4d e8             	mov    -0x18(%ebp),%ecx
     116:	8b 45 ec             	mov    -0x14(%ebp),%eax
     119:	8b 14 85 a0 15 00 00 	mov    0x15a0(,%eax,4),%edx
     120:	8b 45 f4             	mov    -0xc(%ebp),%eax
     123:	8b 04 85 d4 15 00 00 	mov    0x15d4(,%eax,4),%eax
     12a:	83 ec 0c             	sub    $0xc,%esp
     12d:	51                   	push   %ecx
     12e:	52                   	push   %edx
     12f:	50                   	push   %eax
     130:	68 14 11 00 00       	push   $0x1114
     135:	6a 01                	push   $0x1
     137:	e8 3d 06 00 00       	call   779 <printf>
     13c:	83 c4 20             	add    $0x20,%esp
  printf(1, " ");
     13f:	83 ec 08             	sub    $0x8,%esp
     142:	68 1d 11 00 00       	push   $0x111d
     147:	6a 01                	push   $0x1
     149:	e8 2b 06 00 00       	call   779 <printf>
     14e:	83 c4 10             	add    $0x10,%esp
  if (r.hour < 10) printf(1, "0");
     151:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     154:	83 f8 09             	cmp    $0x9,%eax
     157:	77 12                	ja     16b <main+0xb9>
     159:	83 ec 08             	sub    $0x8,%esp
     15c:	68 1f 11 00 00       	push   $0x111f
     161:	6a 01                	push   $0x1
     163:	e8 11 06 00 00       	call   779 <printf>
     168:	83 c4 10             	add    $0x10,%esp
  printf(1, "%d:", r.hour);
     16b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     16e:	83 ec 04             	sub    $0x4,%esp
     171:	50                   	push   %eax
     172:	68 21 11 00 00       	push   $0x1121
     177:	6a 01                	push   $0x1
     179:	e8 fb 05 00 00       	call   779 <printf>
     17e:	83 c4 10             	add    $0x10,%esp
  if (r.minute < 10) printf(1, "0");
     181:	8b 45 e0             	mov    -0x20(%ebp),%eax
     184:	83 f8 09             	cmp    $0x9,%eax
     187:	77 12                	ja     19b <main+0xe9>
     189:	83 ec 08             	sub    $0x8,%esp
     18c:	68 1f 11 00 00       	push   $0x111f
     191:	6a 01                	push   $0x1
     193:	e8 e1 05 00 00       	call   779 <printf>
     198:	83 c4 10             	add    $0x10,%esp
  printf(1, "%d:", r.minute);
     19b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     19e:	83 ec 04             	sub    $0x4,%esp
     1a1:	50                   	push   %eax
     1a2:	68 21 11 00 00       	push   $0x1121
     1a7:	6a 01                	push   $0x1
     1a9:	e8 cb 05 00 00       	call   779 <printf>
     1ae:	83 c4 10             	add    $0x10,%esp
  if (r.second < 10) printf(1, "0");
     1b1:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1b4:	83 f8 09             	cmp    $0x9,%eax
     1b7:	77 12                	ja     1cb <main+0x119>
     1b9:	83 ec 08             	sub    $0x8,%esp
     1bc:	68 1f 11 00 00       	push   $0x111f
     1c1:	6a 01                	push   $0x1
     1c3:	e8 b1 05 00 00       	call   779 <printf>
     1c8:	83 c4 10             	add    $0x10,%esp
  printf(1, "%d UTC %d\n", r.second, r.year);
     1cb:	8b 55 f0             	mov    -0x10(%ebp),%edx
     1ce:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1d1:	52                   	push   %edx
     1d2:	50                   	push   %eax
     1d3:	68 25 11 00 00       	push   $0x1125
     1d8:	6a 01                	push   $0x1
     1da:	e8 9a 05 00 00       	call   779 <printf>
     1df:	83 c4 10             	add    $0x10,%esp

  exit();
     1e2:	e8 c6 03 00 00       	call   5ad <exit>

000001e7 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     1e7:	55                   	push   %ebp
     1e8:	89 e5                	mov    %esp,%ebp
     1ea:	57                   	push   %edi
     1eb:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     1ec:	8b 4d 08             	mov    0x8(%ebp),%ecx
     1ef:	8b 55 10             	mov    0x10(%ebp),%edx
     1f2:	8b 45 0c             	mov    0xc(%ebp),%eax
     1f5:	89 cb                	mov    %ecx,%ebx
     1f7:	89 df                	mov    %ebx,%edi
     1f9:	89 d1                	mov    %edx,%ecx
     1fb:	fc                   	cld    
     1fc:	f3 aa                	rep stos %al,%es:(%edi)
     1fe:	89 ca                	mov    %ecx,%edx
     200:	89 fb                	mov    %edi,%ebx
     202:	89 5d 08             	mov    %ebx,0x8(%ebp)
     205:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     208:	90                   	nop
     209:	5b                   	pop    %ebx
     20a:	5f                   	pop    %edi
     20b:	5d                   	pop    %ebp
     20c:	c3                   	ret    

0000020d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     20d:	f3 0f 1e fb          	endbr32 
     211:	55                   	push   %ebp
     212:	89 e5                	mov    %esp,%ebp
     214:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     217:	8b 45 08             	mov    0x8(%ebp),%eax
     21a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     21d:	90                   	nop
     21e:	8b 55 0c             	mov    0xc(%ebp),%edx
     221:	8d 42 01             	lea    0x1(%edx),%eax
     224:	89 45 0c             	mov    %eax,0xc(%ebp)
     227:	8b 45 08             	mov    0x8(%ebp),%eax
     22a:	8d 48 01             	lea    0x1(%eax),%ecx
     22d:	89 4d 08             	mov    %ecx,0x8(%ebp)
     230:	0f b6 12             	movzbl (%edx),%edx
     233:	88 10                	mov    %dl,(%eax)
     235:	0f b6 00             	movzbl (%eax),%eax
     238:	84 c0                	test   %al,%al
     23a:	75 e2                	jne    21e <strcpy+0x11>
    ;
  return os;
     23c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     23f:	c9                   	leave  
     240:	c3                   	ret    

00000241 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     241:	f3 0f 1e fb          	endbr32 
     245:	55                   	push   %ebp
     246:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     248:	eb 08                	jmp    252 <strcmp+0x11>
    p++, q++;
     24a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     24e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     252:	8b 45 08             	mov    0x8(%ebp),%eax
     255:	0f b6 00             	movzbl (%eax),%eax
     258:	84 c0                	test   %al,%al
     25a:	74 10                	je     26c <strcmp+0x2b>
     25c:	8b 45 08             	mov    0x8(%ebp),%eax
     25f:	0f b6 10             	movzbl (%eax),%edx
     262:	8b 45 0c             	mov    0xc(%ebp),%eax
     265:	0f b6 00             	movzbl (%eax),%eax
     268:	38 c2                	cmp    %al,%dl
     26a:	74 de                	je     24a <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
     26c:	8b 45 08             	mov    0x8(%ebp),%eax
     26f:	0f b6 00             	movzbl (%eax),%eax
     272:	0f b6 d0             	movzbl %al,%edx
     275:	8b 45 0c             	mov    0xc(%ebp),%eax
     278:	0f b6 00             	movzbl (%eax),%eax
     27b:	0f b6 c0             	movzbl %al,%eax
     27e:	29 c2                	sub    %eax,%edx
     280:	89 d0                	mov    %edx,%eax
}
     282:	5d                   	pop    %ebp
     283:	c3                   	ret    

00000284 <strlen>:

uint
strlen(char *s)
{
     284:	f3 0f 1e fb          	endbr32 
     288:	55                   	push   %ebp
     289:	89 e5                	mov    %esp,%ebp
     28b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     28e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     295:	eb 04                	jmp    29b <strlen+0x17>
     297:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     29b:	8b 55 fc             	mov    -0x4(%ebp),%edx
     29e:	8b 45 08             	mov    0x8(%ebp),%eax
     2a1:	01 d0                	add    %edx,%eax
     2a3:	0f b6 00             	movzbl (%eax),%eax
     2a6:	84 c0                	test   %al,%al
     2a8:	75 ed                	jne    297 <strlen+0x13>
    ;
  return n;
     2aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2ad:	c9                   	leave  
     2ae:	c3                   	ret    

000002af <memset>:

void*
memset(void *dst, int c, uint n)
{
     2af:	f3 0f 1e fb          	endbr32 
     2b3:	55                   	push   %ebp
     2b4:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     2b6:	8b 45 10             	mov    0x10(%ebp),%eax
     2b9:	50                   	push   %eax
     2ba:	ff 75 0c             	pushl  0xc(%ebp)
     2bd:	ff 75 08             	pushl  0x8(%ebp)
     2c0:	e8 22 ff ff ff       	call   1e7 <stosb>
     2c5:	83 c4 0c             	add    $0xc,%esp
  return dst;
     2c8:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2cb:	c9                   	leave  
     2cc:	c3                   	ret    

000002cd <strchr>:

char*
strchr(const char *s, char c)
{
     2cd:	f3 0f 1e fb          	endbr32 
     2d1:	55                   	push   %ebp
     2d2:	89 e5                	mov    %esp,%ebp
     2d4:	83 ec 04             	sub    $0x4,%esp
     2d7:	8b 45 0c             	mov    0xc(%ebp),%eax
     2da:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     2dd:	eb 14                	jmp    2f3 <strchr+0x26>
    if(*s == c)
     2df:	8b 45 08             	mov    0x8(%ebp),%eax
     2e2:	0f b6 00             	movzbl (%eax),%eax
     2e5:	38 45 fc             	cmp    %al,-0x4(%ebp)
     2e8:	75 05                	jne    2ef <strchr+0x22>
      return (char*)s;
     2ea:	8b 45 08             	mov    0x8(%ebp),%eax
     2ed:	eb 13                	jmp    302 <strchr+0x35>
  for(; *s; s++)
     2ef:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2f3:	8b 45 08             	mov    0x8(%ebp),%eax
     2f6:	0f b6 00             	movzbl (%eax),%eax
     2f9:	84 c0                	test   %al,%al
     2fb:	75 e2                	jne    2df <strchr+0x12>
  return 0;
     2fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
     302:	c9                   	leave  
     303:	c3                   	ret    

00000304 <gets>:

char*
gets(char *buf, int max)
{
     304:	f3 0f 1e fb          	endbr32 
     308:	55                   	push   %ebp
     309:	89 e5                	mov    %esp,%ebp
     30b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     30e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     315:	eb 42                	jmp    359 <gets+0x55>
    cc = read(0, &c, 1);
     317:	83 ec 04             	sub    $0x4,%esp
     31a:	6a 01                	push   $0x1
     31c:	8d 45 ef             	lea    -0x11(%ebp),%eax
     31f:	50                   	push   %eax
     320:	6a 00                	push   $0x0
     322:	e8 9e 02 00 00       	call   5c5 <read>
     327:	83 c4 10             	add    $0x10,%esp
     32a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     32d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     331:	7e 33                	jle    366 <gets+0x62>
      break;
    buf[i++] = c;
     333:	8b 45 f4             	mov    -0xc(%ebp),%eax
     336:	8d 50 01             	lea    0x1(%eax),%edx
     339:	89 55 f4             	mov    %edx,-0xc(%ebp)
     33c:	89 c2                	mov    %eax,%edx
     33e:	8b 45 08             	mov    0x8(%ebp),%eax
     341:	01 c2                	add    %eax,%edx
     343:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     347:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     349:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     34d:	3c 0a                	cmp    $0xa,%al
     34f:	74 16                	je     367 <gets+0x63>
     351:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     355:	3c 0d                	cmp    $0xd,%al
     357:	74 0e                	je     367 <gets+0x63>
  for(i=0; i+1 < max; ){
     359:	8b 45 f4             	mov    -0xc(%ebp),%eax
     35c:	83 c0 01             	add    $0x1,%eax
     35f:	39 45 0c             	cmp    %eax,0xc(%ebp)
     362:	7f b3                	jg     317 <gets+0x13>
     364:	eb 01                	jmp    367 <gets+0x63>
      break;
     366:	90                   	nop
      break;
  }
  buf[i] = '\0';
     367:	8b 55 f4             	mov    -0xc(%ebp),%edx
     36a:	8b 45 08             	mov    0x8(%ebp),%eax
     36d:	01 d0                	add    %edx,%eax
     36f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     372:	8b 45 08             	mov    0x8(%ebp),%eax
}
     375:	c9                   	leave  
     376:	c3                   	ret    

00000377 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
     377:	f3 0f 1e fb          	endbr32 
     37b:	55                   	push   %ebp
     37c:	89 e5                	mov    %esp,%ebp
     37e:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
     381:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     388:	eb 43                	jmp    3cd <fgets+0x56>
    int cc = read(fd, &c, 1);
     38a:	83 ec 04             	sub    $0x4,%esp
     38d:	6a 01                	push   $0x1
     38f:	8d 45 ef             	lea    -0x11(%ebp),%eax
     392:	50                   	push   %eax
     393:	ff 75 10             	pushl  0x10(%ebp)
     396:	e8 2a 02 00 00       	call   5c5 <read>
     39b:	83 c4 10             	add    $0x10,%esp
     39e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     3a1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3a5:	7e 33                	jle    3da <fgets+0x63>
      break;
    buf[i++] = c;
     3a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3aa:	8d 50 01             	lea    0x1(%eax),%edx
     3ad:	89 55 f4             	mov    %edx,-0xc(%ebp)
     3b0:	89 c2                	mov    %eax,%edx
     3b2:	8b 45 08             	mov    0x8(%ebp),%eax
     3b5:	01 c2                	add    %eax,%edx
     3b7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3bb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     3bd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3c1:	3c 0a                	cmp    $0xa,%al
     3c3:	74 16                	je     3db <fgets+0x64>
     3c5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     3c9:	3c 0d                	cmp    $0xd,%al
     3cb:	74 0e                	je     3db <fgets+0x64>
  for(i = 0; i + 1 < size;){
     3cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3d0:	83 c0 01             	add    $0x1,%eax
     3d3:	39 45 0c             	cmp    %eax,0xc(%ebp)
     3d6:	7f b2                	jg     38a <fgets+0x13>
     3d8:	eb 01                	jmp    3db <fgets+0x64>
      break;
     3da:	90                   	nop
      break;
  }
  buf[i] = '\0';
     3db:	8b 55 f4             	mov    -0xc(%ebp),%edx
     3de:	8b 45 08             	mov    0x8(%ebp),%eax
     3e1:	01 d0                	add    %edx,%eax
     3e3:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     3e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3e9:	c9                   	leave  
     3ea:	c3                   	ret    

000003eb <stat>:

int
stat(char *n, struct stat *st)
{
     3eb:	f3 0f 1e fb          	endbr32 
     3ef:	55                   	push   %ebp
     3f0:	89 e5                	mov    %esp,%ebp
     3f2:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     3f5:	83 ec 08             	sub    $0x8,%esp
     3f8:	6a 00                	push   $0x0
     3fa:	ff 75 08             	pushl  0x8(%ebp)
     3fd:	e8 eb 01 00 00       	call   5ed <open>
     402:	83 c4 10             	add    $0x10,%esp
     405:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     408:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     40c:	79 07                	jns    415 <stat+0x2a>
    return -1;
     40e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     413:	eb 25                	jmp    43a <stat+0x4f>
  r = fstat(fd, st);
     415:	83 ec 08             	sub    $0x8,%esp
     418:	ff 75 0c             	pushl  0xc(%ebp)
     41b:	ff 75 f4             	pushl  -0xc(%ebp)
     41e:	e8 e2 01 00 00       	call   605 <fstat>
     423:	83 c4 10             	add    $0x10,%esp
     426:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     429:	83 ec 0c             	sub    $0xc,%esp
     42c:	ff 75 f4             	pushl  -0xc(%ebp)
     42f:	e8 a1 01 00 00       	call   5d5 <close>
     434:	83 c4 10             	add    $0x10,%esp
  return r;
     437:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     43a:	c9                   	leave  
     43b:	c3                   	ret    

0000043c <atoi>:

int
atoi(const char *s)
{
     43c:	f3 0f 1e fb          	endbr32 
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     446:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     44d:	eb 04                	jmp    453 <atoi+0x17>
     44f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     453:	8b 45 08             	mov    0x8(%ebp),%eax
     456:	0f b6 00             	movzbl (%eax),%eax
     459:	3c 20                	cmp    $0x20,%al
     45b:	74 f2                	je     44f <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
     45d:	8b 45 08             	mov    0x8(%ebp),%eax
     460:	0f b6 00             	movzbl (%eax),%eax
     463:	3c 2d                	cmp    $0x2d,%al
     465:	75 07                	jne    46e <atoi+0x32>
     467:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     46c:	eb 05                	jmp    473 <atoi+0x37>
     46e:	b8 01 00 00 00       	mov    $0x1,%eax
     473:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     476:	8b 45 08             	mov    0x8(%ebp),%eax
     479:	0f b6 00             	movzbl (%eax),%eax
     47c:	3c 2b                	cmp    $0x2b,%al
     47e:	74 0a                	je     48a <atoi+0x4e>
     480:	8b 45 08             	mov    0x8(%ebp),%eax
     483:	0f b6 00             	movzbl (%eax),%eax
     486:	3c 2d                	cmp    $0x2d,%al
     488:	75 2b                	jne    4b5 <atoi+0x79>
    s++;
     48a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     48e:	eb 25                	jmp    4b5 <atoi+0x79>
    n = n*10 + *s++ - '0';
     490:	8b 55 fc             	mov    -0x4(%ebp),%edx
     493:	89 d0                	mov    %edx,%eax
     495:	c1 e0 02             	shl    $0x2,%eax
     498:	01 d0                	add    %edx,%eax
     49a:	01 c0                	add    %eax,%eax
     49c:	89 c1                	mov    %eax,%ecx
     49e:	8b 45 08             	mov    0x8(%ebp),%eax
     4a1:	8d 50 01             	lea    0x1(%eax),%edx
     4a4:	89 55 08             	mov    %edx,0x8(%ebp)
     4a7:	0f b6 00             	movzbl (%eax),%eax
     4aa:	0f be c0             	movsbl %al,%eax
     4ad:	01 c8                	add    %ecx,%eax
     4af:	83 e8 30             	sub    $0x30,%eax
     4b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     4b5:	8b 45 08             	mov    0x8(%ebp),%eax
     4b8:	0f b6 00             	movzbl (%eax),%eax
     4bb:	3c 2f                	cmp    $0x2f,%al
     4bd:	7e 0a                	jle    4c9 <atoi+0x8d>
     4bf:	8b 45 08             	mov    0x8(%ebp),%eax
     4c2:	0f b6 00             	movzbl (%eax),%eax
     4c5:	3c 39                	cmp    $0x39,%al
     4c7:	7e c7                	jle    490 <atoi+0x54>
  return sign*n;
     4c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     4cc:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     4d0:	c9                   	leave  
     4d1:	c3                   	ret    

000004d2 <atoo>:

int
atoo(const char *s)
{
     4d2:	f3 0f 1e fb          	endbr32 
     4d6:	55                   	push   %ebp
     4d7:	89 e5                	mov    %esp,%ebp
     4d9:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     4dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     4e3:	eb 04                	jmp    4e9 <atoo+0x17>
     4e5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     4e9:	8b 45 08             	mov    0x8(%ebp),%eax
     4ec:	0f b6 00             	movzbl (%eax),%eax
     4ef:	3c 20                	cmp    $0x20,%al
     4f1:	74 f2                	je     4e5 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
     4f3:	8b 45 08             	mov    0x8(%ebp),%eax
     4f6:	0f b6 00             	movzbl (%eax),%eax
     4f9:	3c 2d                	cmp    $0x2d,%al
     4fb:	75 07                	jne    504 <atoo+0x32>
     4fd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     502:	eb 05                	jmp    509 <atoo+0x37>
     504:	b8 01 00 00 00       	mov    $0x1,%eax
     509:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     50c:	8b 45 08             	mov    0x8(%ebp),%eax
     50f:	0f b6 00             	movzbl (%eax),%eax
     512:	3c 2b                	cmp    $0x2b,%al
     514:	74 0a                	je     520 <atoo+0x4e>
     516:	8b 45 08             	mov    0x8(%ebp),%eax
     519:	0f b6 00             	movzbl (%eax),%eax
     51c:	3c 2d                	cmp    $0x2d,%al
     51e:	75 27                	jne    547 <atoo+0x75>
    s++;
     520:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     524:	eb 21                	jmp    547 <atoo+0x75>
    n = n*8 + *s++ - '0';
     526:	8b 45 fc             	mov    -0x4(%ebp),%eax
     529:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     530:	8b 45 08             	mov    0x8(%ebp),%eax
     533:	8d 50 01             	lea    0x1(%eax),%edx
     536:	89 55 08             	mov    %edx,0x8(%ebp)
     539:	0f b6 00             	movzbl (%eax),%eax
     53c:	0f be c0             	movsbl %al,%eax
     53f:	01 c8                	add    %ecx,%eax
     541:	83 e8 30             	sub    $0x30,%eax
     544:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
     547:	8b 45 08             	mov    0x8(%ebp),%eax
     54a:	0f b6 00             	movzbl (%eax),%eax
     54d:	3c 2f                	cmp    $0x2f,%al
     54f:	7e 0a                	jle    55b <atoo+0x89>
     551:	8b 45 08             	mov    0x8(%ebp),%eax
     554:	0f b6 00             	movzbl (%eax),%eax
     557:	3c 37                	cmp    $0x37,%al
     559:	7e cb                	jle    526 <atoo+0x54>
  return sign*n;
     55b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     55e:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     562:	c9                   	leave  
     563:	c3                   	ret    

00000564 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     564:	f3 0f 1e fb          	endbr32 
     568:	55                   	push   %ebp
     569:	89 e5                	mov    %esp,%ebp
     56b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     56e:	8b 45 08             	mov    0x8(%ebp),%eax
     571:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     574:	8b 45 0c             	mov    0xc(%ebp),%eax
     577:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     57a:	eb 17                	jmp    593 <memmove+0x2f>
    *dst++ = *src++;
     57c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     57f:	8d 42 01             	lea    0x1(%edx),%eax
     582:	89 45 f8             	mov    %eax,-0x8(%ebp)
     585:	8b 45 fc             	mov    -0x4(%ebp),%eax
     588:	8d 48 01             	lea    0x1(%eax),%ecx
     58b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     58e:	0f b6 12             	movzbl (%edx),%edx
     591:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     593:	8b 45 10             	mov    0x10(%ebp),%eax
     596:	8d 50 ff             	lea    -0x1(%eax),%edx
     599:	89 55 10             	mov    %edx,0x10(%ebp)
     59c:	85 c0                	test   %eax,%eax
     59e:	7f dc                	jg     57c <memmove+0x18>
  return vdst;
     5a0:	8b 45 08             	mov    0x8(%ebp),%eax
}
     5a3:	c9                   	leave  
     5a4:	c3                   	ret    

000005a5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     5a5:	b8 01 00 00 00       	mov    $0x1,%eax
     5aa:	cd 40                	int    $0x40
     5ac:	c3                   	ret    

000005ad <exit>:
SYSCALL(exit)
     5ad:	b8 02 00 00 00       	mov    $0x2,%eax
     5b2:	cd 40                	int    $0x40
     5b4:	c3                   	ret    

000005b5 <wait>:
SYSCALL(wait)
     5b5:	b8 03 00 00 00       	mov    $0x3,%eax
     5ba:	cd 40                	int    $0x40
     5bc:	c3                   	ret    

000005bd <pipe>:
SYSCALL(pipe)
     5bd:	b8 04 00 00 00       	mov    $0x4,%eax
     5c2:	cd 40                	int    $0x40
     5c4:	c3                   	ret    

000005c5 <read>:
SYSCALL(read)
     5c5:	b8 05 00 00 00       	mov    $0x5,%eax
     5ca:	cd 40                	int    $0x40
     5cc:	c3                   	ret    

000005cd <write>:
SYSCALL(write)
     5cd:	b8 10 00 00 00       	mov    $0x10,%eax
     5d2:	cd 40                	int    $0x40
     5d4:	c3                   	ret    

000005d5 <close>:
SYSCALL(close)
     5d5:	b8 15 00 00 00       	mov    $0x15,%eax
     5da:	cd 40                	int    $0x40
     5dc:	c3                   	ret    

000005dd <kill>:
SYSCALL(kill)
     5dd:	b8 06 00 00 00       	mov    $0x6,%eax
     5e2:	cd 40                	int    $0x40
     5e4:	c3                   	ret    

000005e5 <exec>:
SYSCALL(exec)
     5e5:	b8 07 00 00 00       	mov    $0x7,%eax
     5ea:	cd 40                	int    $0x40
     5ec:	c3                   	ret    

000005ed <open>:
SYSCALL(open)
     5ed:	b8 0f 00 00 00       	mov    $0xf,%eax
     5f2:	cd 40                	int    $0x40
     5f4:	c3                   	ret    

000005f5 <mknod>:
SYSCALL(mknod)
     5f5:	b8 11 00 00 00       	mov    $0x11,%eax
     5fa:	cd 40                	int    $0x40
     5fc:	c3                   	ret    

000005fd <unlink>:
SYSCALL(unlink)
     5fd:	b8 12 00 00 00       	mov    $0x12,%eax
     602:	cd 40                	int    $0x40
     604:	c3                   	ret    

00000605 <fstat>:
SYSCALL(fstat)
     605:	b8 08 00 00 00       	mov    $0x8,%eax
     60a:	cd 40                	int    $0x40
     60c:	c3                   	ret    

0000060d <link>:
SYSCALL(link)
     60d:	b8 13 00 00 00       	mov    $0x13,%eax
     612:	cd 40                	int    $0x40
     614:	c3                   	ret    

00000615 <mkdir>:
SYSCALL(mkdir)
     615:	b8 14 00 00 00       	mov    $0x14,%eax
     61a:	cd 40                	int    $0x40
     61c:	c3                   	ret    

0000061d <chdir>:
SYSCALL(chdir)
     61d:	b8 09 00 00 00       	mov    $0x9,%eax
     622:	cd 40                	int    $0x40
     624:	c3                   	ret    

00000625 <dup>:
SYSCALL(dup)
     625:	b8 0a 00 00 00       	mov    $0xa,%eax
     62a:	cd 40                	int    $0x40
     62c:	c3                   	ret    

0000062d <getpid>:
SYSCALL(getpid)
     62d:	b8 0b 00 00 00       	mov    $0xb,%eax
     632:	cd 40                	int    $0x40
     634:	c3                   	ret    

00000635 <sbrk>:
SYSCALL(sbrk)
     635:	b8 0c 00 00 00       	mov    $0xc,%eax
     63a:	cd 40                	int    $0x40
     63c:	c3                   	ret    

0000063d <sleep>:
SYSCALL(sleep)
     63d:	b8 0d 00 00 00       	mov    $0xd,%eax
     642:	cd 40                	int    $0x40
     644:	c3                   	ret    

00000645 <uptime>:
SYSCALL(uptime)
     645:	b8 0e 00 00 00       	mov    $0xe,%eax
     64a:	cd 40                	int    $0x40
     64c:	c3                   	ret    

0000064d <halt>:
SYSCALL(halt)
     64d:	b8 16 00 00 00       	mov    $0x16,%eax
     652:	cd 40                	int    $0x40
     654:	c3                   	ret    

00000655 <date>:
SYSCALL(date)
     655:	b8 17 00 00 00       	mov    $0x17,%eax
     65a:	cd 40                	int    $0x40
     65c:	c3                   	ret    

0000065d <getuid>:
SYSCALL(getuid)
     65d:	b8 18 00 00 00       	mov    $0x18,%eax
     662:	cd 40                	int    $0x40
     664:	c3                   	ret    

00000665 <getgid>:
SYSCALL(getgid)
     665:	b8 19 00 00 00       	mov    $0x19,%eax
     66a:	cd 40                	int    $0x40
     66c:	c3                   	ret    

0000066d <getppid>:
SYSCALL(getppid)
     66d:	b8 1a 00 00 00       	mov    $0x1a,%eax
     672:	cd 40                	int    $0x40
     674:	c3                   	ret    

00000675 <setuid>:
SYSCALL(setuid)
     675:	b8 1b 00 00 00       	mov    $0x1b,%eax
     67a:	cd 40                	int    $0x40
     67c:	c3                   	ret    

0000067d <setgid>:
SYSCALL(setgid)
     67d:	b8 1c 00 00 00       	mov    $0x1c,%eax
     682:	cd 40                	int    $0x40
     684:	c3                   	ret    

00000685 <getprocs>:
SYSCALL(getprocs)
     685:	b8 1d 00 00 00       	mov    $0x1d,%eax
     68a:	cd 40                	int    $0x40
     68c:	c3                   	ret    

0000068d <setpriority>:
SYSCALL(setpriority)
     68d:	b8 1e 00 00 00       	mov    $0x1e,%eax
     692:	cd 40                	int    $0x40
     694:	c3                   	ret    

00000695 <chown>:
SYSCALL(chown)
     695:	b8 1f 00 00 00       	mov    $0x1f,%eax
     69a:	cd 40                	int    $0x40
     69c:	c3                   	ret    

0000069d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     69d:	f3 0f 1e fb          	endbr32 
     6a1:	55                   	push   %ebp
     6a2:	89 e5                	mov    %esp,%ebp
     6a4:	83 ec 18             	sub    $0x18,%esp
     6a7:	8b 45 0c             	mov    0xc(%ebp),%eax
     6aa:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     6ad:	83 ec 04             	sub    $0x4,%esp
     6b0:	6a 01                	push   $0x1
     6b2:	8d 45 f4             	lea    -0xc(%ebp),%eax
     6b5:	50                   	push   %eax
     6b6:	ff 75 08             	pushl  0x8(%ebp)
     6b9:	e8 0f ff ff ff       	call   5cd <write>
     6be:	83 c4 10             	add    $0x10,%esp
}
     6c1:	90                   	nop
     6c2:	c9                   	leave  
     6c3:	c3                   	ret    

000006c4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     6c4:	f3 0f 1e fb          	endbr32 
     6c8:	55                   	push   %ebp
     6c9:	89 e5                	mov    %esp,%ebp
     6cb:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     6d5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     6d9:	74 17                	je     6f2 <printint+0x2e>
     6db:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     6df:	79 11                	jns    6f2 <printint+0x2e>
    neg = 1;
     6e1:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     6e8:	8b 45 0c             	mov    0xc(%ebp),%eax
     6eb:	f7 d8                	neg    %eax
     6ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
     6f0:	eb 06                	jmp    6f8 <printint+0x34>
  } else {
    x = xx;
     6f2:	8b 45 0c             	mov    0xc(%ebp),%eax
     6f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     6f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     6ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
     702:	8b 45 ec             	mov    -0x14(%ebp),%eax
     705:	ba 00 00 00 00       	mov    $0x0,%edx
     70a:	f7 f1                	div    %ecx
     70c:	89 d1                	mov    %edx,%ecx
     70e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     711:	8d 50 01             	lea    0x1(%eax),%edx
     714:	89 55 f4             	mov    %edx,-0xc(%ebp)
     717:	0f b6 91 f0 15 00 00 	movzbl 0x15f0(%ecx),%edx
     71e:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     722:	8b 4d 10             	mov    0x10(%ebp),%ecx
     725:	8b 45 ec             	mov    -0x14(%ebp),%eax
     728:	ba 00 00 00 00       	mov    $0x0,%edx
     72d:	f7 f1                	div    %ecx
     72f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     732:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     736:	75 c7                	jne    6ff <printint+0x3b>
  if(neg)
     738:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     73c:	74 2d                	je     76b <printint+0xa7>
    buf[i++] = '-';
     73e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     741:	8d 50 01             	lea    0x1(%eax),%edx
     744:	89 55 f4             	mov    %edx,-0xc(%ebp)
     747:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     74c:	eb 1d                	jmp    76b <printint+0xa7>
    putc(fd, buf[i]);
     74e:	8d 55 dc             	lea    -0x24(%ebp),%edx
     751:	8b 45 f4             	mov    -0xc(%ebp),%eax
     754:	01 d0                	add    %edx,%eax
     756:	0f b6 00             	movzbl (%eax),%eax
     759:	0f be c0             	movsbl %al,%eax
     75c:	83 ec 08             	sub    $0x8,%esp
     75f:	50                   	push   %eax
     760:	ff 75 08             	pushl  0x8(%ebp)
     763:	e8 35 ff ff ff       	call   69d <putc>
     768:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     76b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     76f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     773:	79 d9                	jns    74e <printint+0x8a>
}
     775:	90                   	nop
     776:	90                   	nop
     777:	c9                   	leave  
     778:	c3                   	ret    

00000779 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     779:	f3 0f 1e fb          	endbr32 
     77d:	55                   	push   %ebp
     77e:	89 e5                	mov    %esp,%ebp
     780:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     783:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     78a:	8d 45 0c             	lea    0xc(%ebp),%eax
     78d:	83 c0 04             	add    $0x4,%eax
     790:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     793:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     79a:	e9 59 01 00 00       	jmp    8f8 <printf+0x17f>
    c = fmt[i] & 0xff;
     79f:	8b 55 0c             	mov    0xc(%ebp),%edx
     7a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a5:	01 d0                	add    %edx,%eax
     7a7:	0f b6 00             	movzbl (%eax),%eax
     7aa:	0f be c0             	movsbl %al,%eax
     7ad:	25 ff 00 00 00       	and    $0xff,%eax
     7b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     7b5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     7b9:	75 2c                	jne    7e7 <printf+0x6e>
      if(c == '%'){
     7bb:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     7bf:	75 0c                	jne    7cd <printf+0x54>
        state = '%';
     7c1:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     7c8:	e9 27 01 00 00       	jmp    8f4 <printf+0x17b>
      } else {
        putc(fd, c);
     7cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7d0:	0f be c0             	movsbl %al,%eax
     7d3:	83 ec 08             	sub    $0x8,%esp
     7d6:	50                   	push   %eax
     7d7:	ff 75 08             	pushl  0x8(%ebp)
     7da:	e8 be fe ff ff       	call   69d <putc>
     7df:	83 c4 10             	add    $0x10,%esp
     7e2:	e9 0d 01 00 00       	jmp    8f4 <printf+0x17b>
      }
    } else if(state == '%'){
     7e7:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     7eb:	0f 85 03 01 00 00    	jne    8f4 <printf+0x17b>
      if(c == 'd'){
     7f1:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     7f5:	75 1e                	jne    815 <printf+0x9c>
        printint(fd, *ap, 10, 1);
     7f7:	8b 45 e8             	mov    -0x18(%ebp),%eax
     7fa:	8b 00                	mov    (%eax),%eax
     7fc:	6a 01                	push   $0x1
     7fe:	6a 0a                	push   $0xa
     800:	50                   	push   %eax
     801:	ff 75 08             	pushl  0x8(%ebp)
     804:	e8 bb fe ff ff       	call   6c4 <printint>
     809:	83 c4 10             	add    $0x10,%esp
        ap++;
     80c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     810:	e9 d8 00 00 00       	jmp    8ed <printf+0x174>
      } else if(c == 'x' || c == 'p'){
     815:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     819:	74 06                	je     821 <printf+0xa8>
     81b:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     81f:	75 1e                	jne    83f <printf+0xc6>
        printint(fd, *ap, 16, 0);
     821:	8b 45 e8             	mov    -0x18(%ebp),%eax
     824:	8b 00                	mov    (%eax),%eax
     826:	6a 00                	push   $0x0
     828:	6a 10                	push   $0x10
     82a:	50                   	push   %eax
     82b:	ff 75 08             	pushl  0x8(%ebp)
     82e:	e8 91 fe ff ff       	call   6c4 <printint>
     833:	83 c4 10             	add    $0x10,%esp
        ap++;
     836:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     83a:	e9 ae 00 00 00       	jmp    8ed <printf+0x174>
      } else if(c == 's'){
     83f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     843:	75 43                	jne    888 <printf+0x10f>
        s = (char*)*ap;
     845:	8b 45 e8             	mov    -0x18(%ebp),%eax
     848:	8b 00                	mov    (%eax),%eax
     84a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     84d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     851:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     855:	75 25                	jne    87c <printf+0x103>
          s = "(null)";
     857:	c7 45 f4 30 11 00 00 	movl   $0x1130,-0xc(%ebp)
        while(*s != 0){
     85e:	eb 1c                	jmp    87c <printf+0x103>
          putc(fd, *s);
     860:	8b 45 f4             	mov    -0xc(%ebp),%eax
     863:	0f b6 00             	movzbl (%eax),%eax
     866:	0f be c0             	movsbl %al,%eax
     869:	83 ec 08             	sub    $0x8,%esp
     86c:	50                   	push   %eax
     86d:	ff 75 08             	pushl  0x8(%ebp)
     870:	e8 28 fe ff ff       	call   69d <putc>
     875:	83 c4 10             	add    $0x10,%esp
          s++;
     878:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     87c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87f:	0f b6 00             	movzbl (%eax),%eax
     882:	84 c0                	test   %al,%al
     884:	75 da                	jne    860 <printf+0xe7>
     886:	eb 65                	jmp    8ed <printf+0x174>
        }
      } else if(c == 'c'){
     888:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     88c:	75 1d                	jne    8ab <printf+0x132>
        putc(fd, *ap);
     88e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     891:	8b 00                	mov    (%eax),%eax
     893:	0f be c0             	movsbl %al,%eax
     896:	83 ec 08             	sub    $0x8,%esp
     899:	50                   	push   %eax
     89a:	ff 75 08             	pushl  0x8(%ebp)
     89d:	e8 fb fd ff ff       	call   69d <putc>
     8a2:	83 c4 10             	add    $0x10,%esp
        ap++;
     8a5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     8a9:	eb 42                	jmp    8ed <printf+0x174>
      } else if(c == '%'){
     8ab:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     8af:	75 17                	jne    8c8 <printf+0x14f>
        putc(fd, c);
     8b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8b4:	0f be c0             	movsbl %al,%eax
     8b7:	83 ec 08             	sub    $0x8,%esp
     8ba:	50                   	push   %eax
     8bb:	ff 75 08             	pushl  0x8(%ebp)
     8be:	e8 da fd ff ff       	call   69d <putc>
     8c3:	83 c4 10             	add    $0x10,%esp
     8c6:	eb 25                	jmp    8ed <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     8c8:	83 ec 08             	sub    $0x8,%esp
     8cb:	6a 25                	push   $0x25
     8cd:	ff 75 08             	pushl  0x8(%ebp)
     8d0:	e8 c8 fd ff ff       	call   69d <putc>
     8d5:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     8d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     8db:	0f be c0             	movsbl %al,%eax
     8de:	83 ec 08             	sub    $0x8,%esp
     8e1:	50                   	push   %eax
     8e2:	ff 75 08             	pushl  0x8(%ebp)
     8e5:	e8 b3 fd ff ff       	call   69d <putc>
     8ea:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     8ed:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     8f4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     8f8:	8b 55 0c             	mov    0xc(%ebp),%edx
     8fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8fe:	01 d0                	add    %edx,%eax
     900:	0f b6 00             	movzbl (%eax),%eax
     903:	84 c0                	test   %al,%al
     905:	0f 85 94 fe ff ff    	jne    79f <printf+0x26>
    }
  }
}
     90b:	90                   	nop
     90c:	90                   	nop
     90d:	c9                   	leave  
     90e:	c3                   	ret    

0000090f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     90f:	f3 0f 1e fb          	endbr32 
     913:	55                   	push   %ebp
     914:	89 e5                	mov    %esp,%ebp
     916:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     919:	8b 45 08             	mov    0x8(%ebp),%eax
     91c:	83 e8 08             	sub    $0x8,%eax
     91f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     922:	a1 28 16 00 00       	mov    0x1628,%eax
     927:	89 45 fc             	mov    %eax,-0x4(%ebp)
     92a:	eb 24                	jmp    950 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     92c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     92f:	8b 00                	mov    (%eax),%eax
     931:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     934:	72 12                	jb     948 <free+0x39>
     936:	8b 45 f8             	mov    -0x8(%ebp),%eax
     939:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     93c:	77 24                	ja     962 <free+0x53>
     93e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     941:	8b 00                	mov    (%eax),%eax
     943:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     946:	72 1a                	jb     962 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     948:	8b 45 fc             	mov    -0x4(%ebp),%eax
     94b:	8b 00                	mov    (%eax),%eax
     94d:	89 45 fc             	mov    %eax,-0x4(%ebp)
     950:	8b 45 f8             	mov    -0x8(%ebp),%eax
     953:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     956:	76 d4                	jbe    92c <free+0x1d>
     958:	8b 45 fc             	mov    -0x4(%ebp),%eax
     95b:	8b 00                	mov    (%eax),%eax
     95d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     960:	73 ca                	jae    92c <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
     962:	8b 45 f8             	mov    -0x8(%ebp),%eax
     965:	8b 40 04             	mov    0x4(%eax),%eax
     968:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     96f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     972:	01 c2                	add    %eax,%edx
     974:	8b 45 fc             	mov    -0x4(%ebp),%eax
     977:	8b 00                	mov    (%eax),%eax
     979:	39 c2                	cmp    %eax,%edx
     97b:	75 24                	jne    9a1 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
     97d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     980:	8b 50 04             	mov    0x4(%eax),%edx
     983:	8b 45 fc             	mov    -0x4(%ebp),%eax
     986:	8b 00                	mov    (%eax),%eax
     988:	8b 40 04             	mov    0x4(%eax),%eax
     98b:	01 c2                	add    %eax,%edx
     98d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     990:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     993:	8b 45 fc             	mov    -0x4(%ebp),%eax
     996:	8b 00                	mov    (%eax),%eax
     998:	8b 10                	mov    (%eax),%edx
     99a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     99d:	89 10                	mov    %edx,(%eax)
     99f:	eb 0a                	jmp    9ab <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
     9a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9a4:	8b 10                	mov    (%eax),%edx
     9a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9a9:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     9ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ae:	8b 40 04             	mov    0x4(%eax),%eax
     9b1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     9b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9bb:	01 d0                	add    %edx,%eax
     9bd:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     9c0:	75 20                	jne    9e2 <free+0xd3>
    p->s.size += bp->s.size;
     9c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9c5:	8b 50 04             	mov    0x4(%eax),%edx
     9c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9cb:	8b 40 04             	mov    0x4(%eax),%eax
     9ce:	01 c2                	add    %eax,%edx
     9d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9d3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     9d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     9d9:	8b 10                	mov    (%eax),%edx
     9db:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9de:	89 10                	mov    %edx,(%eax)
     9e0:	eb 08                	jmp    9ea <free+0xdb>
  } else
    p->s.ptr = bp;
     9e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9e5:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9e8:	89 10                	mov    %edx,(%eax)
  freep = p;
     9ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9ed:	a3 28 16 00 00       	mov    %eax,0x1628
}
     9f2:	90                   	nop
     9f3:	c9                   	leave  
     9f4:	c3                   	ret    

000009f5 <morecore>:

static Header*
morecore(uint nu)
{
     9f5:	f3 0f 1e fb          	endbr32 
     9f9:	55                   	push   %ebp
     9fa:	89 e5                	mov    %esp,%ebp
     9fc:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     9ff:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     a06:	77 07                	ja     a0f <morecore+0x1a>
    nu = 4096;
     a08:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     a0f:	8b 45 08             	mov    0x8(%ebp),%eax
     a12:	c1 e0 03             	shl    $0x3,%eax
     a15:	83 ec 0c             	sub    $0xc,%esp
     a18:	50                   	push   %eax
     a19:	e8 17 fc ff ff       	call   635 <sbrk>
     a1e:	83 c4 10             	add    $0x10,%esp
     a21:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     a24:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     a28:	75 07                	jne    a31 <morecore+0x3c>
    return 0;
     a2a:	b8 00 00 00 00       	mov    $0x0,%eax
     a2f:	eb 26                	jmp    a57 <morecore+0x62>
  hp = (Header*)p;
     a31:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a34:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     a37:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a3a:	8b 55 08             	mov    0x8(%ebp),%edx
     a3d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     a40:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a43:	83 c0 08             	add    $0x8,%eax
     a46:	83 ec 0c             	sub    $0xc,%esp
     a49:	50                   	push   %eax
     a4a:	e8 c0 fe ff ff       	call   90f <free>
     a4f:	83 c4 10             	add    $0x10,%esp
  return freep;
     a52:	a1 28 16 00 00       	mov    0x1628,%eax
}
     a57:	c9                   	leave  
     a58:	c3                   	ret    

00000a59 <malloc>:

void*
malloc(uint nbytes)
{
     a59:	f3 0f 1e fb          	endbr32 
     a5d:	55                   	push   %ebp
     a5e:	89 e5                	mov    %esp,%ebp
     a60:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     a63:	8b 45 08             	mov    0x8(%ebp),%eax
     a66:	83 c0 07             	add    $0x7,%eax
     a69:	c1 e8 03             	shr    $0x3,%eax
     a6c:	83 c0 01             	add    $0x1,%eax
     a6f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     a72:	a1 28 16 00 00       	mov    0x1628,%eax
     a77:	89 45 f0             	mov    %eax,-0x10(%ebp)
     a7a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a7e:	75 23                	jne    aa3 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
     a80:	c7 45 f0 20 16 00 00 	movl   $0x1620,-0x10(%ebp)
     a87:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a8a:	a3 28 16 00 00       	mov    %eax,0x1628
     a8f:	a1 28 16 00 00       	mov    0x1628,%eax
     a94:	a3 20 16 00 00       	mov    %eax,0x1620
    base.s.size = 0;
     a99:	c7 05 24 16 00 00 00 	movl   $0x0,0x1624
     aa0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     aa3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     aa6:	8b 00                	mov    (%eax),%eax
     aa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     aab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aae:	8b 40 04             	mov    0x4(%eax),%eax
     ab1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     ab4:	77 4d                	ja     b03 <malloc+0xaa>
      if(p->s.size == nunits)
     ab6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ab9:	8b 40 04             	mov    0x4(%eax),%eax
     abc:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     abf:	75 0c                	jne    acd <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
     ac1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ac4:	8b 10                	mov    (%eax),%edx
     ac6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ac9:	89 10                	mov    %edx,(%eax)
     acb:	eb 26                	jmp    af3 <malloc+0x9a>
      else {
        p->s.size -= nunits;
     acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad0:	8b 40 04             	mov    0x4(%eax),%eax
     ad3:	2b 45 ec             	sub    -0x14(%ebp),%eax
     ad6:	89 c2                	mov    %eax,%edx
     ad8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     adb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     ade:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ae1:	8b 40 04             	mov    0x4(%eax),%eax
     ae4:	c1 e0 03             	shl    $0x3,%eax
     ae7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aed:	8b 55 ec             	mov    -0x14(%ebp),%edx
     af0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     af3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af6:	a3 28 16 00 00       	mov    %eax,0x1628
      return (void*)(p + 1);
     afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     afe:	83 c0 08             	add    $0x8,%eax
     b01:	eb 3b                	jmp    b3e <malloc+0xe5>
    }
    if(p == freep)
     b03:	a1 28 16 00 00       	mov    0x1628,%eax
     b08:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     b0b:	75 1e                	jne    b2b <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
     b0d:	83 ec 0c             	sub    $0xc,%esp
     b10:	ff 75 ec             	pushl  -0x14(%ebp)
     b13:	e8 dd fe ff ff       	call   9f5 <morecore>
     b18:	83 c4 10             	add    $0x10,%esp
     b1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
     b1e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b22:	75 07                	jne    b2b <malloc+0xd2>
        return 0;
     b24:	b8 00 00 00 00       	mov    $0x0,%eax
     b29:	eb 13                	jmp    b3e <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     b31:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b34:	8b 00                	mov    (%eax),%eax
     b36:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     b39:	e9 6d ff ff ff       	jmp    aab <malloc+0x52>
  }
}
     b3e:	c9                   	leave  
     b3f:	c3                   	ret    

00000b40 <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
     b40:	f3 0f 1e fb          	endbr32 
     b44:	55                   	push   %ebp
     b45:	89 e5                	mov    %esp,%ebp
     b47:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     b4a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     b51:	a1 80 16 00 00       	mov    0x1680,%eax
     b56:	83 ec 04             	sub    $0x4,%esp
     b59:	50                   	push   %eax
     b5a:	6a 20                	push   $0x20
     b5c:	68 60 16 00 00       	push   $0x1660
     b61:	e8 11 f8 ff ff       	call   377 <fgets>
     b66:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     b69:	83 ec 0c             	sub    $0xc,%esp
     b6c:	68 60 16 00 00       	push   $0x1660
     b71:	e8 0e f7 ff ff       	call   284 <strlen>
     b76:	83 c4 10             	add    $0x10,%esp
     b79:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     b7c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b7f:	83 e8 01             	sub    $0x1,%eax
     b82:	0f b6 80 60 16 00 00 	movzbl 0x1660(%eax),%eax
     b89:	3c 0a                	cmp    $0xa,%al
     b8b:	74 11                	je     b9e <get_id+0x5e>
     b8d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b90:	83 e8 01             	sub    $0x1,%eax
     b93:	0f b6 80 60 16 00 00 	movzbl 0x1660(%eax),%eax
     b9a:	3c 0d                	cmp    $0xd,%al
     b9c:	75 0d                	jne    bab <get_id+0x6b>
        current_line[len - 1] = 0;
     b9e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ba1:	83 e8 01             	sub    $0x1,%eax
     ba4:	c6 80 60 16 00 00 00 	movb   $0x0,0x1660(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     bab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     bb2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     bb9:	eb 6c                	jmp    c27 <get_id+0xe7>
        if(current_line[i] == ' '){
     bbb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     bbe:	05 60 16 00 00       	add    $0x1660,%eax
     bc3:	0f b6 00             	movzbl (%eax),%eax
     bc6:	3c 20                	cmp    $0x20,%al
     bc8:	75 30                	jne    bfa <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     bca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bce:	75 16                	jne    be6 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     bd0:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     bd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bd6:	8d 50 01             	lea    0x1(%eax),%edx
     bd9:	89 55 f0             	mov    %edx,-0x10(%ebp)
     bdc:	8d 91 60 16 00 00    	lea    0x1660(%ecx),%edx
     be2:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     be6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     be9:	05 60 16 00 00       	add    $0x1660,%eax
     bee:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     bf1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     bf8:	eb 29                	jmp    c23 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     bfa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bfe:	75 23                	jne    c23 <get_id+0xe3>
     c00:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     c04:	7f 1d                	jg     c23 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     c06:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     c0d:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     c10:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c13:	8d 50 01             	lea    0x1(%eax),%edx
     c16:	89 55 f0             	mov    %edx,-0x10(%ebp)
     c19:	8d 91 60 16 00 00    	lea    0x1660(%ecx),%edx
     c1f:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     c23:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     c27:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c2a:	05 60 16 00 00       	add    $0x1660,%eax
     c2f:	0f b6 00             	movzbl (%eax),%eax
     c32:	84 c0                	test   %al,%al
     c34:	75 85                	jne    bbb <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     c36:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     c3a:	75 07                	jne    c43 <get_id+0x103>
        return -1;
     c3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c41:	eb 35                	jmp    c78 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
     c43:	8b 45 dc             	mov    -0x24(%ebp),%eax
     c46:	a3 40 16 00 00       	mov    %eax,0x1640
    current_id.uid_user = atoi(tokens[1]);
     c4b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c4e:	83 ec 0c             	sub    $0xc,%esp
     c51:	50                   	push   %eax
     c52:	e8 e5 f7 ff ff       	call   43c <atoi>
     c57:	83 c4 10             	add    $0x10,%esp
     c5a:	a3 44 16 00 00       	mov    %eax,0x1644
    current_id.gid_user = atoi(tokens[2]);
     c5f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c62:	83 ec 0c             	sub    $0xc,%esp
     c65:	50                   	push   %eax
     c66:	e8 d1 f7 ff ff       	call   43c <atoi>
     c6b:	83 c4 10             	add    $0x10,%esp
     c6e:	a3 48 16 00 00       	mov    %eax,0x1648

    return 0;
     c73:	b8 00 00 00 00       	mov    $0x0,%eax
}
     c78:	c9                   	leave  
     c79:	c3                   	ret    

00000c7a <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
     c7a:	f3 0f 1e fb          	endbr32 
     c7e:	55                   	push   %ebp
     c7f:	89 e5                	mov    %esp,%ebp
     c81:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     c84:	a1 80 16 00 00       	mov    0x1680,%eax
     c89:	85 c0                	test   %eax,%eax
     c8b:	75 31                	jne    cbe <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
     c8d:	83 ec 08             	sub    $0x8,%esp
     c90:	6a 00                	push   $0x0
     c92:	68 37 11 00 00       	push   $0x1137
     c97:	e8 51 f9 ff ff       	call   5ed <open>
     c9c:	83 c4 10             	add    $0x10,%esp
     c9f:	a3 80 16 00 00       	mov    %eax,0x1680

        if(dir < 0){        // kalau gagal membuka file
     ca4:	a1 80 16 00 00       	mov    0x1680,%eax
     ca9:	85 c0                	test   %eax,%eax
     cab:	79 11                	jns    cbe <getid+0x44>
            dir = 0;
     cad:	c7 05 80 16 00 00 00 	movl   $0x0,0x1680
     cb4:	00 00 00 
            return 0;
     cb7:	b8 00 00 00 00       	mov    $0x0,%eax
     cbc:	eb 16                	jmp    cd4 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
     cbe:	e8 7d fe ff ff       	call   b40 <get_id>
     cc3:	83 f8 ff             	cmp    $0xffffffff,%eax
     cc6:	75 07                	jne    ccf <getid+0x55>
        return 0;
     cc8:	b8 00 00 00 00       	mov    $0x0,%eax
     ccd:	eb 05                	jmp    cd4 <getid+0x5a>
    
    return &current_id;
     ccf:	b8 40 16 00 00       	mov    $0x1640,%eax
}
     cd4:	c9                   	leave  
     cd5:	c3                   	ret    

00000cd6 <setid>:

// open file_ids
void setid(void){
     cd6:	f3 0f 1e fb          	endbr32 
     cda:	55                   	push   %ebp
     cdb:	89 e5                	mov    %esp,%ebp
     cdd:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     ce0:	a1 80 16 00 00       	mov    0x1680,%eax
     ce5:	85 c0                	test   %eax,%eax
     ce7:	74 1b                	je     d04 <setid+0x2e>
        close(dir);
     ce9:	a1 80 16 00 00       	mov    0x1680,%eax
     cee:	83 ec 0c             	sub    $0xc,%esp
     cf1:	50                   	push   %eax
     cf2:	e8 de f8 ff ff       	call   5d5 <close>
     cf7:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     cfa:	c7 05 80 16 00 00 00 	movl   $0x0,0x1680
     d01:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
     d04:	83 ec 08             	sub    $0x8,%esp
     d07:	6a 00                	push   $0x0
     d09:	68 37 11 00 00       	push   $0x1137
     d0e:	e8 da f8 ff ff       	call   5ed <open>
     d13:	83 c4 10             	add    $0x10,%esp
     d16:	a3 80 16 00 00       	mov    %eax,0x1680

    if (dir < 0)
     d1b:	a1 80 16 00 00       	mov    0x1680,%eax
     d20:	85 c0                	test   %eax,%eax
     d22:	79 0a                	jns    d2e <setid+0x58>
        dir = 0;
     d24:	c7 05 80 16 00 00 00 	movl   $0x0,0x1680
     d2b:	00 00 00 
}
     d2e:	90                   	nop
     d2f:	c9                   	leave  
     d30:	c3                   	ret    

00000d31 <endid>:

// tutup file_ids
void endid (void){
     d31:	f3 0f 1e fb          	endbr32 
     d35:	55                   	push   %ebp
     d36:	89 e5                	mov    %esp,%ebp
     d38:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     d3b:	a1 80 16 00 00       	mov    0x1680,%eax
     d40:	85 c0                	test   %eax,%eax
     d42:	74 1b                	je     d5f <endid+0x2e>
        close(dir);
     d44:	a1 80 16 00 00       	mov    0x1680,%eax
     d49:	83 ec 0c             	sub    $0xc,%esp
     d4c:	50                   	push   %eax
     d4d:	e8 83 f8 ff ff       	call   5d5 <close>
     d52:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     d55:	c7 05 80 16 00 00 00 	movl   $0x0,0x1680
     d5c:	00 00 00 
    }
}
     d5f:	90                   	nop
     d60:	c9                   	leave  
     d61:	c3                   	ret    

00000d62 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
     d62:	f3 0f 1e fb          	endbr32 
     d66:	55                   	push   %ebp
     d67:	89 e5                	mov    %esp,%ebp
     d69:	83 ec 08             	sub    $0x8,%esp
    setid();
     d6c:	e8 65 ff ff ff       	call   cd6 <setid>

    while (getid()){
     d71:	eb 24                	jmp    d97 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
     d73:	a1 40 16 00 00       	mov    0x1640,%eax
     d78:	83 ec 08             	sub    $0x8,%esp
     d7b:	50                   	push   %eax
     d7c:	ff 75 08             	pushl  0x8(%ebp)
     d7f:	e8 bd f4 ff ff       	call   241 <strcmp>
     d84:	83 c4 10             	add    $0x10,%esp
     d87:	85 c0                	test   %eax,%eax
     d89:	75 0c                	jne    d97 <cek_nama+0x35>
            endid();
     d8b:	e8 a1 ff ff ff       	call   d31 <endid>
            return &current_id;
     d90:	b8 40 16 00 00       	mov    $0x1640,%eax
     d95:	eb 13                	jmp    daa <cek_nama+0x48>
    while (getid()){
     d97:	e8 de fe ff ff       	call   c7a <getid>
     d9c:	85 c0                	test   %eax,%eax
     d9e:	75 d3                	jne    d73 <cek_nama+0x11>
        }
    }
    endid();
     da0:	e8 8c ff ff ff       	call   d31 <endid>
    return 0;
     da5:	b8 00 00 00 00       	mov    $0x0,%eax
}
     daa:	c9                   	leave  
     dab:	c3                   	ret    

00000dac <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
     dac:	f3 0f 1e fb          	endbr32 
     db0:	55                   	push   %ebp
     db1:	89 e5                	mov    %esp,%ebp
     db3:	83 ec 08             	sub    $0x8,%esp
    setid();
     db6:	e8 1b ff ff ff       	call   cd6 <setid>

    while (getid()){
     dbb:	eb 16                	jmp    dd3 <cek_uid+0x27>
        if(current_id.uid_user == uid){
     dbd:	a1 44 16 00 00       	mov    0x1644,%eax
     dc2:	39 45 08             	cmp    %eax,0x8(%ebp)
     dc5:	75 0c                	jne    dd3 <cek_uid+0x27>
            endid();
     dc7:	e8 65 ff ff ff       	call   d31 <endid>
            return &current_id;
     dcc:	b8 40 16 00 00       	mov    $0x1640,%eax
     dd1:	eb 13                	jmp    de6 <cek_uid+0x3a>
    while (getid()){
     dd3:	e8 a2 fe ff ff       	call   c7a <getid>
     dd8:	85 c0                	test   %eax,%eax
     dda:	75 e1                	jne    dbd <cek_uid+0x11>
        }
    }
    endid();
     ddc:	e8 50 ff ff ff       	call   d31 <endid>
    return 0;
     de1:	b8 00 00 00 00       	mov    $0x0,%eax
}
     de6:	c9                   	leave  
     de7:	c3                   	ret    

00000de8 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
     de8:	f3 0f 1e fb          	endbr32 
     dec:	55                   	push   %ebp
     ded:	89 e5                	mov    %esp,%ebp
     def:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     df2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     df9:	a1 80 16 00 00       	mov    0x1680,%eax
     dfe:	83 ec 04             	sub    $0x4,%esp
     e01:	50                   	push   %eax
     e02:	6a 20                	push   $0x20
     e04:	68 60 16 00 00       	push   $0x1660
     e09:	e8 69 f5 ff ff       	call   377 <fgets>
     e0e:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     e11:	83 ec 0c             	sub    $0xc,%esp
     e14:	68 60 16 00 00       	push   $0x1660
     e19:	e8 66 f4 ff ff       	call   284 <strlen>
     e1e:	83 c4 10             	add    $0x10,%esp
     e21:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     e24:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e27:	83 e8 01             	sub    $0x1,%eax
     e2a:	0f b6 80 60 16 00 00 	movzbl 0x1660(%eax),%eax
     e31:	3c 0a                	cmp    $0xa,%al
     e33:	74 11                	je     e46 <get_group+0x5e>
     e35:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e38:	83 e8 01             	sub    $0x1,%eax
     e3b:	0f b6 80 60 16 00 00 	movzbl 0x1660(%eax),%eax
     e42:	3c 0d                	cmp    $0xd,%al
     e44:	75 0d                	jne    e53 <get_group+0x6b>
        current_line[len - 1] = 0;
     e46:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e49:	83 e8 01             	sub    $0x1,%eax
     e4c:	c6 80 60 16 00 00 00 	movb   $0x0,0x1660(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     e53:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     e5a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     e61:	eb 6c                	jmp    ecf <get_group+0xe7>
        if(current_line[i] == ' '){
     e63:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e66:	05 60 16 00 00       	add    $0x1660,%eax
     e6b:	0f b6 00             	movzbl (%eax),%eax
     e6e:	3c 20                	cmp    $0x20,%al
     e70:	75 30                	jne    ea2 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     e72:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e76:	75 16                	jne    e8e <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     e78:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     e7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e7e:	8d 50 01             	lea    0x1(%eax),%edx
     e81:	89 55 f0             	mov    %edx,-0x10(%ebp)
     e84:	8d 91 60 16 00 00    	lea    0x1660(%ecx),%edx
     e8a:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     e8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e91:	05 60 16 00 00       	add    $0x1660,%eax
     e96:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     e99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ea0:	eb 29                	jmp    ecb <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     ea2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ea6:	75 23                	jne    ecb <get_group+0xe3>
     ea8:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     eac:	7f 1d                	jg     ecb <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     eae:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     eb5:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     eb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ebb:	8d 50 01             	lea    0x1(%eax),%edx
     ebe:	89 55 f0             	mov    %edx,-0x10(%ebp)
     ec1:	8d 91 60 16 00 00    	lea    0x1660(%ecx),%edx
     ec7:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     ecb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     ecf:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ed2:	05 60 16 00 00       	add    $0x1660,%eax
     ed7:	0f b6 00             	movzbl (%eax),%eax
     eda:	84 c0                	test   %al,%al
     edc:	75 85                	jne    e63 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     ede:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ee2:	75 07                	jne    eeb <get_group+0x103>
        return -1;
     ee4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     ee9:	eb 21                	jmp    f0c <get_group+0x124>
    
    current_group.nama_group = tokens[0];
     eeb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     eee:	a3 4c 16 00 00       	mov    %eax,0x164c
    current_group.gid = atoi(tokens[1]);
     ef3:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ef6:	83 ec 0c             	sub    $0xc,%esp
     ef9:	50                   	push   %eax
     efa:	e8 3d f5 ff ff       	call   43c <atoi>
     eff:	83 c4 10             	add    $0x10,%esp
     f02:	a3 50 16 00 00       	mov    %eax,0x1650

    return 0;
     f07:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f0c:	c9                   	leave  
     f0d:	c3                   	ret    

00000f0e <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
     f0e:	f3 0f 1e fb          	endbr32 
     f12:	55                   	push   %ebp
     f13:	89 e5                	mov    %esp,%ebp
     f15:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     f18:	a1 80 16 00 00       	mov    0x1680,%eax
     f1d:	85 c0                	test   %eax,%eax
     f1f:	75 31                	jne    f52 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
     f21:	83 ec 08             	sub    $0x8,%esp
     f24:	6a 00                	push   $0x0
     f26:	68 3f 11 00 00       	push   $0x113f
     f2b:	e8 bd f6 ff ff       	call   5ed <open>
     f30:	83 c4 10             	add    $0x10,%esp
     f33:	a3 80 16 00 00       	mov    %eax,0x1680

        if(dir < 0){        // kalau gagal membuka file
     f38:	a1 80 16 00 00       	mov    0x1680,%eax
     f3d:	85 c0                	test   %eax,%eax
     f3f:	79 11                	jns    f52 <getgroup+0x44>
            dir = 0;
     f41:	c7 05 80 16 00 00 00 	movl   $0x0,0x1680
     f48:	00 00 00 
            return 0;
     f4b:	b8 00 00 00 00       	mov    $0x0,%eax
     f50:	eb 16                	jmp    f68 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
     f52:	e8 91 fe ff ff       	call   de8 <get_group>
     f57:	83 f8 ff             	cmp    $0xffffffff,%eax
     f5a:	75 07                	jne    f63 <getgroup+0x55>
        return 0;
     f5c:	b8 00 00 00 00       	mov    $0x0,%eax
     f61:	eb 05                	jmp    f68 <getgroup+0x5a>
    
    return &current_group;
     f63:	b8 4c 16 00 00       	mov    $0x164c,%eax
}
     f68:	c9                   	leave  
     f69:	c3                   	ret    

00000f6a <setgroup>:

// open file_ids
void setgroup(void){
     f6a:	f3 0f 1e fb          	endbr32 
     f6e:	55                   	push   %ebp
     f6f:	89 e5                	mov    %esp,%ebp
     f71:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     f74:	a1 80 16 00 00       	mov    0x1680,%eax
     f79:	85 c0                	test   %eax,%eax
     f7b:	74 1b                	je     f98 <setgroup+0x2e>
        close(dir);
     f7d:	a1 80 16 00 00       	mov    0x1680,%eax
     f82:	83 ec 0c             	sub    $0xc,%esp
     f85:	50                   	push   %eax
     f86:	e8 4a f6 ff ff       	call   5d5 <close>
     f8b:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     f8e:	c7 05 80 16 00 00 00 	movl   $0x0,0x1680
     f95:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
     f98:	83 ec 08             	sub    $0x8,%esp
     f9b:	6a 00                	push   $0x0
     f9d:	68 3f 11 00 00       	push   $0x113f
     fa2:	e8 46 f6 ff ff       	call   5ed <open>
     fa7:	83 c4 10             	add    $0x10,%esp
     faa:	a3 80 16 00 00       	mov    %eax,0x1680

    if (dir < 0)
     faf:	a1 80 16 00 00       	mov    0x1680,%eax
     fb4:	85 c0                	test   %eax,%eax
     fb6:	79 0a                	jns    fc2 <setgroup+0x58>
        dir = 0;
     fb8:	c7 05 80 16 00 00 00 	movl   $0x0,0x1680
     fbf:	00 00 00 
}
     fc2:	90                   	nop
     fc3:	c9                   	leave  
     fc4:	c3                   	ret    

00000fc5 <endgroup>:

// tutup file_ids
void endgroup (void){
     fc5:	f3 0f 1e fb          	endbr32 
     fc9:	55                   	push   %ebp
     fca:	89 e5                	mov    %esp,%ebp
     fcc:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     fcf:	a1 80 16 00 00       	mov    0x1680,%eax
     fd4:	85 c0                	test   %eax,%eax
     fd6:	74 1b                	je     ff3 <endgroup+0x2e>
        close(dir);
     fd8:	a1 80 16 00 00       	mov    0x1680,%eax
     fdd:	83 ec 0c             	sub    $0xc,%esp
     fe0:	50                   	push   %eax
     fe1:	e8 ef f5 ff ff       	call   5d5 <close>
     fe6:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     fe9:	c7 05 80 16 00 00 00 	movl   $0x0,0x1680
     ff0:	00 00 00 
    }
}
     ff3:	90                   	nop
     ff4:	c9                   	leave  
     ff5:	c3                   	ret    

00000ff6 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
     ff6:	f3 0f 1e fb          	endbr32 
     ffa:	55                   	push   %ebp
     ffb:	89 e5                	mov    %esp,%ebp
     ffd:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    1000:	e8 65 ff ff ff       	call   f6a <setgroup>

    while (getgroup()){
    1005:	eb 3c                	jmp    1043 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
    1007:	a1 4c 16 00 00       	mov    0x164c,%eax
    100c:	83 ec 08             	sub    $0x8,%esp
    100f:	50                   	push   %eax
    1010:	ff 75 08             	pushl  0x8(%ebp)
    1013:	e8 29 f2 ff ff       	call   241 <strcmp>
    1018:	83 c4 10             	add    $0x10,%esp
    101b:	85 c0                	test   %eax,%eax
    101d:	75 24                	jne    1043 <cek_nama_group+0x4d>
            endgroup();
    101f:	e8 a1 ff ff ff       	call   fc5 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
    1024:	a1 4c 16 00 00       	mov    0x164c,%eax
    1029:	83 ec 04             	sub    $0x4,%esp
    102c:	50                   	push   %eax
    102d:	68 4a 11 00 00       	push   $0x114a
    1032:	6a 01                	push   $0x1
    1034:	e8 40 f7 ff ff       	call   779 <printf>
    1039:	83 c4 10             	add    $0x10,%esp
            return &current_group;
    103c:	b8 4c 16 00 00       	mov    $0x164c,%eax
    1041:	eb 13                	jmp    1056 <cek_nama_group+0x60>
    while (getgroup()){
    1043:	e8 c6 fe ff ff       	call   f0e <getgroup>
    1048:	85 c0                	test   %eax,%eax
    104a:	75 bb                	jne    1007 <cek_nama_group+0x11>
        }
    }
    endgroup();
    104c:	e8 74 ff ff ff       	call   fc5 <endgroup>
    return 0;
    1051:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1056:	c9                   	leave  
    1057:	c3                   	ret    

00001058 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
    1058:	f3 0f 1e fb          	endbr32 
    105c:	55                   	push   %ebp
    105d:	89 e5                	mov    %esp,%ebp
    105f:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    1062:	e8 03 ff ff ff       	call   f6a <setgroup>

    while (getgroup()){
    1067:	eb 16                	jmp    107f <cek_gid+0x27>
        if(current_group.gid == gid){
    1069:	a1 50 16 00 00       	mov    0x1650,%eax
    106e:	39 45 08             	cmp    %eax,0x8(%ebp)
    1071:	75 0c                	jne    107f <cek_gid+0x27>
            endgroup();
    1073:	e8 4d ff ff ff       	call   fc5 <endgroup>
            return &current_group;
    1078:	b8 4c 16 00 00       	mov    $0x164c,%eax
    107d:	eb 13                	jmp    1092 <cek_gid+0x3a>
    while (getgroup()){
    107f:	e8 8a fe ff ff       	call   f0e <getgroup>
    1084:	85 c0                	test   %eax,%eax
    1086:	75 e1                	jne    1069 <cek_gid+0x11>
        }
    }
    endgroup();
    1088:	e8 38 ff ff ff       	call   fc5 <endgroup>
    return 0;
    108d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1092:	c9                   	leave  
    1093:	c3                   	ret    
