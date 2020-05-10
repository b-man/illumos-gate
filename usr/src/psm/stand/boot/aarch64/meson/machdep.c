/*
 * CDDL HEADER START
 *
 * The contents of this file are subject to the terms of the
 * Common Development and Distribution License (the "License").
 * You may not use this file except in compliance with the License.
 *
 * You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
 * or http://www.opensolaris.org/os/licensing.
 * See the License for the specific language governing permissions
 * and limitations under the License.
 *
 * When distributing Covered Code, include this CDDL HEADER in each
 * file and include the License file at usr/src/OPENSOLARIS.LICENSE.
 * If applicable, add the following below this CDDL HEADER, with the
 * fields enclosed by brackets "[]" replaced with your own identifying
 * information: Portions Copyright [yyyy] [name of copyright owner]
 *
 * CDDL HEADER END
 */
/*
 * Copyright 2017 Hayashi Naoyuki
 * Copyright 2010 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */

#include <sys/types.h>
#include <sys/param.h>
#include <sys/promif.h>
#include <sys/salib.h>
#include <sys/bootconf.h>
#include <sys/boot.h>
#include <sys/bootinfo.h>
#include <sys/sysmacros.h>
#include <sys/machparam.h>
#include <sys/memlist.h>
#include <sys/memlist_impl.h>
#include <sys/controlregs.h>
#include <sys/saio.h>
#include <sys/bootsyms.h>
#include <sys/fcntl.h>
#include <sys/platform.h>
#include <sys/platnames.h>
#include <alloca.h>
#include <netinet/inetutil.h>
#include <sys/bootvfs.h>
#include <sys/psci.h>
#include <sys/gxbb_smc.h>
#include "ramdisk.h"
#include "dwmac.h"
#include "boot_plat.h"
#include "mmc.h"

extern char _BootScratch[];
extern char _RamdiskStart[];
extern char _RamdiskStart[];
extern char _RamdiskEnd[];
extern char filename[];
static struct xboot_info xboot_info;
static char zfs_bootfs[256];
char v2args_buf[V2ARGS_BUF_SZ];
char *v2args = v2args_buf;
extern char *bootp_response;

extern	int (*readfile(int fd, int print))();
extern	void kmem_init(void);
extern	void *kmem_alloc(size_t, int);
extern	void kmem_free(void *, size_t);
extern	void get_boot_args(char *buf);
extern	void setup_bootops(void);
extern	struct	bootops bootops;
extern	void exitto(int (*entrypoint)());
extern	int openfile(char *filename);
extern int determine_fstype_and_mountroot(char *);
extern	ssize_t xread(int, char *, size_t);
extern	void _reset(void);
extern	void init_physmem_common(void);

void
setup_aux(void)
{
}

void
init_physmem(void)
{
	init_physmem_common();
}
void
init_iolist(void)
{
	memlist_add_span(PERIPHERAL0_PHYS, PERIPHERAL0_SIZE, &piolistp);
	memlist_add_span(gxbb_share_mem_out_base(), 0x1000, &plinearlistp);
	memlist_add_span(gxbb_share_mem_in_base(), 0x1000, &plinearlistp);
}
void exitto(int (*entrypoint)())
{
	for (struct memlist *ml = plinearlistp; ml != NULL; ml = ml->ml_next) {
		uintptr_t pa = ml->ml_address;
		uintptr_t sz = ml->ml_size;
		map_phys(PTE_UXN | PTE_PXN | PTE_AF | PTE_SH_INNER | PTE_AP_KRWUNA | PTE_ATTR_NORMEM, (caddr_t)(SEGKPM_BASE + pa), pa, sz);
	}
	for (struct memlist *ml = piolistp; ml != NULL; ml = ml->ml_next) {
		uintptr_t pa = ml->ml_address;
		uintptr_t sz = ml->ml_size;
		map_phys(PTE_UXN | PTE_PXN | PTE_AF | PTE_SH_INNER | PTE_AP_KRWUNA | PTE_ATTR_DEVICE, (caddr_t)(SEGKPM_BASE + pa), pa, sz);
	}

	uint64_t v;
	const char *str;

	v = htonll((uint64_t)_RamdiskStart);
	prom_setprop(prom_chosennode(), "ramdisk_start", (caddr_t)&v, sizeof(v));
	v = htonll((uint64_t)_RamdiskEnd);
	prom_setprop(prom_chosennode(), "ramdisk_end", (caddr_t)&v, sizeof(v));
	v = htonll((uint64_t)pfreelistp);
	prom_setprop(prom_chosennode(), "phys-avail", (caddr_t)&v, sizeof(v));
	v = htonll((uint64_t)pinstalledp);
	prom_setprop(prom_chosennode(), "phys-installed", (caddr_t)&v, sizeof(v));
	v = htonll((uint64_t)pscratchlistp);
	prom_setprop(prom_chosennode(), "boot-scratch", (caddr_t)&v, sizeof(v));
	if (bootp_response) {
		uint_t blen = strlen(bootp_response) / 2;
		char *pktbuf = alloca(blen);
		hexascii_to_octet(bootp_response, blen * 2, pktbuf, &blen);
		prom_setprop(prom_chosennode(), "bootp-response", pktbuf, blen);
	} else {
	}
	str = "";
	prom_setprop(prom_chosennode(), "boot-args", (caddr_t)str, strlen(str) + 1);
	str = "";
	prom_setprop(prom_chosennode(), "bootargs", (caddr_t)str, strlen(str) + 1);
	str = filename;
	prom_setprop(prom_chosennode(), "whoami", (caddr_t)str, strlen(str) + 1);
	str = filename;
	prom_setprop(prom_chosennode(), "boot-file", (caddr_t)str, strlen(str) + 1);

	if (prom_getproplen(prom_chosennode(), "impl-arch-name") < 0) {
		str = "aarch64";
		prom_setprop(prom_chosennode(), "impl-arch-name", (caddr_t)str, strlen(str) + 1);
	}

	str = get_mfg_name();
	prom_setprop(prom_chosennode(), "mfg-name", (caddr_t)str, strlen(str) + 1);
	str = "115200,8,n,1,-";
	prom_setprop(prom_chosennode(), "ttya-mode", (caddr_t)str, strlen(str) + 1);
	prom_setprop(prom_chosennode(), "ttyb-mode", (caddr_t)str, strlen(str) + 1);

	xboot_info.bi_fdt = SEGKPM_BASE + (uint64_t)get_fdtp();
	entrypoint(&xboot_info);
}

extern void get_boot_zpool(char *);
static void 
set_zfs_bootfs(void)
{
	get_boot_zpool(zfs_bootfs);
	prom_setprop(prom_chosennode(), "zfs-bootfs", (caddr_t)zfs_bootfs, strlen(zfs_bootfs) + 1);
}

static void
set_rootfs(char *bpath, char *fstype)
{
	char *str;
	if (strcmp(fstype, "nfs") == 0) {
#if 1
		str = "nfsdyn";
		prom_setprop(prom_chosennode(), "fstype", (caddr_t)str, strlen(str) + 1);
#else
		str = "zfs";
		prom_setprop(prom_chosennode(), "fstype", (caddr_t)str, strlen(str) + 1);
		str = "/soc/sd@d0072000/blkdev@0";
		prom_setprop(prom_chosennode(), "bootpath", (caddr_t)str, strlen(str) + 1);
		str = "rpool/ROOT/illumos";
		prom_setprop(prom_chosennode(), "zfs-bootfs", (caddr_t)str, strlen(str) + 1);
#endif
	} else {
		str = fstype;
		prom_setprop(prom_chosennode(), "fstype", (caddr_t)str, strlen(str) + 1);
		str = bpath;
		prom_setprop(prom_chosennode(), "bootpath", (caddr_t)str, strlen(str) + 1);
	}
}

void
load_ramdisk(void *virt, const char *name)
{
	static char	tmpname[MAXPATHLEN];

	if (determine_fstype_and_mountroot(prom_bootpath()) == VFS_SUCCESS) {
		set_rootfs(prom_bootpath(), get_default_fs()->fsw_name);
		if (strcmp(get_default_fs()->fsw_name, "zfs") == 0)
			set_zfs_bootfs();

		strcpy(tmpname, name);
		int fd = openfile(tmpname);
		if (fd >= 0) {
			struct stat st;
			if (fstat(fd, &st) == 0) {
				xread(fd, (char *)virt, st.st_size);
			}
		} else {
			prom_printf("open failed %s\n", tmpname);
			prom_reset();
		}
		closeall(1);
		unmountroot();
	} else {
		prom_printf("mountroot failed\n");
		prom_reset();
	}
}

#define	MAXNMLEN	80		/* # of chars in an impl-arch name */

/*
 * Return the manufacturer name for this platform.
 *
 * This is exported (solely) as the rootnode name property in
 * the kernel's devinfo tree via the 'mfg-name' boot property.
 * So it's only used by boot, not the boot blocks.
 */
char *
get_mfg_name(void)
{
	pnode_t n;
	int len;

	static char mfgname[MAXNMLEN];

	if ((n = prom_rootnode()) != OBP_NONODE &&
	    (len = prom_getproplen(n, "mfg-name")) > 0 && len < MAXNMLEN) {
		(void) prom_getprop(n, "mfg-name", mfgname);
		mfgname[len] = '\0'; /* broken clones don't terminate name */
		return (mfgname);
	}

	return ("Unknown");
}

char *
get_default_bootpath(void)
{
	static char def_bootpath[] = "/soc/ethernet@c9410000";
	return def_bootpath;
}

void _reset(void)
{
	prom_printf("%s:%d\n",__func__,__LINE__);
	psci_system_reset();
	for (;;) {}
}

void init_machdev(void)
{
	init_dwmac();
	init_mmc();
}
