
_zip:     file format elf32-i386


Disassembly of section .text:

00000000 <InitTree>:

int file_masuk[10];
int 	infile, outfile;

void InitTree(void)  /* initialize trees */
{
       0:	f3 0f 1e fb          	endbr32 
       4:	55                   	push   %ebp
       5:	89 e5                	mov    %esp,%ebp
       7:	83 ec 10             	sub    $0x10,%esp
    int  i;
    for (i = N + 1; i <= N + 256; i++) rson[i] = NIL;
       a:	c7 45 fc 01 10 00 00 	movl   $0x1001,-0x4(%ebp)
      11:	eb 12                	jmp    25 <InitTree+0x25>
      13:	8b 45 fc             	mov    -0x4(%ebp),%eax
      16:	c7 04 85 a0 b0 00 00 	movl   $0x1000,0xb0a0(,%eax,4)
      1d:	00 10 00 00 
      21:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
      25:	81 7d fc 00 11 00 00 	cmpl   $0x1100,-0x4(%ebp)
      2c:	7e e5                	jle    13 <InitTree+0x13>
    for (i = 0; i < N; i++) dad[i] = NIL;
      2e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
      35:	eb 12                	jmp    49 <InitTree+0x49>
      37:	8b 45 fc             	mov    -0x4(%ebp),%eax
      3a:	c7 04 85 80 70 00 00 	movl   $0x1000,0x7080(,%eax,4)
      41:	00 10 00 00 
      45:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
      49:	81 7d fc ff 0f 00 00 	cmpl   $0xfff,-0x4(%ebp)
      50:	7e e5                	jle    37 <InitTree+0x37>
}
      52:	90                   	nop
      53:	90                   	nop
      54:	c9                   	leave  
      55:	c3                   	ret    

00000056 <InsertNode>:

void InsertNode(int r)
    /* Inserts string of length F, text_buf[r..r+F-1], into one of the
       trees and returns the longest-match position and length via the
        global variables match_position and match_length.*/
{
      56:	f3 0f 1e fb          	endbr32 
      5a:	55                   	push   %ebp
      5b:	89 e5                	mov    %esp,%ebp
      5d:	83 ec 10             	sub    $0x10,%esp
    int  i, p, cmp;
    unsigned char  *key;

    cmp = 1;  key = &text_buf[r];  p = N + 1 + key[0];
      60:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      67:	8b 45 08             	mov    0x8(%ebp),%eax
      6a:	05 00 20 00 00       	add    $0x2000,%eax
      6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
      72:	8b 45 f0             	mov    -0x10(%ebp),%eax
      75:	0f b6 00             	movzbl (%eax),%eax
      78:	0f b6 c0             	movzbl %al,%eax
      7b:	05 01 10 00 00       	add    $0x1001,%eax
      80:	89 45 f8             	mov    %eax,-0x8(%ebp)
    rson[r] = lson[r] = NIL;  match_length = 0;
      83:	8b 45 08             	mov    0x8(%ebp),%eax
      86:	c7 04 85 20 30 00 00 	movl   $0x1000,0x3020(,%eax,4)
      8d:	00 10 00 00 
      91:	8b 45 08             	mov    0x8(%ebp),%eax
      94:	8b 14 85 20 30 00 00 	mov    0x3020(,%eax,4),%edx
      9b:	8b 45 08             	mov    0x8(%ebp),%eax
      9e:	89 14 85 a0 b0 00 00 	mov    %edx,0xb0a0(,%eax,4)
      a5:	c7 05 ac f4 00 00 00 	movl   $0x0,0xf4ac
      ac:	00 00 00 
    for ( ; ; ) {
        if (cmp >= 0) {
      af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      b3:	78 3f                	js     f4 <InsertNode+0x9e>
            if (rson[p] != NIL) p = rson[p];
      b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
      b8:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
      bf:	3d 00 10 00 00       	cmp    $0x1000,%eax
      c4:	74 0f                	je     d5 <InsertNode+0x7f>
      c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
      c9:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
      d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
      d3:	eb 5e                	jmp    133 <InsertNode+0xdd>
            else {  rson[p] = r;  dad[r] = p;  return;  }
      d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
      d8:	8b 55 08             	mov    0x8(%ebp),%edx
      db:	89 14 85 a0 b0 00 00 	mov    %edx,0xb0a0(,%eax,4)
      e2:	8b 45 08             	mov    0x8(%ebp),%eax
      e5:	8b 55 f8             	mov    -0x8(%ebp),%edx
      e8:	89 14 85 80 70 00 00 	mov    %edx,0x7080(,%eax,4)
      ef:	e9 62 01 00 00       	jmp    256 <InsertNode+0x200>
        } else {
            if (lson[p] != NIL) p = lson[p];
      f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
      f7:	8b 04 85 20 30 00 00 	mov    0x3020(,%eax,4),%eax
      fe:	3d 00 10 00 00       	cmp    $0x1000,%eax
     103:	74 0f                	je     114 <InsertNode+0xbe>
     105:	8b 45 f8             	mov    -0x8(%ebp),%eax
     108:	8b 04 85 20 30 00 00 	mov    0x3020(,%eax,4),%eax
     10f:	89 45 f8             	mov    %eax,-0x8(%ebp)
     112:	eb 1f                	jmp    133 <InsertNode+0xdd>
            else {  lson[p] = r;  dad[r] = p;  return;  }
     114:	8b 45 f8             	mov    -0x8(%ebp),%eax
     117:	8b 55 08             	mov    0x8(%ebp),%edx
     11a:	89 14 85 20 30 00 00 	mov    %edx,0x3020(,%eax,4)
     121:	8b 45 08             	mov    0x8(%ebp),%eax
     124:	8b 55 f8             	mov    -0x8(%ebp),%edx
     127:	89 14 85 80 70 00 00 	mov    %edx,0x7080(,%eax,4)
     12e:	e9 23 01 00 00       	jmp    256 <InsertNode+0x200>
        }
        for (i = 1; i < F; i++)
     133:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
     13a:	eb 31                	jmp    16d <InsertNode+0x117>
            if ((cmp = key[i] - text_buf[p + i]) != 0)  break;
     13c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     13f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     142:	01 d0                	add    %edx,%eax
     144:	0f b6 00             	movzbl (%eax),%eax
     147:	0f b6 d0             	movzbl %al,%edx
     14a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
     14d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     150:	01 c8                	add    %ecx,%eax
     152:	0f b6 80 00 20 00 00 	movzbl 0x2000(%eax),%eax
     159:	0f b6 c0             	movzbl %al,%eax
     15c:	29 c2                	sub    %eax,%edx
     15e:	89 d0                	mov    %edx,%eax
     160:	89 45 f4             	mov    %eax,-0xc(%ebp)
     163:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     167:	75 0c                	jne    175 <InsertNode+0x11f>
        for (i = 1; i < F; i++)
     169:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     16d:	83 7d fc 11          	cmpl   $0x11,-0x4(%ebp)
     171:	7e c9                	jle    13c <InsertNode+0xe6>
     173:	eb 01                	jmp    176 <InsertNode+0x120>
            if ((cmp = key[i] - text_buf[p + i]) != 0)  break;
     175:	90                   	nop
        if (i > match_length) {
     176:	a1 ac f4 00 00       	mov    0xf4ac,%eax
     17b:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     17e:	0f 8e 2b ff ff ff    	jle    af <InsertNode+0x59>
            match_position = p;
     184:	8b 45 f8             	mov    -0x8(%ebp),%eax
     187:	a3 a8 f4 00 00       	mov    %eax,0xf4a8
            if ((match_length = i) >= F)  break;
     18c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     18f:	a3 ac f4 00 00       	mov    %eax,0xf4ac
     194:	a1 ac f4 00 00       	mov    0xf4ac,%eax
     199:	83 f8 11             	cmp    $0x11,%eax
     19c:	7f 05                	jg     1a3 <InsertNode+0x14d>
        if (cmp >= 0) {
     19e:	e9 0c ff ff ff       	jmp    af <InsertNode+0x59>
            if ((match_length = i) >= F)  break;
     1a3:	90                   	nop
        }
    }
    dad[r] = dad[p];  lson[r] = lson[p];  rson[r] = rson[p];
     1a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     1a7:	8b 14 85 80 70 00 00 	mov    0x7080(,%eax,4),%edx
     1ae:	8b 45 08             	mov    0x8(%ebp),%eax
     1b1:	89 14 85 80 70 00 00 	mov    %edx,0x7080(,%eax,4)
     1b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     1bb:	8b 14 85 20 30 00 00 	mov    0x3020(,%eax,4),%edx
     1c2:	8b 45 08             	mov    0x8(%ebp),%eax
     1c5:	89 14 85 20 30 00 00 	mov    %edx,0x3020(,%eax,4)
     1cc:	8b 45 f8             	mov    -0x8(%ebp),%eax
     1cf:	8b 14 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%edx
     1d6:	8b 45 08             	mov    0x8(%ebp),%eax
     1d9:	89 14 85 a0 b0 00 00 	mov    %edx,0xb0a0(,%eax,4)
    dad[lson[p]] = r;  dad[rson[p]] = r;
     1e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     1e3:	8b 04 85 20 30 00 00 	mov    0x3020(,%eax,4),%eax
     1ea:	8b 55 08             	mov    0x8(%ebp),%edx
     1ed:	89 14 85 80 70 00 00 	mov    %edx,0x7080(,%eax,4)
     1f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     1f7:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
     1fe:	8b 55 08             	mov    0x8(%ebp),%edx
     201:	89 14 85 80 70 00 00 	mov    %edx,0x7080(,%eax,4)
    if (rson[dad[p]] == p) rson[dad[p]] = r;
     208:	8b 45 f8             	mov    -0x8(%ebp),%eax
     20b:	8b 04 85 80 70 00 00 	mov    0x7080(,%eax,4),%eax
     212:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
     219:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     21c:	75 16                	jne    234 <InsertNode+0x1de>
     21e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     221:	8b 04 85 80 70 00 00 	mov    0x7080(,%eax,4),%eax
     228:	8b 55 08             	mov    0x8(%ebp),%edx
     22b:	89 14 85 a0 b0 00 00 	mov    %edx,0xb0a0(,%eax,4)
     232:	eb 14                	jmp    248 <InsertNode+0x1f2>
    else                  lson[dad[p]] = r;
     234:	8b 45 f8             	mov    -0x8(%ebp),%eax
     237:	8b 04 85 80 70 00 00 	mov    0x7080(,%eax,4),%eax
     23e:	8b 55 08             	mov    0x8(%ebp),%edx
     241:	89 14 85 20 30 00 00 	mov    %edx,0x3020(,%eax,4)
    dad[p] = NIL;  /* remove p */
     248:	8b 45 f8             	mov    -0x8(%ebp),%eax
     24b:	c7 04 85 80 70 00 00 	movl   $0x1000,0x7080(,%eax,4)
     252:	00 10 00 00 
}
     256:	c9                   	leave  
     257:	c3                   	ret    

00000258 <DeleteNode>:

void DeleteNode(int p)  /* deletes node p from tree */
{
     258:	f3 0f 1e fb          	endbr32 
     25c:	55                   	push   %ebp
     25d:	89 e5                	mov    %esp,%ebp
     25f:	83 ec 10             	sub    $0x10,%esp
    int  q;
    
    if (dad[p] == NIL) return;  /* not in tree */
     262:	8b 45 08             	mov    0x8(%ebp),%eax
     265:	8b 04 85 80 70 00 00 	mov    0x7080(,%eax,4),%eax
     26c:	3d 00 10 00 00       	cmp    $0x1000,%eax
     271:	0f 84 6c 01 00 00    	je     3e3 <DeleteNode+0x18b>
    if (rson[p] == NIL) q = lson[p];
     277:	8b 45 08             	mov    0x8(%ebp),%eax
     27a:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
     281:	3d 00 10 00 00       	cmp    $0x1000,%eax
     286:	75 12                	jne    29a <DeleteNode+0x42>
     288:	8b 45 08             	mov    0x8(%ebp),%eax
     28b:	8b 04 85 20 30 00 00 	mov    0x3020(,%eax,4),%eax
     292:	89 45 fc             	mov    %eax,-0x4(%ebp)
     295:	e9 e5 00 00 00       	jmp    37f <DeleteNode+0x127>
    else if (lson[p] == NIL) q = rson[p];
     29a:	8b 45 08             	mov    0x8(%ebp),%eax
     29d:	8b 04 85 20 30 00 00 	mov    0x3020(,%eax,4),%eax
     2a4:	3d 00 10 00 00       	cmp    $0x1000,%eax
     2a9:	75 12                	jne    2bd <DeleteNode+0x65>
     2ab:	8b 45 08             	mov    0x8(%ebp),%eax
     2ae:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
     2b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
     2b8:	e9 c2 00 00 00       	jmp    37f <DeleteNode+0x127>
    else {
        q = lson[p];
     2bd:	8b 45 08             	mov    0x8(%ebp),%eax
     2c0:	8b 04 85 20 30 00 00 	mov    0x3020(,%eax,4),%eax
     2c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
        if (rson[q] != NIL) {
     2ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2cd:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
     2d4:	3d 00 10 00 00       	cmp    $0x1000,%eax
     2d9:	74 7c                	je     357 <DeleteNode+0xff>
            do {  q = rson[q];  } while (rson[q] != NIL);
     2db:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2de:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
     2e5:	89 45 fc             	mov    %eax,-0x4(%ebp)
     2e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2eb:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
     2f2:	3d 00 10 00 00       	cmp    $0x1000,%eax
     2f7:	75 e2                	jne    2db <DeleteNode+0x83>
            rson[dad[q]] = lson[q];  dad[lson[q]] = dad[q];
     2f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2fc:	8b 04 85 80 70 00 00 	mov    0x7080(,%eax,4),%eax
     303:	8b 55 fc             	mov    -0x4(%ebp),%edx
     306:	8b 14 95 20 30 00 00 	mov    0x3020(,%edx,4),%edx
     30d:	89 14 85 a0 b0 00 00 	mov    %edx,0xb0a0(,%eax,4)
     314:	8b 45 fc             	mov    -0x4(%ebp),%eax
     317:	8b 04 85 20 30 00 00 	mov    0x3020(,%eax,4),%eax
     31e:	8b 55 fc             	mov    -0x4(%ebp),%edx
     321:	8b 14 95 80 70 00 00 	mov    0x7080(,%edx,4),%edx
     328:	89 14 85 80 70 00 00 	mov    %edx,0x7080(,%eax,4)
            lson[q] = lson[p];  dad[lson[p]] = q;
     32f:	8b 45 08             	mov    0x8(%ebp),%eax
     332:	8b 14 85 20 30 00 00 	mov    0x3020(,%eax,4),%edx
     339:	8b 45 fc             	mov    -0x4(%ebp),%eax
     33c:	89 14 85 20 30 00 00 	mov    %edx,0x3020(,%eax,4)
     343:	8b 45 08             	mov    0x8(%ebp),%eax
     346:	8b 04 85 20 30 00 00 	mov    0x3020(,%eax,4),%eax
     34d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     350:	89 14 85 80 70 00 00 	mov    %edx,0x7080(,%eax,4)
        }
        rson[q] = rson[p];  dad[rson[p]] = q;
     357:	8b 45 08             	mov    0x8(%ebp),%eax
     35a:	8b 14 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%edx
     361:	8b 45 fc             	mov    -0x4(%ebp),%eax
     364:	89 14 85 a0 b0 00 00 	mov    %edx,0xb0a0(,%eax,4)
     36b:	8b 45 08             	mov    0x8(%ebp),%eax
     36e:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
     375:	8b 55 fc             	mov    -0x4(%ebp),%edx
     378:	89 14 85 80 70 00 00 	mov    %edx,0x7080(,%eax,4)
    }
    dad[q] = dad[p];
     37f:	8b 45 08             	mov    0x8(%ebp),%eax
     382:	8b 14 85 80 70 00 00 	mov    0x7080(,%eax,4),%edx
     389:	8b 45 fc             	mov    -0x4(%ebp),%eax
     38c:	89 14 85 80 70 00 00 	mov    %edx,0x7080(,%eax,4)
    if (rson[dad[p]] == p) rson[dad[p]] = q;  else lson[dad[p]] = q;
     393:	8b 45 08             	mov    0x8(%ebp),%eax
     396:	8b 04 85 80 70 00 00 	mov    0x7080(,%eax,4),%eax
     39d:	8b 04 85 a0 b0 00 00 	mov    0xb0a0(,%eax,4),%eax
     3a4:	39 45 08             	cmp    %eax,0x8(%ebp)
     3a7:	75 16                	jne    3bf <DeleteNode+0x167>
     3a9:	8b 45 08             	mov    0x8(%ebp),%eax
     3ac:	8b 04 85 80 70 00 00 	mov    0x7080(,%eax,4),%eax
     3b3:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3b6:	89 14 85 a0 b0 00 00 	mov    %edx,0xb0a0(,%eax,4)
     3bd:	eb 14                	jmp    3d3 <DeleteNode+0x17b>
     3bf:	8b 45 08             	mov    0x8(%ebp),%eax
     3c2:	8b 04 85 80 70 00 00 	mov    0x7080(,%eax,4),%eax
     3c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3cc:	89 14 85 20 30 00 00 	mov    %edx,0x3020(,%eax,4)
    dad[p] = NIL;
     3d3:	8b 45 08             	mov    0x8(%ebp),%eax
     3d6:	c7 04 85 80 70 00 00 	movl   $0x1000,0x7080(,%eax,4)
     3dd:	00 10 00 00 
     3e1:	eb 01                	jmp    3e4 <DeleteNode+0x18c>
    if (dad[p] == NIL) return;  /* not in tree */
     3e3:	90                   	nop
}
     3e4:	c9                   	leave  
     3e5:	c3                   	ret    

000003e6 <Encode>:

void Encode(void)
{
     3e6:	f3 0f 1e fb          	endbr32 
     3ea:	55                   	push   %ebp
     3eb:	89 e5                	mov    %esp,%ebp
     3ed:	83 ec 48             	sub    $0x48,%esp
    int  i, len, r, s, last_match_length, code_buf_ptr;
    unsigned char  code_buf[17], mask, c;
    
    InitTree();  		/* initialize trees */
     3f0:	e8 0b fc ff ff       	call   0 <InitTree>
    code_buf[0] = 0;    /* code_buf[1..16] saves eight units of code, and
     3f5:	c6 45 c7 00          	movb   $0x0,-0x39(%ebp)
        code_buf[0] works as eight flags, "1" representing that the unit
        is an unencoded letter (1 byte), "0" a position-and-length pair
        (2 bytes).  Thus, eight units require at most 16 bytes of code. */
    code_buf_ptr = mask = 1;
     3f9:	c6 45 e3 01          	movb   $0x1,-0x1d(%ebp)
     3fd:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    s = 0;  r = N - F;
     404:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
     40b:	c7 45 ec ee 0f 00 00 	movl   $0xfee,-0x14(%ebp)
    for (i = s; i < r; i++) text_buf[i] = 0;  /* Clear the buffer with
     412:	8b 45 e8             	mov    -0x18(%ebp),%eax
     415:	89 45 f4             	mov    %eax,-0xc(%ebp)
     418:	eb 0f                	jmp    429 <Encode+0x43>
     41a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     41d:	05 00 20 00 00       	add    $0x2000,%eax
     422:	c6 00 00             	movb   $0x0,(%eax)
     425:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     429:	8b 45 f4             	mov    -0xc(%ebp),%eax
     42c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     42f:	7c e9                	jl     41a <Encode+0x34>
        any character that will appear often. */


    for(int iter = 0; file_masuk[iter] != '\0'; iter++){
     431:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
     438:	e9 9d 02 00 00       	jmp    6da <Encode+0x2f4>
        for (len = 0; len < F && (read((file_masuk[iter]), &c, 1) != 0); len++)
     43d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     444:	eb 16                	jmp    45c <Encode+0x76>
                text_buf[r + len] = c;  
     446:	8b 55 ec             	mov    -0x14(%ebp),%edx
     449:	8b 45 f0             	mov    -0x10(%ebp),%eax
     44c:	01 c2                	add    %eax,%edx
     44e:	0f b6 45 c6          	movzbl -0x3a(%ebp),%eax
     452:	88 82 00 20 00 00    	mov    %al,0x2000(%edx)
        for (len = 0; len < F && (read((file_masuk[iter]), &c, 1) != 0); len++)
     458:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     45c:	83 7d f0 11          	cmpl   $0x11,-0x10(%ebp)
     460:	7f 20                	jg     482 <Encode+0x9c>
     462:	8b 45 dc             	mov    -0x24(%ebp),%eax
     465:	8b 04 85 40 70 00 00 	mov    0x7040(,%eax,4),%eax
     46c:	83 ec 04             	sub    $0x4,%esp
     46f:	6a 01                	push   $0x1
     471:	8d 55 c6             	lea    -0x3a(%ebp),%edx
     474:	52                   	push   %edx
     475:	50                   	push   %eax
     476:	e8 d5 09 00 00       	call   e50 <read>
     47b:	83 c4 10             	add    $0x10,%esp
     47e:	85 c0                	test   %eax,%eax
     480:	75 c4                	jne    446 <Encode+0x60>
                /* Read F bytes into the last F bytes of the buffer */
            
            
            if ((textsize = len) == 0) return;  /* text of size zero */
     482:	8b 45 f0             	mov    -0x10(%ebp),%eax
     485:	a3 80 1f 00 00       	mov    %eax,0x1f80
     48a:	a1 80 1f 00 00       	mov    0x1f80,%eax
     48f:	85 c0                	test   %eax,%eax
     491:	0f 84 9e 02 00 00    	je     735 <Encode+0x34f>
            for (i = 1; i <= F; i++) InsertNode(r - i);  /* Insert the F strings,
     497:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     49e:	eb 16                	jmp    4b6 <Encode+0xd0>
     4a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4a3:	2b 45 f4             	sub    -0xc(%ebp),%eax
     4a6:	83 ec 0c             	sub    $0xc,%esp
     4a9:	50                   	push   %eax
     4aa:	e8 a7 fb ff ff       	call   56 <InsertNode>
     4af:	83 c4 10             	add    $0x10,%esp
     4b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     4b6:	83 7d f4 12          	cmpl   $0x12,-0xc(%ebp)
     4ba:	7e e4                	jle    4a0 <Encode+0xba>
                each of which begins with one or more 'space' characters.  Note
                the order in which these strings are inserted.  This way,
                degenerate trees will be less likely to occur. */
            InsertNode(r);  /* Finally, insert the whole string just read.  The
     4bc:	83 ec 0c             	sub    $0xc,%esp
     4bf:	ff 75 ec             	pushl  -0x14(%ebp)
     4c2:	e8 8f fb ff ff       	call   56 <InsertNode>
     4c7:	83 c4 10             	add    $0x10,%esp
                global variables match_length and match_position are set. */

            do {
                if (match_length > len) match_length = len;  
     4ca:	a1 ac f4 00 00       	mov    0xf4ac,%eax
     4cf:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     4d2:	7d 08                	jge    4dc <Encode+0xf6>
     4d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4d7:	a3 ac f4 00 00       	mov    %eax,0xf4ac
                if (match_length <= THRESHOLD) {
     4dc:	a1 ac f4 00 00       	mov    0xf4ac,%eax
     4e1:	83 f8 02             	cmp    $0x2,%eax
     4e4:	7f 2f                	jg     515 <Encode+0x12f>
                    match_length = 1;     /* Not long enough match.  Send one byte. */
     4e6:	c7 05 ac f4 00 00 01 	movl   $0x1,0xf4ac
     4ed:	00 00 00 
                    code_buf[0] |= mask;  /* 'send one byte' flag */
     4f0:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
     4f4:	0a 45 e3             	or     -0x1d(%ebp),%al
     4f7:	88 45 c7             	mov    %al,-0x39(%ebp)
                    code_buf[code_buf_ptr++] = text_buf[r];  /* Send uncoded. */
     4fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4fd:	8d 50 01             	lea    0x1(%eax),%edx
     500:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     503:	8b 55 ec             	mov    -0x14(%ebp),%edx
     506:	81 c2 00 20 00 00    	add    $0x2000,%edx
     50c:	0f b6 12             	movzbl (%edx),%edx
     50f:	88 54 05 c7          	mov    %dl,-0x39(%ebp,%eax,1)
     513:	eb 3d                	jmp    552 <Encode+0x16c>
                } else {
                    code_buf[code_buf_ptr++] = (unsigned char) match_position;
     515:	8b 0d a8 f4 00 00    	mov    0xf4a8,%ecx
     51b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     51e:	8d 50 01             	lea    0x1(%eax),%edx
     521:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     524:	89 ca                	mov    %ecx,%edx
     526:	88 54 05 c7          	mov    %dl,-0x39(%ebp,%eax,1)
                    code_buf[code_buf_ptr++] = (unsigned char)
                        (((match_position >> 4) & 0xf0)
     52a:	a1 a8 f4 00 00       	mov    0xf4a8,%eax
     52f:	c1 f8 04             	sar    $0x4,%eax
     532:	83 e0 f0             	and    $0xfffffff0,%eax
     535:	89 c2                	mov    %eax,%edx
                     | (match_length - (THRESHOLD + 1)));  /* Send position and
     537:	a1 ac f4 00 00       	mov    0xf4ac,%eax
     53c:	83 e8 03             	sub    $0x3,%eax
     53f:	89 d1                	mov    %edx,%ecx
     541:	09 c1                	or     %eax,%ecx
                    code_buf[code_buf_ptr++] = (unsigned char)
     543:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     546:	8d 50 01             	lea    0x1(%eax),%edx
     549:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     54c:	89 ca                	mov    %ecx,%edx
     54e:	88 54 05 c7          	mov    %dl,-0x39(%ebp,%eax,1)
                            length pair. Note match_length > THRESHOLD. */
                }
                if ((mask <<= 1) == 0) {  /* Shift mask left one bit. */
     552:	d0 65 e3             	shlb   -0x1d(%ebp)
     555:	80 7d e3 00          	cmpb   $0x0,-0x1d(%ebp)
     559:	75 50                	jne    5ab <Encode+0x1c5>
                    for (i = 0; i < code_buf_ptr; i++)  /* Send at most 8 units of */
     55b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     562:	eb 20                	jmp    584 <Encode+0x19e>
                        write(outfile, &code_buf[i], 1);
     564:	8d 55 c7             	lea    -0x39(%ebp),%edx
     567:	8b 45 f4             	mov    -0xc(%ebp),%eax
     56a:	01 c2                	add    %eax,%edx
     56c:	a1 24 70 00 00       	mov    0x7024,%eax
     571:	83 ec 04             	sub    $0x4,%esp
     574:	6a 01                	push   $0x1
     576:	52                   	push   %edx
     577:	50                   	push   %eax
     578:	e8 db 08 00 00       	call   e58 <write>
     57d:	83 c4 10             	add    $0x10,%esp
                    for (i = 0; i < code_buf_ptr; i++)  /* Send at most 8 units of */
     580:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     584:	8b 45 f4             	mov    -0xc(%ebp),%eax
     587:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
     58a:	7c d8                	jl     564 <Encode+0x17e>
                        /*putc(code_buf[i], outfile);*/    /* code together */
                    codesize += code_buf_ptr;
     58c:	8b 15 84 1f 00 00    	mov    0x1f84,%edx
     592:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     595:	01 d0                	add    %edx,%eax
     597:	a3 84 1f 00 00       	mov    %eax,0x1f84
                    code_buf[0] = 0;  code_buf_ptr = mask = 1;
     59c:	c6 45 c7 00          	movb   $0x0,-0x39(%ebp)
     5a0:	c6 45 e3 01          	movb   $0x1,-0x1d(%ebp)
     5a4:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
                }
                last_match_length = match_length;
     5ab:	a1 ac f4 00 00       	mov    0xf4ac,%eax
     5b0:	89 45 d8             	mov    %eax,-0x28(%ebp)
                for (i = 0; i < last_match_length &&
     5b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     5ba:	eb 64                	jmp    620 <Encode+0x23a>
                        (read((file_masuk[iter]), &c, 1) != 0) ; i++) {
                    DeleteNode(s);        /* Delete old strings and */
     5bc:	83 ec 0c             	sub    $0xc,%esp
     5bf:	ff 75 e8             	pushl  -0x18(%ebp)
     5c2:	e8 91 fc ff ff       	call   258 <DeleteNode>
     5c7:	83 c4 10             	add    $0x10,%esp
                    text_buf[s] = c;      /* read new bytes */
     5ca:	0f b6 45 c6          	movzbl -0x3a(%ebp),%eax
     5ce:	8b 55 e8             	mov    -0x18(%ebp),%edx
     5d1:	81 c2 00 20 00 00    	add    $0x2000,%edx
     5d7:	88 02                	mov    %al,(%edx)
                    if (s < F - 1) text_buf[s + N] = c;  /* If the position is
     5d9:	83 7d e8 10          	cmpl   $0x10,-0x18(%ebp)
     5dd:	7f 13                	jg     5f2 <Encode+0x20c>
     5df:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5e2:	8d 90 00 10 00 00    	lea    0x1000(%eax),%edx
     5e8:	0f b6 45 c6          	movzbl -0x3a(%ebp),%eax
     5ec:	88 82 00 20 00 00    	mov    %al,0x2000(%edx)
                        near the end of buffer, extend the buffer to make
                        string comparison easier. */
                    s = (s + 1) & (N - 1);  r = (r + 1) & (N - 1);
     5f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5f5:	83 c0 01             	add    $0x1,%eax
     5f8:	25 ff 0f 00 00       	and    $0xfff,%eax
     5fd:	89 45 e8             	mov    %eax,-0x18(%ebp)
     600:	8b 45 ec             	mov    -0x14(%ebp),%eax
     603:	83 c0 01             	add    $0x1,%eax
     606:	25 ff 0f 00 00       	and    $0xfff,%eax
     60b:	89 45 ec             	mov    %eax,-0x14(%ebp)
                        /* Since this is a ring buffer, increment the position
                           modulo N. */
                    InsertNode(r);    /* Register the string in text_buf[r..r+F-1] */
     60e:	83 ec 0c             	sub    $0xc,%esp
     611:	ff 75 ec             	pushl  -0x14(%ebp)
     614:	e8 3d fa ff ff       	call   56 <InsertNode>
     619:	83 c4 10             	add    $0x10,%esp
                        (read((file_masuk[iter]), &c, 1) != 0) ; i++) {
     61c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
                for (i = 0; i < last_match_length &&
     620:	8b 45 f4             	mov    -0xc(%ebp),%eax
     623:	3b 45 d8             	cmp    -0x28(%ebp),%eax
     626:	7d 24                	jge    64c <Encode+0x266>
                        (read((file_masuk[iter]), &c, 1) != 0) ; i++) {
     628:	8b 45 dc             	mov    -0x24(%ebp),%eax
     62b:	8b 04 85 40 70 00 00 	mov    0x7040(,%eax,4),%eax
     632:	83 ec 04             	sub    $0x4,%esp
     635:	6a 01                	push   $0x1
     637:	8d 55 c6             	lea    -0x3a(%ebp),%edx
     63a:	52                   	push   %edx
     63b:	50                   	push   %eax
     63c:	e8 0f 08 00 00       	call   e50 <read>
     641:	83 c4 10             	add    $0x10,%esp
                for (i = 0; i < last_match_length &&
     644:	85 c0                	test   %eax,%eax
     646:	0f 85 70 ff ff ff    	jne    5bc <Encode+0x1d6>
                }
                if ((textsize += i) > printcount) {
     64c:	8b 15 80 1f 00 00    	mov    0x1f80,%edx
     652:	8b 45 f4             	mov    -0xc(%ebp),%eax
     655:	01 d0                	add    %edx,%eax
     657:	a3 80 1f 00 00       	mov    %eax,0x1f80
     65c:	8b 15 80 1f 00 00    	mov    0x1f80,%edx
     662:	a1 88 1f 00 00       	mov    0x1f88,%eax
     667:	39 c2                	cmp    %eax,%edx
     669:	76 53                	jbe    6be <Encode+0x2d8>
                    printcount += 1024;
     66b:	a1 88 1f 00 00       	mov    0x1f88,%eax
     670:	05 00 04 00 00       	add    $0x400,%eax
     675:	a3 88 1f 00 00       	mov    %eax,0x1f88
                        /* Reports progress each time the textsize exceeds
                           multiples of 1024. */
                }
                while (i++ < last_match_length) {    /* After the end of text, */
     67a:	eb 42                	jmp    6be <Encode+0x2d8>
                    DeleteNode(s);                    /* no need to read, but */
     67c:	83 ec 0c             	sub    $0xc,%esp
     67f:	ff 75 e8             	pushl  -0x18(%ebp)
     682:	e8 d1 fb ff ff       	call   258 <DeleteNode>
     687:	83 c4 10             	add    $0x10,%esp
                    s = (s + 1) & (N - 1);  r = (r + 1) & (N - 1);
     68a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     68d:	83 c0 01             	add    $0x1,%eax
     690:	25 ff 0f 00 00       	and    $0xfff,%eax
     695:	89 45 e8             	mov    %eax,-0x18(%ebp)
     698:	8b 45 ec             	mov    -0x14(%ebp),%eax
     69b:	83 c0 01             	add    $0x1,%eax
     69e:	25 ff 0f 00 00       	and    $0xfff,%eax
     6a3:	89 45 ec             	mov    %eax,-0x14(%ebp)
                    if (--len) InsertNode(r);        /* buffer may not be empty. */
     6a6:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
     6aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6ae:	74 0e                	je     6be <Encode+0x2d8>
     6b0:	83 ec 0c             	sub    $0xc,%esp
     6b3:	ff 75 ec             	pushl  -0x14(%ebp)
     6b6:	e8 9b f9 ff ff       	call   56 <InsertNode>
     6bb:	83 c4 10             	add    $0x10,%esp
                while (i++ < last_match_length) {    /* After the end of text, */
     6be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6c1:	8d 50 01             	lea    0x1(%eax),%edx
     6c4:	89 55 f4             	mov    %edx,-0xc(%ebp)
     6c7:	39 45 d8             	cmp    %eax,-0x28(%ebp)
     6ca:	7f b0                	jg     67c <Encode+0x296>
                }
            } while (len > 0);    /* until length of string to be processed is zero */
     6cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     6d0:	0f 8f f4 fd ff ff    	jg     4ca <Encode+0xe4>
    for(int iter = 0; file_masuk[iter] != '\0'; iter++){
     6d6:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
     6da:	8b 45 dc             	mov    -0x24(%ebp),%eax
     6dd:	8b 04 85 40 70 00 00 	mov    0x7040(,%eax,4),%eax
     6e4:	85 c0                	test   %eax,%eax
     6e6:	0f 85 51 fd ff ff    	jne    43d <Encode+0x57>
    }

    if (code_buf_ptr > 1) {        /* Send remaining code. */
     6ec:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
     6f0:	7e 44                	jle    736 <Encode+0x350>
        for (i = 0; i < code_buf_ptr; i++) write(outfile, &code_buf[i], 1);
     6f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     6f9:	eb 20                	jmp    71b <Encode+0x335>
     6fb:	8d 55 c7             	lea    -0x39(%ebp),%edx
     6fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     701:	01 c2                	add    %eax,%edx
     703:	a1 24 70 00 00       	mov    0x7024,%eax
     708:	83 ec 04             	sub    $0x4,%esp
     70b:	6a 01                	push   $0x1
     70d:	52                   	push   %edx
     70e:	50                   	push   %eax
     70f:	e8 44 07 00 00       	call   e58 <write>
     714:	83 c4 10             	add    $0x10,%esp
     717:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     71b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     71e:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
     721:	7c d8                	jl     6fb <Encode+0x315>
        codesize += code_buf_ptr;
     723:	8b 15 84 1f 00 00    	mov    0x1f84,%edx
     729:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     72c:	01 d0                	add    %edx,%eax
     72e:	a3 84 1f 00 00       	mov    %eax,0x1f84
     733:	eb 01                	jmp    736 <Encode+0x350>
            if ((textsize = len) == 0) return;  /* text of size zero */
     735:	90                   	nop
    }
}
     736:	c9                   	leave  
     737:	c3                   	ret    

00000738 <main>:

int main(int argc, char *argv[]){
     738:	f3 0f 1e fb          	endbr32 
     73c:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     740:	83 e4 f0             	and    $0xfffffff0,%esp
     743:	ff 71 fc             	pushl  -0x4(%ecx)
     746:	55                   	push   %ebp
     747:	89 e5                	mov    %esp,%ebp
     749:	53                   	push   %ebx
     74a:	51                   	push   %ecx
     74b:	83 ec 10             	sub    $0x10,%esp
     74e:	89 cb                	mov    %ecx,%ebx
    if (strcmp(argv[1], "man") == 0){
     750:	8b 43 04             	mov    0x4(%ebx),%eax
     753:	83 c0 04             	add    $0x4,%eax
     756:	8b 00                	mov    (%eax),%eax
     758:	83 ec 08             	sub    $0x8,%esp
     75b:	68 20 19 00 00       	push   $0x1920
     760:	50                   	push   %eax
     761:	e8 66 03 00 00       	call   acc <strcmp>
     766:	83 c4 10             	add    $0x10,%esp
     769:	85 c0                	test   %eax,%eax
     76b:	75 5f                	jne    7cc <main+0x94>
        printf(2, "Penggunaan zip:\n\n");
     76d:	83 ec 08             	sub    $0x8,%esp
     770:	68 24 19 00 00       	push   $0x1924
     775:	6a 02                	push   $0x2
     777:	e8 88 08 00 00       	call   1004 <printf>
     77c:	83 c4 10             	add    $0x10,%esp
        printf(2, "1. zip nama_file.zip nama_file.txt\n");
     77f:	83 ec 08             	sub    $0x8,%esp
     782:	68 38 19 00 00       	push   $0x1938
     787:	6a 02                	push   $0x2
     789:	e8 76 08 00 00       	call   1004 <printf>
     78e:	83 c4 10             	add    $0x10,%esp
        printf(2, "2. zip -m nama_file.zip nama_file.txt\n");
     791:	83 ec 08             	sub    $0x8,%esp
     794:	68 5c 19 00 00       	push   $0x195c
     799:	6a 02                	push   $0x2
     79b:	e8 64 08 00 00       	call   1004 <printf>
     7a0:	83 c4 10             	add    $0x10,%esp
        printf(2, "3. zip nama_file.zip nama_file1.txt nama_file2.txt\n");
     7a3:	83 ec 08             	sub    $0x8,%esp
     7a6:	68 84 19 00 00       	push   $0x1984
     7ab:	6a 02                	push   $0x2
     7ad:	e8 52 08 00 00       	call   1004 <printf>
     7b2:	83 c4 10             	add    $0x10,%esp
        printf(2, "4. zip -r directory\n");
     7b5:	83 ec 08             	sub    $0x8,%esp
     7b8:	68 b8 19 00 00       	push   $0x19b8
     7bd:	6a 02                	push   $0x2
     7bf:	e8 40 08 00 00       	call   1004 <printf>
     7c4:	83 c4 10             	add    $0x10,%esp
        exit();
     7c7:	e8 6c 06 00 00       	call   e38 <exit>
    }
    
    // argumen -m
    if(strcmp(argv[1], "-m") == 0&& argc == 4){
     7cc:	8b 43 04             	mov    0x4(%ebx),%eax
     7cf:	83 c0 04             	add    $0x4,%eax
     7d2:	8b 00                	mov    (%eax),%eax
     7d4:	83 ec 08             	sub    $0x8,%esp
     7d7:	68 cd 19 00 00       	push   $0x19cd
     7dc:	50                   	push   %eax
     7dd:	e8 ea 02 00 00       	call   acc <strcmp>
     7e2:	83 c4 10             	add    $0x10,%esp
     7e5:	85 c0                	test   %eax,%eax
     7e7:	0f 85 f9 00 00 00    	jne    8e6 <main+0x1ae>
     7ed:	83 3b 04             	cmpl   $0x4,(%ebx)
     7f0:	0f 85 f0 00 00 00    	jne    8e6 <main+0x1ae>
        // encode file input dan output
        if ((file_masuk[0] = open(argv[3], O_RDONLY)) == -1){
     7f6:	8b 43 04             	mov    0x4(%ebx),%eax
     7f9:	83 c0 0c             	add    $0xc,%eax
     7fc:	8b 00                	mov    (%eax),%eax
     7fe:	83 ec 08             	sub    $0x8,%esp
     801:	6a 00                	push   $0x0
     803:	50                   	push   %eax
     804:	e8 6f 06 00 00       	call   e78 <open>
     809:	83 c4 10             	add    $0x10,%esp
     80c:	a3 40 70 00 00       	mov    %eax,0x7040
     811:	a1 40 70 00 00       	mov    0x7040,%eax
     816:	83 f8 ff             	cmp    $0xffffffff,%eax
     819:	75 31                	jne    84c <main+0x114>
    	    printf(2, "zip -m: Input file salah (%s)!\n", argv[3]);
     81b:	8b 43 04             	mov    0x4(%ebx),%eax
     81e:	83 c0 0c             	add    $0xc,%eax
     821:	8b 00                	mov    (%eax),%eax
     823:	83 ec 04             	sub    $0x4,%esp
     826:	50                   	push   %eax
     827:	68 d0 19 00 00       	push   $0x19d0
     82c:	6a 02                	push   $0x2
     82e:	e8 d1 07 00 00       	call   1004 <printf>
     833:	83 c4 10             	add    $0x10,%esp
            close(file_masuk[0]);
     836:	a1 40 70 00 00       	mov    0x7040,%eax
     83b:	83 ec 0c             	sub    $0xc,%esp
     83e:	50                   	push   %eax
     83f:	e8 1c 06 00 00       	call   e60 <close>
     844:	83 c4 10             	add    $0x10,%esp
            exit();
     847:	e8 ec 05 00 00       	call   e38 <exit>
        }
        if ((outfile = open(argv[2], O_WRONLY | O_CREATE)) == -1){
     84c:	8b 43 04             	mov    0x4(%ebx),%eax
     84f:	83 c0 08             	add    $0x8,%eax
     852:	8b 00                	mov    (%eax),%eax
     854:	83 ec 08             	sub    $0x8,%esp
     857:	68 01 02 00 00       	push   $0x201
     85c:	50                   	push   %eax
     85d:	e8 16 06 00 00       	call   e78 <open>
     862:	83 c4 10             	add    $0x10,%esp
     865:	a3 24 70 00 00       	mov    %eax,0x7024
     86a:	a1 24 70 00 00       	mov    0x7024,%eax
     86f:	83 f8 ff             	cmp    $0xffffffff,%eax
     872:	75 31                	jne    8a5 <main+0x16d>
            printf(2, "zip -m: Output file salah (%s)!\n", argv[2]);
     874:	8b 43 04             	mov    0x4(%ebx),%eax
     877:	83 c0 08             	add    $0x8,%eax
     87a:	8b 00                	mov    (%eax),%eax
     87c:	83 ec 04             	sub    $0x4,%esp
     87f:	50                   	push   %eax
     880:	68 f0 19 00 00       	push   $0x19f0
     885:	6a 02                	push   $0x2
     887:	e8 78 07 00 00       	call   1004 <printf>
     88c:	83 c4 10             	add    $0x10,%esp
            close(outfile);
     88f:	a1 24 70 00 00       	mov    0x7024,%eax
     894:	83 ec 0c             	sub    $0xc,%esp
     897:	50                   	push   %eax
     898:	e8 c3 05 00 00       	call   e60 <close>
     89d:	83 c4 10             	add    $0x10,%esp
            exit();
     8a0:	e8 93 05 00 00       	call   e38 <exit>
        }

        Encode();
     8a5:	e8 3c fb ff ff       	call   3e6 <Encode>

        // hapus file input
        if(unlink(argv[3]) < 0){
     8aa:	8b 43 04             	mov    0x4(%ebx),%eax
     8ad:	83 c0 0c             	add    $0xc,%eax
     8b0:	8b 00                	mov    (%eax),%eax
     8b2:	83 ec 0c             	sub    $0xc,%esp
     8b5:	50                   	push   %eax
     8b6:	e8 cd 05 00 00       	call   e88 <unlink>
     8bb:	83 c4 10             	add    $0x10,%esp
     8be:	85 c0                	test   %eax,%eax
     8c0:	0f 89 9d 01 00 00    	jns    a63 <main+0x32b>
            printf(2, "ERROR: File tidak bisa dihapus!\n", argv[3]);
     8c6:	8b 43 04             	mov    0x4(%ebx),%eax
     8c9:	83 c0 0c             	add    $0xc,%eax
     8cc:	8b 00                	mov    (%eax),%eax
     8ce:	83 ec 04             	sub    $0x4,%esp
     8d1:	50                   	push   %eax
     8d2:	68 14 1a 00 00       	push   $0x1a14
     8d7:	6a 02                	push   $0x2
     8d9:	e8 26 07 00 00       	call   1004 <printf>
     8de:	83 c4 10             	add    $0x10,%esp
        if(unlink(argv[3]) < 0){
     8e1:	e9 7d 01 00 00       	jmp    a63 <main+0x32b>
        }
    }else if(strcmp(argv[1], "-r") == 0 && argc == 3){
     8e6:	8b 43 04             	mov    0x4(%ebx),%eax
     8e9:	83 c0 04             	add    $0x4,%eax
     8ec:	8b 00                	mov    (%eax),%eax
     8ee:	83 ec 08             	sub    $0x8,%esp
     8f1:	68 35 1a 00 00       	push   $0x1a35
     8f6:	50                   	push   %eax
     8f7:	e8 d0 01 00 00       	call   acc <strcmp>
     8fc:	83 c4 10             	add    $0x10,%esp
     8ff:	85 c0                	test   %eax,%eax
     901:	75 2e                	jne    931 <main+0x1f9>
     903:	83 3b 03             	cmpl   $0x3,(%ebx)
     906:	75 29                	jne    931 <main+0x1f9>
        printf(1, "masuk directory\n");
     908:	83 ec 08             	sub    $0x8,%esp
     90b:	68 38 1a 00 00       	push   $0x1a38
     910:	6a 01                	push   $0x1
     912:	e8 ed 06 00 00       	call   1004 <printf>
     917:	83 c4 10             	add    $0x10,%esp
        printf(1, "ERROR BELUM KEPIKIRAN!!!!!\n");
     91a:	83 ec 08             	sub    $0x8,%esp
     91d:	68 49 1a 00 00       	push   $0x1a49
     922:	6a 01                	push   $0x1
     924:	e8 db 06 00 00       	call   1004 <printf>
     929:	83 c4 10             	add    $0x10,%esp
     92c:	e9 32 01 00 00       	jmp    a63 <main+0x32b>
    }else{
        if(argc > 1){
     931:	83 3b 01             	cmpl   $0x1,(%ebx)
     934:	0f 8e 24 01 00 00    	jle    a5e <main+0x326>
            for(int i = 0; i < argc - 2; i++){
     93a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     941:	eb 75                	jmp    9b8 <main+0x280>
                if ((file_masuk[i] = open(argv[i+2], O_RDONLY)) == -1){
     943:	8b 45 f4             	mov    -0xc(%ebp),%eax
     946:	83 c0 02             	add    $0x2,%eax
     949:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     950:	8b 43 04             	mov    0x4(%ebx),%eax
     953:	01 d0                	add    %edx,%eax
     955:	8b 00                	mov    (%eax),%eax
     957:	83 ec 08             	sub    $0x8,%esp
     95a:	6a 00                	push   $0x0
     95c:	50                   	push   %eax
     95d:	e8 16 05 00 00       	call   e78 <open>
     962:	83 c4 10             	add    $0x10,%esp
     965:	8b 55 f4             	mov    -0xc(%ebp),%edx
     968:	89 04 95 40 70 00 00 	mov    %eax,0x7040(,%edx,4)
     96f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     972:	8b 04 85 40 70 00 00 	mov    0x7040(,%eax,4),%eax
     979:	83 f8 ff             	cmp    $0xffffffff,%eax
     97c:	75 36                	jne    9b4 <main+0x27c>
                    printf(2, "zip: Input file salah (%s)!\n", argv[1+2]);
     97e:	8b 43 04             	mov    0x4(%ebx),%eax
     981:	83 c0 0c             	add    $0xc,%eax
     984:	8b 00                	mov    (%eax),%eax
     986:	83 ec 04             	sub    $0x4,%esp
     989:	50                   	push   %eax
     98a:	68 65 1a 00 00       	push   $0x1a65
     98f:	6a 02                	push   $0x2
     991:	e8 6e 06 00 00       	call   1004 <printf>
     996:	83 c4 10             	add    $0x10,%esp
                    close(file_masuk[i]);
     999:	8b 45 f4             	mov    -0xc(%ebp),%eax
     99c:	8b 04 85 40 70 00 00 	mov    0x7040(,%eax,4),%eax
     9a3:	83 ec 0c             	sub    $0xc,%esp
     9a6:	50                   	push   %eax
     9a7:	e8 b4 04 00 00       	call   e60 <close>
     9ac:	83 c4 10             	add    $0x10,%esp
                    exit();
     9af:	e8 84 04 00 00       	call   e38 <exit>
            for(int i = 0; i < argc - 2; i++){
     9b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     9b8:	8b 03                	mov    (%ebx),%eax
     9ba:	83 e8 02             	sub    $0x2,%eax
     9bd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     9c0:	7c 81                	jl     943 <main+0x20b>
            }
        }

        if ((outfile = open(argv[1], O_WRONLY | O_CREATE)) == -1){
     9c2:	8b 43 04             	mov    0x4(%ebx),%eax
     9c5:	83 c0 04             	add    $0x4,%eax
     9c8:	8b 00                	mov    (%eax),%eax
     9ca:	83 ec 08             	sub    $0x8,%esp
     9cd:	68 01 02 00 00       	push   $0x201
     9d2:	50                   	push   %eax
     9d3:	e8 a0 04 00 00       	call   e78 <open>
     9d8:	83 c4 10             	add    $0x10,%esp
     9db:	a3 24 70 00 00       	mov    %eax,0x7024
     9e0:	a1 24 70 00 00       	mov    0x7024,%eax
     9e5:	83 f8 ff             	cmp    $0xffffffff,%eax
     9e8:	75 31                	jne    a1b <main+0x2e3>
            printf(2, "zip: Output file salah (%s)!\n", argv[1]);
     9ea:	8b 43 04             	mov    0x4(%ebx),%eax
     9ed:	83 c0 04             	add    $0x4,%eax
     9f0:	8b 00                	mov    (%eax),%eax
     9f2:	83 ec 04             	sub    $0x4,%esp
     9f5:	50                   	push   %eax
     9f6:	68 82 1a 00 00       	push   $0x1a82
     9fb:	6a 02                	push   $0x2
     9fd:	e8 02 06 00 00       	call   1004 <printf>
     a02:	83 c4 10             	add    $0x10,%esp
            close(outfile);
     a05:	a1 24 70 00 00       	mov    0x7024,%eax
     a0a:	83 ec 0c             	sub    $0xc,%esp
     a0d:	50                   	push   %eax
     a0e:	e8 4d 04 00 00       	call   e60 <close>
     a13:	83 c4 10             	add    $0x10,%esp
            exit();
     a16:	e8 1d 04 00 00       	call   e38 <exit>
        }
 
        Encode();
     a1b:	e8 c6 f9 ff ff       	call   3e6 <Encode>

        for(int i = 0; i < argc - 1; i++){
     a20:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a27:	eb 1a                	jmp    a43 <main+0x30b>
            close(file_masuk[i]);
     a29:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a2c:	8b 04 85 40 70 00 00 	mov    0x7040(,%eax,4),%eax
     a33:	83 ec 0c             	sub    $0xc,%esp
     a36:	50                   	push   %eax
     a37:	e8 24 04 00 00       	call   e60 <close>
     a3c:	83 c4 10             	add    $0x10,%esp
        for(int i = 0; i < argc - 1; i++){
     a3f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     a43:	8b 03                	mov    (%ebx),%eax
     a45:	83 e8 01             	sub    $0x1,%eax
     a48:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     a4b:	7c dc                	jl     a29 <main+0x2f1>
        }

        close(outfile);
     a4d:	a1 24 70 00 00       	mov    0x7024,%eax
     a52:	83 ec 0c             	sub    $0xc,%esp
     a55:	50                   	push   %eax
     a56:	e8 05 04 00 00       	call   e60 <close>
     a5b:	83 c4 10             	add    $0x10,%esp
        }
    exit();
     a5e:	e8 d5 03 00 00       	call   e38 <exit>
     a63:	b8 00 00 00 00       	mov    $0x0,%eax
    }
     a68:	8d 65 f8             	lea    -0x8(%ebp),%esp
     a6b:	59                   	pop    %ecx
     a6c:	5b                   	pop    %ebx
     a6d:	5d                   	pop    %ebp
     a6e:	8d 61 fc             	lea    -0x4(%ecx),%esp
     a71:	c3                   	ret    

00000a72 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     a72:	55                   	push   %ebp
     a73:	89 e5                	mov    %esp,%ebp
     a75:	57                   	push   %edi
     a76:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     a77:	8b 4d 08             	mov    0x8(%ebp),%ecx
     a7a:	8b 55 10             	mov    0x10(%ebp),%edx
     a7d:	8b 45 0c             	mov    0xc(%ebp),%eax
     a80:	89 cb                	mov    %ecx,%ebx
     a82:	89 df                	mov    %ebx,%edi
     a84:	89 d1                	mov    %edx,%ecx
     a86:	fc                   	cld    
     a87:	f3 aa                	rep stos %al,%es:(%edi)
     a89:	89 ca                	mov    %ecx,%edx
     a8b:	89 fb                	mov    %edi,%ebx
     a8d:	89 5d 08             	mov    %ebx,0x8(%ebp)
     a90:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     a93:	90                   	nop
     a94:	5b                   	pop    %ebx
     a95:	5f                   	pop    %edi
     a96:	5d                   	pop    %ebp
     a97:	c3                   	ret    

00000a98 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     a98:	f3 0f 1e fb          	endbr32 
     a9c:	55                   	push   %ebp
     a9d:	89 e5                	mov    %esp,%ebp
     a9f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     aa2:	8b 45 08             	mov    0x8(%ebp),%eax
     aa5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     aa8:	90                   	nop
     aa9:	8b 55 0c             	mov    0xc(%ebp),%edx
     aac:	8d 42 01             	lea    0x1(%edx),%eax
     aaf:	89 45 0c             	mov    %eax,0xc(%ebp)
     ab2:	8b 45 08             	mov    0x8(%ebp),%eax
     ab5:	8d 48 01             	lea    0x1(%eax),%ecx
     ab8:	89 4d 08             	mov    %ecx,0x8(%ebp)
     abb:	0f b6 12             	movzbl (%edx),%edx
     abe:	88 10                	mov    %dl,(%eax)
     ac0:	0f b6 00             	movzbl (%eax),%eax
     ac3:	84 c0                	test   %al,%al
     ac5:	75 e2                	jne    aa9 <strcpy+0x11>
    ;
  return os;
     ac7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     aca:	c9                   	leave  
     acb:	c3                   	ret    

00000acc <strcmp>:

int
strcmp(const char *p, const char *q)
{
     acc:	f3 0f 1e fb          	endbr32 
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     ad3:	eb 08                	jmp    add <strcmp+0x11>
    p++, q++;
     ad5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     ad9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     add:	8b 45 08             	mov    0x8(%ebp),%eax
     ae0:	0f b6 00             	movzbl (%eax),%eax
     ae3:	84 c0                	test   %al,%al
     ae5:	74 10                	je     af7 <strcmp+0x2b>
     ae7:	8b 45 08             	mov    0x8(%ebp),%eax
     aea:	0f b6 10             	movzbl (%eax),%edx
     aed:	8b 45 0c             	mov    0xc(%ebp),%eax
     af0:	0f b6 00             	movzbl (%eax),%eax
     af3:	38 c2                	cmp    %al,%dl
     af5:	74 de                	je     ad5 <strcmp+0x9>
  return (uchar)*p - (uchar)*q;
     af7:	8b 45 08             	mov    0x8(%ebp),%eax
     afa:	0f b6 00             	movzbl (%eax),%eax
     afd:	0f b6 d0             	movzbl %al,%edx
     b00:	8b 45 0c             	mov    0xc(%ebp),%eax
     b03:	0f b6 00             	movzbl (%eax),%eax
     b06:	0f b6 c0             	movzbl %al,%eax
     b09:	29 c2                	sub    %eax,%edx
     b0b:	89 d0                	mov    %edx,%eax
}
     b0d:	5d                   	pop    %ebp
     b0e:	c3                   	ret    

00000b0f <strlen>:

uint
strlen(char *s)
{
     b0f:	f3 0f 1e fb          	endbr32 
     b13:	55                   	push   %ebp
     b14:	89 e5                	mov    %esp,%ebp
     b16:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     b19:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     b20:	eb 04                	jmp    b26 <strlen+0x17>
     b22:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     b26:	8b 55 fc             	mov    -0x4(%ebp),%edx
     b29:	8b 45 08             	mov    0x8(%ebp),%eax
     b2c:	01 d0                	add    %edx,%eax
     b2e:	0f b6 00             	movzbl (%eax),%eax
     b31:	84 c0                	test   %al,%al
     b33:	75 ed                	jne    b22 <strlen+0x13>
    ;
  return n;
     b35:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     b38:	c9                   	leave  
     b39:	c3                   	ret    

00000b3a <memset>:

void*
memset(void *dst, int c, uint n)
{
     b3a:	f3 0f 1e fb          	endbr32 
     b3e:	55                   	push   %ebp
     b3f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     b41:	8b 45 10             	mov    0x10(%ebp),%eax
     b44:	50                   	push   %eax
     b45:	ff 75 0c             	pushl  0xc(%ebp)
     b48:	ff 75 08             	pushl  0x8(%ebp)
     b4b:	e8 22 ff ff ff       	call   a72 <stosb>
     b50:	83 c4 0c             	add    $0xc,%esp
  return dst;
     b53:	8b 45 08             	mov    0x8(%ebp),%eax
}
     b56:	c9                   	leave  
     b57:	c3                   	ret    

00000b58 <strchr>:

char*
strchr(const char *s, char c)
{
     b58:	f3 0f 1e fb          	endbr32 
     b5c:	55                   	push   %ebp
     b5d:	89 e5                	mov    %esp,%ebp
     b5f:	83 ec 04             	sub    $0x4,%esp
     b62:	8b 45 0c             	mov    0xc(%ebp),%eax
     b65:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     b68:	eb 14                	jmp    b7e <strchr+0x26>
    if(*s == c)
     b6a:	8b 45 08             	mov    0x8(%ebp),%eax
     b6d:	0f b6 00             	movzbl (%eax),%eax
     b70:	38 45 fc             	cmp    %al,-0x4(%ebp)
     b73:	75 05                	jne    b7a <strchr+0x22>
      return (char*)s;
     b75:	8b 45 08             	mov    0x8(%ebp),%eax
     b78:	eb 13                	jmp    b8d <strchr+0x35>
  for(; *s; s++)
     b7a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     b7e:	8b 45 08             	mov    0x8(%ebp),%eax
     b81:	0f b6 00             	movzbl (%eax),%eax
     b84:	84 c0                	test   %al,%al
     b86:	75 e2                	jne    b6a <strchr+0x12>
  return 0;
     b88:	b8 00 00 00 00       	mov    $0x0,%eax
}
     b8d:	c9                   	leave  
     b8e:	c3                   	ret    

00000b8f <gets>:

char*
gets(char *buf, int max)
{
     b8f:	f3 0f 1e fb          	endbr32 
     b93:	55                   	push   %ebp
     b94:	89 e5                	mov    %esp,%ebp
     b96:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b99:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ba0:	eb 42                	jmp    be4 <gets+0x55>
    cc = read(0, &c, 1);
     ba2:	83 ec 04             	sub    $0x4,%esp
     ba5:	6a 01                	push   $0x1
     ba7:	8d 45 ef             	lea    -0x11(%ebp),%eax
     baa:	50                   	push   %eax
     bab:	6a 00                	push   $0x0
     bad:	e8 9e 02 00 00       	call   e50 <read>
     bb2:	83 c4 10             	add    $0x10,%esp
     bb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     bb8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     bbc:	7e 33                	jle    bf1 <gets+0x62>
      break;
    buf[i++] = c;
     bbe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     bc1:	8d 50 01             	lea    0x1(%eax),%edx
     bc4:	89 55 f4             	mov    %edx,-0xc(%ebp)
     bc7:	89 c2                	mov    %eax,%edx
     bc9:	8b 45 08             	mov    0x8(%ebp),%eax
     bcc:	01 c2                	add    %eax,%edx
     bce:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     bd2:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     bd4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     bd8:	3c 0a                	cmp    $0xa,%al
     bda:	74 16                	je     bf2 <gets+0x63>
     bdc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     be0:	3c 0d                	cmp    $0xd,%al
     be2:	74 0e                	je     bf2 <gets+0x63>
  for(i=0; i+1 < max; ){
     be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     be7:	83 c0 01             	add    $0x1,%eax
     bea:	39 45 0c             	cmp    %eax,0xc(%ebp)
     bed:	7f b3                	jg     ba2 <gets+0x13>
     bef:	eb 01                	jmp    bf2 <gets+0x63>
      break;
     bf1:	90                   	nop
      break;
  }
  buf[i] = '\0';
     bf2:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bf5:	8b 45 08             	mov    0x8(%ebp),%eax
     bf8:	01 d0                	add    %edx,%eax
     bfa:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     bfd:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c00:	c9                   	leave  
     c01:	c3                   	ret    

00000c02 <fgets>:

char*
fgets(char* buf, int size, int fd)
{
     c02:	f3 0f 1e fb          	endbr32 
     c06:	55                   	push   %ebp
     c07:	89 e5                	mov    %esp,%ebp
     c09:	83 ec 18             	sub    $0x18,%esp
  int i;
  char c;

  for(i = 0; i + 1 < size;){
     c0c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c13:	eb 43                	jmp    c58 <fgets+0x56>
    int cc = read(fd, &c, 1);
     c15:	83 ec 04             	sub    $0x4,%esp
     c18:	6a 01                	push   $0x1
     c1a:	8d 45 ef             	lea    -0x11(%ebp),%eax
     c1d:	50                   	push   %eax
     c1e:	ff 75 10             	pushl  0x10(%ebp)
     c21:	e8 2a 02 00 00       	call   e50 <read>
     c26:	83 c4 10             	add    $0x10,%esp
     c29:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     c2c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     c30:	7e 33                	jle    c65 <fgets+0x63>
      break;
    buf[i++] = c;
     c32:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c35:	8d 50 01             	lea    0x1(%eax),%edx
     c38:	89 55 f4             	mov    %edx,-0xc(%ebp)
     c3b:	89 c2                	mov    %eax,%edx
     c3d:	8b 45 08             	mov    0x8(%ebp),%eax
     c40:	01 c2                	add    %eax,%edx
     c42:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     c46:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     c48:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     c4c:	3c 0a                	cmp    $0xa,%al
     c4e:	74 16                	je     c66 <fgets+0x64>
     c50:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     c54:	3c 0d                	cmp    $0xd,%al
     c56:	74 0e                	je     c66 <fgets+0x64>
  for(i = 0; i + 1 < size;){
     c58:	8b 45 f4             	mov    -0xc(%ebp),%eax
     c5b:	83 c0 01             	add    $0x1,%eax
     c5e:	39 45 0c             	cmp    %eax,0xc(%ebp)
     c61:	7f b2                	jg     c15 <fgets+0x13>
     c63:	eb 01                	jmp    c66 <fgets+0x64>
      break;
     c65:	90                   	nop
      break;
  }
  buf[i] = '\0';
     c66:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c69:	8b 45 08             	mov    0x8(%ebp),%eax
     c6c:	01 d0                	add    %edx,%eax
     c6e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     c71:	8b 45 08             	mov    0x8(%ebp),%eax
}
     c74:	c9                   	leave  
     c75:	c3                   	ret    

00000c76 <stat>:

int
stat(char *n, struct stat *st)
{
     c76:	f3 0f 1e fb          	endbr32 
     c7a:	55                   	push   %ebp
     c7b:	89 e5                	mov    %esp,%ebp
     c7d:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c80:	83 ec 08             	sub    $0x8,%esp
     c83:	6a 00                	push   $0x0
     c85:	ff 75 08             	pushl  0x8(%ebp)
     c88:	e8 eb 01 00 00       	call   e78 <open>
     c8d:	83 c4 10             	add    $0x10,%esp
     c90:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     c93:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     c97:	79 07                	jns    ca0 <stat+0x2a>
    return -1;
     c99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c9e:	eb 25                	jmp    cc5 <stat+0x4f>
  r = fstat(fd, st);
     ca0:	83 ec 08             	sub    $0x8,%esp
     ca3:	ff 75 0c             	pushl  0xc(%ebp)
     ca6:	ff 75 f4             	pushl  -0xc(%ebp)
     ca9:	e8 e2 01 00 00       	call   e90 <fstat>
     cae:	83 c4 10             	add    $0x10,%esp
     cb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     cb4:	83 ec 0c             	sub    $0xc,%esp
     cb7:	ff 75 f4             	pushl  -0xc(%ebp)
     cba:	e8 a1 01 00 00       	call   e60 <close>
     cbf:	83 c4 10             	add    $0x10,%esp
  return r;
     cc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     cc5:	c9                   	leave  
     cc6:	c3                   	ret    

00000cc7 <atoi>:

int
atoi(const char *s)
{
     cc7:	f3 0f 1e fb          	endbr32 
     ccb:	55                   	push   %ebp
     ccc:	89 e5                	mov    %esp,%ebp
     cce:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     cd1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     cd8:	eb 04                	jmp    cde <atoi+0x17>
     cda:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     cde:	8b 45 08             	mov    0x8(%ebp),%eax
     ce1:	0f b6 00             	movzbl (%eax),%eax
     ce4:	3c 20                	cmp    $0x20,%al
     ce6:	74 f2                	je     cda <atoi+0x13>
  sign = (*s == '-') ? -1 : 1;
     ce8:	8b 45 08             	mov    0x8(%ebp),%eax
     ceb:	0f b6 00             	movzbl (%eax),%eax
     cee:	3c 2d                	cmp    $0x2d,%al
     cf0:	75 07                	jne    cf9 <atoi+0x32>
     cf2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     cf7:	eb 05                	jmp    cfe <atoi+0x37>
     cf9:	b8 01 00 00 00       	mov    $0x1,%eax
     cfe:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     d01:	8b 45 08             	mov    0x8(%ebp),%eax
     d04:	0f b6 00             	movzbl (%eax),%eax
     d07:	3c 2b                	cmp    $0x2b,%al
     d09:	74 0a                	je     d15 <atoi+0x4e>
     d0b:	8b 45 08             	mov    0x8(%ebp),%eax
     d0e:	0f b6 00             	movzbl (%eax),%eax
     d11:	3c 2d                	cmp    $0x2d,%al
     d13:	75 2b                	jne    d40 <atoi+0x79>
    s++;
     d15:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '9')
     d19:	eb 25                	jmp    d40 <atoi+0x79>
    n = n*10 + *s++ - '0';
     d1b:	8b 55 fc             	mov    -0x4(%ebp),%edx
     d1e:	89 d0                	mov    %edx,%eax
     d20:	c1 e0 02             	shl    $0x2,%eax
     d23:	01 d0                	add    %edx,%eax
     d25:	01 c0                	add    %eax,%eax
     d27:	89 c1                	mov    %eax,%ecx
     d29:	8b 45 08             	mov    0x8(%ebp),%eax
     d2c:	8d 50 01             	lea    0x1(%eax),%edx
     d2f:	89 55 08             	mov    %edx,0x8(%ebp)
     d32:	0f b6 00             	movzbl (%eax),%eax
     d35:	0f be c0             	movsbl %al,%eax
     d38:	01 c8                	add    %ecx,%eax
     d3a:	83 e8 30             	sub    $0x30,%eax
     d3d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     d40:	8b 45 08             	mov    0x8(%ebp),%eax
     d43:	0f b6 00             	movzbl (%eax),%eax
     d46:	3c 2f                	cmp    $0x2f,%al
     d48:	7e 0a                	jle    d54 <atoi+0x8d>
     d4a:	8b 45 08             	mov    0x8(%ebp),%eax
     d4d:	0f b6 00             	movzbl (%eax),%eax
     d50:	3c 39                	cmp    $0x39,%al
     d52:	7e c7                	jle    d1b <atoi+0x54>
  return sign*n;
     d54:	8b 45 f8             	mov    -0x8(%ebp),%eax
     d57:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     d5b:	c9                   	leave  
     d5c:	c3                   	ret    

00000d5d <atoo>:

int
atoo(const char *s)
{
     d5d:	f3 0f 1e fb          	endbr32 
     d61:	55                   	push   %ebp
     d62:	89 e5                	mov    %esp,%ebp
     d64:	83 ec 10             	sub    $0x10,%esp
  int n, sign;

  n = 0;
     d67:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while (*s == ' ') s++;
     d6e:	eb 04                	jmp    d74 <atoo+0x17>
     d70:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     d74:	8b 45 08             	mov    0x8(%ebp),%eax
     d77:	0f b6 00             	movzbl (%eax),%eax
     d7a:	3c 20                	cmp    $0x20,%al
     d7c:	74 f2                	je     d70 <atoo+0x13>
  sign = (*s == '-') ? -1 : 1;
     d7e:	8b 45 08             	mov    0x8(%ebp),%eax
     d81:	0f b6 00             	movzbl (%eax),%eax
     d84:	3c 2d                	cmp    $0x2d,%al
     d86:	75 07                	jne    d8f <atoo+0x32>
     d88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     d8d:	eb 05                	jmp    d94 <atoo+0x37>
     d8f:	b8 01 00 00 00       	mov    $0x1,%eax
     d94:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if (*s == '+'  || *s == '-')
     d97:	8b 45 08             	mov    0x8(%ebp),%eax
     d9a:	0f b6 00             	movzbl (%eax),%eax
     d9d:	3c 2b                	cmp    $0x2b,%al
     d9f:	74 0a                	je     dab <atoo+0x4e>
     da1:	8b 45 08             	mov    0x8(%ebp),%eax
     da4:	0f b6 00             	movzbl (%eax),%eax
     da7:	3c 2d                	cmp    $0x2d,%al
     da9:	75 27                	jne    dd2 <atoo+0x75>
    s++;
     dab:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while('0' <= *s && *s <= '7')
     daf:	eb 21                	jmp    dd2 <atoo+0x75>
    n = n*8 + *s++ - '0';
     db1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     db4:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
     dbb:	8b 45 08             	mov    0x8(%ebp),%eax
     dbe:	8d 50 01             	lea    0x1(%eax),%edx
     dc1:	89 55 08             	mov    %edx,0x8(%ebp)
     dc4:	0f b6 00             	movzbl (%eax),%eax
     dc7:	0f be c0             	movsbl %al,%eax
     dca:	01 c8                	add    %ecx,%eax
     dcc:	83 e8 30             	sub    $0x30,%eax
     dcf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '7')
     dd2:	8b 45 08             	mov    0x8(%ebp),%eax
     dd5:	0f b6 00             	movzbl (%eax),%eax
     dd8:	3c 2f                	cmp    $0x2f,%al
     dda:	7e 0a                	jle    de6 <atoo+0x89>
     ddc:	8b 45 08             	mov    0x8(%ebp),%eax
     ddf:	0f b6 00             	movzbl (%eax),%eax
     de2:	3c 37                	cmp    $0x37,%al
     de4:	7e cb                	jle    db1 <atoo+0x54>
  return sign*n;
     de6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     de9:	0f af 45 fc          	imul   -0x4(%ebp),%eax
}
     ded:	c9                   	leave  
     dee:	c3                   	ret    

00000def <memmove>:


void*
memmove(void *vdst, void *vsrc, int n)
{
     def:	f3 0f 1e fb          	endbr32 
     df3:	55                   	push   %ebp
     df4:	89 e5                	mov    %esp,%ebp
     df6:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
     df9:	8b 45 08             	mov    0x8(%ebp),%eax
     dfc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     dff:	8b 45 0c             	mov    0xc(%ebp),%eax
     e02:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     e05:	eb 17                	jmp    e1e <memmove+0x2f>
    *dst++ = *src++;
     e07:	8b 55 f8             	mov    -0x8(%ebp),%edx
     e0a:	8d 42 01             	lea    0x1(%edx),%eax
     e0d:	89 45 f8             	mov    %eax,-0x8(%ebp)
     e10:	8b 45 fc             	mov    -0x4(%ebp),%eax
     e13:	8d 48 01             	lea    0x1(%eax),%ecx
     e16:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     e19:	0f b6 12             	movzbl (%edx),%edx
     e1c:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     e1e:	8b 45 10             	mov    0x10(%ebp),%eax
     e21:	8d 50 ff             	lea    -0x1(%eax),%edx
     e24:	89 55 10             	mov    %edx,0x10(%ebp)
     e27:	85 c0                	test   %eax,%eax
     e29:	7f dc                	jg     e07 <memmove+0x18>
  return vdst;
     e2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e2e:	c9                   	leave  
     e2f:	c3                   	ret    

00000e30 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     e30:	b8 01 00 00 00       	mov    $0x1,%eax
     e35:	cd 40                	int    $0x40
     e37:	c3                   	ret    

00000e38 <exit>:
SYSCALL(exit)
     e38:	b8 02 00 00 00       	mov    $0x2,%eax
     e3d:	cd 40                	int    $0x40
     e3f:	c3                   	ret    

00000e40 <wait>:
SYSCALL(wait)
     e40:	b8 03 00 00 00       	mov    $0x3,%eax
     e45:	cd 40                	int    $0x40
     e47:	c3                   	ret    

00000e48 <pipe>:
SYSCALL(pipe)
     e48:	b8 04 00 00 00       	mov    $0x4,%eax
     e4d:	cd 40                	int    $0x40
     e4f:	c3                   	ret    

00000e50 <read>:
SYSCALL(read)
     e50:	b8 05 00 00 00       	mov    $0x5,%eax
     e55:	cd 40                	int    $0x40
     e57:	c3                   	ret    

00000e58 <write>:
SYSCALL(write)
     e58:	b8 10 00 00 00       	mov    $0x10,%eax
     e5d:	cd 40                	int    $0x40
     e5f:	c3                   	ret    

00000e60 <close>:
SYSCALL(close)
     e60:	b8 15 00 00 00       	mov    $0x15,%eax
     e65:	cd 40                	int    $0x40
     e67:	c3                   	ret    

00000e68 <kill>:
SYSCALL(kill)
     e68:	b8 06 00 00 00       	mov    $0x6,%eax
     e6d:	cd 40                	int    $0x40
     e6f:	c3                   	ret    

00000e70 <exec>:
SYSCALL(exec)
     e70:	b8 07 00 00 00       	mov    $0x7,%eax
     e75:	cd 40                	int    $0x40
     e77:	c3                   	ret    

00000e78 <open>:
SYSCALL(open)
     e78:	b8 0f 00 00 00       	mov    $0xf,%eax
     e7d:	cd 40                	int    $0x40
     e7f:	c3                   	ret    

00000e80 <mknod>:
SYSCALL(mknod)
     e80:	b8 11 00 00 00       	mov    $0x11,%eax
     e85:	cd 40                	int    $0x40
     e87:	c3                   	ret    

00000e88 <unlink>:
SYSCALL(unlink)
     e88:	b8 12 00 00 00       	mov    $0x12,%eax
     e8d:	cd 40                	int    $0x40
     e8f:	c3                   	ret    

00000e90 <fstat>:
SYSCALL(fstat)
     e90:	b8 08 00 00 00       	mov    $0x8,%eax
     e95:	cd 40                	int    $0x40
     e97:	c3                   	ret    

00000e98 <link>:
SYSCALL(link)
     e98:	b8 13 00 00 00       	mov    $0x13,%eax
     e9d:	cd 40                	int    $0x40
     e9f:	c3                   	ret    

00000ea0 <mkdir>:
SYSCALL(mkdir)
     ea0:	b8 14 00 00 00       	mov    $0x14,%eax
     ea5:	cd 40                	int    $0x40
     ea7:	c3                   	ret    

00000ea8 <chdir>:
SYSCALL(chdir)
     ea8:	b8 09 00 00 00       	mov    $0x9,%eax
     ead:	cd 40                	int    $0x40
     eaf:	c3                   	ret    

00000eb0 <dup>:
SYSCALL(dup)
     eb0:	b8 0a 00 00 00       	mov    $0xa,%eax
     eb5:	cd 40                	int    $0x40
     eb7:	c3                   	ret    

00000eb8 <getpid>:
SYSCALL(getpid)
     eb8:	b8 0b 00 00 00       	mov    $0xb,%eax
     ebd:	cd 40                	int    $0x40
     ebf:	c3                   	ret    

00000ec0 <sbrk>:
SYSCALL(sbrk)
     ec0:	b8 0c 00 00 00       	mov    $0xc,%eax
     ec5:	cd 40                	int    $0x40
     ec7:	c3                   	ret    

00000ec8 <sleep>:
SYSCALL(sleep)
     ec8:	b8 0d 00 00 00       	mov    $0xd,%eax
     ecd:	cd 40                	int    $0x40
     ecf:	c3                   	ret    

00000ed0 <uptime>:
SYSCALL(uptime)
     ed0:	b8 0e 00 00 00       	mov    $0xe,%eax
     ed5:	cd 40                	int    $0x40
     ed7:	c3                   	ret    

00000ed8 <halt>:
SYSCALL(halt)
     ed8:	b8 16 00 00 00       	mov    $0x16,%eax
     edd:	cd 40                	int    $0x40
     edf:	c3                   	ret    

00000ee0 <date>:
SYSCALL(date)
     ee0:	b8 17 00 00 00       	mov    $0x17,%eax
     ee5:	cd 40                	int    $0x40
     ee7:	c3                   	ret    

00000ee8 <getuid>:
SYSCALL(getuid)
     ee8:	b8 18 00 00 00       	mov    $0x18,%eax
     eed:	cd 40                	int    $0x40
     eef:	c3                   	ret    

00000ef0 <getgid>:
SYSCALL(getgid)
     ef0:	b8 19 00 00 00       	mov    $0x19,%eax
     ef5:	cd 40                	int    $0x40
     ef7:	c3                   	ret    

00000ef8 <getppid>:
SYSCALL(getppid)
     ef8:	b8 1a 00 00 00       	mov    $0x1a,%eax
     efd:	cd 40                	int    $0x40
     eff:	c3                   	ret    

00000f00 <setuid>:
SYSCALL(setuid)
     f00:	b8 1b 00 00 00       	mov    $0x1b,%eax
     f05:	cd 40                	int    $0x40
     f07:	c3                   	ret    

00000f08 <setgid>:
SYSCALL(setgid)
     f08:	b8 1c 00 00 00       	mov    $0x1c,%eax
     f0d:	cd 40                	int    $0x40
     f0f:	c3                   	ret    

00000f10 <getprocs>:
SYSCALL(getprocs)
     f10:	b8 1d 00 00 00       	mov    $0x1d,%eax
     f15:	cd 40                	int    $0x40
     f17:	c3                   	ret    

00000f18 <setpriority>:
SYSCALL(setpriority)
     f18:	b8 1e 00 00 00       	mov    $0x1e,%eax
     f1d:	cd 40                	int    $0x40
     f1f:	c3                   	ret    

00000f20 <chown>:
SYSCALL(chown)
     f20:	b8 1f 00 00 00       	mov    $0x1f,%eax
     f25:	cd 40                	int    $0x40
     f27:	c3                   	ret    

00000f28 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     f28:	f3 0f 1e fb          	endbr32 
     f2c:	55                   	push   %ebp
     f2d:	89 e5                	mov    %esp,%ebp
     f2f:	83 ec 18             	sub    $0x18,%esp
     f32:	8b 45 0c             	mov    0xc(%ebp),%eax
     f35:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     f38:	83 ec 04             	sub    $0x4,%esp
     f3b:	6a 01                	push   $0x1
     f3d:	8d 45 f4             	lea    -0xc(%ebp),%eax
     f40:	50                   	push   %eax
     f41:	ff 75 08             	pushl  0x8(%ebp)
     f44:	e8 0f ff ff ff       	call   e58 <write>
     f49:	83 c4 10             	add    $0x10,%esp
}
     f4c:	90                   	nop
     f4d:	c9                   	leave  
     f4e:	c3                   	ret    

00000f4f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     f4f:	f3 0f 1e fb          	endbr32 
     f53:	55                   	push   %ebp
     f54:	89 e5                	mov    %esp,%ebp
     f56:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     f59:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     f60:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     f64:	74 17                	je     f7d <printint+0x2e>
     f66:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f6a:	79 11                	jns    f7d <printint+0x2e>
    neg = 1;
     f6c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     f73:	8b 45 0c             	mov    0xc(%ebp),%eax
     f76:	f7 d8                	neg    %eax
     f78:	89 45 ec             	mov    %eax,-0x14(%ebp)
     f7b:	eb 06                	jmp    f83 <printint+0x34>
  } else {
    x = xx;
     f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
     f80:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     f83:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     f8a:	8b 4d 10             	mov    0x10(%ebp),%ecx
     f8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f90:	ba 00 00 00 00       	mov    $0x0,%edx
     f95:	f7 f1                	div    %ecx
     f97:	89 d1                	mov    %edx,%ecx
     f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f9c:	8d 50 01             	lea    0x1(%eax),%edx
     f9f:	89 55 f4             	mov    %edx,-0xc(%ebp)
     fa2:	0f b6 91 64 1f 00 00 	movzbl 0x1f64(%ecx),%edx
     fa9:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     fad:	8b 4d 10             	mov    0x10(%ebp),%ecx
     fb0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     fb3:	ba 00 00 00 00       	mov    $0x0,%edx
     fb8:	f7 f1                	div    %ecx
     fba:	89 45 ec             	mov    %eax,-0x14(%ebp)
     fbd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     fc1:	75 c7                	jne    f8a <printint+0x3b>
  if(neg)
     fc3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     fc7:	74 2d                	je     ff6 <printint+0xa7>
    buf[i++] = '-';
     fc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fcc:	8d 50 01             	lea    0x1(%eax),%edx
     fcf:	89 55 f4             	mov    %edx,-0xc(%ebp)
     fd2:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     fd7:	eb 1d                	jmp    ff6 <printint+0xa7>
    putc(fd, buf[i]);
     fd9:	8d 55 dc             	lea    -0x24(%ebp),%edx
     fdc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fdf:	01 d0                	add    %edx,%eax
     fe1:	0f b6 00             	movzbl (%eax),%eax
     fe4:	0f be c0             	movsbl %al,%eax
     fe7:	83 ec 08             	sub    $0x8,%esp
     fea:	50                   	push   %eax
     feb:	ff 75 08             	pushl  0x8(%ebp)
     fee:	e8 35 ff ff ff       	call   f28 <putc>
     ff3:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     ff6:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     ffa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ffe:	79 d9                	jns    fd9 <printint+0x8a>
}
    1000:	90                   	nop
    1001:	90                   	nop
    1002:	c9                   	leave  
    1003:	c3                   	ret    

00001004 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1004:	f3 0f 1e fb          	endbr32 
    1008:	55                   	push   %ebp
    1009:	89 e5                	mov    %esp,%ebp
    100b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    100e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1015:	8d 45 0c             	lea    0xc(%ebp),%eax
    1018:	83 c0 04             	add    $0x4,%eax
    101b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    101e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1025:	e9 59 01 00 00       	jmp    1183 <printf+0x17f>
    c = fmt[i] & 0xff;
    102a:	8b 55 0c             	mov    0xc(%ebp),%edx
    102d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1030:	01 d0                	add    %edx,%eax
    1032:	0f b6 00             	movzbl (%eax),%eax
    1035:	0f be c0             	movsbl %al,%eax
    1038:	25 ff 00 00 00       	and    $0xff,%eax
    103d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1040:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1044:	75 2c                	jne    1072 <printf+0x6e>
      if(c == '%'){
    1046:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    104a:	75 0c                	jne    1058 <printf+0x54>
        state = '%';
    104c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    1053:	e9 27 01 00 00       	jmp    117f <printf+0x17b>
      } else {
        putc(fd, c);
    1058:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    105b:	0f be c0             	movsbl %al,%eax
    105e:	83 ec 08             	sub    $0x8,%esp
    1061:	50                   	push   %eax
    1062:	ff 75 08             	pushl  0x8(%ebp)
    1065:	e8 be fe ff ff       	call   f28 <putc>
    106a:	83 c4 10             	add    $0x10,%esp
    106d:	e9 0d 01 00 00       	jmp    117f <printf+0x17b>
      }
    } else if(state == '%'){
    1072:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    1076:	0f 85 03 01 00 00    	jne    117f <printf+0x17b>
      if(c == 'd'){
    107c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1080:	75 1e                	jne    10a0 <printf+0x9c>
        printint(fd, *ap, 10, 1);
    1082:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1085:	8b 00                	mov    (%eax),%eax
    1087:	6a 01                	push   $0x1
    1089:	6a 0a                	push   $0xa
    108b:	50                   	push   %eax
    108c:	ff 75 08             	pushl  0x8(%ebp)
    108f:	e8 bb fe ff ff       	call   f4f <printint>
    1094:	83 c4 10             	add    $0x10,%esp
        ap++;
    1097:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    109b:	e9 d8 00 00 00       	jmp    1178 <printf+0x174>
      } else if(c == 'x' || c == 'p'){
    10a0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    10a4:	74 06                	je     10ac <printf+0xa8>
    10a6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    10aa:	75 1e                	jne    10ca <printf+0xc6>
        printint(fd, *ap, 16, 0);
    10ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10af:	8b 00                	mov    (%eax),%eax
    10b1:	6a 00                	push   $0x0
    10b3:	6a 10                	push   $0x10
    10b5:	50                   	push   %eax
    10b6:	ff 75 08             	pushl  0x8(%ebp)
    10b9:	e8 91 fe ff ff       	call   f4f <printint>
    10be:	83 c4 10             	add    $0x10,%esp
        ap++;
    10c1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    10c5:	e9 ae 00 00 00       	jmp    1178 <printf+0x174>
      } else if(c == 's'){
    10ca:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    10ce:	75 43                	jne    1113 <printf+0x10f>
        s = (char*)*ap;
    10d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    10d3:	8b 00                	mov    (%eax),%eax
    10d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    10d8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    10dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    10e0:	75 25                	jne    1107 <printf+0x103>
          s = "(null)";
    10e2:	c7 45 f4 a0 1a 00 00 	movl   $0x1aa0,-0xc(%ebp)
        while(*s != 0){
    10e9:	eb 1c                	jmp    1107 <printf+0x103>
          putc(fd, *s);
    10eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10ee:	0f b6 00             	movzbl (%eax),%eax
    10f1:	0f be c0             	movsbl %al,%eax
    10f4:	83 ec 08             	sub    $0x8,%esp
    10f7:	50                   	push   %eax
    10f8:	ff 75 08             	pushl  0x8(%ebp)
    10fb:	e8 28 fe ff ff       	call   f28 <putc>
    1100:	83 c4 10             	add    $0x10,%esp
          s++;
    1103:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    1107:	8b 45 f4             	mov    -0xc(%ebp),%eax
    110a:	0f b6 00             	movzbl (%eax),%eax
    110d:	84 c0                	test   %al,%al
    110f:	75 da                	jne    10eb <printf+0xe7>
    1111:	eb 65                	jmp    1178 <printf+0x174>
        }
      } else if(c == 'c'){
    1113:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    1117:	75 1d                	jne    1136 <printf+0x132>
        putc(fd, *ap);
    1119:	8b 45 e8             	mov    -0x18(%ebp),%eax
    111c:	8b 00                	mov    (%eax),%eax
    111e:	0f be c0             	movsbl %al,%eax
    1121:	83 ec 08             	sub    $0x8,%esp
    1124:	50                   	push   %eax
    1125:	ff 75 08             	pushl  0x8(%ebp)
    1128:	e8 fb fd ff ff       	call   f28 <putc>
    112d:	83 c4 10             	add    $0x10,%esp
        ap++;
    1130:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1134:	eb 42                	jmp    1178 <printf+0x174>
      } else if(c == '%'){
    1136:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    113a:	75 17                	jne    1153 <printf+0x14f>
        putc(fd, c);
    113c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    113f:	0f be c0             	movsbl %al,%eax
    1142:	83 ec 08             	sub    $0x8,%esp
    1145:	50                   	push   %eax
    1146:	ff 75 08             	pushl  0x8(%ebp)
    1149:	e8 da fd ff ff       	call   f28 <putc>
    114e:	83 c4 10             	add    $0x10,%esp
    1151:	eb 25                	jmp    1178 <printf+0x174>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1153:	83 ec 08             	sub    $0x8,%esp
    1156:	6a 25                	push   $0x25
    1158:	ff 75 08             	pushl  0x8(%ebp)
    115b:	e8 c8 fd ff ff       	call   f28 <putc>
    1160:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    1163:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1166:	0f be c0             	movsbl %al,%eax
    1169:	83 ec 08             	sub    $0x8,%esp
    116c:	50                   	push   %eax
    116d:	ff 75 08             	pushl  0x8(%ebp)
    1170:	e8 b3 fd ff ff       	call   f28 <putc>
    1175:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1178:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    117f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1183:	8b 55 0c             	mov    0xc(%ebp),%edx
    1186:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1189:	01 d0                	add    %edx,%eax
    118b:	0f b6 00             	movzbl (%eax),%eax
    118e:	84 c0                	test   %al,%al
    1190:	0f 85 94 fe ff ff    	jne    102a <printf+0x26>
    }
  }
}
    1196:	90                   	nop
    1197:	90                   	nop
    1198:	c9                   	leave  
    1199:	c3                   	ret    

0000119a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    119a:	f3 0f 1e fb          	endbr32 
    119e:	55                   	push   %ebp
    119f:	89 e5                	mov    %esp,%ebp
    11a1:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    11a4:	8b 45 08             	mov    0x8(%ebp),%eax
    11a7:	83 e8 08             	sub    $0x8,%eax
    11aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11ad:	a1 94 1f 00 00       	mov    0x1f94,%eax
    11b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11b5:	eb 24                	jmp    11db <free+0x41>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11ba:	8b 00                	mov    (%eax),%eax
    11bc:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    11bf:	72 12                	jb     11d3 <free+0x39>
    11c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11c4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    11c7:	77 24                	ja     11ed <free+0x53>
    11c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11cc:	8b 00                	mov    (%eax),%eax
    11ce:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    11d1:	72 1a                	jb     11ed <free+0x53>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11d6:	8b 00                	mov    (%eax),%eax
    11d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    11db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    11e1:	76 d4                	jbe    11b7 <free+0x1d>
    11e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11e6:	8b 00                	mov    (%eax),%eax
    11e8:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    11eb:	73 ca                	jae    11b7 <free+0x1d>
      break;
  if(bp + bp->s.size == p->s.ptr){
    11ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11f0:	8b 40 04             	mov    0x4(%eax),%eax
    11f3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    11fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
    11fd:	01 c2                	add    %eax,%edx
    11ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1202:	8b 00                	mov    (%eax),%eax
    1204:	39 c2                	cmp    %eax,%edx
    1206:	75 24                	jne    122c <free+0x92>
    bp->s.size += p->s.ptr->s.size;
    1208:	8b 45 f8             	mov    -0x8(%ebp),%eax
    120b:	8b 50 04             	mov    0x4(%eax),%edx
    120e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1211:	8b 00                	mov    (%eax),%eax
    1213:	8b 40 04             	mov    0x4(%eax),%eax
    1216:	01 c2                	add    %eax,%edx
    1218:	8b 45 f8             	mov    -0x8(%ebp),%eax
    121b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    121e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1221:	8b 00                	mov    (%eax),%eax
    1223:	8b 10                	mov    (%eax),%edx
    1225:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1228:	89 10                	mov    %edx,(%eax)
    122a:	eb 0a                	jmp    1236 <free+0x9c>
  } else
    bp->s.ptr = p->s.ptr;
    122c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    122f:	8b 10                	mov    (%eax),%edx
    1231:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1234:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1236:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1239:	8b 40 04             	mov    0x4(%eax),%eax
    123c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1243:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1246:	01 d0                	add    %edx,%eax
    1248:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    124b:	75 20                	jne    126d <free+0xd3>
    p->s.size += bp->s.size;
    124d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1250:	8b 50 04             	mov    0x4(%eax),%edx
    1253:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1256:	8b 40 04             	mov    0x4(%eax),%eax
    1259:	01 c2                	add    %eax,%edx
    125b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    125e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1261:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1264:	8b 10                	mov    (%eax),%edx
    1266:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1269:	89 10                	mov    %edx,(%eax)
    126b:	eb 08                	jmp    1275 <free+0xdb>
  } else
    p->s.ptr = bp;
    126d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1270:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1273:	89 10                	mov    %edx,(%eax)
  freep = p;
    1275:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1278:	a3 94 1f 00 00       	mov    %eax,0x1f94
}
    127d:	90                   	nop
    127e:	c9                   	leave  
    127f:	c3                   	ret    

00001280 <morecore>:

static Header*
morecore(uint nu)
{
    1280:	f3 0f 1e fb          	endbr32 
    1284:	55                   	push   %ebp
    1285:	89 e5                	mov    %esp,%ebp
    1287:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    128a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1291:	77 07                	ja     129a <morecore+0x1a>
    nu = 4096;
    1293:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    129a:	8b 45 08             	mov    0x8(%ebp),%eax
    129d:	c1 e0 03             	shl    $0x3,%eax
    12a0:	83 ec 0c             	sub    $0xc,%esp
    12a3:	50                   	push   %eax
    12a4:	e8 17 fc ff ff       	call   ec0 <sbrk>
    12a9:	83 c4 10             	add    $0x10,%esp
    12ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    12af:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    12b3:	75 07                	jne    12bc <morecore+0x3c>
    return 0;
    12b5:	b8 00 00 00 00       	mov    $0x0,%eax
    12ba:	eb 26                	jmp    12e2 <morecore+0x62>
  hp = (Header*)p;
    12bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    12c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12c5:	8b 55 08             	mov    0x8(%ebp),%edx
    12c8:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    12cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12ce:	83 c0 08             	add    $0x8,%eax
    12d1:	83 ec 0c             	sub    $0xc,%esp
    12d4:	50                   	push   %eax
    12d5:	e8 c0 fe ff ff       	call   119a <free>
    12da:	83 c4 10             	add    $0x10,%esp
  return freep;
    12dd:	a1 94 1f 00 00       	mov    0x1f94,%eax
}
    12e2:	c9                   	leave  
    12e3:	c3                   	ret    

000012e4 <malloc>:

void*
malloc(uint nbytes)
{
    12e4:	f3 0f 1e fb          	endbr32 
    12e8:	55                   	push   %ebp
    12e9:	89 e5                	mov    %esp,%ebp
    12eb:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    12ee:	8b 45 08             	mov    0x8(%ebp),%eax
    12f1:	83 c0 07             	add    $0x7,%eax
    12f4:	c1 e8 03             	shr    $0x3,%eax
    12f7:	83 c0 01             	add    $0x1,%eax
    12fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    12fd:	a1 94 1f 00 00       	mov    0x1f94,%eax
    1302:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1305:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1309:	75 23                	jne    132e <malloc+0x4a>
    base.s.ptr = freep = prevp = &base;
    130b:	c7 45 f0 8c 1f 00 00 	movl   $0x1f8c,-0x10(%ebp)
    1312:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1315:	a3 94 1f 00 00       	mov    %eax,0x1f94
    131a:	a1 94 1f 00 00       	mov    0x1f94,%eax
    131f:	a3 8c 1f 00 00       	mov    %eax,0x1f8c
    base.s.size = 0;
    1324:	c7 05 90 1f 00 00 00 	movl   $0x0,0x1f90
    132b:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    132e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1331:	8b 00                	mov    (%eax),%eax
    1333:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1336:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1339:	8b 40 04             	mov    0x4(%eax),%eax
    133c:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    133f:	77 4d                	ja     138e <malloc+0xaa>
      if(p->s.size == nunits)
    1341:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1344:	8b 40 04             	mov    0x4(%eax),%eax
    1347:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    134a:	75 0c                	jne    1358 <malloc+0x74>
        prevp->s.ptr = p->s.ptr;
    134c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    134f:	8b 10                	mov    (%eax),%edx
    1351:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1354:	89 10                	mov    %edx,(%eax)
    1356:	eb 26                	jmp    137e <malloc+0x9a>
      else {
        p->s.size -= nunits;
    1358:	8b 45 f4             	mov    -0xc(%ebp),%eax
    135b:	8b 40 04             	mov    0x4(%eax),%eax
    135e:	2b 45 ec             	sub    -0x14(%ebp),%eax
    1361:	89 c2                	mov    %eax,%edx
    1363:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1366:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1369:	8b 45 f4             	mov    -0xc(%ebp),%eax
    136c:	8b 40 04             	mov    0x4(%eax),%eax
    136f:	c1 e0 03             	shl    $0x3,%eax
    1372:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1375:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1378:	8b 55 ec             	mov    -0x14(%ebp),%edx
    137b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    137e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1381:	a3 94 1f 00 00       	mov    %eax,0x1f94
      return (void*)(p + 1);
    1386:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1389:	83 c0 08             	add    $0x8,%eax
    138c:	eb 3b                	jmp    13c9 <malloc+0xe5>
    }
    if(p == freep)
    138e:	a1 94 1f 00 00       	mov    0x1f94,%eax
    1393:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1396:	75 1e                	jne    13b6 <malloc+0xd2>
      if((p = morecore(nunits)) == 0)
    1398:	83 ec 0c             	sub    $0xc,%esp
    139b:	ff 75 ec             	pushl  -0x14(%ebp)
    139e:	e8 dd fe ff ff       	call   1280 <morecore>
    13a3:	83 c4 10             	add    $0x10,%esp
    13a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13ad:	75 07                	jne    13b6 <malloc+0xd2>
        return 0;
    13af:	b8 00 00 00 00       	mov    $0x0,%eax
    13b4:	eb 13                	jmp    13c9 <malloc+0xe5>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    13bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13bf:	8b 00                	mov    (%eax),%eax
    13c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    13c4:	e9 6d ff ff ff       	jmp    1336 <malloc+0x52>
  }
}
    13c9:	c9                   	leave  
    13ca:	c3                   	ret    

000013cb <get_id>:
static struct group_struct current_group;
static char current_line[PANJANG_LINE];
static int dir;

// transfer info nama, uid, gid ke struct ids_struct
static int get_id(void){
    13cb:	f3 0f 1e fb          	endbr32 
    13cf:	55                   	push   %ebp
    13d0:	89 e5                	mov    %esp,%ebp
    13d2:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
    13d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
    13dc:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    13e1:	83 ec 04             	sub    $0x4,%esp
    13e4:	50                   	push   %eax
    13e5:	6a 20                	push   $0x20
    13e7:	68 c0 1f 00 00       	push   $0x1fc0
    13ec:	e8 11 f8 ff ff       	call   c02 <fgets>
    13f1:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
    13f4:	83 ec 0c             	sub    $0xc,%esp
    13f7:	68 c0 1f 00 00       	push   $0x1fc0
    13fc:	e8 0e f7 ff ff       	call   b0f <strlen>
    1401:	83 c4 10             	add    $0x10,%esp
    1404:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
    1407:	8b 45 e8             	mov    -0x18(%ebp),%eax
    140a:	83 e8 01             	sub    $0x1,%eax
    140d:	0f b6 80 c0 1f 00 00 	movzbl 0x1fc0(%eax),%eax
    1414:	3c 0a                	cmp    $0xa,%al
    1416:	74 11                	je     1429 <get_id+0x5e>
    1418:	8b 45 e8             	mov    -0x18(%ebp),%eax
    141b:	83 e8 01             	sub    $0x1,%eax
    141e:	0f b6 80 c0 1f 00 00 	movzbl 0x1fc0(%eax),%eax
    1425:	3c 0d                	cmp    $0xd,%al
    1427:	75 0d                	jne    1436 <get_id+0x6b>
        current_line[len - 1] = 0;
    1429:	8b 45 e8             	mov    -0x18(%ebp),%eax
    142c:	83 e8 01             	sub    $0x1,%eax
    142f:	c6 80 c0 1f 00 00 00 	movb   $0x0,0x1fc0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
    1436:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
    143d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1444:	eb 6c                	jmp    14b2 <get_id+0xe7>
        if(current_line[i] == ' '){
    1446:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1449:	05 c0 1f 00 00       	add    $0x1fc0,%eax
    144e:	0f b6 00             	movzbl (%eax),%eax
    1451:	3c 20                	cmp    $0x20,%al
    1453:	75 30                	jne    1485 <get_id+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
    1455:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1459:	75 16                	jne    1471 <get_id+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
    145b:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    145e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1461:	8d 50 01             	lea    0x1(%eax),%edx
    1464:	89 55 f0             	mov    %edx,-0x10(%ebp)
    1467:	8d 91 c0 1f 00 00    	lea    0x1fc0(%ecx),%edx
    146d:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
    1471:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1474:	05 c0 1f 00 00       	add    $0x1fc0,%eax
    1479:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
    147c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1483:	eb 29                	jmp    14ae <get_id+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
    1485:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1489:	75 23                	jne    14ae <get_id+0xe3>
    148b:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    148f:	7f 1d                	jg     14ae <get_id+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
    1491:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
    1498:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    149b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    149e:	8d 50 01             	lea    0x1(%eax),%edx
    14a1:	89 55 f0             	mov    %edx,-0x10(%ebp)
    14a4:	8d 91 c0 1f 00 00    	lea    0x1fc0(%ecx),%edx
    14aa:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
    14ae:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    14b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14b5:	05 c0 1f 00 00       	add    $0x1fc0,%eax
    14ba:	0f b6 00             	movzbl (%eax),%eax
    14bd:	84 c0                	test   %al,%al
    14bf:	75 85                	jne    1446 <get_id+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
    14c1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14c5:	75 07                	jne    14ce <get_id+0x103>
        return -1;
    14c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14cc:	eb 35                	jmp    1503 <get_id+0x138>
    
    current_id.nama_user = tokens[0];
    14ce:	8b 45 dc             	mov    -0x24(%ebp),%eax
    14d1:	a3 a0 1f 00 00       	mov    %eax,0x1fa0
    current_id.uid_user = atoi(tokens[1]);
    14d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
    14d9:	83 ec 0c             	sub    $0xc,%esp
    14dc:	50                   	push   %eax
    14dd:	e8 e5 f7 ff ff       	call   cc7 <atoi>
    14e2:	83 c4 10             	add    $0x10,%esp
    14e5:	a3 a4 1f 00 00       	mov    %eax,0x1fa4
    current_id.gid_user = atoi(tokens[2]);
    14ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    14ed:	83 ec 0c             	sub    $0xc,%esp
    14f0:	50                   	push   %eax
    14f1:	e8 d1 f7 ff ff       	call   cc7 <atoi>
    14f6:	83 c4 10             	add    $0x10,%esp
    14f9:	a3 a8 1f 00 00       	mov    %eax,0x1fa8

    return 0;
    14fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1503:	c9                   	leave  
    1504:	c3                   	ret    

00001505 <getid>:

// buka file_ids terus passing ke get_id
struct ids_struct* getid(void){
    1505:	f3 0f 1e fb          	endbr32 
    1509:	55                   	push   %ebp
    150a:	89 e5                	mov    %esp,%ebp
    150c:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
    150f:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1514:	85 c0                	test   %eax,%eax
    1516:	75 31                	jne    1549 <getid+0x44>
        dir = open(IDS_FILE, O_RDONLY);
    1518:	83 ec 08             	sub    $0x8,%esp
    151b:	6a 00                	push   $0x0
    151d:	68 a7 1a 00 00       	push   $0x1aa7
    1522:	e8 51 f9 ff ff       	call   e78 <open>
    1527:	83 c4 10             	add    $0x10,%esp
    152a:	a3 e0 1f 00 00       	mov    %eax,0x1fe0

        if(dir < 0){        // kalau gagal membuka file
    152f:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1534:	85 c0                	test   %eax,%eax
    1536:	79 11                	jns    1549 <getid+0x44>
            dir = 0;
    1538:	c7 05 e0 1f 00 00 00 	movl   $0x0,0x1fe0
    153f:	00 00 00 
            return 0;
    1542:	b8 00 00 00 00       	mov    $0x0,%eax
    1547:	eb 16                	jmp    155f <getid+0x5a>
        }
    }

    if(get_id() == -1) 
    1549:	e8 7d fe ff ff       	call   13cb <get_id>
    154e:	83 f8 ff             	cmp    $0xffffffff,%eax
    1551:	75 07                	jne    155a <getid+0x55>
        return 0;
    1553:	b8 00 00 00 00       	mov    $0x0,%eax
    1558:	eb 05                	jmp    155f <getid+0x5a>
    
    return &current_id;
    155a:	b8 a0 1f 00 00       	mov    $0x1fa0,%eax
}
    155f:	c9                   	leave  
    1560:	c3                   	ret    

00001561 <setid>:

// open file_ids
void setid(void){
    1561:	f3 0f 1e fb          	endbr32 
    1565:	55                   	push   %ebp
    1566:	89 e5                	mov    %esp,%ebp
    1568:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    156b:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1570:	85 c0                	test   %eax,%eax
    1572:	74 1b                	je     158f <setid+0x2e>
        close(dir);
    1574:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1579:	83 ec 0c             	sub    $0xc,%esp
    157c:	50                   	push   %eax
    157d:	e8 de f8 ff ff       	call   e60 <close>
    1582:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1585:	c7 05 e0 1f 00 00 00 	movl   $0x0,0x1fe0
    158c:	00 00 00 
    }

    dir = open(IDS_FILE, O_RDONLY);
    158f:	83 ec 08             	sub    $0x8,%esp
    1592:	6a 00                	push   $0x0
    1594:	68 a7 1a 00 00       	push   $0x1aa7
    1599:	e8 da f8 ff ff       	call   e78 <open>
    159e:	83 c4 10             	add    $0x10,%esp
    15a1:	a3 e0 1f 00 00       	mov    %eax,0x1fe0

    if (dir < 0)
    15a6:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    15ab:	85 c0                	test   %eax,%eax
    15ad:	79 0a                	jns    15b9 <setid+0x58>
        dir = 0;
    15af:	c7 05 e0 1f 00 00 00 	movl   $0x0,0x1fe0
    15b6:	00 00 00 
}
    15b9:	90                   	nop
    15ba:	c9                   	leave  
    15bb:	c3                   	ret    

000015bc <endid>:

// tutup file_ids
void endid (void){
    15bc:	f3 0f 1e fb          	endbr32 
    15c0:	55                   	push   %ebp
    15c1:	89 e5                	mov    %esp,%ebp
    15c3:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    15c6:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    15cb:	85 c0                	test   %eax,%eax
    15cd:	74 1b                	je     15ea <endid+0x2e>
        close(dir);
    15cf:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    15d4:	83 ec 0c             	sub    $0xc,%esp
    15d7:	50                   	push   %eax
    15d8:	e8 83 f8 ff ff       	call   e60 <close>
    15dd:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    15e0:	c7 05 e0 1f 00 00 00 	movl   $0x0,0x1fe0
    15e7:	00 00 00 
    }
}
    15ea:	90                   	nop
    15eb:	c9                   	leave  
    15ec:	c3                   	ret    

000015ed <cek_nama>:

// cek apakah user ada di IDS_FILE
struct ids_struct* cek_nama(const char* nama_id){
    15ed:	f3 0f 1e fb          	endbr32 
    15f1:	55                   	push   %ebp
    15f2:	89 e5                	mov    %esp,%ebp
    15f4:	83 ec 08             	sub    $0x8,%esp
    setid();
    15f7:	e8 65 ff ff ff       	call   1561 <setid>

    while (getid()){
    15fc:	eb 24                	jmp    1622 <cek_nama+0x35>
        if(strcmp (nama_id, current_id.nama_user) == 0){
    15fe:	a1 a0 1f 00 00       	mov    0x1fa0,%eax
    1603:	83 ec 08             	sub    $0x8,%esp
    1606:	50                   	push   %eax
    1607:	ff 75 08             	pushl  0x8(%ebp)
    160a:	e8 bd f4 ff ff       	call   acc <strcmp>
    160f:	83 c4 10             	add    $0x10,%esp
    1612:	85 c0                	test   %eax,%eax
    1614:	75 0c                	jne    1622 <cek_nama+0x35>
            endid();
    1616:	e8 a1 ff ff ff       	call   15bc <endid>
            return &current_id;
    161b:	b8 a0 1f 00 00       	mov    $0x1fa0,%eax
    1620:	eb 13                	jmp    1635 <cek_nama+0x48>
    while (getid()){
    1622:	e8 de fe ff ff       	call   1505 <getid>
    1627:	85 c0                	test   %eax,%eax
    1629:	75 d3                	jne    15fe <cek_nama+0x11>
        }
    }
    endid();
    162b:	e8 8c ff ff ff       	call   15bc <endid>
    return 0;
    1630:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1635:	c9                   	leave  
    1636:	c3                   	ret    

00001637 <cek_uid>:

// cek apakah uid ada di IDS_FILE
struct ids_struct* cek_uid(uid_t uid){
    1637:	f3 0f 1e fb          	endbr32 
    163b:	55                   	push   %ebp
    163c:	89 e5                	mov    %esp,%ebp
    163e:	83 ec 08             	sub    $0x8,%esp
    setid();
    1641:	e8 1b ff ff ff       	call   1561 <setid>

    while (getid()){
    1646:	eb 16                	jmp    165e <cek_uid+0x27>
        if(current_id.uid_user == uid){
    1648:	a1 a4 1f 00 00       	mov    0x1fa4,%eax
    164d:	39 45 08             	cmp    %eax,0x8(%ebp)
    1650:	75 0c                	jne    165e <cek_uid+0x27>
            endid();
    1652:	e8 65 ff ff ff       	call   15bc <endid>
            return &current_id;
    1657:	b8 a0 1f 00 00       	mov    $0x1fa0,%eax
    165c:	eb 13                	jmp    1671 <cek_uid+0x3a>
    while (getid()){
    165e:	e8 a2 fe ff ff       	call   1505 <getid>
    1663:	85 c0                	test   %eax,%eax
    1665:	75 e1                	jne    1648 <cek_uid+0x11>
        }
    }
    endid();
    1667:	e8 50 ff ff ff       	call   15bc <endid>
    return 0;
    166c:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1671:	c9                   	leave  
    1672:	c3                   	ret    

00001673 <get_group>:


// ======================== GROUP =================

// transfer info nama, uid, gid ke struct ids_struct
static int get_group(void){
    1673:	f3 0f 1e fb          	endbr32 
    1677:	55                   	push   %ebp
    1678:	89 e5                	mov    %esp,%ebp
    167a:	83 ec 28             	sub    $0x28,%esp
    char* tokens[JUMLAH_TOKEN];     // bagi ID dalam 3 array
    int ok = 0;
    167d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    // ngambil line dari file
    fgets(current_line, PANJANG_LINE, dir);
    1684:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1689:	83 ec 04             	sub    $0x4,%esp
    168c:	50                   	push   %eax
    168d:	6a 20                	push   $0x20
    168f:	68 c0 1f 00 00       	push   $0x1fc0
    1694:	e8 69 f5 ff ff       	call   c02 <fgets>
    1699:	83 c4 10             	add    $0x10,%esp

    int len = strlen(current_line);
    169c:	83 ec 0c             	sub    $0xc,%esp
    169f:	68 c0 1f 00 00       	push   $0x1fc0
    16a4:	e8 66 f4 ff ff       	call   b0f <strlen>
    16a9:	83 c4 10             	add    $0x10,%esp
    16ac:	89 45 e8             	mov    %eax,-0x18(%ebp)

    // error handling kalau ada enter atau akhir file
    if (current_line[len - 1] == '\n' || current_line[len - 1] == '\r'){
    16af:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16b2:	83 e8 01             	sub    $0x1,%eax
    16b5:	0f b6 80 c0 1f 00 00 	movzbl 0x1fc0(%eax),%eax
    16bc:	3c 0a                	cmp    $0xa,%al
    16be:	74 11                	je     16d1 <get_group+0x5e>
    16c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16c3:	83 e8 01             	sub    $0x1,%eax
    16c6:	0f b6 80 c0 1f 00 00 	movzbl 0x1fc0(%eax),%eax
    16cd:	3c 0d                	cmp    $0xd,%al
    16cf:	75 0d                	jne    16de <get_group+0x6b>
        current_line[len - 1] = 0;
    16d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    16d4:	83 e8 01             	sub    $0x1,%eax
    16d7:	c6 80 c0 1f 00 00 00 	movb   $0x0,0x1fc0(%eax)
    }
    
    // mulai pisah line nya
    int token_selanjutnya = 0;
    16de:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    int i;
    for (i = 0; current_line[i]; ++i){
    16e5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    16ec:	eb 6c                	jmp    175a <get_group+0xe7>
        if(current_line[i] == ' '){
    16ee:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16f1:	05 c0 1f 00 00       	add    $0x1fc0,%eax
    16f6:	0f b6 00             	movzbl (%eax),%eax
    16f9:	3c 20                	cmp    $0x20,%al
    16fb:	75 30                	jne    172d <get_group+0xba>
            if(ok == 0)         // Kalau ketemu spasi, maka ganti ke array berikutnya
    16fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1701:	75 16                	jne    1719 <get_group+0xa6>
                tokens[token_selanjutnya++] = current_line + i;
    1703:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1706:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1709:	8d 50 01             	lea    0x1(%eax),%edx
    170c:	89 55 f0             	mov    %edx,-0x10(%ebp)
    170f:	8d 91 c0 1f 00 00    	lea    0x1fc0(%ecx),%edx
    1715:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
            
            current_line[i] = 0;
    1719:	8b 45 ec             	mov    -0x14(%ebp),%eax
    171c:	05 c0 1f 00 00       	add    $0x1fc0,%eax
    1721:	c6 00 00             	movb   $0x0,(%eax)
            ok = 0;
    1724:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    172b:	eb 29                	jmp    1756 <get_group+0xe3>
        }else if(ok == 0 && token_selanjutnya < JUMLAH_TOKEN){
    172d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1731:	75 23                	jne    1756 <get_group+0xe3>
    1733:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1737:	7f 1d                	jg     1756 <get_group+0xe3>
            ok = 1;     // copy semua isi current line kedalam tokens
    1739:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
            tokens[token_selanjutnya++] = current_line + i;
    1740:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1743:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1746:	8d 50 01             	lea    0x1(%eax),%edx
    1749:	89 55 f0             	mov    %edx,-0x10(%ebp)
    174c:	8d 91 c0 1f 00 00    	lea    0x1fc0(%ecx),%edx
    1752:	89 54 85 dc          	mov    %edx,-0x24(%ebp,%eax,4)
    for (i = 0; current_line[i]; ++i){
    1756:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    175a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    175d:	05 c0 1f 00 00       	add    $0x1fc0,%eax
    1762:	0f b6 00             	movzbl (%eax),%eax
    1765:	84 c0                	test   %al,%al
    1767:	75 85                	jne    16ee <get_group+0x7b>
        }
    }
    
    // kalau gabisa baca isi current line, return -1
    if(i == 0)
    1769:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    176d:	75 07                	jne    1776 <get_group+0x103>
        return -1;
    176f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1774:	eb 21                	jmp    1797 <get_group+0x124>
    
    current_group.nama_group = tokens[0];
    1776:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1779:	a3 ac 1f 00 00       	mov    %eax,0x1fac
    current_group.gid = atoi(tokens[1]);
    177e:	8b 45 e0             	mov    -0x20(%ebp),%eax
    1781:	83 ec 0c             	sub    $0xc,%esp
    1784:	50                   	push   %eax
    1785:	e8 3d f5 ff ff       	call   cc7 <atoi>
    178a:	83 c4 10             	add    $0x10,%esp
    178d:	a3 b0 1f 00 00       	mov    %eax,0x1fb0

    return 0;
    1792:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1797:	c9                   	leave  
    1798:	c3                   	ret    

00001799 <getgroup>:

// buka file_ids terus passing ke get_id
struct group_struct* getgroup(void){
    1799:	f3 0f 1e fb          	endbr32 
    179d:	55                   	push   %ebp
    179e:	89 e5                	mov    %esp,%ebp
    17a0:	83 ec 08             	sub    $0x8,%esp
    if (dir == 0){
    17a3:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    17a8:	85 c0                	test   %eax,%eax
    17aa:	75 31                	jne    17dd <getgroup+0x44>
        dir = open(GROUP_FILE, O_RDONLY);
    17ac:	83 ec 08             	sub    $0x8,%esp
    17af:	6a 00                	push   $0x0
    17b1:	68 af 1a 00 00       	push   $0x1aaf
    17b6:	e8 bd f6 ff ff       	call   e78 <open>
    17bb:	83 c4 10             	add    $0x10,%esp
    17be:	a3 e0 1f 00 00       	mov    %eax,0x1fe0

        if(dir < 0){        // kalau gagal membuka file
    17c3:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    17c8:	85 c0                	test   %eax,%eax
    17ca:	79 11                	jns    17dd <getgroup+0x44>
            dir = 0;
    17cc:	c7 05 e0 1f 00 00 00 	movl   $0x0,0x1fe0
    17d3:	00 00 00 
            return 0;
    17d6:	b8 00 00 00 00       	mov    $0x0,%eax
    17db:	eb 16                	jmp    17f3 <getgroup+0x5a>
        }
    }

    if(get_group() == -1) 
    17dd:	e8 91 fe ff ff       	call   1673 <get_group>
    17e2:	83 f8 ff             	cmp    $0xffffffff,%eax
    17e5:	75 07                	jne    17ee <getgroup+0x55>
        return 0;
    17e7:	b8 00 00 00 00       	mov    $0x0,%eax
    17ec:	eb 05                	jmp    17f3 <getgroup+0x5a>
    
    return &current_group;
    17ee:	b8 ac 1f 00 00       	mov    $0x1fac,%eax
}
    17f3:	c9                   	leave  
    17f4:	c3                   	ret    

000017f5 <setgroup>:

// open file_ids
void setgroup(void){
    17f5:	f3 0f 1e fb          	endbr32 
    17f9:	55                   	push   %ebp
    17fa:	89 e5                	mov    %esp,%ebp
    17fc:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    17ff:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1804:	85 c0                	test   %eax,%eax
    1806:	74 1b                	je     1823 <setgroup+0x2e>
        close(dir);
    1808:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    180d:	83 ec 0c             	sub    $0xc,%esp
    1810:	50                   	push   %eax
    1811:	e8 4a f6 ff ff       	call   e60 <close>
    1816:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1819:	c7 05 e0 1f 00 00 00 	movl   $0x0,0x1fe0
    1820:	00 00 00 
    }

    dir = open(GROUP_FILE, O_RDONLY);
    1823:	83 ec 08             	sub    $0x8,%esp
    1826:	6a 00                	push   $0x0
    1828:	68 af 1a 00 00       	push   $0x1aaf
    182d:	e8 46 f6 ff ff       	call   e78 <open>
    1832:	83 c4 10             	add    $0x10,%esp
    1835:	a3 e0 1f 00 00       	mov    %eax,0x1fe0

    if (dir < 0)
    183a:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    183f:	85 c0                	test   %eax,%eax
    1841:	79 0a                	jns    184d <setgroup+0x58>
        dir = 0;
    1843:	c7 05 e0 1f 00 00 00 	movl   $0x0,0x1fe0
    184a:	00 00 00 
}
    184d:	90                   	nop
    184e:	c9                   	leave  
    184f:	c3                   	ret    

00001850 <endgroup>:

// tutup file_ids
void endgroup (void){
    1850:	f3 0f 1e fb          	endbr32 
    1854:	55                   	push   %ebp
    1855:	89 e5                	mov    %esp,%ebp
    1857:	83 ec 08             	sub    $0x8,%esp
    if (dir != 0){
    185a:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    185f:	85 c0                	test   %eax,%eax
    1861:	74 1b                	je     187e <endgroup+0x2e>
        close(dir);
    1863:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1868:	83 ec 0c             	sub    $0xc,%esp
    186b:	50                   	push   %eax
    186c:	e8 ef f5 ff ff       	call   e60 <close>
    1871:	83 c4 10             	add    $0x10,%esp
        dir = 0;
    1874:	c7 05 e0 1f 00 00 00 	movl   $0x0,0x1fe0
    187b:	00 00 00 
    }
}
    187e:	90                   	nop
    187f:	c9                   	leave  
    1880:	c3                   	ret    

00001881 <cek_nama_group>:

// cek apakah user ada di IDS_FILE
struct group_struct* cek_nama_group(const char* nama_group){
    1881:	f3 0f 1e fb          	endbr32 
    1885:	55                   	push   %ebp
    1886:	89 e5                	mov    %esp,%ebp
    1888:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    188b:	e8 65 ff ff ff       	call   17f5 <setgroup>

    while (getgroup()){
    1890:	eb 3c                	jmp    18ce <cek_nama_group+0x4d>
        if(strcmp (nama_group, current_group.nama_group) == 0){
    1892:	a1 ac 1f 00 00       	mov    0x1fac,%eax
    1897:	83 ec 08             	sub    $0x8,%esp
    189a:	50                   	push   %eax
    189b:	ff 75 08             	pushl  0x8(%ebp)
    189e:	e8 29 f2 ff ff       	call   acc <strcmp>
    18a3:	83 c4 10             	add    $0x10,%esp
    18a6:	85 c0                	test   %eax,%eax
    18a8:	75 24                	jne    18ce <cek_nama_group+0x4d>
            endgroup();
    18aa:	e8 a1 ff ff ff       	call   1850 <endgroup>
            printf(1, "curr_group: %s\n", current_group.nama_group);
    18af:	a1 ac 1f 00 00       	mov    0x1fac,%eax
    18b4:	83 ec 04             	sub    $0x4,%esp
    18b7:	50                   	push   %eax
    18b8:	68 ba 1a 00 00       	push   $0x1aba
    18bd:	6a 01                	push   $0x1
    18bf:	e8 40 f7 ff ff       	call   1004 <printf>
    18c4:	83 c4 10             	add    $0x10,%esp
            return &current_group;
    18c7:	b8 ac 1f 00 00       	mov    $0x1fac,%eax
    18cc:	eb 13                	jmp    18e1 <cek_nama_group+0x60>
    while (getgroup()){
    18ce:	e8 c6 fe ff ff       	call   1799 <getgroup>
    18d3:	85 c0                	test   %eax,%eax
    18d5:	75 bb                	jne    1892 <cek_nama_group+0x11>
        }
    }
    endgroup();
    18d7:	e8 74 ff ff ff       	call   1850 <endgroup>
    return 0;
    18dc:	b8 00 00 00 00       	mov    $0x0,%eax
}
    18e1:	c9                   	leave  
    18e2:	c3                   	ret    

000018e3 <cek_gid>:

// cek apakah uid ada di IDS_FILE
struct group_struct* cek_gid(gid_t gid){
    18e3:	f3 0f 1e fb          	endbr32 
    18e7:	55                   	push   %ebp
    18e8:	89 e5                	mov    %esp,%ebp
    18ea:	83 ec 08             	sub    $0x8,%esp
    setgroup();
    18ed:	e8 03 ff ff ff       	call   17f5 <setgroup>

    while (getgroup()){
    18f2:	eb 16                	jmp    190a <cek_gid+0x27>
        if(current_group.gid == gid){
    18f4:	a1 b0 1f 00 00       	mov    0x1fb0,%eax
    18f9:	39 45 08             	cmp    %eax,0x8(%ebp)
    18fc:	75 0c                	jne    190a <cek_gid+0x27>
            endgroup();
    18fe:	e8 4d ff ff ff       	call   1850 <endgroup>
            return &current_group;
    1903:	b8 ac 1f 00 00       	mov    $0x1fac,%eax
    1908:	eb 13                	jmp    191d <cek_gid+0x3a>
    while (getgroup()){
    190a:	e8 8a fe ff ff       	call   1799 <getgroup>
    190f:	85 c0                	test   %eax,%eax
    1911:	75 e1                	jne    18f4 <cek_gid+0x11>
        }
    }
    endgroup();
    1913:	e8 38 ff ff ff       	call   1850 <endgroup>
    return 0;
    1918:	b8 00 00 00 00       	mov    $0x0,%eax
}
    191d:	c9                   	leave  
    191e:	c3                   	ret    
