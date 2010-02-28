#ifndef _LINUX_ZENTUNE_H
#define _LINUX_ZENTUNE_H

#ifdef __KERNEL__

/* CPU Scheduler Related */
#ifdef CONFIG_SCHED_BFS

/* default */
#define rr_interval_default 6;
#define sched_iso_cpu_default 70;
/* server */
#define rr_interval_server rr_interval_default;
#define sched_iso_cpu_server sched_iso_cpu_default;
/* desktop */
#define rr_interval_desktop 3;
#define sched_iso_cpu_desktop 25;

#endif /* CONFIG_SCHED_BFS */

/* MM Related */

/* default */
#define vm_dirty_ratio_default 20;
#define dirty_background_ratio_default 10;
/* server */
#define vm_dirty_ratio_server 80;
#define dirty_background_ratio_server 1;
/* desktop */
#define vm_dirty_ratio_desktop 50;
#define dirty_background_ratio_desktop 20;

#endif /* __KERNEL__ */

#endif
