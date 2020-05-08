
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <elapsed>:
#include "user.h"
#include "uproc.h"

void
elapsed(uint e)
{
       0:	f3 0f 1e fb          	endbr32 
       4:	55                   	push   %ebp
       5:	89 e5                	mov    %esp,%ebp
       7:	83 ec 28             	sub    $0x28,%esp
    uint elapsed, whole_sec, milisec_ten, milisec_hund, milisec_thou;
    elapsed = e; // find original elapsed time
       a:	8b 45 08             	mov    0x8(%ebp),%eax
       d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    whole_sec = elapsed / 1000; // the the left of the decimal point
      10:	8b 45 f4             	mov    -0xc(%ebp),%eax
      13:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
      18:	f7 e2                	mul    %edx
      1a:	89 d0                	mov    %edx,%eax
      1c:	c1 e8 06             	shr    $0x6,%eax
      1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    // % to shave off leading digit of elapsed for decimal place calcs
    milisec_ten = (elapsed %= 1000) / 100; // divide and round up to nearest int
      22:	8b 4d f4             	mov    -0xc(%ebp),%ecx
      25:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
      2a:	89 c8                	mov    %ecx,%eax
      2c:	f7 e2                	mul    %edx
      2e:	89 d0                	mov    %edx,%eax
      30:	c1 e8 06             	shr    $0x6,%eax
      33:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
      39:	29 c1                	sub    %eax,%ecx
      3b:	89 c8                	mov    %ecx,%eax
      3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      40:	8b 45 f4             	mov    -0xc(%ebp),%eax
      43:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
      48:	f7 e2                	mul    %edx
      4a:	89 d0                	mov    %edx,%eax
      4c:	c1 e8 05             	shr    $0x5,%eax
      4f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    milisec_hund = (elapsed %= 100) / 10; // shave off previously counted int, repeat
      52:	8b 4d f4             	mov    -0xc(%ebp),%ecx
      55:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
      5a:	89 c8                	mov    %ecx,%eax
      5c:	f7 e2                	mul    %edx
      5e:	89 d0                	mov    %edx,%eax
      60:	c1 e8 05             	shr    $0x5,%eax
      63:	6b c0 64             	imul   $0x64,%eax,%eax
      66:	29 c1                	sub    %eax,%ecx
      68:	89 c8                	mov    %ecx,%eax
      6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      70:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
      75:	f7 e2                	mul    %edx
      77:	89 d0                	mov    %edx,%eax
      79:	c1 e8 03             	shr    $0x3,%eax
      7c:	89 45 e8             	mov    %eax,-0x18(%ebp)
    milisec_thou = (elapsed %= 10); // determine thousandth place
      7f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
      82:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
      87:	89 c8                	mov    %ecx,%eax
      89:	f7 e2                	mul    %edx
      8b:	c1 ea 03             	shr    $0x3,%edx
      8e:	89 d0                	mov    %edx,%eax
      90:	c1 e0 02             	shl    $0x2,%eax
      93:	01 d0                	add    %edx,%eax
      95:	01 c0                	add    %eax,%eax
      97:	29 c1                	sub    %eax,%ecx
      99:	89 c8                	mov    %ecx,%eax
      9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
      a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    printf(1, "\t%d.%d%d%d", whole_sec, milisec_ten, milisec_hund, milisec_thou);
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	ff 75 e4             	pushl  -0x1c(%ebp)
      aa:	ff 75 e8             	pushl  -0x18(%ebp)
      ad:	ff 75 ec             	pushl  -0x14(%ebp)
      b0:	ff 75 f0             	pushl  -0x10(%ebp)
      b3:	68 c8 11 00 00       	push   $0x11c8
      b8:	6a 01                	push   $0x1
      ba:	e8 ee 07 00 00       	call   8ad <printf>
      bf:	83 c4 20             	add    $0x20,%esp
}
      c2:	90                   	nop
      c3:	c9                   	leave  
      c4:	c3                   	ret    

000000c5 <main>:

int
main(void)
{
      c5:	f3 0f 1e fb          	endbr32 
      c9:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      cd:	83 e4 f0             	and    $0xfffffff0,%esp
      d0:	ff 71 fc             	pushl  -0x4(%ecx)
      d3:	55                   	push   %ebp
      d4:	89 e5                	mov    %esp,%ebp
      d6:	57                   	push   %edi
      d7:	56                   	push   %esi
      d8:	53                   	push   %ebx
      d9:	51                   	push   %ecx
      da:	83 ec 28             	sub    $0x28,%esp
  int max = 32, active_procs = 0;
      dd:	c7 45 e0 20 00 00 00 	movl   $0x20,-0x20(%ebp)
      e4:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  struct uproc* utable = (struct uproc*) malloc(max * sizeof(struct uproc));
      eb:	8b 55 e0             	mov    -0x20(%ebp),%edx
      ee:	89 d0                	mov    %edx,%eax
      f0:	01 c0                	add    %eax,%eax
      f2:	01 d0                	add    %edx,%eax
      f4:	c1 e0 05             	shl    $0x5,%eax
      f7:	83 ec 0c             	sub    $0xc,%esp
      fa:	50                   	push   %eax
      fb:	e8 8d 0a 00 00       	call   b8d <malloc>
     100:	83 c4 10             	add    $0x10,%esp
     103:	89 45 d8             	mov    %eax,-0x28(%ebp)
  // system call -> sysproc.c -> proc.c -> return
  active_procs = getprocs(max, utable); // populate utable
     106:	8b 45 e0             	mov    -0x20(%ebp),%eax
     109:	83 ec 08             	sub    $0x8,%esp
     10c:	ff 75 d8             	pushl  -0x28(%ebp)
     10f:	50                   	push   %eax
     110:	e8 a4 06 00 00       	call   7b9 <getprocs>
     115:	83 c4 10             	add    $0x10,%esp
     118:	89 45 dc             	mov    %eax,-0x24(%ebp)
  // error from sysproc.c - value not pulled from stack
  if (active_procs == -1) {
     11b:	83 7d dc ff          	cmpl   $0xffffffff,-0x24(%ebp)
     11f:	75 25                	jne    146 <main+0x81>
      printf(1, "Error in active process table creation.\n");
     121:	83 ec 08             	sub    $0x8,%esp
     124:	68 d4 11 00 00       	push   $0x11d4
     129:	6a 01                	push   $0x1
     12b:	e8 7d 07 00 00       	call   8ad <printf>
     130:	83 c4 10             	add    $0x10,%esp
      free(utable);
     133:	83 ec 0c             	sub    $0xc,%esp
     136:	ff 75 d8             	pushl  -0x28(%ebp)
     139:	e8 05 09 00 00       	call   a43 <free>
     13e:	83 c4 10             	add    $0x10,%esp
      exit();
     141:	e8 9b 05 00 00       	call   6e1 <exit>
  }
  // no active processes
  else if (active_procs == 0) {
     146:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     14a:	75 25                	jne    171 <main+0xac>
      printf(1, "No active processes.\n");
     14c:	83 ec 08             	sub    $0x8,%esp
     14f:	68 fd 11 00 00       	push   $0x11fd
     154:	6a 01                	push   $0x1
     156:	e8 52 07 00 00       	call   8ad <printf>
     15b:	83 c4 10             	add    $0x10,%esp
      free(utable);
     15e:	83 ec 0c             	sub    $0xc,%esp
     161:	ff 75 d8             	pushl  -0x28(%ebp)
     164:	e8 da 08 00 00       	call   a43 <free>
     169:	83 c4 10             	add    $0x10,%esp
      exit();
     16c:	e8 70 05 00 00       	call   6e1 <exit>
          printf(1, "\t%s\t%d", utable[i].state, utable[i].size);
      }
      printf(1, "\n");
  }
#else
  else if (active_procs > 0) {
     171:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     175:	0f 8e 8d 01 00 00    	jle    308 <main+0x243>
      printf(1, "\n%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s",
     17b:	68 13 12 00 00       	push   $0x1213
     180:	68 18 12 00 00       	push   $0x1218
     185:	68 1e 12 00 00       	push   $0x121e
     18a:	68 22 12 00 00       	push   $0x1222
     18f:	68 2a 12 00 00       	push   $0x122a
     194:	68 2f 12 00 00       	push   $0x122f
     199:	68 34 12 00 00       	push   $0x1234
     19e:	68 38 12 00 00       	push   $0x1238
     1a3:	68 3c 12 00 00       	push   $0x123c
     1a8:	68 41 12 00 00       	push   $0x1241
     1ad:	68 48 12 00 00       	push   $0x1248
     1b2:	6a 01                	push   $0x1
     1b4:	e8 f4 06 00 00       	call   8ad <printf>
     1b9:	83 c4 30             	add    $0x30,%esp
              "PID", "Name", "UID", "GID", "PPID", "Prio", "Elapsed", "CPU", "State", "Size");
      for (int i = 0; i < active_procs; ++i) {
     1bc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
     1c3:	e9 22 01 00 00       	jmp    2ea <main+0x225>
          printf(1, "\n%d\t%s\t%d\t%d\t%d\t%d",
                  utable[i].pid, utable[i].name, utable[i].uid, utable[i].gid, utable[i].ppid, utable[i].priority);
     1c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     1cb:	89 d0                	mov    %edx,%eax
     1cd:	01 c0                	add    %eax,%eax
     1cf:	01 d0                	add    %edx,%eax
     1d1:	c1 e0 05             	shl    $0x5,%eax
     1d4:	89 c2                	mov    %eax,%edx
     1d6:	8b 45 d8             	mov    -0x28(%ebp),%eax
     1d9:	01 d0                	add    %edx,%eax
          printf(1, "\n%d\t%s\t%d\t%d\t%d\t%d",
     1db:	8b 78 5c             	mov    0x5c(%eax),%edi
                  utable[i].pid, utable[i].name, utable[i].uid, utable[i].gid, utable[i].ppid, utable[i].priority);
     1de:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     1e1:	89 d0                	mov    %edx,%eax
     1e3:	01 c0                	add    %eax,%eax
     1e5:	01 d0                	add    %edx,%eax
     1e7:	c1 e0 05             	shl    $0x5,%eax
     1ea:	89 c2                	mov    %eax,%edx
     1ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
     1ef:	01 d0                	add    %edx,%eax
          printf(1, "\n%d\t%s\t%d\t%d\t%d\t%d",
     1f1:	8b 70 0c             	mov    0xc(%eax),%esi
                  utable[i].pid, utable[i].name, utable[i].uid, utable[i].gid, utable[i].ppid, utable[i].priority);
     1f4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     1f7:	89 d0                	mov    %edx,%eax
     1f9:	01 c0                	add    %eax,%eax
     1fb:	01 d0                	add    %edx,%eax
     1fd:	c1 e0 05             	shl    $0x5,%eax
     200:	89 c2                	mov    %eax,%edx
     202:	8b 45 d8             	mov    -0x28(%ebp),%eax
     205:	01 d0                	add    %edx,%eax
          printf(1, "\n%d\t%s\t%d\t%d\t%d\t%d",
     207:	8b 58 08             	mov    0x8(%eax),%ebx
                  utable[i].pid, utable[i].name, utable[i].uid, utable[i].gid, utable[i].ppid, utable[i].priority);
     20a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     20d:	89 d0                	mov    %edx,%eax
     20f:	01 c0                	add    %eax,%eax
     211:	01 d0                	add    %edx,%eax
     213:	c1 e0 05             	shl    $0x5,%eax
     216:	89 c2                	mov    %eax,%edx
     218:	8b 45 d8             	mov    -0x28(%ebp),%eax
     21b:	01 d0                	add    %edx,%eax
          printf(1, "\n%d\t%s\t%d\t%d\t%d\t%d",
     21d:	8b 48 04             	mov    0x4(%eax),%ecx
                  utable[i].pid, utable[i].name, utable[i].uid, utable[i].gid, utable[i].ppid, utable[i].priority);
     220:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     223:	89 d0                	mov    %edx,%eax
     225:	01 c0                	add    %eax,%eax
     227:	01 d0                	add    %edx,%eax
     229:	c1 e0 05             	shl    $0x5,%eax
     22c:	89 c2                	mov    %eax,%edx
     22e:	8b 45 d8             	mov    -0x28(%ebp),%eax
     231:	01 d0                	add    %edx,%eax
     233:	83 c0 3c             	add    $0x3c,%eax
     236:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     239:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     23c:	89 d0                	mov    %edx,%eax
     23e:	01 c0                	add    %eax,%eax
     240:	01 d0                	add    %edx,%eax
     242:	c1 e0 05             	shl    $0x5,%eax
     245:	89 c2                	mov    %eax,%edx
     247:	8b 45 d8             	mov    -0x28(%ebp),%eax
     24a:	01 d0                	add    %edx,%eax
          printf(1, "\n%d\t%s\t%d\t%d\t%d\t%d",
     24c:	8b 00                	mov    (%eax),%eax
     24e:	57                   	push   %edi
     24f:	56                   	push   %esi
     250:	53                   	push   %ebx
     251:	51                   	push   %ecx
     252:	ff 75 d4             	pushl  -0x2c(%ebp)
     255:	50                   	push   %eax
     256:	68 67 12 00 00       	push   $0x1267
     25b:	6a 01                	push   $0x1
     25d:	e8 4b 06 00 00       	call   8ad <printf>
     262:	83 c4 20             	add    $0x20,%esp
          elapsed(utable[i].elapsed_ticks);
     265:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     268:	89 d0                	mov    %edx,%eax
     26a:	01 c0                	add    %eax,%eax
     26c:	01 d0                	add    %edx,%eax
     26e:	c1 e0 05             	shl    $0x5,%eax
     271:	89 c2                	mov    %eax,%edx
     273:	8b 45 d8             	mov    -0x28(%ebp),%eax
     276:	01 d0                	add    %edx,%eax
     278:	8b 40 10             	mov    0x10(%eax),%eax
     27b:	83 ec 0c             	sub    $0xc,%esp
     27e:	50                   	push   %eax
     27f:	e8 7c fd ff ff       	call   0 <elapsed>
     284:	83 c4 10             	add    $0x10,%esp
          elapsed(utable[i].CPU_total_ticks);
     287:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     28a:	89 d0                	mov    %edx,%eax
     28c:	01 c0                	add    %eax,%eax
     28e:	01 d0                	add    %edx,%eax
     290:	c1 e0 05             	shl    $0x5,%eax
     293:	89 c2                	mov    %eax,%edx
     295:	8b 45 d8             	mov    -0x28(%ebp),%eax
     298:	01 d0                	add    %edx,%eax
     29a:	8b 40 14             	mov    0x14(%eax),%eax
     29d:	83 ec 0c             	sub    $0xc,%esp
     2a0:	50                   	push   %eax
     2a1:	e8 5a fd ff ff       	call   0 <elapsed>
     2a6:	83 c4 10             	add    $0x10,%esp
          printf(1, "\t%s\t%d", utable[i].state, utable[i].size);
     2a9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     2ac:	89 d0                	mov    %edx,%eax
     2ae:	01 c0                	add    %eax,%eax
     2b0:	01 d0                	add    %edx,%eax
     2b2:	c1 e0 05             	shl    $0x5,%eax
     2b5:	89 c2                	mov    %eax,%edx
     2b7:	8b 45 d8             	mov    -0x28(%ebp),%eax
     2ba:	01 d0                	add    %edx,%eax
     2bc:	8b 48 38             	mov    0x38(%eax),%ecx
     2bf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     2c2:	89 d0                	mov    %edx,%eax
     2c4:	01 c0                	add    %eax,%eax
     2c6:	01 d0                	add    %edx,%eax
     2c8:	c1 e0 05             	shl    $0x5,%eax
     2cb:	89 c2                	mov    %eax,%edx
     2cd:	8b 45 d8             	mov    -0x28(%ebp),%eax
     2d0:	01 d0                	add    %edx,%eax
     2d2:	83 c0 18             	add    $0x18,%eax
     2d5:	51                   	push   %ecx
     2d6:	50                   	push   %eax
     2d7:	68 7a 12 00 00       	push   $0x127a
     2dc:	6a 01                	push   $0x1
     2de:	e8 ca 05 00 00       	call   8ad <printf>
     2e3:	83 c4 10             	add    $0x10,%esp
      for (int i = 0; i < active_procs; ++i) {
     2e6:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     2ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     2ed:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     2f0:	0f 8c d2 fe ff ff    	jl     1c8 <main+0x103>
      }
      printf(1, "\n");
     2f6:	83 ec 08             	sub    $0x8,%esp
     2f9:	68 81 12 00 00       	push   $0x1281
     2fe:	6a 01                	push   $0x1
     300:	e8 a8 05 00 00       	call   8ad <printf>
     305:	83 c4 10             	add    $0x10,%esp
  }
#endif
  free(utable);
     308:	83 ec 0c             	sub    $0xc,%esp
     30b:	ff 75 d8             	pushl  -0x28(%ebp)
     30e:	e8 30 07 00 00       	call   a43 <free>
     313:	83 c4 10             	add    $0x10,%esp
  exit();
     316:	e8 c6 03 00 00       	call   6e1 <exit>

0000031b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     31b:	55                   	push   %ebp
     31c:	89 e5                	mov    %esp,%ebp
     31e:	57                   	push   %edi
     31f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     320:	8b 4d 08             	mov    0x8(%ebp),%ecx
     323:	8b 55 10             	mov    0x10(%ebp),%edx
     326:	8b 45 0c             	mov    0xc(%ebp),%eax
     329:	89 cb                	mov    %ecx,%ebx
     32b:	89 df                	mov    %ebx,%edi
     32d:	89 d1                	mov    %edx,%ecx
     32f:	fc                   	cld    
     330:	f3 aa                	rep stos %al,%es:(%edi)
     332:	89 ca                	mov    %ecx,%edx
     334:	89 fb                	mov    %edi,%ebx
     336:	89 5d 08             	mov    %ebx,0x8(%ebp)
     339:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     33c:	90                   	nop
     33d:	5b                   	pop    %ebx
     33e:	5f                   	pop    %edi
     33f:	5d                   	pop    %ebp
     340:	c3                   	ret    

00000341 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     341:	f3 0f 1e fb          	endbr32 
     345:	55                   	push   %ebp
     346:	89 e5                	mov    %esp,%ebp
     348:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     34b:	8b 45 08             	mov    0x8(%ebp),%eax
     34e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     351:	90                   	nop
     352:	8b 55 0c             	mov    0xc(%ebp),%edx
     355:	8d 42 01             	lea    0x1(%edx),%eax
     358:	89 45 0c             	mov    %eax,0xc(%ebp)
     35b:	8b 45 08             	mov    0x8(%ebp),%eax
     35e:	8d 48 01             	lea    0x1(%eax),%ecx
     361:	89 4d 08             	mov    %ecx,0x8(%ebp)
     364:	0f b6 12             	movzbl (%edx),%edx
     367:	88 10                	mov    %dl,(%eax)
     369:	0f b6 00             	movzbl (%eax),%eax
     36c:	84 c0                	test   %al,%al
     36e:	75 e2                	jne    352 <strcpy+0x11>
    ;
  return os;
     370:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     373:	c9                   	leave  
     374:	c3                   	ret    

00000375 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     375:	f3 0f 1e fb          	endbr32 
     379:	55                   	push   %ebp
     37a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     37c:	eb 08                	jmp    386 <strcmp+0x11>
    p++, q++;
     37e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     382:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     386:	8b 45 08             	mov    0x8(%ebp),%eax
     389:	0f b6 00             	movzbl (%eax),%eax
     38c:	84 c0                	test   %al,%al
     38e:	74 10                	je     3a0 <strcmp+0x2b>
     390:	8b 45 08             	mov    0x8(%ebp),%eax
     393:	0f b6 10             	movzbl (%eax),%edx
     396:	8b 45 0c             	mov    0xc(%ebp),%eax
     399:	0f b6 00             	movzbl (%eax),%eax
     39c:	38 c2                	cmp    %al,%dl
     39e:	74 de                	je     37e <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
     3a0:	8b 45 08             	mov    0x8(%ebp),%eax
     3a3:	0f b6 00             	movzbl (%eax),%eax
     3a6:	0f b6 d0             	movzbl %al,%edx
     3a9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ac:	0f b6 00             	movzbl (%eax),%eax
     3af:	0f b6 c0             	movzbl %al,%eax
     3b2:	29 c2                	sub    %eax,%edx
     3b4:	89 d0                	mov    %edx,%eax
}
     3b6:	5d                   	pop    %ebp
     3b7:	c3                   	ret    

000003b8 <strlen>:

uint
strlen(char *s)
{
     3b8:	f3 0f 1e fb          	endbr32 
     3bc:	55                   	push   %ebp
     3bd:	89 e5                	mov    %esp,%ebp
     3bf:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     3c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     3c9:	eb 04                	jmp    3cf <strlen+0x17>
     3cb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     3cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3d2:	8b 45 08             	mov    0x8(%ebp),%eax
     3d5:	01 d0                	add    %edx,%eax
     3d7:	0f b6 00             	movzbl (%eax),%eax
     3da:	84 c0                	test   %al,%al
     3dc:	75 ed                	jne    3cb <strlen+0x13>
    ;
  return n;
     3de:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3e1:	c9                   	leave  
     3e2:	c3                   	ret    

000003e3 <memset>:

void*
memset(void *dst, int c, uint n)
{
     3e3:	f3 0f 1e fb          	endbr32 
     3e7:	55                   	push   %ebp
     3e8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     3ea:	8b 45 10             	mov    0x10(%ebp),%eax
     3ed:	50                   	push   %eax
     3ee:	ff 75 0c             	pushl  0xc(%ebp)
     3f1:	ff 75 08             	pushl  0x8(%ebp)
     3f4:	e8 22 ff ff ff       	call   31b <stosb>
     3f9:	83 c4 0c             	add    $0xc,%esp
  return dst;
     3fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
     3ff:	c9                   	leave  
     400:	c3                   	ret    

00000401 <strchr>:

char*
strchr(const char *s, char c)
{
     401:	f3 0f 1e fb          	endbr32 
     405:	55                   	push   %ebp
     406:	89 e5                	mov    %esp,%ebp
     408:	83 ec 04             	sub    $0x4,%esp
     40b:	8b 45 0c             	mov    0xc(%ebp),%eax
     40e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     411:	eb 14                	jmp    427 <strchr+0x26>
    if(*s == c)
     413:	8b 45 08             	mov    0x8(%ebp),%eax
     416:	0f b6 00             	movzbl (%eax),%eax
     419:	38 45 fc             	cmp    %al,-0x4(%ebp)
     41c:	75 05                	jne    423 <strchr+0x22>
      return (char*)s;
     41e:	8b 45 08             	mov    0x8(%ebp),%eax
     421:	eb 13                	jmp    436 <strchr+0x35>
  for(; *s; s++)
     423:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     427:	8b 45 08             	mov    0x8(%ebp),%eax
     42a:	0f b6 00             	movzbl (%eax),%eax
     42d:	84 c0                	test   %al,%al
     42f:	75 e2                	jne    413 <strchr+0x12>
  return 0;
     431:	b8 00 00 00 00       	mov    $0x0,%eax
}
     436:	c9                   	leave  
     437:	c3                   	ret    

00000438 <gets>:

char*
gets(char *buf, int max)
{
     438:	f3 0f 1e fb          	endbr32 
     43c:	55                   	push   %ebp
     43d:	89 e5                	mov    %esp,%ebp
     43f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     442:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     449:	eb 42                	jmp    48d <gets+0x55>
    cc = read(0, &c, 1);
     44b:	83 ec 04             	sub    $0x4,%esp
     44e:	6a 01                	push   $0x1
     450:	8d 45 ef             	lea    -0x11(%ebp),%eax
     453:	50                   	push   %eax
     454:	6a 00                	push   $0x0
     456:	e8 9e 02 00 00       	call   6f9 <read>
     45b:	83 c4 10             	add    $0x10,%esp
     45e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     461:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     465:	7e 33                	jle    49a <gets+0x62>
      break;
    buf[i++] = c;
     467:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46a:	8d 50 01             	lea    0x1(%eax),%edx
     46d:	89 55 f4             	mov    %edx,-0xc(%ebp)
     470:	89 c2                	mov    %eax,%edx
     472:	8b 45 08             	mov    0x8(%ebp),%eax
     475:	01 c2                	add    %eax,%edx
     477:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     47b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     47d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     481:	3c 0a                	cmp    $0xa,%al
     483:	74 16                	je     49b <gets+0x63>
     485:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     489:	3c 0d                	cmp    $0xd,%al
     48b:	74 0e                	je     49b <gets+0x63>
  for(i=0; i+1 < max; ){
     48d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     490:	83 c0 01             	add    $0x1,%eax
     493:	39 45 0c             	cmp    %eax,0xc(%ebp)
     496:	7f b3                	jg     44b <gets+0x13>
     498:	eb 01                	jmp    49b <gets+0x63>
      break;
     49a:	90                   	nop
      break;
  }
  buf[i] = '\0';
     49b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     49e:	8b 45 08             	mov    0x8(%ebp),%eax
     4a1:	01 d0                	add    %edx,%eax
     4a3:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     4a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     4a9:	c9                   	leave  
     4aa:	c3                   	ret    

000004ab <fgets>:

char*
fgets(char* buf, int size, int fd)
{
     4ab:	f3 0f 1e fb          	endbr32 
     4af:	55                   	push   %ebp
     4b0:	89 e5                	mov    %esp,%ebp
     4b2:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
     4b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4bc:	eb 43                	jmp    501 <fgets+0x56>
    int cc = read(fd, &c, 1);
     4be:	83 ec 04             	sub    $0x4,%esp
     4c1:	6a 01                	push   $0x1
     4c3:	8d 45 ef             	lea    -0x11(%ebp),%eax
     4c6:	50                   	push   %eax
     4c7:	ff 75 10             	pushl  0x10(%ebp)
     4ca:	e8 2a 02 00 00       	call   6f9 <read>
     4cf:	83 c4 10             	add    $0x10,%esp
     4d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     4d5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4d9:	7e 33                	jle    50e <fgets+0x63>
      break;
    buf[i++] = c;
     4db:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4de:	8d 50 01             	lea    0x1(%eax),%edx
     4e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4e4:	89 c2                	mov    %eax,%edx
     4e6:	8b 45 08             	mov    0x8(%ebp),%eax
     4e9:	01 c2                	add    %eax,%edx
     4eb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4ef:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     4f1:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4f5:	3c 0a                	cmp    $0xa,%al
     4f7:	74 16                	je     50f <fgets+0x64>
     4f9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     4fd:	3c 0d                	cmp    $0xd,%al
     4ff:	74 0e                	je     50f <fgets+0x64>
  for(i = 0; i + 1 < size;){
     501:	8b 45 f4             	mov    -0xc(%ebp),%eax
     504:	83 c0 01             	add    $0x1,%eax
     507:	39 45 0c             	cmp    %eax,0xc(%ebp)
     50a:	7f b2                	jg     4be <fgets+0x13>
     50c:	eb 01                	jmp    50f <fgets+0x64>
      break;
     50e:	90                   	nop
      break;
  }
  buf[i] = '\0';
     50f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     512:	8b 45 08             	mov    0x8(%ebp),%eax
     515:	01 d0                	add    %edx,%eax
     517:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     51a:	8b 45 08             	mov    0x8(%ebp),%eax
}
     51d:	c9                   	leave  
     51e:	c3                   	ret    

0000051f <stat>:

int
stat(char *n, struct stat *st)
{
     51f:	f3 0f 1e fb          	endbr32 
     523:	55                   	push   %ebp
     524:	89 e5                	mov    %esp,%ebp
     526:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     529:	83 ec 08             	sub    $0x8,%esp
     52c:	6a 00                	push   $0x0
     52e:	ff 75 08             	pushl  0x8(%ebp)
     531:	e8 eb 01 00 00       	call   721 <open>
     536:	83 c4 10             	add    $0x10,%esp
     539:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     53c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     540:	79 07                	jns    549 <stat+0x2a>
    return -1;
     542:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     547:	eb 25                	jmp    56e <stat+0x4f>
  r = fstat(fd, st);
     549:	83 ec 08             	sub    $0x8,%esp
     54c:	ff 75 0c             	pushl  0xc(%ebp)
     54f:	ff 75 f4             	pushl  -0xc(%ebp)
     552:	e8 e2 01 00 00       	call   739 <fstat>
     557:	83 c4 10             	add    $0x10,%esp
     55a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     55d:	83 ec 0c             	sub    $0xc,%esp
     560:	ff 75 f4             	pushl  -0xc(%ebp)
     563:	e8 a1 01 00 00       	call   709 <close>
     568:	83 c4 10             	add    $0x10,%esp
  return r;
     56b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     56e:	c9                   	leave  
     56f:	c3                   	ret    

00000570 <atoi>:

int
atoi(const char *s)
{
     570:	f3 0f 1e fb          	endbr32 
     574:	55                   	push   %ebp
     575:	89 e5                	mov    %esp,%ebp
     577:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     57a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     581:	eb 04                	jmp    587 <atoi+0x17>
     583:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     587:	8b 45 08             	mov    0x8(%ebp),%eax
     58a:	0f b6 00             	movzbl (%eax),%eax
     58d:	3c 20                	cmp    $0x20,%al
     58f:	74 f2                	je     583 <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
     591:	8b 45 08             	mov    0x8(%ebp),%eax
     594:	0f b6 00             	movzbl (%eax),%eax
     597:	3c 2d                	cmp    $0x2d,%al
     599:	75 07                	jne    5a2 <atoi+0x32>
     59b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     5a0:	eb 05                	jmp    5a7 <atoi+0x37>
     5a2:	b8 01 00 00 00       	mov    $0x1,%eax
     5a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     5aa:	8b 45 08             	mov    0x8(%ebp),%eax
     5ad:	0f b6 00             	movzbl (%eax),%eax
     5b0:	3c 2b                	cmp    $0x2b,%al
     5b2:	74 0a                	je     5be <atoi+0x4e>
     5b4:	8b 45 08             	mov    0x8(%ebp),%eax
     5b7:	0f b6 00             	movzbl (%eax),%eax
     5ba:	3c 2d                	cmp    $0x2d,%al
     5bc:	75 2b                	jne    5e9 <atoi+0x79>
    s++;
     5be:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     5c2:	eb 25                	jmp    5e9 <atoi+0x79>
    n = n*10 + *s++ - '0';
     5c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
     5c7:	89 d0                	mov    %edx,%eax
     5c9:	c1 e0 02             	shl    $0x2,%eax
     5cc:	01 d0                	add    %edx,%eax
     5ce:	01 c0                	add    %eax,%eax
     5d0:	89 c1                	mov    %eax,%ecx
     5d2:	8b 45 08             	mov    0x8(%ebp),%eax
     5d5:	8d 50 01             	lea    0x1(%eax),%edx
     5d8:	89 55 08             	mov    %edx,0x8(%ebp)
     5db:	0f b6 00             	movzbl (%eax),%eax
     5de:	0f be c0             	movsbl %al,%eax
     5e1:	01 c8                	add    %ecx,%eax
     5e3:	83 e8 30             	sub    $0x30,%eax
     5e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     5e9:	8b 45 08             	mov    0x8(%ebp),%eax
     5ec:	0f b6 00             	movzbl (%eax),%eax
     5ef:	3c 2f                	cmp    $0x2f,%al
     5f1:	7e 0a                	jle    5fd <atoi+0x8d>
     5f3:	8b 45 08             	mov    0x8(%ebp),%eax
     5f6:	0f b6 00             	movzbl (%eax),%eax
     5f9:	3c 39                	cmp    $0x39,%al
     5fb:	7e c7                	jle    5c4 <atoi+0x54>
  return sign*n;
     5fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     600:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     604:	c9                   	leave  
     605:	c3                   	ret    

00000606 <atoo>:

int
atoo(const char *s)
{
     606:	f3 0f 1e fb          	endbr32 
     60a:	55                   	push   %ebp
     60b:	89 e5                	mov    %esp,%ebp
     60d:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     610:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     617:	eb 04                	jmp    61d <atoo+0x17>
     619:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     61d:	8b 45 08             	mov    0x8(%ebp),%eax
     620:	0f b6 00             	movzbl (%eax),%eax
     623:	3c 20                	cmp    $0x20,%al
     625:	74 f2                	je     619 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
     627:	8b 45 08             	mov    0x8(%ebp),%eax
     62a:	0f b6 00             	movzbl (%eax),%eax
     62d:	3c 2d                	cmp    $0x2d,%al
     62f:	75 07                	jne    638 <atoo+0x32>
     631:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     636:	eb 05                	jmp    63d <atoo+0x37>
     638:	b8 01 00 00 00       	mov    $0x1,%eax
     63d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     640:	8b 45 08             	mov    0x8(%ebp),%eax
     643:	0f b6 00             	movzbl (%eax),%eax
     646:	3c 2b                	cmp    $0x2b,%al
     648:	74 0a                	je     654 <atoo+0x4e>
     64a:	8b 45 08             	mov    0x8(%ebp),%eax
     64d:	0f b6 00             	movzbl (%eax),%eax
     650:	3c 2d                	cmp    $0x2d,%al
     652:	75 27                	jne    67b <atoo+0x75>
    s++;
     654:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     658:	eb 21                	jmp    67b <atoo+0x75>
    n = n*8 + *s++ - '0';
     65a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65d:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     664:	8b 45 08             	mov    0x8(%ebp),%eax
     667:	8d 50 01             	lea    0x1(%eax),%edx
     66a:	89 55 08             	mov    %edx,0x8(%ebp)
     66d:	0f b6 00             	movzbl (%eax),%eax
     670:	0f be c0             	movsbl %al,%eax
     673:	01 c8                	add    %ecx,%eax
     675:	83 e8 30             	sub    $0x30,%eax
     678:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
     67b:	8b 45 08             	mov    0x8(%ebp),%eax
     67e:	0f b6 00             	movzbl (%eax),%eax
     681:	3c 2f                	cmp    $0x2f,%al
     683:	7e 0a                	jle    68f <atoo+0x89>
     685:	8b 45 08             	mov    0x8(%ebp),%eax
     688:	0f b6 00             	movzbl (%eax),%eax
     68b:	3c 37                	cmp    $0x37,%al
     68d:	7e cb                	jle    65a <atoo+0x54>
  return sign*n;
     68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     692:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     696:	c9                   	leave  
     697:	c3                   	ret    

00000698 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     698:	f3 0f 1e fb          	endbr32 
     69c:	55                   	push   %ebp
     69d:	89 e5                	mov    %esp,%ebp
     69f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     6a2:	8b 45 08             	mov    0x8(%ebp),%eax
     6a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     6a8:	8b 45 0c             	mov    0xc(%ebp),%eax
     6ab:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     6ae:	eb 17                	jmp    6c7 <memmove+0x2f>
    *dst++ = *src++;
     6b0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6b3:	8d 42 01             	lea    0x1(%edx),%eax
     6b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
     6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6bc:	8d 48 01             	lea    0x1(%eax),%ecx
     6bf:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     6c2:	0f b6 12             	movzbl (%edx),%edx
     6c5:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     6c7:	8b 45 10             	mov    0x10(%ebp),%eax
     6ca:	8d 50 ff             	lea    -0x1(%eax),%edx
     6cd:	89 55 10             	mov    %edx,0x10(%ebp)
     6d0:	85 c0                	test   %eax,%eax
     6d2:	7f dc                	jg     6b0 <memmove+0x18>
  return vdst;
     6d4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     6d7:	c9                   	leave  
     6d8:	c3                   	ret    

000006d9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     6d9:	b8 01 00 00 00       	mov    $0x1,%eax
     6de:	cd 40                	int    $0x40
     6e0:	c3                   	ret    

000006e1 <exit>:
SYSCALL(exit)
     6e1:	b8 02 00 00 00       	mov    $0x2,%eax
     6e6:	cd 40                	int    $0x40
     6e8:	c3                   	ret    

000006e9 <wait>:
SYSCALL(wait)
     6e9:	b8 03 00 00 00       	mov    $0x3,%eax
     6ee:	cd 40                	int    $0x40
     6f0:	c3                   	ret    

000006f1 <pipe>:
SYSCALL(pipe)
     6f1:	b8 04 00 00 00       	mov    $0x4,%eax
     6f6:	cd 40                	int    $0x40
     6f8:	c3                   	ret    

000006f9 <read>:
SYSCALL(read)
     6f9:	b8 05 00 00 00       	mov    $0x5,%eax
     6fe:	cd 40                	int    $0x40
     700:	c3                   	ret    

00000701 <write>:
SYSCALL(write)
     701:	b8 10 00 00 00       	mov    $0x10,%eax
     706:	cd 40                	int    $0x40
     708:	c3                   	ret    

00000709 <close>:
SYSCALL(close)
     709:	b8 15 00 00 00       	mov    $0x15,%eax
     70e:	cd 40                	int    $0x40
     710:	c3                   	ret    

00000711 <kill>:
SYSCALL(kill)
     711:	b8 06 00 00 00       	mov    $0x6,%eax
     716:	cd 40                	int    $0x40
     718:	c3                   	ret    

00000719 <exec>:
SYSCALL(exec)
     719:	b8 07 00 00 00       	mov    $0x7,%eax
     71e:	cd 40                	int    $0x40
     720:	c3                   	ret    

00000721 <open>:
SYSCALL(open)
     721:	b8 0f 00 00 00       	mov    $0xf,%eax
     726:	cd 40                	int    $0x40
     728:	c3                   	ret    

00000729 <mknod>:
SYSCALL(mknod)
     729:	b8 11 00 00 00       	mov    $0x11,%eax
     72e:	cd 40                	int    $0x40
     730:	c3                   	ret    

00000731 <unlink>:
SYSCALL(unlink)
     731:	b8 12 00 00 00       	mov    $0x12,%eax
     736:	cd 40                	int    $0x40
     738:	c3                   	ret    

00000739 <fstat>:
SYSCALL(fstat)
     739:	b8 08 00 00 00       	mov    $0x8,%eax
     73e:	cd 40                	int    $0x40
     740:	c3                   	ret    

00000741 <link>:
SYSCALL(link)
     741:	b8 13 00 00 00       	mov    $0x13,%eax
     746:	cd 40                	int    $0x40
     748:	c3                   	ret    

00000749 <mkdir>:
SYSCALL(mkdir)
     749:	b8 14 00 00 00       	mov    $0x14,%eax
     74e:	cd 40                	int    $0x40
     750:	c3                   	ret    

00000751 <chdir>:
SYSCALL(chdir)
     751:	b8 09 00 00 00       	mov    $0x9,%eax
     756:	cd 40                	int    $0x40
     758:	c3                   	ret    

00000759 <dup>:
SYSCALL(dup)
     759:	b8 0a 00 00 00       	mov    $0xa,%eax
     75e:	cd 40                	int    $0x40
     760:	c3                   	ret    

00000761 <getpid>:
SYSCALL(getpid)
     761:	b8 0b 00 00 00       	mov    $0xb,%eax
     766:	cd 40                	int    $0x40
     768:	c3                   	ret    

00000769 <sbrk>:
SYSCALL(sbrk)
     769:	b8 0c 00 00 00       	mov    $0xc,%eax
     76e:	cd 40                	int    $0x40
     770:	c3                   	ret    

00000771 <sleep>:
SYSCALL(sleep)
     771:	b8 0d 00 00 00       	mov    $0xd,%eax
     776:	cd 40                	int    $0x40
     778:	c3                   	ret    

00000779 <uptime>:
SYSCALL(uptime)
     779:	b8 0e 00 00 00       	mov    $0xe,%eax
     77e:	cd 40                	int    $0x40
     780:	c3                   	ret    

00000781 <halt>:
SYSCALL(halt)
     781:	b8 16 00 00 00       	mov    $0x16,%eax
     786:	cd 40                	int    $0x40
     788:	c3                   	ret    

00000789 <date>:
SYSCALL(date)
     789:	b8 17 00 00 00       	mov    $0x17,%eax
     78e:	cd 40                	int    $0x40
     790:	c3                   	ret    

00000791 <getuid>:
SYSCALL(getuid)
     791:	b8 18 00 00 00       	mov    $0x18,%eax
     796:	cd 40                	int    $0x40
     798:	c3                   	ret    

00000799 <getgid>:
SYSCALL(getgid)
     799:	b8 19 00 00 00       	mov    $0x19,%eax
     79e:	cd 40                	int    $0x40
     7a0:	c3                   	ret    

000007a1 <getppid>:
SYSCALL(getppid)
     7a1:	b8 1a 00 00 00       	mov    $0x1a,%eax
     7a6:	cd 40                	int    $0x40
     7a8:	c3                   	ret    

000007a9 <setuid>:
SYSCALL(setuid)
     7a9:	b8 1b 00 00 00       	mov    $0x1b,%eax
     7ae:	cd 40                	int    $0x40
     7b0:	c3                   	ret    

000007b1 <setgid>:
SYSCALL(setgid)
     7b1:	b8 1c 00 00 00       	mov    $0x1c,%eax
     7b6:	cd 40                	int    $0x40
     7b8:	c3                   	ret    

000007b9 <getprocs>:
SYSCALL(getprocs)
     7b9:	b8 1d 00 00 00       	mov    $0x1d,%eax
     7be:	cd 40                	int    $0x40
     7c0:	c3                   	ret    

000007c1 <setpriority>:
SYSCALL(setpriority)
     7c1:	b8 1e 00 00 00       	mov    $0x1e,%eax
     7c6:	cd 40                	int    $0x40
     7c8:	c3                   	ret    

000007c9 <chown>:
SYSCALL(chown)
     7c9:	b8 1f 00 00 00       	mov    $0x1f,%eax
     7ce:	cd 40                	int    $0x40
     7d0:	c3                   	ret    

000007d1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     7d1:	f3 0f 1e fb          	endbr32 
     7d5:	55                   	push   %ebp
     7d6:	89 e5                	mov    %esp,%ebp
     7d8:	83 ec 18             	sub    $0x18,%esp
     7db:	8b 45 0c             	mov    0xc(%ebp),%eax
     7de:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     7e1:	83 ec 04             	sub    $0x4,%esp
     7e4:	6a 01                	push   $0x1
     7e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
     7e9:	50                   	push   %eax
     7ea:	ff 75 08             	pushl  0x8(%ebp)
     7ed:	e8 0f ff ff ff       	call   701 <write>
     7f2:	83 c4 10             	add    $0x10,%esp
}
     7f5:	90                   	nop
     7f6:	c9                   	leave  
     7f7:	c3                   	ret    

000007f8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     7f8:	f3 0f 1e fb          	endbr32 
     7fc:	55                   	push   %ebp
     7fd:	89 e5                	mov    %esp,%ebp
     7ff:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     802:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     809:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     80d:	74 17                	je     826 <printint+0x2e>
     80f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     813:	79 11                	jns    826 <printint+0x2e>
    neg = 1;
     815:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     81c:	8b 45 0c             	mov    0xc(%ebp),%eax
     81f:	f7 d8                	neg    %eax
     821:	89 45 ec             	mov    %eax,-0x14(%ebp)
     824:	eb 06                	jmp    82c <printint+0x34>
  } else {
    x = xx;
     826:	8b 45 0c             	mov    0xc(%ebp),%eax
     829:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     82c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     833:	8b 4d 10             	mov    0x10(%ebp),%ecx
     836:	8b 45 ec             	mov    -0x14(%ebp),%eax
     839:	ba 00 00 00 00       	mov    $0x0,%edx
     83e:	f7 f1                	div    %ecx
     840:	89 d1                	mov    %edx,%ecx
     842:	8b 45 f4             	mov    -0xc(%ebp),%eax
     845:	8d 50 01             	lea    0x1(%eax),%edx
     848:	89 55 f4             	mov    %edx,-0xc(%ebp)
     84b:	0f b6 91 e0 16 00 00 	movzbl 0x16e0(%ecx),%edx
     852:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     856:	8b 4d 10             	mov    0x10(%ebp),%ecx
     859:	8b 45 ec             	mov    -0x14(%ebp),%eax
     85c:	ba 00 00 00 00       	mov    $0x0,%edx
     861:	f7 f1                	div    %ecx
     863:	89 45 ec             	mov    %eax,-0x14(%ebp)
     866:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     86a:	75 c7                	jne    833 <printint+0x3b>
  if(neg)
     86c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     870:	74 2d                	je     89f <printint+0xa7>
    buf[i++] = '-';
     872:	8b 45 f4             	mov    -0xc(%ebp),%eax
     875:	8d 50 01             	lea    0x1(%eax),%edx
     878:	89 55 f4             	mov    %edx,-0xc(%ebp)
     87b:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     880:	eb 1d                	jmp    89f <printint+0xa7>
    putc(fd, buf[i]);
     882:	8d 55 dc             	lea    -0x24(%ebp),%edx
     885:	8b 45 f4             	mov    -0xc(%ebp),%eax
     888:	01 d0                	add    %edx,%eax
     88a:	0f b6 00             	movzbl (%eax),%eax
     88d:	0f be c0             	movsbl %al,%eax
     890:	83 ec 08             	sub    $0x8,%esp
     893:	50                   	push   %eax
     894:	ff 75 08             	pushl  0x8(%ebp)
     897:	e8 35 ff ff ff       	call   7d1 <putc>
     89c:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     89f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     8a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8a7:	79 d9                	jns    882 <printint+0x8a>
}
     8a9:	90                   	nop
     8aa:	90                   	nop
     8ab:	c9                   	leave  
     8ac:	c3                   	ret    

000008ad <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     8ad:	f3 0f 1e fb          	endbr32 
     8b1:	55                   	push   %ebp
     8b2:	89 e5                	mov    %esp,%ebp
     8b4:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     8b7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     8be:	8d 45 0c             	lea    0xc(%ebp),%eax
     8c1:	83 c0 04             	add    $0x4,%eax
     8c4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     8c7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     8ce:	e9 59 01 00 00       	jmp    a2c <printf+0x17f>
    c = fmt[i] & 0xff;
     8d3:	8b 55 0c             	mov    0xc(%ebp),%edx
     8d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8d9:	01 d0                	add    %edx,%eax
     8db:	0f b6 00             	movzbl (%eax),%eax
     8de:	0f be c0             	movsbl %al,%eax
     8e1:	25 ff 00 00 00       	and    $0xff,%eax
     8e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     8e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8ed:	75 2c                	jne    91b <printf+0x6e>
      if(c == '%'){
     8ef:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     8f3:	75 0c                	jne    901 <printf+0x54>
        state = '%';
     8f5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     8fc:	e9 27 01 00 00       	jmp    a28 <printf+0x17b>
      } else {
        putc(fd, c);
     901:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     904:	0f be c0             	movsbl %al,%eax
     907:	83 ec 08             	sub    $0x8,%esp
     90a:	50                   	push   %eax
     90b:	ff 75 08             	pushl  0x8(%ebp)
     90e:	e8 be fe ff ff       	call   7d1 <putc>
     913:	83 c4 10             	add    $0x10,%esp
     916:	e9 0d 01 00 00       	jmp    a28 <printf+0x17b>
      }
    } else if(state == '%'){
     91b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     91f:	0f 85 03 01 00 00    	jne    a28 <printf+0x17b>
      if(c == 'd'){
     925:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     929:	75 1e                	jne    949 <printf+0x9c>
        printint(fd, *ap, 10, 1);
     92b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     92e:	8b 00                	mov    (%eax),%eax
     930:	6a 01                	push   $0x1
     932:	6a 0a                	push   $0xa
     934:	50                   	push   %eax
     935:	ff 75 08             	pushl  0x8(%ebp)
     938:	e8 bb fe ff ff       	call   7f8 <printint>
     93d:	83 c4 10             	add    $0x10,%esp
        ap++;
     940:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     944:	e9 d8 00 00 00       	jmp    a21 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
     949:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     94d:	74 06                	je     955 <printf+0xa8>
     94f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     953:	75 1e                	jne    973 <printf+0xc6>
        printint(fd, *ap, 16, 0);
     955:	8b 45 e8             	mov    -0x18(%ebp),%eax
     958:	8b 00                	mov    (%eax),%eax
     95a:	6a 00                	push   $0x0
     95c:	6a 10                	push   $0x10
     95e:	50                   	push   %eax
     95f:	ff 75 08             	pushl  0x8(%ebp)
     962:	e8 91 fe ff ff       	call   7f8 <printint>
     967:	83 c4 10             	add    $0x10,%esp
        ap++;
     96a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     96e:	e9 ae 00 00 00       	jmp    a21 <printf+0x174>
      } else if(c == 's'){
     973:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     977:	75 43                	jne    9bc <printf+0x10f>
        s = (char*)*ap;
     979:	8b 45 e8             	mov    -0x18(%ebp),%eax
     97c:	8b 00                	mov    (%eax),%eax
     97e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     981:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     985:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     989:	75 25                	jne    9b0 <printf+0x103>
          s = "(null)";
     98b:	c7 45 f4 83 12 00 00 	movl   $0x1283,-0xc(%ebp)
        while(*s != 0){
     992:	eb 1c                	jmp    9b0 <printf+0x103>
          putc(fd, *s);
     994:	8b 45 f4             	mov    -0xc(%ebp),%eax
     997:	0f b6 00             	movzbl (%eax),%eax
     99a:	0f be c0             	movsbl %al,%eax
     99d:	83 ec 08             	sub    $0x8,%esp
     9a0:	50                   	push   %eax
     9a1:	ff 75 08             	pushl  0x8(%ebp)
     9a4:	e8 28 fe ff ff       	call   7d1 <putc>
     9a9:	83 c4 10             	add    $0x10,%esp
          s++;
     9ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     9b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9b3:	0f b6 00             	movzbl (%eax),%eax
     9b6:	84 c0                	test   %al,%al
     9b8:	75 da                	jne    994 <printf+0xe7>
     9ba:	eb 65                	jmp    a21 <printf+0x174>
        }
      } else if(c == 'c'){
     9bc:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     9c0:	75 1d                	jne    9df <printf+0x132>
        putc(fd, *ap);
     9c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     9c5:	8b 00                	mov    (%eax),%eax
     9c7:	0f be c0             	movsbl %al,%eax
     9ca:	83 ec 08             	sub    $0x8,%esp
     9cd:	50                   	push   %eax
     9ce:	ff 75 08             	pushl  0x8(%ebp)
     9d1:	e8 fb fd ff ff       	call   7d1 <putc>
     9d6:	83 c4 10             	add    $0x10,%esp
        ap++;
     9d9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     9dd:	eb 42                	jmp    a21 <printf+0x174>
      } else if(c == '%'){
     9df:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     9e3:	75 17                	jne    9fc <printf+0x14f>
        putc(fd, c);
     9e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     9e8:	0f be c0             	movsbl %al,%eax
     9eb:	83 ec 08             	sub    $0x8,%esp
     9ee:	50                   	push   %eax
     9ef:	ff 75 08             	pushl  0x8(%ebp)
     9f2:	e8 da fd ff ff       	call   7d1 <putc>
     9f7:	83 c4 10             	add    $0x10,%esp
     9fa:	eb 25                	jmp    a21 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     9fc:	83 ec 08             	sub    $0x8,%esp
     9ff:	6a 25                	push   $0x25
     a01:	ff 75 08             	pushl  0x8(%ebp)
     a04:	e8 c8 fd ff ff       	call   7d1 <putc>
     a09:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     a0c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a0f:	0f be c0             	movsbl %al,%eax
     a12:	83 ec 08             	sub    $0x8,%esp
     a15:	50                   	push   %eax
     a16:	ff 75 08             	pushl  0x8(%ebp)
     a19:	e8 b3 fd ff ff       	call   7d1 <putc>
     a1e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     a21:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     a28:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     a2c:	8b 55 0c             	mov    0xc(%ebp),%edx
     a2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a32:	01 d0                	add    %edx,%eax
     a34:	0f b6 00             	movzbl (%eax),%eax
     a37:	84 c0                	test   %al,%al
     a39:	0f 85 94 fe ff ff    	jne    8d3 <printf+0x26>
    }
  }
}
     a3f:	90                   	nop
     a40:	90                   	nop
     a41:	c9                   	leave  
     a42:	c3                   	ret    

00000a43 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     a43:	f3 0f 1e fb          	endbr32 
     a47:	55                   	push   %ebp
     a48:	89 e5                	mov    %esp,%ebp
     a4a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     a4d:	8b 45 08             	mov    0x8(%ebp),%eax
     a50:	83 e8 08             	sub    $0x8,%eax
     a53:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     a56:	a1 08 17 00 00       	mov    0x1708,%eax
     a5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     a5e:	eb 24                	jmp    a84 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     a60:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a63:	8b 00                	mov    (%eax),%eax
     a65:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     a68:	72 12                	jb     a7c <free+0x39>
     a6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a6d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     a70:	77 24                	ja     a96 <free+0x53>
     a72:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a75:	8b 00                	mov    (%eax),%eax
     a77:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     a7a:	72 1a                	jb     a96 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     a7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a7f:	8b 00                	mov    (%eax),%eax
     a81:	89 45 fc             	mov    %eax,-0x4(%ebp)
     a84:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a87:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     a8a:	76 d4                	jbe    a60 <free+0x1d>
     a8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     a8f:	8b 00                	mov    (%eax),%eax
     a91:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     a94:	73 ca                	jae    a60 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
     a96:	8b 45 f8             	mov    -0x8(%ebp),%eax
     a99:	8b 40 04             	mov    0x4(%eax),%eax
     a9c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     aa3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     aa6:	01 c2                	add    %eax,%edx
     aa8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aab:	8b 00                	mov    (%eax),%eax
     aad:	39 c2                	cmp    %eax,%edx
     aaf:	75 24                	jne    ad5 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
     ab1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ab4:	8b 50 04             	mov    0x4(%eax),%edx
     ab7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aba:	8b 00                	mov    (%eax),%eax
     abc:	8b 40 04             	mov    0x4(%eax),%eax
     abf:	01 c2                	add    %eax,%edx
     ac1:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ac4:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     ac7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aca:	8b 00                	mov    (%eax),%eax
     acc:	8b 10                	mov    (%eax),%edx
     ace:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ad1:	89 10                	mov    %edx,(%eax)
     ad3:	eb 0a                	jmp    adf <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
     ad5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ad8:	8b 10                	mov    (%eax),%edx
     ada:	8b 45 f8             	mov    -0x8(%ebp),%eax
     add:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     adf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     ae2:	8b 40 04             	mov    0x4(%eax),%eax
     ae5:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     aec:	8b 45 fc             	mov    -0x4(%ebp),%eax
     aef:	01 d0                	add    %edx,%eax
     af1:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     af4:	75 20                	jne    b16 <free+0xd3>
    p->s.size += bp->s.size;
     af6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     af9:	8b 50 04             	mov    0x4(%eax),%edx
     afc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     aff:	8b 40 04             	mov    0x4(%eax),%eax
     b02:	01 c2                	add    %eax,%edx
     b04:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b07:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     b0a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     b0d:	8b 10                	mov    (%eax),%edx
     b0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b12:	89 10                	mov    %edx,(%eax)
     b14:	eb 08                	jmp    b1e <free+0xdb>
  } else
    p->s.ptr = bp;
     b16:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b19:	8b 55 f8             	mov    -0x8(%ebp),%edx
     b1c:	89 10                	mov    %edx,(%eax)
  freep = p;
     b1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     b21:	a3 08 17 00 00       	mov    %eax,0x1708
}
     b26:	90                   	nop
     b27:	c9                   	leave  
     b28:	c3                   	ret    

00000b29 <morecore>:

static Header*
morecore(uint nu)
{
     b29:	f3 0f 1e fb          	endbr32 
     b2d:	55                   	push   %ebp
     b2e:	89 e5                	mov    %esp,%ebp
     b30:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     b33:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     b3a:	77 07                	ja     b43 <morecore+0x1a>
    nu = 4096;
     b3c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     b43:	8b 45 08             	mov    0x8(%ebp),%eax
     b46:	c1 e0 03             	shl    $0x3,%eax
     b49:	83 ec 0c             	sub    $0xc,%esp
     b4c:	50                   	push   %eax
     b4d:	e8 17 fc ff ff       	call   769 <sbrk>
     b52:	83 c4 10             	add    $0x10,%esp
     b55:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     b58:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     b5c:	75 07                	jne    b65 <morecore+0x3c>
    return 0;
     b5e:	b8 00 00 00 00       	mov    $0x0,%eax
     b63:	eb 26                	jmp    b8b <morecore+0x62>
  hp = (Header*)p;
     b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     b6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b6e:	8b 55 08             	mov    0x8(%ebp),%edx
     b71:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     b74:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b77:	83 c0 08             	add    $0x8,%eax
     b7a:	83 ec 0c             	sub    $0xc,%esp
     b7d:	50                   	push   %eax
     b7e:	e8 c0 fe ff ff       	call   a43 <free>
     b83:	83 c4 10             	add    $0x10,%esp
  return freep;
     b86:	a1 08 17 00 00       	mov    0x1708,%eax
}
     b8b:	c9                   	leave  
     b8c:	c3                   	ret    

00000b8d <malloc>:

void*
malloc(uint nbytes)
{
     b8d:	f3 0f 1e fb          	endbr32 
     b91:	55                   	push   %ebp
     b92:	89 e5                	mov    %esp,%ebp
     b94:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     b97:	8b 45 08             	mov    0x8(%ebp),%eax
     b9a:	83 c0 07             	add    $0x7,%eax
     b9d:	c1 e8 03             	shr    $0x3,%eax
     ba0:	83 c0 01             	add    $0x1,%eax
     ba3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     ba6:	a1 08 17 00 00       	mov    0x1708,%eax
     bab:	89 45 f0             	mov    %eax,-0x10(%ebp)
     bae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     bb2:	75 23                	jne    bd7 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
     bb4:	c7 45 f0 00 17 00 00 	movl   $0x1700,-0x10(%ebp)
     bbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bbe:	a3 08 17 00 00       	mov    %eax,0x1708
     bc3:	a1 08 17 00 00       	mov    0x1708,%eax
     bc8:	a3 00 17 00 00       	mov    %eax,0x1700
    base.s.size = 0;
     bcd:	c7 05 04 17 00 00 00 	movl   $0x0,0x1704
     bd4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     bd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bda:	8b 00                	mov    (%eax),%eax
     bdc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be2:	8b 40 04             	mov    0x4(%eax),%eax
     be5:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     be8:	77 4d                	ja     c37 <malloc+0xaa>
      if(p->s.size == nunits)
     bea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bed:	8b 40 04             	mov    0x4(%eax),%eax
     bf0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     bf3:	75 0c                	jne    c01 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
     bf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bf8:	8b 10                	mov    (%eax),%edx
     bfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bfd:	89 10                	mov    %edx,(%eax)
     bff:	eb 26                	jmp    c27 <malloc+0x9a>
      else {
        p->s.size -= nunits;
     c01:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c04:	8b 40 04             	mov    0x4(%eax),%eax
     c07:	2b 45 ec             	sub    -0x14(%ebp),%eax
     c0a:	89 c2                	mov    %eax,%edx
     c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c0f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c15:	8b 40 04             	mov    0x4(%eax),%eax
     c18:	c1 e0 03             	shl    $0x3,%eax
     c1b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     c1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c21:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c24:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     c27:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c2a:	a3 08 17 00 00       	mov    %eax,0x1708
      return (void*)(p + 1);
     c2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c32:	83 c0 08             	add    $0x8,%eax
     c35:	eb 3b                	jmp    c72 <malloc+0xe5>
    }
    if(p == freep)
     c37:	a1 08 17 00 00       	mov    0x1708,%eax
     c3c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     c3f:	75 1e                	jne    c5f <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
     c41:	83 ec 0c             	sub    $0xc,%esp
     c44:	ff 75 ec             	pushl  -0x14(%ebp)
     c47:	e8 dd fe ff ff       	call   b29 <morecore>
     c4c:	83 c4 10             	add    $0x10,%esp
     c4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
     c52:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c56:	75 07                	jne    c5f <malloc+0xd2>
        return 0;
     c58:	b8 00 00 00 00       	mov    $0x0,%eax
     c5d:	eb 13                	jmp    c72 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     c5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c62:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c65:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c68:	8b 00                	mov    (%eax),%eax
     c6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     c6d:	e9 6d ff ff ff       	jmp    bdf <malloc+0x52>
  }
}
     c72:	c9                   	leave  
     c73:	c3                   	ret    

00000c74 <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
     c74:	f3 0f 1e fb          	endbr32 
     c78:	55                   	push   %ebp
     c79:	89 e5                	mov    %esp,%ebp
     c7b:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     c7e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     c85:	a1 60 17 00 00       	mov    0x1760,%eax
     c8a:	83 ec 04             	sub    $0x4,%esp
     c8d:	50                   	push   %eax
     c8e:	6a 20                	push   $0x20
     c90:	68 40 17 00 00       	push   $0x1740
     c95:	e8 11 f8 ff ff       	call   4ab <fgets>
     c9a:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     c9d:	83 ec 0c             	sub    $0xc,%esp
     ca0:	68 40 17 00 00       	push   $0x1740
     ca5:	e8 0e f7 ff ff       	call   3b8 <strlen>
     caa:	83 c4 10             	add    $0x10,%esp
     cad:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     cb0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cb3:	83 e8 01             	sub    $0x1,%eax
     cb6:	0f b6 80 40 17 00 00 	movzbl 0x1740(%eax),%eax
     cbd:	3c 0a                	cmp    $0xa,%al
     cbf:	74 11                	je     cd2 <get_id+0x5e>
     cc1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cc4:	83 e8 01             	sub    $0x1,%eax
     cc7:	0f b6 80 40 17 00 00 	movzbl 0x1740(%eax),%eax
     cce:	3c 0d                	cmp    $0xd,%al
     cd0:	75 0d                	jne    cdf <get_id+0x6b>
        current_line[len - 1] = 0;
     cd2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     cd5:	83 e8 01             	sub    $0x1,%eax
     cd8:	c6 80 40 17 00 00 00 	movb   $0x0,0x1740(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     cdf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     ce6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ced:	eb 6c                	jmp    d5b <get_id+0xe7>
        if(current_line[i] == ' '){
     cef:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cf2:	05 40 17 00 00       	add    $0x1740,%eax
     cf7:	0f b6 00             	movzbl (%eax),%eax
     cfa:	3c 20                	cmp    $0x20,%al
     cfc:	75 30                	jne    d2e <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     cfe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d02:	75 16                	jne    d1a <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     d04:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     d07:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d0a:	8d 50 01             	lea    0x1(%eax),%edx
     d0d:	89 55 f0             	mov    %edx,-0x10(%ebp)
     d10:	8d 91 40 17 00 00    	lea    0x1740(%ecx),%edx
     d16:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     d1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d1d:	05 40 17 00 00       	add    $0x1740,%eax
     d22:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     d25:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d2c:	eb 29                	jmp    d57 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     d2e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     d32:	75 23                	jne    d57 <get_id+0xe3>
     d34:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     d38:	7f 1d                	jg     d57 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     d3a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     d41:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     d44:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d47:	8d 50 01             	lea    0x1(%eax),%edx
     d4a:	89 55 f0             	mov    %edx,-0x10(%ebp)
     d4d:	8d 91 40 17 00 00    	lea    0x1740(%ecx),%edx
     d53:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     d57:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     d5b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d5e:	05 40 17 00 00       	add    $0x1740,%eax
     d63:	0f b6 00             	movzbl (%eax),%eax
     d66:	84 c0                	test   %al,%al
     d68:	75 85                	jne    cef <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
     d6a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     d6e:	75 07                	jne    d77 <get_id+0x103>
        return -1;
     d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     d75:	eb 35                	jmp    dac <get_id+0x138>
    
    current_id.nama_user = tokens[0];
     d77:	8b 45 dc             	mov    -0x24(%ebp),%eax
     d7a:	a3 20 17 00 00       	mov    %eax,0x1720
    current_id.uid_user = atoi(tokens[1]);
     d7f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     d82:	83 ec 0c             	sub    $0xc,%esp
     d85:	50                   	push   %eax
     d86:	e8 e5 f7 ff ff       	call   570 <atoi>
     d8b:	83 c4 10             	add    $0x10,%esp
     d8e:	a3 24 17 00 00       	mov    %eax,0x1724
    current_id.gid_user = atoi(tokens[2]);
     d93:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d96:	83 ec 0c             	sub    $0xc,%esp
     d99:	50                   	push   %eax
     d9a:	e8 d1 f7 ff ff       	call   570 <atoi>
     d9f:	83 c4 10             	add    $0x10,%esp
     da2:	a3 28 17 00 00       	mov    %eax,0x1728

    return 0;
     da7:	b8 00 00 00 00       	mov    $0x0,%eax
}
     dac:	c9                   	leave  
     dad:	c3                   	ret    

00000dae <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
     dae:	f3 0f 1e fb          	endbr32 
     db2:	55                   	push   %ebp
     db3:	89 e5                	mov    %esp,%ebp
     db5:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
     db8:	a1 60 17 00 00       	mov    0x1760,%eax
     dbd:	85 c0                	test   %eax,%eax
     dbf:	75 31                	jne    df2 <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
     dc1:	83 ec 08             	sub    $0x8,%esp
     dc4:	6a 00                	push   $0x0
     dc6:	68 8a 12 00 00       	push   $0x128a
     dcb:	e8 51 f9 ff ff       	call   721 <open>
     dd0:	83 c4 10             	add    $0x10,%esp
     dd3:	a3 60 17 00 00       	mov    %eax,0x1760

        if(dir < 0){        // kalau gagal membuka file
     dd8:	a1 60 17 00 00       	mov    0x1760,%eax
     ddd:	85 c0                	test   %eax,%eax
     ddf:	79 11                	jns    df2 <getid+0x44>
            dir = 0;
     de1:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
     de8:	00 00 00 
            return 0;
     deb:	b8 00 00 00 00       	mov    $0x0,%eax
     df0:	eb 16                	jmp    e08 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
     df2:	e8 7d fe ff ff       	call   c74 <get_id>
     df7:	83 f8 ff             	cmp    $0xffffffff,%eax
     dfa:	75 07                	jne    e03 <getid+0x55>
        return 0;
     dfc:	b8 00 00 00 00       	mov    $0x0,%eax
     e01:	eb 05                	jmp    e08 <getid+0x5a>
    
    return &current_id;
     e03:	b8 20 17 00 00       	mov    $0x1720,%eax
}
     e08:	c9                   	leave  
     e09:	c3                   	ret    

00000e0a <setid>:

// open file_ids
void setid(void){
     e0a:	f3 0f 1e fb          	endbr32 
     e0e:	55                   	push   %ebp
     e0f:	89 e5                	mov    %esp,%ebp
     e11:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     e14:	a1 60 17 00 00       	mov    0x1760,%eax
     e19:	85 c0                	test   %eax,%eax
     e1b:	74 1b                	je     e38 <setid+0x2e>
        close(dir);
     e1d:	a1 60 17 00 00       	mov    0x1760,%eax
     e22:	83 ec 0c             	sub    $0xc,%esp
     e25:	50                   	push   %eax
     e26:	e8 de f8 ff ff       	call   709 <close>
     e2b:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     e2e:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
     e35:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
     e38:	83 ec 08             	sub    $0x8,%esp
     e3b:	6a 00                	push   $0x0
     e3d:	68 8a 12 00 00       	push   $0x128a
     e42:	e8 da f8 ff ff       	call   721 <open>
     e47:	83 c4 10             	add    $0x10,%esp
     e4a:	a3 60 17 00 00       	mov    %eax,0x1760

    if (dir < 0)
     e4f:	a1 60 17 00 00       	mov    0x1760,%eax
     e54:	85 c0                	test   %eax,%eax
     e56:	79 0a                	jns    e62 <setid+0x58>
        dir = 0;
     e58:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
     e5f:	00 00 00 
}
     e62:	90                   	nop
     e63:	c9                   	leave  
     e64:	c3                   	ret    

00000e65 <endid>:

// tutup file_ids
void endid (void){
     e65:	f3 0f 1e fb          	endbr32 
     e69:	55                   	push   %ebp
     e6a:	89 e5                	mov    %esp,%ebp
     e6c:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
     e6f:	a1 60 17 00 00       	mov    0x1760,%eax
     e74:	85 c0                	test   %eax,%eax
     e76:	74 1b                	je     e93 <endid+0x2e>
        close(dir);
     e78:	a1 60 17 00 00       	mov    0x1760,%eax
     e7d:	83 ec 0c             	sub    $0xc,%esp
     e80:	50                   	push   %eax
     e81:	e8 83 f8 ff ff       	call   709 <close>
     e86:	83 c4 10             	add    $0x10,%esp
        dir = 0;
     e89:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
     e90:	00 00 00 
    }
}
     e93:	90                   	nop
     e94:	c9                   	leave  
     e95:	c3                   	ret    

00000e96 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
     e96:	f3 0f 1e fb          	endbr32 
     e9a:	55                   	push   %ebp
     e9b:	89 e5                	mov    %esp,%ebp
     e9d:	83 ec 08             	sub    $0x8,%esp
    setid();
     ea0:	e8 65 ff ff ff       	call   e0a <setid>

    while (getid()){
     ea5:	eb 24                	jmp    ecb <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
     ea7:	a1 20 17 00 00       	mov    0x1720,%eax
     eac:	83 ec 08             	sub    $0x8,%esp
     eaf:	50                   	push   %eax
     eb0:	ff 75 08             	pushl  0x8(%ebp)
     eb3:	e8 bd f4 ff ff       	call   375 <strcmp>
     eb8:	83 c4 10             	add    $0x10,%esp
     ebb:	85 c0                	test   %eax,%eax
     ebd:	75 0c                	jne    ecb <cek_nama+0x35>
            endid();
     ebf:	e8 a1 ff ff ff       	call   e65 <endid>
            return &current_id;
     ec4:	b8 20 17 00 00       	mov    $0x1720,%eax
     ec9:	eb 13                	jmp    ede <cek_nama+0x48>
    while (getid()){
     ecb:	e8 de fe ff ff       	call   dae <getid>
     ed0:	85 c0                	test   %eax,%eax
     ed2:	75 d3                	jne    ea7 <cek_nama+0x11>
        }
    }
    endid();
     ed4:	e8 8c ff ff ff       	call   e65 <endid>
    return 0;
     ed9:	b8 00 00 00 00       	mov    $0x0,%eax
}
     ede:	c9                   	leave  
     edf:	c3                   	ret    

00000ee0 <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
     ee0:	f3 0f 1e fb          	endbr32 
     ee4:	55                   	push   %ebp
     ee5:	89 e5                	mov    %esp,%ebp
     ee7:	83 ec 08             	sub    $0x8,%esp
    setid();
     eea:	e8 1b ff ff ff       	call   e0a <setid>

    while (getid()){
     eef:	eb 16                	jmp    f07 <cek_uid+0x27>
        if(current_id.uid_user == uid){
     ef1:	a1 24 17 00 00       	mov    0x1724,%eax
     ef6:	39 45 08             	cmp    %eax,0x8(%ebp)
     ef9:	75 0c                	jne    f07 <cek_uid+0x27>
            endid();
     efb:	e8 65 ff ff ff       	call   e65 <endid>
            return &current_id;
     f00:	b8 20 17 00 00       	mov    $0x1720,%eax
     f05:	eb 13                	jmp    f1a <cek_uid+0x3a>
    while (getid()){
     f07:	e8 a2 fe ff ff       	call   dae <getid>
     f0c:	85 c0                	test   %eax,%eax
     f0e:	75 e1                	jne    ef1 <cek_uid+0x11>
        }
    }
    endid();
     f10:	e8 50 ff ff ff       	call   e65 <endid>
    return 0;
     f15:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f1a:	c9                   	leave  
     f1b:	c3                   	ret    

00000f1c <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
     f1c:	f3 0f 1e fb          	endbr32 
     f20:	55                   	push   %ebp
     f21:	89 e5                	mov    %esp,%ebp
     f23:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     f26:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     f2d:	a1 60 17 00 00       	mov    0x1760,%eax
     f32:	83 ec 04             	sub    $0x4,%esp
     f35:	50                   	push   %eax
     f36:	6a 20                	push   $0x20
     f38:	68 40 17 00 00       	push   $0x1740
     f3d:	e8 69 f5 ff ff       	call   4ab <fgets>
     f42:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     f45:	83 ec 0c             	sub    $0xc,%esp
     f48:	68 40 17 00 00       	push   $0x1740
     f4d:	e8 66 f4 ff ff       	call   3b8 <strlen>
     f52:	83 c4 10             	add    $0x10,%esp
     f55:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     f58:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f5b:	83 e8 01             	sub    $0x1,%eax
     f5e:	0f b6 80 40 17 00 00 	movzbl 0x1740(%eax),%eax
     f65:	3c 0a                	cmp    $0xa,%al
     f67:	74 11                	je     f7a <get_group+0x5e>
     f69:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f6c:	83 e8 01             	sub    $0x1,%eax
     f6f:	0f b6 80 40 17 00 00 	movzbl 0x1740(%eax),%eax
     f76:	3c 0d                	cmp    $0xd,%al
     f78:	75 0d                	jne    f87 <get_group+0x6b>
        current_line[len - 1] = 0;
     f7a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f7d:	83 e8 01             	sub    $0x1,%eax
     f80:	c6 80 40 17 00 00 00 	movb   $0x0,0x1740(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     f87:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     f8e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f95:	eb 6c                	jmp    1003 <get_group+0xe7>
        if(current_line[i] == ' '){
     f97:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f9a:	05 40 17 00 00       	add    $0x1740,%eax
     f9f:	0f b6 00             	movzbl (%eax),%eax
     fa2:	3c 20                	cmp    $0x20,%al
     fa4:	75 30                	jne    fd6 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
     fa6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     faa:	75 16                	jne    fc2 <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
     fac:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     faf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fb2:	8d 50 01             	lea    0x1(%eax),%edx
     fb5:	89 55 f0             	mov    %edx,-0x10(%ebp)
     fb8:	8d 91 40 17 00 00    	lea    0x1740(%ecx),%edx
     fbe:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
     fc2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fc5:	05 40 17 00 00       	add    $0x1740,%eax
     fca:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
     fcd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     fd4:	eb 29                	jmp    fff <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
     fd6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     fda:	75 23                	jne    fff <get_group+0xe3>
     fdc:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
     fe0:	7f 1d                	jg     fff <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
     fe2:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
     fe9:	8b 4d ec             	mov    -0x14(%ebp),%ecx
     fec:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fef:	8d 50 01             	lea    0x1(%eax),%edx
     ff2:	89 55 f0             	mov    %edx,-0x10(%ebp)
     ff5:	8d 91 40 17 00 00    	lea    0x1740(%ecx),%edx
     ffb:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
     fff:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1003:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1006:	05 40 17 00 00       	add    $0x1740,%eax
    100b:	0f b6 00             	movzbl (%eax),%eax
    100e:	84 c0                	test   %al,%al
    1010:	75 85                	jne    f97 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
    1012:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1016:	75 07                	jne    101f <get_group+0x103>
        return -1;
    1018:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    101d:	eb 21                	jmp    1040 <get_group+0x124>
    
    current_group.nama_group = tokens[0];
    101f:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1022:	a3 2c 17 00 00       	mov    %eax,0x172c
    current_group.gid = atoi(tokens[1]);
    1027:	8b 45 e0             	mov    -0x20(%ebp),%eax
    102a:	83 ec 0c             	sub    $0xc,%esp
    102d:	50                   	push   %eax
    102e:	e8 3d f5 ff ff       	call   570 <atoi>
    1033:	83 c4 10             	add    $0x10,%esp
    1036:	a3 30 17 00 00       	mov    %eax,0x1730

    return 0;
    103b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1040:	c9                   	leave  
    1041:	c3                   	ret    

00001042 <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
    1042:	f3 0f 1e fb          	endbr32 
    1046:	55                   	push   %ebp
    1047:	89 e5                	mov    %esp,%ebp
    1049:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
    104c:	a1 60 17 00 00       	mov    0x1760,%eax
    1051:	85 c0                	test   %eax,%eax
    1053:	75 31                	jne    1086 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
    1055:	83 ec 08             	sub    $0x8,%esp
    1058:	6a 00                	push   $0x0
    105a:	68 92 12 00 00       	push   $0x1292
    105f:	e8 bd f6 ff ff       	call   721 <open>
    1064:	83 c4 10             	add    $0x10,%esp
    1067:	a3 60 17 00 00       	mov    %eax,0x1760

        if(dir < 0){        // kalau gagal membuka file
    106c:	a1 60 17 00 00       	mov    0x1760,%eax
    1071:	85 c0                	test   %eax,%eax
    1073:	79 11                	jns    1086 <getgroup+0x44>
            dir = 0;
    1075:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
    107c:	00 00 00 
            return 0;
    107f:	b8 00 00 00 00       	mov    $0x0,%eax
    1084:	eb 16                	jmp    109c <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
    1086:	e8 91 fe ff ff       	call   f1c <get_group>
    108b:	83 f8 ff             	cmp    $0xffffffff,%eax
    108e:	75 07                	jne    1097 <getgroup+0x55>
        return 0;
    1090:	b8 00 00 00 00       	mov    $0x0,%eax
    1095:	eb 05                	jmp    109c <getgroup+0x5a>
    
    return &current_group;
    1097:	b8 2c 17 00 00       	mov    $0x172c,%eax
}
    109c:	c9                   	leave  
    109d:	c3                   	ret    

0000109e <setgroup>:

// open file_ids
void setgroup(void){
    109e:	f3 0f 1e fb          	endbr32 
    10a2:	55                   	push   %ebp
    10a3:	89 e5                	mov    %esp,%ebp
    10a5:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    10a8:	a1 60 17 00 00       	mov    0x1760,%eax
    10ad:	85 c0                	test   %eax,%eax
    10af:	74 1b                	je     10cc <setgroup+0x2e>
        close(dir);
    10b1:	a1 60 17 00 00       	mov    0x1760,%eax
    10b6:	83 ec 0c             	sub    $0xc,%esp
    10b9:	50                   	push   %eax
    10ba:	e8 4a f6 ff ff       	call   709 <close>
    10bf:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    10c2:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
    10c9:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
    10cc:	83 ec 08             	sub    $0x8,%esp
    10cf:	6a 00                	push   $0x0
    10d1:	68 92 12 00 00       	push   $0x1292
    10d6:	e8 46 f6 ff ff       	call   721 <open>
    10db:	83 c4 10             	add    $0x10,%esp
    10de:	a3 60 17 00 00       	mov    %eax,0x1760

    if (dir < 0)
    10e3:	a1 60 17 00 00       	mov    0x1760,%eax
    10e8:	85 c0                	test   %eax,%eax
    10ea:	79 0a                	jns    10f6 <setgroup+0x58>
        dir = 0;
    10ec:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
    10f3:	00 00 00 
}
    10f6:	90                   	nop
    10f7:	c9                   	leave  
    10f8:	c3                   	ret    

000010f9 <endgroup>:

// tutup file_ids
void endgroup (void){
    10f9:	f3 0f 1e fb          	endbr32 
    10fd:	55                   	push   %ebp
    10fe:	89 e5                	mov    %esp,%ebp
    1100:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    1103:	a1 60 17 00 00       	mov    0x1760,%eax
    1108:	85 c0                	test   %eax,%eax
    110a:	74 1b                	je     1127 <endgroup+0x2e>
        close(dir);
    110c:	a1 60 17 00 00       	mov    0x1760,%eax
    1111:	83 ec 0c             	sub    $0xc,%esp
    1114:	50                   	push   %eax
    1115:	e8 ef f5 ff ff       	call   709 <close>
    111a:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    111d:	c7 05 60 17 00 00 00 	movl   $0x0,0x1760
    1124:	00 00 00 
    }
}
    1127:	90                   	nop
    1128:	c9                   	leave  
    1129:	c3                   	ret    

0000112a <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
    112a:	f3 0f 1e fb          	endbr32 
    112e:	55                   	push   %ebp
    112f:	89 e5                	mov    %esp,%ebp
    1131:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    1134:	e8 65 ff ff ff       	call   109e <setgroup>

    while (getgroup()){
    1139:	eb 3c                	jmp    1177 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
    113b:	a1 2c 17 00 00       	mov    0x172c,%eax
    1140:	83 ec 08             	sub    $0x8,%esp
    1143:	50                   	push   %eax
    1144:	ff 75 08             	pushl  0x8(%ebp)
    1147:	e8 29 f2 ff ff       	call   375 <strcmp>
    114c:	83 c4 10             	add    $0x10,%esp
    114f:	85 c0                	test   %eax,%eax
    1151:	75 24                	jne    1177 <cek_nama_group+0x4d>
            endgroup();
    1153:	e8 a1 ff ff ff       	call   10f9 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
    1158:	a1 2c 17 00 00       	mov    0x172c,%eax
    115d:	83 ec 04             	sub    $0x4,%esp
    1160:	50                   	push   %eax
    1161:	68 9d 12 00 00       	push   $0x129d
    1166:	6a 01                	push   $0x1
    1168:	e8 40 f7 ff ff       	call   8ad <printf>
    116d:	83 c4 10             	add    $0x10,%esp
            return &current_group;
    1170:	b8 2c 17 00 00       	mov    $0x172c,%eax
    1175:	eb 13                	jmp    118a <cek_nama_group+0x60>
    while (getgroup()){
    1177:	e8 c6 fe ff ff       	call   1042 <getgroup>
    117c:	85 c0                	test   %eax,%eax
    117e:	75 bb                	jne    113b <cek_nama_group+0x11>
        }
    }
    endgroup();
    1180:	e8 74 ff ff ff       	call   10f9 <endgroup>
    return 0;
    1185:	b8 00 00 00 00       	mov    $0x0,%eax
}
    118a:	c9                   	leave  
    118b:	c3                   	ret    

0000118c <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
    118c:	f3 0f 1e fb          	endbr32 
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    1196:	e8 03 ff ff ff       	call   109e <setgroup>

    while (getgroup()){
    119b:	eb 16                	jmp    11b3 <cek_gid+0x27>
        if(current_group.gid == gid){
    119d:	a1 30 17 00 00       	mov    0x1730,%eax
    11a2:	39 45 08             	cmp    %eax,0x8(%ebp)
    11a5:	75 0c                	jne    11b3 <cek_gid+0x27>
            endgroup();
    11a7:	e8 4d ff ff ff       	call   10f9 <endgroup>
            return &current_group;
    11ac:	b8 2c 17 00 00       	mov    $0x172c,%eax
    11b1:	eb 13                	jmp    11c6 <cek_gid+0x3a>
    while (getgroup()){
    11b3:	e8 8a fe ff ff       	call   1042 <getgroup>
    11b8:	85 c0                	test   %eax,%eax
    11ba:	75 e1                	jne    119d <cek_gid+0x11>
        }
    }
    endgroup();
    11bc:	e8 38 ff ff ff       	call   10f9 <endgroup>
    return 0;
    11c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11c6:	c9                   	leave  
    11c7:	c3                   	ret    
