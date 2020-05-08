
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <print_mode>:
#ifdef LS_EXEC
// this is an ugly series of if statements but it works
void
print_mode(struct stat* st)
{
       0:	f3 0f 1e fb          	endbr32 
       4:	55                   	push   %ebp
       5:	89 e5                	mov    %esp,%ebp
       7:	83 ec 08             	sub    $0x8,%esp
  switch (st->type) {
       a:	8b 45 08             	mov    0x8(%ebp),%eax
       d:	0f b7 00             	movzwl (%eax),%eax
      10:	98                   	cwtl   
      11:	83 f8 03             	cmp    $0x3,%eax
      14:	74 39                	je     4f <print_mode+0x4f>
      16:	83 f8 03             	cmp    $0x3,%eax
      19:	7f 48                	jg     63 <print_mode+0x63>
      1b:	83 f8 01             	cmp    $0x1,%eax
      1e:	74 07                	je     27 <print_mode+0x27>
      20:	83 f8 02             	cmp    $0x2,%eax
      23:	74 16                	je     3b <print_mode+0x3b>
      25:	eb 3c                	jmp    63 <print_mode+0x63>
    case T_DIR: printf(1, "d"); break;
      27:	83 ec 08             	sub    $0x8,%esp
      2a:	68 d4 14 00 00       	push   $0x14d4
      2f:	6a 01                	push   $0x1
      31:	e8 81 0b 00 00       	call   bb7 <printf>
      36:	83 c4 10             	add    $0x10,%esp
      39:	eb 3a                	jmp    75 <print_mode+0x75>
    case T_FILE: printf(1, "-"); break;
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	68 d6 14 00 00       	push   $0x14d6
      43:	6a 01                	push   $0x1
      45:	e8 6d 0b 00 00       	call   bb7 <printf>
      4a:	83 c4 10             	add    $0x10,%esp
      4d:	eb 26                	jmp    75 <print_mode+0x75>
    case T_DEV: printf(1, "c"); break;
      4f:	83 ec 08             	sub    $0x8,%esp
      52:	68 d8 14 00 00       	push   $0x14d8
      57:	6a 01                	push   $0x1
      59:	e8 59 0b 00 00       	call   bb7 <printf>
      5e:	83 c4 10             	add    $0x10,%esp
      61:	eb 12                	jmp    75 <print_mode+0x75>
    default: printf(1, "?");
      63:	83 ec 08             	sub    $0x8,%esp
      66:	68 da 14 00 00       	push   $0x14da
      6b:	6a 01                	push   $0x1
      6d:	e8 45 0b 00 00       	call   bb7 <printf>
      72:	83 c4 10             	add    $0x10,%esp
  }

  if (st->mode.flags.u_r)
      75:	8b 45 08             	mov    0x8(%ebp),%eax
      78:	0f b6 40 19          	movzbl 0x19(%eax),%eax
      7c:	83 e0 01             	and    $0x1,%eax
      7f:	84 c0                	test   %al,%al
      81:	74 14                	je     97 <print_mode+0x97>
    printf(1, "r");
      83:	83 ec 08             	sub    $0x8,%esp
      86:	68 dc 14 00 00       	push   $0x14dc
      8b:	6a 01                	push   $0x1
      8d:	e8 25 0b 00 00       	call   bb7 <printf>
      92:	83 c4 10             	add    $0x10,%esp
      95:	eb 12                	jmp    a9 <print_mode+0xa9>
  else
    printf(1, "-");
      97:	83 ec 08             	sub    $0x8,%esp
      9a:	68 d6 14 00 00       	push   $0x14d6
      9f:	6a 01                	push   $0x1
      a1:	e8 11 0b 00 00       	call   bb7 <printf>
      a6:	83 c4 10             	add    $0x10,%esp

  if (st->mode.flags.u_w)
      a9:	8b 45 08             	mov    0x8(%ebp),%eax
      ac:	0f b6 40 18          	movzbl 0x18(%eax),%eax
      b0:	83 e0 80             	and    $0xffffff80,%eax
      b3:	84 c0                	test   %al,%al
      b5:	74 14                	je     cb <print_mode+0xcb>
    printf(1, "w");
      b7:	83 ec 08             	sub    $0x8,%esp
      ba:	68 de 14 00 00       	push   $0x14de
      bf:	6a 01                	push   $0x1
      c1:	e8 f1 0a 00 00       	call   bb7 <printf>
      c6:	83 c4 10             	add    $0x10,%esp
      c9:	eb 12                	jmp    dd <print_mode+0xdd>
  else
    printf(1, "-");
      cb:	83 ec 08             	sub    $0x8,%esp
      ce:	68 d6 14 00 00       	push   $0x14d6
      d3:	6a 01                	push   $0x1
      d5:	e8 dd 0a 00 00       	call   bb7 <printf>
      da:	83 c4 10             	add    $0x10,%esp

  if ((st->mode.flags.u_x) & (st->mode.flags.setuid))
      dd:	8b 45 08             	mov    0x8(%ebp),%eax
      e0:	0f b6 40 18          	movzbl 0x18(%eax),%eax
      e4:	c0 e8 06             	shr    $0x6,%al
      e7:	83 e0 01             	and    $0x1,%eax
      ea:	0f b6 d0             	movzbl %al,%edx
      ed:	8b 45 08             	mov    0x8(%ebp),%eax
      f0:	0f b6 40 19          	movzbl 0x19(%eax),%eax
      f4:	d0 e8                	shr    %al
      f6:	83 e0 01             	and    $0x1,%eax
      f9:	0f b6 c0             	movzbl %al,%eax
      fc:	21 d0                	and    %edx,%eax
      fe:	85 c0                	test   %eax,%eax
     100:	74 14                	je     116 <print_mode+0x116>
    printf(1, "S");
     102:	83 ec 08             	sub    $0x8,%esp
     105:	68 e0 14 00 00       	push   $0x14e0
     10a:	6a 01                	push   $0x1
     10c:	e8 a6 0a 00 00       	call   bb7 <printf>
     111:	83 c4 10             	add    $0x10,%esp
     114:	eb 34                	jmp    14a <print_mode+0x14a>
  else if (st->mode.flags.u_x)
     116:	8b 45 08             	mov    0x8(%ebp),%eax
     119:	0f b6 40 18          	movzbl 0x18(%eax),%eax
     11d:	83 e0 40             	and    $0x40,%eax
     120:	84 c0                	test   %al,%al
     122:	74 14                	je     138 <print_mode+0x138>
    printf(1, "x");
     124:	83 ec 08             	sub    $0x8,%esp
     127:	68 e2 14 00 00       	push   $0x14e2
     12c:	6a 01                	push   $0x1
     12e:	e8 84 0a 00 00       	call   bb7 <printf>
     133:	83 c4 10             	add    $0x10,%esp
     136:	eb 12                	jmp    14a <print_mode+0x14a>
  else
    printf(1, "-");
     138:	83 ec 08             	sub    $0x8,%esp
     13b:	68 d6 14 00 00       	push   $0x14d6
     140:	6a 01                	push   $0x1
     142:	e8 70 0a 00 00       	call   bb7 <printf>
     147:	83 c4 10             	add    $0x10,%esp

  if (st->mode.flags.g_r)
     14a:	8b 45 08             	mov    0x8(%ebp),%eax
     14d:	0f b6 40 18          	movzbl 0x18(%eax),%eax
     151:	83 e0 20             	and    $0x20,%eax
     154:	84 c0                	test   %al,%al
     156:	74 14                	je     16c <print_mode+0x16c>
    printf(1, "r");
     158:	83 ec 08             	sub    $0x8,%esp
     15b:	68 dc 14 00 00       	push   $0x14dc
     160:	6a 01                	push   $0x1
     162:	e8 50 0a 00 00       	call   bb7 <printf>
     167:	83 c4 10             	add    $0x10,%esp
     16a:	eb 12                	jmp    17e <print_mode+0x17e>
  else
    printf(1, "-");
     16c:	83 ec 08             	sub    $0x8,%esp
     16f:	68 d6 14 00 00       	push   $0x14d6
     174:	6a 01                	push   $0x1
     176:	e8 3c 0a 00 00       	call   bb7 <printf>
     17b:	83 c4 10             	add    $0x10,%esp

  if (st->mode.flags.g_w)
     17e:	8b 45 08             	mov    0x8(%ebp),%eax
     181:	0f b6 40 18          	movzbl 0x18(%eax),%eax
     185:	83 e0 10             	and    $0x10,%eax
     188:	84 c0                	test   %al,%al
     18a:	74 14                	je     1a0 <print_mode+0x1a0>
    printf(1, "w");
     18c:	83 ec 08             	sub    $0x8,%esp
     18f:	68 de 14 00 00       	push   $0x14de
     194:	6a 01                	push   $0x1
     196:	e8 1c 0a 00 00       	call   bb7 <printf>
     19b:	83 c4 10             	add    $0x10,%esp
     19e:	eb 12                	jmp    1b2 <print_mode+0x1b2>
  else
    printf(1, "-");
     1a0:	83 ec 08             	sub    $0x8,%esp
     1a3:	68 d6 14 00 00       	push   $0x14d6
     1a8:	6a 01                	push   $0x1
     1aa:	e8 08 0a 00 00       	call   bb7 <printf>
     1af:	83 c4 10             	add    $0x10,%esp

  if (st->mode.flags.g_x)
     1b2:	8b 45 08             	mov    0x8(%ebp),%eax
     1b5:	0f b6 40 18          	movzbl 0x18(%eax),%eax
     1b9:	83 e0 08             	and    $0x8,%eax
     1bc:	84 c0                	test   %al,%al
     1be:	74 14                	je     1d4 <print_mode+0x1d4>
    printf(1, "x");
     1c0:	83 ec 08             	sub    $0x8,%esp
     1c3:	68 e2 14 00 00       	push   $0x14e2
     1c8:	6a 01                	push   $0x1
     1ca:	e8 e8 09 00 00       	call   bb7 <printf>
     1cf:	83 c4 10             	add    $0x10,%esp
     1d2:	eb 12                	jmp    1e6 <print_mode+0x1e6>
  else
    printf(1, "-");
     1d4:	83 ec 08             	sub    $0x8,%esp
     1d7:	68 d6 14 00 00       	push   $0x14d6
     1dc:	6a 01                	push   $0x1
     1de:	e8 d4 09 00 00       	call   bb7 <printf>
     1e3:	83 c4 10             	add    $0x10,%esp

  if (st->mode.flags.o_r)
     1e6:	8b 45 08             	mov    0x8(%ebp),%eax
     1e9:	0f b6 40 18          	movzbl 0x18(%eax),%eax
     1ed:	83 e0 04             	and    $0x4,%eax
     1f0:	84 c0                	test   %al,%al
     1f2:	74 14                	je     208 <print_mode+0x208>
    printf(1, "r");
     1f4:	83 ec 08             	sub    $0x8,%esp
     1f7:	68 dc 14 00 00       	push   $0x14dc
     1fc:	6a 01                	push   $0x1
     1fe:	e8 b4 09 00 00       	call   bb7 <printf>
     203:	83 c4 10             	add    $0x10,%esp
     206:	eb 12                	jmp    21a <print_mode+0x21a>
  else
    printf(1, "-");
     208:	83 ec 08             	sub    $0x8,%esp
     20b:	68 d6 14 00 00       	push   $0x14d6
     210:	6a 01                	push   $0x1
     212:	e8 a0 09 00 00       	call   bb7 <printf>
     217:	83 c4 10             	add    $0x10,%esp

  if (st->mode.flags.o_w)
     21a:	8b 45 08             	mov    0x8(%ebp),%eax
     21d:	0f b6 40 18          	movzbl 0x18(%eax),%eax
     221:	83 e0 02             	and    $0x2,%eax
     224:	84 c0                	test   %al,%al
     226:	74 14                	je     23c <print_mode+0x23c>
    printf(1, "w");
     228:	83 ec 08             	sub    $0x8,%esp
     22b:	68 de 14 00 00       	push   $0x14de
     230:	6a 01                	push   $0x1
     232:	e8 80 09 00 00       	call   bb7 <printf>
     237:	83 c4 10             	add    $0x10,%esp
     23a:	eb 12                	jmp    24e <print_mode+0x24e>
  else
    printf(1, "-");
     23c:	83 ec 08             	sub    $0x8,%esp
     23f:	68 d6 14 00 00       	push   $0x14d6
     244:	6a 01                	push   $0x1
     246:	e8 6c 09 00 00       	call   bb7 <printf>
     24b:	83 c4 10             	add    $0x10,%esp

  if (st->mode.flags.o_x)
     24e:	8b 45 08             	mov    0x8(%ebp),%eax
     251:	0f b6 40 18          	movzbl 0x18(%eax),%eax
     255:	83 e0 01             	and    $0x1,%eax
     258:	84 c0                	test   %al,%al
     25a:	74 14                	je     270 <print_mode+0x270>
    printf(1, "x");
     25c:	83 ec 08             	sub    $0x8,%esp
     25f:	68 e2 14 00 00       	push   $0x14e2
     264:	6a 01                	push   $0x1
     266:	e8 4c 09 00 00       	call   bb7 <printf>
     26b:	83 c4 10             	add    $0x10,%esp
  else
    printf(1, "-");

  return;
     26e:	eb 13                	jmp    283 <print_mode+0x283>
    printf(1, "-");
     270:	83 ec 08             	sub    $0x8,%esp
     273:	68 d6 14 00 00       	push   $0x14d6
     278:	6a 01                	push   $0x1
     27a:	e8 38 09 00 00       	call   bb7 <printf>
     27f:	83 c4 10             	add    $0x10,%esp
  return;
     282:	90                   	nop
}
     283:	c9                   	leave  
     284:	c3                   	ret    

00000285 <fmtname>:
#include "print_mode.c"
#endif

char*
fmtname(char *path)
{
     285:	f3 0f 1e fb          	endbr32 
     289:	55                   	push   %ebp
     28a:	89 e5                	mov    %esp,%ebp
     28c:	53                   	push   %ebx
     28d:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
     290:	83 ec 0c             	sub    $0xc,%esp
     293:	ff 75 08             	pushl  0x8(%ebp)
     296:	e8 27 04 00 00       	call   6c2 <strlen>
     29b:	83 c4 10             	add    $0x10,%esp
     29e:	8b 55 08             	mov    0x8(%ebp),%edx
     2a1:	01 d0                	add    %edx,%eax
     2a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
     2a6:	eb 04                	jmp    2ac <fmtname+0x27>
     2a8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     2ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2af:	3b 45 08             	cmp    0x8(%ebp),%eax
     2b2:	72 0a                	jb     2be <fmtname+0x39>
     2b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2b7:	0f b6 00             	movzbl (%eax),%eax
     2ba:	3c 2f                	cmp    $0x2f,%al
     2bc:	75 ea                	jne    2a8 <fmtname+0x23>
    ;
  p++;
     2be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
     2c2:	83 ec 0c             	sub    $0xc,%esp
     2c5:	ff 75 f4             	pushl  -0xc(%ebp)
     2c8:	e8 f5 03 00 00       	call   6c2 <strlen>
     2cd:	83 c4 10             	add    $0x10,%esp
     2d0:	83 f8 0d             	cmp    $0xd,%eax
     2d3:	76 05                	jbe    2da <fmtname+0x55>
    return p;
     2d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2d8:	eb 60                	jmp    33a <fmtname+0xb5>
  memmove(buf, p, strlen(p));
     2da:	83 ec 0c             	sub    $0xc,%esp
     2dd:	ff 75 f4             	pushl  -0xc(%ebp)
     2e0:	e8 dd 03 00 00       	call   6c2 <strlen>
     2e5:	83 c4 10             	add    $0x10,%esp
     2e8:	83 ec 04             	sub    $0x4,%esp
     2eb:	50                   	push   %eax
     2ec:	ff 75 f4             	pushl  -0xc(%ebp)
     2ef:	68 20 1a 00 00       	push   $0x1a20
     2f4:	e8 a9 06 00 00       	call   9a2 <memmove>
     2f9:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
     2fc:	83 ec 0c             	sub    $0xc,%esp
     2ff:	ff 75 f4             	pushl  -0xc(%ebp)
     302:	e8 bb 03 00 00       	call   6c2 <strlen>
     307:	83 c4 10             	add    $0x10,%esp
     30a:	ba 0e 00 00 00       	mov    $0xe,%edx
     30f:	89 d3                	mov    %edx,%ebx
     311:	29 c3                	sub    %eax,%ebx
     313:	83 ec 0c             	sub    $0xc,%esp
     316:	ff 75 f4             	pushl  -0xc(%ebp)
     319:	e8 a4 03 00 00       	call   6c2 <strlen>
     31e:	83 c4 10             	add    $0x10,%esp
     321:	05 20 1a 00 00       	add    $0x1a20,%eax
     326:	83 ec 04             	sub    $0x4,%esp
     329:	53                   	push   %ebx
     32a:	6a 20                	push   $0x20
     32c:	50                   	push   %eax
     32d:	e8 bb 03 00 00       	call   6ed <memset>
     332:	83 c4 10             	add    $0x10,%esp
  return buf;
     335:	b8 20 1a 00 00       	mov    $0x1a20,%eax
}
     33a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     33d:	c9                   	leave  
     33e:	c3                   	ret    

0000033f <ls>:

void
ls(char *path)
{
     33f:	f3 0f 1e fb          	endbr32 
     343:	55                   	push   %ebp
     344:	89 e5                	mov    %esp,%ebp
     346:	57                   	push   %edi
     347:	56                   	push   %esi
     348:	53                   	push   %ebx
     349:	81 ec 5c 02 00 00    	sub    $0x25c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
     34f:	83 ec 08             	sub    $0x8,%esp
     352:	6a 00                	push   $0x0
     354:	ff 75 08             	pushl  0x8(%ebp)
     357:	e8 cf 06 00 00       	call   a2b <open>
     35c:	83 c4 10             	add    $0x10,%esp
     35f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     362:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     366:	79 1a                	jns    382 <ls+0x43>
    printf(2, "ls: cannot open %s\n", path);
     368:	83 ec 04             	sub    $0x4,%esp
     36b:	ff 75 08             	pushl  0x8(%ebp)
     36e:	68 e4 14 00 00       	push   $0x14e4
     373:	6a 02                	push   $0x2
     375:	e8 3d 08 00 00       	call   bb7 <printf>
     37a:	83 c4 10             	add    $0x10,%esp
    return;
     37d:	e9 21 02 00 00       	jmp    5a3 <ls+0x264>
  }
  
  if(fstat(fd, &st) < 0){
     382:	83 ec 08             	sub    $0x8,%esp
     385:	8d 85 b0 fd ff ff    	lea    -0x250(%ebp),%eax
     38b:	50                   	push   %eax
     38c:	ff 75 e4             	pushl  -0x1c(%ebp)
     38f:	e8 af 06 00 00       	call   a43 <fstat>
     394:	83 c4 10             	add    $0x10,%esp
     397:	85 c0                	test   %eax,%eax
     399:	79 28                	jns    3c3 <ls+0x84>
    printf(2, "ls: cannot stat %s\n", path);
     39b:	83 ec 04             	sub    $0x4,%esp
     39e:	ff 75 08             	pushl  0x8(%ebp)
     3a1:	68 f8 14 00 00       	push   $0x14f8
     3a6:	6a 02                	push   $0x2
     3a8:	e8 0a 08 00 00       	call   bb7 <printf>
     3ad:	83 c4 10             	add    $0x10,%esp
    close(fd);
     3b0:	83 ec 0c             	sub    $0xc,%esp
     3b3:	ff 75 e4             	pushl  -0x1c(%ebp)
     3b6:	e8 58 06 00 00       	call   a13 <close>
     3bb:	83 c4 10             	add    $0x10,%esp
    return;
     3be:	e9 e0 01 00 00       	jmp    5a3 <ls+0x264>
  }
  
  switch(st.type){
     3c3:	0f b7 85 b0 fd ff ff 	movzwl -0x250(%ebp),%eax
     3ca:	98                   	cwtl   
     3cb:	83 f8 01             	cmp    $0x1,%eax
     3ce:	74 68                	je     438 <ls+0xf9>
     3d0:	83 f8 02             	cmp    $0x2,%eax
     3d3:	0f 85 bc 01 00 00    	jne    595 <ls+0x256>
  case T_FILE:
#ifndef LS_EXEC
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
#else
    // Print mode bits & new format
    print_mode(&st);
     3d9:	83 ec 0c             	sub    $0xc,%esp
     3dc:	8d 85 b0 fd ff ff    	lea    -0x250(%ebp),%eax
     3e2:	50                   	push   %eax
     3e3:	e8 18 fc ff ff       	call   0 <print_mode>
     3e8:	83 c4 10             	add    $0x10,%esp
    printf(1, " %s %d\t%d\t%d\t%d\n", fmtname(path), st.uid, st.gid, st.ino, st.size);
     3eb:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
     3f1:	89 85 a4 fd ff ff    	mov    %eax,-0x25c(%ebp)
     3f7:	8b bd b8 fd ff ff    	mov    -0x248(%ebp),%edi
     3fd:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
     403:	8b 9d c0 fd ff ff    	mov    -0x240(%ebp),%ebx
     409:	83 ec 0c             	sub    $0xc,%esp
     40c:	ff 75 08             	pushl  0x8(%ebp)
     40f:	e8 71 fe ff ff       	call   285 <fmtname>
     414:	83 c4 10             	add    $0x10,%esp
     417:	83 ec 04             	sub    $0x4,%esp
     41a:	ff b5 a4 fd ff ff    	pushl  -0x25c(%ebp)
     420:	57                   	push   %edi
     421:	56                   	push   %esi
     422:	53                   	push   %ebx
     423:	50                   	push   %eax
     424:	68 0c 15 00 00       	push   $0x150c
     429:	6a 01                	push   $0x1
     42b:	e8 87 07 00 00       	call   bb7 <printf>
     430:	83 c4 20             	add    $0x20,%esp
#endif
    break;
     433:	e9 5d 01 00 00       	jmp    595 <ls+0x256>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     438:	83 ec 0c             	sub    $0xc,%esp
     43b:	ff 75 08             	pushl  0x8(%ebp)
     43e:	e8 7f 02 00 00       	call   6c2 <strlen>
     443:	83 c4 10             	add    $0x10,%esp
     446:	83 c0 10             	add    $0x10,%eax
     449:	3d 00 02 00 00       	cmp    $0x200,%eax
     44e:	76 17                	jbe    467 <ls+0x128>
      printf(1, "ls: path too long\n");
     450:	83 ec 08             	sub    $0x8,%esp
     453:	68 1d 15 00 00       	push   $0x151d
     458:	6a 01                	push   $0x1
     45a:	e8 58 07 00 00       	call   bb7 <printf>
     45f:	83 c4 10             	add    $0x10,%esp
      break;
     462:	e9 2e 01 00 00       	jmp    595 <ls+0x256>
    }
    strcpy(buf, path);
     467:	83 ec 08             	sub    $0x8,%esp
     46a:	ff 75 08             	pushl  0x8(%ebp)
     46d:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     473:	50                   	push   %eax
     474:	e8 d2 01 00 00       	call   64b <strcpy>
     479:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
     47c:	83 ec 0c             	sub    $0xc,%esp
     47f:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     485:	50                   	push   %eax
     486:	e8 37 02 00 00       	call   6c2 <strlen>
     48b:	83 c4 10             	add    $0x10,%esp
     48e:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
     494:	01 d0                	add    %edx,%eax
     496:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
     499:	8b 45 e0             	mov    -0x20(%ebp),%eax
     49c:	8d 50 01             	lea    0x1(%eax),%edx
     49f:	89 55 e0             	mov    %edx,-0x20(%ebp)
     4a2:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     4a5:	e9 ca 00 00 00       	jmp    574 <ls+0x235>
      if(de.inum == 0)
     4aa:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
     4b1:	66 85 c0             	test   %ax,%ax
     4b4:	75 05                	jne    4bb <ls+0x17c>
        continue;
     4b6:	e9 b9 00 00 00       	jmp    574 <ls+0x235>
      memmove(p, de.name, DIRSIZ);
     4bb:	83 ec 04             	sub    $0x4,%esp
     4be:	6a 0e                	push   $0xe
     4c0:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
     4c6:	83 c0 02             	add    $0x2,%eax
     4c9:	50                   	push   %eax
     4ca:	ff 75 e0             	pushl  -0x20(%ebp)
     4cd:	e8 d0 04 00 00       	call   9a2 <memmove>
     4d2:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
     4d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
     4d8:	83 c0 0e             	add    $0xe,%eax
     4db:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
     4de:	83 ec 08             	sub    $0x8,%esp
     4e1:	8d 85 b0 fd ff ff    	lea    -0x250(%ebp),%eax
     4e7:	50                   	push   %eax
     4e8:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     4ee:	50                   	push   %eax
     4ef:	e8 35 03 00 00       	call   829 <stat>
     4f4:	83 c4 10             	add    $0x10,%esp
     4f7:	85 c0                	test   %eax,%eax
     4f9:	79 1b                	jns    516 <ls+0x1d7>
        printf(1, "ls: cannot stat %s\n", buf);
     4fb:	83 ec 04             	sub    $0x4,%esp
     4fe:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     504:	50                   	push   %eax
     505:	68 f8 14 00 00       	push   $0x14f8
     50a:	6a 01                	push   $0x1
     50c:	e8 a6 06 00 00       	call   bb7 <printf>
     511:	83 c4 10             	add    $0x10,%esp
        continue;
     514:	eb 5e                	jmp    574 <ls+0x235>
      }
#ifndef LS_EXEC
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
#else
      // Print mode bits & new format
      print_mode(&st);
     516:	83 ec 0c             	sub    $0xc,%esp
     519:	8d 85 b0 fd ff ff    	lea    -0x250(%ebp),%eax
     51f:	50                   	push   %eax
     520:	e8 db fa ff ff       	call   0 <print_mode>
     525:	83 c4 10             	add    $0x10,%esp
      printf(1, " %s %d\t%d\t%d\t%d\n", fmtname(buf), st.uid, st.gid, st.ino, st.size);
     528:	8b 85 cc fd ff ff    	mov    -0x234(%ebp),%eax
     52e:	89 85 a4 fd ff ff    	mov    %eax,-0x25c(%ebp)
     534:	8b bd b8 fd ff ff    	mov    -0x248(%ebp),%edi
     53a:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
     540:	8b 9d c0 fd ff ff    	mov    -0x240(%ebp),%ebx
     546:	83 ec 0c             	sub    $0xc,%esp
     549:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
     54f:	50                   	push   %eax
     550:	e8 30 fd ff ff       	call   285 <fmtname>
     555:	83 c4 10             	add    $0x10,%esp
     558:	83 ec 04             	sub    $0x4,%esp
     55b:	ff b5 a4 fd ff ff    	pushl  -0x25c(%ebp)
     561:	57                   	push   %edi
     562:	56                   	push   %esi
     563:	53                   	push   %ebx
     564:	50                   	push   %eax
     565:	68 0c 15 00 00       	push   $0x150c
     56a:	6a 01                	push   $0x1
     56c:	e8 46 06 00 00       	call   bb7 <printf>
     571:	83 c4 20             	add    $0x20,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     574:	83 ec 04             	sub    $0x4,%esp
     577:	6a 10                	push   $0x10
     579:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
     57f:	50                   	push   %eax
     580:	ff 75 e4             	pushl  -0x1c(%ebp)
     583:	e8 7b 04 00 00       	call   a03 <read>
     588:	83 c4 10             	add    $0x10,%esp
     58b:	83 f8 10             	cmp    $0x10,%eax
     58e:	0f 84 16 ff ff ff    	je     4aa <ls+0x16b>
#endif
    }
    break;
     594:	90                   	nop
  }
  close(fd);
     595:	83 ec 0c             	sub    $0xc,%esp
     598:	ff 75 e4             	pushl  -0x1c(%ebp)
     59b:	e8 73 04 00 00       	call   a13 <close>
     5a0:	83 c4 10             	add    $0x10,%esp
}
     5a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5a6:	5b                   	pop    %ebx
     5a7:	5e                   	pop    %esi
     5a8:	5f                   	pop    %edi
     5a9:	5d                   	pop    %ebp
     5aa:	c3                   	ret    

000005ab <main>:

int
main(int argc, char *argv[])
{
     5ab:	f3 0f 1e fb          	endbr32 
     5af:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     5b3:	83 e4 f0             	and    $0xfffffff0,%esp
     5b6:	ff 71 fc             	pushl  -0x4(%ecx)
     5b9:	55                   	push   %ebp
     5ba:	89 e5                	mov    %esp,%ebp
     5bc:	53                   	push   %ebx
     5bd:	51                   	push   %ecx
     5be:	83 ec 10             	sub    $0x10,%esp
     5c1:	89 cb                	mov    %ecx,%ebx
  int i;

#ifdef LS_EXEC
  // New column headers
  printf(1, "mode\t\tname\tuid\tgid\tinode\tsize\n");
     5c3:	83 ec 08             	sub    $0x8,%esp
     5c6:	68 30 15 00 00       	push   $0x1530
     5cb:	6a 01                	push   $0x1
     5cd:	e8 e5 05 00 00       	call   bb7 <printf>
     5d2:	83 c4 10             	add    $0x10,%esp
#endif
  if(argc < 2){
     5d5:	83 3b 01             	cmpl   $0x1,(%ebx)
     5d8:	7f 15                	jg     5ef <main+0x44>
    ls(".");
     5da:	83 ec 0c             	sub    $0xc,%esp
     5dd:	68 4f 15 00 00       	push   $0x154f
     5e2:	e8 58 fd ff ff       	call   33f <ls>
     5e7:	83 c4 10             	add    $0x10,%esp
    exit();
     5ea:	e8 fc 03 00 00       	call   9eb <exit>
  }
  for(i=1; i<argc; i++)
     5ef:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     5f6:	eb 21                	jmp    619 <main+0x6e>
    ls(argv[i]);
     5f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5fb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     602:	8b 43 04             	mov    0x4(%ebx),%eax
     605:	01 d0                	add    %edx,%eax
     607:	8b 00                	mov    (%eax),%eax
     609:	83 ec 0c             	sub    $0xc,%esp
     60c:	50                   	push   %eax
     60d:	e8 2d fd ff ff       	call   33f <ls>
     612:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
     615:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     619:	8b 45 f4             	mov    -0xc(%ebp),%eax
     61c:	3b 03                	cmp    (%ebx),%eax
     61e:	7c d8                	jl     5f8 <main+0x4d>
  exit();
     620:	e8 c6 03 00 00       	call   9eb <exit>

00000625 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     625:	55                   	push   %ebp
     626:	89 e5                	mov    %esp,%ebp
     628:	57                   	push   %edi
     629:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     62a:	8b 4d 08             	mov    0x8(%ebp),%ecx
     62d:	8b 55 10             	mov    0x10(%ebp),%edx
     630:	8b 45 0c             	mov    0xc(%ebp),%eax
     633:	89 cb                	mov    %ecx,%ebx
     635:	89 df                	mov    %ebx,%edi
     637:	89 d1                	mov    %edx,%ecx
     639:	fc                   	cld    
     63a:	f3 aa                	rep stos %al,%es:(%edi)
     63c:	89 ca                	mov    %ecx,%edx
     63e:	89 fb                	mov    %edi,%ebx
     640:	89 5d 08             	mov    %ebx,0x8(%ebp)
     643:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     646:	90                   	nop
     647:	5b                   	pop    %ebx
     648:	5f                   	pop    %edi
     649:	5d                   	pop    %ebp
     64a:	c3                   	ret    

0000064b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     64b:	f3 0f 1e fb          	endbr32 
     64f:	55                   	push   %ebp
     650:	89 e5                	mov    %esp,%ebp
     652:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     655:	8b 45 08             	mov    0x8(%ebp),%eax
     658:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     65b:	90                   	nop
     65c:	8b 55 0c             	mov    0xc(%ebp),%edx
     65f:	8d 42 01             	lea    0x1(%edx),%eax
     662:	89 45 0c             	mov    %eax,0xc(%ebp)
     665:	8b 45 08             	mov    0x8(%ebp),%eax
     668:	8d 48 01             	lea    0x1(%eax),%ecx
     66b:	89 4d 08             	mov    %ecx,0x8(%ebp)
     66e:	0f b6 12             	movzbl (%edx),%edx
     671:	88 10                	mov    %dl,(%eax)
     673:	0f b6 00             	movzbl (%eax),%eax
     676:	84 c0                	test   %al,%al
     678:	75 e2                	jne    65c <strcpy+0x11>
    ;
  return os;
     67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     67d:	c9                   	leave  
     67e:	c3                   	ret    

0000067f <strcmp>:

int
strcmp(const char *p, const char *q)
{
     67f:	f3 0f 1e fb          	endbr32 
     683:	55                   	push   %ebp
     684:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     686:	eb 08                	jmp    690 <strcmp+0x11>
    p++, q++;
     688:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     68c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     690:	8b 45 08             	mov    0x8(%ebp),%eax
     693:	0f b6 00             	movzbl (%eax),%eax
     696:	84 c0                	test   %al,%al
     698:	74 10                	je     6aa <strcmp+0x2b>
     69a:	8b 45 08             	mov    0x8(%ebp),%eax
     69d:	0f b6 10             	movzbl (%eax),%edx
     6a0:	8b 45 0c             	mov    0xc(%ebp),%eax
     6a3:	0f b6 00             	movzbl (%eax),%eax
     6a6:	38 c2                	cmp    %al,%dl
     6a8:	74 de                	je     688 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
     6aa:	8b 45 08             	mov    0x8(%ebp),%eax
     6ad:	0f b6 00             	movzbl (%eax),%eax
     6b0:	0f b6 d0             	movzbl %al,%edx
     6b3:	8b 45 0c             	mov    0xc(%ebp),%eax
     6b6:	0f b6 00             	movzbl (%eax),%eax
     6b9:	0f b6 c0             	movzbl %al,%eax
     6bc:	29 c2                	sub    %eax,%edx
     6be:	89 d0                	mov    %edx,%eax
}
     6c0:	5d                   	pop    %ebp
     6c1:	c3                   	ret    

000006c2 <strlen>:

uint
strlen(char *s)
{
     6c2:	f3 0f 1e fb          	endbr32 
     6c6:	55                   	push   %ebp
     6c7:	89 e5                	mov    %esp,%ebp
     6c9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     6cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     6d3:	eb 04                	jmp    6d9 <strlen+0x17>
     6d5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     6d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     6dc:	8b 45 08             	mov    0x8(%ebp),%eax
     6df:	01 d0                	add    %edx,%eax
     6e1:	0f b6 00             	movzbl (%eax),%eax
     6e4:	84 c0                	test   %al,%al
     6e6:	75 ed                	jne    6d5 <strlen+0x13>
    ;
  return n;
     6e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     6eb:	c9                   	leave  
     6ec:	c3                   	ret    

000006ed <memset>:

void*
memset(void *dst, int c, uint n)
{
     6ed:	f3 0f 1e fb          	endbr32 
     6f1:	55                   	push   %ebp
     6f2:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     6f4:	8b 45 10             	mov    0x10(%ebp),%eax
     6f7:	50                   	push   %eax
     6f8:	ff 75 0c             	pushl  0xc(%ebp)
     6fb:	ff 75 08             	pushl  0x8(%ebp)
     6fe:	e8 22 ff ff ff       	call   625 <stosb>
     703:	83 c4 0c             	add    $0xc,%esp
  return dst;
     706:	8b 45 08             	mov    0x8(%ebp),%eax
}
     709:	c9                   	leave  
     70a:	c3                   	ret    

0000070b <strchr>:

char*
strchr(const char *s, char c)
{
     70b:	f3 0f 1e fb          	endbr32 
     70f:	55                   	push   %ebp
     710:	89 e5                	mov    %esp,%ebp
     712:	83 ec 04             	sub    $0x4,%esp
     715:	8b 45 0c             	mov    0xc(%ebp),%eax
     718:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     71b:	eb 14                	jmp    731 <strchr+0x26>
    if(*s == c)
     71d:	8b 45 08             	mov    0x8(%ebp),%eax
     720:	0f b6 00             	movzbl (%eax),%eax
     723:	38 45 fc             	cmp    %al,-0x4(%ebp)
     726:	75 05                	jne    72d <strchr+0x22>
      return (char*)s;
     728:	8b 45 08             	mov    0x8(%ebp),%eax
     72b:	eb 13                	jmp    740 <strchr+0x35>
  for(; *s; s++)
     72d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     731:	8b 45 08             	mov    0x8(%ebp),%eax
     734:	0f b6 00             	movzbl (%eax),%eax
     737:	84 c0                	test   %al,%al
     739:	75 e2                	jne    71d <strchr+0x12>
  return 0;
     73b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     740:	c9                   	leave  
     741:	c3                   	ret    

00000742 <gets>:

char*
gets(char *buf, int max)
{
     742:	f3 0f 1e fb          	endbr32 
     746:	55                   	push   %ebp
     747:	89 e5                	mov    %esp,%ebp
     749:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     74c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     753:	eb 42                	jmp    797 <gets+0x55>
    cc = read(0, &c, 1);
     755:	83 ec 04             	sub    $0x4,%esp
     758:	6a 01                	push   $0x1
     75a:	8d 45 ef             	lea    -0x11(%ebp),%eax
     75d:	50                   	push   %eax
     75e:	6a 00                	push   $0x0
     760:	e8 9e 02 00 00       	call   a03 <read>
     765:	83 c4 10             	add    $0x10,%esp
     768:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     76b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     76f:	7e 33                	jle    7a4 <gets+0x62>
      break;
    buf[i++] = c;
     771:	8b 45 f4             	mov    -0xc(%ebp),%eax
     774:	8d 50 01             	lea    0x1(%eax),%edx
     777:	89 55 f4             	mov    %edx,-0xc(%ebp)
     77a:	89 c2                	mov    %eax,%edx
     77c:	8b 45 08             	mov    0x8(%ebp),%eax
     77f:	01 c2                	add    %eax,%edx
     781:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     785:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     787:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     78b:	3c 0a                	cmp    $0xa,%al
     78d:	74 16                	je     7a5 <gets+0x63>
     78f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     793:	3c 0d                	cmp    $0xd,%al
     795:	74 0e                	je     7a5 <gets+0x63>
  for(i=0; i+1 < max; ){
     797:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79a:	83 c0 01             	add    $0x1,%eax
     79d:	39 45 0c             	cmp    %eax,0xc(%ebp)
     7a0:	7f b3                	jg     755 <gets+0x13>
     7a2:	eb 01                	jmp    7a5 <gets+0x63>
      break;
     7a4:	90                   	nop
      break;
  }
  buf[i] = '\0';
     7a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     7a8:	8b 45 08             	mov    0x8(%ebp),%eax
     7ab:	01 d0                	add    %edx,%eax
     7ad:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     7b0:	8b 45 08             	mov    0x8(%ebp),%eax
}
     7b3:	c9                   	leave  
     7b4:	c3                   	ret    

000007b5 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
     7b5:	f3 0f 1e fb          	endbr32 
     7b9:	55                   	push   %ebp
     7ba:	89 e5                	mov    %esp,%ebp
     7bc:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
     7bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     7c6:	eb 43                	jmp    80b <fgets+0x56>
    int cc = read(fd, &c, 1);
     7c8:	83 ec 04             	sub    $0x4,%esp
     7cb:	6a 01                	push   $0x1
     7cd:	8d 45 ef             	lea    -0x11(%ebp),%eax
     7d0:	50                   	push   %eax
     7d1:	ff 75 10             	pushl  0x10(%ebp)
     7d4:	e8 2a 02 00 00       	call   a03 <read>
     7d9:	83 c4 10             	add    $0x10,%esp
     7dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     7df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7e3:	7e 33                	jle    818 <fgets+0x63>
      break;
    buf[i++] = c;
     7e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e8:	8d 50 01             	lea    0x1(%eax),%edx
     7eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
     7ee:	89 c2                	mov    %eax,%edx
     7f0:	8b 45 08             	mov    0x8(%ebp),%eax
     7f3:	01 c2                	add    %eax,%edx
     7f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     7f9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     7fb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     7ff:	3c 0a                	cmp    $0xa,%al
     801:	74 16                	je     819 <fgets+0x64>
     803:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     807:	3c 0d                	cmp    $0xd,%al
     809:	74 0e                	je     819 <fgets+0x64>
  for(i = 0; i + 1 < size;){
     80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80e:	83 c0 01             	add    $0x1,%eax
     811:	39 45 0c             	cmp    %eax,0xc(%ebp)
     814:	7f b2                	jg     7c8 <fgets+0x13>
     816:	eb 01                	jmp    819 <fgets+0x64>
      break;
     818:	90                   	nop
      break;
  }
  buf[i] = '\0';
     819:	8b 55 f4             	mov    -0xc(%ebp),%edx
     81c:	8b 45 08             	mov    0x8(%ebp),%eax
     81f:	01 d0                	add    %edx,%eax
     821:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     824:	8b 45 08             	mov    0x8(%ebp),%eax
}
     827:	c9                   	leave  
     828:	c3                   	ret    

00000829 <stat>:

int
stat(char *n, struct stat *st)
{
     829:	f3 0f 1e fb          	endbr32 
     82d:	55                   	push   %ebp
     82e:	89 e5                	mov    %esp,%ebp
     830:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     833:	83 ec 08             	sub    $0x8,%esp
     836:	6a 00                	push   $0x0
     838:	ff 75 08             	pushl  0x8(%ebp)
     83b:	e8 eb 01 00 00       	call   a2b <open>
     840:	83 c4 10             	add    $0x10,%esp
     843:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     846:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     84a:	79 07                	jns    853 <stat+0x2a>
    return -1;
     84c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     851:	eb 25                	jmp    878 <stat+0x4f>
  r = fstat(fd, st);
     853:	83 ec 08             	sub    $0x8,%esp
     856:	ff 75 0c             	pushl  0xc(%ebp)
     859:	ff 75 f4             	pushl  -0xc(%ebp)
     85c:	e8 e2 01 00 00       	call   a43 <fstat>
     861:	83 c4 10             	add    $0x10,%esp
     864:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     867:	83 ec 0c             	sub    $0xc,%esp
     86a:	ff 75 f4             	pushl  -0xc(%ebp)
     86d:	e8 a1 01 00 00       	call   a13 <close>
     872:	83 c4 10             	add    $0x10,%esp
  return r;
     875:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     878:	c9                   	leave  
     879:	c3                   	ret    

0000087a <atoi>:

int
atoi(const char *s)
{
     87a:	f3 0f 1e fb          	endbr32 
     87e:	55                   	push   %ebp
     87f:	89 e5                	mov    %esp,%ebp
     881:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     884:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     88b:	eb 04                	jmp    891 <atoi+0x17>
     88d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     891:	8b 45 08             	mov    0x8(%ebp),%eax
     894:	0f b6 00             	movzbl (%eax),%eax
     897:	3c 20                	cmp    $0x20,%al
     899:	74 f2                	je     88d <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
     89b:	8b 45 08             	mov    0x8(%ebp),%eax
     89e:	0f b6 00             	movzbl (%eax),%eax
     8a1:	3c 2d                	cmp    $0x2d,%al
     8a3:	75 07                	jne    8ac <atoi+0x32>
     8a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     8aa:	eb 05                	jmp    8b1 <atoi+0x37>
     8ac:	b8 01 00 00 00       	mov    $0x1,%eax
     8b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     8b4:	8b 45 08             	mov    0x8(%ebp),%eax
     8b7:	0f b6 00             	movzbl (%eax),%eax
     8ba:	3c 2b                	cmp    $0x2b,%al
     8bc:	74 0a                	je     8c8 <atoi+0x4e>
     8be:	8b 45 08             	mov    0x8(%ebp),%eax
     8c1:	0f b6 00             	movzbl (%eax),%eax
     8c4:	3c 2d                	cmp    $0x2d,%al
     8c6:	75 2b                	jne    8f3 <atoi+0x79>
    s++;
     8c8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     8cc:	eb 25                	jmp    8f3 <atoi+0x79>
    n = n*10 + *s++ - '0';
     8ce:	8b 55 fc             	mov    -0x4(%ebp),%edx
     8d1:	89 d0                	mov    %edx,%eax
     8d3:	c1 e0 02             	shl    $0x2,%eax
     8d6:	01 d0                	add    %edx,%eax
     8d8:	01 c0                	add    %eax,%eax
     8da:	89 c1                	mov    %eax,%ecx
     8dc:	8b 45 08             	mov    0x8(%ebp),%eax
     8df:	8d 50 01             	lea    0x1(%eax),%edx
     8e2:	89 55 08             	mov    %edx,0x8(%ebp)
     8e5:	0f b6 00             	movzbl (%eax),%eax
     8e8:	0f be c0             	movsbl %al,%eax
     8eb:	01 c8                	add    %ecx,%eax
     8ed:	83 e8 30             	sub    $0x30,%eax
     8f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     8f3:	8b 45 08             	mov    0x8(%ebp),%eax
     8f6:	0f b6 00             	movzbl (%eax),%eax
     8f9:	3c 2f                	cmp    $0x2f,%al
     8fb:	7e 0a                	jle    907 <atoi+0x8d>
     8fd:	8b 45 08             	mov    0x8(%ebp),%eax
     900:	0f b6 00             	movzbl (%eax),%eax
     903:	3c 39                	cmp    $0x39,%al
     905:	7e c7                	jle    8ce <atoi+0x54>
  return sign*n;
     907:	8b 45 f8             	mov    -0x8(%ebp),%eax
     90a:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     90e:	c9                   	leave  
     90f:	c3                   	ret    

00000910 <atoo>:

int
atoo(const char *s)
{
     910:	f3 0f 1e fb          	endbr32 
     914:	55                   	push   %ebp
     915:	89 e5                	mov    %esp,%ebp
     917:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     91a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     921:	eb 04                	jmp    927 <atoo+0x17>
     923:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     927:	8b 45 08             	mov    0x8(%ebp),%eax
     92a:	0f b6 00             	movzbl (%eax),%eax
     92d:	3c 20                	cmp    $0x20,%al
     92f:	74 f2                	je     923 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
     931:	8b 45 08             	mov    0x8(%ebp),%eax
     934:	0f b6 00             	movzbl (%eax),%eax
     937:	3c 2d                	cmp    $0x2d,%al
     939:	75 07                	jne    942 <atoo+0x32>
     93b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     940:	eb 05                	jmp    947 <atoo+0x37>
     942:	b8 01 00 00 00       	mov    $0x1,%eax
     947:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     94a:	8b 45 08             	mov    0x8(%ebp),%eax
     94d:	0f b6 00             	movzbl (%eax),%eax
     950:	3c 2b                	cmp    $0x2b,%al
     952:	74 0a                	je     95e <atoo+0x4e>
     954:	8b 45 08             	mov    0x8(%ebp),%eax
     957:	0f b6 00             	movzbl (%eax),%eax
     95a:	3c 2d                	cmp    $0x2d,%al
     95c:	75 27                	jne    985 <atoo+0x75>
    s++;
     95e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     962:	eb 21                	jmp    985 <atoo+0x75>
    n = n*8 + *s++ - '0';
     964:	8b 45 fc             	mov    -0x4(%ebp),%eax
     967:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     96e:	8b 45 08             	mov    0x8(%ebp),%eax
     971:	8d 50 01             	lea    0x1(%eax),%edx
     974:	89 55 08             	mov    %edx,0x8(%ebp)
     977:	0f b6 00             	movzbl (%eax),%eax
     97a:	0f be c0             	movsbl %al,%eax
     97d:	01 c8                	add    %ecx,%eax
     97f:	83 e8 30             	sub    $0x30,%eax
     982:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
     985:	8b 45 08             	mov    0x8(%ebp),%eax
     988:	0f b6 00             	movzbl (%eax),%eax
     98b:	3c 2f                	cmp    $0x2f,%al
     98d:	7e 0a                	jle    999 <atoo+0x89>
     98f:	8b 45 08             	mov    0x8(%ebp),%eax
     992:	0f b6 00             	movzbl (%eax),%eax
     995:	3c 37                	cmp    $0x37,%al
     997:	7e cb                	jle    964 <atoo+0x54>
  return sign*n;
     999:	8b 45 f8             	mov    -0x8(%ebp),%eax
     99c:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     9a0:	c9                   	leave  
     9a1:	c3                   	ret    

000009a2 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     9a2:	f3 0f 1e fb          	endbr32 
     9a6:	55                   	push   %ebp
     9a7:	89 e5                	mov    %esp,%ebp
     9a9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     9ac:	8b 45 08             	mov    0x8(%ebp),%eax
     9af:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     9b2:	8b 45 0c             	mov    0xc(%ebp),%eax
     9b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     9b8:	eb 17                	jmp    9d1 <memmove+0x2f>
    *dst++ = *src++;
     9ba:	8b 55 f8             	mov    -0x8(%ebp),%edx
     9bd:	8d 42 01             	lea    0x1(%edx),%eax
     9c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
     9c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     9c6:	8d 48 01             	lea    0x1(%eax),%ecx
     9c9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     9cc:	0f b6 12             	movzbl (%edx),%edx
     9cf:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     9d1:	8b 45 10             	mov    0x10(%ebp),%eax
     9d4:	8d 50 ff             	lea    -0x1(%eax),%edx
     9d7:	89 55 10             	mov    %edx,0x10(%ebp)
     9da:	85 c0                	test   %eax,%eax
     9dc:	7f dc                	jg     9ba <memmove+0x18>
  return vdst;
     9de:	8b 45 08             	mov    0x8(%ebp),%eax
}
     9e1:	c9                   	leave  
     9e2:	c3                   	ret    

000009e3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     9e3:	b8 01 00 00 00       	mov    $0x1,%eax
     9e8:	cd 40                	int    $0x40
     9ea:	c3                   	ret    

000009eb <exit>:
SYSCALL(exit)
     9eb:	b8 02 00 00 00       	mov    $0x2,%eax
     9f0:	cd 40                	int    $0x40
     9f2:	c3                   	ret    

000009f3 <wait>:
SYSCALL(wait)
     9f3:	b8 03 00 00 00       	mov    $0x3,%eax
     9f8:	cd 40                	int    $0x40
     9fa:	c3                   	ret    

000009fb <pipe>:
SYSCALL(pipe)
     9fb:	b8 04 00 00 00       	mov    $0x4,%eax
     a00:	cd 40                	int    $0x40
     a02:	c3                   	ret    

00000a03 <read>:
SYSCALL(read)
     a03:	b8 05 00 00 00       	mov    $0x5,%eax
     a08:	cd 40                	int    $0x40
     a0a:	c3                   	ret    

00000a0b <write>:
SYSCALL(write)
     a0b:	b8 10 00 00 00       	mov    $0x10,%eax
     a10:	cd 40                	int    $0x40
     a12:	c3                   	ret    

00000a13 <close>:
SYSCALL(close)
     a13:	b8 15 00 00 00       	mov    $0x15,%eax
     a18:	cd 40                	int    $0x40
     a1a:	c3                   	ret    

00000a1b <kill>:
SYSCALL(kill)
     a1b:	b8 06 00 00 00       	mov    $0x6,%eax
     a20:	cd 40                	int    $0x40
     a22:	c3                   	ret    

00000a23 <exec>:
SYSCALL(exec)
     a23:	b8 07 00 00 00       	mov    $0x7,%eax
     a28:	cd 40                	int    $0x40
     a2a:	c3                   	ret    

00000a2b <open>:
SYSCALL(open)
     a2b:	b8 0f 00 00 00       	mov    $0xf,%eax
     a30:	cd 40                	int    $0x40
     a32:	c3                   	ret    

00000a33 <mknod>:
SYSCALL(mknod)
     a33:	b8 11 00 00 00       	mov    $0x11,%eax
     a38:	cd 40                	int    $0x40
     a3a:	c3                   	ret    

00000a3b <unlink>:
SYSCALL(unlink)
     a3b:	b8 12 00 00 00       	mov    $0x12,%eax
     a40:	cd 40                	int    $0x40
     a42:	c3                   	ret    

00000a43 <fstat>:
SYSCALL(fstat)
     a43:	b8 08 00 00 00       	mov    $0x8,%eax
     a48:	cd 40                	int    $0x40
     a4a:	c3                   	ret    

00000a4b <link>:
SYSCALL(link)
     a4b:	b8 13 00 00 00       	mov    $0x13,%eax
     a50:	cd 40                	int    $0x40
     a52:	c3                   	ret    

00000a53 <mkdir>:
SYSCALL(mkdir)
     a53:	b8 14 00 00 00       	mov    $0x14,%eax
     a58:	cd 40                	int    $0x40
     a5a:	c3                   	ret    

00000a5b <chdir>:
SYSCALL(chdir)
     a5b:	b8 09 00 00 00       	mov    $0x9,%eax
     a60:	cd 40                	int    $0x40
     a62:	c3                   	ret    

00000a63 <dup>:
SYSCALL(dup)
     a63:	b8 0a 00 00 00       	mov    $0xa,%eax
     a68:	cd 40                	int    $0x40
     a6a:	c3                   	ret    

00000a6b <getpid>:
SYSCALL(getpid)
     a6b:	b8 0b 00 00 00       	mov    $0xb,%eax
     a70:	cd 40                	int    $0x40
     a72:	c3                   	ret    

00000a73 <sbrk>:
SYSCALL(sbrk)
     a73:	b8 0c 00 00 00       	mov    $0xc,%eax
     a78:	cd 40                	int    $0x40
     a7a:	c3                   	ret    

00000a7b <sleep>:
SYSCALL(sleep)
     a7b:	b8 0d 00 00 00       	mov    $0xd,%eax
     a80:	cd 40                	int    $0x40
     a82:	c3                   	ret    

00000a83 <uptime>:
SYSCALL(uptime)
     a83:	b8 0e 00 00 00       	mov    $0xe,%eax
     a88:	cd 40                	int    $0x40
     a8a:	c3                   	ret    

00000a8b <halt>:
SYSCALL(halt)
     a8b:	b8 16 00 00 00       	mov    $0x16,%eax
     a90:	cd 40                	int    $0x40
     a92:	c3                   	ret    

00000a93 <date>:
SYSCALL(date)
     a93:	b8 17 00 00 00       	mov    $0x17,%eax
     a98:	cd 40                	int    $0x40
     a9a:	c3                   	ret    

00000a9b <getuid>:
SYSCALL(getuid)
     a9b:	b8 18 00 00 00       	mov    $0x18,%eax
     aa0:	cd 40                	int    $0x40
     aa2:	c3                   	ret    

00000aa3 <getgid>:
SYSCALL(getgid)
     aa3:	b8 19 00 00 00       	mov    $0x19,%eax
     aa8:	cd 40                	int    $0x40
     aaa:	c3                   	ret    

00000aab <getppid>:
SYSCALL(getppid)
     aab:	b8 1a 00 00 00       	mov    $0x1a,%eax
     ab0:	cd 40                	int    $0x40
     ab2:	c3                   	ret    

00000ab3 <setuid>:
SYSCALL(setuid)
     ab3:	b8 1b 00 00 00       	mov    $0x1b,%eax
     ab8:	cd 40                	int    $0x40
     aba:	c3                   	ret    

00000abb <setgid>:
SYSCALL(setgid)
     abb:	b8 1c 00 00 00       	mov    $0x1c,%eax
     ac0:	cd 40                	int    $0x40
     ac2:	c3                   	ret    

00000ac3 <getprocs>:
SYSCALL(getprocs)
     ac3:	b8 1d 00 00 00       	mov    $0x1d,%eax
     ac8:	cd 40                	int    $0x40
     aca:	c3                   	ret    

00000acb <setpriority>:
SYSCALL(setpriority)
     acb:	b8 1e 00 00 00       	mov    $0x1e,%eax
     ad0:	cd 40                	int    $0x40
     ad2:	c3                   	ret    

00000ad3 <chown>:
SYSCALL(chown)
     ad3:	b8 1f 00 00 00       	mov    $0x1f,%eax
     ad8:	cd 40                	int    $0x40
     ada:	c3                   	ret    

00000adb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     adb:	f3 0f 1e fb          	endbr32 
     adf:	55                   	push   %ebp
     ae0:	89 e5                	mov    %esp,%ebp
     ae2:	83 ec 18             	sub    $0x18,%esp
     ae5:	8b 45 0c             	mov    0xc(%ebp),%eax
     ae8:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     aeb:	83 ec 04             	sub    $0x4,%esp
     aee:	6a 01                	push   $0x1
     af0:	8d 45 f4             	lea    -0xc(%ebp),%eax
     af3:	50                   	push   %eax
     af4:	ff 75 08             	pushl  0x8(%ebp)
     af7:	e8 0f ff ff ff       	call   a0b <write>
     afc:	83 c4 10             	add    $0x10,%esp
}
     aff:	90                   	nop
     b00:	c9                   	leave  
     b01:	c3                   	ret    

00000b02 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     b02:	f3 0f 1e fb          	endbr32 
     b06:	55                   	push   %ebp
     b07:	89 e5                	mov    %esp,%ebp
     b09:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     b0c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     b13:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     b17:	74 17                	je     b30 <printint+0x2e>
     b19:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     b1d:	79 11                	jns    b30 <printint+0x2e>
    neg = 1;
     b1f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     b26:	8b 45 0c             	mov    0xc(%ebp),%eax
     b29:	f7 d8                	neg    %eax
     b2b:	89 45 ec             	mov    %eax,-0x14(%ebp)
     b2e:	eb 06                	jmp    b36 <printint+0x34>
  } else {
    x = xx;
     b30:	8b 45 0c             	mov    0xc(%ebp),%eax
     b33:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     b36:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     b3d:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b40:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b43:	ba 00 00 00 00       	mov    $0x0,%edx
     b48:	f7 f1                	div    %ecx
     b4a:	89 d1                	mov    %edx,%ecx
     b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b4f:	8d 50 01             	lea    0x1(%eax),%edx
     b52:	89 55 f4             	mov    %edx,-0xc(%ebp)
     b55:	0f b6 91 f8 19 00 00 	movzbl 0x19f8(%ecx),%edx
     b5c:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     b60:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b63:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b66:	ba 00 00 00 00       	mov    $0x0,%edx
     b6b:	f7 f1                	div    %ecx
     b6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     b70:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     b74:	75 c7                	jne    b3d <printint+0x3b>
  if(neg)
     b76:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     b7a:	74 2d                	je     ba9 <printint+0xa7>
    buf[i++] = '-';
     b7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b7f:	8d 50 01             	lea    0x1(%eax),%edx
     b82:	89 55 f4             	mov    %edx,-0xc(%ebp)
     b85:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     b8a:	eb 1d                	jmp    ba9 <printint+0xa7>
    putc(fd, buf[i]);
     b8c:	8d 55 dc             	lea    -0x24(%ebp),%edx
     b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     b92:	01 d0                	add    %edx,%eax
     b94:	0f b6 00             	movzbl (%eax),%eax
     b97:	0f be c0             	movsbl %al,%eax
     b9a:	83 ec 08             	sub    $0x8,%esp
     b9d:	50                   	push   %eax
     b9e:	ff 75 08             	pushl  0x8(%ebp)
     ba1:	e8 35 ff ff ff       	call   adb <putc>
     ba6:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     ba9:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     bad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bb1:	79 d9                	jns    b8c <printint+0x8a>
}
     bb3:	90                   	nop
     bb4:	90                   	nop
     bb5:	c9                   	leave  
     bb6:	c3                   	ret    

00000bb7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     bb7:	f3 0f 1e fb          	endbr32 
     bbb:	55                   	push   %ebp
     bbc:	89 e5                	mov    %esp,%ebp
     bbe:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     bc1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     bc8:	8d 45 0c             	lea    0xc(%ebp),%eax
     bcb:	83 c0 04             	add    $0x4,%eax
     bce:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     bd1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     bd8:	e9 59 01 00 00       	jmp    d36 <printf+0x17f>
    c = fmt[i] & 0xff;
     bdd:	8b 55 0c             	mov    0xc(%ebp),%edx
     be0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     be3:	01 d0                	add    %edx,%eax
     be5:	0f b6 00             	movzbl (%eax),%eax
     be8:	0f be c0             	movsbl %al,%eax
     beb:	25 ff 00 00 00       	and    $0xff,%eax
     bf0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     bf3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bf7:	75 2c                	jne    c25 <printf+0x6e>
      if(c == '%'){
     bf9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     bfd:	75 0c                	jne    c0b <printf+0x54>
        state = '%';
     bff:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     c06:	e9 27 01 00 00       	jmp    d32 <printf+0x17b>
      } else {
        putc(fd, c);
     c0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c0e:	0f be c0             	movsbl %al,%eax
     c11:	83 ec 08             	sub    $0x8,%esp
     c14:	50                   	push   %eax
     c15:	ff 75 08             	pushl  0x8(%ebp)
     c18:	e8 be fe ff ff       	call   adb <putc>
     c1d:	83 c4 10             	add    $0x10,%esp
     c20:	e9 0d 01 00 00       	jmp    d32 <printf+0x17b>
      }
    } else if(state == '%'){
     c25:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     c29:	0f 85 03 01 00 00    	jne    d32 <printf+0x17b>
      if(c == 'd'){
     c2f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     c33:	75 1e                	jne    c53 <printf+0x9c>
        printint(fd, *ap, 10, 1);
     c35:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c38:	8b 00                	mov    (%eax),%eax
     c3a:	6a 01                	push   $0x1
     c3c:	6a 0a                	push   $0xa
     c3e:	50                   	push   %eax
     c3f:	ff 75 08             	pushl  0x8(%ebp)
     c42:	e8 bb fe ff ff       	call   b02 <printint>
     c47:	83 c4 10             	add    $0x10,%esp
        ap++;
     c4a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     c4e:	e9 d8 00 00 00       	jmp    d2b <printf+0x174>
      } else if(c == 'x' || c == 'p'){
     c53:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     c57:	74 06                	je     c5f <printf+0xa8>
     c59:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     c5d:	75 1e                	jne    c7d <printf+0xc6>
        printint(fd, *ap, 16, 0);
     c5f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c62:	8b 00                	mov    (%eax),%eax
     c64:	6a 00                	push   $0x0
     c66:	6a 10                	push   $0x10
     c68:	50                   	push   %eax
     c69:	ff 75 08             	pushl  0x8(%ebp)
     c6c:	e8 91 fe ff ff       	call   b02 <printint>
     c71:	83 c4 10             	add    $0x10,%esp
        ap++;
     c74:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     c78:	e9 ae 00 00 00       	jmp    d2b <printf+0x174>
      } else if(c == 's'){
     c7d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     c81:	75 43                	jne    cc6 <printf+0x10f>
        s = (char*)*ap;
     c83:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c86:	8b 00                	mov    (%eax),%eax
     c88:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     c8b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     c8f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c93:	75 25                	jne    cba <printf+0x103>
          s = "(null)";
     c95:	c7 45 f4 51 15 00 00 	movl   $0x1551,-0xc(%ebp)
        while(*s != 0){
     c9c:	eb 1c                	jmp    cba <printf+0x103>
          putc(fd, *s);
     c9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ca1:	0f b6 00             	movzbl (%eax),%eax
     ca4:	0f be c0             	movsbl %al,%eax
     ca7:	83 ec 08             	sub    $0x8,%esp
     caa:	50                   	push   %eax
     cab:	ff 75 08             	pushl  0x8(%ebp)
     cae:	e8 28 fe ff ff       	call   adb <putc>
     cb3:	83 c4 10             	add    $0x10,%esp
          s++;
     cb6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cbd:	0f b6 00             	movzbl (%eax),%eax
     cc0:	84 c0                	test   %al,%al
     cc2:	75 da                	jne    c9e <printf+0xe7>
     cc4:	eb 65                	jmp    d2b <printf+0x174>
        }
      } else if(c == 'c'){
     cc6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     cca:	75 1d                	jne    ce9 <printf+0x132>
        putc(fd, *ap);
     ccc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ccf:	8b 00                	mov    (%eax),%eax
     cd1:	0f be c0             	movsbl %al,%eax
     cd4:	83 ec 08             	sub    $0x8,%esp
     cd7:	50                   	push   %eax
     cd8:	ff 75 08             	pushl  0x8(%ebp)
     cdb:	e8 fb fd ff ff       	call   adb <putc>
     ce0:	83 c4 10             	add    $0x10,%esp
        ap++;
     ce3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     ce7:	eb 42                	jmp    d2b <printf+0x174>
      } else if(c == '%'){
     ce9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     ced:	75 17                	jne    d06 <printf+0x14f>
        putc(fd, c);
     cef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cf2:	0f be c0             	movsbl %al,%eax
     cf5:	83 ec 08             	sub    $0x8,%esp
     cf8:	50                   	push   %eax
     cf9:	ff 75 08             	pushl  0x8(%ebp)
     cfc:	e8 da fd ff ff       	call   adb <putc>
     d01:	83 c4 10             	add    $0x10,%esp
     d04:	eb 25                	jmp    d2b <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     d06:	83 ec 08             	sub    $0x8,%esp
     d09:	6a 25                	push   $0x25
     d0b:	ff 75 08             	pushl  0x8(%ebp)
     d0e:	e8 c8 fd ff ff       	call   adb <putc>
     d13:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     d16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     d19:	0f be c0             	movsbl %al,%eax
     d1c:	83 ec 08             	sub    $0x8,%esp
     d1f:	50                   	push   %eax
     d20:	ff 75 08             	pushl  0x8(%ebp)
     d23:	e8 b3 fd ff ff       	call   adb <putc>
     d28:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     d2b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     d32:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     d36:	8b 55 0c             	mov    0xc(%ebp),%edx
     d39:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d3c:	01 d0                	add    %edx,%eax
     d3e:	0f b6 00             	movzbl (%eax),%eax
     d41:	84 c0                	test   %al,%al
     d43:	0f 85 94 fe ff ff    	jne    bdd <printf+0x26>
    }
  }
}
     d49:	90                   	nop
     d4a:	90                   	nop
     d4b:	c9                   	leave  
     d4c:	c3                   	ret    

00000d4d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     d4d:	f3 0f 1e fb          	endbr32 
     d51:	55                   	push   %ebp
     d52:	89 e5                	mov    %esp,%ebp
     d54:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     d57:	8b 45 08             	mov    0x8(%ebp),%eax
     d5a:	83 e8 08             	sub    $0x8,%eax
     d5d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d60:	a1 38 1a 00 00       	mov    0x1a38,%eax
     d65:	89 45 fc             	mov    %eax,-0x4(%ebp)
     d68:	eb 24                	jmp    d8e <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     d6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d6d:	8b 00                	mov    (%eax),%eax
     d6f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     d72:	72 12                	jb     d86 <free+0x39>
     d74:	8b 45 f8             	mov    -0x8(%ebp),%eax
     d77:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d7a:	77 24                	ja     da0 <free+0x53>
     d7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d7f:	8b 00                	mov    (%eax),%eax
     d81:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     d84:	72 1a                	jb     da0 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d86:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d89:	8b 00                	mov    (%eax),%eax
     d8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
     d8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     d91:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     d94:	76 d4                	jbe    d6a <free+0x1d>
     d96:	8b 45 fc             	mov    -0x4(%ebp),%eax
     d99:	8b 00                	mov    (%eax),%eax
     d9b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     d9e:	73 ca                	jae    d6a <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
     da0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     da3:	8b 40 04             	mov    0x4(%eax),%eax
     da6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     dad:	8b 45 f8             	mov    -0x8(%ebp),%eax
     db0:	01 c2                	add    %eax,%edx
     db2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     db5:	8b 00                	mov    (%eax),%eax
     db7:	39 c2                	cmp    %eax,%edx
     db9:	75 24                	jne    ddf <free+0x92>
    bp->s.size += p->s.ptr->s.size;
     dbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     dbe:	8b 50 04             	mov    0x4(%eax),%edx
     dc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     dc4:	8b 00                	mov    (%eax),%eax
     dc6:	8b 40 04             	mov    0x4(%eax),%eax
     dc9:	01 c2                	add    %eax,%edx
     dcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     dce:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     dd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     dd4:	8b 00                	mov    (%eax),%eax
     dd6:	8b 10                	mov    (%eax),%edx
     dd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     ddb:	89 10                	mov    %edx,(%eax)
     ddd:	eb 0a                	jmp    de9 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
     ddf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     de2:	8b 10                	mov    (%eax),%edx
     de4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     de7:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     de9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     dec:	8b 40 04             	mov    0x4(%eax),%eax
     def:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     df6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     df9:	01 d0                	add    %edx,%eax
     dfb:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     dfe:	75 20                	jne    e20 <free+0xd3>
    p->s.size += bp->s.size;
     e00:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e03:	8b 50 04             	mov    0x4(%eax),%edx
     e06:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e09:	8b 40 04             	mov    0x4(%eax),%eax
     e0c:	01 c2                	add    %eax,%edx
     e0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e11:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     e14:	8b 45 f8             	mov    -0x8(%ebp),%eax
     e17:	8b 10                	mov    (%eax),%edx
     e19:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e1c:	89 10                	mov    %edx,(%eax)
     e1e:	eb 08                	jmp    e28 <free+0xdb>
  } else
    p->s.ptr = bp;
     e20:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e23:	8b 55 f8             	mov    -0x8(%ebp),%edx
     e26:	89 10                	mov    %edx,(%eax)
  freep = p;
     e28:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e2b:	a3 38 1a 00 00       	mov    %eax,0x1a38
}
     e30:	90                   	nop
     e31:	c9                   	leave  
     e32:	c3                   	ret    

00000e33 <morecore>:

static Header*
morecore(uint nu)
{
     e33:	f3 0f 1e fb          	endbr32 
     e37:	55                   	push   %ebp
     e38:	89 e5                	mov    %esp,%ebp
     e3a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     e3d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     e44:	77 07                	ja     e4d <morecore+0x1a>
    nu = 4096;
     e46:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     e4d:	8b 45 08             	mov    0x8(%ebp),%eax
     e50:	c1 e0 03             	shl    $0x3,%eax
     e53:	83 ec 0c             	sub    $0xc,%esp
     e56:	50                   	push   %eax
     e57:	e8 17 fc ff ff       	call   a73 <sbrk>
     e5c:	83 c4 10             	add    $0x10,%esp
     e5f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     e62:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     e66:	75 07                	jne    e6f <morecore+0x3c>
    return 0;
     e68:	b8 00 00 00 00       	mov    $0x0,%eax
     e6d:	eb 26                	jmp    e95 <morecore+0x62>
  hp = (Header*)p;
     e6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     e72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     e75:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e78:	8b 55 08             	mov    0x8(%ebp),%edx
     e7b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     e7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e81:	83 c0 08             	add    $0x8,%eax
     e84:	83 ec 0c             	sub    $0xc,%esp
     e87:	50                   	push   %eax
     e88:	e8 c0 fe ff ff       	call   d4d <free>
     e8d:	83 c4 10             	add    $0x10,%esp
  return freep;
     e90:	a1 38 1a 00 00       	mov    0x1a38,%eax
}
     e95:	c9                   	leave  
     e96:	c3                   	ret    

00000e97 <malloc>:

void*
malloc(uint nbytes)
{
     e97:	f3 0f 1e fb          	endbr32 
     e9b:	55                   	push   %ebp
     e9c:	89 e5                	mov    %esp,%ebp
     e9e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     ea1:	8b 45 08             	mov    0x8(%ebp),%eax
     ea4:	83 c0 07             	add    $0x7,%eax
     ea7:	c1 e8 03             	shr    $0x3,%eax
     eaa:	83 c0 01             	add    $0x1,%eax
     ead:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     eb0:	a1 38 1a 00 00       	mov    0x1a38,%eax
     eb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     eb8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ebc:	75 23                	jne    ee1 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
     ebe:	c7 45 f0 30 1a 00 00 	movl   $0x1a30,-0x10(%ebp)
     ec5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ec8:	a3 38 1a 00 00       	mov    %eax,0x1a38
     ecd:	a1 38 1a 00 00       	mov    0x1a38,%eax
     ed2:	a3 30 1a 00 00       	mov    %eax,0x1a30
    base.s.size = 0;
     ed7:	c7 05 34 1a 00 00 00 	movl   $0x0,0x1a34
     ede:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ee1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ee4:	8b 00                	mov    (%eax),%eax
     ee6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     ee9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     eec:	8b 40 04             	mov    0x4(%eax),%eax
     eef:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     ef2:	77 4d                	ja     f41 <malloc+0xaa>
      if(p->s.size == nunits)
     ef4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ef7:	8b 40 04             	mov    0x4(%eax),%eax
     efa:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     efd:	75 0c                	jne    f0b <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
     eff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f02:	8b 10                	mov    (%eax),%edx
     f04:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f07:	89 10                	mov    %edx,(%eax)
     f09:	eb 26                	jmp    f31 <malloc+0x9a>
      else {
        p->s.size -= nunits;
     f0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f0e:	8b 40 04             	mov    0x4(%eax),%eax
     f11:	2b 45 ec             	sub    -0x14(%ebp),%eax
     f14:	89 c2                	mov    %eax,%edx
     f16:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f19:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     f1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f1f:	8b 40 04             	mov    0x4(%eax),%eax
     f22:	c1 e0 03             	shl    $0x3,%eax
     f25:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     f28:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f2b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     f2e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     f31:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f34:	a3 38 1a 00 00       	mov    %eax,0x1a38
      return (void*)(p + 1);
     f39:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f3c:	83 c0 08             	add    $0x8,%eax
     f3f:	eb 3b                	jmp    f7c <malloc+0xe5>
    }
    if(p == freep)
     f41:	a1 38 1a 00 00       	mov    0x1a38,%eax
     f46:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     f49:	75 1e                	jne    f69 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
     f4b:	83 ec 0c             	sub    $0xc,%esp
     f4e:	ff 75 ec             	pushl  -0x14(%ebp)
     f51:	e8 dd fe ff ff       	call   e33 <morecore>
     f56:	83 c4 10             	add    $0x10,%esp
     f59:	89 45 f4             	mov    %eax,-0xc(%ebp)
     f5c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     f60:	75 07                	jne    f69 <malloc+0xd2>
        return 0;
     f62:	b8 00 00 00 00       	mov    $0x0,%eax
     f67:	eb 13                	jmp    f7c <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f69:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f72:	8b 00                	mov    (%eax),%eax
     f74:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     f77:	e9 6d ff ff ff       	jmp    ee9 <malloc+0x52>
  }
}
     f7c:	c9                   	leave  
     f7d:	c3                   	ret    

00000f7e <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
     f7e:	f3 0f 1e fb          	endbr32 
     f82:	55                   	push   %ebp
     f83:	89 e5                	mov    %esp,%ebp
     f85:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
     f88:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
     f8f:	a1 80 1a 00 00       	mov    0x1a80,%eax
     f94:	83 ec 04             	sub    $0x4,%esp
     f97:	50                   	push   %eax
     f98:	6a 20                	push   $0x20
     f9a:	68 60 1a 00 00       	push   $0x1a60
     f9f:	e8 11 f8 ff ff       	call   7b5 <fgets>
     fa4:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
     fa7:	83 ec 0c             	sub    $0xc,%esp
     faa:	68 60 1a 00 00       	push   $0x1a60
     faf:	e8 0e f7 ff ff       	call   6c2 <strlen>
     fb4:	83 c4 10             	add    $0x10,%esp
     fb7:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
     fba:	8b 45 e8             	mov    -0x18(%ebp),%eax
     fbd:	83 e8 01             	sub    $0x1,%eax
     fc0:	0f b6 80 60 1a 00 00 	movzbl 0x1a60(%eax),%eax
     fc7:	3c 0a                	cmp    $0xa,%al
     fc9:	74 11                	je     fdc <get_id+0x5e>
     fcb:	8b 45 e8             	mov    -0x18(%ebp),%eax
     fce:	83 e8 01             	sub    $0x1,%eax
     fd1:	0f b6 80 60 1a 00 00 	movzbl 0x1a60(%eax),%eax
     fd8:	3c 0d                	cmp    $0xd,%al
     fda:	75 0d                	jne    fe9 <get_id+0x6b>
        current_line[len - 1] = 0;
     fdc:	8b 45 e8             	mov    -0x18(%ebp),%eax
     fdf:	83 e8 01             	sub    $0x1,%eax
     fe2:	c6 80 60 1a 00 00 00 	movb   $0x0,0x1a60(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
     fe9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
     ff0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     ff7:	eb 6c                	jmp    1065 <get_id+0xe7>
        if(current_line[i] == ' '){
     ff9:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ffc:	05 60 1a 00 00       	add    $0x1a60,%eax
    1001:	0f b6 00             	movzbl (%eax),%eax
    1004:	3c 20                	cmp    $0x20,%al
    1006:	75 30                	jne    1038 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
    1008:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    100c:	75 16                	jne    1024 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
    100e:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1011:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1014:	8d 50 01             	lea    0x1(%eax),%edx
    1017:	89 55 f0             	mov    %edx,-0x10(%ebp)
    101a:	8d 91 60 1a 00 00    	lea    0x1a60(%ecx),%edx
    1020:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
    1024:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1027:	05 60 1a 00 00       	add    $0x1a60,%eax
    102c:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
    102f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1036:	eb 29                	jmp    1061 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
    1038:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    103c:	75 23                	jne    1061 <get_id+0xe3>
    103e:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1042:	7f 1d                	jg     1061 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
    1044:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
    104b:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    104e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1051:	8d 50 01             	lea    0x1(%eax),%edx
    1054:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1057:	8d 91 60 1a 00 00    	lea    0x1a60(%ecx),%edx
    105d:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
    1061:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1065:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1068:	05 60 1a 00 00       	add    $0x1a60,%eax
    106d:	0f b6 00             	movzbl (%eax),%eax
    1070:	84 c0                	test   %al,%al
    1072:	75 85                	jne    ff9 <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
    1074:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1078:	75 07                	jne    1081 <get_id+0x103>
        return -1;
    107a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    107f:	eb 35                	jmp    10b6 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
    1081:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1084:	a3 40 1a 00 00       	mov    %eax,0x1a40
    current_id.uid_user = atoi(tokens[1]);
    1089:	8b 45 e0             	mov    -0x20(%ebp),%eax
    108c:	83 ec 0c             	sub    $0xc,%esp
    108f:	50                   	push   %eax
    1090:	e8 e5 f7 ff ff       	call   87a <atoi>
    1095:	83 c4 10             	add    $0x10,%esp
    1098:	a3 44 1a 00 00       	mov    %eax,0x1a44
    current_id.gid_user = atoi(tokens[2]);
    109d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    10a0:	83 ec 0c             	sub    $0xc,%esp
    10a3:	50                   	push   %eax
    10a4:	e8 d1 f7 ff ff       	call   87a <atoi>
    10a9:	83 c4 10             	add    $0x10,%esp
    10ac:	a3 48 1a 00 00       	mov    %eax,0x1a48

    return 0;
    10b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    10b6:	c9                   	leave  
    10b7:	c3                   	ret    

000010b8 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
    10b8:	f3 0f 1e fb          	endbr32 
    10bc:	55                   	push   %ebp
    10bd:	89 e5                	mov    %esp,%ebp
    10bf:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
    10c2:	a1 80 1a 00 00       	mov    0x1a80,%eax
    10c7:	85 c0                	test   %eax,%eax
    10c9:	75 31                	jne    10fc <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
    10cb:	83 ec 08             	sub    $0x8,%esp
    10ce:	6a 00                	push   $0x0
    10d0:	68 58 15 00 00       	push   $0x1558
    10d5:	e8 51 f9 ff ff       	call   a2b <open>
    10da:	83 c4 10             	add    $0x10,%esp
    10dd:	a3 80 1a 00 00       	mov    %eax,0x1a80

        if(dir < 0){        // kalau gagal membuka file
    10e2:	a1 80 1a 00 00       	mov    0x1a80,%eax
    10e7:	85 c0                	test   %eax,%eax
    10e9:	79 11                	jns    10fc <getid+0x44>
            dir = 0;
    10eb:	c7 05 80 1a 00 00 00 	movl   $0x0,0x1a80
    10f2:	00 00 00 
            return 0;
    10f5:	b8 00 00 00 00       	mov    $0x0,%eax
    10fa:	eb 16                	jmp    1112 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
    10fc:	e8 7d fe ff ff       	call   f7e <get_id>
    1101:	83 f8 ff             	cmp    $0xffffffff,%eax
    1104:	75 07                	jne    110d <getid+0x55>
        return 0;
    1106:	b8 00 00 00 00       	mov    $0x0,%eax
    110b:	eb 05                	jmp    1112 <getid+0x5a>
    
    return &current_id;
    110d:	b8 40 1a 00 00       	mov    $0x1a40,%eax
}
    1112:	c9                   	leave  
    1113:	c3                   	ret    

00001114 <setid>:

// open file_ids
void setid(void){
    1114:	f3 0f 1e fb          	endbr32 
    1118:	55                   	push   %ebp
    1119:	89 e5                	mov    %esp,%ebp
    111b:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    111e:	a1 80 1a 00 00       	mov    0x1a80,%eax
    1123:	85 c0                	test   %eax,%eax
    1125:	74 1b                	je     1142 <setid+0x2e>
        close(dir);
    1127:	a1 80 1a 00 00       	mov    0x1a80,%eax
    112c:	83 ec 0c             	sub    $0xc,%esp
    112f:	50                   	push   %eax
    1130:	e8 de f8 ff ff       	call   a13 <close>
    1135:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1138:	c7 05 80 1a 00 00 00 	movl   $0x0,0x1a80
    113f:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
    1142:	83 ec 08             	sub    $0x8,%esp
    1145:	6a 00                	push   $0x0
    1147:	68 58 15 00 00       	push   $0x1558
    114c:	e8 da f8 ff ff       	call   a2b <open>
    1151:	83 c4 10             	add    $0x10,%esp
    1154:	a3 80 1a 00 00       	mov    %eax,0x1a80

    if (dir < 0)
    1159:	a1 80 1a 00 00       	mov    0x1a80,%eax
    115e:	85 c0                	test   %eax,%eax
    1160:	79 0a                	jns    116c <setid+0x58>
        dir = 0;
    1162:	c7 05 80 1a 00 00 00 	movl   $0x0,0x1a80
    1169:	00 00 00 
}
    116c:	90                   	nop
    116d:	c9                   	leave  
    116e:	c3                   	ret    

0000116f <endid>:

// tutup file_ids
void endid (void){
    116f:	f3 0f 1e fb          	endbr32 
    1173:	55                   	push   %ebp
    1174:	89 e5                	mov    %esp,%ebp
    1176:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    1179:	a1 80 1a 00 00       	mov    0x1a80,%eax
    117e:	85 c0                	test   %eax,%eax
    1180:	74 1b                	je     119d <endid+0x2e>
        close(dir);
    1182:	a1 80 1a 00 00       	mov    0x1a80,%eax
    1187:	83 ec 0c             	sub    $0xc,%esp
    118a:	50                   	push   %eax
    118b:	e8 83 f8 ff ff       	call   a13 <close>
    1190:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1193:	c7 05 80 1a 00 00 00 	movl   $0x0,0x1a80
    119a:	00 00 00 
    }
}
    119d:	90                   	nop
    119e:	c9                   	leave  
    119f:	c3                   	ret    

000011a0 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
    11a0:	f3 0f 1e fb          	endbr32 
    11a4:	55                   	push   %ebp
    11a5:	89 e5                	mov    %esp,%ebp
    11a7:	83 ec 08             	sub    $0x8,%esp
    setid();
    11aa:	e8 65 ff ff ff       	call   1114 <setid>

    while (getid()){
    11af:	eb 24                	jmp    11d5 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
    11b1:	a1 40 1a 00 00       	mov    0x1a40,%eax
    11b6:	83 ec 08             	sub    $0x8,%esp
    11b9:	50                   	push   %eax
    11ba:	ff 75 08             	pushl  0x8(%ebp)
    11bd:	e8 bd f4 ff ff       	call   67f <strcmp>
    11c2:	83 c4 10             	add    $0x10,%esp
    11c5:	85 c0                	test   %eax,%eax
    11c7:	75 0c                	jne    11d5 <cek_nama+0x35>
            endid();
    11c9:	e8 a1 ff ff ff       	call   116f <endid>
            return &current_id;
    11ce:	b8 40 1a 00 00       	mov    $0x1a40,%eax
    11d3:	eb 13                	jmp    11e8 <cek_nama+0x48>
    while (getid()){
    11d5:	e8 de fe ff ff       	call   10b8 <getid>
    11da:	85 c0                	test   %eax,%eax
    11dc:	75 d3                	jne    11b1 <cek_nama+0x11>
        }
    }
    endid();
    11de:	e8 8c ff ff ff       	call   116f <endid>
    return 0;
    11e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11e8:	c9                   	leave  
    11e9:	c3                   	ret    

000011ea <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
    11ea:	f3 0f 1e fb          	endbr32 
    11ee:	55                   	push   %ebp
    11ef:	89 e5                	mov    %esp,%ebp
    11f1:	83 ec 08             	sub    $0x8,%esp
    setid();
    11f4:	e8 1b ff ff ff       	call   1114 <setid>

    while (getid()){
    11f9:	eb 16                	jmp    1211 <cek_uid+0x27>
        if(current_id.uid_user == uid){
    11fb:	a1 44 1a 00 00       	mov    0x1a44,%eax
    1200:	39 45 08             	cmp    %eax,0x8(%ebp)
    1203:	75 0c                	jne    1211 <cek_uid+0x27>
            endid();
    1205:	e8 65 ff ff ff       	call   116f <endid>
            return &current_id;
    120a:	b8 40 1a 00 00       	mov    $0x1a40,%eax
    120f:	eb 13                	jmp    1224 <cek_uid+0x3a>
    while (getid()){
    1211:	e8 a2 fe ff ff       	call   10b8 <getid>
    1216:	85 c0                	test   %eax,%eax
    1218:	75 e1                	jne    11fb <cek_uid+0x11>
        }
    }
    endid();
    121a:	e8 50 ff ff ff       	call   116f <endid>
    return 0;
    121f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1224:	c9                   	leave  
    1225:	c3                   	ret    

00001226 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
    1226:	f3 0f 1e fb          	endbr32 
    122a:	55                   	push   %ebp
    122b:	89 e5                	mov    %esp,%ebp
    122d:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
    1230:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
    1237:	a1 80 1a 00 00       	mov    0x1a80,%eax
    123c:	83 ec 04             	sub    $0x4,%esp
    123f:	50                   	push   %eax
    1240:	6a 20                	push   $0x20
    1242:	68 60 1a 00 00       	push   $0x1a60
    1247:	e8 69 f5 ff ff       	call   7b5 <fgets>
    124c:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
    124f:	83 ec 0c             	sub    $0xc,%esp
    1252:	68 60 1a 00 00       	push   $0x1a60
    1257:	e8 66 f4 ff ff       	call   6c2 <strlen>
    125c:	83 c4 10             	add    $0x10,%esp
    125f:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
    1262:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1265:	83 e8 01             	sub    $0x1,%eax
    1268:	0f b6 80 60 1a 00 00 	movzbl 0x1a60(%eax),%eax
    126f:	3c 0a                	cmp    $0xa,%al
    1271:	74 11                	je     1284 <get_group+0x5e>
    1273:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1276:	83 e8 01             	sub    $0x1,%eax
    1279:	0f b6 80 60 1a 00 00 	movzbl 0x1a60(%eax),%eax
    1280:	3c 0d                	cmp    $0xd,%al
    1282:	75 0d                	jne    1291 <get_group+0x6b>
        current_line[len - 1] = 0;
    1284:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1287:	83 e8 01             	sub    $0x1,%eax
    128a:	c6 80 60 1a 00 00 00 	movb   $0x0,0x1a60(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
    1291:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
    1298:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    129f:	eb 6c                	jmp    130d <get_group+0xe7>
        if(current_line[i] == ' '){
    12a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12a4:	05 60 1a 00 00       	add    $0x1a60,%eax
    12a9:	0f b6 00             	movzbl (%eax),%eax
    12ac:	3c 20                	cmp    $0x20,%al
    12ae:	75 30                	jne    12e0 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
    12b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12b4:	75 16                	jne    12cc <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
    12b6:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    12b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12bc:	8d 50 01             	lea    0x1(%eax),%edx
    12bf:	89 55 f0             	mov    %edx,-0x10(%ebp)
    12c2:	8d 91 60 1a 00 00    	lea    0x1a60(%ecx),%edx
    12c8:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
    12cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    12cf:	05 60 1a 00 00       	add    $0x1a60,%eax
    12d4:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
    12d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    12de:	eb 29                	jmp    1309 <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
    12e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12e4:	75 23                	jne    1309 <get_group+0xe3>
    12e6:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    12ea:	7f 1d                	jg     1309 <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
    12ec:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
    12f3:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    12f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12f9:	8d 50 01             	lea    0x1(%eax),%edx
    12fc:	89 55 f0             	mov    %edx,-0x10(%ebp)
    12ff:	8d 91 60 1a 00 00    	lea    0x1a60(%ecx),%edx
    1305:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
    1309:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    130d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1310:	05 60 1a 00 00       	add    $0x1a60,%eax
    1315:	0f b6 00             	movzbl (%eax),%eax
    1318:	84 c0                	test   %al,%al
    131a:	75 85                	jne    12a1 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
    131c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1320:	75 07                	jne    1329 <get_group+0x103>
        return -1;
    1322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1327:	eb 21                	jmp    134a <get_group+0x124>
    
    current_group.nama_group = tokens[0];
    1329:	8b 45 dc             	mov    -0x24(%ebp),%eax
    132c:	a3 4c 1a 00 00       	mov    %eax,0x1a4c
    current_group.gid = atoi(tokens[1]);
    1331:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1334:	83 ec 0c             	sub    $0xc,%esp
    1337:	50                   	push   %eax
    1338:	e8 3d f5 ff ff       	call   87a <atoi>
    133d:	83 c4 10             	add    $0x10,%esp
    1340:	a3 50 1a 00 00       	mov    %eax,0x1a50

    return 0;
    1345:	b8 00 00 00 00       	mov    $0x0,%eax
}
    134a:	c9                   	leave  
    134b:	c3                   	ret    

0000134c <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
    134c:	f3 0f 1e fb          	endbr32 
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
    1356:	a1 80 1a 00 00       	mov    0x1a80,%eax
    135b:	85 c0                	test   %eax,%eax
    135d:	75 31                	jne    1390 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
    135f:	83 ec 08             	sub    $0x8,%esp
    1362:	6a 00                	push   $0x0
    1364:	68 60 15 00 00       	push   $0x1560
    1369:	e8 bd f6 ff ff       	call   a2b <open>
    136e:	83 c4 10             	add    $0x10,%esp
    1371:	a3 80 1a 00 00       	mov    %eax,0x1a80

        if(dir < 0){        // kalau gagal membuka file
    1376:	a1 80 1a 00 00       	mov    0x1a80,%eax
    137b:	85 c0                	test   %eax,%eax
    137d:	79 11                	jns    1390 <getgroup+0x44>
            dir = 0;
    137f:	c7 05 80 1a 00 00 00 	movl   $0x0,0x1a80
    1386:	00 00 00 
            return 0;
    1389:	b8 00 00 00 00       	mov    $0x0,%eax
    138e:	eb 16                	jmp    13a6 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
    1390:	e8 91 fe ff ff       	call   1226 <get_group>
    1395:	83 f8 ff             	cmp    $0xffffffff,%eax
    1398:	75 07                	jne    13a1 <getgroup+0x55>
        return 0;
    139a:	b8 00 00 00 00       	mov    $0x0,%eax
    139f:	eb 05                	jmp    13a6 <getgroup+0x5a>
    
    return &current_group;
    13a1:	b8 4c 1a 00 00       	mov    $0x1a4c,%eax
}
    13a6:	c9                   	leave  
    13a7:	c3                   	ret    

000013a8 <setgroup>:

// open file_ids
void setgroup(void){
    13a8:	f3 0f 1e fb          	endbr32 
    13ac:	55                   	push   %ebp
    13ad:	89 e5                	mov    %esp,%ebp
    13af:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    13b2:	a1 80 1a 00 00       	mov    0x1a80,%eax
    13b7:	85 c0                	test   %eax,%eax
    13b9:	74 1b                	je     13d6 <setgroup+0x2e>
        close(dir);
    13bb:	a1 80 1a 00 00       	mov    0x1a80,%eax
    13c0:	83 ec 0c             	sub    $0xc,%esp
    13c3:	50                   	push   %eax
    13c4:	e8 4a f6 ff ff       	call   a13 <close>
    13c9:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    13cc:	c7 05 80 1a 00 00 00 	movl   $0x0,0x1a80
    13d3:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
    13d6:	83 ec 08             	sub    $0x8,%esp
    13d9:	6a 00                	push   $0x0
    13db:	68 60 15 00 00       	push   $0x1560
    13e0:	e8 46 f6 ff ff       	call   a2b <open>
    13e5:	83 c4 10             	add    $0x10,%esp
    13e8:	a3 80 1a 00 00       	mov    %eax,0x1a80

    if (dir < 0)
    13ed:	a1 80 1a 00 00       	mov    0x1a80,%eax
    13f2:	85 c0                	test   %eax,%eax
    13f4:	79 0a                	jns    1400 <setgroup+0x58>
        dir = 0;
    13f6:	c7 05 80 1a 00 00 00 	movl   $0x0,0x1a80
    13fd:	00 00 00 
}
    1400:	90                   	nop
    1401:	c9                   	leave  
    1402:	c3                   	ret    

00001403 <endgroup>:

// tutup file_ids
void endgroup (void){
    1403:	f3 0f 1e fb          	endbr32 
    1407:	55                   	push   %ebp
    1408:	89 e5                	mov    %esp,%ebp
    140a:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    140d:	a1 80 1a 00 00       	mov    0x1a80,%eax
    1412:	85 c0                	test   %eax,%eax
    1414:	74 1b                	je     1431 <endgroup+0x2e>
        close(dir);
    1416:	a1 80 1a 00 00       	mov    0x1a80,%eax
    141b:	83 ec 0c             	sub    $0xc,%esp
    141e:	50                   	push   %eax
    141f:	e8 ef f5 ff ff       	call   a13 <close>
    1424:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1427:	c7 05 80 1a 00 00 00 	movl   $0x0,0x1a80
    142e:	00 00 00 
    }
}
    1431:	90                   	nop
    1432:	c9                   	leave  
    1433:	c3                   	ret    

00001434 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
    1434:	f3 0f 1e fb          	endbr32 
    1438:	55                   	push   %ebp
    1439:	89 e5                	mov    %esp,%ebp
    143b:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    143e:	e8 65 ff ff ff       	call   13a8 <setgroup>

    while (getgroup()){
    1443:	eb 3c                	jmp    1481 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
    1445:	a1 4c 1a 00 00       	mov    0x1a4c,%eax
    144a:	83 ec 08             	sub    $0x8,%esp
    144d:	50                   	push   %eax
    144e:	ff 75 08             	pushl  0x8(%ebp)
    1451:	e8 29 f2 ff ff       	call   67f <strcmp>
    1456:	83 c4 10             	add    $0x10,%esp
    1459:	85 c0                	test   %eax,%eax
    145b:	75 24                	jne    1481 <cek_nama_group+0x4d>
            endgroup();
    145d:	e8 a1 ff ff ff       	call   1403 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
    1462:	a1 4c 1a 00 00       	mov    0x1a4c,%eax
    1467:	83 ec 04             	sub    $0x4,%esp
    146a:	50                   	push   %eax
    146b:	68 6b 15 00 00       	push   $0x156b
    1470:	6a 01                	push   $0x1
    1472:	e8 40 f7 ff ff       	call   bb7 <printf>
    1477:	83 c4 10             	add    $0x10,%esp
            return &current_group;
    147a:	b8 4c 1a 00 00       	mov    $0x1a4c,%eax
    147f:	eb 13                	jmp    1494 <cek_nama_group+0x60>
    while (getgroup()){
    1481:	e8 c6 fe ff ff       	call   134c <getgroup>
    1486:	85 c0                	test   %eax,%eax
    1488:	75 bb                	jne    1445 <cek_nama_group+0x11>
        }
    }
    endgroup();
    148a:	e8 74 ff ff ff       	call   1403 <endgroup>
    return 0;
    148f:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1494:	c9                   	leave  
    1495:	c3                   	ret    

00001496 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
    1496:	f3 0f 1e fb          	endbr32 
    149a:	55                   	push   %ebp
    149b:	89 e5                	mov    %esp,%ebp
    149d:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    14a0:	e8 03 ff ff ff       	call   13a8 <setgroup>

    while (getgroup()){
    14a5:	eb 16                	jmp    14bd <cek_gid+0x27>
        if(current_group.gid == gid){
    14a7:	a1 50 1a 00 00       	mov    0x1a50,%eax
    14ac:	39 45 08             	cmp    %eax,0x8(%ebp)
    14af:	75 0c                	jne    14bd <cek_gid+0x27>
            endgroup();
    14b1:	e8 4d ff ff ff       	call   1403 <endgroup>
            return &current_group;
    14b6:	b8 4c 1a 00 00       	mov    $0x1a4c,%eax
    14bb:	eb 13                	jmp    14d0 <cek_gid+0x3a>
    while (getgroup()){
    14bd:	e8 8a fe ff ff       	call   134c <getgroup>
    14c2:	85 c0                	test   %eax,%eax
    14c4:	75 e1                	jne    14a7 <cek_gid+0x11>
        }
    }
    endgroup();
    14c6:	e8 38 ff ff ff       	call   1403 <endgroup>
    return 0;
    14cb:	b8 00 00 00 00       	mov    $0x0,%eax
}
    14d0:	c9                   	leave  
    14d1:	c3                   	ret    
