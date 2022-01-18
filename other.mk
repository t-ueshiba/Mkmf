#
#  $Id$
#
#########################
#  Common macros	#
#########################
OTHER_TARGHDRS	= $(OTHER_HDRS:%=$(OTHER_DIR)/%)
OTHER_TARGSRCS	= $(OTHER_SRCS:%=$(OTHER_DIR)/%)

#########################
#  Making rules		#
#########################
.PHONY: other
other: $(OTHER_TARGHDRS) $(OTHER_TARGSRCS)

#########################
#  Implicit rules	#
#########################
$(OTHER_DIR)/%: %
	$(INSTALL) -m 0644 $< $@
