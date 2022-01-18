#
#  $Id$
#
#########################
#  Common macros	#
#########################
ifneq ($(findstring darwin,$(OSTYPE)),)
  ifneq ($(strip $(LIBRARY)),)
    LIBRARY    := $(LIBRARY).dylib
  endif
  PIC		= -dynamic
  NVCCFLAGS    += -m64
  ifneq ($(findstring nvcc,$(LINKER)),)
    SHFLAGS	= $(NVCCFLAGS) -shared -Xlinker "-dynamic -undefined dynamic_lookup"
  else
    SHFLAGS	= -dynamiclib -undefined dynamic_lookup 
  endif
else
  ifneq ($(strip $(LIBRARY)),)
    LIBRARY    := $(LIBRARY).so
  endif
  PIC		= -fPIC
  SHFLAGS	= -shared
endif

ifneq ($(strip $(PROGRAM)),)
  TARGPROG	= $(BINDIR)/$(PROGRAM)
endif
ifneq ($(strip $(LIBRARY)),)
  TARGLIB	= $(LIBDIR)/$(LIBRARY)
endif

INSTALL		= install
MAKEFILE	= Makefile

ifeq ($(shell arch), armv7l)
  CFLAGS       += -mcpu=cortex-a7 -mtune=cortex-a7 -mfpu=neon -funsafe-math-optimizations #-mfloat-abi=softfp
else ifeq ($(shell arch), aarch64)
  CFLAGS       += -funsafe-math-optimizations
endif

ifneq ($(findstring nvcc,$(CXX)),)
  CCFLAGS      += -std=c++14
  PIC		=
else
  CCFLAGS      += -std=c++1y
  ifneq ($(findstring icpc,$(CXX)),)
    LIBS       += -lsvml -lintlc
  endif
endif

NVCCFLAGS      += -std=c++14 -Xcompiler -std=c++1y

#LDFLAGS	       += -march=armv7-a -mfloat-abi=softfp -mfpu=neon

#########################
#  Making rules		#
#########################
.PHONY: all
all: $(PROGRAM) $(LIBRARY)

$(SRCS): $(IDLHDRS)

$(PROGRAM): $(OBJS)
	$(LINKER) $(LDFLAGS) $^ -o $@ $(LIBS)

$(LIBRARY): $(OBJS)
	$(LINKER) $(SHFLAGS) $(LDFLAGS) $^ -o $@ $(LIBS)

$(TARGPROG): $(PROGRAM)
	$(INSTALL) -m 0755 $< $@

$(TARGLIB): $(LIBRARY)
	$(INSTALL) -m 0755 $< $@

.PHONY: install
install: $(TARGPROG) $(TARGLIB) $(TARGHDRS)

.PHONY:	clean
clean:
	$(RM) -r $(IDLSRCS) $(IDLHDRS) $(MOCSRCS) $(OBJS) $(PROGRAM) $(LIBRARY)

.PHONY: depend
depend:
	mkmf $(INCDIRS) -f $(MAKEFILE)

.PHONY: index
index:
	ctags -wx $(HDRS) $(SRCS)

tags: $(HDRS) $(SRCS)
	ctags $(HDRS) $(SRCS)

.PHONY: link
link:
	$(RM) $(PROGRAM) $(LIBRARY)
	make $(PROGRAM) $(LIBRARY)

.PHONY:	doc
doc: $(HDRS) $(SRCS) doxygen.cfg
	doxygen doxygen.cfg

doxygen.cfg:
	doxygen -g $@

#########################
#  Implicit rules	#
#########################
$(INCDIR)/%: %
	$(INSTALL) -m 0644 $< $@

%.hh %SK.cc %DynSK.cc: %.idl
	$(IDLC) $(IDLFLAGS) $<

moc_%.cc: %.h
	$(MOC) $< -o $@

%.o: %.c
	$(CC) $(CPPFLAGS) $(INCDIRS) $(CFLAGS) $(PIC) -c $<

%.o: %.cc
	$(CXX) $(CPPFLAGS) $(INCDIRS) $(CCFLAGS) $(PIC) -c $<

%.o: %.cpp
	$(CXX) $(CPPFLAGS) $(INCDIRS) $(CCFLAGS) $(PIC) -c $<

%.o: %.cu
	$(NVCC) $(CPPFLAGS) $(INCDIRS) $(NVCCFLAGS) -Xcompiler $(PIC) -c $<
