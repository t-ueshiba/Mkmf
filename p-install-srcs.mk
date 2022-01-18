#################################
#  Source installation macros	#
#################################
SRCDIRHDRS	= $(HDRS:%=$(SRCDIR)/%)
SRCDIRSRCS	= $(SRCS:%=$(SRCDIR)/%)

#################################
#  Source installation rules	#
#################################
install-srcs:	$(SRCDIRHDRS) $(SRCDIRSRCS) $(SRCDIR)/Makefile.in

#################################
#  Implicit rules		#
#################################
$(SRCDIR)/%:	%
		$(INSTALL) -m 0644 $< $(SRCDIR)

