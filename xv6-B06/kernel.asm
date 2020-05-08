
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 d0 10 00       	mov    $0x10d000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 70 f6 10 80       	mov    $0x8010f670,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 3d 3c 10 80       	mov    $0x80103c3d,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	f3 0f 1e fb          	endbr32 
80100038:	55                   	push   %ebp
80100039:	89 e5                	mov    %esp,%ebp
8010003b:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003e:	83 ec 08             	sub    $0x8,%esp
80100041:	68 08 a5 10 80       	push   $0x8010a508
80100046:	68 80 f6 10 80       	push   $0x8010f680
8010004b:	e8 99 6b 00 00       	call   80106be9 <initlock>
80100050:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100053:	c7 05 90 35 11 80 84 	movl   $0x80113584,0x80113590
8010005a:	35 11 80 
  bcache.head.next = &bcache.head;
8010005d:	c7 05 94 35 11 80 84 	movl   $0x80113584,0x80113594
80100064:	35 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100067:	c7 45 f4 b4 f6 10 80 	movl   $0x8010f6b4,-0xc(%ebp)
8010006e:	eb 3a                	jmp    801000aa <binit+0x76>
    b->next = bcache.head.next;
80100070:	8b 15 94 35 11 80    	mov    0x80113594,%edx
80100076:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100079:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
8010007c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007f:	c7 40 0c 84 35 11 80 	movl   $0x80113584,0xc(%eax)
    b->dev = -1;
80100086:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100089:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
80100090:	a1 94 35 11 80       	mov    0x80113594,%eax
80100095:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100098:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
8010009b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009e:	a3 94 35 11 80       	mov    %eax,0x80113594
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a3:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000aa:	b8 84 35 11 80       	mov    $0x80113584,%eax
801000af:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000b2:	72 bc                	jb     80100070 <binit+0x3c>
  }
}
801000b4:	90                   	nop
801000b5:	90                   	nop
801000b6:	c9                   	leave  
801000b7:	c3                   	ret    

801000b8 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000b8:	f3 0f 1e fb          	endbr32 
801000bc:	55                   	push   %ebp
801000bd:	89 e5                	mov    %esp,%ebp
801000bf:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000c2:	83 ec 0c             	sub    $0xc,%esp
801000c5:	68 80 f6 10 80       	push   $0x8010f680
801000ca:	e8 40 6b 00 00       	call   80106c0f <acquire>
801000cf:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000d2:	a1 94 35 11 80       	mov    0x80113594,%eax
801000d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000da:	eb 67                	jmp    80100143 <bget+0x8b>
    if(b->dev == dev && b->blockno == blockno){
801000dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000df:	8b 40 04             	mov    0x4(%eax),%eax
801000e2:	39 45 08             	cmp    %eax,0x8(%ebp)
801000e5:	75 53                	jne    8010013a <bget+0x82>
801000e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ea:	8b 40 08             	mov    0x8(%eax),%eax
801000ed:	39 45 0c             	cmp    %eax,0xc(%ebp)
801000f0:	75 48                	jne    8010013a <bget+0x82>
      if(!(b->flags & B_BUSY)){
801000f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f5:	8b 00                	mov    (%eax),%eax
801000f7:	83 e0 01             	and    $0x1,%eax
801000fa:	85 c0                	test   %eax,%eax
801000fc:	75 27                	jne    80100125 <bget+0x6d>
        b->flags |= B_BUSY;
801000fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100101:	8b 00                	mov    (%eax),%eax
80100103:	83 c8 01             	or     $0x1,%eax
80100106:	89 c2                	mov    %eax,%edx
80100108:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010b:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
8010010d:	83 ec 0c             	sub    $0xc,%esp
80100110:	68 80 f6 10 80       	push   $0x8010f680
80100115:	e8 60 6b 00 00       	call   80106c7a <release>
8010011a:	83 c4 10             	add    $0x10,%esp
        return b;
8010011d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100120:	e9 98 00 00 00       	jmp    801001bd <bget+0x105>
      }
      sleep(b, &bcache.lock);
80100125:	83 ec 08             	sub    $0x8,%esp
80100128:	68 80 f6 10 80       	push   $0x8010f680
8010012d:	ff 75 f4             	pushl  -0xc(%ebp)
80100130:	e8 d9 57 00 00       	call   8010590e <sleep>
80100135:	83 c4 10             	add    $0x10,%esp
      goto loop;
80100138:	eb 98                	jmp    801000d2 <bget+0x1a>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
8010013a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010013d:	8b 40 10             	mov    0x10(%eax),%eax
80100140:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100143:	81 7d f4 84 35 11 80 	cmpl   $0x80113584,-0xc(%ebp)
8010014a:	75 90                	jne    801000dc <bget+0x24>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
8010014c:	a1 90 35 11 80       	mov    0x80113590,%eax
80100151:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100154:	eb 51                	jmp    801001a7 <bget+0xef>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
80100156:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100159:	8b 00                	mov    (%eax),%eax
8010015b:	83 e0 01             	and    $0x1,%eax
8010015e:	85 c0                	test   %eax,%eax
80100160:	75 3c                	jne    8010019e <bget+0xe6>
80100162:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100165:	8b 00                	mov    (%eax),%eax
80100167:	83 e0 04             	and    $0x4,%eax
8010016a:	85 c0                	test   %eax,%eax
8010016c:	75 30                	jne    8010019e <bget+0xe6>
      b->dev = dev;
8010016e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100171:	8b 55 08             	mov    0x8(%ebp),%edx
80100174:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
80100177:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010017d:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100180:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100183:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100189:	83 ec 0c             	sub    $0xc,%esp
8010018c:	68 80 f6 10 80       	push   $0x8010f680
80100191:	e8 e4 6a 00 00       	call   80106c7a <release>
80100196:	83 c4 10             	add    $0x10,%esp
      return b;
80100199:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010019c:	eb 1f                	jmp    801001bd <bget+0x105>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
8010019e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001a1:	8b 40 0c             	mov    0xc(%eax),%eax
801001a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001a7:	81 7d f4 84 35 11 80 	cmpl   $0x80113584,-0xc(%ebp)
801001ae:	75 a6                	jne    80100156 <bget+0x9e>
    }
  }
  panic("bget: no buffers");
801001b0:	83 ec 0c             	sub    $0xc,%esp
801001b3:	68 0f a5 10 80       	push   $0x8010a50f
801001b8:	e8 da 03 00 00       	call   80100597 <panic>
}
801001bd:	c9                   	leave  
801001be:	c3                   	ret    

801001bf <bread>:

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801001bf:	f3 0f 1e fb          	endbr32 
801001c3:	55                   	push   %ebp
801001c4:	89 e5                	mov    %esp,%ebp
801001c6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
801001c9:	83 ec 08             	sub    $0x8,%esp
801001cc:	ff 75 0c             	pushl  0xc(%ebp)
801001cf:	ff 75 08             	pushl  0x8(%ebp)
801001d2:	e8 e1 fe ff ff       	call   801000b8 <bget>
801001d7:	83 c4 10             	add    $0x10,%esp
801001da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID)) {
801001dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001e0:	8b 00                	mov    (%eax),%eax
801001e2:	83 e0 02             	and    $0x2,%eax
801001e5:	85 c0                	test   %eax,%eax
801001e7:	75 0e                	jne    801001f7 <bread+0x38>
    iderw(b);
801001e9:	83 ec 0c             	sub    $0xc,%esp
801001ec:	ff 75 f4             	pushl  -0xc(%ebp)
801001ef:	e8 4e 2a 00 00       	call   80102c42 <iderw>
801001f4:	83 c4 10             	add    $0x10,%esp
  }
  return b;
801001f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001fa:	c9                   	leave  
801001fb:	c3                   	ret    

801001fc <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001fc:	f3 0f 1e fb          	endbr32 
80100200:	55                   	push   %ebp
80100201:	89 e5                	mov    %esp,%ebp
80100203:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100206:	8b 45 08             	mov    0x8(%ebp),%eax
80100209:	8b 00                	mov    (%eax),%eax
8010020b:	83 e0 01             	and    $0x1,%eax
8010020e:	85 c0                	test   %eax,%eax
80100210:	75 0d                	jne    8010021f <bwrite+0x23>
    panic("bwrite");
80100212:	83 ec 0c             	sub    $0xc,%esp
80100215:	68 20 a5 10 80       	push   $0x8010a520
8010021a:	e8 78 03 00 00       	call   80100597 <panic>
  b->flags |= B_DIRTY;
8010021f:	8b 45 08             	mov    0x8(%ebp),%eax
80100222:	8b 00                	mov    (%eax),%eax
80100224:	83 c8 04             	or     $0x4,%eax
80100227:	89 c2                	mov    %eax,%edx
80100229:	8b 45 08             	mov    0x8(%ebp),%eax
8010022c:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010022e:	83 ec 0c             	sub    $0xc,%esp
80100231:	ff 75 08             	pushl  0x8(%ebp)
80100234:	e8 09 2a 00 00       	call   80102c42 <iderw>
80100239:	83 c4 10             	add    $0x10,%esp
}
8010023c:	90                   	nop
8010023d:	c9                   	leave  
8010023e:	c3                   	ret    

8010023f <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010023f:	f3 0f 1e fb          	endbr32 
80100243:	55                   	push   %ebp
80100244:	89 e5                	mov    %esp,%ebp
80100246:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100249:	8b 45 08             	mov    0x8(%ebp),%eax
8010024c:	8b 00                	mov    (%eax),%eax
8010024e:	83 e0 01             	and    $0x1,%eax
80100251:	85 c0                	test   %eax,%eax
80100253:	75 0d                	jne    80100262 <brelse+0x23>
    panic("brelse");
80100255:	83 ec 0c             	sub    $0xc,%esp
80100258:	68 27 a5 10 80       	push   $0x8010a527
8010025d:	e8 35 03 00 00       	call   80100597 <panic>

  acquire(&bcache.lock);
80100262:	83 ec 0c             	sub    $0xc,%esp
80100265:	68 80 f6 10 80       	push   $0x8010f680
8010026a:	e8 a0 69 00 00       	call   80106c0f <acquire>
8010026f:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
80100272:	8b 45 08             	mov    0x8(%ebp),%eax
80100275:	8b 40 10             	mov    0x10(%eax),%eax
80100278:	8b 55 08             	mov    0x8(%ebp),%edx
8010027b:	8b 52 0c             	mov    0xc(%edx),%edx
8010027e:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100281:	8b 45 08             	mov    0x8(%ebp),%eax
80100284:	8b 40 0c             	mov    0xc(%eax),%eax
80100287:	8b 55 08             	mov    0x8(%ebp),%edx
8010028a:	8b 52 10             	mov    0x10(%edx),%edx
8010028d:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
80100290:	8b 15 94 35 11 80    	mov    0x80113594,%edx
80100296:	8b 45 08             	mov    0x8(%ebp),%eax
80100299:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
8010029c:	8b 45 08             	mov    0x8(%ebp),%eax
8010029f:	c7 40 0c 84 35 11 80 	movl   $0x80113584,0xc(%eax)
  bcache.head.next->prev = b;
801002a6:	a1 94 35 11 80       	mov    0x80113594,%eax
801002ab:	8b 55 08             	mov    0x8(%ebp),%edx
801002ae:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
801002b1:	8b 45 08             	mov    0x8(%ebp),%eax
801002b4:	a3 94 35 11 80       	mov    %eax,0x80113594

  b->flags &= ~B_BUSY;
801002b9:	8b 45 08             	mov    0x8(%ebp),%eax
801002bc:	8b 00                	mov    (%eax),%eax
801002be:	83 e0 fe             	and    $0xfffffffe,%eax
801002c1:	89 c2                	mov    %eax,%edx
801002c3:	8b 45 08             	mov    0x8(%ebp),%eax
801002c6:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801002c8:	83 ec 0c             	sub    $0xc,%esp
801002cb:	ff 75 08             	pushl  0x8(%ebp)
801002ce:	e8 98 58 00 00       	call   80105b6b <wakeup>
801002d3:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002d6:	83 ec 0c             	sub    $0xc,%esp
801002d9:	68 80 f6 10 80       	push   $0x8010f680
801002de:	e8 97 69 00 00       	call   80106c7a <release>
801002e3:	83 c4 10             	add    $0x10,%esp
}
801002e6:	90                   	nop
801002e7:	c9                   	leave  
801002e8:	c3                   	ret    

801002e9 <inb>:
}


static inline uchar
inb(ushort port)
{
801002e9:	55                   	push   %ebp
801002ea:	89 e5                	mov    %esp,%ebp
801002ec:	83 ec 14             	sub    $0x14,%esp
801002ef:	8b 45 08             	mov    0x8(%ebp),%eax
801002f2:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002f6:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002fa:	89 c2                	mov    %eax,%edx
801002fc:	ec                   	in     (%dx),%al
801002fd:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80100300:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80100304:	c9                   	leave  
80100305:	c3                   	ret    

80100306 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80100306:	55                   	push   %ebp
80100307:	89 e5                	mov    %esp,%ebp
80100309:	83 ec 08             	sub    $0x8,%esp
8010030c:	8b 45 08             	mov    0x8(%ebp),%eax
8010030f:	8b 55 0c             	mov    0xc(%ebp),%edx
80100312:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80100316:	89 d0                	mov    %edx,%eax
80100318:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010031b:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010031f:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80100323:	ee                   	out    %al,(%dx)
}
80100324:	90                   	nop
80100325:	c9                   	leave  
80100326:	c3                   	ret    

80100327 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100327:	55                   	push   %ebp
80100328:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
8010032a:	fa                   	cli    
}
8010032b:	90                   	nop
8010032c:	5d                   	pop    %ebp
8010032d:	c3                   	ret    

8010032e <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010032e:	f3 0f 1e fb          	endbr32 
80100332:	55                   	push   %ebp
80100333:	89 e5                	mov    %esp,%ebp
80100335:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100338:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010033c:	74 1c                	je     8010035a <printint+0x2c>
8010033e:	8b 45 08             	mov    0x8(%ebp),%eax
80100341:	c1 e8 1f             	shr    $0x1f,%eax
80100344:	0f b6 c0             	movzbl %al,%eax
80100347:	89 45 10             	mov    %eax,0x10(%ebp)
8010034a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010034e:	74 0a                	je     8010035a <printint+0x2c>
    x = -xx;
80100350:	8b 45 08             	mov    0x8(%ebp),%eax
80100353:	f7 d8                	neg    %eax
80100355:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100358:	eb 06                	jmp    80100360 <printint+0x32>
  else
    x = xx;
8010035a:	8b 45 08             	mov    0x8(%ebp),%eax
8010035d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100360:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010036a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010036d:	ba 00 00 00 00       	mov    $0x0,%edx
80100372:	f7 f1                	div    %ecx
80100374:	89 d1                	mov    %edx,%ecx
80100376:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100379:	8d 50 01             	lea    0x1(%eax),%edx
8010037c:	89 55 f4             	mov    %edx,-0xc(%ebp)
8010037f:	0f b6 91 04 c0 10 80 	movzbl -0x7fef3ffc(%ecx),%edx
80100386:	88 54 05 e0          	mov    %dl,-0x20(%ebp,%eax,1)
  }while((x /= base) != 0);
8010038a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010038d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100390:	ba 00 00 00 00       	mov    $0x0,%edx
80100395:	f7 f1                	div    %ecx
80100397:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010039a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010039e:	75 c7                	jne    80100367 <printint+0x39>

  if(sign)
801003a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801003a4:	74 2a                	je     801003d0 <printint+0xa2>
    buf[i++] = '-';
801003a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003a9:	8d 50 01             	lea    0x1(%eax),%edx
801003ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
801003af:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
801003b4:	eb 1a                	jmp    801003d0 <printint+0xa2>
    consputc(buf[i]);
801003b6:	8d 55 e0             	lea    -0x20(%ebp),%edx
801003b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003bc:	01 d0                	add    %edx,%eax
801003be:	0f b6 00             	movzbl (%eax),%eax
801003c1:	0f be c0             	movsbl %al,%eax
801003c4:	83 ec 0c             	sub    $0xc,%esp
801003c7:	50                   	push   %eax
801003c8:	e8 06 04 00 00       	call   801007d3 <consputc>
801003cd:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
801003d0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003d8:	79 dc                	jns    801003b6 <printint+0x88>
}
801003da:	90                   	nop
801003db:	90                   	nop
801003dc:	c9                   	leave  
801003dd:	c3                   	ret    

801003de <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003de:	f3 0f 1e fb          	endbr32 
801003e2:	55                   	push   %ebp
801003e3:	89 e5                	mov    %esp,%ebp
801003e5:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003e8:	a1 14 e6 10 80       	mov    0x8010e614,%eax
801003ed:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003f0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003f4:	74 10                	je     80100406 <cprintf+0x28>
    acquire(&cons.lock);
801003f6:	83 ec 0c             	sub    $0xc,%esp
801003f9:	68 e0 e5 10 80       	push   $0x8010e5e0
801003fe:	e8 0c 68 00 00       	call   80106c0f <acquire>
80100403:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
80100406:	8b 45 08             	mov    0x8(%ebp),%eax
80100409:	85 c0                	test   %eax,%eax
8010040b:	75 0d                	jne    8010041a <cprintf+0x3c>
    panic("null fmt");
8010040d:	83 ec 0c             	sub    $0xc,%esp
80100410:	68 30 a5 10 80       	push   $0x8010a530
80100415:	e8 7d 01 00 00       	call   80100597 <panic>

  argp = (uint*)(void*)(&fmt + 1);
8010041a:	8d 45 0c             	lea    0xc(%ebp),%eax
8010041d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100420:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100427:	e9 2f 01 00 00       	jmp    8010055b <cprintf+0x17d>
    if(c != '%'){
8010042c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100430:	74 13                	je     80100445 <cprintf+0x67>
      consputc(c);
80100432:	83 ec 0c             	sub    $0xc,%esp
80100435:	ff 75 e4             	pushl  -0x1c(%ebp)
80100438:	e8 96 03 00 00       	call   801007d3 <consputc>
8010043d:	83 c4 10             	add    $0x10,%esp
      continue;
80100440:	e9 12 01 00 00       	jmp    80100557 <cprintf+0x179>
    }
    c = fmt[++i] & 0xff;
80100445:	8b 55 08             	mov    0x8(%ebp),%edx
80100448:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010044c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010044f:	01 d0                	add    %edx,%eax
80100451:	0f b6 00             	movzbl (%eax),%eax
80100454:	0f be c0             	movsbl %al,%eax
80100457:	25 ff 00 00 00       	and    $0xff,%eax
8010045c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010045f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100463:	0f 84 14 01 00 00    	je     8010057d <cprintf+0x19f>
      break;
    switch(c){
80100469:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
8010046d:	74 5e                	je     801004cd <cprintf+0xef>
8010046f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
80100473:	0f 8f c2 00 00 00    	jg     8010053b <cprintf+0x15d>
80100479:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
8010047d:	74 6b                	je     801004ea <cprintf+0x10c>
8010047f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
80100483:	0f 8f b2 00 00 00    	jg     8010053b <cprintf+0x15d>
80100489:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
8010048d:	74 3e                	je     801004cd <cprintf+0xef>
8010048f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
80100493:	0f 8f a2 00 00 00    	jg     8010053b <cprintf+0x15d>
80100499:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
8010049d:	0f 84 89 00 00 00    	je     8010052c <cprintf+0x14e>
801004a3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
801004a7:	0f 85 8e 00 00 00    	jne    8010053b <cprintf+0x15d>
    case 'd':
      printint(*argp++, 10, 1);
801004ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004b0:	8d 50 04             	lea    0x4(%eax),%edx
801004b3:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004b6:	8b 00                	mov    (%eax),%eax
801004b8:	83 ec 04             	sub    $0x4,%esp
801004bb:	6a 01                	push   $0x1
801004bd:	6a 0a                	push   $0xa
801004bf:	50                   	push   %eax
801004c0:	e8 69 fe ff ff       	call   8010032e <printint>
801004c5:	83 c4 10             	add    $0x10,%esp
      break;
801004c8:	e9 8a 00 00 00       	jmp    80100557 <cprintf+0x179>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801004cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004d0:	8d 50 04             	lea    0x4(%eax),%edx
801004d3:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004d6:	8b 00                	mov    (%eax),%eax
801004d8:	83 ec 04             	sub    $0x4,%esp
801004db:	6a 00                	push   $0x0
801004dd:	6a 10                	push   $0x10
801004df:	50                   	push   %eax
801004e0:	e8 49 fe ff ff       	call   8010032e <printint>
801004e5:	83 c4 10             	add    $0x10,%esp
      break;
801004e8:	eb 6d                	jmp    80100557 <cprintf+0x179>
    case 's':
      if((s = (char*)*argp++) == 0)
801004ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004ed:	8d 50 04             	lea    0x4(%eax),%edx
801004f0:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004f3:	8b 00                	mov    (%eax),%eax
801004f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004f8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004fc:	75 22                	jne    80100520 <cprintf+0x142>
        s = "(null)";
801004fe:	c7 45 ec 39 a5 10 80 	movl   $0x8010a539,-0x14(%ebp)
      for(; *s; s++)
80100505:	eb 19                	jmp    80100520 <cprintf+0x142>
        consputc(*s);
80100507:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010050a:	0f b6 00             	movzbl (%eax),%eax
8010050d:	0f be c0             	movsbl %al,%eax
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	50                   	push   %eax
80100514:	e8 ba 02 00 00       	call   801007d3 <consputc>
80100519:	83 c4 10             	add    $0x10,%esp
      for(; *s; s++)
8010051c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100520:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100523:	0f b6 00             	movzbl (%eax),%eax
80100526:	84 c0                	test   %al,%al
80100528:	75 dd                	jne    80100507 <cprintf+0x129>
      break;
8010052a:	eb 2b                	jmp    80100557 <cprintf+0x179>
    case '%':
      consputc('%');
8010052c:	83 ec 0c             	sub    $0xc,%esp
8010052f:	6a 25                	push   $0x25
80100531:	e8 9d 02 00 00       	call   801007d3 <consputc>
80100536:	83 c4 10             	add    $0x10,%esp
      break;
80100539:	eb 1c                	jmp    80100557 <cprintf+0x179>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
8010053b:	83 ec 0c             	sub    $0xc,%esp
8010053e:	6a 25                	push   $0x25
80100540:	e8 8e 02 00 00       	call   801007d3 <consputc>
80100545:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100548:	83 ec 0c             	sub    $0xc,%esp
8010054b:	ff 75 e4             	pushl  -0x1c(%ebp)
8010054e:	e8 80 02 00 00       	call   801007d3 <consputc>
80100553:	83 c4 10             	add    $0x10,%esp
      break;
80100556:	90                   	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100557:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010055b:	8b 55 08             	mov    0x8(%ebp),%edx
8010055e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100561:	01 d0                	add    %edx,%eax
80100563:	0f b6 00             	movzbl (%eax),%eax
80100566:	0f be c0             	movsbl %al,%eax
80100569:	25 ff 00 00 00       	and    $0xff,%eax
8010056e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100571:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100575:	0f 85 b1 fe ff ff    	jne    8010042c <cprintf+0x4e>
8010057b:	eb 01                	jmp    8010057e <cprintf+0x1a0>
      break;
8010057d:	90                   	nop
    }
  }

  if(locking)
8010057e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100582:	74 10                	je     80100594 <cprintf+0x1b6>
    release(&cons.lock);
80100584:	83 ec 0c             	sub    $0xc,%esp
80100587:	68 e0 e5 10 80       	push   $0x8010e5e0
8010058c:	e8 e9 66 00 00       	call   80106c7a <release>
80100591:	83 c4 10             	add    $0x10,%esp
}
80100594:	90                   	nop
80100595:	c9                   	leave  
80100596:	c3                   	ret    

80100597 <panic>:

void
panic(char *s)
{
80100597:	f3 0f 1e fb          	endbr32 
8010059b:	55                   	push   %ebp
8010059c:	89 e5                	mov    %esp,%ebp
8010059e:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
801005a1:	e8 81 fd ff ff       	call   80100327 <cli>
  cons.locking = 0;
801005a6:	c7 05 14 e6 10 80 00 	movl   $0x0,0x8010e614
801005ad:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
801005b0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801005b6:	0f b6 00             	movzbl (%eax),%eax
801005b9:	0f b6 c0             	movzbl %al,%eax
801005bc:	83 ec 08             	sub    $0x8,%esp
801005bf:	50                   	push   %eax
801005c0:	68 40 a5 10 80       	push   $0x8010a540
801005c5:	e8 14 fe ff ff       	call   801003de <cprintf>
801005ca:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
801005cd:	8b 45 08             	mov    0x8(%ebp),%eax
801005d0:	83 ec 0c             	sub    $0xc,%esp
801005d3:	50                   	push   %eax
801005d4:	e8 05 fe ff ff       	call   801003de <cprintf>
801005d9:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005dc:	83 ec 0c             	sub    $0xc,%esp
801005df:	68 4f a5 10 80       	push   $0x8010a54f
801005e4:	e8 f5 fd ff ff       	call   801003de <cprintf>
801005e9:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005ec:	83 ec 08             	sub    $0x8,%esp
801005ef:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005f2:	50                   	push   %eax
801005f3:	8d 45 08             	lea    0x8(%ebp),%eax
801005f6:	50                   	push   %eax
801005f7:	e8 d4 66 00 00       	call   80106cd0 <getcallerpcs>
801005fc:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100606:	eb 1c                	jmp    80100624 <panic+0x8d>
    cprintf(" %p", pcs[i]);
80100608:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010060b:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
8010060f:	83 ec 08             	sub    $0x8,%esp
80100612:	50                   	push   %eax
80100613:	68 51 a5 10 80       	push   $0x8010a551
80100618:	e8 c1 fd ff ff       	call   801003de <cprintf>
8010061d:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100620:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100624:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80100628:	7e de                	jle    80100608 <panic+0x71>
  panicked = 1; // freeze other CPU
8010062a:	c7 05 c0 e5 10 80 01 	movl   $0x1,0x8010e5c0
80100631:	00 00 00 
  for(;;)
80100634:	eb fe                	jmp    80100634 <panic+0x9d>

80100636 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
80100636:	f3 0f 1e fb          	endbr32 
8010063a:	55                   	push   %ebp
8010063b:	89 e5                	mov    %esp,%ebp
8010063d:	53                   	push   %ebx
8010063e:	83 ec 14             	sub    $0x14,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100641:	6a 0e                	push   $0xe
80100643:	68 d4 03 00 00       	push   $0x3d4
80100648:	e8 b9 fc ff ff       	call   80100306 <outb>
8010064d:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100650:	68 d5 03 00 00       	push   $0x3d5
80100655:	e8 8f fc ff ff       	call   801002e9 <inb>
8010065a:	83 c4 04             	add    $0x4,%esp
8010065d:	0f b6 c0             	movzbl %al,%eax
80100660:	c1 e0 08             	shl    $0x8,%eax
80100663:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100666:	6a 0f                	push   $0xf
80100668:	68 d4 03 00 00       	push   $0x3d4
8010066d:	e8 94 fc ff ff       	call   80100306 <outb>
80100672:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100675:	68 d5 03 00 00       	push   $0x3d5
8010067a:	e8 6a fc ff ff       	call   801002e9 <inb>
8010067f:	83 c4 04             	add    $0x4,%esp
80100682:	0f b6 c0             	movzbl %al,%eax
80100685:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100688:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010068c:	75 30                	jne    801006be <cgaputc+0x88>
    pos += 80 - pos%80;
8010068e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100691:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100696:	89 c8                	mov    %ecx,%eax
80100698:	f7 ea                	imul   %edx
8010069a:	c1 fa 05             	sar    $0x5,%edx
8010069d:	89 c8                	mov    %ecx,%eax
8010069f:	c1 f8 1f             	sar    $0x1f,%eax
801006a2:	29 c2                	sub    %eax,%edx
801006a4:	89 d0                	mov    %edx,%eax
801006a6:	c1 e0 02             	shl    $0x2,%eax
801006a9:	01 d0                	add    %edx,%eax
801006ab:	c1 e0 04             	shl    $0x4,%eax
801006ae:	29 c1                	sub    %eax,%ecx
801006b0:	89 ca                	mov    %ecx,%edx
801006b2:	b8 50 00 00 00       	mov    $0x50,%eax
801006b7:	29 d0                	sub    %edx,%eax
801006b9:	01 45 f4             	add    %eax,-0xc(%ebp)
801006bc:	eb 38                	jmp    801006f6 <cgaputc+0xc0>
  else if(c == BACKSPACE){
801006be:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801006c5:	75 0c                	jne    801006d3 <cgaputc+0x9d>
    if(pos > 0) --pos;
801006c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006cb:	7e 29                	jle    801006f6 <cgaputc+0xc0>
801006cd:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801006d1:	eb 23                	jmp    801006f6 <cgaputc+0xc0>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801006d3:	8b 45 08             	mov    0x8(%ebp),%eax
801006d6:	0f b6 c0             	movzbl %al,%eax
801006d9:	80 cc 07             	or     $0x7,%ah
801006dc:	89 c3                	mov    %eax,%ebx
801006de:	8b 0d 00 c0 10 80    	mov    0x8010c000,%ecx
801006e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006e7:	8d 50 01             	lea    0x1(%eax),%edx
801006ea:	89 55 f4             	mov    %edx,-0xc(%ebp)
801006ed:	01 c0                	add    %eax,%eax
801006ef:	01 c8                	add    %ecx,%eax
801006f1:	89 da                	mov    %ebx,%edx
801006f3:	66 89 10             	mov    %dx,(%eax)

  if(pos < 0 || pos > 25*80)
801006f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006fa:	78 09                	js     80100705 <cgaputc+0xcf>
801006fc:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
80100703:	7e 0d                	jle    80100712 <cgaputc+0xdc>
    panic("pos under/overflow");
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 55 a5 10 80       	push   $0x8010a555
8010070d:	e8 85 fe ff ff       	call   80100597 <panic>
  
  if((pos/80) >= 24){  // Scroll up.
80100712:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
80100719:	7e 4c                	jle    80100767 <cgaputc+0x131>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010071b:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80100720:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
80100726:	a1 00 c0 10 80       	mov    0x8010c000,%eax
8010072b:	83 ec 04             	sub    $0x4,%esp
8010072e:	68 60 0e 00 00       	push   $0xe60
80100733:	52                   	push   %edx
80100734:	50                   	push   %eax
80100735:	e8 18 68 00 00       	call   80106f52 <memmove>
8010073a:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
8010073d:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100741:	b8 80 07 00 00       	mov    $0x780,%eax
80100746:	2b 45 f4             	sub    -0xc(%ebp),%eax
80100749:	8d 14 00             	lea    (%eax,%eax,1),%edx
8010074c:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80100751:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100754:	01 c9                	add    %ecx,%ecx
80100756:	01 c8                	add    %ecx,%eax
80100758:	83 ec 04             	sub    $0x4,%esp
8010075b:	52                   	push   %edx
8010075c:	6a 00                	push   $0x0
8010075e:	50                   	push   %eax
8010075f:	e8 27 67 00 00       	call   80106e8b <memset>
80100764:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
80100767:	83 ec 08             	sub    $0x8,%esp
8010076a:	6a 0e                	push   $0xe
8010076c:	68 d4 03 00 00       	push   $0x3d4
80100771:	e8 90 fb ff ff       	call   80100306 <outb>
80100776:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
80100779:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010077c:	c1 f8 08             	sar    $0x8,%eax
8010077f:	0f b6 c0             	movzbl %al,%eax
80100782:	83 ec 08             	sub    $0x8,%esp
80100785:	50                   	push   %eax
80100786:	68 d5 03 00 00       	push   $0x3d5
8010078b:	e8 76 fb ff ff       	call   80100306 <outb>
80100790:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
80100793:	83 ec 08             	sub    $0x8,%esp
80100796:	6a 0f                	push   $0xf
80100798:	68 d4 03 00 00       	push   $0x3d4
8010079d:	e8 64 fb ff ff       	call   80100306 <outb>
801007a2:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
801007a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007a8:	0f b6 c0             	movzbl %al,%eax
801007ab:	83 ec 08             	sub    $0x8,%esp
801007ae:	50                   	push   %eax
801007af:	68 d5 03 00 00       	push   $0x3d5
801007b4:	e8 4d fb ff ff       	call   80100306 <outb>
801007b9:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
801007bc:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801007c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801007c4:	01 d2                	add    %edx,%edx
801007c6:	01 d0                	add    %edx,%eax
801007c8:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
801007cd:	90                   	nop
801007ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801007d1:	c9                   	leave  
801007d2:	c3                   	ret    

801007d3 <consputc>:

void
consputc(int c)
{
801007d3:	f3 0f 1e fb          	endbr32 
801007d7:	55                   	push   %ebp
801007d8:	89 e5                	mov    %esp,%ebp
801007da:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
801007dd:	a1 c0 e5 10 80       	mov    0x8010e5c0,%eax
801007e2:	85 c0                	test   %eax,%eax
801007e4:	74 07                	je     801007ed <consputc+0x1a>
    cli();
801007e6:	e8 3c fb ff ff       	call   80100327 <cli>
    for(;;)
801007eb:	eb fe                	jmp    801007eb <consputc+0x18>
      ;
  }

  if(c == BACKSPACE){
801007ed:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801007f4:	75 29                	jne    8010081f <consputc+0x4c>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801007f6:	83 ec 0c             	sub    $0xc,%esp
801007f9:	6a 08                	push   $0x8
801007fb:	e8 45 83 00 00       	call   80108b45 <uartputc>
80100800:	83 c4 10             	add    $0x10,%esp
80100803:	83 ec 0c             	sub    $0xc,%esp
80100806:	6a 20                	push   $0x20
80100808:	e8 38 83 00 00       	call   80108b45 <uartputc>
8010080d:	83 c4 10             	add    $0x10,%esp
80100810:	83 ec 0c             	sub    $0xc,%esp
80100813:	6a 08                	push   $0x8
80100815:	e8 2b 83 00 00       	call   80108b45 <uartputc>
8010081a:	83 c4 10             	add    $0x10,%esp
8010081d:	eb 0e                	jmp    8010082d <consputc+0x5a>
  } else
    uartputc(c);
8010081f:	83 ec 0c             	sub    $0xc,%esp
80100822:	ff 75 08             	pushl  0x8(%ebp)
80100825:	e8 1b 83 00 00       	call   80108b45 <uartputc>
8010082a:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
8010082d:	83 ec 0c             	sub    $0xc,%esp
80100830:	ff 75 08             	pushl  0x8(%ebp)
80100833:	e8 fe fd ff ff       	call   80100636 <cgaputc>
80100838:	83 c4 10             	add    $0x10,%esp
}
8010083b:	90                   	nop
8010083c:	c9                   	leave  
8010083d:	c3                   	ret    

8010083e <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
8010083e:	f3 0f 1e fb          	endbr32 
80100842:	55                   	push   %ebp
80100843:	89 e5                	mov    %esp,%ebp
80100845:	83 ec 18             	sub    $0x18,%esp
  int c, doprocdump = 0;
80100848:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
#ifdef BAGIAN_INODE
  int ctrlkey = 0; // 1-4, depending on what list to show
8010084f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
#endif

  acquire(&cons.lock);
80100856:	83 ec 0c             	sub    $0xc,%esp
80100859:	68 e0 e5 10 80       	push   $0x8010e5e0
8010085e:	e8 ac 63 00 00       	call   80106c0f <acquire>
80100863:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
80100866:	e9 82 01 00 00       	jmp    801009ed <consoleintr+0x1af>
    switch(c){
8010086b:	83 7d ec 1a          	cmpl   $0x1a,-0x14(%ebp)
8010086f:	7f 23                	jg     80100894 <consoleintr+0x56>
80100871:	83 7d ec 06          	cmpl   $0x6,-0x14(%ebp)
80100875:	0f 8c e0 00 00 00    	jl     8010095b <consoleintr+0x11d>
8010087b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010087e:	83 e8 06             	sub    $0x6,%eax
80100881:	83 f8 14             	cmp    $0x14,%eax
80100884:	0f 87 d1 00 00 00    	ja     8010095b <consoleintr+0x11d>
8010088a:	8b 04 85 68 a5 10 80 	mov    -0x7fef5a98(,%eax,4),%eax
80100891:	3e ff e0             	notrack jmp *%eax
80100894:	83 7d ec 7f          	cmpl   $0x7f,-0x14(%ebp)
80100898:	74 5c                	je     801008f6 <consoleintr+0xb8>
8010089a:	e9 bc 00 00 00       	jmp    8010095b <consoleintr+0x11d>
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
8010089f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
801008a6:	e9 42 01 00 00       	jmp    801009ed <consoleintr+0x1af>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801008ab:	a1 28 38 11 80       	mov    0x80113828,%eax
801008b0:	83 e8 01             	sub    $0x1,%eax
801008b3:	a3 28 38 11 80       	mov    %eax,0x80113828
        consputc(BACKSPACE);
801008b8:	83 ec 0c             	sub    $0xc,%esp
801008bb:	68 00 01 00 00       	push   $0x100
801008c0:	e8 0e ff ff ff       	call   801007d3 <consputc>
801008c5:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
801008c8:	8b 15 28 38 11 80    	mov    0x80113828,%edx
801008ce:	a1 24 38 11 80       	mov    0x80113824,%eax
801008d3:	39 c2                	cmp    %eax,%edx
801008d5:	0f 84 12 01 00 00    	je     801009ed <consoleintr+0x1af>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008db:	a1 28 38 11 80       	mov    0x80113828,%eax
801008e0:	83 e8 01             	sub    $0x1,%eax
801008e3:	83 e0 7f             	and    $0x7f,%eax
801008e6:	0f b6 80 a0 37 11 80 	movzbl -0x7feec860(%eax),%eax
      while(input.e != input.w &&
801008ed:	3c 0a                	cmp    $0xa,%al
801008ef:	75 ba                	jne    801008ab <consoleintr+0x6d>
      }
      break;
801008f1:	e9 f7 00 00 00       	jmp    801009ed <consoleintr+0x1af>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801008f6:	8b 15 28 38 11 80    	mov    0x80113828,%edx
801008fc:	a1 24 38 11 80       	mov    0x80113824,%eax
80100901:	39 c2                	cmp    %eax,%edx
80100903:	0f 84 e4 00 00 00    	je     801009ed <consoleintr+0x1af>
        input.e--;
80100909:	a1 28 38 11 80       	mov    0x80113828,%eax
8010090e:	83 e8 01             	sub    $0x1,%eax
80100911:	a3 28 38 11 80       	mov    %eax,0x80113828
        consputc(BACKSPACE);
80100916:	83 ec 0c             	sub    $0xc,%esp
80100919:	68 00 01 00 00       	push   $0x100
8010091e:	e8 b0 fe ff ff       	call   801007d3 <consputc>
80100923:	83 c4 10             	add    $0x10,%esp
      }
      break;
80100926:	e9 c2 00 00 00       	jmp    801009ed <consoleintr+0x1af>
#ifdef BAGIAN_INODE
    case C('R'):
      ctrlkey = 1;
8010092b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      break;
80100932:	e9 b6 00 00 00       	jmp    801009ed <consoleintr+0x1af>
    case C('F'):
      ctrlkey = 2;
80100937:	c7 45 f0 02 00 00 00 	movl   $0x2,-0x10(%ebp)
      break;
8010093e:	e9 aa 00 00 00       	jmp    801009ed <consoleintr+0x1af>
    case C('S'):
      ctrlkey = 3;
80100943:	c7 45 f0 03 00 00 00 	movl   $0x3,-0x10(%ebp)
      break;
8010094a:	e9 9e 00 00 00       	jmp    801009ed <consoleintr+0x1af>
    case C('Z'):
      ctrlkey = 4;
8010094f:	c7 45 f0 04 00 00 00 	movl   $0x4,-0x10(%ebp)
      break;
80100956:	e9 92 00 00 00       	jmp    801009ed <consoleintr+0x1af>
#endif
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010095b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010095f:	0f 84 87 00 00 00    	je     801009ec <consoleintr+0x1ae>
80100965:	8b 15 28 38 11 80    	mov    0x80113828,%edx
8010096b:	a1 20 38 11 80       	mov    0x80113820,%eax
80100970:	29 c2                	sub    %eax,%edx
80100972:	89 d0                	mov    %edx,%eax
80100974:	83 f8 7f             	cmp    $0x7f,%eax
80100977:	77 73                	ja     801009ec <consoleintr+0x1ae>
        c = (c == '\r') ? '\n' : c;
80100979:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
8010097d:	74 05                	je     80100984 <consoleintr+0x146>
8010097f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100982:	eb 05                	jmp    80100989 <consoleintr+0x14b>
80100984:	b8 0a 00 00 00       	mov    $0xa,%eax
80100989:	89 45 ec             	mov    %eax,-0x14(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
8010098c:	a1 28 38 11 80       	mov    0x80113828,%eax
80100991:	8d 50 01             	lea    0x1(%eax),%edx
80100994:	89 15 28 38 11 80    	mov    %edx,0x80113828
8010099a:	83 e0 7f             	and    $0x7f,%eax
8010099d:	8b 55 ec             	mov    -0x14(%ebp),%edx
801009a0:	88 90 a0 37 11 80    	mov    %dl,-0x7feec860(%eax)
        consputc(c);
801009a6:	83 ec 0c             	sub    $0xc,%esp
801009a9:	ff 75 ec             	pushl  -0x14(%ebp)
801009ac:	e8 22 fe ff ff       	call   801007d3 <consputc>
801009b1:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009b4:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
801009b8:	74 18                	je     801009d2 <consoleintr+0x194>
801009ba:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
801009be:	74 12                	je     801009d2 <consoleintr+0x194>
801009c0:	a1 28 38 11 80       	mov    0x80113828,%eax
801009c5:	8b 15 20 38 11 80    	mov    0x80113820,%edx
801009cb:	83 ea 80             	sub    $0xffffff80,%edx
801009ce:	39 d0                	cmp    %edx,%eax
801009d0:	75 1a                	jne    801009ec <consoleintr+0x1ae>
          input.w = input.e;
801009d2:	a1 28 38 11 80       	mov    0x80113828,%eax
801009d7:	a3 24 38 11 80       	mov    %eax,0x80113824
          wakeup(&input.r);
801009dc:	83 ec 0c             	sub    $0xc,%esp
801009df:	68 20 38 11 80       	push   $0x80113820
801009e4:	e8 82 51 00 00       	call   80105b6b <wakeup>
801009e9:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
801009ec:	90                   	nop
  while((c = getc()) >= 0){
801009ed:	8b 45 08             	mov    0x8(%ebp),%eax
801009f0:	ff d0                	call   *%eax
801009f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
801009f5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801009f9:	0f 89 6c fe ff ff    	jns    8010086b <consoleintr+0x2d>
    }
  }
  release(&cons.lock);
801009ff:	83 ec 0c             	sub    $0xc,%esp
80100a02:	68 e0 e5 10 80       	push   $0x8010e5e0
80100a07:	e8 6e 62 00 00       	call   80106c7a <release>
80100a0c:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
80100a0f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100a13:	74 05                	je     80100a1a <consoleintr+0x1dc>
    procdump();  // now call procdump() wo. cons.lock held
80100a15:	e8 ed 54 00 00       	call   80105f07 <procdump>
  }
#ifdef BAGIAN_INODE
  // run Ready list display function
  if (ctrlkey == 1) {
80100a1a:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
80100a1e:	75 0c                	jne    80100a2c <consoleintr+0x1ee>
      //cprintf("Ready list not implemented yet..\n");
      printReadyList();
80100a20:	e8 25 5b 00 00       	call   8010654a <printReadyList>
      ctrlkey = 0;
80100a25:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  }
  // run Free list display function
  if (ctrlkey == 2) {
80100a2c:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
80100a30:	75 0c                	jne    80100a3e <consoleintr+0x200>
      printFreeList();
80100a32:	e8 11 5c 00 00       	call   80106648 <printFreeList>
      ctrlkey = 0;
80100a37:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  }
  // run Sleep list display function
  if (ctrlkey == 3) {
80100a3e:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
80100a42:	75 0c                	jne    80100a50 <consoleintr+0x212>
     // cprintf("Sleep list not implemented yet..\n");
      printSleepList();
80100a44:	e8 61 5c 00 00       	call   801066aa <printSleepList>
      ctrlkey = 0;
80100a49:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  }
  // run Zombie list display function
  if (ctrlkey == 4) {
80100a50:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a54:	75 0c                	jne    80100a62 <consoleintr+0x224>
      //cprintf("Zombie list not implemented yet..\n");
      printZombieList();
80100a56:	e8 f0 5c 00 00       	call   8010674b <printZombieList>
      ctrlkey = 0;
80100a5b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  }
#endif
}
80100a62:	90                   	nop
80100a63:	c9                   	leave  
80100a64:	c3                   	ret    

80100a65 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100a65:	f3 0f 1e fb          	endbr32 
80100a69:	55                   	push   %ebp
80100a6a:	89 e5                	mov    %esp,%ebp
80100a6c:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100a6f:	83 ec 0c             	sub    $0xc,%esp
80100a72:	ff 75 08             	pushl  0x8(%ebp)
80100a75:	e8 7c 12 00 00       	call   80101cf6 <iunlock>
80100a7a:	83 c4 10             	add    $0x10,%esp
  target = n;
80100a7d:	8b 45 10             	mov    0x10(%ebp),%eax
80100a80:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
80100a83:	83 ec 0c             	sub    $0xc,%esp
80100a86:	68 e0 e5 10 80       	push   $0x8010e5e0
80100a8b:	e8 7f 61 00 00       	call   80106c0f <acquire>
80100a90:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
80100a93:	e9 ac 00 00 00       	jmp    80100b44 <consoleread+0xdf>
    while(input.r == input.w){
      if(proc->killed){
80100a98:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100a9e:	8b 40 24             	mov    0x24(%eax),%eax
80100aa1:	85 c0                	test   %eax,%eax
80100aa3:	74 28                	je     80100acd <consoleread+0x68>
        release(&cons.lock);
80100aa5:	83 ec 0c             	sub    $0xc,%esp
80100aa8:	68 e0 e5 10 80       	push   $0x8010e5e0
80100aad:	e8 c8 61 00 00       	call   80106c7a <release>
80100ab2:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
80100ab5:	83 ec 0c             	sub    $0xc,%esp
80100ab8:	ff 75 08             	pushl  0x8(%ebp)
80100abb:	e8 b0 10 00 00       	call   80101b70 <ilock>
80100ac0:	83 c4 10             	add    $0x10,%esp
        return -1;
80100ac3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ac8:	e9 ab 00 00 00       	jmp    80100b78 <consoleread+0x113>
      }
      sleep(&input.r, &cons.lock);
80100acd:	83 ec 08             	sub    $0x8,%esp
80100ad0:	68 e0 e5 10 80       	push   $0x8010e5e0
80100ad5:	68 20 38 11 80       	push   $0x80113820
80100ada:	e8 2f 4e 00 00       	call   8010590e <sleep>
80100adf:	83 c4 10             	add    $0x10,%esp
    while(input.r == input.w){
80100ae2:	8b 15 20 38 11 80    	mov    0x80113820,%edx
80100ae8:	a1 24 38 11 80       	mov    0x80113824,%eax
80100aed:	39 c2                	cmp    %eax,%edx
80100aef:	74 a7                	je     80100a98 <consoleread+0x33>
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100af1:	a1 20 38 11 80       	mov    0x80113820,%eax
80100af6:	8d 50 01             	lea    0x1(%eax),%edx
80100af9:	89 15 20 38 11 80    	mov    %edx,0x80113820
80100aff:	83 e0 7f             	and    $0x7f,%eax
80100b02:	0f b6 80 a0 37 11 80 	movzbl -0x7feec860(%eax),%eax
80100b09:	0f be c0             	movsbl %al,%eax
80100b0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100b0f:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100b13:	75 17                	jne    80100b2c <consoleread+0xc7>
      if(n < target){
80100b15:	8b 45 10             	mov    0x10(%ebp),%eax
80100b18:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100b1b:	76 2f                	jbe    80100b4c <consoleread+0xe7>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100b1d:	a1 20 38 11 80       	mov    0x80113820,%eax
80100b22:	83 e8 01             	sub    $0x1,%eax
80100b25:	a3 20 38 11 80       	mov    %eax,0x80113820
      }
      break;
80100b2a:	eb 20                	jmp    80100b4c <consoleread+0xe7>
    }
    *dst++ = c;
80100b2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b2f:	8d 50 01             	lea    0x1(%eax),%edx
80100b32:	89 55 0c             	mov    %edx,0xc(%ebp)
80100b35:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100b38:	88 10                	mov    %dl,(%eax)
    --n;
80100b3a:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100b3e:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100b42:	74 0b                	je     80100b4f <consoleread+0xea>
  while(n > 0){
80100b44:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100b48:	7f 98                	jg     80100ae2 <consoleread+0x7d>
80100b4a:	eb 04                	jmp    80100b50 <consoleread+0xeb>
      break;
80100b4c:	90                   	nop
80100b4d:	eb 01                	jmp    80100b50 <consoleread+0xeb>
      break;
80100b4f:	90                   	nop
  }
  release(&cons.lock);
80100b50:	83 ec 0c             	sub    $0xc,%esp
80100b53:	68 e0 e5 10 80       	push   $0x8010e5e0
80100b58:	e8 1d 61 00 00       	call   80106c7a <release>
80100b5d:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100b60:	83 ec 0c             	sub    $0xc,%esp
80100b63:	ff 75 08             	pushl  0x8(%ebp)
80100b66:	e8 05 10 00 00       	call   80101b70 <ilock>
80100b6b:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100b6e:	8b 45 10             	mov    0x10(%ebp),%eax
80100b71:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100b74:	29 c2                	sub    %eax,%edx
80100b76:	89 d0                	mov    %edx,%eax
}
80100b78:	c9                   	leave  
80100b79:	c3                   	ret    

80100b7a <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100b7a:	f3 0f 1e fb          	endbr32 
80100b7e:	55                   	push   %ebp
80100b7f:	89 e5                	mov    %esp,%ebp
80100b81:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100b84:	83 ec 0c             	sub    $0xc,%esp
80100b87:	ff 75 08             	pushl  0x8(%ebp)
80100b8a:	e8 67 11 00 00       	call   80101cf6 <iunlock>
80100b8f:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100b92:	83 ec 0c             	sub    $0xc,%esp
80100b95:	68 e0 e5 10 80       	push   $0x8010e5e0
80100b9a:	e8 70 60 00 00       	call   80106c0f <acquire>
80100b9f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100ba2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100ba9:	eb 21                	jmp    80100bcc <consolewrite+0x52>
    consputc(buf[i] & 0xff);
80100bab:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100bae:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bb1:	01 d0                	add    %edx,%eax
80100bb3:	0f b6 00             	movzbl (%eax),%eax
80100bb6:	0f be c0             	movsbl %al,%eax
80100bb9:	0f b6 c0             	movzbl %al,%eax
80100bbc:	83 ec 0c             	sub    $0xc,%esp
80100bbf:	50                   	push   %eax
80100bc0:	e8 0e fc ff ff       	call   801007d3 <consputc>
80100bc5:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100bc8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100bcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100bcf:	3b 45 10             	cmp    0x10(%ebp),%eax
80100bd2:	7c d7                	jl     80100bab <consolewrite+0x31>
  release(&cons.lock);
80100bd4:	83 ec 0c             	sub    $0xc,%esp
80100bd7:	68 e0 e5 10 80       	push   $0x8010e5e0
80100bdc:	e8 99 60 00 00       	call   80106c7a <release>
80100be1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100be4:	83 ec 0c             	sub    $0xc,%esp
80100be7:	ff 75 08             	pushl  0x8(%ebp)
80100bea:	e8 81 0f 00 00       	call   80101b70 <ilock>
80100bef:	83 c4 10             	add    $0x10,%esp

  return n;
80100bf2:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100bf5:	c9                   	leave  
80100bf6:	c3                   	ret    

80100bf7 <consoleinit>:

void
consoleinit(void)
{
80100bf7:	f3 0f 1e fb          	endbr32 
80100bfb:	55                   	push   %ebp
80100bfc:	89 e5                	mov    %esp,%ebp
80100bfe:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100c01:	83 ec 08             	sub    $0x8,%esp
80100c04:	68 bc a5 10 80       	push   $0x8010a5bc
80100c09:	68 e0 e5 10 80       	push   $0x8010e5e0
80100c0e:	e8 d6 5f 00 00       	call   80106be9 <initlock>
80100c13:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100c16:	c7 05 ec 41 11 80 7a 	movl   $0x80100b7a,0x801141ec
80100c1d:	0b 10 80 
  devsw[CONSOLE].read = consoleread;
80100c20:	c7 05 e8 41 11 80 65 	movl   $0x80100a65,0x801141e8
80100c27:	0a 10 80 
  cons.locking = 1;
80100c2a:	c7 05 14 e6 10 80 01 	movl   $0x1,0x8010e614
80100c31:	00 00 00 

  picenable(IRQ_KBD);
80100c34:	83 ec 0c             	sub    $0xc,%esp
80100c37:	6a 01                	push   $0x1
80100c39:	e8 e4 36 00 00       	call   80104322 <picenable>
80100c3e:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100c41:	83 ec 08             	sub    $0x8,%esp
80100c44:	6a 00                	push   $0x0
80100c46:	6a 01                	push   $0x1
80100c48:	e8 d2 21 00 00       	call   80102e1f <ioapicenable>
80100c4d:	83 c4 10             	add    $0x10,%esp
}
80100c50:	90                   	nop
80100c51:	c9                   	leave  
80100c52:	c3                   	ret    

80100c53 <exec>:
#include "stat.h"
#endif

int
exec(char *path, char **argv)
{
80100c53:	f3 0f 1e fb          	endbr32 
80100c57:	55                   	push   %ebp
80100c58:	89 e5                	mov    %esp,%ebp
80100c5a:	81 ec 38 01 00 00    	sub    $0x138,%esp
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;


  begin_op();
80100c60:	e8 81 2c 00 00       	call   801038e6 <begin_op>
  if((ip = namei(path)) == 0){
80100c65:	83 ec 0c             	sub    $0xc,%esp
80100c68:	ff 75 08             	pushl  0x8(%ebp)
80100c6b:	e8 43 1b 00 00       	call   801027b3 <namei>
80100c70:	83 c4 10             	add    $0x10,%esp
80100c73:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100c76:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100c7a:	75 0f                	jne    80100c8b <exec+0x38>
    end_op();
80100c7c:	e8 f5 2c 00 00       	call   80103976 <end_op>
    return -1;
80100c81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c86:	e9 66 04 00 00       	jmp    801010f1 <exec+0x49e>
  }
  ilock(ip);
80100c8b:	83 ec 0c             	sub    $0xc,%esp
80100c8e:	ff 75 d8             	pushl  -0x28(%ebp)
80100c91:	e8 da 0e 00 00       	call   80101b70 <ilock>
80100c96:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100c99:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

#ifdef LS_EXEC
  // Check permissions before executing program
  struct stat st;
  stati(ip, &st); // Copy relevant information
80100ca0:	83 ec 08             	sub    $0x8,%esp
80100ca3:	8d 85 cc fe ff ff    	lea    -0x134(%ebp),%eax
80100ca9:	50                   	push   %eax
80100caa:	ff 75 d8             	pushl  -0x28(%ebp)
80100cad:	e8 2f 14 00 00       	call   801020e1 <stati>
80100cb2:	83 c4 10             	add    $0x10,%esp
  if ((st.uid == proc->uid) && (st.mode.flags.u_x)) {
80100cb5:	8b 95 dc fe ff ff    	mov    -0x124(%ebp),%edx
80100cbb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cc1:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80100cc7:	39 c2                	cmp    %eax,%edx
80100cc9:	75 0e                	jne    80100cd9 <exec+0x86>
80100ccb:	0f b6 85 e4 fe ff ff 	movzbl -0x11c(%ebp),%eax
80100cd2:	83 e0 40             	and    $0x40,%eax
80100cd5:	84 c0                	test   %al,%al
80100cd7:	75 38                	jne    80100d11 <exec+0xbe>
      goto good; // User permisson is good, execute
  }
  else if ((st.gid == proc->gid) && (st.mode.flags.g_x)) {
80100cd9:	8b 95 e0 fe ff ff    	mov    -0x120(%ebp),%edx
80100cdf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ce5:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
80100ceb:	39 c2                	cmp    %eax,%edx
80100ced:	75 0e                	jne    80100cfd <exec+0xaa>
80100cef:	0f b6 85 e4 fe ff ff 	movzbl -0x11c(%ebp),%eax
80100cf6:	83 e0 08             	and    $0x8,%eax
80100cf9:	84 c0                	test   %al,%al
80100cfb:	75 17                	jne    80100d14 <exec+0xc1>
      goto good; // Group permission is good, execute
  }
  else if (st.mode.flags.o_x) {
80100cfd:	0f b6 85 e4 fe ff ff 	movzbl -0x11c(%ebp),%eax
80100d04:	83 e0 01             	and    $0x1,%eax
80100d07:	84 c0                	test   %al,%al
80100d09:	0f 84 8e 03 00 00    	je     8010109d <exec+0x44a>
      goto good; // Other permission is good, execute
80100d0f:	eb 04                	jmp    80100d15 <exec+0xc2>
      goto good; // User permisson is good, execute
80100d11:	90                   	nop
80100d12:	eb 01                	jmp    80100d15 <exec+0xc2>
      goto good; // Group permission is good, execute
80100d14:	90                   	nop
// If we have permissions, continue with exec
good:
#endif

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100d15:	6a 34                	push   $0x34
80100d17:	6a 00                	push   $0x0
80100d19:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100d1f:	50                   	push   %eax
80100d20:	ff 75 d8             	pushl  -0x28(%ebp)
80100d23:	e8 27 14 00 00       	call   8010214f <readi>
80100d28:	83 c4 10             	add    $0x10,%esp
80100d2b:	83 f8 33             	cmp    $0x33,%eax
80100d2e:	0f 86 6c 03 00 00    	jbe    801010a0 <exec+0x44d>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100d34:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100d3a:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100d3f:	0f 85 5e 03 00 00    	jne    801010a3 <exec+0x450>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100d45:	e8 68 8f 00 00       	call   80109cb2 <setupkvm>
80100d4a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100d4d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100d51:	0f 84 4f 03 00 00    	je     801010a6 <exec+0x453>
    goto bad;

  // Load program into memory.
  sz = 0;
80100d57:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d5e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100d65:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100d6b:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100d6e:	e9 ab 00 00 00       	jmp    80100e1e <exec+0x1cb>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100d73:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100d76:	6a 20                	push   $0x20
80100d78:	50                   	push   %eax
80100d79:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100d7f:	50                   	push   %eax
80100d80:	ff 75 d8             	pushl  -0x28(%ebp)
80100d83:	e8 c7 13 00 00       	call   8010214f <readi>
80100d88:	83 c4 10             	add    $0x10,%esp
80100d8b:	83 f8 20             	cmp    $0x20,%eax
80100d8e:	0f 85 15 03 00 00    	jne    801010a9 <exec+0x456>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100d94:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100d9a:	83 f8 01             	cmp    $0x1,%eax
80100d9d:	75 71                	jne    80100e10 <exec+0x1bd>
      continue;
    if(ph.memsz < ph.filesz)
80100d9f:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100da5:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100dab:	39 c2                	cmp    %eax,%edx
80100dad:	0f 82 f9 02 00 00    	jb     801010ac <exec+0x459>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100db3:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100db9:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100dbf:	01 d0                	add    %edx,%eax
80100dc1:	83 ec 04             	sub    $0x4,%esp
80100dc4:	50                   	push   %eax
80100dc5:	ff 75 e0             	pushl  -0x20(%ebp)
80100dc8:	ff 75 d4             	pushl  -0x2c(%ebp)
80100dcb:	e8 a2 92 00 00       	call   8010a072 <allocuvm>
80100dd0:	83 c4 10             	add    $0x10,%esp
80100dd3:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100dd6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100dda:	0f 84 cf 02 00 00    	je     801010af <exec+0x45c>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100de0:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100de6:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100dec:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100df2:	83 ec 0c             	sub    $0xc,%esp
80100df5:	52                   	push   %edx
80100df6:	50                   	push   %eax
80100df7:	ff 75 d8             	pushl  -0x28(%ebp)
80100dfa:	51                   	push   %ecx
80100dfb:	ff 75 d4             	pushl  -0x2c(%ebp)
80100dfe:	e8 94 91 00 00       	call   80109f97 <loaduvm>
80100e03:	83 c4 20             	add    $0x20,%esp
80100e06:	85 c0                	test   %eax,%eax
80100e08:	0f 88 a4 02 00 00    	js     801010b2 <exec+0x45f>
80100e0e:	eb 01                	jmp    80100e11 <exec+0x1be>
      continue;
80100e10:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e11:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100e15:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100e18:	83 c0 20             	add    $0x20,%eax
80100e1b:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100e1e:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100e25:	0f b7 c0             	movzwl %ax,%eax
80100e28:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80100e2b:	0f 8c 42 ff ff ff    	jl     80100d73 <exec+0x120>
      goto bad;
  }
  iunlockput(ip);
80100e31:	83 ec 0c             	sub    $0xc,%esp
80100e34:	ff 75 d8             	pushl  -0x28(%ebp)
80100e37:	e8 24 10 00 00       	call   80101e60 <iunlockput>
80100e3c:	83 c4 10             	add    $0x10,%esp
  end_op();
80100e3f:	e8 32 2b 00 00       	call   80103976 <end_op>
  ip = 0;
80100e44:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100e4b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100e4e:	05 ff 0f 00 00       	add    $0xfff,%eax
80100e53:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100e58:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100e5b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100e5e:	05 00 20 00 00       	add    $0x2000,%eax
80100e63:	83 ec 04             	sub    $0x4,%esp
80100e66:	50                   	push   %eax
80100e67:	ff 75 e0             	pushl  -0x20(%ebp)
80100e6a:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e6d:	e8 00 92 00 00       	call   8010a072 <allocuvm>
80100e72:	83 c4 10             	add    $0x10,%esp
80100e75:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100e78:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100e7c:	0f 84 33 02 00 00    	je     801010b5 <exec+0x462>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100e82:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100e85:	2d 00 20 00 00       	sub    $0x2000,%eax
80100e8a:	83 ec 08             	sub    $0x8,%esp
80100e8d:	50                   	push   %eax
80100e8e:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e91:	e8 0c 94 00 00       	call   8010a2a2 <clearpteu>
80100e96:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100e99:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100e9c:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100e9f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100ea6:	e9 96 00 00 00       	jmp    80100f41 <exec+0x2ee>
    if(argc >= MAXARG)
80100eab:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100eaf:	0f 87 03 02 00 00    	ja     801010b8 <exec+0x465>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100eb5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100eb8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ec2:	01 d0                	add    %edx,%eax
80100ec4:	8b 00                	mov    (%eax),%eax
80100ec6:	83 ec 0c             	sub    $0xc,%esp
80100ec9:	50                   	push   %eax
80100eca:	e8 25 62 00 00       	call   801070f4 <strlen>
80100ecf:	83 c4 10             	add    $0x10,%esp
80100ed2:	89 c2                	mov    %eax,%edx
80100ed4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100ed7:	29 d0                	sub    %edx,%eax
80100ed9:	83 e8 01             	sub    $0x1,%eax
80100edc:	83 e0 fc             	and    $0xfffffffc,%eax
80100edf:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ee2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ee5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100eec:	8b 45 0c             	mov    0xc(%ebp),%eax
80100eef:	01 d0                	add    %edx,%eax
80100ef1:	8b 00                	mov    (%eax),%eax
80100ef3:	83 ec 0c             	sub    $0xc,%esp
80100ef6:	50                   	push   %eax
80100ef7:	e8 f8 61 00 00       	call   801070f4 <strlen>
80100efc:	83 c4 10             	add    $0x10,%esp
80100eff:	83 c0 01             	add    $0x1,%eax
80100f02:	89 c1                	mov    %eax,%ecx
80100f04:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f07:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100f0e:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f11:	01 d0                	add    %edx,%eax
80100f13:	8b 00                	mov    (%eax),%eax
80100f15:	51                   	push   %ecx
80100f16:	50                   	push   %eax
80100f17:	ff 75 dc             	pushl  -0x24(%ebp)
80100f1a:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f1d:	e8 42 95 00 00       	call   8010a464 <copyout>
80100f22:	83 c4 10             	add    $0x10,%esp
80100f25:	85 c0                	test   %eax,%eax
80100f27:	0f 88 8e 01 00 00    	js     801010bb <exec+0x468>
      goto bad;
    ustack[3+argc] = sp;
80100f2d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f30:	8d 50 03             	lea    0x3(%eax),%edx
80100f33:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100f36:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
  for(argc = 0; argv[argc]; argc++) {
80100f3d:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100f41:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f44:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100f4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f4e:	01 d0                	add    %edx,%eax
80100f50:	8b 00                	mov    (%eax),%eax
80100f52:	85 c0                	test   %eax,%eax
80100f54:	0f 85 51 ff ff ff    	jne    80100eab <exec+0x258>
  }
  ustack[3+argc] = 0;
80100f5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f5d:	83 c0 03             	add    $0x3,%eax
80100f60:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100f67:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100f6b:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100f72:	ff ff ff 
  ustack[1] = argc;
80100f75:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f78:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100f7e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f81:	83 c0 01             	add    $0x1,%eax
80100f84:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100f8b:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100f8e:	29 d0                	sub    %edx,%eax
80100f90:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100f96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100f99:	83 c0 04             	add    $0x4,%eax
80100f9c:	c1 e0 02             	shl    $0x2,%eax
80100f9f:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100fa2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100fa5:	83 c0 04             	add    $0x4,%eax
80100fa8:	c1 e0 02             	shl    $0x2,%eax
80100fab:	50                   	push   %eax
80100fac:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100fb2:	50                   	push   %eax
80100fb3:	ff 75 dc             	pushl  -0x24(%ebp)
80100fb6:	ff 75 d4             	pushl  -0x2c(%ebp)
80100fb9:	e8 a6 94 00 00       	call   8010a464 <copyout>
80100fbe:	83 c4 10             	add    $0x10,%esp
80100fc1:	85 c0                	test   %eax,%eax
80100fc3:	0f 88 f5 00 00 00    	js     801010be <exec+0x46b>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100fc9:	8b 45 08             	mov    0x8(%ebp),%eax
80100fcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100fcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100fd5:	eb 17                	jmp    80100fee <exec+0x39b>
    if(*s == '/')
80100fd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fda:	0f b6 00             	movzbl (%eax),%eax
80100fdd:	3c 2f                	cmp    $0x2f,%al
80100fdf:	75 09                	jne    80100fea <exec+0x397>
      last = s+1;
80100fe1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100fe4:	83 c0 01             	add    $0x1,%eax
80100fe7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(last=s=path; *s; s++)
80100fea:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100fee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ff1:	0f b6 00             	movzbl (%eax),%eax
80100ff4:	84 c0                	test   %al,%al
80100ff6:	75 df                	jne    80100fd7 <exec+0x384>
  safestrcpy(proc->name, last, sizeof(proc->name));
80100ff8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ffe:	83 c0 6c             	add    $0x6c,%eax
80101001:	83 ec 04             	sub    $0x4,%esp
80101004:	6a 10                	push   $0x10
80101006:	ff 75 f0             	pushl  -0x10(%ebp)
80101009:	50                   	push   %eax
8010100a:	e8 97 60 00 00       	call   801070a6 <safestrcpy>
8010100f:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80101012:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101018:	8b 40 04             	mov    0x4(%eax),%eax
8010101b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
8010101e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101024:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80101027:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
8010102a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101030:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101033:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80101035:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010103b:	8b 40 18             	mov    0x18(%eax),%eax
8010103e:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80101044:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80101047:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010104d:	8b 40 18             	mov    0x18(%eax),%eax
80101050:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101053:	89 50 44             	mov    %edx,0x44(%eax)
#ifdef LS_EXEC
  // change process's UID if flag is on
  if (st.mode.flags.setuid) {
80101056:	0f b6 85 e5 fe ff ff 	movzbl -0x11b(%ebp),%eax
8010105d:	83 e0 02             	and    $0x2,%eax
80101060:	84 c0                	test   %al,%al
80101062:	74 12                	je     80101076 <exec+0x423>
      proc->uid = st.uid;
80101064:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010106a:	8b 95 dc fe ff ff    	mov    -0x124(%ebp),%edx
80101070:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
  }
#endif
  switchuvm(proc);
80101076:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010107c:	83 ec 0c             	sub    $0xc,%esp
8010107f:	50                   	push   %eax
80101080:	e8 20 8d 00 00       	call   80109da5 <switchuvm>
80101085:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80101088:	83 ec 0c             	sub    $0xc,%esp
8010108b:	ff 75 d0             	pushl  -0x30(%ebp)
8010108e:	e8 6b 91 00 00       	call   8010a1fe <freevm>
80101093:	83 c4 10             	add    $0x10,%esp
  return 0;
80101096:	b8 00 00 00 00       	mov    $0x0,%eax
8010109b:	eb 54                	jmp    801010f1 <exec+0x49e>
      goto bad; // No permissions, exec fails
8010109d:	90                   	nop
8010109e:	eb 1f                	jmp    801010bf <exec+0x46c>
    goto bad;
801010a0:	90                   	nop
801010a1:	eb 1c                	jmp    801010bf <exec+0x46c>
    goto bad;
801010a3:	90                   	nop
801010a4:	eb 19                	jmp    801010bf <exec+0x46c>
    goto bad;
801010a6:	90                   	nop
801010a7:	eb 16                	jmp    801010bf <exec+0x46c>
      goto bad;
801010a9:	90                   	nop
801010aa:	eb 13                	jmp    801010bf <exec+0x46c>
      goto bad;
801010ac:	90                   	nop
801010ad:	eb 10                	jmp    801010bf <exec+0x46c>
      goto bad;
801010af:	90                   	nop
801010b0:	eb 0d                	jmp    801010bf <exec+0x46c>
      goto bad;
801010b2:	90                   	nop
801010b3:	eb 0a                	jmp    801010bf <exec+0x46c>
    goto bad;
801010b5:	90                   	nop
801010b6:	eb 07                	jmp    801010bf <exec+0x46c>
      goto bad;
801010b8:	90                   	nop
801010b9:	eb 04                	jmp    801010bf <exec+0x46c>
      goto bad;
801010bb:	90                   	nop
801010bc:	eb 01                	jmp    801010bf <exec+0x46c>
    goto bad;
801010be:	90                   	nop

 bad:
  if(pgdir)
801010bf:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
801010c3:	74 0e                	je     801010d3 <exec+0x480>
    freevm(pgdir);
801010c5:	83 ec 0c             	sub    $0xc,%esp
801010c8:	ff 75 d4             	pushl  -0x2c(%ebp)
801010cb:	e8 2e 91 00 00       	call   8010a1fe <freevm>
801010d0:	83 c4 10             	add    $0x10,%esp
  if(ip){
801010d3:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
801010d7:	74 13                	je     801010ec <exec+0x499>
    iunlockput(ip);
801010d9:	83 ec 0c             	sub    $0xc,%esp
801010dc:	ff 75 d8             	pushl  -0x28(%ebp)
801010df:	e8 7c 0d 00 00       	call   80101e60 <iunlockput>
801010e4:	83 c4 10             	add    $0x10,%esp
    end_op();
801010e7:	e8 8a 28 00 00       	call   80103976 <end_op>
  }
  return -1;
801010ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010f1:	c9                   	leave  
801010f2:	c3                   	ret    

801010f3 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801010f3:	f3 0f 1e fb          	endbr32 
801010f7:	55                   	push   %ebp
801010f8:	89 e5                	mov    %esp,%ebp
801010fa:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
801010fd:	83 ec 08             	sub    $0x8,%esp
80101100:	68 c4 a5 10 80       	push   $0x8010a5c4
80101105:	68 40 38 11 80       	push   $0x80113840
8010110a:	e8 da 5a 00 00       	call   80106be9 <initlock>
8010110f:	83 c4 10             	add    $0x10,%esp
}
80101112:	90                   	nop
80101113:	c9                   	leave  
80101114:	c3                   	ret    

80101115 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101115:	f3 0f 1e fb          	endbr32 
80101119:	55                   	push   %ebp
8010111a:	89 e5                	mov    %esp,%ebp
8010111c:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
8010111f:	83 ec 0c             	sub    $0xc,%esp
80101122:	68 40 38 11 80       	push   $0x80113840
80101127:	e8 e3 5a 00 00       	call   80106c0f <acquire>
8010112c:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
8010112f:	c7 45 f4 74 38 11 80 	movl   $0x80113874,-0xc(%ebp)
80101136:	eb 2d                	jmp    80101165 <filealloc+0x50>
    if(f->ref == 0){
80101138:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010113b:	8b 40 04             	mov    0x4(%eax),%eax
8010113e:	85 c0                	test   %eax,%eax
80101140:	75 1f                	jne    80101161 <filealloc+0x4c>
      f->ref = 1;
80101142:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101145:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
8010114c:	83 ec 0c             	sub    $0xc,%esp
8010114f:	68 40 38 11 80       	push   $0x80113840
80101154:	e8 21 5b 00 00       	call   80106c7a <release>
80101159:	83 c4 10             	add    $0x10,%esp
      return f;
8010115c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010115f:	eb 23                	jmp    80101184 <filealloc+0x6f>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101161:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80101165:	b8 d4 41 11 80       	mov    $0x801141d4,%eax
8010116a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010116d:	72 c9                	jb     80101138 <filealloc+0x23>
    }
  }
  release(&ftable.lock);
8010116f:	83 ec 0c             	sub    $0xc,%esp
80101172:	68 40 38 11 80       	push   $0x80113840
80101177:	e8 fe 5a 00 00       	call   80106c7a <release>
8010117c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010117f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80101184:	c9                   	leave  
80101185:	c3                   	ret    

80101186 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101186:	f3 0f 1e fb          	endbr32 
8010118a:	55                   	push   %ebp
8010118b:	89 e5                	mov    %esp,%ebp
8010118d:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80101190:	83 ec 0c             	sub    $0xc,%esp
80101193:	68 40 38 11 80       	push   $0x80113840
80101198:	e8 72 5a 00 00       	call   80106c0f <acquire>
8010119d:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801011a0:	8b 45 08             	mov    0x8(%ebp),%eax
801011a3:	8b 40 04             	mov    0x4(%eax),%eax
801011a6:	85 c0                	test   %eax,%eax
801011a8:	7f 0d                	jg     801011b7 <filedup+0x31>
    panic("filedup");
801011aa:	83 ec 0c             	sub    $0xc,%esp
801011ad:	68 cb a5 10 80       	push   $0x8010a5cb
801011b2:	e8 e0 f3 ff ff       	call   80100597 <panic>
  f->ref++;
801011b7:	8b 45 08             	mov    0x8(%ebp),%eax
801011ba:	8b 40 04             	mov    0x4(%eax),%eax
801011bd:	8d 50 01             	lea    0x1(%eax),%edx
801011c0:	8b 45 08             	mov    0x8(%ebp),%eax
801011c3:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
801011c6:	83 ec 0c             	sub    $0xc,%esp
801011c9:	68 40 38 11 80       	push   $0x80113840
801011ce:	e8 a7 5a 00 00       	call   80106c7a <release>
801011d3:	83 c4 10             	add    $0x10,%esp
  return f;
801011d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
801011d9:	c9                   	leave  
801011da:	c3                   	ret    

801011db <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801011db:	f3 0f 1e fb          	endbr32 
801011df:	55                   	push   %ebp
801011e0:	89 e5                	mov    %esp,%ebp
801011e2:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
801011e5:	83 ec 0c             	sub    $0xc,%esp
801011e8:	68 40 38 11 80       	push   $0x80113840
801011ed:	e8 1d 5a 00 00       	call   80106c0f <acquire>
801011f2:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801011f5:	8b 45 08             	mov    0x8(%ebp),%eax
801011f8:	8b 40 04             	mov    0x4(%eax),%eax
801011fb:	85 c0                	test   %eax,%eax
801011fd:	7f 0d                	jg     8010120c <fileclose+0x31>
    panic("fileclose");
801011ff:	83 ec 0c             	sub    $0xc,%esp
80101202:	68 d3 a5 10 80       	push   $0x8010a5d3
80101207:	e8 8b f3 ff ff       	call   80100597 <panic>
  if(--f->ref > 0){
8010120c:	8b 45 08             	mov    0x8(%ebp),%eax
8010120f:	8b 40 04             	mov    0x4(%eax),%eax
80101212:	8d 50 ff             	lea    -0x1(%eax),%edx
80101215:	8b 45 08             	mov    0x8(%ebp),%eax
80101218:	89 50 04             	mov    %edx,0x4(%eax)
8010121b:	8b 45 08             	mov    0x8(%ebp),%eax
8010121e:	8b 40 04             	mov    0x4(%eax),%eax
80101221:	85 c0                	test   %eax,%eax
80101223:	7e 15                	jle    8010123a <fileclose+0x5f>
    release(&ftable.lock);
80101225:	83 ec 0c             	sub    $0xc,%esp
80101228:	68 40 38 11 80       	push   $0x80113840
8010122d:	e8 48 5a 00 00       	call   80106c7a <release>
80101232:	83 c4 10             	add    $0x10,%esp
80101235:	e9 8b 00 00 00       	jmp    801012c5 <fileclose+0xea>
    return;
  }
  ff = *f;
8010123a:	8b 45 08             	mov    0x8(%ebp),%eax
8010123d:	8b 10                	mov    (%eax),%edx
8010123f:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101242:	8b 50 04             	mov    0x4(%eax),%edx
80101245:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101248:	8b 50 08             	mov    0x8(%eax),%edx
8010124b:	89 55 e8             	mov    %edx,-0x18(%ebp)
8010124e:	8b 50 0c             	mov    0xc(%eax),%edx
80101251:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101254:	8b 50 10             	mov    0x10(%eax),%edx
80101257:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010125a:	8b 40 14             	mov    0x14(%eax),%eax
8010125d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101260:	8b 45 08             	mov    0x8(%ebp),%eax
80101263:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
8010126a:	8b 45 08             	mov    0x8(%ebp),%eax
8010126d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101273:	83 ec 0c             	sub    $0xc,%esp
80101276:	68 40 38 11 80       	push   $0x80113840
8010127b:	e8 fa 59 00 00       	call   80106c7a <release>
80101280:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
80101283:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101286:	83 f8 01             	cmp    $0x1,%eax
80101289:	75 19                	jne    801012a4 <fileclose+0xc9>
    pipeclose(ff.pipe, ff.writable);
8010128b:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
8010128f:	0f be d0             	movsbl %al,%edx
80101292:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101295:	83 ec 08             	sub    $0x8,%esp
80101298:	52                   	push   %edx
80101299:	50                   	push   %eax
8010129a:	e8 f7 32 00 00       	call   80104596 <pipeclose>
8010129f:	83 c4 10             	add    $0x10,%esp
801012a2:	eb 21                	jmp    801012c5 <fileclose+0xea>
  else if(ff.type == FD_INODE){
801012a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801012a7:	83 f8 02             	cmp    $0x2,%eax
801012aa:	75 19                	jne    801012c5 <fileclose+0xea>
    begin_op();
801012ac:	e8 35 26 00 00       	call   801038e6 <begin_op>
    iput(ff.ip);
801012b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801012b4:	83 ec 0c             	sub    $0xc,%esp
801012b7:	50                   	push   %eax
801012b8:	e8 af 0a 00 00       	call   80101d6c <iput>
801012bd:	83 c4 10             	add    $0x10,%esp
    end_op();
801012c0:	e8 b1 26 00 00       	call   80103976 <end_op>
  }
}
801012c5:	c9                   	leave  
801012c6:	c3                   	ret    

801012c7 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801012c7:	f3 0f 1e fb          	endbr32 
801012cb:	55                   	push   %ebp
801012cc:	89 e5                	mov    %esp,%ebp
801012ce:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
801012d1:	8b 45 08             	mov    0x8(%ebp),%eax
801012d4:	8b 00                	mov    (%eax),%eax
801012d6:	83 f8 02             	cmp    $0x2,%eax
801012d9:	75 40                	jne    8010131b <filestat+0x54>
    ilock(f->ip);
801012db:	8b 45 08             	mov    0x8(%ebp),%eax
801012de:	8b 40 10             	mov    0x10(%eax),%eax
801012e1:	83 ec 0c             	sub    $0xc,%esp
801012e4:	50                   	push   %eax
801012e5:	e8 86 08 00 00       	call   80101b70 <ilock>
801012ea:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
801012ed:	8b 45 08             	mov    0x8(%ebp),%eax
801012f0:	8b 40 10             	mov    0x10(%eax),%eax
801012f3:	83 ec 08             	sub    $0x8,%esp
801012f6:	ff 75 0c             	pushl  0xc(%ebp)
801012f9:	50                   	push   %eax
801012fa:	e8 e2 0d 00 00       	call   801020e1 <stati>
801012ff:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
80101302:	8b 45 08             	mov    0x8(%ebp),%eax
80101305:	8b 40 10             	mov    0x10(%eax),%eax
80101308:	83 ec 0c             	sub    $0xc,%esp
8010130b:	50                   	push   %eax
8010130c:	e8 e5 09 00 00       	call   80101cf6 <iunlock>
80101311:	83 c4 10             	add    $0x10,%esp
    return 0;
80101314:	b8 00 00 00 00       	mov    $0x0,%eax
80101319:	eb 05                	jmp    80101320 <filestat+0x59>
  }
  return -1;
8010131b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101320:	c9                   	leave  
80101321:	c3                   	ret    

80101322 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101322:	f3 0f 1e fb          	endbr32 
80101326:	55                   	push   %ebp
80101327:	89 e5                	mov    %esp,%ebp
80101329:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
8010132c:	8b 45 08             	mov    0x8(%ebp),%eax
8010132f:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101333:	84 c0                	test   %al,%al
80101335:	75 0a                	jne    80101341 <fileread+0x1f>
    return -1;
80101337:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010133c:	e9 9b 00 00 00       	jmp    801013dc <fileread+0xba>
  if(f->type == FD_PIPE)
80101341:	8b 45 08             	mov    0x8(%ebp),%eax
80101344:	8b 00                	mov    (%eax),%eax
80101346:	83 f8 01             	cmp    $0x1,%eax
80101349:	75 1a                	jne    80101365 <fileread+0x43>
    return piperead(f->pipe, addr, n);
8010134b:	8b 45 08             	mov    0x8(%ebp),%eax
8010134e:	8b 40 0c             	mov    0xc(%eax),%eax
80101351:	83 ec 04             	sub    $0x4,%esp
80101354:	ff 75 10             	pushl  0x10(%ebp)
80101357:	ff 75 0c             	pushl  0xc(%ebp)
8010135a:	50                   	push   %eax
8010135b:	e8 ec 33 00 00       	call   8010474c <piperead>
80101360:	83 c4 10             	add    $0x10,%esp
80101363:	eb 77                	jmp    801013dc <fileread+0xba>
  if(f->type == FD_INODE){
80101365:	8b 45 08             	mov    0x8(%ebp),%eax
80101368:	8b 00                	mov    (%eax),%eax
8010136a:	83 f8 02             	cmp    $0x2,%eax
8010136d:	75 60                	jne    801013cf <fileread+0xad>
    ilock(f->ip);
8010136f:	8b 45 08             	mov    0x8(%ebp),%eax
80101372:	8b 40 10             	mov    0x10(%eax),%eax
80101375:	83 ec 0c             	sub    $0xc,%esp
80101378:	50                   	push   %eax
80101379:	e8 f2 07 00 00       	call   80101b70 <ilock>
8010137e:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101381:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101384:	8b 45 08             	mov    0x8(%ebp),%eax
80101387:	8b 50 14             	mov    0x14(%eax),%edx
8010138a:	8b 45 08             	mov    0x8(%ebp),%eax
8010138d:	8b 40 10             	mov    0x10(%eax),%eax
80101390:	51                   	push   %ecx
80101391:	52                   	push   %edx
80101392:	ff 75 0c             	pushl  0xc(%ebp)
80101395:	50                   	push   %eax
80101396:	e8 b4 0d 00 00       	call   8010214f <readi>
8010139b:	83 c4 10             	add    $0x10,%esp
8010139e:	89 45 f4             	mov    %eax,-0xc(%ebp)
801013a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801013a5:	7e 11                	jle    801013b8 <fileread+0x96>
      f->off += r;
801013a7:	8b 45 08             	mov    0x8(%ebp),%eax
801013aa:	8b 50 14             	mov    0x14(%eax),%edx
801013ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013b0:	01 c2                	add    %eax,%edx
801013b2:	8b 45 08             	mov    0x8(%ebp),%eax
801013b5:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801013b8:	8b 45 08             	mov    0x8(%ebp),%eax
801013bb:	8b 40 10             	mov    0x10(%eax),%eax
801013be:	83 ec 0c             	sub    $0xc,%esp
801013c1:	50                   	push   %eax
801013c2:	e8 2f 09 00 00       	call   80101cf6 <iunlock>
801013c7:	83 c4 10             	add    $0x10,%esp
    return r;
801013ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013cd:	eb 0d                	jmp    801013dc <fileread+0xba>
  }
  panic("fileread");
801013cf:	83 ec 0c             	sub    $0xc,%esp
801013d2:	68 dd a5 10 80       	push   $0x8010a5dd
801013d7:	e8 bb f1 ff ff       	call   80100597 <panic>
}
801013dc:	c9                   	leave  
801013dd:	c3                   	ret    

801013de <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801013de:	f3 0f 1e fb          	endbr32 
801013e2:	55                   	push   %ebp
801013e3:	89 e5                	mov    %esp,%ebp
801013e5:	53                   	push   %ebx
801013e6:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
801013e9:	8b 45 08             	mov    0x8(%ebp),%eax
801013ec:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801013f0:	84 c0                	test   %al,%al
801013f2:	75 0a                	jne    801013fe <filewrite+0x20>
    return -1;
801013f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801013f9:	e9 1b 01 00 00       	jmp    80101519 <filewrite+0x13b>
  if(f->type == FD_PIPE)
801013fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101401:	8b 00                	mov    (%eax),%eax
80101403:	83 f8 01             	cmp    $0x1,%eax
80101406:	75 1d                	jne    80101425 <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
80101408:	8b 45 08             	mov    0x8(%ebp),%eax
8010140b:	8b 40 0c             	mov    0xc(%eax),%eax
8010140e:	83 ec 04             	sub    $0x4,%esp
80101411:	ff 75 10             	pushl  0x10(%ebp)
80101414:	ff 75 0c             	pushl  0xc(%ebp)
80101417:	50                   	push   %eax
80101418:	e8 28 32 00 00       	call   80104645 <pipewrite>
8010141d:	83 c4 10             	add    $0x10,%esp
80101420:	e9 f4 00 00 00       	jmp    80101519 <filewrite+0x13b>
  if(f->type == FD_INODE){
80101425:	8b 45 08             	mov    0x8(%ebp),%eax
80101428:	8b 00                	mov    (%eax),%eax
8010142a:	83 f8 02             	cmp    $0x2,%eax
8010142d:	0f 85 d9 00 00 00    	jne    8010150c <filewrite+0x12e>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
80101433:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
    int i = 0;
8010143a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101441:	e9 a3 00 00 00       	jmp    801014e9 <filewrite+0x10b>
      int n1 = n - i;
80101446:	8b 45 10             	mov    0x10(%ebp),%eax
80101449:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010144c:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
8010144f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101452:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101455:	7e 06                	jle    8010145d <filewrite+0x7f>
        n1 = max;
80101457:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010145a:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
8010145d:	e8 84 24 00 00       	call   801038e6 <begin_op>
      ilock(f->ip);
80101462:	8b 45 08             	mov    0x8(%ebp),%eax
80101465:	8b 40 10             	mov    0x10(%eax),%eax
80101468:	83 ec 0c             	sub    $0xc,%esp
8010146b:	50                   	push   %eax
8010146c:	e8 ff 06 00 00       	call   80101b70 <ilock>
80101471:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101474:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101477:	8b 45 08             	mov    0x8(%ebp),%eax
8010147a:	8b 50 14             	mov    0x14(%eax),%edx
8010147d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101480:	8b 45 0c             	mov    0xc(%ebp),%eax
80101483:	01 c3                	add    %eax,%ebx
80101485:	8b 45 08             	mov    0x8(%ebp),%eax
80101488:	8b 40 10             	mov    0x10(%eax),%eax
8010148b:	51                   	push   %ecx
8010148c:	52                   	push   %edx
8010148d:	53                   	push   %ebx
8010148e:	50                   	push   %eax
8010148f:	e8 14 0e 00 00       	call   801022a8 <writei>
80101494:	83 c4 10             	add    $0x10,%esp
80101497:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010149a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010149e:	7e 11                	jle    801014b1 <filewrite+0xd3>
        f->off += r;
801014a0:	8b 45 08             	mov    0x8(%ebp),%eax
801014a3:	8b 50 14             	mov    0x14(%eax),%edx
801014a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
801014a9:	01 c2                	add    %eax,%edx
801014ab:	8b 45 08             	mov    0x8(%ebp),%eax
801014ae:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801014b1:	8b 45 08             	mov    0x8(%ebp),%eax
801014b4:	8b 40 10             	mov    0x10(%eax),%eax
801014b7:	83 ec 0c             	sub    $0xc,%esp
801014ba:	50                   	push   %eax
801014bb:	e8 36 08 00 00       	call   80101cf6 <iunlock>
801014c0:	83 c4 10             	add    $0x10,%esp
      end_op();
801014c3:	e8 ae 24 00 00       	call   80103976 <end_op>

      if(r < 0)
801014c8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801014cc:	78 29                	js     801014f7 <filewrite+0x119>
        break;
      if(r != n1)
801014ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
801014d1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801014d4:	74 0d                	je     801014e3 <filewrite+0x105>
        panic("short filewrite");
801014d6:	83 ec 0c             	sub    $0xc,%esp
801014d9:	68 e6 a5 10 80       	push   $0x8010a5e6
801014de:	e8 b4 f0 ff ff       	call   80100597 <panic>
      i += r;
801014e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801014e6:	01 45 f4             	add    %eax,-0xc(%ebp)
    while(i < n){
801014e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014ec:	3b 45 10             	cmp    0x10(%ebp),%eax
801014ef:	0f 8c 51 ff ff ff    	jl     80101446 <filewrite+0x68>
801014f5:	eb 01                	jmp    801014f8 <filewrite+0x11a>
        break;
801014f7:	90                   	nop
    }
    return i == n ? n : -1;
801014f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014fb:	3b 45 10             	cmp    0x10(%ebp),%eax
801014fe:	75 05                	jne    80101505 <filewrite+0x127>
80101500:	8b 45 10             	mov    0x10(%ebp),%eax
80101503:	eb 14                	jmp    80101519 <filewrite+0x13b>
80101505:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010150a:	eb 0d                	jmp    80101519 <filewrite+0x13b>
  }
  panic("filewrite");
8010150c:	83 ec 0c             	sub    $0xc,%esp
8010150f:	68 f6 a5 10 80       	push   $0x8010a5f6
80101514:	e8 7e f0 ff ff       	call   80100597 <panic>
}
80101519:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010151c:	c9                   	leave  
8010151d:	c3                   	ret    

8010151e <readsb>:
struct superblock sb;   // there should be one per dev, but we run with one dev

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
8010151e:	f3 0f 1e fb          	endbr32 
80101522:	55                   	push   %ebp
80101523:	89 e5                	mov    %esp,%ebp
80101525:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
80101528:	8b 45 08             	mov    0x8(%ebp),%eax
8010152b:	83 ec 08             	sub    $0x8,%esp
8010152e:	6a 01                	push   $0x1
80101530:	50                   	push   %eax
80101531:	e8 89 ec ff ff       	call   801001bf <bread>
80101536:	83 c4 10             	add    $0x10,%esp
80101539:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
8010153c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010153f:	83 c0 18             	add    $0x18,%eax
80101542:	83 ec 04             	sub    $0x4,%esp
80101545:	6a 1c                	push   $0x1c
80101547:	50                   	push   %eax
80101548:	ff 75 0c             	pushl  0xc(%ebp)
8010154b:	e8 02 5a 00 00       	call   80106f52 <memmove>
80101550:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101553:	83 ec 0c             	sub    $0xc,%esp
80101556:	ff 75 f4             	pushl  -0xc(%ebp)
80101559:	e8 e1 ec ff ff       	call   8010023f <brelse>
8010155e:	83 c4 10             	add    $0x10,%esp
}
80101561:	90                   	nop
80101562:	c9                   	leave  
80101563:	c3                   	ret    

80101564 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101564:	f3 0f 1e fb          	endbr32 
80101568:	55                   	push   %ebp
80101569:	89 e5                	mov    %esp,%ebp
8010156b:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
8010156e:	8b 55 0c             	mov    0xc(%ebp),%edx
80101571:	8b 45 08             	mov    0x8(%ebp),%eax
80101574:	83 ec 08             	sub    $0x8,%esp
80101577:	52                   	push   %edx
80101578:	50                   	push   %eax
80101579:	e8 41 ec ff ff       	call   801001bf <bread>
8010157e:	83 c4 10             	add    $0x10,%esp
80101581:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101584:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101587:	83 c0 18             	add    $0x18,%eax
8010158a:	83 ec 04             	sub    $0x4,%esp
8010158d:	68 00 02 00 00       	push   $0x200
80101592:	6a 00                	push   $0x0
80101594:	50                   	push   %eax
80101595:	e8 f1 58 00 00       	call   80106e8b <memset>
8010159a:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
8010159d:	83 ec 0c             	sub    $0xc,%esp
801015a0:	ff 75 f4             	pushl  -0xc(%ebp)
801015a3:	e8 87 25 00 00       	call   80103b2f <log_write>
801015a8:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801015ab:	83 ec 0c             	sub    $0xc,%esp
801015ae:	ff 75 f4             	pushl  -0xc(%ebp)
801015b1:	e8 89 ec ff ff       	call   8010023f <brelse>
801015b6:	83 c4 10             	add    $0x10,%esp
}
801015b9:	90                   	nop
801015ba:	c9                   	leave  
801015bb:	c3                   	ret    

801015bc <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801015bc:	f3 0f 1e fb          	endbr32 
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
801015c6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801015cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801015d4:	e9 13 01 00 00       	jmp    801016ec <balloc+0x130>
    bp = bread(dev, BBLOCK(b, sb));
801015d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015dc:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801015e2:	85 c0                	test   %eax,%eax
801015e4:	0f 48 c2             	cmovs  %edx,%eax
801015e7:	c1 f8 0c             	sar    $0xc,%eax
801015ea:	89 c2                	mov    %eax,%edx
801015ec:	a1 58 42 11 80       	mov    0x80114258,%eax
801015f1:	01 d0                	add    %edx,%eax
801015f3:	83 ec 08             	sub    $0x8,%esp
801015f6:	50                   	push   %eax
801015f7:	ff 75 08             	pushl  0x8(%ebp)
801015fa:	e8 c0 eb ff ff       	call   801001bf <bread>
801015ff:	83 c4 10             	add    $0x10,%esp
80101602:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101605:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010160c:	e9 a6 00 00 00       	jmp    801016b7 <balloc+0xfb>
      m = 1 << (bi % 8);
80101611:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101614:	99                   	cltd   
80101615:	c1 ea 1d             	shr    $0x1d,%edx
80101618:	01 d0                	add    %edx,%eax
8010161a:	83 e0 07             	and    $0x7,%eax
8010161d:	29 d0                	sub    %edx,%eax
8010161f:	ba 01 00 00 00       	mov    $0x1,%edx
80101624:	89 c1                	mov    %eax,%ecx
80101626:	d3 e2                	shl    %cl,%edx
80101628:	89 d0                	mov    %edx,%eax
8010162a:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010162d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101630:	8d 50 07             	lea    0x7(%eax),%edx
80101633:	85 c0                	test   %eax,%eax
80101635:	0f 48 c2             	cmovs  %edx,%eax
80101638:	c1 f8 03             	sar    $0x3,%eax
8010163b:	89 c2                	mov    %eax,%edx
8010163d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101640:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101645:	0f b6 c0             	movzbl %al,%eax
80101648:	23 45 e8             	and    -0x18(%ebp),%eax
8010164b:	85 c0                	test   %eax,%eax
8010164d:	75 64                	jne    801016b3 <balloc+0xf7>
        bp->data[bi/8] |= m;  // Mark block in use.
8010164f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101652:	8d 50 07             	lea    0x7(%eax),%edx
80101655:	85 c0                	test   %eax,%eax
80101657:	0f 48 c2             	cmovs  %edx,%eax
8010165a:	c1 f8 03             	sar    $0x3,%eax
8010165d:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101660:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101665:	89 d1                	mov    %edx,%ecx
80101667:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010166a:	09 ca                	or     %ecx,%edx
8010166c:	89 d1                	mov    %edx,%ecx
8010166e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101671:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
80101675:	83 ec 0c             	sub    $0xc,%esp
80101678:	ff 75 ec             	pushl  -0x14(%ebp)
8010167b:	e8 af 24 00 00       	call   80103b2f <log_write>
80101680:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
80101683:	83 ec 0c             	sub    $0xc,%esp
80101686:	ff 75 ec             	pushl  -0x14(%ebp)
80101689:	e8 b1 eb ff ff       	call   8010023f <brelse>
8010168e:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
80101691:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101694:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101697:	01 c2                	add    %eax,%edx
80101699:	8b 45 08             	mov    0x8(%ebp),%eax
8010169c:	83 ec 08             	sub    $0x8,%esp
8010169f:	52                   	push   %edx
801016a0:	50                   	push   %eax
801016a1:	e8 be fe ff ff       	call   80101564 <bzero>
801016a6:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801016a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801016ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016af:	01 d0                	add    %edx,%eax
801016b1:	eb 57                	jmp    8010170a <balloc+0x14e>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801016b3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801016b7:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
801016be:	7f 17                	jg     801016d7 <balloc+0x11b>
801016c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801016c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016c6:	01 d0                	add    %edx,%eax
801016c8:	89 c2                	mov    %eax,%edx
801016ca:	a1 40 42 11 80       	mov    0x80114240,%eax
801016cf:	39 c2                	cmp    %eax,%edx
801016d1:	0f 82 3a ff ff ff    	jb     80101611 <balloc+0x55>
      }
    }
    brelse(bp);
801016d7:	83 ec 0c             	sub    $0xc,%esp
801016da:	ff 75 ec             	pushl  -0x14(%ebp)
801016dd:	e8 5d eb ff ff       	call   8010023f <brelse>
801016e2:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
801016e5:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801016ec:	8b 15 40 42 11 80    	mov    0x80114240,%edx
801016f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016f5:	39 c2                	cmp    %eax,%edx
801016f7:	0f 87 dc fe ff ff    	ja     801015d9 <balloc+0x1d>
  }
  panic("balloc: out of blocks");
801016fd:	83 ec 0c             	sub    $0xc,%esp
80101700:	68 00 a6 10 80       	push   $0x8010a600
80101705:	e8 8d ee ff ff       	call   80100597 <panic>
}
8010170a:	c9                   	leave  
8010170b:	c3                   	ret    

8010170c <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
8010170c:	f3 0f 1e fb          	endbr32 
80101710:	55                   	push   %ebp
80101711:	89 e5                	mov    %esp,%ebp
80101713:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101716:	83 ec 08             	sub    $0x8,%esp
80101719:	68 40 42 11 80       	push   $0x80114240
8010171e:	ff 75 08             	pushl  0x8(%ebp)
80101721:	e8 f8 fd ff ff       	call   8010151e <readsb>
80101726:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101729:	8b 45 0c             	mov    0xc(%ebp),%eax
8010172c:	c1 e8 0c             	shr    $0xc,%eax
8010172f:	89 c2                	mov    %eax,%edx
80101731:	a1 58 42 11 80       	mov    0x80114258,%eax
80101736:	01 c2                	add    %eax,%edx
80101738:	8b 45 08             	mov    0x8(%ebp),%eax
8010173b:	83 ec 08             	sub    $0x8,%esp
8010173e:	52                   	push   %edx
8010173f:	50                   	push   %eax
80101740:	e8 7a ea ff ff       	call   801001bf <bread>
80101745:	83 c4 10             	add    $0x10,%esp
80101748:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
8010174b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010174e:	25 ff 0f 00 00       	and    $0xfff,%eax
80101753:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101756:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101759:	99                   	cltd   
8010175a:	c1 ea 1d             	shr    $0x1d,%edx
8010175d:	01 d0                	add    %edx,%eax
8010175f:	83 e0 07             	and    $0x7,%eax
80101762:	29 d0                	sub    %edx,%eax
80101764:	ba 01 00 00 00       	mov    $0x1,%edx
80101769:	89 c1                	mov    %eax,%ecx
8010176b:	d3 e2                	shl    %cl,%edx
8010176d:	89 d0                	mov    %edx,%eax
8010176f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101772:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101775:	8d 50 07             	lea    0x7(%eax),%edx
80101778:	85 c0                	test   %eax,%eax
8010177a:	0f 48 c2             	cmovs  %edx,%eax
8010177d:	c1 f8 03             	sar    $0x3,%eax
80101780:	89 c2                	mov    %eax,%edx
80101782:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101785:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
8010178a:	0f b6 c0             	movzbl %al,%eax
8010178d:	23 45 ec             	and    -0x14(%ebp),%eax
80101790:	85 c0                	test   %eax,%eax
80101792:	75 0d                	jne    801017a1 <bfree+0x95>
    panic("freeing free block");
80101794:	83 ec 0c             	sub    $0xc,%esp
80101797:	68 16 a6 10 80       	push   $0x8010a616
8010179c:	e8 f6 ed ff ff       	call   80100597 <panic>
  bp->data[bi/8] &= ~m;
801017a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017a4:	8d 50 07             	lea    0x7(%eax),%edx
801017a7:	85 c0                	test   %eax,%eax
801017a9:	0f 48 c2             	cmovs  %edx,%eax
801017ac:	c1 f8 03             	sar    $0x3,%eax
801017af:	8b 55 f4             	mov    -0xc(%ebp),%edx
801017b2:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801017b7:	89 d1                	mov    %edx,%ecx
801017b9:	8b 55 ec             	mov    -0x14(%ebp),%edx
801017bc:	f7 d2                	not    %edx
801017be:	21 ca                	and    %ecx,%edx
801017c0:	89 d1                	mov    %edx,%ecx
801017c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801017c5:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
801017c9:	83 ec 0c             	sub    $0xc,%esp
801017cc:	ff 75 f4             	pushl  -0xc(%ebp)
801017cf:	e8 5b 23 00 00       	call   80103b2f <log_write>
801017d4:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801017d7:	83 ec 0c             	sub    $0xc,%esp
801017da:	ff 75 f4             	pushl  -0xc(%ebp)
801017dd:	e8 5d ea ff ff       	call   8010023f <brelse>
801017e2:	83 c4 10             	add    $0x10,%esp
}
801017e5:	90                   	nop
801017e6:	c9                   	leave  
801017e7:	c3                   	ret    

801017e8 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801017e8:	f3 0f 1e fb          	endbr32 
801017ec:	55                   	push   %ebp
801017ed:	89 e5                	mov    %esp,%ebp
801017ef:	57                   	push   %edi
801017f0:	56                   	push   %esi
801017f1:	53                   	push   %ebx
801017f2:	83 ec 1c             	sub    $0x1c,%esp
  initlock(&icache.lock, "icache");
801017f5:	83 ec 08             	sub    $0x8,%esp
801017f8:	68 29 a6 10 80       	push   $0x8010a629
801017fd:	68 60 42 11 80       	push   $0x80114260
80101802:	e8 e2 53 00 00       	call   80106be9 <initlock>
80101807:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
8010180a:	83 ec 08             	sub    $0x8,%esp
8010180d:	68 40 42 11 80       	push   $0x80114240
80101812:	ff 75 08             	pushl  0x8(%ebp)
80101815:	e8 04 fd ff ff       	call   8010151e <readsb>
8010181a:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d inodestart %d bmap start %d\n", sb.size,
8010181d:	a1 58 42 11 80       	mov    0x80114258,%eax
80101822:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101825:	8b 3d 54 42 11 80    	mov    0x80114254,%edi
8010182b:	8b 35 50 42 11 80    	mov    0x80114250,%esi
80101831:	8b 1d 4c 42 11 80    	mov    0x8011424c,%ebx
80101837:	8b 0d 48 42 11 80    	mov    0x80114248,%ecx
8010183d:	8b 15 44 42 11 80    	mov    0x80114244,%edx
80101843:	a1 40 42 11 80       	mov    0x80114240,%eax
80101848:	ff 75 e4             	pushl  -0x1c(%ebp)
8010184b:	57                   	push   %edi
8010184c:	56                   	push   %esi
8010184d:	53                   	push   %ebx
8010184e:	51                   	push   %ecx
8010184f:	52                   	push   %edx
80101850:	50                   	push   %eax
80101851:	68 30 a6 10 80       	push   $0x8010a630
80101856:	e8 83 eb ff ff       	call   801003de <cprintf>
8010185b:	83 c4 20             	add    $0x20,%esp
          sb.nblocks, sb.ninodes, sb.nlog, sb.logstart, sb.inodestart, sb.bmapstart);
}
8010185e:	90                   	nop
8010185f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101862:	5b                   	pop    %ebx
80101863:	5e                   	pop    %esi
80101864:	5f                   	pop    %edi
80101865:	5d                   	pop    %ebp
80101866:	c3                   	ret    

80101867 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101867:	f3 0f 1e fb          	endbr32 
8010186b:	55                   	push   %ebp
8010186c:	89 e5                	mov    %esp,%ebp
8010186e:	83 ec 28             	sub    $0x28,%esp
80101871:	8b 45 0c             	mov    0xc(%ebp),%eax
80101874:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101878:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
8010187f:	e9 bf 00 00 00       	jmp    80101943 <ialloc+0xdc>
    bp = bread(dev, IBLOCK(inum, sb));
80101884:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101887:	c1 e8 02             	shr    $0x2,%eax
8010188a:	89 c2                	mov    %eax,%edx
8010188c:	a1 54 42 11 80       	mov    0x80114254,%eax
80101891:	01 d0                	add    %edx,%eax
80101893:	83 ec 08             	sub    $0x8,%esp
80101896:	50                   	push   %eax
80101897:	ff 75 08             	pushl  0x8(%ebp)
8010189a:	e8 20 e9 ff ff       	call   801001bf <bread>
8010189f:	83 c4 10             	add    $0x10,%esp
801018a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801018a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018a8:	8d 50 18             	lea    0x18(%eax),%edx
801018ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ae:	83 e0 03             	and    $0x3,%eax
801018b1:	c1 e0 07             	shl    $0x7,%eax
801018b4:	01 d0                	add    %edx,%eax
801018b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
801018b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801018bc:	0f b7 00             	movzwl (%eax),%eax
801018bf:	66 85 c0             	test   %ax,%ax
801018c2:	75 6d                	jne    80101931 <ialloc+0xca>
      memset(dip, 0, sizeof(*dip));
801018c4:	83 ec 04             	sub    $0x4,%esp
801018c7:	68 80 00 00 00       	push   $0x80
801018cc:	6a 00                	push   $0x0
801018ce:	ff 75 ec             	pushl  -0x14(%ebp)
801018d1:	e8 b5 55 00 00       	call   80106e8b <memset>
801018d6:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801018d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801018dc:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
801018e0:	66 89 10             	mov    %dx,(%eax)
#ifdef LS_EXEC
      dip->uid = DEFAULT_UID;
801018e3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801018e6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
      dip->gid = DEFAULT_GID;
801018ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
801018f0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
      dip->mode.asInt = DEFAULT_MODE;
801018f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801018fa:	c7 40 10 ed 01 00 00 	movl   $0x1ed,0x10(%eax)
#endif
      log_write(bp);   // mark it allocated on the disk
80101901:	83 ec 0c             	sub    $0xc,%esp
80101904:	ff 75 f0             	pushl  -0x10(%ebp)
80101907:	e8 23 22 00 00       	call   80103b2f <log_write>
8010190c:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
8010190f:	83 ec 0c             	sub    $0xc,%esp
80101912:	ff 75 f0             	pushl  -0x10(%ebp)
80101915:	e8 25 e9 ff ff       	call   8010023f <brelse>
8010191a:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
8010191d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101920:	83 ec 08             	sub    $0x8,%esp
80101923:	50                   	push   %eax
80101924:	ff 75 08             	pushl  0x8(%ebp)
80101927:	e8 20 01 00 00       	call   80101a4c <iget>
8010192c:	83 c4 10             	add    $0x10,%esp
8010192f:	eb 30                	jmp    80101961 <ialloc+0xfa>
    }
    brelse(bp);
80101931:	83 ec 0c             	sub    $0xc,%esp
80101934:	ff 75 f0             	pushl  -0x10(%ebp)
80101937:	e8 03 e9 ff ff       	call   8010023f <brelse>
8010193c:	83 c4 10             	add    $0x10,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
8010193f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101943:	8b 15 48 42 11 80    	mov    0x80114248,%edx
80101949:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010194c:	39 c2                	cmp    %eax,%edx
8010194e:	0f 87 30 ff ff ff    	ja     80101884 <ialloc+0x1d>
  }
  panic("ialloc: no inodes");
80101954:	83 ec 0c             	sub    $0xc,%esp
80101957:	68 83 a6 10 80       	push   $0x8010a683
8010195c:	e8 36 ec ff ff       	call   80100597 <panic>
}
80101961:	c9                   	leave  
80101962:	c3                   	ret    

80101963 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101963:	f3 0f 1e fb          	endbr32 
80101967:	55                   	push   %ebp
80101968:	89 e5                	mov    %esp,%ebp
8010196a:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010196d:	8b 45 08             	mov    0x8(%ebp),%eax
80101970:	8b 40 04             	mov    0x4(%eax),%eax
80101973:	c1 e8 02             	shr    $0x2,%eax
80101976:	89 c2                	mov    %eax,%edx
80101978:	a1 54 42 11 80       	mov    0x80114254,%eax
8010197d:	01 c2                	add    %eax,%edx
8010197f:	8b 45 08             	mov    0x8(%ebp),%eax
80101982:	8b 00                	mov    (%eax),%eax
80101984:	83 ec 08             	sub    $0x8,%esp
80101987:	52                   	push   %edx
80101988:	50                   	push   %eax
80101989:	e8 31 e8 ff ff       	call   801001bf <bread>
8010198e:	83 c4 10             	add    $0x10,%esp
80101991:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101994:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101997:	8d 50 18             	lea    0x18(%eax),%edx
8010199a:	8b 45 08             	mov    0x8(%ebp),%eax
8010199d:	8b 40 04             	mov    0x4(%eax),%eax
801019a0:	83 e0 03             	and    $0x3,%eax
801019a3:	c1 e0 07             	shl    $0x7,%eax
801019a6:	01 d0                	add    %edx,%eax
801019a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
801019ab:	8b 45 08             	mov    0x8(%ebp),%eax
801019ae:	0f b7 50 10          	movzwl 0x10(%eax),%edx
801019b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019b5:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801019b8:	8b 45 08             	mov    0x8(%ebp),%eax
801019bb:	0f b7 50 12          	movzwl 0x12(%eax),%edx
801019bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019c2:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
801019c6:	8b 45 08             	mov    0x8(%ebp),%eax
801019c9:	0f b7 50 14          	movzwl 0x14(%eax),%edx
801019cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019d0:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801019d4:	8b 45 08             	mov    0x8(%ebp),%eax
801019d7:	0f b7 50 16          	movzwl 0x16(%eax),%edx
801019db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019de:	66 89 50 06          	mov    %dx,0x6(%eax)
#ifdef LS_EXEC
  dip->uid = ip->uid;
801019e2:	8b 45 08             	mov    0x8(%ebp),%eax
801019e5:	8b 50 18             	mov    0x18(%eax),%edx
801019e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019eb:	89 50 08             	mov    %edx,0x8(%eax)
  dip->gid = ip->gid;
801019ee:	8b 45 08             	mov    0x8(%ebp),%eax
801019f1:	8b 50 1c             	mov    0x1c(%eax),%edx
801019f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019f7:	89 50 0c             	mov    %edx,0xc(%eax)
  dip->mode.asInt = ip->mode.asInt;
801019fa:	8b 45 08             	mov    0x8(%ebp),%eax
801019fd:	8b 50 20             	mov    0x20(%eax),%edx
80101a00:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a03:	89 50 10             	mov    %edx,0x10(%eax)
#endif
  dip->size = ip->size;
80101a06:	8b 45 08             	mov    0x8(%ebp),%eax
80101a09:	8b 50 24             	mov    0x24(%eax),%edx
80101a0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a0f:	89 50 14             	mov    %edx,0x14(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a12:	8b 45 08             	mov    0x8(%ebp),%eax
80101a15:	8d 50 28             	lea    0x28(%eax),%edx
80101a18:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a1b:	83 c0 18             	add    $0x18,%eax
80101a1e:	83 ec 04             	sub    $0x4,%esp
80101a21:	6a 68                	push   $0x68
80101a23:	52                   	push   %edx
80101a24:	50                   	push   %eax
80101a25:	e8 28 55 00 00       	call   80106f52 <memmove>
80101a2a:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101a2d:	83 ec 0c             	sub    $0xc,%esp
80101a30:	ff 75 f4             	pushl  -0xc(%ebp)
80101a33:	e8 f7 20 00 00       	call   80103b2f <log_write>
80101a38:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101a3b:	83 ec 0c             	sub    $0xc,%esp
80101a3e:	ff 75 f4             	pushl  -0xc(%ebp)
80101a41:	e8 f9 e7 ff ff       	call   8010023f <brelse>
80101a46:	83 c4 10             	add    $0x10,%esp
}
80101a49:	90                   	nop
80101a4a:	c9                   	leave  
80101a4b:	c3                   	ret    

80101a4c <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101a4c:	f3 0f 1e fb          	endbr32 
80101a50:	55                   	push   %ebp
80101a51:	89 e5                	mov    %esp,%ebp
80101a53:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101a56:	83 ec 0c             	sub    $0xc,%esp
80101a59:	68 60 42 11 80       	push   $0x80114260
80101a5e:	e8 ac 51 00 00       	call   80106c0f <acquire>
80101a63:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101a66:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101a6d:	c7 45 f4 94 42 11 80 	movl   $0x80114294,-0xc(%ebp)
80101a74:	eb 60                	jmp    80101ad6 <iget+0x8a>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a79:	8b 40 08             	mov    0x8(%eax),%eax
80101a7c:	85 c0                	test   %eax,%eax
80101a7e:	7e 39                	jle    80101ab9 <iget+0x6d>
80101a80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a83:	8b 00                	mov    (%eax),%eax
80101a85:	39 45 08             	cmp    %eax,0x8(%ebp)
80101a88:	75 2f                	jne    80101ab9 <iget+0x6d>
80101a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a8d:	8b 40 04             	mov    0x4(%eax),%eax
80101a90:	39 45 0c             	cmp    %eax,0xc(%ebp)
80101a93:	75 24                	jne    80101ab9 <iget+0x6d>
      ip->ref++;
80101a95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a98:	8b 40 08             	mov    0x8(%eax),%eax
80101a9b:	8d 50 01             	lea    0x1(%eax),%edx
80101a9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101aa1:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101aa4:	83 ec 0c             	sub    $0xc,%esp
80101aa7:	68 60 42 11 80       	push   $0x80114260
80101aac:	e8 c9 51 00 00       	call   80106c7a <release>
80101ab1:	83 c4 10             	add    $0x10,%esp
      return ip;
80101ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ab7:	eb 77                	jmp    80101b30 <iget+0xe4>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101ab9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101abd:	75 10                	jne    80101acf <iget+0x83>
80101abf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ac2:	8b 40 08             	mov    0x8(%eax),%eax
80101ac5:	85 c0                	test   %eax,%eax
80101ac7:	75 06                	jne    80101acf <iget+0x83>
      empty = ip;
80101ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101acc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101acf:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
80101ad6:	81 7d f4 b4 5e 11 80 	cmpl   $0x80115eb4,-0xc(%ebp)
80101add:	72 97                	jb     80101a76 <iget+0x2a>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101adf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101ae3:	75 0d                	jne    80101af2 <iget+0xa6>
    panic("iget: no inodes");
80101ae5:	83 ec 0c             	sub    $0xc,%esp
80101ae8:	68 95 a6 10 80       	push   $0x8010a695
80101aed:	e8 a5 ea ff ff       	call   80100597 <panic>

  ip = empty;
80101af2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101af5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101af8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101afb:	8b 55 08             	mov    0x8(%ebp),%edx
80101afe:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
80101b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b03:	8b 55 0c             	mov    0xc(%ebp),%edx
80101b06:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101b09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b0c:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
80101b13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101b16:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101b1d:	83 ec 0c             	sub    $0xc,%esp
80101b20:	68 60 42 11 80       	push   $0x80114260
80101b25:	e8 50 51 00 00       	call   80106c7a <release>
80101b2a:	83 c4 10             	add    $0x10,%esp

  return ip;
80101b2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80101b30:	c9                   	leave  
80101b31:	c3                   	ret    

80101b32 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101b32:	f3 0f 1e fb          	endbr32 
80101b36:	55                   	push   %ebp
80101b37:	89 e5                	mov    %esp,%ebp
80101b39:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101b3c:	83 ec 0c             	sub    $0xc,%esp
80101b3f:	68 60 42 11 80       	push   $0x80114260
80101b44:	e8 c6 50 00 00       	call   80106c0f <acquire>
80101b49:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
80101b4c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b4f:	8b 40 08             	mov    0x8(%eax),%eax
80101b52:	8d 50 01             	lea    0x1(%eax),%edx
80101b55:	8b 45 08             	mov    0x8(%ebp),%eax
80101b58:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101b5b:	83 ec 0c             	sub    $0xc,%esp
80101b5e:	68 60 42 11 80       	push   $0x80114260
80101b63:	e8 12 51 00 00       	call   80106c7a <release>
80101b68:	83 c4 10             	add    $0x10,%esp
  return ip;
80101b6b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101b6e:	c9                   	leave  
80101b6f:	c3                   	ret    

80101b70 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101b70:	f3 0f 1e fb          	endbr32 
80101b74:	55                   	push   %ebp
80101b75:	89 e5                	mov    %esp,%ebp
80101b77:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101b7a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101b7e:	74 0a                	je     80101b8a <ilock+0x1a>
80101b80:	8b 45 08             	mov    0x8(%ebp),%eax
80101b83:	8b 40 08             	mov    0x8(%eax),%eax
80101b86:	85 c0                	test   %eax,%eax
80101b88:	7f 0d                	jg     80101b97 <ilock+0x27>
    panic("ilock");
80101b8a:	83 ec 0c             	sub    $0xc,%esp
80101b8d:	68 a5 a6 10 80       	push   $0x8010a6a5
80101b92:	e8 00 ea ff ff       	call   80100597 <panic>

  acquire(&icache.lock);
80101b97:	83 ec 0c             	sub    $0xc,%esp
80101b9a:	68 60 42 11 80       	push   $0x80114260
80101b9f:	e8 6b 50 00 00       	call   80106c0f <acquire>
80101ba4:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
80101ba7:	eb 13                	jmp    80101bbc <ilock+0x4c>
    sleep(ip, &icache.lock);
80101ba9:	83 ec 08             	sub    $0x8,%esp
80101bac:	68 60 42 11 80       	push   $0x80114260
80101bb1:	ff 75 08             	pushl  0x8(%ebp)
80101bb4:	e8 55 3d 00 00       	call   8010590e <sleep>
80101bb9:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
80101bbc:	8b 45 08             	mov    0x8(%ebp),%eax
80101bbf:	8b 40 0c             	mov    0xc(%eax),%eax
80101bc2:	83 e0 01             	and    $0x1,%eax
80101bc5:	85 c0                	test   %eax,%eax
80101bc7:	75 e0                	jne    80101ba9 <ilock+0x39>
  ip->flags |= I_BUSY;
80101bc9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bcc:	8b 40 0c             	mov    0xc(%eax),%eax
80101bcf:	83 c8 01             	or     $0x1,%eax
80101bd2:	89 c2                	mov    %eax,%edx
80101bd4:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd7:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
80101bda:	83 ec 0c             	sub    $0xc,%esp
80101bdd:	68 60 42 11 80       	push   $0x80114260
80101be2:	e8 93 50 00 00       	call   80106c7a <release>
80101be7:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
80101bea:	8b 45 08             	mov    0x8(%ebp),%eax
80101bed:	8b 40 0c             	mov    0xc(%eax),%eax
80101bf0:	83 e0 02             	and    $0x2,%eax
80101bf3:	85 c0                	test   %eax,%eax
80101bf5:	0f 85 f8 00 00 00    	jne    80101cf3 <ilock+0x183>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101bfb:	8b 45 08             	mov    0x8(%ebp),%eax
80101bfe:	8b 40 04             	mov    0x4(%eax),%eax
80101c01:	c1 e8 02             	shr    $0x2,%eax
80101c04:	89 c2                	mov    %eax,%edx
80101c06:	a1 54 42 11 80       	mov    0x80114254,%eax
80101c0b:	01 c2                	add    %eax,%edx
80101c0d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c10:	8b 00                	mov    (%eax),%eax
80101c12:	83 ec 08             	sub    $0x8,%esp
80101c15:	52                   	push   %edx
80101c16:	50                   	push   %eax
80101c17:	e8 a3 e5 ff ff       	call   801001bf <bread>
80101c1c:	83 c4 10             	add    $0x10,%esp
80101c1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101c22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c25:	8d 50 18             	lea    0x18(%eax),%edx
80101c28:	8b 45 08             	mov    0x8(%ebp),%eax
80101c2b:	8b 40 04             	mov    0x4(%eax),%eax
80101c2e:	83 e0 03             	and    $0x3,%eax
80101c31:	c1 e0 07             	shl    $0x7,%eax
80101c34:	01 d0                	add    %edx,%eax
80101c36:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101c39:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c3c:	0f b7 10             	movzwl (%eax),%edx
80101c3f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c42:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101c46:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c49:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101c4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c50:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
80101c54:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c57:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101c5b:	8b 45 08             	mov    0x8(%ebp),%eax
80101c5e:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
80101c62:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c65:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101c69:	8b 45 08             	mov    0x8(%ebp),%eax
80101c6c:	66 89 50 16          	mov    %dx,0x16(%eax)
#ifdef LS_EXEC
    ip->uid = dip->uid;
80101c70:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c73:	8b 50 08             	mov    0x8(%eax),%edx
80101c76:	8b 45 08             	mov    0x8(%ebp),%eax
80101c79:	89 50 18             	mov    %edx,0x18(%eax)
    ip->gid = dip->gid;
80101c7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c7f:	8b 50 0c             	mov    0xc(%eax),%edx
80101c82:	8b 45 08             	mov    0x8(%ebp),%eax
80101c85:	89 50 1c             	mov    %edx,0x1c(%eax)
    (ip->mode.asInt) = (dip->mode.asInt);
80101c88:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c8b:	8b 50 10             	mov    0x10(%eax),%edx
80101c8e:	8b 45 08             	mov    0x8(%ebp),%eax
80101c91:	89 50 20             	mov    %edx,0x20(%eax)
#endif
    ip->size = dip->size;
80101c94:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c97:	8b 50 14             	mov    0x14(%eax),%edx
80101c9a:	8b 45 08             	mov    0x8(%ebp),%eax
80101c9d:	89 50 24             	mov    %edx,0x24(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101ca0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ca3:	8d 50 18             	lea    0x18(%eax),%edx
80101ca6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ca9:	83 c0 28             	add    $0x28,%eax
80101cac:	83 ec 04             	sub    $0x4,%esp
80101caf:	6a 68                	push   $0x68
80101cb1:	52                   	push   %edx
80101cb2:	50                   	push   %eax
80101cb3:	e8 9a 52 00 00       	call   80106f52 <memmove>
80101cb8:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101cbb:	83 ec 0c             	sub    $0xc,%esp
80101cbe:	ff 75 f4             	pushl  -0xc(%ebp)
80101cc1:	e8 79 e5 ff ff       	call   8010023f <brelse>
80101cc6:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101cc9:	8b 45 08             	mov    0x8(%ebp),%eax
80101ccc:	8b 40 0c             	mov    0xc(%eax),%eax
80101ccf:	83 c8 02             	or     $0x2,%eax
80101cd2:	89 c2                	mov    %eax,%edx
80101cd4:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd7:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101cda:	8b 45 08             	mov    0x8(%ebp),%eax
80101cdd:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101ce1:	66 85 c0             	test   %ax,%ax
80101ce4:	75 0d                	jne    80101cf3 <ilock+0x183>
      panic("ilock: no type");
80101ce6:	83 ec 0c             	sub    $0xc,%esp
80101ce9:	68 ab a6 10 80       	push   $0x8010a6ab
80101cee:	e8 a4 e8 ff ff       	call   80100597 <panic>
  }
}
80101cf3:	90                   	nop
80101cf4:	c9                   	leave  
80101cf5:	c3                   	ret    

80101cf6 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101cf6:	f3 0f 1e fb          	endbr32 
80101cfa:	55                   	push   %ebp
80101cfb:	89 e5                	mov    %esp,%ebp
80101cfd:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101d00:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101d04:	74 17                	je     80101d1d <iunlock+0x27>
80101d06:	8b 45 08             	mov    0x8(%ebp),%eax
80101d09:	8b 40 0c             	mov    0xc(%eax),%eax
80101d0c:	83 e0 01             	and    $0x1,%eax
80101d0f:	85 c0                	test   %eax,%eax
80101d11:	74 0a                	je     80101d1d <iunlock+0x27>
80101d13:	8b 45 08             	mov    0x8(%ebp),%eax
80101d16:	8b 40 08             	mov    0x8(%eax),%eax
80101d19:	85 c0                	test   %eax,%eax
80101d1b:	7f 0d                	jg     80101d2a <iunlock+0x34>
    panic("iunlock");
80101d1d:	83 ec 0c             	sub    $0xc,%esp
80101d20:	68 ba a6 10 80       	push   $0x8010a6ba
80101d25:	e8 6d e8 ff ff       	call   80100597 <panic>

  acquire(&icache.lock);
80101d2a:	83 ec 0c             	sub    $0xc,%esp
80101d2d:	68 60 42 11 80       	push   $0x80114260
80101d32:	e8 d8 4e 00 00       	call   80106c0f <acquire>
80101d37:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101d3a:	8b 45 08             	mov    0x8(%ebp),%eax
80101d3d:	8b 40 0c             	mov    0xc(%eax),%eax
80101d40:	83 e0 fe             	and    $0xfffffffe,%eax
80101d43:	89 c2                	mov    %eax,%edx
80101d45:	8b 45 08             	mov    0x8(%ebp),%eax
80101d48:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101d4b:	83 ec 0c             	sub    $0xc,%esp
80101d4e:	ff 75 08             	pushl  0x8(%ebp)
80101d51:	e8 15 3e 00 00       	call   80105b6b <wakeup>
80101d56:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101d59:	83 ec 0c             	sub    $0xc,%esp
80101d5c:	68 60 42 11 80       	push   $0x80114260
80101d61:	e8 14 4f 00 00       	call   80106c7a <release>
80101d66:	83 c4 10             	add    $0x10,%esp
}
80101d69:	90                   	nop
80101d6a:	c9                   	leave  
80101d6b:	c3                   	ret    

80101d6c <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101d6c:	f3 0f 1e fb          	endbr32 
80101d70:	55                   	push   %ebp
80101d71:	89 e5                	mov    %esp,%ebp
80101d73:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101d76:	83 ec 0c             	sub    $0xc,%esp
80101d79:	68 60 42 11 80       	push   $0x80114260
80101d7e:	e8 8c 4e 00 00       	call   80106c0f <acquire>
80101d83:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101d86:	8b 45 08             	mov    0x8(%ebp),%eax
80101d89:	8b 40 08             	mov    0x8(%eax),%eax
80101d8c:	83 f8 01             	cmp    $0x1,%eax
80101d8f:	0f 85 a9 00 00 00    	jne    80101e3e <iput+0xd2>
80101d95:	8b 45 08             	mov    0x8(%ebp),%eax
80101d98:	8b 40 0c             	mov    0xc(%eax),%eax
80101d9b:	83 e0 02             	and    $0x2,%eax
80101d9e:	85 c0                	test   %eax,%eax
80101da0:	0f 84 98 00 00 00    	je     80101e3e <iput+0xd2>
80101da6:	8b 45 08             	mov    0x8(%ebp),%eax
80101da9:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101dad:	66 85 c0             	test   %ax,%ax
80101db0:	0f 85 88 00 00 00    	jne    80101e3e <iput+0xd2>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
80101db6:	8b 45 08             	mov    0x8(%ebp),%eax
80101db9:	8b 40 0c             	mov    0xc(%eax),%eax
80101dbc:	83 e0 01             	and    $0x1,%eax
80101dbf:	85 c0                	test   %eax,%eax
80101dc1:	74 0d                	je     80101dd0 <iput+0x64>
      panic("iput busy");
80101dc3:	83 ec 0c             	sub    $0xc,%esp
80101dc6:	68 c2 a6 10 80       	push   $0x8010a6c2
80101dcb:	e8 c7 e7 ff ff       	call   80100597 <panic>
    ip->flags |= I_BUSY;
80101dd0:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd3:	8b 40 0c             	mov    0xc(%eax),%eax
80101dd6:	83 c8 01             	or     $0x1,%eax
80101dd9:	89 c2                	mov    %eax,%edx
80101ddb:	8b 45 08             	mov    0x8(%ebp),%eax
80101dde:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101de1:	83 ec 0c             	sub    $0xc,%esp
80101de4:	68 60 42 11 80       	push   $0x80114260
80101de9:	e8 8c 4e 00 00       	call   80106c7a <release>
80101dee:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101df1:	83 ec 0c             	sub    $0xc,%esp
80101df4:	ff 75 08             	pushl  0x8(%ebp)
80101df7:	e8 b1 01 00 00       	call   80101fad <itrunc>
80101dfc:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101dff:	8b 45 08             	mov    0x8(%ebp),%eax
80101e02:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101e08:	83 ec 0c             	sub    $0xc,%esp
80101e0b:	ff 75 08             	pushl  0x8(%ebp)
80101e0e:	e8 50 fb ff ff       	call   80101963 <iupdate>
80101e13:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101e16:	83 ec 0c             	sub    $0xc,%esp
80101e19:	68 60 42 11 80       	push   $0x80114260
80101e1e:	e8 ec 4d 00 00       	call   80106c0f <acquire>
80101e23:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101e26:	8b 45 08             	mov    0x8(%ebp),%eax
80101e29:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101e30:	83 ec 0c             	sub    $0xc,%esp
80101e33:	ff 75 08             	pushl  0x8(%ebp)
80101e36:	e8 30 3d 00 00       	call   80105b6b <wakeup>
80101e3b:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101e3e:	8b 45 08             	mov    0x8(%ebp),%eax
80101e41:	8b 40 08             	mov    0x8(%eax),%eax
80101e44:	8d 50 ff             	lea    -0x1(%eax),%edx
80101e47:	8b 45 08             	mov    0x8(%ebp),%eax
80101e4a:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101e4d:	83 ec 0c             	sub    $0xc,%esp
80101e50:	68 60 42 11 80       	push   $0x80114260
80101e55:	e8 20 4e 00 00       	call   80106c7a <release>
80101e5a:	83 c4 10             	add    $0x10,%esp
}
80101e5d:	90                   	nop
80101e5e:	c9                   	leave  
80101e5f:	c3                   	ret    

80101e60 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101e60:	f3 0f 1e fb          	endbr32 
80101e64:	55                   	push   %ebp
80101e65:	89 e5                	mov    %esp,%ebp
80101e67:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101e6a:	83 ec 0c             	sub    $0xc,%esp
80101e6d:	ff 75 08             	pushl  0x8(%ebp)
80101e70:	e8 81 fe ff ff       	call   80101cf6 <iunlock>
80101e75:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101e78:	83 ec 0c             	sub    $0xc,%esp
80101e7b:	ff 75 08             	pushl  0x8(%ebp)
80101e7e:	e8 e9 fe ff ff       	call   80101d6c <iput>
80101e83:	83 c4 10             	add    $0x10,%esp
}
80101e86:	90                   	nop
80101e87:	c9                   	leave  
80101e88:	c3                   	ret    

80101e89 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101e89:	f3 0f 1e fb          	endbr32 
80101e8d:	55                   	push   %ebp
80101e8e:	89 e5                	mov    %esp,%ebp
80101e90:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101e93:	83 7d 0c 18          	cmpl   $0x18,0xc(%ebp)
80101e97:	77 42                	ja     80101edb <bmap+0x52>
    if((addr = ip->addrs[bn]) == 0)
80101e99:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9c:	8b 55 0c             	mov    0xc(%ebp),%edx
80101e9f:	83 c2 08             	add    $0x8,%edx
80101ea2:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80101ea6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ea9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101ead:	75 24                	jne    80101ed3 <bmap+0x4a>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101eaf:	8b 45 08             	mov    0x8(%ebp),%eax
80101eb2:	8b 00                	mov    (%eax),%eax
80101eb4:	83 ec 0c             	sub    $0xc,%esp
80101eb7:	50                   	push   %eax
80101eb8:	e8 ff f6 ff ff       	call   801015bc <balloc>
80101ebd:	83 c4 10             	add    $0x10,%esp
80101ec0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ec3:	8b 45 08             	mov    0x8(%ebp),%eax
80101ec6:	8b 55 0c             	mov    0xc(%ebp),%edx
80101ec9:	8d 4a 08             	lea    0x8(%edx),%ecx
80101ecc:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101ecf:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
    return addr;
80101ed3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ed6:	e9 d0 00 00 00       	jmp    80101fab <bmap+0x122>
  }
  bn -= NDIRECT;
80101edb:	83 6d 0c 19          	subl   $0x19,0xc(%ebp)

  if(bn < NINDIRECT){
80101edf:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101ee3:	0f 87 b5 00 00 00    	ja     80101f9e <bmap+0x115>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101ee9:	8b 45 08             	mov    0x8(%ebp),%eax
80101eec:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101ef2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ef5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101ef9:	75 20                	jne    80101f1b <bmap+0x92>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101efb:	8b 45 08             	mov    0x8(%ebp),%eax
80101efe:	8b 00                	mov    (%eax),%eax
80101f00:	83 ec 0c             	sub    $0xc,%esp
80101f03:	50                   	push   %eax
80101f04:	e8 b3 f6 ff ff       	call   801015bc <balloc>
80101f09:	83 c4 10             	add    $0x10,%esp
80101f0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101f0f:	8b 45 08             	mov    0x8(%ebp),%eax
80101f12:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101f15:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    bp = bread(ip->dev, addr);
80101f1b:	8b 45 08             	mov    0x8(%ebp),%eax
80101f1e:	8b 00                	mov    (%eax),%eax
80101f20:	83 ec 08             	sub    $0x8,%esp
80101f23:	ff 75 f4             	pushl  -0xc(%ebp)
80101f26:	50                   	push   %eax
80101f27:	e8 93 e2 ff ff       	call   801001bf <bread>
80101f2c:	83 c4 10             	add    $0x10,%esp
80101f2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101f32:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f35:	83 c0 18             	add    $0x18,%eax
80101f38:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101f3b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f3e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101f45:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f48:	01 d0                	add    %edx,%eax
80101f4a:	8b 00                	mov    (%eax),%eax
80101f4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101f4f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101f53:	75 36                	jne    80101f8b <bmap+0x102>
      a[bn] = addr = balloc(ip->dev);
80101f55:	8b 45 08             	mov    0x8(%ebp),%eax
80101f58:	8b 00                	mov    (%eax),%eax
80101f5a:	83 ec 0c             	sub    $0xc,%esp
80101f5d:	50                   	push   %eax
80101f5e:	e8 59 f6 ff ff       	call   801015bc <balloc>
80101f63:	83 c4 10             	add    $0x10,%esp
80101f66:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101f69:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f6c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101f73:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f76:	01 c2                	add    %eax,%edx
80101f78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f7b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101f7d:	83 ec 0c             	sub    $0xc,%esp
80101f80:	ff 75 f0             	pushl  -0x10(%ebp)
80101f83:	e8 a7 1b 00 00       	call   80103b2f <log_write>
80101f88:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101f8b:	83 ec 0c             	sub    $0xc,%esp
80101f8e:	ff 75 f0             	pushl  -0x10(%ebp)
80101f91:	e8 a9 e2 ff ff       	call   8010023f <brelse>
80101f96:	83 c4 10             	add    $0x10,%esp
    return addr;
80101f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101f9c:	eb 0d                	jmp    80101fab <bmap+0x122>
  }

  panic("bmap: out of range");
80101f9e:	83 ec 0c             	sub    $0xc,%esp
80101fa1:	68 cc a6 10 80       	push   $0x8010a6cc
80101fa6:	e8 ec e5 ff ff       	call   80100597 <panic>
}
80101fab:	c9                   	leave  
80101fac:	c3                   	ret    

80101fad <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101fad:	f3 0f 1e fb          	endbr32 
80101fb1:	55                   	push   %ebp
80101fb2:	89 e5                	mov    %esp,%ebp
80101fb4:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101fb7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101fbe:	eb 45                	jmp    80102005 <itrunc+0x58>
    if(ip->addrs[i]){
80101fc0:	8b 45 08             	mov    0x8(%ebp),%eax
80101fc3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101fc6:	83 c2 08             	add    $0x8,%edx
80101fc9:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80101fcd:	85 c0                	test   %eax,%eax
80101fcf:	74 30                	je     80102001 <itrunc+0x54>
      bfree(ip->dev, ip->addrs[i]);
80101fd1:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd4:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101fd7:	83 c2 08             	add    $0x8,%edx
80101fda:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80101fde:	8b 55 08             	mov    0x8(%ebp),%edx
80101fe1:	8b 12                	mov    (%edx),%edx
80101fe3:	83 ec 08             	sub    $0x8,%esp
80101fe6:	50                   	push   %eax
80101fe7:	52                   	push   %edx
80101fe8:	e8 1f f7 ff ff       	call   8010170c <bfree>
80101fed:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101ff0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ff3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101ff6:	83 c2 08             	add    $0x8,%edx
80101ff9:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80102000:	00 
  for(i = 0; i < NDIRECT; i++){
80102001:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102005:	83 7d f4 18          	cmpl   $0x18,-0xc(%ebp)
80102009:	7e b5                	jle    80101fc0 <itrunc+0x13>
    }
  }
  
  if(ip->addrs[NDIRECT]){
8010200b:	8b 45 08             	mov    0x8(%ebp),%eax
8010200e:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102014:	85 c0                	test   %eax,%eax
80102016:	0f 84 aa 00 00 00    	je     801020c6 <itrunc+0x119>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010201c:	8b 45 08             	mov    0x8(%ebp),%eax
8010201f:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80102025:	8b 45 08             	mov    0x8(%ebp),%eax
80102028:	8b 00                	mov    (%eax),%eax
8010202a:	83 ec 08             	sub    $0x8,%esp
8010202d:	52                   	push   %edx
8010202e:	50                   	push   %eax
8010202f:	e8 8b e1 ff ff       	call   801001bf <bread>
80102034:	83 c4 10             	add    $0x10,%esp
80102037:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
8010203a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010203d:	83 c0 18             	add    $0x18,%eax
80102040:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80102043:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010204a:	eb 3c                	jmp    80102088 <itrunc+0xdb>
      if(a[j])
8010204c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010204f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80102056:	8b 45 e8             	mov    -0x18(%ebp),%eax
80102059:	01 d0                	add    %edx,%eax
8010205b:	8b 00                	mov    (%eax),%eax
8010205d:	85 c0                	test   %eax,%eax
8010205f:	74 23                	je     80102084 <itrunc+0xd7>
        bfree(ip->dev, a[j]);
80102061:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102064:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010206b:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010206e:	01 d0                	add    %edx,%eax
80102070:	8b 00                	mov    (%eax),%eax
80102072:	8b 55 08             	mov    0x8(%ebp),%edx
80102075:	8b 12                	mov    (%edx),%edx
80102077:	83 ec 08             	sub    $0x8,%esp
8010207a:	50                   	push   %eax
8010207b:	52                   	push   %edx
8010207c:	e8 8b f6 ff ff       	call   8010170c <bfree>
80102081:	83 c4 10             	add    $0x10,%esp
    for(j = 0; j < NINDIRECT; j++){
80102084:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80102088:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010208b:	83 f8 7f             	cmp    $0x7f,%eax
8010208e:	76 bc                	jbe    8010204c <itrunc+0x9f>
    }
    brelse(bp);
80102090:	83 ec 0c             	sub    $0xc,%esp
80102093:	ff 75 ec             	pushl  -0x14(%ebp)
80102096:	e8 a4 e1 ff ff       	call   8010023f <brelse>
8010209b:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010209e:	8b 45 08             	mov    0x8(%ebp),%eax
801020a1:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801020a7:	8b 55 08             	mov    0x8(%ebp),%edx
801020aa:	8b 12                	mov    (%edx),%edx
801020ac:	83 ec 08             	sub    $0x8,%esp
801020af:	50                   	push   %eax
801020b0:	52                   	push   %edx
801020b1:	e8 56 f6 ff ff       	call   8010170c <bfree>
801020b6:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
801020b9:	8b 45 08             	mov    0x8(%ebp),%eax
801020bc:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
801020c3:	00 00 00 
  }

  ip->size = 0;
801020c6:	8b 45 08             	mov    0x8(%ebp),%eax
801020c9:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
  iupdate(ip);
801020d0:	83 ec 0c             	sub    $0xc,%esp
801020d3:	ff 75 08             	pushl  0x8(%ebp)
801020d6:	e8 88 f8 ff ff       	call   80101963 <iupdate>
801020db:	83 c4 10             	add    $0x10,%esp
}
801020de:	90                   	nop
801020df:	c9                   	leave  
801020e0:	c3                   	ret    

801020e1 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
801020e1:	f3 0f 1e fb          	endbr32 
801020e5:	55                   	push   %ebp
801020e6:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
801020e8:	8b 45 08             	mov    0x8(%ebp),%eax
801020eb:	8b 00                	mov    (%eax),%eax
801020ed:	89 c2                	mov    %eax,%edx
801020ef:	8b 45 0c             	mov    0xc(%ebp),%eax
801020f2:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
801020f5:	8b 45 08             	mov    0x8(%ebp),%eax
801020f8:	8b 50 04             	mov    0x4(%eax),%edx
801020fb:	8b 45 0c             	mov    0xc(%ebp),%eax
801020fe:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80102101:	8b 45 08             	mov    0x8(%ebp),%eax
80102104:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80102108:	8b 45 0c             	mov    0xc(%ebp),%eax
8010210b:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
8010210e:	8b 45 08             	mov    0x8(%ebp),%eax
80102111:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80102115:	8b 45 0c             	mov    0xc(%ebp),%eax
80102118:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
8010211c:	8b 45 08             	mov    0x8(%ebp),%eax
8010211f:	8b 50 24             	mov    0x24(%eax),%edx
80102122:	8b 45 0c             	mov    0xc(%ebp),%eax
80102125:	89 50 1c             	mov    %edx,0x1c(%eax)
#ifdef LS_EXEC
  st->uid = ip->uid;
80102128:	8b 45 08             	mov    0x8(%ebp),%eax
8010212b:	8b 50 18             	mov    0x18(%eax),%edx
8010212e:	8b 45 0c             	mov    0xc(%ebp),%eax
80102131:	89 50 10             	mov    %edx,0x10(%eax)
  st->gid = ip->gid;
80102134:	8b 45 08             	mov    0x8(%ebp),%eax
80102137:	8b 50 1c             	mov    0x1c(%eax),%edx
8010213a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010213d:	89 50 14             	mov    %edx,0x14(%eax)
  (st->mode.asInt) = (ip->mode.asInt);
80102140:	8b 45 08             	mov    0x8(%ebp),%eax
80102143:	8b 50 20             	mov    0x20(%eax),%edx
80102146:	8b 45 0c             	mov    0xc(%ebp),%eax
80102149:	89 50 18             	mov    %edx,0x18(%eax)
#endif
}
8010214c:	90                   	nop
8010214d:	5d                   	pop    %ebp
8010214e:	c3                   	ret    

8010214f <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
8010214f:	f3 0f 1e fb          	endbr32 
80102153:	55                   	push   %ebp
80102154:	89 e5                	mov    %esp,%ebp
80102156:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102159:	8b 45 08             	mov    0x8(%ebp),%eax
8010215c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102160:	66 83 f8 03          	cmp    $0x3,%ax
80102164:	75 5c                	jne    801021c2 <readi+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102166:	8b 45 08             	mov    0x8(%ebp),%eax
80102169:	0f b7 40 12          	movzwl 0x12(%eax),%eax
8010216d:	66 85 c0             	test   %ax,%ax
80102170:	78 20                	js     80102192 <readi+0x43>
80102172:	8b 45 08             	mov    0x8(%ebp),%eax
80102175:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102179:	66 83 f8 09          	cmp    $0x9,%ax
8010217d:	7f 13                	jg     80102192 <readi+0x43>
8010217f:	8b 45 08             	mov    0x8(%ebp),%eax
80102182:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102186:	98                   	cwtl   
80102187:	8b 04 c5 e0 41 11 80 	mov    -0x7feebe20(,%eax,8),%eax
8010218e:	85 c0                	test   %eax,%eax
80102190:	75 0a                	jne    8010219c <readi+0x4d>
      return -1;
80102192:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102197:	e9 0a 01 00 00       	jmp    801022a6 <readi+0x157>
    return devsw[ip->major].read(ip, dst, n);
8010219c:	8b 45 08             	mov    0x8(%ebp),%eax
8010219f:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801021a3:	98                   	cwtl   
801021a4:	8b 04 c5 e0 41 11 80 	mov    -0x7feebe20(,%eax,8),%eax
801021ab:	8b 55 14             	mov    0x14(%ebp),%edx
801021ae:	83 ec 04             	sub    $0x4,%esp
801021b1:	52                   	push   %edx
801021b2:	ff 75 0c             	pushl  0xc(%ebp)
801021b5:	ff 75 08             	pushl  0x8(%ebp)
801021b8:	ff d0                	call   *%eax
801021ba:	83 c4 10             	add    $0x10,%esp
801021bd:	e9 e4 00 00 00       	jmp    801022a6 <readi+0x157>
  }

  if(off > ip->size || off + n < off)
801021c2:	8b 45 08             	mov    0x8(%ebp),%eax
801021c5:	8b 40 24             	mov    0x24(%eax),%eax
801021c8:	39 45 10             	cmp    %eax,0x10(%ebp)
801021cb:	77 0d                	ja     801021da <readi+0x8b>
801021cd:	8b 55 10             	mov    0x10(%ebp),%edx
801021d0:	8b 45 14             	mov    0x14(%ebp),%eax
801021d3:	01 d0                	add    %edx,%eax
801021d5:	39 45 10             	cmp    %eax,0x10(%ebp)
801021d8:	76 0a                	jbe    801021e4 <readi+0x95>
    return -1;
801021da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021df:	e9 c2 00 00 00       	jmp    801022a6 <readi+0x157>
  if(off + n > ip->size)
801021e4:	8b 55 10             	mov    0x10(%ebp),%edx
801021e7:	8b 45 14             	mov    0x14(%ebp),%eax
801021ea:	01 c2                	add    %eax,%edx
801021ec:	8b 45 08             	mov    0x8(%ebp),%eax
801021ef:	8b 40 24             	mov    0x24(%eax),%eax
801021f2:	39 c2                	cmp    %eax,%edx
801021f4:	76 0c                	jbe    80102202 <readi+0xb3>
    n = ip->size - off;
801021f6:	8b 45 08             	mov    0x8(%ebp),%eax
801021f9:	8b 40 24             	mov    0x24(%eax),%eax
801021fc:	2b 45 10             	sub    0x10(%ebp),%eax
801021ff:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102202:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102209:	e9 89 00 00 00       	jmp    80102297 <readi+0x148>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010220e:	8b 45 10             	mov    0x10(%ebp),%eax
80102211:	c1 e8 09             	shr    $0x9,%eax
80102214:	83 ec 08             	sub    $0x8,%esp
80102217:	50                   	push   %eax
80102218:	ff 75 08             	pushl  0x8(%ebp)
8010221b:	e8 69 fc ff ff       	call   80101e89 <bmap>
80102220:	83 c4 10             	add    $0x10,%esp
80102223:	8b 55 08             	mov    0x8(%ebp),%edx
80102226:	8b 12                	mov    (%edx),%edx
80102228:	83 ec 08             	sub    $0x8,%esp
8010222b:	50                   	push   %eax
8010222c:	52                   	push   %edx
8010222d:	e8 8d df ff ff       	call   801001bf <bread>
80102232:	83 c4 10             	add    $0x10,%esp
80102235:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102238:	8b 45 10             	mov    0x10(%ebp),%eax
8010223b:	25 ff 01 00 00       	and    $0x1ff,%eax
80102240:	ba 00 02 00 00       	mov    $0x200,%edx
80102245:	29 c2                	sub    %eax,%edx
80102247:	8b 45 14             	mov    0x14(%ebp),%eax
8010224a:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010224d:	39 c2                	cmp    %eax,%edx
8010224f:	0f 46 c2             	cmovbe %edx,%eax
80102252:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80102255:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102258:	8d 50 18             	lea    0x18(%eax),%edx
8010225b:	8b 45 10             	mov    0x10(%ebp),%eax
8010225e:	25 ff 01 00 00       	and    $0x1ff,%eax
80102263:	01 d0                	add    %edx,%eax
80102265:	83 ec 04             	sub    $0x4,%esp
80102268:	ff 75 ec             	pushl  -0x14(%ebp)
8010226b:	50                   	push   %eax
8010226c:	ff 75 0c             	pushl  0xc(%ebp)
8010226f:	e8 de 4c 00 00       	call   80106f52 <memmove>
80102274:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102277:	83 ec 0c             	sub    $0xc,%esp
8010227a:	ff 75 f0             	pushl  -0x10(%ebp)
8010227d:	e8 bd df ff ff       	call   8010023f <brelse>
80102282:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102285:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102288:	01 45 f4             	add    %eax,-0xc(%ebp)
8010228b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010228e:	01 45 10             	add    %eax,0x10(%ebp)
80102291:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102294:	01 45 0c             	add    %eax,0xc(%ebp)
80102297:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010229a:	3b 45 14             	cmp    0x14(%ebp),%eax
8010229d:	0f 82 6b ff ff ff    	jb     8010220e <readi+0xbf>
  }
  return n;
801022a3:	8b 45 14             	mov    0x14(%ebp),%eax
}
801022a6:	c9                   	leave  
801022a7:	c3                   	ret    

801022a8 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801022a8:	f3 0f 1e fb          	endbr32 
801022ac:	55                   	push   %ebp
801022ad:	89 e5                	mov    %esp,%ebp
801022af:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801022b2:	8b 45 08             	mov    0x8(%ebp),%eax
801022b5:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801022b9:	66 83 f8 03          	cmp    $0x3,%ax
801022bd:	75 5c                	jne    8010231b <writei+0x73>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801022bf:	8b 45 08             	mov    0x8(%ebp),%eax
801022c2:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801022c6:	66 85 c0             	test   %ax,%ax
801022c9:	78 20                	js     801022eb <writei+0x43>
801022cb:	8b 45 08             	mov    0x8(%ebp),%eax
801022ce:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801022d2:	66 83 f8 09          	cmp    $0x9,%ax
801022d6:	7f 13                	jg     801022eb <writei+0x43>
801022d8:	8b 45 08             	mov    0x8(%ebp),%eax
801022db:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801022df:	98                   	cwtl   
801022e0:	8b 04 c5 e4 41 11 80 	mov    -0x7feebe1c(,%eax,8),%eax
801022e7:	85 c0                	test   %eax,%eax
801022e9:	75 0a                	jne    801022f5 <writei+0x4d>
      return -1;
801022eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022f0:	e9 3b 01 00 00       	jmp    80102430 <writei+0x188>
    return devsw[ip->major].write(ip, src, n);
801022f5:	8b 45 08             	mov    0x8(%ebp),%eax
801022f8:	0f b7 40 12          	movzwl 0x12(%eax),%eax
801022fc:	98                   	cwtl   
801022fd:	8b 04 c5 e4 41 11 80 	mov    -0x7feebe1c(,%eax,8),%eax
80102304:	8b 55 14             	mov    0x14(%ebp),%edx
80102307:	83 ec 04             	sub    $0x4,%esp
8010230a:	52                   	push   %edx
8010230b:	ff 75 0c             	pushl  0xc(%ebp)
8010230e:	ff 75 08             	pushl  0x8(%ebp)
80102311:	ff d0                	call   *%eax
80102313:	83 c4 10             	add    $0x10,%esp
80102316:	e9 15 01 00 00       	jmp    80102430 <writei+0x188>
  }

  if(off > ip->size || off + n < off)
8010231b:	8b 45 08             	mov    0x8(%ebp),%eax
8010231e:	8b 40 24             	mov    0x24(%eax),%eax
80102321:	39 45 10             	cmp    %eax,0x10(%ebp)
80102324:	77 0d                	ja     80102333 <writei+0x8b>
80102326:	8b 55 10             	mov    0x10(%ebp),%edx
80102329:	8b 45 14             	mov    0x14(%ebp),%eax
8010232c:	01 d0                	add    %edx,%eax
8010232e:	39 45 10             	cmp    %eax,0x10(%ebp)
80102331:	76 0a                	jbe    8010233d <writei+0x95>
    return -1;
80102333:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102338:	e9 f3 00 00 00       	jmp    80102430 <writei+0x188>
  if(off + n > MAXFILE*BSIZE)
8010233d:	8b 55 10             	mov    0x10(%ebp),%edx
80102340:	8b 45 14             	mov    0x14(%ebp),%eax
80102343:	01 d0                	add    %edx,%eax
80102345:	3d 00 32 01 00       	cmp    $0x13200,%eax
8010234a:	76 0a                	jbe    80102356 <writei+0xae>
    return -1;
8010234c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102351:	e9 da 00 00 00       	jmp    80102430 <writei+0x188>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102356:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010235d:	e9 97 00 00 00       	jmp    801023f9 <writei+0x151>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102362:	8b 45 10             	mov    0x10(%ebp),%eax
80102365:	c1 e8 09             	shr    $0x9,%eax
80102368:	83 ec 08             	sub    $0x8,%esp
8010236b:	50                   	push   %eax
8010236c:	ff 75 08             	pushl  0x8(%ebp)
8010236f:	e8 15 fb ff ff       	call   80101e89 <bmap>
80102374:	83 c4 10             	add    $0x10,%esp
80102377:	8b 55 08             	mov    0x8(%ebp),%edx
8010237a:	8b 12                	mov    (%edx),%edx
8010237c:	83 ec 08             	sub    $0x8,%esp
8010237f:	50                   	push   %eax
80102380:	52                   	push   %edx
80102381:	e8 39 de ff ff       	call   801001bf <bread>
80102386:	83 c4 10             	add    $0x10,%esp
80102389:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
8010238c:	8b 45 10             	mov    0x10(%ebp),%eax
8010238f:	25 ff 01 00 00       	and    $0x1ff,%eax
80102394:	ba 00 02 00 00       	mov    $0x200,%edx
80102399:	29 c2                	sub    %eax,%edx
8010239b:	8b 45 14             	mov    0x14(%ebp),%eax
8010239e:	2b 45 f4             	sub    -0xc(%ebp),%eax
801023a1:	39 c2                	cmp    %eax,%edx
801023a3:	0f 46 c2             	cmovbe %edx,%eax
801023a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801023a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023ac:	8d 50 18             	lea    0x18(%eax),%edx
801023af:	8b 45 10             	mov    0x10(%ebp),%eax
801023b2:	25 ff 01 00 00       	and    $0x1ff,%eax
801023b7:	01 d0                	add    %edx,%eax
801023b9:	83 ec 04             	sub    $0x4,%esp
801023bc:	ff 75 ec             	pushl  -0x14(%ebp)
801023bf:	ff 75 0c             	pushl  0xc(%ebp)
801023c2:	50                   	push   %eax
801023c3:	e8 8a 4b 00 00       	call   80106f52 <memmove>
801023c8:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
801023cb:	83 ec 0c             	sub    $0xc,%esp
801023ce:	ff 75 f0             	pushl  -0x10(%ebp)
801023d1:	e8 59 17 00 00       	call   80103b2f <log_write>
801023d6:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801023d9:	83 ec 0c             	sub    $0xc,%esp
801023dc:	ff 75 f0             	pushl  -0x10(%ebp)
801023df:	e8 5b de ff ff       	call   8010023f <brelse>
801023e4:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801023e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801023ea:	01 45 f4             	add    %eax,-0xc(%ebp)
801023ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
801023f0:	01 45 10             	add    %eax,0x10(%ebp)
801023f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801023f6:	01 45 0c             	add    %eax,0xc(%ebp)
801023f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023fc:	3b 45 14             	cmp    0x14(%ebp),%eax
801023ff:	0f 82 5d ff ff ff    	jb     80102362 <writei+0xba>
  }

  if(n > 0 && off > ip->size){
80102405:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102409:	74 22                	je     8010242d <writei+0x185>
8010240b:	8b 45 08             	mov    0x8(%ebp),%eax
8010240e:	8b 40 24             	mov    0x24(%eax),%eax
80102411:	39 45 10             	cmp    %eax,0x10(%ebp)
80102414:	76 17                	jbe    8010242d <writei+0x185>
    ip->size = off;
80102416:	8b 45 08             	mov    0x8(%ebp),%eax
80102419:	8b 55 10             	mov    0x10(%ebp),%edx
8010241c:	89 50 24             	mov    %edx,0x24(%eax)
    iupdate(ip);
8010241f:	83 ec 0c             	sub    $0xc,%esp
80102422:	ff 75 08             	pushl  0x8(%ebp)
80102425:	e8 39 f5 ff ff       	call   80101963 <iupdate>
8010242a:	83 c4 10             	add    $0x10,%esp
  }
  return n;
8010242d:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102430:	c9                   	leave  
80102431:	c3                   	ret    

80102432 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102432:	f3 0f 1e fb          	endbr32 
80102436:	55                   	push   %ebp
80102437:	89 e5                	mov    %esp,%ebp
80102439:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
8010243c:	83 ec 04             	sub    $0x4,%esp
8010243f:	6a 0e                	push   $0xe
80102441:	ff 75 0c             	pushl  0xc(%ebp)
80102444:	ff 75 08             	pushl  0x8(%ebp)
80102447:	e8 a4 4b 00 00       	call   80106ff0 <strncmp>
8010244c:	83 c4 10             	add    $0x10,%esp
}
8010244f:	c9                   	leave  
80102450:	c3                   	ret    

80102451 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102451:	f3 0f 1e fb          	endbr32 
80102455:	55                   	push   %ebp
80102456:	89 e5                	mov    %esp,%ebp
80102458:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010245b:	8b 45 08             	mov    0x8(%ebp),%eax
8010245e:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102462:	66 83 f8 01          	cmp    $0x1,%ax
80102466:	74 0d                	je     80102475 <dirlookup+0x24>
    panic("dirlookup not DIR");
80102468:	83 ec 0c             	sub    $0xc,%esp
8010246b:	68 df a6 10 80       	push   $0x8010a6df
80102470:	e8 22 e1 ff ff       	call   80100597 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102475:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010247c:	eb 7b                	jmp    801024f9 <dirlookup+0xa8>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010247e:	6a 10                	push   $0x10
80102480:	ff 75 f4             	pushl  -0xc(%ebp)
80102483:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102486:	50                   	push   %eax
80102487:	ff 75 08             	pushl  0x8(%ebp)
8010248a:	e8 c0 fc ff ff       	call   8010214f <readi>
8010248f:	83 c4 10             	add    $0x10,%esp
80102492:	83 f8 10             	cmp    $0x10,%eax
80102495:	74 0d                	je     801024a4 <dirlookup+0x53>
      panic("dirlink read");
80102497:	83 ec 0c             	sub    $0xc,%esp
8010249a:	68 f1 a6 10 80       	push   $0x8010a6f1
8010249f:	e8 f3 e0 ff ff       	call   80100597 <panic>
    if(de.inum == 0)
801024a4:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801024a8:	66 85 c0             	test   %ax,%ax
801024ab:	74 47                	je     801024f4 <dirlookup+0xa3>
      continue;
    if(namecmp(name, de.name) == 0){
801024ad:	83 ec 08             	sub    $0x8,%esp
801024b0:	8d 45 e0             	lea    -0x20(%ebp),%eax
801024b3:	83 c0 02             	add    $0x2,%eax
801024b6:	50                   	push   %eax
801024b7:	ff 75 0c             	pushl  0xc(%ebp)
801024ba:	e8 73 ff ff ff       	call   80102432 <namecmp>
801024bf:	83 c4 10             	add    $0x10,%esp
801024c2:	85 c0                	test   %eax,%eax
801024c4:	75 2f                	jne    801024f5 <dirlookup+0xa4>
      // entry matches path element
      if(poff)
801024c6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801024ca:	74 08                	je     801024d4 <dirlookup+0x83>
        *poff = off;
801024cc:	8b 45 10             	mov    0x10(%ebp),%eax
801024cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
801024d2:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
801024d4:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801024d8:	0f b7 c0             	movzwl %ax,%eax
801024db:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
801024de:	8b 45 08             	mov    0x8(%ebp),%eax
801024e1:	8b 00                	mov    (%eax),%eax
801024e3:	83 ec 08             	sub    $0x8,%esp
801024e6:	ff 75 f0             	pushl  -0x10(%ebp)
801024e9:	50                   	push   %eax
801024ea:	e8 5d f5 ff ff       	call   80101a4c <iget>
801024ef:	83 c4 10             	add    $0x10,%esp
801024f2:	eb 19                	jmp    8010250d <dirlookup+0xbc>
      continue;
801024f4:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
801024f5:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801024f9:	8b 45 08             	mov    0x8(%ebp),%eax
801024fc:	8b 40 24             	mov    0x24(%eax),%eax
801024ff:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80102502:	0f 82 76 ff ff ff    	jb     8010247e <dirlookup+0x2d>
    }
  }

  return 0;
80102508:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010250d:	c9                   	leave  
8010250e:	c3                   	ret    

8010250f <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
8010250f:	f3 0f 1e fb          	endbr32 
80102513:	55                   	push   %ebp
80102514:	89 e5                	mov    %esp,%ebp
80102516:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102519:	83 ec 04             	sub    $0x4,%esp
8010251c:	6a 00                	push   $0x0
8010251e:	ff 75 0c             	pushl  0xc(%ebp)
80102521:	ff 75 08             	pushl  0x8(%ebp)
80102524:	e8 28 ff ff ff       	call   80102451 <dirlookup>
80102529:	83 c4 10             	add    $0x10,%esp
8010252c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010252f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102533:	74 18                	je     8010254d <dirlink+0x3e>
    iput(ip);
80102535:	83 ec 0c             	sub    $0xc,%esp
80102538:	ff 75 f0             	pushl  -0x10(%ebp)
8010253b:	e8 2c f8 ff ff       	call   80101d6c <iput>
80102540:	83 c4 10             	add    $0x10,%esp
    return -1;
80102543:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102548:	e9 9c 00 00 00       	jmp    801025e9 <dirlink+0xda>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010254d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102554:	eb 39                	jmp    8010258f <dirlink+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102556:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102559:	6a 10                	push   $0x10
8010255b:	50                   	push   %eax
8010255c:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010255f:	50                   	push   %eax
80102560:	ff 75 08             	pushl  0x8(%ebp)
80102563:	e8 e7 fb ff ff       	call   8010214f <readi>
80102568:	83 c4 10             	add    $0x10,%esp
8010256b:	83 f8 10             	cmp    $0x10,%eax
8010256e:	74 0d                	je     8010257d <dirlink+0x6e>
      panic("dirlink read");
80102570:	83 ec 0c             	sub    $0xc,%esp
80102573:	68 f1 a6 10 80       	push   $0x8010a6f1
80102578:	e8 1a e0 ff ff       	call   80100597 <panic>
    if(de.inum == 0)
8010257d:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102581:	66 85 c0             	test   %ax,%ax
80102584:	74 18                	je     8010259e <dirlink+0x8f>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102586:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102589:	83 c0 10             	add    $0x10,%eax
8010258c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010258f:	8b 45 08             	mov    0x8(%ebp),%eax
80102592:	8b 50 24             	mov    0x24(%eax),%edx
80102595:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102598:	39 c2                	cmp    %eax,%edx
8010259a:	77 ba                	ja     80102556 <dirlink+0x47>
8010259c:	eb 01                	jmp    8010259f <dirlink+0x90>
      break;
8010259e:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
8010259f:	83 ec 04             	sub    $0x4,%esp
801025a2:	6a 0e                	push   $0xe
801025a4:	ff 75 0c             	pushl  0xc(%ebp)
801025a7:	8d 45 e0             	lea    -0x20(%ebp),%eax
801025aa:	83 c0 02             	add    $0x2,%eax
801025ad:	50                   	push   %eax
801025ae:	e8 97 4a 00 00       	call   8010704a <strncpy>
801025b3:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
801025b6:	8b 45 10             	mov    0x10(%ebp),%eax
801025b9:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801025bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801025c0:	6a 10                	push   $0x10
801025c2:	50                   	push   %eax
801025c3:	8d 45 e0             	lea    -0x20(%ebp),%eax
801025c6:	50                   	push   %eax
801025c7:	ff 75 08             	pushl  0x8(%ebp)
801025ca:	e8 d9 fc ff ff       	call   801022a8 <writei>
801025cf:	83 c4 10             	add    $0x10,%esp
801025d2:	83 f8 10             	cmp    $0x10,%eax
801025d5:	74 0d                	je     801025e4 <dirlink+0xd5>
    panic("dirlink");
801025d7:	83 ec 0c             	sub    $0xc,%esp
801025da:	68 fe a6 10 80       	push   $0x8010a6fe
801025df:	e8 b3 df ff ff       	call   80100597 <panic>
  
  return 0;
801025e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801025e9:	c9                   	leave  
801025ea:	c3                   	ret    

801025eb <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
801025eb:	f3 0f 1e fb          	endbr32 
801025ef:	55                   	push   %ebp
801025f0:	89 e5                	mov    %esp,%ebp
801025f2:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
801025f5:	eb 04                	jmp    801025fb <skipelem+0x10>
    path++;
801025f7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
801025fb:	8b 45 08             	mov    0x8(%ebp),%eax
801025fe:	0f b6 00             	movzbl (%eax),%eax
80102601:	3c 2f                	cmp    $0x2f,%al
80102603:	74 f2                	je     801025f7 <skipelem+0xc>
  if(*path == 0)
80102605:	8b 45 08             	mov    0x8(%ebp),%eax
80102608:	0f b6 00             	movzbl (%eax),%eax
8010260b:	84 c0                	test   %al,%al
8010260d:	75 07                	jne    80102616 <skipelem+0x2b>
    return 0;
8010260f:	b8 00 00 00 00       	mov    $0x0,%eax
80102614:	eb 77                	jmp    8010268d <skipelem+0xa2>
  s = path;
80102616:	8b 45 08             	mov    0x8(%ebp),%eax
80102619:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
8010261c:	eb 04                	jmp    80102622 <skipelem+0x37>
    path++;
8010261e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path != '/' && *path != 0)
80102622:	8b 45 08             	mov    0x8(%ebp),%eax
80102625:	0f b6 00             	movzbl (%eax),%eax
80102628:	3c 2f                	cmp    $0x2f,%al
8010262a:	74 0a                	je     80102636 <skipelem+0x4b>
8010262c:	8b 45 08             	mov    0x8(%ebp),%eax
8010262f:	0f b6 00             	movzbl (%eax),%eax
80102632:	84 c0                	test   %al,%al
80102634:	75 e8                	jne    8010261e <skipelem+0x33>
  len = path - s;
80102636:	8b 45 08             	mov    0x8(%ebp),%eax
80102639:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010263c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
8010263f:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80102643:	7e 15                	jle    8010265a <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
80102645:	83 ec 04             	sub    $0x4,%esp
80102648:	6a 0e                	push   $0xe
8010264a:	ff 75 f4             	pushl  -0xc(%ebp)
8010264d:	ff 75 0c             	pushl  0xc(%ebp)
80102650:	e8 fd 48 00 00       	call   80106f52 <memmove>
80102655:	83 c4 10             	add    $0x10,%esp
80102658:	eb 26                	jmp    80102680 <skipelem+0x95>
  else {
    memmove(name, s, len);
8010265a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010265d:	83 ec 04             	sub    $0x4,%esp
80102660:	50                   	push   %eax
80102661:	ff 75 f4             	pushl  -0xc(%ebp)
80102664:	ff 75 0c             	pushl  0xc(%ebp)
80102667:	e8 e6 48 00 00       	call   80106f52 <memmove>
8010266c:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
8010266f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102672:	8b 45 0c             	mov    0xc(%ebp),%eax
80102675:	01 d0                	add    %edx,%eax
80102677:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
8010267a:	eb 04                	jmp    80102680 <skipelem+0x95>
    path++;
8010267c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
80102680:	8b 45 08             	mov    0x8(%ebp),%eax
80102683:	0f b6 00             	movzbl (%eax),%eax
80102686:	3c 2f                	cmp    $0x2f,%al
80102688:	74 f2                	je     8010267c <skipelem+0x91>
  return path;
8010268a:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010268d:	c9                   	leave  
8010268e:	c3                   	ret    

8010268f <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
8010268f:	f3 0f 1e fb          	endbr32 
80102693:	55                   	push   %ebp
80102694:	89 e5                	mov    %esp,%ebp
80102696:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102699:	8b 45 08             	mov    0x8(%ebp),%eax
8010269c:	0f b6 00             	movzbl (%eax),%eax
8010269f:	3c 2f                	cmp    $0x2f,%al
801026a1:	75 17                	jne    801026ba <namex+0x2b>
    ip = iget(ROOTDEV, ROOTINO);
801026a3:	83 ec 08             	sub    $0x8,%esp
801026a6:	6a 01                	push   $0x1
801026a8:	6a 01                	push   $0x1
801026aa:	e8 9d f3 ff ff       	call   80101a4c <iget>
801026af:	83 c4 10             	add    $0x10,%esp
801026b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026b5:	e9 bb 00 00 00       	jmp    80102775 <namex+0xe6>
  else
    ip = idup(proc->cwd);
801026ba:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801026c0:	8b 40 68             	mov    0x68(%eax),%eax
801026c3:	83 ec 0c             	sub    $0xc,%esp
801026c6:	50                   	push   %eax
801026c7:	e8 66 f4 ff ff       	call   80101b32 <idup>
801026cc:	83 c4 10             	add    $0x10,%esp
801026cf:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
801026d2:	e9 9e 00 00 00       	jmp    80102775 <namex+0xe6>
    ilock(ip);
801026d7:	83 ec 0c             	sub    $0xc,%esp
801026da:	ff 75 f4             	pushl  -0xc(%ebp)
801026dd:	e8 8e f4 ff ff       	call   80101b70 <ilock>
801026e2:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
801026e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026e8:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801026ec:	66 83 f8 01          	cmp    $0x1,%ax
801026f0:	74 18                	je     8010270a <namex+0x7b>
      iunlockput(ip);
801026f2:	83 ec 0c             	sub    $0xc,%esp
801026f5:	ff 75 f4             	pushl  -0xc(%ebp)
801026f8:	e8 63 f7 ff ff       	call   80101e60 <iunlockput>
801026fd:	83 c4 10             	add    $0x10,%esp
      return 0;
80102700:	b8 00 00 00 00       	mov    $0x0,%eax
80102705:	e9 a7 00 00 00       	jmp    801027b1 <namex+0x122>
    }
    if(nameiparent && *path == '\0'){
8010270a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010270e:	74 20                	je     80102730 <namex+0xa1>
80102710:	8b 45 08             	mov    0x8(%ebp),%eax
80102713:	0f b6 00             	movzbl (%eax),%eax
80102716:	84 c0                	test   %al,%al
80102718:	75 16                	jne    80102730 <namex+0xa1>
      // Stop one level early.
      iunlock(ip);
8010271a:	83 ec 0c             	sub    $0xc,%esp
8010271d:	ff 75 f4             	pushl  -0xc(%ebp)
80102720:	e8 d1 f5 ff ff       	call   80101cf6 <iunlock>
80102725:	83 c4 10             	add    $0x10,%esp
      return ip;
80102728:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010272b:	e9 81 00 00 00       	jmp    801027b1 <namex+0x122>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102730:	83 ec 04             	sub    $0x4,%esp
80102733:	6a 00                	push   $0x0
80102735:	ff 75 10             	pushl  0x10(%ebp)
80102738:	ff 75 f4             	pushl  -0xc(%ebp)
8010273b:	e8 11 fd ff ff       	call   80102451 <dirlookup>
80102740:	83 c4 10             	add    $0x10,%esp
80102743:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102746:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010274a:	75 15                	jne    80102761 <namex+0xd2>
      iunlockput(ip);
8010274c:	83 ec 0c             	sub    $0xc,%esp
8010274f:	ff 75 f4             	pushl  -0xc(%ebp)
80102752:	e8 09 f7 ff ff       	call   80101e60 <iunlockput>
80102757:	83 c4 10             	add    $0x10,%esp
      return 0;
8010275a:	b8 00 00 00 00       	mov    $0x0,%eax
8010275f:	eb 50                	jmp    801027b1 <namex+0x122>
    }
    iunlockput(ip);
80102761:	83 ec 0c             	sub    $0xc,%esp
80102764:	ff 75 f4             	pushl  -0xc(%ebp)
80102767:	e8 f4 f6 ff ff       	call   80101e60 <iunlockput>
8010276c:	83 c4 10             	add    $0x10,%esp
    ip = next;
8010276f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102772:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while((path = skipelem(path, name)) != 0){
80102775:	83 ec 08             	sub    $0x8,%esp
80102778:	ff 75 10             	pushl  0x10(%ebp)
8010277b:	ff 75 08             	pushl  0x8(%ebp)
8010277e:	e8 68 fe ff ff       	call   801025eb <skipelem>
80102783:	83 c4 10             	add    $0x10,%esp
80102786:	89 45 08             	mov    %eax,0x8(%ebp)
80102789:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010278d:	0f 85 44 ff ff ff    	jne    801026d7 <namex+0x48>
  }
  if(nameiparent){
80102793:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102797:	74 15                	je     801027ae <namex+0x11f>
    iput(ip);
80102799:	83 ec 0c             	sub    $0xc,%esp
8010279c:	ff 75 f4             	pushl  -0xc(%ebp)
8010279f:	e8 c8 f5 ff ff       	call   80101d6c <iput>
801027a4:	83 c4 10             	add    $0x10,%esp
    return 0;
801027a7:	b8 00 00 00 00       	mov    $0x0,%eax
801027ac:	eb 03                	jmp    801027b1 <namex+0x122>
  }
  return ip;
801027ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801027b1:	c9                   	leave  
801027b2:	c3                   	ret    

801027b3 <namei>:

struct inode*
namei(char *path)
{
801027b3:	f3 0f 1e fb          	endbr32 
801027b7:	55                   	push   %ebp
801027b8:	89 e5                	mov    %esp,%ebp
801027ba:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801027bd:	83 ec 04             	sub    $0x4,%esp
801027c0:	8d 45 ea             	lea    -0x16(%ebp),%eax
801027c3:	50                   	push   %eax
801027c4:	6a 00                	push   $0x0
801027c6:	ff 75 08             	pushl  0x8(%ebp)
801027c9:	e8 c1 fe ff ff       	call   8010268f <namex>
801027ce:	83 c4 10             	add    $0x10,%esp
}
801027d1:	c9                   	leave  
801027d2:	c3                   	ret    

801027d3 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801027d3:	f3 0f 1e fb          	endbr32 
801027d7:	55                   	push   %ebp
801027d8:	89 e5                	mov    %esp,%ebp
801027da:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
801027dd:	83 ec 04             	sub    $0x4,%esp
801027e0:	ff 75 0c             	pushl  0xc(%ebp)
801027e3:	6a 01                	push   $0x1
801027e5:	ff 75 08             	pushl  0x8(%ebp)
801027e8:	e8 a2 fe ff ff       	call   8010268f <namex>
801027ed:	83 c4 10             	add    $0x10,%esp
}
801027f0:	c9                   	leave  
801027f1:	c3                   	ret    

801027f2 <chown>:

#ifdef LS_EXEC
int
chown(char *pathname, int owner, int group) {
801027f2:	f3 0f 1e fb          	endbr32 
801027f6:	55                   	push   %ebp
801027f7:	89 e5                	mov    %esp,%ebp
801027f9:	83 ec 18             	sub    $0x18,%esp
    struct inode *ip;
    cprintf("%d %d\n", owner, group);
801027fc:	83 ec 04             	sub    $0x4,%esp
801027ff:	ff 75 10             	pushl  0x10(%ebp)
80102802:	ff 75 0c             	pushl  0xc(%ebp)
80102805:	68 06 a7 10 80       	push   $0x8010a706
8010280a:	e8 cf db ff ff       	call   801003de <cprintf>
8010280f:	83 c4 10             	add    $0x10,%esp
    begin_op();
80102812:	e8 cf 10 00 00       	call   801038e6 <begin_op>
    if ((ip = namei(pathname)) == 0) {
80102817:	83 ec 0c             	sub    $0xc,%esp
8010281a:	ff 75 08             	pushl  0x8(%ebp)
8010281d:	e8 91 ff ff ff       	call   801027b3 <namei>
80102822:	83 c4 10             	add    $0x10,%esp
80102825:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102828:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010282c:	75 0c                	jne    8010283a <chown+0x48>
        end_op();
8010282e:	e8 43 11 00 00       	call   80103976 <end_op>
        return -1;
80102833:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102838:	eb 46                	jmp    80102880 <chown+0x8e>
    }
    ilock(ip);
8010283a:	83 ec 0c             	sub    $0xc,%esp
8010283d:	ff 75 f4             	pushl  -0xc(%ebp)
80102840:	e8 2b f3 ff ff       	call   80101b70 <ilock>
80102845:	83 c4 10             	add    $0x10,%esp
    ip->uid = owner;
80102848:	8b 55 0c             	mov    0xc(%ebp),%edx
8010284b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010284e:	89 50 18             	mov    %edx,0x18(%eax)
    ip->gid = group;
80102851:	8b 55 10             	mov    0x10(%ebp),%edx
80102854:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102857:	89 50 1c             	mov    %edx,0x1c(%eax)
    iupdate(ip);
8010285a:	83 ec 0c             	sub    $0xc,%esp
8010285d:	ff 75 f4             	pushl  -0xc(%ebp)
80102860:	e8 fe f0 ff ff       	call   80101963 <iupdate>
80102865:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80102868:	83 ec 0c             	sub    $0xc,%esp
8010286b:	ff 75 f4             	pushl  -0xc(%ebp)
8010286e:	e8 ed f5 ff ff       	call   80101e60 <iunlockput>
80102873:	83 c4 10             	add    $0x10,%esp
    end_op();
80102876:	e8 fb 10 00 00       	call   80103976 <end_op>
    return 0;
8010287b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102880:	c9                   	leave  
80102881:	c3                   	ret    

80102882 <inb>:
{
80102882:	55                   	push   %ebp
80102883:	89 e5                	mov    %esp,%ebp
80102885:	83 ec 14             	sub    $0x14,%esp
80102888:	8b 45 08             	mov    0x8(%ebp),%eax
8010288b:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288f:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102893:	89 c2                	mov    %eax,%edx
80102895:	ec                   	in     (%dx),%al
80102896:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102899:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010289d:	c9                   	leave  
8010289e:	c3                   	ret    

8010289f <insl>:
{
8010289f:	55                   	push   %ebp
801028a0:	89 e5                	mov    %esp,%ebp
801028a2:	57                   	push   %edi
801028a3:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
801028a4:	8b 55 08             	mov    0x8(%ebp),%edx
801028a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801028aa:	8b 45 10             	mov    0x10(%ebp),%eax
801028ad:	89 cb                	mov    %ecx,%ebx
801028af:	89 df                	mov    %ebx,%edi
801028b1:	89 c1                	mov    %eax,%ecx
801028b3:	fc                   	cld    
801028b4:	f3 6d                	rep insl (%dx),%es:(%edi)
801028b6:	89 c8                	mov    %ecx,%eax
801028b8:	89 fb                	mov    %edi,%ebx
801028ba:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801028bd:	89 45 10             	mov    %eax,0x10(%ebp)
}
801028c0:	90                   	nop
801028c1:	5b                   	pop    %ebx
801028c2:	5f                   	pop    %edi
801028c3:	5d                   	pop    %ebp
801028c4:	c3                   	ret    

801028c5 <outb>:
{
801028c5:	55                   	push   %ebp
801028c6:	89 e5                	mov    %esp,%ebp
801028c8:	83 ec 08             	sub    $0x8,%esp
801028cb:	8b 45 08             	mov    0x8(%ebp),%eax
801028ce:	8b 55 0c             	mov    0xc(%ebp),%edx
801028d1:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801028d5:	89 d0                	mov    %edx,%eax
801028d7:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028da:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801028de:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801028e2:	ee                   	out    %al,(%dx)
}
801028e3:	90                   	nop
801028e4:	c9                   	leave  
801028e5:	c3                   	ret    

801028e6 <outsl>:
{
801028e6:	55                   	push   %ebp
801028e7:	89 e5                	mov    %esp,%ebp
801028e9:	56                   	push   %esi
801028ea:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801028eb:	8b 55 08             	mov    0x8(%ebp),%edx
801028ee:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801028f1:	8b 45 10             	mov    0x10(%ebp),%eax
801028f4:	89 cb                	mov    %ecx,%ebx
801028f6:	89 de                	mov    %ebx,%esi
801028f8:	89 c1                	mov    %eax,%ecx
801028fa:	fc                   	cld    
801028fb:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801028fd:	89 c8                	mov    %ecx,%eax
801028ff:	89 f3                	mov    %esi,%ebx
80102901:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102904:	89 45 10             	mov    %eax,0x10(%ebp)
}
80102907:	90                   	nop
80102908:	5b                   	pop    %ebx
80102909:	5e                   	pop    %esi
8010290a:	5d                   	pop    %ebp
8010290b:	c3                   	ret    

8010290c <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
8010290c:	f3 0f 1e fb          	endbr32 
80102910:	55                   	push   %ebp
80102911:	89 e5                	mov    %esp,%ebp
80102913:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
80102916:	90                   	nop
80102917:	68 f7 01 00 00       	push   $0x1f7
8010291c:	e8 61 ff ff ff       	call   80102882 <inb>
80102921:	83 c4 04             	add    $0x4,%esp
80102924:	0f b6 c0             	movzbl %al,%eax
80102927:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010292a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010292d:	25 c0 00 00 00       	and    $0xc0,%eax
80102932:	83 f8 40             	cmp    $0x40,%eax
80102935:	75 e0                	jne    80102917 <idewait+0xb>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102937:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010293b:	74 11                	je     8010294e <idewait+0x42>
8010293d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102940:	83 e0 21             	and    $0x21,%eax
80102943:	85 c0                	test   %eax,%eax
80102945:	74 07                	je     8010294e <idewait+0x42>
    return -1;
80102947:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010294c:	eb 05                	jmp    80102953 <idewait+0x47>
  return 0;
8010294e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102953:	c9                   	leave  
80102954:	c3                   	ret    

80102955 <ideinit>:

void
ideinit(void)
{
80102955:	f3 0f 1e fb          	endbr32 
80102959:	55                   	push   %ebp
8010295a:	89 e5                	mov    %esp,%ebp
8010295c:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  initlock(&idelock, "ide");
8010295f:	83 ec 08             	sub    $0x8,%esp
80102962:	68 0d a7 10 80       	push   $0x8010a70d
80102967:	68 20 e6 10 80       	push   $0x8010e620
8010296c:	e8 78 42 00 00       	call   80106be9 <initlock>
80102971:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
80102974:	83 ec 0c             	sub    $0xc,%esp
80102977:	6a 0e                	push   $0xe
80102979:	e8 a4 19 00 00       	call   80104322 <picenable>
8010297e:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
80102981:	a1 e0 65 11 80       	mov    0x801165e0,%eax
80102986:	83 e8 01             	sub    $0x1,%eax
80102989:	83 ec 08             	sub    $0x8,%esp
8010298c:	50                   	push   %eax
8010298d:	6a 0e                	push   $0xe
8010298f:	e8 8b 04 00 00       	call   80102e1f <ioapicenable>
80102994:	83 c4 10             	add    $0x10,%esp
  idewait(0);
80102997:	83 ec 0c             	sub    $0xc,%esp
8010299a:	6a 00                	push   $0x0
8010299c:	e8 6b ff ff ff       	call   8010290c <idewait>
801029a1:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
801029a4:	83 ec 08             	sub    $0x8,%esp
801029a7:	68 f0 00 00 00       	push   $0xf0
801029ac:	68 f6 01 00 00       	push   $0x1f6
801029b1:	e8 0f ff ff ff       	call   801028c5 <outb>
801029b6:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
801029b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801029c0:	eb 24                	jmp    801029e6 <ideinit+0x91>
    if(inb(0x1f7) != 0){
801029c2:	83 ec 0c             	sub    $0xc,%esp
801029c5:	68 f7 01 00 00       	push   $0x1f7
801029ca:	e8 b3 fe ff ff       	call   80102882 <inb>
801029cf:	83 c4 10             	add    $0x10,%esp
801029d2:	84 c0                	test   %al,%al
801029d4:	74 0c                	je     801029e2 <ideinit+0x8d>
      havedisk1 = 1;
801029d6:	c7 05 58 e6 10 80 01 	movl   $0x1,0x8010e658
801029dd:	00 00 00 
      break;
801029e0:	eb 0d                	jmp    801029ef <ideinit+0x9a>
  for(i=0; i<1000; i++){
801029e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801029e6:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801029ed:	7e d3                	jle    801029c2 <ideinit+0x6d>
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801029ef:	83 ec 08             	sub    $0x8,%esp
801029f2:	68 e0 00 00 00       	push   $0xe0
801029f7:	68 f6 01 00 00       	push   $0x1f6
801029fc:	e8 c4 fe ff ff       	call   801028c5 <outb>
80102a01:	83 c4 10             	add    $0x10,%esp
}
80102a04:	90                   	nop
80102a05:	c9                   	leave  
80102a06:	c3                   	ret    

80102a07 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102a07:	f3 0f 1e fb          	endbr32 
80102a0b:	55                   	push   %ebp
80102a0c:	89 e5                	mov    %esp,%ebp
80102a0e:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
80102a11:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102a15:	75 0d                	jne    80102a24 <idestart+0x1d>
    panic("idestart");
80102a17:	83 ec 0c             	sub    $0xc,%esp
80102a1a:	68 11 a7 10 80       	push   $0x8010a711
80102a1f:	e8 73 db ff ff       	call   80100597 <panic>
  if(b->blockno >= FSSIZE)
80102a24:	8b 45 08             	mov    0x8(%ebp),%eax
80102a27:	8b 40 08             	mov    0x8(%eax),%eax
80102a2a:	3d cf 07 00 00       	cmp    $0x7cf,%eax
80102a2f:	76 0d                	jbe    80102a3e <idestart+0x37>
    panic("incorrect blockno");
80102a31:	83 ec 0c             	sub    $0xc,%esp
80102a34:	68 1a a7 10 80       	push   $0x8010a71a
80102a39:	e8 59 db ff ff       	call   80100597 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
80102a3e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
80102a45:	8b 45 08             	mov    0x8(%ebp),%eax
80102a48:	8b 50 08             	mov    0x8(%eax),%edx
80102a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a4e:	0f af c2             	imul   %edx,%eax
80102a51:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if (sector_per_block > 7) panic("idestart");
80102a54:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
80102a58:	7e 0d                	jle    80102a67 <idestart+0x60>
80102a5a:	83 ec 0c             	sub    $0xc,%esp
80102a5d:	68 11 a7 10 80       	push   $0x8010a711
80102a62:	e8 30 db ff ff       	call   80100597 <panic>
  
  idewait(0);
80102a67:	83 ec 0c             	sub    $0xc,%esp
80102a6a:	6a 00                	push   $0x0
80102a6c:	e8 9b fe ff ff       	call   8010290c <idewait>
80102a71:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
80102a74:	83 ec 08             	sub    $0x8,%esp
80102a77:	6a 00                	push   $0x0
80102a79:	68 f6 03 00 00       	push   $0x3f6
80102a7e:	e8 42 fe ff ff       	call   801028c5 <outb>
80102a83:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
80102a86:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a89:	0f b6 c0             	movzbl %al,%eax
80102a8c:	83 ec 08             	sub    $0x8,%esp
80102a8f:	50                   	push   %eax
80102a90:	68 f2 01 00 00       	push   $0x1f2
80102a95:	e8 2b fe ff ff       	call   801028c5 <outb>
80102a9a:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
80102a9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102aa0:	0f b6 c0             	movzbl %al,%eax
80102aa3:	83 ec 08             	sub    $0x8,%esp
80102aa6:	50                   	push   %eax
80102aa7:	68 f3 01 00 00       	push   $0x1f3
80102aac:	e8 14 fe ff ff       	call   801028c5 <outb>
80102ab1:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
80102ab4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102ab7:	c1 f8 08             	sar    $0x8,%eax
80102aba:	0f b6 c0             	movzbl %al,%eax
80102abd:	83 ec 08             	sub    $0x8,%esp
80102ac0:	50                   	push   %eax
80102ac1:	68 f4 01 00 00       	push   $0x1f4
80102ac6:	e8 fa fd ff ff       	call   801028c5 <outb>
80102acb:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
80102ace:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102ad1:	c1 f8 10             	sar    $0x10,%eax
80102ad4:	0f b6 c0             	movzbl %al,%eax
80102ad7:	83 ec 08             	sub    $0x8,%esp
80102ada:	50                   	push   %eax
80102adb:	68 f5 01 00 00       	push   $0x1f5
80102ae0:	e8 e0 fd ff ff       	call   801028c5 <outb>
80102ae5:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102ae8:	8b 45 08             	mov    0x8(%ebp),%eax
80102aeb:	8b 40 04             	mov    0x4(%eax),%eax
80102aee:	c1 e0 04             	shl    $0x4,%eax
80102af1:	83 e0 10             	and    $0x10,%eax
80102af4:	89 c2                	mov    %eax,%edx
80102af6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102af9:	c1 f8 18             	sar    $0x18,%eax
80102afc:	83 e0 0f             	and    $0xf,%eax
80102aff:	09 d0                	or     %edx,%eax
80102b01:	83 c8 e0             	or     $0xffffffe0,%eax
80102b04:	0f b6 c0             	movzbl %al,%eax
80102b07:	83 ec 08             	sub    $0x8,%esp
80102b0a:	50                   	push   %eax
80102b0b:	68 f6 01 00 00       	push   $0x1f6
80102b10:	e8 b0 fd ff ff       	call   801028c5 <outb>
80102b15:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102b18:	8b 45 08             	mov    0x8(%ebp),%eax
80102b1b:	8b 00                	mov    (%eax),%eax
80102b1d:	83 e0 04             	and    $0x4,%eax
80102b20:	85 c0                	test   %eax,%eax
80102b22:	74 30                	je     80102b54 <idestart+0x14d>
    outb(0x1f7, IDE_CMD_WRITE);
80102b24:	83 ec 08             	sub    $0x8,%esp
80102b27:	6a 30                	push   $0x30
80102b29:	68 f7 01 00 00       	push   $0x1f7
80102b2e:	e8 92 fd ff ff       	call   801028c5 <outb>
80102b33:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
80102b36:	8b 45 08             	mov    0x8(%ebp),%eax
80102b39:	83 c0 18             	add    $0x18,%eax
80102b3c:	83 ec 04             	sub    $0x4,%esp
80102b3f:	68 80 00 00 00       	push   $0x80
80102b44:	50                   	push   %eax
80102b45:	68 f0 01 00 00       	push   $0x1f0
80102b4a:	e8 97 fd ff ff       	call   801028e6 <outsl>
80102b4f:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
80102b52:	eb 12                	jmp    80102b66 <idestart+0x15f>
    outb(0x1f7, IDE_CMD_READ);
80102b54:	83 ec 08             	sub    $0x8,%esp
80102b57:	6a 20                	push   $0x20
80102b59:	68 f7 01 00 00       	push   $0x1f7
80102b5e:	e8 62 fd ff ff       	call   801028c5 <outb>
80102b63:	83 c4 10             	add    $0x10,%esp
}
80102b66:	90                   	nop
80102b67:	c9                   	leave  
80102b68:	c3                   	ret    

80102b69 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102b69:	f3 0f 1e fb          	endbr32 
80102b6d:	55                   	push   %ebp
80102b6e:	89 e5                	mov    %esp,%ebp
80102b70:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102b73:	83 ec 0c             	sub    $0xc,%esp
80102b76:	68 20 e6 10 80       	push   $0x8010e620
80102b7b:	e8 8f 40 00 00       	call   80106c0f <acquire>
80102b80:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
80102b83:	a1 54 e6 10 80       	mov    0x8010e654,%eax
80102b88:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b8b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102b8f:	75 15                	jne    80102ba6 <ideintr+0x3d>
    release(&idelock);
80102b91:	83 ec 0c             	sub    $0xc,%esp
80102b94:	68 20 e6 10 80       	push   $0x8010e620
80102b99:	e8 dc 40 00 00       	call   80106c7a <release>
80102b9e:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
80102ba1:	e9 9a 00 00 00       	jmp    80102c40 <ideintr+0xd7>
  }
  idequeue = b->qnext;
80102ba6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ba9:	8b 40 14             	mov    0x14(%eax),%eax
80102bac:	a3 54 e6 10 80       	mov    %eax,0x8010e654

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102bb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bb4:	8b 00                	mov    (%eax),%eax
80102bb6:	83 e0 04             	and    $0x4,%eax
80102bb9:	85 c0                	test   %eax,%eax
80102bbb:	75 2d                	jne    80102bea <ideintr+0x81>
80102bbd:	83 ec 0c             	sub    $0xc,%esp
80102bc0:	6a 01                	push   $0x1
80102bc2:	e8 45 fd ff ff       	call   8010290c <idewait>
80102bc7:	83 c4 10             	add    $0x10,%esp
80102bca:	85 c0                	test   %eax,%eax
80102bcc:	78 1c                	js     80102bea <ideintr+0x81>
    insl(0x1f0, b->data, BSIZE/4);
80102bce:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bd1:	83 c0 18             	add    $0x18,%eax
80102bd4:	83 ec 04             	sub    $0x4,%esp
80102bd7:	68 80 00 00 00       	push   $0x80
80102bdc:	50                   	push   %eax
80102bdd:	68 f0 01 00 00       	push   $0x1f0
80102be2:	e8 b8 fc ff ff       	call   8010289f <insl>
80102be7:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102bea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bed:	8b 00                	mov    (%eax),%eax
80102bef:	83 c8 02             	or     $0x2,%eax
80102bf2:	89 c2                	mov    %eax,%edx
80102bf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bf7:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102bf9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bfc:	8b 00                	mov    (%eax),%eax
80102bfe:	83 e0 fb             	and    $0xfffffffb,%eax
80102c01:	89 c2                	mov    %eax,%edx
80102c03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c06:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102c08:	83 ec 0c             	sub    $0xc,%esp
80102c0b:	ff 75 f4             	pushl  -0xc(%ebp)
80102c0e:	e8 58 2f 00 00       	call   80105b6b <wakeup>
80102c13:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
80102c16:	a1 54 e6 10 80       	mov    0x8010e654,%eax
80102c1b:	85 c0                	test   %eax,%eax
80102c1d:	74 11                	je     80102c30 <ideintr+0xc7>
    idestart(idequeue);
80102c1f:	a1 54 e6 10 80       	mov    0x8010e654,%eax
80102c24:	83 ec 0c             	sub    $0xc,%esp
80102c27:	50                   	push   %eax
80102c28:	e8 da fd ff ff       	call   80102a07 <idestart>
80102c2d:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102c30:	83 ec 0c             	sub    $0xc,%esp
80102c33:	68 20 e6 10 80       	push   $0x8010e620
80102c38:	e8 3d 40 00 00       	call   80106c7a <release>
80102c3d:	83 c4 10             	add    $0x10,%esp
}
80102c40:	c9                   	leave  
80102c41:	c3                   	ret    

80102c42 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102c42:	f3 0f 1e fb          	endbr32 
80102c46:	55                   	push   %ebp
80102c47:	89 e5                	mov    %esp,%ebp
80102c49:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
80102c4c:	8b 45 08             	mov    0x8(%ebp),%eax
80102c4f:	8b 00                	mov    (%eax),%eax
80102c51:	83 e0 01             	and    $0x1,%eax
80102c54:	85 c0                	test   %eax,%eax
80102c56:	75 0d                	jne    80102c65 <iderw+0x23>
    panic("iderw: buf not busy");
80102c58:	83 ec 0c             	sub    $0xc,%esp
80102c5b:	68 2c a7 10 80       	push   $0x8010a72c
80102c60:	e8 32 d9 ff ff       	call   80100597 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102c65:	8b 45 08             	mov    0x8(%ebp),%eax
80102c68:	8b 00                	mov    (%eax),%eax
80102c6a:	83 e0 06             	and    $0x6,%eax
80102c6d:	83 f8 02             	cmp    $0x2,%eax
80102c70:	75 0d                	jne    80102c7f <iderw+0x3d>
    panic("iderw: nothing to do");
80102c72:	83 ec 0c             	sub    $0xc,%esp
80102c75:	68 40 a7 10 80       	push   $0x8010a740
80102c7a:	e8 18 d9 ff ff       	call   80100597 <panic>
  if(b->dev != 0 && !havedisk1)
80102c7f:	8b 45 08             	mov    0x8(%ebp),%eax
80102c82:	8b 40 04             	mov    0x4(%eax),%eax
80102c85:	85 c0                	test   %eax,%eax
80102c87:	74 16                	je     80102c9f <iderw+0x5d>
80102c89:	a1 58 e6 10 80       	mov    0x8010e658,%eax
80102c8e:	85 c0                	test   %eax,%eax
80102c90:	75 0d                	jne    80102c9f <iderw+0x5d>
    panic("iderw: ide disk 1 not present");
80102c92:	83 ec 0c             	sub    $0xc,%esp
80102c95:	68 55 a7 10 80       	push   $0x8010a755
80102c9a:	e8 f8 d8 ff ff       	call   80100597 <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102c9f:	83 ec 0c             	sub    $0xc,%esp
80102ca2:	68 20 e6 10 80       	push   $0x8010e620
80102ca7:	e8 63 3f 00 00       	call   80106c0f <acquire>
80102cac:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
80102caf:	8b 45 08             	mov    0x8(%ebp),%eax
80102cb2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102cb9:	c7 45 f4 54 e6 10 80 	movl   $0x8010e654,-0xc(%ebp)
80102cc0:	eb 0b                	jmp    80102ccd <iderw+0x8b>
80102cc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cc5:	8b 00                	mov    (%eax),%eax
80102cc7:	83 c0 14             	add    $0x14,%eax
80102cca:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cd0:	8b 00                	mov    (%eax),%eax
80102cd2:	85 c0                	test   %eax,%eax
80102cd4:	75 ec                	jne    80102cc2 <iderw+0x80>
    ;
  *pp = b;
80102cd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cd9:	8b 55 08             	mov    0x8(%ebp),%edx
80102cdc:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
80102cde:	a1 54 e6 10 80       	mov    0x8010e654,%eax
80102ce3:	39 45 08             	cmp    %eax,0x8(%ebp)
80102ce6:	75 23                	jne    80102d0b <iderw+0xc9>
    idestart(b);
80102ce8:	83 ec 0c             	sub    $0xc,%esp
80102ceb:	ff 75 08             	pushl  0x8(%ebp)
80102cee:	e8 14 fd ff ff       	call   80102a07 <idestart>
80102cf3:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102cf6:	eb 13                	jmp    80102d0b <iderw+0xc9>
    sleep(b, &idelock);
80102cf8:	83 ec 08             	sub    $0x8,%esp
80102cfb:	68 20 e6 10 80       	push   $0x8010e620
80102d00:	ff 75 08             	pushl  0x8(%ebp)
80102d03:	e8 06 2c 00 00       	call   8010590e <sleep>
80102d08:	83 c4 10             	add    $0x10,%esp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102d0b:	8b 45 08             	mov    0x8(%ebp),%eax
80102d0e:	8b 00                	mov    (%eax),%eax
80102d10:	83 e0 06             	and    $0x6,%eax
80102d13:	83 f8 02             	cmp    $0x2,%eax
80102d16:	75 e0                	jne    80102cf8 <iderw+0xb6>
  }

  release(&idelock);
80102d18:	83 ec 0c             	sub    $0xc,%esp
80102d1b:	68 20 e6 10 80       	push   $0x8010e620
80102d20:	e8 55 3f 00 00       	call   80106c7a <release>
80102d25:	83 c4 10             	add    $0x10,%esp
}
80102d28:	90                   	nop
80102d29:	c9                   	leave  
80102d2a:	c3                   	ret    

80102d2b <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102d2b:	f3 0f 1e fb          	endbr32 
80102d2f:	55                   	push   %ebp
80102d30:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102d32:	a1 b4 5e 11 80       	mov    0x80115eb4,%eax
80102d37:	8b 55 08             	mov    0x8(%ebp),%edx
80102d3a:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102d3c:	a1 b4 5e 11 80       	mov    0x80115eb4,%eax
80102d41:	8b 40 10             	mov    0x10(%eax),%eax
}
80102d44:	5d                   	pop    %ebp
80102d45:	c3                   	ret    

80102d46 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102d46:	f3 0f 1e fb          	endbr32 
80102d4a:	55                   	push   %ebp
80102d4b:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102d4d:	a1 b4 5e 11 80       	mov    0x80115eb4,%eax
80102d52:	8b 55 08             	mov    0x8(%ebp),%edx
80102d55:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102d57:	a1 b4 5e 11 80       	mov    0x80115eb4,%eax
80102d5c:	8b 55 0c             	mov    0xc(%ebp),%edx
80102d5f:	89 50 10             	mov    %edx,0x10(%eax)
}
80102d62:	90                   	nop
80102d63:	5d                   	pop    %ebp
80102d64:	c3                   	ret    

80102d65 <ioapicinit>:

void
ioapicinit(void)
{
80102d65:	f3 0f 1e fb          	endbr32 
80102d69:	55                   	push   %ebp
80102d6a:	89 e5                	mov    %esp,%ebp
80102d6c:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102d6f:	a1 e4 5f 11 80       	mov    0x80115fe4,%eax
80102d74:	85 c0                	test   %eax,%eax
80102d76:	0f 84 a0 00 00 00    	je     80102e1c <ioapicinit+0xb7>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102d7c:	c7 05 b4 5e 11 80 00 	movl   $0xfec00000,0x80115eb4
80102d83:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102d86:	6a 01                	push   $0x1
80102d88:	e8 9e ff ff ff       	call   80102d2b <ioapicread>
80102d8d:	83 c4 04             	add    $0x4,%esp
80102d90:	c1 e8 10             	shr    $0x10,%eax
80102d93:	25 ff 00 00 00       	and    $0xff,%eax
80102d98:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102d9b:	6a 00                	push   $0x0
80102d9d:	e8 89 ff ff ff       	call   80102d2b <ioapicread>
80102da2:	83 c4 04             	add    $0x4,%esp
80102da5:	c1 e8 18             	shr    $0x18,%eax
80102da8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102dab:	0f b6 05 e0 5f 11 80 	movzbl 0x80115fe0,%eax
80102db2:	0f b6 c0             	movzbl %al,%eax
80102db5:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80102db8:	74 10                	je     80102dca <ioapicinit+0x65>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102dba:	83 ec 0c             	sub    $0xc,%esp
80102dbd:	68 74 a7 10 80       	push   $0x8010a774
80102dc2:	e8 17 d6 ff ff       	call   801003de <cprintf>
80102dc7:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102dca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102dd1:	eb 3f                	jmp    80102e12 <ioapicinit+0xad>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102dd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102dd6:	83 c0 20             	add    $0x20,%eax
80102dd9:	0d 00 00 01 00       	or     $0x10000,%eax
80102dde:	89 c2                	mov    %eax,%edx
80102de0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102de3:	83 c0 08             	add    $0x8,%eax
80102de6:	01 c0                	add    %eax,%eax
80102de8:	83 ec 08             	sub    $0x8,%esp
80102deb:	52                   	push   %edx
80102dec:	50                   	push   %eax
80102ded:	e8 54 ff ff ff       	call   80102d46 <ioapicwrite>
80102df2:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102df5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102df8:	83 c0 08             	add    $0x8,%eax
80102dfb:	01 c0                	add    %eax,%eax
80102dfd:	83 c0 01             	add    $0x1,%eax
80102e00:	83 ec 08             	sub    $0x8,%esp
80102e03:	6a 00                	push   $0x0
80102e05:	50                   	push   %eax
80102e06:	e8 3b ff ff ff       	call   80102d46 <ioapicwrite>
80102e0b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i <= maxintr; i++){
80102e0e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102e12:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102e15:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102e18:	7e b9                	jle    80102dd3 <ioapicinit+0x6e>
80102e1a:	eb 01                	jmp    80102e1d <ioapicinit+0xb8>
    return;
80102e1c:	90                   	nop
  }
}
80102e1d:	c9                   	leave  
80102e1e:	c3                   	ret    

80102e1f <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102e1f:	f3 0f 1e fb          	endbr32 
80102e23:	55                   	push   %ebp
80102e24:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102e26:	a1 e4 5f 11 80       	mov    0x80115fe4,%eax
80102e2b:	85 c0                	test   %eax,%eax
80102e2d:	74 39                	je     80102e68 <ioapicenable+0x49>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102e2f:	8b 45 08             	mov    0x8(%ebp),%eax
80102e32:	83 c0 20             	add    $0x20,%eax
80102e35:	89 c2                	mov    %eax,%edx
80102e37:	8b 45 08             	mov    0x8(%ebp),%eax
80102e3a:	83 c0 08             	add    $0x8,%eax
80102e3d:	01 c0                	add    %eax,%eax
80102e3f:	52                   	push   %edx
80102e40:	50                   	push   %eax
80102e41:	e8 00 ff ff ff       	call   80102d46 <ioapicwrite>
80102e46:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102e49:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e4c:	c1 e0 18             	shl    $0x18,%eax
80102e4f:	89 c2                	mov    %eax,%edx
80102e51:	8b 45 08             	mov    0x8(%ebp),%eax
80102e54:	83 c0 08             	add    $0x8,%eax
80102e57:	01 c0                	add    %eax,%eax
80102e59:	83 c0 01             	add    $0x1,%eax
80102e5c:	52                   	push   %edx
80102e5d:	50                   	push   %eax
80102e5e:	e8 e3 fe ff ff       	call   80102d46 <ioapicwrite>
80102e63:	83 c4 08             	add    $0x8,%esp
80102e66:	eb 01                	jmp    80102e69 <ioapicenable+0x4a>
    return;
80102e68:	90                   	nop
}
80102e69:	c9                   	leave  
80102e6a:	c3                   	ret    

80102e6b <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102e6b:	55                   	push   %ebp
80102e6c:	89 e5                	mov    %esp,%ebp
80102e6e:	8b 45 08             	mov    0x8(%ebp),%eax
80102e71:	05 00 00 00 80       	add    $0x80000000,%eax
80102e76:	5d                   	pop    %ebp
80102e77:	c3                   	ret    

80102e78 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102e78:	f3 0f 1e fb          	endbr32 
80102e7c:	55                   	push   %ebp
80102e7d:	89 e5                	mov    %esp,%ebp
80102e7f:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102e82:	83 ec 08             	sub    $0x8,%esp
80102e85:	68 a6 a7 10 80       	push   $0x8010a7a6
80102e8a:	68 c0 5e 11 80       	push   $0x80115ec0
80102e8f:	e8 55 3d 00 00       	call   80106be9 <initlock>
80102e94:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102e97:	c7 05 f4 5e 11 80 00 	movl   $0x0,0x80115ef4
80102e9e:	00 00 00 
  freerange(vstart, vend);
80102ea1:	83 ec 08             	sub    $0x8,%esp
80102ea4:	ff 75 0c             	pushl  0xc(%ebp)
80102ea7:	ff 75 08             	pushl  0x8(%ebp)
80102eaa:	e8 2e 00 00 00       	call   80102edd <freerange>
80102eaf:	83 c4 10             	add    $0x10,%esp
}
80102eb2:	90                   	nop
80102eb3:	c9                   	leave  
80102eb4:	c3                   	ret    

80102eb5 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102eb5:	f3 0f 1e fb          	endbr32 
80102eb9:	55                   	push   %ebp
80102eba:	89 e5                	mov    %esp,%ebp
80102ebc:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102ebf:	83 ec 08             	sub    $0x8,%esp
80102ec2:	ff 75 0c             	pushl  0xc(%ebp)
80102ec5:	ff 75 08             	pushl  0x8(%ebp)
80102ec8:	e8 10 00 00 00       	call   80102edd <freerange>
80102ecd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102ed0:	c7 05 f4 5e 11 80 01 	movl   $0x1,0x80115ef4
80102ed7:	00 00 00 
}
80102eda:	90                   	nop
80102edb:	c9                   	leave  
80102edc:	c3                   	ret    

80102edd <freerange>:

void
freerange(void *vstart, void *vend)
{
80102edd:	f3 0f 1e fb          	endbr32 
80102ee1:	55                   	push   %ebp
80102ee2:	89 e5                	mov    %esp,%ebp
80102ee4:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102ee7:	8b 45 08             	mov    0x8(%ebp),%eax
80102eea:	05 ff 0f 00 00       	add    $0xfff,%eax
80102eef:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102ef4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ef7:	eb 15                	jmp    80102f0e <freerange+0x31>
    kfree(p);
80102ef9:	83 ec 0c             	sub    $0xc,%esp
80102efc:	ff 75 f4             	pushl  -0xc(%ebp)
80102eff:	e8 1b 00 00 00       	call   80102f1f <kfree>
80102f04:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102f07:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102f0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f11:	05 00 10 00 00       	add    $0x1000,%eax
80102f16:	39 45 0c             	cmp    %eax,0xc(%ebp)
80102f19:	73 de                	jae    80102ef9 <freerange+0x1c>
}
80102f1b:	90                   	nop
80102f1c:	90                   	nop
80102f1d:	c9                   	leave  
80102f1e:	c3                   	ret    

80102f1f <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102f1f:	f3 0f 1e fb          	endbr32 
80102f23:	55                   	push   %ebp
80102f24:	89 e5                	mov    %esp,%ebp
80102f26:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102f29:	8b 45 08             	mov    0x8(%ebp),%eax
80102f2c:	25 ff 0f 00 00       	and    $0xfff,%eax
80102f31:	85 c0                	test   %eax,%eax
80102f33:	75 1b                	jne    80102f50 <kfree+0x31>
80102f35:	81 7d 08 bc 95 11 80 	cmpl   $0x801195bc,0x8(%ebp)
80102f3c:	72 12                	jb     80102f50 <kfree+0x31>
80102f3e:	ff 75 08             	pushl  0x8(%ebp)
80102f41:	e8 25 ff ff ff       	call   80102e6b <v2p>
80102f46:	83 c4 04             	add    $0x4,%esp
80102f49:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102f4e:	76 0d                	jbe    80102f5d <kfree+0x3e>
    panic("kfree");
80102f50:	83 ec 0c             	sub    $0xc,%esp
80102f53:	68 ab a7 10 80       	push   $0x8010a7ab
80102f58:	e8 3a d6 ff ff       	call   80100597 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102f5d:	83 ec 04             	sub    $0x4,%esp
80102f60:	68 00 10 00 00       	push   $0x1000
80102f65:	6a 01                	push   $0x1
80102f67:	ff 75 08             	pushl  0x8(%ebp)
80102f6a:	e8 1c 3f 00 00       	call   80106e8b <memset>
80102f6f:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102f72:	a1 f4 5e 11 80       	mov    0x80115ef4,%eax
80102f77:	85 c0                	test   %eax,%eax
80102f79:	74 10                	je     80102f8b <kfree+0x6c>
    acquire(&kmem.lock);
80102f7b:	83 ec 0c             	sub    $0xc,%esp
80102f7e:	68 c0 5e 11 80       	push   $0x80115ec0
80102f83:	e8 87 3c 00 00       	call   80106c0f <acquire>
80102f88:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102f8b:	8b 45 08             	mov    0x8(%ebp),%eax
80102f8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102f91:	8b 15 f8 5e 11 80    	mov    0x80115ef8,%edx
80102f97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f9a:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102f9f:	a3 f8 5e 11 80       	mov    %eax,0x80115ef8
  if(kmem.use_lock)
80102fa4:	a1 f4 5e 11 80       	mov    0x80115ef4,%eax
80102fa9:	85 c0                	test   %eax,%eax
80102fab:	74 10                	je     80102fbd <kfree+0x9e>
    release(&kmem.lock);
80102fad:	83 ec 0c             	sub    $0xc,%esp
80102fb0:	68 c0 5e 11 80       	push   $0x80115ec0
80102fb5:	e8 c0 3c 00 00       	call   80106c7a <release>
80102fba:	83 c4 10             	add    $0x10,%esp
}
80102fbd:	90                   	nop
80102fbe:	c9                   	leave  
80102fbf:	c3                   	ret    

80102fc0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102fc0:	f3 0f 1e fb          	endbr32 
80102fc4:	55                   	push   %ebp
80102fc5:	89 e5                	mov    %esp,%ebp
80102fc7:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102fca:	a1 f4 5e 11 80       	mov    0x80115ef4,%eax
80102fcf:	85 c0                	test   %eax,%eax
80102fd1:	74 10                	je     80102fe3 <kalloc+0x23>
    acquire(&kmem.lock);
80102fd3:	83 ec 0c             	sub    $0xc,%esp
80102fd6:	68 c0 5e 11 80       	push   $0x80115ec0
80102fdb:	e8 2f 3c 00 00       	call   80106c0f <acquire>
80102fe0:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102fe3:	a1 f8 5e 11 80       	mov    0x80115ef8,%eax
80102fe8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102feb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102fef:	74 0a                	je     80102ffb <kalloc+0x3b>
    kmem.freelist = r->next;
80102ff1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ff4:	8b 00                	mov    (%eax),%eax
80102ff6:	a3 f8 5e 11 80       	mov    %eax,0x80115ef8
  if(kmem.use_lock)
80102ffb:	a1 f4 5e 11 80       	mov    0x80115ef4,%eax
80103000:	85 c0                	test   %eax,%eax
80103002:	74 10                	je     80103014 <kalloc+0x54>
    release(&kmem.lock);
80103004:	83 ec 0c             	sub    $0xc,%esp
80103007:	68 c0 5e 11 80       	push   $0x80115ec0
8010300c:	e8 69 3c 00 00       	call   80106c7a <release>
80103011:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80103014:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103017:	c9                   	leave  
80103018:	c3                   	ret    

80103019 <inb>:
{
80103019:	55                   	push   %ebp
8010301a:	89 e5                	mov    %esp,%ebp
8010301c:	83 ec 14             	sub    $0x14,%esp
8010301f:	8b 45 08             	mov    0x8(%ebp),%eax
80103022:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103026:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
8010302a:	89 c2                	mov    %eax,%edx
8010302c:	ec                   	in     (%dx),%al
8010302d:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103030:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103034:	c9                   	leave  
80103035:	c3                   	ret    

80103036 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80103036:	f3 0f 1e fb          	endbr32 
8010303a:	55                   	push   %ebp
8010303b:	89 e5                	mov    %esp,%ebp
8010303d:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80103040:	6a 64                	push   $0x64
80103042:	e8 d2 ff ff ff       	call   80103019 <inb>
80103047:	83 c4 04             	add    $0x4,%esp
8010304a:	0f b6 c0             	movzbl %al,%eax
8010304d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80103050:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103053:	83 e0 01             	and    $0x1,%eax
80103056:	85 c0                	test   %eax,%eax
80103058:	75 0a                	jne    80103064 <kbdgetc+0x2e>
    return -1;
8010305a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010305f:	e9 23 01 00 00       	jmp    80103187 <kbdgetc+0x151>
  data = inb(KBDATAP);
80103064:	6a 60                	push   $0x60
80103066:	e8 ae ff ff ff       	call   80103019 <inb>
8010306b:	83 c4 04             	add    $0x4,%esp
8010306e:	0f b6 c0             	movzbl %al,%eax
80103071:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80103074:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
8010307b:	75 17                	jne    80103094 <kbdgetc+0x5e>
    shift |= E0ESC;
8010307d:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
80103082:	83 c8 40             	or     $0x40,%eax
80103085:	a3 5c e6 10 80       	mov    %eax,0x8010e65c
    return 0;
8010308a:	b8 00 00 00 00       	mov    $0x0,%eax
8010308f:	e9 f3 00 00 00       	jmp    80103187 <kbdgetc+0x151>
  } else if(data & 0x80){
80103094:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103097:	25 80 00 00 00       	and    $0x80,%eax
8010309c:	85 c0                	test   %eax,%eax
8010309e:	74 45                	je     801030e5 <kbdgetc+0xaf>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801030a0:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
801030a5:	83 e0 40             	and    $0x40,%eax
801030a8:	85 c0                	test   %eax,%eax
801030aa:	75 08                	jne    801030b4 <kbdgetc+0x7e>
801030ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
801030af:	83 e0 7f             	and    $0x7f,%eax
801030b2:	eb 03                	jmp    801030b7 <kbdgetc+0x81>
801030b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
801030b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
801030ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
801030bd:	05 20 c0 10 80       	add    $0x8010c020,%eax
801030c2:	0f b6 00             	movzbl (%eax),%eax
801030c5:	83 c8 40             	or     $0x40,%eax
801030c8:	0f b6 c0             	movzbl %al,%eax
801030cb:	f7 d0                	not    %eax
801030cd:	89 c2                	mov    %eax,%edx
801030cf:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
801030d4:	21 d0                	and    %edx,%eax
801030d6:	a3 5c e6 10 80       	mov    %eax,0x8010e65c
    return 0;
801030db:	b8 00 00 00 00       	mov    $0x0,%eax
801030e0:	e9 a2 00 00 00       	jmp    80103187 <kbdgetc+0x151>
  } else if(shift & E0ESC){
801030e5:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
801030ea:	83 e0 40             	and    $0x40,%eax
801030ed:	85 c0                	test   %eax,%eax
801030ef:	74 14                	je     80103105 <kbdgetc+0xcf>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801030f1:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
801030f8:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
801030fd:	83 e0 bf             	and    $0xffffffbf,%eax
80103100:	a3 5c e6 10 80       	mov    %eax,0x8010e65c
  }

  shift |= shiftcode[data];
80103105:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103108:	05 20 c0 10 80       	add    $0x8010c020,%eax
8010310d:	0f b6 00             	movzbl (%eax),%eax
80103110:	0f b6 d0             	movzbl %al,%edx
80103113:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
80103118:	09 d0                	or     %edx,%eax
8010311a:	a3 5c e6 10 80       	mov    %eax,0x8010e65c
  shift ^= togglecode[data];
8010311f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103122:	05 20 c1 10 80       	add    $0x8010c120,%eax
80103127:	0f b6 00             	movzbl (%eax),%eax
8010312a:	0f b6 d0             	movzbl %al,%edx
8010312d:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
80103132:	31 d0                	xor    %edx,%eax
80103134:	a3 5c e6 10 80       	mov    %eax,0x8010e65c
  c = charcode[shift & (CTL | SHIFT)][data];
80103139:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
8010313e:	83 e0 03             	and    $0x3,%eax
80103141:	8b 14 85 20 c5 10 80 	mov    -0x7fef3ae0(,%eax,4),%edx
80103148:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010314b:	01 d0                	add    %edx,%eax
8010314d:	0f b6 00             	movzbl (%eax),%eax
80103150:	0f b6 c0             	movzbl %al,%eax
80103153:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80103156:	a1 5c e6 10 80       	mov    0x8010e65c,%eax
8010315b:	83 e0 08             	and    $0x8,%eax
8010315e:	85 c0                	test   %eax,%eax
80103160:	74 22                	je     80103184 <kbdgetc+0x14e>
    if('a' <= c && c <= 'z')
80103162:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80103166:	76 0c                	jbe    80103174 <kbdgetc+0x13e>
80103168:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
8010316c:	77 06                	ja     80103174 <kbdgetc+0x13e>
      c += 'A' - 'a';
8010316e:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80103172:	eb 10                	jmp    80103184 <kbdgetc+0x14e>
    else if('A' <= c && c <= 'Z')
80103174:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80103178:	76 0a                	jbe    80103184 <kbdgetc+0x14e>
8010317a:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
8010317e:	77 04                	ja     80103184 <kbdgetc+0x14e>
      c += 'a' - 'A';
80103180:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80103184:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103187:	c9                   	leave  
80103188:	c3                   	ret    

80103189 <kbdintr>:

void
kbdintr(void)
{
80103189:	f3 0f 1e fb          	endbr32 
8010318d:	55                   	push   %ebp
8010318e:	89 e5                	mov    %esp,%ebp
80103190:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80103193:	83 ec 0c             	sub    $0xc,%esp
80103196:	68 36 30 10 80       	push   $0x80103036
8010319b:	e8 9e d6 ff ff       	call   8010083e <consoleintr>
801031a0:	83 c4 10             	add    $0x10,%esp
}
801031a3:	90                   	nop
801031a4:	c9                   	leave  
801031a5:	c3                   	ret    

801031a6 <inb>:
{
801031a6:	55                   	push   %ebp
801031a7:	89 e5                	mov    %esp,%ebp
801031a9:	83 ec 14             	sub    $0x14,%esp
801031ac:	8b 45 08             	mov    0x8(%ebp),%eax
801031af:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031b3:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801031b7:	89 c2                	mov    %eax,%edx
801031b9:	ec                   	in     (%dx),%al
801031ba:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801031bd:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801031c1:	c9                   	leave  
801031c2:	c3                   	ret    

801031c3 <outb>:
{
801031c3:	55                   	push   %ebp
801031c4:	89 e5                	mov    %esp,%ebp
801031c6:	83 ec 08             	sub    $0x8,%esp
801031c9:	8b 45 08             	mov    0x8(%ebp),%eax
801031cc:	8b 55 0c             	mov    0xc(%ebp),%edx
801031cf:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801031d3:	89 d0                	mov    %edx,%eax
801031d5:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031d8:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801031dc:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801031e0:	ee                   	out    %al,(%dx)
}
801031e1:	90                   	nop
801031e2:	c9                   	leave  
801031e3:	c3                   	ret    

801031e4 <readeflags>:
{
801031e4:	55                   	push   %ebp
801031e5:	89 e5                	mov    %esp,%ebp
801031e7:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801031ea:	9c                   	pushf  
801031eb:	58                   	pop    %eax
801031ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801031ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801031f2:	c9                   	leave  
801031f3:	c3                   	ret    

801031f4 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
801031f4:	f3 0f 1e fb          	endbr32 
801031f8:	55                   	push   %ebp
801031f9:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
801031fb:	a1 fc 5e 11 80       	mov    0x80115efc,%eax
80103200:	8b 55 08             	mov    0x8(%ebp),%edx
80103203:	c1 e2 02             	shl    $0x2,%edx
80103206:	01 c2                	add    %eax,%edx
80103208:	8b 45 0c             	mov    0xc(%ebp),%eax
8010320b:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
8010320d:	a1 fc 5e 11 80       	mov    0x80115efc,%eax
80103212:	83 c0 20             	add    $0x20,%eax
80103215:	8b 00                	mov    (%eax),%eax
}
80103217:	90                   	nop
80103218:	5d                   	pop    %ebp
80103219:	c3                   	ret    

8010321a <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
8010321a:	f3 0f 1e fb          	endbr32 
8010321e:	55                   	push   %ebp
8010321f:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80103221:	a1 fc 5e 11 80       	mov    0x80115efc,%eax
80103226:	85 c0                	test   %eax,%eax
80103228:	0f 84 0c 01 00 00    	je     8010333a <lapicinit+0x120>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
8010322e:	68 3f 01 00 00       	push   $0x13f
80103233:	6a 3c                	push   $0x3c
80103235:	e8 ba ff ff ff       	call   801031f4 <lapicw>
8010323a:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
8010323d:	6a 0b                	push   $0xb
8010323f:	68 f8 00 00 00       	push   $0xf8
80103244:	e8 ab ff ff ff       	call   801031f4 <lapicw>
80103249:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
8010324c:	68 20 00 02 00       	push   $0x20020
80103251:	68 c8 00 00 00       	push   $0xc8
80103256:	e8 99 ff ff ff       	call   801031f4 <lapicw>
8010325b:	83 c4 08             	add    $0x8,%esp
  // lapicw(TICR, 10000000); 
  lapicw(TICR, 1000000000/TPS); // Makes ticks per second programmable
8010325e:	68 40 42 0f 00       	push   $0xf4240
80103263:	68 e0 00 00 00       	push   $0xe0
80103268:	e8 87 ff ff ff       	call   801031f4 <lapicw>
8010326d:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80103270:	68 00 00 01 00       	push   $0x10000
80103275:	68 d4 00 00 00       	push   $0xd4
8010327a:	e8 75 ff ff ff       	call   801031f4 <lapicw>
8010327f:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80103282:	68 00 00 01 00       	push   $0x10000
80103287:	68 d8 00 00 00       	push   $0xd8
8010328c:	e8 63 ff ff ff       	call   801031f4 <lapicw>
80103291:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80103294:	a1 fc 5e 11 80       	mov    0x80115efc,%eax
80103299:	83 c0 30             	add    $0x30,%eax
8010329c:	8b 00                	mov    (%eax),%eax
8010329e:	c1 e8 10             	shr    $0x10,%eax
801032a1:	25 fc 00 00 00       	and    $0xfc,%eax
801032a6:	85 c0                	test   %eax,%eax
801032a8:	74 12                	je     801032bc <lapicinit+0xa2>
    lapicw(PCINT, MASKED);
801032aa:	68 00 00 01 00       	push   $0x10000
801032af:	68 d0 00 00 00       	push   $0xd0
801032b4:	e8 3b ff ff ff       	call   801031f4 <lapicw>
801032b9:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
801032bc:	6a 33                	push   $0x33
801032be:	68 dc 00 00 00       	push   $0xdc
801032c3:	e8 2c ff ff ff       	call   801031f4 <lapicw>
801032c8:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
801032cb:	6a 00                	push   $0x0
801032cd:	68 a0 00 00 00       	push   $0xa0
801032d2:	e8 1d ff ff ff       	call   801031f4 <lapicw>
801032d7:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
801032da:	6a 00                	push   $0x0
801032dc:	68 a0 00 00 00       	push   $0xa0
801032e1:	e8 0e ff ff ff       	call   801031f4 <lapicw>
801032e6:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
801032e9:	6a 00                	push   $0x0
801032eb:	6a 2c                	push   $0x2c
801032ed:	e8 02 ff ff ff       	call   801031f4 <lapicw>
801032f2:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
801032f5:	6a 00                	push   $0x0
801032f7:	68 c4 00 00 00       	push   $0xc4
801032fc:	e8 f3 fe ff ff       	call   801031f4 <lapicw>
80103301:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80103304:	68 00 85 08 00       	push   $0x88500
80103309:	68 c0 00 00 00       	push   $0xc0
8010330e:	e8 e1 fe ff ff       	call   801031f4 <lapicw>
80103313:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80103316:	90                   	nop
80103317:	a1 fc 5e 11 80       	mov    0x80115efc,%eax
8010331c:	05 00 03 00 00       	add    $0x300,%eax
80103321:	8b 00                	mov    (%eax),%eax
80103323:	25 00 10 00 00       	and    $0x1000,%eax
80103328:	85 c0                	test   %eax,%eax
8010332a:	75 eb                	jne    80103317 <lapicinit+0xfd>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
8010332c:	6a 00                	push   $0x0
8010332e:	6a 20                	push   $0x20
80103330:	e8 bf fe ff ff       	call   801031f4 <lapicw>
80103335:	83 c4 08             	add    $0x8,%esp
80103338:	eb 01                	jmp    8010333b <lapicinit+0x121>
    return;
8010333a:	90                   	nop
}
8010333b:	c9                   	leave  
8010333c:	c3                   	ret    

8010333d <cpunum>:

int
cpunum(void)
{
8010333d:	f3 0f 1e fb          	endbr32 
80103341:	55                   	push   %ebp
80103342:	89 e5                	mov    %esp,%ebp
80103344:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80103347:	e8 98 fe ff ff       	call   801031e4 <readeflags>
8010334c:	25 00 02 00 00       	and    $0x200,%eax
80103351:	85 c0                	test   %eax,%eax
80103353:	74 26                	je     8010337b <cpunum+0x3e>
    static int n;
    if(n++ == 0)
80103355:	a1 60 e6 10 80       	mov    0x8010e660,%eax
8010335a:	8d 50 01             	lea    0x1(%eax),%edx
8010335d:	89 15 60 e6 10 80    	mov    %edx,0x8010e660
80103363:	85 c0                	test   %eax,%eax
80103365:	75 14                	jne    8010337b <cpunum+0x3e>
      cprintf("cpu called from %x with interrupts enabled\n",
80103367:	8b 45 04             	mov    0x4(%ebp),%eax
8010336a:	83 ec 08             	sub    $0x8,%esp
8010336d:	50                   	push   %eax
8010336e:	68 b4 a7 10 80       	push   $0x8010a7b4
80103373:	e8 66 d0 ff ff       	call   801003de <cprintf>
80103378:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
8010337b:	a1 fc 5e 11 80       	mov    0x80115efc,%eax
80103380:	85 c0                	test   %eax,%eax
80103382:	74 0f                	je     80103393 <cpunum+0x56>
    return lapic[ID]>>24;
80103384:	a1 fc 5e 11 80       	mov    0x80115efc,%eax
80103389:	83 c0 20             	add    $0x20,%eax
8010338c:	8b 00                	mov    (%eax),%eax
8010338e:	c1 e8 18             	shr    $0x18,%eax
80103391:	eb 05                	jmp    80103398 <cpunum+0x5b>
  return 0;
80103393:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103398:	c9                   	leave  
80103399:	c3                   	ret    

8010339a <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
8010339a:	f3 0f 1e fb          	endbr32 
8010339e:	55                   	push   %ebp
8010339f:	89 e5                	mov    %esp,%ebp
  if(lapic)
801033a1:	a1 fc 5e 11 80       	mov    0x80115efc,%eax
801033a6:	85 c0                	test   %eax,%eax
801033a8:	74 0c                	je     801033b6 <lapiceoi+0x1c>
    lapicw(EOI, 0);
801033aa:	6a 00                	push   $0x0
801033ac:	6a 2c                	push   $0x2c
801033ae:	e8 41 fe ff ff       	call   801031f4 <lapicw>
801033b3:	83 c4 08             	add    $0x8,%esp
}
801033b6:	90                   	nop
801033b7:	c9                   	leave  
801033b8:	c3                   	ret    

801033b9 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801033b9:	f3 0f 1e fb          	endbr32 
801033bd:	55                   	push   %ebp
801033be:	89 e5                	mov    %esp,%ebp
}
801033c0:	90                   	nop
801033c1:	5d                   	pop    %ebp
801033c2:	c3                   	ret    

801033c3 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801033c3:	f3 0f 1e fb          	endbr32 
801033c7:	55                   	push   %ebp
801033c8:	89 e5                	mov    %esp,%ebp
801033ca:	83 ec 14             	sub    $0x14,%esp
801033cd:	8b 45 08             	mov    0x8(%ebp),%eax
801033d0:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
801033d3:	6a 0f                	push   $0xf
801033d5:	6a 70                	push   $0x70
801033d7:	e8 e7 fd ff ff       	call   801031c3 <outb>
801033dc:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
801033df:	6a 0a                	push   $0xa
801033e1:	6a 71                	push   $0x71
801033e3:	e8 db fd ff ff       	call   801031c3 <outb>
801033e8:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
801033eb:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
801033f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
801033f5:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
801033fa:	8b 45 0c             	mov    0xc(%ebp),%eax
801033fd:	c1 e8 04             	shr    $0x4,%eax
80103400:	89 c2                	mov    %eax,%edx
80103402:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103405:	83 c0 02             	add    $0x2,%eax
80103408:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010340b:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010340f:	c1 e0 18             	shl    $0x18,%eax
80103412:	50                   	push   %eax
80103413:	68 c4 00 00 00       	push   $0xc4
80103418:	e8 d7 fd ff ff       	call   801031f4 <lapicw>
8010341d:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80103420:	68 00 c5 00 00       	push   $0xc500
80103425:	68 c0 00 00 00       	push   $0xc0
8010342a:	e8 c5 fd ff ff       	call   801031f4 <lapicw>
8010342f:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80103432:	68 c8 00 00 00       	push   $0xc8
80103437:	e8 7d ff ff ff       	call   801033b9 <microdelay>
8010343c:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
8010343f:	68 00 85 00 00       	push   $0x8500
80103444:	68 c0 00 00 00       	push   $0xc0
80103449:	e8 a6 fd ff ff       	call   801031f4 <lapicw>
8010344e:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80103451:	6a 64                	push   $0x64
80103453:	e8 61 ff ff ff       	call   801033b9 <microdelay>
80103458:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
8010345b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103462:	eb 3d                	jmp    801034a1 <lapicstartap+0xde>
    lapicw(ICRHI, apicid<<24);
80103464:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103468:	c1 e0 18             	shl    $0x18,%eax
8010346b:	50                   	push   %eax
8010346c:	68 c4 00 00 00       	push   $0xc4
80103471:	e8 7e fd ff ff       	call   801031f4 <lapicw>
80103476:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
80103479:	8b 45 0c             	mov    0xc(%ebp),%eax
8010347c:	c1 e8 0c             	shr    $0xc,%eax
8010347f:	80 cc 06             	or     $0x6,%ah
80103482:	50                   	push   %eax
80103483:	68 c0 00 00 00       	push   $0xc0
80103488:	e8 67 fd ff ff       	call   801031f4 <lapicw>
8010348d:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
80103490:	68 c8 00 00 00       	push   $0xc8
80103495:	e8 1f ff ff ff       	call   801033b9 <microdelay>
8010349a:	83 c4 04             	add    $0x4,%esp
  for(i = 0; i < 2; i++){
8010349d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801034a1:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801034a5:	7e bd                	jle    80103464 <lapicstartap+0xa1>
  }
}
801034a7:	90                   	nop
801034a8:	90                   	nop
801034a9:	c9                   	leave  
801034aa:	c3                   	ret    

801034ab <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
801034ab:	f3 0f 1e fb          	endbr32 
801034af:	55                   	push   %ebp
801034b0:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
801034b2:	8b 45 08             	mov    0x8(%ebp),%eax
801034b5:	0f b6 c0             	movzbl %al,%eax
801034b8:	50                   	push   %eax
801034b9:	6a 70                	push   $0x70
801034bb:	e8 03 fd ff ff       	call   801031c3 <outb>
801034c0:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
801034c3:	68 c8 00 00 00       	push   $0xc8
801034c8:	e8 ec fe ff ff       	call   801033b9 <microdelay>
801034cd:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
801034d0:	6a 71                	push   $0x71
801034d2:	e8 cf fc ff ff       	call   801031a6 <inb>
801034d7:	83 c4 04             	add    $0x4,%esp
801034da:	0f b6 c0             	movzbl %al,%eax
}
801034dd:	c9                   	leave  
801034de:	c3                   	ret    

801034df <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
801034df:	f3 0f 1e fb          	endbr32 
801034e3:	55                   	push   %ebp
801034e4:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
801034e6:	6a 00                	push   $0x0
801034e8:	e8 be ff ff ff       	call   801034ab <cmos_read>
801034ed:	83 c4 04             	add    $0x4,%esp
801034f0:	8b 55 08             	mov    0x8(%ebp),%edx
801034f3:	89 02                	mov    %eax,(%edx)
  r->minute = cmos_read(MINS);
801034f5:	6a 02                	push   $0x2
801034f7:	e8 af ff ff ff       	call   801034ab <cmos_read>
801034fc:	83 c4 04             	add    $0x4,%esp
801034ff:	8b 55 08             	mov    0x8(%ebp),%edx
80103502:	89 42 04             	mov    %eax,0x4(%edx)
  r->hour   = cmos_read(HOURS);
80103505:	6a 04                	push   $0x4
80103507:	e8 9f ff ff ff       	call   801034ab <cmos_read>
8010350c:	83 c4 04             	add    $0x4,%esp
8010350f:	8b 55 08             	mov    0x8(%ebp),%edx
80103512:	89 42 08             	mov    %eax,0x8(%edx)
  r->day    = cmos_read(DAY);
80103515:	6a 07                	push   $0x7
80103517:	e8 8f ff ff ff       	call   801034ab <cmos_read>
8010351c:	83 c4 04             	add    $0x4,%esp
8010351f:	8b 55 08             	mov    0x8(%ebp),%edx
80103522:	89 42 0c             	mov    %eax,0xc(%edx)
  r->month  = cmos_read(MONTH);
80103525:	6a 08                	push   $0x8
80103527:	e8 7f ff ff ff       	call   801034ab <cmos_read>
8010352c:	83 c4 04             	add    $0x4,%esp
8010352f:	8b 55 08             	mov    0x8(%ebp),%edx
80103532:	89 42 10             	mov    %eax,0x10(%edx)
  r->year   = cmos_read(YEAR);
80103535:	6a 09                	push   $0x9
80103537:	e8 6f ff ff ff       	call   801034ab <cmos_read>
8010353c:	83 c4 04             	add    $0x4,%esp
8010353f:	8b 55 08             	mov    0x8(%ebp),%edx
80103542:	89 42 14             	mov    %eax,0x14(%edx)
}
80103545:	90                   	nop
80103546:	c9                   	leave  
80103547:	c3                   	ret    

80103548 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80103548:	f3 0f 1e fb          	endbr32 
8010354c:	55                   	push   %ebp
8010354d:	89 e5                	mov    %esp,%ebp
8010354f:	83 ec 48             	sub    $0x48,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
80103552:	6a 0b                	push   $0xb
80103554:	e8 52 ff ff ff       	call   801034ab <cmos_read>
80103559:	83 c4 04             	add    $0x4,%esp
8010355c:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
8010355f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103562:	83 e0 04             	and    $0x4,%eax
80103565:	85 c0                	test   %eax,%eax
80103567:	0f 94 c0             	sete   %al
8010356a:	0f b6 c0             	movzbl %al,%eax
8010356d:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for (;;) {
    fill_rtcdate(&t1);
80103570:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103573:	50                   	push   %eax
80103574:	e8 66 ff ff ff       	call   801034df <fill_rtcdate>
80103579:	83 c4 04             	add    $0x4,%esp
    if (cmos_read(CMOS_STATA) & CMOS_UIP)
8010357c:	6a 0a                	push   $0xa
8010357e:	e8 28 ff ff ff       	call   801034ab <cmos_read>
80103583:	83 c4 04             	add    $0x4,%esp
80103586:	25 80 00 00 00       	and    $0x80,%eax
8010358b:	85 c0                	test   %eax,%eax
8010358d:	75 27                	jne    801035b6 <cmostime+0x6e>
        continue;
    fill_rtcdate(&t2);
8010358f:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103592:	50                   	push   %eax
80103593:	e8 47 ff ff ff       	call   801034df <fill_rtcdate>
80103598:	83 c4 04             	add    $0x4,%esp
    if (memcmp(&t1, &t2, sizeof(t1)) == 0)
8010359b:	83 ec 04             	sub    $0x4,%esp
8010359e:	6a 18                	push   $0x18
801035a0:	8d 45 c0             	lea    -0x40(%ebp),%eax
801035a3:	50                   	push   %eax
801035a4:	8d 45 d8             	lea    -0x28(%ebp),%eax
801035a7:	50                   	push   %eax
801035a8:	e8 49 39 00 00       	call   80106ef6 <memcmp>
801035ad:	83 c4 10             	add    $0x10,%esp
801035b0:	85 c0                	test   %eax,%eax
801035b2:	74 05                	je     801035b9 <cmostime+0x71>
801035b4:	eb ba                	jmp    80103570 <cmostime+0x28>
        continue;
801035b6:	90                   	nop
    fill_rtcdate(&t1);
801035b7:	eb b7                	jmp    80103570 <cmostime+0x28>
      break;
801035b9:	90                   	nop
  }

  // convert
  if (bcd) {
801035ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801035be:	0f 84 b4 00 00 00    	je     80103678 <cmostime+0x130>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801035c4:	8b 45 d8             	mov    -0x28(%ebp),%eax
801035c7:	c1 e8 04             	shr    $0x4,%eax
801035ca:	89 c2                	mov    %eax,%edx
801035cc:	89 d0                	mov    %edx,%eax
801035ce:	c1 e0 02             	shl    $0x2,%eax
801035d1:	01 d0                	add    %edx,%eax
801035d3:	01 c0                	add    %eax,%eax
801035d5:	89 c2                	mov    %eax,%edx
801035d7:	8b 45 d8             	mov    -0x28(%ebp),%eax
801035da:	83 e0 0f             	and    $0xf,%eax
801035dd:	01 d0                	add    %edx,%eax
801035df:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
801035e2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801035e5:	c1 e8 04             	shr    $0x4,%eax
801035e8:	89 c2                	mov    %eax,%edx
801035ea:	89 d0                	mov    %edx,%eax
801035ec:	c1 e0 02             	shl    $0x2,%eax
801035ef:	01 d0                	add    %edx,%eax
801035f1:	01 c0                	add    %eax,%eax
801035f3:	89 c2                	mov    %eax,%edx
801035f5:	8b 45 dc             	mov    -0x24(%ebp),%eax
801035f8:	83 e0 0f             	and    $0xf,%eax
801035fb:	01 d0                	add    %edx,%eax
801035fd:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
80103600:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103603:	c1 e8 04             	shr    $0x4,%eax
80103606:	89 c2                	mov    %eax,%edx
80103608:	89 d0                	mov    %edx,%eax
8010360a:	c1 e0 02             	shl    $0x2,%eax
8010360d:	01 d0                	add    %edx,%eax
8010360f:	01 c0                	add    %eax,%eax
80103611:	89 c2                	mov    %eax,%edx
80103613:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103616:	83 e0 0f             	and    $0xf,%eax
80103619:	01 d0                	add    %edx,%eax
8010361b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
8010361e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103621:	c1 e8 04             	shr    $0x4,%eax
80103624:	89 c2                	mov    %eax,%edx
80103626:	89 d0                	mov    %edx,%eax
80103628:	c1 e0 02             	shl    $0x2,%eax
8010362b:	01 d0                	add    %edx,%eax
8010362d:	01 c0                	add    %eax,%eax
8010362f:	89 c2                	mov    %eax,%edx
80103631:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103634:	83 e0 0f             	and    $0xf,%eax
80103637:	01 d0                	add    %edx,%eax
80103639:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
8010363c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010363f:	c1 e8 04             	shr    $0x4,%eax
80103642:	89 c2                	mov    %eax,%edx
80103644:	89 d0                	mov    %edx,%eax
80103646:	c1 e0 02             	shl    $0x2,%eax
80103649:	01 d0                	add    %edx,%eax
8010364b:	01 c0                	add    %eax,%eax
8010364d:	89 c2                	mov    %eax,%edx
8010364f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103652:	83 e0 0f             	and    $0xf,%eax
80103655:	01 d0                	add    %edx,%eax
80103657:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
8010365a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010365d:	c1 e8 04             	shr    $0x4,%eax
80103660:	89 c2                	mov    %eax,%edx
80103662:	89 d0                	mov    %edx,%eax
80103664:	c1 e0 02             	shl    $0x2,%eax
80103667:	01 d0                	add    %edx,%eax
80103669:	01 c0                	add    %eax,%eax
8010366b:	89 c2                	mov    %eax,%edx
8010366d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103670:	83 e0 0f             	and    $0xf,%eax
80103673:	01 d0                	add    %edx,%eax
80103675:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
80103678:	8b 45 08             	mov    0x8(%ebp),%eax
8010367b:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010367e:	89 10                	mov    %edx,(%eax)
80103680:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103683:	89 50 04             	mov    %edx,0x4(%eax)
80103686:	8b 55 e0             	mov    -0x20(%ebp),%edx
80103689:	89 50 08             	mov    %edx,0x8(%eax)
8010368c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010368f:	89 50 0c             	mov    %edx,0xc(%eax)
80103692:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103695:	89 50 10             	mov    %edx,0x10(%eax)
80103698:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010369b:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
8010369e:	8b 45 08             	mov    0x8(%ebp),%eax
801036a1:	8b 40 14             	mov    0x14(%eax),%eax
801036a4:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
801036aa:	8b 45 08             	mov    0x8(%ebp),%eax
801036ad:	89 50 14             	mov    %edx,0x14(%eax)
}
801036b0:	90                   	nop
801036b1:	c9                   	leave  
801036b2:	c3                   	ret    

801036b3 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
801036b3:	f3 0f 1e fb          	endbr32 
801036b7:	55                   	push   %ebp
801036b8:	89 e5                	mov    %esp,%ebp
801036ba:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801036bd:	83 ec 08             	sub    $0x8,%esp
801036c0:	68 e0 a7 10 80       	push   $0x8010a7e0
801036c5:	68 00 5f 11 80       	push   $0x80115f00
801036ca:	e8 1a 35 00 00       	call   80106be9 <initlock>
801036cf:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
801036d2:	83 ec 08             	sub    $0x8,%esp
801036d5:	8d 45 dc             	lea    -0x24(%ebp),%eax
801036d8:	50                   	push   %eax
801036d9:	ff 75 08             	pushl  0x8(%ebp)
801036dc:	e8 3d de ff ff       	call   8010151e <readsb>
801036e1:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
801036e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801036e7:	a3 34 5f 11 80       	mov    %eax,0x80115f34
  log.size = sb.nlog;
801036ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
801036ef:	a3 38 5f 11 80       	mov    %eax,0x80115f38
  log.dev = dev;
801036f4:	8b 45 08             	mov    0x8(%ebp),%eax
801036f7:	a3 44 5f 11 80       	mov    %eax,0x80115f44
  recover_from_log();
801036fc:	e8 bf 01 00 00       	call   801038c0 <recover_from_log>
}
80103701:	90                   	nop
80103702:	c9                   	leave  
80103703:	c3                   	ret    

80103704 <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
80103704:	f3 0f 1e fb          	endbr32 
80103708:	55                   	push   %ebp
80103709:	89 e5                	mov    %esp,%ebp
8010370b:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010370e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103715:	e9 95 00 00 00       	jmp    801037af <install_trans+0xab>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
8010371a:	8b 15 34 5f 11 80    	mov    0x80115f34,%edx
80103720:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103723:	01 d0                	add    %edx,%eax
80103725:	83 c0 01             	add    $0x1,%eax
80103728:	89 c2                	mov    %eax,%edx
8010372a:	a1 44 5f 11 80       	mov    0x80115f44,%eax
8010372f:	83 ec 08             	sub    $0x8,%esp
80103732:	52                   	push   %edx
80103733:	50                   	push   %eax
80103734:	e8 86 ca ff ff       	call   801001bf <bread>
80103739:	83 c4 10             	add    $0x10,%esp
8010373c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010373f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103742:	83 c0 10             	add    $0x10,%eax
80103745:	8b 04 85 0c 5f 11 80 	mov    -0x7feea0f4(,%eax,4),%eax
8010374c:	89 c2                	mov    %eax,%edx
8010374e:	a1 44 5f 11 80       	mov    0x80115f44,%eax
80103753:	83 ec 08             	sub    $0x8,%esp
80103756:	52                   	push   %edx
80103757:	50                   	push   %eax
80103758:	e8 62 ca ff ff       	call   801001bf <bread>
8010375d:	83 c4 10             	add    $0x10,%esp
80103760:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103763:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103766:	8d 50 18             	lea    0x18(%eax),%edx
80103769:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010376c:	83 c0 18             	add    $0x18,%eax
8010376f:	83 ec 04             	sub    $0x4,%esp
80103772:	68 00 02 00 00       	push   $0x200
80103777:	52                   	push   %edx
80103778:	50                   	push   %eax
80103779:	e8 d4 37 00 00       	call   80106f52 <memmove>
8010377e:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103781:	83 ec 0c             	sub    $0xc,%esp
80103784:	ff 75 ec             	pushl  -0x14(%ebp)
80103787:	e8 70 ca ff ff       	call   801001fc <bwrite>
8010378c:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
8010378f:	83 ec 0c             	sub    $0xc,%esp
80103792:	ff 75 f0             	pushl  -0x10(%ebp)
80103795:	e8 a5 ca ff ff       	call   8010023f <brelse>
8010379a:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
8010379d:	83 ec 0c             	sub    $0xc,%esp
801037a0:	ff 75 ec             	pushl  -0x14(%ebp)
801037a3:	e8 97 ca ff ff       	call   8010023f <brelse>
801037a8:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
801037ab:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801037af:	a1 48 5f 11 80       	mov    0x80115f48,%eax
801037b4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801037b7:	0f 8c 5d ff ff ff    	jl     8010371a <install_trans+0x16>
  }
}
801037bd:	90                   	nop
801037be:	90                   	nop
801037bf:	c9                   	leave  
801037c0:	c3                   	ret    

801037c1 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
801037c1:	f3 0f 1e fb          	endbr32 
801037c5:	55                   	push   %ebp
801037c6:	89 e5                	mov    %esp,%ebp
801037c8:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801037cb:	a1 34 5f 11 80       	mov    0x80115f34,%eax
801037d0:	89 c2                	mov    %eax,%edx
801037d2:	a1 44 5f 11 80       	mov    0x80115f44,%eax
801037d7:	83 ec 08             	sub    $0x8,%esp
801037da:	52                   	push   %edx
801037db:	50                   	push   %eax
801037dc:	e8 de c9 ff ff       	call   801001bf <bread>
801037e1:	83 c4 10             	add    $0x10,%esp
801037e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
801037e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801037ea:	83 c0 18             	add    $0x18,%eax
801037ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
801037f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801037f3:	8b 00                	mov    (%eax),%eax
801037f5:	a3 48 5f 11 80       	mov    %eax,0x80115f48
  for (i = 0; i < log.lh.n; i++) {
801037fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103801:	eb 1b                	jmp    8010381e <read_head+0x5d>
    log.lh.block[i] = lh->block[i];
80103803:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103806:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103809:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
8010380d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103810:	83 c2 10             	add    $0x10,%edx
80103813:	89 04 95 0c 5f 11 80 	mov    %eax,-0x7feea0f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010381a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010381e:	a1 48 5f 11 80       	mov    0x80115f48,%eax
80103823:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103826:	7c db                	jl     80103803 <read_head+0x42>
  }
  brelse(buf);
80103828:	83 ec 0c             	sub    $0xc,%esp
8010382b:	ff 75 f0             	pushl  -0x10(%ebp)
8010382e:	e8 0c ca ff ff       	call   8010023f <brelse>
80103833:	83 c4 10             	add    $0x10,%esp
}
80103836:	90                   	nop
80103837:	c9                   	leave  
80103838:	c3                   	ret    

80103839 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103839:	f3 0f 1e fb          	endbr32 
8010383d:	55                   	push   %ebp
8010383e:	89 e5                	mov    %esp,%ebp
80103840:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103843:	a1 34 5f 11 80       	mov    0x80115f34,%eax
80103848:	89 c2                	mov    %eax,%edx
8010384a:	a1 44 5f 11 80       	mov    0x80115f44,%eax
8010384f:	83 ec 08             	sub    $0x8,%esp
80103852:	52                   	push   %edx
80103853:	50                   	push   %eax
80103854:	e8 66 c9 ff ff       	call   801001bf <bread>
80103859:	83 c4 10             	add    $0x10,%esp
8010385c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
8010385f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103862:	83 c0 18             	add    $0x18,%eax
80103865:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103868:	8b 15 48 5f 11 80    	mov    0x80115f48,%edx
8010386e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103871:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103873:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010387a:	eb 1b                	jmp    80103897 <write_head+0x5e>
    hb->block[i] = log.lh.block[i];
8010387c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010387f:	83 c0 10             	add    $0x10,%eax
80103882:	8b 0c 85 0c 5f 11 80 	mov    -0x7feea0f4(,%eax,4),%ecx
80103889:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010388c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010388f:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103893:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103897:	a1 48 5f 11 80       	mov    0x80115f48,%eax
8010389c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010389f:	7c db                	jl     8010387c <write_head+0x43>
  }
  bwrite(buf);
801038a1:	83 ec 0c             	sub    $0xc,%esp
801038a4:	ff 75 f0             	pushl  -0x10(%ebp)
801038a7:	e8 50 c9 ff ff       	call   801001fc <bwrite>
801038ac:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
801038af:	83 ec 0c             	sub    $0xc,%esp
801038b2:	ff 75 f0             	pushl  -0x10(%ebp)
801038b5:	e8 85 c9 ff ff       	call   8010023f <brelse>
801038ba:	83 c4 10             	add    $0x10,%esp
}
801038bd:	90                   	nop
801038be:	c9                   	leave  
801038bf:	c3                   	ret    

801038c0 <recover_from_log>:

static void
recover_from_log(void)
{
801038c0:	f3 0f 1e fb          	endbr32 
801038c4:	55                   	push   %ebp
801038c5:	89 e5                	mov    %esp,%ebp
801038c7:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801038ca:	e8 f2 fe ff ff       	call   801037c1 <read_head>
  install_trans(); // if committed, copy from log to disk
801038cf:	e8 30 fe ff ff       	call   80103704 <install_trans>
  log.lh.n = 0;
801038d4:	c7 05 48 5f 11 80 00 	movl   $0x0,0x80115f48
801038db:	00 00 00 
  write_head(); // clear the log
801038de:	e8 56 ff ff ff       	call   80103839 <write_head>
}
801038e3:	90                   	nop
801038e4:	c9                   	leave  
801038e5:	c3                   	ret    

801038e6 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
801038e6:	f3 0f 1e fb          	endbr32 
801038ea:	55                   	push   %ebp
801038eb:	89 e5                	mov    %esp,%ebp
801038ed:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
801038f0:	83 ec 0c             	sub    $0xc,%esp
801038f3:	68 00 5f 11 80       	push   $0x80115f00
801038f8:	e8 12 33 00 00       	call   80106c0f <acquire>
801038fd:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
80103900:	a1 40 5f 11 80       	mov    0x80115f40,%eax
80103905:	85 c0                	test   %eax,%eax
80103907:	74 17                	je     80103920 <begin_op+0x3a>
      sleep(&log, &log.lock);
80103909:	83 ec 08             	sub    $0x8,%esp
8010390c:	68 00 5f 11 80       	push   $0x80115f00
80103911:	68 00 5f 11 80       	push   $0x80115f00
80103916:	e8 f3 1f 00 00       	call   8010590e <sleep>
8010391b:	83 c4 10             	add    $0x10,%esp
8010391e:	eb e0                	jmp    80103900 <begin_op+0x1a>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103920:	8b 0d 48 5f 11 80    	mov    0x80115f48,%ecx
80103926:	a1 3c 5f 11 80       	mov    0x80115f3c,%eax
8010392b:	8d 50 01             	lea    0x1(%eax),%edx
8010392e:	89 d0                	mov    %edx,%eax
80103930:	c1 e0 02             	shl    $0x2,%eax
80103933:	01 d0                	add    %edx,%eax
80103935:	01 c0                	add    %eax,%eax
80103937:	01 c8                	add    %ecx,%eax
80103939:	83 f8 1e             	cmp    $0x1e,%eax
8010393c:	7e 17                	jle    80103955 <begin_op+0x6f>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
8010393e:	83 ec 08             	sub    $0x8,%esp
80103941:	68 00 5f 11 80       	push   $0x80115f00
80103946:	68 00 5f 11 80       	push   $0x80115f00
8010394b:	e8 be 1f 00 00       	call   8010590e <sleep>
80103950:	83 c4 10             	add    $0x10,%esp
80103953:	eb ab                	jmp    80103900 <begin_op+0x1a>
    } else {
      log.outstanding += 1;
80103955:	a1 3c 5f 11 80       	mov    0x80115f3c,%eax
8010395a:	83 c0 01             	add    $0x1,%eax
8010395d:	a3 3c 5f 11 80       	mov    %eax,0x80115f3c
      release(&log.lock);
80103962:	83 ec 0c             	sub    $0xc,%esp
80103965:	68 00 5f 11 80       	push   $0x80115f00
8010396a:	e8 0b 33 00 00       	call   80106c7a <release>
8010396f:	83 c4 10             	add    $0x10,%esp
      break;
80103972:	90                   	nop
    }
  }
}
80103973:	90                   	nop
80103974:	c9                   	leave  
80103975:	c3                   	ret    

80103976 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103976:	f3 0f 1e fb          	endbr32 
8010397a:	55                   	push   %ebp
8010397b:	89 e5                	mov    %esp,%ebp
8010397d:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
80103980:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
80103987:	83 ec 0c             	sub    $0xc,%esp
8010398a:	68 00 5f 11 80       	push   $0x80115f00
8010398f:	e8 7b 32 00 00       	call   80106c0f <acquire>
80103994:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103997:	a1 3c 5f 11 80       	mov    0x80115f3c,%eax
8010399c:	83 e8 01             	sub    $0x1,%eax
8010399f:	a3 3c 5f 11 80       	mov    %eax,0x80115f3c
  if(log.committing)
801039a4:	a1 40 5f 11 80       	mov    0x80115f40,%eax
801039a9:	85 c0                	test   %eax,%eax
801039ab:	74 0d                	je     801039ba <end_op+0x44>
    panic("log.committing");
801039ad:	83 ec 0c             	sub    $0xc,%esp
801039b0:	68 e4 a7 10 80       	push   $0x8010a7e4
801039b5:	e8 dd cb ff ff       	call   80100597 <panic>
  if(log.outstanding == 0){
801039ba:	a1 3c 5f 11 80       	mov    0x80115f3c,%eax
801039bf:	85 c0                	test   %eax,%eax
801039c1:	75 13                	jne    801039d6 <end_op+0x60>
    do_commit = 1;
801039c3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
801039ca:	c7 05 40 5f 11 80 01 	movl   $0x1,0x80115f40
801039d1:	00 00 00 
801039d4:	eb 10                	jmp    801039e6 <end_op+0x70>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
801039d6:	83 ec 0c             	sub    $0xc,%esp
801039d9:	68 00 5f 11 80       	push   $0x80115f00
801039de:	e8 88 21 00 00       	call   80105b6b <wakeup>
801039e3:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
801039e6:	83 ec 0c             	sub    $0xc,%esp
801039e9:	68 00 5f 11 80       	push   $0x80115f00
801039ee:	e8 87 32 00 00       	call   80106c7a <release>
801039f3:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
801039f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801039fa:	74 3f                	je     80103a3b <end_op+0xc5>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
801039fc:	e8 fa 00 00 00       	call   80103afb <commit>
    acquire(&log.lock);
80103a01:	83 ec 0c             	sub    $0xc,%esp
80103a04:	68 00 5f 11 80       	push   $0x80115f00
80103a09:	e8 01 32 00 00       	call   80106c0f <acquire>
80103a0e:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
80103a11:	c7 05 40 5f 11 80 00 	movl   $0x0,0x80115f40
80103a18:	00 00 00 
    wakeup(&log);
80103a1b:	83 ec 0c             	sub    $0xc,%esp
80103a1e:	68 00 5f 11 80       	push   $0x80115f00
80103a23:	e8 43 21 00 00       	call   80105b6b <wakeup>
80103a28:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
80103a2b:	83 ec 0c             	sub    $0xc,%esp
80103a2e:	68 00 5f 11 80       	push   $0x80115f00
80103a33:	e8 42 32 00 00       	call   80106c7a <release>
80103a38:	83 c4 10             	add    $0x10,%esp
  }
}
80103a3b:	90                   	nop
80103a3c:	c9                   	leave  
80103a3d:	c3                   	ret    

80103a3e <write_log>:

// Copy modified blocks from cache to log.
static void 
write_log(void)
{
80103a3e:	f3 0f 1e fb          	endbr32 
80103a42:	55                   	push   %ebp
80103a43:	89 e5                	mov    %esp,%ebp
80103a45:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103a48:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103a4f:	e9 95 00 00 00       	jmp    80103ae9 <write_log+0xab>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103a54:	8b 15 34 5f 11 80    	mov    0x80115f34,%edx
80103a5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a5d:	01 d0                	add    %edx,%eax
80103a5f:	83 c0 01             	add    $0x1,%eax
80103a62:	89 c2                	mov    %eax,%edx
80103a64:	a1 44 5f 11 80       	mov    0x80115f44,%eax
80103a69:	83 ec 08             	sub    $0x8,%esp
80103a6c:	52                   	push   %edx
80103a6d:	50                   	push   %eax
80103a6e:	e8 4c c7 ff ff       	call   801001bf <bread>
80103a73:	83 c4 10             	add    $0x10,%esp
80103a76:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a7c:	83 c0 10             	add    $0x10,%eax
80103a7f:	8b 04 85 0c 5f 11 80 	mov    -0x7feea0f4(,%eax,4),%eax
80103a86:	89 c2                	mov    %eax,%edx
80103a88:	a1 44 5f 11 80       	mov    0x80115f44,%eax
80103a8d:	83 ec 08             	sub    $0x8,%esp
80103a90:	52                   	push   %edx
80103a91:	50                   	push   %eax
80103a92:	e8 28 c7 ff ff       	call   801001bf <bread>
80103a97:	83 c4 10             	add    $0x10,%esp
80103a9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
80103a9d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103aa0:	8d 50 18             	lea    0x18(%eax),%edx
80103aa3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103aa6:	83 c0 18             	add    $0x18,%eax
80103aa9:	83 ec 04             	sub    $0x4,%esp
80103aac:	68 00 02 00 00       	push   $0x200
80103ab1:	52                   	push   %edx
80103ab2:	50                   	push   %eax
80103ab3:	e8 9a 34 00 00       	call   80106f52 <memmove>
80103ab8:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
80103abb:	83 ec 0c             	sub    $0xc,%esp
80103abe:	ff 75 f0             	pushl  -0x10(%ebp)
80103ac1:	e8 36 c7 ff ff       	call   801001fc <bwrite>
80103ac6:	83 c4 10             	add    $0x10,%esp
    brelse(from); 
80103ac9:	83 ec 0c             	sub    $0xc,%esp
80103acc:	ff 75 ec             	pushl  -0x14(%ebp)
80103acf:	e8 6b c7 ff ff       	call   8010023f <brelse>
80103ad4:	83 c4 10             	add    $0x10,%esp
    brelse(to);
80103ad7:	83 ec 0c             	sub    $0xc,%esp
80103ada:	ff 75 f0             	pushl  -0x10(%ebp)
80103add:	e8 5d c7 ff ff       	call   8010023f <brelse>
80103ae2:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80103ae5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103ae9:	a1 48 5f 11 80       	mov    0x80115f48,%eax
80103aee:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103af1:	0f 8c 5d ff ff ff    	jl     80103a54 <write_log+0x16>
  }
}
80103af7:	90                   	nop
80103af8:	90                   	nop
80103af9:	c9                   	leave  
80103afa:	c3                   	ret    

80103afb <commit>:

static void
commit()
{
80103afb:	f3 0f 1e fb          	endbr32 
80103aff:	55                   	push   %ebp
80103b00:	89 e5                	mov    %esp,%ebp
80103b02:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103b05:	a1 48 5f 11 80       	mov    0x80115f48,%eax
80103b0a:	85 c0                	test   %eax,%eax
80103b0c:	7e 1e                	jle    80103b2c <commit+0x31>
    write_log();     // Write modified blocks from cache to log
80103b0e:	e8 2b ff ff ff       	call   80103a3e <write_log>
    write_head();    // Write header to disk -- the real commit
80103b13:	e8 21 fd ff ff       	call   80103839 <write_head>
    install_trans(); // Now install writes to home locations
80103b18:	e8 e7 fb ff ff       	call   80103704 <install_trans>
    log.lh.n = 0; 
80103b1d:	c7 05 48 5f 11 80 00 	movl   $0x0,0x80115f48
80103b24:	00 00 00 
    write_head();    // Erase the transaction from the log
80103b27:	e8 0d fd ff ff       	call   80103839 <write_head>
  }
}
80103b2c:	90                   	nop
80103b2d:	c9                   	leave  
80103b2e:	c3                   	ret    

80103b2f <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103b2f:	f3 0f 1e fb          	endbr32 
80103b33:	55                   	push   %ebp
80103b34:	89 e5                	mov    %esp,%ebp
80103b36:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103b39:	a1 48 5f 11 80       	mov    0x80115f48,%eax
80103b3e:	83 f8 1d             	cmp    $0x1d,%eax
80103b41:	7f 12                	jg     80103b55 <log_write+0x26>
80103b43:	a1 48 5f 11 80       	mov    0x80115f48,%eax
80103b48:	8b 15 38 5f 11 80    	mov    0x80115f38,%edx
80103b4e:	83 ea 01             	sub    $0x1,%edx
80103b51:	39 d0                	cmp    %edx,%eax
80103b53:	7c 0d                	jl     80103b62 <log_write+0x33>
    panic("too big a transaction");
80103b55:	83 ec 0c             	sub    $0xc,%esp
80103b58:	68 f3 a7 10 80       	push   $0x8010a7f3
80103b5d:	e8 35 ca ff ff       	call   80100597 <panic>
  if (log.outstanding < 1)
80103b62:	a1 3c 5f 11 80       	mov    0x80115f3c,%eax
80103b67:	85 c0                	test   %eax,%eax
80103b69:	7f 0d                	jg     80103b78 <log_write+0x49>
    panic("log_write outside of trans");
80103b6b:	83 ec 0c             	sub    $0xc,%esp
80103b6e:	68 09 a8 10 80       	push   $0x8010a809
80103b73:	e8 1f ca ff ff       	call   80100597 <panic>

  acquire(&log.lock);
80103b78:	83 ec 0c             	sub    $0xc,%esp
80103b7b:	68 00 5f 11 80       	push   $0x80115f00
80103b80:	e8 8a 30 00 00       	call   80106c0f <acquire>
80103b85:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
80103b88:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103b8f:	eb 1d                	jmp    80103bae <log_write+0x7f>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103b91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b94:	83 c0 10             	add    $0x10,%eax
80103b97:	8b 04 85 0c 5f 11 80 	mov    -0x7feea0f4(,%eax,4),%eax
80103b9e:	89 c2                	mov    %eax,%edx
80103ba0:	8b 45 08             	mov    0x8(%ebp),%eax
80103ba3:	8b 40 08             	mov    0x8(%eax),%eax
80103ba6:	39 c2                	cmp    %eax,%edx
80103ba8:	74 10                	je     80103bba <log_write+0x8b>
  for (i = 0; i < log.lh.n; i++) {
80103baa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103bae:	a1 48 5f 11 80       	mov    0x80115f48,%eax
80103bb3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103bb6:	7c d9                	jl     80103b91 <log_write+0x62>
80103bb8:	eb 01                	jmp    80103bbb <log_write+0x8c>
      break;
80103bba:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
80103bbb:	8b 45 08             	mov    0x8(%ebp),%eax
80103bbe:	8b 40 08             	mov    0x8(%eax),%eax
80103bc1:	89 c2                	mov    %eax,%edx
80103bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bc6:	83 c0 10             	add    $0x10,%eax
80103bc9:	89 14 85 0c 5f 11 80 	mov    %edx,-0x7feea0f4(,%eax,4)
  if (i == log.lh.n)
80103bd0:	a1 48 5f 11 80       	mov    0x80115f48,%eax
80103bd5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103bd8:	75 0d                	jne    80103be7 <log_write+0xb8>
    log.lh.n++;
80103bda:	a1 48 5f 11 80       	mov    0x80115f48,%eax
80103bdf:	83 c0 01             	add    $0x1,%eax
80103be2:	a3 48 5f 11 80       	mov    %eax,0x80115f48
  b->flags |= B_DIRTY; // prevent eviction
80103be7:	8b 45 08             	mov    0x8(%ebp),%eax
80103bea:	8b 00                	mov    (%eax),%eax
80103bec:	83 c8 04             	or     $0x4,%eax
80103bef:	89 c2                	mov    %eax,%edx
80103bf1:	8b 45 08             	mov    0x8(%ebp),%eax
80103bf4:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
80103bf6:	83 ec 0c             	sub    $0xc,%esp
80103bf9:	68 00 5f 11 80       	push   $0x80115f00
80103bfe:	e8 77 30 00 00       	call   80106c7a <release>
80103c03:	83 c4 10             	add    $0x10,%esp
}
80103c06:	90                   	nop
80103c07:	c9                   	leave  
80103c08:	c3                   	ret    

80103c09 <v2p>:
80103c09:	55                   	push   %ebp
80103c0a:	89 e5                	mov    %esp,%ebp
80103c0c:	8b 45 08             	mov    0x8(%ebp),%eax
80103c0f:	05 00 00 00 80       	add    $0x80000000,%eax
80103c14:	5d                   	pop    %ebp
80103c15:	c3                   	ret    

80103c16 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80103c16:	55                   	push   %ebp
80103c17:	89 e5                	mov    %esp,%ebp
80103c19:	8b 45 08             	mov    0x8(%ebp),%eax
80103c1c:	05 00 00 00 80       	add    $0x80000000,%eax
80103c21:	5d                   	pop    %ebp
80103c22:	c3                   	ret    

80103c23 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
80103c23:	55                   	push   %ebp
80103c24:	89 e5                	mov    %esp,%ebp
80103c26:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103c29:	8b 55 08             	mov    0x8(%ebp),%edx
80103c2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c2f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103c32:	f0 87 02             	lock xchg %eax,(%edx)
80103c35:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103c38:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103c3b:	c9                   	leave  
80103c3c:	c3                   	ret    

80103c3d <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103c3d:	f3 0f 1e fb          	endbr32 
80103c41:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103c45:	83 e4 f0             	and    $0xfffffff0,%esp
80103c48:	ff 71 fc             	pushl  -0x4(%ecx)
80103c4b:	55                   	push   %ebp
80103c4c:	89 e5                	mov    %esp,%ebp
80103c4e:	51                   	push   %ecx
80103c4f:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103c52:	83 ec 08             	sub    $0x8,%esp
80103c55:	68 00 00 40 80       	push   $0x80400000
80103c5a:	68 bc 95 11 80       	push   $0x801195bc
80103c5f:	e8 14 f2 ff ff       	call   80102e78 <kinit1>
80103c64:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
80103c67:	e8 fc 60 00 00       	call   80109d68 <kvmalloc>
  mpinit();        // collect info about this machine
80103c6c:	e8 5a 04 00 00       	call   801040cb <mpinit>
  lapicinit();
80103c71:	e8 a4 f5 ff ff       	call   8010321a <lapicinit>
  seginit();       // set up segments
80103c76:	e8 86 5a 00 00       	call   80109701 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103c7b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103c81:	0f b6 00             	movzbl (%eax),%eax
80103c84:	0f b6 c0             	movzbl %al,%eax
80103c87:	83 ec 08             	sub    $0x8,%esp
80103c8a:	50                   	push   %eax
80103c8b:	68 24 a8 10 80       	push   $0x8010a824
80103c90:	e8 49 c7 ff ff       	call   801003de <cprintf>
80103c95:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
80103c98:	e8 b6 06 00 00       	call   80104353 <picinit>
  ioapicinit();    // another interrupt controller
80103c9d:	e8 c3 f0 ff ff       	call   80102d65 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103ca2:	e8 50 cf ff ff       	call   80100bf7 <consoleinit>
  uartinit();      // serial port
80103ca7:	e8 a1 4d 00 00       	call   80108a4d <uartinit>
  pinit();         // process table
80103cac:	e8 ba 0b 00 00       	call   8010486b <pinit>
  tvinit();        // trap vectors
80103cb1:	e8 60 49 00 00       	call   80108616 <tvinit>
  binit();         // buffer cache
80103cb6:	e8 79 c3 ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103cbb:	e8 33 d4 ff ff       	call   801010f3 <fileinit>
  ideinit();       // disk
80103cc0:	e8 90 ec ff ff       	call   80102955 <ideinit>
  if(!ismp)
80103cc5:	a1 e4 5f 11 80       	mov    0x80115fe4,%eax
80103cca:	85 c0                	test   %eax,%eax
80103ccc:	75 05                	jne    80103cd3 <main+0x96>
    timerinit();   // uniprocessor timer
80103cce:	e8 90 48 00 00       	call   80108563 <timerinit>
  startothers();   // start other processors
80103cd3:	e8 87 00 00 00       	call   80103d5f <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103cd8:	83 ec 08             	sub    $0x8,%esp
80103cdb:	68 00 00 00 8e       	push   $0x8e000000
80103ce0:	68 00 00 40 80       	push   $0x80400000
80103ce5:	e8 cb f1 ff ff       	call   80102eb5 <kinit2>
80103cea:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
80103ced:	e8 85 0d 00 00       	call   80104a77 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
80103cf2:	e8 1e 00 00 00       	call   80103d15 <mpmain>

80103cf7 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103cf7:	f3 0f 1e fb          	endbr32 
80103cfb:	55                   	push   %ebp
80103cfc:	89 e5                	mov    %esp,%ebp
80103cfe:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
80103d01:	e8 7e 60 00 00       	call   80109d84 <switchkvm>
  seginit();
80103d06:	e8 f6 59 00 00       	call   80109701 <seginit>
  lapicinit();
80103d0b:	e8 0a f5 ff ff       	call   8010321a <lapicinit>
  mpmain();
80103d10:	e8 00 00 00 00       	call   80103d15 <mpmain>

80103d15 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103d15:	f3 0f 1e fb          	endbr32 
80103d19:	55                   	push   %ebp
80103d1a:	89 e5                	mov    %esp,%ebp
80103d1c:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103d1f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103d25:	0f b6 00             	movzbl (%eax),%eax
80103d28:	0f b6 c0             	movzbl %al,%eax
80103d2b:	83 ec 08             	sub    $0x8,%esp
80103d2e:	50                   	push   %eax
80103d2f:	68 3b a8 10 80       	push   $0x8010a83b
80103d34:	e8 a5 c6 ff ff       	call   801003de <cprintf>
80103d39:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103d3c:	e8 3a 4a 00 00       	call   8010877b <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80103d41:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103d47:	05 a8 00 00 00       	add    $0xa8,%eax
80103d4c:	83 ec 08             	sub    $0x8,%esp
80103d4f:	6a 01                	push   $0x1
80103d51:	50                   	push   %eax
80103d52:	e8 cc fe ff ff       	call   80103c23 <xchg>
80103d57:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103d5a:	e8 a6 17 00 00       	call   80105505 <scheduler>

80103d5f <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103d5f:	f3 0f 1e fb          	endbr32 
80103d63:	55                   	push   %ebp
80103d64:	89 e5                	mov    %esp,%ebp
80103d66:	83 ec 18             	sub    $0x18,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103d69:	68 00 70 00 00       	push   $0x7000
80103d6e:	e8 a3 fe ff ff       	call   80103c16 <p2v>
80103d73:	83 c4 04             	add    $0x4,%esp
80103d76:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103d79:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103d7e:	83 ec 04             	sub    $0x4,%esp
80103d81:	50                   	push   %eax
80103d82:	68 2c e5 10 80       	push   $0x8010e52c
80103d87:	ff 75 f0             	pushl  -0x10(%ebp)
80103d8a:	e8 c3 31 00 00       	call   80106f52 <memmove>
80103d8f:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80103d92:	c7 45 f4 00 60 11 80 	movl   $0x80116000,-0xc(%ebp)
80103d99:	e9 8e 00 00 00       	jmp    80103e2c <startothers+0xcd>
    if(c == cpus+cpunum())  // We've started already.
80103d9e:	e8 9a f5 ff ff       	call   8010333d <cpunum>
80103da3:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103da9:	05 00 60 11 80       	add    $0x80116000,%eax
80103dae:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103db1:	74 71                	je     80103e24 <startothers+0xc5>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103db3:	e8 08 f2 ff ff       	call   80102fc0 <kalloc>
80103db8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103dbb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103dbe:	83 e8 04             	sub    $0x4,%eax
80103dc1:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103dc4:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103dca:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103dcc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103dcf:	83 e8 08             	sub    $0x8,%eax
80103dd2:	c7 00 f7 3c 10 80    	movl   $0x80103cf7,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103dd8:	83 ec 0c             	sub    $0xc,%esp
80103ddb:	68 00 d0 10 80       	push   $0x8010d000
80103de0:	e8 24 fe ff ff       	call   80103c09 <v2p>
80103de5:	83 c4 10             	add    $0x10,%esp
80103de8:	8b 55 f0             	mov    -0x10(%ebp),%edx
80103deb:	83 ea 0c             	sub    $0xc,%edx
80103dee:	89 02                	mov    %eax,(%edx)

    lapicstartap(c->id, v2p(code));
80103df0:	83 ec 0c             	sub    $0xc,%esp
80103df3:	ff 75 f0             	pushl  -0x10(%ebp)
80103df6:	e8 0e fe ff ff       	call   80103c09 <v2p>
80103dfb:	83 c4 10             	add    $0x10,%esp
80103dfe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103e01:	0f b6 12             	movzbl (%edx),%edx
80103e04:	0f b6 d2             	movzbl %dl,%edx
80103e07:	83 ec 08             	sub    $0x8,%esp
80103e0a:	50                   	push   %eax
80103e0b:	52                   	push   %edx
80103e0c:	e8 b2 f5 ff ff       	call   801033c3 <lapicstartap>
80103e11:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103e14:	90                   	nop
80103e15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e18:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103e1e:	85 c0                	test   %eax,%eax
80103e20:	74 f3                	je     80103e15 <startothers+0xb6>
80103e22:	eb 01                	jmp    80103e25 <startothers+0xc6>
      continue;
80103e24:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
80103e25:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103e2c:	a1 e0 65 11 80       	mov    0x801165e0,%eax
80103e31:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103e37:	05 00 60 11 80       	add    $0x80116000,%eax
80103e3c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103e3f:	0f 82 59 ff ff ff    	jb     80103d9e <startothers+0x3f>
      ;
  }
}
80103e45:	90                   	nop
80103e46:	90                   	nop
80103e47:	c9                   	leave  
80103e48:	c3                   	ret    

80103e49 <p2v>:
80103e49:	55                   	push   %ebp
80103e4a:	89 e5                	mov    %esp,%ebp
80103e4c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e4f:	05 00 00 00 80       	add    $0x80000000,%eax
80103e54:	5d                   	pop    %ebp
80103e55:	c3                   	ret    

80103e56 <inb>:
{
80103e56:	55                   	push   %ebp
80103e57:	89 e5                	mov    %esp,%ebp
80103e59:	83 ec 14             	sub    $0x14,%esp
80103e5c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e5f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103e63:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103e67:	89 c2                	mov    %eax,%edx
80103e69:	ec                   	in     (%dx),%al
80103e6a:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103e6d:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103e71:	c9                   	leave  
80103e72:	c3                   	ret    

80103e73 <outb>:
{
80103e73:	55                   	push   %ebp
80103e74:	89 e5                	mov    %esp,%ebp
80103e76:	83 ec 08             	sub    $0x8,%esp
80103e79:	8b 45 08             	mov    0x8(%ebp),%eax
80103e7c:	8b 55 0c             	mov    0xc(%ebp),%edx
80103e7f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103e83:	89 d0                	mov    %edx,%eax
80103e85:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103e88:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103e8c:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103e90:	ee                   	out    %al,(%dx)
}
80103e91:	90                   	nop
80103e92:	c9                   	leave  
80103e93:	c3                   	ret    

80103e94 <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
80103e94:	f3 0f 1e fb          	endbr32 
80103e98:	55                   	push   %ebp
80103e99:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
80103e9b:	a1 64 e6 10 80       	mov    0x8010e664,%eax
80103ea0:	2d 00 60 11 80       	sub    $0x80116000,%eax
80103ea5:	c1 f8 02             	sar    $0x2,%eax
80103ea8:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
80103eae:	5d                   	pop    %ebp
80103eaf:	c3                   	ret    

80103eb0 <sum>:

static uchar
sum(uchar *addr, int len)
{
80103eb0:	f3 0f 1e fb          	endbr32 
80103eb4:	55                   	push   %ebp
80103eb5:	89 e5                	mov    %esp,%ebp
80103eb7:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103eba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103ec1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103ec8:	eb 15                	jmp    80103edf <sum+0x2f>
    sum += addr[i];
80103eca:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103ecd:	8b 45 08             	mov    0x8(%ebp),%eax
80103ed0:	01 d0                	add    %edx,%eax
80103ed2:	0f b6 00             	movzbl (%eax),%eax
80103ed5:	0f b6 c0             	movzbl %al,%eax
80103ed8:	01 45 f8             	add    %eax,-0x8(%ebp)
  for(i=0; i<len; i++)
80103edb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103edf:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103ee2:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103ee5:	7c e3                	jl     80103eca <sum+0x1a>
  return sum;
80103ee7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103eea:	c9                   	leave  
80103eeb:	c3                   	ret    

80103eec <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103eec:	f3 0f 1e fb          	endbr32 
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103ef6:	ff 75 08             	pushl  0x8(%ebp)
80103ef9:	e8 4b ff ff ff       	call   80103e49 <p2v>
80103efe:	83 c4 04             	add    $0x4,%esp
80103f01:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103f04:	8b 55 0c             	mov    0xc(%ebp),%edx
80103f07:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103f0a:	01 d0                	add    %edx,%eax
80103f0c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103f0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103f12:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103f15:	eb 36                	jmp    80103f4d <mpsearch1+0x61>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103f17:	83 ec 04             	sub    $0x4,%esp
80103f1a:	6a 04                	push   $0x4
80103f1c:	68 4c a8 10 80       	push   $0x8010a84c
80103f21:	ff 75 f4             	pushl  -0xc(%ebp)
80103f24:	e8 cd 2f 00 00       	call   80106ef6 <memcmp>
80103f29:	83 c4 10             	add    $0x10,%esp
80103f2c:	85 c0                	test   %eax,%eax
80103f2e:	75 19                	jne    80103f49 <mpsearch1+0x5d>
80103f30:	83 ec 08             	sub    $0x8,%esp
80103f33:	6a 10                	push   $0x10
80103f35:	ff 75 f4             	pushl  -0xc(%ebp)
80103f38:	e8 73 ff ff ff       	call   80103eb0 <sum>
80103f3d:	83 c4 10             	add    $0x10,%esp
80103f40:	84 c0                	test   %al,%al
80103f42:	75 05                	jne    80103f49 <mpsearch1+0x5d>
      return (struct mp*)p;
80103f44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f47:	eb 11                	jmp    80103f5a <mpsearch1+0x6e>
  for(p = addr; p < e; p += sizeof(struct mp))
80103f49:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103f4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f50:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103f53:	72 c2                	jb     80103f17 <mpsearch1+0x2b>
  return 0;
80103f55:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103f5a:	c9                   	leave  
80103f5b:	c3                   	ret    

80103f5c <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103f5c:	f3 0f 1e fb          	endbr32 
80103f60:	55                   	push   %ebp
80103f61:	89 e5                	mov    %esp,%ebp
80103f63:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103f66:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103f6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f70:	83 c0 0f             	add    $0xf,%eax
80103f73:	0f b6 00             	movzbl (%eax),%eax
80103f76:	0f b6 c0             	movzbl %al,%eax
80103f79:	c1 e0 08             	shl    $0x8,%eax
80103f7c:	89 c2                	mov    %eax,%edx
80103f7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f81:	83 c0 0e             	add    $0xe,%eax
80103f84:	0f b6 00             	movzbl (%eax),%eax
80103f87:	0f b6 c0             	movzbl %al,%eax
80103f8a:	09 d0                	or     %edx,%eax
80103f8c:	c1 e0 04             	shl    $0x4,%eax
80103f8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103f92:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103f96:	74 21                	je     80103fb9 <mpsearch+0x5d>
    if((mp = mpsearch1(p, 1024)))
80103f98:	83 ec 08             	sub    $0x8,%esp
80103f9b:	68 00 04 00 00       	push   $0x400
80103fa0:	ff 75 f0             	pushl  -0x10(%ebp)
80103fa3:	e8 44 ff ff ff       	call   80103eec <mpsearch1>
80103fa8:	83 c4 10             	add    $0x10,%esp
80103fab:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103fae:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103fb2:	74 51                	je     80104005 <mpsearch+0xa9>
      return mp;
80103fb4:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103fb7:	eb 61                	jmp    8010401a <mpsearch+0xbe>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103fb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fbc:	83 c0 14             	add    $0x14,%eax
80103fbf:	0f b6 00             	movzbl (%eax),%eax
80103fc2:	0f b6 c0             	movzbl %al,%eax
80103fc5:	c1 e0 08             	shl    $0x8,%eax
80103fc8:	89 c2                	mov    %eax,%edx
80103fca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103fcd:	83 c0 13             	add    $0x13,%eax
80103fd0:	0f b6 00             	movzbl (%eax),%eax
80103fd3:	0f b6 c0             	movzbl %al,%eax
80103fd6:	09 d0                	or     %edx,%eax
80103fd8:	c1 e0 0a             	shl    $0xa,%eax
80103fdb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103fde:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103fe1:	2d 00 04 00 00       	sub    $0x400,%eax
80103fe6:	83 ec 08             	sub    $0x8,%esp
80103fe9:	68 00 04 00 00       	push   $0x400
80103fee:	50                   	push   %eax
80103fef:	e8 f8 fe ff ff       	call   80103eec <mpsearch1>
80103ff4:	83 c4 10             	add    $0x10,%esp
80103ff7:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103ffa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103ffe:	74 05                	je     80104005 <mpsearch+0xa9>
      return mp;
80104000:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104003:	eb 15                	jmp    8010401a <mpsearch+0xbe>
  }
  return mpsearch1(0xF0000, 0x10000);
80104005:	83 ec 08             	sub    $0x8,%esp
80104008:	68 00 00 01 00       	push   $0x10000
8010400d:	68 00 00 0f 00       	push   $0xf0000
80104012:	e8 d5 fe ff ff       	call   80103eec <mpsearch1>
80104017:	83 c4 10             	add    $0x10,%esp
}
8010401a:	c9                   	leave  
8010401b:	c3                   	ret    

8010401c <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
8010401c:	f3 0f 1e fb          	endbr32 
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80104026:	e8 31 ff ff ff       	call   80103f5c <mpsearch>
8010402b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010402e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104032:	74 0a                	je     8010403e <mpconfig+0x22>
80104034:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104037:	8b 40 04             	mov    0x4(%eax),%eax
8010403a:	85 c0                	test   %eax,%eax
8010403c:	75 0a                	jne    80104048 <mpconfig+0x2c>
    return 0;
8010403e:	b8 00 00 00 00       	mov    $0x0,%eax
80104043:	e9 81 00 00 00       	jmp    801040c9 <mpconfig+0xad>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80104048:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010404b:	8b 40 04             	mov    0x4(%eax),%eax
8010404e:	83 ec 0c             	sub    $0xc,%esp
80104051:	50                   	push   %eax
80104052:	e8 f2 fd ff ff       	call   80103e49 <p2v>
80104057:	83 c4 10             	add    $0x10,%esp
8010405a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010405d:	83 ec 04             	sub    $0x4,%esp
80104060:	6a 04                	push   $0x4
80104062:	68 51 a8 10 80       	push   $0x8010a851
80104067:	ff 75 f0             	pushl  -0x10(%ebp)
8010406a:	e8 87 2e 00 00       	call   80106ef6 <memcmp>
8010406f:	83 c4 10             	add    $0x10,%esp
80104072:	85 c0                	test   %eax,%eax
80104074:	74 07                	je     8010407d <mpconfig+0x61>
    return 0;
80104076:	b8 00 00 00 00       	mov    $0x0,%eax
8010407b:	eb 4c                	jmp    801040c9 <mpconfig+0xad>
  if(conf->version != 1 && conf->version != 4)
8010407d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104080:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80104084:	3c 01                	cmp    $0x1,%al
80104086:	74 12                	je     8010409a <mpconfig+0x7e>
80104088:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010408b:	0f b6 40 06          	movzbl 0x6(%eax),%eax
8010408f:	3c 04                	cmp    $0x4,%al
80104091:	74 07                	je     8010409a <mpconfig+0x7e>
    return 0;
80104093:	b8 00 00 00 00       	mov    $0x0,%eax
80104098:	eb 2f                	jmp    801040c9 <mpconfig+0xad>
  if(sum((uchar*)conf, conf->length) != 0)
8010409a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010409d:	0f b7 40 04          	movzwl 0x4(%eax),%eax
801040a1:	0f b7 c0             	movzwl %ax,%eax
801040a4:	83 ec 08             	sub    $0x8,%esp
801040a7:	50                   	push   %eax
801040a8:	ff 75 f0             	pushl  -0x10(%ebp)
801040ab:	e8 00 fe ff ff       	call   80103eb0 <sum>
801040b0:	83 c4 10             	add    $0x10,%esp
801040b3:	84 c0                	test   %al,%al
801040b5:	74 07                	je     801040be <mpconfig+0xa2>
    return 0;
801040b7:	b8 00 00 00 00       	mov    $0x0,%eax
801040bc:	eb 0b                	jmp    801040c9 <mpconfig+0xad>
  *pmp = mp;
801040be:	8b 45 08             	mov    0x8(%ebp),%eax
801040c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040c4:	89 10                	mov    %edx,(%eax)
  return conf;
801040c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801040c9:	c9                   	leave  
801040ca:	c3                   	ret    

801040cb <mpinit>:

void
mpinit(void)
{
801040cb:	f3 0f 1e fb          	endbr32 
801040cf:	55                   	push   %ebp
801040d0:	89 e5                	mov    %esp,%ebp
801040d2:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
801040d5:	c7 05 64 e6 10 80 00 	movl   $0x80116000,0x8010e664
801040dc:	60 11 80 
  if((conf = mpconfig(&mp)) == 0)
801040df:	83 ec 0c             	sub    $0xc,%esp
801040e2:	8d 45 e0             	lea    -0x20(%ebp),%eax
801040e5:	50                   	push   %eax
801040e6:	e8 31 ff ff ff       	call   8010401c <mpconfig>
801040eb:	83 c4 10             	add    $0x10,%esp
801040ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
801040f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801040f5:	0f 84 ba 01 00 00    	je     801042b5 <mpinit+0x1ea>
    return;
  ismp = 1;
801040fb:	c7 05 e4 5f 11 80 01 	movl   $0x1,0x80115fe4
80104102:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
80104105:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104108:	8b 40 24             	mov    0x24(%eax),%eax
8010410b:	a3 fc 5e 11 80       	mov    %eax,0x80115efc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104110:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104113:	83 c0 2c             	add    $0x2c,%eax
80104116:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104119:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010411c:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80104120:	0f b7 d0             	movzwl %ax,%edx
80104123:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104126:	01 d0                	add    %edx,%eax
80104128:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010412b:	e9 16 01 00 00       	jmp    80104246 <mpinit+0x17b>
    switch(*p){
80104130:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104133:	0f b6 00             	movzbl (%eax),%eax
80104136:	0f b6 c0             	movzbl %al,%eax
80104139:	83 f8 04             	cmp    $0x4,%eax
8010413c:	0f 8f e0 00 00 00    	jg     80104222 <mpinit+0x157>
80104142:	83 f8 03             	cmp    $0x3,%eax
80104145:	0f 8d d1 00 00 00    	jge    8010421c <mpinit+0x151>
8010414b:	83 f8 02             	cmp    $0x2,%eax
8010414e:	0f 84 b0 00 00 00    	je     80104204 <mpinit+0x139>
80104154:	83 f8 02             	cmp    $0x2,%eax
80104157:	0f 8f c5 00 00 00    	jg     80104222 <mpinit+0x157>
8010415d:	85 c0                	test   %eax,%eax
8010415f:	74 0e                	je     8010416f <mpinit+0xa4>
80104161:	83 f8 01             	cmp    $0x1,%eax
80104164:	0f 84 b2 00 00 00    	je     8010421c <mpinit+0x151>
8010416a:	e9 b3 00 00 00       	jmp    80104222 <mpinit+0x157>
    case MPPROC:
      proc = (struct mpproc*)p;
8010416f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104172:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(ncpu != proc->apicid){
80104175:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104178:	0f b6 40 01          	movzbl 0x1(%eax),%eax
8010417c:	0f b6 d0             	movzbl %al,%edx
8010417f:	a1 e0 65 11 80       	mov    0x801165e0,%eax
80104184:	39 c2                	cmp    %eax,%edx
80104186:	74 2b                	je     801041b3 <mpinit+0xe8>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
80104188:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010418b:	0f b6 40 01          	movzbl 0x1(%eax),%eax
8010418f:	0f b6 d0             	movzbl %al,%edx
80104192:	a1 e0 65 11 80       	mov    0x801165e0,%eax
80104197:	83 ec 04             	sub    $0x4,%esp
8010419a:	52                   	push   %edx
8010419b:	50                   	push   %eax
8010419c:	68 56 a8 10 80       	push   $0x8010a856
801041a1:	e8 38 c2 ff ff       	call   801003de <cprintf>
801041a6:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
801041a9:	c7 05 e4 5f 11 80 00 	movl   $0x0,0x80115fe4
801041b0:	00 00 00 
      }
      if(proc->flags & MPBOOT)
801041b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801041b6:	0f b6 40 03          	movzbl 0x3(%eax),%eax
801041ba:	0f b6 c0             	movzbl %al,%eax
801041bd:	83 e0 02             	and    $0x2,%eax
801041c0:	85 c0                	test   %eax,%eax
801041c2:	74 15                	je     801041d9 <mpinit+0x10e>
        bcpu = &cpus[ncpu];
801041c4:	a1 e0 65 11 80       	mov    0x801165e0,%eax
801041c9:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801041cf:	05 00 60 11 80       	add    $0x80116000,%eax
801041d4:	a3 64 e6 10 80       	mov    %eax,0x8010e664
      cpus[ncpu].id = ncpu;
801041d9:	8b 15 e0 65 11 80    	mov    0x801165e0,%edx
801041df:	a1 e0 65 11 80       	mov    0x801165e0,%eax
801041e4:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801041ea:	05 00 60 11 80       	add    $0x80116000,%eax
801041ef:	88 10                	mov    %dl,(%eax)
      ncpu++;
801041f1:	a1 e0 65 11 80       	mov    0x801165e0,%eax
801041f6:	83 c0 01             	add    $0x1,%eax
801041f9:	a3 e0 65 11 80       	mov    %eax,0x801165e0
      p += sizeof(struct mpproc);
801041fe:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80104202:	eb 42                	jmp    80104246 <mpinit+0x17b>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80104204:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104207:	89 45 e8             	mov    %eax,-0x18(%ebp)
      ioapicid = ioapic->apicno;
8010420a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010420d:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80104211:	a2 e0 5f 11 80       	mov    %al,0x80115fe0
      p += sizeof(struct mpioapic);
80104216:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
8010421a:	eb 2a                	jmp    80104246 <mpinit+0x17b>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010421c:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80104220:	eb 24                	jmp    80104246 <mpinit+0x17b>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80104222:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104225:	0f b6 00             	movzbl (%eax),%eax
80104228:	0f b6 c0             	movzbl %al,%eax
8010422b:	83 ec 08             	sub    $0x8,%esp
8010422e:	50                   	push   %eax
8010422f:	68 74 a8 10 80       	push   $0x8010a874
80104234:	e8 a5 c1 ff ff       	call   801003de <cprintf>
80104239:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
8010423c:	c7 05 e4 5f 11 80 00 	movl   $0x0,0x80115fe4
80104243:	00 00 00 
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104246:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104249:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010424c:	0f 82 de fe ff ff    	jb     80104130 <mpinit+0x65>
    }
  }
  if(!ismp){
80104252:	a1 e4 5f 11 80       	mov    0x80115fe4,%eax
80104257:	85 c0                	test   %eax,%eax
80104259:	75 1d                	jne    80104278 <mpinit+0x1ad>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
8010425b:	c7 05 e0 65 11 80 01 	movl   $0x1,0x801165e0
80104262:	00 00 00 
    lapic = 0;
80104265:	c7 05 fc 5e 11 80 00 	movl   $0x0,0x80115efc
8010426c:	00 00 00 
    ioapicid = 0;
8010426f:	c6 05 e0 5f 11 80 00 	movb   $0x0,0x80115fe0
    return;
80104276:	eb 3e                	jmp    801042b6 <mpinit+0x1eb>
  }

  if(mp->imcrp){
80104278:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010427b:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
8010427f:	84 c0                	test   %al,%al
80104281:	74 33                	je     801042b6 <mpinit+0x1eb>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80104283:	83 ec 08             	sub    $0x8,%esp
80104286:	6a 70                	push   $0x70
80104288:	6a 22                	push   $0x22
8010428a:	e8 e4 fb ff ff       	call   80103e73 <outb>
8010428f:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80104292:	83 ec 0c             	sub    $0xc,%esp
80104295:	6a 23                	push   $0x23
80104297:	e8 ba fb ff ff       	call   80103e56 <inb>
8010429c:	83 c4 10             	add    $0x10,%esp
8010429f:	83 c8 01             	or     $0x1,%eax
801042a2:	0f b6 c0             	movzbl %al,%eax
801042a5:	83 ec 08             	sub    $0x8,%esp
801042a8:	50                   	push   %eax
801042a9:	6a 23                	push   $0x23
801042ab:	e8 c3 fb ff ff       	call   80103e73 <outb>
801042b0:	83 c4 10             	add    $0x10,%esp
801042b3:	eb 01                	jmp    801042b6 <mpinit+0x1eb>
    return;
801042b5:	90                   	nop
  }
}
801042b6:	c9                   	leave  
801042b7:	c3                   	ret    

801042b8 <outb>:
{
801042b8:	55                   	push   %ebp
801042b9:	89 e5                	mov    %esp,%ebp
801042bb:	83 ec 08             	sub    $0x8,%esp
801042be:	8b 45 08             	mov    0x8(%ebp),%eax
801042c1:	8b 55 0c             	mov    0xc(%ebp),%edx
801042c4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801042c8:	89 d0                	mov    %edx,%eax
801042ca:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801042cd:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801042d1:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801042d5:	ee                   	out    %al,(%dx)
}
801042d6:	90                   	nop
801042d7:	c9                   	leave  
801042d8:	c3                   	ret    

801042d9 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
801042d9:	f3 0f 1e fb          	endbr32 
801042dd:	55                   	push   %ebp
801042de:	89 e5                	mov    %esp,%ebp
801042e0:	83 ec 04             	sub    $0x4,%esp
801042e3:	8b 45 08             	mov    0x8(%ebp),%eax
801042e6:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
801042ea:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801042ee:	66 a3 00 e0 10 80    	mov    %ax,0x8010e000
  outb(IO_PIC1+1, mask);
801042f4:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801042f8:	0f b6 c0             	movzbl %al,%eax
801042fb:	50                   	push   %eax
801042fc:	6a 21                	push   $0x21
801042fe:	e8 b5 ff ff ff       	call   801042b8 <outb>
80104303:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80104306:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010430a:	66 c1 e8 08          	shr    $0x8,%ax
8010430e:	0f b6 c0             	movzbl %al,%eax
80104311:	50                   	push   %eax
80104312:	68 a1 00 00 00       	push   $0xa1
80104317:	e8 9c ff ff ff       	call   801042b8 <outb>
8010431c:	83 c4 08             	add    $0x8,%esp
}
8010431f:	90                   	nop
80104320:	c9                   	leave  
80104321:	c3                   	ret    

80104322 <picenable>:

void
picenable(int irq)
{
80104322:	f3 0f 1e fb          	endbr32 
80104326:	55                   	push   %ebp
80104327:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80104329:	8b 45 08             	mov    0x8(%ebp),%eax
8010432c:	ba 01 00 00 00       	mov    $0x1,%edx
80104331:	89 c1                	mov    %eax,%ecx
80104333:	d3 e2                	shl    %cl,%edx
80104335:	89 d0                	mov    %edx,%eax
80104337:	f7 d0                	not    %eax
80104339:	89 c2                	mov    %eax,%edx
8010433b:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80104342:	21 d0                	and    %edx,%eax
80104344:	0f b7 c0             	movzwl %ax,%eax
80104347:	50                   	push   %eax
80104348:	e8 8c ff ff ff       	call   801042d9 <picsetmask>
8010434d:	83 c4 04             	add    $0x4,%esp
}
80104350:	90                   	nop
80104351:	c9                   	leave  
80104352:	c3                   	ret    

80104353 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80104353:	f3 0f 1e fb          	endbr32 
80104357:	55                   	push   %ebp
80104358:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
8010435a:	68 ff 00 00 00       	push   $0xff
8010435f:	6a 21                	push   $0x21
80104361:	e8 52 ff ff ff       	call   801042b8 <outb>
80104366:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80104369:	68 ff 00 00 00       	push   $0xff
8010436e:	68 a1 00 00 00       	push   $0xa1
80104373:	e8 40 ff ff ff       	call   801042b8 <outb>
80104378:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
8010437b:	6a 11                	push   $0x11
8010437d:	6a 20                	push   $0x20
8010437f:	e8 34 ff ff ff       	call   801042b8 <outb>
80104384:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80104387:	6a 20                	push   $0x20
80104389:	6a 21                	push   $0x21
8010438b:	e8 28 ff ff ff       	call   801042b8 <outb>
80104390:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80104393:	6a 04                	push   $0x4
80104395:	6a 21                	push   $0x21
80104397:	e8 1c ff ff ff       	call   801042b8 <outb>
8010439c:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
8010439f:	6a 03                	push   $0x3
801043a1:	6a 21                	push   $0x21
801043a3:	e8 10 ff ff ff       	call   801042b8 <outb>
801043a8:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
801043ab:	6a 11                	push   $0x11
801043ad:	68 a0 00 00 00       	push   $0xa0
801043b2:	e8 01 ff ff ff       	call   801042b8 <outb>
801043b7:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
801043ba:	6a 28                	push   $0x28
801043bc:	68 a1 00 00 00       	push   $0xa1
801043c1:	e8 f2 fe ff ff       	call   801042b8 <outb>
801043c6:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
801043c9:	6a 02                	push   $0x2
801043cb:	68 a1 00 00 00       	push   $0xa1
801043d0:	e8 e3 fe ff ff       	call   801042b8 <outb>
801043d5:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
801043d8:	6a 03                	push   $0x3
801043da:	68 a1 00 00 00       	push   $0xa1
801043df:	e8 d4 fe ff ff       	call   801042b8 <outb>
801043e4:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
801043e7:	6a 68                	push   $0x68
801043e9:	6a 20                	push   $0x20
801043eb:	e8 c8 fe ff ff       	call   801042b8 <outb>
801043f0:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
801043f3:	6a 0a                	push   $0xa
801043f5:	6a 20                	push   $0x20
801043f7:	e8 bc fe ff ff       	call   801042b8 <outb>
801043fc:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
801043ff:	6a 68                	push   $0x68
80104401:	68 a0 00 00 00       	push   $0xa0
80104406:	e8 ad fe ff ff       	call   801042b8 <outb>
8010440b:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
8010440e:	6a 0a                	push   $0xa
80104410:	68 a0 00 00 00       	push   $0xa0
80104415:	e8 9e fe ff ff       	call   801042b8 <outb>
8010441a:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
8010441d:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80104424:	66 83 f8 ff          	cmp    $0xffff,%ax
80104428:	74 13                	je     8010443d <picinit+0xea>
    picsetmask(irqmask);
8010442a:	0f b7 05 00 e0 10 80 	movzwl 0x8010e000,%eax
80104431:	0f b7 c0             	movzwl %ax,%eax
80104434:	50                   	push   %eax
80104435:	e8 9f fe ff ff       	call   801042d9 <picsetmask>
8010443a:	83 c4 04             	add    $0x4,%esp
}
8010443d:	90                   	nop
8010443e:	c9                   	leave  
8010443f:	c3                   	ret    

80104440 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104440:	f3 0f 1e fb          	endbr32 
80104444:	55                   	push   %ebp
80104445:	89 e5                	mov    %esp,%ebp
80104447:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
8010444a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80104451:	8b 45 0c             	mov    0xc(%ebp),%eax
80104454:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010445a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010445d:	8b 10                	mov    (%eax),%edx
8010445f:	8b 45 08             	mov    0x8(%ebp),%eax
80104462:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80104464:	e8 ac cc ff ff       	call   80101115 <filealloc>
80104469:	8b 55 08             	mov    0x8(%ebp),%edx
8010446c:	89 02                	mov    %eax,(%edx)
8010446e:	8b 45 08             	mov    0x8(%ebp),%eax
80104471:	8b 00                	mov    (%eax),%eax
80104473:	85 c0                	test   %eax,%eax
80104475:	0f 84 c8 00 00 00    	je     80104543 <pipealloc+0x103>
8010447b:	e8 95 cc ff ff       	call   80101115 <filealloc>
80104480:	8b 55 0c             	mov    0xc(%ebp),%edx
80104483:	89 02                	mov    %eax,(%edx)
80104485:	8b 45 0c             	mov    0xc(%ebp),%eax
80104488:	8b 00                	mov    (%eax),%eax
8010448a:	85 c0                	test   %eax,%eax
8010448c:	0f 84 b1 00 00 00    	je     80104543 <pipealloc+0x103>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104492:	e8 29 eb ff ff       	call   80102fc0 <kalloc>
80104497:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010449a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010449e:	0f 84 a2 00 00 00    	je     80104546 <pipealloc+0x106>
    goto bad;
  p->readopen = 1;
801044a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a7:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801044ae:	00 00 00 
  p->writeopen = 1;
801044b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044b4:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801044bb:	00 00 00 
  p->nwrite = 0;
801044be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044c1:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801044c8:	00 00 00 
  p->nread = 0;
801044cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ce:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801044d5:	00 00 00 
  initlock(&p->lock, "pipe");
801044d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044db:	83 ec 08             	sub    $0x8,%esp
801044de:	68 94 a8 10 80       	push   $0x8010a894
801044e3:	50                   	push   %eax
801044e4:	e8 00 27 00 00       	call   80106be9 <initlock>
801044e9:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801044ec:	8b 45 08             	mov    0x8(%ebp),%eax
801044ef:	8b 00                	mov    (%eax),%eax
801044f1:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801044f7:	8b 45 08             	mov    0x8(%ebp),%eax
801044fa:	8b 00                	mov    (%eax),%eax
801044fc:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80104500:	8b 45 08             	mov    0x8(%ebp),%eax
80104503:	8b 00                	mov    (%eax),%eax
80104505:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104509:	8b 45 08             	mov    0x8(%ebp),%eax
8010450c:	8b 00                	mov    (%eax),%eax
8010450e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104511:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80104514:	8b 45 0c             	mov    0xc(%ebp),%eax
80104517:	8b 00                	mov    (%eax),%eax
80104519:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010451f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104522:	8b 00                	mov    (%eax),%eax
80104524:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104528:	8b 45 0c             	mov    0xc(%ebp),%eax
8010452b:	8b 00                	mov    (%eax),%eax
8010452d:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80104531:	8b 45 0c             	mov    0xc(%ebp),%eax
80104534:	8b 00                	mov    (%eax),%eax
80104536:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104539:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
8010453c:	b8 00 00 00 00       	mov    $0x0,%eax
80104541:	eb 51                	jmp    80104594 <pipealloc+0x154>
    goto bad;
80104543:	90                   	nop
80104544:	eb 01                	jmp    80104547 <pipealloc+0x107>
    goto bad;
80104546:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
80104547:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010454b:	74 0e                	je     8010455b <pipealloc+0x11b>
    kfree((char*)p);
8010454d:	83 ec 0c             	sub    $0xc,%esp
80104550:	ff 75 f4             	pushl  -0xc(%ebp)
80104553:	e8 c7 e9 ff ff       	call   80102f1f <kfree>
80104558:	83 c4 10             	add    $0x10,%esp
  if(*f0)
8010455b:	8b 45 08             	mov    0x8(%ebp),%eax
8010455e:	8b 00                	mov    (%eax),%eax
80104560:	85 c0                	test   %eax,%eax
80104562:	74 11                	je     80104575 <pipealloc+0x135>
    fileclose(*f0);
80104564:	8b 45 08             	mov    0x8(%ebp),%eax
80104567:	8b 00                	mov    (%eax),%eax
80104569:	83 ec 0c             	sub    $0xc,%esp
8010456c:	50                   	push   %eax
8010456d:	e8 69 cc ff ff       	call   801011db <fileclose>
80104572:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104575:	8b 45 0c             	mov    0xc(%ebp),%eax
80104578:	8b 00                	mov    (%eax),%eax
8010457a:	85 c0                	test   %eax,%eax
8010457c:	74 11                	je     8010458f <pipealloc+0x14f>
    fileclose(*f1);
8010457e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104581:	8b 00                	mov    (%eax),%eax
80104583:	83 ec 0c             	sub    $0xc,%esp
80104586:	50                   	push   %eax
80104587:	e8 4f cc ff ff       	call   801011db <fileclose>
8010458c:	83 c4 10             	add    $0x10,%esp
  return -1;
8010458f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104594:	c9                   	leave  
80104595:	c3                   	ret    

80104596 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104596:	f3 0f 1e fb          	endbr32 
8010459a:	55                   	push   %ebp
8010459b:	89 e5                	mov    %esp,%ebp
8010459d:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
801045a0:	8b 45 08             	mov    0x8(%ebp),%eax
801045a3:	83 ec 0c             	sub    $0xc,%esp
801045a6:	50                   	push   %eax
801045a7:	e8 63 26 00 00       	call   80106c0f <acquire>
801045ac:	83 c4 10             	add    $0x10,%esp
  if(writable){
801045af:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801045b3:	74 23                	je     801045d8 <pipeclose+0x42>
    p->writeopen = 0;
801045b5:	8b 45 08             	mov    0x8(%ebp),%eax
801045b8:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
801045bf:	00 00 00 
    wakeup(&p->nread);
801045c2:	8b 45 08             	mov    0x8(%ebp),%eax
801045c5:	05 34 02 00 00       	add    $0x234,%eax
801045ca:	83 ec 0c             	sub    $0xc,%esp
801045cd:	50                   	push   %eax
801045ce:	e8 98 15 00 00       	call   80105b6b <wakeup>
801045d3:	83 c4 10             	add    $0x10,%esp
801045d6:	eb 21                	jmp    801045f9 <pipeclose+0x63>
  } else {
    p->readopen = 0;
801045d8:	8b 45 08             	mov    0x8(%ebp),%eax
801045db:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
801045e2:	00 00 00 
    wakeup(&p->nwrite);
801045e5:	8b 45 08             	mov    0x8(%ebp),%eax
801045e8:	05 38 02 00 00       	add    $0x238,%eax
801045ed:	83 ec 0c             	sub    $0xc,%esp
801045f0:	50                   	push   %eax
801045f1:	e8 75 15 00 00       	call   80105b6b <wakeup>
801045f6:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
801045f9:	8b 45 08             	mov    0x8(%ebp),%eax
801045fc:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104602:	85 c0                	test   %eax,%eax
80104604:	75 2c                	jne    80104632 <pipeclose+0x9c>
80104606:	8b 45 08             	mov    0x8(%ebp),%eax
80104609:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010460f:	85 c0                	test   %eax,%eax
80104611:	75 1f                	jne    80104632 <pipeclose+0x9c>
    release(&p->lock);
80104613:	8b 45 08             	mov    0x8(%ebp),%eax
80104616:	83 ec 0c             	sub    $0xc,%esp
80104619:	50                   	push   %eax
8010461a:	e8 5b 26 00 00       	call   80106c7a <release>
8010461f:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80104622:	83 ec 0c             	sub    $0xc,%esp
80104625:	ff 75 08             	pushl  0x8(%ebp)
80104628:	e8 f2 e8 ff ff       	call   80102f1f <kfree>
8010462d:	83 c4 10             	add    $0x10,%esp
80104630:	eb 10                	jmp    80104642 <pipeclose+0xac>
  } else
    release(&p->lock);
80104632:	8b 45 08             	mov    0x8(%ebp),%eax
80104635:	83 ec 0c             	sub    $0xc,%esp
80104638:	50                   	push   %eax
80104639:	e8 3c 26 00 00       	call   80106c7a <release>
8010463e:	83 c4 10             	add    $0x10,%esp
}
80104641:	90                   	nop
80104642:	90                   	nop
80104643:	c9                   	leave  
80104644:	c3                   	ret    

80104645 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104645:	f3 0f 1e fb          	endbr32 
80104649:	55                   	push   %ebp
8010464a:	89 e5                	mov    %esp,%ebp
8010464c:	53                   	push   %ebx
8010464d:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80104650:	8b 45 08             	mov    0x8(%ebp),%eax
80104653:	83 ec 0c             	sub    $0xc,%esp
80104656:	50                   	push   %eax
80104657:	e8 b3 25 00 00       	call   80106c0f <acquire>
8010465c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
8010465f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104666:	e9 ae 00 00 00       	jmp    80104719 <pipewrite+0xd4>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
8010466b:	8b 45 08             	mov    0x8(%ebp),%eax
8010466e:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104674:	85 c0                	test   %eax,%eax
80104676:	74 0d                	je     80104685 <pipewrite+0x40>
80104678:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010467e:	8b 40 24             	mov    0x24(%eax),%eax
80104681:	85 c0                	test   %eax,%eax
80104683:	74 19                	je     8010469e <pipewrite+0x59>
        release(&p->lock);
80104685:	8b 45 08             	mov    0x8(%ebp),%eax
80104688:	83 ec 0c             	sub    $0xc,%esp
8010468b:	50                   	push   %eax
8010468c:	e8 e9 25 00 00       	call   80106c7a <release>
80104691:	83 c4 10             	add    $0x10,%esp
        return -1;
80104694:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104699:	e9 a9 00 00 00       	jmp    80104747 <pipewrite+0x102>
      }
      wakeup(&p->nread);
8010469e:	8b 45 08             	mov    0x8(%ebp),%eax
801046a1:	05 34 02 00 00       	add    $0x234,%eax
801046a6:	83 ec 0c             	sub    $0xc,%esp
801046a9:	50                   	push   %eax
801046aa:	e8 bc 14 00 00       	call   80105b6b <wakeup>
801046af:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801046b2:	8b 45 08             	mov    0x8(%ebp),%eax
801046b5:	8b 55 08             	mov    0x8(%ebp),%edx
801046b8:	81 c2 38 02 00 00    	add    $0x238,%edx
801046be:	83 ec 08             	sub    $0x8,%esp
801046c1:	50                   	push   %eax
801046c2:	52                   	push   %edx
801046c3:	e8 46 12 00 00       	call   8010590e <sleep>
801046c8:	83 c4 10             	add    $0x10,%esp
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801046cb:	8b 45 08             	mov    0x8(%ebp),%eax
801046ce:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
801046d4:	8b 45 08             	mov    0x8(%ebp),%eax
801046d7:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801046dd:	05 00 02 00 00       	add    $0x200,%eax
801046e2:	39 c2                	cmp    %eax,%edx
801046e4:	74 85                	je     8010466b <pipewrite+0x26>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801046e6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801046ec:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
801046ef:	8b 45 08             	mov    0x8(%ebp),%eax
801046f2:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801046f8:	8d 48 01             	lea    0x1(%eax),%ecx
801046fb:	8b 55 08             	mov    0x8(%ebp),%edx
801046fe:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80104704:	25 ff 01 00 00       	and    $0x1ff,%eax
80104709:	89 c1                	mov    %eax,%ecx
8010470b:	0f b6 13             	movzbl (%ebx),%edx
8010470e:	8b 45 08             	mov    0x8(%ebp),%eax
80104711:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
  for(i = 0; i < n; i++){
80104715:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104719:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010471c:	3b 45 10             	cmp    0x10(%ebp),%eax
8010471f:	7c aa                	jl     801046cb <pipewrite+0x86>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104721:	8b 45 08             	mov    0x8(%ebp),%eax
80104724:	05 34 02 00 00       	add    $0x234,%eax
80104729:	83 ec 0c             	sub    $0xc,%esp
8010472c:	50                   	push   %eax
8010472d:	e8 39 14 00 00       	call   80105b6b <wakeup>
80104732:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104735:	8b 45 08             	mov    0x8(%ebp),%eax
80104738:	83 ec 0c             	sub    $0xc,%esp
8010473b:	50                   	push   %eax
8010473c:	e8 39 25 00 00       	call   80106c7a <release>
80104741:	83 c4 10             	add    $0x10,%esp
  return n;
80104744:	8b 45 10             	mov    0x10(%ebp),%eax
}
80104747:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010474a:	c9                   	leave  
8010474b:	c3                   	ret    

8010474c <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
8010474c:	f3 0f 1e fb          	endbr32 
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
80104756:	8b 45 08             	mov    0x8(%ebp),%eax
80104759:	83 ec 0c             	sub    $0xc,%esp
8010475c:	50                   	push   %eax
8010475d:	e8 ad 24 00 00       	call   80106c0f <acquire>
80104762:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104765:	eb 3f                	jmp    801047a6 <piperead+0x5a>
    if(proc->killed){
80104767:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010476d:	8b 40 24             	mov    0x24(%eax),%eax
80104770:	85 c0                	test   %eax,%eax
80104772:	74 19                	je     8010478d <piperead+0x41>
      release(&p->lock);
80104774:	8b 45 08             	mov    0x8(%ebp),%eax
80104777:	83 ec 0c             	sub    $0xc,%esp
8010477a:	50                   	push   %eax
8010477b:	e8 fa 24 00 00       	call   80106c7a <release>
80104780:	83 c4 10             	add    $0x10,%esp
      return -1;
80104783:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104788:	e9 be 00 00 00       	jmp    8010484b <piperead+0xff>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010478d:	8b 45 08             	mov    0x8(%ebp),%eax
80104790:	8b 55 08             	mov    0x8(%ebp),%edx
80104793:	81 c2 34 02 00 00    	add    $0x234,%edx
80104799:	83 ec 08             	sub    $0x8,%esp
8010479c:	50                   	push   %eax
8010479d:	52                   	push   %edx
8010479e:	e8 6b 11 00 00       	call   8010590e <sleep>
801047a3:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801047a6:	8b 45 08             	mov    0x8(%ebp),%eax
801047a9:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801047af:	8b 45 08             	mov    0x8(%ebp),%eax
801047b2:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801047b8:	39 c2                	cmp    %eax,%edx
801047ba:	75 0d                	jne    801047c9 <piperead+0x7d>
801047bc:	8b 45 08             	mov    0x8(%ebp),%eax
801047bf:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801047c5:	85 c0                	test   %eax,%eax
801047c7:	75 9e                	jne    80104767 <piperead+0x1b>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801047c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801047d0:	eb 48                	jmp    8010481a <piperead+0xce>
    if(p->nread == p->nwrite)
801047d2:	8b 45 08             	mov    0x8(%ebp),%eax
801047d5:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
801047db:	8b 45 08             	mov    0x8(%ebp),%eax
801047de:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
801047e4:	39 c2                	cmp    %eax,%edx
801047e6:	74 3c                	je     80104824 <piperead+0xd8>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801047e8:	8b 45 08             	mov    0x8(%ebp),%eax
801047eb:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
801047f1:	8d 48 01             	lea    0x1(%eax),%ecx
801047f4:	8b 55 08             	mov    0x8(%ebp),%edx
801047f7:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
801047fd:	25 ff 01 00 00       	and    $0x1ff,%eax
80104802:	89 c1                	mov    %eax,%ecx
80104804:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104807:	8b 45 0c             	mov    0xc(%ebp),%eax
8010480a:	01 c2                	add    %eax,%edx
8010480c:	8b 45 08             	mov    0x8(%ebp),%eax
8010480f:	0f b6 44 08 34       	movzbl 0x34(%eax,%ecx,1),%eax
80104814:	88 02                	mov    %al,(%edx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104816:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010481a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010481d:	3b 45 10             	cmp    0x10(%ebp),%eax
80104820:	7c b0                	jl     801047d2 <piperead+0x86>
80104822:	eb 01                	jmp    80104825 <piperead+0xd9>
      break;
80104824:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104825:	8b 45 08             	mov    0x8(%ebp),%eax
80104828:	05 38 02 00 00       	add    $0x238,%eax
8010482d:	83 ec 0c             	sub    $0xc,%esp
80104830:	50                   	push   %eax
80104831:	e8 35 13 00 00       	call   80105b6b <wakeup>
80104836:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80104839:	8b 45 08             	mov    0x8(%ebp),%eax
8010483c:	83 ec 0c             	sub    $0xc,%esp
8010483f:	50                   	push   %eax
80104840:	e8 35 24 00 00       	call   80106c7a <release>
80104845:	83 c4 10             	add    $0x10,%esp
  return i;
80104848:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010484b:	c9                   	leave  
8010484c:	c3                   	ret    

8010484d <hlt>:
{
8010484d:	55                   	push   %ebp
8010484e:	89 e5                	mov    %esp,%ebp
  asm volatile("hlt");
80104850:	f4                   	hlt    
}
80104851:	90                   	nop
80104852:	5d                   	pop    %ebp
80104853:	c3                   	ret    

80104854 <readeflags>:
{
80104854:	55                   	push   %ebp
80104855:	89 e5                	mov    %esp,%ebp
80104857:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
8010485a:	9c                   	pushf  
8010485b:	58                   	pop    %eax
8010485c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010485f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104862:	c9                   	leave  
80104863:	c3                   	ret    

80104864 <sti>:
{
80104864:	55                   	push   %ebp
80104865:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104867:	fb                   	sti    
}
80104868:	90                   	nop
80104869:	5d                   	pop    %ebp
8010486a:	c3                   	ret    

8010486b <pinit>:
    [ZOMBIE]    "zombie"
};

void
pinit(void)
{
8010486b:	f3 0f 1e fb          	endbr32 
8010486f:	55                   	push   %ebp
80104870:	89 e5                	mov    %esp,%ebp
80104872:	83 ec 08             	sub    $0x8,%esp
    initlock(&ptable.lock, "ptable");
80104875:	83 ec 08             	sub    $0x8,%esp
80104878:	68 c6 a8 10 80       	push   $0x8010a8c6
8010487d:	68 00 66 11 80       	push   $0x80116600
80104882:	e8 62 23 00 00       	call   80106be9 <initlock>
80104887:	83 c4 10             	add    $0x10,%esp
}
8010488a:	90                   	nop
8010488b:	c9                   	leave  
8010488c:	c3                   	ret    

8010488d <allocproc>:
#else

// PROJECT 3 + 4 ALLOCPROC
static struct proc*
allocproc(void)
{
8010488d:	f3 0f 1e fb          	endbr32 
80104891:	55                   	push   %ebp
80104892:	89 e5                	mov    %esp,%ebp
80104894:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);
80104897:	83 ec 0c             	sub    $0xc,%esp
8010489a:	68 00 66 11 80       	push   $0x80116600
8010489f:	e8 6b 23 00 00       	call   80106c0f <acquire>
801048a4:	83 c4 10             	add    $0x10,%esp
    p = ptable.pLists.free;
801048a7:	a1 40 8d 11 80       	mov    0x80118d40,%eax
801048ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p) {
801048af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801048b3:	75 1a                	jne    801048cf <allocproc+0x42>
        goto found;
    }
    release(&ptable.lock);
801048b5:	83 ec 0c             	sub    $0xc,%esp
801048b8:	68 00 66 11 80       	push   $0x80116600
801048bd:	e8 b8 23 00 00       	call   80106c7a <release>
801048c2:	83 c4 10             	add    $0x10,%esp
    return 0;
801048c5:	b8 00 00 00 00       	mov    $0x0,%eax
801048ca:	e9 a6 01 00 00       	jmp    80104a75 <allocproc+0x1e8>
        goto found;
801048cf:	90                   	nop
801048d0:	f3 0f 1e fb          	endbr32 

found:

    assertState(p, UNUSED);
801048d4:	83 ec 08             	sub    $0x8,%esp
801048d7:	6a 00                	push   $0x0
801048d9:	ff 75 f4             	pushl  -0xc(%ebp)
801048dc:	e8 fa 19 00 00       	call   801062db <assertState>
801048e1:	83 c4 10             	add    $0x10,%esp
    if (removeFromStateList(&ptable.pLists.free, p) == -1) {
801048e4:	83 ec 08             	sub    $0x8,%esp
801048e7:	ff 75 f4             	pushl  -0xc(%ebp)
801048ea:	68 40 8d 11 80       	push   $0x80118d40
801048ef:	e8 14 1b 00 00       	call   80106408 <removeFromStateList>
801048f4:	83 c4 10             	add    $0x10,%esp
801048f7:	83 f8 ff             	cmp    $0xffffffff,%eax
801048fa:	75 10                	jne    8010490c <allocproc+0x7f>
        cprintf("Failed to remove proc from UNUSED list (allocproc).\n");
801048fc:	83 ec 0c             	sub    $0xc,%esp
801048ff:	68 d0 a8 10 80       	push   $0x8010a8d0
80104904:	e8 d5 ba ff ff       	call   801003de <cprintf>
80104909:	83 c4 10             	add    $0x10,%esp
    }
    p->state = EMBRYO;
8010490c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010490f:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
    if (addToStateListHead(&ptable.pLists.embryo, p) == -1) {
80104916:	83 ec 08             	sub    $0x8,%esp
80104919:	ff 75 f4             	pushl  -0xc(%ebp)
8010491c:	68 50 8d 11 80       	push   $0x80118d50
80104921:	e8 ed 19 00 00       	call   80106313 <addToStateListHead>
80104926:	83 c4 10             	add    $0x10,%esp
80104929:	83 f8 ff             	cmp    $0xffffffff,%eax
8010492c:	75 10                	jne    8010493e <allocproc+0xb1>
        cprintf("Failed to add proc to EMBRYO list (allocproc).\n");
8010492e:	83 ec 0c             	sub    $0xc,%esp
80104931:	68 08 a9 10 80       	push   $0x8010a908
80104936:	e8 a3 ba ff ff       	call   801003de <cprintf>
8010493b:	83 c4 10             	add    $0x10,%esp
    }

    p->pid = nextpid++;
8010493e:	a1 04 e0 10 80       	mov    0x8010e004,%eax
80104943:	8d 50 01             	lea    0x1(%eax),%edx
80104946:	89 15 04 e0 10 80    	mov    %edx,0x8010e004
8010494c:	89 c2                	mov    %eax,%edx
8010494e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104951:	89 50 10             	mov    %edx,0x10(%eax)
    release(&ptable.lock);
80104954:	83 ec 0c             	sub    $0xc,%esp
80104957:	68 00 66 11 80       	push   $0x80116600
8010495c:	e8 19 23 00 00       	call   80106c7a <release>
80104961:	83 c4 10             	add    $0x10,%esp

    // Allocate kernel stack.
    if((p->kstack = kalloc()) == 0){
80104964:	e8 57 e6 ff ff       	call   80102fc0 <kalloc>
80104969:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010496c:	89 42 08             	mov    %eax,0x8(%edx)
8010496f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104972:	8b 40 08             	mov    0x8(%eax),%eax
80104975:	85 c0                	test   %eax,%eax
80104977:	75 5f                	jne    801049d8 <allocproc+0x14b>
        assertState(p, EMBRYO);
80104979:	83 ec 08             	sub    $0x8,%esp
8010497c:	6a 01                	push   $0x1
8010497e:	ff 75 f4             	pushl  -0xc(%ebp)
80104981:	e8 55 19 00 00       	call   801062db <assertState>
80104986:	83 c4 10             	add    $0x10,%esp
        removeFromStateList(&ptable.pLists.embryo, p);
80104989:	83 ec 08             	sub    $0x8,%esp
8010498c:	ff 75 f4             	pushl  -0xc(%ebp)
8010498f:	68 50 8d 11 80       	push   $0x80118d50
80104994:	e8 6f 1a 00 00       	call   80106408 <removeFromStateList>
80104999:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
8010499c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010499f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        if (addToStateListHead(&ptable.pLists.free, p) == -1) {
801049a6:	83 ec 08             	sub    $0x8,%esp
801049a9:	ff 75 f4             	pushl  -0xc(%ebp)
801049ac:	68 40 8d 11 80       	push   $0x80118d40
801049b1:	e8 5d 19 00 00       	call   80106313 <addToStateListHead>
801049b6:	83 c4 10             	add    $0x10,%esp
801049b9:	83 f8 ff             	cmp    $0xffffffff,%eax
801049bc:	75 10                	jne    801049ce <allocproc+0x141>
            cprintf("Not enough room for process stack; Failed to add proc to UNUSED list (allocproc).\n");
801049be:	83 ec 0c             	sub    $0xc,%esp
801049c1:	68 38 a9 10 80       	push   $0x8010a938
801049c6:	e8 13 ba ff ff       	call   801003de <cprintf>
801049cb:	83 c4 10             	add    $0x10,%esp
        }
        return 0;
801049ce:	b8 00 00 00 00       	mov    $0x0,%eax
801049d3:	e9 9d 00 00 00       	jmp    80104a75 <allocproc+0x1e8>
    }
    sp = p->kstack + KSTACKSIZE;
801049d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049db:	8b 40 08             	mov    0x8(%eax),%eax
801049de:	05 00 10 00 00       	add    $0x1000,%eax
801049e3:	89 45 f0             	mov    %eax,-0x10(%ebp)

    // Leave room for trap frame.
    sp -= sizeof *p->tf;
801049e6:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
    p->tf = (struct trapframe*)sp;
801049ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049ed:	8b 55 f0             	mov    -0x10(%ebp),%edx
801049f0:	89 50 18             	mov    %edx,0x18(%eax)

    // Set up new context to start executing at forkret,
    // which returns to trapret.
    sp -= 4;
801049f3:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
    *(uint*)sp = (uint)trapret;
801049f7:	ba c4 85 10 80       	mov    $0x801085c4,%edx
801049fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801049ff:	89 10                	mov    %edx,(%eax)

    sp -= sizeof *p->context;
80104a01:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
    p->context = (struct context*)sp;
80104a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a08:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a0b:	89 50 1c             	mov    %edx,0x1c(%eax)
    memset(p->context, 0, sizeof *p->context);
80104a0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a11:	8b 40 1c             	mov    0x1c(%eax),%eax
80104a14:	83 ec 04             	sub    $0x4,%esp
80104a17:	6a 14                	push   $0x14
80104a19:	6a 00                	push   $0x0
80104a1b:	50                   	push   %eax
80104a1c:	e8 6a 24 00 00       	call   80106e8b <memset>
80104a21:	83 c4 10             	add    $0x10,%esp
    p->context->eip = (uint)forkret;
80104a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a27:	8b 40 1c             	mov    0x1c(%eax),%eax
80104a2a:	ba c4 58 10 80       	mov    $0x801058c4,%edx
80104a2f:	89 50 10             	mov    %edx,0x10(%eax)

    p->start_ticks = ticks;
80104a32:	8b 15 60 95 11 80    	mov    0x80119560,%edx
80104a38:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a3b:	89 50 7c             	mov    %edx,0x7c(%eax)
    p->cpu_ticks_total = 0;
80104a3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a41:	c7 80 88 00 00 00 00 	movl   $0x0,0x88(%eax)
80104a48:	00 00 00 
    p->cpu_ticks_in = 0;
80104a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a4e:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80104a55:	00 00 00 

    // Project 4
    p->budget = BUDGET;
80104a58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a5b:	c7 80 98 00 00 00 78 	movl   $0x78,0x98(%eax)
80104a62:	00 00 00 
    p->priority = 0;
80104a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a68:	c7 80 94 00 00 00 00 	movl   $0x0,0x94(%eax)
80104a6f:	00 00 00 

    return p;
80104a72:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104a75:	c9                   	leave  
80104a76:	c3                   	ret    

80104a77 <userinit>:
}
#else
// PROJECT 3 + 4 USERINIT
void
userinit(void)
{
80104a77:	f3 0f 1e fb          	endbr32 
80104a7b:	55                   	push   %ebp
80104a7c:	89 e5                	mov    %esp,%ebp
80104a7e:	83 ec 18             	sub    $0x18,%esp
    ptable.promoteAtTime = TIME_TO_PROMOTE; // Project 4, initialize promotion timer
80104a81:	c7 05 54 8d 11 80 0e 	movl   $0x10e,0x80118d54
80104a88:	01 00 00 
    struct proc *p;
    extern char _binary_initcode_start[], _binary_initcode_size[];

    // Add to the END of the UNUSED list upon init, or else processes will be backwards (ctrl-p & ps)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104a8b:	c7 45 f4 34 66 11 80 	movl   $0x80116634,-0xc(%ebp)
80104a92:	eb 3c                	jmp    80104ad0 <userinit+0x59>
        assertState(p, UNUSED);
80104a94:	83 ec 08             	sub    $0x8,%esp
80104a97:	6a 00                	push   $0x0
80104a99:	ff 75 f4             	pushl  -0xc(%ebp)
80104a9c:	e8 3a 18 00 00       	call   801062db <assertState>
80104aa1:	83 c4 10             	add    $0x10,%esp
        if (addToStateListEnd(&ptable.pLists.free, p) == -1) {
80104aa4:	83 ec 08             	sub    $0x8,%esp
80104aa7:	ff 75 f4             	pushl  -0xc(%ebp)
80104aaa:	68 40 8d 11 80       	push   $0x80118d40
80104aaf:	e8 cf 18 00 00       	call   80106383 <addToStateListEnd>
80104ab4:	83 c4 10             	add    $0x10,%esp
80104ab7:	83 f8 ff             	cmp    $0xffffffff,%eax
80104aba:	75 0d                	jne    80104ac9 <userinit+0x52>
            panic("Failed to add proc to UNUSED list.\n");
80104abc:	83 ec 0c             	sub    $0xc,%esp
80104abf:	68 8c a9 10 80       	push   $0x8010a98c
80104ac4:	e8 ce ba ff ff       	call   80100597 <panic>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104ac9:	81 45 f4 9c 00 00 00 	addl   $0x9c,-0xc(%ebp)
80104ad0:	81 7d f4 34 8d 11 80 	cmpl   $0x80118d34,-0xc(%ebp)
80104ad7:	72 bb                	jb     80104a94 <userinit+0x1d>
        }
    }

    p = allocproc();
80104ad9:	e8 af fd ff ff       	call   8010488d <allocproc>
80104ade:	89 45 f4             	mov    %eax,-0xc(%ebp)

    initproc = p;
80104ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ae4:	a3 68 e6 10 80       	mov    %eax,0x8010e668
    if((p->pgdir = setupkvm()) == 0)
80104ae9:	e8 c4 51 00 00       	call   80109cb2 <setupkvm>
80104aee:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104af1:	89 42 04             	mov    %eax,0x4(%edx)
80104af4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104af7:	8b 40 04             	mov    0x4(%eax),%eax
80104afa:	85 c0                	test   %eax,%eax
80104afc:	75 0d                	jne    80104b0b <userinit+0x94>
        panic("userinit: out of memory?");
80104afe:	83 ec 0c             	sub    $0xc,%esp
80104b01:	68 b0 a9 10 80       	push   $0x8010a9b0
80104b06:	e8 8c ba ff ff       	call   80100597 <panic>
    inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104b0b:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b13:	8b 40 04             	mov    0x4(%eax),%eax
80104b16:	83 ec 04             	sub    $0x4,%esp
80104b19:	52                   	push   %edx
80104b1a:	68 00 e5 10 80       	push   $0x8010e500
80104b1f:	50                   	push   %eax
80104b20:	e8 f8 53 00 00       	call   80109f1d <inituvm>
80104b25:	83 c4 10             	add    $0x10,%esp
    p->sz = PGSIZE;
80104b28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b2b:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
    memset(p->tf, 0, sizeof(*p->tf));
80104b31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b34:	8b 40 18             	mov    0x18(%eax),%eax
80104b37:	83 ec 04             	sub    $0x4,%esp
80104b3a:	6a 4c                	push   $0x4c
80104b3c:	6a 00                	push   $0x0
80104b3e:	50                   	push   %eax
80104b3f:	e8 47 23 00 00       	call   80106e8b <memset>
80104b44:	83 c4 10             	add    $0x10,%esp
    p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104b47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b4a:	8b 40 18             	mov    0x18(%eax),%eax
80104b4d:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
    p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b56:	8b 40 18             	mov    0x18(%eax),%eax
80104b59:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
    p->tf->es = p->tf->ds;
80104b5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b62:	8b 50 18             	mov    0x18(%eax),%edx
80104b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b68:	8b 40 18             	mov    0x18(%eax),%eax
80104b6b:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104b6f:	66 89 50 28          	mov    %dx,0x28(%eax)
    p->tf->ss = p->tf->ds;
80104b73:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b76:	8b 50 18             	mov    0x18(%eax),%edx
80104b79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b7c:	8b 40 18             	mov    0x18(%eax),%eax
80104b7f:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104b83:	66 89 50 48          	mov    %dx,0x48(%eax)
    p->tf->eflags = FL_IF;
80104b87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b8a:	8b 40 18             	mov    0x18(%eax),%eax
80104b8d:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
    p->tf->esp = PGSIZE;
80104b94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b97:	8b 40 18             	mov    0x18(%eax),%eax
80104b9a:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
    p->tf->eip = 0;  // beginning of initcode.S
80104ba1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ba4:	8b 40 18             	mov    0x18(%eax),%eax
80104ba7:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

#ifdef BAGIAN_UPROC
    p->uid = UID;
80104bae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bb1:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80104bb8:	00 00 00 
    p->gid = GID;
80104bbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bbe:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80104bc5:	00 00 00 
    p->parent = p; // parent of proc one is itself
80104bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bcb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bce:	89 50 14             	mov    %edx,0x14(%eax)
#endif

    safestrcpy(p->name, "initcode", sizeof(p->name));
80104bd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bd4:	83 c0 6c             	add    $0x6c,%eax
80104bd7:	83 ec 04             	sub    $0x4,%esp
80104bda:	6a 10                	push   $0x10
80104bdc:	68 c9 a9 10 80       	push   $0x8010a9c9
80104be1:	50                   	push   %eax
80104be2:	e8 bf 24 00 00       	call   801070a6 <safestrcpy>
80104be7:	83 c4 10             	add    $0x10,%esp
    p->cwd = namei("/");
80104bea:	83 ec 0c             	sub    $0xc,%esp
80104bed:	68 d2 a9 10 80       	push   $0x8010a9d2
80104bf2:	e8 bc db ff ff       	call   801027b3 <namei>
80104bf7:	83 c4 10             	add    $0x10,%esp
80104bfa:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bfd:	89 42 68             	mov    %eax,0x68(%edx)

    assertState(p, EMBRYO);
80104c00:	83 ec 08             	sub    $0x8,%esp
80104c03:	6a 01                	push   $0x1
80104c05:	ff 75 f4             	pushl  -0xc(%ebp)
80104c08:	e8 ce 16 00 00       	call   801062db <assertState>
80104c0d:	83 c4 10             	add    $0x10,%esp
    if (removeFromStateList(&ptable.pLists.embryo, p) < 0) {
80104c10:	83 ec 08             	sub    $0x8,%esp
80104c13:	ff 75 f4             	pushl  -0xc(%ebp)
80104c16:	68 50 8d 11 80       	push   $0x80118d50
80104c1b:	e8 e8 17 00 00       	call   80106408 <removeFromStateList>
80104c20:	83 c4 10             	add    $0x10,%esp
80104c23:	85 c0                	test   %eax,%eax
80104c25:	79 10                	jns    80104c37 <userinit+0x1c0>
        cprintf("Failed to remove EMBRYO proc from list (userinit).\n");
80104c27:	83 ec 0c             	sub    $0xc,%esp
80104c2a:	68 d4 a9 10 80       	push   $0x8010a9d4
80104c2f:	e8 aa b7 ff ff       	call   801003de <cprintf>
80104c34:	83 c4 10             	add    $0x10,%esp
    }

    p->state = RUNNABLE;
80104c37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c3a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

    //ptable.pLists.ready = p;  // add to head of ready list

    ptable.pLists.ready[0] = p;  // add to head of highest priority ready list
80104c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c44:	a3 34 8d 11 80       	mov    %eax,0x80118d34
    p->next = 0;
80104c49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c4c:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80104c53:	00 00 00 
    for (int i = 1; i <= MAX; ++i) {
80104c56:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
80104c5d:	eb 17                	jmp    80104c76 <userinit+0x1ff>
        ptable.pLists.ready[i] = 0; // initialize all of the other ready lists
80104c5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c62:	05 cc 09 00 00       	add    $0x9cc,%eax
80104c67:	c7 04 85 04 66 11 80 	movl   $0x0,-0x7fee99fc(,%eax,4)
80104c6e:	00 00 00 00 
    for (int i = 1; i <= MAX; ++i) {
80104c72:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104c76:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
80104c7a:	7e e3                	jle    80104c5f <userinit+0x1e8>
    }
    ptable.pLists.sleep = 0;  // initialize rest of the lists to NULL
80104c7c:	c7 05 44 8d 11 80 00 	movl   $0x0,0x80118d44
80104c83:	00 00 00 
    ptable.pLists.zombie = 0;
80104c86:	c7 05 48 8d 11 80 00 	movl   $0x0,0x80118d48
80104c8d:	00 00 00 
    ptable.pLists.running = 0;
80104c90:	c7 05 4c 8d 11 80 00 	movl   $0x0,0x80118d4c
80104c97:	00 00 00 
    ptable.pLists.embryo = 0;
80104c9a:	c7 05 50 8d 11 80 00 	movl   $0x0,0x80118d50
80104ca1:	00 00 00 
}
80104ca4:	90                   	nop
80104ca5:	c9                   	leave  
80104ca6:	c3                   	ret    

80104ca7 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104ca7:	f3 0f 1e fb          	endbr32 
80104cab:	55                   	push   %ebp
80104cac:	89 e5                	mov    %esp,%ebp
80104cae:	83 ec 18             	sub    $0x18,%esp
    uint sz;

    sz = proc->sz;
80104cb1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cb7:	8b 00                	mov    (%eax),%eax
80104cb9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(n > 0){
80104cbc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104cc0:	7e 31                	jle    80104cf3 <growproc+0x4c>
        if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80104cc2:	8b 55 08             	mov    0x8(%ebp),%edx
80104cc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cc8:	01 c2                	add    %eax,%edx
80104cca:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cd0:	8b 40 04             	mov    0x4(%eax),%eax
80104cd3:	83 ec 04             	sub    $0x4,%esp
80104cd6:	52                   	push   %edx
80104cd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cda:	50                   	push   %eax
80104cdb:	e8 92 53 00 00       	call   8010a072 <allocuvm>
80104ce0:	83 c4 10             	add    $0x10,%esp
80104ce3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104ce6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104cea:	75 3e                	jne    80104d2a <growproc+0x83>
            return -1;
80104cec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cf1:	eb 59                	jmp    80104d4c <growproc+0xa5>
    } else if(n < 0){
80104cf3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104cf7:	79 31                	jns    80104d2a <growproc+0x83>
        if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80104cf9:	8b 55 08             	mov    0x8(%ebp),%edx
80104cfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cff:	01 c2                	add    %eax,%edx
80104d01:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d07:	8b 40 04             	mov    0x4(%eax),%eax
80104d0a:	83 ec 04             	sub    $0x4,%esp
80104d0d:	52                   	push   %edx
80104d0e:	ff 75 f4             	pushl  -0xc(%ebp)
80104d11:	50                   	push   %eax
80104d12:	e8 26 54 00 00       	call   8010a13d <deallocuvm>
80104d17:	83 c4 10             	add    $0x10,%esp
80104d1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104d1d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104d21:	75 07                	jne    80104d2a <growproc+0x83>
            return -1;
80104d23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d28:	eb 22                	jmp    80104d4c <growproc+0xa5>
    }
    proc->sz = sz;
80104d2a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d30:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d33:	89 10                	mov    %edx,(%eax)
    switchuvm(proc);
80104d35:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d3b:	83 ec 0c             	sub    $0xc,%esp
80104d3e:	50                   	push   %eax
80104d3f:	e8 61 50 00 00       	call   80109da5 <switchuvm>
80104d44:	83 c4 10             	add    $0x10,%esp
    return 0;
80104d47:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104d4c:	c9                   	leave  
80104d4d:	c3                   	ret    

80104d4e <fork>:
}
#else
// PROJECT 3 + 4 FORK
int
fork(void)
{
80104d4e:	f3 0f 1e fb          	endbr32 
80104d52:	55                   	push   %ebp
80104d53:	89 e5                	mov    %esp,%ebp
80104d55:	57                   	push   %edi
80104d56:	56                   	push   %esi
80104d57:	53                   	push   %ebx
80104d58:	83 ec 1c             	sub    $0x1c,%esp
    int i, pid;
    struct proc *np;

    // Allocate process.
    if((np = allocproc()) == 0)
80104d5b:	e8 2d fb ff ff       	call   8010488d <allocproc>
80104d60:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104d63:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80104d67:	75 0a                	jne    80104d73 <fork+0x25>
        return -1;
80104d69:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d6e:	e9 5d 02 00 00       	jmp    80104fd0 <fork+0x282>

    // Copy process state from p.
    if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80104d73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d79:	8b 10                	mov    (%eax),%edx
80104d7b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d81:	8b 40 04             	mov    0x4(%eax),%eax
80104d84:	83 ec 08             	sub    $0x8,%esp
80104d87:	52                   	push   %edx
80104d88:	50                   	push   %eax
80104d89:	e8 59 55 00 00       	call   8010a2e7 <copyuvm>
80104d8e:	83 c4 10             	add    $0x10,%esp
80104d91:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104d94:	89 42 04             	mov    %eax,0x4(%edx)
80104d97:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104d9a:	8b 40 04             	mov    0x4(%eax),%eax
80104d9d:	85 c0                	test   %eax,%eax
80104d9f:	0f 85 88 00 00 00    	jne    80104e2d <fork+0xdf>
        kfree(np->kstack);
80104da5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104da8:	8b 40 08             	mov    0x8(%eax),%eax
80104dab:	83 ec 0c             	sub    $0xc,%esp
80104dae:	50                   	push   %eax
80104daf:	e8 6b e1 ff ff       	call   80102f1f <kfree>
80104db4:	83 c4 10             	add    $0x10,%esp
        np->kstack = 0;
80104db7:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104dba:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        assertState(np, EMBRYO);
80104dc1:	83 ec 08             	sub    $0x8,%esp
80104dc4:	6a 01                	push   $0x1
80104dc6:	ff 75 e0             	pushl  -0x20(%ebp)
80104dc9:	e8 0d 15 00 00       	call   801062db <assertState>
80104dce:	83 c4 10             	add    $0x10,%esp
        if (removeFromStateList(&ptable.pLists.embryo, np) < 0) {
80104dd1:	83 ec 08             	sub    $0x8,%esp
80104dd4:	ff 75 e0             	pushl  -0x20(%ebp)
80104dd7:	68 50 8d 11 80       	push   $0x80118d50
80104ddc:	e8 27 16 00 00       	call   80106408 <removeFromStateList>
80104de1:	83 c4 10             	add    $0x10,%esp
80104de4:	85 c0                	test   %eax,%eax
80104de6:	79 0d                	jns    80104df5 <fork+0xa7>
            panic("Failed to remove proc from EMBRYO list (fork).\n");
80104de8:	83 ec 0c             	sub    $0xc,%esp
80104deb:	68 08 aa 10 80       	push   $0x8010aa08
80104df0:	e8 a2 b7 ff ff       	call   80100597 <panic>
        }
        np->state = UNUSED;
80104df5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104df8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        if (addToStateListHead(&ptable.pLists.free, np) < 0) {
80104dff:	83 ec 08             	sub    $0x8,%esp
80104e02:	ff 75 e0             	pushl  -0x20(%ebp)
80104e05:	68 40 8d 11 80       	push   $0x80118d40
80104e0a:	e8 04 15 00 00       	call   80106313 <addToStateListHead>
80104e0f:	83 c4 10             	add    $0x10,%esp
80104e12:	85 c0                	test   %eax,%eax
80104e14:	79 0d                	jns    80104e23 <fork+0xd5>
            panic("Failed to add proc to UNUSED list (fork).\n");
80104e16:	83 ec 0c             	sub    $0xc,%esp
80104e19:	68 38 aa 10 80       	push   $0x8010aa38
80104e1e:	e8 74 b7 ff ff       	call   80100597 <panic>
        }
        return -1;
80104e23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e28:	e9 a3 01 00 00       	jmp    80104fd0 <fork+0x282>
    }
    np->sz = proc->sz;
80104e2d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e33:	8b 10                	mov    (%eax),%edx
80104e35:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e38:	89 10                	mov    %edx,(%eax)
    np->parent = proc;
80104e3a:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104e41:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e44:	89 50 14             	mov    %edx,0x14(%eax)
    *np->tf = *proc->tf;
80104e47:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e4d:	8b 48 18             	mov    0x18(%eax),%ecx
80104e50:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e53:	8b 40 18             	mov    0x18(%eax),%eax
80104e56:	89 c2                	mov    %eax,%edx
80104e58:	89 cb                	mov    %ecx,%ebx
80104e5a:	b8 13 00 00 00       	mov    $0x13,%eax
80104e5f:	89 d7                	mov    %edx,%edi
80104e61:	89 de                	mov    %ebx,%esi
80104e63:	89 c1                	mov    %eax,%ecx
80104e65:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
80104e67:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e6a:	8b 40 18             	mov    0x18(%eax),%eax
80104e6d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

    for(i = 0; i < NOFILE; i++)
80104e74:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104e7b:	eb 41                	jmp    80104ebe <fork+0x170>
        if(proc->ofile[i])
80104e7d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e83:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104e86:	83 c2 08             	add    $0x8,%edx
80104e89:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104e8d:	85 c0                	test   %eax,%eax
80104e8f:	74 29                	je     80104eba <fork+0x16c>
            np->ofile[i] = filedup(proc->ofile[i]);
80104e91:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104e97:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104e9a:	83 c2 08             	add    $0x8,%edx
80104e9d:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104ea1:	83 ec 0c             	sub    $0xc,%esp
80104ea4:	50                   	push   %eax
80104ea5:	e8 dc c2 ff ff       	call   80101186 <filedup>
80104eaa:	83 c4 10             	add    $0x10,%esp
80104ead:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104eb0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104eb3:	83 c1 08             	add    $0x8,%ecx
80104eb6:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
    for(i = 0; i < NOFILE; i++)
80104eba:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104ebe:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104ec2:	7e b9                	jle    80104e7d <fork+0x12f>
    np->cwd = idup(proc->cwd);
80104ec4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104eca:	8b 40 68             	mov    0x68(%eax),%eax
80104ecd:	83 ec 0c             	sub    $0xc,%esp
80104ed0:	50                   	push   %eax
80104ed1:	e8 5c cc ff ff       	call   80101b32 <idup>
80104ed6:	83 c4 10             	add    $0x10,%esp
80104ed9:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104edc:	89 42 68             	mov    %eax,0x68(%edx)

    safestrcpy(np->name, proc->name, sizeof(proc->name));
80104edf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ee5:	8d 50 6c             	lea    0x6c(%eax),%edx
80104ee8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104eeb:	83 c0 6c             	add    $0x6c,%eax
80104eee:	83 ec 04             	sub    $0x4,%esp
80104ef1:	6a 10                	push   $0x10
80104ef3:	52                   	push   %edx
80104ef4:	50                   	push   %eax
80104ef5:	e8 ac 21 00 00       	call   801070a6 <safestrcpy>
80104efa:	83 c4 10             	add    $0x10,%esp

    np->uid = proc->uid;
80104efd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f03:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80104f09:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f0c:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    np->gid = proc->gid;
80104f12:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104f18:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
80104f1e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f21:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)

    pid = np->pid;
80104f27:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f2a:	8b 40 10             	mov    0x10(%eax),%eax
80104f2d:	89 45 dc             	mov    %eax,-0x24(%ebp)

    // lock to force the compiler to emit the np->state write last.
    acquire(&ptable.lock);
80104f30:	83 ec 0c             	sub    $0xc,%esp
80104f33:	68 00 66 11 80       	push   $0x80116600
80104f38:	e8 d2 1c 00 00       	call   80106c0f <acquire>
80104f3d:	83 c4 10             	add    $0x10,%esp
    assertState(np, EMBRYO);
80104f40:	83 ec 08             	sub    $0x8,%esp
80104f43:	6a 01                	push   $0x1
80104f45:	ff 75 e0             	pushl  -0x20(%ebp)
80104f48:	e8 8e 13 00 00       	call   801062db <assertState>
80104f4d:	83 c4 10             	add    $0x10,%esp
    if (removeFromStateList(&ptable.pLists.embryo, np) < 0) {
80104f50:	83 ec 08             	sub    $0x8,%esp
80104f53:	ff 75 e0             	pushl  -0x20(%ebp)
80104f56:	68 50 8d 11 80       	push   $0x80118d50
80104f5b:	e8 a8 14 00 00       	call   80106408 <removeFromStateList>
80104f60:	83 c4 10             	add    $0x10,%esp
80104f63:	85 c0                	test   %eax,%eax
80104f65:	79 10                	jns    80104f77 <fork+0x229>
        cprintf("Failed to remove EMBRYO proc from list (fork).\n");
80104f67:	83 ec 0c             	sub    $0xc,%esp
80104f6a:	68 64 aa 10 80       	push   $0x8010aa64
80104f6f:	e8 6a b4 ff ff       	call   801003de <cprintf>
80104f74:	83 c4 10             	add    $0x10,%esp
    }

    np->state = RUNNABLE;
80104f77:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f7a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

    // add to end of highest priority queue
    if (addToStateListEnd(&ptable.pLists.ready[np->priority], np) < 0) {
80104f81:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f84:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80104f8a:	05 cc 09 00 00       	add    $0x9cc,%eax
80104f8f:	c1 e0 02             	shl    $0x2,%eax
80104f92:	05 00 66 11 80       	add    $0x80116600,%eax
80104f97:	83 c0 04             	add    $0x4,%eax
80104f9a:	83 ec 08             	sub    $0x8,%esp
80104f9d:	ff 75 e0             	pushl  -0x20(%ebp)
80104fa0:	50                   	push   %eax
80104fa1:	e8 dd 13 00 00       	call   80106383 <addToStateListEnd>
80104fa6:	83 c4 10             	add    $0x10,%esp
80104fa9:	85 c0                	test   %eax,%eax
80104fab:	79 10                	jns    80104fbd <fork+0x26f>
        cprintf("Failed to add RUNNABLE proc to list (fork).\n");
80104fad:	83 ec 0c             	sub    $0xc,%esp
80104fb0:	68 94 aa 10 80       	push   $0x8010aa94
80104fb5:	e8 24 b4 ff ff       	call   801003de <cprintf>
80104fba:	83 c4 10             	add    $0x10,%esp
    }
    release(&ptable.lock);
80104fbd:	83 ec 0c             	sub    $0xc,%esp
80104fc0:	68 00 66 11 80       	push   $0x80116600
80104fc5:	e8 b0 1c 00 00       	call   80106c7a <release>
80104fca:	83 c4 10             	add    $0x10,%esp

    return pid;
80104fcd:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80104fd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104fd3:	5b                   	pop    %ebx
80104fd4:	5e                   	pop    %esi
80104fd5:	5f                   	pop    %edi
80104fd6:	5d                   	pop    %ebp
80104fd7:	c3                   	ret    

80104fd8 <exit>:
    panic("zombie exit");
}
#else
void
exit(void)
{
80104fd8:	f3 0f 1e fb          	endbr32 
80104fdc:	55                   	push   %ebp
80104fdd:	89 e5                	mov    %esp,%ebp
80104fdf:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;
    struct proc *current;
    int fd;

    if(proc == initproc)
80104fe2:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104fe9:	a1 68 e6 10 80       	mov    0x8010e668,%eax
80104fee:	39 c2                	cmp    %eax,%edx
80104ff0:	75 0d                	jne    80104fff <exit+0x27>
        panic("init exiting");
80104ff2:	83 ec 0c             	sub    $0xc,%esp
80104ff5:	68 c1 aa 10 80       	push   $0x8010aac1
80104ffa:	e8 98 b5 ff ff       	call   80100597 <panic>

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
80104fff:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80105006:	eb 48                	jmp    80105050 <exit+0x78>
        if(proc->ofile[fd]){
80105008:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010500e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105011:	83 c2 08             	add    $0x8,%edx
80105014:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105018:	85 c0                	test   %eax,%eax
8010501a:	74 30                	je     8010504c <exit+0x74>
            fileclose(proc->ofile[fd]);
8010501c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105022:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105025:	83 c2 08             	add    $0x8,%edx
80105028:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010502c:	83 ec 0c             	sub    $0xc,%esp
8010502f:	50                   	push   %eax
80105030:	e8 a6 c1 ff ff       	call   801011db <fileclose>
80105035:	83 c4 10             	add    $0x10,%esp
            proc->ofile[fd] = 0;
80105038:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010503e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105041:	83 c2 08             	add    $0x8,%edx
80105044:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010504b:	00 
    for(fd = 0; fd < NOFILE; fd++){
8010504c:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80105050:	83 7d ec 0f          	cmpl   $0xf,-0x14(%ebp)
80105054:	7e b2                	jle    80105008 <exit+0x30>
        }
    }

    begin_op();
80105056:	e8 8b e8 ff ff       	call   801038e6 <begin_op>
    iput(proc->cwd);
8010505b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105061:	8b 40 68             	mov    0x68(%eax),%eax
80105064:	83 ec 0c             	sub    $0xc,%esp
80105067:	50                   	push   %eax
80105068:	e8 ff cc ff ff       	call   80101d6c <iput>
8010506d:	83 c4 10             	add    $0x10,%esp
    end_op();
80105070:	e8 01 e9 ff ff       	call   80103976 <end_op>
    proc->cwd = 0;
80105075:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010507b:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

    acquire(&ptable.lock);
80105082:	83 ec 0c             	sub    $0xc,%esp
80105085:	68 00 66 11 80       	push   $0x80116600
8010508a:	e8 80 1b 00 00       	call   80106c0f <acquire>
8010508f:	83 c4 10             	add    $0x10,%esp

    // Parent might be sleeping in wait().
    wakeup1(proc->parent);
80105092:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105098:	8b 40 14             	mov    0x14(%eax),%eax
8010509b:	83 ec 0c             	sub    $0xc,%esp
8010509e:	50                   	push   %eax
8010509f:	e8 f5 09 00 00       	call   80105a99 <wakeup1>
801050a4:	83 c4 10             	add    $0x10,%esp
    
    // Pass abandoned children to init.
    current = ptable.pLists.zombie;
801050a7:	a1 48 8d 11 80       	mov    0x80118d48,%eax
801050ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while (current) {
801050af:	eb 3f                	jmp    801050f0 <exit+0x118>
        p = current;
801050b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        current = current->next;
801050b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050ba:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801050c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (p->parent == proc) {
801050c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050c6:	8b 50 14             	mov    0x14(%eax),%edx
801050c9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801050cf:	39 c2                	cmp    %eax,%edx
801050d1:	75 1d                	jne    801050f0 <exit+0x118>
            p->parent = initproc;
801050d3:	8b 15 68 e6 10 80    	mov    0x8010e668,%edx
801050d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050dc:	89 50 14             	mov    %edx,0x14(%eax)
            wakeup1(initproc);
801050df:	a1 68 e6 10 80       	mov    0x8010e668,%eax
801050e4:	83 ec 0c             	sub    $0xc,%esp
801050e7:	50                   	push   %eax
801050e8:	e8 ac 09 00 00       	call   80105a99 <wakeup1>
801050ed:	83 c4 10             	add    $0x10,%esp
    while (current) {
801050f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801050f4:	75 bb                	jne    801050b1 <exit+0xd9>
        }
    }
    p = ptable.pLists.running; // now running list
801050f6:	a1 4c 8d 11 80       	mov    0x80118d4c,%eax
801050fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
801050fe:	eb 28                	jmp    80105128 <exit+0x150>
        if(p->parent == proc){
80105100:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105103:	8b 50 14             	mov    0x14(%eax),%edx
80105106:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010510c:	39 c2                	cmp    %eax,%edx
8010510e:	75 0c                	jne    8010511c <exit+0x144>
            p->parent = initproc;
80105110:	8b 15 68 e6 10 80    	mov    0x8010e668,%edx
80105116:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105119:	89 50 14             	mov    %edx,0x14(%eax)
        }
        p = p->next;
8010511c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010511f:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105125:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105128:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010512c:	75 d2                	jne    80105100 <exit+0x128>
    }
    // traverse array of ready lists
    for (int i = 0; i <= MAX; ++i) {
8010512e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
80105135:	eb 46                	jmp    8010517d <exit+0x1a5>
        p = ptable.pLists.ready[i]; // now ready
80105137:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010513a:	05 cc 09 00 00       	add    $0x9cc,%eax
8010513f:	8b 04 85 04 66 11 80 	mov    -0x7fee99fc(,%eax,4),%eax
80105146:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (p) {
80105149:	eb 28                	jmp    80105173 <exit+0x19b>
            if (p->parent == proc) {
8010514b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010514e:	8b 50 14             	mov    0x14(%eax),%edx
80105151:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105157:	39 c2                	cmp    %eax,%edx
80105159:	75 0c                	jne    80105167 <exit+0x18f>
                p->parent = initproc;
8010515b:	8b 15 68 e6 10 80    	mov    0x8010e668,%edx
80105161:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105164:	89 50 14             	mov    %edx,0x14(%eax)
            }
            p = p->next;
80105167:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010516a:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105170:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (p) {
80105173:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105177:	75 d2                	jne    8010514b <exit+0x173>
    for (int i = 0; i <= MAX; ++i) {
80105179:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
8010517d:	83 7d e8 02          	cmpl   $0x2,-0x18(%ebp)
80105181:	7e b4                	jle    80105137 <exit+0x15f>
        }
    }
    p = ptable.pLists.sleep; // sleeping list
80105183:	a1 44 8d 11 80       	mov    0x80118d44,%eax
80105188:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
8010518b:	eb 28                	jmp    801051b5 <exit+0x1dd>
        if (p->parent == proc) {
8010518d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105190:	8b 50 14             	mov    0x14(%eax),%edx
80105193:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105199:	39 c2                	cmp    %eax,%edx
8010519b:	75 0c                	jne    801051a9 <exit+0x1d1>
            p->parent = initproc;
8010519d:	8b 15 68 e6 10 80    	mov    0x8010e668,%edx
801051a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051a6:	89 50 14             	mov    %edx,0x14(%eax)
        }
        p = p->next;
801051a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051ac:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801051b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
801051b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801051b9:	75 d2                	jne    8010518d <exit+0x1b5>
    }
    p = ptable.pLists.embryo; // embryo list
801051bb:	a1 50 8d 11 80       	mov    0x80118d50,%eax
801051c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
801051c3:	eb 28                	jmp    801051ed <exit+0x215>
        if (p->parent == proc) {
801051c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051c8:	8b 50 14             	mov    0x14(%eax),%edx
801051cb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051d1:	39 c2                	cmp    %eax,%edx
801051d3:	75 0c                	jne    801051e1 <exit+0x209>
            p->parent = initproc;
801051d5:	8b 15 68 e6 10 80    	mov    0x8010e668,%edx
801051db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051de:	89 50 14             	mov    %edx,0x14(%eax)
        }
        p = p->next;
801051e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051e4:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801051ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
801051ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801051f1:	75 d2                	jne    801051c5 <exit+0x1ed>
    }
    p = ptable.pLists.free; // free list
801051f3:	a1 40 8d 11 80       	mov    0x80118d40,%eax
801051f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
801051fb:	eb 28                	jmp    80105225 <exit+0x24d>
        if (p->parent == proc) {
801051fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105200:	8b 50 14             	mov    0x14(%eax),%edx
80105203:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105209:	39 c2                	cmp    %eax,%edx
8010520b:	75 0c                	jne    80105219 <exit+0x241>
            p->parent = initproc;
8010520d:	8b 15 68 e6 10 80    	mov    0x8010e668,%edx
80105213:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105216:	89 50 14             	mov    %edx,0x14(%eax)
        }
        p = p->next;
80105219:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010521c:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105222:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105225:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105229:	75 d2                	jne    801051fd <exit+0x225>
    }

    assertState(proc, RUNNING);
8010522b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105231:	83 ec 08             	sub    $0x8,%esp
80105234:	6a 04                	push   $0x4
80105236:	50                   	push   %eax
80105237:	e8 9f 10 00 00       	call   801062db <assertState>
8010523c:	83 c4 10             	add    $0x10,%esp
    if (removeFromStateList(&ptable.pLists.running, proc) < 0) {
8010523f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105245:	83 ec 08             	sub    $0x8,%esp
80105248:	50                   	push   %eax
80105249:	68 4c 8d 11 80       	push   $0x80118d4c
8010524e:	e8 b5 11 00 00       	call   80106408 <removeFromStateList>
80105253:	83 c4 10             	add    $0x10,%esp
80105256:	85 c0                	test   %eax,%eax
80105258:	79 10                	jns    8010526a <exit+0x292>
        cprintf("Failed to remove RUNNING proc from list (exit).\n");
8010525a:	83 ec 0c             	sub    $0xc,%esp
8010525d:	68 d0 aa 10 80       	push   $0x8010aad0
80105262:	e8 77 b1 ff ff       	call   801003de <cprintf>
80105267:	83 c4 10             	add    $0x10,%esp
    }
    // Jump into the scheduler, never to return.
    proc->state = ZOMBIE;
8010526a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105270:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
    if (addToStateListHead(&ptable.pLists.zombie, proc) < 0) {
80105277:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010527d:	83 ec 08             	sub    $0x8,%esp
80105280:	50                   	push   %eax
80105281:	68 48 8d 11 80       	push   $0x80118d48
80105286:	e8 88 10 00 00       	call   80106313 <addToStateListHead>
8010528b:	83 c4 10             	add    $0x10,%esp
8010528e:	85 c0                	test   %eax,%eax
80105290:	79 10                	jns    801052a2 <exit+0x2ca>
        cprintf("Failed to add ZOMBIE proc to list (exit).\n");
80105292:	83 ec 0c             	sub    $0xc,%esp
80105295:	68 04 ab 10 80       	push   $0x8010ab04
8010529a:	e8 3f b1 ff ff       	call   801003de <cprintf>
8010529f:	83 c4 10             	add    $0x10,%esp
    }

    sched();
801052a2:	e8 f3 03 00 00       	call   8010569a <sched>
    panic("zombie exit");
801052a7:	83 ec 0c             	sub    $0xc,%esp
801052aa:	68 2f ab 10 80       	push   $0x8010ab2f
801052af:	e8 e3 b2 ff ff       	call   80100597 <panic>

801052b4 <wait>:
    }
}
#else
int
wait(void)
{
801052b4:	f3 0f 1e fb          	endbr32 
801052b8:	55                   	push   %ebp
801052b9:	89 e5                	mov    %esp,%ebp
801052bb:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;
    int havekids, pid;

    acquire(&ptable.lock);
801052be:	83 ec 0c             	sub    $0xc,%esp
801052c1:	68 00 66 11 80       	push   $0x80116600
801052c6:	e8 44 19 00 00       	call   80106c0f <acquire>
801052cb:	83 c4 10             	add    $0x10,%esp
    for(;;){
        // Scan through table looking for zombie children.
        havekids = 0;
801052ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
        // start at zombie list
        p = ptable.pLists.zombie;
801052d5:	a1 48 8d 11 80       	mov    0x80118d48,%eax
801052da:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (!havekids && p) {
801052dd:	e9 03 01 00 00       	jmp    801053e5 <wait+0x131>
            if (p->parent == proc) {
801052e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052e5:	8b 50 14             	mov    0x14(%eax),%edx
801052e8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052ee:	39 c2                	cmp    %eax,%edx
801052f0:	0f 85 e3 00 00 00    	jne    801053d9 <wait+0x125>
                havekids = 1;
801052f6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
                pid = p->pid;
801052fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105300:	8b 40 10             	mov    0x10(%eax),%eax
80105303:	89 45 e8             	mov    %eax,-0x18(%ebp)
                kfree(p->kstack);
80105306:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105309:	8b 40 08             	mov    0x8(%eax),%eax
8010530c:	83 ec 0c             	sub    $0xc,%esp
8010530f:	50                   	push   %eax
80105310:	e8 0a dc ff ff       	call   80102f1f <kfree>
80105315:	83 c4 10             	add    $0x10,%esp
                p->kstack = 0;
80105318:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010531b:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
                freevm(p->pgdir);
80105322:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105325:	8b 40 04             	mov    0x4(%eax),%eax
80105328:	83 ec 0c             	sub    $0xc,%esp
8010532b:	50                   	push   %eax
8010532c:	e8 cd 4e 00 00       	call   8010a1fe <freevm>
80105331:	83 c4 10             	add    $0x10,%esp
                assertState(p, ZOMBIE);
80105334:	83 ec 08             	sub    $0x8,%esp
80105337:	6a 05                	push   $0x5
80105339:	ff 75 f4             	pushl  -0xc(%ebp)
8010533c:	e8 9a 0f 00 00       	call   801062db <assertState>
80105341:	83 c4 10             	add    $0x10,%esp
                if (removeFromStateList(&ptable.pLists.zombie, p) < 0) {
80105344:	83 ec 08             	sub    $0x8,%esp
80105347:	ff 75 f4             	pushl  -0xc(%ebp)
8010534a:	68 48 8d 11 80       	push   $0x80118d48
8010534f:	e8 b4 10 00 00       	call   80106408 <removeFromStateList>
80105354:	83 c4 10             	add    $0x10,%esp
80105357:	85 c0                	test   %eax,%eax
80105359:	79 10                	jns    8010536b <wait+0xb7>
                    cprintf("Failed to remove ZOMBIE process from list (wait).\n");
8010535b:	83 ec 0c             	sub    $0xc,%esp
8010535e:	68 3c ab 10 80       	push   $0x8010ab3c
80105363:	e8 76 b0 ff ff       	call   801003de <cprintf>
80105368:	83 c4 10             	add    $0x10,%esp
                }
                p->state = UNUSED;
8010536b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010536e:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
                if (addToStateListHead(&ptable.pLists.free, p) < 0) {
80105375:	83 ec 08             	sub    $0x8,%esp
80105378:	ff 75 f4             	pushl  -0xc(%ebp)
8010537b:	68 40 8d 11 80       	push   $0x80118d40
80105380:	e8 8e 0f 00 00       	call   80106313 <addToStateListHead>
80105385:	83 c4 10             	add    $0x10,%esp
80105388:	85 c0                	test   %eax,%eax
8010538a:	79 10                	jns    8010539c <wait+0xe8>
                    cprintf("Failed to add UNUSED process to list (wait).\n");
8010538c:	83 ec 0c             	sub    $0xc,%esp
8010538f:	68 70 ab 10 80       	push   $0x8010ab70
80105394:	e8 45 b0 ff ff       	call   801003de <cprintf>
80105399:	83 c4 10             	add    $0x10,%esp
                }
                p->pid = 0;
8010539c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010539f:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
                p->parent = 0;
801053a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053a9:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
                p->name[0] = 0;
801053b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053b3:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
                p->killed = 0;
801053b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053ba:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
                release(&ptable.lock);
801053c1:	83 ec 0c             	sub    $0xc,%esp
801053c4:	68 00 66 11 80       	push   $0x80116600
801053c9:	e8 ac 18 00 00       	call   80106c7a <release>
801053ce:	83 c4 10             	add    $0x10,%esp
                return pid;
801053d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801053d4:	e9 2a 01 00 00       	jmp    80105503 <wait+0x24f>
            }
            p = p->next;
801053d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053dc:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801053e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (!havekids && p) {
801053e5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801053e9:	75 0a                	jne    801053f5 <wait+0x141>
801053eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801053ef:	0f 85 ed fe ff ff    	jne    801052e2 <wait+0x2e>
        }
        // Runnable list
        for (int i = 0; i <= MAX; i++) {
801053f5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
801053fc:	eb 47                	jmp    80105445 <wait+0x191>
            p = ptable.pLists.ready[i];
801053fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105401:	05 cc 09 00 00       	add    $0x9cc,%eax
80105406:	8b 04 85 04 66 11 80 	mov    -0x7fee99fc(,%eax,4),%eax
8010540d:	89 45 f4             	mov    %eax,-0xc(%ebp)
            while (!havekids && p) {
80105410:	eb 23                	jmp    80105435 <wait+0x181>
                if (p->parent == proc) {
80105412:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105415:	8b 50 14             	mov    0x14(%eax),%edx
80105418:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010541e:	39 c2                	cmp    %eax,%edx
80105420:	75 07                	jne    80105429 <wait+0x175>
                    havekids = 1;
80105422:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
                }
                p = p->next;
80105429:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010542c:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105432:	89 45 f4             	mov    %eax,-0xc(%ebp)
            while (!havekids && p) {
80105435:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105439:	75 06                	jne    80105441 <wait+0x18d>
8010543b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010543f:	75 d1                	jne    80105412 <wait+0x15e>
        for (int i = 0; i <= MAX; i++) {
80105441:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80105445:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
80105449:	7e b3                	jle    801053fe <wait+0x14a>
            }
        }
        // Running list
        p = ptable.pLists.running;
8010544b:	a1 4c 8d 11 80       	mov    0x80118d4c,%eax
80105450:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (!havekids && p) {
80105453:	eb 23                	jmp    80105478 <wait+0x1c4>
            if (p->parent == proc) {
80105455:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105458:	8b 50 14             	mov    0x14(%eax),%edx
8010545b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105461:	39 c2                	cmp    %eax,%edx
80105463:	75 07                	jne    8010546c <wait+0x1b8>
                havekids = 1;
80105465:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
            }
            p = p->next;
8010546c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010546f:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105475:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (!havekids && p) {
80105478:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010547c:	75 06                	jne    80105484 <wait+0x1d0>
8010547e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105482:	75 d1                	jne    80105455 <wait+0x1a1>
        }
        // Sleep list
        p = ptable.pLists.sleep;
80105484:	a1 44 8d 11 80       	mov    0x80118d44,%eax
80105489:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (!havekids && p) {
8010548c:	eb 23                	jmp    801054b1 <wait+0x1fd>
            if (p->parent == proc) {
8010548e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105491:	8b 50 14             	mov    0x14(%eax),%edx
80105494:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010549a:	39 c2                	cmp    %eax,%edx
8010549c:	75 07                	jne    801054a5 <wait+0x1f1>
                havekids = 1;
8010549e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
            }
            p = p->next;
801054a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054a8:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801054ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (!havekids && p) {
801054b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801054b5:	75 06                	jne    801054bd <wait+0x209>
801054b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801054bb:	75 d1                	jne    8010548e <wait+0x1da>
        }
        // No point waiting if we don't have any children.
        if(!havekids || proc->killed) {
801054bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801054c1:	74 0d                	je     801054d0 <wait+0x21c>
801054c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054c9:	8b 40 24             	mov    0x24(%eax),%eax
801054cc:	85 c0                	test   %eax,%eax
801054ce:	74 17                	je     801054e7 <wait+0x233>
            release(&ptable.lock);
801054d0:	83 ec 0c             	sub    $0xc,%esp
801054d3:	68 00 66 11 80       	push   $0x80116600
801054d8:	e8 9d 17 00 00       	call   80106c7a <release>
801054dd:	83 c4 10             	add    $0x10,%esp
            return -1;
801054e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054e5:	eb 1c                	jmp    80105503 <wait+0x24f>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(proc, &ptable.lock);  //DOC: wait-sleep
801054e7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054ed:	83 ec 08             	sub    $0x8,%esp
801054f0:	68 00 66 11 80       	push   $0x80116600
801054f5:	50                   	push   %eax
801054f6:	e8 13 04 00 00       	call   8010590e <sleep>
801054fb:	83 c4 10             	add    $0x10,%esp
        havekids = 0;
801054fe:	e9 cb fd ff ff       	jmp    801052ce <wait+0x1a>
    }
}
80105503:	c9                   	leave  
80105504:	c3                   	ret    

80105505 <scheduler>:

#else
// Project 3 scheduler
void
scheduler(void)
{
80105505:	f3 0f 1e fb          	endbr32 
80105509:	55                   	push   %ebp
8010550a:	89 e5                	mov    %esp,%ebp
8010550c:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;
    int idle;  // for checking if processor is idle
    int ran; // ready list loop condition 
    for(;;) {
        // Enable interrupts on this processor.
        sti();
8010550f:	e8 50 f3 ff ff       	call   80104864 <sti>
        idle = 1;  // assume idle unless we schedule a process
80105514:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        ran = 0; // reset ran, look for another process
8010551b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
80105522:	83 ec 0c             	sub    $0xc,%esp
80105525:	68 00 66 11 80       	push   $0x80116600
8010552a:	e8 e0 16 00 00       	call   80106c0f <acquire>
8010552f:	83 c4 10             	add    $0x10,%esp

        if ((ptable.promoteAtTime) == ticks) {
80105532:	8b 15 54 8d 11 80    	mov    0x80118d54,%edx
80105538:	a1 60 95 11 80       	mov    0x80119560,%eax
8010553d:	39 c2                	cmp    %eax,%edx
8010553f:	75 14                	jne    80105555 <scheduler+0x50>
            promoteAll(); // RUNNING, RUNNABLE, SLEEPING
80105541:	e8 be 12 00 00       	call   80106804 <promoteAll>
            ptable.promoteAtTime = (ticks + TIME_TO_PROMOTE); // update next time we will promote everything
80105546:	a1 60 95 11 80       	mov    0x80119560,%eax
8010554b:	05 0e 01 00 00       	add    $0x10e,%eax
80105550:	a3 54 8d 11 80       	mov    %eax,0x80118d54
        }
        for (int i = 0; (i <= MAX) && (ran == 0); ++i) {
80105555:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
8010555c:	e9 00 01 00 00       	jmp    80105661 <scheduler+0x15c>
            // take first process on first valid list
            p = ptable.pLists.ready[i];
80105561:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105564:	05 cc 09 00 00       	add    $0x9cc,%eax
80105569:	8b 04 85 04 66 11 80 	mov    -0x7fee99fc(,%eax,4),%eax
80105570:	89 45 e8             	mov    %eax,-0x18(%ebp)
            if (p) {
80105573:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80105577:	0f 84 e0 00 00 00    	je     8010565d <scheduler+0x158>
                // assign pointer, aseert correct state
                assertState(p, RUNNABLE);
8010557d:	83 ec 08             	sub    $0x8,%esp
80105580:	6a 03                	push   $0x3
80105582:	ff 75 e8             	pushl  -0x18(%ebp)
80105585:	e8 51 0d 00 00       	call   801062db <assertState>
8010558a:	83 c4 10             	add    $0x10,%esp
                // take 1st process on ready list
                p = removeHead(&ptable.pLists.ready[p->priority]);
8010558d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105590:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80105596:	05 cc 09 00 00       	add    $0x9cc,%eax
8010559b:	c1 e0 02             	shl    $0x2,%eax
8010559e:	05 00 66 11 80       	add    $0x80116600,%eax
801055a3:	83 c0 04             	add    $0x4,%eax
801055a6:	83 ec 0c             	sub    $0xc,%esp
801055a9:	50                   	push   %eax
801055aa:	e8 51 0f 00 00       	call   80106500 <removeHead>
801055af:	83 c4 10             	add    $0x10,%esp
801055b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
                if (!p) {
801055b5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801055b9:	75 0d                	jne    801055c8 <scheduler+0xc3>
                    panic("Scheduler: removeHead failed.");
801055bb:	83 ec 0c             	sub    $0xc,%esp
801055be:	68 9e ab 10 80       	push   $0x8010ab9e
801055c3:	e8 cf af ff ff       	call   80100597 <panic>
                }
                // hand over to the CPU
                idle = 0;
801055c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
                proc = p;
801055cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
801055d2:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
                switchuvm(p);
801055d8:	83 ec 0c             	sub    $0xc,%esp
801055db:	ff 75 e8             	pushl  -0x18(%ebp)
801055de:	e8 c2 47 00 00       	call   80109da5 <switchuvm>
801055e3:	83 c4 10             	add    $0x10,%esp
                p->state = RUNNING;
801055e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
801055e9:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
                // add to end of running list
                if (addToStateListEnd(&ptable.pLists.running, p) < 0) {
801055f0:	83 ec 08             	sub    $0x8,%esp
801055f3:	ff 75 e8             	pushl  -0x18(%ebp)
801055f6:	68 4c 8d 11 80       	push   $0x80118d4c
801055fb:	e8 83 0d 00 00       	call   80106383 <addToStateListEnd>
80105600:	83 c4 10             	add    $0x10,%esp
80105603:	85 c0                	test   %eax,%eax
80105605:	79 10                	jns    80105617 <scheduler+0x112>
                    cprintf("Failed to add RUNNING proc to list (scheduler).");
80105607:	83 ec 0c             	sub    $0xc,%esp
8010560a:	68 bc ab 10 80       	push   $0x8010abbc
8010560f:	e8 ca ad ff ff       	call   801003de <cprintf>
80105614:	83 c4 10             	add    $0x10,%esp
                }
                p->cpu_ticks_in = ticks; // ticks when scheduled
80105617:	8b 15 60 95 11 80    	mov    0x80119560,%edx
8010561d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105620:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
                swtch(&cpu->scheduler, proc->context);
80105626:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010562c:	8b 40 1c             	mov    0x1c(%eax),%eax
8010562f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80105636:	83 c2 04             	add    $0x4,%edx
80105639:	83 ec 08             	sub    $0x8,%esp
8010563c:	50                   	push   %eax
8010563d:	52                   	push   %edx
8010563e:	e8 dc 1a 00 00       	call   8010711f <swtch>
80105643:	83 c4 10             	add    $0x10,%esp
                switchkvm();
80105646:	e8 39 47 00 00       	call   80109d84 <switchkvm>
                // Process is done running for now.
                // It should have changed its p->state before coming back.
                proc = 0;
8010564b:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80105652:	00 00 00 00 
                ran = 1; // exit loop after this
80105656:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
        for (int i = 0; (i <= MAX) && (ran == 0); ++i) {
8010565d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80105661:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
80105665:	7f 0a                	jg     80105671 <scheduler+0x16c>
80105667:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010566b:	0f 84 f0 fe ff ff    	je     80105561 <scheduler+0x5c>
            }
        }
        release(&ptable.lock);
80105671:	83 ec 0c             	sub    $0xc,%esp
80105674:	68 00 66 11 80       	push   $0x80116600
80105679:	e8 fc 15 00 00       	call   80106c7a <release>
8010567e:	83 c4 10             	add    $0x10,%esp
        if (idle) {
80105681:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105685:	0f 84 84 fe ff ff    	je     8010550f <scheduler+0xa>
            sti();
8010568b:	e8 d4 f1 ff ff       	call   80104864 <sti>
            hlt();
80105690:	e8 b8 f1 ff ff       	call   8010484d <hlt>
        sti();
80105695:	e9 75 fe ff ff       	jmp    8010550f <scheduler+0xa>

8010569a <sched>:
    cpu->intena = intena;
}
#else
void
sched(void)
{
8010569a:	f3 0f 1e fb          	endbr32 
8010569e:	55                   	push   %ebp
8010569f:	89 e5                	mov    %esp,%ebp
801056a1:	83 ec 18             	sub    $0x18,%esp
    int intena;

    if(!holding(&ptable.lock))
801056a4:	83 ec 0c             	sub    $0xc,%esp
801056a7:	68 00 66 11 80       	push   $0x80116600
801056ac:	e8 9e 16 00 00       	call   80106d4f <holding>
801056b1:	83 c4 10             	add    $0x10,%esp
801056b4:	85 c0                	test   %eax,%eax
801056b6:	75 0d                	jne    801056c5 <sched+0x2b>
        panic("sched ptable.lock");
801056b8:	83 ec 0c             	sub    $0xc,%esp
801056bb:	68 ec ab 10 80       	push   $0x8010abec
801056c0:	e8 d2 ae ff ff       	call   80100597 <panic>
    if(cpu->ncli != 1)
801056c5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801056cb:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801056d1:	83 f8 01             	cmp    $0x1,%eax
801056d4:	74 0d                	je     801056e3 <sched+0x49>
        panic("sched locks");
801056d6:	83 ec 0c             	sub    $0xc,%esp
801056d9:	68 fe ab 10 80       	push   $0x8010abfe
801056de:	e8 b4 ae ff ff       	call   80100597 <panic>
    if(proc->state == RUNNING)
801056e3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056e9:	8b 40 0c             	mov    0xc(%eax),%eax
801056ec:	83 f8 04             	cmp    $0x4,%eax
801056ef:	75 0d                	jne    801056fe <sched+0x64>
        panic("sched running");
801056f1:	83 ec 0c             	sub    $0xc,%esp
801056f4:	68 0a ac 10 80       	push   $0x8010ac0a
801056f9:	e8 99 ae ff ff       	call   80100597 <panic>
    if(readeflags()&FL_IF)
801056fe:	e8 51 f1 ff ff       	call   80104854 <readeflags>
80105703:	25 00 02 00 00       	and    $0x200,%eax
80105708:	85 c0                	test   %eax,%eax
8010570a:	74 0d                	je     80105719 <sched+0x7f>
        panic("sched interruptible");
8010570c:	83 ec 0c             	sub    $0xc,%esp
8010570f:	68 18 ac 10 80       	push   $0x8010ac18
80105714:	e8 7e ae ff ff       	call   80100597 <panic>
    intena = cpu->intena;
80105719:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010571f:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105725:	89 45 f4             	mov    %eax,-0xc(%ebp)

    proc->cpu_ticks_total += (ticks - proc->cpu_ticks_in);
80105728:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010572e:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80105734:	8b 0d 60 95 11 80    	mov    0x80119560,%ecx
8010573a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105740:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80105746:	29 c1                	sub    %eax,%ecx
80105748:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010574e:	01 ca                	add    %ecx,%edx
80105750:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)

    swtch(&proc->context, cpu->scheduler);
80105756:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010575c:	8b 40 04             	mov    0x4(%eax),%eax
8010575f:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105766:	83 c2 1c             	add    $0x1c,%edx
80105769:	83 ec 08             	sub    $0x8,%esp
8010576c:	50                   	push   %eax
8010576d:	52                   	push   %edx
8010576e:	e8 ac 19 00 00       	call   8010711f <swtch>
80105773:	83 c4 10             	add    $0x10,%esp

    cpu->intena = intena;
80105776:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010577c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010577f:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80105785:	90                   	nop
80105786:	c9                   	leave  
80105787:	c3                   	ret    

80105788 <yield>:
#endif

// Give up the CPU for one scheduling round.
void
yield(void)
{
80105788:	f3 0f 1e fb          	endbr32 
8010578c:	55                   	push   %ebp
8010578d:	89 e5                	mov    %esp,%ebp
8010578f:	83 ec 08             	sub    $0x8,%esp
    acquire(&ptable.lock);  //DOC: yieldlock
80105792:	83 ec 0c             	sub    $0xc,%esp
80105795:	68 00 66 11 80       	push   $0x80116600
8010579a:	e8 70 14 00 00       	call   80106c0f <acquire>
8010579f:	83 c4 10             	add    $0x10,%esp

#ifdef BAGIAN_INODE
    assertState(proc, RUNNING);
801057a2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057a8:	83 ec 08             	sub    $0x8,%esp
801057ab:	6a 04                	push   $0x4
801057ad:	50                   	push   %eax
801057ae:	e8 28 0b 00 00       	call   801062db <assertState>
801057b3:	83 c4 10             	add    $0x10,%esp
    if (removeFromStateList(&ptable.pLists.running, proc) < 0) {
801057b6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057bc:	83 ec 08             	sub    $0x8,%esp
801057bf:	50                   	push   %eax
801057c0:	68 4c 8d 11 80       	push   $0x80118d4c
801057c5:	e8 3e 0c 00 00       	call   80106408 <removeFromStateList>
801057ca:	83 c4 10             	add    $0x10,%esp
801057cd:	85 c0                	test   %eax,%eax
801057cf:	79 10                	jns    801057e1 <yield+0x59>
        cprintf("Failed to remove RUNNING proc to list (yeild).");
801057d1:	83 ec 0c             	sub    $0xc,%esp
801057d4:	68 2c ac 10 80       	push   $0x8010ac2c
801057d9:	e8 00 ac ff ff       	call   801003de <cprintf>
801057de:	83 c4 10             	add    $0x10,%esp
    }
#endif

    proc->state = RUNNABLE;
801057e1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057e7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

#ifdef BAGIAN_INODE
    proc->budget -= (ticks - proc->cpu_ticks_in); // update budget, then check
801057ee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057f4:	8b 80 98 00 00 00    	mov    0x98(%eax),%eax
801057fa:	89 c1                	mov    %eax,%ecx
801057fc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105802:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80105808:	a1 60 95 11 80       	mov    0x80119560,%eax
8010580d:	29 c2                	sub    %eax,%edx
8010580f:	89 d0                	mov    %edx,%eax
80105811:	8d 14 01             	lea    (%ecx,%eax,1),%edx
80105814:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010581a:	89 90 98 00 00 00    	mov    %edx,0x98(%eax)
    if ((proc->budget) <= 0) {
80105820:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105826:	8b 80 98 00 00 00    	mov    0x98(%eax),%eax
8010582c:	85 c0                	test   %eax,%eax
8010582e:	7f 36                	jg     80105866 <yield+0xde>
        if ((proc->priority) < MAX) {
80105830:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105836:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
8010583c:	83 f8 01             	cmp    $0x1,%eax
8010583f:	77 15                	ja     80105856 <yield+0xce>
            ++(proc->priority); // Demotion
80105841:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105847:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
8010584d:	83 c2 01             	add    $0x1,%edx
80105850:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
        }
        proc->budget = BUDGET; // Reset budget
80105856:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010585c:	c7 80 98 00 00 00 78 	movl   $0x78,0x98(%eax)
80105863:	00 00 00 
    }

    if (addToStateListEnd(&ptable.pLists.ready[proc->priority], proc) < 0) {
80105866:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010586c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105873:	8b 92 94 00 00 00    	mov    0x94(%edx),%edx
80105879:	81 c2 cc 09 00 00    	add    $0x9cc,%edx
8010587f:	c1 e2 02             	shl    $0x2,%edx
80105882:	81 c2 00 66 11 80    	add    $0x80116600,%edx
80105888:	83 c2 04             	add    $0x4,%edx
8010588b:	83 ec 08             	sub    $0x8,%esp
8010588e:	50                   	push   %eax
8010588f:	52                   	push   %edx
80105890:	e8 ee 0a 00 00       	call   80106383 <addToStateListEnd>
80105895:	83 c4 10             	add    $0x10,%esp
80105898:	85 c0                	test   %eax,%eax
8010589a:	79 10                	jns    801058ac <yield+0x124>
        cprintf("Failed to add RUNNABLE proc to list (yeild).");
8010589c:	83 ec 0c             	sub    $0xc,%esp
8010589f:	68 5c ac 10 80       	push   $0x8010ac5c
801058a4:	e8 35 ab ff ff       	call   801003de <cprintf>
801058a9:	83 c4 10             	add    $0x10,%esp
    }
#endif

    sched();
801058ac:	e8 e9 fd ff ff       	call   8010569a <sched>
    release(&ptable.lock);
801058b1:	83 ec 0c             	sub    $0xc,%esp
801058b4:	68 00 66 11 80       	push   $0x80116600
801058b9:	e8 bc 13 00 00       	call   80106c7a <release>
801058be:	83 c4 10             	add    $0x10,%esp
}
801058c1:	90                   	nop
801058c2:	c9                   	leave  
801058c3:	c3                   	ret    

801058c4 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801058c4:	f3 0f 1e fb          	endbr32 
801058c8:	55                   	push   %ebp
801058c9:	89 e5                	mov    %esp,%ebp
801058cb:	83 ec 08             	sub    $0x8,%esp
    static int first = 1;
    // Still holding ptable.lock from scheduler.
    release(&ptable.lock);
801058ce:	83 ec 0c             	sub    $0xc,%esp
801058d1:	68 00 66 11 80       	push   $0x80116600
801058d6:	e8 9f 13 00 00       	call   80106c7a <release>
801058db:	83 c4 10             	add    $0x10,%esp

    if (first) {
801058de:	a1 20 e0 10 80       	mov    0x8010e020,%eax
801058e3:	85 c0                	test   %eax,%eax
801058e5:	74 24                	je     8010590b <forkret+0x47>
        // Some initialization functions must be run in the context
        // of a regular process (e.g., they call sleep), and thus cannot 
        // be run from main().
        first = 0;
801058e7:	c7 05 20 e0 10 80 00 	movl   $0x0,0x8010e020
801058ee:	00 00 00 
        iinit(ROOTDEV);
801058f1:	83 ec 0c             	sub    $0xc,%esp
801058f4:	6a 01                	push   $0x1
801058f6:	e8 ed be ff ff       	call   801017e8 <iinit>
801058fb:	83 c4 10             	add    $0x10,%esp
        initlog(ROOTDEV);
801058fe:	83 ec 0c             	sub    $0xc,%esp
80105901:	6a 01                	push   $0x1
80105903:	e8 ab dd ff ff       	call   801036b3 <initlog>
80105908:	83 c4 10             	add    $0x10,%esp
    }

    // Return to "caller", actually trapret (see allocproc).
}
8010590b:	90                   	nop
8010590c:	c9                   	leave  
8010590d:	c3                   	ret    

8010590e <sleep>:
// Reacquires lock when awakened.
// 2016/12/28: ticklock removed from xv6. sleep() changed to
// accept a NULL lock to accommodate.
void
sleep(void *chan, struct spinlock *lk)
{
8010590e:	f3 0f 1e fb          	endbr32 
80105912:	55                   	push   %ebp
80105913:	89 e5                	mov    %esp,%ebp
80105915:	83 ec 08             	sub    $0x8,%esp
    if(proc == 0)
80105918:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010591e:	85 c0                	test   %eax,%eax
80105920:	75 0d                	jne    8010592f <sleep+0x21>
        panic("sleep");
80105922:	83 ec 0c             	sub    $0xc,%esp
80105925:	68 89 ac 10 80       	push   $0x8010ac89
8010592a:	e8 68 ac ff ff       	call   80100597 <panic>
    // change p->state and then call sched.
    // Once we hold ptable.lock, we can be
    // guaranteed that we won't miss any wakeup
    // (wakeup runs with ptable.lock locked),
    // so it's okay to release lk.
    if(lk != &ptable.lock){
8010592f:	81 7d 0c 00 66 11 80 	cmpl   $0x80116600,0xc(%ebp)
80105936:	74 24                	je     8010595c <sleep+0x4e>
        acquire(&ptable.lock);
80105938:	83 ec 0c             	sub    $0xc,%esp
8010593b:	68 00 66 11 80       	push   $0x80116600
80105940:	e8 ca 12 00 00       	call   80106c0f <acquire>
80105945:	83 c4 10             	add    $0x10,%esp
        if (lk) release(lk);
80105948:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010594c:	74 0e                	je     8010595c <sleep+0x4e>
8010594e:	83 ec 0c             	sub    $0xc,%esp
80105951:	ff 75 0c             	pushl  0xc(%ebp)
80105954:	e8 21 13 00 00       	call   80106c7a <release>
80105959:	83 c4 10             	add    $0x10,%esp
    }

    // Go to sleep.
    proc->chan = chan;
8010595c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105962:	8b 55 08             	mov    0x8(%ebp),%edx
80105965:	89 50 20             	mov    %edx,0x20(%eax)

#ifdef BAGIAN_INODE
    assertState(proc, RUNNING);
80105968:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010596e:	83 ec 08             	sub    $0x8,%esp
80105971:	6a 04                	push   $0x4
80105973:	50                   	push   %eax
80105974:	e8 62 09 00 00       	call   801062db <assertState>
80105979:	83 c4 10             	add    $0x10,%esp
    if (removeFromStateList(&ptable.pLists.running, proc) < 0) {
8010597c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105982:	83 ec 08             	sub    $0x8,%esp
80105985:	50                   	push   %eax
80105986:	68 4c 8d 11 80       	push   $0x80118d4c
8010598b:	e8 78 0a 00 00       	call   80106408 <removeFromStateList>
80105990:	83 c4 10             	add    $0x10,%esp
80105993:	85 c0                	test   %eax,%eax
80105995:	79 10                	jns    801059a7 <sleep+0x99>
        cprintf("Could not remove RUNNING proc from list (sleep()).\n");
80105997:	83 ec 0c             	sub    $0xc,%esp
8010599a:	68 90 ac 10 80       	push   $0x8010ac90
8010599f:	e8 3a aa ff ff       	call   801003de <cprintf>
801059a4:	83 c4 10             	add    $0x10,%esp
    }
#endif

    proc->state = SLEEPING;
801059a7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059ad:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

#ifdef BAGIAN_INODE
    proc->budget -= (ticks - proc->cpu_ticks_in); // update budget, then check
801059b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059ba:	8b 80 98 00 00 00    	mov    0x98(%eax),%eax
801059c0:	89 c1                	mov    %eax,%ecx
801059c2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059c8:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801059ce:	a1 60 95 11 80       	mov    0x80119560,%eax
801059d3:	29 c2                	sub    %eax,%edx
801059d5:	89 d0                	mov    %edx,%eax
801059d7:	8d 14 01             	lea    (%ecx,%eax,1),%edx
801059da:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059e0:	89 90 98 00 00 00    	mov    %edx,0x98(%eax)
    if ((proc->budget) <= 0) {
801059e6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059ec:	8b 80 98 00 00 00    	mov    0x98(%eax),%eax
801059f2:	85 c0                	test   %eax,%eax
801059f4:	7f 36                	jg     80105a2c <sleep+0x11e>
        // priority cant be greater than MAX bc it is literal index of ready list array
        if ((proc->priority) < MAX) {
801059f6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801059fc:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80105a02:	83 f8 01             	cmp    $0x1,%eax
80105a05:	77 15                	ja     80105a1c <sleep+0x10e>
            ++(proc->priority); // Demotion
80105a07:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a0d:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
80105a13:	83 c2 01             	add    $0x1,%edx
80105a16:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
        }
        proc->budget = BUDGET; // Reset budget
80105a1c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a22:	c7 80 98 00 00 00 78 	movl   $0x78,0x98(%eax)
80105a29:	00 00 00 
    }
    if (addToStateListEnd(&ptable.pLists.sleep, proc) < 0) {
80105a2c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a32:	83 ec 08             	sub    $0x8,%esp
80105a35:	50                   	push   %eax
80105a36:	68 44 8d 11 80       	push   $0x80118d44
80105a3b:	e8 43 09 00 00       	call   80106383 <addToStateListEnd>
80105a40:	83 c4 10             	add    $0x10,%esp
80105a43:	85 c0                	test   %eax,%eax
80105a45:	79 10                	jns    80105a57 <sleep+0x149>
        cprintf("Could not add SLEEPING proc to list (sleep()).\n");
80105a47:	83 ec 0c             	sub    $0xc,%esp
80105a4a:	68 c4 ac 10 80       	push   $0x8010acc4
80105a4f:	e8 8a a9 ff ff       	call   801003de <cprintf>
80105a54:	83 c4 10             	add    $0x10,%esp
    }
#endif

    sched();
80105a57:	e8 3e fc ff ff       	call   8010569a <sched>

    // Tidy up.
    proc->chan = 0;
80105a5c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105a62:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

    // Reacquire original lock.
    if(lk != &ptable.lock){ 
80105a69:	81 7d 0c 00 66 11 80 	cmpl   $0x80116600,0xc(%ebp)
80105a70:	74 24                	je     80105a96 <sleep+0x188>
        release(&ptable.lock);
80105a72:	83 ec 0c             	sub    $0xc,%esp
80105a75:	68 00 66 11 80       	push   $0x80116600
80105a7a:	e8 fb 11 00 00       	call   80106c7a <release>
80105a7f:	83 c4 10             	add    $0x10,%esp
        if (lk) acquire(lk);
80105a82:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105a86:	74 0e                	je     80105a96 <sleep+0x188>
80105a88:	83 ec 0c             	sub    $0xc,%esp
80105a8b:	ff 75 0c             	pushl  0xc(%ebp)
80105a8e:	e8 7c 11 00 00       	call   80106c0f <acquire>
80105a93:	83 c4 10             	add    $0x10,%esp
    }
}
80105a96:	90                   	nop
80105a97:	c9                   	leave  
80105a98:	c3                   	ret    

80105a99 <wakeup1>:
}
#else
// P3 wakeup1
static void
wakeup1(void *chan)
{
80105a99:	f3 0f 1e fb          	endbr32 
80105a9d:	55                   	push   %ebp
80105a9e:	89 e5                	mov    %esp,%ebp
80105aa0:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;
    if (ptable.pLists.sleep) {
80105aa3:	a1 44 8d 11 80       	mov    0x80118d44,%eax
80105aa8:	85 c0                	test   %eax,%eax
80105aaa:	0f 84 b8 00 00 00    	je     80105b68 <wakeup1+0xcf>
        struct proc * current = ptable.pLists.sleep;
80105ab0:	a1 44 8d 11 80       	mov    0x80118d44,%eax
80105ab5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        p = 0;
80105ab8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
        while (current) {
80105abf:	e9 9a 00 00 00       	jmp    80105b5e <wakeup1+0xc5>
            p = current;
80105ac4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ac7:	89 45 f0             	mov    %eax,-0x10(%ebp)
            current = current->next;
80105aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105acd:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105ad3:	89 45 f4             	mov    %eax,-0xc(%ebp)
            assertState(p, SLEEPING);
80105ad6:	83 ec 08             	sub    $0x8,%esp
80105ad9:	6a 02                	push   $0x2
80105adb:	ff 75 f0             	pushl  -0x10(%ebp)
80105ade:	e8 f8 07 00 00       	call   801062db <assertState>
80105ae3:	83 c4 10             	add    $0x10,%esp
            if (p->chan == chan) {
80105ae6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ae9:	8b 40 20             	mov    0x20(%eax),%eax
80105aec:	39 45 08             	cmp    %eax,0x8(%ebp)
80105aef:	75 6d                	jne    80105b5e <wakeup1+0xc5>
                if (removeFromStateList(&ptable.pLists.sleep, p) < 0) {
80105af1:	83 ec 08             	sub    $0x8,%esp
80105af4:	ff 75 f0             	pushl  -0x10(%ebp)
80105af7:	68 44 8d 11 80       	push   $0x80118d44
80105afc:	e8 07 09 00 00       	call   80106408 <removeFromStateList>
80105b01:	83 c4 10             	add    $0x10,%esp
80105b04:	85 c0                	test   %eax,%eax
80105b06:	79 10                	jns    80105b18 <wakeup1+0x7f>
                    cprintf("Failed to remove SLEEPING proc to list (wakeup1).\n");
80105b08:	83 ec 0c             	sub    $0xc,%esp
80105b0b:	68 f4 ac 10 80       	push   $0x8010acf4
80105b10:	e8 c9 a8 ff ff       	call   801003de <cprintf>
80105b15:	83 c4 10             	add    $0x10,%esp
                }
                p->state = RUNNABLE;
80105b18:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b1b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
                if (addToStateListEnd(&ptable.pLists.ready[p->priority], p) < 0) {
80105b22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105b25:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80105b2b:	05 cc 09 00 00       	add    $0x9cc,%eax
80105b30:	c1 e0 02             	shl    $0x2,%eax
80105b33:	05 00 66 11 80       	add    $0x80116600,%eax
80105b38:	83 c0 04             	add    $0x4,%eax
80105b3b:	83 ec 08             	sub    $0x8,%esp
80105b3e:	ff 75 f0             	pushl  -0x10(%ebp)
80105b41:	50                   	push   %eax
80105b42:	e8 3c 08 00 00       	call   80106383 <addToStateListEnd>
80105b47:	83 c4 10             	add    $0x10,%esp
80105b4a:	85 c0                	test   %eax,%eax
80105b4c:	79 10                	jns    80105b5e <wakeup1+0xc5>
                    cprintf("Failed to add RUNNABLE proc to list (wakeup1).\n");
80105b4e:	83 ec 0c             	sub    $0xc,%esp
80105b51:	68 28 ad 10 80       	push   $0x8010ad28
80105b56:	e8 83 a8 ff ff       	call   801003de <cprintf>
80105b5b:	83 c4 10             	add    $0x10,%esp
        while (current) {
80105b5e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b62:	0f 85 5c ff ff ff    	jne    80105ac4 <wakeup1+0x2b>
                }
            }
        }
    }
}
80105b68:	90                   	nop
80105b69:	c9                   	leave  
80105b6a:	c3                   	ret    

80105b6b <wakeup>:
#endif

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80105b6b:	f3 0f 1e fb          	endbr32 
80105b6f:	55                   	push   %ebp
80105b70:	89 e5                	mov    %esp,%ebp
80105b72:	83 ec 08             	sub    $0x8,%esp
    acquire(&ptable.lock);
80105b75:	83 ec 0c             	sub    $0xc,%esp
80105b78:	68 00 66 11 80       	push   $0x80116600
80105b7d:	e8 8d 10 00 00       	call   80106c0f <acquire>
80105b82:	83 c4 10             	add    $0x10,%esp
    wakeup1(chan);
80105b85:	83 ec 0c             	sub    $0xc,%esp
80105b88:	ff 75 08             	pushl  0x8(%ebp)
80105b8b:	e8 09 ff ff ff       	call   80105a99 <wakeup1>
80105b90:	83 c4 10             	add    $0x10,%esp
    release(&ptable.lock);
80105b93:	83 ec 0c             	sub    $0xc,%esp
80105b96:	68 00 66 11 80       	push   $0x80116600
80105b9b:	e8 da 10 00 00       	call   80106c7a <release>
80105ba0:	83 c4 10             	add    $0x10,%esp
}
80105ba3:	90                   	nop
80105ba4:	c9                   	leave  
80105ba5:	c3                   	ret    

80105ba6 <kill>:
    return -1;
}
#else
int
kill(int pid)
{
80105ba6:	f3 0f 1e fb          	endbr32 
80105baa:	55                   	push   %ebp
80105bab:	89 e5                	mov    %esp,%ebp
80105bad:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;

    acquire(&ptable.lock);
80105bb0:	83 ec 0c             	sub    $0xc,%esp
80105bb3:	68 00 66 11 80       	push   $0x80116600
80105bb8:	e8 52 10 00 00       	call   80106c0f <acquire>
80105bbd:	83 c4 10             	add    $0x10,%esp
    // traverse Sleeping list, wake processes if necessary
    p = ptable.pLists.sleep;
80105bc0:	a1 44 8d 11 80       	mov    0x80118d44,%eax
80105bc5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105bc8:	e9 be 00 00 00       	jmp    80105c8b <kill+0xe5>
        if (p->pid == pid) {
80105bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bd0:	8b 50 10             	mov    0x10(%eax),%edx
80105bd3:	8b 45 08             	mov    0x8(%ebp),%eax
80105bd6:	39 c2                	cmp    %eax,%edx
80105bd8:	0f 85 a1 00 00 00    	jne    80105c7f <kill+0xd9>
            p->killed = 1;
80105bde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105be1:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            assertState(p, SLEEPING);
80105be8:	83 ec 08             	sub    $0x8,%esp
80105beb:	6a 02                	push   $0x2
80105bed:	ff 75 f4             	pushl  -0xc(%ebp)
80105bf0:	e8 e6 06 00 00       	call   801062db <assertState>
80105bf5:	83 c4 10             	add    $0x10,%esp
            if (removeFromStateList(&ptable.pLists.sleep, p) < 0) {
80105bf8:	83 ec 08             	sub    $0x8,%esp
80105bfb:	ff 75 f4             	pushl  -0xc(%ebp)
80105bfe:	68 44 8d 11 80       	push   $0x80118d44
80105c03:	e8 00 08 00 00       	call   80106408 <removeFromStateList>
80105c08:	83 c4 10             	add    $0x10,%esp
80105c0b:	85 c0                	test   %eax,%eax
80105c0d:	79 10                	jns    80105c1f <kill+0x79>
                cprintf("Could not remove SLEEPING proc from list (kill).\n");
80105c0f:	83 ec 0c             	sub    $0xc,%esp
80105c12:	68 58 ad 10 80       	push   $0x8010ad58
80105c17:	e8 c2 a7 ff ff       	call   801003de <cprintf>
80105c1c:	83 c4 10             	add    $0x10,%esp
            }
            p->state = RUNNABLE;
80105c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c22:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
            if (addToStateListEnd(&ptable.pLists.ready[p->priority], p) < 0) {
80105c29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c2c:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80105c32:	05 cc 09 00 00       	add    $0x9cc,%eax
80105c37:	c1 e0 02             	shl    $0x2,%eax
80105c3a:	05 00 66 11 80       	add    $0x80116600,%eax
80105c3f:	83 c0 04             	add    $0x4,%eax
80105c42:	83 ec 08             	sub    $0x8,%esp
80105c45:	ff 75 f4             	pushl  -0xc(%ebp)
80105c48:	50                   	push   %eax
80105c49:	e8 35 07 00 00       	call   80106383 <addToStateListEnd>
80105c4e:	83 c4 10             	add    $0x10,%esp
80105c51:	85 c0                	test   %eax,%eax
80105c53:	79 10                	jns    80105c65 <kill+0xbf>
                cprintf("Could not add RUNNABLE proc to list (kill).\n");
80105c55:	83 ec 0c             	sub    $0xc,%esp
80105c58:	68 8c ad 10 80       	push   $0x8010ad8c
80105c5d:	e8 7c a7 ff ff       	call   801003de <cprintf>
80105c62:	83 c4 10             	add    $0x10,%esp
            }
            release(&ptable.lock);
80105c65:	83 ec 0c             	sub    $0xc,%esp
80105c68:	68 00 66 11 80       	push   $0x80116600
80105c6d:	e8 08 10 00 00       	call   80106c7a <release>
80105c72:	83 c4 10             	add    $0x10,%esp
            return 0;
80105c75:	b8 00 00 00 00       	mov    $0x0,%eax
80105c7a:	e9 c3 01 00 00       	jmp    80105e42 <kill+0x29c>
        }
        p = p->next;
80105c7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c82:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105c88:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105c8b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105c8f:	0f 85 38 ff ff ff    	jne    80105bcd <kill+0x27>
    }

    // traverse Runnable list
    for (int i = 0; i <= MAX; ++i) {
80105c95:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80105c9c:	eb 5b                	jmp    80105cf9 <kill+0x153>
        p = ptable.pLists.ready[i];
80105c9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ca1:	05 cc 09 00 00       	add    $0x9cc,%eax
80105ca6:	8b 04 85 04 66 11 80 	mov    -0x7fee99fc(,%eax,4),%eax
80105cad:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (p) {
80105cb0:	eb 3d                	jmp    80105cef <kill+0x149>
            if (p->pid == pid) {
80105cb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cb5:	8b 50 10             	mov    0x10(%eax),%edx
80105cb8:	8b 45 08             	mov    0x8(%ebp),%eax
80105cbb:	39 c2                	cmp    %eax,%edx
80105cbd:	75 24                	jne    80105ce3 <kill+0x13d>
                p->killed = 1;
80105cbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cc2:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
                release(&ptable.lock);
80105cc9:	83 ec 0c             	sub    $0xc,%esp
80105ccc:	68 00 66 11 80       	push   $0x80116600
80105cd1:	e8 a4 0f 00 00       	call   80106c7a <release>
80105cd6:	83 c4 10             	add    $0x10,%esp
                return 0;
80105cd9:	b8 00 00 00 00       	mov    $0x0,%eax
80105cde:	e9 5f 01 00 00       	jmp    80105e42 <kill+0x29c>
            }
            p = p->next;
80105ce3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ce6:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105cec:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (p) {
80105cef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105cf3:	75 bd                	jne    80105cb2 <kill+0x10c>
    for (int i = 0; i <= MAX; ++i) {
80105cf5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80105cf9:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
80105cfd:	7e 9f                	jle    80105c9e <kill+0xf8>
        }
    }

    // traverse Running list
    p = ptable.pLists.running;
80105cff:	a1 4c 8d 11 80       	mov    0x80118d4c,%eax
80105d04:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105d07:	eb 3d                	jmp    80105d46 <kill+0x1a0>
        if (p->pid == pid) {
80105d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d0c:	8b 50 10             	mov    0x10(%eax),%edx
80105d0f:	8b 45 08             	mov    0x8(%ebp),%eax
80105d12:	39 c2                	cmp    %eax,%edx
80105d14:	75 24                	jne    80105d3a <kill+0x194>
            p->killed = 1;
80105d16:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d19:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            release(&ptable.lock);
80105d20:	83 ec 0c             	sub    $0xc,%esp
80105d23:	68 00 66 11 80       	push   $0x80116600
80105d28:	e8 4d 0f 00 00       	call   80106c7a <release>
80105d2d:	83 c4 10             	add    $0x10,%esp
            return 0;
80105d30:	b8 00 00 00 00       	mov    $0x0,%eax
80105d35:	e9 08 01 00 00       	jmp    80105e42 <kill+0x29c>
        }
        p = p->next;
80105d3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d3d:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105d43:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105d46:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d4a:	75 bd                	jne    80105d09 <kill+0x163>
    }

    // traverse Unused List
    p = ptable.pLists.free;
80105d4c:	a1 40 8d 11 80       	mov    0x80118d40,%eax
80105d51:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105d54:	eb 3d                	jmp    80105d93 <kill+0x1ed>
        if (p->pid == pid) {
80105d56:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d59:	8b 50 10             	mov    0x10(%eax),%edx
80105d5c:	8b 45 08             	mov    0x8(%ebp),%eax
80105d5f:	39 c2                	cmp    %eax,%edx
80105d61:	75 24                	jne    80105d87 <kill+0x1e1>
            p->killed = 1;
80105d63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d66:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            release(&ptable.lock);
80105d6d:	83 ec 0c             	sub    $0xc,%esp
80105d70:	68 00 66 11 80       	push   $0x80116600
80105d75:	e8 00 0f 00 00       	call   80106c7a <release>
80105d7a:	83 c4 10             	add    $0x10,%esp
            return 0;
80105d7d:	b8 00 00 00 00       	mov    $0x0,%eax
80105d82:	e9 bb 00 00 00       	jmp    80105e42 <kill+0x29c>
        }
        p = p->next;
80105d87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d8a:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105d90:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105d93:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d97:	75 bd                	jne    80105d56 <kill+0x1b0>
    }

    // traverse Zombie list
    p = ptable.pLists.zombie;
80105d99:	a1 48 8d 11 80       	mov    0x80118d48,%eax
80105d9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105da1:	eb 3a                	jmp    80105ddd <kill+0x237>
        if (p->pid == pid) {
80105da3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105da6:	8b 50 10             	mov    0x10(%eax),%edx
80105da9:	8b 45 08             	mov    0x8(%ebp),%eax
80105dac:	39 c2                	cmp    %eax,%edx
80105dae:	75 21                	jne    80105dd1 <kill+0x22b>
            p->killed = 1;
80105db0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105db3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            release(&ptable.lock);
80105dba:	83 ec 0c             	sub    $0xc,%esp
80105dbd:	68 00 66 11 80       	push   $0x80116600
80105dc2:	e8 b3 0e 00 00       	call   80106c7a <release>
80105dc7:	83 c4 10             	add    $0x10,%esp
            return 0;
80105dca:	b8 00 00 00 00       	mov    $0x0,%eax
80105dcf:	eb 71                	jmp    80105e42 <kill+0x29c>
        }
        p = p->next;
80105dd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dd4:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105dda:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105ddd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105de1:	75 c0                	jne    80105da3 <kill+0x1fd>
    }

    // traverse Embryo list
    p = ptable.pLists.embryo;
80105de3:	a1 50 8d 11 80       	mov    0x80118d50,%eax
80105de8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105deb:	eb 3a                	jmp    80105e27 <kill+0x281>
        if (p->pid == pid) {
80105ded:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105df0:	8b 50 10             	mov    0x10(%eax),%edx
80105df3:	8b 45 08             	mov    0x8(%ebp),%eax
80105df6:	39 c2                	cmp    %eax,%edx
80105df8:	75 21                	jne    80105e1b <kill+0x275>
            p->killed = 1;
80105dfa:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dfd:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            release(&ptable.lock);
80105e04:	83 ec 0c             	sub    $0xc,%esp
80105e07:	68 00 66 11 80       	push   $0x80116600
80105e0c:	e8 69 0e 00 00       	call   80106c7a <release>
80105e11:	83 c4 10             	add    $0x10,%esp
            return 0;
80105e14:	b8 00 00 00 00       	mov    $0x0,%eax
80105e19:	eb 27                	jmp    80105e42 <kill+0x29c>
        }
        p = p->next;
80105e1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e1e:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80105e24:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80105e27:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105e2b:	75 c0                	jne    80105ded <kill+0x247>
    }

    // return error
    release(&ptable.lock);
80105e2d:	83 ec 0c             	sub    $0xc,%esp
80105e30:	68 00 66 11 80       	push   $0x80116600
80105e35:	e8 40 0e 00 00       	call   80106c7a <release>
80105e3a:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e42:	c9                   	leave  
80105e43:	c3                   	ret    

80105e44 <elapsed_time>:
// No lock to avoid wedging a stuck machine further.

#ifdef BAGIAN_ID
void
elapsed_time(uint p_ticks)
{
80105e44:	f3 0f 1e fb          	endbr32 
80105e48:	55                   	push   %ebp
80105e49:	89 e5                	mov    %esp,%ebp
80105e4b:	83 ec 28             	sub    $0x28,%esp
    uint elapsed, whole_sec, milisec_ten, milisec_hund, milisec_thou;
    //elapsed = ticks - p->start_ticks; // find original elapsed time
    elapsed = p_ticks;
80105e4e:	8b 45 08             	mov    0x8(%ebp),%eax
80105e51:	89 45 f4             	mov    %eax,-0xc(%ebp)
    whole_sec = (elapsed / 1000); // the the left of the decimal point
80105e54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e57:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
80105e5c:	f7 e2                	mul    %edx
80105e5e:	89 d0                	mov    %edx,%eax
80105e60:	c1 e8 06             	shr    $0x6,%eax
80105e63:	89 45 f0             	mov    %eax,-0x10(%ebp)
    // % to shave off leading digit of elapsed for decimal place calcs
    milisec_ten = ((elapsed %= 1000) / 100); // divide and round up to nearest int
80105e66:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80105e69:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
80105e6e:	89 c8                	mov    %ecx,%eax
80105e70:	f7 e2                	mul    %edx
80105e72:	89 d0                	mov    %edx,%eax
80105e74:	c1 e8 06             	shr    $0x6,%eax
80105e77:	69 c0 e8 03 00 00    	imul   $0x3e8,%eax,%eax
80105e7d:	29 c1                	sub    %eax,%ecx
80105e7f:	89 c8                	mov    %ecx,%eax
80105e81:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105e84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e87:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
80105e8c:	f7 e2                	mul    %edx
80105e8e:	89 d0                	mov    %edx,%eax
80105e90:	c1 e8 05             	shr    $0x5,%eax
80105e93:	89 45 ec             	mov    %eax,-0x14(%ebp)
    milisec_hund = ((elapsed %= 100) / 10); // shave off previously counted int, repeat
80105e96:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80105e99:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
80105e9e:	89 c8                	mov    %ecx,%eax
80105ea0:	f7 e2                	mul    %edx
80105ea2:	89 d0                	mov    %edx,%eax
80105ea4:	c1 e8 05             	shr    $0x5,%eax
80105ea7:	6b c0 64             	imul   $0x64,%eax,%eax
80105eaa:	29 c1                	sub    %eax,%ecx
80105eac:	89 c8                	mov    %ecx,%eax
80105eae:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105eb1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105eb4:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80105eb9:	f7 e2                	mul    %edx
80105ebb:	89 d0                	mov    %edx,%eax
80105ebd:	c1 e8 03             	shr    $0x3,%eax
80105ec0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    milisec_thou = (elapsed %= 10); // determine thousandth place
80105ec3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80105ec6:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80105ecb:	89 c8                	mov    %ecx,%eax
80105ecd:	f7 e2                	mul    %edx
80105ecf:	c1 ea 03             	shr    $0x3,%edx
80105ed2:	89 d0                	mov    %edx,%eax
80105ed4:	c1 e0 02             	shl    $0x2,%eax
80105ed7:	01 d0                	add    %edx,%eax
80105ed9:	01 c0                	add    %eax,%eax
80105edb:	29 c1                	sub    %eax,%ecx
80105edd:	89 c8                	mov    %ecx,%eax
80105edf:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105ee2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ee5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    cprintf("\t%d.%d%d%d", whole_sec, milisec_ten, milisec_hund, milisec_thou);
80105ee8:	83 ec 0c             	sub    $0xc,%esp
80105eeb:	ff 75 e4             	pushl  -0x1c(%ebp)
80105eee:	ff 75 e8             	pushl  -0x18(%ebp)
80105ef1:	ff 75 ec             	pushl  -0x14(%ebp)
80105ef4:	ff 75 f0             	pushl  -0x10(%ebp)
80105ef7:	68 b9 ad 10 80       	push   $0x8010adb9
80105efc:	e8 dd a4 ff ff       	call   801003de <cprintf>
80105f01:	83 c4 20             	add    $0x20,%esp
}
80105f04:	90                   	nop
80105f05:	c9                   	leave  
80105f06:	c3                   	ret    

80105f07 <procdump>:
#else

// Project 3 & 4
void
procdump(void)
{
80105f07:	f3 0f 1e fb          	endbr32 
80105f0b:	55                   	push   %ebp
80105f0c:	89 e5                	mov    %esp,%ebp
80105f0e:	56                   	push   %esi
80105f0f:	53                   	push   %ebx
80105f10:	83 ec 40             	sub    $0x40,%esp
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    cprintf("\n%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n",
80105f13:	68 c4 ad 10 80       	push   $0x8010adc4
80105f18:	68 c8 ad 10 80       	push   $0x8010adc8
80105f1d:	68 cd ad 10 80       	push   $0x8010adcd
80105f22:	68 d3 ad 10 80       	push   $0x8010add3
80105f27:	68 d7 ad 10 80       	push   $0x8010add7
80105f2c:	68 df ad 10 80       	push   $0x8010addf
80105f31:	68 e4 ad 10 80       	push   $0x8010ade4
80105f36:	68 e9 ad 10 80       	push   $0x8010ade9
80105f3b:	68 ed ad 10 80       	push   $0x8010aded
80105f40:	68 f1 ad 10 80       	push   $0x8010adf1
80105f45:	68 f6 ad 10 80       	push   $0x8010adf6
80105f4a:	68 fc ad 10 80       	push   $0x8010adfc
80105f4f:	e8 8a a4 ff ff       	call   801003de <cprintf>
80105f54:	83 c4 30             	add    $0x30,%esp
            "PID", "Name", "UID", "GID", "PPID", "Prio", "Elapsed", "CPU", "State", "Size", "PCs");

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105f57:	c7 45 f0 34 66 11 80 	movl   $0x80116634,-0x10(%ebp)
80105f5e:	e9 5c 01 00 00       	jmp    801060bf <procdump+0x1b8>
        if(p->state == UNUSED)
80105f63:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f66:	8b 40 0c             	mov    0xc(%eax),%eax
80105f69:	85 c0                	test   %eax,%eax
80105f6b:	0f 84 46 01 00 00    	je     801060b7 <procdump+0x1b0>
            continue;
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105f71:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f74:	8b 40 0c             	mov    0xc(%eax),%eax
80105f77:	83 f8 05             	cmp    $0x5,%eax
80105f7a:	77 23                	ja     80105f9f <procdump+0x98>
80105f7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f7f:	8b 40 0c             	mov    0xc(%eax),%eax
80105f82:	8b 04 85 08 e0 10 80 	mov    -0x7fef1ff8(,%eax,4),%eax
80105f89:	85 c0                	test   %eax,%eax
80105f8b:	74 12                	je     80105f9f <procdump+0x98>
            state = states[p->state];
80105f8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f90:	8b 40 0c             	mov    0xc(%eax),%eax
80105f93:	8b 04 85 08 e0 10 80 	mov    -0x7fef1ff8(,%eax,4),%eax
80105f9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105f9d:	eb 07                	jmp    80105fa6 <procdump+0x9f>
        else
            state = "???";
80105f9f:	c7 45 ec 1f ae 10 80 	movl   $0x8010ae1f,-0x14(%ebp)
        cprintf("%d\t%s\t%d\t%d\t%d",
                p->pid, p->name, p->uid, p->gid, p->parent->pid);
80105fa6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fa9:	8b 40 14             	mov    0x14(%eax),%eax
        cprintf("%d\t%s\t%d\t%d\t%d",
80105fac:	8b 58 10             	mov    0x10(%eax),%ebx
80105faf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fb2:	8b 88 84 00 00 00    	mov    0x84(%eax),%ecx
80105fb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fbb:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
                p->pid, p->name, p->uid, p->gid, p->parent->pid);
80105fc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fc4:	8d 70 6c             	lea    0x6c(%eax),%esi
        cprintf("%d\t%s\t%d\t%d\t%d",
80105fc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fca:	8b 40 10             	mov    0x10(%eax),%eax
80105fcd:	83 ec 08             	sub    $0x8,%esp
80105fd0:	53                   	push   %ebx
80105fd1:	51                   	push   %ecx
80105fd2:	52                   	push   %edx
80105fd3:	56                   	push   %esi
80105fd4:	50                   	push   %eax
80105fd5:	68 23 ae 10 80       	push   $0x8010ae23
80105fda:	e8 ff a3 ff ff       	call   801003de <cprintf>
80105fdf:	83 c4 20             	add    $0x20,%esp
        cprintf("\t%d", p->priority);
80105fe2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fe5:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80105feb:	83 ec 08             	sub    $0x8,%esp
80105fee:	50                   	push   %eax
80105fef:	68 32 ae 10 80       	push   $0x8010ae32
80105ff4:	e8 e5 a3 ff ff       	call   801003de <cprintf>
80105ff9:	83 c4 10             	add    $0x10,%esp
        elapsed_time(ticks - p->start_ticks);
80105ffc:	8b 15 60 95 11 80    	mov    0x80119560,%edx
80106002:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106005:	8b 40 7c             	mov    0x7c(%eax),%eax
80106008:	29 c2                	sub    %eax,%edx
8010600a:	89 d0                	mov    %edx,%eax
8010600c:	83 ec 0c             	sub    $0xc,%esp
8010600f:	50                   	push   %eax
80106010:	e8 2f fe ff ff       	call   80105e44 <elapsed_time>
80106015:	83 c4 10             	add    $0x10,%esp
        elapsed_time(p->cpu_ticks_total);
80106018:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010601b:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
80106021:	83 ec 0c             	sub    $0xc,%esp
80106024:	50                   	push   %eax
80106025:	e8 1a fe ff ff       	call   80105e44 <elapsed_time>
8010602a:	83 c4 10             	add    $0x10,%esp
        cprintf("\t%s\t%d", state, p->sz);
8010602d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106030:	8b 00                	mov    (%eax),%eax
80106032:	83 ec 04             	sub    $0x4,%esp
80106035:	50                   	push   %eax
80106036:	ff 75 ec             	pushl  -0x14(%ebp)
80106039:	68 36 ae 10 80       	push   $0x8010ae36
8010603e:	e8 9b a3 ff ff       	call   801003de <cprintf>
80106043:	83 c4 10             	add    $0x10,%esp

        if(p->state == SLEEPING){
80106046:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106049:	8b 40 0c             	mov    0xc(%eax),%eax
8010604c:	83 f8 02             	cmp    $0x2,%eax
8010604f:	75 54                	jne    801060a5 <procdump+0x19e>
            getcallerpcs((uint*)p->context->ebp+2, pc);
80106051:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106054:	8b 40 1c             	mov    0x1c(%eax),%eax
80106057:	8b 40 0c             	mov    0xc(%eax),%eax
8010605a:	83 c0 08             	add    $0x8,%eax
8010605d:	89 c2                	mov    %eax,%edx
8010605f:	83 ec 08             	sub    $0x8,%esp
80106062:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106065:	50                   	push   %eax
80106066:	52                   	push   %edx
80106067:	e8 64 0c 00 00       	call   80106cd0 <getcallerpcs>
8010606c:	83 c4 10             	add    $0x10,%esp
            for(i=0; i<10 && pc[i] != 0; i++)
8010606f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106076:	eb 1c                	jmp    80106094 <procdump+0x18d>
                cprintf("\t%p", pc[i]);
80106078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010607b:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
8010607f:	83 ec 08             	sub    $0x8,%esp
80106082:	50                   	push   %eax
80106083:	68 3d ae 10 80       	push   $0x8010ae3d
80106088:	e8 51 a3 ff ff       	call   801003de <cprintf>
8010608d:	83 c4 10             	add    $0x10,%esp
            for(i=0; i<10 && pc[i] != 0; i++)
80106090:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106094:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80106098:	7f 0b                	jg     801060a5 <procdump+0x19e>
8010609a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010609d:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801060a1:	85 c0                	test   %eax,%eax
801060a3:	75 d3                	jne    80106078 <procdump+0x171>
        }
        cprintf("\n");
801060a5:	83 ec 0c             	sub    $0xc,%esp
801060a8:	68 41 ae 10 80       	push   $0x8010ae41
801060ad:	e8 2c a3 ff ff       	call   801003de <cprintf>
801060b2:	83 c4 10             	add    $0x10,%esp
801060b5:	eb 01                	jmp    801060b8 <procdump+0x1b1>
            continue;
801060b7:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801060b8:	81 45 f0 9c 00 00 00 	addl   $0x9c,-0x10(%ebp)
801060bf:	81 7d f0 34 8d 11 80 	cmpl   $0x80118d34,-0x10(%ebp)
801060c6:	0f 82 97 fe ff ff    	jb     80105f63 <procdump+0x5c>
    }
}
801060cc:	90                   	nop
801060cd:	90                   	nop
801060ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801060d1:	5b                   	pop    %ebx
801060d2:	5e                   	pop    %esi
801060d3:	5d                   	pop    %ebp
801060d4:	c3                   	ret    

801060d5 <getprocs>:
#ifdef BAGIAN_UPROC
// loop process table and copy active processes, return number of copied procs
// populate uproc array passed in from ps.c
int
getprocs(uint max, struct uproc *table)
{
801060d5:	f3 0f 1e fb          	endbr32 
801060d9:	55                   	push   %ebp
801060da:	89 e5                	mov    %esp,%ebp
801060dc:	53                   	push   %ebx
801060dd:	83 ec 14             	sub    $0x14,%esp
    int i = 0;
801060e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    struct proc *p;
    acquire(&ptable.lock);
801060e7:	83 ec 0c             	sub    $0xc,%esp
801060ea:	68 00 66 11 80       	push   $0x80116600
801060ef:	e8 1b 0b 00 00       	call   80106c0f <acquire>
801060f4:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC] && i < max; p++) {
801060f7:	c7 45 f0 34 66 11 80 	movl   $0x80116634,-0x10(%ebp)
801060fe:	e9 ab 01 00 00       	jmp    801062ae <getprocs+0x1d9>
        // only copy active processes
        if (p->state == RUNNABLE || p->state == RUNNING || p->state == SLEEPING) {
80106103:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106106:	8b 40 0c             	mov    0xc(%eax),%eax
80106109:	83 f8 03             	cmp    $0x3,%eax
8010610c:	74 1a                	je     80106128 <getprocs+0x53>
8010610e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106111:	8b 40 0c             	mov    0xc(%eax),%eax
80106114:	83 f8 04             	cmp    $0x4,%eax
80106117:	74 0f                	je     80106128 <getprocs+0x53>
80106119:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010611c:	8b 40 0c             	mov    0xc(%eax),%eax
8010611f:	83 f8 02             	cmp    $0x2,%eax
80106122:	0f 85 7f 01 00 00    	jne    801062a7 <getprocs+0x1d2>
            table[i].pid = p->pid;
80106128:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010612b:	89 d0                	mov    %edx,%eax
8010612d:	01 c0                	add    %eax,%eax
8010612f:	01 d0                	add    %edx,%eax
80106131:	c1 e0 05             	shl    $0x5,%eax
80106134:	89 c2                	mov    %eax,%edx
80106136:	8b 45 0c             	mov    0xc(%ebp),%eax
80106139:	01 c2                	add    %eax,%edx
8010613b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010613e:	8b 40 10             	mov    0x10(%eax),%eax
80106141:	89 02                	mov    %eax,(%edx)
            table[i].uid = p->uid;
80106143:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106146:	89 d0                	mov    %edx,%eax
80106148:	01 c0                	add    %eax,%eax
8010614a:	01 d0                	add    %edx,%eax
8010614c:	c1 e0 05             	shl    $0x5,%eax
8010614f:	89 c2                	mov    %eax,%edx
80106151:	8b 45 0c             	mov    0xc(%ebp),%eax
80106154:	01 c2                	add    %eax,%edx
80106156:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106159:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
8010615f:	89 42 04             	mov    %eax,0x4(%edx)
            table[i].gid = p->gid;
80106162:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106165:	89 d0                	mov    %edx,%eax
80106167:	01 c0                	add    %eax,%eax
80106169:	01 d0                	add    %edx,%eax
8010616b:	c1 e0 05             	shl    $0x5,%eax
8010616e:	89 c2                	mov    %eax,%edx
80106170:	8b 45 0c             	mov    0xc(%ebp),%eax
80106173:	01 c2                	add    %eax,%edx
80106175:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106178:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
8010617e:	89 42 08             	mov    %eax,0x8(%edx)
            if (p->pid == 1) {
80106181:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106184:	8b 40 10             	mov    0x10(%eax),%eax
80106187:	83 f8 01             	cmp    $0x1,%eax
8010618a:	75 1c                	jne    801061a8 <getprocs+0xd3>
                table[i].ppid = 1;
8010618c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010618f:	89 d0                	mov    %edx,%eax
80106191:	01 c0                	add    %eax,%eax
80106193:	01 d0                	add    %edx,%eax
80106195:	c1 e0 05             	shl    $0x5,%eax
80106198:	89 c2                	mov    %eax,%edx
8010619a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010619d:	01 d0                	add    %edx,%eax
8010619f:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
801061a6:	eb 1f                	jmp    801061c7 <getprocs+0xf2>
            } else {
                table[i].ppid = p->parent->pid;
801061a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061ab:	8b 48 14             	mov    0x14(%eax),%ecx
801061ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061b1:	89 d0                	mov    %edx,%eax
801061b3:	01 c0                	add    %eax,%eax
801061b5:	01 d0                	add    %edx,%eax
801061b7:	c1 e0 05             	shl    $0x5,%eax
801061ba:	89 c2                	mov    %eax,%edx
801061bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801061bf:	01 c2                	add    %eax,%edx
801061c1:	8b 41 10             	mov    0x10(%ecx),%eax
801061c4:	89 42 0c             	mov    %eax,0xc(%edx)
            }
#ifdef BAGIAN_INODE
            table[i].priority = p->priority;
801061c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061ca:	89 d0                	mov    %edx,%eax
801061cc:	01 c0                	add    %eax,%eax
801061ce:	01 d0                	add    %edx,%eax
801061d0:	c1 e0 05             	shl    $0x5,%eax
801061d3:	89 c2                	mov    %eax,%edx
801061d5:	8b 45 0c             	mov    0xc(%ebp),%eax
801061d8:	01 c2                	add    %eax,%edx
801061da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061dd:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
801061e3:	89 42 5c             	mov    %eax,0x5c(%edx)
#endif
            table[i].elapsed_ticks = (ticks - p->start_ticks);
801061e6:	8b 1d 60 95 11 80    	mov    0x80119560,%ebx
801061ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061ef:	8b 48 7c             	mov    0x7c(%eax),%ecx
801061f2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061f5:	89 d0                	mov    %edx,%eax
801061f7:	01 c0                	add    %eax,%eax
801061f9:	01 d0                	add    %edx,%eax
801061fb:	c1 e0 05             	shl    $0x5,%eax
801061fe:	89 c2                	mov    %eax,%edx
80106200:	8b 45 0c             	mov    0xc(%ebp),%eax
80106203:	01 d0                	add    %edx,%eax
80106205:	29 cb                	sub    %ecx,%ebx
80106207:	89 da                	mov    %ebx,%edx
80106209:	89 50 10             	mov    %edx,0x10(%eax)
            table[i].CPU_total_ticks = p->cpu_ticks_total;
8010620c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010620f:	89 d0                	mov    %edx,%eax
80106211:	01 c0                	add    %eax,%eax
80106213:	01 d0                	add    %edx,%eax
80106215:	c1 e0 05             	shl    $0x5,%eax
80106218:	89 c2                	mov    %eax,%edx
8010621a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010621d:	01 c2                	add    %eax,%edx
8010621f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106222:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
80106228:	89 42 14             	mov    %eax,0x14(%edx)
            safestrcpy(table[i].state, states[p->state], STRMAX);
8010622b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010622e:	8b 40 0c             	mov    0xc(%eax),%eax
80106231:	8b 0c 85 08 e0 10 80 	mov    -0x7fef1ff8(,%eax,4),%ecx
80106238:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010623b:	89 d0                	mov    %edx,%eax
8010623d:	01 c0                	add    %eax,%eax
8010623f:	01 d0                	add    %edx,%eax
80106241:	c1 e0 05             	shl    $0x5,%eax
80106244:	89 c2                	mov    %eax,%edx
80106246:	8b 45 0c             	mov    0xc(%ebp),%eax
80106249:	01 d0                	add    %edx,%eax
8010624b:	83 c0 18             	add    $0x18,%eax
8010624e:	83 ec 04             	sub    $0x4,%esp
80106251:	6a 20                	push   $0x20
80106253:	51                   	push   %ecx
80106254:	50                   	push   %eax
80106255:	e8 4c 0e 00 00       	call   801070a6 <safestrcpy>
8010625a:	83 c4 10             	add    $0x10,%esp
            table[i].size = p->sz;
8010625d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106260:	89 d0                	mov    %edx,%eax
80106262:	01 c0                	add    %eax,%eax
80106264:	01 d0                	add    %edx,%eax
80106266:	c1 e0 05             	shl    $0x5,%eax
80106269:	89 c2                	mov    %eax,%edx
8010626b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010626e:	01 c2                	add    %eax,%edx
80106270:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106273:	8b 00                	mov    (%eax),%eax
80106275:	89 42 38             	mov    %eax,0x38(%edx)
            safestrcpy(table[i].name, p->name, STRMAX);
80106278:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010627b:	8d 48 6c             	lea    0x6c(%eax),%ecx
8010627e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106281:	89 d0                	mov    %edx,%eax
80106283:	01 c0                	add    %eax,%eax
80106285:	01 d0                	add    %edx,%eax
80106287:	c1 e0 05             	shl    $0x5,%eax
8010628a:	89 c2                	mov    %eax,%edx
8010628c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010628f:	01 d0                	add    %edx,%eax
80106291:	83 c0 3c             	add    $0x3c,%eax
80106294:	83 ec 04             	sub    $0x4,%esp
80106297:	6a 20                	push   $0x20
80106299:	51                   	push   %ecx
8010629a:	50                   	push   %eax
8010629b:	e8 06 0e 00 00       	call   801070a6 <safestrcpy>
801062a0:	83 c4 10             	add    $0x10,%esp
            ++i;
801062a3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC] && i < max; p++) {
801062a7:	81 45 f0 9c 00 00 00 	addl   $0x9c,-0x10(%ebp)
801062ae:	81 7d f0 34 8d 11 80 	cmpl   $0x80118d34,-0x10(%ebp)
801062b5:	73 0c                	jae    801062c3 <getprocs+0x1ee>
801062b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062ba:	39 45 08             	cmp    %eax,0x8(%ebp)
801062bd:	0f 87 40 fe ff ff    	ja     80106103 <getprocs+0x2e>
        }
    }
    release(&ptable.lock);
801062c3:	83 ec 0c             	sub    $0xc,%esp
801062c6:	68 00 66 11 80       	push   $0x80116600
801062cb:	e8 aa 09 00 00       	call   80106c7a <release>
801062d0:	83 c4 10             	add    $0x10,%esp
    return i; // return number of procs copied
801062d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801062d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801062d9:	c9                   	leave  
801062da:	c3                   	ret    

801062db <assertState>:


//PROJECT 3
// assert that process is in proper state, otherwise panic
static void
assertState(struct proc* p, enum procstate state) {
801062db:	f3 0f 1e fb          	endbr32 
801062df:	55                   	push   %ebp
801062e0:	89 e5                	mov    %esp,%ebp
801062e2:	83 ec 08             	sub    $0x8,%esp
    if (!p) {
801062e5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801062e9:	75 0d                	jne    801062f8 <assertState+0x1d>
        panic("assertState: invalid proc argument.\n");
801062eb:	83 ec 0c             	sub    $0xc,%esp
801062ee:	68 44 ae 10 80       	push   $0x8010ae44
801062f3:	e8 9f a2 ff ff       	call   80100597 <panic>
    }
    if (p->state != state) {
801062f8:	8b 45 08             	mov    0x8(%ebp),%eax
801062fb:	8b 40 0c             	mov    0xc(%eax),%eax
801062fe:	39 45 0c             	cmp    %eax,0xc(%ebp)
80106301:	74 0d                	je     80106310 <assertState+0x35>
        panic("assertState: process in wrong state.\n");
80106303:	83 ec 0c             	sub    $0xc,%esp
80106306:	68 6c ae 10 80       	push   $0x8010ae6c
8010630b:	e8 87 a2 ff ff       	call   80100597 <panic>
    }
}
80106310:	90                   	nop
80106311:	c9                   	leave  
80106312:	c3                   	ret    

80106313 <addToStateListHead>:

static int
addToStateListHead(struct proc** sList, struct proc* p) {
80106313:	f3 0f 1e fb          	endbr32 
80106317:	55                   	push   %ebp
80106318:	89 e5                	mov    %esp,%ebp
8010631a:	83 ec 08             	sub    $0x8,%esp
    if (!p) {
8010631d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80106321:	75 0d                	jne    80106330 <addToStateListHead+0x1d>
        panic("Invalid process.");
80106323:	83 ec 0c             	sub    $0xc,%esp
80106326:	68 92 ae 10 80       	push   $0x8010ae92
8010632b:	e8 67 a2 ff ff       	call   80100597 <panic>
    }
    if (!(*sList)) { // if no list exists, make first entry
80106330:	8b 45 08             	mov    0x8(%ebp),%eax
80106333:	8b 00                	mov    (%eax),%eax
80106335:	85 c0                	test   %eax,%eax
80106337:	75 1c                	jne    80106355 <addToStateListHead+0x42>
        (*sList) = p; // arg proc is now the first item in list
80106339:	8b 45 08             	mov    0x8(%ebp),%eax
8010633c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010633f:	89 10                	mov    %edx,(%eax)
        p->next = 0; // next is null
80106341:	8b 45 0c             	mov    0xc(%ebp),%eax
80106344:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
8010634b:	00 00 00 
        return 0; // return success
8010634e:	b8 00 00 00 00       	mov    $0x0,%eax
80106353:	eb 2c                	jmp    80106381 <addToStateListHead+0x6e>
    }
    // otherwise hold to next element and become 1st element
    p->next = (*sList); // arg proc has next element
80106355:	8b 45 08             	mov    0x8(%ebp),%eax
80106358:	8b 10                	mov    (%eax),%edx
8010635a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010635d:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
    (*sList) = p; // reassign head of list to arg proc
80106363:	8b 45 08             	mov    0x8(%ebp),%eax
80106366:	8b 55 0c             	mov    0xc(%ebp),%edx
80106369:	89 10                	mov    %edx,(%eax)
    if (p != (*sList)) {
8010636b:	8b 45 08             	mov    0x8(%ebp),%eax
8010636e:	8b 00                	mov    (%eax),%eax
80106370:	39 45 0c             	cmp    %eax,0xc(%ebp)
80106373:	74 07                	je     8010637c <addToStateListHead+0x69>
        return -1; // if they don't match, return failure
80106375:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010637a:	eb 05                	jmp    80106381 <addToStateListHead+0x6e>
    }
    return 0; // return success
8010637c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106381:	c9                   	leave  
80106382:	c3                   	ret    

80106383 <addToStateListEnd>:

static int
addToStateListEnd(struct proc** sList, struct proc* p) {
80106383:	f3 0f 1e fb          	endbr32 
80106387:	55                   	push   %ebp
80106388:	89 e5                	mov    %esp,%ebp
8010638a:	83 ec 18             	sub    $0x18,%esp
    if (!p) {
8010638d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80106391:	75 0d                	jne    801063a0 <addToStateListEnd+0x1d>
        panic("Invalid process.");
80106393:	83 ec 0c             	sub    $0xc,%esp
80106396:	68 92 ae 10 80       	push   $0x8010ae92
8010639b:	e8 f7 a1 ff ff       	call   80100597 <panic>
    }
    // if list desn't exist yet, initialize
    if (!(*sList)) {
801063a0:	8b 45 08             	mov    0x8(%ebp),%eax
801063a3:	8b 00                	mov    (%eax),%eax
801063a5:	85 c0                	test   %eax,%eax
801063a7:	75 1c                	jne    801063c5 <addToStateListEnd+0x42>
        (*sList) = p;
801063a9:	8b 45 08             	mov    0x8(%ebp),%eax
801063ac:	8b 55 0c             	mov    0xc(%ebp),%edx
801063af:	89 10                	mov    %edx,(%eax)
        p->next = 0;
801063b1:	8b 45 0c             	mov    0xc(%ebp),%eax
801063b4:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
801063bb:	00 00 00 
        return 0;
801063be:	b8 00 00 00 00       	mov    $0x0,%eax
801063c3:	eb 41                	jmp    80106406 <addToStateListEnd+0x83>
    }
    // otherwise traverse and add at the end
    struct proc * current = (*sList);
801063c5:	8b 45 08             	mov    0x8(%ebp),%eax
801063c8:	8b 00                	mov    (%eax),%eax
801063ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (current->next) {
801063cd:	eb 0c                	jmp    801063db <addToStateListEnd+0x58>
        current = current->next;
801063cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063d2:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801063d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (current->next) {
801063db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063de:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801063e4:	85 c0                	test   %eax,%eax
801063e6:	75 e7                	jne    801063cf <addToStateListEnd+0x4c>
    }
    current->next = p;
801063e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063eb:	8b 55 0c             	mov    0xc(%ebp),%edx
801063ee:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
    p->next = 0;
801063f4:	8b 45 0c             	mov    0xc(%ebp),%eax
801063f7:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
801063fe:	00 00 00 
    return 0;
80106401:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106406:	c9                   	leave  
80106407:	c3                   	ret    

80106408 <removeFromStateList>:

// search and remove process based on pointer address
static int
removeFromStateList(struct proc** sList, struct proc* p) {
80106408:	f3 0f 1e fb          	endbr32 
8010640c:	55                   	push   %ebp
8010640d:	89 e5                	mov    %esp,%ebp
8010640f:	83 ec 18             	sub    $0x18,%esp
    if (!p) {
80106412:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80106416:	75 0d                	jne    80106425 <removeFromStateList+0x1d>
        panic("Invalid process structures.");
80106418:	83 ec 0c             	sub    $0xc,%esp
8010641b:	68 a3 ae 10 80       	push   $0x8010aea3
80106420:	e8 72 a1 ff ff       	call   80100597 <panic>
    }
    if (!(*sList)) {
80106425:	8b 45 08             	mov    0x8(%ebp),%eax
80106428:	8b 00                	mov    (%eax),%eax
8010642a:	85 c0                	test   %eax,%eax
8010642c:	75 0a                	jne    80106438 <removeFromStateList+0x30>
        return -1;
8010642e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106433:	e9 c6 00 00 00       	jmp    801064fe <removeFromStateList+0xf6>
    }
    // if p is the first element in list
    if (p == (*sList)) {
80106438:	8b 45 08             	mov    0x8(%ebp),%eax
8010643b:	8b 00                	mov    (%eax),%eax
8010643d:	39 45 0c             	cmp    %eax,0xc(%ebp)
80106440:	75 59                	jne    8010649b <removeFromStateList+0x93>
        // if it is the only item in list
        if (!(*sList)->next) {
80106442:	8b 45 08             	mov    0x8(%ebp),%eax
80106445:	8b 00                	mov    (%eax),%eax
80106447:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010644d:	85 c0                	test   %eax,%eax
8010644f:	75 20                	jne    80106471 <removeFromStateList+0x69>
            (*sList) = 0;
80106451:	8b 45 08             	mov    0x8(%ebp),%eax
80106454:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
            p->next = 0;
8010645a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010645d:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80106464:	00 00 00 
            return 0;
80106467:	b8 00 00 00 00       	mov    $0x0,%eax
8010646c:	e9 8d 00 00 00       	jmp    801064fe <removeFromStateList+0xf6>
        }
        // if p is the first item in list
        else {
            struct proc * temp = (*sList)->next;
80106471:	8b 45 08             	mov    0x8(%ebp),%eax
80106474:	8b 00                	mov    (%eax),%eax
80106476:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010647c:	89 45 ec             	mov    %eax,-0x14(%ebp)
            p->next = 0;
8010647f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106482:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
80106489:	00 00 00 
            (*sList) = temp;
8010648c:	8b 45 08             	mov    0x8(%ebp),%eax
8010648f:	8b 55 ec             	mov    -0x14(%ebp),%edx
80106492:	89 10                	mov    %edx,(%eax)
            return 0;
80106494:	b8 00 00 00 00       	mov    $0x0,%eax
80106499:	eb 63                	jmp    801064fe <removeFromStateList+0xf6>
        }
    }
    // from middle or end of list
    else {
        struct proc * current = (*sList)->next;
8010649b:	8b 45 08             	mov    0x8(%ebp),%eax
8010649e:	8b 00                	mov    (%eax),%eax
801064a0:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801064a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        struct proc * prev = (*sList);
801064a9:	8b 45 08             	mov    0x8(%ebp),%eax
801064ac:	8b 00                	mov    (%eax),%eax
801064ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
        while (current) {
801064b1:	eb 40                	jmp    801064f3 <removeFromStateList+0xeb>
            if (current == p) {
801064b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064b6:	3b 45 0c             	cmp    0xc(%ebp),%eax
801064b9:	75 26                	jne    801064e1 <removeFromStateList+0xd9>
                prev->next = current->next;
801064bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064be:	8b 90 90 00 00 00    	mov    0x90(%eax),%edx
801064c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064c7:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
                p->next = 0;
801064cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801064d0:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
801064d7:	00 00 00 
                return 0;
801064da:	b8 00 00 00 00       	mov    $0x0,%eax
801064df:	eb 1d                	jmp    801064fe <removeFromStateList+0xf6>
            }
            prev = current;
801064e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
            current = current->next;
801064e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064ea:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801064f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (current) {
801064f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801064f7:	75 ba                	jne    801064b3 <removeFromStateList+0xab>
        }
    }
    return -1; // nothing found
801064f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064fe:	c9                   	leave  
801064ff:	c3                   	ret    

80106500 <removeHead>:

// remove first element of list, return its pointer
static struct proc*
removeHead(struct proc** sList) {
80106500:	f3 0f 1e fb          	endbr32 
80106504:	55                   	push   %ebp
80106505:	89 e5                	mov    %esp,%ebp
80106507:	83 ec 10             	sub    $0x10,%esp
    if (!(*sList)) {
8010650a:	8b 45 08             	mov    0x8(%ebp),%eax
8010650d:	8b 00                	mov    (%eax),%eax
8010650f:	85 c0                	test   %eax,%eax
80106511:	75 07                	jne    8010651a <removeHead+0x1a>
        return 0; // return null, check value in calling routine
80106513:	b8 00 00 00 00       	mov    $0x0,%eax
80106518:	eb 2e                	jmp    80106548 <removeHead+0x48>
    }
    struct proc* p = (*sList); // assign pointer to head of sList
8010651a:	8b 45 08             	mov    0x8(%ebp),%eax
8010651d:	8b 00                	mov    (%eax),%eax
8010651f:	89 45 fc             	mov    %eax,-0x4(%ebp)
    struct proc* temp = (*sList)->next; // hold onto next element in list
80106522:	8b 45 08             	mov    0x8(%ebp),%eax
80106525:	8b 00                	mov    (%eax),%eax
80106527:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010652d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    p->next = 0; // p is no longer head of sList
80106530:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106533:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%eax)
8010653a:	00 00 00 
    (*sList) = temp; // sList now starts at  2nd element, or is NULL if one-item list
8010653d:	8b 45 08             	mov    0x8(%ebp),%eax
80106540:	8b 55 f8             	mov    -0x8(%ebp),%edx
80106543:	89 10                	mov    %edx,(%eax)
    return p; // return 
80106545:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106548:	c9                   	leave  
80106549:	c3                   	ret    

8010654a <printReadyList>:

// print PIDs of all procs in Ready list
void
printReadyList(void) {
8010654a:	f3 0f 1e fb          	endbr32 
8010654e:	55                   	push   %ebp
8010654f:	89 e5                	mov    %esp,%ebp
80106551:	83 ec 18             	sub    $0x18,%esp
    //int i = 0;
    cprintf("\nReady List Processes:\n");
80106554:	83 ec 0c             	sub    $0xc,%esp
80106557:	68 bf ae 10 80       	push   $0x8010aebf
8010655c:	e8 7d 9e ff ff       	call   801003de <cprintf>
80106561:	83 c4 10             	add    $0x10,%esp
    //while (i <= MAX) {
    for (int i = 0; i <= MAX; ++i) {
80106564:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010656b:	e9 ca 00 00 00       	jmp    8010663a <printReadyList+0xf0>
        if (ptable.pLists.ready[i]) {
80106570:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106573:	05 cc 09 00 00       	add    $0x9cc,%eax
80106578:	8b 04 85 04 66 11 80 	mov    -0x7fee99fc(,%eax,4),%eax
8010657f:	85 c0                	test   %eax,%eax
80106581:	0f 84 9c 00 00 00    	je     80106623 <printReadyList+0xd9>
            cprintf("\n%d: ", i);
80106587:	83 ec 08             	sub    $0x8,%esp
8010658a:	ff 75 f4             	pushl  -0xc(%ebp)
8010658d:	68 d7 ae 10 80       	push   $0x8010aed7
80106592:	e8 47 9e ff ff       	call   801003de <cprintf>
80106597:	83 c4 10             	add    $0x10,%esp
            struct proc* current = ptable.pLists.ready[i];
8010659a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010659d:	05 cc 09 00 00       	add    $0x9cc,%eax
801065a2:	8b 04 85 04 66 11 80 	mov    -0x7fee99fc(,%eax,4),%eax
801065a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
            while (current) {
801065ac:	eb 5d                	jmp    8010660b <printReadyList+0xc1>
                if (current->next) {
801065ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065b1:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801065b7:	85 c0                	test   %eax,%eax
801065b9:	74 23                	je     801065de <printReadyList+0x94>
                    cprintf("(%d, %d) -> ", current->pid, current->budget);
801065bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065be:	8b 90 98 00 00 00    	mov    0x98(%eax),%edx
801065c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065c7:	8b 40 10             	mov    0x10(%eax),%eax
801065ca:	83 ec 04             	sub    $0x4,%esp
801065cd:	52                   	push   %edx
801065ce:	50                   	push   %eax
801065cf:	68 dd ae 10 80       	push   $0x8010aedd
801065d4:	e8 05 9e ff ff       	call   801003de <cprintf>
801065d9:	83 c4 10             	add    $0x10,%esp
801065dc:	eb 21                	jmp    801065ff <printReadyList+0xb5>
                } else {
                    cprintf("(%d, %d)", current->pid, current->budget);
801065de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065e1:	8b 90 98 00 00 00    	mov    0x98(%eax),%edx
801065e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065ea:	8b 40 10             	mov    0x10(%eax),%eax
801065ed:	83 ec 04             	sub    $0x4,%esp
801065f0:	52                   	push   %edx
801065f1:	50                   	push   %eax
801065f2:	68 ea ae 10 80       	push   $0x8010aeea
801065f7:	e8 e2 9d ff ff       	call   801003de <cprintf>
801065fc:	83 c4 10             	add    $0x10,%esp
                }
                current = current->next;
801065ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106602:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80106608:	89 45 f0             	mov    %eax,-0x10(%ebp)
            while (current) {
8010660b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010660f:	75 9d                	jne    801065ae <printReadyList+0x64>
            }
            cprintf("\n");
80106611:	83 ec 0c             	sub    $0xc,%esp
80106614:	68 41 ae 10 80       	push   $0x8010ae41
80106619:	e8 c0 9d ff ff       	call   801003de <cprintf>
8010661e:	83 c4 10             	add    $0x10,%esp
80106621:	eb 13                	jmp    80106636 <printReadyList+0xec>
        }
        else {
            cprintf("\n%d: Empty.\n", i);
80106623:	83 ec 08             	sub    $0x8,%esp
80106626:	ff 75 f4             	pushl  -0xc(%ebp)
80106629:	68 f3 ae 10 80       	push   $0x8010aef3
8010662e:	e8 ab 9d ff ff       	call   801003de <cprintf>
80106633:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i <= MAX; ++i) {
80106636:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010663a:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
8010663e:	0f 8e 2c ff ff ff    	jle    80106570 <printReadyList+0x26>
        }
    }
}
80106644:	90                   	nop
80106645:	90                   	nop
80106646:	c9                   	leave  
80106647:	c3                   	ret    

80106648 <printFreeList>:

// print number of procs in Free list
void
printFreeList(void) {
80106648:	f3 0f 1e fb          	endbr32 
8010664c:	55                   	push   %ebp
8010664d:	89 e5                	mov    %esp,%ebp
8010664f:	83 ec 18             	sub    $0x18,%esp
    if (ptable.pLists.free) {
80106652:	a1 40 8d 11 80       	mov    0x80118d40,%eax
80106657:	85 c0                	test   %eax,%eax
80106659:	74 3c                	je     80106697 <printFreeList+0x4f>
        int size = 0;
8010665b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
        struct proc * current = ptable.pLists.free;
80106662:	a1 40 8d 11 80       	mov    0x80118d40,%eax
80106667:	89 45 f0             	mov    %eax,-0x10(%ebp)
        while (current) {
8010666a:	eb 10                	jmp    8010667c <printFreeList+0x34>
            ++size; // cycle list and keep count
8010666c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
            current = current->next;
80106670:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106673:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80106679:	89 45 f0             	mov    %eax,-0x10(%ebp)
        while (current) {
8010667c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106680:	75 ea                	jne    8010666c <printFreeList+0x24>
        }
        //for (struct proc* current = ptable.pLists.free; current; current = current->next) {++size;}
        cprintf("\nFree List Size: %d processes\n", size);
80106682:	83 ec 08             	sub    $0x8,%esp
80106685:	ff 75 f4             	pushl  -0xc(%ebp)
80106688:	68 00 af 10 80       	push   $0x8010af00
8010668d:	e8 4c 9d ff ff       	call   801003de <cprintf>
80106692:	83 c4 10             	add    $0x10,%esp
    }
    else {
        cprintf("\nNo processes on Free List.\n");
    }
}
80106695:	eb 10                	jmp    801066a7 <printFreeList+0x5f>
        cprintf("\nNo processes on Free List.\n");
80106697:	83 ec 0c             	sub    $0xc,%esp
8010669a:	68 1f af 10 80       	push   $0x8010af1f
8010669f:	e8 3a 9d ff ff       	call   801003de <cprintf>
801066a4:	83 c4 10             	add    $0x10,%esp
}
801066a7:	90                   	nop
801066a8:	c9                   	leave  
801066a9:	c3                   	ret    

801066aa <printSleepList>:

// print PIDs of all procs in Sleep list
void
printSleepList(void) {
801066aa:	f3 0f 1e fb          	endbr32 
801066ae:	55                   	push   %ebp
801066af:	89 e5                	mov    %esp,%ebp
801066b1:	83 ec 18             	sub    $0x18,%esp
    //acquire(&ptable.lock);
    if (ptable.pLists.sleep) {
801066b4:	a1 44 8d 11 80       	mov    0x80118d44,%eax
801066b9:	85 c0                	test   %eax,%eax
801066bb:	74 7b                	je     80106738 <printSleepList+0x8e>
        struct proc* current = ptable.pLists.sleep;
801066bd:	a1 44 8d 11 80       	mov    0x80118d44,%eax
801066c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        cprintf("\nSleep List Processes:\n");
801066c5:	83 ec 0c             	sub    $0xc,%esp
801066c8:	68 3c af 10 80       	push   $0x8010af3c
801066cd:	e8 0c 9d ff ff       	call   801003de <cprintf>
801066d2:	83 c4 10             	add    $0x10,%esp
        while (current) {
801066d5:	eb 49                	jmp    80106720 <printSleepList+0x76>
            if (current->next) {
801066d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066da:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801066e0:	85 c0                	test   %eax,%eax
801066e2:	74 19                	je     801066fd <printSleepList+0x53>
                cprintf("%d -> ", current->pid);
801066e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066e7:	8b 40 10             	mov    0x10(%eax),%eax
801066ea:	83 ec 08             	sub    $0x8,%esp
801066ed:	50                   	push   %eax
801066ee:	68 54 af 10 80       	push   $0x8010af54
801066f3:	e8 e6 9c ff ff       	call   801003de <cprintf>
801066f8:	83 c4 10             	add    $0x10,%esp
801066fb:	eb 17                	jmp    80106714 <printSleepList+0x6a>
            } else {
                cprintf("%d", current->pid);
801066fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106700:	8b 40 10             	mov    0x10(%eax),%eax
80106703:	83 ec 08             	sub    $0x8,%esp
80106706:	50                   	push   %eax
80106707:	68 5b af 10 80       	push   $0x8010af5b
8010670c:	e8 cd 9c ff ff       	call   801003de <cprintf>
80106711:	83 c4 10             	add    $0x10,%esp
            }
            current = current->next;
80106714:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106717:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010671d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (current) {
80106720:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106724:	75 b1                	jne    801066d7 <printSleepList+0x2d>
        }
        cprintf("\n");
80106726:	83 ec 0c             	sub    $0xc,%esp
80106729:	68 41 ae 10 80       	push   $0x8010ae41
8010672e:	e8 ab 9c ff ff       	call   801003de <cprintf>
80106733:	83 c4 10             	add    $0x10,%esp
    }
    else {
        cprintf("\nNo processes on Sleep List.\n");
    }
    //release(&ptable.lock);
}
80106736:	eb 10                	jmp    80106748 <printSleepList+0x9e>
        cprintf("\nNo processes on Sleep List.\n");
80106738:	83 ec 0c             	sub    $0xc,%esp
8010673b:	68 5e af 10 80       	push   $0x8010af5e
80106740:	e8 99 9c ff ff       	call   801003de <cprintf>
80106745:	83 c4 10             	add    $0x10,%esp
}
80106748:	90                   	nop
80106749:	c9                   	leave  
8010674a:	c3                   	ret    

8010674b <printZombieList>:

// print PIDs & PPIDs of all procs in Zombie list
void
printZombieList(void) {
8010674b:	f3 0f 1e fb          	endbr32 
8010674f:	55                   	push   %ebp
80106750:	89 e5                	mov    %esp,%ebp
80106752:	83 ec 18             	sub    $0x18,%esp
    if (ptable.pLists.zombie) {
80106755:	a1 48 8d 11 80       	mov    0x80118d48,%eax
8010675a:	85 c0                	test   %eax,%eax
8010675c:	0f 84 8f 00 00 00    	je     801067f1 <printZombieList+0xa6>
        struct proc* current = ptable.pLists.zombie;
80106762:	a1 48 8d 11 80       	mov    0x80118d48,%eax
80106767:	89 45 f4             	mov    %eax,-0xc(%ebp)
        cprintf("\nZombie List Processes:\n");
8010676a:	83 ec 0c             	sub    $0xc,%esp
8010676d:	68 7c af 10 80       	push   $0x8010af7c
80106772:	e8 67 9c ff ff       	call   801003de <cprintf>
80106777:	83 c4 10             	add    $0x10,%esp
        while (current) {
8010677a:	eb 5d                	jmp    801067d9 <printZombieList+0x8e>
            if (current->next) {
8010677c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010677f:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80106785:	85 c0                	test   %eax,%eax
80106787:	74 23                	je     801067ac <printZombieList+0x61>
                cprintf("(%d, %d) -> ", current->pid, current->parent->pid);
80106789:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010678c:	8b 40 14             	mov    0x14(%eax),%eax
8010678f:	8b 50 10             	mov    0x10(%eax),%edx
80106792:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106795:	8b 40 10             	mov    0x10(%eax),%eax
80106798:	83 ec 04             	sub    $0x4,%esp
8010679b:	52                   	push   %edx
8010679c:	50                   	push   %eax
8010679d:	68 dd ae 10 80       	push   $0x8010aedd
801067a2:	e8 37 9c ff ff       	call   801003de <cprintf>
801067a7:	83 c4 10             	add    $0x10,%esp
801067aa:	eb 21                	jmp    801067cd <printZombieList+0x82>
            } else {
                cprintf("(%d, %d)", current->pid, current->parent->pid);
801067ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067af:	8b 40 14             	mov    0x14(%eax),%eax
801067b2:	8b 50 10             	mov    0x10(%eax),%edx
801067b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067b8:	8b 40 10             	mov    0x10(%eax),%eax
801067bb:	83 ec 04             	sub    $0x4,%esp
801067be:	52                   	push   %edx
801067bf:	50                   	push   %eax
801067c0:	68 ea ae 10 80       	push   $0x8010aeea
801067c5:	e8 14 9c ff ff       	call   801003de <cprintf>
801067ca:	83 c4 10             	add    $0x10,%esp
            }
            current = current->next;
801067cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067d0:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801067d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (current) {
801067d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801067dd:	75 9d                	jne    8010677c <printZombieList+0x31>
        }
        cprintf("\n");
801067df:	83 ec 0c             	sub    $0xc,%esp
801067e2:	68 41 ae 10 80       	push   $0x8010ae41
801067e7:	e8 f2 9b ff ff       	call   801003de <cprintf>
801067ec:	83 c4 10             	add    $0x10,%esp
    }
    else {
        cprintf("\nNo processes on Zombie List.\n");
    }
}
801067ef:	eb 10                	jmp    80106801 <printZombieList+0xb6>
        cprintf("\nNo processes on Zombie List.\n");
801067f1:	83 ec 0c             	sub    $0xc,%esp
801067f4:	68 98 af 10 80       	push   $0x8010af98
801067f9:	e8 e0 9b ff ff       	call   801003de <cprintf>
801067fe:	83 c4 10             	add    $0x10,%esp
}
80106801:	90                   	nop
80106802:	c9                   	leave  
80106803:	c3                   	ret    

80106804 <promoteAll>:
// upwards to lowest priority queue

// Promote all ACTIVE(RUNNING, RUNNABLE, SLEEPING) processes one priority level
// this is only called in scheduler(), which holds &ptable.lock
static void
promoteAll(void) {
80106804:	f3 0f 1e fb          	endbr32 
80106808:	55                   	push   %ebp
80106809:	89 e5                	mov    %esp,%ebp
8010680b:	83 ec 18             	sub    $0x18,%esp
    struct proc* p; // main ptr
    struct proc* current; // 2nd ptr needed for traversal + list management
    for (int i = 1; i <= MAX; ++i) {
8010680e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
80106815:	e9 ff 00 00 00       	jmp    80106919 <promoteAll+0x115>
        // traverse ready list array
        if (ptable.pLists.ready[i]) {
8010681a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010681d:	05 cc 09 00 00       	add    $0x9cc,%eax
80106822:	8b 04 85 04 66 11 80 	mov    -0x7fee99fc(,%eax,4),%eax
80106829:	85 c0                	test   %eax,%eax
8010682b:	0f 84 e4 00 00 00    	je     80106915 <promoteAll+0x111>
            current = ptable.pLists.ready[i]; // initialize
80106831:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106834:	05 cc 09 00 00       	add    $0x9cc,%eax
80106839:	8b 04 85 04 66 11 80 	mov    -0x7fee99fc(,%eax,4),%eax
80106840:	89 45 f0             	mov    %eax,-0x10(%ebp)
            p = 0;
80106843:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            while (current) {
8010684a:	e9 bc 00 00 00       	jmp    8010690b <promoteAll+0x107>
                p = current; // p is the current process to adjust
8010684f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106852:	89 45 f4             	mov    %eax,-0xc(%ebp)
                current = current->next; // current traverses one ahead
80106855:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106858:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
8010685e:	89 45 f0             	mov    %eax,-0x10(%ebp)
                assertState(p, RUNNABLE); // assert state, we need to swap ready lists
80106861:	83 ec 08             	sub    $0x8,%esp
80106864:	6a 03                	push   $0x3
80106866:	ff 75 f4             	pushl  -0xc(%ebp)
80106869:	e8 6d fa ff ff       	call   801062db <assertState>
8010686e:	83 c4 10             	add    $0x10,%esp
                if (removeFromStateList(&ptable.pLists.ready[p->priority], p) < 0) {
80106871:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106874:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
8010687a:	05 cc 09 00 00       	add    $0x9cc,%eax
8010687f:	c1 e0 02             	shl    $0x2,%eax
80106882:	05 00 66 11 80       	add    $0x80116600,%eax
80106887:	83 c0 04             	add    $0x4,%eax
8010688a:	83 ec 08             	sub    $0x8,%esp
8010688d:	ff 75 f4             	pushl  -0xc(%ebp)
80106890:	50                   	push   %eax
80106891:	e8 72 fb ff ff       	call   80106408 <removeFromStateList>
80106896:	83 c4 10             	add    $0x10,%esp
80106899:	85 c0                	test   %eax,%eax
8010689b:	79 10                	jns    801068ad <promoteAll+0xa9>
                    cprintf("promoteAll: Could not remove from ready list.\n");
8010689d:	83 ec 0c             	sub    $0xc,%esp
801068a0:	68 b8 af 10 80       	push   $0x8010afb8
801068a5:	e8 34 9b ff ff       	call   801003de <cprintf>
801068aa:	83 c4 10             	add    $0x10,%esp
                } // take off lower priority (whatever one it is)
                if (p->priority > 0) {
801068ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068b0:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
801068b6:	85 c0                	test   %eax,%eax
801068b8:	74 15                	je     801068cf <promoteAll+0xcb>
                    --(p->priority); // adjust upward (toward zero)
801068ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068bd:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
801068c3:	8d 50 ff             	lea    -0x1(%eax),%edx
801068c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068c9:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
                } // add to higher priority list
                if (addToStateListEnd(&ptable.pLists.ready[p->priority], p) < 0) {
801068cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801068d2:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
801068d8:	05 cc 09 00 00       	add    $0x9cc,%eax
801068dd:	c1 e0 02             	shl    $0x2,%eax
801068e0:	05 00 66 11 80       	add    $0x80116600,%eax
801068e5:	83 c0 04             	add    $0x4,%eax
801068e8:	83 ec 08             	sub    $0x8,%esp
801068eb:	ff 75 f4             	pushl  -0xc(%ebp)
801068ee:	50                   	push   %eax
801068ef:	e8 8f fa ff ff       	call   80106383 <addToStateListEnd>
801068f4:	83 c4 10             	add    $0x10,%esp
801068f7:	85 c0                	test   %eax,%eax
801068f9:	79 10                	jns    8010690b <promoteAll+0x107>
                    cprintf("promoteAll: Could not add to ready list.\n");
801068fb:	83 ec 0c             	sub    $0xc,%esp
801068fe:	68 e8 af 10 80       	push   $0x8010afe8
80106903:	e8 d6 9a ff ff       	call   801003de <cprintf>
80106908:	83 c4 10             	add    $0x10,%esp
            while (current) {
8010690b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010690f:	0f 85 3a ff ff ff    	jne    8010684f <promoteAll+0x4b>
    for (int i = 1; i <= MAX; ++i) {
80106915:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80106919:	83 7d ec 02          	cmpl   $0x2,-0x14(%ebp)
8010691d:	0f 8e f7 fe ff ff    	jle    8010681a <promoteAll+0x16>
                }
            }
        }
    }
    // promote all SLEEPING processes
    if (ptable.pLists.sleep) {
80106923:	a1 44 8d 11 80       	mov    0x80118d44,%eax
80106928:	85 c0                	test   %eax,%eax
8010692a:	74 3e                	je     8010696a <promoteAll+0x166>
        p = ptable.pLists.sleep;
8010692c:	a1 44 8d 11 80       	mov    0x80118d44,%eax
80106931:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (p) {
80106934:	eb 2e                	jmp    80106964 <promoteAll+0x160>
            if (p->priority > 0) {
80106936:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106939:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
8010693f:	85 c0                	test   %eax,%eax
80106941:	74 15                	je     80106958 <promoteAll+0x154>
                --(p->priority); // promote process
80106943:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106946:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
8010694c:	8d 50 ff             	lea    -0x1(%eax),%edx
8010694f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106952:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
            }
            p = p->next;
80106958:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010695b:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80106961:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (p) {
80106964:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106968:	75 cc                	jne    80106936 <promoteAll+0x132>
        }
    }
    // promote all RUNNING processes
    if (ptable.pLists.running) {
8010696a:	a1 4c 8d 11 80       	mov    0x80118d4c,%eax
8010696f:	85 c0                	test   %eax,%eax
80106971:	74 3e                	je     801069b1 <promoteAll+0x1ad>
        p = ptable.pLists.running;
80106973:	a1 4c 8d 11 80       	mov    0x80118d4c,%eax
80106978:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (p) {
8010697b:	eb 2e                	jmp    801069ab <promoteAll+0x1a7>
            if (p->priority > 0) {
8010697d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106980:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80106986:	85 c0                	test   %eax,%eax
80106988:	74 15                	je     8010699f <promoteAll+0x19b>
                --(p->priority); // promote process
8010698a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010698d:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80106993:	8d 50 ff             	lea    -0x1(%eax),%edx
80106996:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106999:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
            }
            p = p->next;
8010699f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069a2:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
801069a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (p) {
801069ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801069af:	75 cc                	jne    8010697d <promoteAll+0x179>
        }
    }
    // nothing to return, just promote anything if they are there
}
801069b1:	90                   	nop
801069b2:	c9                   	leave  
801069b3:	c3                   	ret    

801069b4 <setpriority>:
// set priority system call
// bounds enforced in sysproc.c (kernel-side)
// active processes: RUNNABLE, RUNNING, SLEEPING
int
setpriority(int pid, int priority) {
801069b4:	f3 0f 1e fb          	endbr32 
801069b8:	55                   	push   %ebp
801069b9:	89 e5                	mov    %esp,%ebp
801069bb:	83 ec 18             	sub    $0x18,%esp
    struct proc* p;
    acquire(&ptable.lock); // maintain atomicity
801069be:	83 ec 0c             	sub    $0xc,%esp
801069c1:	68 00 66 11 80       	push   $0x80116600
801069c6:	e8 44 02 00 00       	call   80106c0f <acquire>
801069cb:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i <= MAX; ++i) {
801069ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801069d5:	e9 01 01 00 00       	jmp    80106adb <setpriority+0x127>
        p = ptable.pLists.ready[i]; // traverse ready list array
801069da:	8b 45 f0             	mov    -0x10(%ebp),%eax
801069dd:	05 cc 09 00 00       	add    $0x9cc,%eax
801069e2:	8b 04 85 04 66 11 80 	mov    -0x7fee99fc(,%eax,4),%eax
801069e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (p) {
801069ec:	e9 dc 00 00 00       	jmp    80106acd <setpriority+0x119>
            // match PIDs and only if the new priority value changes anything
            if (p->pid == pid) {
801069f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069f4:	8b 50 10             	mov    0x10(%eax),%edx
801069f7:	8b 45 08             	mov    0x8(%ebp),%eax
801069fa:	39 c2                	cmp    %eax,%edx
801069fc:	0f 85 bf 00 00 00    	jne    80106ac1 <setpriority+0x10d>
                if (removeFromStateList(&ptable.pLists.ready[p->priority], p) < 0) {
80106a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a05:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80106a0b:	05 cc 09 00 00       	add    $0x9cc,%eax
80106a10:	c1 e0 02             	shl    $0x2,%eax
80106a13:	05 00 66 11 80       	add    $0x80116600,%eax
80106a18:	83 c0 04             	add    $0x4,%eax
80106a1b:	83 ec 08             	sub    $0x8,%esp
80106a1e:	ff 75 f4             	pushl  -0xc(%ebp)
80106a21:	50                   	push   %eax
80106a22:	e8 e1 f9 ff ff       	call   80106408 <removeFromStateList>
80106a27:	83 c4 10             	add    $0x10,%esp
80106a2a:	85 c0                	test   %eax,%eax
80106a2c:	79 1a                	jns    80106a48 <setpriority+0x94>
                    cprintf("setpriority: remove from ready list[%d] failed.\n", p->priority);
80106a2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a31:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80106a37:	83 ec 08             	sub    $0x8,%esp
80106a3a:	50                   	push   %eax
80106a3b:	68 14 b0 10 80       	push   $0x8010b014
80106a40:	e8 99 99 ff ff       	call   801003de <cprintf>
80106a45:	83 c4 10             	add    $0x10,%esp
                }// remove from old ready list
                p->priority = priority; // set priority
80106a48:	8b 55 0c             	mov    0xc(%ebp),%edx
80106a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a4e:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
                if (addToStateListEnd(&ptable.pLists.ready[p->priority], p) < 0) {
80106a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a57:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80106a5d:	05 cc 09 00 00       	add    $0x9cc,%eax
80106a62:	c1 e0 02             	shl    $0x2,%eax
80106a65:	05 00 66 11 80       	add    $0x80116600,%eax
80106a6a:	83 c0 04             	add    $0x4,%eax
80106a6d:	83 ec 08             	sub    $0x8,%esp
80106a70:	ff 75 f4             	pushl  -0xc(%ebp)
80106a73:	50                   	push   %eax
80106a74:	e8 0a f9 ff ff       	call   80106383 <addToStateListEnd>
80106a79:	83 c4 10             	add    $0x10,%esp
80106a7c:	85 c0                	test   %eax,%eax
80106a7e:	79 1a                	jns    80106a9a <setpriority+0xe6>
                    cprintf("setpriority: add to ready list[%d] failed.\n", p->priority);
80106a80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a83:	8b 80 94 00 00 00    	mov    0x94(%eax),%eax
80106a89:	83 ec 08             	sub    $0x8,%esp
80106a8c:	50                   	push   %eax
80106a8d:	68 48 b0 10 80       	push   $0x8010b048
80106a92:	e8 47 99 ff ff       	call   801003de <cprintf>
80106a97:	83 c4 10             	add    $0x10,%esp
                } //  add to new ready list
                p->budget = BUDGET; // reset budget
80106a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a9d:	c7 80 98 00 00 00 78 	movl   $0x78,0x98(%eax)
80106aa4:	00 00 00 
                //cprintf("setPriority: ready list priority set.\n");
                release(&ptable.lock); // release lock
80106aa7:	83 ec 0c             	sub    $0xc,%esp
80106aaa:	68 00 66 11 80       	push   $0x80116600
80106aaf:	e8 c6 01 00 00       	call   80106c7a <release>
80106ab4:	83 c4 10             	add    $0x10,%esp
                return 0; // return success
80106ab7:	b8 00 00 00 00       	mov    $0x0,%eax
80106abc:	e9 ee 00 00 00       	jmp    80106baf <setpriority+0x1fb>
            }
            p = p->next;
80106ac1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ac4:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80106aca:	89 45 f4             	mov    %eax,-0xc(%ebp)
        while (p) {
80106acd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106ad1:	0f 85 1a ff ff ff    	jne    801069f1 <setpriority+0x3d>
    for (int i = 0; i <= MAX; ++i) {
80106ad7:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80106adb:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
80106adf:	0f 8e f5 fe ff ff    	jle    801069da <setpriority+0x26>
        }
    }
    p = ptable.pLists.running; // repeat process if PID not found in ready lists
80106ae5:	a1 4c 8d 11 80       	mov    0x80118d4c,%eax
80106aea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80106aed:	eb 4c                	jmp    80106b3b <setpriority+0x187>
        if (p->pid == pid) {
80106aef:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106af2:	8b 50 10             	mov    0x10(%eax),%edx
80106af5:	8b 45 08             	mov    0x8(%ebp),%eax
80106af8:	39 c2                	cmp    %eax,%edx
80106afa:	75 33                	jne    80106b2f <setpriority+0x17b>
            p->priority = priority;
80106afc:	8b 55 0c             	mov    0xc(%ebp),%edx
80106aff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b02:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
            p->budget = BUDGET;
80106b08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b0b:	c7 80 98 00 00 00 78 	movl   $0x78,0x98(%eax)
80106b12:	00 00 00 
            //cprintf("setPriority: running list priority set.\n");
            release(&ptable.lock);
80106b15:	83 ec 0c             	sub    $0xc,%esp
80106b18:	68 00 66 11 80       	push   $0x80116600
80106b1d:	e8 58 01 00 00       	call   80106c7a <release>
80106b22:	83 c4 10             	add    $0x10,%esp
            return 0; // return success
80106b25:	b8 00 00 00 00       	mov    $0x0,%eax
80106b2a:	e9 80 00 00 00       	jmp    80106baf <setpriority+0x1fb>
        }
        p = p->next;
80106b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b32:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80106b38:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80106b3b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106b3f:	75 ae                	jne    80106aef <setpriority+0x13b>
    }
    p = ptable.pLists.sleep; // continue search in sleep list
80106b41:	a1 44 8d 11 80       	mov    0x80118d44,%eax
80106b46:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80106b49:	eb 49                	jmp    80106b94 <setpriority+0x1e0>
        if (p->pid == pid) {
80106b4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b4e:	8b 50 10             	mov    0x10(%eax),%edx
80106b51:	8b 45 08             	mov    0x8(%ebp),%eax
80106b54:	39 c2                	cmp    %eax,%edx
80106b56:	75 30                	jne    80106b88 <setpriority+0x1d4>
            p->priority = priority;
80106b58:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b5e:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
            p->budget = BUDGET;
80106b64:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b67:	c7 80 98 00 00 00 78 	movl   $0x78,0x98(%eax)
80106b6e:	00 00 00 
            //cprintf("setPriority: sleep list priority set.\n");
            release(&ptable.lock);
80106b71:	83 ec 0c             	sub    $0xc,%esp
80106b74:	68 00 66 11 80       	push   $0x80116600
80106b79:	e8 fc 00 00 00       	call   80106c7a <release>
80106b7e:	83 c4 10             	add    $0x10,%esp
            return 0; //  return success
80106b81:	b8 00 00 00 00       	mov    $0x0,%eax
80106b86:	eb 27                	jmp    80106baf <setpriority+0x1fb>
        }
        p = p->next;
80106b88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b8b:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80106b91:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while (p) {
80106b94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106b98:	75 b1                	jne    80106b4b <setpriority+0x197>
    }
    //cprintf("setPriority: No priority set.\n");
    release(&ptable.lock);
80106b9a:	83 ec 0c             	sub    $0xc,%esp
80106b9d:	68 00 66 11 80       	push   $0x80116600
80106ba2:	e8 d3 00 00 00       	call   80106c7a <release>
80106ba7:	83 c4 10             	add    $0x10,%esp
    return -1; // return error if no PID match is found
80106baa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106baf:	c9                   	leave  
80106bb0:	c3                   	ret    

80106bb1 <readeflags>:
{
80106bb1:	55                   	push   %ebp
80106bb2:	89 e5                	mov    %esp,%ebp
80106bb4:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80106bb7:	9c                   	pushf  
80106bb8:	58                   	pop    %eax
80106bb9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80106bbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106bbf:	c9                   	leave  
80106bc0:	c3                   	ret    

80106bc1 <cli>:
{
80106bc1:	55                   	push   %ebp
80106bc2:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80106bc4:	fa                   	cli    
}
80106bc5:	90                   	nop
80106bc6:	5d                   	pop    %ebp
80106bc7:	c3                   	ret    

80106bc8 <sti>:
{
80106bc8:	55                   	push   %ebp
80106bc9:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80106bcb:	fb                   	sti    
}
80106bcc:	90                   	nop
80106bcd:	5d                   	pop    %ebp
80106bce:	c3                   	ret    

80106bcf <xchg>:
{
80106bcf:	55                   	push   %ebp
80106bd0:	89 e5                	mov    %esp,%ebp
80106bd2:	83 ec 10             	sub    $0x10,%esp
  asm volatile("lock; xchgl %0, %1" :
80106bd5:	8b 55 08             	mov    0x8(%ebp),%edx
80106bd8:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bdb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106bde:	f0 87 02             	lock xchg %eax,(%edx)
80106be1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return result;
80106be4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106be7:	c9                   	leave  
80106be8:	c3                   	ret    

80106be9 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80106be9:	f3 0f 1e fb          	endbr32 
80106bed:	55                   	push   %ebp
80106bee:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80106bf0:	8b 45 08             	mov    0x8(%ebp),%eax
80106bf3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106bf6:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80106bf9:	8b 45 08             	mov    0x8(%ebp),%eax
80106bfc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80106c02:	8b 45 08             	mov    0x8(%ebp),%eax
80106c05:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80106c0c:	90                   	nop
80106c0d:	5d                   	pop    %ebp
80106c0e:	c3                   	ret    

80106c0f <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80106c0f:	f3 0f 1e fb          	endbr32 
80106c13:	55                   	push   %ebp
80106c14:	89 e5                	mov    %esp,%ebp
80106c16:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80106c19:	e8 5f 01 00 00       	call   80106d7d <pushcli>
  if(holding(lk))
80106c1e:	8b 45 08             	mov    0x8(%ebp),%eax
80106c21:	83 ec 0c             	sub    $0xc,%esp
80106c24:	50                   	push   %eax
80106c25:	e8 25 01 00 00       	call   80106d4f <holding>
80106c2a:	83 c4 10             	add    $0x10,%esp
80106c2d:	85 c0                	test   %eax,%eax
80106c2f:	74 0d                	je     80106c3e <acquire+0x2f>
    panic("acquire");
80106c31:	83 ec 0c             	sub    $0xc,%esp
80106c34:	68 74 b0 10 80       	push   $0x8010b074
80106c39:	e8 59 99 ff ff       	call   80100597 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80106c3e:	90                   	nop
80106c3f:	8b 45 08             	mov    0x8(%ebp),%eax
80106c42:	83 ec 08             	sub    $0x8,%esp
80106c45:	6a 01                	push   $0x1
80106c47:	50                   	push   %eax
80106c48:	e8 82 ff ff ff       	call   80106bcf <xchg>
80106c4d:	83 c4 10             	add    $0x10,%esp
80106c50:	85 c0                	test   %eax,%eax
80106c52:	75 eb                	jne    80106c3f <acquire+0x30>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80106c54:	8b 45 08             	mov    0x8(%ebp),%eax
80106c57:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80106c5e:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80106c61:	8b 45 08             	mov    0x8(%ebp),%eax
80106c64:	83 c0 0c             	add    $0xc,%eax
80106c67:	83 ec 08             	sub    $0x8,%esp
80106c6a:	50                   	push   %eax
80106c6b:	8d 45 08             	lea    0x8(%ebp),%eax
80106c6e:	50                   	push   %eax
80106c6f:	e8 5c 00 00 00       	call   80106cd0 <getcallerpcs>
80106c74:	83 c4 10             	add    $0x10,%esp
}
80106c77:	90                   	nop
80106c78:	c9                   	leave  
80106c79:	c3                   	ret    

80106c7a <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80106c7a:	f3 0f 1e fb          	endbr32 
80106c7e:	55                   	push   %ebp
80106c7f:	89 e5                	mov    %esp,%ebp
80106c81:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80106c84:	83 ec 0c             	sub    $0xc,%esp
80106c87:	ff 75 08             	pushl  0x8(%ebp)
80106c8a:	e8 c0 00 00 00       	call   80106d4f <holding>
80106c8f:	83 c4 10             	add    $0x10,%esp
80106c92:	85 c0                	test   %eax,%eax
80106c94:	75 0d                	jne    80106ca3 <release+0x29>
    panic("release");
80106c96:	83 ec 0c             	sub    $0xc,%esp
80106c99:	68 7c b0 10 80       	push   $0x8010b07c
80106c9e:	e8 f4 98 ff ff       	call   80100597 <panic>

  lk->pcs[0] = 0;
80106ca3:	8b 45 08             	mov    0x8(%ebp),%eax
80106ca6:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80106cad:	8b 45 08             	mov    0x8(%ebp),%eax
80106cb0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80106cb7:	8b 45 08             	mov    0x8(%ebp),%eax
80106cba:	83 ec 08             	sub    $0x8,%esp
80106cbd:	6a 00                	push   $0x0
80106cbf:	50                   	push   %eax
80106cc0:	e8 0a ff ff ff       	call   80106bcf <xchg>
80106cc5:	83 c4 10             	add    $0x10,%esp

  popcli();
80106cc8:	e8 f9 00 00 00       	call   80106dc6 <popcli>
}
80106ccd:	90                   	nop
80106cce:	c9                   	leave  
80106ccf:	c3                   	ret    

80106cd0 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80106cd0:	f3 0f 1e fb          	endbr32 
80106cd4:	55                   	push   %ebp
80106cd5:	89 e5                	mov    %esp,%ebp
80106cd7:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80106cda:	8b 45 08             	mov    0x8(%ebp),%eax
80106cdd:	83 e8 08             	sub    $0x8,%eax
80106ce0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80106ce3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80106cea:	eb 38                	jmp    80106d24 <getcallerpcs+0x54>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80106cec:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80106cf0:	74 53                	je     80106d45 <getcallerpcs+0x75>
80106cf2:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80106cf9:	76 4a                	jbe    80106d45 <getcallerpcs+0x75>
80106cfb:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80106cff:	74 44                	je     80106d45 <getcallerpcs+0x75>
      break;
    pcs[i] = ebp[1];     // saved %eip
80106d01:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106d04:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80106d0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d0e:	01 c2                	add    %eax,%edx
80106d10:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106d13:	8b 40 04             	mov    0x4(%eax),%eax
80106d16:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80106d18:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106d1b:	8b 00                	mov    (%eax),%eax
80106d1d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80106d20:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80106d24:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80106d28:	7e c2                	jle    80106cec <getcallerpcs+0x1c>
  }
  for(; i < 10; i++)
80106d2a:	eb 19                	jmp    80106d45 <getcallerpcs+0x75>
    pcs[i] = 0;
80106d2c:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106d2f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80106d36:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d39:	01 d0                	add    %edx,%eax
80106d3b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80106d41:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80106d45:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80106d49:	7e e1                	jle    80106d2c <getcallerpcs+0x5c>
}
80106d4b:	90                   	nop
80106d4c:	90                   	nop
80106d4d:	c9                   	leave  
80106d4e:	c3                   	ret    

80106d4f <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80106d4f:	f3 0f 1e fb          	endbr32 
80106d53:	55                   	push   %ebp
80106d54:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80106d56:	8b 45 08             	mov    0x8(%ebp),%eax
80106d59:	8b 00                	mov    (%eax),%eax
80106d5b:	85 c0                	test   %eax,%eax
80106d5d:	74 17                	je     80106d76 <holding+0x27>
80106d5f:	8b 45 08             	mov    0x8(%ebp),%eax
80106d62:	8b 50 08             	mov    0x8(%eax),%edx
80106d65:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106d6b:	39 c2                	cmp    %eax,%edx
80106d6d:	75 07                	jne    80106d76 <holding+0x27>
80106d6f:	b8 01 00 00 00       	mov    $0x1,%eax
80106d74:	eb 05                	jmp    80106d7b <holding+0x2c>
80106d76:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106d7b:	5d                   	pop    %ebp
80106d7c:	c3                   	ret    

80106d7d <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80106d7d:	f3 0f 1e fb          	endbr32 
80106d81:	55                   	push   %ebp
80106d82:	89 e5                	mov    %esp,%ebp
80106d84:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80106d87:	e8 25 fe ff ff       	call   80106bb1 <readeflags>
80106d8c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80106d8f:	e8 2d fe ff ff       	call   80106bc1 <cli>
  if(cpu->ncli++ == 0)
80106d94:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80106d9b:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80106da1:	8d 48 01             	lea    0x1(%eax),%ecx
80106da4:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
80106daa:	85 c0                	test   %eax,%eax
80106dac:	75 15                	jne    80106dc3 <pushcli+0x46>
    cpu->intena = eflags & FL_IF;
80106dae:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106db4:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106db7:	81 e2 00 02 00 00    	and    $0x200,%edx
80106dbd:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80106dc3:	90                   	nop
80106dc4:	c9                   	leave  
80106dc5:	c3                   	ret    

80106dc6 <popcli>:

void
popcli(void)
{
80106dc6:	f3 0f 1e fb          	endbr32 
80106dca:	55                   	push   %ebp
80106dcb:	89 e5                	mov    %esp,%ebp
80106dcd:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
80106dd0:	e8 dc fd ff ff       	call   80106bb1 <readeflags>
80106dd5:	25 00 02 00 00       	and    $0x200,%eax
80106dda:	85 c0                	test   %eax,%eax
80106ddc:	74 0d                	je     80106deb <popcli+0x25>
    panic("popcli - interruptible");
80106dde:	83 ec 0c             	sub    $0xc,%esp
80106de1:	68 84 b0 10 80       	push   $0x8010b084
80106de6:	e8 ac 97 ff ff       	call   80100597 <panic>
  if(--cpu->ncli < 0)
80106deb:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106df1:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80106df7:	83 ea 01             	sub    $0x1,%edx
80106dfa:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80106e00:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80106e06:	85 c0                	test   %eax,%eax
80106e08:	79 0d                	jns    80106e17 <popcli+0x51>
    panic("popcli");
80106e0a:	83 ec 0c             	sub    $0xc,%esp
80106e0d:	68 9b b0 10 80       	push   $0x8010b09b
80106e12:	e8 80 97 ff ff       	call   80100597 <panic>
  if(cpu->ncli == 0 && cpu->intena)
80106e17:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106e1d:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80106e23:	85 c0                	test   %eax,%eax
80106e25:	75 15                	jne    80106e3c <popcli+0x76>
80106e27:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106e2d:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80106e33:	85 c0                	test   %eax,%eax
80106e35:	74 05                	je     80106e3c <popcli+0x76>
    sti();
80106e37:	e8 8c fd ff ff       	call   80106bc8 <sti>
}
80106e3c:	90                   	nop
80106e3d:	c9                   	leave  
80106e3e:	c3                   	ret    

80106e3f <stosb>:
{
80106e3f:	55                   	push   %ebp
80106e40:	89 e5                	mov    %esp,%ebp
80106e42:	57                   	push   %edi
80106e43:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80106e44:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106e47:	8b 55 10             	mov    0x10(%ebp),%edx
80106e4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e4d:	89 cb                	mov    %ecx,%ebx
80106e4f:	89 df                	mov    %ebx,%edi
80106e51:	89 d1                	mov    %edx,%ecx
80106e53:	fc                   	cld    
80106e54:	f3 aa                	rep stos %al,%es:(%edi)
80106e56:	89 ca                	mov    %ecx,%edx
80106e58:	89 fb                	mov    %edi,%ebx
80106e5a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106e5d:	89 55 10             	mov    %edx,0x10(%ebp)
}
80106e60:	90                   	nop
80106e61:	5b                   	pop    %ebx
80106e62:	5f                   	pop    %edi
80106e63:	5d                   	pop    %ebp
80106e64:	c3                   	ret    

80106e65 <stosl>:
{
80106e65:	55                   	push   %ebp
80106e66:	89 e5                	mov    %esp,%ebp
80106e68:	57                   	push   %edi
80106e69:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80106e6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106e6d:	8b 55 10             	mov    0x10(%ebp),%edx
80106e70:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e73:	89 cb                	mov    %ecx,%ebx
80106e75:	89 df                	mov    %ebx,%edi
80106e77:	89 d1                	mov    %edx,%ecx
80106e79:	fc                   	cld    
80106e7a:	f3 ab                	rep stos %eax,%es:(%edi)
80106e7c:	89 ca                	mov    %ecx,%edx
80106e7e:	89 fb                	mov    %edi,%ebx
80106e80:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106e83:	89 55 10             	mov    %edx,0x10(%ebp)
}
80106e86:	90                   	nop
80106e87:	5b                   	pop    %ebx
80106e88:	5f                   	pop    %edi
80106e89:	5d                   	pop    %ebp
80106e8a:	c3                   	ret    

80106e8b <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80106e8b:	f3 0f 1e fb          	endbr32 
80106e8f:	55                   	push   %ebp
80106e90:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
80106e92:	8b 45 08             	mov    0x8(%ebp),%eax
80106e95:	83 e0 03             	and    $0x3,%eax
80106e98:	85 c0                	test   %eax,%eax
80106e9a:	75 43                	jne    80106edf <memset+0x54>
80106e9c:	8b 45 10             	mov    0x10(%ebp),%eax
80106e9f:	83 e0 03             	and    $0x3,%eax
80106ea2:	85 c0                	test   %eax,%eax
80106ea4:	75 39                	jne    80106edf <memset+0x54>
    c &= 0xFF;
80106ea6:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80106ead:	8b 45 10             	mov    0x10(%ebp),%eax
80106eb0:	c1 e8 02             	shr    $0x2,%eax
80106eb3:	89 c1                	mov    %eax,%ecx
80106eb5:	8b 45 0c             	mov    0xc(%ebp),%eax
80106eb8:	c1 e0 18             	shl    $0x18,%eax
80106ebb:	89 c2                	mov    %eax,%edx
80106ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ec0:	c1 e0 10             	shl    $0x10,%eax
80106ec3:	09 c2                	or     %eax,%edx
80106ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ec8:	c1 e0 08             	shl    $0x8,%eax
80106ecb:	09 d0                	or     %edx,%eax
80106ecd:	0b 45 0c             	or     0xc(%ebp),%eax
80106ed0:	51                   	push   %ecx
80106ed1:	50                   	push   %eax
80106ed2:	ff 75 08             	pushl  0x8(%ebp)
80106ed5:	e8 8b ff ff ff       	call   80106e65 <stosl>
80106eda:	83 c4 0c             	add    $0xc,%esp
80106edd:	eb 12                	jmp    80106ef1 <memset+0x66>
  } else
    stosb(dst, c, n);
80106edf:	8b 45 10             	mov    0x10(%ebp),%eax
80106ee2:	50                   	push   %eax
80106ee3:	ff 75 0c             	pushl  0xc(%ebp)
80106ee6:	ff 75 08             	pushl  0x8(%ebp)
80106ee9:	e8 51 ff ff ff       	call   80106e3f <stosb>
80106eee:	83 c4 0c             	add    $0xc,%esp
  return dst;
80106ef1:	8b 45 08             	mov    0x8(%ebp),%eax
}
80106ef4:	c9                   	leave  
80106ef5:	c3                   	ret    

80106ef6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80106ef6:	f3 0f 1e fb          	endbr32 
80106efa:	55                   	push   %ebp
80106efb:	89 e5                	mov    %esp,%ebp
80106efd:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
80106f00:	8b 45 08             	mov    0x8(%ebp),%eax
80106f03:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80106f06:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f09:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
80106f0c:	eb 30                	jmp    80106f3e <memcmp+0x48>
    if(*s1 != *s2)
80106f0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106f11:	0f b6 10             	movzbl (%eax),%edx
80106f14:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106f17:	0f b6 00             	movzbl (%eax),%eax
80106f1a:	38 c2                	cmp    %al,%dl
80106f1c:	74 18                	je     80106f36 <memcmp+0x40>
      return *s1 - *s2;
80106f1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106f21:	0f b6 00             	movzbl (%eax),%eax
80106f24:	0f b6 d0             	movzbl %al,%edx
80106f27:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106f2a:	0f b6 00             	movzbl (%eax),%eax
80106f2d:	0f b6 c0             	movzbl %al,%eax
80106f30:	29 c2                	sub    %eax,%edx
80106f32:	89 d0                	mov    %edx,%eax
80106f34:	eb 1a                	jmp    80106f50 <memcmp+0x5a>
    s1++, s2++;
80106f36:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80106f3a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  while(n-- > 0){
80106f3e:	8b 45 10             	mov    0x10(%ebp),%eax
80106f41:	8d 50 ff             	lea    -0x1(%eax),%edx
80106f44:	89 55 10             	mov    %edx,0x10(%ebp)
80106f47:	85 c0                	test   %eax,%eax
80106f49:	75 c3                	jne    80106f0e <memcmp+0x18>
  }

  return 0;
80106f4b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106f50:	c9                   	leave  
80106f51:	c3                   	ret    

80106f52 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80106f52:	f3 0f 1e fb          	endbr32 
80106f56:	55                   	push   %ebp
80106f57:	89 e5                	mov    %esp,%ebp
80106f59:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80106f5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f5f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80106f62:	8b 45 08             	mov    0x8(%ebp),%eax
80106f65:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80106f68:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106f6b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80106f6e:	73 54                	jae    80106fc4 <memmove+0x72>
80106f70:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106f73:	8b 45 10             	mov    0x10(%ebp),%eax
80106f76:	01 d0                	add    %edx,%eax
80106f78:	39 45 f8             	cmp    %eax,-0x8(%ebp)
80106f7b:	73 47                	jae    80106fc4 <memmove+0x72>
    s += n;
80106f7d:	8b 45 10             	mov    0x10(%ebp),%eax
80106f80:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80106f83:	8b 45 10             	mov    0x10(%ebp),%eax
80106f86:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80106f89:	eb 13                	jmp    80106f9e <memmove+0x4c>
      *--d = *--s;
80106f8b:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80106f8f:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80106f93:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106f96:	0f b6 10             	movzbl (%eax),%edx
80106f99:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106f9c:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80106f9e:	8b 45 10             	mov    0x10(%ebp),%eax
80106fa1:	8d 50 ff             	lea    -0x1(%eax),%edx
80106fa4:	89 55 10             	mov    %edx,0x10(%ebp)
80106fa7:	85 c0                	test   %eax,%eax
80106fa9:	75 e0                	jne    80106f8b <memmove+0x39>
  if(s < d && s + n > d){
80106fab:	eb 24                	jmp    80106fd1 <memmove+0x7f>
  } else
    while(n-- > 0)
      *d++ = *s++;
80106fad:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106fb0:	8d 42 01             	lea    0x1(%edx),%eax
80106fb3:	89 45 fc             	mov    %eax,-0x4(%ebp)
80106fb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106fb9:	8d 48 01             	lea    0x1(%eax),%ecx
80106fbc:	89 4d f8             	mov    %ecx,-0x8(%ebp)
80106fbf:	0f b6 12             	movzbl (%edx),%edx
80106fc2:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80106fc4:	8b 45 10             	mov    0x10(%ebp),%eax
80106fc7:	8d 50 ff             	lea    -0x1(%eax),%edx
80106fca:	89 55 10             	mov    %edx,0x10(%ebp)
80106fcd:	85 c0                	test   %eax,%eax
80106fcf:	75 dc                	jne    80106fad <memmove+0x5b>

  return dst;
80106fd1:	8b 45 08             	mov    0x8(%ebp),%eax
}
80106fd4:	c9                   	leave  
80106fd5:	c3                   	ret    

80106fd6 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80106fd6:	f3 0f 1e fb          	endbr32 
80106fda:	55                   	push   %ebp
80106fdb:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80106fdd:	ff 75 10             	pushl  0x10(%ebp)
80106fe0:	ff 75 0c             	pushl  0xc(%ebp)
80106fe3:	ff 75 08             	pushl  0x8(%ebp)
80106fe6:	e8 67 ff ff ff       	call   80106f52 <memmove>
80106feb:	83 c4 0c             	add    $0xc,%esp
}
80106fee:	c9                   	leave  
80106fef:	c3                   	ret    

80106ff0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80106ff0:	f3 0f 1e fb          	endbr32 
80106ff4:	55                   	push   %ebp
80106ff5:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80106ff7:	eb 0c                	jmp    80107005 <strncmp+0x15>
    n--, p++, q++;
80106ff9:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80106ffd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80107001:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(n > 0 && *p && *p == *q)
80107005:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107009:	74 1a                	je     80107025 <strncmp+0x35>
8010700b:	8b 45 08             	mov    0x8(%ebp),%eax
8010700e:	0f b6 00             	movzbl (%eax),%eax
80107011:	84 c0                	test   %al,%al
80107013:	74 10                	je     80107025 <strncmp+0x35>
80107015:	8b 45 08             	mov    0x8(%ebp),%eax
80107018:	0f b6 10             	movzbl (%eax),%edx
8010701b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010701e:	0f b6 00             	movzbl (%eax),%eax
80107021:	38 c2                	cmp    %al,%dl
80107023:	74 d4                	je     80106ff9 <strncmp+0x9>
  if(n == 0)
80107025:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107029:	75 07                	jne    80107032 <strncmp+0x42>
    return 0;
8010702b:	b8 00 00 00 00       	mov    $0x0,%eax
80107030:	eb 16                	jmp    80107048 <strncmp+0x58>
  return (uchar)*p - (uchar)*q;
80107032:	8b 45 08             	mov    0x8(%ebp),%eax
80107035:	0f b6 00             	movzbl (%eax),%eax
80107038:	0f b6 d0             	movzbl %al,%edx
8010703b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010703e:	0f b6 00             	movzbl (%eax),%eax
80107041:	0f b6 c0             	movzbl %al,%eax
80107044:	29 c2                	sub    %eax,%edx
80107046:	89 d0                	mov    %edx,%eax
}
80107048:	5d                   	pop    %ebp
80107049:	c3                   	ret    

8010704a <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
8010704a:	f3 0f 1e fb          	endbr32 
8010704e:	55                   	push   %ebp
8010704f:	89 e5                	mov    %esp,%ebp
80107051:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80107054:	8b 45 08             	mov    0x8(%ebp),%eax
80107057:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010705a:	90                   	nop
8010705b:	8b 45 10             	mov    0x10(%ebp),%eax
8010705e:	8d 50 ff             	lea    -0x1(%eax),%edx
80107061:	89 55 10             	mov    %edx,0x10(%ebp)
80107064:	85 c0                	test   %eax,%eax
80107066:	7e 2c                	jle    80107094 <strncpy+0x4a>
80107068:	8b 55 0c             	mov    0xc(%ebp),%edx
8010706b:	8d 42 01             	lea    0x1(%edx),%eax
8010706e:	89 45 0c             	mov    %eax,0xc(%ebp)
80107071:	8b 45 08             	mov    0x8(%ebp),%eax
80107074:	8d 48 01             	lea    0x1(%eax),%ecx
80107077:	89 4d 08             	mov    %ecx,0x8(%ebp)
8010707a:	0f b6 12             	movzbl (%edx),%edx
8010707d:	88 10                	mov    %dl,(%eax)
8010707f:	0f b6 00             	movzbl (%eax),%eax
80107082:	84 c0                	test   %al,%al
80107084:	75 d5                	jne    8010705b <strncpy+0x11>
    ;
  while(n-- > 0)
80107086:	eb 0c                	jmp    80107094 <strncpy+0x4a>
    *s++ = 0;
80107088:	8b 45 08             	mov    0x8(%ebp),%eax
8010708b:	8d 50 01             	lea    0x1(%eax),%edx
8010708e:	89 55 08             	mov    %edx,0x8(%ebp)
80107091:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
80107094:	8b 45 10             	mov    0x10(%ebp),%eax
80107097:	8d 50 ff             	lea    -0x1(%eax),%edx
8010709a:	89 55 10             	mov    %edx,0x10(%ebp)
8010709d:	85 c0                	test   %eax,%eax
8010709f:	7f e7                	jg     80107088 <strncpy+0x3e>
  return os;
801070a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801070a4:	c9                   	leave  
801070a5:	c3                   	ret    

801070a6 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801070a6:	f3 0f 1e fb          	endbr32 
801070aa:	55                   	push   %ebp
801070ab:	89 e5                	mov    %esp,%ebp
801070ad:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801070b0:	8b 45 08             	mov    0x8(%ebp),%eax
801070b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
801070b6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801070ba:	7f 05                	jg     801070c1 <safestrcpy+0x1b>
    return os;
801070bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
801070bf:	eb 31                	jmp    801070f2 <safestrcpy+0x4c>
  while(--n > 0 && (*s++ = *t++) != 0)
801070c1:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801070c5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801070c9:	7e 1e                	jle    801070e9 <safestrcpy+0x43>
801070cb:	8b 55 0c             	mov    0xc(%ebp),%edx
801070ce:	8d 42 01             	lea    0x1(%edx),%eax
801070d1:	89 45 0c             	mov    %eax,0xc(%ebp)
801070d4:	8b 45 08             	mov    0x8(%ebp),%eax
801070d7:	8d 48 01             	lea    0x1(%eax),%ecx
801070da:	89 4d 08             	mov    %ecx,0x8(%ebp)
801070dd:	0f b6 12             	movzbl (%edx),%edx
801070e0:	88 10                	mov    %dl,(%eax)
801070e2:	0f b6 00             	movzbl (%eax),%eax
801070e5:	84 c0                	test   %al,%al
801070e7:	75 d8                	jne    801070c1 <safestrcpy+0x1b>
    ;
  *s = 0;
801070e9:	8b 45 08             	mov    0x8(%ebp),%eax
801070ec:	c6 00 00             	movb   $0x0,(%eax)
  return os;
801070ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801070f2:	c9                   	leave  
801070f3:	c3                   	ret    

801070f4 <strlen>:

int
strlen(const char *s)
{
801070f4:	f3 0f 1e fb          	endbr32 
801070f8:	55                   	push   %ebp
801070f9:	89 e5                	mov    %esp,%ebp
801070fb:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
801070fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80107105:	eb 04                	jmp    8010710b <strlen+0x17>
80107107:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010710b:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010710e:	8b 45 08             	mov    0x8(%ebp),%eax
80107111:	01 d0                	add    %edx,%eax
80107113:	0f b6 00             	movzbl (%eax),%eax
80107116:	84 c0                	test   %al,%al
80107118:	75 ed                	jne    80107107 <strlen+0x13>
    ;
  return n;
8010711a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010711d:	c9                   	leave  
8010711e:	c3                   	ret    

8010711f <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010711f:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80107123:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80107127:	55                   	push   %ebp
  pushl %ebx
80107128:	53                   	push   %ebx
  pushl %esi
80107129:	56                   	push   %esi
  pushl %edi
8010712a:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
8010712b:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
8010712d:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010712f:	5f                   	pop    %edi
  popl %esi
80107130:	5e                   	pop    %esi
  popl %ebx
80107131:	5b                   	pop    %ebx
  popl %ebp
80107132:	5d                   	pop    %ebp
  ret
80107133:	c3                   	ret    

80107134 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80107134:	f3 0f 1e fb          	endbr32 
80107138:	55                   	push   %ebp
80107139:	89 e5                	mov    %esp,%ebp
    if(addr >= proc->sz || addr+4 > proc->sz)
8010713b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107141:	8b 00                	mov    (%eax),%eax
80107143:	39 45 08             	cmp    %eax,0x8(%ebp)
80107146:	73 12                	jae    8010715a <fetchint+0x26>
80107148:	8b 45 08             	mov    0x8(%ebp),%eax
8010714b:	8d 50 04             	lea    0x4(%eax),%edx
8010714e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107154:	8b 00                	mov    (%eax),%eax
80107156:	39 c2                	cmp    %eax,%edx
80107158:	76 07                	jbe    80107161 <fetchint+0x2d>
        return -1;
8010715a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010715f:	eb 0f                	jmp    80107170 <fetchint+0x3c>
    *ip = *(int*)(addr);
80107161:	8b 45 08             	mov    0x8(%ebp),%eax
80107164:	8b 10                	mov    (%eax),%edx
80107166:	8b 45 0c             	mov    0xc(%ebp),%eax
80107169:	89 10                	mov    %edx,(%eax)
    return 0;
8010716b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107170:	5d                   	pop    %ebp
80107171:	c3                   	ret    

80107172 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80107172:	f3 0f 1e fb          	endbr32 
80107176:	55                   	push   %ebp
80107177:	89 e5                	mov    %esp,%ebp
80107179:	83 ec 10             	sub    $0x10,%esp
    char *s, *ep;

    if(addr >= proc->sz)
8010717c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107182:	8b 00                	mov    (%eax),%eax
80107184:	39 45 08             	cmp    %eax,0x8(%ebp)
80107187:	72 07                	jb     80107190 <fetchstr+0x1e>
        return -1;
80107189:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010718e:	eb 46                	jmp    801071d6 <fetchstr+0x64>
    *pp = (char*)addr;
80107190:	8b 55 08             	mov    0x8(%ebp),%edx
80107193:	8b 45 0c             	mov    0xc(%ebp),%eax
80107196:	89 10                	mov    %edx,(%eax)
    ep = (char*)proc->sz;
80107198:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010719e:	8b 00                	mov    (%eax),%eax
801071a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
    for(s = *pp; s < ep; s++)
801071a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801071a6:	8b 00                	mov    (%eax),%eax
801071a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
801071ab:	eb 1c                	jmp    801071c9 <fetchstr+0x57>
        if(*s == 0)
801071ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
801071b0:	0f b6 00             	movzbl (%eax),%eax
801071b3:	84 c0                	test   %al,%al
801071b5:	75 0e                	jne    801071c5 <fetchstr+0x53>
            return s - *pp;
801071b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801071ba:	8b 00                	mov    (%eax),%eax
801071bc:	8b 55 fc             	mov    -0x4(%ebp),%edx
801071bf:	29 c2                	sub    %eax,%edx
801071c1:	89 d0                	mov    %edx,%eax
801071c3:	eb 11                	jmp    801071d6 <fetchstr+0x64>
    for(s = *pp; s < ep; s++)
801071c5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801071c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801071cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801071cf:	72 dc                	jb     801071ad <fetchstr+0x3b>
    return -1;
801071d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801071d6:	c9                   	leave  
801071d7:	c3                   	ret    

801071d8 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801071d8:	f3 0f 1e fb          	endbr32 
801071dc:	55                   	push   %ebp
801071dd:	89 e5                	mov    %esp,%ebp
    return fetchint(proc->tf->esp + 4 + 4*n, ip);
801071df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801071e5:	8b 40 18             	mov    0x18(%eax),%eax
801071e8:	8b 40 44             	mov    0x44(%eax),%eax
801071eb:	8b 55 08             	mov    0x8(%ebp),%edx
801071ee:	c1 e2 02             	shl    $0x2,%edx
801071f1:	01 d0                	add    %edx,%eax
801071f3:	83 c0 04             	add    $0x4,%eax
801071f6:	ff 75 0c             	pushl  0xc(%ebp)
801071f9:	50                   	push   %eax
801071fa:	e8 35 ff ff ff       	call   80107134 <fetchint>
801071ff:	83 c4 08             	add    $0x8,%esp
}
80107202:	c9                   	leave  
80107203:	c3                   	ret    

80107204 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80107204:	f3 0f 1e fb          	endbr32 
80107208:	55                   	push   %ebp
80107209:	89 e5                	mov    %esp,%ebp
8010720b:	83 ec 10             	sub    $0x10,%esp
    int i;

    if(argint(n, &i) < 0)
8010720e:	8d 45 fc             	lea    -0x4(%ebp),%eax
80107211:	50                   	push   %eax
80107212:	ff 75 08             	pushl  0x8(%ebp)
80107215:	e8 be ff ff ff       	call   801071d8 <argint>
8010721a:	83 c4 08             	add    $0x8,%esp
8010721d:	85 c0                	test   %eax,%eax
8010721f:	79 07                	jns    80107228 <argptr+0x24>
        return -1;
80107221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107226:	eb 3b                	jmp    80107263 <argptr+0x5f>
    if((uint)i >= proc->sz || (uint)i+size > proc->sz)
80107228:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010722e:	8b 00                	mov    (%eax),%eax
80107230:	8b 55 fc             	mov    -0x4(%ebp),%edx
80107233:	39 d0                	cmp    %edx,%eax
80107235:	76 16                	jbe    8010724d <argptr+0x49>
80107237:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010723a:	89 c2                	mov    %eax,%edx
8010723c:	8b 45 10             	mov    0x10(%ebp),%eax
8010723f:	01 c2                	add    %eax,%edx
80107241:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107247:	8b 00                	mov    (%eax),%eax
80107249:	39 c2                	cmp    %eax,%edx
8010724b:	76 07                	jbe    80107254 <argptr+0x50>
        return -1;
8010724d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107252:	eb 0f                	jmp    80107263 <argptr+0x5f>
    *pp = (char*)i;
80107254:	8b 45 fc             	mov    -0x4(%ebp),%eax
80107257:	89 c2                	mov    %eax,%edx
80107259:	8b 45 0c             	mov    0xc(%ebp),%eax
8010725c:	89 10                	mov    %edx,(%eax)
    return 0;
8010725e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107263:	c9                   	leave  
80107264:	c3                   	ret    

80107265 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80107265:	f3 0f 1e fb          	endbr32 
80107269:	55                   	push   %ebp
8010726a:	89 e5                	mov    %esp,%ebp
8010726c:	83 ec 10             	sub    $0x10,%esp
    int addr;
    if(argint(n, &addr) < 0)
8010726f:	8d 45 fc             	lea    -0x4(%ebp),%eax
80107272:	50                   	push   %eax
80107273:	ff 75 08             	pushl  0x8(%ebp)
80107276:	e8 5d ff ff ff       	call   801071d8 <argint>
8010727b:	83 c4 08             	add    $0x8,%esp
8010727e:	85 c0                	test   %eax,%eax
80107280:	79 07                	jns    80107289 <argstr+0x24>
        return -1;
80107282:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107287:	eb 0f                	jmp    80107298 <argstr+0x33>
    return fetchstr(addr, pp);
80107289:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010728c:	ff 75 0c             	pushl  0xc(%ebp)
8010728f:	50                   	push   %eax
80107290:	e8 dd fe ff ff       	call   80107172 <fetchstr>
80107295:	83 c4 08             	add    $0x8,%esp
}
80107298:	c9                   	leave  
80107299:	c3                   	ret    

8010729a <syscall>:
#endif
};

void
syscall(void)
{
8010729a:	f3 0f 1e fb          	endbr32 
8010729e:	55                   	push   %ebp
8010729f:	89 e5                	mov    %esp,%ebp
801072a1:	83 ec 18             	sub    $0x18,%esp
    int num;

    num = proc->tf->eax;
801072a4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801072aa:	8b 40 18             	mov    0x18(%eax),%eax
801072ad:	8b 40 1c             	mov    0x1c(%eax),%eax
801072b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801072b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801072b7:	7e 32                	jle    801072eb <syscall+0x51>
801072b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801072bc:	83 f8 1f             	cmp    $0x1f,%eax
801072bf:	77 2a                	ja     801072eb <syscall+0x51>
801072c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801072c4:	8b 04 85 40 e0 10 80 	mov    -0x7fef1fc0(,%eax,4),%eax
801072cb:	85 c0                	test   %eax,%eax
801072cd:	74 1c                	je     801072eb <syscall+0x51>
        proc->tf->eax = syscalls[num]();
801072cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801072d2:	8b 04 85 40 e0 10 80 	mov    -0x7fef1fc0(,%eax,4),%eax
801072d9:	ff d0                	call   *%eax
801072db:	89 c2                	mov    %eax,%edx
801072dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801072e3:	8b 40 18             	mov    0x18(%eax),%eax
801072e6:	89 50 1c             	mov    %edx,0x1c(%eax)
801072e9:	eb 35                	jmp    80107320 <syscall+0x86>
    } else {
        cprintf("%d %s: unknown sys call %d\n",
                proc->pid, proc->name, num);
801072eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801072f1:	8d 50 6c             	lea    0x6c(%eax),%edx
801072f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
        cprintf("%d %s: unknown sys call %d\n",
801072fa:	8b 40 10             	mov    0x10(%eax),%eax
801072fd:	ff 75 f4             	pushl  -0xc(%ebp)
80107300:	52                   	push   %edx
80107301:	50                   	push   %eax
80107302:	68 a2 b0 10 80       	push   $0x8010b0a2
80107307:	e8 d2 90 ff ff       	call   801003de <cprintf>
8010730c:	83 c4 10             	add    $0x10,%esp
        proc->tf->eax = -1;
8010730f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107315:	8b 40 18             	mov    0x18(%eax),%eax
80107318:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
    }
}
8010731f:	90                   	nop
80107320:	90                   	nop
80107321:	c9                   	leave  
80107322:	c3                   	ret    

80107323 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80107323:	f3 0f 1e fb          	endbr32 
80107327:	55                   	push   %ebp
80107328:	89 e5                	mov    %esp,%ebp
8010732a:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010732d:	83 ec 08             	sub    $0x8,%esp
80107330:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107333:	50                   	push   %eax
80107334:	ff 75 08             	pushl  0x8(%ebp)
80107337:	e8 9c fe ff ff       	call   801071d8 <argint>
8010733c:	83 c4 10             	add    $0x10,%esp
8010733f:	85 c0                	test   %eax,%eax
80107341:	79 07                	jns    8010734a <argfd+0x27>
    return -1;
80107343:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107348:	eb 50                	jmp    8010739a <argfd+0x77>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010734a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010734d:	85 c0                	test   %eax,%eax
8010734f:	78 21                	js     80107372 <argfd+0x4f>
80107351:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107354:	83 f8 0f             	cmp    $0xf,%eax
80107357:	7f 19                	jg     80107372 <argfd+0x4f>
80107359:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010735f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107362:	83 c2 08             	add    $0x8,%edx
80107365:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80107369:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010736c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107370:	75 07                	jne    80107379 <argfd+0x56>
    return -1;
80107372:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107377:	eb 21                	jmp    8010739a <argfd+0x77>
  if(pfd)
80107379:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010737d:	74 08                	je     80107387 <argfd+0x64>
    *pfd = fd;
8010737f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107382:	8b 45 0c             	mov    0xc(%ebp),%eax
80107385:	89 10                	mov    %edx,(%eax)
  if(pf)
80107387:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010738b:	74 08                	je     80107395 <argfd+0x72>
    *pf = f;
8010738d:	8b 45 10             	mov    0x10(%ebp),%eax
80107390:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107393:	89 10                	mov    %edx,(%eax)
  return 0;
80107395:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010739a:	c9                   	leave  
8010739b:	c3                   	ret    

8010739c <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
8010739c:	f3 0f 1e fb          	endbr32 
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801073a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801073ad:	eb 30                	jmp    801073df <fdalloc+0x43>
    if(proc->ofile[fd] == 0){
801073af:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801073b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
801073b8:	83 c2 08             	add    $0x8,%edx
801073bb:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801073bf:	85 c0                	test   %eax,%eax
801073c1:	75 18                	jne    801073db <fdalloc+0x3f>
      proc->ofile[fd] = f;
801073c3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801073c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
801073cc:	8d 4a 08             	lea    0x8(%edx),%ecx
801073cf:	8b 55 08             	mov    0x8(%ebp),%edx
801073d2:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801073d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
801073d9:	eb 0f                	jmp    801073ea <fdalloc+0x4e>
  for(fd = 0; fd < NOFILE; fd++){
801073db:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801073df:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
801073e3:	7e ca                	jle    801073af <fdalloc+0x13>
    }
  }
  return -1;
801073e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073ea:	c9                   	leave  
801073eb:	c3                   	ret    

801073ec <sys_dup>:

int
sys_dup(void)
{
801073ec:	f3 0f 1e fb          	endbr32 
801073f0:	55                   	push   %ebp
801073f1:	89 e5                	mov    %esp,%ebp
801073f3:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
801073f6:	83 ec 04             	sub    $0x4,%esp
801073f9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801073fc:	50                   	push   %eax
801073fd:	6a 00                	push   $0x0
801073ff:	6a 00                	push   $0x0
80107401:	e8 1d ff ff ff       	call   80107323 <argfd>
80107406:	83 c4 10             	add    $0x10,%esp
80107409:	85 c0                	test   %eax,%eax
8010740b:	79 07                	jns    80107414 <sys_dup+0x28>
    return -1;
8010740d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107412:	eb 31                	jmp    80107445 <sys_dup+0x59>
  if((fd=fdalloc(f)) < 0)
80107414:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107417:	83 ec 0c             	sub    $0xc,%esp
8010741a:	50                   	push   %eax
8010741b:	e8 7c ff ff ff       	call   8010739c <fdalloc>
80107420:	83 c4 10             	add    $0x10,%esp
80107423:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107426:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010742a:	79 07                	jns    80107433 <sys_dup+0x47>
    return -1;
8010742c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107431:	eb 12                	jmp    80107445 <sys_dup+0x59>
  filedup(f);
80107433:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107436:	83 ec 0c             	sub    $0xc,%esp
80107439:	50                   	push   %eax
8010743a:	e8 47 9d ff ff       	call   80101186 <filedup>
8010743f:	83 c4 10             	add    $0x10,%esp
  return fd;
80107442:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80107445:	c9                   	leave  
80107446:	c3                   	ret    

80107447 <sys_read>:

int
sys_read(void)
{
80107447:	f3 0f 1e fb          	endbr32 
8010744b:	55                   	push   %ebp
8010744c:	89 e5                	mov    %esp,%ebp
8010744e:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80107451:	83 ec 04             	sub    $0x4,%esp
80107454:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107457:	50                   	push   %eax
80107458:	6a 00                	push   $0x0
8010745a:	6a 00                	push   $0x0
8010745c:	e8 c2 fe ff ff       	call   80107323 <argfd>
80107461:	83 c4 10             	add    $0x10,%esp
80107464:	85 c0                	test   %eax,%eax
80107466:	78 2e                	js     80107496 <sys_read+0x4f>
80107468:	83 ec 08             	sub    $0x8,%esp
8010746b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010746e:	50                   	push   %eax
8010746f:	6a 02                	push   $0x2
80107471:	e8 62 fd ff ff       	call   801071d8 <argint>
80107476:	83 c4 10             	add    $0x10,%esp
80107479:	85 c0                	test   %eax,%eax
8010747b:	78 19                	js     80107496 <sys_read+0x4f>
8010747d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107480:	83 ec 04             	sub    $0x4,%esp
80107483:	50                   	push   %eax
80107484:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107487:	50                   	push   %eax
80107488:	6a 01                	push   $0x1
8010748a:	e8 75 fd ff ff       	call   80107204 <argptr>
8010748f:	83 c4 10             	add    $0x10,%esp
80107492:	85 c0                	test   %eax,%eax
80107494:	79 07                	jns    8010749d <sys_read+0x56>
    return -1;
80107496:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010749b:	eb 17                	jmp    801074b4 <sys_read+0x6d>
  return fileread(f, p, n);
8010749d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801074a0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801074a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074a6:	83 ec 04             	sub    $0x4,%esp
801074a9:	51                   	push   %ecx
801074aa:	52                   	push   %edx
801074ab:	50                   	push   %eax
801074ac:	e8 71 9e ff ff       	call   80101322 <fileread>
801074b1:	83 c4 10             	add    $0x10,%esp
}
801074b4:	c9                   	leave  
801074b5:	c3                   	ret    

801074b6 <sys_write>:

int
sys_write(void)
{
801074b6:	f3 0f 1e fb          	endbr32 
801074ba:	55                   	push   %ebp
801074bb:	89 e5                	mov    %esp,%ebp
801074bd:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801074c0:	83 ec 04             	sub    $0x4,%esp
801074c3:	8d 45 f4             	lea    -0xc(%ebp),%eax
801074c6:	50                   	push   %eax
801074c7:	6a 00                	push   $0x0
801074c9:	6a 00                	push   $0x0
801074cb:	e8 53 fe ff ff       	call   80107323 <argfd>
801074d0:	83 c4 10             	add    $0x10,%esp
801074d3:	85 c0                	test   %eax,%eax
801074d5:	78 2e                	js     80107505 <sys_write+0x4f>
801074d7:	83 ec 08             	sub    $0x8,%esp
801074da:	8d 45 f0             	lea    -0x10(%ebp),%eax
801074dd:	50                   	push   %eax
801074de:	6a 02                	push   $0x2
801074e0:	e8 f3 fc ff ff       	call   801071d8 <argint>
801074e5:	83 c4 10             	add    $0x10,%esp
801074e8:	85 c0                	test   %eax,%eax
801074ea:	78 19                	js     80107505 <sys_write+0x4f>
801074ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801074ef:	83 ec 04             	sub    $0x4,%esp
801074f2:	50                   	push   %eax
801074f3:	8d 45 ec             	lea    -0x14(%ebp),%eax
801074f6:	50                   	push   %eax
801074f7:	6a 01                	push   $0x1
801074f9:	e8 06 fd ff ff       	call   80107204 <argptr>
801074fe:	83 c4 10             	add    $0x10,%esp
80107501:	85 c0                	test   %eax,%eax
80107503:	79 07                	jns    8010750c <sys_write+0x56>
    return -1;
80107505:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010750a:	eb 17                	jmp    80107523 <sys_write+0x6d>
  return filewrite(f, p, n);
8010750c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010750f:	8b 55 ec             	mov    -0x14(%ebp),%edx
80107512:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107515:	83 ec 04             	sub    $0x4,%esp
80107518:	51                   	push   %ecx
80107519:	52                   	push   %edx
8010751a:	50                   	push   %eax
8010751b:	e8 be 9e ff ff       	call   801013de <filewrite>
80107520:	83 c4 10             	add    $0x10,%esp
}
80107523:	c9                   	leave  
80107524:	c3                   	ret    

80107525 <sys_close>:

int
sys_close(void)
{
80107525:	f3 0f 1e fb          	endbr32 
80107529:	55                   	push   %ebp
8010752a:	89 e5                	mov    %esp,%ebp
8010752c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
8010752f:	83 ec 04             	sub    $0x4,%esp
80107532:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107535:	50                   	push   %eax
80107536:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107539:	50                   	push   %eax
8010753a:	6a 00                	push   $0x0
8010753c:	e8 e2 fd ff ff       	call   80107323 <argfd>
80107541:	83 c4 10             	add    $0x10,%esp
80107544:	85 c0                	test   %eax,%eax
80107546:	79 07                	jns    8010754f <sys_close+0x2a>
    return -1;
80107548:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010754d:	eb 28                	jmp    80107577 <sys_close+0x52>
  proc->ofile[fd] = 0;
8010754f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107555:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107558:	83 c2 08             	add    $0x8,%edx
8010755b:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80107562:	00 
  fileclose(f);
80107563:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107566:	83 ec 0c             	sub    $0xc,%esp
80107569:	50                   	push   %eax
8010756a:	e8 6c 9c ff ff       	call   801011db <fileclose>
8010756f:	83 c4 10             	add    $0x10,%esp
  return 0;
80107572:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107577:	c9                   	leave  
80107578:	c3                   	ret    

80107579 <sys_fstat>:

int
sys_fstat(void)
{
80107579:	f3 0f 1e fb          	endbr32 
8010757d:	55                   	push   %ebp
8010757e:	89 e5                	mov    %esp,%ebp
80107580:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80107583:	83 ec 04             	sub    $0x4,%esp
80107586:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107589:	50                   	push   %eax
8010758a:	6a 00                	push   $0x0
8010758c:	6a 00                	push   $0x0
8010758e:	e8 90 fd ff ff       	call   80107323 <argfd>
80107593:	83 c4 10             	add    $0x10,%esp
80107596:	85 c0                	test   %eax,%eax
80107598:	78 17                	js     801075b1 <sys_fstat+0x38>
8010759a:	83 ec 04             	sub    $0x4,%esp
8010759d:	6a 20                	push   $0x20
8010759f:	8d 45 f0             	lea    -0x10(%ebp),%eax
801075a2:	50                   	push   %eax
801075a3:	6a 01                	push   $0x1
801075a5:	e8 5a fc ff ff       	call   80107204 <argptr>
801075aa:	83 c4 10             	add    $0x10,%esp
801075ad:	85 c0                	test   %eax,%eax
801075af:	79 07                	jns    801075b8 <sys_fstat+0x3f>
    return -1;
801075b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801075b6:	eb 13                	jmp    801075cb <sys_fstat+0x52>
  return filestat(f, st);
801075b8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801075bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075be:	83 ec 08             	sub    $0x8,%esp
801075c1:	52                   	push   %edx
801075c2:	50                   	push   %eax
801075c3:	e8 ff 9c ff ff       	call   801012c7 <filestat>
801075c8:	83 c4 10             	add    $0x10,%esp
}
801075cb:	c9                   	leave  
801075cc:	c3                   	ret    

801075cd <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801075cd:	f3 0f 1e fb          	endbr32 
801075d1:	55                   	push   %ebp
801075d2:	89 e5                	mov    %esp,%ebp
801075d4:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801075d7:	83 ec 08             	sub    $0x8,%esp
801075da:	8d 45 d8             	lea    -0x28(%ebp),%eax
801075dd:	50                   	push   %eax
801075de:	6a 00                	push   $0x0
801075e0:	e8 80 fc ff ff       	call   80107265 <argstr>
801075e5:	83 c4 10             	add    $0x10,%esp
801075e8:	85 c0                	test   %eax,%eax
801075ea:	78 15                	js     80107601 <sys_link+0x34>
801075ec:	83 ec 08             	sub    $0x8,%esp
801075ef:	8d 45 dc             	lea    -0x24(%ebp),%eax
801075f2:	50                   	push   %eax
801075f3:	6a 01                	push   $0x1
801075f5:	e8 6b fc ff ff       	call   80107265 <argstr>
801075fa:	83 c4 10             	add    $0x10,%esp
801075fd:	85 c0                	test   %eax,%eax
801075ff:	79 0a                	jns    8010760b <sys_link+0x3e>
    return -1;
80107601:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107606:	e9 68 01 00 00       	jmp    80107773 <sys_link+0x1a6>

  begin_op();
8010760b:	e8 d6 c2 ff ff       	call   801038e6 <begin_op>
  if((ip = namei(old)) == 0){
80107610:	8b 45 d8             	mov    -0x28(%ebp),%eax
80107613:	83 ec 0c             	sub    $0xc,%esp
80107616:	50                   	push   %eax
80107617:	e8 97 b1 ff ff       	call   801027b3 <namei>
8010761c:	83 c4 10             	add    $0x10,%esp
8010761f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107622:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107626:	75 0f                	jne    80107637 <sys_link+0x6a>
    end_op();
80107628:	e8 49 c3 ff ff       	call   80103976 <end_op>
    return -1;
8010762d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107632:	e9 3c 01 00 00       	jmp    80107773 <sys_link+0x1a6>
  }

  ilock(ip);
80107637:	83 ec 0c             	sub    $0xc,%esp
8010763a:	ff 75 f4             	pushl  -0xc(%ebp)
8010763d:	e8 2e a5 ff ff       	call   80101b70 <ilock>
80107642:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80107645:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107648:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010764c:	66 83 f8 01          	cmp    $0x1,%ax
80107650:	75 1d                	jne    8010766f <sys_link+0xa2>
    iunlockput(ip);
80107652:	83 ec 0c             	sub    $0xc,%esp
80107655:	ff 75 f4             	pushl  -0xc(%ebp)
80107658:	e8 03 a8 ff ff       	call   80101e60 <iunlockput>
8010765d:	83 c4 10             	add    $0x10,%esp
    end_op();
80107660:	e8 11 c3 ff ff       	call   80103976 <end_op>
    return -1;
80107665:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010766a:	e9 04 01 00 00       	jmp    80107773 <sys_link+0x1a6>
  }

  ip->nlink++;
8010766f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107672:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80107676:	83 c0 01             	add    $0x1,%eax
80107679:	89 c2                	mov    %eax,%edx
8010767b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010767e:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80107682:	83 ec 0c             	sub    $0xc,%esp
80107685:	ff 75 f4             	pushl  -0xc(%ebp)
80107688:	e8 d6 a2 ff ff       	call   80101963 <iupdate>
8010768d:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80107690:	83 ec 0c             	sub    $0xc,%esp
80107693:	ff 75 f4             	pushl  -0xc(%ebp)
80107696:	e8 5b a6 ff ff       	call   80101cf6 <iunlock>
8010769b:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
8010769e:	8b 45 dc             	mov    -0x24(%ebp),%eax
801076a1:	83 ec 08             	sub    $0x8,%esp
801076a4:	8d 55 e2             	lea    -0x1e(%ebp),%edx
801076a7:	52                   	push   %edx
801076a8:	50                   	push   %eax
801076a9:	e8 25 b1 ff ff       	call   801027d3 <nameiparent>
801076ae:	83 c4 10             	add    $0x10,%esp
801076b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
801076b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801076b8:	74 71                	je     8010772b <sys_link+0x15e>
    goto bad;
  ilock(dp);
801076ba:	83 ec 0c             	sub    $0xc,%esp
801076bd:	ff 75 f0             	pushl  -0x10(%ebp)
801076c0:	e8 ab a4 ff ff       	call   80101b70 <ilock>
801076c5:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801076c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801076cb:	8b 10                	mov    (%eax),%edx
801076cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076d0:	8b 00                	mov    (%eax),%eax
801076d2:	39 c2                	cmp    %eax,%edx
801076d4:	75 1d                	jne    801076f3 <sys_link+0x126>
801076d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076d9:	8b 40 04             	mov    0x4(%eax),%eax
801076dc:	83 ec 04             	sub    $0x4,%esp
801076df:	50                   	push   %eax
801076e0:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801076e3:	50                   	push   %eax
801076e4:	ff 75 f0             	pushl  -0x10(%ebp)
801076e7:	e8 23 ae ff ff       	call   8010250f <dirlink>
801076ec:	83 c4 10             	add    $0x10,%esp
801076ef:	85 c0                	test   %eax,%eax
801076f1:	79 10                	jns    80107703 <sys_link+0x136>
    iunlockput(dp);
801076f3:	83 ec 0c             	sub    $0xc,%esp
801076f6:	ff 75 f0             	pushl  -0x10(%ebp)
801076f9:	e8 62 a7 ff ff       	call   80101e60 <iunlockput>
801076fe:	83 c4 10             	add    $0x10,%esp
    goto bad;
80107701:	eb 29                	jmp    8010772c <sys_link+0x15f>
  }
  iunlockput(dp);
80107703:	83 ec 0c             	sub    $0xc,%esp
80107706:	ff 75 f0             	pushl  -0x10(%ebp)
80107709:	e8 52 a7 ff ff       	call   80101e60 <iunlockput>
8010770e:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80107711:	83 ec 0c             	sub    $0xc,%esp
80107714:	ff 75 f4             	pushl  -0xc(%ebp)
80107717:	e8 50 a6 ff ff       	call   80101d6c <iput>
8010771c:	83 c4 10             	add    $0x10,%esp

  end_op();
8010771f:	e8 52 c2 ff ff       	call   80103976 <end_op>

  return 0;
80107724:	b8 00 00 00 00       	mov    $0x0,%eax
80107729:	eb 48                	jmp    80107773 <sys_link+0x1a6>
    goto bad;
8010772b:	90                   	nop

bad:
  ilock(ip);
8010772c:	83 ec 0c             	sub    $0xc,%esp
8010772f:	ff 75 f4             	pushl  -0xc(%ebp)
80107732:	e8 39 a4 ff ff       	call   80101b70 <ilock>
80107737:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
8010773a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010773d:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80107741:	83 e8 01             	sub    $0x1,%eax
80107744:	89 c2                	mov    %eax,%edx
80107746:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107749:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
8010774d:	83 ec 0c             	sub    $0xc,%esp
80107750:	ff 75 f4             	pushl  -0xc(%ebp)
80107753:	e8 0b a2 ff ff       	call   80101963 <iupdate>
80107758:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
8010775b:	83 ec 0c             	sub    $0xc,%esp
8010775e:	ff 75 f4             	pushl  -0xc(%ebp)
80107761:	e8 fa a6 ff ff       	call   80101e60 <iunlockput>
80107766:	83 c4 10             	add    $0x10,%esp
  end_op();
80107769:	e8 08 c2 ff ff       	call   80103976 <end_op>
  return -1;
8010776e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107773:	c9                   	leave  
80107774:	c3                   	ret    

80107775 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80107775:	f3 0f 1e fb          	endbr32 
80107779:	55                   	push   %ebp
8010777a:	89 e5                	mov    %esp,%ebp
8010777c:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010777f:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80107786:	eb 40                	jmp    801077c8 <isdirempty+0x53>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80107788:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010778b:	6a 10                	push   $0x10
8010778d:	50                   	push   %eax
8010778e:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107791:	50                   	push   %eax
80107792:	ff 75 08             	pushl  0x8(%ebp)
80107795:	e8 b5 a9 ff ff       	call   8010214f <readi>
8010779a:	83 c4 10             	add    $0x10,%esp
8010779d:	83 f8 10             	cmp    $0x10,%eax
801077a0:	74 0d                	je     801077af <isdirempty+0x3a>
      panic("isdirempty: readi");
801077a2:	83 ec 0c             	sub    $0xc,%esp
801077a5:	68 be b0 10 80       	push   $0x8010b0be
801077aa:	e8 e8 8d ff ff       	call   80100597 <panic>
    if(de.inum != 0)
801077af:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801077b3:	66 85 c0             	test   %ax,%ax
801077b6:	74 07                	je     801077bf <isdirempty+0x4a>
      return 0;
801077b8:	b8 00 00 00 00       	mov    $0x0,%eax
801077bd:	eb 1b                	jmp    801077da <isdirempty+0x65>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801077bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077c2:	83 c0 10             	add    $0x10,%eax
801077c5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801077c8:	8b 45 08             	mov    0x8(%ebp),%eax
801077cb:	8b 50 24             	mov    0x24(%eax),%edx
801077ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077d1:	39 c2                	cmp    %eax,%edx
801077d3:	77 b3                	ja     80107788 <isdirempty+0x13>
  }
  return 1;
801077d5:	b8 01 00 00 00       	mov    $0x1,%eax
}
801077da:	c9                   	leave  
801077db:	c3                   	ret    

801077dc <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801077dc:	f3 0f 1e fb          	endbr32 
801077e0:	55                   	push   %ebp
801077e1:	89 e5                	mov    %esp,%ebp
801077e3:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801077e6:	83 ec 08             	sub    $0x8,%esp
801077e9:	8d 45 cc             	lea    -0x34(%ebp),%eax
801077ec:	50                   	push   %eax
801077ed:	6a 00                	push   $0x0
801077ef:	e8 71 fa ff ff       	call   80107265 <argstr>
801077f4:	83 c4 10             	add    $0x10,%esp
801077f7:	85 c0                	test   %eax,%eax
801077f9:	79 0a                	jns    80107805 <sys_unlink+0x29>
    return -1;
801077fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107800:	e9 bf 01 00 00       	jmp    801079c4 <sys_unlink+0x1e8>

  begin_op();
80107805:	e8 dc c0 ff ff       	call   801038e6 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
8010780a:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010780d:	83 ec 08             	sub    $0x8,%esp
80107810:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80107813:	52                   	push   %edx
80107814:	50                   	push   %eax
80107815:	e8 b9 af ff ff       	call   801027d3 <nameiparent>
8010781a:	83 c4 10             	add    $0x10,%esp
8010781d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107820:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107824:	75 0f                	jne    80107835 <sys_unlink+0x59>
    end_op();
80107826:	e8 4b c1 ff ff       	call   80103976 <end_op>
    return -1;
8010782b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107830:	e9 8f 01 00 00       	jmp    801079c4 <sys_unlink+0x1e8>
  }

  ilock(dp);
80107835:	83 ec 0c             	sub    $0xc,%esp
80107838:	ff 75 f4             	pushl  -0xc(%ebp)
8010783b:	e8 30 a3 ff ff       	call   80101b70 <ilock>
80107840:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80107843:	83 ec 08             	sub    $0x8,%esp
80107846:	68 d0 b0 10 80       	push   $0x8010b0d0
8010784b:	8d 45 d2             	lea    -0x2e(%ebp),%eax
8010784e:	50                   	push   %eax
8010784f:	e8 de ab ff ff       	call   80102432 <namecmp>
80107854:	83 c4 10             	add    $0x10,%esp
80107857:	85 c0                	test   %eax,%eax
80107859:	0f 84 49 01 00 00    	je     801079a8 <sys_unlink+0x1cc>
8010785f:	83 ec 08             	sub    $0x8,%esp
80107862:	68 d2 b0 10 80       	push   $0x8010b0d2
80107867:	8d 45 d2             	lea    -0x2e(%ebp),%eax
8010786a:	50                   	push   %eax
8010786b:	e8 c2 ab ff ff       	call   80102432 <namecmp>
80107870:	83 c4 10             	add    $0x10,%esp
80107873:	85 c0                	test   %eax,%eax
80107875:	0f 84 2d 01 00 00    	je     801079a8 <sys_unlink+0x1cc>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010787b:	83 ec 04             	sub    $0x4,%esp
8010787e:	8d 45 c8             	lea    -0x38(%ebp),%eax
80107881:	50                   	push   %eax
80107882:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80107885:	50                   	push   %eax
80107886:	ff 75 f4             	pushl  -0xc(%ebp)
80107889:	e8 c3 ab ff ff       	call   80102451 <dirlookup>
8010788e:	83 c4 10             	add    $0x10,%esp
80107891:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107894:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107898:	0f 84 0d 01 00 00    	je     801079ab <sys_unlink+0x1cf>
    goto bad;
  ilock(ip);
8010789e:	83 ec 0c             	sub    $0xc,%esp
801078a1:	ff 75 f0             	pushl  -0x10(%ebp)
801078a4:	e8 c7 a2 ff ff       	call   80101b70 <ilock>
801078a9:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
801078ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801078af:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801078b3:	66 85 c0             	test   %ax,%ax
801078b6:	7f 0d                	jg     801078c5 <sys_unlink+0xe9>
    panic("unlink: nlink < 1");
801078b8:	83 ec 0c             	sub    $0xc,%esp
801078bb:	68 d5 b0 10 80       	push   $0x8010b0d5
801078c0:	e8 d2 8c ff ff       	call   80100597 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
801078c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801078c8:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801078cc:	66 83 f8 01          	cmp    $0x1,%ax
801078d0:	75 25                	jne    801078f7 <sys_unlink+0x11b>
801078d2:	83 ec 0c             	sub    $0xc,%esp
801078d5:	ff 75 f0             	pushl  -0x10(%ebp)
801078d8:	e8 98 fe ff ff       	call   80107775 <isdirempty>
801078dd:	83 c4 10             	add    $0x10,%esp
801078e0:	85 c0                	test   %eax,%eax
801078e2:	75 13                	jne    801078f7 <sys_unlink+0x11b>
    iunlockput(ip);
801078e4:	83 ec 0c             	sub    $0xc,%esp
801078e7:	ff 75 f0             	pushl  -0x10(%ebp)
801078ea:	e8 71 a5 ff ff       	call   80101e60 <iunlockput>
801078ef:	83 c4 10             	add    $0x10,%esp
    goto bad;
801078f2:	e9 b5 00 00 00       	jmp    801079ac <sys_unlink+0x1d0>
  }

  memset(&de, 0, sizeof(de));
801078f7:	83 ec 04             	sub    $0x4,%esp
801078fa:	6a 10                	push   $0x10
801078fc:	6a 00                	push   $0x0
801078fe:	8d 45 e0             	lea    -0x20(%ebp),%eax
80107901:	50                   	push   %eax
80107902:	e8 84 f5 ff ff       	call   80106e8b <memset>
80107907:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010790a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010790d:	6a 10                	push   $0x10
8010790f:	50                   	push   %eax
80107910:	8d 45 e0             	lea    -0x20(%ebp),%eax
80107913:	50                   	push   %eax
80107914:	ff 75 f4             	pushl  -0xc(%ebp)
80107917:	e8 8c a9 ff ff       	call   801022a8 <writei>
8010791c:	83 c4 10             	add    $0x10,%esp
8010791f:	83 f8 10             	cmp    $0x10,%eax
80107922:	74 0d                	je     80107931 <sys_unlink+0x155>
    panic("unlink: writei");
80107924:	83 ec 0c             	sub    $0xc,%esp
80107927:	68 e7 b0 10 80       	push   $0x8010b0e7
8010792c:	e8 66 8c ff ff       	call   80100597 <panic>
  if(ip->type == T_DIR){
80107931:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107934:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80107938:	66 83 f8 01          	cmp    $0x1,%ax
8010793c:	75 21                	jne    8010795f <sys_unlink+0x183>
    dp->nlink--;
8010793e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107941:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80107945:	83 e8 01             	sub    $0x1,%eax
80107948:	89 c2                	mov    %eax,%edx
8010794a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010794d:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80107951:	83 ec 0c             	sub    $0xc,%esp
80107954:	ff 75 f4             	pushl  -0xc(%ebp)
80107957:	e8 07 a0 ff ff       	call   80101963 <iupdate>
8010795c:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
8010795f:	83 ec 0c             	sub    $0xc,%esp
80107962:	ff 75 f4             	pushl  -0xc(%ebp)
80107965:	e8 f6 a4 ff ff       	call   80101e60 <iunlockput>
8010796a:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
8010796d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107970:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80107974:	83 e8 01             	sub    $0x1,%eax
80107977:	89 c2                	mov    %eax,%edx
80107979:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010797c:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80107980:	83 ec 0c             	sub    $0xc,%esp
80107983:	ff 75 f0             	pushl  -0x10(%ebp)
80107986:	e8 d8 9f ff ff       	call   80101963 <iupdate>
8010798b:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
8010798e:	83 ec 0c             	sub    $0xc,%esp
80107991:	ff 75 f0             	pushl  -0x10(%ebp)
80107994:	e8 c7 a4 ff ff       	call   80101e60 <iunlockput>
80107999:	83 c4 10             	add    $0x10,%esp

  end_op();
8010799c:	e8 d5 bf ff ff       	call   80103976 <end_op>

  return 0;
801079a1:	b8 00 00 00 00       	mov    $0x0,%eax
801079a6:	eb 1c                	jmp    801079c4 <sys_unlink+0x1e8>
    goto bad;
801079a8:	90                   	nop
801079a9:	eb 01                	jmp    801079ac <sys_unlink+0x1d0>
    goto bad;
801079ab:	90                   	nop

bad:
  iunlockput(dp);
801079ac:	83 ec 0c             	sub    $0xc,%esp
801079af:	ff 75 f4             	pushl  -0xc(%ebp)
801079b2:	e8 a9 a4 ff ff       	call   80101e60 <iunlockput>
801079b7:	83 c4 10             	add    $0x10,%esp
  end_op();
801079ba:	e8 b7 bf ff ff       	call   80103976 <end_op>
  return -1;
801079bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801079c4:	c9                   	leave  
801079c5:	c3                   	ret    

801079c6 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
801079c6:	f3 0f 1e fb          	endbr32 
801079ca:	55                   	push   %ebp
801079cb:	89 e5                	mov    %esp,%ebp
801079cd:	83 ec 38             	sub    $0x38,%esp
801079d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801079d3:	8b 55 10             	mov    0x10(%ebp),%edx
801079d6:	8b 45 14             	mov    0x14(%ebp),%eax
801079d9:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
801079dd:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
801079e1:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801079e5:	83 ec 08             	sub    $0x8,%esp
801079e8:	8d 45 de             	lea    -0x22(%ebp),%eax
801079eb:	50                   	push   %eax
801079ec:	ff 75 08             	pushl  0x8(%ebp)
801079ef:	e8 df ad ff ff       	call   801027d3 <nameiparent>
801079f4:	83 c4 10             	add    $0x10,%esp
801079f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801079fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801079fe:	75 0a                	jne    80107a0a <create+0x44>
    return 0;
80107a00:	b8 00 00 00 00       	mov    $0x0,%eax
80107a05:	e9 90 01 00 00       	jmp    80107b9a <create+0x1d4>
  ilock(dp);
80107a0a:	83 ec 0c             	sub    $0xc,%esp
80107a0d:	ff 75 f4             	pushl  -0xc(%ebp)
80107a10:	e8 5b a1 ff ff       	call   80101b70 <ilock>
80107a15:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80107a18:	83 ec 04             	sub    $0x4,%esp
80107a1b:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107a1e:	50                   	push   %eax
80107a1f:	8d 45 de             	lea    -0x22(%ebp),%eax
80107a22:	50                   	push   %eax
80107a23:	ff 75 f4             	pushl  -0xc(%ebp)
80107a26:	e8 26 aa ff ff       	call   80102451 <dirlookup>
80107a2b:	83 c4 10             	add    $0x10,%esp
80107a2e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107a31:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107a35:	74 50                	je     80107a87 <create+0xc1>
    iunlockput(dp);
80107a37:	83 ec 0c             	sub    $0xc,%esp
80107a3a:	ff 75 f4             	pushl  -0xc(%ebp)
80107a3d:	e8 1e a4 ff ff       	call   80101e60 <iunlockput>
80107a42:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80107a45:	83 ec 0c             	sub    $0xc,%esp
80107a48:	ff 75 f0             	pushl  -0x10(%ebp)
80107a4b:	e8 20 a1 ff ff       	call   80101b70 <ilock>
80107a50:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80107a53:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80107a58:	75 15                	jne    80107a6f <create+0xa9>
80107a5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a5d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80107a61:	66 83 f8 02          	cmp    $0x2,%ax
80107a65:	75 08                	jne    80107a6f <create+0xa9>
      return ip;
80107a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107a6a:	e9 2b 01 00 00       	jmp    80107b9a <create+0x1d4>
    iunlockput(ip);
80107a6f:	83 ec 0c             	sub    $0xc,%esp
80107a72:	ff 75 f0             	pushl  -0x10(%ebp)
80107a75:	e8 e6 a3 ff ff       	call   80101e60 <iunlockput>
80107a7a:	83 c4 10             	add    $0x10,%esp
    return 0;
80107a7d:	b8 00 00 00 00       	mov    $0x0,%eax
80107a82:	e9 13 01 00 00       	jmp    80107b9a <create+0x1d4>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80107a87:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80107a8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a8e:	8b 00                	mov    (%eax),%eax
80107a90:	83 ec 08             	sub    $0x8,%esp
80107a93:	52                   	push   %edx
80107a94:	50                   	push   %eax
80107a95:	e8 cd 9d ff ff       	call   80101867 <ialloc>
80107a9a:	83 c4 10             	add    $0x10,%esp
80107a9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107aa0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107aa4:	75 0d                	jne    80107ab3 <create+0xed>
    panic("create: ialloc");
80107aa6:	83 ec 0c             	sub    $0xc,%esp
80107aa9:	68 f6 b0 10 80       	push   $0x8010b0f6
80107aae:	e8 e4 8a ff ff       	call   80100597 <panic>

  ilock(ip);
80107ab3:	83 ec 0c             	sub    $0xc,%esp
80107ab6:	ff 75 f0             	pushl  -0x10(%ebp)
80107ab9:	e8 b2 a0 ff ff       	call   80101b70 <ilock>
80107abe:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80107ac1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ac4:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80107ac8:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80107acc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107acf:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80107ad3:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80107ad7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ada:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80107ae0:	83 ec 0c             	sub    $0xc,%esp
80107ae3:	ff 75 f0             	pushl  -0x10(%ebp)
80107ae6:	e8 78 9e ff ff       	call   80101963 <iupdate>
80107aeb:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80107aee:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80107af3:	75 6a                	jne    80107b5f <create+0x199>
    dp->nlink++;  // for ".."
80107af5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af8:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80107afc:	83 c0 01             	add    $0x1,%eax
80107aff:	89 c2                	mov    %eax,%edx
80107b01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b04:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80107b08:	83 ec 0c             	sub    $0xc,%esp
80107b0b:	ff 75 f4             	pushl  -0xc(%ebp)
80107b0e:	e8 50 9e ff ff       	call   80101963 <iupdate>
80107b13:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80107b16:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107b19:	8b 40 04             	mov    0x4(%eax),%eax
80107b1c:	83 ec 04             	sub    $0x4,%esp
80107b1f:	50                   	push   %eax
80107b20:	68 d0 b0 10 80       	push   $0x8010b0d0
80107b25:	ff 75 f0             	pushl  -0x10(%ebp)
80107b28:	e8 e2 a9 ff ff       	call   8010250f <dirlink>
80107b2d:	83 c4 10             	add    $0x10,%esp
80107b30:	85 c0                	test   %eax,%eax
80107b32:	78 1e                	js     80107b52 <create+0x18c>
80107b34:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b37:	8b 40 04             	mov    0x4(%eax),%eax
80107b3a:	83 ec 04             	sub    $0x4,%esp
80107b3d:	50                   	push   %eax
80107b3e:	68 d2 b0 10 80       	push   $0x8010b0d2
80107b43:	ff 75 f0             	pushl  -0x10(%ebp)
80107b46:	e8 c4 a9 ff ff       	call   8010250f <dirlink>
80107b4b:	83 c4 10             	add    $0x10,%esp
80107b4e:	85 c0                	test   %eax,%eax
80107b50:	79 0d                	jns    80107b5f <create+0x199>
      panic("create dots");
80107b52:	83 ec 0c             	sub    $0xc,%esp
80107b55:	68 05 b1 10 80       	push   $0x8010b105
80107b5a:	e8 38 8a ff ff       	call   80100597 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80107b5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107b62:	8b 40 04             	mov    0x4(%eax),%eax
80107b65:	83 ec 04             	sub    $0x4,%esp
80107b68:	50                   	push   %eax
80107b69:	8d 45 de             	lea    -0x22(%ebp),%eax
80107b6c:	50                   	push   %eax
80107b6d:	ff 75 f4             	pushl  -0xc(%ebp)
80107b70:	e8 9a a9 ff ff       	call   8010250f <dirlink>
80107b75:	83 c4 10             	add    $0x10,%esp
80107b78:	85 c0                	test   %eax,%eax
80107b7a:	79 0d                	jns    80107b89 <create+0x1c3>
    panic("create: dirlink");
80107b7c:	83 ec 0c             	sub    $0xc,%esp
80107b7f:	68 11 b1 10 80       	push   $0x8010b111
80107b84:	e8 0e 8a ff ff       	call   80100597 <panic>

  iunlockput(dp);
80107b89:	83 ec 0c             	sub    $0xc,%esp
80107b8c:	ff 75 f4             	pushl  -0xc(%ebp)
80107b8f:	e8 cc a2 ff ff       	call   80101e60 <iunlockput>
80107b94:	83 c4 10             	add    $0x10,%esp

  return ip;
80107b97:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107b9a:	c9                   	leave  
80107b9b:	c3                   	ret    

80107b9c <sys_open>:

int
sys_open(void)
{
80107b9c:	f3 0f 1e fb          	endbr32 
80107ba0:	55                   	push   %ebp
80107ba1:	89 e5                	mov    %esp,%ebp
80107ba3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80107ba6:	83 ec 08             	sub    $0x8,%esp
80107ba9:	8d 45 e8             	lea    -0x18(%ebp),%eax
80107bac:	50                   	push   %eax
80107bad:	6a 00                	push   $0x0
80107baf:	e8 b1 f6 ff ff       	call   80107265 <argstr>
80107bb4:	83 c4 10             	add    $0x10,%esp
80107bb7:	85 c0                	test   %eax,%eax
80107bb9:	78 15                	js     80107bd0 <sys_open+0x34>
80107bbb:	83 ec 08             	sub    $0x8,%esp
80107bbe:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107bc1:	50                   	push   %eax
80107bc2:	6a 01                	push   $0x1
80107bc4:	e8 0f f6 ff ff       	call   801071d8 <argint>
80107bc9:	83 c4 10             	add    $0x10,%esp
80107bcc:	85 c0                	test   %eax,%eax
80107bce:	79 0a                	jns    80107bda <sys_open+0x3e>
    return -1;
80107bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107bd5:	e9 61 01 00 00       	jmp    80107d3b <sys_open+0x19f>

  begin_op();
80107bda:	e8 07 bd ff ff       	call   801038e6 <begin_op>

  if(omode & O_CREATE){
80107bdf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107be2:	25 00 02 00 00       	and    $0x200,%eax
80107be7:	85 c0                	test   %eax,%eax
80107be9:	74 2a                	je     80107c15 <sys_open+0x79>
    ip = create(path, T_FILE, 0, 0);
80107beb:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107bee:	6a 00                	push   $0x0
80107bf0:	6a 00                	push   $0x0
80107bf2:	6a 02                	push   $0x2
80107bf4:	50                   	push   %eax
80107bf5:	e8 cc fd ff ff       	call   801079c6 <create>
80107bfa:	83 c4 10             	add    $0x10,%esp
80107bfd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
80107c00:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107c04:	75 75                	jne    80107c7b <sys_open+0xdf>
      end_op();
80107c06:	e8 6b bd ff ff       	call   80103976 <end_op>
      return -1;
80107c0b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107c10:	e9 26 01 00 00       	jmp    80107d3b <sys_open+0x19f>
    }
  } else {
    if((ip = namei(path)) == 0){
80107c15:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107c18:	83 ec 0c             	sub    $0xc,%esp
80107c1b:	50                   	push   %eax
80107c1c:	e8 92 ab ff ff       	call   801027b3 <namei>
80107c21:	83 c4 10             	add    $0x10,%esp
80107c24:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107c27:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107c2b:	75 0f                	jne    80107c3c <sys_open+0xa0>
      end_op();
80107c2d:	e8 44 bd ff ff       	call   80103976 <end_op>
      return -1;
80107c32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107c37:	e9 ff 00 00 00       	jmp    80107d3b <sys_open+0x19f>
    }
    ilock(ip);
80107c3c:	83 ec 0c             	sub    $0xc,%esp
80107c3f:	ff 75 f4             	pushl  -0xc(%ebp)
80107c42:	e8 29 9f ff ff       	call   80101b70 <ilock>
80107c47:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80107c4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c4d:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80107c51:	66 83 f8 01          	cmp    $0x1,%ax
80107c55:	75 24                	jne    80107c7b <sys_open+0xdf>
80107c57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c5a:	85 c0                	test   %eax,%eax
80107c5c:	74 1d                	je     80107c7b <sys_open+0xdf>
      iunlockput(ip);
80107c5e:	83 ec 0c             	sub    $0xc,%esp
80107c61:	ff 75 f4             	pushl  -0xc(%ebp)
80107c64:	e8 f7 a1 ff ff       	call   80101e60 <iunlockput>
80107c69:	83 c4 10             	add    $0x10,%esp
      end_op();
80107c6c:	e8 05 bd ff ff       	call   80103976 <end_op>
      return -1;
80107c71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107c76:	e9 c0 00 00 00       	jmp    80107d3b <sys_open+0x19f>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80107c7b:	e8 95 94 ff ff       	call   80101115 <filealloc>
80107c80:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107c83:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107c87:	74 17                	je     80107ca0 <sys_open+0x104>
80107c89:	83 ec 0c             	sub    $0xc,%esp
80107c8c:	ff 75 f0             	pushl  -0x10(%ebp)
80107c8f:	e8 08 f7 ff ff       	call   8010739c <fdalloc>
80107c94:	83 c4 10             	add    $0x10,%esp
80107c97:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107c9a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107c9e:	79 2e                	jns    80107cce <sys_open+0x132>
    if(f)
80107ca0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107ca4:	74 0e                	je     80107cb4 <sys_open+0x118>
      fileclose(f);
80107ca6:	83 ec 0c             	sub    $0xc,%esp
80107ca9:	ff 75 f0             	pushl  -0x10(%ebp)
80107cac:	e8 2a 95 ff ff       	call   801011db <fileclose>
80107cb1:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80107cb4:	83 ec 0c             	sub    $0xc,%esp
80107cb7:	ff 75 f4             	pushl  -0xc(%ebp)
80107cba:	e8 a1 a1 ff ff       	call   80101e60 <iunlockput>
80107cbf:	83 c4 10             	add    $0x10,%esp
    end_op();
80107cc2:	e8 af bc ff ff       	call   80103976 <end_op>
    return -1;
80107cc7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ccc:	eb 6d                	jmp    80107d3b <sys_open+0x19f>
  }
  iunlock(ip);
80107cce:	83 ec 0c             	sub    $0xc,%esp
80107cd1:	ff 75 f4             	pushl  -0xc(%ebp)
80107cd4:	e8 1d a0 ff ff       	call   80101cf6 <iunlock>
80107cd9:	83 c4 10             	add    $0x10,%esp
  end_op();
80107cdc:	e8 95 bc ff ff       	call   80103976 <end_op>

  f->type = FD_INODE;
80107ce1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ce4:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80107cea:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ced:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107cf0:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80107cf3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107cf6:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80107cfd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d00:	83 e0 01             	and    $0x1,%eax
80107d03:	85 c0                	test   %eax,%eax
80107d05:	0f 94 c0             	sete   %al
80107d08:	89 c2                	mov    %eax,%edx
80107d0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d0d:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80107d10:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d13:	83 e0 01             	and    $0x1,%eax
80107d16:	85 c0                	test   %eax,%eax
80107d18:	75 0a                	jne    80107d24 <sys_open+0x188>
80107d1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d1d:	83 e0 02             	and    $0x2,%eax
80107d20:	85 c0                	test   %eax,%eax
80107d22:	74 07                	je     80107d2b <sys_open+0x18f>
80107d24:	b8 01 00 00 00       	mov    $0x1,%eax
80107d29:	eb 05                	jmp    80107d30 <sys_open+0x194>
80107d2b:	b8 00 00 00 00       	mov    $0x0,%eax
80107d30:	89 c2                	mov    %eax,%edx
80107d32:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d35:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80107d38:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80107d3b:	c9                   	leave  
80107d3c:	c3                   	ret    

80107d3d <sys_mkdir>:

int
sys_mkdir(void)
{
80107d3d:	f3 0f 1e fb          	endbr32 
80107d41:	55                   	push   %ebp
80107d42:	89 e5                	mov    %esp,%ebp
80107d44:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80107d47:	e8 9a bb ff ff       	call   801038e6 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80107d4c:	83 ec 08             	sub    $0x8,%esp
80107d4f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107d52:	50                   	push   %eax
80107d53:	6a 00                	push   $0x0
80107d55:	e8 0b f5 ff ff       	call   80107265 <argstr>
80107d5a:	83 c4 10             	add    $0x10,%esp
80107d5d:	85 c0                	test   %eax,%eax
80107d5f:	78 1b                	js     80107d7c <sys_mkdir+0x3f>
80107d61:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d64:	6a 00                	push   $0x0
80107d66:	6a 00                	push   $0x0
80107d68:	6a 01                	push   $0x1
80107d6a:	50                   	push   %eax
80107d6b:	e8 56 fc ff ff       	call   801079c6 <create>
80107d70:	83 c4 10             	add    $0x10,%esp
80107d73:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107d76:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107d7a:	75 0c                	jne    80107d88 <sys_mkdir+0x4b>
    end_op();
80107d7c:	e8 f5 bb ff ff       	call   80103976 <end_op>
    return -1;
80107d81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107d86:	eb 18                	jmp    80107da0 <sys_mkdir+0x63>
  }
  iunlockput(ip);
80107d88:	83 ec 0c             	sub    $0xc,%esp
80107d8b:	ff 75 f4             	pushl  -0xc(%ebp)
80107d8e:	e8 cd a0 ff ff       	call   80101e60 <iunlockput>
80107d93:	83 c4 10             	add    $0x10,%esp
  end_op();
80107d96:	e8 db bb ff ff       	call   80103976 <end_op>
  return 0;
80107d9b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107da0:	c9                   	leave  
80107da1:	c3                   	ret    

80107da2 <sys_mknod>:

int
sys_mknod(void)
{
80107da2:	f3 0f 1e fb          	endbr32 
80107da6:	55                   	push   %ebp
80107da7:	89 e5                	mov    %esp,%ebp
80107da9:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_op();
80107dac:	e8 35 bb ff ff       	call   801038e6 <begin_op>
  if((len=argstr(0, &path)) < 0 ||
80107db1:	83 ec 08             	sub    $0x8,%esp
80107db4:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107db7:	50                   	push   %eax
80107db8:	6a 00                	push   $0x0
80107dba:	e8 a6 f4 ff ff       	call   80107265 <argstr>
80107dbf:	83 c4 10             	add    $0x10,%esp
80107dc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107dc5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107dc9:	78 4f                	js     80107e1a <sys_mknod+0x78>
     argint(1, &major) < 0 ||
80107dcb:	83 ec 08             	sub    $0x8,%esp
80107dce:	8d 45 e8             	lea    -0x18(%ebp),%eax
80107dd1:	50                   	push   %eax
80107dd2:	6a 01                	push   $0x1
80107dd4:	e8 ff f3 ff ff       	call   801071d8 <argint>
80107dd9:	83 c4 10             	add    $0x10,%esp
  if((len=argstr(0, &path)) < 0 ||
80107ddc:	85 c0                	test   %eax,%eax
80107dde:	78 3a                	js     80107e1a <sys_mknod+0x78>
     argint(2, &minor) < 0 ||
80107de0:	83 ec 08             	sub    $0x8,%esp
80107de3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107de6:	50                   	push   %eax
80107de7:	6a 02                	push   $0x2
80107de9:	e8 ea f3 ff ff       	call   801071d8 <argint>
80107dee:	83 c4 10             	add    $0x10,%esp
     argint(1, &major) < 0 ||
80107df1:	85 c0                	test   %eax,%eax
80107df3:	78 25                	js     80107e1a <sys_mknod+0x78>
     (ip = create(path, T_DEV, major, minor)) == 0){
80107df5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107df8:	0f bf c8             	movswl %ax,%ecx
80107dfb:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107dfe:	0f bf d0             	movswl %ax,%edx
80107e01:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107e04:	51                   	push   %ecx
80107e05:	52                   	push   %edx
80107e06:	6a 03                	push   $0x3
80107e08:	50                   	push   %eax
80107e09:	e8 b8 fb ff ff       	call   801079c6 <create>
80107e0e:	83 c4 10             	add    $0x10,%esp
80107e11:	89 45 f0             	mov    %eax,-0x10(%ebp)
     argint(2, &minor) < 0 ||
80107e14:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107e18:	75 0c                	jne    80107e26 <sys_mknod+0x84>
    end_op();
80107e1a:	e8 57 bb ff ff       	call   80103976 <end_op>
    return -1;
80107e1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e24:	eb 18                	jmp    80107e3e <sys_mknod+0x9c>
  }
  iunlockput(ip);
80107e26:	83 ec 0c             	sub    $0xc,%esp
80107e29:	ff 75 f0             	pushl  -0x10(%ebp)
80107e2c:	e8 2f a0 ff ff       	call   80101e60 <iunlockput>
80107e31:	83 c4 10             	add    $0x10,%esp
  end_op();
80107e34:	e8 3d bb ff ff       	call   80103976 <end_op>
  return 0;
80107e39:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107e3e:	c9                   	leave  
80107e3f:	c3                   	ret    

80107e40 <sys_chdir>:

int
sys_chdir(void)
{
80107e40:	f3 0f 1e fb          	endbr32 
80107e44:	55                   	push   %ebp
80107e45:	89 e5                	mov    %esp,%ebp
80107e47:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80107e4a:	e8 97 ba ff ff       	call   801038e6 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80107e4f:	83 ec 08             	sub    $0x8,%esp
80107e52:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107e55:	50                   	push   %eax
80107e56:	6a 00                	push   $0x0
80107e58:	e8 08 f4 ff ff       	call   80107265 <argstr>
80107e5d:	83 c4 10             	add    $0x10,%esp
80107e60:	85 c0                	test   %eax,%eax
80107e62:	78 18                	js     80107e7c <sys_chdir+0x3c>
80107e64:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e67:	83 ec 0c             	sub    $0xc,%esp
80107e6a:	50                   	push   %eax
80107e6b:	e8 43 a9 ff ff       	call   801027b3 <namei>
80107e70:	83 c4 10             	add    $0x10,%esp
80107e73:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107e76:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107e7a:	75 0c                	jne    80107e88 <sys_chdir+0x48>
    end_op();
80107e7c:	e8 f5 ba ff ff       	call   80103976 <end_op>
    return -1;
80107e81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e86:	eb 6e                	jmp    80107ef6 <sys_chdir+0xb6>
  }
  ilock(ip);
80107e88:	83 ec 0c             	sub    $0xc,%esp
80107e8b:	ff 75 f4             	pushl  -0xc(%ebp)
80107e8e:	e8 dd 9c ff ff       	call   80101b70 <ilock>
80107e93:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80107e96:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e99:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80107e9d:	66 83 f8 01          	cmp    $0x1,%ax
80107ea1:	74 1a                	je     80107ebd <sys_chdir+0x7d>
    iunlockput(ip);
80107ea3:	83 ec 0c             	sub    $0xc,%esp
80107ea6:	ff 75 f4             	pushl  -0xc(%ebp)
80107ea9:	e8 b2 9f ff ff       	call   80101e60 <iunlockput>
80107eae:	83 c4 10             	add    $0x10,%esp
    end_op();
80107eb1:	e8 c0 ba ff ff       	call   80103976 <end_op>
    return -1;
80107eb6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ebb:	eb 39                	jmp    80107ef6 <sys_chdir+0xb6>
  }
  iunlock(ip);
80107ebd:	83 ec 0c             	sub    $0xc,%esp
80107ec0:	ff 75 f4             	pushl  -0xc(%ebp)
80107ec3:	e8 2e 9e ff ff       	call   80101cf6 <iunlock>
80107ec8:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80107ecb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107ed1:	8b 40 68             	mov    0x68(%eax),%eax
80107ed4:	83 ec 0c             	sub    $0xc,%esp
80107ed7:	50                   	push   %eax
80107ed8:	e8 8f 9e ff ff       	call   80101d6c <iput>
80107edd:	83 c4 10             	add    $0x10,%esp
  end_op();
80107ee0:	e8 91 ba ff ff       	call   80103976 <end_op>
  proc->cwd = ip;
80107ee5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107eeb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107eee:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80107ef1:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107ef6:	c9                   	leave  
80107ef7:	c3                   	ret    

80107ef8 <sys_exec>:

int
sys_exec(void)
{
80107ef8:	f3 0f 1e fb          	endbr32 
80107efc:	55                   	push   %ebp
80107efd:	89 e5                	mov    %esp,%ebp
80107eff:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80107f05:	83 ec 08             	sub    $0x8,%esp
80107f08:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107f0b:	50                   	push   %eax
80107f0c:	6a 00                	push   $0x0
80107f0e:	e8 52 f3 ff ff       	call   80107265 <argstr>
80107f13:	83 c4 10             	add    $0x10,%esp
80107f16:	85 c0                	test   %eax,%eax
80107f18:	78 18                	js     80107f32 <sys_exec+0x3a>
80107f1a:	83 ec 08             	sub    $0x8,%esp
80107f1d:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80107f23:	50                   	push   %eax
80107f24:	6a 01                	push   $0x1
80107f26:	e8 ad f2 ff ff       	call   801071d8 <argint>
80107f2b:	83 c4 10             	add    $0x10,%esp
80107f2e:	85 c0                	test   %eax,%eax
80107f30:	79 0a                	jns    80107f3c <sys_exec+0x44>
    return -1;
80107f32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107f37:	e9 c6 00 00 00       	jmp    80108002 <sys_exec+0x10a>
  }
  memset(argv, 0, sizeof(argv));
80107f3c:	83 ec 04             	sub    $0x4,%esp
80107f3f:	68 80 00 00 00       	push   $0x80
80107f44:	6a 00                	push   $0x0
80107f46:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80107f4c:	50                   	push   %eax
80107f4d:	e8 39 ef ff ff       	call   80106e8b <memset>
80107f52:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80107f55:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
80107f5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f5f:	83 f8 1f             	cmp    $0x1f,%eax
80107f62:	76 0a                	jbe    80107f6e <sys_exec+0x76>
      return -1;
80107f64:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107f69:	e9 94 00 00 00       	jmp    80108002 <sys_exec+0x10a>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80107f6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f71:	c1 e0 02             	shl    $0x2,%eax
80107f74:	89 c2                	mov    %eax,%edx
80107f76:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80107f7c:	01 c2                	add    %eax,%edx
80107f7e:	83 ec 08             	sub    $0x8,%esp
80107f81:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80107f87:	50                   	push   %eax
80107f88:	52                   	push   %edx
80107f89:	e8 a6 f1 ff ff       	call   80107134 <fetchint>
80107f8e:	83 c4 10             	add    $0x10,%esp
80107f91:	85 c0                	test   %eax,%eax
80107f93:	79 07                	jns    80107f9c <sys_exec+0xa4>
      return -1;
80107f95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107f9a:	eb 66                	jmp    80108002 <sys_exec+0x10a>
    if(uarg == 0){
80107f9c:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80107fa2:	85 c0                	test   %eax,%eax
80107fa4:	75 27                	jne    80107fcd <sys_exec+0xd5>
      argv[i] = 0;
80107fa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fa9:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80107fb0:	00 00 00 00 
      break;
80107fb4:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80107fb5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107fb8:	83 ec 08             	sub    $0x8,%esp
80107fbb:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80107fc1:	52                   	push   %edx
80107fc2:	50                   	push   %eax
80107fc3:	e8 8b 8c ff ff       	call   80100c53 <exec>
80107fc8:	83 c4 10             	add    $0x10,%esp
80107fcb:	eb 35                	jmp    80108002 <sys_exec+0x10a>
    if(fetchstr(uarg, &argv[i]) < 0)
80107fcd:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80107fd3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107fd6:	c1 e2 02             	shl    $0x2,%edx
80107fd9:	01 c2                	add    %eax,%edx
80107fdb:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80107fe1:	83 ec 08             	sub    $0x8,%esp
80107fe4:	52                   	push   %edx
80107fe5:	50                   	push   %eax
80107fe6:	e8 87 f1 ff ff       	call   80107172 <fetchstr>
80107feb:	83 c4 10             	add    $0x10,%esp
80107fee:	85 c0                	test   %eax,%eax
80107ff0:	79 07                	jns    80107ff9 <sys_exec+0x101>
      return -1;
80107ff2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ff7:	eb 09                	jmp    80108002 <sys_exec+0x10a>
  for(i=0;; i++){
80107ff9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(i >= NELEM(argv))
80107ffd:	e9 5a ff ff ff       	jmp    80107f5c <sys_exec+0x64>
}
80108002:	c9                   	leave  
80108003:	c3                   	ret    

80108004 <sys_pipe>:

int
sys_pipe(void)
{
80108004:	f3 0f 1e fb          	endbr32 
80108008:	55                   	push   %ebp
80108009:	89 e5                	mov    %esp,%ebp
8010800b:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010800e:	83 ec 04             	sub    $0x4,%esp
80108011:	6a 08                	push   $0x8
80108013:	8d 45 ec             	lea    -0x14(%ebp),%eax
80108016:	50                   	push   %eax
80108017:	6a 00                	push   $0x0
80108019:	e8 e6 f1 ff ff       	call   80107204 <argptr>
8010801e:	83 c4 10             	add    $0x10,%esp
80108021:	85 c0                	test   %eax,%eax
80108023:	79 0a                	jns    8010802f <sys_pipe+0x2b>
    return -1;
80108025:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010802a:	e9 af 00 00 00       	jmp    801080de <sys_pipe+0xda>
  if(pipealloc(&rf, &wf) < 0)
8010802f:	83 ec 08             	sub    $0x8,%esp
80108032:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80108035:	50                   	push   %eax
80108036:	8d 45 e8             	lea    -0x18(%ebp),%eax
80108039:	50                   	push   %eax
8010803a:	e8 01 c4 ff ff       	call   80104440 <pipealloc>
8010803f:	83 c4 10             	add    $0x10,%esp
80108042:	85 c0                	test   %eax,%eax
80108044:	79 0a                	jns    80108050 <sys_pipe+0x4c>
    return -1;
80108046:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010804b:	e9 8e 00 00 00       	jmp    801080de <sys_pipe+0xda>
  fd0 = -1;
80108050:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80108057:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010805a:	83 ec 0c             	sub    $0xc,%esp
8010805d:	50                   	push   %eax
8010805e:	e8 39 f3 ff ff       	call   8010739c <fdalloc>
80108063:	83 c4 10             	add    $0x10,%esp
80108066:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108069:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010806d:	78 18                	js     80108087 <sys_pipe+0x83>
8010806f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108072:	83 ec 0c             	sub    $0xc,%esp
80108075:	50                   	push   %eax
80108076:	e8 21 f3 ff ff       	call   8010739c <fdalloc>
8010807b:	83 c4 10             	add    $0x10,%esp
8010807e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108081:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108085:	79 3f                	jns    801080c6 <sys_pipe+0xc2>
    if(fd0 >= 0)
80108087:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010808b:	78 14                	js     801080a1 <sys_pipe+0x9d>
      proc->ofile[fd0] = 0;
8010808d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108093:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108096:	83 c2 08             	add    $0x8,%edx
80108099:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801080a0:	00 
    fileclose(rf);
801080a1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801080a4:	83 ec 0c             	sub    $0xc,%esp
801080a7:	50                   	push   %eax
801080a8:	e8 2e 91 ff ff       	call   801011db <fileclose>
801080ad:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
801080b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801080b3:	83 ec 0c             	sub    $0xc,%esp
801080b6:	50                   	push   %eax
801080b7:	e8 1f 91 ff ff       	call   801011db <fileclose>
801080bc:	83 c4 10             	add    $0x10,%esp
    return -1;
801080bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801080c4:	eb 18                	jmp    801080de <sys_pipe+0xda>
  }
  fd[0] = fd0;
801080c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801080cc:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
801080ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080d1:	8d 50 04             	lea    0x4(%eax),%edx
801080d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801080d7:	89 02                	mov    %eax,(%edx)
  return 0;
801080d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
801080de:	c9                   	leave  
801080df:	c3                   	ret    

801080e0 <sys_chown>:


#ifdef LS_EXEC
int
sys_chown(void) {
801080e0:	f3 0f 1e fb          	endbr32 
801080e4:	55                   	push   %ebp
801080e5:	89 e5                	mov    %esp,%ebp
801080e7:	83 ec 18             	sub    $0x18,%esp
    char *path;
    int owner;
    int group;

    if (argstr(0, &path) < 0) {
801080ea:	83 ec 08             	sub    $0x8,%esp
801080ed:	8d 45 f4             	lea    -0xc(%ebp),%eax
801080f0:	50                   	push   %eax
801080f1:	6a 00                	push   $0x0
801080f3:	e8 6d f1 ff ff       	call   80107265 <argstr>
801080f8:	83 c4 10             	add    $0x10,%esp
801080fb:	85 c0                	test   %eax,%eax
801080fd:	79 07                	jns    80108106 <sys_chown+0x26>
        return -1; 
801080ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108104:	eb 7f                	jmp    80108185 <sys_chown+0xa5>
    }
    if (argint(1, &owner) < 0) {
80108106:	83 ec 08             	sub    $0x8,%esp
80108109:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010810c:	50                   	push   %eax
8010810d:	6a 01                	push   $0x1
8010810f:	e8 c4 f0 ff ff       	call   801071d8 <argint>
80108114:	83 c4 10             	add    $0x10,%esp
80108117:	85 c0                	test   %eax,%eax
80108119:	79 07                	jns    80108122 <sys_chown+0x42>
        return -2; 
8010811b:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80108120:	eb 63                	jmp    80108185 <sys_chown+0xa5>
    }

    if (owner < 0 || owner > 32767) {
80108122:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108125:	85 c0                	test   %eax,%eax
80108127:	78 0a                	js     80108133 <sys_chown+0x53>
80108129:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010812c:	3d ff 7f 00 00       	cmp    $0x7fff,%eax
80108131:	7e 07                	jle    8010813a <sys_chown+0x5a>
        return -2; 
80108133:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80108138:	eb 4b                	jmp    80108185 <sys_chown+0xa5>
    }

    if (argint(1, &group) < 0) {
8010813a:	83 ec 08             	sub    $0x8,%esp
8010813d:	8d 45 ec             	lea    -0x14(%ebp),%eax
80108140:	50                   	push   %eax
80108141:	6a 01                	push   $0x1
80108143:	e8 90 f0 ff ff       	call   801071d8 <argint>
80108148:	83 c4 10             	add    $0x10,%esp
8010814b:	85 c0                	test   %eax,%eax
8010814d:	79 07                	jns    80108156 <sys_chown+0x76>
        return -3; 
8010814f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
80108154:	eb 2f                	jmp    80108185 <sys_chown+0xa5>
    }

    if (group < 0 || group > 32767) {
80108156:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108159:	85 c0                	test   %eax,%eax
8010815b:	78 0a                	js     80108167 <sys_chown+0x87>
8010815d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108160:	3d ff 7f 00 00       	cmp    $0x7fff,%eax
80108165:	7e 07                	jle    8010816e <sys_chown+0x8e>
        return -3; 
80108167:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
8010816c:	eb 17                	jmp    80108185 <sys_chown+0xa5>
    }

    return chown(path, owner, group);
8010816e:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80108171:	8b 55 f0             	mov    -0x10(%ebp),%edx
80108174:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108177:	83 ec 04             	sub    $0x4,%esp
8010817a:	51                   	push   %ecx
8010817b:	52                   	push   %edx
8010817c:	50                   	push   %eax
8010817d:	e8 70 a6 ff ff       	call   801027f2 <chown>
80108182:	83 c4 10             	add    $0x10,%esp
}
80108185:	c9                   	leave  
80108186:	c3                   	ret    

80108187 <outw>:
{
80108187:	55                   	push   %ebp
80108188:	89 e5                	mov    %esp,%ebp
8010818a:	83 ec 08             	sub    $0x8,%esp
8010818d:	8b 55 08             	mov    0x8(%ebp),%edx
80108190:	8b 45 0c             	mov    0xc(%ebp),%eax
80108193:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80108197:	66 89 45 f8          	mov    %ax,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010819b:	0f b7 45 f8          	movzwl -0x8(%ebp),%eax
8010819f:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801081a3:	66 ef                	out    %ax,(%dx)
}
801081a5:	90                   	nop
801081a6:	c9                   	leave  
801081a7:	c3                   	ret    

801081a8 <sys_fork>:
#include "uproc.h"
#endif

int
sys_fork(void)
{
801081a8:	f3 0f 1e fb          	endbr32 
801081ac:	55                   	push   %ebp
801081ad:	89 e5                	mov    %esp,%ebp
801081af:	83 ec 08             	sub    $0x8,%esp
  return fork();
801081b2:	e8 97 cb ff ff       	call   80104d4e <fork>
}
801081b7:	c9                   	leave  
801081b8:	c3                   	ret    

801081b9 <sys_exit>:

int
sys_exit(void)
{
801081b9:	f3 0f 1e fb          	endbr32 
801081bd:	55                   	push   %ebp
801081be:	89 e5                	mov    %esp,%ebp
801081c0:	83 ec 08             	sub    $0x8,%esp
  exit();
801081c3:	e8 10 ce ff ff       	call   80104fd8 <exit>
  return 0;  // not reached
801081c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
801081cd:	c9                   	leave  
801081ce:	c3                   	ret    

801081cf <sys_wait>:

int
sys_wait(void)
{
801081cf:	f3 0f 1e fb          	endbr32 
801081d3:	55                   	push   %ebp
801081d4:	89 e5                	mov    %esp,%ebp
801081d6:	83 ec 08             	sub    $0x8,%esp
  return wait();
801081d9:	e8 d6 d0 ff ff       	call   801052b4 <wait>
}
801081de:	c9                   	leave  
801081df:	c3                   	ret    

801081e0 <sys_kill>:

int
sys_kill(void)
{
801081e0:	f3 0f 1e fb          	endbr32 
801081e4:	55                   	push   %ebp
801081e5:	89 e5                	mov    %esp,%ebp
801081e7:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
801081ea:	83 ec 08             	sub    $0x8,%esp
801081ed:	8d 45 f4             	lea    -0xc(%ebp),%eax
801081f0:	50                   	push   %eax
801081f1:	6a 00                	push   $0x0
801081f3:	e8 e0 ef ff ff       	call   801071d8 <argint>
801081f8:	83 c4 10             	add    $0x10,%esp
801081fb:	85 c0                	test   %eax,%eax
801081fd:	79 07                	jns    80108206 <sys_kill+0x26>
    return -1;
801081ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108204:	eb 0f                	jmp    80108215 <sys_kill+0x35>
  return kill(pid);
80108206:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108209:	83 ec 0c             	sub    $0xc,%esp
8010820c:	50                   	push   %eax
8010820d:	e8 94 d9 ff ff       	call   80105ba6 <kill>
80108212:	83 c4 10             	add    $0x10,%esp
}
80108215:	c9                   	leave  
80108216:	c3                   	ret    

80108217 <sys_getpid>:

int
sys_getpid(void)
{
80108217:	f3 0f 1e fb          	endbr32 
8010821b:	55                   	push   %ebp
8010821c:	89 e5                	mov    %esp,%ebp
  return proc->pid;
8010821e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108224:	8b 40 10             	mov    0x10(%eax),%eax
}
80108227:	5d                   	pop    %ebp
80108228:	c3                   	ret    

80108229 <sys_sbrk>:

int
sys_sbrk(void)
{
80108229:	f3 0f 1e fb          	endbr32 
8010822d:	55                   	push   %ebp
8010822e:	89 e5                	mov    %esp,%ebp
80108230:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80108233:	83 ec 08             	sub    $0x8,%esp
80108236:	8d 45 f0             	lea    -0x10(%ebp),%eax
80108239:	50                   	push   %eax
8010823a:	6a 00                	push   $0x0
8010823c:	e8 97 ef ff ff       	call   801071d8 <argint>
80108241:	83 c4 10             	add    $0x10,%esp
80108244:	85 c0                	test   %eax,%eax
80108246:	79 07                	jns    8010824f <sys_sbrk+0x26>
    return -1;
80108248:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010824d:	eb 28                	jmp    80108277 <sys_sbrk+0x4e>
  addr = proc->sz;
8010824f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108255:	8b 00                	mov    (%eax),%eax
80108257:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
8010825a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010825d:	83 ec 0c             	sub    $0xc,%esp
80108260:	50                   	push   %eax
80108261:	e8 41 ca ff ff       	call   80104ca7 <growproc>
80108266:	83 c4 10             	add    $0x10,%esp
80108269:	85 c0                	test   %eax,%eax
8010826b:	79 07                	jns    80108274 <sys_sbrk+0x4b>
    return -1;
8010826d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108272:	eb 03                	jmp    80108277 <sys_sbrk+0x4e>
  return addr;
80108274:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80108277:	c9                   	leave  
80108278:	c3                   	ret    

80108279 <sys_sleep>:

int
sys_sleep(void)
{
80108279:	f3 0f 1e fb          	endbr32 
8010827d:	55                   	push   %ebp
8010827e:	89 e5                	mov    %esp,%ebp
80108280:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80108283:	83 ec 08             	sub    $0x8,%esp
80108286:	8d 45 f0             	lea    -0x10(%ebp),%eax
80108289:	50                   	push   %eax
8010828a:	6a 00                	push   $0x0
8010828c:	e8 47 ef ff ff       	call   801071d8 <argint>
80108291:	83 c4 10             	add    $0x10,%esp
80108294:	85 c0                	test   %eax,%eax
80108296:	79 07                	jns    8010829f <sys_sleep+0x26>
    return -1;
80108298:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010829d:	eb 44                	jmp    801082e3 <sys_sleep+0x6a>
  ticks0 = ticks;
8010829f:	a1 60 95 11 80       	mov    0x80119560,%eax
801082a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
801082a7:	eb 26                	jmp    801082cf <sys_sleep+0x56>
    if(proc->killed){
801082a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801082af:	8b 40 24             	mov    0x24(%eax),%eax
801082b2:	85 c0                	test   %eax,%eax
801082b4:	74 07                	je     801082bd <sys_sleep+0x44>
      return -1;
801082b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801082bb:	eb 26                	jmp    801082e3 <sys_sleep+0x6a>
    }
    sleep(&ticks, (struct spinlock *)0);
801082bd:	83 ec 08             	sub    $0x8,%esp
801082c0:	6a 00                	push   $0x0
801082c2:	68 60 95 11 80       	push   $0x80119560
801082c7:	e8 42 d6 ff ff       	call   8010590e <sleep>
801082cc:	83 c4 10             	add    $0x10,%esp
  while(ticks - ticks0 < n){
801082cf:	a1 60 95 11 80       	mov    0x80119560,%eax
801082d4:	2b 45 f4             	sub    -0xc(%ebp),%eax
801082d7:	8b 55 f0             	mov    -0x10(%ebp),%edx
801082da:	39 d0                	cmp    %edx,%eax
801082dc:	72 cb                	jb     801082a9 <sys_sleep+0x30>
  }
  return 0;
801082de:	b8 00 00 00 00       	mov    $0x0,%eax
}
801082e3:	c9                   	leave  
801082e4:	c3                   	ret    

801082e5 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start. 
int
sys_uptime(void)
{
801082e5:	f3 0f 1e fb          	endbr32 
801082e9:	55                   	push   %ebp
801082ea:	89 e5                	mov    %esp,%ebp
801082ec:	83 ec 10             	sub    $0x10,%esp
  uint xticks;
  
  xticks = ticks;
801082ef:	a1 60 95 11 80       	mov    0x80119560,%eax
801082f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return xticks;
801082f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801082fa:	c9                   	leave  
801082fb:	c3                   	ret    

801082fc <sys_halt>:

//Turn of the computer
int
sys_halt(void){
801082fc:	f3 0f 1e fb          	endbr32 
80108300:	55                   	push   %ebp
80108301:	89 e5                	mov    %esp,%ebp
80108303:	83 ec 08             	sub    $0x8,%esp
  cprintf("Shutting down ...\n");
80108306:	83 ec 0c             	sub    $0xc,%esp
80108309:	68 21 b1 10 80       	push   $0x8010b121
8010830e:	e8 cb 80 ff ff       	call   801003de <cprintf>
80108313:	83 c4 10             	add    $0x10,%esp
  outw( 0x604, 0x0 | 0x2000);
80108316:	83 ec 08             	sub    $0x8,%esp
80108319:	68 00 20 00 00       	push   $0x2000
8010831e:	68 04 06 00 00       	push   $0x604
80108323:	e8 5f fe ff ff       	call   80108187 <outw>
80108328:	83 c4 10             	add    $0x10,%esp
  return 0;
8010832b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108330:	c9                   	leave  
80108331:	c3                   	ret    

80108332 <sys_date>:

#ifdef BAGIAN_ID
int
sys_date(void) {
80108332:	f3 0f 1e fb          	endbr32 
80108336:	55                   	push   %ebp
80108337:	89 e5                	mov    %esp,%ebp
80108339:	83 ec 18             	sub    $0x18,%esp
    struct rtcdate *d;
    if (argptr(0, (void*)&d, sizeof(struct rtcdate)) < 0) {
8010833c:	83 ec 04             	sub    $0x4,%esp
8010833f:	6a 18                	push   $0x18
80108341:	8d 45 f4             	lea    -0xc(%ebp),%eax
80108344:	50                   	push   %eax
80108345:	6a 00                	push   $0x0
80108347:	e8 b8 ee ff ff       	call   80107204 <argptr>
8010834c:	83 c4 10             	add    $0x10,%esp
8010834f:	85 c0                	test   %eax,%eax
80108351:	79 07                	jns    8010835a <sys_date+0x28>
        return -1;
80108353:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108358:	eb 14                	jmp    8010836e <sys_date+0x3c>
    } else {
        cmostime(d);
8010835a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010835d:	83 ec 0c             	sub    $0xc,%esp
80108360:	50                   	push   %eax
80108361:	e8 e2 b1 ff ff       	call   80103548 <cmostime>
80108366:	83 c4 10             	add    $0x10,%esp
        return 0;
80108369:	b8 00 00 00 00       	mov    $0x0,%eax
    }
}
8010836e:	c9                   	leave  
8010836f:	c3                   	ret    

80108370 <sys_getuid>:

#ifdef BAGIAN_UPROC

// return process UID
int
sys_getuid(void) {
80108370:	f3 0f 1e fb          	endbr32 
80108374:	55                   	push   %ebp
80108375:	89 e5                	mov    %esp,%ebp
    return proc->uid;
80108377:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010837d:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
}
80108383:	5d                   	pop    %ebp
80108384:	c3                   	ret    

80108385 <sys_getgid>:

// return process GID
int
sys_getgid(void) {
80108385:	f3 0f 1e fb          	endbr32 
80108389:	55                   	push   %ebp
8010838a:	89 e5                	mov    %esp,%ebp
    return proc->gid;
8010838c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108392:	8b 80 84 00 00 00    	mov    0x84(%eax),%eax
}
80108398:	5d                   	pop    %ebp
80108399:	c3                   	ret    

8010839a <sys_getppid>:

// return process parent's PID
int
sys_getppid(void) {
8010839a:	f3 0f 1e fb          	endbr32 
8010839e:	55                   	push   %ebp
8010839f:	89 e5                	mov    %esp,%ebp
    return proc->parent->pid;
801083a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801083a7:	8b 40 14             	mov    0x14(%eax),%eax
801083aa:	8b 40 10             	mov    0x10(%eax),%eax
}
801083ad:	5d                   	pop    %ebp
801083ae:	c3                   	ret    

801083af <sys_setuid>:

// pull argument from stack, check range, set process UID
int
sys_setuid(void) {
801083af:	f3 0f 1e fb          	endbr32 
801083b3:	55                   	push   %ebp
801083b4:	89 e5                	mov    %esp,%ebp
801083b6:	83 ec 18             	sub    $0x18,%esp
    int n;
    if (argint(0, &n) < 0) {
801083b9:	83 ec 08             	sub    $0x8,%esp
801083bc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801083bf:	50                   	push   %eax
801083c0:	6a 00                	push   $0x0
801083c2:	e8 11 ee ff ff       	call   801071d8 <argint>
801083c7:	83 c4 10             	add    $0x10,%esp
801083ca:	85 c0                	test   %eax,%eax
801083cc:	79 07                	jns    801083d5 <sys_setuid+0x26>
        return -1;
801083ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801083d3:	eb 2c                	jmp    80108401 <sys_setuid+0x52>
    }
    if (n < 0 || n > 32767) {
801083d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083d8:	85 c0                	test   %eax,%eax
801083da:	78 0a                	js     801083e6 <sys_setuid+0x37>
801083dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083df:	3d ff 7f 00 00       	cmp    $0x7fff,%eax
801083e4:	7e 07                	jle    801083ed <sys_setuid+0x3e>
        return -1;
801083e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801083eb:	eb 14                	jmp    80108401 <sys_setuid+0x52>
    }
    proc->uid = n;
801083ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
801083f0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801083f6:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
    return 0;
801083fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108401:	c9                   	leave  
80108402:	c3                   	ret    

80108403 <sys_setgid>:

// pull argument from stack, check range, set process PID
int
sys_setgid(void) {
80108403:	f3 0f 1e fb          	endbr32 
80108407:	55                   	push   %ebp
80108408:	89 e5                	mov    %esp,%ebp
8010840a:	83 ec 18             	sub    $0x18,%esp
    int n;
    if (argint(0, &n) < 0) {
8010840d:	83 ec 08             	sub    $0x8,%esp
80108410:	8d 45 f4             	lea    -0xc(%ebp),%eax
80108413:	50                   	push   %eax
80108414:	6a 00                	push   $0x0
80108416:	e8 bd ed ff ff       	call   801071d8 <argint>
8010841b:	83 c4 10             	add    $0x10,%esp
8010841e:	85 c0                	test   %eax,%eax
80108420:	79 07                	jns    80108429 <sys_setgid+0x26>
        return -1;
80108422:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108427:	eb 2c                	jmp    80108455 <sys_setgid+0x52>
    }
    if (n < 0 || n > 32767) {
80108429:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010842c:	85 c0                	test   %eax,%eax
8010842e:	78 0a                	js     8010843a <sys_setgid+0x37>
80108430:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108433:	3d ff 7f 00 00       	cmp    $0x7fff,%eax
80108438:	7e 07                	jle    80108441 <sys_setgid+0x3e>
        return -1;
8010843a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010843f:	eb 14                	jmp    80108455 <sys_setgid+0x52>
    }
    proc->gid = n;
80108441:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108444:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010844a:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
    return 0;
80108450:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108455:	c9                   	leave  
80108456:	c3                   	ret    

80108457 <sys_getprocs>:

// pull arguments from stack, pass to proc.c getprocs(uint, struct)
int
sys_getprocs(void) {
80108457:	f3 0f 1e fb          	endbr32 
8010845b:	55                   	push   %ebp
8010845c:	89 e5                	mov    %esp,%ebp
8010845e:	83 ec 18             	sub    $0x18,%esp
    int n;
    struct uproc *u;
    if (argint(0, &n) < 0) {
80108461:	83 ec 08             	sub    $0x8,%esp
80108464:	8d 45 f4             	lea    -0xc(%ebp),%eax
80108467:	50                   	push   %eax
80108468:	6a 00                	push   $0x0
8010846a:	e8 69 ed ff ff       	call   801071d8 <argint>
8010846f:	83 c4 10             	add    $0x10,%esp
80108472:	85 c0                	test   %eax,%eax
80108474:	79 07                	jns    8010847d <sys_getprocs+0x26>
        return -1;
80108476:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010847b:	eb 3e                	jmp    801084bb <sys_getprocs+0x64>
    }
    // sizeof * MAX
    if (argptr(1, (void*)&u, (sizeof(struct uproc) * n)) < 0) {
8010847d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108480:	89 c2                	mov    %eax,%edx
80108482:	89 d0                	mov    %edx,%eax
80108484:	01 c0                	add    %eax,%eax
80108486:	01 d0                	add    %edx,%eax
80108488:	c1 e0 05             	shl    $0x5,%eax
8010848b:	83 ec 04             	sub    $0x4,%esp
8010848e:	50                   	push   %eax
8010848f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80108492:	50                   	push   %eax
80108493:	6a 01                	push   $0x1
80108495:	e8 6a ed ff ff       	call   80107204 <argptr>
8010849a:	83 c4 10             	add    $0x10,%esp
8010849d:	85 c0                	test   %eax,%eax
8010849f:	79 07                	jns    801084a8 <sys_getprocs+0x51>
        return -1;
801084a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801084a6:	eb 13                	jmp    801084bb <sys_getprocs+0x64>
    }
    return getprocs(n, u);
801084a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801084ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
801084ae:	83 ec 08             	sub    $0x8,%esp
801084b1:	50                   	push   %eax
801084b2:	52                   	push   %edx
801084b3:	e8 1d dc ff ff       	call   801060d5 <getprocs>
801084b8:	83 c4 10             	add    $0x10,%esp
}
801084bb:	c9                   	leave  
801084bc:	c3                   	ret    

801084bd <sys_setpriority>:
#endif

#ifdef BAGIAN_INODE
int
sys_setpriority(void) {
801084bd:	f3 0f 1e fb          	endbr32 
801084c1:	55                   	push   %ebp
801084c2:	89 e5                	mov    %esp,%ebp
801084c4:	83 ec 18             	sub    $0x18,%esp
    int n, i;
    // PID argument from stack
    if (argint(0, &n) < 0) {
801084c7:	83 ec 08             	sub    $0x8,%esp
801084ca:	8d 45 f4             	lea    -0xc(%ebp),%eax
801084cd:	50                   	push   %eax
801084ce:	6a 00                	push   $0x0
801084d0:	e8 03 ed ff ff       	call   801071d8 <argint>
801084d5:	83 c4 10             	add    $0x10,%esp
801084d8:	85 c0                	test   %eax,%eax
801084da:	79 07                	jns    801084e3 <sys_setpriority+0x26>
        return -1;
801084dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801084e1:	eb 5d                	jmp    80108540 <sys_setpriority+0x83>
    }
    // priority argument
    if (argint(1, &i) < 0) {
801084e3:	83 ec 08             	sub    $0x8,%esp
801084e6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801084e9:	50                   	push   %eax
801084ea:	6a 01                	push   $0x1
801084ec:	e8 e7 ec ff ff       	call   801071d8 <argint>
801084f1:	83 c4 10             	add    $0x10,%esp
801084f4:	85 c0                	test   %eax,%eax
801084f6:	79 07                	jns    801084ff <sys_setpriority+0x42>
        return -1;
801084f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801084fd:	eb 41                	jmp    80108540 <sys_setpriority+0x83>
    }
    // check bounds of PID argument
    if (n < 0 || n > 32767) {
801084ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108502:	85 c0                	test   %eax,%eax
80108504:	78 0a                	js     80108510 <sys_setpriority+0x53>
80108506:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108509:	3d ff 7f 00 00       	cmp    $0x7fff,%eax
8010850e:	7e 07                	jle    80108517 <sys_setpriority+0x5a>
        return -1;
80108510:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108515:	eb 29                	jmp    80108540 <sys_setpriority+0x83>
    }
    // check bounds of priority argument
    if (i < 0 || i > MAX) {
80108517:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010851a:	85 c0                	test   %eax,%eax
8010851c:	78 08                	js     80108526 <sys_setpriority+0x69>
8010851e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108521:	83 f8 02             	cmp    $0x2,%eax
80108524:	7e 07                	jle    8010852d <sys_setpriority+0x70>
        return -1;
80108526:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010852b:	eb 13                	jmp    80108540 <sys_setpriority+0x83>
    }
    return setpriority(n, i); // pass to user-side
8010852d:	8b 55 f0             	mov    -0x10(%ebp),%edx
80108530:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108533:	83 ec 08             	sub    $0x8,%esp
80108536:	52                   	push   %edx
80108537:	50                   	push   %eax
80108538:	e8 77 e4 ff ff       	call   801069b4 <setpriority>
8010853d:	83 c4 10             	add    $0x10,%esp
}
80108540:	c9                   	leave  
80108541:	c3                   	ret    

80108542 <outb>:
{
80108542:	55                   	push   %ebp
80108543:	89 e5                	mov    %esp,%ebp
80108545:	83 ec 08             	sub    $0x8,%esp
80108548:	8b 45 08             	mov    0x8(%ebp),%eax
8010854b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010854e:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80108552:	89 d0                	mov    %edx,%eax
80108554:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80108557:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010855b:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010855f:	ee                   	out    %al,(%dx)
}
80108560:	90                   	nop
80108561:	c9                   	leave  
80108562:	c3                   	ret    

80108563 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80108563:	f3 0f 1e fb          	endbr32 
80108567:	55                   	push   %ebp
80108568:	89 e5                	mov    %esp,%ebp
8010856a:	83 ec 08             	sub    $0x8,%esp
  // Interrupt TPS times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
8010856d:	6a 34                	push   $0x34
8010856f:	6a 43                	push   $0x43
80108571:	e8 cc ff ff ff       	call   80108542 <outb>
80108576:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(TPS) % 256);
80108579:	68 a9 00 00 00       	push   $0xa9
8010857e:	6a 40                	push   $0x40
80108580:	e8 bd ff ff ff       	call   80108542 <outb>
80108585:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(TPS) / 256);
80108588:	6a 04                	push   $0x4
8010858a:	6a 40                	push   $0x40
8010858c:	e8 b1 ff ff ff       	call   80108542 <outb>
80108591:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
80108594:	83 ec 0c             	sub    $0xc,%esp
80108597:	6a 00                	push   $0x0
80108599:	e8 84 bd ff ff       	call   80104322 <picenable>
8010859e:	83 c4 10             	add    $0x10,%esp
}
801085a1:	90                   	nop
801085a2:	c9                   	leave  
801085a3:	c3                   	ret    

801085a4 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801085a4:	1e                   	push   %ds
  pushl %es
801085a5:	06                   	push   %es
  pushl %fs
801085a6:	0f a0                	push   %fs
  pushl %gs
801085a8:	0f a8                	push   %gs
  pushal
801085aa:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
801085ab:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801085af:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801085b1:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
801085b3:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
801085b7:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
801085b9:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
801085bb:	54                   	push   %esp
  call trap
801085bc:	e8 d6 01 00 00       	call   80108797 <trap>
  addl $4, %esp
801085c1:	83 c4 04             	add    $0x4,%esp

801085c4 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801085c4:	61                   	popa   
  popl %gs
801085c5:	0f a9                	pop    %gs
  popl %fs
801085c7:	0f a1                	pop    %fs
  popl %es
801085c9:	07                   	pop    %es
  popl %ds
801085ca:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801085cb:	83 c4 08             	add    $0x8,%esp
  iret
801085ce:	cf                   	iret   

801085cf <atom_inc>:
{
801085cf:	55                   	push   %ebp
801085d0:	89 e5                	mov    %esp,%ebp
  asm volatile ( "lock incl %0" : "=m" (*num));
801085d2:	8b 45 08             	mov    0x8(%ebp),%eax
801085d5:	f0 ff 00             	lock incl (%eax)
}
801085d8:	90                   	nop
801085d9:	5d                   	pop    %ebp
801085da:	c3                   	ret    

801085db <lidt>:
{
801085db:	55                   	push   %ebp
801085dc:	89 e5                	mov    %esp,%ebp
801085de:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
801085e1:	8b 45 0c             	mov    0xc(%ebp),%eax
801085e4:	83 e8 01             	sub    $0x1,%eax
801085e7:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801085eb:	8b 45 08             	mov    0x8(%ebp),%eax
801085ee:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801085f2:	8b 45 08             	mov    0x8(%ebp),%eax
801085f5:	c1 e8 10             	shr    $0x10,%eax
801085f8:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801085fc:	8d 45 fa             	lea    -0x6(%ebp),%eax
801085ff:	0f 01 18             	lidtl  (%eax)
}
80108602:	90                   	nop
80108603:	c9                   	leave  
80108604:	c3                   	ret    

80108605 <rcr2>:

static inline uint
rcr2(void)
{
80108605:	55                   	push   %ebp
80108606:	89 e5                	mov    %esp,%ebp
80108608:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010860b:	0f 20 d0             	mov    %cr2,%eax
8010860e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80108611:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80108614:	c9                   	leave  
80108615:	c3                   	ret    

80108616 <tvinit>:
// Software Developer’s Manual, Vol 3A, 8.1.1 Guaranteed Atomic Operations.
uint ticks __attribute__ ((aligned (4)));

void
tvinit(void)
{
80108616:	f3 0f 1e fb          	endbr32 
8010861a:	55                   	push   %ebp
8010861b:	89 e5                	mov    %esp,%ebp
8010861d:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
80108620:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80108627:	e9 c3 00 00 00       	jmp    801086ef <tvinit+0xd9>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
8010862c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010862f:	8b 04 85 c0 e0 10 80 	mov    -0x7fef1f40(,%eax,4),%eax
80108636:	89 c2                	mov    %eax,%edx
80108638:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010863b:	66 89 14 c5 60 8d 11 	mov    %dx,-0x7fee72a0(,%eax,8)
80108642:	80 
80108643:	8b 45 fc             	mov    -0x4(%ebp),%eax
80108646:	66 c7 04 c5 62 8d 11 	movw   $0x8,-0x7fee729e(,%eax,8)
8010864d:	80 08 00 
80108650:	8b 45 fc             	mov    -0x4(%ebp),%eax
80108653:	0f b6 14 c5 64 8d 11 	movzbl -0x7fee729c(,%eax,8),%edx
8010865a:	80 
8010865b:	83 e2 e0             	and    $0xffffffe0,%edx
8010865e:	88 14 c5 64 8d 11 80 	mov    %dl,-0x7fee729c(,%eax,8)
80108665:	8b 45 fc             	mov    -0x4(%ebp),%eax
80108668:	0f b6 14 c5 64 8d 11 	movzbl -0x7fee729c(,%eax,8),%edx
8010866f:	80 
80108670:	83 e2 1f             	and    $0x1f,%edx
80108673:	88 14 c5 64 8d 11 80 	mov    %dl,-0x7fee729c(,%eax,8)
8010867a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010867d:	0f b6 14 c5 65 8d 11 	movzbl -0x7fee729b(,%eax,8),%edx
80108684:	80 
80108685:	83 e2 f0             	and    $0xfffffff0,%edx
80108688:	83 ca 0e             	or     $0xe,%edx
8010868b:	88 14 c5 65 8d 11 80 	mov    %dl,-0x7fee729b(,%eax,8)
80108692:	8b 45 fc             	mov    -0x4(%ebp),%eax
80108695:	0f b6 14 c5 65 8d 11 	movzbl -0x7fee729b(,%eax,8),%edx
8010869c:	80 
8010869d:	83 e2 ef             	and    $0xffffffef,%edx
801086a0:	88 14 c5 65 8d 11 80 	mov    %dl,-0x7fee729b(,%eax,8)
801086a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
801086aa:	0f b6 14 c5 65 8d 11 	movzbl -0x7fee729b(,%eax,8),%edx
801086b1:	80 
801086b2:	83 e2 9f             	and    $0xffffff9f,%edx
801086b5:	88 14 c5 65 8d 11 80 	mov    %dl,-0x7fee729b(,%eax,8)
801086bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
801086bf:	0f b6 14 c5 65 8d 11 	movzbl -0x7fee729b(,%eax,8),%edx
801086c6:	80 
801086c7:	83 ca 80             	or     $0xffffff80,%edx
801086ca:	88 14 c5 65 8d 11 80 	mov    %dl,-0x7fee729b(,%eax,8)
801086d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801086d4:	8b 04 85 c0 e0 10 80 	mov    -0x7fef1f40(,%eax,4),%eax
801086db:	c1 e8 10             	shr    $0x10,%eax
801086de:	89 c2                	mov    %eax,%edx
801086e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801086e3:	66 89 14 c5 66 8d 11 	mov    %dx,-0x7fee729a(,%eax,8)
801086ea:	80 
  for(i = 0; i < 256; i++)
801086eb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801086ef:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
801086f6:	0f 8e 30 ff ff ff    	jle    8010862c <tvinit+0x16>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801086fc:	a1 c0 e1 10 80       	mov    0x8010e1c0,%eax
80108701:	66 a3 60 8f 11 80    	mov    %ax,0x80118f60
80108707:	66 c7 05 62 8f 11 80 	movw   $0x8,0x80118f62
8010870e:	08 00 
80108710:	0f b6 05 64 8f 11 80 	movzbl 0x80118f64,%eax
80108717:	83 e0 e0             	and    $0xffffffe0,%eax
8010871a:	a2 64 8f 11 80       	mov    %al,0x80118f64
8010871f:	0f b6 05 64 8f 11 80 	movzbl 0x80118f64,%eax
80108726:	83 e0 1f             	and    $0x1f,%eax
80108729:	a2 64 8f 11 80       	mov    %al,0x80118f64
8010872e:	0f b6 05 65 8f 11 80 	movzbl 0x80118f65,%eax
80108735:	83 c8 0f             	or     $0xf,%eax
80108738:	a2 65 8f 11 80       	mov    %al,0x80118f65
8010873d:	0f b6 05 65 8f 11 80 	movzbl 0x80118f65,%eax
80108744:	83 e0 ef             	and    $0xffffffef,%eax
80108747:	a2 65 8f 11 80       	mov    %al,0x80118f65
8010874c:	0f b6 05 65 8f 11 80 	movzbl 0x80118f65,%eax
80108753:	83 c8 60             	or     $0x60,%eax
80108756:	a2 65 8f 11 80       	mov    %al,0x80118f65
8010875b:	0f b6 05 65 8f 11 80 	movzbl 0x80118f65,%eax
80108762:	83 c8 80             	or     $0xffffff80,%eax
80108765:	a2 65 8f 11 80       	mov    %al,0x80118f65
8010876a:	a1 c0 e1 10 80       	mov    0x8010e1c0,%eax
8010876f:	c1 e8 10             	shr    $0x10,%eax
80108772:	66 a3 66 8f 11 80    	mov    %ax,0x80118f66
  
}
80108778:	90                   	nop
80108779:	c9                   	leave  
8010877a:	c3                   	ret    

8010877b <idtinit>:

void
idtinit(void)
{
8010877b:	f3 0f 1e fb          	endbr32 
8010877f:	55                   	push   %ebp
80108780:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80108782:	68 00 08 00 00       	push   $0x800
80108787:	68 60 8d 11 80       	push   $0x80118d60
8010878c:	e8 4a fe ff ff       	call   801085db <lidt>
80108791:	83 c4 08             	add    $0x8,%esp
}
80108794:	90                   	nop
80108795:	c9                   	leave  
80108796:	c3                   	ret    

80108797 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80108797:	f3 0f 1e fb          	endbr32 
8010879b:	55                   	push   %ebp
8010879c:	89 e5                	mov    %esp,%ebp
8010879e:	57                   	push   %edi
8010879f:	56                   	push   %esi
801087a0:	53                   	push   %ebx
801087a1:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
801087a4:	8b 45 08             	mov    0x8(%ebp),%eax
801087a7:	8b 40 30             	mov    0x30(%eax),%eax
801087aa:	83 f8 40             	cmp    $0x40,%eax
801087ad:	75 3e                	jne    801087ed <trap+0x56>
    if(proc->killed)
801087af:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801087b5:	8b 40 24             	mov    0x24(%eax),%eax
801087b8:	85 c0                	test   %eax,%eax
801087ba:	74 05                	je     801087c1 <trap+0x2a>
      exit();
801087bc:	e8 17 c8 ff ff       	call   80104fd8 <exit>
    proc->tf = tf;
801087c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801087c7:	8b 55 08             	mov    0x8(%ebp),%edx
801087ca:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
801087cd:	e8 c8 ea ff ff       	call   8010729a <syscall>
    if(proc->killed)
801087d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801087d8:	8b 40 24             	mov    0x24(%eax),%eax
801087db:	85 c0                	test   %eax,%eax
801087dd:	0f 84 23 02 00 00    	je     80108a06 <trap+0x26f>
      exit();
801087e3:	e8 f0 c7 ff ff       	call   80104fd8 <exit>
    return;
801087e8:	e9 19 02 00 00       	jmp    80108a06 <trap+0x26f>
  }

  switch(tf->trapno){
801087ed:	8b 45 08             	mov    0x8(%ebp),%eax
801087f0:	8b 40 30             	mov    0x30(%eax),%eax
801087f3:	83 e8 20             	sub    $0x20,%eax
801087f6:	83 f8 1f             	cmp    $0x1f,%eax
801087f9:	0f 87 a4 00 00 00    	ja     801088a3 <trap+0x10c>
801087ff:	8b 04 85 d4 b1 10 80 	mov    -0x7fef4e2c(,%eax,4),%eax
80108806:	3e ff e0             	notrack jmp *%eax
  case T_IRQ0 + IRQ_TIMER:
   if(cpu->id == 0){
80108809:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010880f:	0f b6 00             	movzbl (%eax),%eax
80108812:	84 c0                	test   %al,%al
80108814:	75 20                	jne    80108836 <trap+0x9f>
      atom_inc((int *)&ticks);   // guaranteed atomic so no lock necessary
80108816:	83 ec 0c             	sub    $0xc,%esp
80108819:	68 60 95 11 80       	push   $0x80119560
8010881e:	e8 ac fd ff ff       	call   801085cf <atom_inc>
80108823:	83 c4 10             	add    $0x10,%esp
      wakeup(&ticks);
80108826:	83 ec 0c             	sub    $0xc,%esp
80108829:	68 60 95 11 80       	push   $0x80119560
8010882e:	e8 38 d3 ff ff       	call   80105b6b <wakeup>
80108833:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80108836:	e8 5f ab ff ff       	call   8010339a <lapiceoi>
    break;
8010883b:	e9 1d 01 00 00       	jmp    8010895d <trap+0x1c6>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80108840:	e8 24 a3 ff ff       	call   80102b69 <ideintr>
    lapiceoi();
80108845:	e8 50 ab ff ff       	call   8010339a <lapiceoi>
    break;
8010884a:	e9 0e 01 00 00       	jmp    8010895d <trap+0x1c6>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
8010884f:	e8 35 a9 ff ff       	call   80103189 <kbdintr>
    lapiceoi();
80108854:	e8 41 ab ff ff       	call   8010339a <lapiceoi>
    break;
80108859:	e9 ff 00 00 00       	jmp    8010895d <trap+0x1c6>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
8010885e:	e8 92 03 00 00       	call   80108bf5 <uartintr>
    lapiceoi();
80108863:	e8 32 ab ff ff       	call   8010339a <lapiceoi>
    break;
80108868:	e9 f0 00 00 00       	jmp    8010895d <trap+0x1c6>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010886d:	8b 45 08             	mov    0x8(%ebp),%eax
80108870:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80108873:	8b 45 08             	mov    0x8(%ebp),%eax
80108876:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010887a:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
8010887d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108883:	0f b6 00             	movzbl (%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80108886:	0f b6 c0             	movzbl %al,%eax
80108889:	51                   	push   %ecx
8010888a:	52                   	push   %edx
8010888b:	50                   	push   %eax
8010888c:	68 34 b1 10 80       	push   $0x8010b134
80108891:	e8 48 7b ff ff       	call   801003de <cprintf>
80108896:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80108899:	e8 fc aa ff ff       	call   8010339a <lapiceoi>
    break;
8010889e:	e9 ba 00 00 00       	jmp    8010895d <trap+0x1c6>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
801088a3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801088a9:	85 c0                	test   %eax,%eax
801088ab:	74 11                	je     801088be <trap+0x127>
801088ad:	8b 45 08             	mov    0x8(%ebp),%eax
801088b0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801088b4:	0f b7 c0             	movzwl %ax,%eax
801088b7:	83 e0 03             	and    $0x3,%eax
801088ba:	85 c0                	test   %eax,%eax
801088bc:	75 3f                	jne    801088fd <trap+0x166>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801088be:	e8 42 fd ff ff       	call   80108605 <rcr2>
801088c3:	8b 55 08             	mov    0x8(%ebp),%edx
801088c6:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
801088c9:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801088d0:	0f b6 12             	movzbl (%edx),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801088d3:	0f b6 ca             	movzbl %dl,%ecx
801088d6:	8b 55 08             	mov    0x8(%ebp),%edx
801088d9:	8b 52 30             	mov    0x30(%edx),%edx
801088dc:	83 ec 0c             	sub    $0xc,%esp
801088df:	50                   	push   %eax
801088e0:	53                   	push   %ebx
801088e1:	51                   	push   %ecx
801088e2:	52                   	push   %edx
801088e3:	68 58 b1 10 80       	push   $0x8010b158
801088e8:	e8 f1 7a ff ff       	call   801003de <cprintf>
801088ed:	83 c4 20             	add    $0x20,%esp
      panic("trap");
801088f0:	83 ec 0c             	sub    $0xc,%esp
801088f3:	68 8a b1 10 80       	push   $0x8010b18a
801088f8:	e8 9a 7c ff ff       	call   80100597 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801088fd:	e8 03 fd ff ff       	call   80108605 <rcr2>
80108902:	89 c2                	mov    %eax,%edx
80108904:	8b 45 08             	mov    0x8(%ebp),%eax
80108907:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
8010890a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80108910:	0f b6 00             	movzbl (%eax),%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80108913:	0f b6 f0             	movzbl %al,%esi
80108916:	8b 45 08             	mov    0x8(%ebp),%eax
80108919:	8b 58 34             	mov    0x34(%eax),%ebx
8010891c:	8b 45 08             	mov    0x8(%ebp),%eax
8010891f:	8b 48 30             	mov    0x30(%eax),%ecx
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80108922:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108928:	83 c0 6c             	add    $0x6c,%eax
8010892b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010892e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80108934:	8b 40 10             	mov    0x10(%eax),%eax
80108937:	52                   	push   %edx
80108938:	57                   	push   %edi
80108939:	56                   	push   %esi
8010893a:	53                   	push   %ebx
8010893b:	51                   	push   %ecx
8010893c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010893f:	50                   	push   %eax
80108940:	68 90 b1 10 80       	push   $0x8010b190
80108945:	e8 94 7a ff ff       	call   801003de <cprintf>
8010894a:	83 c4 20             	add    $0x20,%esp
            rcr2());
    proc->killed = 1;
8010894d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108953:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010895a:	eb 01                	jmp    8010895d <trap+0x1c6>
    break;
8010895c:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
8010895d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108963:	85 c0                	test   %eax,%eax
80108965:	74 24                	je     8010898b <trap+0x1f4>
80108967:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010896d:	8b 40 24             	mov    0x24(%eax),%eax
80108970:	85 c0                	test   %eax,%eax
80108972:	74 17                	je     8010898b <trap+0x1f4>
80108974:	8b 45 08             	mov    0x8(%ebp),%eax
80108977:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
8010897b:	0f b7 c0             	movzwl %ax,%eax
8010897e:	83 e0 03             	and    $0x3,%eax
80108981:	83 f8 03             	cmp    $0x3,%eax
80108984:	75 05                	jne    8010898b <trap+0x1f4>
    exit();
80108986:	e8 4d c6 ff ff       	call   80104fd8 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING &&
8010898b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80108991:	85 c0                	test   %eax,%eax
80108993:	74 41                	je     801089d6 <trap+0x23f>
80108995:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010899b:	8b 40 0c             	mov    0xc(%eax),%eax
8010899e:	83 f8 04             	cmp    $0x4,%eax
801089a1:	75 33                	jne    801089d6 <trap+0x23f>
	  tf->trapno == T_IRQ0+IRQ_TIMER && ticks%SCHED_INTERVAL==0)
801089a3:	8b 45 08             	mov    0x8(%ebp),%eax
801089a6:	8b 40 30             	mov    0x30(%eax),%eax
  if(proc && proc->state == RUNNING &&
801089a9:	83 f8 20             	cmp    $0x20,%eax
801089ac:	75 28                	jne    801089d6 <trap+0x23f>
	  tf->trapno == T_IRQ0+IRQ_TIMER && ticks%SCHED_INTERVAL==0)
801089ae:	8b 0d 60 95 11 80    	mov    0x80119560,%ecx
801089b4:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801089b9:	89 c8                	mov    %ecx,%eax
801089bb:	f7 e2                	mul    %edx
801089bd:	c1 ea 03             	shr    $0x3,%edx
801089c0:	89 d0                	mov    %edx,%eax
801089c2:	c1 e0 02             	shl    $0x2,%eax
801089c5:	01 d0                	add    %edx,%eax
801089c7:	01 c0                	add    %eax,%eax
801089c9:	29 c1                	sub    %eax,%ecx
801089cb:	89 ca                	mov    %ecx,%edx
801089cd:	85 d2                	test   %edx,%edx
801089cf:	75 05                	jne    801089d6 <trap+0x23f>
    yield();
801089d1:	e8 b2 cd ff ff       	call   80105788 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801089d6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801089dc:	85 c0                	test   %eax,%eax
801089de:	74 27                	je     80108a07 <trap+0x270>
801089e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801089e6:	8b 40 24             	mov    0x24(%eax),%eax
801089e9:	85 c0                	test   %eax,%eax
801089eb:	74 1a                	je     80108a07 <trap+0x270>
801089ed:	8b 45 08             	mov    0x8(%ebp),%eax
801089f0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801089f4:	0f b7 c0             	movzwl %ax,%eax
801089f7:	83 e0 03             	and    $0x3,%eax
801089fa:	83 f8 03             	cmp    $0x3,%eax
801089fd:	75 08                	jne    80108a07 <trap+0x270>
    exit();
801089ff:	e8 d4 c5 ff ff       	call   80104fd8 <exit>
80108a04:	eb 01                	jmp    80108a07 <trap+0x270>
    return;
80108a06:	90                   	nop
}
80108a07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108a0a:	5b                   	pop    %ebx
80108a0b:	5e                   	pop    %esi
80108a0c:	5f                   	pop    %edi
80108a0d:	5d                   	pop    %ebp
80108a0e:	c3                   	ret    

80108a0f <inb>:
{
80108a0f:	55                   	push   %ebp
80108a10:	89 e5                	mov    %esp,%ebp
80108a12:	83 ec 14             	sub    $0x14,%esp
80108a15:	8b 45 08             	mov    0x8(%ebp),%eax
80108a18:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80108a1c:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80108a20:	89 c2                	mov    %eax,%edx
80108a22:	ec                   	in     (%dx),%al
80108a23:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80108a26:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80108a2a:	c9                   	leave  
80108a2b:	c3                   	ret    

80108a2c <outb>:
{
80108a2c:	55                   	push   %ebp
80108a2d:	89 e5                	mov    %esp,%ebp
80108a2f:	83 ec 08             	sub    $0x8,%esp
80108a32:	8b 45 08             	mov    0x8(%ebp),%eax
80108a35:	8b 55 0c             	mov    0xc(%ebp),%edx
80108a38:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80108a3c:	89 d0                	mov    %edx,%eax
80108a3e:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80108a41:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80108a45:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80108a49:	ee                   	out    %al,(%dx)
}
80108a4a:	90                   	nop
80108a4b:	c9                   	leave  
80108a4c:	c3                   	ret    

80108a4d <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80108a4d:	f3 0f 1e fb          	endbr32 
80108a51:	55                   	push   %ebp
80108a52:	89 e5                	mov    %esp,%ebp
80108a54:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80108a57:	6a 00                	push   $0x0
80108a59:	68 fa 03 00 00       	push   $0x3fa
80108a5e:	e8 c9 ff ff ff       	call   80108a2c <outb>
80108a63:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80108a66:	68 80 00 00 00       	push   $0x80
80108a6b:	68 fb 03 00 00       	push   $0x3fb
80108a70:	e8 b7 ff ff ff       	call   80108a2c <outb>
80108a75:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80108a78:	6a 0c                	push   $0xc
80108a7a:	68 f8 03 00 00       	push   $0x3f8
80108a7f:	e8 a8 ff ff ff       	call   80108a2c <outb>
80108a84:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80108a87:	6a 00                	push   $0x0
80108a89:	68 f9 03 00 00       	push   $0x3f9
80108a8e:	e8 99 ff ff ff       	call   80108a2c <outb>
80108a93:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80108a96:	6a 03                	push   $0x3
80108a98:	68 fb 03 00 00       	push   $0x3fb
80108a9d:	e8 8a ff ff ff       	call   80108a2c <outb>
80108aa2:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80108aa5:	6a 00                	push   $0x0
80108aa7:	68 fc 03 00 00       	push   $0x3fc
80108aac:	e8 7b ff ff ff       	call   80108a2c <outb>
80108ab1:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80108ab4:	6a 01                	push   $0x1
80108ab6:	68 f9 03 00 00       	push   $0x3f9
80108abb:	e8 6c ff ff ff       	call   80108a2c <outb>
80108ac0:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80108ac3:	68 fd 03 00 00       	push   $0x3fd
80108ac8:	e8 42 ff ff ff       	call   80108a0f <inb>
80108acd:	83 c4 04             	add    $0x4,%esp
80108ad0:	3c ff                	cmp    $0xff,%al
80108ad2:	74 6e                	je     80108b42 <uartinit+0xf5>
    return;
  uart = 1;
80108ad4:	c7 05 6c e6 10 80 01 	movl   $0x1,0x8010e66c
80108adb:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80108ade:	68 fa 03 00 00       	push   $0x3fa
80108ae3:	e8 27 ff ff ff       	call   80108a0f <inb>
80108ae8:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80108aeb:	68 f8 03 00 00       	push   $0x3f8
80108af0:	e8 1a ff ff ff       	call   80108a0f <inb>
80108af5:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
80108af8:	83 ec 0c             	sub    $0xc,%esp
80108afb:	6a 04                	push   $0x4
80108afd:	e8 20 b8 ff ff       	call   80104322 <picenable>
80108b02:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
80108b05:	83 ec 08             	sub    $0x8,%esp
80108b08:	6a 00                	push   $0x0
80108b0a:	6a 04                	push   $0x4
80108b0c:	e8 0e a3 ff ff       	call   80102e1f <ioapicenable>
80108b11:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80108b14:	c7 45 f4 54 b2 10 80 	movl   $0x8010b254,-0xc(%ebp)
80108b1b:	eb 19                	jmp    80108b36 <uartinit+0xe9>
    uartputc(*p);
80108b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b20:	0f b6 00             	movzbl (%eax),%eax
80108b23:	0f be c0             	movsbl %al,%eax
80108b26:	83 ec 0c             	sub    $0xc,%esp
80108b29:	50                   	push   %eax
80108b2a:	e8 16 00 00 00       	call   80108b45 <uartputc>
80108b2f:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80108b32:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b39:	0f b6 00             	movzbl (%eax),%eax
80108b3c:	84 c0                	test   %al,%al
80108b3e:	75 dd                	jne    80108b1d <uartinit+0xd0>
80108b40:	eb 01                	jmp    80108b43 <uartinit+0xf6>
    return;
80108b42:	90                   	nop
}
80108b43:	c9                   	leave  
80108b44:	c3                   	ret    

80108b45 <uartputc>:

void
uartputc(int c)
{
80108b45:	f3 0f 1e fb          	endbr32 
80108b49:	55                   	push   %ebp
80108b4a:	89 e5                	mov    %esp,%ebp
80108b4c:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80108b4f:	a1 6c e6 10 80       	mov    0x8010e66c,%eax
80108b54:	85 c0                	test   %eax,%eax
80108b56:	74 53                	je     80108bab <uartputc+0x66>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80108b58:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108b5f:	eb 11                	jmp    80108b72 <uartputc+0x2d>
    microdelay(10);
80108b61:	83 ec 0c             	sub    $0xc,%esp
80108b64:	6a 0a                	push   $0xa
80108b66:	e8 4e a8 ff ff       	call   801033b9 <microdelay>
80108b6b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80108b6e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80108b72:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80108b76:	7f 1a                	jg     80108b92 <uartputc+0x4d>
80108b78:	83 ec 0c             	sub    $0xc,%esp
80108b7b:	68 fd 03 00 00       	push   $0x3fd
80108b80:	e8 8a fe ff ff       	call   80108a0f <inb>
80108b85:	83 c4 10             	add    $0x10,%esp
80108b88:	0f b6 c0             	movzbl %al,%eax
80108b8b:	83 e0 20             	and    $0x20,%eax
80108b8e:	85 c0                	test   %eax,%eax
80108b90:	74 cf                	je     80108b61 <uartputc+0x1c>
  outb(COM1+0, c);
80108b92:	8b 45 08             	mov    0x8(%ebp),%eax
80108b95:	0f b6 c0             	movzbl %al,%eax
80108b98:	83 ec 08             	sub    $0x8,%esp
80108b9b:	50                   	push   %eax
80108b9c:	68 f8 03 00 00       	push   $0x3f8
80108ba1:	e8 86 fe ff ff       	call   80108a2c <outb>
80108ba6:	83 c4 10             	add    $0x10,%esp
80108ba9:	eb 01                	jmp    80108bac <uartputc+0x67>
    return;
80108bab:	90                   	nop
}
80108bac:	c9                   	leave  
80108bad:	c3                   	ret    

80108bae <uartgetc>:

static int
uartgetc(void)
{
80108bae:	f3 0f 1e fb          	endbr32 
80108bb2:	55                   	push   %ebp
80108bb3:	89 e5                	mov    %esp,%ebp
  if(!uart)
80108bb5:	a1 6c e6 10 80       	mov    0x8010e66c,%eax
80108bba:	85 c0                	test   %eax,%eax
80108bbc:	75 07                	jne    80108bc5 <uartgetc+0x17>
    return -1;
80108bbe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108bc3:	eb 2e                	jmp    80108bf3 <uartgetc+0x45>
  if(!(inb(COM1+5) & 0x01))
80108bc5:	68 fd 03 00 00       	push   $0x3fd
80108bca:	e8 40 fe ff ff       	call   80108a0f <inb>
80108bcf:	83 c4 04             	add    $0x4,%esp
80108bd2:	0f b6 c0             	movzbl %al,%eax
80108bd5:	83 e0 01             	and    $0x1,%eax
80108bd8:	85 c0                	test   %eax,%eax
80108bda:	75 07                	jne    80108be3 <uartgetc+0x35>
    return -1;
80108bdc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108be1:	eb 10                	jmp    80108bf3 <uartgetc+0x45>
  return inb(COM1+0);
80108be3:	68 f8 03 00 00       	push   $0x3f8
80108be8:	e8 22 fe ff ff       	call   80108a0f <inb>
80108bed:	83 c4 04             	add    $0x4,%esp
80108bf0:	0f b6 c0             	movzbl %al,%eax
}
80108bf3:	c9                   	leave  
80108bf4:	c3                   	ret    

80108bf5 <uartintr>:

void
uartintr(void)
{
80108bf5:	f3 0f 1e fb          	endbr32 
80108bf9:	55                   	push   %ebp
80108bfa:	89 e5                	mov    %esp,%ebp
80108bfc:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80108bff:	83 ec 0c             	sub    $0xc,%esp
80108c02:	68 ae 8b 10 80       	push   $0x80108bae
80108c07:	e8 32 7c ff ff       	call   8010083e <consoleintr>
80108c0c:	83 c4 10             	add    $0x10,%esp
}
80108c0f:	90                   	nop
80108c10:	c9                   	leave  
80108c11:	c3                   	ret    

80108c12 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80108c12:	6a 00                	push   $0x0
  pushl $0
80108c14:	6a 00                	push   $0x0
  jmp alltraps
80108c16:	e9 89 f9 ff ff       	jmp    801085a4 <alltraps>

80108c1b <vector1>:
.globl vector1
vector1:
  pushl $0
80108c1b:	6a 00                	push   $0x0
  pushl $1
80108c1d:	6a 01                	push   $0x1
  jmp alltraps
80108c1f:	e9 80 f9 ff ff       	jmp    801085a4 <alltraps>

80108c24 <vector2>:
.globl vector2
vector2:
  pushl $0
80108c24:	6a 00                	push   $0x0
  pushl $2
80108c26:	6a 02                	push   $0x2
  jmp alltraps
80108c28:	e9 77 f9 ff ff       	jmp    801085a4 <alltraps>

80108c2d <vector3>:
.globl vector3
vector3:
  pushl $0
80108c2d:	6a 00                	push   $0x0
  pushl $3
80108c2f:	6a 03                	push   $0x3
  jmp alltraps
80108c31:	e9 6e f9 ff ff       	jmp    801085a4 <alltraps>

80108c36 <vector4>:
.globl vector4
vector4:
  pushl $0
80108c36:	6a 00                	push   $0x0
  pushl $4
80108c38:	6a 04                	push   $0x4
  jmp alltraps
80108c3a:	e9 65 f9 ff ff       	jmp    801085a4 <alltraps>

80108c3f <vector5>:
.globl vector5
vector5:
  pushl $0
80108c3f:	6a 00                	push   $0x0
  pushl $5
80108c41:	6a 05                	push   $0x5
  jmp alltraps
80108c43:	e9 5c f9 ff ff       	jmp    801085a4 <alltraps>

80108c48 <vector6>:
.globl vector6
vector6:
  pushl $0
80108c48:	6a 00                	push   $0x0
  pushl $6
80108c4a:	6a 06                	push   $0x6
  jmp alltraps
80108c4c:	e9 53 f9 ff ff       	jmp    801085a4 <alltraps>

80108c51 <vector7>:
.globl vector7
vector7:
  pushl $0
80108c51:	6a 00                	push   $0x0
  pushl $7
80108c53:	6a 07                	push   $0x7
  jmp alltraps
80108c55:	e9 4a f9 ff ff       	jmp    801085a4 <alltraps>

80108c5a <vector8>:
.globl vector8
vector8:
  pushl $8
80108c5a:	6a 08                	push   $0x8
  jmp alltraps
80108c5c:	e9 43 f9 ff ff       	jmp    801085a4 <alltraps>

80108c61 <vector9>:
.globl vector9
vector9:
  pushl $0
80108c61:	6a 00                	push   $0x0
  pushl $9
80108c63:	6a 09                	push   $0x9
  jmp alltraps
80108c65:	e9 3a f9 ff ff       	jmp    801085a4 <alltraps>

80108c6a <vector10>:
.globl vector10
vector10:
  pushl $10
80108c6a:	6a 0a                	push   $0xa
  jmp alltraps
80108c6c:	e9 33 f9 ff ff       	jmp    801085a4 <alltraps>

80108c71 <vector11>:
.globl vector11
vector11:
  pushl $11
80108c71:	6a 0b                	push   $0xb
  jmp alltraps
80108c73:	e9 2c f9 ff ff       	jmp    801085a4 <alltraps>

80108c78 <vector12>:
.globl vector12
vector12:
  pushl $12
80108c78:	6a 0c                	push   $0xc
  jmp alltraps
80108c7a:	e9 25 f9 ff ff       	jmp    801085a4 <alltraps>

80108c7f <vector13>:
.globl vector13
vector13:
  pushl $13
80108c7f:	6a 0d                	push   $0xd
  jmp alltraps
80108c81:	e9 1e f9 ff ff       	jmp    801085a4 <alltraps>

80108c86 <vector14>:
.globl vector14
vector14:
  pushl $14
80108c86:	6a 0e                	push   $0xe
  jmp alltraps
80108c88:	e9 17 f9 ff ff       	jmp    801085a4 <alltraps>

80108c8d <vector15>:
.globl vector15
vector15:
  pushl $0
80108c8d:	6a 00                	push   $0x0
  pushl $15
80108c8f:	6a 0f                	push   $0xf
  jmp alltraps
80108c91:	e9 0e f9 ff ff       	jmp    801085a4 <alltraps>

80108c96 <vector16>:
.globl vector16
vector16:
  pushl $0
80108c96:	6a 00                	push   $0x0
  pushl $16
80108c98:	6a 10                	push   $0x10
  jmp alltraps
80108c9a:	e9 05 f9 ff ff       	jmp    801085a4 <alltraps>

80108c9f <vector17>:
.globl vector17
vector17:
  pushl $17
80108c9f:	6a 11                	push   $0x11
  jmp alltraps
80108ca1:	e9 fe f8 ff ff       	jmp    801085a4 <alltraps>

80108ca6 <vector18>:
.globl vector18
vector18:
  pushl $0
80108ca6:	6a 00                	push   $0x0
  pushl $18
80108ca8:	6a 12                	push   $0x12
  jmp alltraps
80108caa:	e9 f5 f8 ff ff       	jmp    801085a4 <alltraps>

80108caf <vector19>:
.globl vector19
vector19:
  pushl $0
80108caf:	6a 00                	push   $0x0
  pushl $19
80108cb1:	6a 13                	push   $0x13
  jmp alltraps
80108cb3:	e9 ec f8 ff ff       	jmp    801085a4 <alltraps>

80108cb8 <vector20>:
.globl vector20
vector20:
  pushl $0
80108cb8:	6a 00                	push   $0x0
  pushl $20
80108cba:	6a 14                	push   $0x14
  jmp alltraps
80108cbc:	e9 e3 f8 ff ff       	jmp    801085a4 <alltraps>

80108cc1 <vector21>:
.globl vector21
vector21:
  pushl $0
80108cc1:	6a 00                	push   $0x0
  pushl $21
80108cc3:	6a 15                	push   $0x15
  jmp alltraps
80108cc5:	e9 da f8 ff ff       	jmp    801085a4 <alltraps>

80108cca <vector22>:
.globl vector22
vector22:
  pushl $0
80108cca:	6a 00                	push   $0x0
  pushl $22
80108ccc:	6a 16                	push   $0x16
  jmp alltraps
80108cce:	e9 d1 f8 ff ff       	jmp    801085a4 <alltraps>

80108cd3 <vector23>:
.globl vector23
vector23:
  pushl $0
80108cd3:	6a 00                	push   $0x0
  pushl $23
80108cd5:	6a 17                	push   $0x17
  jmp alltraps
80108cd7:	e9 c8 f8 ff ff       	jmp    801085a4 <alltraps>

80108cdc <vector24>:
.globl vector24
vector24:
  pushl $0
80108cdc:	6a 00                	push   $0x0
  pushl $24
80108cde:	6a 18                	push   $0x18
  jmp alltraps
80108ce0:	e9 bf f8 ff ff       	jmp    801085a4 <alltraps>

80108ce5 <vector25>:
.globl vector25
vector25:
  pushl $0
80108ce5:	6a 00                	push   $0x0
  pushl $25
80108ce7:	6a 19                	push   $0x19
  jmp alltraps
80108ce9:	e9 b6 f8 ff ff       	jmp    801085a4 <alltraps>

80108cee <vector26>:
.globl vector26
vector26:
  pushl $0
80108cee:	6a 00                	push   $0x0
  pushl $26
80108cf0:	6a 1a                	push   $0x1a
  jmp alltraps
80108cf2:	e9 ad f8 ff ff       	jmp    801085a4 <alltraps>

80108cf7 <vector27>:
.globl vector27
vector27:
  pushl $0
80108cf7:	6a 00                	push   $0x0
  pushl $27
80108cf9:	6a 1b                	push   $0x1b
  jmp alltraps
80108cfb:	e9 a4 f8 ff ff       	jmp    801085a4 <alltraps>

80108d00 <vector28>:
.globl vector28
vector28:
  pushl $0
80108d00:	6a 00                	push   $0x0
  pushl $28
80108d02:	6a 1c                	push   $0x1c
  jmp alltraps
80108d04:	e9 9b f8 ff ff       	jmp    801085a4 <alltraps>

80108d09 <vector29>:
.globl vector29
vector29:
  pushl $0
80108d09:	6a 00                	push   $0x0
  pushl $29
80108d0b:	6a 1d                	push   $0x1d
  jmp alltraps
80108d0d:	e9 92 f8 ff ff       	jmp    801085a4 <alltraps>

80108d12 <vector30>:
.globl vector30
vector30:
  pushl $0
80108d12:	6a 00                	push   $0x0
  pushl $30
80108d14:	6a 1e                	push   $0x1e
  jmp alltraps
80108d16:	e9 89 f8 ff ff       	jmp    801085a4 <alltraps>

80108d1b <vector31>:
.globl vector31
vector31:
  pushl $0
80108d1b:	6a 00                	push   $0x0
  pushl $31
80108d1d:	6a 1f                	push   $0x1f
  jmp alltraps
80108d1f:	e9 80 f8 ff ff       	jmp    801085a4 <alltraps>

80108d24 <vector32>:
.globl vector32
vector32:
  pushl $0
80108d24:	6a 00                	push   $0x0
  pushl $32
80108d26:	6a 20                	push   $0x20
  jmp alltraps
80108d28:	e9 77 f8 ff ff       	jmp    801085a4 <alltraps>

80108d2d <vector33>:
.globl vector33
vector33:
  pushl $0
80108d2d:	6a 00                	push   $0x0
  pushl $33
80108d2f:	6a 21                	push   $0x21
  jmp alltraps
80108d31:	e9 6e f8 ff ff       	jmp    801085a4 <alltraps>

80108d36 <vector34>:
.globl vector34
vector34:
  pushl $0
80108d36:	6a 00                	push   $0x0
  pushl $34
80108d38:	6a 22                	push   $0x22
  jmp alltraps
80108d3a:	e9 65 f8 ff ff       	jmp    801085a4 <alltraps>

80108d3f <vector35>:
.globl vector35
vector35:
  pushl $0
80108d3f:	6a 00                	push   $0x0
  pushl $35
80108d41:	6a 23                	push   $0x23
  jmp alltraps
80108d43:	e9 5c f8 ff ff       	jmp    801085a4 <alltraps>

80108d48 <vector36>:
.globl vector36
vector36:
  pushl $0
80108d48:	6a 00                	push   $0x0
  pushl $36
80108d4a:	6a 24                	push   $0x24
  jmp alltraps
80108d4c:	e9 53 f8 ff ff       	jmp    801085a4 <alltraps>

80108d51 <vector37>:
.globl vector37
vector37:
  pushl $0
80108d51:	6a 00                	push   $0x0
  pushl $37
80108d53:	6a 25                	push   $0x25
  jmp alltraps
80108d55:	e9 4a f8 ff ff       	jmp    801085a4 <alltraps>

80108d5a <vector38>:
.globl vector38
vector38:
  pushl $0
80108d5a:	6a 00                	push   $0x0
  pushl $38
80108d5c:	6a 26                	push   $0x26
  jmp alltraps
80108d5e:	e9 41 f8 ff ff       	jmp    801085a4 <alltraps>

80108d63 <vector39>:
.globl vector39
vector39:
  pushl $0
80108d63:	6a 00                	push   $0x0
  pushl $39
80108d65:	6a 27                	push   $0x27
  jmp alltraps
80108d67:	e9 38 f8 ff ff       	jmp    801085a4 <alltraps>

80108d6c <vector40>:
.globl vector40
vector40:
  pushl $0
80108d6c:	6a 00                	push   $0x0
  pushl $40
80108d6e:	6a 28                	push   $0x28
  jmp alltraps
80108d70:	e9 2f f8 ff ff       	jmp    801085a4 <alltraps>

80108d75 <vector41>:
.globl vector41
vector41:
  pushl $0
80108d75:	6a 00                	push   $0x0
  pushl $41
80108d77:	6a 29                	push   $0x29
  jmp alltraps
80108d79:	e9 26 f8 ff ff       	jmp    801085a4 <alltraps>

80108d7e <vector42>:
.globl vector42
vector42:
  pushl $0
80108d7e:	6a 00                	push   $0x0
  pushl $42
80108d80:	6a 2a                	push   $0x2a
  jmp alltraps
80108d82:	e9 1d f8 ff ff       	jmp    801085a4 <alltraps>

80108d87 <vector43>:
.globl vector43
vector43:
  pushl $0
80108d87:	6a 00                	push   $0x0
  pushl $43
80108d89:	6a 2b                	push   $0x2b
  jmp alltraps
80108d8b:	e9 14 f8 ff ff       	jmp    801085a4 <alltraps>

80108d90 <vector44>:
.globl vector44
vector44:
  pushl $0
80108d90:	6a 00                	push   $0x0
  pushl $44
80108d92:	6a 2c                	push   $0x2c
  jmp alltraps
80108d94:	e9 0b f8 ff ff       	jmp    801085a4 <alltraps>

80108d99 <vector45>:
.globl vector45
vector45:
  pushl $0
80108d99:	6a 00                	push   $0x0
  pushl $45
80108d9b:	6a 2d                	push   $0x2d
  jmp alltraps
80108d9d:	e9 02 f8 ff ff       	jmp    801085a4 <alltraps>

80108da2 <vector46>:
.globl vector46
vector46:
  pushl $0
80108da2:	6a 00                	push   $0x0
  pushl $46
80108da4:	6a 2e                	push   $0x2e
  jmp alltraps
80108da6:	e9 f9 f7 ff ff       	jmp    801085a4 <alltraps>

80108dab <vector47>:
.globl vector47
vector47:
  pushl $0
80108dab:	6a 00                	push   $0x0
  pushl $47
80108dad:	6a 2f                	push   $0x2f
  jmp alltraps
80108daf:	e9 f0 f7 ff ff       	jmp    801085a4 <alltraps>

80108db4 <vector48>:
.globl vector48
vector48:
  pushl $0
80108db4:	6a 00                	push   $0x0
  pushl $48
80108db6:	6a 30                	push   $0x30
  jmp alltraps
80108db8:	e9 e7 f7 ff ff       	jmp    801085a4 <alltraps>

80108dbd <vector49>:
.globl vector49
vector49:
  pushl $0
80108dbd:	6a 00                	push   $0x0
  pushl $49
80108dbf:	6a 31                	push   $0x31
  jmp alltraps
80108dc1:	e9 de f7 ff ff       	jmp    801085a4 <alltraps>

80108dc6 <vector50>:
.globl vector50
vector50:
  pushl $0
80108dc6:	6a 00                	push   $0x0
  pushl $50
80108dc8:	6a 32                	push   $0x32
  jmp alltraps
80108dca:	e9 d5 f7 ff ff       	jmp    801085a4 <alltraps>

80108dcf <vector51>:
.globl vector51
vector51:
  pushl $0
80108dcf:	6a 00                	push   $0x0
  pushl $51
80108dd1:	6a 33                	push   $0x33
  jmp alltraps
80108dd3:	e9 cc f7 ff ff       	jmp    801085a4 <alltraps>

80108dd8 <vector52>:
.globl vector52
vector52:
  pushl $0
80108dd8:	6a 00                	push   $0x0
  pushl $52
80108dda:	6a 34                	push   $0x34
  jmp alltraps
80108ddc:	e9 c3 f7 ff ff       	jmp    801085a4 <alltraps>

80108de1 <vector53>:
.globl vector53
vector53:
  pushl $0
80108de1:	6a 00                	push   $0x0
  pushl $53
80108de3:	6a 35                	push   $0x35
  jmp alltraps
80108de5:	e9 ba f7 ff ff       	jmp    801085a4 <alltraps>

80108dea <vector54>:
.globl vector54
vector54:
  pushl $0
80108dea:	6a 00                	push   $0x0
  pushl $54
80108dec:	6a 36                	push   $0x36
  jmp alltraps
80108dee:	e9 b1 f7 ff ff       	jmp    801085a4 <alltraps>

80108df3 <vector55>:
.globl vector55
vector55:
  pushl $0
80108df3:	6a 00                	push   $0x0
  pushl $55
80108df5:	6a 37                	push   $0x37
  jmp alltraps
80108df7:	e9 a8 f7 ff ff       	jmp    801085a4 <alltraps>

80108dfc <vector56>:
.globl vector56
vector56:
  pushl $0
80108dfc:	6a 00                	push   $0x0
  pushl $56
80108dfe:	6a 38                	push   $0x38
  jmp alltraps
80108e00:	e9 9f f7 ff ff       	jmp    801085a4 <alltraps>

80108e05 <vector57>:
.globl vector57
vector57:
  pushl $0
80108e05:	6a 00                	push   $0x0
  pushl $57
80108e07:	6a 39                	push   $0x39
  jmp alltraps
80108e09:	e9 96 f7 ff ff       	jmp    801085a4 <alltraps>

80108e0e <vector58>:
.globl vector58
vector58:
  pushl $0
80108e0e:	6a 00                	push   $0x0
  pushl $58
80108e10:	6a 3a                	push   $0x3a
  jmp alltraps
80108e12:	e9 8d f7 ff ff       	jmp    801085a4 <alltraps>

80108e17 <vector59>:
.globl vector59
vector59:
  pushl $0
80108e17:	6a 00                	push   $0x0
  pushl $59
80108e19:	6a 3b                	push   $0x3b
  jmp alltraps
80108e1b:	e9 84 f7 ff ff       	jmp    801085a4 <alltraps>

80108e20 <vector60>:
.globl vector60
vector60:
  pushl $0
80108e20:	6a 00                	push   $0x0
  pushl $60
80108e22:	6a 3c                	push   $0x3c
  jmp alltraps
80108e24:	e9 7b f7 ff ff       	jmp    801085a4 <alltraps>

80108e29 <vector61>:
.globl vector61
vector61:
  pushl $0
80108e29:	6a 00                	push   $0x0
  pushl $61
80108e2b:	6a 3d                	push   $0x3d
  jmp alltraps
80108e2d:	e9 72 f7 ff ff       	jmp    801085a4 <alltraps>

80108e32 <vector62>:
.globl vector62
vector62:
  pushl $0
80108e32:	6a 00                	push   $0x0
  pushl $62
80108e34:	6a 3e                	push   $0x3e
  jmp alltraps
80108e36:	e9 69 f7 ff ff       	jmp    801085a4 <alltraps>

80108e3b <vector63>:
.globl vector63
vector63:
  pushl $0
80108e3b:	6a 00                	push   $0x0
  pushl $63
80108e3d:	6a 3f                	push   $0x3f
  jmp alltraps
80108e3f:	e9 60 f7 ff ff       	jmp    801085a4 <alltraps>

80108e44 <vector64>:
.globl vector64
vector64:
  pushl $0
80108e44:	6a 00                	push   $0x0
  pushl $64
80108e46:	6a 40                	push   $0x40
  jmp alltraps
80108e48:	e9 57 f7 ff ff       	jmp    801085a4 <alltraps>

80108e4d <vector65>:
.globl vector65
vector65:
  pushl $0
80108e4d:	6a 00                	push   $0x0
  pushl $65
80108e4f:	6a 41                	push   $0x41
  jmp alltraps
80108e51:	e9 4e f7 ff ff       	jmp    801085a4 <alltraps>

80108e56 <vector66>:
.globl vector66
vector66:
  pushl $0
80108e56:	6a 00                	push   $0x0
  pushl $66
80108e58:	6a 42                	push   $0x42
  jmp alltraps
80108e5a:	e9 45 f7 ff ff       	jmp    801085a4 <alltraps>

80108e5f <vector67>:
.globl vector67
vector67:
  pushl $0
80108e5f:	6a 00                	push   $0x0
  pushl $67
80108e61:	6a 43                	push   $0x43
  jmp alltraps
80108e63:	e9 3c f7 ff ff       	jmp    801085a4 <alltraps>

80108e68 <vector68>:
.globl vector68
vector68:
  pushl $0
80108e68:	6a 00                	push   $0x0
  pushl $68
80108e6a:	6a 44                	push   $0x44
  jmp alltraps
80108e6c:	e9 33 f7 ff ff       	jmp    801085a4 <alltraps>

80108e71 <vector69>:
.globl vector69
vector69:
  pushl $0
80108e71:	6a 00                	push   $0x0
  pushl $69
80108e73:	6a 45                	push   $0x45
  jmp alltraps
80108e75:	e9 2a f7 ff ff       	jmp    801085a4 <alltraps>

80108e7a <vector70>:
.globl vector70
vector70:
  pushl $0
80108e7a:	6a 00                	push   $0x0
  pushl $70
80108e7c:	6a 46                	push   $0x46
  jmp alltraps
80108e7e:	e9 21 f7 ff ff       	jmp    801085a4 <alltraps>

80108e83 <vector71>:
.globl vector71
vector71:
  pushl $0
80108e83:	6a 00                	push   $0x0
  pushl $71
80108e85:	6a 47                	push   $0x47
  jmp alltraps
80108e87:	e9 18 f7 ff ff       	jmp    801085a4 <alltraps>

80108e8c <vector72>:
.globl vector72
vector72:
  pushl $0
80108e8c:	6a 00                	push   $0x0
  pushl $72
80108e8e:	6a 48                	push   $0x48
  jmp alltraps
80108e90:	e9 0f f7 ff ff       	jmp    801085a4 <alltraps>

80108e95 <vector73>:
.globl vector73
vector73:
  pushl $0
80108e95:	6a 00                	push   $0x0
  pushl $73
80108e97:	6a 49                	push   $0x49
  jmp alltraps
80108e99:	e9 06 f7 ff ff       	jmp    801085a4 <alltraps>

80108e9e <vector74>:
.globl vector74
vector74:
  pushl $0
80108e9e:	6a 00                	push   $0x0
  pushl $74
80108ea0:	6a 4a                	push   $0x4a
  jmp alltraps
80108ea2:	e9 fd f6 ff ff       	jmp    801085a4 <alltraps>

80108ea7 <vector75>:
.globl vector75
vector75:
  pushl $0
80108ea7:	6a 00                	push   $0x0
  pushl $75
80108ea9:	6a 4b                	push   $0x4b
  jmp alltraps
80108eab:	e9 f4 f6 ff ff       	jmp    801085a4 <alltraps>

80108eb0 <vector76>:
.globl vector76
vector76:
  pushl $0
80108eb0:	6a 00                	push   $0x0
  pushl $76
80108eb2:	6a 4c                	push   $0x4c
  jmp alltraps
80108eb4:	e9 eb f6 ff ff       	jmp    801085a4 <alltraps>

80108eb9 <vector77>:
.globl vector77
vector77:
  pushl $0
80108eb9:	6a 00                	push   $0x0
  pushl $77
80108ebb:	6a 4d                	push   $0x4d
  jmp alltraps
80108ebd:	e9 e2 f6 ff ff       	jmp    801085a4 <alltraps>

80108ec2 <vector78>:
.globl vector78
vector78:
  pushl $0
80108ec2:	6a 00                	push   $0x0
  pushl $78
80108ec4:	6a 4e                	push   $0x4e
  jmp alltraps
80108ec6:	e9 d9 f6 ff ff       	jmp    801085a4 <alltraps>

80108ecb <vector79>:
.globl vector79
vector79:
  pushl $0
80108ecb:	6a 00                	push   $0x0
  pushl $79
80108ecd:	6a 4f                	push   $0x4f
  jmp alltraps
80108ecf:	e9 d0 f6 ff ff       	jmp    801085a4 <alltraps>

80108ed4 <vector80>:
.globl vector80
vector80:
  pushl $0
80108ed4:	6a 00                	push   $0x0
  pushl $80
80108ed6:	6a 50                	push   $0x50
  jmp alltraps
80108ed8:	e9 c7 f6 ff ff       	jmp    801085a4 <alltraps>

80108edd <vector81>:
.globl vector81
vector81:
  pushl $0
80108edd:	6a 00                	push   $0x0
  pushl $81
80108edf:	6a 51                	push   $0x51
  jmp alltraps
80108ee1:	e9 be f6 ff ff       	jmp    801085a4 <alltraps>

80108ee6 <vector82>:
.globl vector82
vector82:
  pushl $0
80108ee6:	6a 00                	push   $0x0
  pushl $82
80108ee8:	6a 52                	push   $0x52
  jmp alltraps
80108eea:	e9 b5 f6 ff ff       	jmp    801085a4 <alltraps>

80108eef <vector83>:
.globl vector83
vector83:
  pushl $0
80108eef:	6a 00                	push   $0x0
  pushl $83
80108ef1:	6a 53                	push   $0x53
  jmp alltraps
80108ef3:	e9 ac f6 ff ff       	jmp    801085a4 <alltraps>

80108ef8 <vector84>:
.globl vector84
vector84:
  pushl $0
80108ef8:	6a 00                	push   $0x0
  pushl $84
80108efa:	6a 54                	push   $0x54
  jmp alltraps
80108efc:	e9 a3 f6 ff ff       	jmp    801085a4 <alltraps>

80108f01 <vector85>:
.globl vector85
vector85:
  pushl $0
80108f01:	6a 00                	push   $0x0
  pushl $85
80108f03:	6a 55                	push   $0x55
  jmp alltraps
80108f05:	e9 9a f6 ff ff       	jmp    801085a4 <alltraps>

80108f0a <vector86>:
.globl vector86
vector86:
  pushl $0
80108f0a:	6a 00                	push   $0x0
  pushl $86
80108f0c:	6a 56                	push   $0x56
  jmp alltraps
80108f0e:	e9 91 f6 ff ff       	jmp    801085a4 <alltraps>

80108f13 <vector87>:
.globl vector87
vector87:
  pushl $0
80108f13:	6a 00                	push   $0x0
  pushl $87
80108f15:	6a 57                	push   $0x57
  jmp alltraps
80108f17:	e9 88 f6 ff ff       	jmp    801085a4 <alltraps>

80108f1c <vector88>:
.globl vector88
vector88:
  pushl $0
80108f1c:	6a 00                	push   $0x0
  pushl $88
80108f1e:	6a 58                	push   $0x58
  jmp alltraps
80108f20:	e9 7f f6 ff ff       	jmp    801085a4 <alltraps>

80108f25 <vector89>:
.globl vector89
vector89:
  pushl $0
80108f25:	6a 00                	push   $0x0
  pushl $89
80108f27:	6a 59                	push   $0x59
  jmp alltraps
80108f29:	e9 76 f6 ff ff       	jmp    801085a4 <alltraps>

80108f2e <vector90>:
.globl vector90
vector90:
  pushl $0
80108f2e:	6a 00                	push   $0x0
  pushl $90
80108f30:	6a 5a                	push   $0x5a
  jmp alltraps
80108f32:	e9 6d f6 ff ff       	jmp    801085a4 <alltraps>

80108f37 <vector91>:
.globl vector91
vector91:
  pushl $0
80108f37:	6a 00                	push   $0x0
  pushl $91
80108f39:	6a 5b                	push   $0x5b
  jmp alltraps
80108f3b:	e9 64 f6 ff ff       	jmp    801085a4 <alltraps>

80108f40 <vector92>:
.globl vector92
vector92:
  pushl $0
80108f40:	6a 00                	push   $0x0
  pushl $92
80108f42:	6a 5c                	push   $0x5c
  jmp alltraps
80108f44:	e9 5b f6 ff ff       	jmp    801085a4 <alltraps>

80108f49 <vector93>:
.globl vector93
vector93:
  pushl $0
80108f49:	6a 00                	push   $0x0
  pushl $93
80108f4b:	6a 5d                	push   $0x5d
  jmp alltraps
80108f4d:	e9 52 f6 ff ff       	jmp    801085a4 <alltraps>

80108f52 <vector94>:
.globl vector94
vector94:
  pushl $0
80108f52:	6a 00                	push   $0x0
  pushl $94
80108f54:	6a 5e                	push   $0x5e
  jmp alltraps
80108f56:	e9 49 f6 ff ff       	jmp    801085a4 <alltraps>

80108f5b <vector95>:
.globl vector95
vector95:
  pushl $0
80108f5b:	6a 00                	push   $0x0
  pushl $95
80108f5d:	6a 5f                	push   $0x5f
  jmp alltraps
80108f5f:	e9 40 f6 ff ff       	jmp    801085a4 <alltraps>

80108f64 <vector96>:
.globl vector96
vector96:
  pushl $0
80108f64:	6a 00                	push   $0x0
  pushl $96
80108f66:	6a 60                	push   $0x60
  jmp alltraps
80108f68:	e9 37 f6 ff ff       	jmp    801085a4 <alltraps>

80108f6d <vector97>:
.globl vector97
vector97:
  pushl $0
80108f6d:	6a 00                	push   $0x0
  pushl $97
80108f6f:	6a 61                	push   $0x61
  jmp alltraps
80108f71:	e9 2e f6 ff ff       	jmp    801085a4 <alltraps>

80108f76 <vector98>:
.globl vector98
vector98:
  pushl $0
80108f76:	6a 00                	push   $0x0
  pushl $98
80108f78:	6a 62                	push   $0x62
  jmp alltraps
80108f7a:	e9 25 f6 ff ff       	jmp    801085a4 <alltraps>

80108f7f <vector99>:
.globl vector99
vector99:
  pushl $0
80108f7f:	6a 00                	push   $0x0
  pushl $99
80108f81:	6a 63                	push   $0x63
  jmp alltraps
80108f83:	e9 1c f6 ff ff       	jmp    801085a4 <alltraps>

80108f88 <vector100>:
.globl vector100
vector100:
  pushl $0
80108f88:	6a 00                	push   $0x0
  pushl $100
80108f8a:	6a 64                	push   $0x64
  jmp alltraps
80108f8c:	e9 13 f6 ff ff       	jmp    801085a4 <alltraps>

80108f91 <vector101>:
.globl vector101
vector101:
  pushl $0
80108f91:	6a 00                	push   $0x0
  pushl $101
80108f93:	6a 65                	push   $0x65
  jmp alltraps
80108f95:	e9 0a f6 ff ff       	jmp    801085a4 <alltraps>

80108f9a <vector102>:
.globl vector102
vector102:
  pushl $0
80108f9a:	6a 00                	push   $0x0
  pushl $102
80108f9c:	6a 66                	push   $0x66
  jmp alltraps
80108f9e:	e9 01 f6 ff ff       	jmp    801085a4 <alltraps>

80108fa3 <vector103>:
.globl vector103
vector103:
  pushl $0
80108fa3:	6a 00                	push   $0x0
  pushl $103
80108fa5:	6a 67                	push   $0x67
  jmp alltraps
80108fa7:	e9 f8 f5 ff ff       	jmp    801085a4 <alltraps>

80108fac <vector104>:
.globl vector104
vector104:
  pushl $0
80108fac:	6a 00                	push   $0x0
  pushl $104
80108fae:	6a 68                	push   $0x68
  jmp alltraps
80108fb0:	e9 ef f5 ff ff       	jmp    801085a4 <alltraps>

80108fb5 <vector105>:
.globl vector105
vector105:
  pushl $0
80108fb5:	6a 00                	push   $0x0
  pushl $105
80108fb7:	6a 69                	push   $0x69
  jmp alltraps
80108fb9:	e9 e6 f5 ff ff       	jmp    801085a4 <alltraps>

80108fbe <vector106>:
.globl vector106
vector106:
  pushl $0
80108fbe:	6a 00                	push   $0x0
  pushl $106
80108fc0:	6a 6a                	push   $0x6a
  jmp alltraps
80108fc2:	e9 dd f5 ff ff       	jmp    801085a4 <alltraps>

80108fc7 <vector107>:
.globl vector107
vector107:
  pushl $0
80108fc7:	6a 00                	push   $0x0
  pushl $107
80108fc9:	6a 6b                	push   $0x6b
  jmp alltraps
80108fcb:	e9 d4 f5 ff ff       	jmp    801085a4 <alltraps>

80108fd0 <vector108>:
.globl vector108
vector108:
  pushl $0
80108fd0:	6a 00                	push   $0x0
  pushl $108
80108fd2:	6a 6c                	push   $0x6c
  jmp alltraps
80108fd4:	e9 cb f5 ff ff       	jmp    801085a4 <alltraps>

80108fd9 <vector109>:
.globl vector109
vector109:
  pushl $0
80108fd9:	6a 00                	push   $0x0
  pushl $109
80108fdb:	6a 6d                	push   $0x6d
  jmp alltraps
80108fdd:	e9 c2 f5 ff ff       	jmp    801085a4 <alltraps>

80108fe2 <vector110>:
.globl vector110
vector110:
  pushl $0
80108fe2:	6a 00                	push   $0x0
  pushl $110
80108fe4:	6a 6e                	push   $0x6e
  jmp alltraps
80108fe6:	e9 b9 f5 ff ff       	jmp    801085a4 <alltraps>

80108feb <vector111>:
.globl vector111
vector111:
  pushl $0
80108feb:	6a 00                	push   $0x0
  pushl $111
80108fed:	6a 6f                	push   $0x6f
  jmp alltraps
80108fef:	e9 b0 f5 ff ff       	jmp    801085a4 <alltraps>

80108ff4 <vector112>:
.globl vector112
vector112:
  pushl $0
80108ff4:	6a 00                	push   $0x0
  pushl $112
80108ff6:	6a 70                	push   $0x70
  jmp alltraps
80108ff8:	e9 a7 f5 ff ff       	jmp    801085a4 <alltraps>

80108ffd <vector113>:
.globl vector113
vector113:
  pushl $0
80108ffd:	6a 00                	push   $0x0
  pushl $113
80108fff:	6a 71                	push   $0x71
  jmp alltraps
80109001:	e9 9e f5 ff ff       	jmp    801085a4 <alltraps>

80109006 <vector114>:
.globl vector114
vector114:
  pushl $0
80109006:	6a 00                	push   $0x0
  pushl $114
80109008:	6a 72                	push   $0x72
  jmp alltraps
8010900a:	e9 95 f5 ff ff       	jmp    801085a4 <alltraps>

8010900f <vector115>:
.globl vector115
vector115:
  pushl $0
8010900f:	6a 00                	push   $0x0
  pushl $115
80109011:	6a 73                	push   $0x73
  jmp alltraps
80109013:	e9 8c f5 ff ff       	jmp    801085a4 <alltraps>

80109018 <vector116>:
.globl vector116
vector116:
  pushl $0
80109018:	6a 00                	push   $0x0
  pushl $116
8010901a:	6a 74                	push   $0x74
  jmp alltraps
8010901c:	e9 83 f5 ff ff       	jmp    801085a4 <alltraps>

80109021 <vector117>:
.globl vector117
vector117:
  pushl $0
80109021:	6a 00                	push   $0x0
  pushl $117
80109023:	6a 75                	push   $0x75
  jmp alltraps
80109025:	e9 7a f5 ff ff       	jmp    801085a4 <alltraps>

8010902a <vector118>:
.globl vector118
vector118:
  pushl $0
8010902a:	6a 00                	push   $0x0
  pushl $118
8010902c:	6a 76                	push   $0x76
  jmp alltraps
8010902e:	e9 71 f5 ff ff       	jmp    801085a4 <alltraps>

80109033 <vector119>:
.globl vector119
vector119:
  pushl $0
80109033:	6a 00                	push   $0x0
  pushl $119
80109035:	6a 77                	push   $0x77
  jmp alltraps
80109037:	e9 68 f5 ff ff       	jmp    801085a4 <alltraps>

8010903c <vector120>:
.globl vector120
vector120:
  pushl $0
8010903c:	6a 00                	push   $0x0
  pushl $120
8010903e:	6a 78                	push   $0x78
  jmp alltraps
80109040:	e9 5f f5 ff ff       	jmp    801085a4 <alltraps>

80109045 <vector121>:
.globl vector121
vector121:
  pushl $0
80109045:	6a 00                	push   $0x0
  pushl $121
80109047:	6a 79                	push   $0x79
  jmp alltraps
80109049:	e9 56 f5 ff ff       	jmp    801085a4 <alltraps>

8010904e <vector122>:
.globl vector122
vector122:
  pushl $0
8010904e:	6a 00                	push   $0x0
  pushl $122
80109050:	6a 7a                	push   $0x7a
  jmp alltraps
80109052:	e9 4d f5 ff ff       	jmp    801085a4 <alltraps>

80109057 <vector123>:
.globl vector123
vector123:
  pushl $0
80109057:	6a 00                	push   $0x0
  pushl $123
80109059:	6a 7b                	push   $0x7b
  jmp alltraps
8010905b:	e9 44 f5 ff ff       	jmp    801085a4 <alltraps>

80109060 <vector124>:
.globl vector124
vector124:
  pushl $0
80109060:	6a 00                	push   $0x0
  pushl $124
80109062:	6a 7c                	push   $0x7c
  jmp alltraps
80109064:	e9 3b f5 ff ff       	jmp    801085a4 <alltraps>

80109069 <vector125>:
.globl vector125
vector125:
  pushl $0
80109069:	6a 00                	push   $0x0
  pushl $125
8010906b:	6a 7d                	push   $0x7d
  jmp alltraps
8010906d:	e9 32 f5 ff ff       	jmp    801085a4 <alltraps>

80109072 <vector126>:
.globl vector126
vector126:
  pushl $0
80109072:	6a 00                	push   $0x0
  pushl $126
80109074:	6a 7e                	push   $0x7e
  jmp alltraps
80109076:	e9 29 f5 ff ff       	jmp    801085a4 <alltraps>

8010907b <vector127>:
.globl vector127
vector127:
  pushl $0
8010907b:	6a 00                	push   $0x0
  pushl $127
8010907d:	6a 7f                	push   $0x7f
  jmp alltraps
8010907f:	e9 20 f5 ff ff       	jmp    801085a4 <alltraps>

80109084 <vector128>:
.globl vector128
vector128:
  pushl $0
80109084:	6a 00                	push   $0x0
  pushl $128
80109086:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010908b:	e9 14 f5 ff ff       	jmp    801085a4 <alltraps>

80109090 <vector129>:
.globl vector129
vector129:
  pushl $0
80109090:	6a 00                	push   $0x0
  pushl $129
80109092:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80109097:	e9 08 f5 ff ff       	jmp    801085a4 <alltraps>

8010909c <vector130>:
.globl vector130
vector130:
  pushl $0
8010909c:	6a 00                	push   $0x0
  pushl $130
8010909e:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801090a3:	e9 fc f4 ff ff       	jmp    801085a4 <alltraps>

801090a8 <vector131>:
.globl vector131
vector131:
  pushl $0
801090a8:	6a 00                	push   $0x0
  pushl $131
801090aa:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801090af:	e9 f0 f4 ff ff       	jmp    801085a4 <alltraps>

801090b4 <vector132>:
.globl vector132
vector132:
  pushl $0
801090b4:	6a 00                	push   $0x0
  pushl $132
801090b6:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801090bb:	e9 e4 f4 ff ff       	jmp    801085a4 <alltraps>

801090c0 <vector133>:
.globl vector133
vector133:
  pushl $0
801090c0:	6a 00                	push   $0x0
  pushl $133
801090c2:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801090c7:	e9 d8 f4 ff ff       	jmp    801085a4 <alltraps>

801090cc <vector134>:
.globl vector134
vector134:
  pushl $0
801090cc:	6a 00                	push   $0x0
  pushl $134
801090ce:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801090d3:	e9 cc f4 ff ff       	jmp    801085a4 <alltraps>

801090d8 <vector135>:
.globl vector135
vector135:
  pushl $0
801090d8:	6a 00                	push   $0x0
  pushl $135
801090da:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801090df:	e9 c0 f4 ff ff       	jmp    801085a4 <alltraps>

801090e4 <vector136>:
.globl vector136
vector136:
  pushl $0
801090e4:	6a 00                	push   $0x0
  pushl $136
801090e6:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801090eb:	e9 b4 f4 ff ff       	jmp    801085a4 <alltraps>

801090f0 <vector137>:
.globl vector137
vector137:
  pushl $0
801090f0:	6a 00                	push   $0x0
  pushl $137
801090f2:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801090f7:	e9 a8 f4 ff ff       	jmp    801085a4 <alltraps>

801090fc <vector138>:
.globl vector138
vector138:
  pushl $0
801090fc:	6a 00                	push   $0x0
  pushl $138
801090fe:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80109103:	e9 9c f4 ff ff       	jmp    801085a4 <alltraps>

80109108 <vector139>:
.globl vector139
vector139:
  pushl $0
80109108:	6a 00                	push   $0x0
  pushl $139
8010910a:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
8010910f:	e9 90 f4 ff ff       	jmp    801085a4 <alltraps>

80109114 <vector140>:
.globl vector140
vector140:
  pushl $0
80109114:	6a 00                	push   $0x0
  pushl $140
80109116:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010911b:	e9 84 f4 ff ff       	jmp    801085a4 <alltraps>

80109120 <vector141>:
.globl vector141
vector141:
  pushl $0
80109120:	6a 00                	push   $0x0
  pushl $141
80109122:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80109127:	e9 78 f4 ff ff       	jmp    801085a4 <alltraps>

8010912c <vector142>:
.globl vector142
vector142:
  pushl $0
8010912c:	6a 00                	push   $0x0
  pushl $142
8010912e:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80109133:	e9 6c f4 ff ff       	jmp    801085a4 <alltraps>

80109138 <vector143>:
.globl vector143
vector143:
  pushl $0
80109138:	6a 00                	push   $0x0
  pushl $143
8010913a:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
8010913f:	e9 60 f4 ff ff       	jmp    801085a4 <alltraps>

80109144 <vector144>:
.globl vector144
vector144:
  pushl $0
80109144:	6a 00                	push   $0x0
  pushl $144
80109146:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010914b:	e9 54 f4 ff ff       	jmp    801085a4 <alltraps>

80109150 <vector145>:
.globl vector145
vector145:
  pushl $0
80109150:	6a 00                	push   $0x0
  pushl $145
80109152:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80109157:	e9 48 f4 ff ff       	jmp    801085a4 <alltraps>

8010915c <vector146>:
.globl vector146
vector146:
  pushl $0
8010915c:	6a 00                	push   $0x0
  pushl $146
8010915e:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80109163:	e9 3c f4 ff ff       	jmp    801085a4 <alltraps>

80109168 <vector147>:
.globl vector147
vector147:
  pushl $0
80109168:	6a 00                	push   $0x0
  pushl $147
8010916a:	68 93 00 00 00       	push   $0x93
  jmp alltraps
8010916f:	e9 30 f4 ff ff       	jmp    801085a4 <alltraps>

80109174 <vector148>:
.globl vector148
vector148:
  pushl $0
80109174:	6a 00                	push   $0x0
  pushl $148
80109176:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010917b:	e9 24 f4 ff ff       	jmp    801085a4 <alltraps>

80109180 <vector149>:
.globl vector149
vector149:
  pushl $0
80109180:	6a 00                	push   $0x0
  pushl $149
80109182:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80109187:	e9 18 f4 ff ff       	jmp    801085a4 <alltraps>

8010918c <vector150>:
.globl vector150
vector150:
  pushl $0
8010918c:	6a 00                	push   $0x0
  pushl $150
8010918e:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80109193:	e9 0c f4 ff ff       	jmp    801085a4 <alltraps>

80109198 <vector151>:
.globl vector151
vector151:
  pushl $0
80109198:	6a 00                	push   $0x0
  pushl $151
8010919a:	68 97 00 00 00       	push   $0x97
  jmp alltraps
8010919f:	e9 00 f4 ff ff       	jmp    801085a4 <alltraps>

801091a4 <vector152>:
.globl vector152
vector152:
  pushl $0
801091a4:	6a 00                	push   $0x0
  pushl $152
801091a6:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801091ab:	e9 f4 f3 ff ff       	jmp    801085a4 <alltraps>

801091b0 <vector153>:
.globl vector153
vector153:
  pushl $0
801091b0:	6a 00                	push   $0x0
  pushl $153
801091b2:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801091b7:	e9 e8 f3 ff ff       	jmp    801085a4 <alltraps>

801091bc <vector154>:
.globl vector154
vector154:
  pushl $0
801091bc:	6a 00                	push   $0x0
  pushl $154
801091be:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801091c3:	e9 dc f3 ff ff       	jmp    801085a4 <alltraps>

801091c8 <vector155>:
.globl vector155
vector155:
  pushl $0
801091c8:	6a 00                	push   $0x0
  pushl $155
801091ca:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801091cf:	e9 d0 f3 ff ff       	jmp    801085a4 <alltraps>

801091d4 <vector156>:
.globl vector156
vector156:
  pushl $0
801091d4:	6a 00                	push   $0x0
  pushl $156
801091d6:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801091db:	e9 c4 f3 ff ff       	jmp    801085a4 <alltraps>

801091e0 <vector157>:
.globl vector157
vector157:
  pushl $0
801091e0:	6a 00                	push   $0x0
  pushl $157
801091e2:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801091e7:	e9 b8 f3 ff ff       	jmp    801085a4 <alltraps>

801091ec <vector158>:
.globl vector158
vector158:
  pushl $0
801091ec:	6a 00                	push   $0x0
  pushl $158
801091ee:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801091f3:	e9 ac f3 ff ff       	jmp    801085a4 <alltraps>

801091f8 <vector159>:
.globl vector159
vector159:
  pushl $0
801091f8:	6a 00                	push   $0x0
  pushl $159
801091fa:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801091ff:	e9 a0 f3 ff ff       	jmp    801085a4 <alltraps>

80109204 <vector160>:
.globl vector160
vector160:
  pushl $0
80109204:	6a 00                	push   $0x0
  pushl $160
80109206:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010920b:	e9 94 f3 ff ff       	jmp    801085a4 <alltraps>

80109210 <vector161>:
.globl vector161
vector161:
  pushl $0
80109210:	6a 00                	push   $0x0
  pushl $161
80109212:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80109217:	e9 88 f3 ff ff       	jmp    801085a4 <alltraps>

8010921c <vector162>:
.globl vector162
vector162:
  pushl $0
8010921c:	6a 00                	push   $0x0
  pushl $162
8010921e:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80109223:	e9 7c f3 ff ff       	jmp    801085a4 <alltraps>

80109228 <vector163>:
.globl vector163
vector163:
  pushl $0
80109228:	6a 00                	push   $0x0
  pushl $163
8010922a:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
8010922f:	e9 70 f3 ff ff       	jmp    801085a4 <alltraps>

80109234 <vector164>:
.globl vector164
vector164:
  pushl $0
80109234:	6a 00                	push   $0x0
  pushl $164
80109236:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010923b:	e9 64 f3 ff ff       	jmp    801085a4 <alltraps>

80109240 <vector165>:
.globl vector165
vector165:
  pushl $0
80109240:	6a 00                	push   $0x0
  pushl $165
80109242:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80109247:	e9 58 f3 ff ff       	jmp    801085a4 <alltraps>

8010924c <vector166>:
.globl vector166
vector166:
  pushl $0
8010924c:	6a 00                	push   $0x0
  pushl $166
8010924e:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80109253:	e9 4c f3 ff ff       	jmp    801085a4 <alltraps>

80109258 <vector167>:
.globl vector167
vector167:
  pushl $0
80109258:	6a 00                	push   $0x0
  pushl $167
8010925a:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
8010925f:	e9 40 f3 ff ff       	jmp    801085a4 <alltraps>

80109264 <vector168>:
.globl vector168
vector168:
  pushl $0
80109264:	6a 00                	push   $0x0
  pushl $168
80109266:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010926b:	e9 34 f3 ff ff       	jmp    801085a4 <alltraps>

80109270 <vector169>:
.globl vector169
vector169:
  pushl $0
80109270:	6a 00                	push   $0x0
  pushl $169
80109272:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80109277:	e9 28 f3 ff ff       	jmp    801085a4 <alltraps>

8010927c <vector170>:
.globl vector170
vector170:
  pushl $0
8010927c:	6a 00                	push   $0x0
  pushl $170
8010927e:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80109283:	e9 1c f3 ff ff       	jmp    801085a4 <alltraps>

80109288 <vector171>:
.globl vector171
vector171:
  pushl $0
80109288:	6a 00                	push   $0x0
  pushl $171
8010928a:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
8010928f:	e9 10 f3 ff ff       	jmp    801085a4 <alltraps>

80109294 <vector172>:
.globl vector172
vector172:
  pushl $0
80109294:	6a 00                	push   $0x0
  pushl $172
80109296:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010929b:	e9 04 f3 ff ff       	jmp    801085a4 <alltraps>

801092a0 <vector173>:
.globl vector173
vector173:
  pushl $0
801092a0:	6a 00                	push   $0x0
  pushl $173
801092a2:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801092a7:	e9 f8 f2 ff ff       	jmp    801085a4 <alltraps>

801092ac <vector174>:
.globl vector174
vector174:
  pushl $0
801092ac:	6a 00                	push   $0x0
  pushl $174
801092ae:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801092b3:	e9 ec f2 ff ff       	jmp    801085a4 <alltraps>

801092b8 <vector175>:
.globl vector175
vector175:
  pushl $0
801092b8:	6a 00                	push   $0x0
  pushl $175
801092ba:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801092bf:	e9 e0 f2 ff ff       	jmp    801085a4 <alltraps>

801092c4 <vector176>:
.globl vector176
vector176:
  pushl $0
801092c4:	6a 00                	push   $0x0
  pushl $176
801092c6:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801092cb:	e9 d4 f2 ff ff       	jmp    801085a4 <alltraps>

801092d0 <vector177>:
.globl vector177
vector177:
  pushl $0
801092d0:	6a 00                	push   $0x0
  pushl $177
801092d2:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801092d7:	e9 c8 f2 ff ff       	jmp    801085a4 <alltraps>

801092dc <vector178>:
.globl vector178
vector178:
  pushl $0
801092dc:	6a 00                	push   $0x0
  pushl $178
801092de:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801092e3:	e9 bc f2 ff ff       	jmp    801085a4 <alltraps>

801092e8 <vector179>:
.globl vector179
vector179:
  pushl $0
801092e8:	6a 00                	push   $0x0
  pushl $179
801092ea:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801092ef:	e9 b0 f2 ff ff       	jmp    801085a4 <alltraps>

801092f4 <vector180>:
.globl vector180
vector180:
  pushl $0
801092f4:	6a 00                	push   $0x0
  pushl $180
801092f6:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801092fb:	e9 a4 f2 ff ff       	jmp    801085a4 <alltraps>

80109300 <vector181>:
.globl vector181
vector181:
  pushl $0
80109300:	6a 00                	push   $0x0
  pushl $181
80109302:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80109307:	e9 98 f2 ff ff       	jmp    801085a4 <alltraps>

8010930c <vector182>:
.globl vector182
vector182:
  pushl $0
8010930c:	6a 00                	push   $0x0
  pushl $182
8010930e:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80109313:	e9 8c f2 ff ff       	jmp    801085a4 <alltraps>

80109318 <vector183>:
.globl vector183
vector183:
  pushl $0
80109318:	6a 00                	push   $0x0
  pushl $183
8010931a:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
8010931f:	e9 80 f2 ff ff       	jmp    801085a4 <alltraps>

80109324 <vector184>:
.globl vector184
vector184:
  pushl $0
80109324:	6a 00                	push   $0x0
  pushl $184
80109326:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010932b:	e9 74 f2 ff ff       	jmp    801085a4 <alltraps>

80109330 <vector185>:
.globl vector185
vector185:
  pushl $0
80109330:	6a 00                	push   $0x0
  pushl $185
80109332:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80109337:	e9 68 f2 ff ff       	jmp    801085a4 <alltraps>

8010933c <vector186>:
.globl vector186
vector186:
  pushl $0
8010933c:	6a 00                	push   $0x0
  pushl $186
8010933e:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80109343:	e9 5c f2 ff ff       	jmp    801085a4 <alltraps>

80109348 <vector187>:
.globl vector187
vector187:
  pushl $0
80109348:	6a 00                	push   $0x0
  pushl $187
8010934a:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
8010934f:	e9 50 f2 ff ff       	jmp    801085a4 <alltraps>

80109354 <vector188>:
.globl vector188
vector188:
  pushl $0
80109354:	6a 00                	push   $0x0
  pushl $188
80109356:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010935b:	e9 44 f2 ff ff       	jmp    801085a4 <alltraps>

80109360 <vector189>:
.globl vector189
vector189:
  pushl $0
80109360:	6a 00                	push   $0x0
  pushl $189
80109362:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80109367:	e9 38 f2 ff ff       	jmp    801085a4 <alltraps>

8010936c <vector190>:
.globl vector190
vector190:
  pushl $0
8010936c:	6a 00                	push   $0x0
  pushl $190
8010936e:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80109373:	e9 2c f2 ff ff       	jmp    801085a4 <alltraps>

80109378 <vector191>:
.globl vector191
vector191:
  pushl $0
80109378:	6a 00                	push   $0x0
  pushl $191
8010937a:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
8010937f:	e9 20 f2 ff ff       	jmp    801085a4 <alltraps>

80109384 <vector192>:
.globl vector192
vector192:
  pushl $0
80109384:	6a 00                	push   $0x0
  pushl $192
80109386:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010938b:	e9 14 f2 ff ff       	jmp    801085a4 <alltraps>

80109390 <vector193>:
.globl vector193
vector193:
  pushl $0
80109390:	6a 00                	push   $0x0
  pushl $193
80109392:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80109397:	e9 08 f2 ff ff       	jmp    801085a4 <alltraps>

8010939c <vector194>:
.globl vector194
vector194:
  pushl $0
8010939c:	6a 00                	push   $0x0
  pushl $194
8010939e:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801093a3:	e9 fc f1 ff ff       	jmp    801085a4 <alltraps>

801093a8 <vector195>:
.globl vector195
vector195:
  pushl $0
801093a8:	6a 00                	push   $0x0
  pushl $195
801093aa:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801093af:	e9 f0 f1 ff ff       	jmp    801085a4 <alltraps>

801093b4 <vector196>:
.globl vector196
vector196:
  pushl $0
801093b4:	6a 00                	push   $0x0
  pushl $196
801093b6:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801093bb:	e9 e4 f1 ff ff       	jmp    801085a4 <alltraps>

801093c0 <vector197>:
.globl vector197
vector197:
  pushl $0
801093c0:	6a 00                	push   $0x0
  pushl $197
801093c2:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801093c7:	e9 d8 f1 ff ff       	jmp    801085a4 <alltraps>

801093cc <vector198>:
.globl vector198
vector198:
  pushl $0
801093cc:	6a 00                	push   $0x0
  pushl $198
801093ce:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801093d3:	e9 cc f1 ff ff       	jmp    801085a4 <alltraps>

801093d8 <vector199>:
.globl vector199
vector199:
  pushl $0
801093d8:	6a 00                	push   $0x0
  pushl $199
801093da:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801093df:	e9 c0 f1 ff ff       	jmp    801085a4 <alltraps>

801093e4 <vector200>:
.globl vector200
vector200:
  pushl $0
801093e4:	6a 00                	push   $0x0
  pushl $200
801093e6:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801093eb:	e9 b4 f1 ff ff       	jmp    801085a4 <alltraps>

801093f0 <vector201>:
.globl vector201
vector201:
  pushl $0
801093f0:	6a 00                	push   $0x0
  pushl $201
801093f2:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801093f7:	e9 a8 f1 ff ff       	jmp    801085a4 <alltraps>

801093fc <vector202>:
.globl vector202
vector202:
  pushl $0
801093fc:	6a 00                	push   $0x0
  pushl $202
801093fe:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80109403:	e9 9c f1 ff ff       	jmp    801085a4 <alltraps>

80109408 <vector203>:
.globl vector203
vector203:
  pushl $0
80109408:	6a 00                	push   $0x0
  pushl $203
8010940a:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
8010940f:	e9 90 f1 ff ff       	jmp    801085a4 <alltraps>

80109414 <vector204>:
.globl vector204
vector204:
  pushl $0
80109414:	6a 00                	push   $0x0
  pushl $204
80109416:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010941b:	e9 84 f1 ff ff       	jmp    801085a4 <alltraps>

80109420 <vector205>:
.globl vector205
vector205:
  pushl $0
80109420:	6a 00                	push   $0x0
  pushl $205
80109422:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80109427:	e9 78 f1 ff ff       	jmp    801085a4 <alltraps>

8010942c <vector206>:
.globl vector206
vector206:
  pushl $0
8010942c:	6a 00                	push   $0x0
  pushl $206
8010942e:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80109433:	e9 6c f1 ff ff       	jmp    801085a4 <alltraps>

80109438 <vector207>:
.globl vector207
vector207:
  pushl $0
80109438:	6a 00                	push   $0x0
  pushl $207
8010943a:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
8010943f:	e9 60 f1 ff ff       	jmp    801085a4 <alltraps>

80109444 <vector208>:
.globl vector208
vector208:
  pushl $0
80109444:	6a 00                	push   $0x0
  pushl $208
80109446:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010944b:	e9 54 f1 ff ff       	jmp    801085a4 <alltraps>

80109450 <vector209>:
.globl vector209
vector209:
  pushl $0
80109450:	6a 00                	push   $0x0
  pushl $209
80109452:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80109457:	e9 48 f1 ff ff       	jmp    801085a4 <alltraps>

8010945c <vector210>:
.globl vector210
vector210:
  pushl $0
8010945c:	6a 00                	push   $0x0
  pushl $210
8010945e:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80109463:	e9 3c f1 ff ff       	jmp    801085a4 <alltraps>

80109468 <vector211>:
.globl vector211
vector211:
  pushl $0
80109468:	6a 00                	push   $0x0
  pushl $211
8010946a:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
8010946f:	e9 30 f1 ff ff       	jmp    801085a4 <alltraps>

80109474 <vector212>:
.globl vector212
vector212:
  pushl $0
80109474:	6a 00                	push   $0x0
  pushl $212
80109476:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010947b:	e9 24 f1 ff ff       	jmp    801085a4 <alltraps>

80109480 <vector213>:
.globl vector213
vector213:
  pushl $0
80109480:	6a 00                	push   $0x0
  pushl $213
80109482:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80109487:	e9 18 f1 ff ff       	jmp    801085a4 <alltraps>

8010948c <vector214>:
.globl vector214
vector214:
  pushl $0
8010948c:	6a 00                	push   $0x0
  pushl $214
8010948e:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80109493:	e9 0c f1 ff ff       	jmp    801085a4 <alltraps>

80109498 <vector215>:
.globl vector215
vector215:
  pushl $0
80109498:	6a 00                	push   $0x0
  pushl $215
8010949a:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
8010949f:	e9 00 f1 ff ff       	jmp    801085a4 <alltraps>

801094a4 <vector216>:
.globl vector216
vector216:
  pushl $0
801094a4:	6a 00                	push   $0x0
  pushl $216
801094a6:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801094ab:	e9 f4 f0 ff ff       	jmp    801085a4 <alltraps>

801094b0 <vector217>:
.globl vector217
vector217:
  pushl $0
801094b0:	6a 00                	push   $0x0
  pushl $217
801094b2:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801094b7:	e9 e8 f0 ff ff       	jmp    801085a4 <alltraps>

801094bc <vector218>:
.globl vector218
vector218:
  pushl $0
801094bc:	6a 00                	push   $0x0
  pushl $218
801094be:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801094c3:	e9 dc f0 ff ff       	jmp    801085a4 <alltraps>

801094c8 <vector219>:
.globl vector219
vector219:
  pushl $0
801094c8:	6a 00                	push   $0x0
  pushl $219
801094ca:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801094cf:	e9 d0 f0 ff ff       	jmp    801085a4 <alltraps>

801094d4 <vector220>:
.globl vector220
vector220:
  pushl $0
801094d4:	6a 00                	push   $0x0
  pushl $220
801094d6:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801094db:	e9 c4 f0 ff ff       	jmp    801085a4 <alltraps>

801094e0 <vector221>:
.globl vector221
vector221:
  pushl $0
801094e0:	6a 00                	push   $0x0
  pushl $221
801094e2:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801094e7:	e9 b8 f0 ff ff       	jmp    801085a4 <alltraps>

801094ec <vector222>:
.globl vector222
vector222:
  pushl $0
801094ec:	6a 00                	push   $0x0
  pushl $222
801094ee:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801094f3:	e9 ac f0 ff ff       	jmp    801085a4 <alltraps>

801094f8 <vector223>:
.globl vector223
vector223:
  pushl $0
801094f8:	6a 00                	push   $0x0
  pushl $223
801094fa:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801094ff:	e9 a0 f0 ff ff       	jmp    801085a4 <alltraps>

80109504 <vector224>:
.globl vector224
vector224:
  pushl $0
80109504:	6a 00                	push   $0x0
  pushl $224
80109506:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010950b:	e9 94 f0 ff ff       	jmp    801085a4 <alltraps>

80109510 <vector225>:
.globl vector225
vector225:
  pushl $0
80109510:	6a 00                	push   $0x0
  pushl $225
80109512:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80109517:	e9 88 f0 ff ff       	jmp    801085a4 <alltraps>

8010951c <vector226>:
.globl vector226
vector226:
  pushl $0
8010951c:	6a 00                	push   $0x0
  pushl $226
8010951e:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80109523:	e9 7c f0 ff ff       	jmp    801085a4 <alltraps>

80109528 <vector227>:
.globl vector227
vector227:
  pushl $0
80109528:	6a 00                	push   $0x0
  pushl $227
8010952a:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
8010952f:	e9 70 f0 ff ff       	jmp    801085a4 <alltraps>

80109534 <vector228>:
.globl vector228
vector228:
  pushl $0
80109534:	6a 00                	push   $0x0
  pushl $228
80109536:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010953b:	e9 64 f0 ff ff       	jmp    801085a4 <alltraps>

80109540 <vector229>:
.globl vector229
vector229:
  pushl $0
80109540:	6a 00                	push   $0x0
  pushl $229
80109542:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80109547:	e9 58 f0 ff ff       	jmp    801085a4 <alltraps>

8010954c <vector230>:
.globl vector230
vector230:
  pushl $0
8010954c:	6a 00                	push   $0x0
  pushl $230
8010954e:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80109553:	e9 4c f0 ff ff       	jmp    801085a4 <alltraps>

80109558 <vector231>:
.globl vector231
vector231:
  pushl $0
80109558:	6a 00                	push   $0x0
  pushl $231
8010955a:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
8010955f:	e9 40 f0 ff ff       	jmp    801085a4 <alltraps>

80109564 <vector232>:
.globl vector232
vector232:
  pushl $0
80109564:	6a 00                	push   $0x0
  pushl $232
80109566:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010956b:	e9 34 f0 ff ff       	jmp    801085a4 <alltraps>

80109570 <vector233>:
.globl vector233
vector233:
  pushl $0
80109570:	6a 00                	push   $0x0
  pushl $233
80109572:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80109577:	e9 28 f0 ff ff       	jmp    801085a4 <alltraps>

8010957c <vector234>:
.globl vector234
vector234:
  pushl $0
8010957c:	6a 00                	push   $0x0
  pushl $234
8010957e:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80109583:	e9 1c f0 ff ff       	jmp    801085a4 <alltraps>

80109588 <vector235>:
.globl vector235
vector235:
  pushl $0
80109588:	6a 00                	push   $0x0
  pushl $235
8010958a:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
8010958f:	e9 10 f0 ff ff       	jmp    801085a4 <alltraps>

80109594 <vector236>:
.globl vector236
vector236:
  pushl $0
80109594:	6a 00                	push   $0x0
  pushl $236
80109596:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010959b:	e9 04 f0 ff ff       	jmp    801085a4 <alltraps>

801095a0 <vector237>:
.globl vector237
vector237:
  pushl $0
801095a0:	6a 00                	push   $0x0
  pushl $237
801095a2:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801095a7:	e9 f8 ef ff ff       	jmp    801085a4 <alltraps>

801095ac <vector238>:
.globl vector238
vector238:
  pushl $0
801095ac:	6a 00                	push   $0x0
  pushl $238
801095ae:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801095b3:	e9 ec ef ff ff       	jmp    801085a4 <alltraps>

801095b8 <vector239>:
.globl vector239
vector239:
  pushl $0
801095b8:	6a 00                	push   $0x0
  pushl $239
801095ba:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801095bf:	e9 e0 ef ff ff       	jmp    801085a4 <alltraps>

801095c4 <vector240>:
.globl vector240
vector240:
  pushl $0
801095c4:	6a 00                	push   $0x0
  pushl $240
801095c6:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801095cb:	e9 d4 ef ff ff       	jmp    801085a4 <alltraps>

801095d0 <vector241>:
.globl vector241
vector241:
  pushl $0
801095d0:	6a 00                	push   $0x0
  pushl $241
801095d2:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801095d7:	e9 c8 ef ff ff       	jmp    801085a4 <alltraps>

801095dc <vector242>:
.globl vector242
vector242:
  pushl $0
801095dc:	6a 00                	push   $0x0
  pushl $242
801095de:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801095e3:	e9 bc ef ff ff       	jmp    801085a4 <alltraps>

801095e8 <vector243>:
.globl vector243
vector243:
  pushl $0
801095e8:	6a 00                	push   $0x0
  pushl $243
801095ea:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801095ef:	e9 b0 ef ff ff       	jmp    801085a4 <alltraps>

801095f4 <vector244>:
.globl vector244
vector244:
  pushl $0
801095f4:	6a 00                	push   $0x0
  pushl $244
801095f6:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801095fb:	e9 a4 ef ff ff       	jmp    801085a4 <alltraps>

80109600 <vector245>:
.globl vector245
vector245:
  pushl $0
80109600:	6a 00                	push   $0x0
  pushl $245
80109602:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80109607:	e9 98 ef ff ff       	jmp    801085a4 <alltraps>

8010960c <vector246>:
.globl vector246
vector246:
  pushl $0
8010960c:	6a 00                	push   $0x0
  pushl $246
8010960e:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80109613:	e9 8c ef ff ff       	jmp    801085a4 <alltraps>

80109618 <vector247>:
.globl vector247
vector247:
  pushl $0
80109618:	6a 00                	push   $0x0
  pushl $247
8010961a:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
8010961f:	e9 80 ef ff ff       	jmp    801085a4 <alltraps>

80109624 <vector248>:
.globl vector248
vector248:
  pushl $0
80109624:	6a 00                	push   $0x0
  pushl $248
80109626:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010962b:	e9 74 ef ff ff       	jmp    801085a4 <alltraps>

80109630 <vector249>:
.globl vector249
vector249:
  pushl $0
80109630:	6a 00                	push   $0x0
  pushl $249
80109632:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80109637:	e9 68 ef ff ff       	jmp    801085a4 <alltraps>

8010963c <vector250>:
.globl vector250
vector250:
  pushl $0
8010963c:	6a 00                	push   $0x0
  pushl $250
8010963e:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80109643:	e9 5c ef ff ff       	jmp    801085a4 <alltraps>

80109648 <vector251>:
.globl vector251
vector251:
  pushl $0
80109648:	6a 00                	push   $0x0
  pushl $251
8010964a:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
8010964f:	e9 50 ef ff ff       	jmp    801085a4 <alltraps>

80109654 <vector252>:
.globl vector252
vector252:
  pushl $0
80109654:	6a 00                	push   $0x0
  pushl $252
80109656:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010965b:	e9 44 ef ff ff       	jmp    801085a4 <alltraps>

80109660 <vector253>:
.globl vector253
vector253:
  pushl $0
80109660:	6a 00                	push   $0x0
  pushl $253
80109662:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80109667:	e9 38 ef ff ff       	jmp    801085a4 <alltraps>

8010966c <vector254>:
.globl vector254
vector254:
  pushl $0
8010966c:	6a 00                	push   $0x0
  pushl $254
8010966e:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80109673:	e9 2c ef ff ff       	jmp    801085a4 <alltraps>

80109678 <vector255>:
.globl vector255
vector255:
  pushl $0
80109678:	6a 00                	push   $0x0
  pushl $255
8010967a:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
8010967f:	e9 20 ef ff ff       	jmp    801085a4 <alltraps>

80109684 <lgdt>:
{
80109684:	55                   	push   %ebp
80109685:	89 e5                	mov    %esp,%ebp
80109687:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
8010968a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010968d:	83 e8 01             	sub    $0x1,%eax
80109690:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80109694:	8b 45 08             	mov    0x8(%ebp),%eax
80109697:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010969b:	8b 45 08             	mov    0x8(%ebp),%eax
8010969e:	c1 e8 10             	shr    $0x10,%eax
801096a1:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801096a5:	8d 45 fa             	lea    -0x6(%ebp),%eax
801096a8:	0f 01 10             	lgdtl  (%eax)
}
801096ab:	90                   	nop
801096ac:	c9                   	leave  
801096ad:	c3                   	ret    

801096ae <ltr>:
{
801096ae:	55                   	push   %ebp
801096af:	89 e5                	mov    %esp,%ebp
801096b1:	83 ec 04             	sub    $0x4,%esp
801096b4:	8b 45 08             	mov    0x8(%ebp),%eax
801096b7:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
801096bb:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801096bf:	0f 00 d8             	ltr    %ax
}
801096c2:	90                   	nop
801096c3:	c9                   	leave  
801096c4:	c3                   	ret    

801096c5 <loadgs>:
{
801096c5:	55                   	push   %ebp
801096c6:	89 e5                	mov    %esp,%ebp
801096c8:	83 ec 04             	sub    $0x4,%esp
801096cb:	8b 45 08             	mov    0x8(%ebp),%eax
801096ce:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
801096d2:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801096d6:	8e e8                	mov    %eax,%gs
}
801096d8:	90                   	nop
801096d9:	c9                   	leave  
801096da:	c3                   	ret    

801096db <lcr3>:

static inline void
lcr3(uint val) 
{
801096db:	55                   	push   %ebp
801096dc:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
801096de:	8b 45 08             	mov    0x8(%ebp),%eax
801096e1:	0f 22 d8             	mov    %eax,%cr3
}
801096e4:	90                   	nop
801096e5:	5d                   	pop    %ebp
801096e6:	c3                   	ret    

801096e7 <v2p>:
static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
801096e7:	55                   	push   %ebp
801096e8:	89 e5                	mov    %esp,%ebp
801096ea:	8b 45 08             	mov    0x8(%ebp),%eax
801096ed:	05 00 00 00 80       	add    $0x80000000,%eax
801096f2:	5d                   	pop    %ebp
801096f3:	c3                   	ret    

801096f4 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801096f4:	55                   	push   %ebp
801096f5:	89 e5                	mov    %esp,%ebp
801096f7:	8b 45 08             	mov    0x8(%ebp),%eax
801096fa:	05 00 00 00 80       	add    $0x80000000,%eax
801096ff:	5d                   	pop    %ebp
80109700:	c3                   	ret    

80109701 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80109701:	f3 0f 1e fb          	endbr32 
80109705:	55                   	push   %ebp
80109706:	89 e5                	mov    %esp,%ebp
80109708:	53                   	push   %ebx
80109709:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
8010970c:	e8 2c 9c ff ff       	call   8010333d <cpunum>
80109711:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80109717:	05 00 60 11 80       	add    $0x80116000,%eax
8010971c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010971f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109722:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80109728:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010972b:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80109731:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109734:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80109738:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010973b:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010973f:	83 e2 f0             	and    $0xfffffff0,%edx
80109742:	83 ca 0a             	or     $0xa,%edx
80109745:	88 50 7d             	mov    %dl,0x7d(%eax)
80109748:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010974b:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010974f:	83 ca 10             	or     $0x10,%edx
80109752:	88 50 7d             	mov    %dl,0x7d(%eax)
80109755:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109758:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010975c:	83 e2 9f             	and    $0xffffff9f,%edx
8010975f:	88 50 7d             	mov    %dl,0x7d(%eax)
80109762:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109765:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80109769:	83 ca 80             	or     $0xffffff80,%edx
8010976c:	88 50 7d             	mov    %dl,0x7d(%eax)
8010976f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109772:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80109776:	83 ca 0f             	or     $0xf,%edx
80109779:	88 50 7e             	mov    %dl,0x7e(%eax)
8010977c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010977f:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80109783:	83 e2 ef             	and    $0xffffffef,%edx
80109786:	88 50 7e             	mov    %dl,0x7e(%eax)
80109789:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010978c:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80109790:	83 e2 df             	and    $0xffffffdf,%edx
80109793:	88 50 7e             	mov    %dl,0x7e(%eax)
80109796:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109799:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010979d:	83 ca 40             	or     $0x40,%edx
801097a0:	88 50 7e             	mov    %dl,0x7e(%eax)
801097a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801097a6:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801097aa:	83 ca 80             	or     $0xffffff80,%edx
801097ad:	88 50 7e             	mov    %dl,0x7e(%eax)
801097b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801097b3:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801097b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801097ba:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801097c1:	ff ff 
801097c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801097c6:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801097cd:	00 00 
801097cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801097d2:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801097d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801097dc:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801097e3:	83 e2 f0             	and    $0xfffffff0,%edx
801097e6:	83 ca 02             	or     $0x2,%edx
801097e9:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801097ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801097f2:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801097f9:	83 ca 10             	or     $0x10,%edx
801097fc:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80109802:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109805:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010980c:	83 e2 9f             	and    $0xffffff9f,%edx
8010980f:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80109815:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109818:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010981f:	83 ca 80             	or     $0xffffff80,%edx
80109822:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80109828:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010982b:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80109832:	83 ca 0f             	or     $0xf,%edx
80109835:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010983b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010983e:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80109845:	83 e2 ef             	and    $0xffffffef,%edx
80109848:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010984e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109851:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80109858:	83 e2 df             	and    $0xffffffdf,%edx
8010985b:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80109861:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109864:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010986b:	83 ca 40             	or     $0x40,%edx
8010986e:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80109874:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109877:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010987e:	83 ca 80             	or     $0xffffff80,%edx
80109881:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80109887:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010988a:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80109891:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109894:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
8010989b:	ff ff 
8010989d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801098a0:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
801098a7:	00 00 
801098a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801098ac:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
801098b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801098b6:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801098bd:	83 e2 f0             	and    $0xfffffff0,%edx
801098c0:	83 ca 0a             	or     $0xa,%edx
801098c3:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801098c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801098cc:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801098d3:	83 ca 10             	or     $0x10,%edx
801098d6:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801098dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801098df:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801098e6:	83 ca 60             	or     $0x60,%edx
801098e9:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801098ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801098f2:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801098f9:	83 ca 80             	or     $0xffffff80,%edx
801098fc:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80109902:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109905:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010990c:	83 ca 0f             	or     $0xf,%edx
8010990f:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80109915:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109918:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010991f:	83 e2 ef             	and    $0xffffffef,%edx
80109922:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80109928:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010992b:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80109932:	83 e2 df             	and    $0xffffffdf,%edx
80109935:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
8010993b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010993e:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80109945:	83 ca 40             	or     $0x40,%edx
80109948:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
8010994e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109951:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80109958:	83 ca 80             	or     $0xffffff80,%edx
8010995b:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80109961:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109964:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010996b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010996e:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80109975:	ff ff 
80109977:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010997a:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80109981:	00 00 
80109983:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109986:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
8010998d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109990:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80109997:	83 e2 f0             	and    $0xfffffff0,%edx
8010999a:	83 ca 02             	or     $0x2,%edx
8010999d:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801099a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801099a6:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
801099ad:	83 ca 10             	or     $0x10,%edx
801099b0:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801099b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801099b9:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
801099c0:	83 ca 60             	or     $0x60,%edx
801099c3:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801099c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801099cc:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
801099d3:	83 ca 80             	or     $0xffffff80,%edx
801099d6:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801099dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801099df:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801099e6:	83 ca 0f             	or     $0xf,%edx
801099e9:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801099ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801099f2:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801099f9:	83 e2 ef             	and    $0xffffffef,%edx
801099fc:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80109a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a05:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80109a0c:	83 e2 df             	and    $0xffffffdf,%edx
80109a0f:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80109a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a18:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80109a1f:	83 ca 40             	or     $0x40,%edx
80109a22:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80109a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a2b:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80109a32:	83 ca 80             	or     $0xffffff80,%edx
80109a35:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80109a3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a3e:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80109a45:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a48:	05 b4 00 00 00       	add    $0xb4,%eax
80109a4d:	89 c3                	mov    %eax,%ebx
80109a4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a52:	05 b4 00 00 00       	add    $0xb4,%eax
80109a57:	c1 e8 10             	shr    $0x10,%eax
80109a5a:	89 c2                	mov    %eax,%edx
80109a5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a5f:	05 b4 00 00 00       	add    $0xb4,%eax
80109a64:	c1 e8 18             	shr    $0x18,%eax
80109a67:	89 c1                	mov    %eax,%ecx
80109a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a6c:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80109a73:	00 00 
80109a75:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a78:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80109a7f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a82:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80109a88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109a8b:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80109a92:	83 e2 f0             	and    $0xfffffff0,%edx
80109a95:	83 ca 02             	or     $0x2,%edx
80109a98:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80109a9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109aa1:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80109aa8:	83 ca 10             	or     $0x10,%edx
80109aab:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80109ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109ab4:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80109abb:	83 e2 9f             	and    $0xffffff9f,%edx
80109abe:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80109ac4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109ac7:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80109ace:	83 ca 80             	or     $0xffffff80,%edx
80109ad1:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80109ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109ada:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80109ae1:	83 e2 f0             	and    $0xfffffff0,%edx
80109ae4:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80109aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109aed:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80109af4:	83 e2 ef             	and    $0xffffffef,%edx
80109af7:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80109afd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109b00:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80109b07:	83 e2 df             	and    $0xffffffdf,%edx
80109b0a:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80109b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109b13:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80109b1a:	83 ca 40             	or     $0x40,%edx
80109b1d:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80109b23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109b26:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80109b2d:	83 ca 80             	or     $0xffffff80,%edx
80109b30:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80109b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109b39:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80109b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109b42:	83 c0 70             	add    $0x70,%eax
80109b45:	83 ec 08             	sub    $0x8,%esp
80109b48:	6a 38                	push   $0x38
80109b4a:	50                   	push   %eax
80109b4b:	e8 34 fb ff ff       	call   80109684 <lgdt>
80109b50:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80109b53:	83 ec 0c             	sub    $0xc,%esp
80109b56:	6a 18                	push   $0x18
80109b58:	e8 68 fb ff ff       	call   801096c5 <loadgs>
80109b5d:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80109b60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109b63:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80109b69:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80109b70:	00 00 00 00 
}
80109b74:	90                   	nop
80109b75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109b78:	c9                   	leave  
80109b79:	c3                   	ret    

80109b7a <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80109b7a:	f3 0f 1e fb          	endbr32 
80109b7e:	55                   	push   %ebp
80109b7f:	89 e5                	mov    %esp,%ebp
80109b81:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80109b84:	8b 45 0c             	mov    0xc(%ebp),%eax
80109b87:	c1 e8 16             	shr    $0x16,%eax
80109b8a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80109b91:	8b 45 08             	mov    0x8(%ebp),%eax
80109b94:	01 d0                	add    %edx,%eax
80109b96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80109b99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109b9c:	8b 00                	mov    (%eax),%eax
80109b9e:	83 e0 01             	and    $0x1,%eax
80109ba1:	85 c0                	test   %eax,%eax
80109ba3:	74 18                	je     80109bbd <walkpgdir+0x43>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80109ba5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109ba8:	8b 00                	mov    (%eax),%eax
80109baa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109baf:	50                   	push   %eax
80109bb0:	e8 3f fb ff ff       	call   801096f4 <p2v>
80109bb5:	83 c4 04             	add    $0x4,%esp
80109bb8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80109bbb:	eb 48                	jmp    80109c05 <walkpgdir+0x8b>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80109bbd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80109bc1:	74 0e                	je     80109bd1 <walkpgdir+0x57>
80109bc3:	e8 f8 93 ff ff       	call   80102fc0 <kalloc>
80109bc8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80109bcb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80109bcf:	75 07                	jne    80109bd8 <walkpgdir+0x5e>
      return 0;
80109bd1:	b8 00 00 00 00       	mov    $0x0,%eax
80109bd6:	eb 44                	jmp    80109c1c <walkpgdir+0xa2>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80109bd8:	83 ec 04             	sub    $0x4,%esp
80109bdb:	68 00 10 00 00       	push   $0x1000
80109be0:	6a 00                	push   $0x0
80109be2:	ff 75 f4             	pushl  -0xc(%ebp)
80109be5:	e8 a1 d2 ff ff       	call   80106e8b <memset>
80109bea:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80109bed:	83 ec 0c             	sub    $0xc,%esp
80109bf0:	ff 75 f4             	pushl  -0xc(%ebp)
80109bf3:	e8 ef fa ff ff       	call   801096e7 <v2p>
80109bf8:	83 c4 10             	add    $0x10,%esp
80109bfb:	83 c8 07             	or     $0x7,%eax
80109bfe:	89 c2                	mov    %eax,%edx
80109c00:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109c03:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80109c05:	8b 45 0c             	mov    0xc(%ebp),%eax
80109c08:	c1 e8 0c             	shr    $0xc,%eax
80109c0b:	25 ff 03 00 00       	and    $0x3ff,%eax
80109c10:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80109c17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109c1a:	01 d0                	add    %edx,%eax
}
80109c1c:	c9                   	leave  
80109c1d:	c3                   	ret    

80109c1e <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80109c1e:	f3 0f 1e fb          	endbr32 
80109c22:	55                   	push   %ebp
80109c23:	89 e5                	mov    %esp,%ebp
80109c25:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80109c28:	8b 45 0c             	mov    0xc(%ebp),%eax
80109c2b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109c30:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80109c33:	8b 55 0c             	mov    0xc(%ebp),%edx
80109c36:	8b 45 10             	mov    0x10(%ebp),%eax
80109c39:	01 d0                	add    %edx,%eax
80109c3b:	83 e8 01             	sub    $0x1,%eax
80109c3e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109c43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80109c46:	83 ec 04             	sub    $0x4,%esp
80109c49:	6a 01                	push   $0x1
80109c4b:	ff 75 f4             	pushl  -0xc(%ebp)
80109c4e:	ff 75 08             	pushl  0x8(%ebp)
80109c51:	e8 24 ff ff ff       	call   80109b7a <walkpgdir>
80109c56:	83 c4 10             	add    $0x10,%esp
80109c59:	89 45 ec             	mov    %eax,-0x14(%ebp)
80109c5c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80109c60:	75 07                	jne    80109c69 <mappages+0x4b>
      return -1;
80109c62:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80109c67:	eb 47                	jmp    80109cb0 <mappages+0x92>
    if(*pte & PTE_P)
80109c69:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109c6c:	8b 00                	mov    (%eax),%eax
80109c6e:	83 e0 01             	and    $0x1,%eax
80109c71:	85 c0                	test   %eax,%eax
80109c73:	74 0d                	je     80109c82 <mappages+0x64>
      panic("remap");
80109c75:	83 ec 0c             	sub    $0xc,%esp
80109c78:	68 5c b2 10 80       	push   $0x8010b25c
80109c7d:	e8 15 69 ff ff       	call   80100597 <panic>
    *pte = pa | perm | PTE_P;
80109c82:	8b 45 18             	mov    0x18(%ebp),%eax
80109c85:	0b 45 14             	or     0x14(%ebp),%eax
80109c88:	83 c8 01             	or     $0x1,%eax
80109c8b:	89 c2                	mov    %eax,%edx
80109c8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109c90:	89 10                	mov    %edx,(%eax)
    if(a == last)
80109c92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109c95:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80109c98:	74 10                	je     80109caa <mappages+0x8c>
      break;
    a += PGSIZE;
80109c9a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80109ca1:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80109ca8:	eb 9c                	jmp    80109c46 <mappages+0x28>
      break;
80109caa:	90                   	nop
  }
  return 0;
80109cab:	b8 00 00 00 00       	mov    $0x0,%eax
}
80109cb0:	c9                   	leave  
80109cb1:	c3                   	ret    

80109cb2 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80109cb2:	f3 0f 1e fb          	endbr32 
80109cb6:	55                   	push   %ebp
80109cb7:	89 e5                	mov    %esp,%ebp
80109cb9:	53                   	push   %ebx
80109cba:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80109cbd:	e8 fe 92 ff ff       	call   80102fc0 <kalloc>
80109cc2:	89 45 f0             	mov    %eax,-0x10(%ebp)
80109cc5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80109cc9:	75 0a                	jne    80109cd5 <setupkvm+0x23>
    return 0;
80109ccb:	b8 00 00 00 00       	mov    $0x0,%eax
80109cd0:	e9 8e 00 00 00       	jmp    80109d63 <setupkvm+0xb1>
  memset(pgdir, 0, PGSIZE);
80109cd5:	83 ec 04             	sub    $0x4,%esp
80109cd8:	68 00 10 00 00       	push   $0x1000
80109cdd:	6a 00                	push   $0x0
80109cdf:	ff 75 f0             	pushl  -0x10(%ebp)
80109ce2:	e8 a4 d1 ff ff       	call   80106e8b <memset>
80109ce7:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80109cea:	83 ec 0c             	sub    $0xc,%esp
80109ced:	68 00 00 00 0e       	push   $0xe000000
80109cf2:	e8 fd f9 ff ff       	call   801096f4 <p2v>
80109cf7:	83 c4 10             	add    $0x10,%esp
80109cfa:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80109cff:	76 0d                	jbe    80109d0e <setupkvm+0x5c>
    panic("PHYSTOP too high");
80109d01:	83 ec 0c             	sub    $0xc,%esp
80109d04:	68 62 b2 10 80       	push   $0x8010b262
80109d09:	e8 89 68 ff ff       	call   80100597 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80109d0e:	c7 45 f4 c0 e4 10 80 	movl   $0x8010e4c0,-0xc(%ebp)
80109d15:	eb 40                	jmp    80109d57 <setupkvm+0xa5>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80109d17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109d1a:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
80109d1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109d20:	8b 50 04             	mov    0x4(%eax),%edx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80109d23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109d26:	8b 58 08             	mov    0x8(%eax),%ebx
80109d29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109d2c:	8b 40 04             	mov    0x4(%eax),%eax
80109d2f:	29 c3                	sub    %eax,%ebx
80109d31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109d34:	8b 00                	mov    (%eax),%eax
80109d36:	83 ec 0c             	sub    $0xc,%esp
80109d39:	51                   	push   %ecx
80109d3a:	52                   	push   %edx
80109d3b:	53                   	push   %ebx
80109d3c:	50                   	push   %eax
80109d3d:	ff 75 f0             	pushl  -0x10(%ebp)
80109d40:	e8 d9 fe ff ff       	call   80109c1e <mappages>
80109d45:	83 c4 20             	add    $0x20,%esp
80109d48:	85 c0                	test   %eax,%eax
80109d4a:	79 07                	jns    80109d53 <setupkvm+0xa1>
      return 0;
80109d4c:	b8 00 00 00 00       	mov    $0x0,%eax
80109d51:	eb 10                	jmp    80109d63 <setupkvm+0xb1>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80109d53:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80109d57:	81 7d f4 00 e5 10 80 	cmpl   $0x8010e500,-0xc(%ebp)
80109d5e:	72 b7                	jb     80109d17 <setupkvm+0x65>
  return pgdir;
80109d60:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80109d63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80109d66:	c9                   	leave  
80109d67:	c3                   	ret    

80109d68 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80109d68:	f3 0f 1e fb          	endbr32 
80109d6c:	55                   	push   %ebp
80109d6d:	89 e5                	mov    %esp,%ebp
80109d6f:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80109d72:	e8 3b ff ff ff       	call   80109cb2 <setupkvm>
80109d77:	a3 b8 95 11 80       	mov    %eax,0x801195b8
  switchkvm();
80109d7c:	e8 03 00 00 00       	call   80109d84 <switchkvm>
}
80109d81:	90                   	nop
80109d82:	c9                   	leave  
80109d83:	c3                   	ret    

80109d84 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80109d84:	f3 0f 1e fb          	endbr32 
80109d88:	55                   	push   %ebp
80109d89:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80109d8b:	a1 b8 95 11 80       	mov    0x801195b8,%eax
80109d90:	50                   	push   %eax
80109d91:	e8 51 f9 ff ff       	call   801096e7 <v2p>
80109d96:	83 c4 04             	add    $0x4,%esp
80109d99:	50                   	push   %eax
80109d9a:	e8 3c f9 ff ff       	call   801096db <lcr3>
80109d9f:	83 c4 04             	add    $0x4,%esp
}
80109da2:	90                   	nop
80109da3:	c9                   	leave  
80109da4:	c3                   	ret    

80109da5 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80109da5:	f3 0f 1e fb          	endbr32 
80109da9:	55                   	push   %ebp
80109daa:	89 e5                	mov    %esp,%ebp
80109dac:	56                   	push   %esi
80109dad:	53                   	push   %ebx
  pushcli();
80109dae:	e8 ca cf ff ff       	call   80106d7d <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80109db3:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80109db9:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80109dc0:	83 c2 08             	add    $0x8,%edx
80109dc3:	89 d6                	mov    %edx,%esi
80109dc5:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80109dcc:	83 c2 08             	add    $0x8,%edx
80109dcf:	c1 ea 10             	shr    $0x10,%edx
80109dd2:	89 d3                	mov    %edx,%ebx
80109dd4:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80109ddb:	83 c2 08             	add    $0x8,%edx
80109dde:	c1 ea 18             	shr    $0x18,%edx
80109de1:	89 d1                	mov    %edx,%ecx
80109de3:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80109dea:	67 00 
80109dec:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80109df3:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80109df9:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80109e00:	83 e2 f0             	and    $0xfffffff0,%edx
80109e03:	83 ca 09             	or     $0x9,%edx
80109e06:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80109e0c:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80109e13:	83 ca 10             	or     $0x10,%edx
80109e16:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80109e1c:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80109e23:	83 e2 9f             	and    $0xffffff9f,%edx
80109e26:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80109e2c:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80109e33:	83 ca 80             	or     $0xffffff80,%edx
80109e36:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80109e3c:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80109e43:	83 e2 f0             	and    $0xfffffff0,%edx
80109e46:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80109e4c:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80109e53:	83 e2 ef             	and    $0xffffffef,%edx
80109e56:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80109e5c:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80109e63:	83 e2 df             	and    $0xffffffdf,%edx
80109e66:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80109e6c:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80109e73:	83 ca 40             	or     $0x40,%edx
80109e76:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80109e7c:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80109e83:	83 e2 7f             	and    $0x7f,%edx
80109e86:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80109e8c:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80109e92:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80109e98:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80109e9f:	83 e2 ef             	and    $0xffffffef,%edx
80109ea2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80109ea8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80109eae:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80109eb4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80109eba:	8b 40 08             	mov    0x8(%eax),%eax
80109ebd:	89 c2                	mov    %eax,%edx
80109ebf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80109ec5:	81 c2 00 10 00 00    	add    $0x1000,%edx
80109ecb:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80109ece:	83 ec 0c             	sub    $0xc,%esp
80109ed1:	6a 30                	push   $0x30
80109ed3:	e8 d6 f7 ff ff       	call   801096ae <ltr>
80109ed8:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80109edb:	8b 45 08             	mov    0x8(%ebp),%eax
80109ede:	8b 40 04             	mov    0x4(%eax),%eax
80109ee1:	85 c0                	test   %eax,%eax
80109ee3:	75 0d                	jne    80109ef2 <switchuvm+0x14d>
    panic("switchuvm: no pgdir");
80109ee5:	83 ec 0c             	sub    $0xc,%esp
80109ee8:	68 73 b2 10 80       	push   $0x8010b273
80109eed:	e8 a5 66 ff ff       	call   80100597 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80109ef2:	8b 45 08             	mov    0x8(%ebp),%eax
80109ef5:	8b 40 04             	mov    0x4(%eax),%eax
80109ef8:	83 ec 0c             	sub    $0xc,%esp
80109efb:	50                   	push   %eax
80109efc:	e8 e6 f7 ff ff       	call   801096e7 <v2p>
80109f01:	83 c4 10             	add    $0x10,%esp
80109f04:	83 ec 0c             	sub    $0xc,%esp
80109f07:	50                   	push   %eax
80109f08:	e8 ce f7 ff ff       	call   801096db <lcr3>
80109f0d:	83 c4 10             	add    $0x10,%esp
  popcli();
80109f10:	e8 b1 ce ff ff       	call   80106dc6 <popcli>
}
80109f15:	90                   	nop
80109f16:	8d 65 f8             	lea    -0x8(%ebp),%esp
80109f19:	5b                   	pop    %ebx
80109f1a:	5e                   	pop    %esi
80109f1b:	5d                   	pop    %ebp
80109f1c:	c3                   	ret    

80109f1d <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80109f1d:	f3 0f 1e fb          	endbr32 
80109f21:	55                   	push   %ebp
80109f22:	89 e5                	mov    %esp,%ebp
80109f24:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80109f27:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80109f2e:	76 0d                	jbe    80109f3d <inituvm+0x20>
    panic("inituvm: more than a page");
80109f30:	83 ec 0c             	sub    $0xc,%esp
80109f33:	68 87 b2 10 80       	push   $0x8010b287
80109f38:	e8 5a 66 ff ff       	call   80100597 <panic>
  mem = kalloc();
80109f3d:	e8 7e 90 ff ff       	call   80102fc0 <kalloc>
80109f42:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80109f45:	83 ec 04             	sub    $0x4,%esp
80109f48:	68 00 10 00 00       	push   $0x1000
80109f4d:	6a 00                	push   $0x0
80109f4f:	ff 75 f4             	pushl  -0xc(%ebp)
80109f52:	e8 34 cf ff ff       	call   80106e8b <memset>
80109f57:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80109f5a:	83 ec 0c             	sub    $0xc,%esp
80109f5d:	ff 75 f4             	pushl  -0xc(%ebp)
80109f60:	e8 82 f7 ff ff       	call   801096e7 <v2p>
80109f65:	83 c4 10             	add    $0x10,%esp
80109f68:	83 ec 0c             	sub    $0xc,%esp
80109f6b:	6a 06                	push   $0x6
80109f6d:	50                   	push   %eax
80109f6e:	68 00 10 00 00       	push   $0x1000
80109f73:	6a 00                	push   $0x0
80109f75:	ff 75 08             	pushl  0x8(%ebp)
80109f78:	e8 a1 fc ff ff       	call   80109c1e <mappages>
80109f7d:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80109f80:	83 ec 04             	sub    $0x4,%esp
80109f83:	ff 75 10             	pushl  0x10(%ebp)
80109f86:	ff 75 0c             	pushl  0xc(%ebp)
80109f89:	ff 75 f4             	pushl  -0xc(%ebp)
80109f8c:	e8 c1 cf ff ff       	call   80106f52 <memmove>
80109f91:	83 c4 10             	add    $0x10,%esp
}
80109f94:	90                   	nop
80109f95:	c9                   	leave  
80109f96:	c3                   	ret    

80109f97 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80109f97:	f3 0f 1e fb          	endbr32 
80109f9b:	55                   	push   %ebp
80109f9c:	89 e5                	mov    %esp,%ebp
80109f9e:	53                   	push   %ebx
80109f9f:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80109fa2:	8b 45 0c             	mov    0xc(%ebp),%eax
80109fa5:	25 ff 0f 00 00       	and    $0xfff,%eax
80109faa:	85 c0                	test   %eax,%eax
80109fac:	74 0d                	je     80109fbb <loaduvm+0x24>
    panic("loaduvm: addr must be page aligned");
80109fae:	83 ec 0c             	sub    $0xc,%esp
80109fb1:	68 a4 b2 10 80       	push   $0x8010b2a4
80109fb6:	e8 dc 65 ff ff       	call   80100597 <panic>
  for(i = 0; i < sz; i += PGSIZE){
80109fbb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80109fc2:	e9 95 00 00 00       	jmp    8010a05c <loaduvm+0xc5>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80109fc7:	8b 55 0c             	mov    0xc(%ebp),%edx
80109fca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109fcd:	01 d0                	add    %edx,%eax
80109fcf:	83 ec 04             	sub    $0x4,%esp
80109fd2:	6a 00                	push   $0x0
80109fd4:	50                   	push   %eax
80109fd5:	ff 75 08             	pushl  0x8(%ebp)
80109fd8:	e8 9d fb ff ff       	call   80109b7a <walkpgdir>
80109fdd:	83 c4 10             	add    $0x10,%esp
80109fe0:	89 45 ec             	mov    %eax,-0x14(%ebp)
80109fe3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80109fe7:	75 0d                	jne    80109ff6 <loaduvm+0x5f>
      panic("loaduvm: address should exist");
80109fe9:	83 ec 0c             	sub    $0xc,%esp
80109fec:	68 c7 b2 10 80       	push   $0x8010b2c7
80109ff1:	e8 a1 65 ff ff       	call   80100597 <panic>
    pa = PTE_ADDR(*pte);
80109ff6:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109ff9:	8b 00                	mov    (%eax),%eax
80109ffb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010a000:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
8010a003:	8b 45 18             	mov    0x18(%ebp),%eax
8010a006:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010a009:	3d ff 0f 00 00       	cmp    $0xfff,%eax
8010a00e:	77 0b                	ja     8010a01b <loaduvm+0x84>
      n = sz - i;
8010a010:	8b 45 18             	mov    0x18(%ebp),%eax
8010a013:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010a016:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010a019:	eb 07                	jmp    8010a022 <loaduvm+0x8b>
    else
      n = PGSIZE;
8010a01b:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
8010a022:	8b 55 14             	mov    0x14(%ebp),%edx
8010a025:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a028:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
8010a02b:	83 ec 0c             	sub    $0xc,%esp
8010a02e:	ff 75 e8             	pushl  -0x18(%ebp)
8010a031:	e8 be f6 ff ff       	call   801096f4 <p2v>
8010a036:	83 c4 10             	add    $0x10,%esp
8010a039:	ff 75 f0             	pushl  -0x10(%ebp)
8010a03c:	53                   	push   %ebx
8010a03d:	50                   	push   %eax
8010a03e:	ff 75 10             	pushl  0x10(%ebp)
8010a041:	e8 09 81 ff ff       	call   8010214f <readi>
8010a046:	83 c4 10             	add    $0x10,%esp
8010a049:	39 45 f0             	cmp    %eax,-0x10(%ebp)
8010a04c:	74 07                	je     8010a055 <loaduvm+0xbe>
      return -1;
8010a04e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a053:	eb 18                	jmp    8010a06d <loaduvm+0xd6>
  for(i = 0; i < sz; i += PGSIZE){
8010a055:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010a05c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a05f:	3b 45 18             	cmp    0x18(%ebp),%eax
8010a062:	0f 82 5f ff ff ff    	jb     80109fc7 <loaduvm+0x30>
  }
  return 0;
8010a068:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a06d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010a070:	c9                   	leave  
8010a071:	c3                   	ret    

8010a072 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010a072:	f3 0f 1e fb          	endbr32 
8010a076:	55                   	push   %ebp
8010a077:	89 e5                	mov    %esp,%ebp
8010a079:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010a07c:	8b 45 10             	mov    0x10(%ebp),%eax
8010a07f:	85 c0                	test   %eax,%eax
8010a081:	79 0a                	jns    8010a08d <allocuvm+0x1b>
    return 0;
8010a083:	b8 00 00 00 00       	mov    $0x0,%eax
8010a088:	e9 ae 00 00 00       	jmp    8010a13b <allocuvm+0xc9>
  if(newsz < oldsz)
8010a08d:	8b 45 10             	mov    0x10(%ebp),%eax
8010a090:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010a093:	73 08                	jae    8010a09d <allocuvm+0x2b>
    return oldsz;
8010a095:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a098:	e9 9e 00 00 00       	jmp    8010a13b <allocuvm+0xc9>

  a = PGROUNDUP(oldsz);
8010a09d:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a0a0:	05 ff 0f 00 00       	add    $0xfff,%eax
8010a0a5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010a0aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
8010a0ad:	eb 7d                	jmp    8010a12c <allocuvm+0xba>
    mem = kalloc();
8010a0af:	e8 0c 8f ff ff       	call   80102fc0 <kalloc>
8010a0b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
8010a0b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010a0bb:	75 2b                	jne    8010a0e8 <allocuvm+0x76>
      cprintf("allocuvm out of memory\n");
8010a0bd:	83 ec 0c             	sub    $0xc,%esp
8010a0c0:	68 e5 b2 10 80       	push   $0x8010b2e5
8010a0c5:	e8 14 63 ff ff       	call   801003de <cprintf>
8010a0ca:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
8010a0cd:	83 ec 04             	sub    $0x4,%esp
8010a0d0:	ff 75 0c             	pushl  0xc(%ebp)
8010a0d3:	ff 75 10             	pushl  0x10(%ebp)
8010a0d6:	ff 75 08             	pushl  0x8(%ebp)
8010a0d9:	e8 5f 00 00 00       	call   8010a13d <deallocuvm>
8010a0de:	83 c4 10             	add    $0x10,%esp
      return 0;
8010a0e1:	b8 00 00 00 00       	mov    $0x0,%eax
8010a0e6:	eb 53                	jmp    8010a13b <allocuvm+0xc9>
    }
    memset(mem, 0, PGSIZE);
8010a0e8:	83 ec 04             	sub    $0x4,%esp
8010a0eb:	68 00 10 00 00       	push   $0x1000
8010a0f0:	6a 00                	push   $0x0
8010a0f2:	ff 75 f0             	pushl  -0x10(%ebp)
8010a0f5:	e8 91 cd ff ff       	call   80106e8b <memset>
8010a0fa:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
8010a0fd:	83 ec 0c             	sub    $0xc,%esp
8010a100:	ff 75 f0             	pushl  -0x10(%ebp)
8010a103:	e8 df f5 ff ff       	call   801096e7 <v2p>
8010a108:	83 c4 10             	add    $0x10,%esp
8010a10b:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a10e:	83 ec 0c             	sub    $0xc,%esp
8010a111:	6a 06                	push   $0x6
8010a113:	50                   	push   %eax
8010a114:	68 00 10 00 00       	push   $0x1000
8010a119:	52                   	push   %edx
8010a11a:	ff 75 08             	pushl  0x8(%ebp)
8010a11d:	e8 fc fa ff ff       	call   80109c1e <mappages>
8010a122:	83 c4 20             	add    $0x20,%esp
  for(; a < newsz; a += PGSIZE){
8010a125:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010a12c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a12f:	3b 45 10             	cmp    0x10(%ebp),%eax
8010a132:	0f 82 77 ff ff ff    	jb     8010a0af <allocuvm+0x3d>
  }
  return newsz;
8010a138:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010a13b:	c9                   	leave  
8010a13c:	c3                   	ret    

8010a13d <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010a13d:	f3 0f 1e fb          	endbr32 
8010a141:	55                   	push   %ebp
8010a142:	89 e5                	mov    %esp,%ebp
8010a144:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010a147:	8b 45 10             	mov    0x10(%ebp),%eax
8010a14a:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010a14d:	72 08                	jb     8010a157 <deallocuvm+0x1a>
    return oldsz;
8010a14f:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a152:	e9 a5 00 00 00       	jmp    8010a1fc <deallocuvm+0xbf>

  a = PGROUNDUP(newsz);
8010a157:	8b 45 10             	mov    0x10(%ebp),%eax
8010a15a:	05 ff 0f 00 00       	add    $0xfff,%eax
8010a15f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010a164:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010a167:	e9 81 00 00 00       	jmp    8010a1ed <deallocuvm+0xb0>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010a16c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a16f:	83 ec 04             	sub    $0x4,%esp
8010a172:	6a 00                	push   $0x0
8010a174:	50                   	push   %eax
8010a175:	ff 75 08             	pushl  0x8(%ebp)
8010a178:	e8 fd f9 ff ff       	call   80109b7a <walkpgdir>
8010a17d:	83 c4 10             	add    $0x10,%esp
8010a180:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
8010a183:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010a187:	75 09                	jne    8010a192 <deallocuvm+0x55>
      a += (NPTENTRIES - 1) * PGSIZE;
8010a189:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
8010a190:	eb 54                	jmp    8010a1e6 <deallocuvm+0xa9>
    else if((*pte & PTE_P) != 0){
8010a192:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a195:	8b 00                	mov    (%eax),%eax
8010a197:	83 e0 01             	and    $0x1,%eax
8010a19a:	85 c0                	test   %eax,%eax
8010a19c:	74 48                	je     8010a1e6 <deallocuvm+0xa9>
      pa = PTE_ADDR(*pte);
8010a19e:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a1a1:	8b 00                	mov    (%eax),%eax
8010a1a3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010a1a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
8010a1ab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010a1af:	75 0d                	jne    8010a1be <deallocuvm+0x81>
        panic("kfree");
8010a1b1:	83 ec 0c             	sub    $0xc,%esp
8010a1b4:	68 fd b2 10 80       	push   $0x8010b2fd
8010a1b9:	e8 d9 63 ff ff       	call   80100597 <panic>
      char *v = p2v(pa);
8010a1be:	83 ec 0c             	sub    $0xc,%esp
8010a1c1:	ff 75 ec             	pushl  -0x14(%ebp)
8010a1c4:	e8 2b f5 ff ff       	call   801096f4 <p2v>
8010a1c9:	83 c4 10             	add    $0x10,%esp
8010a1cc:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
8010a1cf:	83 ec 0c             	sub    $0xc,%esp
8010a1d2:	ff 75 e8             	pushl  -0x18(%ebp)
8010a1d5:	e8 45 8d ff ff       	call   80102f1f <kfree>
8010a1da:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
8010a1dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a1e0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
8010a1e6:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010a1ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a1f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010a1f3:	0f 82 73 ff ff ff    	jb     8010a16c <deallocuvm+0x2f>
    }
  }
  return newsz;
8010a1f9:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010a1fc:	c9                   	leave  
8010a1fd:	c3                   	ret    

8010a1fe <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
8010a1fe:	f3 0f 1e fb          	endbr32 
8010a202:	55                   	push   %ebp
8010a203:	89 e5                	mov    %esp,%ebp
8010a205:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
8010a208:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010a20c:	75 0d                	jne    8010a21b <freevm+0x1d>
    panic("freevm: no pgdir");
8010a20e:	83 ec 0c             	sub    $0xc,%esp
8010a211:	68 03 b3 10 80       	push   $0x8010b303
8010a216:	e8 7c 63 ff ff       	call   80100597 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
8010a21b:	83 ec 04             	sub    $0x4,%esp
8010a21e:	6a 00                	push   $0x0
8010a220:	68 00 00 00 80       	push   $0x80000000
8010a225:	ff 75 08             	pushl  0x8(%ebp)
8010a228:	e8 10 ff ff ff       	call   8010a13d <deallocuvm>
8010a22d:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010a230:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a237:	eb 4f                	jmp    8010a288 <freevm+0x8a>
    if(pgdir[i] & PTE_P){
8010a239:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a23c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010a243:	8b 45 08             	mov    0x8(%ebp),%eax
8010a246:	01 d0                	add    %edx,%eax
8010a248:	8b 00                	mov    (%eax),%eax
8010a24a:	83 e0 01             	and    $0x1,%eax
8010a24d:	85 c0                	test   %eax,%eax
8010a24f:	74 33                	je     8010a284 <freevm+0x86>
      char * v = p2v(PTE_ADDR(pgdir[i]));
8010a251:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a254:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010a25b:	8b 45 08             	mov    0x8(%ebp),%eax
8010a25e:	01 d0                	add    %edx,%eax
8010a260:	8b 00                	mov    (%eax),%eax
8010a262:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010a267:	83 ec 0c             	sub    $0xc,%esp
8010a26a:	50                   	push   %eax
8010a26b:	e8 84 f4 ff ff       	call   801096f4 <p2v>
8010a270:	83 c4 10             	add    $0x10,%esp
8010a273:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
8010a276:	83 ec 0c             	sub    $0xc,%esp
8010a279:	ff 75 f0             	pushl  -0x10(%ebp)
8010a27c:	e8 9e 8c ff ff       	call   80102f1f <kfree>
8010a281:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010a284:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010a288:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
8010a28f:	76 a8                	jbe    8010a239 <freevm+0x3b>
    }
  }
  kfree((char*)pgdir);
8010a291:	83 ec 0c             	sub    $0xc,%esp
8010a294:	ff 75 08             	pushl  0x8(%ebp)
8010a297:	e8 83 8c ff ff       	call   80102f1f <kfree>
8010a29c:	83 c4 10             	add    $0x10,%esp
}
8010a29f:	90                   	nop
8010a2a0:	c9                   	leave  
8010a2a1:	c3                   	ret    

8010a2a2 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
8010a2a2:	f3 0f 1e fb          	endbr32 
8010a2a6:	55                   	push   %ebp
8010a2a7:	89 e5                	mov    %esp,%ebp
8010a2a9:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010a2ac:	83 ec 04             	sub    $0x4,%esp
8010a2af:	6a 00                	push   $0x0
8010a2b1:	ff 75 0c             	pushl  0xc(%ebp)
8010a2b4:	ff 75 08             	pushl  0x8(%ebp)
8010a2b7:	e8 be f8 ff ff       	call   80109b7a <walkpgdir>
8010a2bc:	83 c4 10             	add    $0x10,%esp
8010a2bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
8010a2c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010a2c6:	75 0d                	jne    8010a2d5 <clearpteu+0x33>
    panic("clearpteu");
8010a2c8:	83 ec 0c             	sub    $0xc,%esp
8010a2cb:	68 14 b3 10 80       	push   $0x8010b314
8010a2d0:	e8 c2 62 ff ff       	call   80100597 <panic>
  *pte &= ~PTE_U;
8010a2d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a2d8:	8b 00                	mov    (%eax),%eax
8010a2da:	83 e0 fb             	and    $0xfffffffb,%eax
8010a2dd:	89 c2                	mov    %eax,%edx
8010a2df:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a2e2:	89 10                	mov    %edx,(%eax)
}
8010a2e4:	90                   	nop
8010a2e5:	c9                   	leave  
8010a2e6:	c3                   	ret    

8010a2e7 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
8010a2e7:	f3 0f 1e fb          	endbr32 
8010a2eb:	55                   	push   %ebp
8010a2ec:	89 e5                	mov    %esp,%ebp
8010a2ee:	53                   	push   %ebx
8010a2ef:	83 ec 24             	sub    $0x24,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010a2f2:	e8 bb f9 ff ff       	call   80109cb2 <setupkvm>
8010a2f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010a2fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010a2fe:	75 0a                	jne    8010a30a <copyuvm+0x23>
    return 0;
8010a300:	b8 00 00 00 00       	mov    $0x0,%eax
8010a305:	e9 f6 00 00 00       	jmp    8010a400 <copyuvm+0x119>
  for(i = 0; i < sz; i += PGSIZE){
8010a30a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010a311:	e9 c2 00 00 00       	jmp    8010a3d8 <copyuvm+0xf1>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
8010a316:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a319:	83 ec 04             	sub    $0x4,%esp
8010a31c:	6a 00                	push   $0x0
8010a31e:	50                   	push   %eax
8010a31f:	ff 75 08             	pushl  0x8(%ebp)
8010a322:	e8 53 f8 ff ff       	call   80109b7a <walkpgdir>
8010a327:	83 c4 10             	add    $0x10,%esp
8010a32a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010a32d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010a331:	75 0d                	jne    8010a340 <copyuvm+0x59>
      panic("copyuvm: pte should exist");
8010a333:	83 ec 0c             	sub    $0xc,%esp
8010a336:	68 1e b3 10 80       	push   $0x8010b31e
8010a33b:	e8 57 62 ff ff       	call   80100597 <panic>
    if(!(*pte & PTE_P))
8010a340:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a343:	8b 00                	mov    (%eax),%eax
8010a345:	83 e0 01             	and    $0x1,%eax
8010a348:	85 c0                	test   %eax,%eax
8010a34a:	75 0d                	jne    8010a359 <copyuvm+0x72>
      panic("copyuvm: page not present");
8010a34c:	83 ec 0c             	sub    $0xc,%esp
8010a34f:	68 38 b3 10 80       	push   $0x8010b338
8010a354:	e8 3e 62 ff ff       	call   80100597 <panic>
    pa = PTE_ADDR(*pte);
8010a359:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a35c:	8b 00                	mov    (%eax),%eax
8010a35e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010a363:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
8010a366:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a369:	8b 00                	mov    (%eax),%eax
8010a36b:	25 ff 0f 00 00       	and    $0xfff,%eax
8010a370:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
8010a373:	e8 48 8c ff ff       	call   80102fc0 <kalloc>
8010a378:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010a37b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010a37f:	74 68                	je     8010a3e9 <copyuvm+0x102>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
8010a381:	83 ec 0c             	sub    $0xc,%esp
8010a384:	ff 75 e8             	pushl  -0x18(%ebp)
8010a387:	e8 68 f3 ff ff       	call   801096f4 <p2v>
8010a38c:	83 c4 10             	add    $0x10,%esp
8010a38f:	83 ec 04             	sub    $0x4,%esp
8010a392:	68 00 10 00 00       	push   $0x1000
8010a397:	50                   	push   %eax
8010a398:	ff 75 e0             	pushl  -0x20(%ebp)
8010a39b:	e8 b2 cb ff ff       	call   80106f52 <memmove>
8010a3a0:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
8010a3a3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010a3a6:	83 ec 0c             	sub    $0xc,%esp
8010a3a9:	ff 75 e0             	pushl  -0x20(%ebp)
8010a3ac:	e8 36 f3 ff ff       	call   801096e7 <v2p>
8010a3b1:	83 c4 10             	add    $0x10,%esp
8010a3b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010a3b7:	83 ec 0c             	sub    $0xc,%esp
8010a3ba:	53                   	push   %ebx
8010a3bb:	50                   	push   %eax
8010a3bc:	68 00 10 00 00       	push   $0x1000
8010a3c1:	52                   	push   %edx
8010a3c2:	ff 75 f0             	pushl  -0x10(%ebp)
8010a3c5:	e8 54 f8 ff ff       	call   80109c1e <mappages>
8010a3ca:	83 c4 20             	add    $0x20,%esp
8010a3cd:	85 c0                	test   %eax,%eax
8010a3cf:	78 1b                	js     8010a3ec <copyuvm+0x105>
  for(i = 0; i < sz; i += PGSIZE){
8010a3d1:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010a3d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a3db:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010a3de:	0f 82 32 ff ff ff    	jb     8010a316 <copyuvm+0x2f>
      goto bad;
  }
  return d;
8010a3e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a3e7:	eb 17                	jmp    8010a400 <copyuvm+0x119>
      goto bad;
8010a3e9:	90                   	nop
8010a3ea:	eb 01                	jmp    8010a3ed <copyuvm+0x106>
      goto bad;
8010a3ec:	90                   	nop

bad:
  freevm(d);
8010a3ed:	83 ec 0c             	sub    $0xc,%esp
8010a3f0:	ff 75 f0             	pushl  -0x10(%ebp)
8010a3f3:	e8 06 fe ff ff       	call   8010a1fe <freevm>
8010a3f8:	83 c4 10             	add    $0x10,%esp
  return 0;
8010a3fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a400:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010a403:	c9                   	leave  
8010a404:	c3                   	ret    

8010a405 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
8010a405:	f3 0f 1e fb          	endbr32 
8010a409:	55                   	push   %ebp
8010a40a:	89 e5                	mov    %esp,%ebp
8010a40c:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010a40f:	83 ec 04             	sub    $0x4,%esp
8010a412:	6a 00                	push   $0x0
8010a414:	ff 75 0c             	pushl  0xc(%ebp)
8010a417:	ff 75 08             	pushl  0x8(%ebp)
8010a41a:	e8 5b f7 ff ff       	call   80109b7a <walkpgdir>
8010a41f:	83 c4 10             	add    $0x10,%esp
8010a422:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
8010a425:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a428:	8b 00                	mov    (%eax),%eax
8010a42a:	83 e0 01             	and    $0x1,%eax
8010a42d:	85 c0                	test   %eax,%eax
8010a42f:	75 07                	jne    8010a438 <uva2ka+0x33>
    return 0;
8010a431:	b8 00 00 00 00       	mov    $0x0,%eax
8010a436:	eb 2a                	jmp    8010a462 <uva2ka+0x5d>
  if((*pte & PTE_U) == 0)
8010a438:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a43b:	8b 00                	mov    (%eax),%eax
8010a43d:	83 e0 04             	and    $0x4,%eax
8010a440:	85 c0                	test   %eax,%eax
8010a442:	75 07                	jne    8010a44b <uva2ka+0x46>
    return 0;
8010a444:	b8 00 00 00 00       	mov    $0x0,%eax
8010a449:	eb 17                	jmp    8010a462 <uva2ka+0x5d>
  return (char*)p2v(PTE_ADDR(*pte));
8010a44b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010a44e:	8b 00                	mov    (%eax),%eax
8010a450:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010a455:	83 ec 0c             	sub    $0xc,%esp
8010a458:	50                   	push   %eax
8010a459:	e8 96 f2 ff ff       	call   801096f4 <p2v>
8010a45e:	83 c4 10             	add    $0x10,%esp
8010a461:	90                   	nop
}
8010a462:	c9                   	leave  
8010a463:	c3                   	ret    

8010a464 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
8010a464:	f3 0f 1e fb          	endbr32 
8010a468:	55                   	push   %ebp
8010a469:	89 e5                	mov    %esp,%ebp
8010a46b:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
8010a46e:	8b 45 10             	mov    0x10(%ebp),%eax
8010a471:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
8010a474:	eb 7f                	jmp    8010a4f5 <copyout+0x91>
    va0 = (uint)PGROUNDDOWN(va);
8010a476:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a479:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010a47e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
8010a481:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a484:	83 ec 08             	sub    $0x8,%esp
8010a487:	50                   	push   %eax
8010a488:	ff 75 08             	pushl  0x8(%ebp)
8010a48b:	e8 75 ff ff ff       	call   8010a405 <uva2ka>
8010a490:	83 c4 10             	add    $0x10,%esp
8010a493:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
8010a496:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010a49a:	75 07                	jne    8010a4a3 <copyout+0x3f>
      return -1;
8010a49c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010a4a1:	eb 61                	jmp    8010a504 <copyout+0xa0>
    n = PGSIZE - (va - va0);
8010a4a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a4a6:	2b 45 0c             	sub    0xc(%ebp),%eax
8010a4a9:	05 00 10 00 00       	add    $0x1000,%eax
8010a4ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
8010a4b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a4b4:	3b 45 14             	cmp    0x14(%ebp),%eax
8010a4b7:	76 06                	jbe    8010a4bf <copyout+0x5b>
      n = len;
8010a4b9:	8b 45 14             	mov    0x14(%ebp),%eax
8010a4bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
8010a4bf:	8b 45 0c             	mov    0xc(%ebp),%eax
8010a4c2:	2b 45 ec             	sub    -0x14(%ebp),%eax
8010a4c5:	89 c2                	mov    %eax,%edx
8010a4c7:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010a4ca:	01 d0                	add    %edx,%eax
8010a4cc:	83 ec 04             	sub    $0x4,%esp
8010a4cf:	ff 75 f0             	pushl  -0x10(%ebp)
8010a4d2:	ff 75 f4             	pushl  -0xc(%ebp)
8010a4d5:	50                   	push   %eax
8010a4d6:	e8 77 ca ff ff       	call   80106f52 <memmove>
8010a4db:	83 c4 10             	add    $0x10,%esp
    len -= n;
8010a4de:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a4e1:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
8010a4e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010a4e7:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
8010a4ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010a4ed:	05 00 10 00 00       	add    $0x1000,%eax
8010a4f2:	89 45 0c             	mov    %eax,0xc(%ebp)
  while(len > 0){
8010a4f5:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010a4f9:	0f 85 77 ff ff ff    	jne    8010a476 <copyout+0x12>
  }
  return 0;
8010a4ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010a504:	c9                   	leave  
8010a505:	c3                   	ret    
