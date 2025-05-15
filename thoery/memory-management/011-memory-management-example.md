To visually understand how logical (virtual) addresses map to physical addresses in Linux, you can use the `/proc` filesystem, which provides detailed information about process memory mappings. Here's a step-by-step guide:

---

### 🧪 Step 1: Create a Simple C Program

Let's write a C program that allocates memory and prints the address of a variable:

```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    int *ptr = malloc(sizeof(int));
    *ptr = 42;
    printf("PID: %d\n", getpid());
    printf("Virtual address of ptr: %p\n", (void*)ptr);
    getchar(); // Wait for user input to keep the process running
    free(ptr);
    return 0;
}
```



Compile and run the program:

```bash
gcc -o mem_example mem_example.c
./mem_example
```



The program will display its Process ID (PID) and the virtual address of the allocated memory. It will then wait for user input, allowing you to inspect its memory mappings.

---

### 🔍 Step 2: Inspect Memory Mappings

While the program is running, open another terminal and use the `pmap` command to view the memory map of the process:

```bash
pmap -x <PID>
```



Replace `<PID>` with the actual Process ID displayed by the program. The `pmap` output will show the virtual memory regions allocated to the process, including their sizes and permissions.

For a more detailed view, you can examine the `/proc/<PID>/maps` file:([Unix & Linux Stack Exchange][1])

```bash
cat /proc/<PID>/maps
```



This file lists the memory regions with their start and end addresses, permissions, and associated files or libraries.

---

### 🧠 Understanding the Output

* **Virtual Address**: The addresses shown in the `pmap` and `/proc/<PID>/maps` outputs are virtual addresses used by the process.

* **Physical Address**: To map a virtual address to a physical address, you can use the `/proc/<PID>/pagemap` interface. However, interpreting this file requires parsing binary data and understanding the Linux pagemap format.([codentium.com][2])

For more information on accessing physical addresses from user space in Linux, you can refer to this Stack Overflow discussion:([Stack Overflow][3])

([Stack Overflow][4])

---

By following these steps, you can observe how a program's virtual addresses are mapped in memory, providing insight into the relationship between logical and physical addresses in a Linux environment.

[1]: https://unix.stackexchange.com/questions/624746/how-to-get-the-mapping-between-physical-and-virtual-memory-page-addresses-in-lin?utm_source=chatgpt.com "How to get the mapping between physical and virtual memory page ..."
[2]: https://codentium.com/accessing-physical-memory-from-userspace-on-linux/?utm_source=chatgpt.com "Accessing physical memory from userspace on Linux - Codentium"
[3]: https://stackoverflow.com/questions/12040303/how-to-access-physical-addresses-from-user-space-in-linux/45127890?utm_source=chatgpt.com "How to access physical addresses from user space in Linux?"
[4]: https://stackoverflow.com/questions/5748492/is-there-any-api-for-determining-the-physical-address-from-virtual-address-in-li?utm_source=chatgpt.com "Is there any API for determining the physical address from virtual ..."

```bash
dinesh-kanth: ~/GIT/multilang-codes/thoery/Memory-management
─❯ gcc -o mem_example mem_example.c ;./mem_example

PID: 695976
Virtual address of ptr: 0x56f1f3fa42a0


dinesh-kanth:  ~ 
─❯ pmap -x 695976

695976:   ./mem_example
Address           Kbytes     RSS   Dirty Mode  Mapping
000056f1e8327000       4       4       0 r---- mem_example
000056f1e8328000       4       4       0 r-x-- mem_example
000056f1e8329000       4       4       0 r---- mem_example
000056f1e832a000       4       4       4 r---- mem_example
000056f1e832b000       4       4       4 rw--- mem_example
000056f1f3fa4000     132       4       4 rw---   [ anon ]
0000738653c00000     160     156       0 r---- libc.so.6
0000738653c28000    1568     984       0 r-x-- libc.so.6
0000738653db0000     316      64       0 r---- libc.so.6
0000738653dff000      16      16      16 r---- libc.so.6
0000738653e03000       8       8       8 rw--- libc.so.6
0000738653e05000      52      20      20 rw---   [ anon ]
0000738653e42000      12       8       8 rw---   [ anon ]
0000738653e60000       8       4       4 rw---   [ anon ]
0000738653e62000       4       4       0 r---- ld-linux-x86-64.so.2
0000738653e63000     172     172       0 r-x-- ld-linux-x86-64.so.2
0000738653e8e000      40      40       0 r---- ld-linux-x86-64.so.2
0000738653e98000       8       8       8 r---- ld-linux-x86-64.so.2
0000738653e9a000       8       8       8 rw--- ld-linux-x86-64.so.2
00007ffc624ad000     132      12      12 rw---   [ stack ]
00007ffc624eb000      16       0       0 r----   [ anon ]
00007ffc624ef000       8       4       0 r-x--   [ anon ]
ffffffffff600000       4       0       0 --x--   [ anon ]
---------------- ------- ------- ------- 
total kB            2684    1532      96
dinesh-kanth:  ~ 
─❯ cat /proc/695976/maps

56f1e8327000-56f1e8328000 r--p 00000000 103:06 1859560                   /home/dinesh-kanth/GIT/multilang-codes/thoery/Memory-management/mem_example
56f1e8328000-56f1e8329000 r-xp 00001000 103:06 1859560                   /home/dinesh-kanth/GIT/multilang-codes/thoery/Memory-management/mem_example
56f1e8329000-56f1e832a000 r--p 00002000 103:06 1859560                   /home/dinesh-kanth/GIT/multilang-codes/thoery/Memory-management/mem_example
56f1e832a000-56f1e832b000 r--p 00002000 103:06 1859560                   /home/dinesh-kanth/GIT/multilang-codes/thoery/Memory-management/mem_example
56f1e832b000-56f1e832c000 rw-p 00003000 103:06 1859560                   /home/dinesh-kanth/GIT/multilang-codes/thoery/Memory-management/mem_example
56f1f3fa4000-56f1f3fc5000 rw-p 00000000 00:00 0                          [heap]
738653c00000-738653c28000 r--p 00000000 103:06 820291                    /usr/lib/x86_64-linux-gnu/libc.so.6
738653c28000-738653db0000 r-xp 00028000 103:06 820291                    /usr/lib/x86_64-linux-gnu/libc.so.6
738653db0000-738653dff000 r--p 001b0000 103:06 820291                    /usr/lib/x86_64-linux-gnu/libc.so.6
738653dff000-738653e03000 r--p 001fe000 103:06 820291                    /usr/lib/x86_64-linux-gnu/libc.so.6
738653e03000-738653e05000 rw-p 00202000 103:06 820291                    /usr/lib/x86_64-linux-gnu/libc.so.6
738653e05000-738653e12000 rw-p 00000000 00:00 0 
738653e42000-738653e45000 rw-p 00000000 00:00 0 
738653e60000-738653e62000 rw-p 00000000 00:00 0 
738653e62000-738653e63000 r--p 00000000 103:06 820288                    /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
738653e63000-738653e8e000 r-xp 00001000 103:06 820288                    /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
738653e8e000-738653e98000 r--p 0002c000 103:06 820288                    /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
738653e98000-738653e9a000 r--p 00036000 103:06 820288                    /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
738653e9a000-738653e9c000 rw-p 00038000 103:06 820288                    /usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
7ffc624ad000-7ffc624ce000 rw-p 00000000 00:00 0                          [stack]
7ffc624eb000-7ffc624ef000 r--p 00000000 00:00 0                          [vvar]
7ffc624ef000-7ffc624f1000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]
 dinesh-kanth:   ~ 

```
