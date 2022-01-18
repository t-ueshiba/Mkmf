#########################
#  Intel Compiler	#
#########################
ifeq ($(CXX), icpc)
#  CCFLAGS      += -cxxlib-icc -no-gcc
#  LDFLAGS      += -cxxlib-icc
#  CCFLAGS      += -cxxlib-gcc
#  LDFLAGS      += -cxxlib-gcc
#  CCFLAGS	+= -gxx-name=/usr/bin/g++-3.3.6
#  LDFLAGS	+= -gxx-name=/usr/bin/g++-3.3.6
endif

#########################
#  Common macros	#
#########################
COMMHDRS	= $(filter-out %_.h, $(HDRS)) $(filter %++.cc, $(SRCS))
DESTCOMMHDRS	= $(COMMHDRS:%=$(INCDIR)/%)

LIBOBJS		= $(filter-out %++.o, $(OBJS))
ifneq ($(CXX), g++)
  ifneq ($(CXX), icpc)
    LIBOBJS    := $(filter-out %.inst.o, $(LIBOBJS))
  endif
endif

VER		= $(shell echo $(REV) | awk -F"." '{printf("%d", $$1);}')

ALIB		= lib$(NAME).a
SLINK		= lib$(NAME).so
SOLIB		= $(SLINK).$(VER)

ifneq ($(strip $(LIBOBJS)),)
    LIBRARY    += $(ALIB)
endif
DESTLIBRARY	= $(LIBRARY:%=$(DEST)/%)

CPIC		= -fpic
CCPIC		= -fpic

LN		= ln -s
INSTALL		= install
PRINT		= pr
MAKEFILE	= Makefile

#########################
#  Making rules		#
#########################
all:		$(LIBRARY)

$(ALIB):	$(LIBOBJS)
		$(RM) $@
#		$(LINKER) -xar -o $@ archive/$(LIBOBJS)
		$(AR) rv $@ $(LIBOBJS)
		ranlib $@

archive:
		mkdir archive

install:	$(DESTLIBRARY) $(DESTCOMMHDRS)

$(DEST)/$(ALIB):	$(ALIB)
		$(INSTALL) -m 0644 $(ALIB) $@
		ranlib $@

clean:
		$(RM) -r $(LIBRARY) $(SLINK) $(OBJS) .sb
		(cd archive; $(RM) $(OBJS))

depend:
		mkmf $(INCDIRS) -f $(MAKEFILE)

index:
		ctags -wx $(HDRS) $(SRCS)

tags:           $(HDRS) $(SRCS)
		ctags $(HDRS) $(SRCS)

print:
		$(PRINT) $(HDRS) $(SRCS)

doc:		$(HDRS) $(SRCS) doxygen.cfg
		doxygen doxygen.cfg

doxygen.cfg:
		doxygen -g $@

#########################
#  Implicit rules	#
#########################
$(INCDIR)/%:	%
		$(INSTALL) -m 0644 $< $(INCDIR)

.c.o:
		$(CC) $(CPPFLAGS) $(CFLAGS) $(INCDIRS) -c $<

.cc.o:
		$(CXX) $(CPPFLAGS) $(CCFLAGS) $(INCDIRS) -c $<

.cu.o:
		$(NVCC) $(CPPFLAGS) $(NVCCFLAGS) $(INCDIRS) -c $<
