#ifdef BAGIAN_UPROC
#include "types.h"
#include "user.h"
#include "uproc.h"

void
elapsed(uint e)
{
    uint elapsed, whole_sec, milisec_ten, milisec_hund, milisec_thou;
    elapsed = e; // find original elapsed time
    whole_sec = elapsed / 1000; // the the left of the decimal point
    // % to shave off leading digit of elapsed for decimal place calcs
    milisec_ten = (elapsed %= 1000) / 100; // divide and round up to nearest int
    milisec_hund = (elapsed %= 100) / 10; // shave off previously counted int, repeat
    milisec_thou = (elapsed %= 10); // determine thousandth place
    printf(1, "\t%d.%d%d%d", whole_sec, milisec_ten, milisec_hund, milisec_thou);
}

int
main(void)
{
  int max = 32, active_procs = 0;
  struct uproc* utable = (struct uproc*) malloc(max * sizeof(struct uproc));
  // system call -> sysproc.c -> proc.c -> return
  active_procs = getprocs(max, utable); // populate utable
  // error from sysproc.c - value not pulled from stack
  if (active_procs == -1) {
      printf(1, "Error in active process table creation.\n");
      free(utable);
      exit();
  }
  // no active processes
  else if (active_procs == 0) {
      printf(1, "No active processes.\n");
      free(utable);
      exit();
  }
#ifndef BAGIAN_INODE
  // loop utable and print process information
  else if (active_procs > 0) {
      printf(1, "\n%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s",
              "PID", "Name", "UID", "GID", "PPID", "Elapsed", "CPU", "State", "Size");
      for (int i = 0; i < active_procs; ++i) {
          printf(1, "\n%d\t%s\t%d\t%d\t%d",
                  utable[i].pid, utable[i].name, utable[i].uid, utable[i].gid, utable[i].ppid);
          elapsed(utable[i].elapsed_ticks);
          elapsed(utable[i].CPU_total_ticks);
          printf(1, "\t%s\t%d", utable[i].state, utable[i].size);
      }
      printf(1, "\n");
  }
#else
  else if (active_procs > 0) {
      printf(1, "\n%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s",
              "PID", "Name", "UID", "GID", "PPID", "Prio", "Elapsed", "CPU", "State", "Size");
      for (int i = 0; i < active_procs; ++i) {
          printf(1, "\n%d\t%s\t%d\t%d\t%d\t%d",
                  utable[i].pid, utable[i].name, utable[i].uid, utable[i].gid, utable[i].ppid, utable[i].priority);
          elapsed(utable[i].elapsed_ticks);
          elapsed(utable[i].CPU_total_ticks);
          printf(1, "\t%s\t%d", utable[i].state, utable[i].size);
      }
      printf(1, "\n");
  }
#endif
  free(utable);
  exit();
}
#endif
