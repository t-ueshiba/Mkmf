#################################
#  Source installation macros	#
#################################
COMMHDRS	= $(filter-out %_.h, $(HDRS)) $(filter %++.cc, $(SRCS))
SRCDIRHDRS	= $(COMMHDRS:%=$(SRCDIR)/TU/%)
LIBSRCS		= $(filter-out %++.cc, $(SRCS))
SRCDIRSRCS	= $(LIBSRCS:%=$(SRCDIR)/%)

#################################
#  Source installation rules	#
#################################
install-srcs:	$(SRCDIRHDRS) $(SRCDIRSRCS) $(SRCDIR)/Makefile.in

#################################
#  Implicit rules		#
#################################
$(SRCDIR)/TU/%:	%
		@$(INSTALL) -m 0644 $< $(SRCDIR)/TU

$(SRCDIR)/%:	%
		@$(INSTALL) -m 0644 $< $(SRCDIR)


