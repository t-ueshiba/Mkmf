#
#  $Id$
#
#########################
#  Common macros	#
#########################
IDLHDRS		= $(notdir $(patsubst %.idl,%.hh,$(IDLS)))
IDLSRCS		= $(notdir $(patsubst %.idl,%SK.cc,$(IDLS)) \
			   $(patsubst %.idl,%DynSK.cc,$(IDLS)))
OBJS	       += $(patsubst %.cc,%.o,$(IDLSRCS))
IDLFLAGS	= $(shell rtm-config --idlflags)
IDLC		= $(shell rtm-config --idlc)

CPPFLAGS       += -I$(shell rtm-config --rtm-includedir) \
		  -I$(shell rtm-config --coil-includedir) \
		  -I$(shell rtm-config --rtm-idldir)
LIBS	       += $(shell rtm-config --libs-only-l)
