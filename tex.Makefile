#
#  $Id$
#
#################################
#  User customizable macros	#
#################################
DEST		= $(BINDIR)

NAME		= 

LATEX		= platex
XDVI		= xdvi

#########################
#  Macros set by mkmf	#
#########################
SUFFIX		= .tex
HDRS		=				# all headers
SRCS		=				# all sources
OBJS		=				# all objects

#########################
#  Macros used by RCS	#
#########################
REV		= $(shell echo $Revision$	|		\
		  sed 's/evision://'		|		\
		  awk -F"."					\
		  '{						\
		      for (count = 1; count < NF; count++)	\
			  printf("%d.", $$count);		\
		      printf("%d", $$count + 1);		\
		  }')

include $(PROJECT)/lib/tex.mk
include $(PROJECT)/lib/RCS.mk
