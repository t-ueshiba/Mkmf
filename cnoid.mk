#
#  $Id$
#
#########################
#  Common macros	#
#########################
CPPFLAGS       += $(shell pkg-config --cflags choreonoid)
LIBS	       += $(shell pkg-config --libs choreonoid)
LIBDIR		= $(shell pkg-config --variable=plugindir choreonoid)
