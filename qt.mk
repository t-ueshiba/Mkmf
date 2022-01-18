#
#  $Id$
#
#########################
#  Common macros	#
#########################
MOC		= moc
MOCSRCS		= $(patsubst %.h,moc_%.cc,$(MOCHDRS))
OBJS	       += $(patsubst %.cc,%.o,$(MOCSRCS))
