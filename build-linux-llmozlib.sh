#!/bin/bash
# This script builds llmozlib itself.  This should happen after
# mozilla has been built and copy_products_linux.sh has been run.

CXX='g++'
MOZARCH='i686-linux'
SRCS='llembeddedbrowser.cpp llembeddedbrowserwindow.cpp llmozlib2.cpp llwebpage.cpp moc_webpage.cpp'

#------------------------

LIBNAME=libllmozlib2
OBJS=`echo ${SRCS} | sed s/\\.cpp/.o/g`
#INCS_LINE="`find libraries/${MOZARCH}/include -type d | sed s/^/-I/`"
INCS_LINE="-I$QTDIR/include"
DEFS='-DMOZILLA_INTERNAL_API -DLL_LINUX=1'
OPTS='-ggdb'
# -fvisibility=hidden'

rm -f ${LIBNAME}.a ${OBJS}

moc llwebpage.h -o moc_llwebpage.cpp

for source in ${SRCS} ; do
    ${CXX} ${OPTS} ${DEFS} ${INCS_LINE} -c ${source}
done

ar rcs ${LIBNAME}.a ${OBJS}

ls -la ${LIBNAME}.a


