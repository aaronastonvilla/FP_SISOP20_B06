
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	f3 0f 1e fb          	endbr32 
       4:	55                   	push   %ebp
       5:	89 e5                	mov    %esp,%ebp
       7:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       e:	75 05                	jne    15 <runcmd+0x15>
    exit();
      10:	e8 ab 13 00 00       	call   13c0 <exit>
  
  switch(cmd->type){
      15:	8b 45 08             	mov    0x8(%ebp),%eax
      18:	8b 00                	mov    (%eax),%eax
      1a:	83 f8 05             	cmp    $0x5,%eax
      1d:	77 0a                	ja     29 <runcmd+0x29>
      1f:	8b 04 85 d4 1e 00 00 	mov    0x1ed4(,%eax,4),%eax
      26:	3e ff e0             	notrack jmp *%eax
  default:
    panic("runcmd");
      29:	83 ec 0c             	sub    $0xc,%esp
      2c:	68 a8 1e 00 00       	push   $0x1ea8
      31:	e8 9e 06 00 00       	call   6d4 <panic>
      36:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      39:	8b 45 08             	mov    0x8(%ebp),%eax
      3c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(ecmd->argv[0] == 0)
      3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      42:	8b 40 04             	mov    0x4(%eax),%eax
      45:	85 c0                	test   %eax,%eax
      47:	75 05                	jne    4e <runcmd+0x4e>
      exit();
      49:	e8 72 13 00 00       	call   13c0 <exit>
    exec(ecmd->argv[0], ecmd->argv);
      4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      51:	8d 50 04             	lea    0x4(%eax),%edx
      54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      57:	8b 40 04             	mov    0x4(%eax),%eax
      5a:	83 ec 08             	sub    $0x8,%esp
      5d:	52                   	push   %edx
      5e:	50                   	push   %eax
      5f:	e8 94 13 00 00       	call   13f8 <exec>
      64:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      6a:	8b 40 04             	mov    0x4(%eax),%eax
      6d:	83 ec 04             	sub    $0x4,%esp
      70:	50                   	push   %eax
      71:	68 af 1e 00 00       	push   $0x1eaf
      76:	6a 02                	push   $0x2
      78:	e8 0f 15 00 00       	call   158c <printf>
      7d:	83 c4 10             	add    $0x10,%esp
    break;
      80:	e9 c6 01 00 00       	jmp    24b <runcmd+0x24b>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      85:	8b 45 08             	mov    0x8(%ebp),%eax
      88:	89 45 e8             	mov    %eax,-0x18(%ebp)
    close(rcmd->fd);
      8b:	8b 45 e8             	mov    -0x18(%ebp),%eax
      8e:	8b 40 14             	mov    0x14(%eax),%eax
      91:	83 ec 0c             	sub    $0xc,%esp
      94:	50                   	push   %eax
      95:	e8 4e 13 00 00       	call   13e8 <close>
      9a:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
      a0:	8b 50 10             	mov    0x10(%eax),%edx
      a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
      a6:	8b 40 08             	mov    0x8(%eax),%eax
      a9:	83 ec 08             	sub    $0x8,%esp
      ac:	52                   	push   %edx
      ad:	50                   	push   %eax
      ae:	e8 4d 13 00 00       	call   1400 <open>
      b3:	83 c4 10             	add    $0x10,%esp
      b6:	85 c0                	test   %eax,%eax
      b8:	79 1e                	jns    d8 <runcmd+0xd8>
      printf(2, "open %s failed\n", rcmd->file);
      ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
      bd:	8b 40 08             	mov    0x8(%eax),%eax
      c0:	83 ec 04             	sub    $0x4,%esp
      c3:	50                   	push   %eax
      c4:	68 bf 1e 00 00       	push   $0x1ebf
      c9:	6a 02                	push   $0x2
      cb:	e8 bc 14 00 00       	call   158c <printf>
      d0:	83 c4 10             	add    $0x10,%esp
      exit();
      d3:	e8 e8 12 00 00       	call   13c0 <exit>
    }
    runcmd(rcmd->cmd);
      d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
      db:	8b 40 04             	mov    0x4(%eax),%eax
      de:	83 ec 0c             	sub    $0xc,%esp
      e1:	50                   	push   %eax
      e2:	e8 19 ff ff ff       	call   0 <runcmd>
      e7:	83 c4 10             	add    $0x10,%esp
    break;
      ea:	e9 5c 01 00 00       	jmp    24b <runcmd+0x24b>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ef:	8b 45 08             	mov    0x8(%ebp),%eax
      f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fork1() == 0)
      f5:	e8 fe 05 00 00       	call   6f8 <fork1>
      fa:	85 c0                	test   %eax,%eax
      fc:	75 12                	jne    110 <runcmd+0x110>
      runcmd(lcmd->left);
      fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     101:	8b 40 04             	mov    0x4(%eax),%eax
     104:	83 ec 0c             	sub    $0xc,%esp
     107:	50                   	push   %eax
     108:	e8 f3 fe ff ff       	call   0 <runcmd>
     10d:	83 c4 10             	add    $0x10,%esp
    wait();
     110:	e8 b3 12 00 00       	call   13c8 <wait>
    runcmd(lcmd->right);
     115:	8b 45 f0             	mov    -0x10(%ebp),%eax
     118:	8b 40 08             	mov    0x8(%eax),%eax
     11b:	83 ec 0c             	sub    $0xc,%esp
     11e:	50                   	push   %eax
     11f:	e8 dc fe ff ff       	call   0 <runcmd>
     124:	83 c4 10             	add    $0x10,%esp
    break;
     127:	e9 1f 01 00 00       	jmp    24b <runcmd+0x24b>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     12c:	8b 45 08             	mov    0x8(%ebp),%eax
     12f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pipe(p) < 0)
     132:	83 ec 0c             	sub    $0xc,%esp
     135:	8d 45 dc             	lea    -0x24(%ebp),%eax
     138:	50                   	push   %eax
     139:	e8 92 12 00 00       	call   13d0 <pipe>
     13e:	83 c4 10             	add    $0x10,%esp
     141:	85 c0                	test   %eax,%eax
     143:	79 10                	jns    155 <runcmd+0x155>
      panic("pipe");
     145:	83 ec 0c             	sub    $0xc,%esp
     148:	68 cf 1e 00 00       	push   $0x1ecf
     14d:	e8 82 05 00 00       	call   6d4 <panic>
     152:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     155:	e8 9e 05 00 00       	call   6f8 <fork1>
     15a:	85 c0                	test   %eax,%eax
     15c:	75 4c                	jne    1aa <runcmd+0x1aa>
      close(1);
     15e:	83 ec 0c             	sub    $0xc,%esp
     161:	6a 01                	push   $0x1
     163:	e8 80 12 00 00       	call   13e8 <close>
     168:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     16b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     16e:	83 ec 0c             	sub    $0xc,%esp
     171:	50                   	push   %eax
     172:	e8 c1 12 00 00       	call   1438 <dup>
     177:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     17a:	8b 45 dc             	mov    -0x24(%ebp),%eax
     17d:	83 ec 0c             	sub    $0xc,%esp
     180:	50                   	push   %eax
     181:	e8 62 12 00 00       	call   13e8 <close>
     186:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     189:	8b 45 e0             	mov    -0x20(%ebp),%eax
     18c:	83 ec 0c             	sub    $0xc,%esp
     18f:	50                   	push   %eax
     190:	e8 53 12 00 00       	call   13e8 <close>
     195:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     198:	8b 45 ec             	mov    -0x14(%ebp),%eax
     19b:	8b 40 04             	mov    0x4(%eax),%eax
     19e:	83 ec 0c             	sub    $0xc,%esp
     1a1:	50                   	push   %eax
     1a2:	e8 59 fe ff ff       	call   0 <runcmd>
     1a7:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1aa:	e8 49 05 00 00       	call   6f8 <fork1>
     1af:	85 c0                	test   %eax,%eax
     1b1:	75 4c                	jne    1ff <runcmd+0x1ff>
      close(0);
     1b3:	83 ec 0c             	sub    $0xc,%esp
     1b6:	6a 00                	push   $0x0
     1b8:	e8 2b 12 00 00       	call   13e8 <close>
     1bd:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1c3:	83 ec 0c             	sub    $0xc,%esp
     1c6:	50                   	push   %eax
     1c7:	e8 6c 12 00 00       	call   1438 <dup>
     1cc:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1cf:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1d2:	83 ec 0c             	sub    $0xc,%esp
     1d5:	50                   	push   %eax
     1d6:	e8 0d 12 00 00       	call   13e8 <close>
     1db:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1de:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1e1:	83 ec 0c             	sub    $0xc,%esp
     1e4:	50                   	push   %eax
     1e5:	e8 fe 11 00 00       	call   13e8 <close>
     1ea:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
     1f0:	8b 40 08             	mov    0x8(%eax),%eax
     1f3:	83 ec 0c             	sub    $0xc,%esp
     1f6:	50                   	push   %eax
     1f7:	e8 04 fe ff ff       	call   0 <runcmd>
     1fc:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     1ff:	8b 45 dc             	mov    -0x24(%ebp),%eax
     202:	83 ec 0c             	sub    $0xc,%esp
     205:	50                   	push   %eax
     206:	e8 dd 11 00 00       	call   13e8 <close>
     20b:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     20e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     211:	83 ec 0c             	sub    $0xc,%esp
     214:	50                   	push   %eax
     215:	e8 ce 11 00 00       	call   13e8 <close>
     21a:	83 c4 10             	add    $0x10,%esp
    wait();
     21d:	e8 a6 11 00 00       	call   13c8 <wait>
    wait();
     222:	e8 a1 11 00 00       	call   13c8 <wait>
    break;
     227:	eb 22                	jmp    24b <runcmd+0x24b>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     229:	8b 45 08             	mov    0x8(%ebp),%eax
     22c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(fork1() == 0)
     22f:	e8 c4 04 00 00       	call   6f8 <fork1>
     234:	85 c0                	test   %eax,%eax
     236:	75 12                	jne    24a <runcmd+0x24a>
      runcmd(bcmd->cmd);
     238:	8b 45 f4             	mov    -0xc(%ebp),%eax
     23b:	8b 40 04             	mov    0x4(%eax),%eax
     23e:	83 ec 0c             	sub    $0xc,%esp
     241:	50                   	push   %eax
     242:	e8 b9 fd ff ff       	call   0 <runcmd>
     247:	83 c4 10             	add    $0x10,%esp
    break;
     24a:	90                   	nop
  }
  exit();
     24b:	e8 70 11 00 00       	call   13c0 <exit>

00000250 <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     250:	f3 0f 1e fb          	endbr32 
     254:	55                   	push   %ebp
     255:	89 e5                	mov    %esp,%ebp
     257:	83 ec 08             	sub    $0x8,%esp
  printf(2, "$ ");
     25a:	83 ec 08             	sub    $0x8,%esp
     25d:	68 ec 1e 00 00       	push   $0x1eec
     262:	6a 02                	push   $0x2
     264:	e8 23 13 00 00       	call   158c <printf>
     269:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     26c:	8b 45 0c             	mov    0xc(%ebp),%eax
     26f:	83 ec 04             	sub    $0x4,%esp
     272:	50                   	push   %eax
     273:	6a 00                	push   $0x0
     275:	ff 75 08             	pushl  0x8(%ebp)
     278:	e8 45 0e 00 00       	call   10c2 <memset>
     27d:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     280:	83 ec 08             	sub    $0x8,%esp
     283:	ff 75 0c             	pushl  0xc(%ebp)
     286:	ff 75 08             	pushl  0x8(%ebp)
     289:	e8 89 0e 00 00       	call   1117 <gets>
     28e:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     291:	8b 45 08             	mov    0x8(%ebp),%eax
     294:	0f b6 00             	movzbl (%eax),%eax
     297:	84 c0                	test   %al,%al
     299:	75 07                	jne    2a2 <getcmd+0x52>
    return -1;
     29b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2a0:	eb 05                	jmp    2a7 <getcmd+0x57>
  return 0;
     2a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2a7:	c9                   	leave  
     2a8:	c3                   	ret    

000002a9 <strncmp>:
#ifdef USE_BUILTINS
// ***** processing for shell builtins begins here *****

int
strncmp(const char *p, const char *q, uint n)
{
     2a9:	f3 0f 1e fb          	endbr32 
     2ad:	55                   	push   %ebp
     2ae:	89 e5                	mov    %esp,%ebp
    while(n > 0 && *p && *p == *q)
     2b0:	eb 0c                	jmp    2be <strncmp+0x15>
      n--, p++, q++;
     2b2:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     2b6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2ba:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while(n > 0 && *p && *p == *q)
     2be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     2c2:	74 1a                	je     2de <strncmp+0x35>
     2c4:	8b 45 08             	mov    0x8(%ebp),%eax
     2c7:	0f b6 00             	movzbl (%eax),%eax
     2ca:	84 c0                	test   %al,%al
     2cc:	74 10                	je     2de <strncmp+0x35>
     2ce:	8b 45 08             	mov    0x8(%ebp),%eax
     2d1:	0f b6 10             	movzbl (%eax),%edx
     2d4:	8b 45 0c             	mov    0xc(%ebp),%eax
     2d7:	0f b6 00             	movzbl (%eax),%eax
     2da:	38 c2                	cmp    %al,%dl
     2dc:	74 d4                	je     2b2 <strncmp+0x9>
    if(n == 0)
     2de:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     2e2:	75 07                	jne    2eb <strncmp+0x42>
      return 0;
     2e4:	b8 00 00 00 00       	mov    $0x0,%eax
     2e9:	eb 16                	jmp    301 <strncmp+0x58>
    return (uchar)*p - (uchar)*q;
     2eb:	8b 45 08             	mov    0x8(%ebp),%eax
     2ee:	0f b6 00             	movzbl (%eax),%eax
     2f1:	0f b6 d0             	movzbl %al,%edx
     2f4:	8b 45 0c             	mov    0xc(%ebp),%eax
     2f7:	0f b6 00             	movzbl (%eax),%eax
     2fa:	0f b6 c0             	movzbl %al,%eax
     2fd:	29 c2                	sub    %eax,%edx
     2ff:	89 d0                	mov    %edx,%eax
}
     301:	5d                   	pop    %ebp
     302:	c3                   	ret    

00000303 <makeint>:

int
makeint(char *p)
{
     303:	f3 0f 1e fb          	endbr32 
     307:	55                   	push   %ebp
     308:	89 e5                	mov    %esp,%ebp
     30a:	83 ec 10             	sub    $0x10,%esp
  int val = 0;
     30d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)

  while ((*p >= '0') && (*p <= '9')) {
     314:	eb 23                	jmp    339 <makeint+0x36>
    val = 10*val + (*p-'0');
     316:	8b 55 fc             	mov    -0x4(%ebp),%edx
     319:	89 d0                	mov    %edx,%eax
     31b:	c1 e0 02             	shl    $0x2,%eax
     31e:	01 d0                	add    %edx,%eax
     320:	01 c0                	add    %eax,%eax
     322:	89 c2                	mov    %eax,%edx
     324:	8b 45 08             	mov    0x8(%ebp),%eax
     327:	0f b6 00             	movzbl (%eax),%eax
     32a:	0f be c0             	movsbl %al,%eax
     32d:	83 e8 30             	sub    $0x30,%eax
     330:	01 d0                	add    %edx,%eax
     332:	89 45 fc             	mov    %eax,-0x4(%ebp)
    ++p;
     335:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while ((*p >= '0') && (*p <= '9')) {
     339:	8b 45 08             	mov    0x8(%ebp),%eax
     33c:	0f b6 00             	movzbl (%eax),%eax
     33f:	3c 2f                	cmp    $0x2f,%al
     341:	7e 0a                	jle    34d <makeint+0x4a>
     343:	8b 45 08             	mov    0x8(%ebp),%eax
     346:	0f b6 00             	movzbl (%eax),%eax
     349:	3c 39                	cmp    $0x39,%al
     34b:	7e c9                	jle    316 <makeint+0x13>
  }
  return val;
     34d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     350:	c9                   	leave  
     351:	c3                   	ret    

00000352 <setbuiltin>:

int
setbuiltin(char *p)
{
     352:	f3 0f 1e fb          	endbr32 
     356:	55                   	push   %ebp
     357:	89 e5                	mov    %esp,%ebp
     359:	83 ec 18             	sub    $0x18,%esp
  int i;

  p += strlen("_set");
     35c:	83 ec 0c             	sub    $0xc,%esp
     35f:	68 ef 1e 00 00       	push   $0x1eef
     364:	e8 2e 0d 00 00       	call   1097 <strlen>
     369:	83 c4 10             	add    $0x10,%esp
     36c:	01 45 08             	add    %eax,0x8(%ebp)
  while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     36f:	eb 04                	jmp    375 <setbuiltin+0x23>
     371:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     375:	83 ec 04             	sub    $0x4,%esp
     378:	6a 01                	push   $0x1
     37a:	68 f4 1e 00 00       	push   $0x1ef4
     37f:	ff 75 08             	pushl  0x8(%ebp)
     382:	e8 22 ff ff ff       	call   2a9 <strncmp>
     387:	83 c4 10             	add    $0x10,%esp
     38a:	85 c0                	test   %eax,%eax
     38c:	74 e3                	je     371 <setbuiltin+0x1f>
  if (strncmp("uid", p, 3) == 0) {
     38e:	83 ec 04             	sub    $0x4,%esp
     391:	6a 03                	push   $0x3
     393:	ff 75 08             	pushl  0x8(%ebp)
     396:	68 f6 1e 00 00       	push   $0x1ef6
     39b:	e8 09 ff ff ff       	call   2a9 <strncmp>
     3a0:	83 c4 10             	add    $0x10,%esp
     3a3:	85 c0                	test   %eax,%eax
     3a5:	75 57                	jne    3fe <setbuiltin+0xac>
    p += strlen("uid");
     3a7:	83 ec 0c             	sub    $0xc,%esp
     3aa:	68 f6 1e 00 00       	push   $0x1ef6
     3af:	e8 e3 0c 00 00       	call   1097 <strlen>
     3b4:	83 c4 10             	add    $0x10,%esp
     3b7:	01 45 08             	add    %eax,0x8(%ebp)
    while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     3ba:	eb 04                	jmp    3c0 <setbuiltin+0x6e>
     3bc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     3c0:	83 ec 04             	sub    $0x4,%esp
     3c3:	6a 01                	push   $0x1
     3c5:	68 f4 1e 00 00       	push   $0x1ef4
     3ca:	ff 75 08             	pushl  0x8(%ebp)
     3cd:	e8 d7 fe ff ff       	call   2a9 <strncmp>
     3d2:	83 c4 10             	add    $0x10,%esp
     3d5:	85 c0                	test   %eax,%eax
     3d7:	74 e3                	je     3bc <setbuiltin+0x6a>
    i = makeint(p); // ugly
     3d9:	83 ec 0c             	sub    $0xc,%esp
     3dc:	ff 75 08             	pushl  0x8(%ebp)
     3df:	e8 1f ff ff ff       	call   303 <makeint>
     3e4:	83 c4 10             	add    $0x10,%esp
     3e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return (setuid(i));
     3ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3ed:	83 ec 0c             	sub    $0xc,%esp
     3f0:	50                   	push   %eax
     3f1:	e8 92 10 00 00       	call   1488 <setuid>
     3f6:	83 c4 10             	add    $0x10,%esp
     3f9:	e9 84 00 00 00       	jmp    482 <setbuiltin+0x130>
  } else 
  if (strncmp("gid", p, 3) == 0) {
     3fe:	83 ec 04             	sub    $0x4,%esp
     401:	6a 03                	push   $0x3
     403:	ff 75 08             	pushl  0x8(%ebp)
     406:	68 fa 1e 00 00       	push   $0x1efa
     40b:	e8 99 fe ff ff       	call   2a9 <strncmp>
     410:	83 c4 10             	add    $0x10,%esp
     413:	85 c0                	test   %eax,%eax
     415:	75 54                	jne    46b <setbuiltin+0x119>
    p += strlen("gid");
     417:	83 ec 0c             	sub    $0xc,%esp
     41a:	68 fa 1e 00 00       	push   $0x1efa
     41f:	e8 73 0c 00 00       	call   1097 <strlen>
     424:	83 c4 10             	add    $0x10,%esp
     427:	01 45 08             	add    %eax,0x8(%ebp)
    while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     42a:	eb 04                	jmp    430 <setbuiltin+0xde>
     42c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     430:	83 ec 04             	sub    $0x4,%esp
     433:	6a 01                	push   $0x1
     435:	68 f4 1e 00 00       	push   $0x1ef4
     43a:	ff 75 08             	pushl  0x8(%ebp)
     43d:	e8 67 fe ff ff       	call   2a9 <strncmp>
     442:	83 c4 10             	add    $0x10,%esp
     445:	85 c0                	test   %eax,%eax
     447:	74 e3                	je     42c <setbuiltin+0xda>
    i = makeint(p); // ugly
     449:	83 ec 0c             	sub    $0xc,%esp
     44c:	ff 75 08             	pushl  0x8(%ebp)
     44f:	e8 af fe ff ff       	call   303 <makeint>
     454:	83 c4 10             	add    $0x10,%esp
     457:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return (setgid(i));
     45a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     45d:	83 ec 0c             	sub    $0xc,%esp
     460:	50                   	push   %eax
     461:	e8 2a 10 00 00       	call   1490 <setgid>
     466:	83 c4 10             	add    $0x10,%esp
     469:	eb 17                	jmp    482 <setbuiltin+0x130>
  }
  printf(2, "Invalid _set parameter\n");
     46b:	83 ec 08             	sub    $0x8,%esp
     46e:	68 fe 1e 00 00       	push   $0x1efe
     473:	6a 02                	push   $0x2
     475:	e8 12 11 00 00       	call   158c <printf>
     47a:	83 c4 10             	add    $0x10,%esp
  return -1;
     47d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     482:	c9                   	leave  
     483:	c3                   	ret    

00000484 <getbuiltin>:

int
getbuiltin(char *p)
{
     484:	f3 0f 1e fb          	endbr32 
     488:	55                   	push   %ebp
     489:	89 e5                	mov    %esp,%ebp
     48b:	83 ec 08             	sub    $0x8,%esp
  p += strlen("_get");
     48e:	83 ec 0c             	sub    $0xc,%esp
     491:	68 16 1f 00 00       	push   $0x1f16
     496:	e8 fc 0b 00 00       	call   1097 <strlen>
     49b:	83 c4 10             	add    $0x10,%esp
     49e:	01 45 08             	add    %eax,0x8(%ebp)
  while (strncmp(p, " ", 1) == 0) p++; // chomp spaces
     4a1:	eb 04                	jmp    4a7 <getbuiltin+0x23>
     4a3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     4a7:	83 ec 04             	sub    $0x4,%esp
     4aa:	6a 01                	push   $0x1
     4ac:	68 f4 1e 00 00       	push   $0x1ef4
     4b1:	ff 75 08             	pushl  0x8(%ebp)
     4b4:	e8 f0 fd ff ff       	call   2a9 <strncmp>
     4b9:	83 c4 10             	add    $0x10,%esp
     4bc:	85 c0                	test   %eax,%eax
     4be:	74 e3                	je     4a3 <getbuiltin+0x1f>
  if (strncmp("uid", p, 3) == 0) {
     4c0:	83 ec 04             	sub    $0x4,%esp
     4c3:	6a 03                	push   $0x3
     4c5:	ff 75 08             	pushl  0x8(%ebp)
     4c8:	68 f6 1e 00 00       	push   $0x1ef6
     4cd:	e8 d7 fd ff ff       	call   2a9 <strncmp>
     4d2:	83 c4 10             	add    $0x10,%esp
     4d5:	85 c0                	test   %eax,%eax
     4d7:	75 1f                	jne    4f8 <getbuiltin+0x74>
    printf(2, "%d\n", getuid());
     4d9:	e8 92 0f 00 00       	call   1470 <getuid>
     4de:	83 ec 04             	sub    $0x4,%esp
     4e1:	50                   	push   %eax
     4e2:	68 1b 1f 00 00       	push   $0x1f1b
     4e7:	6a 02                	push   $0x2
     4e9:	e8 9e 10 00 00       	call   158c <printf>
     4ee:	83 c4 10             	add    $0x10,%esp
    return 0;
     4f1:	b8 00 00 00 00       	mov    $0x0,%eax
     4f6:	eb 4f                	jmp    547 <getbuiltin+0xc3>
  }
  if (strncmp("gid", p, 3) == 0) {
     4f8:	83 ec 04             	sub    $0x4,%esp
     4fb:	6a 03                	push   $0x3
     4fd:	ff 75 08             	pushl  0x8(%ebp)
     500:	68 fa 1e 00 00       	push   $0x1efa
     505:	e8 9f fd ff ff       	call   2a9 <strncmp>
     50a:	83 c4 10             	add    $0x10,%esp
     50d:	85 c0                	test   %eax,%eax
     50f:	75 1f                	jne    530 <getbuiltin+0xac>
    printf(2, "%d\n", getgid());
     511:	e8 62 0f 00 00       	call   1478 <getgid>
     516:	83 ec 04             	sub    $0x4,%esp
     519:	50                   	push   %eax
     51a:	68 1b 1f 00 00       	push   $0x1f1b
     51f:	6a 02                	push   $0x2
     521:	e8 66 10 00 00       	call   158c <printf>
     526:	83 c4 10             	add    $0x10,%esp
    return 0;
     529:	b8 00 00 00 00       	mov    $0x0,%eax
     52e:	eb 17                	jmp    547 <getbuiltin+0xc3>
  }
  printf(2, "Invalid _get parameter\n");
     530:	83 ec 08             	sub    $0x8,%esp
     533:	68 1f 1f 00 00       	push   $0x1f1f
     538:	6a 02                	push   $0x2
     53a:	e8 4d 10 00 00       	call   158c <printf>
     53f:	83 c4 10             	add    $0x10,%esp
  return -1;
     542:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     547:	c9                   	leave  
     548:	c3                   	ret    

00000549 <dobuiltin>:
  {"_get", getbuiltin}
};
int FDTcount = sizeof(fdt) / sizeof(fdt[0]); // # entris in FDT

void
dobuiltin(char *cmd) {
     549:	f3 0f 1e fb          	endbr32 
     54d:	55                   	push   %ebp
     54e:	89 e5                	mov    %esp,%ebp
     550:	83 ec 18             	sub    $0x18,%esp
  int i;

  for (i=0; i<FDTcount; i++) 
     553:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     55a:	eb 4d                	jmp    5a9 <dobuiltin+0x60>
    if (strncmp(cmd, fdt[i].cmd, strlen(fdt[i].cmd)) == 0) 
     55c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     55f:	8b 04 c5 ec 26 00 00 	mov    0x26ec(,%eax,8),%eax
     566:	83 ec 0c             	sub    $0xc,%esp
     569:	50                   	push   %eax
     56a:	e8 28 0b 00 00       	call   1097 <strlen>
     56f:	83 c4 10             	add    $0x10,%esp
     572:	8b 55 f4             	mov    -0xc(%ebp),%edx
     575:	8b 14 d5 ec 26 00 00 	mov    0x26ec(,%edx,8),%edx
     57c:	83 ec 04             	sub    $0x4,%esp
     57f:	50                   	push   %eax
     580:	52                   	push   %edx
     581:	ff 75 08             	pushl  0x8(%ebp)
     584:	e8 20 fd ff ff       	call   2a9 <strncmp>
     589:	83 c4 10             	add    $0x10,%esp
     58c:	85 c0                	test   %eax,%eax
     58e:	75 15                	jne    5a5 <dobuiltin+0x5c>
     (*fdt[i].name)(cmd);
     590:	8b 45 f4             	mov    -0xc(%ebp),%eax
     593:	8b 04 c5 f0 26 00 00 	mov    0x26f0(,%eax,8),%eax
     59a:	83 ec 0c             	sub    $0xc,%esp
     59d:	ff 75 08             	pushl  0x8(%ebp)
     5a0:	ff d0                	call   *%eax
     5a2:	83 c4 10             	add    $0x10,%esp
  for (i=0; i<FDTcount; i++) 
     5a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     5a9:	a1 fc 26 00 00       	mov    0x26fc,%eax
     5ae:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     5b1:	7c a9                	jl     55c <dobuiltin+0x13>
}
     5b3:	90                   	nop
     5b4:	90                   	nop
     5b5:	c9                   	leave  
     5b6:	c3                   	ret    

000005b7 <main>:
// ***** processing for shell builtins ends here *****
#endif

int
main(void)
{
     5b7:	f3 0f 1e fb          	endbr32 
     5bb:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     5bf:	83 e4 f0             	and    $0xfffffff0,%esp
     5c2:	ff 71 fc             	pushl  -0x4(%ecx)
     5c5:	55                   	push   %ebp
     5c6:	89 e5                	mov    %esp,%ebp
     5c8:	51                   	push   %ecx
     5c9:	83 ec 14             	sub    $0x14,%esp
  static char buf[100];
  int fd;
  
  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     5cc:	eb 16                	jmp    5e4 <main+0x2d>
    if(fd >= 3){
     5ce:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     5d2:	7e 10                	jle    5e4 <main+0x2d>
      close(fd);
     5d4:	83 ec 0c             	sub    $0xc,%esp
     5d7:	ff 75 f4             	pushl  -0xc(%ebp)
     5da:	e8 09 0e 00 00       	call   13e8 <close>
     5df:	83 c4 10             	add    $0x10,%esp
      break;
     5e2:	eb 1b                	jmp    5ff <main+0x48>
  while((fd = open("console", O_RDWR)) >= 0){
     5e4:	83 ec 08             	sub    $0x8,%esp
     5e7:	6a 02                	push   $0x2
     5e9:	68 37 1f 00 00       	push   $0x1f37
     5ee:	e8 0d 0e 00 00       	call   1400 <open>
     5f3:	83 c4 10             	add    $0x10,%esp
     5f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
     5f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5fd:	79 cf                	jns    5ce <main+0x17>
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     5ff:	e9 b1 00 00 00       	jmp    6b5 <main+0xfe>
// add support for built-ins here. cd is a built-in
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     604:	0f b6 05 40 27 00 00 	movzbl 0x2740,%eax
     60b:	3c 63                	cmp    $0x63,%al
     60d:	75 5f                	jne    66e <main+0xb7>
     60f:	0f b6 05 41 27 00 00 	movzbl 0x2741,%eax
     616:	3c 64                	cmp    $0x64,%al
     618:	75 54                	jne    66e <main+0xb7>
     61a:	0f b6 05 42 27 00 00 	movzbl 0x2742,%eax
     621:	3c 20                	cmp    $0x20,%al
     623:	75 49                	jne    66e <main+0xb7>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     625:	83 ec 0c             	sub    $0xc,%esp
     628:	68 40 27 00 00       	push   $0x2740
     62d:	e8 65 0a 00 00       	call   1097 <strlen>
     632:	83 c4 10             	add    $0x10,%esp
     635:	83 e8 01             	sub    $0x1,%eax
     638:	c6 80 40 27 00 00 00 	movb   $0x0,0x2740(%eax)
      if(chdir(buf+3) < 0)
     63f:	b8 43 27 00 00       	mov    $0x2743,%eax
     644:	83 ec 0c             	sub    $0xc,%esp
     647:	50                   	push   %eax
     648:	e8 e3 0d 00 00       	call   1430 <chdir>
     64d:	83 c4 10             	add    $0x10,%esp
     650:	85 c0                	test   %eax,%eax
     652:	79 61                	jns    6b5 <main+0xfe>
        printf(2, "cannot cd %s\n", buf+3);
     654:	b8 43 27 00 00       	mov    $0x2743,%eax
     659:	83 ec 04             	sub    $0x4,%esp
     65c:	50                   	push   %eax
     65d:	68 3f 1f 00 00       	push   $0x1f3f
     662:	6a 02                	push   $0x2
     664:	e8 23 0f 00 00       	call   158c <printf>
     669:	83 c4 10             	add    $0x10,%esp
      continue;
     66c:	eb 47                	jmp    6b5 <main+0xfe>
    }
#ifdef USE_BUILTINS
    if (buf[0]=='_') {     // assume it is a builtin command
     66e:	0f b6 05 40 27 00 00 	movzbl 0x2740,%eax
     675:	3c 5f                	cmp    $0x5f,%al
     677:	75 12                	jne    68b <main+0xd4>
      dobuiltin(buf);
     679:	83 ec 0c             	sub    $0xc,%esp
     67c:	68 40 27 00 00       	push   $0x2740
     681:	e8 c3 fe ff ff       	call   549 <dobuiltin>
     686:	83 c4 10             	add    $0x10,%esp
      continue;
     689:	eb 2a                	jmp    6b5 <main+0xfe>
    }
#endif
    if(fork1() == 0)
     68b:	e8 68 00 00 00       	call   6f8 <fork1>
     690:	85 c0                	test   %eax,%eax
     692:	75 1c                	jne    6b0 <main+0xf9>
      runcmd(parsecmd(buf));
     694:	83 ec 0c             	sub    $0xc,%esp
     697:	68 40 27 00 00       	push   $0x2740
     69c:	e8 ce 03 00 00       	call   a6f <parsecmd>
     6a1:	83 c4 10             	add    $0x10,%esp
     6a4:	83 ec 0c             	sub    $0xc,%esp
     6a7:	50                   	push   %eax
     6a8:	e8 53 f9 ff ff       	call   0 <runcmd>
     6ad:	83 c4 10             	add    $0x10,%esp
    wait();
     6b0:	e8 13 0d 00 00       	call   13c8 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     6b5:	83 ec 08             	sub    $0x8,%esp
     6b8:	6a 64                	push   $0x64
     6ba:	68 40 27 00 00       	push   $0x2740
     6bf:	e8 8c fb ff ff       	call   250 <getcmd>
     6c4:	83 c4 10             	add    $0x10,%esp
     6c7:	85 c0                	test   %eax,%eax
     6c9:	0f 89 35 ff ff ff    	jns    604 <main+0x4d>
  }
  exit();
     6cf:	e8 ec 0c 00 00       	call   13c0 <exit>

000006d4 <panic>:
}

void
panic(char *s)
{
     6d4:	f3 0f 1e fb          	endbr32 
     6d8:	55                   	push   %ebp
     6d9:	89 e5                	mov    %esp,%ebp
     6db:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     6de:	83 ec 04             	sub    $0x4,%esp
     6e1:	ff 75 08             	pushl  0x8(%ebp)
     6e4:	68 4d 1f 00 00       	push   $0x1f4d
     6e9:	6a 02                	push   $0x2
     6eb:	e8 9c 0e 00 00       	call   158c <printf>
     6f0:	83 c4 10             	add    $0x10,%esp
  exit();
     6f3:	e8 c8 0c 00 00       	call   13c0 <exit>

000006f8 <fork1>:
}

int
fork1(void)
{
     6f8:	f3 0f 1e fb          	endbr32 
     6fc:	55                   	push   %ebp
     6fd:	89 e5                	mov    %esp,%ebp
     6ff:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     702:	e8 b1 0c 00 00       	call   13b8 <fork>
     707:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     70a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     70e:	75 10                	jne    720 <fork1+0x28>
    panic("fork");
     710:	83 ec 0c             	sub    $0xc,%esp
     713:	68 51 1f 00 00       	push   $0x1f51
     718:	e8 b7 ff ff ff       	call   6d4 <panic>
     71d:	83 c4 10             	add    $0x10,%esp
  return pid;
     720:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     723:	c9                   	leave  
     724:	c3                   	ret    

00000725 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     725:	f3 0f 1e fb          	endbr32 
     729:	55                   	push   %ebp
     72a:	89 e5                	mov    %esp,%ebp
     72c:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     72f:	83 ec 0c             	sub    $0xc,%esp
     732:	6a 54                	push   $0x54
     734:	e8 33 11 00 00       	call   186c <malloc>
     739:	83 c4 10             	add    $0x10,%esp
     73c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     73f:	83 ec 04             	sub    $0x4,%esp
     742:	6a 54                	push   $0x54
     744:	6a 00                	push   $0x0
     746:	ff 75 f4             	pushl  -0xc(%ebp)
     749:	e8 74 09 00 00       	call   10c2 <memset>
     74e:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     751:	8b 45 f4             	mov    -0xc(%ebp),%eax
     754:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     75a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     75d:	c9                   	leave  
     75e:	c3                   	ret    

0000075f <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     75f:	f3 0f 1e fb          	endbr32 
     763:	55                   	push   %ebp
     764:	89 e5                	mov    %esp,%ebp
     766:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     769:	83 ec 0c             	sub    $0xc,%esp
     76c:	6a 18                	push   $0x18
     76e:	e8 f9 10 00 00       	call   186c <malloc>
     773:	83 c4 10             	add    $0x10,%esp
     776:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     779:	83 ec 04             	sub    $0x4,%esp
     77c:	6a 18                	push   $0x18
     77e:	6a 00                	push   $0x0
     780:	ff 75 f4             	pushl  -0xc(%ebp)
     783:	e8 3a 09 00 00       	call   10c2 <memset>
     788:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78e:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     794:	8b 45 f4             	mov    -0xc(%ebp),%eax
     797:	8b 55 08             	mov    0x8(%ebp),%edx
     79a:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     79d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a0:	8b 55 0c             	mov    0xc(%ebp),%edx
     7a3:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     7a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a9:	8b 55 10             	mov    0x10(%ebp),%edx
     7ac:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     7af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b2:	8b 55 14             	mov    0x14(%ebp),%edx
     7b5:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7bb:	8b 55 18             	mov    0x18(%ebp),%edx
     7be:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     7c4:	c9                   	leave  
     7c5:	c3                   	ret    

000007c6 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     7c6:	f3 0f 1e fb          	endbr32 
     7ca:	55                   	push   %ebp
     7cb:	89 e5                	mov    %esp,%ebp
     7cd:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     7d0:	83 ec 0c             	sub    $0xc,%esp
     7d3:	6a 0c                	push   $0xc
     7d5:	e8 92 10 00 00       	call   186c <malloc>
     7da:	83 c4 10             	add    $0x10,%esp
     7dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     7e0:	83 ec 04             	sub    $0x4,%esp
     7e3:	6a 0c                	push   $0xc
     7e5:	6a 00                	push   $0x0
     7e7:	ff 75 f4             	pushl  -0xc(%ebp)
     7ea:	e8 d3 08 00 00       	call   10c2 <memset>
     7ef:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     7f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f5:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     7fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fe:	8b 55 08             	mov    0x8(%ebp),%edx
     801:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     804:	8b 45 f4             	mov    -0xc(%ebp),%eax
     807:	8b 55 0c             	mov    0xc(%ebp),%edx
     80a:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     80d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     810:	c9                   	leave  
     811:	c3                   	ret    

00000812 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     812:	f3 0f 1e fb          	endbr32 
     816:	55                   	push   %ebp
     817:	89 e5                	mov    %esp,%ebp
     819:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     81c:	83 ec 0c             	sub    $0xc,%esp
     81f:	6a 0c                	push   $0xc
     821:	e8 46 10 00 00       	call   186c <malloc>
     826:	83 c4 10             	add    $0x10,%esp
     829:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     82c:	83 ec 04             	sub    $0x4,%esp
     82f:	6a 0c                	push   $0xc
     831:	6a 00                	push   $0x0
     833:	ff 75 f4             	pushl  -0xc(%ebp)
     836:	e8 87 08 00 00       	call   10c2 <memset>
     83b:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     83e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     841:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     847:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84a:	8b 55 08             	mov    0x8(%ebp),%edx
     84d:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     850:	8b 45 f4             	mov    -0xc(%ebp),%eax
     853:	8b 55 0c             	mov    0xc(%ebp),%edx
     856:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     859:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     85c:	c9                   	leave  
     85d:	c3                   	ret    

0000085e <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     85e:	f3 0f 1e fb          	endbr32 
     862:	55                   	push   %ebp
     863:	89 e5                	mov    %esp,%ebp
     865:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     868:	83 ec 0c             	sub    $0xc,%esp
     86b:	6a 08                	push   $0x8
     86d:	e8 fa 0f 00 00       	call   186c <malloc>
     872:	83 c4 10             	add    $0x10,%esp
     875:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     878:	83 ec 04             	sub    $0x4,%esp
     87b:	6a 08                	push   $0x8
     87d:	6a 00                	push   $0x0
     87f:	ff 75 f4             	pushl  -0xc(%ebp)
     882:	e8 3b 08 00 00       	call   10c2 <memset>
     887:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     88a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88d:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     893:	8b 45 f4             	mov    -0xc(%ebp),%eax
     896:	8b 55 08             	mov    0x8(%ebp),%edx
     899:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     89c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     89f:	c9                   	leave  
     8a0:	c3                   	ret    

000008a1 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     8a1:	f3 0f 1e fb          	endbr32 
     8a5:	55                   	push   %ebp
     8a6:	89 e5                	mov    %esp,%ebp
     8a8:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     8ab:	8b 45 08             	mov    0x8(%ebp),%eax
     8ae:	8b 00                	mov    (%eax),%eax
     8b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     8b3:	eb 04                	jmp    8b9 <gettoken+0x18>
    s++;
     8b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     8b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8bc:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8bf:	73 1e                	jae    8df <gettoken+0x3e>
     8c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c4:	0f b6 00             	movzbl (%eax),%eax
     8c7:	0f be c0             	movsbl %al,%eax
     8ca:	83 ec 08             	sub    $0x8,%esp
     8cd:	50                   	push   %eax
     8ce:	68 00 27 00 00       	push   $0x2700
     8d3:	e8 08 08 00 00       	call   10e0 <strchr>
     8d8:	83 c4 10             	add    $0x10,%esp
     8db:	85 c0                	test   %eax,%eax
     8dd:	75 d6                	jne    8b5 <gettoken+0x14>
  if(q)
     8df:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     8e3:	74 08                	je     8ed <gettoken+0x4c>
    *q = s;
     8e5:	8b 45 10             	mov    0x10(%ebp),%eax
     8e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8eb:	89 10                	mov    %edx,(%eax)
  ret = *s;
     8ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8f0:	0f b6 00             	movzbl (%eax),%eax
     8f3:	0f be c0             	movsbl %al,%eax
     8f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     8f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8fc:	0f b6 00             	movzbl (%eax),%eax
     8ff:	0f be c0             	movsbl %al,%eax
     902:	83 f8 7c             	cmp    $0x7c,%eax
     905:	74 2c                	je     933 <gettoken+0x92>
     907:	83 f8 7c             	cmp    $0x7c,%eax
     90a:	7f 48                	jg     954 <gettoken+0xb3>
     90c:	83 f8 3e             	cmp    $0x3e,%eax
     90f:	74 28                	je     939 <gettoken+0x98>
     911:	83 f8 3e             	cmp    $0x3e,%eax
     914:	7f 3e                	jg     954 <gettoken+0xb3>
     916:	83 f8 3c             	cmp    $0x3c,%eax
     919:	7f 39                	jg     954 <gettoken+0xb3>
     91b:	83 f8 3b             	cmp    $0x3b,%eax
     91e:	7d 13                	jge    933 <gettoken+0x92>
     920:	83 f8 29             	cmp    $0x29,%eax
     923:	7f 2f                	jg     954 <gettoken+0xb3>
     925:	83 f8 28             	cmp    $0x28,%eax
     928:	7d 09                	jge    933 <gettoken+0x92>
     92a:	85 c0                	test   %eax,%eax
     92c:	74 79                	je     9a7 <gettoken+0x106>
     92e:	83 f8 26             	cmp    $0x26,%eax
     931:	75 21                	jne    954 <gettoken+0xb3>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     933:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     937:	eb 75                	jmp    9ae <gettoken+0x10d>
  case '>':
    s++;
     939:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     93d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     940:	0f b6 00             	movzbl (%eax),%eax
     943:	3c 3e                	cmp    $0x3e,%al
     945:	75 63                	jne    9aa <gettoken+0x109>
      ret = '+';
     947:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     94e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     952:	eb 56                	jmp    9aa <gettoken+0x109>
  default:
    ret = 'a';
     954:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     95b:	eb 04                	jmp    961 <gettoken+0xc0>
      s++;
     95d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     961:	8b 45 f4             	mov    -0xc(%ebp),%eax
     964:	3b 45 0c             	cmp    0xc(%ebp),%eax
     967:	73 44                	jae    9ad <gettoken+0x10c>
     969:	8b 45 f4             	mov    -0xc(%ebp),%eax
     96c:	0f b6 00             	movzbl (%eax),%eax
     96f:	0f be c0             	movsbl %al,%eax
     972:	83 ec 08             	sub    $0x8,%esp
     975:	50                   	push   %eax
     976:	68 00 27 00 00       	push   $0x2700
     97b:	e8 60 07 00 00       	call   10e0 <strchr>
     980:	83 c4 10             	add    $0x10,%esp
     983:	85 c0                	test   %eax,%eax
     985:	75 26                	jne    9ad <gettoken+0x10c>
     987:	8b 45 f4             	mov    -0xc(%ebp),%eax
     98a:	0f b6 00             	movzbl (%eax),%eax
     98d:	0f be c0             	movsbl %al,%eax
     990:	83 ec 08             	sub    $0x8,%esp
     993:	50                   	push   %eax
     994:	68 08 27 00 00       	push   $0x2708
     999:	e8 42 07 00 00       	call   10e0 <strchr>
     99e:	83 c4 10             	add    $0x10,%esp
     9a1:	85 c0                	test   %eax,%eax
     9a3:	74 b8                	je     95d <gettoken+0xbc>
    break;
     9a5:	eb 06                	jmp    9ad <gettoken+0x10c>
    break;
     9a7:	90                   	nop
     9a8:	eb 04                	jmp    9ae <gettoken+0x10d>
    break;
     9aa:	90                   	nop
     9ab:	eb 01                	jmp    9ae <gettoken+0x10d>
    break;
     9ad:	90                   	nop
  }
  if(eq)
     9ae:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     9b2:	74 0e                	je     9c2 <gettoken+0x121>
    *eq = s;
     9b4:	8b 45 14             	mov    0x14(%ebp),%eax
     9b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     9ba:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     9bc:	eb 04                	jmp    9c2 <gettoken+0x121>
    s++;
     9be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     9c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
     9c8:	73 1e                	jae    9e8 <gettoken+0x147>
     9ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     9cd:	0f b6 00             	movzbl (%eax),%eax
     9d0:	0f be c0             	movsbl %al,%eax
     9d3:	83 ec 08             	sub    $0x8,%esp
     9d6:	50                   	push   %eax
     9d7:	68 00 27 00 00       	push   $0x2700
     9dc:	e8 ff 06 00 00       	call   10e0 <strchr>
     9e1:	83 c4 10             	add    $0x10,%esp
     9e4:	85 c0                	test   %eax,%eax
     9e6:	75 d6                	jne    9be <gettoken+0x11d>
  *ps = s;
     9e8:	8b 45 08             	mov    0x8(%ebp),%eax
     9eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
     9ee:	89 10                	mov    %edx,(%eax)
  return ret;
     9f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     9f3:	c9                   	leave  
     9f4:	c3                   	ret    

000009f5 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     9f5:	f3 0f 1e fb          	endbr32 
     9f9:	55                   	push   %ebp
     9fa:	89 e5                	mov    %esp,%ebp
     9fc:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     9ff:	8b 45 08             	mov    0x8(%ebp),%eax
     a02:	8b 00                	mov    (%eax),%eax
     a04:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     a07:	eb 04                	jmp    a0d <peek+0x18>
    s++;
     a09:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a10:	3b 45 0c             	cmp    0xc(%ebp),%eax
     a13:	73 1e                	jae    a33 <peek+0x3e>
     a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a18:	0f b6 00             	movzbl (%eax),%eax
     a1b:	0f be c0             	movsbl %al,%eax
     a1e:	83 ec 08             	sub    $0x8,%esp
     a21:	50                   	push   %eax
     a22:	68 00 27 00 00       	push   $0x2700
     a27:	e8 b4 06 00 00       	call   10e0 <strchr>
     a2c:	83 c4 10             	add    $0x10,%esp
     a2f:	85 c0                	test   %eax,%eax
     a31:	75 d6                	jne    a09 <peek+0x14>
  *ps = s;
     a33:	8b 45 08             	mov    0x8(%ebp),%eax
     a36:	8b 55 f4             	mov    -0xc(%ebp),%edx
     a39:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     a3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a3e:	0f b6 00             	movzbl (%eax),%eax
     a41:	84 c0                	test   %al,%al
     a43:	74 23                	je     a68 <peek+0x73>
     a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a48:	0f b6 00             	movzbl (%eax),%eax
     a4b:	0f be c0             	movsbl %al,%eax
     a4e:	83 ec 08             	sub    $0x8,%esp
     a51:	50                   	push   %eax
     a52:	ff 75 10             	pushl  0x10(%ebp)
     a55:	e8 86 06 00 00       	call   10e0 <strchr>
     a5a:	83 c4 10             	add    $0x10,%esp
     a5d:	85 c0                	test   %eax,%eax
     a5f:	74 07                	je     a68 <peek+0x73>
     a61:	b8 01 00 00 00       	mov    $0x1,%eax
     a66:	eb 05                	jmp    a6d <peek+0x78>
     a68:	b8 00 00 00 00       	mov    $0x0,%eax
}
     a6d:	c9                   	leave  
     a6e:	c3                   	ret    

00000a6f <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     a6f:	f3 0f 1e fb          	endbr32 
     a73:	55                   	push   %ebp
     a74:	89 e5                	mov    %esp,%ebp
     a76:	53                   	push   %ebx
     a77:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     a7a:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a7d:	8b 45 08             	mov    0x8(%ebp),%eax
     a80:	83 ec 0c             	sub    $0xc,%esp
     a83:	50                   	push   %eax
     a84:	e8 0e 06 00 00       	call   1097 <strlen>
     a89:	83 c4 10             	add    $0x10,%esp
     a8c:	01 d8                	add    %ebx,%eax
     a8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     a91:	83 ec 08             	sub    $0x8,%esp
     a94:	ff 75 f4             	pushl  -0xc(%ebp)
     a97:	8d 45 08             	lea    0x8(%ebp),%eax
     a9a:	50                   	push   %eax
     a9b:	e8 61 00 00 00       	call   b01 <parseline>
     aa0:	83 c4 10             	add    $0x10,%esp
     aa3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     aa6:	83 ec 04             	sub    $0x4,%esp
     aa9:	68 56 1f 00 00       	push   $0x1f56
     aae:	ff 75 f4             	pushl  -0xc(%ebp)
     ab1:	8d 45 08             	lea    0x8(%ebp),%eax
     ab4:	50                   	push   %eax
     ab5:	e8 3b ff ff ff       	call   9f5 <peek>
     aba:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     abd:	8b 45 08             	mov    0x8(%ebp),%eax
     ac0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     ac3:	74 26                	je     aeb <parsecmd+0x7c>
    printf(2, "leftovers: %s\n", s);
     ac5:	8b 45 08             	mov    0x8(%ebp),%eax
     ac8:	83 ec 04             	sub    $0x4,%esp
     acb:	50                   	push   %eax
     acc:	68 57 1f 00 00       	push   $0x1f57
     ad1:	6a 02                	push   $0x2
     ad3:	e8 b4 0a 00 00       	call   158c <printf>
     ad8:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     adb:	83 ec 0c             	sub    $0xc,%esp
     ade:	68 66 1f 00 00       	push   $0x1f66
     ae3:	e8 ec fb ff ff       	call   6d4 <panic>
     ae8:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     aeb:	83 ec 0c             	sub    $0xc,%esp
     aee:	ff 75 f0             	pushl  -0x10(%ebp)
     af1:	e8 03 04 00 00       	call   ef9 <nulterminate>
     af6:	83 c4 10             	add    $0x10,%esp
  return cmd;
     af9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     afc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     aff:	c9                   	leave  
     b00:	c3                   	ret    

00000b01 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     b01:	f3 0f 1e fb          	endbr32 
     b05:	55                   	push   %ebp
     b06:	89 e5                	mov    %esp,%ebp
     b08:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     b0b:	83 ec 08             	sub    $0x8,%esp
     b0e:	ff 75 0c             	pushl  0xc(%ebp)
     b11:	ff 75 08             	pushl  0x8(%ebp)
     b14:	e8 99 00 00 00       	call   bb2 <parsepipe>
     b19:	83 c4 10             	add    $0x10,%esp
     b1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     b1f:	eb 23                	jmp    b44 <parseline+0x43>
    gettoken(ps, es, 0, 0);
     b21:	6a 00                	push   $0x0
     b23:	6a 00                	push   $0x0
     b25:	ff 75 0c             	pushl  0xc(%ebp)
     b28:	ff 75 08             	pushl  0x8(%ebp)
     b2b:	e8 71 fd ff ff       	call   8a1 <gettoken>
     b30:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     b33:	83 ec 0c             	sub    $0xc,%esp
     b36:	ff 75 f4             	pushl  -0xc(%ebp)
     b39:	e8 20 fd ff ff       	call   85e <backcmd>
     b3e:	83 c4 10             	add    $0x10,%esp
     b41:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     b44:	83 ec 04             	sub    $0x4,%esp
     b47:	68 6d 1f 00 00       	push   $0x1f6d
     b4c:	ff 75 0c             	pushl  0xc(%ebp)
     b4f:	ff 75 08             	pushl  0x8(%ebp)
     b52:	e8 9e fe ff ff       	call   9f5 <peek>
     b57:	83 c4 10             	add    $0x10,%esp
     b5a:	85 c0                	test   %eax,%eax
     b5c:	75 c3                	jne    b21 <parseline+0x20>
  }
  if(peek(ps, es, ";")){
     b5e:	83 ec 04             	sub    $0x4,%esp
     b61:	68 6f 1f 00 00       	push   $0x1f6f
     b66:	ff 75 0c             	pushl  0xc(%ebp)
     b69:	ff 75 08             	pushl  0x8(%ebp)
     b6c:	e8 84 fe ff ff       	call   9f5 <peek>
     b71:	83 c4 10             	add    $0x10,%esp
     b74:	85 c0                	test   %eax,%eax
     b76:	74 35                	je     bad <parseline+0xac>
    gettoken(ps, es, 0, 0);
     b78:	6a 00                	push   $0x0
     b7a:	6a 00                	push   $0x0
     b7c:	ff 75 0c             	pushl  0xc(%ebp)
     b7f:	ff 75 08             	pushl  0x8(%ebp)
     b82:	e8 1a fd ff ff       	call   8a1 <gettoken>
     b87:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     b8a:	83 ec 08             	sub    $0x8,%esp
     b8d:	ff 75 0c             	pushl  0xc(%ebp)
     b90:	ff 75 08             	pushl  0x8(%ebp)
     b93:	e8 69 ff ff ff       	call   b01 <parseline>
     b98:	83 c4 10             	add    $0x10,%esp
     b9b:	83 ec 08             	sub    $0x8,%esp
     b9e:	50                   	push   %eax
     b9f:	ff 75 f4             	pushl  -0xc(%ebp)
     ba2:	e8 6b fc ff ff       	call   812 <listcmd>
     ba7:	83 c4 10             	add    $0x10,%esp
     baa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     bb0:	c9                   	leave  
     bb1:	c3                   	ret    

00000bb2 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     bb2:	f3 0f 1e fb          	endbr32 
     bb6:	55                   	push   %ebp
     bb7:	89 e5                	mov    %esp,%ebp
     bb9:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     bbc:	83 ec 08             	sub    $0x8,%esp
     bbf:	ff 75 0c             	pushl  0xc(%ebp)
     bc2:	ff 75 08             	pushl  0x8(%ebp)
     bc5:	e8 f8 01 00 00       	call   dc2 <parseexec>
     bca:	83 c4 10             	add    $0x10,%esp
     bcd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     bd0:	83 ec 04             	sub    $0x4,%esp
     bd3:	68 71 1f 00 00       	push   $0x1f71
     bd8:	ff 75 0c             	pushl  0xc(%ebp)
     bdb:	ff 75 08             	pushl  0x8(%ebp)
     bde:	e8 12 fe ff ff       	call   9f5 <peek>
     be3:	83 c4 10             	add    $0x10,%esp
     be6:	85 c0                	test   %eax,%eax
     be8:	74 35                	je     c1f <parsepipe+0x6d>
    gettoken(ps, es, 0, 0);
     bea:	6a 00                	push   $0x0
     bec:	6a 00                	push   $0x0
     bee:	ff 75 0c             	pushl  0xc(%ebp)
     bf1:	ff 75 08             	pushl  0x8(%ebp)
     bf4:	e8 a8 fc ff ff       	call   8a1 <gettoken>
     bf9:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     bfc:	83 ec 08             	sub    $0x8,%esp
     bff:	ff 75 0c             	pushl  0xc(%ebp)
     c02:	ff 75 08             	pushl  0x8(%ebp)
     c05:	e8 a8 ff ff ff       	call   bb2 <parsepipe>
     c0a:	83 c4 10             	add    $0x10,%esp
     c0d:	83 ec 08             	sub    $0x8,%esp
     c10:	50                   	push   %eax
     c11:	ff 75 f4             	pushl  -0xc(%ebp)
     c14:	e8 ad fb ff ff       	call   7c6 <pipecmd>
     c19:	83 c4 10             	add    $0x10,%esp
     c1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     c22:	c9                   	leave  
     c23:	c3                   	ret    

00000c24 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     c24:	f3 0f 1e fb          	endbr32 
     c28:	55                   	push   %ebp
     c29:	89 e5                	mov    %esp,%ebp
     c2b:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     c2e:	e9 ba 00 00 00       	jmp    ced <parseredirs+0xc9>
    tok = gettoken(ps, es, 0, 0);
     c33:	6a 00                	push   $0x0
     c35:	6a 00                	push   $0x0
     c37:	ff 75 10             	pushl  0x10(%ebp)
     c3a:	ff 75 0c             	pushl  0xc(%ebp)
     c3d:	e8 5f fc ff ff       	call   8a1 <gettoken>
     c42:	83 c4 10             	add    $0x10,%esp
     c45:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     c48:	8d 45 ec             	lea    -0x14(%ebp),%eax
     c4b:	50                   	push   %eax
     c4c:	8d 45 f0             	lea    -0x10(%ebp),%eax
     c4f:	50                   	push   %eax
     c50:	ff 75 10             	pushl  0x10(%ebp)
     c53:	ff 75 0c             	pushl  0xc(%ebp)
     c56:	e8 46 fc ff ff       	call   8a1 <gettoken>
     c5b:	83 c4 10             	add    $0x10,%esp
     c5e:	83 f8 61             	cmp    $0x61,%eax
     c61:	74 10                	je     c73 <parseredirs+0x4f>
      panic("missing file for redirection");
     c63:	83 ec 0c             	sub    $0xc,%esp
     c66:	68 73 1f 00 00       	push   $0x1f73
     c6b:	e8 64 fa ff ff       	call   6d4 <panic>
     c70:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     c73:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     c77:	74 31                	je     caa <parseredirs+0x86>
     c79:	83 7d f4 3e          	cmpl   $0x3e,-0xc(%ebp)
     c7d:	7f 6e                	jg     ced <parseredirs+0xc9>
     c7f:	83 7d f4 2b          	cmpl   $0x2b,-0xc(%ebp)
     c83:	74 47                	je     ccc <parseredirs+0xa8>
     c85:	83 7d f4 3c          	cmpl   $0x3c,-0xc(%ebp)
     c89:	75 62                	jne    ced <parseredirs+0xc9>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     c8b:	8b 55 ec             	mov    -0x14(%ebp),%edx
     c8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c91:	83 ec 0c             	sub    $0xc,%esp
     c94:	6a 00                	push   $0x0
     c96:	6a 00                	push   $0x0
     c98:	52                   	push   %edx
     c99:	50                   	push   %eax
     c9a:	ff 75 08             	pushl  0x8(%ebp)
     c9d:	e8 bd fa ff ff       	call   75f <redircmd>
     ca2:	83 c4 20             	add    $0x20,%esp
     ca5:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     ca8:	eb 43                	jmp    ced <parseredirs+0xc9>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     caa:	8b 55 ec             	mov    -0x14(%ebp),%edx
     cad:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cb0:	83 ec 0c             	sub    $0xc,%esp
     cb3:	6a 01                	push   $0x1
     cb5:	68 01 02 00 00       	push   $0x201
     cba:	52                   	push   %edx
     cbb:	50                   	push   %eax
     cbc:	ff 75 08             	pushl  0x8(%ebp)
     cbf:	e8 9b fa ff ff       	call   75f <redircmd>
     cc4:	83 c4 20             	add    $0x20,%esp
     cc7:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     cca:	eb 21                	jmp    ced <parseredirs+0xc9>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     ccc:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ccf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cd2:	83 ec 0c             	sub    $0xc,%esp
     cd5:	6a 01                	push   $0x1
     cd7:	68 01 02 00 00       	push   $0x201
     cdc:	52                   	push   %edx
     cdd:	50                   	push   %eax
     cde:	ff 75 08             	pushl  0x8(%ebp)
     ce1:	e8 79 fa ff ff       	call   75f <redircmd>
     ce6:	83 c4 20             	add    $0x20,%esp
     ce9:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     cec:	90                   	nop
  while(peek(ps, es, "<>")){
     ced:	83 ec 04             	sub    $0x4,%esp
     cf0:	68 90 1f 00 00       	push   $0x1f90
     cf5:	ff 75 10             	pushl  0x10(%ebp)
     cf8:	ff 75 0c             	pushl  0xc(%ebp)
     cfb:	e8 f5 fc ff ff       	call   9f5 <peek>
     d00:	83 c4 10             	add    $0x10,%esp
     d03:	85 c0                	test   %eax,%eax
     d05:	0f 85 28 ff ff ff    	jne    c33 <parseredirs+0xf>
    }
  }
  return cmd;
     d0b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     d0e:	c9                   	leave  
     d0f:	c3                   	ret    

00000d10 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     d10:	f3 0f 1e fb          	endbr32 
     d14:	55                   	push   %ebp
     d15:	89 e5                	mov    %esp,%ebp
     d17:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     d1a:	83 ec 04             	sub    $0x4,%esp
     d1d:	68 93 1f 00 00       	push   $0x1f93
     d22:	ff 75 0c             	pushl  0xc(%ebp)
     d25:	ff 75 08             	pushl  0x8(%ebp)
     d28:	e8 c8 fc ff ff       	call   9f5 <peek>
     d2d:	83 c4 10             	add    $0x10,%esp
     d30:	85 c0                	test   %eax,%eax
     d32:	75 10                	jne    d44 <parseblock+0x34>
    panic("parseblock");
     d34:	83 ec 0c             	sub    $0xc,%esp
     d37:	68 95 1f 00 00       	push   $0x1f95
     d3c:	e8 93 f9 ff ff       	call   6d4 <panic>
     d41:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     d44:	6a 00                	push   $0x0
     d46:	6a 00                	push   $0x0
     d48:	ff 75 0c             	pushl  0xc(%ebp)
     d4b:	ff 75 08             	pushl  0x8(%ebp)
     d4e:	e8 4e fb ff ff       	call   8a1 <gettoken>
     d53:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     d56:	83 ec 08             	sub    $0x8,%esp
     d59:	ff 75 0c             	pushl  0xc(%ebp)
     d5c:	ff 75 08             	pushl  0x8(%ebp)
     d5f:	e8 9d fd ff ff       	call   b01 <parseline>
     d64:	83 c4 10             	add    $0x10,%esp
     d67:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     d6a:	83 ec 04             	sub    $0x4,%esp
     d6d:	68 a0 1f 00 00       	push   $0x1fa0
     d72:	ff 75 0c             	pushl  0xc(%ebp)
     d75:	ff 75 08             	pushl  0x8(%ebp)
     d78:	e8 78 fc ff ff       	call   9f5 <peek>
     d7d:	83 c4 10             	add    $0x10,%esp
     d80:	85 c0                	test   %eax,%eax
     d82:	75 10                	jne    d94 <parseblock+0x84>
    panic("syntax - missing )");
     d84:	83 ec 0c             	sub    $0xc,%esp
     d87:	68 a2 1f 00 00       	push   $0x1fa2
     d8c:	e8 43 f9 ff ff       	call   6d4 <panic>
     d91:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     d94:	6a 00                	push   $0x0
     d96:	6a 00                	push   $0x0
     d98:	ff 75 0c             	pushl  0xc(%ebp)
     d9b:	ff 75 08             	pushl  0x8(%ebp)
     d9e:	e8 fe fa ff ff       	call   8a1 <gettoken>
     da3:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     da6:	83 ec 04             	sub    $0x4,%esp
     da9:	ff 75 0c             	pushl  0xc(%ebp)
     dac:	ff 75 08             	pushl  0x8(%ebp)
     daf:	ff 75 f4             	pushl  -0xc(%ebp)
     db2:	e8 6d fe ff ff       	call   c24 <parseredirs>
     db7:	83 c4 10             	add    $0x10,%esp
     dba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     dbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     dc0:	c9                   	leave  
     dc1:	c3                   	ret    

00000dc2 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     dc2:	f3 0f 1e fb          	endbr32 
     dc6:	55                   	push   %ebp
     dc7:	89 e5                	mov    %esp,%ebp
     dc9:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     dcc:	83 ec 04             	sub    $0x4,%esp
     dcf:	68 93 1f 00 00       	push   $0x1f93
     dd4:	ff 75 0c             	pushl  0xc(%ebp)
     dd7:	ff 75 08             	pushl  0x8(%ebp)
     dda:	e8 16 fc ff ff       	call   9f5 <peek>
     ddf:	83 c4 10             	add    $0x10,%esp
     de2:	85 c0                	test   %eax,%eax
     de4:	74 16                	je     dfc <parseexec+0x3a>
    return parseblock(ps, es);
     de6:	83 ec 08             	sub    $0x8,%esp
     de9:	ff 75 0c             	pushl  0xc(%ebp)
     dec:	ff 75 08             	pushl  0x8(%ebp)
     def:	e8 1c ff ff ff       	call   d10 <parseblock>
     df4:	83 c4 10             	add    $0x10,%esp
     df7:	e9 fb 00 00 00       	jmp    ef7 <parseexec+0x135>

  ret = execcmd();
     dfc:	e8 24 f9 ff ff       	call   725 <execcmd>
     e01:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     e04:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e07:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     e0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     e11:	83 ec 04             	sub    $0x4,%esp
     e14:	ff 75 0c             	pushl  0xc(%ebp)
     e17:	ff 75 08             	pushl  0x8(%ebp)
     e1a:	ff 75 f0             	pushl  -0x10(%ebp)
     e1d:	e8 02 fe ff ff       	call   c24 <parseredirs>
     e22:	83 c4 10             	add    $0x10,%esp
     e25:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     e28:	e9 87 00 00 00       	jmp    eb4 <parseexec+0xf2>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     e2d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     e30:	50                   	push   %eax
     e31:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     e34:	50                   	push   %eax
     e35:	ff 75 0c             	pushl  0xc(%ebp)
     e38:	ff 75 08             	pushl  0x8(%ebp)
     e3b:	e8 61 fa ff ff       	call   8a1 <gettoken>
     e40:	83 c4 10             	add    $0x10,%esp
     e43:	89 45 e8             	mov    %eax,-0x18(%ebp)
     e46:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e4a:	0f 84 84 00 00 00    	je     ed4 <parseexec+0x112>
      break;
    if(tok != 'a')
     e50:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     e54:	74 10                	je     e66 <parseexec+0xa4>
      panic("syntax");
     e56:	83 ec 0c             	sub    $0xc,%esp
     e59:	68 66 1f 00 00       	push   $0x1f66
     e5e:	e8 71 f8 ff ff       	call   6d4 <panic>
     e63:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     e66:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     e69:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     e6f:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     e73:	8b 55 e0             	mov    -0x20(%ebp),%edx
     e76:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e79:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     e7c:	83 c1 08             	add    $0x8,%ecx
     e7f:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     e83:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     e87:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     e8b:	7e 10                	jle    e9d <parseexec+0xdb>
      panic("too many args");
     e8d:	83 ec 0c             	sub    $0xc,%esp
     e90:	68 b5 1f 00 00       	push   $0x1fb5
     e95:	e8 3a f8 ff ff       	call   6d4 <panic>
     e9a:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     e9d:	83 ec 04             	sub    $0x4,%esp
     ea0:	ff 75 0c             	pushl  0xc(%ebp)
     ea3:	ff 75 08             	pushl  0x8(%ebp)
     ea6:	ff 75 f0             	pushl  -0x10(%ebp)
     ea9:	e8 76 fd ff ff       	call   c24 <parseredirs>
     eae:	83 c4 10             	add    $0x10,%esp
     eb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     eb4:	83 ec 04             	sub    $0x4,%esp
     eb7:	68 c3 1f 00 00       	push   $0x1fc3
     ebc:	ff 75 0c             	pushl  0xc(%ebp)
     ebf:	ff 75 08             	pushl  0x8(%ebp)
     ec2:	e8 2e fb ff ff       	call   9f5 <peek>
     ec7:	83 c4 10             	add    $0x10,%esp
     eca:	85 c0                	test   %eax,%eax
     ecc:	0f 84 5b ff ff ff    	je     e2d <parseexec+0x6b>
     ed2:	eb 01                	jmp    ed5 <parseexec+0x113>
      break;
     ed4:	90                   	nop
  }
  cmd->argv[argc] = 0;
     ed5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ed8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     edb:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     ee2:	00 
  cmd->eargv[argc] = 0;
     ee3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ee6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ee9:	83 c2 08             	add    $0x8,%edx
     eec:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     ef3:	00 
  return ret;
     ef4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     ef7:	c9                   	leave  
     ef8:	c3                   	ret    

00000ef9 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     ef9:	f3 0f 1e fb          	endbr32 
     efd:	55                   	push   %ebp
     efe:	89 e5                	mov    %esp,%ebp
     f00:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     f03:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     f07:	75 0a                	jne    f13 <nulterminate+0x1a>
    return 0;
     f09:	b8 00 00 00 00       	mov    $0x0,%eax
     f0e:	e9 e5 00 00 00       	jmp    ff8 <nulterminate+0xff>
  
  switch(cmd->type){
     f13:	8b 45 08             	mov    0x8(%ebp),%eax
     f16:	8b 00                	mov    (%eax),%eax
     f18:	83 f8 05             	cmp    $0x5,%eax
     f1b:	0f 87 d4 00 00 00    	ja     ff5 <nulterminate+0xfc>
     f21:	8b 04 85 c8 1f 00 00 	mov    0x1fc8(,%eax,4),%eax
     f28:	3e ff e0             	notrack jmp *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     f2b:	8b 45 08             	mov    0x8(%ebp),%eax
     f2e:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     f31:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f38:	eb 14                	jmp    f4e <nulterminate+0x55>
      *ecmd->eargv[i] = 0;
     f3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f3d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f40:	83 c2 08             	add    $0x8,%edx
     f43:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     f47:	c6 00 00             	movb   $0x0,(%eax)
    for(i=0; ecmd->argv[i]; i++)
     f4a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f4e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     f51:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f54:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     f58:	85 c0                	test   %eax,%eax
     f5a:	75 de                	jne    f3a <nulterminate+0x41>
    break;
     f5c:	e9 94 00 00 00       	jmp    ff5 <nulterminate+0xfc>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     f61:	8b 45 08             	mov    0x8(%ebp),%eax
     f64:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(rcmd->cmd);
     f67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f6a:	8b 40 04             	mov    0x4(%eax),%eax
     f6d:	83 ec 0c             	sub    $0xc,%esp
     f70:	50                   	push   %eax
     f71:	e8 83 ff ff ff       	call   ef9 <nulterminate>
     f76:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     f79:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     f7c:	8b 40 0c             	mov    0xc(%eax),%eax
     f7f:	c6 00 00             	movb   $0x0,(%eax)
    break;
     f82:	eb 71                	jmp    ff5 <nulterminate+0xfc>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     f84:	8b 45 08             	mov    0x8(%ebp),%eax
     f87:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     f8a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f8d:	8b 40 04             	mov    0x4(%eax),%eax
     f90:	83 ec 0c             	sub    $0xc,%esp
     f93:	50                   	push   %eax
     f94:	e8 60 ff ff ff       	call   ef9 <nulterminate>
     f99:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     f9c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     f9f:	8b 40 08             	mov    0x8(%eax),%eax
     fa2:	83 ec 0c             	sub    $0xc,%esp
     fa5:	50                   	push   %eax
     fa6:	e8 4e ff ff ff       	call   ef9 <nulterminate>
     fab:	83 c4 10             	add    $0x10,%esp
    break;
     fae:	eb 45                	jmp    ff5 <nulterminate+0xfc>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     fb0:	8b 45 08             	mov    0x8(%ebp),%eax
     fb3:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(lcmd->left);
     fb6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fb9:	8b 40 04             	mov    0x4(%eax),%eax
     fbc:	83 ec 0c             	sub    $0xc,%esp
     fbf:	50                   	push   %eax
     fc0:	e8 34 ff ff ff       	call   ef9 <nulterminate>
     fc5:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     fc8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fcb:	8b 40 08             	mov    0x8(%eax),%eax
     fce:	83 ec 0c             	sub    $0xc,%esp
     fd1:	50                   	push   %eax
     fd2:	e8 22 ff ff ff       	call   ef9 <nulterminate>
     fd7:	83 c4 10             	add    $0x10,%esp
    break;
     fda:	eb 19                	jmp    ff5 <nulterminate+0xfc>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     fdc:	8b 45 08             	mov    0x8(%ebp),%eax
     fdf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    nulterminate(bcmd->cmd);
     fe2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     fe5:	8b 40 04             	mov    0x4(%eax),%eax
     fe8:	83 ec 0c             	sub    $0xc,%esp
     feb:	50                   	push   %eax
     fec:	e8 08 ff ff ff       	call   ef9 <nulterminate>
     ff1:	83 c4 10             	add    $0x10,%esp
    break;
     ff4:	90                   	nop
  }
  return cmd;
     ff5:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ff8:	c9                   	leave  
     ff9:	c3                   	ret    

00000ffa <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     ffa:	55                   	push   %ebp
     ffb:	89 e5                	mov    %esp,%ebp
     ffd:	57                   	push   %edi
     ffe:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     fff:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1002:	8b 55 10             	mov    0x10(%ebp),%edx
    1005:	8b 45 0c             	mov    0xc(%ebp),%eax
    1008:	89 cb                	mov    %ecx,%ebx
    100a:	89 df                	mov    %ebx,%edi
    100c:	89 d1                	mov    %edx,%ecx
    100e:	fc                   	cld    
    100f:	f3 aa                	rep stos %al,%es:(%edi)
    1011:	89 ca                	mov    %ecx,%edx
    1013:	89 fb                	mov    %edi,%ebx
    1015:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1018:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    101b:	90                   	nop
    101c:	5b                   	pop    %ebx
    101d:	5f                   	pop    %edi
    101e:	5d                   	pop    %ebp
    101f:	c3                   	ret    

00001020 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1020:	f3 0f 1e fb          	endbr32 
    1024:	55                   	push   %ebp
    1025:	89 e5                	mov    %esp,%ebp
    1027:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    102a:	8b 45 08             	mov    0x8(%ebp),%eax
    102d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1030:	90                   	nop
    1031:	8b 55 0c             	mov    0xc(%ebp),%edx
    1034:	8d 42 01             	lea    0x1(%edx),%eax
    1037:	89 45 0c             	mov    %eax,0xc(%ebp)
    103a:	8b 45 08             	mov    0x8(%ebp),%eax
    103d:	8d 48 01             	lea    0x1(%eax),%ecx
    1040:	89 4d 08             	mov    %ecx,0x8(%ebp)
    1043:	0f b6 12             	movzbl (%edx),%edx
    1046:	88 10                	mov    %dl,(%eax)
    1048:	0f b6 00             	movzbl (%eax),%eax
    104b:	84 c0                	test   %al,%al
    104d:	75 e2                	jne    1031 <strcpy+0x11>
    ;
  return os;
    104f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1052:	c9                   	leave  
    1053:	c3                   	ret    

00001054 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1054:	f3 0f 1e fb          	endbr32 
    1058:	55                   	push   %ebp
    1059:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    105b:	eb 08                	jmp    1065 <strcmp+0x11>
    p++, q++;
    105d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1061:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    1065:	8b 45 08             	mov    0x8(%ebp),%eax
    1068:	0f b6 00             	movzbl (%eax),%eax
    106b:	84 c0                	test   %al,%al
    106d:	74 10                	je     107f <strcmp+0x2b>
    106f:	8b 45 08             	mov    0x8(%ebp),%eax
    1072:	0f b6 10             	movzbl (%eax),%edx
    1075:	8b 45 0c             	mov    0xc(%ebp),%eax
    1078:	0f b6 00             	movzbl (%eax),%eax
    107b:	38 c2                	cmp    %al,%dl
    107d:	74 de                	je     105d <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
    107f:	8b 45 08             	mov    0x8(%ebp),%eax
    1082:	0f b6 00             	movzbl (%eax),%eax
    1085:	0f b6 d0             	movzbl %al,%edx
    1088:	8b 45 0c             	mov    0xc(%ebp),%eax
    108b:	0f b6 00             	movzbl (%eax),%eax
    108e:	0f b6 c0             	movzbl %al,%eax
    1091:	29 c2                	sub    %eax,%edx
    1093:	89 d0                	mov    %edx,%eax
}
    1095:	5d                   	pop    %ebp
    1096:	c3                   	ret    

00001097 <strlen>:

uint
strlen(char *s)
{
    1097:	f3 0f 1e fb          	endbr32 
    109b:	55                   	push   %ebp
    109c:	89 e5                	mov    %esp,%ebp
    109e:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10a8:	eb 04                	jmp    10ae <strlen+0x17>
    10aa:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10ae:	8b 55 fc             	mov    -0x4(%ebp),%edx
    10b1:	8b 45 08             	mov    0x8(%ebp),%eax
    10b4:	01 d0                	add    %edx,%eax
    10b6:	0f b6 00             	movzbl (%eax),%eax
    10b9:	84 c0                	test   %al,%al
    10bb:	75 ed                	jne    10aa <strlen+0x13>
    ;
  return n;
    10bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10c0:	c9                   	leave  
    10c1:	c3                   	ret    

000010c2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    10c2:	f3 0f 1e fb          	endbr32 
    10c6:	55                   	push   %ebp
    10c7:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    10c9:	8b 45 10             	mov    0x10(%ebp),%eax
    10cc:	50                   	push   %eax
    10cd:	ff 75 0c             	pushl  0xc(%ebp)
    10d0:	ff 75 08             	pushl  0x8(%ebp)
    10d3:	e8 22 ff ff ff       	call   ffa <stosb>
    10d8:	83 c4 0c             	add    $0xc,%esp
  return dst;
    10db:	8b 45 08             	mov    0x8(%ebp),%eax
}
    10de:	c9                   	leave  
    10df:	c3                   	ret    

000010e0 <strchr>:

char*
strchr(const char *s, char c)
{
    10e0:	f3 0f 1e fb          	endbr32 
    10e4:	55                   	push   %ebp
    10e5:	89 e5                	mov    %esp,%ebp
    10e7:	83 ec 04             	sub    $0x4,%esp
    10ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    10ed:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    10f0:	eb 14                	jmp    1106 <strchr+0x26>
    if(*s == c)
    10f2:	8b 45 08             	mov    0x8(%ebp),%eax
    10f5:	0f b6 00             	movzbl (%eax),%eax
    10f8:	38 45 fc             	cmp    %al,-0x4(%ebp)
    10fb:	75 05                	jne    1102 <strchr+0x22>
      return (char*)s;
    10fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1100:	eb 13                	jmp    1115 <strchr+0x35>
  for(; *s; s++)
    1102:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1106:	8b 45 08             	mov    0x8(%ebp),%eax
    1109:	0f b6 00             	movzbl (%eax),%eax
    110c:	84 c0                	test   %al,%al
    110e:	75 e2                	jne    10f2 <strchr+0x12>
  return 0;
    1110:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1115:	c9                   	leave  
    1116:	c3                   	ret    

00001117 <gets>:

char*
gets(char *buf, int max)
{
    1117:	f3 0f 1e fb          	endbr32 
    111b:	55                   	push   %ebp
    111c:	89 e5                	mov    %esp,%ebp
    111e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1121:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1128:	eb 42                	jmp    116c <gets+0x55>
    cc = read(0, &c, 1);
    112a:	83 ec 04             	sub    $0x4,%esp
    112d:	6a 01                	push   $0x1
    112f:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1132:	50                   	push   %eax
    1133:	6a 00                	push   $0x0
    1135:	e8 9e 02 00 00       	call   13d8 <read>
    113a:	83 c4 10             	add    $0x10,%esp
    113d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    1140:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1144:	7e 33                	jle    1179 <gets+0x62>
      break;
    buf[i++] = c;
    1146:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1149:	8d 50 01             	lea    0x1(%eax),%edx
    114c:	89 55 f4             	mov    %edx,-0xc(%ebp)
    114f:	89 c2                	mov    %eax,%edx
    1151:	8b 45 08             	mov    0x8(%ebp),%eax
    1154:	01 c2                	add    %eax,%edx
    1156:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    115a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    115c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1160:	3c 0a                	cmp    $0xa,%al
    1162:	74 16                	je     117a <gets+0x63>
    1164:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1168:	3c 0d                	cmp    $0xd,%al
    116a:	74 0e                	je     117a <gets+0x63>
  for(i=0; i+1 < max; ){
    116c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    116f:	83 c0 01             	add    $0x1,%eax
    1172:	39 45 0c             	cmp    %eax,0xc(%ebp)
    1175:	7f b3                	jg     112a <gets+0x13>
    1177:	eb 01                	jmp    117a <gets+0x63>
      break;
    1179:	90                   	nop
      break;
  }
  buf[i] = '\0';
    117a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    117d:	8b 45 08             	mov    0x8(%ebp),%eax
    1180:	01 d0                	add    %edx,%eax
    1182:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1185:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1188:	c9                   	leave  
    1189:	c3                   	ret    

0000118a <fgets>:

char*
fgets(char* buf, int size, int fd)
{
    118a:	f3 0f 1e fb          	endbr32 
    118e:	55                   	push   %ebp
    118f:	89 e5                	mov    %esp,%ebp
    1191:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
    1194:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    119b:	eb 43                	jmp    11e0 <fgets+0x56>
    int cc = read(fd, &c, 1);
    119d:	83 ec 04             	sub    $0x4,%esp
    11a0:	6a 01                	push   $0x1
    11a2:	8d 45 ef             	lea    -0x11(%ebp),%eax
    11a5:	50                   	push   %eax
    11a6:	ff 75 10             	pushl  0x10(%ebp)
    11a9:	e8 2a 02 00 00       	call   13d8 <read>
    11ae:	83 c4 10             	add    $0x10,%esp
    11b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    11b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11b8:	7e 33                	jle    11ed <fgets+0x63>
      break;
    buf[i++] = c;
    11ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11bd:	8d 50 01             	lea    0x1(%eax),%edx
    11c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11c3:	89 c2                	mov    %eax,%edx
    11c5:	8b 45 08             	mov    0x8(%ebp),%eax
    11c8:	01 c2                	add    %eax,%edx
    11ca:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11ce:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    11d0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11d4:	3c 0a                	cmp    $0xa,%al
    11d6:	74 16                	je     11ee <fgets+0x64>
    11d8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    11dc:	3c 0d                	cmp    $0xd,%al
    11de:	74 0e                	je     11ee <fgets+0x64>
  for(i = 0; i + 1 < size;){
    11e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11e3:	83 c0 01             	add    $0x1,%eax
    11e6:	39 45 0c             	cmp    %eax,0xc(%ebp)
    11e9:	7f b2                	jg     119d <fgets+0x13>
    11eb:	eb 01                	jmp    11ee <fgets+0x64>
      break;
    11ed:	90                   	nop
      break;
  }
  buf[i] = '\0';
    11ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11f1:	8b 45 08             	mov    0x8(%ebp),%eax
    11f4:	01 d0                	add    %edx,%eax
    11f6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11f9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11fc:	c9                   	leave  
    11fd:	c3                   	ret    

000011fe <stat>:

int
stat(char *n, struct stat *st)
{
    11fe:	f3 0f 1e fb          	endbr32 
    1202:	55                   	push   %ebp
    1203:	89 e5                	mov    %esp,%ebp
    1205:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1208:	83 ec 08             	sub    $0x8,%esp
    120b:	6a 00                	push   $0x0
    120d:	ff 75 08             	pushl  0x8(%ebp)
    1210:	e8 eb 01 00 00       	call   1400 <open>
    1215:	83 c4 10             	add    $0x10,%esp
    1218:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    121b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    121f:	79 07                	jns    1228 <stat+0x2a>
    return -1;
    1221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1226:	eb 25                	jmp    124d <stat+0x4f>
  r = fstat(fd, st);
    1228:	83 ec 08             	sub    $0x8,%esp
    122b:	ff 75 0c             	pushl  0xc(%ebp)
    122e:	ff 75 f4             	pushl  -0xc(%ebp)
    1231:	e8 e2 01 00 00       	call   1418 <fstat>
    1236:	83 c4 10             	add    $0x10,%esp
    1239:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    123c:	83 ec 0c             	sub    $0xc,%esp
    123f:	ff 75 f4             	pushl  -0xc(%ebp)
    1242:	e8 a1 01 00 00       	call   13e8 <close>
    1247:	83 c4 10             	add    $0x10,%esp
  return r;
    124a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    124d:	c9                   	leave  
    124e:	c3                   	ret    

0000124f <atoi>:

int
atoi(const char *s)
{
    124f:	f3 0f 1e fb          	endbr32 
    1253:	55                   	push   %ebp
    1254:	89 e5                	mov    %esp,%ebp
    1256:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
    1259:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
    1260:	eb 04                	jmp    1266 <atoi+0x17>
    1262:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1266:	8b 45 08             	mov    0x8(%ebp),%eax
    1269:	0f b6 00             	movzbl (%eax),%eax
    126c:	3c 20                	cmp    $0x20,%al
    126e:	74 f2                	je     1262 <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
    1270:	8b 45 08             	mov    0x8(%ebp),%eax
    1273:	0f b6 00             	movzbl (%eax),%eax
    1276:	3c 2d                	cmp    $0x2d,%al
    1278:	75 07                	jne    1281 <atoi+0x32>
    127a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    127f:	eb 05                	jmp    1286 <atoi+0x37>
    1281:	b8 01 00 00 00       	mov    $0x1,%eax
    1286:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
    1289:	8b 45 08             	mov    0x8(%ebp),%eax
    128c:	0f b6 00             	movzbl (%eax),%eax
    128f:	3c 2b                	cmp    $0x2b,%al
    1291:	74 0a                	je     129d <atoi+0x4e>
    1293:	8b 45 08             	mov    0x8(%ebp),%eax
    1296:	0f b6 00             	movzbl (%eax),%eax
    1299:	3c 2d                	cmp    $0x2d,%al
    129b:	75 2b                	jne    12c8 <atoi+0x79>
    s++;
    129d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
    12a1:	eb 25                	jmp    12c8 <atoi+0x79>
    n = n*10 + *s++ - '0';
    12a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12a6:	89 d0                	mov    %edx,%eax
    12a8:	c1 e0 02             	shl    $0x2,%eax
    12ab:	01 d0                	add    %edx,%eax
    12ad:	01 c0                	add    %eax,%eax
    12af:	89 c1                	mov    %eax,%ecx
    12b1:	8b 45 08             	mov    0x8(%ebp),%eax
    12b4:	8d 50 01             	lea    0x1(%eax),%edx
    12b7:	89 55 08             	mov    %edx,0x8(%ebp)
    12ba:	0f b6 00             	movzbl (%eax),%eax
    12bd:	0f be c0             	movsbl %al,%eax
    12c0:	01 c8                	add    %ecx,%eax
    12c2:	83 e8 30             	sub    $0x30,%eax
    12c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12c8:	8b 45 08             	mov    0x8(%ebp),%eax
    12cb:	0f b6 00             	movzbl (%eax),%eax
    12ce:	3c 2f                	cmp    $0x2f,%al
    12d0:	7e 0a                	jle    12dc <atoi+0x8d>
    12d2:	8b 45 08             	mov    0x8(%ebp),%eax
    12d5:	0f b6 00             	movzbl (%eax),%eax
    12d8:	3c 39                	cmp    $0x39,%al
    12da:	7e c7                	jle    12a3 <atoi+0x54>
  return sign*n;
    12dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    12df:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
    12e3:	c9                   	leave  
    12e4:	c3                   	ret    

000012e5 <atoo>:

int
atoo(const char *s)
{
    12e5:	f3 0f 1e fb          	endbr32 
    12e9:	55                   	push   %ebp
    12ea:	89 e5                	mov    %esp,%ebp
    12ec:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
    12ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
    12f6:	eb 04                	jmp    12fc <atoo+0x17>
    12f8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12fc:	8b 45 08             	mov    0x8(%ebp),%eax
    12ff:	0f b6 00             	movzbl (%eax),%eax
    1302:	3c 20                	cmp    $0x20,%al
    1304:	74 f2                	je     12f8 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
    1306:	8b 45 08             	mov    0x8(%ebp),%eax
    1309:	0f b6 00             	movzbl (%eax),%eax
    130c:	3c 2d                	cmp    $0x2d,%al
    130e:	75 07                	jne    1317 <atoo+0x32>
    1310:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1315:	eb 05                	jmp    131c <atoo+0x37>
    1317:	b8 01 00 00 00       	mov    $0x1,%eax
    131c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
    131f:	8b 45 08             	mov    0x8(%ebp),%eax
    1322:	0f b6 00             	movzbl (%eax),%eax
    1325:	3c 2b                	cmp    $0x2b,%al
    1327:	74 0a                	je     1333 <atoo+0x4e>
    1329:	8b 45 08             	mov    0x8(%ebp),%eax
    132c:	0f b6 00             	movzbl (%eax),%eax
    132f:	3c 2d                	cmp    $0x2d,%al
    1331:	75 27                	jne    135a <atoo+0x75>
    s++;
    1333:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
    1337:	eb 21                	jmp    135a <atoo+0x75>
    n = n*8 + *s++ - '0';
    1339:	8b 45 fc             	mov    -0x4(%ebp),%eax
    133c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
    1343:	8b 45 08             	mov    0x8(%ebp),%eax
    1346:	8d 50 01             	lea    0x1(%eax),%edx
    1349:	89 55 08             	mov    %edx,0x8(%ebp)
    134c:	0f b6 00             	movzbl (%eax),%eax
    134f:	0f be c0             	movsbl %al,%eax
    1352:	01 c8                	add    %ecx,%eax
    1354:	83 e8 30             	sub    $0x30,%eax
    1357:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
    135a:	8b 45 08             	mov    0x8(%ebp),%eax
    135d:	0f b6 00             	movzbl (%eax),%eax
    1360:	3c 2f                	cmp    $0x2f,%al
    1362:	7e 0a                	jle    136e <atoo+0x89>
    1364:	8b 45 08             	mov    0x8(%ebp),%eax
    1367:	0f b6 00             	movzbl (%eax),%eax
    136a:	3c 37                	cmp    $0x37,%al
    136c:	7e cb                	jle    1339 <atoo+0x54>
  return sign*n;
    136e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1371:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
    1375:	c9                   	leave  
    1376:	c3                   	ret    

00001377 <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
    1377:	f3 0f 1e fb          	endbr32 
    137b:	55                   	push   %ebp
    137c:	89 e5                	mov    %esp,%ebp
    137e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1381:	8b 45 08             	mov    0x8(%ebp),%eax
    1384:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1387:	8b 45 0c             	mov    0xc(%ebp),%eax
    138a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    138d:	eb 17                	jmp    13a6 <memmove+0x2f>
    *dst++ = *src++;
    138f:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1392:	8d 42 01             	lea    0x1(%edx),%eax
    1395:	89 45 f8             	mov    %eax,-0x8(%ebp)
    1398:	8b 45 fc             	mov    -0x4(%ebp),%eax
    139b:	8d 48 01             	lea    0x1(%eax),%ecx
    139e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    13a1:	0f b6 12             	movzbl (%edx),%edx
    13a4:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    13a6:	8b 45 10             	mov    0x10(%ebp),%eax
    13a9:	8d 50 ff             	lea    -0x1(%eax),%edx
    13ac:	89 55 10             	mov    %edx,0x10(%ebp)
    13af:	85 c0                	test   %eax,%eax
    13b1:	7f dc                	jg     138f <memmove+0x18>
  return vdst;
    13b3:	8b 45 08             	mov    0x8(%ebp),%eax
}
    13b6:	c9                   	leave  
    13b7:	c3                   	ret    

000013b8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    13b8:	b8 01 00 00 00       	mov    $0x1,%eax
    13bd:	cd 40                	int    $0x40
    13bf:	c3                   	ret    

000013c0 <exit>:
SYSCALL(exit)
    13c0:	b8 02 00 00 00       	mov    $0x2,%eax
    13c5:	cd 40                	int    $0x40
    13c7:	c3                   	ret    

000013c8 <wait>:
SYSCALL(wait)
    13c8:	b8 03 00 00 00       	mov    $0x3,%eax
    13cd:	cd 40                	int    $0x40
    13cf:	c3                   	ret    

000013d0 <pipe>:
SYSCALL(pipe)
    13d0:	b8 04 00 00 00       	mov    $0x4,%eax
    13d5:	cd 40                	int    $0x40
    13d7:	c3                   	ret    

000013d8 <read>:
SYSCALL(read)
    13d8:	b8 05 00 00 00       	mov    $0x5,%eax
    13dd:	cd 40                	int    $0x40
    13df:	c3                   	ret    

000013e0 <write>:
SYSCALL(write)
    13e0:	b8 10 00 00 00       	mov    $0x10,%eax
    13e5:	cd 40                	int    $0x40
    13e7:	c3                   	ret    

000013e8 <close>:
SYSCALL(close)
    13e8:	b8 15 00 00 00       	mov    $0x15,%eax
    13ed:	cd 40                	int    $0x40
    13ef:	c3                   	ret    

000013f0 <kill>:
SYSCALL(kill)
    13f0:	b8 06 00 00 00       	mov    $0x6,%eax
    13f5:	cd 40                	int    $0x40
    13f7:	c3                   	ret    

000013f8 <exec>:
SYSCALL(exec)
    13f8:	b8 07 00 00 00       	mov    $0x7,%eax
    13fd:	cd 40                	int    $0x40
    13ff:	c3                   	ret    

00001400 <open>:
SYSCALL(open)
    1400:	b8 0f 00 00 00       	mov    $0xf,%eax
    1405:	cd 40                	int    $0x40
    1407:	c3                   	ret    

00001408 <mknod>:
SYSCALL(mknod)
    1408:	b8 11 00 00 00       	mov    $0x11,%eax
    140d:	cd 40                	int    $0x40
    140f:	c3                   	ret    

00001410 <unlink>:
SYSCALL(unlink)
    1410:	b8 12 00 00 00       	mov    $0x12,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <fstat>:
SYSCALL(fstat)
    1418:	b8 08 00 00 00       	mov    $0x8,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <link>:
SYSCALL(link)
    1420:	b8 13 00 00 00       	mov    $0x13,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <mkdir>:
SYSCALL(mkdir)
    1428:	b8 14 00 00 00       	mov    $0x14,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <chdir>:
SYSCALL(chdir)
    1430:	b8 09 00 00 00       	mov    $0x9,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    

00001438 <dup>:
SYSCALL(dup)
    1438:	b8 0a 00 00 00       	mov    $0xa,%eax
    143d:	cd 40                	int    $0x40
    143f:	c3                   	ret    

00001440 <getpid>:
SYSCALL(getpid)
    1440:	b8 0b 00 00 00       	mov    $0xb,%eax
    1445:	cd 40                	int    $0x40
    1447:	c3                   	ret    

00001448 <sbrk>:
SYSCALL(sbrk)
    1448:	b8 0c 00 00 00       	mov    $0xc,%eax
    144d:	cd 40                	int    $0x40
    144f:	c3                   	ret    

00001450 <sleep>:
SYSCALL(sleep)
    1450:	b8 0d 00 00 00       	mov    $0xd,%eax
    1455:	cd 40                	int    $0x40
    1457:	c3                   	ret    

00001458 <uptime>:
SYSCALL(uptime)
    1458:	b8 0e 00 00 00       	mov    $0xe,%eax
    145d:	cd 40                	int    $0x40
    145f:	c3                   	ret    

00001460 <halt>:
SYSCALL(halt)
    1460:	b8 16 00 00 00       	mov    $0x16,%eax
    1465:	cd 40                	int    $0x40
    1467:	c3                   	ret    

00001468 <date>:
SYSCALL(date)
    1468:	b8 17 00 00 00       	mov    $0x17,%eax
    146d:	cd 40                	int    $0x40
    146f:	c3                   	ret    

00001470 <getuid>:
SYSCALL(getuid)
    1470:	b8 18 00 00 00       	mov    $0x18,%eax
    1475:	cd 40                	int    $0x40
    1477:	c3                   	ret    

00001478 <getgid>:
SYSCALL(getgid)
    1478:	b8 19 00 00 00       	mov    $0x19,%eax
    147d:	cd 40                	int    $0x40
    147f:	c3                   	ret    

00001480 <getppid>:
SYSCALL(getppid)
    1480:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1485:	cd 40                	int    $0x40
    1487:	c3                   	ret    

00001488 <setuid>:
SYSCALL(setuid)
    1488:	b8 1b 00 00 00       	mov    $0x1b,%eax
    148d:	cd 40                	int    $0x40
    148f:	c3                   	ret    

00001490 <setgid>:
SYSCALL(setgid)
    1490:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1495:	cd 40                	int    $0x40
    1497:	c3                   	ret    

00001498 <getprocs>:
SYSCALL(getprocs)
    1498:	b8 1d 00 00 00       	mov    $0x1d,%eax
    149d:	cd 40                	int    $0x40
    149f:	c3                   	ret    

000014a0 <setpriority>:
SYSCALL(setpriority)
    14a0:	b8 1e 00 00 00       	mov    $0x1e,%eax
    14a5:	cd 40                	int    $0x40
    14a7:	c3                   	ret    

000014a8 <chown>:
SYSCALL(chown)
    14a8:	b8 1f 00 00 00       	mov    $0x1f,%eax
    14ad:	cd 40                	int    $0x40
    14af:	c3                   	ret    

000014b0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    14b0:	f3 0f 1e fb          	endbr32 
    14b4:	55                   	push   %ebp
    14b5:	89 e5                	mov    %esp,%ebp
    14b7:	83 ec 18             	sub    $0x18,%esp
    14ba:	8b 45 0c             	mov    0xc(%ebp),%eax
    14bd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    14c0:	83 ec 04             	sub    $0x4,%esp
    14c3:	6a 01                	push   $0x1
    14c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
    14c8:	50                   	push   %eax
    14c9:	ff 75 08             	pushl  0x8(%ebp)
    14cc:	e8 0f ff ff ff       	call   13e0 <write>
    14d1:	83 c4 10             	add    $0x10,%esp
}
    14d4:	90                   	nop
    14d5:	c9                   	leave  
    14d6:	c3                   	ret    

000014d7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    14d7:	f3 0f 1e fb          	endbr32 
    14db:	55                   	push   %ebp
    14dc:	89 e5                	mov    %esp,%ebp
    14de:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    14e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    14e8:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    14ec:	74 17                	je     1505 <printint+0x2e>
    14ee:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    14f2:	79 11                	jns    1505 <printint+0x2e>
    neg = 1;
    14f4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    14fb:	8b 45 0c             	mov    0xc(%ebp),%eax
    14fe:	f7 d8                	neg    %eax
    1500:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1503:	eb 06                	jmp    150b <printint+0x34>
  } else {
    x = xx;
    1505:	8b 45 0c             	mov    0xc(%ebp),%eax
    1508:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    150b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1512:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1515:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1518:	ba 00 00 00 00       	mov    $0x0,%edx
    151d:	f7 f1                	div    %ecx
    151f:	89 d1                	mov    %edx,%ecx
    1521:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1524:	8d 50 01             	lea    0x1(%eax),%edx
    1527:	89 55 f4             	mov    %edx,-0xc(%ebp)
    152a:	0f b6 91 10 27 00 00 	movzbl 0x2710(%ecx),%edx
    1531:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    1535:	8b 4d 10             	mov    0x10(%ebp),%ecx
    1538:	8b 45 ec             	mov    -0x14(%ebp),%eax
    153b:	ba 00 00 00 00       	mov    $0x0,%edx
    1540:	f7 f1                	div    %ecx
    1542:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1545:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1549:	75 c7                	jne    1512 <printint+0x3b>
  if(neg)
    154b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    154f:	74 2d                	je     157e <printint+0xa7>
    buf[i++] = '-';
    1551:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1554:	8d 50 01             	lea    0x1(%eax),%edx
    1557:	89 55 f4             	mov    %edx,-0xc(%ebp)
    155a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    155f:	eb 1d                	jmp    157e <printint+0xa7>
    putc(fd, buf[i]);
    1561:	8d 55 dc             	lea    -0x24(%ebp),%edx
    1564:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1567:	01 d0                	add    %edx,%eax
    1569:	0f b6 00             	movzbl (%eax),%eax
    156c:	0f be c0             	movsbl %al,%eax
    156f:	83 ec 08             	sub    $0x8,%esp
    1572:	50                   	push   %eax
    1573:	ff 75 08             	pushl  0x8(%ebp)
    1576:	e8 35 ff ff ff       	call   14b0 <putc>
    157b:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    157e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    1582:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1586:	79 d9                	jns    1561 <printint+0x8a>
}
    1588:	90                   	nop
    1589:	90                   	nop
    158a:	c9                   	leave  
    158b:	c3                   	ret    

0000158c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    158c:	f3 0f 1e fb          	endbr32 
    1590:	55                   	push   %ebp
    1591:	89 e5                	mov    %esp,%ebp
    1593:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1596:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    159d:	8d 45 0c             	lea    0xc(%ebp),%eax
    15a0:	83 c0 04             	add    $0x4,%eax
    15a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    15a6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15ad:	e9 59 01 00 00       	jmp    170b <printf+0x17f>
    c = fmt[i] & 0xff;
    15b2:	8b 55 0c             	mov    0xc(%ebp),%edx
    15b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15b8:	01 d0                	add    %edx,%eax
    15ba:	0f b6 00             	movzbl (%eax),%eax
    15bd:	0f be c0             	movsbl %al,%eax
    15c0:	25 ff 00 00 00       	and    $0xff,%eax
    15c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    15c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15cc:	75 2c                	jne    15fa <printf+0x6e>
      if(c == '%'){
    15ce:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    15d2:	75 0c                	jne    15e0 <printf+0x54>
        state = '%';
    15d4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    15db:	e9 27 01 00 00       	jmp    1707 <printf+0x17b>
      } else {
        putc(fd, c);
    15e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    15e3:	0f be c0             	movsbl %al,%eax
    15e6:	83 ec 08             	sub    $0x8,%esp
    15e9:	50                   	push   %eax
    15ea:	ff 75 08             	pushl  0x8(%ebp)
    15ed:	e8 be fe ff ff       	call   14b0 <putc>
    15f2:	83 c4 10             	add    $0x10,%esp
    15f5:	e9 0d 01 00 00       	jmp    1707 <printf+0x17b>
      }
    } else if(state == '%'){
    15fa:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    15fe:	0f 85 03 01 00 00    	jne    1707 <printf+0x17b>
      if(c == 'd'){
    1604:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1608:	75 1e                	jne    1628 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    160a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    160d:	8b 00                	mov    (%eax),%eax
    160f:	6a 01                	push   $0x1
    1611:	6a 0a                	push   $0xa
    1613:	50                   	push   %eax
    1614:	ff 75 08             	pushl  0x8(%ebp)
    1617:	e8 bb fe ff ff       	call   14d7 <printint>
    161c:	83 c4 10             	add    $0x10,%esp
        ap++;
    161f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1623:	e9 d8 00 00 00       	jmp    1700 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    1628:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    162c:	74 06                	je     1634 <printf+0xa8>
    162e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1632:	75 1e                	jne    1652 <printf+0xc6>
        printint(fd, *ap, 16, 0);
    1634:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1637:	8b 00                	mov    (%eax),%eax
    1639:	6a 00                	push   $0x0
    163b:	6a 10                	push   $0x10
    163d:	50                   	push   %eax
    163e:	ff 75 08             	pushl  0x8(%ebp)
    1641:	e8 91 fe ff ff       	call   14d7 <printint>
    1646:	83 c4 10             	add    $0x10,%esp
        ap++;
    1649:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    164d:	e9 ae 00 00 00       	jmp    1700 <printf+0x174>
      } else if(c == 's'){
    1652:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    1656:	75 43                	jne    169b <printf+0x10f>
        s = (char*)*ap;
    1658:	8b 45 e8             	mov    -0x18(%ebp),%eax
    165b:	8b 00                	mov    (%eax),%eax
    165d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    1660:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    1664:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1668:	75 25                	jne    168f <printf+0x103>
          s = "(null)";
    166a:	c7 45 f4 e0 1f 00 00 	movl   $0x1fe0,-0xc(%ebp)
        while(*s != 0){
    1671:	eb 1c                	jmp    168f <printf+0x103>
          putc(fd, *s);
    1673:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1676:	0f b6 00             	movzbl (%eax),%eax
    1679:	0f be c0             	movsbl %al,%eax
    167c:	83 ec 08             	sub    $0x8,%esp
    167f:	50                   	push   %eax
    1680:	ff 75 08             	pushl  0x8(%ebp)
    1683:	e8 28 fe ff ff       	call   14b0 <putc>
    1688:	83 c4 10             	add    $0x10,%esp
          s++;
    168b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    168f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1692:	0f b6 00             	movzbl (%eax),%eax
    1695:	84 c0                	test   %al,%al
    1697:	75 da                	jne    1673 <printf+0xe7>
    1699:	eb 65                	jmp    1700 <printf+0x174>
        }
      } else if(c == 'c'){
    169b:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    169f:	75 1d                	jne    16be <printf+0x132>
        putc(fd, *ap);
    16a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16a4:	8b 00                	mov    (%eax),%eax
    16a6:	0f be c0             	movsbl %al,%eax
    16a9:	83 ec 08             	sub    $0x8,%esp
    16ac:	50                   	push   %eax
    16ad:	ff 75 08             	pushl  0x8(%ebp)
    16b0:	e8 fb fd ff ff       	call   14b0 <putc>
    16b5:	83 c4 10             	add    $0x10,%esp
        ap++;
    16b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    16bc:	eb 42                	jmp    1700 <printf+0x174>
      } else if(c == '%'){
    16be:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    16c2:	75 17                	jne    16db <printf+0x14f>
        putc(fd, c);
    16c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16c7:	0f be c0             	movsbl %al,%eax
    16ca:	83 ec 08             	sub    $0x8,%esp
    16cd:	50                   	push   %eax
    16ce:	ff 75 08             	pushl  0x8(%ebp)
    16d1:	e8 da fd ff ff       	call   14b0 <putc>
    16d6:	83 c4 10             	add    $0x10,%esp
    16d9:	eb 25                	jmp    1700 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    16db:	83 ec 08             	sub    $0x8,%esp
    16de:	6a 25                	push   $0x25
    16e0:	ff 75 08             	pushl  0x8(%ebp)
    16e3:	e8 c8 fd ff ff       	call   14b0 <putc>
    16e8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    16eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16ee:	0f be c0             	movsbl %al,%eax
    16f1:	83 ec 08             	sub    $0x8,%esp
    16f4:	50                   	push   %eax
    16f5:	ff 75 08             	pushl  0x8(%ebp)
    16f8:	e8 b3 fd ff ff       	call   14b0 <putc>
    16fd:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1700:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    1707:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    170b:	8b 55 0c             	mov    0xc(%ebp),%edx
    170e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1711:	01 d0                	add    %edx,%eax
    1713:	0f b6 00             	movzbl (%eax),%eax
    1716:	84 c0                	test   %al,%al
    1718:	0f 85 94 fe ff ff    	jne    15b2 <printf+0x26>
    }
  }
}
    171e:	90                   	nop
    171f:	90                   	nop
    1720:	c9                   	leave  
    1721:	c3                   	ret    

00001722 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1722:	f3 0f 1e fb          	endbr32 
    1726:	55                   	push   %ebp
    1727:	89 e5                	mov    %esp,%ebp
    1729:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    172c:	8b 45 08             	mov    0x8(%ebp),%eax
    172f:	83 e8 08             	sub    $0x8,%eax
    1732:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1735:	a1 ac 27 00 00       	mov    0x27ac,%eax
    173a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    173d:	eb 24                	jmp    1763 <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    173f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1742:	8b 00                	mov    (%eax),%eax
    1744:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    1747:	72 12                	jb     175b <free+0x39>
    1749:	8b 45 f8             	mov    -0x8(%ebp),%eax
    174c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    174f:	77 24                	ja     1775 <free+0x53>
    1751:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1754:	8b 00                	mov    (%eax),%eax
    1756:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1759:	72 1a                	jb     1775 <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    175b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    175e:	8b 00                	mov    (%eax),%eax
    1760:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1763:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1766:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1769:	76 d4                	jbe    173f <free+0x1d>
    176b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    176e:	8b 00                	mov    (%eax),%eax
    1770:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    1773:	73 ca                	jae    173f <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1775:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1778:	8b 40 04             	mov    0x4(%eax),%eax
    177b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1782:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1785:	01 c2                	add    %eax,%edx
    1787:	8b 45 fc             	mov    -0x4(%ebp),%eax
    178a:	8b 00                	mov    (%eax),%eax
    178c:	39 c2                	cmp    %eax,%edx
    178e:	75 24                	jne    17b4 <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1790:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1793:	8b 50 04             	mov    0x4(%eax),%edx
    1796:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1799:	8b 00                	mov    (%eax),%eax
    179b:	8b 40 04             	mov    0x4(%eax),%eax
    179e:	01 c2                	add    %eax,%edx
    17a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17a3:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    17a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a9:	8b 00                	mov    (%eax),%eax
    17ab:	8b 10                	mov    (%eax),%edx
    17ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b0:	89 10                	mov    %edx,(%eax)
    17b2:	eb 0a                	jmp    17be <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    17b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b7:	8b 10                	mov    (%eax),%edx
    17b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17bc:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    17be:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c1:	8b 40 04             	mov    0x4(%eax),%eax
    17c4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    17cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ce:	01 d0                	add    %edx,%eax
    17d0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    17d3:	75 20                	jne    17f5 <free+0xd3>
    p->s.size += bp->s.size;
    17d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d8:	8b 50 04             	mov    0x4(%eax),%edx
    17db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17de:	8b 40 04             	mov    0x4(%eax),%eax
    17e1:	01 c2                	add    %eax,%edx
    17e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    17e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17ec:	8b 10                	mov    (%eax),%edx
    17ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f1:	89 10                	mov    %edx,(%eax)
    17f3:	eb 08                	jmp    17fd <free+0xdb>
  } else
    p->s.ptr = bp;
    17f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f8:	8b 55 f8             	mov    -0x8(%ebp),%edx
    17fb:	89 10                	mov    %edx,(%eax)
  freep = p;
    17fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1800:	a3 ac 27 00 00       	mov    %eax,0x27ac
}
    1805:	90                   	nop
    1806:	c9                   	leave  
    1807:	c3                   	ret    

00001808 <morecore>:

static Header*
morecore(uint nu)
{
    1808:	f3 0f 1e fb          	endbr32 
    180c:	55                   	push   %ebp
    180d:	89 e5                	mov    %esp,%ebp
    180f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1812:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1819:	77 07                	ja     1822 <morecore+0x1a>
    nu = 4096;
    181b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1822:	8b 45 08             	mov    0x8(%ebp),%eax
    1825:	c1 e0 03             	shl    $0x3,%eax
    1828:	83 ec 0c             	sub    $0xc,%esp
    182b:	50                   	push   %eax
    182c:	e8 17 fc ff ff       	call   1448 <sbrk>
    1831:	83 c4 10             	add    $0x10,%esp
    1834:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    1837:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    183b:	75 07                	jne    1844 <morecore+0x3c>
    return 0;
    183d:	b8 00 00 00 00       	mov    $0x0,%eax
    1842:	eb 26                	jmp    186a <morecore+0x62>
  hp = (Header*)p;
    1844:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1847:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    184a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    184d:	8b 55 08             	mov    0x8(%ebp),%edx
    1850:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1853:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1856:	83 c0 08             	add    $0x8,%eax
    1859:	83 ec 0c             	sub    $0xc,%esp
    185c:	50                   	push   %eax
    185d:	e8 c0 fe ff ff       	call   1722 <free>
    1862:	83 c4 10             	add    $0x10,%esp
  return freep;
    1865:	a1 ac 27 00 00       	mov    0x27ac,%eax
}
    186a:	c9                   	leave  
    186b:	c3                   	ret    

0000186c <malloc>:

void*
malloc(uint nbytes)
{
    186c:	f3 0f 1e fb          	endbr32 
    1870:	55                   	push   %ebp
    1871:	89 e5                	mov    %esp,%ebp
    1873:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1876:	8b 45 08             	mov    0x8(%ebp),%eax
    1879:	83 c0 07             	add    $0x7,%eax
    187c:	c1 e8 03             	shr    $0x3,%eax
    187f:	83 c0 01             	add    $0x1,%eax
    1882:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    1885:	a1 ac 27 00 00       	mov    0x27ac,%eax
    188a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    188d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1891:	75 23                	jne    18b6 <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    1893:	c7 45 f0 a4 27 00 00 	movl   $0x27a4,-0x10(%ebp)
    189a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    189d:	a3 ac 27 00 00       	mov    %eax,0x27ac
    18a2:	a1 ac 27 00 00       	mov    0x27ac,%eax
    18a7:	a3 a4 27 00 00       	mov    %eax,0x27a4
    base.s.size = 0;
    18ac:	c7 05 a8 27 00 00 00 	movl   $0x0,0x27a8
    18b3:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18b9:	8b 00                	mov    (%eax),%eax
    18bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    18be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c1:	8b 40 04             	mov    0x4(%eax),%eax
    18c4:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    18c7:	77 4d                	ja     1916 <malloc+0xaa>
      if(p->s.size == nunits)
    18c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cc:	8b 40 04             	mov    0x4(%eax),%eax
    18cf:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    18d2:	75 0c                	jne    18e0 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    18d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d7:	8b 10                	mov    (%eax),%edx
    18d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18dc:	89 10                	mov    %edx,(%eax)
    18de:	eb 26                	jmp    1906 <malloc+0x9a>
      else {
        p->s.size -= nunits;
    18e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e3:	8b 40 04             	mov    0x4(%eax),%eax
    18e6:	2b 45 ec             	sub    -0x14(%ebp),%eax
    18e9:	89 c2                	mov    %eax,%edx
    18eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ee:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    18f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18f4:	8b 40 04             	mov    0x4(%eax),%eax
    18f7:	c1 e0 03             	shl    $0x3,%eax
    18fa:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    18fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1900:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1903:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1906:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1909:	a3 ac 27 00 00       	mov    %eax,0x27ac
      return (void*)(p + 1);
    190e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1911:	83 c0 08             	add    $0x8,%eax
    1914:	eb 3b                	jmp    1951 <malloc+0xe5>
    }
    if(p == freep)
    1916:	a1 ac 27 00 00       	mov    0x27ac,%eax
    191b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    191e:	75 1e                	jne    193e <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1920:	83 ec 0c             	sub    $0xc,%esp
    1923:	ff 75 ec             	pushl  -0x14(%ebp)
    1926:	e8 dd fe ff ff       	call   1808 <morecore>
    192b:	83 c4 10             	add    $0x10,%esp
    192e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1931:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1935:	75 07                	jne    193e <malloc+0xd2>
        return 0;
    1937:	b8 00 00 00 00       	mov    $0x0,%eax
    193c:	eb 13                	jmp    1951 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    193e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1941:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1944:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1947:	8b 00                	mov    (%eax),%eax
    1949:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    194c:	e9 6d ff ff ff       	jmp    18be <malloc+0x52>
  }
}
    1951:	c9                   	leave  
    1952:	c3                   	ret    

00001953 <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
    1953:	f3 0f 1e fb          	endbr32 
    1957:	55                   	push   %ebp
    1958:	89 e5                	mov    %esp,%ebp
    195a:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
    195d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
    1964:	a1 00 28 00 00       	mov    0x2800,%eax
    1969:	83 ec 04             	sub    $0x4,%esp
    196c:	50                   	push   %eax
    196d:	6a 20                	push   $0x20
    196f:	68 e0 27 00 00       	push   $0x27e0
    1974:	e8 11 f8 ff ff       	call   118a <fgets>
    1979:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
    197c:	83 ec 0c             	sub    $0xc,%esp
    197f:	68 e0 27 00 00       	push   $0x27e0
    1984:	e8 0e f7 ff ff       	call   1097 <strlen>
    1989:	83 c4 10             	add    $0x10,%esp
    198c:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
    198f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1992:	83 e8 01             	sub    $0x1,%eax
    1995:	0f b6 80 e0 27 00 00 	movzbl 0x27e0(%eax),%eax
    199c:	3c 0a                	cmp    $0xa,%al
    199e:	74 11                	je     19b1 <get_id+0x5e>
    19a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    19a3:	83 e8 01             	sub    $0x1,%eax
    19a6:	0f b6 80 e0 27 00 00 	movzbl 0x27e0(%eax),%eax
    19ad:	3c 0d                	cmp    $0xd,%al
    19af:	75 0d                	jne    19be <get_id+0x6b>
        current_line[len - 1] = 0;
    19b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    19b4:	83 e8 01             	sub    $0x1,%eax
    19b7:	c6 80 e0 27 00 00 00 	movb   $0x0,0x27e0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
    19be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
    19c5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    19cc:	eb 6c                	jmp    1a3a <get_id+0xe7>
        if(current_line[i] == ' '){
    19ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19d1:	05 e0 27 00 00       	add    $0x27e0,%eax
    19d6:	0f b6 00             	movzbl (%eax),%eax
    19d9:	3c 20                	cmp    $0x20,%al
    19db:	75 30                	jne    1a0d <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
    19dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19e1:	75 16                	jne    19f9 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
    19e3:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    19e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19e9:	8d 50 01             	lea    0x1(%eax),%edx
    19ec:	89 55 f0             	mov    %edx,-0x10(%ebp)
    19ef:	8d 91 e0 27 00 00    	lea    0x27e0(%ecx),%edx
    19f5:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
    19f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19fc:	05 e0 27 00 00       	add    $0x27e0,%eax
    1a01:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
    1a04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a0b:	eb 29                	jmp    1a36 <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
    1a0d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a11:	75 23                	jne    1a36 <get_id+0xe3>
    1a13:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1a17:	7f 1d                	jg     1a36 <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
    1a19:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
    1a20:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1a23:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a26:	8d 50 01             	lea    0x1(%eax),%edx
    1a29:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1a2c:	8d 91 e0 27 00 00    	lea    0x27e0(%ecx),%edx
    1a32:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
    1a36:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1a3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a3d:	05 e0 27 00 00       	add    $0x27e0,%eax
    1a42:	0f b6 00             	movzbl (%eax),%eax
    1a45:	84 c0                	test   %al,%al
    1a47:	75 85                	jne    19ce <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
    1a49:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a4d:	75 07                	jne    1a56 <get_id+0x103>
        return -1;
    1a4f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1a54:	eb 35                	jmp    1a8b <get_id+0x138>
    
    current_id.nama_user = tokens[0];
    1a56:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1a59:	a3 c0 27 00 00       	mov    %eax,0x27c0
    current_id.uid_user = atoi(tokens[1]);
    1a5e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1a61:	83 ec 0c             	sub    $0xc,%esp
    1a64:	50                   	push   %eax
    1a65:	e8 e5 f7 ff ff       	call   124f <atoi>
    1a6a:	83 c4 10             	add    $0x10,%esp
    1a6d:	a3 c4 27 00 00       	mov    %eax,0x27c4
    current_id.gid_user = atoi(tokens[2]);
    1a72:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a75:	83 ec 0c             	sub    $0xc,%esp
    1a78:	50                   	push   %eax
    1a79:	e8 d1 f7 ff ff       	call   124f <atoi>
    1a7e:	83 c4 10             	add    $0x10,%esp
    1a81:	a3 c8 27 00 00       	mov    %eax,0x27c8

    return 0;
    1a86:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1a8b:	c9                   	leave  
    1a8c:	c3                   	ret    

00001a8d <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
    1a8d:	f3 0f 1e fb          	endbr32 
    1a91:	55                   	push   %ebp
    1a92:	89 e5                	mov    %esp,%ebp
    1a94:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
    1a97:	a1 00 28 00 00       	mov    0x2800,%eax
    1a9c:	85 c0                	test   %eax,%eax
    1a9e:	75 31                	jne    1ad1 <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
    1aa0:	83 ec 08             	sub    $0x8,%esp
    1aa3:	6a 00                	push   $0x0
    1aa5:	68 e7 1f 00 00       	push   $0x1fe7
    1aaa:	e8 51 f9 ff ff       	call   1400 <open>
    1aaf:	83 c4 10             	add    $0x10,%esp
    1ab2:	a3 00 28 00 00       	mov    %eax,0x2800

        if(dir < 0){        // kalau gagal membuka file
    1ab7:	a1 00 28 00 00       	mov    0x2800,%eax
    1abc:	85 c0                	test   %eax,%eax
    1abe:	79 11                	jns    1ad1 <getid+0x44>
            dir = 0;
    1ac0:	c7 05 00 28 00 00 00 	movl   $0x0,0x2800
    1ac7:	00 00 00 
            return 0;
    1aca:	b8 00 00 00 00       	mov    $0x0,%eax
    1acf:	eb 16                	jmp    1ae7 <getid+0x5a>
        }
    }

    if(get_id() == -1) 
    1ad1:	e8 7d fe ff ff       	call   1953 <get_id>
    1ad6:	83 f8 ff             	cmp    $0xffffffff,%eax
    1ad9:	75 07                	jne    1ae2 <getid+0x55>
        return 0;
    1adb:	b8 00 00 00 00       	mov    $0x0,%eax
    1ae0:	eb 05                	jmp    1ae7 <getid+0x5a>
    
    return &current_id;
    1ae2:	b8 c0 27 00 00       	mov    $0x27c0,%eax
}
    1ae7:	c9                   	leave  
    1ae8:	c3                   	ret    

00001ae9 <setid>:

// open file_ids
void setid(void){
    1ae9:	f3 0f 1e fb          	endbr32 
    1aed:	55                   	push   %ebp
    1aee:	89 e5                	mov    %esp,%ebp
    1af0:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    1af3:	a1 00 28 00 00       	mov    0x2800,%eax
    1af8:	85 c0                	test   %eax,%eax
    1afa:	74 1b                	je     1b17 <setid+0x2e>
        close(dir);
    1afc:	a1 00 28 00 00       	mov    0x2800,%eax
    1b01:	83 ec 0c             	sub    $0xc,%esp
    1b04:	50                   	push   %eax
    1b05:	e8 de f8 ff ff       	call   13e8 <close>
    1b0a:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1b0d:	c7 05 00 28 00 00 00 	movl   $0x0,0x2800
    1b14:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
    1b17:	83 ec 08             	sub    $0x8,%esp
    1b1a:	6a 00                	push   $0x0
    1b1c:	68 e7 1f 00 00       	push   $0x1fe7
    1b21:	e8 da f8 ff ff       	call   1400 <open>
    1b26:	83 c4 10             	add    $0x10,%esp
    1b29:	a3 00 28 00 00       	mov    %eax,0x2800

    if (dir < 0)
    1b2e:	a1 00 28 00 00       	mov    0x2800,%eax
    1b33:	85 c0                	test   %eax,%eax
    1b35:	79 0a                	jns    1b41 <setid+0x58>
        dir = 0;
    1b37:	c7 05 00 28 00 00 00 	movl   $0x0,0x2800
    1b3e:	00 00 00 
}
    1b41:	90                   	nop
    1b42:	c9                   	leave  
    1b43:	c3                   	ret    

00001b44 <endid>:

// tutup file_ids
void endid (void){
    1b44:	f3 0f 1e fb          	endbr32 
    1b48:	55                   	push   %ebp
    1b49:	89 e5                	mov    %esp,%ebp
    1b4b:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    1b4e:	a1 00 28 00 00       	mov    0x2800,%eax
    1b53:	85 c0                	test   %eax,%eax
    1b55:	74 1b                	je     1b72 <endid+0x2e>
        close(dir);
    1b57:	a1 00 28 00 00       	mov    0x2800,%eax
    1b5c:	83 ec 0c             	sub    $0xc,%esp
    1b5f:	50                   	push   %eax
    1b60:	e8 83 f8 ff ff       	call   13e8 <close>
    1b65:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1b68:	c7 05 00 28 00 00 00 	movl   $0x0,0x2800
    1b6f:	00 00 00 
    }
}
    1b72:	90                   	nop
    1b73:	c9                   	leave  
    1b74:	c3                   	ret    

00001b75 <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
    1b75:	f3 0f 1e fb          	endbr32 
    1b79:	55                   	push   %ebp
    1b7a:	89 e5                	mov    %esp,%ebp
    1b7c:	83 ec 08             	sub    $0x8,%esp
    setid();
    1b7f:	e8 65 ff ff ff       	call   1ae9 <setid>

    while (getid()){
    1b84:	eb 24                	jmp    1baa <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
    1b86:	a1 c0 27 00 00       	mov    0x27c0,%eax
    1b8b:	83 ec 08             	sub    $0x8,%esp
    1b8e:	50                   	push   %eax
    1b8f:	ff 75 08             	pushl  0x8(%ebp)
    1b92:	e8 bd f4 ff ff       	call   1054 <strcmp>
    1b97:	83 c4 10             	add    $0x10,%esp
    1b9a:	85 c0                	test   %eax,%eax
    1b9c:	75 0c                	jne    1baa <cek_nama+0x35>
            endid();
    1b9e:	e8 a1 ff ff ff       	call   1b44 <endid>
            return &current_id;
    1ba3:	b8 c0 27 00 00       	mov    $0x27c0,%eax
    1ba8:	eb 13                	jmp    1bbd <cek_nama+0x48>
    while (getid()){
    1baa:	e8 de fe ff ff       	call   1a8d <getid>
    1baf:	85 c0                	test   %eax,%eax
    1bb1:	75 d3                	jne    1b86 <cek_nama+0x11>
        }
    }
    endid();
    1bb3:	e8 8c ff ff ff       	call   1b44 <endid>
    return 0;
    1bb8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1bbd:	c9                   	leave  
    1bbe:	c3                   	ret    

00001bbf <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
    1bbf:	f3 0f 1e fb          	endbr32 
    1bc3:	55                   	push   %ebp
    1bc4:	89 e5                	mov    %esp,%ebp
    1bc6:	83 ec 08             	sub    $0x8,%esp
    setid();
    1bc9:	e8 1b ff ff ff       	call   1ae9 <setid>

    while (getid()){
    1bce:	eb 16                	jmp    1be6 <cek_uid+0x27>
        if(current_id.uid_user == uid){
    1bd0:	a1 c4 27 00 00       	mov    0x27c4,%eax
    1bd5:	39 45 08             	cmp    %eax,0x8(%ebp)
    1bd8:	75 0c                	jne    1be6 <cek_uid+0x27>
            endid();
    1bda:	e8 65 ff ff ff       	call   1b44 <endid>
            return &current_id;
    1bdf:	b8 c0 27 00 00       	mov    $0x27c0,%eax
    1be4:	eb 13                	jmp    1bf9 <cek_uid+0x3a>
    while (getid()){
    1be6:	e8 a2 fe ff ff       	call   1a8d <getid>
    1beb:	85 c0                	test   %eax,%eax
    1bed:	75 e1                	jne    1bd0 <cek_uid+0x11>
        }
    }
    endid();
    1bef:	e8 50 ff ff ff       	call   1b44 <endid>
    return 0;
    1bf4:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1bf9:	c9                   	leave  
    1bfa:	c3                   	ret    

00001bfb <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
    1bfb:	f3 0f 1e fb          	endbr32 
    1bff:	55                   	push   %ebp
    1c00:	89 e5                	mov    %esp,%ebp
    1c02:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
    1c05:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
    1c0c:	a1 00 28 00 00       	mov    0x2800,%eax
    1c11:	83 ec 04             	sub    $0x4,%esp
    1c14:	50                   	push   %eax
    1c15:	6a 20                	push   $0x20
    1c17:	68 e0 27 00 00       	push   $0x27e0
    1c1c:	e8 69 f5 ff ff       	call   118a <fgets>
    1c21:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
    1c24:	83 ec 0c             	sub    $0xc,%esp
    1c27:	68 e0 27 00 00       	push   $0x27e0
    1c2c:	e8 66 f4 ff ff       	call   1097 <strlen>
    1c31:	83 c4 10             	add    $0x10,%esp
    1c34:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
    1c37:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c3a:	83 e8 01             	sub    $0x1,%eax
    1c3d:	0f b6 80 e0 27 00 00 	movzbl 0x27e0(%eax),%eax
    1c44:	3c 0a                	cmp    $0xa,%al
    1c46:	74 11                	je     1c59 <get_group+0x5e>
    1c48:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c4b:	83 e8 01             	sub    $0x1,%eax
    1c4e:	0f b6 80 e0 27 00 00 	movzbl 0x27e0(%eax),%eax
    1c55:	3c 0d                	cmp    $0xd,%al
    1c57:	75 0d                	jne    1c66 <get_group+0x6b>
        current_line[len - 1] = 0;
    1c59:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c5c:	83 e8 01             	sub    $0x1,%eax
    1c5f:	c6 80 e0 27 00 00 00 	movb   $0x0,0x27e0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
    1c66:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
    1c6d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1c74:	eb 6c                	jmp    1ce2 <get_group+0xe7>
        if(current_line[i] == ' '){
    1c76:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c79:	05 e0 27 00 00       	add    $0x27e0,%eax
    1c7e:	0f b6 00             	movzbl (%eax),%eax
    1c81:	3c 20                	cmp    $0x20,%al
    1c83:	75 30                	jne    1cb5 <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
    1c85:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1c89:	75 16                	jne    1ca1 <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
    1c8b:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1c8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c91:	8d 50 01             	lea    0x1(%eax),%edx
    1c94:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1c97:	8d 91 e0 27 00 00    	lea    0x27e0(%ecx),%edx
    1c9d:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
    1ca1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ca4:	05 e0 27 00 00       	add    $0x27e0,%eax
    1ca9:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
    1cac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1cb3:	eb 29                	jmp    1cde <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
    1cb5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1cb9:	75 23                	jne    1cde <get_group+0xe3>
    1cbb:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1cbf:	7f 1d                	jg     1cde <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
    1cc1:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
    1cc8:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1ccb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cce:	8d 50 01             	lea    0x1(%eax),%edx
    1cd1:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1cd4:	8d 91 e0 27 00 00    	lea    0x27e0(%ecx),%edx
    1cda:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
    1cde:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1ce2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ce5:	05 e0 27 00 00       	add    $0x27e0,%eax
    1cea:	0f b6 00             	movzbl (%eax),%eax
    1ced:	84 c0                	test   %al,%al
    1cef:	75 85                	jne    1c76 <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
    1cf1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1cf5:	75 07                	jne    1cfe <get_group+0x103>
        return -1;
    1cf7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1cfc:	eb 21                	jmp    1d1f <get_group+0x124>
    
    current_group.nama_group = tokens[0];
    1cfe:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1d01:	a3 cc 27 00 00       	mov    %eax,0x27cc
    current_group.gid = atoi(tokens[1]);
    1d06:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1d09:	83 ec 0c             	sub    $0xc,%esp
    1d0c:	50                   	push   %eax
    1d0d:	e8 3d f5 ff ff       	call   124f <atoi>
    1d12:	83 c4 10             	add    $0x10,%esp
    1d15:	a3 d0 27 00 00       	mov    %eax,0x27d0

    return 0;
    1d1a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1d1f:	c9                   	leave  
    1d20:	c3                   	ret    

00001d21 <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
    1d21:	f3 0f 1e fb          	endbr32 
    1d25:	55                   	push   %ebp
    1d26:	89 e5                	mov    %esp,%ebp
    1d28:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
    1d2b:	a1 00 28 00 00       	mov    0x2800,%eax
    1d30:	85 c0                	test   %eax,%eax
    1d32:	75 31                	jne    1d65 <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
    1d34:	83 ec 08             	sub    $0x8,%esp
    1d37:	6a 00                	push   $0x0
    1d39:	68 ef 1f 00 00       	push   $0x1fef
    1d3e:	e8 bd f6 ff ff       	call   1400 <open>
    1d43:	83 c4 10             	add    $0x10,%esp
    1d46:	a3 00 28 00 00       	mov    %eax,0x2800

        if(dir < 0){        // kalau gagal membuka file
    1d4b:	a1 00 28 00 00       	mov    0x2800,%eax
    1d50:	85 c0                	test   %eax,%eax
    1d52:	79 11                	jns    1d65 <getgroup+0x44>
            dir = 0;
    1d54:	c7 05 00 28 00 00 00 	movl   $0x0,0x2800
    1d5b:	00 00 00 
            return 0;
    1d5e:	b8 00 00 00 00       	mov    $0x0,%eax
    1d63:	eb 16                	jmp    1d7b <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
    1d65:	e8 91 fe ff ff       	call   1bfb <get_group>
    1d6a:	83 f8 ff             	cmp    $0xffffffff,%eax
    1d6d:	75 07                	jne    1d76 <getgroup+0x55>
        return 0;
    1d6f:	b8 00 00 00 00       	mov    $0x0,%eax
    1d74:	eb 05                	jmp    1d7b <getgroup+0x5a>
    
    return &current_group;
    1d76:	b8 cc 27 00 00       	mov    $0x27cc,%eax
}
    1d7b:	c9                   	leave  
    1d7c:	c3                   	ret    

00001d7d <setgroup>:

// open file_ids
void setgroup(void){
    1d7d:	f3 0f 1e fb          	endbr32 
    1d81:	55                   	push   %ebp
    1d82:	89 e5                	mov    %esp,%ebp
    1d84:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    1d87:	a1 00 28 00 00       	mov    0x2800,%eax
    1d8c:	85 c0                	test   %eax,%eax
    1d8e:	74 1b                	je     1dab <setgroup+0x2e>
        close(dir);
    1d90:	a1 00 28 00 00       	mov    0x2800,%eax
    1d95:	83 ec 0c             	sub    $0xc,%esp
    1d98:	50                   	push   %eax
    1d99:	e8 4a f6 ff ff       	call   13e8 <close>
    1d9e:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1da1:	c7 05 00 28 00 00 00 	movl   $0x0,0x2800
    1da8:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
    1dab:	83 ec 08             	sub    $0x8,%esp
    1dae:	6a 00                	push   $0x0
    1db0:	68 ef 1f 00 00       	push   $0x1fef
    1db5:	e8 46 f6 ff ff       	call   1400 <open>
    1dba:	83 c4 10             	add    $0x10,%esp
    1dbd:	a3 00 28 00 00       	mov    %eax,0x2800

    if (dir < 0)
    1dc2:	a1 00 28 00 00       	mov    0x2800,%eax
    1dc7:	85 c0                	test   %eax,%eax
    1dc9:	79 0a                	jns    1dd5 <setgroup+0x58>
        dir = 0;
    1dcb:	c7 05 00 28 00 00 00 	movl   $0x0,0x2800
    1dd2:	00 00 00 
}
    1dd5:	90                   	nop
    1dd6:	c9                   	leave  
    1dd7:	c3                   	ret    

00001dd8 <endgroup>:

// tutup file_ids
void endgroup (void){
    1dd8:	f3 0f 1e fb          	endbr32 
    1ddc:	55                   	push   %ebp
    1ddd:	89 e5                	mov    %esp,%ebp
    1ddf:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    1de2:	a1 00 28 00 00       	mov    0x2800,%eax
    1de7:	85 c0                	test   %eax,%eax
    1de9:	74 1b                	je     1e06 <endgroup+0x2e>
        close(dir);
    1deb:	a1 00 28 00 00       	mov    0x2800,%eax
    1df0:	83 ec 0c             	sub    $0xc,%esp
    1df3:	50                   	push   %eax
    1df4:	e8 ef f5 ff ff       	call   13e8 <close>
    1df9:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1dfc:	c7 05 00 28 00 00 00 	movl   $0x0,0x2800
    1e03:	00 00 00 
    }
}
    1e06:	90                   	nop
    1e07:	c9                   	leave  
    1e08:	c3                   	ret    

00001e09 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
    1e09:	f3 0f 1e fb          	endbr32 
    1e0d:	55                   	push   %ebp
    1e0e:	89 e5                	mov    %esp,%ebp
    1e10:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    1e13:	e8 65 ff ff ff       	call   1d7d <setgroup>

    while (getgroup()){
    1e18:	eb 3c                	jmp    1e56 <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
    1e1a:	a1 cc 27 00 00       	mov    0x27cc,%eax
    1e1f:	83 ec 08             	sub    $0x8,%esp
    1e22:	50                   	push   %eax
    1e23:	ff 75 08             	pushl  0x8(%ebp)
    1e26:	e8 29 f2 ff ff       	call   1054 <strcmp>
    1e2b:	83 c4 10             	add    $0x10,%esp
    1e2e:	85 c0                	test   %eax,%eax
    1e30:	75 24                	jne    1e56 <cek_nama_group+0x4d>
            endgroup();
    1e32:	e8 a1 ff ff ff       	call   1dd8 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
    1e37:	a1 cc 27 00 00       	mov    0x27cc,%eax
    1e3c:	83 ec 04             	sub    $0x4,%esp
    1e3f:	50                   	push   %eax
    1e40:	68 fa 1f 00 00       	push   $0x1ffa
    1e45:	6a 01                	push   $0x1
    1e47:	e8 40 f7 ff ff       	call   158c <printf>
    1e4c:	83 c4 10             	add    $0x10,%esp
            return &current_group;
    1e4f:	b8 cc 27 00 00       	mov    $0x27cc,%eax
    1e54:	eb 13                	jmp    1e69 <cek_nama_group+0x60>
    while (getgroup()){
    1e56:	e8 c6 fe ff ff       	call   1d21 <getgroup>
    1e5b:	85 c0                	test   %eax,%eax
    1e5d:	75 bb                	jne    1e1a <cek_nama_group+0x11>
        }
    }
    endgroup();
    1e5f:	e8 74 ff ff ff       	call   1dd8 <endgroup>
    return 0;
    1e64:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1e69:	c9                   	leave  
    1e6a:	c3                   	ret    

00001e6b <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
    1e6b:	f3 0f 1e fb          	endbr32 
    1e6f:	55                   	push   %ebp
    1e70:	89 e5                	mov    %esp,%ebp
    1e72:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    1e75:	e8 03 ff ff ff       	call   1d7d <setgroup>

    while (getgroup()){
    1e7a:	eb 16                	jmp    1e92 <cek_gid+0x27>
        if(current_group.gid == gid){
    1e7c:	a1 d0 27 00 00       	mov    0x27d0,%eax
    1e81:	39 45 08             	cmp    %eax,0x8(%ebp)
    1e84:	75 0c                	jne    1e92 <cek_gid+0x27>
            endgroup();
    1e86:	e8 4d ff ff ff       	call   1dd8 <endgroup>
            return &current_group;
    1e8b:	b8 cc 27 00 00       	mov    $0x27cc,%eax
    1e90:	eb 13                	jmp    1ea5 <cek_gid+0x3a>
    while (getgroup()){
    1e92:	e8 8a fe ff ff       	call   1d21 <getgroup>
    1e97:	85 c0                	test   %eax,%eax
    1e99:	75 e1                	jne    1e7c <cek_gid+0x11>
        }
    }
    endgroup();
    1e9b:	e8 38 ff ff ff       	call   1dd8 <endgroup>
    return 0;
    1ea0:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1ea5:	c9                   	leave  
    1ea6:	c3                   	ret    
