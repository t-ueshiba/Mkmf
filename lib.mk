#
#  $Id$
#
#########################
#  Common macros	#
#########################
PUBHDRS		= $(filter-out %_.h,$(HDRS))
TARGHDRS	= $(PUBHDRS:%=$(INCDIR)/%)
