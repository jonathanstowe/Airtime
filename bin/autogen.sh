#!/bin/bash
#-------------------------------------------------------------------------------
#   Copyright (c) 2010 Sourcefabric O.P.S.
#
#   This file is part of the Campcaster project.
#   http://campcaster.sourcefabric.org/
#   To report bugs, send an e-mail to bugs@campware.org
#
#   Campcaster is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   Campcaster is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Campcaster; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Run this to set up the build system: configure, makefiles, etc.
# (based on the version in enlightenment's cvs)
#-------------------------------------------------------------------------------

package="Campcaster"

# assume we're in $basedir/bin
reldir=`dirname $0`/..
basedir=`cd $reldir; pwd;`
test -z "$basedir" && basedir=.

bindir=$basedir/bin
etcdir=$basedir/etc
tmpdir=$basedir/tmp

cd "$tmpdir"
DIE=0

(autoconf --version) < /dev/null > /dev/null 2>&1 || {
    echo
    echo "You must have autoconf installed to compile $package."
    echo "Download the appropriate package for your distribution,"
    echo "or get the source tarball at ftp://ftp.gnu.org/pub/gnu/"
    DIE=1
}

(automake --version) < /dev/null > /dev/null 2>&1 || {
    echo
    echo "You must have automake installed to compile $package."
    echo "Download the appropriate package for your distribution,"
    echo "or get the source tarball at ftp://ftp.gnu.org/pub/gnu/"
    DIE=1
}

if test "$DIE" -eq 1; then
    exit 1
fi

if test -z "$*"; then
    echo "I am going to run ./configure with no arguments - if you wish "
    echo "to pass any to it, please specify them on the $0 command line."
fi

echo "Generating configuration files for $package, please wait...."

configure_ac=${etcdir}/configure.ac
configure=${tmpdir}/configure

# copy over install-sh, as it's going to be missed by autoconf
cp -f ${bindir}/install-sh ${tmpdir}
cp -f ${configure_ac} ${tmpdir}

echo "  aclocal"
aclocal

echo "  autoconf -I ${tmpdir} -o ${configure} ${configure_ac}"
autoconf -I ${tmpdir} -o ${configure} ${configure_ac}

