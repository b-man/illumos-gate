#!/bin/ksh -p
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
# Copyright 2008 Sun Microsystems, Inc.  All rights reserved.
# Use is subject to license terms.
#
#ident	"%Z%%M%	%I%	%E% SMI"
#

#
# Copyright (c) 2006-2009 NEC Corporation
# Copyright (c) 2020 Brian McKenzie
#

##
## Create runtime configuration file of the build tools.
##

CAT=/bin/cat
PWD=/bin/pwd
WHO=/bin/who
UNAME=/bin/uname
BASENAME=/bin/basename
DIRNAME=/bin/dirname
AWK=/bin/awk

aarch64_COMPILER_TARGET=${aarch64_COMPILER_TARGET:-aarch64-solaris2.11}
aarch64_COMPILER_PREFIX=${aarch64_COMPILER_PREFIX:-/opt/corss-aarch64}
aarch64_COMPILER_ROOT=${aarch64_COMPILER_ROOT:-${aarch64_COMPILER_PREFIX}/${aarch64_COMPILER_TARGET}}
aarch64_DEFAULT_SYSROOT=${aarch64_DEFAULT_SYSROOT:-${aarch64_COMPILER_PREFIX}/sysroot}

# Specify platform for Aarch64 explicitly.
AARCH64_PLATFORM=${AARCH64_PLATFORM:-virt}

get_workspace_root()
{
	dir=`$PWD`
	while [ ! -d $dir/usr -o ! -d $dir/usr/src -o \
		! -f $dir/usr/src/OPENSOLARIS.LICENSE ]; do
	if [ $dir = "/" ]; then
		echo "Can't detect workspace path." >&2
		exit 1
	fi
	dir=`$DIRNAME $dir`
	done
	workspace=$dir
}


dump_config()
{
	ws=$1
	staffer=$2
	mach=$3

	gate=`$BASENAME $ws`
	native_mach=`$UNAME -p`

	cross=`eval echo '$'"${mach}"_COMPILER_ROOT`
	target=
	xtarget=
	xprefix=
	xtool_prefix=
	xsysroot=
	if [ "$cross" != "" ]; then
		# Use cross compiler
		cross="GNU_ROOT=${cross};                               export GNU_ROOT"
		prefix=`eval echo '$'"${mach}"_COMPILER_PREFIX`
		xprefix="GNU_PREFIX=${prefix};                          export GNU_PREFIX"
		xld_prefix="LD_PREFIX=${prefix};                        export LD_PREFIX"

		target=`eval echo '$'"${mach}"_COMPILER_TARGET`
		xtarget="GNU_TOOL_TARGET=${target};                     export GNU_TOOL_TARGET"
		xtool_prefix="GNU_TOOL_PREFIX=${target}-;               export GNU_TOOL_PREFIX"
		sysroot=`eval echo '$'"${mach}"_DEFAULT_SYSROOT`
		xsysroot="DEFAULT_SYSROOT=${sysroot};                   export DEFAULT_SYSROOT"
	fi

	fname="illumos-${mach}.sh"
	$CAT > $fname <<EOF

#
#	Configuration variables for the runtime environment of the nightly
#	build script and other tools for construction and packaging of releases.
#	This script is sourced by 'nightly' and 'bldenv' to set up the environment
#	for the build. This example is suitable for building an OpenSolaris
#	workspace, which will contain the resulting archives. It is based
#	off the onnv release. It sets NIGHTLY_OPTIONS to make nightly do:
#	DEBUG build only (-D, -F)
#	do not run protocmp or checkpaths (-N)
#	do not bringover from the parent (-n)
#	creates cpio archives for bfu (-a)
#	runs 'make check' (-C)
#	runs lint in usr/src (-l plus the LINTDIRS variable)
#	sends mail on completion (-m and the MAILTO variable)
#	checks for changes in ELF runpaths (-r)
#	build and use this workspace's tools in $SRC/tools (-t)
#
NIGHTLY_OPTIONS="-FNnDt";	        export NIGHTLY_OPTIONS

# This is a variable for the rest of the script - GATE doesn't matter to
# nightly itself
GATE=$gate;                             export GATE

# CODEMGR_WS - where is your workspace at (or what should nightly name it)
CODEMGR_WS="$ws";                       export CODEMGR_WS

# This flag controls whether to build the closed source.  If
# undefined, nightly(1) and bldenv(1) will set it according to whether
# the closed source tree is present.  CLOSED_IS_PRESENT="no" means not
# building the closed sources.
CLOSED_IS_PRESENT="no";                 export CLOSED_IS_PRESENT

# Maximum number of dmake jobs.  The recommended number is 2 + NCPUS,
# where NCPUS is the number of logical CPUs on your build system.
function maxjobs
{
	nameref maxjobs=\$1
	integer ncpu
	integer -r min_mem_per_job=512 # minimum amount of memory for a job

	ncpu=\$(builtin getconf ; getconf 'NPROCESSORS_ONLN')
	(( maxjobs=ncpu + 2 ))

	# Throttle number of parallel jobs launched by dmake to a value which
	# gurantees that all jobs have enough memory. This was added to avoid
	# excessive paging/swapping in cases of virtual machine installations
	# which have lots of CPUs but not enough memory assigned to handle
	# that many parallel jobs
	if [[ \$(/usr/sbin/prtconf 2>'/dev/null') == ~(E)Memory\ size:\ ([[:digit:]]+)\ Megabytes ]] ; then
		integer max_jobs_per_memory # parallel jobs which fit into physical memory
		integer physical_memory # physical memory installed

		# The array ".sh.match" contains the contents of capturing
		# brackets in the last regex, .sh.match[1] will contain
		# the value matched by ([[:digit:]]+), i.e. the amount of
		# memory installed
		physical_memory="10#\${.sh.match[1]}"

		((
			max_jobs_per_memory=round(physical_memory/min_mem_per_job) ,
			maxjobs=fmax(2, fmin(maxjobs, max_jobs_per_memory))
		))
	fi

	return 0
}
maxjobs DMAKE_MAX_JOBS # "DMAKE_MAX_JOBS" passed as ksh(1) name reference
export DMAKE_MAX_JOBS

# path to onbld tool binaries
ONBLD_BIN="/opt/onbld/bin"

# PARENT_WS is used to determine the parent of this workspace. This is
# for the options that deal with the parent workspace (such as where the
# proto area will go).
PARENT_WS="";                           export PARENT_WS

# CLONE_WS is the workspace nightly should do a bringover from. Since it's
# going to bringover usr/src, this could take a while, so we use the
# clone instead of the gate (see the gate's README).
CLONE_WS="";                            export CLONE_WS

# The bringover, if any, is done as STAFFER.
# Set STAFFER to your own login as gatekeeper or developer
# The point is to use group "staff" and avoid referencing the parent
# workspace as root.
export STAFFER="$LOGNAME"
export MAILTO="${MAILTO:-$STAFFER}"

# If you wish the mail messages to be From: an arbitrary address, export
# MAILFROM.
#export MAILFROM="user@example.com"

# The project (see project(4)) under which to run this build.  If not
# specified, the build is simply run in a new task in the current project.
BUILD_PROJECT=;				export BUILD_PROJECT

# You should not need to change the next four lines
ATLOG="\$CODEMGR_WS/log";               export ATLOG
LOGFILE="\$ATLOG/nightly.log";          export LOGFILE
MACH=$mach;                             export MACH
NATIVE_MACH=$native_mach;               export NATIVE_MACH

#
#  The following macro points to the closed binaries.  Once illumos has
#  totally freed itself, we can remove this reference.
#
# Location of encumbered binaries.
#export ON_CLOSED_BINS="$CODEMGR_WS/closed"

# REF_PROTO_LIST - for comparing the list of stuff in your proto area
# with. Generally this should be left alone, since you want to see differences
# from your parent (the gate).
#
export REF_PROTO_LIST="$PARENT_WS/usr/src/proto_list_\${MACH}"

#
# build environment variables, including version info for mcs, motd,
# motd, uname and boot messages. Mostly you shouldn't change this except
# when the release slips (nah) or you move an environment file to a new
# release
#
ROOT="\$CODEMGR_WS/proto/root_\${MACH}";               export ROOT
SRC="\$CODEMGR_WS/usr/src";                            export SRC
MULTI_PROTO="no";                                      export MULTI_PROTO
VERSION="`git describe --long --all HEAD | cut -d/ -f2-`"; export VERSION

#
# the RELEASE and RELEASE_DATE variables are set in Makefile.master;
# there might be special reasons to override them here, but that
# should not be the case in general
#
# RELEASE="5.11";                       export RELEASE
# RELEASE_DATE="October 2007";          export RELEASE_DATE

# proto area in parent for optionally depositing a copy of headers and
# libraries corresponding to the protolibs target
# not applicable given the NIGHTLY_OPTIONS
#
PARENT_ROOT=\$PARENT_WS/proto/root_\$MACH;             export PARENT_ROOT
PARENT_TOOLS_ROOT="\$PARENT_WS/usr/src/tools/proto/root_\$MACH-nd"; export PARENT_TOOLS_ROOT

#
#       package creation variable. you probably shouldn't change this either.
#
PKGARCHIVE="\${CODEMGR_WS}/packages/\${MACH}/nightly"; export PKGARCHIVE
# export PKGPUBLISHER_REDIST='on-redist'

# Package manifest format version.
export PKGFMT_OUTPUT='v1'

# we want make to do as much as it can, just in case there's more than
# one problem.
MAKEFLAGS=k;	export MAKEFLAGS

# Magic variable to prevent the devpro compilers/teamware from sending
# mail back to devpro on every use.
SUNW_NO_UPDATE_NOTIFY="1"; export SUNW_NO_UPDATE_NOTIFY
UT_NO_USAGE_TRACKING="1"; export UT_NO_USAGE_TRACKING

# Build tools - don't change these unless you know what you're doing.  These
# variables allows you to get the compilers and onbld files locally or
# through cachefs.  Set BUILD_TOOLS to pull everything from one location.
# Alternately, you can set ONBLD_TOOLS to where you keep the contents of
# SUNWonbld and SPRO_ROOT to where you keep the compilers.  SPRO_VROOT
# exists to make it easier to test new versions of the compiler.
BUILD_TOOLS=/opt;				export BUILD_TOOLS
#ONBLD_TOOLS=/opt/onbld;			export ONBLD_TOOLS
SPRO_ROOT=/opt/SUNWspro;			export SPRO_ROOT
SPRO_VROOT=$SPRO_ROOT;				export SPRO_VROOT

__GNUC="";              export __GNUC
CW_NO_SHADOW=1;         export CW_NO_SHADOW
$cross
$xprefix
$xtarget
$xtool_prefix
$xsysroot
$xld_prefix
__LINT=#;               export __LINT
__ARLIB=#;              export __ARLIB
__SOLIB="";             export __SOLIB
USE_WS_TOOLS=;          export USE_WS_TOOLS
USE_UTSTUNE=;           export USE_UTSTUNE

EOF

if [ "$mach" = "aarch64" ]; then
	$CAT >> $fname <<EOF

# Target Aarch64 platform.
AARCH64_PLATFORM=$AARCH64_PLATFORM; export AARCH64_PLATFORM

# Comment out below line if you want to use GNU binutils linker
# to build Illumos (Illumos LD is not currently supported).
#__GNU_LD=#;            export __GNU_LD
EOF
	fi
}

get_workspace_root
VERSION='$GATE'
staffer=`$WHO -m|$AWK '{print $1}'`

for mach in aarch64; do
	dump_config "$workspace" "$staffer" "$mach"
done
