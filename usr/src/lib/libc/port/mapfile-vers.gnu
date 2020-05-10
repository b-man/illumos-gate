#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright (c) 2006, 2010, Oracle and/or its affiliates. All rights reserved.
# Copyright 2017 Nexenta Systems, Inc.
# Copyright (c) 2012 by Delphix. All rights reserved.
# Copyright 2016 Joyent, Inc.
# Copyright (c) 2013, OmniTI Computer Consulting, Inc. All rights reserved.
# Copyright (c) 2013 Gary Mills
# Copyright 2014 Garrett D'Amore <garrett@damore.org>
#

#
# MAPFILE HEADER START
#
# WARNING:  STOP NOW.  DO NOT MODIFY THIS FILE.
# Object versioning must comply with the rules detailed in
#
#	usr/src/lib/README.mapfiles
#
# You should not be making modifications here until you've read the most current
# copy of that file. If you need help, contact a gatekeeper for guidance.
#
# MAPFILE HEADER END
#

$mapfile_version 2

#
# All function names added to this or any other libc mapfile
# must be placed under the 'protected:' designation.
# The 'global:' designation is used *only* for data
# items and for the members of the malloc() family.
#

#
# README README README README README README: how to update this file
#   1) each version of Solaris/OpenSolaris gets a version number.
#      (Actually since Solaris is actually a series of OpenSolaris releases
#	we'll just use OpenSolaris for this exercise.)
#	OpenSolaris 2008.11 gets 1.23
#	OpenSolaris 2009.04 gets 1.24
#	etc.
#   2) each project integration uses a unique version number.
#	PSARC/2008/123 gets 1.24.1
#	PSARC/2008/456 gets 1.24.2
#	etc.
#


# Mnemonic conditional input identifiers:
#
# - amd64, i386, sparc32, sparcv9: Correspond to ISA subdirectories used to
#	hold per-platform code. Note however that we use 'sparc32' instead of
#	'sparc'. Since '_sparc' is predefined to apply to, all sparc platforms,
#	naming the 32-bit version 'sparc' would be too likely to cause errors.
#
# -	lf64: Defined on platforms that offer the 32-bit largefile APIs
#
{
    global:
#$if _ELF32
#$add lf64
#$endif
#$if _sparc && _ELF32
#$add sparc32
#$endif
#$if _sparc && _ELF64
#$add sparcv9
#$endif
#$if _x86 && _ELF32
#$add i386
#$endif
#$if _x86 && _ELF64
#$add amd64
#$endif

#SYMBOL_VERSION ILLUMOS_0.30 {
#    protected:
	reallocf;
#} ILLUMOS_0.29;

#SYMBOL_VERSION ILLUMOS_0.29 {
#    protected:
	getrandom;
#} ILLUMOS_0.28;

#SYMBOL_VERSION ILLUMOS_0.28 {
#    protected:
	pthread_attr_getname_np;
	pthread_attr_setname_np;
	pthread_getname_np;
	pthread_setname_np;
	thr_getname;
	thr_setname;
#} ILLUMOS_0.27;

#SYMBOL_VERSION ILLUMOS_0.27 {	# memset_s(3C) and set_constraint_handler_s(3C)
#    protected:
	abort_handler_s;
	ignore_handler_s;
	memset_s;
	set_constraint_handler_s;
#} ILLUMOS_0.26;

#SYMBOL_VERSION ILLUMOS_0.26 {	# fts(3) LFS
#$if lf64
#    protected:
	fts_children64;
	fts_close64;
	fts_open64;
	fts_read64;
	fts_set64;
#$endif
#} ILLUMOS_0.25;

#SYMBOL_VERSION ILLUMOS_0.25 {	# inet_* moved from libnsl/libsocket
#    protected:
	inet_addr;
	inet_aton;
	inet_lnaof;
	inet_makeaddr;
	inet_netof;
	inet_network;
	inet_ntoa;
	inet_ntoa_r;
	inet_ntop;
	inet_pton;
#} ILLUMOS_0.24;

#SYMBOL_VERSION ILLUMOS_0.24 {	# openbsd compat
#    protected:
	freezero;
	recallocarray;
#} ILLUMOS_0.23;

#SYMBOL_VERSION ILLUMOS_0.23 {	# openbsd compat
#    protected:
	fts_children;
	fts_close;
	fts_open;
	fts_read;
	fts_set;
	reallocarray;
	strtonum;
#} ILLUMOS_0.22;

#SYMBOL_VERSION ILLUMOS_0.22 {	# endian(3C)
#    protected:
	htobe16;
	htobe32;
	htobe64;
	htole16;
	htole32;
	htole64;
	betoh16;
	letoh16;
	be16toh;
	le16toh;
	betoh32;
	letoh32;
	be32toh;
	le32toh;
	betoh64;
	letoh64;
	be64toh;
	le64toh;
#} ILLUMOS_0.21;

#SYMBOL_VERSION ILLUMOS_0.21 {
#    protected:
	pthread_attr_get_np;
#} ILLUMOS_0.20;

#SYMBOL_VERSION ILLUMOS_0.20 {	# C11
#    protected:
	aligned_alloc;
	at_quick_exit;
	call_once;
	cnd_broadcast;
	cnd_destroy;
	cnd_init;
	cnd_signal;
	cnd_timedwait;
	cnd_wait;
	mtx_destroy;
	mtx_init;
	mtx_lock;
	mtx_timedlock;
	mtx_trylock;
	mtx_unlock;
	quick_exit;
	thrd_create;
	thrd_current;
	thrd_detach;
	thrd_equal;
	thrd_exit;
	thrd_join;
	thrd_sleep;
	thrd_yield;
	timespec_get;
	tss_create;
	tss_delete;
	tss_get;
	tss_set;
#} ILLUMOS_0.19;

#SYMBOL_VERSION ILLUMOS_0.19 {	# flock
#    protected:
	flock;
#} ILLUMOS_0.18;

#SYMBOL_VERSION ILLUMOS_0.18 {	# signalfd
#    protected:
	signalfd;
#} ILLUMOS_0.17;

#SYMBOL_VERSION ILLUMOS_0.17 {	# glob(3C) LFS
#$if lf64
#    protected:
	_glob_ext64;
	_globfree_ext64;
#$endif
#} ILLUMOS_0.16;

#SYMBOL_VERSION ILLUMOS_0.16 {	# timerfd
#    protected:
	timerfd_create;
	timerfd_gettime;
	timerfd_settime;
#} ILLUMOS_0.15;

#SYMBOL_VERSION ILLUMOS_0.15 {	# epoll(3C)
#    protected:
	epoll_create;
	epoll_create1;
	epoll_ctl;
	epoll_wait;
	epoll_pwait;
#} ILLUMOS_0.14;

#SYMBOL_VERSION ILLUMOS_0.14 {	# strerror_l
#    protected:
	strerror_l;
#} ILLUMOS_0.13;

#SYMBOL_VERSION ILLUMOS_0.13 {	# eventfd
#    protected:
	eventfd;
	eventfd_read;
	eventfd_write;
#} ILLUMOS_0.12;

#SYMBOL_VERSION ILLUMOS_0.12 {	# arc4random and friends
#    protected:
	arc4random;
	arc4random_buf;
	arc4random_uniform;
	explicit_bzero;
	getentropy;
#} ILLUMOS_0.11;

#SYMBOL_VERSION ILLUMOS_0.11 {	# Illumos additions
#    protected:
	iswxdigit_l;
	isxdigit_l;
#} ILLUMOS_0.10;

#SYMBOL_VERSION ILLUMOS_0.10 {	# Illumos additions
#    protected:
	preadv;
	pwritev;

#$if lf64
	preadv64;
	pwritev64;
#$endif
#} ILLUMOS_0.9;

#SYMBOL_VERSION ILLUMOS_0.9 {
#    protected:
	wcsnrtombs;
	wcsnrtombs_l;
#} ILLUMOS_0.8;

#SYMBOL_VERSION ILLUMOS_0.8 {	# POSIX 2008 newlocale and friends
#    protected:
	__global_locale;
	__mb_cur_max;
	__mb_cur_max_l;
	btowc_l;
	duplocale;
	fgetwc_l;
	freelocale;
	getwc_l;
	isalnum_l;
	isalpha_l;
	isblank_l;
	iscntrl_l;
	isdigit_l;
	isgraph_l;
	islower_l;
	isprint_l;
	ispunct_l;
	isspace_l;
	isupper_l;
	iswideogram;
	iswideogram_l;
	iswnumber;
	iswnumber_l;
	iswhexnumber;
	iswhexnumber_l;
	iswphonogram;
	iswphonogram_l;
	iswspecial;
	iswspecial_l;
	iswalnum_l;
	iswalpha_l;
	iswblank_l;
	iswcntrl_l;
	iswctype_l;
	iswdigit_l;
	iswgraph_l;
	iswlower_l;
	iswprint_l;
	iswpunct_l;
	iswspace_l;
	iswupper_l;
	mblen_l;
	mbrlen_l;
	mbsinit_l;
	mbsnrtowcs;
	mbsnrtowcs_l;
	mbsrtowcs_l;
	mbstowcs_l;
	mbtowc_l;
	newlocale;
	nl_langinfo_l;
	strcasecmp_l;
	strcasestr_l;
	strcoll_l;
	strfmon_l;
	strftime_l;
	strncasecmp_l;
	strptime_l;
	strxfrm_l;
	tolower_l;
	toupper_l;
	towlower_l;
	towupper_l;
	towctrans_l;
	uselocale;
	wcrtomb_l;
	wcscasecmp_l;
	wcscoll_l;
	wcsncasecmp_l;
	wcsrtombs_l;
	wcstombs_l;
	wcswidth_l;
	wcsxfrm_l;
	wctob_l;
	wctomb_l;
	wctrans_l;
	wctype_l;
	wcwidth_l;
#} ILLUMOS_0.7;

#SYMBOL_VERSION ILLUMOS_0.7 {	# Illumos additions
#    protected:
	_glob_ext;
	_globfree_ext;
#} ILLUMOS_0.6;

#SYMBOL_VERSION ILLUMOS_0.6 {	# Illumos additions
#    protected:
	getloginx;
	getloginx_r;
	__posix_getloginx_r;
#} ILLUMOS_0.5;

#SYMBOL_VERSION ILLUMOS_0.5 {	# common C++ ABI exit handlers
#    protected:
	__cxa_atexit;
	__cxa_finalize;
#} ILLUMOS_0.4;

#SYMBOL_VERSION ILLUMOS_0.4 {	# Illumos additions
#    protected:
        pipe2;
        dup3;
        mkostemp;
        mkostemps;

#$if lf64
        mkostemp64;
        mkostemps64;
#$endif
#} ILLUMOS_0.3;

#SYMBOL_VERSION ILLUMOS_0.3 {	# Illumos additions
#    protected:
        assfail3;
#} ILLUMOS_0.2;

#SYMBOL_VERSION ILLUMOS_0.2 {	# Illumos additions
#    protected:
        posix_spawn_pipe_np;
#} ILLUMOS_0.1;

#SYMBOL_VERSION ILLUMOS_0.1 {	# Illumos additions
#    protected:
        timegm;
#} SUNW_1.23;

#SYMBOL_VERSION SUNW_1.23 {	# SunOS 5.11 (Solaris 11)
#    global:
	_nl_domain_bindings;
	_nl_msg_cat_cntr;

#$if _ELF32
	dl_iterate_phdr	;
#$elif sparcv9
	dl_iterate_phdr	;
#$elif amd64
	dl_iterate_phdr	;
#$else
#$error unknown platform
#$endif

#    protected:

#$if sparc32
	__align_cpy_1;
#$endif

	addrtosymstr;
	aio_cancel;
	aiocancel;
	aio_error;
	aio_fsync;
	aio_read;
	aioread;
	aio_return;
	aio_suspend;
	aiowait;
	aio_waitn;
	aio_write;
	aiowrite;
	asprintf;
	assfail;
	backtrace;
	backtrace_symbols;
	backtrace_symbols_fd;
	canonicalize_file_name;
	clearenv;
	clock_getres;
	clock_gettime;
	clock_nanosleep;
	clock_settime;
	daemon;
	dirfd;
	door_bind;
	door_call;
	door_create;
	door_cred;
	door_getparam;
	door_info;
	door_return;
	door_revoke;
	door_server_create;
	door_setparam;
	door_ucred;
	door_unbind;
	door_xcreate;
	err;
	errx;
	faccessat;
	fchmodat;
	fcloseall;
	fdatasync;
	ffsl;
	ffsll;
	fgetattr;
	fls;
	flsl;
	flsll;
	forkallx;
	forkx;
	fsetattr;
	getattrat;
	getdelim;
	getline;
	get_nprocs;
	get_nprocs_conf;
	getprogname;
	htonl;
	htonll;
	htons;
	linkat;
	lio_listio;
	memmem;
	mkdirat;
	mkdtemp;
	mkfifoat;
	mknodat;
	mkstemps;
	mmapobj;
	mq_close;
	mq_getattr;
	mq_notify;
	mq_open;
	mq_receive;
	mq_reltimedreceive_np;
	mq_reltimedsend_np;
	mq_send;
	mq_setattr;
	mq_timedreceive;
	mq_timedsend;
	mq_unlink;
	nanosleep;
	ntohl;
	ntohll;
	ntohs;
	posix_fadvise;
	posix_fallocate;
	posix_madvise;
	posix_memalign;
	posix_spawn_file_actions_addclosefrom_np;
	posix_spawnattr_getsigignore_np;
	posix_spawnattr_setsigignore_np;
	ppoll;
	priv_basicset;
	pthread_key_create_once_np;
	pthread_mutexattr_getrobust;
	pthread_mutexattr_setrobust;
	pthread_mutex_consistent;
	readlinkat;
	sched_getparam;
	sched_get_priority_max;
	sched_get_priority_min;
	sched_getscheduler;
	sched_rr_get_interval;
	sched_setparam;
	sched_setscheduler;
	sched_yield;
	sem_close;
	sem_destroy;
	sem_getvalue;
	sem_init;
	sem_open;
	sem_post;
	sem_reltimedwait_np;
	sem_timedwait;
	sem_trywait;
	sem_unlink;
	sem_wait;
	setattrat;
	setprogname;
	_sharefs;
	shm_open;
	shm_unlink;
	sigqueue;
	sigtimedwait;
	sigwaitinfo;
	smt_pause;
	stpcpy;
	stpncpy;
	strcasestr;
	strchrnul;
	strndup;
	strnlen;
	strnstr;
	strsep;
	symlinkat;
	thr_keycreate_once;
	timer_create;
	timer_delete;
	timer_getoverrun;
	timer_gettime;
	timer_settime;
	u8_strcmp;
	u8_validate;
	uconv_u16tou32;
	uconv_u16tou8;
	uconv_u32tou16;
	uconv_u32tou8;
	uconv_u8tou16;
	uconv_u8tou32;
	vasprintf;
	verr;
	verrx;
	vforkx;
	vwarn;
	vwarnx;
	warn;
	warnx;
	wcpcpy;
	wcpncpy;
	wcscasecmp;
	wcsdup;
	wcsncasecmp;
	wcsnlen;

#$if lf64
	aio_cancel64;
	aio_error64;
	aio_fsync64;
	aio_read64;
	aioread64;
	aio_return64;
	aio_suspend64;
	aio_waitn64;
	aio_write64;
	aiowrite64;
	lio_listio64;
	mkstemps64;
	posix_fadvise64;
	posix_fallocate64;
#$endif
#} SUNW_1.22.6;

#SYMBOL_VERSION SUNW_1.22.6 {	# s10u9 - SunOS 5.10 (Solaris 10) patch additions
#    protected:
	futimens;
	utimensat;
#} SUNW_1.22.5;

#SYMBOL_VERSION SUNW_1.22.5 {	# s10u8 - SunOS 5.10 (Solaris 10) patch additions
#    protected:
	getpagesizes2;
#} SUNW_1.22.4;

#SYMBOL_VERSION SUNW_1.22.4 {	# s10u7 - SunOS 5.10 (Solaris 10) patch additions
#    protected:
	SUNW_1.22.4;
#} SUNW_1.22.3;

#SYMBOL_VERSION SUNW_1.22.3 {	# SunOS 5.10 (Solaris 10) patch additions
#    protected:
	mutex_consistent;
	u8_textprep_str;
	uucopy;
	uucopystr;
#} SUNW_1.22.2;

#SYMBOL_VERSION SUNW_1.22.2 {	# SunOS 5.10 (Solaris 10) patch additions
#    protected:
	is_system_labeled;
	ucred_getlabel;
	_ucred_getlabel;
#} SUNW_1.22.1;

#SYMBOL_VERSION SUNW_1.22.1 {	# SunOS 5.10 (Solaris 10) patch additions
#    protected:
	atomic_add_8;
	atomic_add_8_nv;
	atomic_add_char		;
	atomic_add_char_nv	;
	atomic_add_int		;
	atomic_add_int_nv	;
	atomic_add_ptr		;
	atomic_add_ptr_nv	;
	atomic_add_short	;
	atomic_add_short_nv	;
	atomic_and_16;
	atomic_and_16_nv;
	atomic_and_32_nv;
	atomic_and_64;
	atomic_and_64_nv;
	atomic_and_8;
	atomic_and_8_nv;
	atomic_and_uchar	;
	atomic_and_uchar_nv	;
	atomic_and_uint_nv	;
	atomic_and_ulong	;
	atomic_and_ulong_nv	;
	atomic_and_ushort	;
	atomic_and_ushort_nv	;
	atomic_cas_16;
	atomic_cas_32;
	atomic_cas_64;
	atomic_cas_8;
	atomic_cas_ptr		;
	atomic_cas_uchar	;
	atomic_cas_uint		;
	atomic_cas_ulong	;
	atomic_cas_ushort	;
	atomic_clear_long_excl	;
	atomic_dec_16;
	atomic_dec_16_nv;
	atomic_dec_32;
	atomic_dec_32_nv;
	atomic_dec_64;
	atomic_dec_64_nv;
	atomic_dec_8;
	atomic_dec_8_nv;
	atomic_dec_uchar	;
	atomic_dec_uchar_nv	;
	atomic_dec_uint		;
	atomic_dec_uint_nv	;
	atomic_dec_ulong	;
	atomic_dec_ulong_nv	;
	atomic_dec_ushort	;
	atomic_dec_ushort_nv	;
	atomic_inc_16;
	atomic_inc_16_nv;
	atomic_inc_32;
	atomic_inc_32_nv;
	atomic_inc_64;
	atomic_inc_64_nv;
	atomic_inc_8;
	atomic_inc_8_nv;
	atomic_inc_uchar	;
	atomic_inc_uchar_nv	;
	atomic_inc_uint		;
	atomic_inc_uint_nv	;
	atomic_inc_ulong	;
	atomic_inc_ulong_nv	;
	atomic_inc_ushort	;
	atomic_inc_ushort_nv	;
	atomic_or_16;
	atomic_or_16_nv;
	atomic_or_32_nv;
	atomic_or_64;
	atomic_or_64_nv;
	atomic_or_8;
	atomic_or_8_nv;
	atomic_or_uchar		;
	atomic_or_uchar_nv	;
	atomic_or_uint_nv	;
	atomic_or_ulong		;
	atomic_or_ulong_nv	;
	atomic_or_ushort	;
	atomic_or_ushort_nv	;
	atomic_set_long_excl	;
	atomic_swap_16;
	atomic_swap_32;
	atomic_swap_64;
	atomic_swap_8;
	atomic_swap_ptr		;
	atomic_swap_uchar	;
	atomic_swap_uint	;
	atomic_swap_ulong	;
	atomic_swap_ushort	;
	membar_consumer;
	membar_enter;
	membar_exit;
	membar_producer;

#$if _ELF32
	enable_extended_FILE_stdio;
#$endif

#$if i386
	# Note: atomic_[and,dec,inc,or]_64_nv are also defined above. Here,
	# we add the NODYNSORT attribute to them. On this platform, they are
	# aliases for the non-_nv versions. If that is changed, these lines
	# should be removed.
	atomic_and_64_nv	;
	atomic_dec_64_nv	;
	atomic_inc_64_nv	;
	atomic_or_64_nv		;
#$endif
#$if _sparc
	# Note: atomic_OP_WIDTH_nv symbols are also defined above. Here,
	# we add the NODYNSORT attribute to them. On this platform, they are
	# aliases for the non-_nv versions. If that is changed, these lines
	# should be removed.
	atomic_add_8_nv		;
	atomic_and_8_nv		;
	atomic_and_16_nv	;
	atomic_and_32_nv	;
	atomic_and_64_nv	;
	atomic_dec_8_nv		;
	atomic_dec_16_nv	;
	atomic_dec_32_nv	;
	atomic_dec_64_nv	;
	atomic_inc_8_nv		;
	atomic_inc_16_nv	;
	atomic_inc_32_nv	;
	atomic_inc_64_nv	;
	atomic_or_8_nv		;
	atomic_or_16_nv		;
	atomic_or_32_nv		;
	atomic_or_64_nv		;
#$endif
#} SUNW_1.22;

#SYMBOL_VERSION SUNW_1.22 {	# SunOS 5.10 (Solaris 10)
#    global:
#$if _ELF32
	dladdr		;
	dladdr1		;
	dlclose		;
	dldump		;
	dlerror		;
	dlinfo		;
	dlmopen		;
	dlopen		;
	dlsym		;
#$elif sparcv9
	dladdr		;
	dladdr1		;
	dlclose		;
	dldump		;
	dlerror		;
	dlinfo		;
	dlmopen		;
	dlopen		;
	dlsym		;
#$elif amd64
	dladdr		;
	dladdr1		;
	dlamd64getunwind ;
	dlclose		;
	dldump		;
	dlerror		;
	dlinfo		;
	dlmopen		;
	dlopen		;
	dlsym		;
#$else
#$error unknown platform
#$endif

#    protected:
	alphasort;
	_alphasort;
	atomic_add_16;
	atomic_add_16_nv;
	atomic_add_32;
	atomic_add_32_nv;
	atomic_add_64;
	atomic_add_64_nv;
	atomic_add_long		;
	atomic_add_long_nv	;
	atomic_and_32;
	atomic_and_uint		;
	atomic_or_32;
	atomic_or_uint		;
	_Exit;
	getisax;
	_getisax;
	getopt_clip;
	_getopt_clip;
	getopt_long;
	_getopt_long;
	getopt_long_only;
	_getopt_long_only;
	getpeerucred;
	_getpeerucred;
	getpflags;
	_getpflags;
	getppriv;
	_getppriv;
	getprivimplinfo;
	_getprivimplinfo;
	getzoneid;
	getzoneidbyname;
	getzonenamebyid;
	imaxabs;
	imaxdiv;
	isblank;
	iswblank;
	port_alert;
	port_associate;
	port_create;
	port_dissociate;
	port_get;
	port_getn;
	port_send;
	port_sendn;
	posix_openpt;
	posix_spawn;
	posix_spawnattr_destroy;
	posix_spawnattr_getflags;
	posix_spawnattr_getpgroup;
	posix_spawnattr_getschedparam;
	posix_spawnattr_getschedpolicy;
	posix_spawnattr_getsigdefault;
	posix_spawnattr_getsigmask;
	posix_spawnattr_init;
	posix_spawnattr_setflags;
	posix_spawnattr_setpgroup;
	posix_spawnattr_setschedparam;
	posix_spawnattr_setschedpolicy;
	posix_spawnattr_setsigdefault;
	posix_spawnattr_setsigmask;
	posix_spawn_file_actions_addclose;
	posix_spawn_file_actions_adddup2;
	posix_spawn_file_actions_addopen;
	posix_spawn_file_actions_destroy;
	posix_spawn_file_actions_init;
	posix_spawnp;
	priv_addset;
	_priv_addset;
	priv_allocset;
	_priv_allocset;
	priv_copyset;
	_priv_copyset;
	priv_delset;
	_priv_delset;
	priv_emptyset;
	_priv_emptyset;
	priv_fillset;
	_priv_fillset;
	__priv_free_info;
	priv_freeset;
	_priv_freeset;
	priv_getbyname;
	_priv_getbyname;
	__priv_getbyname;
	priv_getbynum;
	_priv_getbynum;
	__priv_getbynum;
	__priv_getdata;
	priv_getsetbyname;
	_priv_getsetbyname;
	__priv_getsetbyname;
	priv_getsetbynum;
	_priv_getsetbynum;
	__priv_getsetbynum;
	priv_gettext;
	_priv_gettext;
	priv_ineffect;
	_priv_ineffect;
	priv_intersect;
	_priv_intersect;
	priv_inverse;
	_priv_inverse;
	priv_isemptyset;
	_priv_isemptyset;
	priv_isequalset;
	_priv_isequalset;
	priv_isfullset;
	_priv_isfullset;
	priv_ismember;
	_priv_ismember;
	priv_issubset;
	_priv_issubset;
	__priv_parse_info;
	priv_set;
	_priv_set;
	priv_set_to_str;
	_priv_set_to_str;
	__priv_set_to_str;
	priv_str_to_set;
	_priv_str_to_set;
	priv_union;
	_priv_union;
	pselect;
	pthread_attr_getstack;
	pthread_attr_setstack;
	pthread_barrierattr_destroy;
	pthread_barrierattr_getpshared;
	pthread_barrierattr_init;
	pthread_barrierattr_setpshared;
	pthread_barrier_destroy;
	pthread_barrier_init;
	pthread_barrier_wait;
	pthread_condattr_getclock;
	pthread_condattr_setclock;
	pthread_mutexattr_getrobust_np	;
	pthread_mutexattr_setrobust_np	;
	pthread_mutex_consistent_np	;
	pthread_mutex_reltimedlock_np;
	pthread_mutex_timedlock;
	pthread_rwlock_reltimedrdlock_np;
	pthread_rwlock_reltimedwrlock_np;
	pthread_rwlock_timedrdlock;
	pthread_rwlock_timedwrlock;
	pthread_setschedprio;
	pthread_spin_destroy;
	pthread_spin_init;
	pthread_spin_lock;
	pthread_spin_trylock;
	pthread_spin_unlock;
	rctlblk_set_recipient_pid;
	scandir;
	_scandir;
	schedctl_exit;
	schedctl_init;
	schedctl_lookup;
	sema_reltimedwait;
	sema_timedwait;
	setenv;
	setpflags;
	_setpflags;
	setppriv;
	_setppriv;
	strerror_r;
	strtof;
	strtoimax;
	strtold;
	strtoumax;
	ucred_free;
	_ucred_free;
	ucred_get;
	_ucred_get;
	ucred_getegid;
	_ucred_getegid;
	ucred_geteuid;
	_ucred_geteuid;
	ucred_getgroups;
	_ucred_getgroups;
	ucred_getpflags;
	_ucred_getpflags;
	ucred_getpid;
	_ucred_getpid;
	ucred_getprivset;
	_ucred_getprivset;
	ucred_getprojid;
	_ucred_getprojid;
	ucred_getrgid;
	_ucred_getrgid;
	ucred_getruid;
	_ucred_getruid;
	ucred_getsgid;
	_ucred_getsgid;
	ucred_getsuid;
	_ucred_getsuid;
	ucred_getzoneid;
	_ucred_getzoneid;
	ucred_size;
	_ucred_size;
	unsetenv;
	wcstof;
	wcstoimax;
	wcstold;
	wcstoll;
	wcstoull;
	wcstoumax;

#$if lf64
	alphasort64;
	_alphasort64;
	pselect_large_fdset;
	scandir64;
	_scandir64;
#$endif

#$if _ELF64
	walkcontext;
#$endif

#$if _sparc
	# Note: atomic_add_[16,32,64]_nv are also defined above. Here, we add
	# the NODYNSORT attribute to them. On this platform, they are aliases
	# for the non-_nv versions. If that is changed, these lines should be
	# removed.
	atomic_add_16_nv	;
	atomic_add_32_nv	;
	atomic_add_64_nv	;
#$endif

#$if i386
	# Note: atomic_add_64_nv is also defined above. Here, we add the
	# NODYNSORT attribute to it. On this platform, it is an aliases for
	# atomic_add_64. If that is changed, this line should be removed.
	atomic_add_64_nv 	;
#$endif

#$if amd64
	# Exception unwind APIs required by the amd64 ABI
	_SUNW_Unwind_DeleteException;
	_SUNW_Unwind_ForcedUnwind;
	_SUNW_Unwind_GetCFA;
	_SUNW_Unwind_GetGR;
	_SUNW_Unwind_GetIP;
	_SUNW_Unwind_GetLanguageSpecificData;
	_SUNW_Unwind_GetRegionStart;
	_SUNW_Unwind_RaiseException;
	_SUNW_Unwind_Resume;
	_SUNW_Unwind_SetGR;
	_SUNW_Unwind_SetIP;
	_UA_CLEANUP_PHASE;
	_UA_FORCE_UNWIND;
	_UA_HANDLER_FRAME;
	_UA_SEARCH_PHASE;
	_Unwind_DeleteException;
	_Unwind_ForcedUnwind;
	_Unwind_GetCFA;
	_Unwind_GetGR;
	_Unwind_GetIP;
	_Unwind_GetLanguageSpecificData;
	_Unwind_GetRegionStart;
	_Unwind_RaiseException;
	_Unwind_Resume;
	_Unwind_SetGR;
	_Unwind_SetIP;
#$endif
#} SUNW_1.21.3;

#SYMBOL_VERSION SUNW_1.21.3 {	# SunOS 5.9 (Solaris 9) patch additions
#    protected:
	forkall;
#} SUNW_1.21.2;

#SYMBOL_VERSION SUNW_1.21.2 {	# SunOS 5.9 (Solaris 9) patch additions
#    protected:
	getustack;
	_getustack;
	setustack;
	_setustack;
	stack_getbounds;
	_stack_getbounds;
	_stack_grow;
	stack_inbounds;
	_stack_inbounds;
	stack_setbounds;
	_stack_setbounds;
	stack_violation;
	_stack_violation;

#$if _sparc
	__makecontext_v2;
	___makecontext_v2;
#$endif
#} SUNW_1.21.1;

#SYMBOL_VERSION SUNW_1.21.1 {	# SunOS 5.9 (Solaris 9) patch additions
#    protected:
	crypt_gensalt;
#} SUNW_1.21;

#SYMBOL_VERSION SUNW_1.21 {	# SunOS 5.9 (Solaris 9)
#    protected:
	attropen;
	_attropen;
	bind_textdomain_codeset;
	closefrom;
	_closefrom;
	cond_reltimedwait;
	dcngettext;
	dngettext;
	fchownat;
	_fchownat;
	fdopendir;
	_fdopendir;
	fdwalk;
	_fdwalk;
	fstatat;
	_fstatat;
	futimesat;
	_futimesat;
	getcpuid;
	_getcpuid;
	gethomelgroup;
	_gethomelgroup		;
	getpagesizes;
	getrctl;
	_getrctl;
	issetugid;
	_issetugid;
	_lwp_cond_reltimedwait;
	meminfo;
	_meminfo;
	ngettext;
	openat;
	_openat;
	printstack;
	priocntl;
	priocntlset;
	pset_getattr;
	pset_getloadavg;
	pset_list;
	pset_setattr;
	pthread_cond_reltimedwait_np;
	rctlblk_get_enforced_value;
	rctlblk_get_firing_time;
	rctlblk_get_global_action;
	rctlblk_get_global_flags;
	rctlblk_get_local_action;
	rctlblk_get_local_flags;
	rctlblk_get_privilege;
	rctlblk_get_recipient_pid;
	rctlblk_get_value;
	rctlblk_set_local_action;
	rctlblk_set_local_flags;
	rctlblk_set_privilege;
	rctlblk_set_value;
	rctlblk_size;
	rctl_walk;
	renameat;
	setrctl;
	_setrctl;
	unlinkat;
	_unlinkat;
	vfscanf;
	_vfscanf;
	vfwscanf;
	vscanf;
	_vscanf;
	vsscanf;
	_vsscanf;
	vswscanf;
	vwscanf;

#$if _ELF32
	walkcontext;
#$endif

#$if lf64
	attropen64;
	_attropen64;
	fstatat64;
	_fstatat64;
	openat64;
	_openat64;
#$endif
#} SUNW_1.20.4;

#SYMBOL_VERSION SUNW_1.20.4 {	# SunOS 5.8 (Solaris 8) patch additions
#    protected:
	semtimedop;
	_semtimedop;
#} SUNW_1.20.1;

#SYMBOL_VERSION SUNW_1.20.1 {	# SunOS 5.8 (Solaris 8) patch additions
#    protected:
	getacct;
	_getacct;
	getprojid;
	_getprojid;
	gettaskid;
	_gettaskid;
	msgids;
	_msgids;
	msgsnap;
	_msgsnap;
	putacct;
	_putacct;
	semids;
	_semids;
	settaskid;
	_settaskid;
	shmids;
	_shmids;
	wracct;
	_wracct;
#} SUNW_1.20;

#SYMBOL_VERSION SUNW_1.20 {	# SunOS 5.8 (Solaris 8)
#    protected:
	getextmntent;
	resetmnttab;
#} SUNW_1.19;

#SYMBOL_VERSION SUNW_1.19 {
#    protected:
	strlcat;
	strlcpy;
	umount2;
	_umount2;
#} SUNW_1.18.1;

#SYMBOL_VERSION SUNW_1.18.1 {
#    protected:
	__fsetlocking;
#} SUNW_1.18;

#SYMBOL_VERSION SUNW_1.18 {	# SunOS 5.7 (Solaris 7)
#    protected:
	btowc;
	__fbufsize;
	__flbf;
	_flushlbf;
	__fpending;
	__fpurge;
	__freadable;
	__freading;
	fwide;
	fwprintf;
	__fwritable;
	__fwriting;
	fwscanf;
	getloadavg;
	isaexec;
	mbrlen;
	mbrtowc;
	mbsinit;
	mbsrtowcs;
	pcsample;
	pthread_attr_getguardsize;
	pthread_attr_setguardsize;
	pthread_getconcurrency;
	pthread_mutexattr_gettype;
	pthread_mutexattr_settype;
	pthread_rwlockattr_destroy;
	pthread_rwlockattr_getpshared;
	pthread_rwlockattr_init;
	pthread_rwlockattr_setpshared;
	pthread_rwlock_destroy;
	pthread_rwlock_init;
	pthread_rwlock_rdlock;
	pthread_rwlock_tryrdlock;
	pthread_rwlock_trywrlock;
	pthread_rwlock_unlock;
	pthread_rwlock_wrlock;
	pthread_setconcurrency;
	swprintf;
	swscanf;
	__sysconf_xpg5;
	vfwprintf;
	vswprintf;
	vwprintf;
	wcrtomb;
	wcsrtombs;
	wcsstr;
	wctob;
	wmemchr;
	wmemcmp;
	wmemcpy;
	wmemmove;
	wmemset;
	wprintf;
	wscanf;

#$if _ELF32
	select_large_fdset;
#$endif
#} SUNW_1.17;

# The empty versions SUNW_1.2 through SUNW_1.17 must be preserved because
# applications built on Solaris 2.6 Beta (when they did contain symbols)
# may depend on them.  All symbol content for SunOS 5.6 is now in SUNW_1.1

#SYMBOL_VERSION SUNW_1.17 {
#    protected:
	SUNW_1.17;
#} SUNW_1.16;

#SYMBOL_VERSION SUNW_1.16 {
#    protected:
	SUNW_1.16;
#} SUNW_1.15;

#SYMBOL_VERSION SUNW_1.15 {
#    protected:
	SUNW_1.15;
#} SUNW_1.14;

#SYMBOL_VERSION SUNW_1.14 {
#    protected:
	SUNW_1.14;
#} SUNW_1.13;

#SYMBOL_VERSION SUNW_1.13 {
#    protected:
	SUNW_1.13;
#} SUNW_1.12;

#SYMBOL_VERSION SUNW_1.12 {
#    protected:
	SUNW_1.12;
#} SUNW_1.11;

#SYMBOL_VERSION SUNW_1.11 {
#    protected:
	SUNW_1.11;
#} SUNW_1.10;

#SYMBOL_VERSION SUNW_1.10 {
#    protected:
	SUNW_1.10;
#} SUNW_1.9;

#SYMBOL_VERSION SUNW_1.9 {
#    protected:
	SUNW_1.9;
#} SUNW_1.8;

#SYMBOL_VERSION SUNW_1.8 {
#    protected:
	SUNW_1.8;
#} SUNW_1.7;

#SYMBOL_VERSION SUNW_1.7 {
#    protected:
	SUNW_1.7;
#} SUNW_1.6;

#SYMBOL_VERSION SUNW_1.6 {
#    protected:
	SUNW_1.6;
#} SUNW_1.5;

#SYMBOL_VERSION SUNW_1.5 {
#    protected:
	SUNW_1.5;
#} SUNW_1.4;

#SYMBOL_VERSION SUNW_1.4 {
#    protected:
	SUNW_1.4;
#} SUNW_1.3;

#SYMBOL_VERSION SUNW_1.3 {
#    protected:
	SUNW_1.3;
#} SUNW_1.2;

#SYMBOL_VERSION SUNW_1.2 {
#    protected:
	SUNW_1.2;
#} SUNW_1.1;

#SYMBOL_VERSION SUNW_1.1 {	# SunOS 5.6 (Solaris 2.6)
#    global:
	__loc1;
#    protected:
	basename;
	bindtextdomain;
	bsd_signal;
	dbm_clearerr;
	dbm_error;
	dcgettext;
	dgettext;
	directio;
	dirname;
	endusershell;
	_exithandle;
	fgetwc;
	fgetws;
	fpgetround;
	fpsetround;
	fputwc;
	fputws;
	fseeko;
	ftello;
	ftrylockfile;
	getexecname;
	_getexecname;
	getpassphrase;
	gettext;
	getusershell;
	getwc;
	getwchar;
	getws;
	isenglish;
	isideogram;
	isnumber;
	isphonogram;
	isspecial;
	iswalnum;
	iswalpha;
	iswcntrl;
	iswctype;
	iswdigit;
	iswgraph;
	iswlower;
	iswprint;
	iswpunct;
	iswspace;
	iswupper;
	iswxdigit;
	____loc1;
	_longjmp;
	_lwp_sema_trywait;
	ntp_adjtime;
	_ntp_adjtime;
	ntp_gettime;
	_ntp_gettime;
	__posix_asctime_r;
	__posix_ctime_r;
	__posix_getgrgid_r;
	__posix_getgrnam_r;
	__posix_getlogin_r;
	__posix_getpwnam_r;
	__posix_getpwuid_r;
	__posix_sigwait;
	__posix_ttyname_r;
	pset_assign;
	pset_bind;
	pset_create;
	pset_destroy;
	pset_info;
	pthread_atfork;
	pthread_attr_destroy;
	pthread_attr_getdetachstate;
	pthread_attr_getinheritsched;
	pthread_attr_getschedparam;
	pthread_attr_getschedpolicy;
	pthread_attr_getscope;
	pthread_attr_getstackaddr;
	pthread_attr_getstacksize;
	pthread_attr_init;
	pthread_attr_setdetachstate;
	pthread_attr_setinheritsched;
	pthread_attr_setschedparam;
	pthread_attr_setschedpolicy;
	pthread_attr_setscope;
	pthread_attr_setstackaddr;
	pthread_attr_setstacksize;
	pthread_cancel;
	__pthread_cleanup_pop;
	__pthread_cleanup_push;
	pthread_create;
	pthread_detach;
	pthread_equal;
	pthread_exit;
	pthread_getschedparam;
	pthread_getspecific;
	pthread_join;
	pthread_key_create;
	pthread_key_delete;
	pthread_kill;
	pthread_once;
	pthread_self;
	pthread_setcancelstate;
	pthread_setcanceltype;
	pthread_setschedparam;
	pthread_setspecific;
	pthread_sigmask;
	pthread_testcancel;
	putwc;
	putwchar;
	putws;
	regcmp;
	regex;
	resolvepath;
	_resolvepath;
	rwlock_destroy		;
	_rwlock_destroy		;
	sema_destroy;
	_sema_destroy;
	_setjmp;
	setusershell;
	siginterrupt;
	sigstack;
	snprintf;
	strtows;
	sync_instruction_memory;
	textdomain;
	thr_main;
	towctrans;
	towlower;
	towupper;
	ungetwc;
	vsnprintf;
	watoll;
	wcscat;
	wcschr;
	wcscmp;
	wcscoll;
	wcscpy;
	wcscspn;
	wcsftime;
	wcslen;
	wcsncat;
	wcsncmp;
	wcsncpy;
	wcspbrk;
	wcsrchr;
	wcsspn;
	wcstod;
	wcstok;
	wcstol;
	wcstoul;
	wcswcs;
	wcswidth;
	wcsxfrm;
	wctrans;
	wctype;
	wcwidth;
	wscasecmp;
	wscat;
	wschr;
	wscmp;
	wscol;
	wscoll;
	wscpy;
	wscspn;
	wsdup;
	wslen;
	wsncasecmp;
	wsncat;
	wsncmp;
	wsncpy;
	wspbrk;
	wsprintf;
	wsrchr;
	wsscanf;
	wsspn;
	wstod;
	wstok;
	wstol;
	wstoll;
	wstostr;
	wsxfrm;
	__xpg4_putmsg;
	__xpg4_putpmsg;

#$if lf64
	creat64;
	_creat64;
	fgetpos64;
	fopen64;
	freopen64;
	fseeko64;
	fsetpos64;
	fstat64;
	_fstat64;
	fstatvfs64;
	_fstatvfs64;
	ftello64;
	ftruncate64;
	_ftruncate64;
	ftw64;
	_ftw64;
	getdents64;
	_getdents64;
	getrlimit64;
	_getrlimit64;
	lockf64;
	_lockf64;
	lseek64;
	_lseek64;
	lstat64;
	_lstat64;
	mkstemp64;
	_mkstemp64;
	mmap64;
	_mmap64;
	nftw64;
	_nftw64;
	open64;
	_open64;
	__posix_readdir_r;
	pread64;
	_pread64;
	pwrite64;
	_pwrite64;
	readdir64;
	_readdir64;
	readdir64_r;
	_readdir64_r;
	setrlimit64;
	_setrlimit64;
	s_fcntl;
	_s_fcntl		;
	s_ioctl;
	stat64;
	_stat64;
	statvfs64;
	_statvfs64;
	tell64;
	_tell64;
	tmpfile64;
	truncate64;
	_truncate64;
	_xftw64;
#$endif

#$if _sparc
	__flt_rounds;
#$endif
#} SUNW_0.9;

#SYMBOL_VERSION SUNW_0.9 {	# SunOS 5.5 (Solaris 2.5)
#    protected:
	acl;
	bcmp;
	bcopy;
	bzero;
	facl;
	ftime;
	getdtablesize;
	gethostid;
	gethostname;
	getpagesize;
	getpriority;
	getrusage;
	getwd;
	index;
	initstate;
	killpg;
	_nsc_trydoorcall;
	pthread_condattr_destroy;
	pthread_condattr_getpshared;
	pthread_condattr_init;
	pthread_condattr_setpshared;
	pthread_cond_broadcast;
	pthread_cond_destroy;
	pthread_cond_init;
	pthread_cond_signal;
	pthread_cond_timedwait;
	pthread_cond_wait;
	pthread_mutexattr_destroy;
	pthread_mutexattr_getprioceiling;
	pthread_mutexattr_getprotocol;
	pthread_mutexattr_getpshared;
	pthread_mutexattr_init;
	pthread_mutexattr_setprioceiling;
	pthread_mutexattr_setprotocol;
	pthread_mutexattr_setpshared;
	pthread_mutex_destroy;
	pthread_mutex_getprioceiling;
	pthread_mutex_init;
	pthread_mutex_lock;
	pthread_mutex_setprioceiling;
	pthread_mutex_trylock;
	pthread_mutex_unlock;
	random;
	reboot;
	re_comp;
	re_exec;
	rindex;
	setbuffer;
	sethostname;
	setlinebuf;
	setpriority;
	setregid;
	setreuid;
	setstate;
	srandom;
	thr_min_stack;
	thr_stksegment;
	ualarm;
	usleep;
	wait3;
	wait4;
#} SUNW_0.8;

#SYMBOL_VERSION SUNW_0.8 {	# SunOS 5.4 (Solaris 2.4)
#    global:
	__xpg4			;
#    protected:
	addsev;
	cond_broadcast		;
	cond_destroy		;
	cond_init;
	cond_signal		;
	cond_timedwait;
	cond_wait;
	confstr;
	fnmatch;
	_getdate_err_addr;
	glob;
	globfree;
	iconv;
	iconv_close;
	iconv_open;
	lfmt;
	mutex_destroy		;
	mutex_init;
	mutex_lock		;
	mutex_trylock		;
	mutex_unlock		;
	pfmt;
	regcomp;
	regerror;
	regexec;
	regfree;
	rwlock_init;
	rw_rdlock		;
	rw_read_held;
	rw_tryrdlock		;
	rw_trywrlock		;
	rw_unlock		;
	rw_write_held;
	rw_wrlock		;
	sema_held;
	sema_init;
	sema_post;
	sema_trywait;
	sema_wait;
	setcat;
	sigfpe;
	strfmon;
	strptime;
	thr_continue;
	thr_create;
	thr_exit;
	thr_getconcurrency;
	thr_getprio;
	thr_getspecific;
	thr_join;
	thr_keycreate;
	thr_kill;
	thr_self		;
	thr_setconcurrency;
	thr_setprio;
	thr_setspecific;
	thr_sigsetmask;
	thr_suspend;
	thr_yield;
	vlfmt;
	vpfmt;
	wordexp;
	wordfree;
#} SUNW_0.7;

#SYMBOL_VERSION SUNW_0.7 {	# SunOS 5.3 (Solaris 2.3)
#    global:
	altzone;
	_ctype;
	isnanf			;
	lone;
	lten;
	lzero;
	memalign		;
	modff			;
	nss_default_finders;
	_sibuf;
	_sobuf;
	_sys_buslist;
	_sys_cldlist;
	_sys_fpelist;
	_sys_illlist;
	_sys_segvlist;
	_sys_siginfolistp;
	_sys_siglist;
	_sys_siglistn;
	_sys_siglistp;
	_sys_traplist;
	valloc			;

#$if _ELF32
	_bufendtab;
	_lastbuf;
	sys_errlist;
	sys_nerr;
	_sys_nsig;
#$endif

#    protected:
	a64l;
	adjtime;
	ascftime;
	_assert;
	atoll;
	brk;
	__builtin_alloca;
	cftime;
	closelog;
	csetcol;
	csetlen;
	ctermid_r;
	dbm_close;
	dbm_delete;
	dbm_fetch;
	dbm_firstkey;
	dbm_nextkey;
	dbm_open;
	dbm_store;
	decimal_to_double;
	decimal_to_extended;
	decimal_to_quadruple;
	decimal_to_single;
	double_to_decimal;
	drand48;
	econvert;
	ecvt;
	endnetgrent;
	endspent;
	endutent;
	endutxent;
	erand48;
	euccol;
	euclen;
	eucscol;
	extended_to_decimal;
	fchroot;
	fconvert;
	fcvt;
	ffs;
	fgetspent;
	fgetspent_r;
	_filbuf;
	file_to_decimal;
	finite;
	_flsbuf;
	fork1			;
	fpclass;
	fpgetmask;
	fpgetsticky;
	fpsetmask;
	fpsetsticky;
	fstatfs;
	ftruncate;
	ftw;
	func_to_decimal;
	gconvert;
	gcvt;
	getdents;
	gethrtime;
	gethrvtime;
	getmntany;
	getmntent;
	getnetgrent;
	getnetgrent_r;
	getpw;
	getspent;
	getspent_r;
	getspnam;
	getspnam_r;
	getutent;
	getutid;
	getutline;
	getutmp;
	getutmpx;
	getutxent;
	getutxid;
	getutxline;
	getvfsany;
	getvfsent;
	getvfsfile;
	getvfsspec;
	getwidth;
	gsignal;
	hasmntopt;
	innetgr;
	insque;
	_insque;
	jrand48;
	l64a;
	ladd;
	lckpwdf;
	lcong48;
	ldivide;
	lexp10;
	llabs;
	lldiv;
	llog10;
	llseek;
	lltostr;
	lmul;
	lrand48;
	lshiftl;
	lsub;
	_lwp_cond_broadcast;
	_lwp_cond_signal;
	_lwp_cond_timedwait;
	_lwp_cond_wait;
	_lwp_continue;
	_lwp_info;
	_lwp_kill;
	_lwp_mutex_lock;
	_lwp_mutex_trylock;
	_lwp_mutex_unlock;
	_lwp_self;
	_lwp_sema_init;
	_lwp_sema_post;
	_lwp_sema_wait;
	_lwp_suspend;
	madvise;
	__major;
	__makedev;
	mincore;
	__minor;
	mkstemp;
	_mkstemp;
	mlockall;
	mrand48;
	munlockall;
	_mutex_held		;
	_mutex_lock		;
	nrand48;
	_nss_netdb_aliases;
	_nss_XbyY_buf_alloc;
	_nss_XbyY_buf_free;
	__nsw_extended_action;
	__nsw_freeconfig;
	__nsw_getconfig;
	openlog;
	plock;
	p_online;
	pread;
	__priocntl;
	__priocntlset;
	processor_bind;
	processor_info;
	psiginfo;
	psignal;
	putpwent;
	putspent;
	pututline;
	pututxline;
	pwrite;
	qeconvert;
	qecvt;
	qfconvert;
	qfcvt;
	qgconvert;
	qgcvt;
	quadruple_to_decimal;
	realpath;
	remque;
	_remque;
	_rw_read_held;
	_rw_write_held;
	seconvert;
	seed48;
	select;
	_sema_held;
	setegid;
	seteuid;
	setlogmask;
	setnetgrent;
	setspent;
	settimeofday;
	setutent;
	setutxent;
	sfconvert;
	sgconvert;
	sig2str;
	sigwait;
	single_to_decimal;
	srand48;
	ssignal;
	statfs;
	str2sig;
	strcasecmp;
	string_to_decimal;
	strncasecmp;
	strsignal;
	strtoll;
	strtoull;
	swapctl;
	_syscall;
	sysfs;
	syslog;
	_syslog;
	tmpnam_r;
	truncate;
	ttyslot;
	uadmin;
	ulckpwdf;
	ulltostr;
	unordered;
	updwtmp;
	updwtmpx;
	ustat;
	utimes;
	utmpname;
	utmpxname;
	vfork;
	vhangup;
	vsyslog;
	yield;

#$if i386
	# Note: _syscall is also defined above. Here, we add the NODYNSORT
	# attribute to it. On this platform, it is an alias to syscall.
	# If that is changed, this lines should be removed.
	_syscall		;
#$endif

# The 32-bit sparc ABI requires SISCD_2.3. On other platforms, those symbols
# go directly into SUNW_0.7.
#$if sparc32
#} SISCD_2.3;

#SYMBOL_VERSION SISCD_2.3 {
#$endif

#    global:
	errno			;
	_iob;

#    protected:
	addseverity;
	_addseverity;
	asctime_r;
	crypt;
	_crypt;
	ctime_r;
	encrypt;
	_encrypt;
	endgrent;
	endpwent;
	___errno;
	fgetgrent;
	fgetgrent_r;
	fgetpwent;
	fgetpwent_r;
	flockfile;
	funlockfile;
	getchar_unlocked;
	getc_unlocked;
	getgrent;
	getgrent_r;
	getgrgid_r;
	getgrnam_r;
	getitimer;
	_getitimer;
	getlogin_r;
	getpwent;
	getpwent_r;
	getpwnam_r;
	getpwuid_r;
	gettimeofday;
	_gettimeofday;
	gmtime_r;
	localtime_r;
	putchar_unlocked;
	putc_unlocked;
	rand_r;
	readdir_r;
	setgrent;
	setitimer;
	_setitimer;
	setkey;
	_setkey;
	setpwent;
	strtok_r;
	sysinfo;
	_sysinfo;
	ttyname_r;

#$if _ELF32
	__div64;
	__mul64;
	__rem64;
	__udiv64;
	__urem64;
#$endif

#$if sparc32
	__dtoll;
	__dtoull;
	__ftoll;
	__ftoull;
	_Q_lltoq;
	_Q_qtoll;
	_Q_qtoull;
	_Q_ulltoq;
	sbrk;
	_sbrk;
	__umul64		;	# Same address as __mul64
#$endif

# On 32-bit platforms, the following symbols go into SYSVABI_1.3, but on
# other platforms they go directly into the current version (which will be
# either SUNW_0.7, or SISCD_2.3, depending on the similar issue described above.
#$if _ELF32
#} SYSVABI_1.3;

#SYMBOL_VERSION SYSVABI_1.3 {
#$endif

#    global:
	_altzone;
	calloc			;
	__ctype;
	daylight;
	_daylight;
	environ			;
	_environ		;
	free			;
	frexp			;
	getdate_err;
	_getdate_err;
	getenv;
	__huge_val;
	__iob;
	isnan			;
	_isnan			;
	isnand			;
	_isnand			;
	ldexp			;
	logb			;
	malloc			;
	memcmp;
	memcpy;
	memmove;
	memset;
	modf			;
	_modf			;
	nextafter		;
	_nextafter		;
	_numeric;
	optarg;
	opterr;
	optind;
	optopt;
	realloc			;
	scalb			;
	_scalb			;
	timezone;
	_timezone;
	tzname;
	_tzname;
#$if i386
	_fp_hw;
#$endif

#    protected:
	abort;
	abs;
	access;
	_access;
	acct;
	_acct;
	alarm;
	_alarm;
	asctime;
	__assert;
	atexit;
	atof;
	atoi;
	atol;
	bsearch;
	catclose;
	_catclose;
	catgets;
	_catgets;
	catopen;
	_catopen;
	cfgetispeed;
	_cfgetispeed;
	cfgetospeed;
	_cfgetospeed;
	cfsetispeed;
	_cfsetispeed;
	cfsetospeed;
	_cfsetospeed;
	chdir;
	_chdir;
	chmod;
	_chmod;
	chown;
	_chown;
	chroot;
	_chroot;
	_cleanup;
	clearerr;
	clock;
	_close;
	close;
	closedir;
	_closedir;
	creat;
	_creat;
	ctermid;
	ctime;
	cuserid;
	_cuserid;
	difftime;
	div;
	dup;
	_dup;
	dup2;
	_dup2;
	execl;
	_execl;
	execle;
	_execle;
	execlp;
	_execlp;
	execv;
	_execv;
	execve;
	_execve;
	execvp;
	_execvp;
	exit;
	_exit;
	fattach;
	_fattach;
	fchdir;
	_fchdir;
	fchmod;
	_fchmod;
	fchown;
	_fchown;
	fclose;
	fcntl;
	_fcntl;
	fdetach;
	_fdetach;
	fdopen;
	_fdopen;
	feof;
	ferror;
	fflush;
	fgetc;
	fgetpos;
	fgets;
	__filbuf;
	fileno;
	_fileno;
	__flsbuf;
	fmtmsg;
	_fmtmsg;
	fopen;
	_fork;
	fork;
	fpathconf;
	_fpathconf;
	fprintf;
	fputc;
	fputs;
	fread;
	freopen;
	fscanf;
	fseek;
	fsetpos;
	fstat;
	_fstat;
	fstatvfs;
	_fstatvfs;
	fsync;
	_fsync;
	ftell;
	ftok;
	_ftok;
	fwrite;
	getc;
	getchar;
	getcontext;
	_getcontext;
	getcwd;
	_getcwd;
	getdate;
	_getdate;
	getegid;
	_getegid;
	geteuid;
	_geteuid;
	getgid;
	_getgid;
	getgrgid;
	getgrnam;
	getgroups;
	_getgroups;
	getlogin;
	getmsg;
	_getmsg;
	getopt;
	_getopt;
	getpass;
	_getpass;
	getpgid;
	_getpgid;
	getpgrp;
	_getpgrp;
	getpid;
	_getpid;
	getpmsg;
	_getpmsg;
	getppid;
	_getppid;
	getpwnam;
	getpwuid;
	getrlimit;
	_getrlimit;
	gets;
	getsid;
	_getsid;
	getsubopt;
	_getsubopt;
	gettxt;
	_gettxt;
	getuid;
	_getuid;
	getw;
	_getw;
	gmtime;
	grantpt;
	_grantpt;
	hcreate;
	_hcreate;
	hdestroy;
	_hdestroy;
	hsearch;
	_hsearch;
	initgroups;
	_initgroups;
	ioctl;
	_ioctl;
	isalnum;
	isalpha;
	isascii;
	_isascii;
	isastream;
	_isastream;
	isatty;
	_isatty;
	iscntrl;
	isdigit;
	isgraph;
	islower;
	isprint;
	ispunct;
	isspace;
	isupper;
	isxdigit;
	kill;
	_kill;
	labs;
	lchown;
	_lchown;
	ldiv;
	lfind;
	_lfind;
	link;
	_link;
	localeconv;
	localtime;
	lockf;
	_lockf;
	longjmp;
	lsearch;
	_lsearch;
	lseek;
	_lseek;
	lstat;
	_lstat;
	makecontext;
	_makecontext;
	mblen;
	mbstowcs;
	mbtowc;
	memccpy;
	_memccpy;
	memchr;
	memcntl;
	_memcntl;
	mkdir;
	_mkdir;
	mkfifo;
	_mkfifo;
	mknod;
	_mknod;
	mktemp;
	_mktemp;
	mktime;
	mlock;
	_mlock;
	mmap;
	_mmap;
	monitor;
	_monitor;
	mount;
	_mount;
	mprotect;
	_mprotect;
	msgctl;
	_msgctl;
	msgget;
	_msgget;
	msgrcv;
	_msgrcv;
	msgsnd;
	_msgsnd;
	msync;
	_msync;
	munlock;
	_munlock;
	munmap;
	_munmap;
	nftw;
	_nftw;
	nice;
	_nice;
	nl_langinfo;
	_nl_langinfo;
	open;
	_open;
	opendir;
	_opendir;
	pathconf;
	_pathconf;
	pause;
	_pause;
	pclose;
	_pclose;
	perror;
	pipe;
	_pipe;
	poll;
	_poll;
	popen;
	_popen;
	printf;
	profil;
	_profil;
	ptsname;
	_ptsname;
	putc;
	putchar;
	putenv;
	_putenv;
	putmsg;
	_putmsg;
	putpmsg;
	_putpmsg;
	puts;
	putw;
	_putw;
	qsort;
	raise;
	rand;
	read;
	_read;
	readdir;
	_readdir;
	readlink;
	_readlink;
	readv;
	_readv;
	remove;
	rename;
	_rename;
	rewind;
	rewinddir;
	_rewinddir;
	rmdir;
	_rmdir;
	scanf;
	seekdir;
	_seekdir;
	semctl;
	_semctl;
	semget;
	_semget;
	semop;
	_semop;
	setbuf;
	setcontext;
	_setcontext		;
	setgid;
	_setgid;
	setgroups;
	_setgroups;
	setjmp;
	setlabel;
	setlocale;
	setpgid;
	_setpgid;
	setpgrp;
	_setpgrp;
	setrlimit;
	_setrlimit;
	setsid;
	_setsid;
	setuid;
	_setuid;
	setvbuf;
	shmat;
	_shmat;
	shmctl;
	_shmctl;
	shmdt;
	_shmdt;
	shmget;
	_shmget;
	sigaction;
	_sigaction		;
	sigaddset;
	_sigaddset;
	sigaltstack;
	_sigaltstack;
	sigdelset;
	_sigdelset;
	sigemptyset;
	_sigemptyset;
	sigfillset;
	_sigfillset;
	sighold;
	_sighold;
	sigignore;
	_sigignore;
	sigismember;
	_sigismember;
	siglongjmp;
	_siglongjmp;
	signal;
	sigpause;
	_sigpause;
	sigpending;
	_sigpending;
	sigprocmask;
	_sigprocmask;
	sigrelse;
	_sigrelse;
	sigsend;
	_sigsend;
	sigsendset;
	_sigsendset;
	sigset;
	_sigset;
	sigsetjmp;
	_sigsetjmp		;
	sigsuspend;
	_sigsuspend;
	sleep;
	_sleep;
	sprintf;
	srand;
	sscanf;
	stat;
	_stat;
	statvfs;
	_statvfs;
	stime;
	_stime;
	strcat;
	strchr;
	strcmp;
	strcoll;
	strcpy;
	strcspn;
	strdup;
	_strdup;
	strerror;
	strftime;
	strlen;
	strncat;
	strncmp;
	strncpy;
	strpbrk;
	strrchr;
	strspn;
	strstr;
	strtod;
	strtok;
	strtol;
	strtoul;
	strxfrm;
	swab;
	_swab;
	swapcontext;
	_swapcontext;
	symlink;
	_symlink;
	sync;
	_sync;
	sysconf;
	_sysconf;
	system;
	tcdrain;
	_tcdrain;
	tcflow;
	_tcflow;
	tcflush;
	_tcflush;
	tcgetattr;
	_tcgetattr;
	tcgetpgrp;
	_tcgetpgrp;
	tcgetsid;
	_tcgetsid;
	tcsendbreak;
	_tcsendbreak;
	tcsetattr;
	_tcsetattr;
	tcsetpgrp;
	_tcsetpgrp;
	tdelete;
	_tdelete;
	tell;
	_tell;
	telldir;
	_telldir;
	tempnam;
	_tempnam;
	tfind;
	_tfind;
	time;
	_time;
	times;
	_times;
	tmpfile;
	tmpnam;
	toascii;
	_toascii;
	tolower;
	_tolower;
	toupper;
	_toupper;
	tsearch;
	_tsearch;
	ttyname;
	twalk;
	_twalk;
	tzset;
	_tzset;
	ulimit;
	_ulimit;
	umask;
	_umask;
	umount;
	_umount;
	uname;
	_uname;
	ungetc;
	unlink;
	_unlink;
	unlockpt;
	_unlockpt;
	utime;
	_utime;
	vfprintf;
	vprintf;
	vsprintf;
	wait;
	_wait;
	waitid;
	_waitid;
	waitpid;
	_waitpid;
	wcstombs;
	wctomb;
	write;
	_write;
	writev;
	_writev;
	_xftw;

#$if _ELF32
	ptrace;
	_ptrace;
#$endif

#$if i386
	_fxstat;
	_lxstat;
	nuname;
	_nuname;
	_xmknod;
	_xstat;
#$endif

#$if !sparc32
	sbrk;
#$endif

#$if _sparc
	__dtou;
	__ftou;
#$endif

#$if sparc32
	.div;
	.mul;
	.rem;
	.stret1;
	.stret2;
	.stret4;
	# .stret4 and .stret8 are the same thing
	.stret8			;
	.udiv;
	.umul;
	.urem;
	_Q_add;
	_Q_cmp;
	_Q_cmpe;
	_Q_div;
	_Q_dtoq;
	_Q_feq;
	_Q_fge;
	_Q_fgt;
	_Q_fle;
	_Q_flt;
	_Q_fne;
	_Q_itoq;
	_Q_mul;
	_Q_neg;
	_Q_qtod;
	_Q_qtoi;
	_Q_qtos;
	_Q_qtou;
	_Q_sqrt;
	_Q_stoq;
	_Q_sub;
	_Q_utoq;
#$endif

#$if sparcv9
	# __align_cpy_1 is an alias for memcpy. Filter it out of
	# the .SUNW_dynsymsort section
	__align_cpy_1		;
	__align_cpy_16;
	__align_cpy_2;
	__align_cpy_4;
	# __align_cpy_8 is same as __align_cpy_16
	__align_cpy_8		;
	__dtoul;
	__ftoul;
	_Qp_add;
	_Qp_cmp;
	_Qp_cmpe;
	_Qp_div;
	_Qp_dtoq;
	_Qp_feq;
	_Qp_fge;
	_Qp_fgt;
	_Qp_fle;
	_Qp_flt;
	_Qp_fne;
	_Qp_itoq;
	_Qp_mul;
	_Qp_neg;
	_Qp_qtod;
	_Qp_qtoi;
	_Qp_qtos;
	_Qp_qtoui;
	_Qp_qtoux;
	_Qp_qtox;
	_Qp_sqrt;
	_Qp_stoq;
	_Qp_sub;
	_Qp_uitoq;
	_Qp_uxtoq;
	_Qp_xtoq;
	__sparc_utrap_install;
#$endif

# On amd64, we also have SYSVABI_1.3, but it contains a small subset of
# the symbols put in that version on other platforms.
#$if amd64
#} SYSVABI_1.3;

#SYMBOL_VERSION SYSVABI_1.3 { 
#$endif
#    global:
#$if !_sparc
	__flt_rounds;
#$endif

#    protected:
	_ctermid;
	_getgrgid;
	_getgrnam;
	_getlogin;
	_getpwnam;
	_getpwuid;
	_ttyname;

#$if !sparc32
	_sbrk;
#$endif

#$if _x86
	_fpstart;
	__fpstart;
#$endif
#};



# There should never be more than one SUNWprivate version.
# Don't add any more.  Add new private symbols to SUNWprivate_1.1

#SYMBOL_VERSION SUNWprivate_1.1 {
#    global:
	___Argv			;
	cfree			;
	_cswidth;
	__ctype_mask;
	__environ_lock		;
	__inf_read;
	__inf_written;
	__i_size;
	_isnanf			;
	__iswrune;
	__libc_threaded;
	_lib_version		;
	_logb			;
	_lone			;
	_lten			;
	_lzero			;
	__malloc_lock;
	_memcmp;
	_memcpy			;
	_memmove;
	_memset;
	_modff			;
	__nan_read;
	__nan_written;
	__nextwctype;
	__nis_debug_bind;
	__nis_debug_calls;
	__nis_debug_file;
	__nis_debug_rpc;
	__nis_prefsrv;
	__nis_preftype;
	__nis_server;
	_nss_default_finders;
	__progname		;
	_smbuf;
	_sp;
	__strdupa_str		;
	__strdupa_len		;
	_tdb_bootstrap;
	__threaded;
	thr_probe_getfunc_addr;
	__trans_lower;
	__trans_upper;
	_uberdata;
	__xpg6			;

#$if _ELF32
	_dladdr			;
	_dladdr1		;
	_dlclose		;
	_dldump			;
	_dlerror		;
	_dlinfo			;
	_dlmopen		;
	_dlopen			;
	_dlsym			;
	_ld_libc		;
	_sys_errlist;
	_sys_errs;
	_sys_index;
	_sys_nerr		;
	_sys_num_err;
#$elif sparcv9
	_dladdr		;
	_dladdr1	;
	_dlclose	;
	_dldump		;
	_dlerror	;
	_dlinfo		;
	_dlmopen	;
	_dlopen		;
	_dlsym		;
	_ld_libc	;
#$elif amd64
	_dladdr		;
	_dladdr1	;
	_dlamd64getunwind ;
	_dlclose	;
	_dldump		;
	_dlerror	;
	_dlinfo		;
	_dlmopen	;
	_dlopen		;
	_dlsym		;
	_ld_libc	;
#$else
#$error unknown platform
#$endif

#$if _sparc
	__lyday_to_month;
	__mon_lengths;
	__yday_to_month;
#$endif
#$if i386
	_sse_hw;
#$endif

#    protected:
	acctctl;
	allocids;
	_assert_c99;
	__assert_c99;
	_assfail;
	attr_count;
	attr_to_data_type;
	attr_to_name;
	attr_to_option;
	attr_to_xattr_view;	
	_autofssys;
	_bufsync;
	_cladm;
	__class_quadruple;
	core_get_default_content;
	core_get_default_path;
	core_get_global_content;
	core_get_global_path;
	core_get_options;
	core_get_process_content;
	core_get_process_path;
	core_set_default_content;
	core_set_default_path;
	core_set_global_content;
	core_set_global_path;
	core_set_options;
	core_set_process_content;
	core_set_process_path;
	dbm_close_status;
	dbm_do_nextkey;
	dbm_setdefwrite;
	_D_cplx_div;
	_D_cplx_div_ix;
	_D_cplx_div_rx;
	_D_cplx_mul;
	defclose_r;
	defcntl;
	defcntl_r;
	defopen;
	defopen_r;
	defread;
	defread_r;
	_delete;
	_dgettext;
	_doprnt;
	_doscan;
	_errfp;
	_errxfp;
	exportfs;
	_F_cplx_div;
	_F_cplx_div_ix;
	_F_cplx_div_rx;
	_F_cplx_mul;
	__fgetwc_xpg5;
	__fgetws_xpg5;
	_findbuf;
	_findiop;
	__fini_daemon_priv;
	_finite;
	_fork1			;
	_forkall		;
	_fpclass;
	_fpgetmask;
	_fpgetround;
	_fpgetsticky;
	_fprintf;
	_fpsetmask;
	_fpsetround;
	_fpsetsticky;
	__fputwc_xpg5;
	__fputws_xpg5;
	_ftw;
	_gcvt;
	_getarg;
	__getcontext;
	_getdents;
	_get_exit_frame_monitor;
	_getfp;
	_getgroupsbymember;
	_getlogin_r;
	getrandom;
	_getsp;
	__gettsp;
	getvmusage;
	__getwchar_xpg5;
	__getwc_xpg5;
	gtty;
	__idmap_flush_kcache;
	__idmap_reg;
	__idmap_unreg;
	__init_daemon_priv;
	__init_suid_priv;
	_insert;
	inst_sync;
	_iswctype;
	klpd_create;
	klpd_getpath;
	klpd_getport;
	klpd_getucred;
	klpd_register;
	klpd_register_id;
	klpd_unregister;
	klpd_unregister_id;
	_lgrp_home_fast		;
	_lgrpsys;
	_lltostr;
	_lock_clear;
	_lock_try;
	_ltzset;
	lwp_self;
	makeut;
	makeutx;
	_mbftowc;
	mcfiller;
	mntopt;
	modctl;
	modutx;
	msgctl64;
	__multi_innetgr;
	_mutex_destroy		;
	mutex_enter;
	mutex_exit;
	mutex_held;
	_mutex_init		;
	_mutex_unlock		;
	name_to_attr;
	nfs_getfh;
	nfssvc;
	_nfssys;
	__nis_get_environment;
	_nss_db_state_destr;
	nss_default_key2str;
	nss_delete;
	nss_endent;
	nss_getent;
	_nss_initf_group;
	_nss_initf_netgroup;
	_nss_initf_passwd;
	_nss_initf_shadow;
	nss_packed_arg_init;
	nss_packed_context_init;
	nss_packed_getkey;
	nss_packed_set_status;
	nss_search;
	nss_setent;
	_nss_XbyY_fgets;
	_nss_XbyY_fini;
	__nsw_extended_action_v1;
	__nsw_freeconfig_v1;
	__nsw_getconfig_v1;
	__nthreads;
	__openattrdirat;
	option_to_attr;
	__priv_bracket;
	__priv_relinquish;
	psecflags;
	pset_assign_forced;
	pset_bind_lwp;
	_psignal;
	pthread_attr_getdaemonstate_np;
	pthread_attr_setdaemonstate_np;
	_pthread_setcleanupinit;
	__putwchar_xpg5;
	__putwc_xpg5;
	rctlctl;
	rctllist;
	_realbufend;
	_resume;
	_resume_ret;
	_rpcsys;
	_sbrk_grow_aligned;
	scrwidth;
	secflag_by_name;
	secflag_clear;
	secflags_copy;
	secflags_difference;
	secflags_fullset;
	secflags_intersection;
	secflags_isempty;
	secflag_isset;
	secflags_issubset;
	secflags_issuperset;
	secflag_set;
	secflag_to_bit;
	secflag_to_str;
	secflags_union;
	psecflags_validate_delta;
	secflags_zero;
	psecflags_default;
	secflags_parse;
	secflags_to_str;
	psecflags_validate;
	semctl64;
	_semctl64;
	set_setcontext_enforcement;
	_setbufend;
	__set_errno;
	setprojrctl;
	_setregid;
	_setreuid;
	setsigacthandler;
	shmctl64;
	_shmctl64;
	sigflag;
	_signal;
	_sigoff;
	_sigon;
	_so_accept;
	_so_bind;
	_sockconfig;
	_so_connect;
	_so_getpeername;
	_so_getsockname;
	_so_getsockopt;
	_so_listen;
	_so_recv;
	_so_recvfrom;
	_so_recvmsg;
	_so_send;
	_so_sendmsg;
	_so_sendto;
	_so_setsockopt;
	_so_shutdown;
	_so_socket;
	_so_socketpair;
	str2group;
	str2passwd;
	str2spwd;
	__strptime_dontzero;
	stty;
	syscall;
	_sysconfig;
	__systemcall;
	thr_continue_allmutators;
	_thr_continue_allmutators;
	thr_continue_mutator;
	_thr_continue_mutator;
	thr_getstate;
	_thr_getstate;
	thr_mutators_barrier;
	_thr_mutators_barrier;
	thr_probe_setup;
	_thr_schedctl;
	thr_setmutator;
	_thr_setmutator;
	thr_setstate;
	_thr_setstate;
	thr_sighndlrinfo;
	_thr_sighndlrinfo;
	_thr_slot_offset;
	thr_suspend_allmutators;
	_thr_suspend_allmutators;
	thr_suspend_mutator;
	_thr_suspend_mutator;
	thr_wait_mutator;
	_thr_wait_mutator;
	__tls_get_addr;
	_tmem_get_base;
	_tmem_get_nentries;
	_tmem_set_cleanup;
	tpool_create;
	tpool_dispatch;
	tpool_destroy;
	tpool_wait;
	tpool_suspend;
	tpool_suspended;
	tpool_resume;
	tpool_member;
	_ttyname_dev;
	_ucred_alloc;
	ucred_getamask;
	_ucred_getamask;
	ucred_getasid;
	_ucred_getasid;
	ucred_getatid;
	_ucred_getatid;
	ucred_getauid;
	_ucred_getauid;
	_ulltostr;
	_uncached_getgrgid_r;
	_uncached_getgrnam_r;
	_uncached_getpwnam_r;
	_uncached_getpwuid_r;
	__ungetwc_xpg5;
	_unordered;
	utssys;
	_verrfp;
	_verrxfp;
	_vwarnfp;
	_vwarnxfp;
	_warnfp;
	_warnxfp;
	__wcsftime_xpg5;
	__wcstok_xpg5;
	wdbindf;
	wdchkind;
	wddelim;
	_wrtchk;
	_xflsbuf;
	_xgetwidth;
	zone_add_datalink;
	zone_boot;
	zone_check_datalink;
	zone_create;
	zone_destroy;
	zone_enter;
	zone_getattr;
	zone_get_id;
	zone_list;
	zone_list_datalink;
	zonept;
	zone_remove_datalink;
	zone_setattr;
	zone_shutdown;
	zone_version;

#$if _ELF32
	__divdi3;
	_file_set;
	_fprintf_c89;
	_fscanf_c89;
	_fwprintf_c89;
	_fwscanf_c89;
	_imaxabs_c89;
	_imaxdiv_c89;
	__moddi3;
	_printf_c89;
	_scanf_c89;
	_snprintf_c89;
	_sprintf_c89;
	_sscanf_c89;
	_strtoimax_c89;
	_strtoumax_c89;
	_swprintf_c89;
	_swscanf_c89;
	__udivdi3;
	__umoddi3;
	_vfprintf_c89;
	_vfscanf_c89;
	_vfwprintf_c89;
	_vfwscanf_c89;
	_vprintf_c89;
	_vscanf_c89;
	_vsnprintf_c89;
	_vsprintf_c89;
	_vsscanf_c89;
	_vswprintf_c89;
	_vswscanf_c89;
	_vwprintf_c89;
	_vwscanf_c89;
	_wcstoimax_c89;
	_wcstoumax_c89;
	_wprintf_c89;
	_wscanf_c89;
#$endif

#$if _sparc
	_cerror;
	install_utrap;
	_install_utrap;
	nop;
	_Q_cplx_div;
	_Q_cplx_div_ix;
	_Q_cplx_div_rx;
	_Q_cplx_lr_div;
	_Q_cplx_lr_div_ix;
	_Q_cplx_lr_div_rx;
	_Q_cplx_lr_mul;
	_Q_cplx_mul;
	_QgetRD;
	_xregs_clrptr;
#$endif

#$if sparc32
	__ashldi3;
	__ashrdi3;
	_cerror64;
	__cmpdi2;
	__floatdidf;
	__floatdisf;
	__floatundidf;
	__floatundisf;
	__lshrdi3;
	__muldi3;
	__ucmpdi2;
#$endif

#$if _x86
	_D_cplx_lr_div;
	_D_cplx_lr_div_ix;
	_D_cplx_lr_div_rx;
	_F_cplx_lr_div;
	_F_cplx_lr_div_ix;
	_F_cplx_lr_div_rx;
	__fltrounds;
	sysi86;
	_sysi86;
	_X_cplx_div;
	_X_cplx_div_ix;
	_X_cplx_div_rx;
	_X_cplx_lr_div;
	_X_cplx_lr_div_ix;
	_X_cplx_lr_div_rx;
	_X_cplx_mul;
	__xgetRD;
	__xtol;
	__xtoll;
	__xtoul;
	__xtoull;
#$endif

#$if i386
	__divrem64;
	___tls_get_addr;
	__udivrem64;
#$endif

# The following functions should not be exported from libc,
# but /lib/libm.so.2, some older versions of the Studio
# compiler/debugger components, and some ancient programs
# found in /usr/dist reference them.  When we no longer
# care about these old and broken binary objects, these
# symbols should be deleted.
	_brk					;
	_cond_broadcast				;
	_cond_init				;
	_cond_signal				;
	_cond_wait				;
	_ecvt					;
	_fcvt					;
	_getc_unlocked				;
	_llseek					;
	_pthread_attr_getdetachstate		;
	_pthread_attr_getinheritsched		;
	_pthread_attr_getschedparam		;
	_pthread_attr_getschedpolicy		;
	_pthread_attr_getscope			;
	_pthread_attr_getstackaddr		;
	_pthread_attr_getstacksize		;
	_pthread_attr_init			;
	_pthread_condattr_getpshared		;
	_pthread_condattr_init			;
	_pthread_cond_init			;
	_pthread_create				;
	_pthread_getschedparam			;
	_pthread_join				;
	_pthread_key_create			;
	_pthread_mutexattr_getprioceiling	;
	_pthread_mutexattr_getprotocol		;
	_pthread_mutexattr_getpshared		;
	_pthread_mutexattr_init			;
	_pthread_mutex_getprioceiling		;
	_pthread_mutex_init			;
	_pthread_sigmask			;
	_rwlock_init				;
	_rw_rdlock				;
	_rw_unlock				;
	_rw_wrlock				;
	_sbrk_unlocked				;
	_select					;
	_sema_init				;
	_sema_post				;
	_sema_trywait				;
	_sema_wait				;
	_sysfs					;
	_thr_create				;
	_thr_exit				;
	_thr_getprio				;
	_thr_getspecific			;
	_thr_join				;
	_thr_keycreate				;
	_thr_kill				;
	_thr_main				;
	_thr_self				;
	_thr_setspecific			;
	_thr_sigsetmask				;
	_thr_stksegment				;
	_ungetc_unlocked			;


# for alpha
	__divl;
	__divlu;
	__divq;
	__divqu;
	__reml;
	__remlu;
	__remq;
	__remqu;

	__bss_start;
	_edata;
	_end;
	_fini;
	_init;


    local:
	__imax_lldiv				;
	_ti_thr_self				;
	*;

#$if lf64
	_seekdir64		;
	_telldir64		;
#$endif

#$if _sparc
	__cerror		;
#$endif

#$if sparc32
	__cerror64		;
#$endif

#$if sparcv9
	__cleanup		;
#$endif

#$if i386
	_syscall6		;
	__systemcall6		;
#$endif

#$if amd64
	___tls_get_addr		;
#$endif
};
